package test

import (
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"log"
	"os"
	"strings"
	"testing"
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
