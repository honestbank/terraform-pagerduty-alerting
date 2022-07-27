module "dummy_users" {
  count = var.dummy_user_count

  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-schedule-example-user-${count.index}"
  email_address = "pagerduty-schedule-example-user-${count.index}@honestbank.com"
}

module "schedule" {
  source = "../../modules/honest-two-level-schedule"

  name        = "Example - ${var.name}"
  description = "${var.name} - this is an example description"

  # 604,800 seconds = 1 week (7 days)
  # 86,400 seconds = 1 day
  rotation_turn_length_seconds = 86400

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = module.dummy_users.*.id
}
