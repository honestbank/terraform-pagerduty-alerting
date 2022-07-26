resource "pagerduty_schedule" "schedule" {
  name        = var.name
  description = var.description
  time_zone   = var.time_zone

  layer {
    # Follows the PagerDuty UI of the layers being named "Layer 1", "Layer 2", etc
    name                         = "Layer 1"
    start                        = var.start_datetime
    rotation_virtual_start       = var.start_datetime
    rotation_turn_length_seconds = var.rotation_turn_length_seconds
    users                        = var.user_ids
  }
}
