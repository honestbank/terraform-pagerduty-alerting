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

// pagerdutyRetryableTerraformOptions returns terraform options with PagerDuty-specific
// retryable errors added on top of the default retryable errors.
func pagerdutyRetryableTerraformOptions(t *testing.T, opts *terraform.Options) *terraform.Options {
	opts.RetryableTerraformErrors = map[string]string{
		".*Client\\.Timeout exceeded.*":   "PagerDuty API timeout, retrying.",
		".*Email has already been taken.*": "PagerDuty user conflict from previous attempt, retrying.",
		".*net/http: request canceled.*":   "HTTP request canceled, retrying.",
		".*context deadline exceeded.*":    "Context deadline exceeded, retrying.",
		".*TLS handshake timeout.*":        "TLS handshake timeout, retrying.",
		".*i/o timeout.*":                  "Network I/O timeout, retrying.",
	}
	opts.MaxRetries = 5
	opts.TimeBetweenRetries = 10 * time.Second
	return terraform.WithDefaultRetryableErrors(t, opts)
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
