terraform {
  required_providers {
    maas = {
      source  = "mc-b/lernmaas"
      version = ">=2.4.1"
    }
  }
}

provider "maas" {
  # Configuration options
  api_version = "2.0"
  api_url     = var.url
  api_key     = var.key
}
