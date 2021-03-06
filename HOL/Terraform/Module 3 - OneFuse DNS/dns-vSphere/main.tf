 // Comment out the following for Terraform 0.12

 terraform {
  required_providers {
    onefuse = {
      source  = "CloudBoltSoftware/onefuse"
      version = ">= 1.10.0"
   }
  }
  required_version = ">= 0.13"
}
// Comment out the above for Terraform 0.12

// Inititalize OneFuse Provider
provider "onefuse" {

  scheme     = var.onefuse_scheme
  address    = var.onefuse_address
  port       = var.onefuse_port
  user       = var.onefuse_user
  password   = var.onefuse_password
  verify_ssl = var.onefuse_verify_ssl
}

// OneFuse Data Source for DNS Policy to lookup policy ID
data "onefuse_dns_policy" "policy" {
  name = "prod"
}

// OneFuse Resource for DNS Record
resource "onefuse_dns_record" "dns-record" {
    
    name = var.hostname
    policy_id = data.onefuse_dns_policy.policy.id
    workspace_url = var.workspace_url
    zones = [var.dns_zones]
    value = var.ip_address
    template_properties = var.onefuse_template_properties
}




