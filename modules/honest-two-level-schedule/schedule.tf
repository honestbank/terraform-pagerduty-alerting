locals {
  # This number represents how many rotations/slots each schedule is offset by, to prevent the same responder being
  # on-call for both schedules at the same time.
  schedule_offset_rotation_count = floor(length(var.user_ids) / 2)


  # 5pm Wednesday, 23rd March / in GMT format for Terraform
  level_one_start_datetime_terraform_format = "2022-03-23T10:00:00Z"
  level_one_start_date                      = split("T", local.level_one_start_datetime_terraform_format).0
  level_one_start_datetime_pagerduty_format = "${local.level_one_start_date}T17:00:00+07:00"

  # Terraform format has a Z - RFC3339 format
  # This date is fixed to a date in the past, at 5pm on Wednesday. This means rotation handoff is fixed at 5pm Wednesday.
  start_datetime_rfc3339 = "2022-03-23T10:00:00Z"

  # Level two schedule is offset "backwards" to adjust for the staggered rotation
  level_two_schedule_calculated_offset_start_datetime_terraform_format = timeadd(
    local.start_datetime_rfc3339,
    "${(-1 * (var.rotation_turn_length_seconds * local.schedule_offset_rotation_count))}s"
  )

  # Get the timestamp without the trailing "Z"
  level_two_schedule_calculated_offset_start_datetime_pagerduty_format = "${((split("T", local.level_two_schedule_calculated_offset_start_datetime_terraform_format)).0)}T17:00:00+07:00"
}

module "level_one_schedule" {
  source = "../pagerduty-schedule"

  name                         = "${var.name} - Level 1"
  description                  = "${var.description} - Level 1"
  rotation_turn_length_seconds = var.rotation_turn_length_seconds
  user_ids                     = var.user_ids
  start_datetime               = local.level_one_start_datetime_pagerduty_format
  time_zone                    = var.time_zone
}

module "level_two_schedule" {
  source = "../pagerduty-schedule"

  name                         = "${var.name} - Level 2"
  description                  = "${var.description} - Level 2"
  rotation_turn_length_seconds = var.rotation_turn_length_seconds
  user_ids                     = var.user_ids
  start_datetime               = local.level_two_schedule_calculated_offset_start_datetime_pagerduty_format
  time_zone                    = var.time_zone
}
