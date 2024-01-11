resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  random_suffix = random_id.random_suffix.b64_url
}

module "dummy_users" {
  count = var.dummy_user_count

  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-schedule-example-user-${count.index}-${local.random_suffix}"
  email_address = "pagerduty-schedule-example-user-${count.index}-${local.random_suffix}@honestbank.com"
}

module "dummy_team" {
  source = "../../modules/pagerduty-team"

  name        = "${var.team_name}-${local.random_suffix}"
  description = "${var.name}-${local.random_suffix} - this is an example description"
}

module "schedule" {
  source = "../../modules/honest-two-level-schedule"

  name        = "Example-${var.name}-${local.random_suffix}"
  description = "${var.name} - ${local.random_suffix} - this is an example description"

  # 604,800 seconds = 1 week (7 days)
  # 86,400 seconds = 1 day
  rotation_turn_length_seconds = 86400

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = module.dummy_users.*.id

  team_ids = [
    module.dummy_team.id
  ]
}
