variable "url" {
  description = "Evtl. URL fuer den Zugriff auf das API des Racks Servers"
  type        = string
}

variable "key" {
  description = "API Key, Token etc. fuer Zugriff"
  type        = string
  sensitive   = true
}

variable "hostname_prefix" {
  description = "Prefix for the hostnames / KVM-hostname"
  type        = string
  default     = "cloud-hf-24"
}
