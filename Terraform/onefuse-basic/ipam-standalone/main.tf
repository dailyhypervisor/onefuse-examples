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

// OneFuse Data Source for IPAM Policy to lookup policy ID
data "onefuse_ipam_policy" "policy" {
  name = "atlprod"
}

// OneFuse Resource for IPAM Record
resource "onefuse_ipam_record" "ipam-record" {
    
    hostname = var.hostname
    policy_id = data.onefuse_ipam_policy.policy.id
    workspace_url = var.workspace_url
    template_properties = var.onefuse_template_properties
}

// Output Results for IPAM Resources
output "ip_address" {
  value = onefuse_ipam_record.ipam-record.ip_address
}

output "netmask" {
  value = onefuse_ipam_record.ipam-record.netmask
}

output "gateway" {
  value = onefuse_ipam_record.ipam-record.gateway
}

output "network" {
  value = onefuse_ipam_record.ipam-record.network
}