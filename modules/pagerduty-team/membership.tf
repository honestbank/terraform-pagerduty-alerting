locals {
  # The 3 consts below are the only prossible roles for a membership, as defined in Pagerduty API.
  CONST_RESPONDER_ROLE = "responder"
  CONST_MANAGER_ROLE   = "manager"
  CONST_OBSERVER_ROLE  = "observer"
}

resource "pagerduty_team_membership" "responders" {
  count = length(var.responder_user_ids)

  user_id = var.responder_user_ids[count.index]
  team_id = pagerduty_team.team.id
  role    = local.CONST_RESPONDER_ROLE
}

resource "pagerduty_team_membership" "managers" {
  for_each = toset(var.manager_user_ids)

  user_id = each.key
  team_id = pagerduty_team.team.id
  role    = local.CONST_MANAGER_ROLE
}

resource "pagerduty_team_membership" "observers" {
  for_each = toset(var.observer_user_ids)

  user_id = each.key
  team_id = pagerduty_team.team.id
  role    = local.CONST_OBSERVER_ROLE
}
