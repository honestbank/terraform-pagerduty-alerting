# This iterator isn't great but it's the only way
# to use a list of objects.
resource "pagerduty_user" "level_one_responders" {
  for_each = {
    for index, user_object in var.pagerduty_responders_engineers_level_one :
    user_object.email => user_object
  }

  name  = each.value.name
  email = each.value.email
  role  = try(each.value.role, "user")
}

# Level Two

resource "pagerduty_user" "level_two_responders" {
  for_each = {
    for index, user_object in var.pagerduty_responders_engineers_level_two :
    user_object.email => user_object
  }

  name  = each.value.name
  email = each.value.email
  role  = try(each.value.role, "user")
}
