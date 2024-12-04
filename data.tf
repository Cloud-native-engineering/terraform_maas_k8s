# all kvm hosts
data "maas_vm_host" "default" {
  name = var.hostname_prefix
}