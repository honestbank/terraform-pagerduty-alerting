resource "pagerduty_business_service" "business_service" {
  name             = var.name
  description      = var.description
  team             = var.owner_team_id
  point_of_contact = var.point_of_contact
}

resource "pagerduty_service_dependency" "supporting_services" {
  count = length(var.supporting_service_ids)

  dependency {
    dependent_service {
      id   = pagerduty_business_service.business_service.id
      type = pagerduty_business_service.business_service.type
    }
    supporting_service {
      id   = var.supporting_service_ids[count.index]
      type = "service"
    }
  }
}

resource "pagerduty_service_dependency" "supporting_business_services" {
  count = length(var.supporting_business_service_ids)

  dependency {
    dependent_service {
      id   = pagerduty_business_service.business_service.id
      type = pagerduty_business_service.business_service.type
    }
    supporting_service {
      id   = var.supporting_business_service_ids[count.index]
      type = "business_service"
    }
  }
}
