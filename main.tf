data "aci_tenant" "aci_tenant" {
  name             = var.tenant_name
}

data "aci_vrf" "aci_vrf" {
  tenant_dn         = data.aci_tenant.aci_tenant.id
  name              = var.vrf_name
}

resource "aci_application_profile" "aci_application_profile" {
  tenant_dn         = data.aci_tenant.aci_tenant.id
  name              = var.application_profile_name
}

resource "aci_bridge_domain" "aci_bridge_domain" {
    tenant_dn             = data.aci_tenant.aci_tenant.id
    arp_flood             = var.arp_flood
    unicast_route         = var.unicast_route
    unk_mac_ucast_act     = var.unknown_unicast_route
    relation_fv_rs_ctx    = data.aci_vrf.aci_vrf.id
    name                  = var.bridge_domain_name
}

resource "aci_subnet" "aci_subnet" {
    parent_dn             = aci_bridge_domain.aci_bridge_domain.id
    ip                    = var.bridge_domain_ip_and_mask
}

resource "aci_application_epg" "aci_application_epg" {
  application_profile_dn  = resource.aci_application_profile.aci_application_profile.id
  name                    = var.epg_name
  relation_fv_rs_bd       = aci_bridge_domain.aci_bridge_domain.id
}

 data "aci_vmm_domain" "aci_vmm_domain" {
  provider_profile_dn     = "/uni/vmmp-VMware"
  name                     = var.vds_name
}

resource "aci_epg_to_domain" "aci_epg_to_domain" {
    application_epg_dn = aci_application_epg.aci_application_epg.id
    tdn = data.aci_vmm_domain.aci_vmm_domain.id
}
