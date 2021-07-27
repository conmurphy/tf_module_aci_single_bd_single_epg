terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
      version = ">= 0.7.1"
    }
  }
  required_version = ">= 1.0.1"
}