package test

import (
	"log"
	"os"
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

const pagerdutyApiBaseUrl = "https://api.pagerduty.com"

type pagerdutyScheduleResponse struct {
	Schedule pagerdutySchedule `json:"schedule"`
}

type pagerdutySchedule struct {
	Id             string                   `json:"id"`
	Name           string                   `json:"summary"`
	Description    string                   `json:"description"`
	Users          []pagerdutyUser          `json:"users"`
	ScheduleLayers []pagerdutyScheduleLayer `json:"schedule_layers"`
}

type pagerdutyScheduleLayer struct {
	Id                   string                                `json:"id"`
	Name                 string                                `json:"name"`
	RotationVirtualStart string                                `json:"rotation_virtual_start"`
	Start                string                                `json:"start"`
	Users                []pagerdutyScheduleLayerUserContainer `json:"users"`
}

type pagerdutyScheduleLayerUserContainer struct {
	User pagerdutyUser `json:"user"`
}

type pagerdutyUser struct {
	Id string `json:"id"`
}

func generateRunId() string {
	return strings.ToLower(random.UniqueId())
}

func loadPagerdutyToken(t *testing.T) string {
	token := os.Getenv("PAGERDUTY_TOKEN")
	if len(token) == 0 {
		log.Println("Empty PAGERDUTY_TOKEN from env")
		t.FailNow()
	}
	return token
}

// pagerdutyRetryableTerraformOptions returns terraform options with a curated set of
// retryable errors and Parallelism=1 to avoid PagerDuty API contention.
//
// We intentionally DO NOT use terraform.WithDefaultRetryableErrors because its default
// list includes "Provider produced inconsistent result after apply", which causes a
// destructive retry cascade with the PagerDuty provider:
//  1. Apply creates users in PagerDuty, but provider reports state inconsistency
//  2. Users exist in PagerDuty but are NOT recorded in Terraform state
//  3. Retry re-runs apply → "Email has already been taken" (always fails)
//  4. Leaked users consume licenses → subsequent tests fail with license errors
//
// Instead, we define only retryable errors that are genuinely transient.
func pagerdutyRetryableTerraformOptions(t *testing.T, opts *terraform.Options) *terraform.Options {
	opts.RetryableTerraformErrors = map[string]string{
		// Terraform registry/provider download errors (transient)
		".*Error installing provider.*":                  "Failed to install provider, retrying.",
		".*Failed to query available provider packages.*": "Failed to query provider registry, retrying.",
		".*no provider exists with the given name.*":     "Provider not found, retrying.",
		".*registry service is unreachable.*":            "Registry unreachable, retrying.",
		".*unable to verify checksum.*":                  "Checksum verification failed, retrying.",
		".*unable to verify signature.*":                 "Signature verification failed, retrying.",
		"could not query provider registry for":          "Could not query provider registry, retrying.",

		// Network errors (transient)
		".*Client\\.Timeout exceeded.*":             "PagerDuty API timeout, retrying.",
		".*net/http: request canceled.*":             "HTTP request canceled, retrying.",
		".*context deadline exceeded.*":              "Context deadline exceeded, retrying.",
		".*TLS handshake timeout.*":                  "TLS handshake timeout, retrying.",
		".*i/o timeout.*":                            "Network I/O timeout, retrying.",
		".*read: connection reset by peer.*":         "Connection reset, retrying.",
		".*transport is closing.*":                   "Transport closing, retrying.",
		".*timed out waiting for server handshake.*": "Server handshake timeout, retrying.",
		".*timeout while waiting for plugin to start.*": "Plugin start timeout, retrying.",

		// PagerDuty license errors (transient when licenses are being freed by concurrent destroy)
		".*License error.*": "PagerDuty license unavailable, retrying.",
	}
	opts.MaxRetries = 3
	opts.TimeBetweenRetries = 30 * time.Second

	// Reduce Terraform parallelism to 1 to avoid concurrent PagerDuty API calls
	// that trigger "Provider produced inconsistent result after apply" errors.
	opts.Parallelism = 1

	return opts
}

func createPagerdutyApiOptions(t *testing.T, method string, path string) http_helper.HttpDoOptions {
	pagerdutyApiOptions := http_helper.HttpDoOptions{
		Method: method,
		Url:    pagerdutyApiBaseUrl + path,
		Headers: map[string]string{
			"Authorization": "Token token=" + loadPagerdutyToken(t),
		},
	}

	return pagerdutyApiOptions
}
