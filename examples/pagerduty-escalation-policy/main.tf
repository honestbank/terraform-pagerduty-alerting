resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  random_suffix = random_id.random_suffix.b64_url
}

module "engineering_user_one" {
  source        = "../../modules/pagerduty-user"
  name          = "engineering-user-one-${local.random_suffix}"
  email_address = "engineering-user-one-${local.random_suffix}@honestbank.com"
}

module "engineering_user_two" {
  source        = "../../modules/pagerduty-user"
  name          = "example-engineering-user-two-${local.random_suffix}"
  email_address = "example-engineering-user-two-${local.random_suffix}@honestbank.com"
}

module "engineering_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "example-engineering-lead-${local.random_suffix}"
  email_address = "example-engineering-lead-${local.random_suffix}@honestbank.com"
}

module "product_manager" {
  source        = "../../modules/pagerduty-user"
  name          = "example-product-manager-${local.random_suffix}"
  email_address = "example-product-manager-${local.random_suffix}@honestbank.com"
}

module "product_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "example-product-lead-${local.random_suffix}"
  email_address = "example-product-lead-${local.random_suffix}@honestbank.com"
}

module "level_one_engineering_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level one engineering schedule"
  name        = "level one engineering schedule-${var.schedule_suffix}-${local.random_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [
    module.engineering_user_one.id,
    module.engineering_user_two.id,
  ]
}

module "level_two_engineering_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level two engineering schedule"
  name        = "level two engineering schedule-${var.schedule_suffix}-${local.random_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [
    module.engineering_user_two.id,
    module.engineering_user_one.id,
  ]
}

module "level_two_product_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level two product schedule"
  name        = "level two product schedule-${var.schedule_suffix}-${local.random_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [module.product_manager.id]
}

module "level_three_engineering_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level three engineering schedule"
  name        = "level three engineering schedule-${var.schedule_suffix}-${local.random_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [module.engineering_lead.id]
}

module "level_three_product_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level three product schedule"
  name        = "level three product schedule-${var.schedule_suffix}-${local.random_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [module.product_lead.id]
}

module "mock_team" {
  source      = "../../modules/pagerduty-team"
  name        = "Team-${var.name}-${local.random_suffix}"
  description = "Created by terratest"
}

module "escalation_policy" {
  source = "../../modules/pagerduty-escalation-policy"

  name        = "${var.name}-${local.random_suffix}"
  description = var.description

  escalation_delay_in_minutes = 60

  escalation_levels = (length(var.escalation_levels) > 0 ? var.escalation_levels : [
    [module.level_one_engineering_schedule.id],
    [module.level_two_engineering_schedule.id, module.level_two_product_schedule.id],
    [module.level_three_engineering_schedule.id, module.level_three_product_schedule.id],
  ])

  teams_id = [
    module.mock_team.id,
  ]
}
