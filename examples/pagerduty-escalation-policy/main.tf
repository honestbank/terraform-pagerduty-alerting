module "engineering_user_one" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-user-one"
  email_address = "pagerduty-escalation-policy-example-engineering-user-one@honestbank.com"
}

module "engineering_user_two" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-user-two"
  email_address = "pagerduty-escalation-policy-example-engineering-user-two@honestbank.com"
}

module "engineering_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-lead"
  email_address = "pagerduty-escalation-policy-example-engineering-lead@honestbank.com"
}

module "product_manager" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-product-manager"
  email_address = "pagerduty-escalation-policy-example-product-manager@honestbank.com"
}

module "product_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-product-lead"
  email_address = "pagerduty-escalation-policy-example-product-lead@honestbank.com"
}

module "level_one_engineering_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level one engineering schedule"
  name        = "level one engineering schedule"

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
  name        = "level two engineering schedule"

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
  name        = "level two product schedule"

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
  name        = "level three engineering schedule"

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
  name        = "level three product schedule"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [module.product_lead.id]
}

module "escalation_policy" {
  source = "../../modules/pagerduty-escalation-policy"

  name        = var.name
  description = var.description

  escalation_delay_in_minutes = 60

  escalation_levels = (length(var.escalation_levels) > 0 ? var.escalation_levels : [
    [module.level_one_engineering_schedule.id],
    [module.level_two_engineering_schedule.id, module.level_two_product_schedule.id],
    [module.level_three_engineering_schedule.id, module.level_three_product_schedule.id],
  ])
}
