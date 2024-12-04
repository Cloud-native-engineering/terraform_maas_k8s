locals {
  worker_instances_count     = 3
  controller_instances_count = 2

  worker_instances_list     = [for i in range(1, local.worker_instances_count + 1) : i]
  controller_instances_list = [for i in range(2, local.controller_instances_count + 1) : i]

  worker_instances_map     = zipmap(local.worker_instances_list, local.worker_instances_list)
  controller_instances_map = zipmap(local.controller_instances_list, local.controller_instances_list)
}

data "template_file" "cloud_init_k0s" {
  template = file("${path.module}/cloud_init_k0s.yaml.tpl")
  vars = {
    hostname_prefix = var.hostname_prefix
  }
}

# This Host is used to provision the k0s cluster
resource "maas_vm_instance" "k8s_controller_init" {
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 4096
  storage   = 30
  hostname  = "${var.hostname_prefix}-c1"
  zone      = "10-3-24-0"
  user_data = data.template_file.cloud_init_k0s.rendered

  depends_on = [maas_vm_instance.k8s_controller, maas_vm_instance.k8s_worker]
}

# k0s additional controller instances
resource "maas_vm_instance" "k8s_controller" {
  for_each  = local.controller_instances_map
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 4096
  storage   = 30
  hostname  = "${var.hostname_prefix}-c${each.key}"
  zone      = "10-3-24-0"
  user_data = data.template_file.cloud_init_k0s.rendered
}

# k0s worker instances
resource "maas_vm_instance" "k8s_worker" {
  for_each  = local.worker_instances_map
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 4096
  storage   = 30
  hostname  = "${var.hostname_prefix}-w${each.key}"
  zone      = "10-3-24-0"
  user_data = data.template_file.cloud_init_k0s.rendered
}
