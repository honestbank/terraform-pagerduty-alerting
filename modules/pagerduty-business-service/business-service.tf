locals {
  # See https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/business_service#type
  CONST_SERVICE_TYPE_BUSINESS = "business_service"
  CONST_SERVICE_TYPE_SERVICE  = "service"
}

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
      type = local.CONST_SERVICE_TYPE_BUSINESS
    }
    supporting_service {
      id   = var.supporting_service_ids[count.index]
      type = local.CONST_SERVICE_TYPE_SERVICE
    }
  }
}

resource "pagerduty_service_dependency" "supporting_business_services" {
  count = length(var.supporting_business_service_ids)

  dependency {
    dependent_service {
      id   = pagerduty_business_service.business_service.id
      type = local.CONST_SERVICE_TYPE_BUSINESS
    }
    supporting_service {
      id   = var.supporting_business_service_ids[count.index]
      type = local.CONST_SERVICE_TYPE_BUSINESS
    }
  }
}
