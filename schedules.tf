resource "pagerduty_schedule" "engineering_level_one_schedule" {
  name      = "[Terraform] Engineering L1 Schedule"
  time_zone = "Asia/Bangkok"

  layer {
    name                         = "L1 Rotation"
    start                        = "2022-03-23T17:00:00+07:00"
    rotation_virtual_start       = "2022-03-23T17:00:00+07:00"
    rotation_turn_length_seconds = 604800
    users = [
      for key, value in pagerduty_user.level_one_responders : value.id
    ]
  }
}

resource "pagerduty_schedule" "engineering_level_two_schedule" {
  name      = "[Terraform] Engineering L2 Schedule"
  time_zone = "Asia/Bangkok"

  layer {
    name                         = "L1 Rotation"
    start                        = "2022-03-23T17:00:00+07:00"
    rotation_virtual_start       = "2022-03-23T17:00:00+07:00"
    rotation_turn_length_seconds = 604800
    users = [
      for key, value in pagerduty_user.level_two_responders : value.id
    ]
  }
}
