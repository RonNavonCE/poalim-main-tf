variable "policies" {
  type = list(object({
    name  = string
    state = string
    conditions = object({
      client_app_types    = list(string)
      sign_in_risk_levels = optional(list(string), null)
      user_risk_levels    = optional(list(string), null)
      applications = object({
        excluded_applications = optional(list(string), null)
        included_applications = optional(list(string), null)
        included_user_actions = optional(list(string), null)
      })
      devices_rule = optional(object({
        mode = string
        rule = string
      }))
      users = object({
        excluded_groups = optional(list(string), null)
        excluded_roles  = optional(list(string), null)
        excluded_users  = optional(list(string), null)
        included_groups = optional(list(string), null)
        included_roles  = optional(list(string), null)
        included_users  = optional(list(string), null)
      })
      locations = object({
        excluded_locations = optional(list(string), null)
        included_locations = list(string)
      })
      platforms = object({
        included_platforms = list(string)
        excluded_platforms = optional(list(string), null)
      })
    })
    grant_controls = object({
      built_in_controls             = list(string)
      operator                      = string
      custom_authentication_factors = optional(list(string), null)
      terms_of_use                  = optional(list(string), null)
    })
    session_controls = optional(object({
      application_enforced_restrictions_enabled = optional(bool, false)
      cloud_app_security_policy                 = optional(string, null)
      persistent_browser_mode                   = optional(string, null)
      sign_in_frequency                         = optional(number, null)
      sign_in_frequency_period                  = optional(string, null)
    }))
  }))
}
