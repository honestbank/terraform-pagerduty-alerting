resource "pagerduty_business_service" "business_service" {
  name             = var.name
  description      = var.description
  team             = var.owner_team_id
  point_of_contact = var.point_of_contact
}

resource "pagerduty_service_dependency" "supporting_services" {
  for_each = toset(var.supporting_service_ids)

  dependency {
    dependent_service {
      id   = pagerduty_business_service.business_service.id
      type = pagerduty_business_service.business_service.type
    }
    supporting_service {
      id   = each.value
      type = "service"
    }
  }
}

resource "pagerduty_service_dependency" "supporting_business_services" {
  for_each = toset(var.supporting_business_service_ids)

  dependency {
    dependent_service {
      id   = pagerduty_business_service.business_service.id
      type = pagerduty_business_service.business_service.type
    }
    supporting_service {
      id   = each.value
      type = "business_service"
    }
  }
}
