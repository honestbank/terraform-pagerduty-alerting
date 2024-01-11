resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  random_suffix = random_id.random_suffix.b64_url
}

module "user_one" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-schedule-example-user-one-${local.random_suffix}"
  email_address = "pagerduty-schedule-example-user-one-${local.random_suffix}@honestbank.com"
}

module "user_two" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-schedule-example-user-two-${local.random_suffix}"
  email_address = "pagerduty-schedule-example-user-two-${local.random_suffix}@honestbank.com"
}

module "schedule" {
  source = "../../modules/pagerduty-schedule"

  name        = "${var.name}-${local.random_suffix}"
  description = "Example schedule"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [
    module.user_one.id,
    module.user_two.id,
  ]
}
