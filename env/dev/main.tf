terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

provider "azurerm" {
  features {}
}

module "dev" {
  source = "../.."

  policies = [
    {
      name  = "test-policy"
      state = "disabled"
      conditions = {
        client_app_types = ["all"]
        applications = {
          included_applications = ["All"]
        }
        devices_rule = {
          mode = "include"
          rule = "device.operatingSystem -eq \"Windows\""
        }
        users = {
          included_users = ["All"]
        }
        locations = {
          included_locations = ["All"]
        }
        platforms = {
          included_platforms = ["all"]
        }
      }
      grant_controls = {
        built_in_controls = ["mfa"]
        operator          = "OR"
      }
    }
    /* {
      name  = "string"
      state = "POLICY STATE - OPTIONS: enabled / disabled / enabledForReportingButNotEnforced"
      conditions = {
        client_app_types    = ["LIST OF APPS TYPES INCLUDED IN THE POLICY - OPTIONS: all , browser , mobileAppsAndDesktopClients , exchangeActiveSync , easSupported , other"]
        sign_in_risk_levels = ["OPTIONS: low , medium , high , hidden , none , unknownFutureValue"]
        user_risk_levels    = ["OPTIONS: low , medium , high , hidden , none , unknownFutureValue"]
        applications = {
          excluded_applications = optional(list(string), null)
          included_applications = optional(list(string), null)
          included_user_actions = optional(list(string), null)
        }
        devices_rule = {
          mode = "include / exclude MATCHING DEVICIES FROM THE POLICY"
          rule = "CONDITIONAL FILTER TO MATCH DEVICES - FOR INFO: https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/concept-condition-filters-for-devices#supported-operators-and-device-properties-for-filters"
        }
        USERS = {
          excluded_groups = ["!!OPTIONAL!!"]
          excluded_roles  = ["!!OPTIONAL!!"]
          excluded_users  = ["!!OPTIONAL!!"]
          included_groups = ["!!OPTIONAL!!"]
          included_roles  = ["!!OPTIONAL!!"]
          included_users  = ["!!OPTIONAL!!"]
        }
        locations = {
          excluded_locations = ["!!OPTIONAL!!"]
          included_locations = ["LIST OF LOCATIONS IDs IN SCOPE OF THE POLICY, CAN ALSO USE - All / AllTrusted"]
        }
        platforms = {
          included_platforms = ["LIST OF PLATFORMS THE POLICY APPLIES TO, OPTIONS - all, android, iOS, linux, macOS, windows, windowsPhone, unknownFutureValue"]
          excluded_platforms = ["!!OPTIONAL!! OPTIONS - all, android, iOS, linux, macOS, windows, windowsPhone, unknownFutureValue"]
        }
      }
      grant_controls = {
        built_in_controls             = ["LIST OF BUILT-IN CONTROLS REQUIRED BY THE POLICY, OPTIONS - block, mfa, approvedApplication, compliantApplication, compliantDevice, domainJoinedDevice, passwordChange, unknownFutureValue"]
        operator                      = "DEFINE THE RELATIONSHIP OF THE GRANT CONTROLS, OPTIONS - AND / OR"
        custom_authentication_factors = ["!!OPTIONAL!! LIST OF CUSTOM CONTROLS IDs REQUIRED BY THE POLICY"]
        terms_of_use                  = ["!!OPTIONAL!! LIST OF TERMS OF USE IDs REQUIRED BY THE POLICY"]
      }
      session_controls = {
        application_enforced_restrictions_enabled = false # !!OPTIONAL!! ENFORCE OR NOT APP RESTRICTIONS
        cloud_app_security_policy                 = "!!OPTIONAL!! ENABLE APP SECURITY AND SPECIFIES THE CLOUD APP SECURITY POLICY TO USE, OPTIONS - blockDownloads / mcasConfigured / monitorOnly / unknownFutureValue"
        persistent_browser_mode                   = "!!OPTIONAL!! DEFINE WHETHER TO PERSIST COOKIES OR NOT, OPTIONS - always / never"
        sign_in_frequency                         = 10 # !!OPTIONAL!! NUMBER OF DAYS OR HOURS TO ENFORCE SIGN-IN FREQUENCY
        sign_in_frequency_period                  = "!!OPTIONAL!! THE TIME PERIOD TO ENFORCE SIGN-IN FREQUENCY, OPTIONS - hours / days"
      }
    } */
  ]
}
