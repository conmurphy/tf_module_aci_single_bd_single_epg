variable "tenant_name" {}
variable "vrf_name" {}
variable "application_profile_name" {}
variable "bridge_domain_name" {}
variable "bridge_domain_ip_and_mask" {}
variable "epg_name" {}
variable "vds_name" {}

variable "arp_flood" {
    default = "yes"
}
variable "unicast_route" {
    default = "yes"
}
variable "unknown_unicast_route" {
    default = "flood"
}