locals {
  worker_instances_count     = 3
  controller_instances_count = 2

  worker_instances_list     = [for i in range(1, local.worker_instances_count + 1) : i]
  controller_instances_list = [for i in range(2, local.controller_instances_count + 1) : i]

  worker_instances_map     = zipmap(local.worker_instances_list, local.worker_instances_list)
  controller_instances_map = zipmap(local.controller_instances_list, local.controller_instances_list)
}


# This Host is used to provision the k0s cluster
resource "maas_vm_instance" "k8s_controller_init" {
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 2048
  storage   = 12
  hostname  = "cloud-hf-24-c1"
  zone      = "10-3-24-0"
  user_data = file("${path.module}/cloud_init_k0s.yaml")

  depends_on = [ maas_vm_instance.k8s_controller, maas_vm_instance.k8s_worker ]
}

# k0s additional controller instances
resource "maas_vm_instance" "k8s_controller" {
  for_each  = local.controller_instances_map
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 2048
  storage   = 12
  hostname  = "cloud-hf-24-c${each.key}"
  zone      = "10-3-24-0"
}

# k0s worker instances
resource "maas_vm_instance" "k8s_worker" {
  for_each  = local.worker_instances_map
  kvm_no    = data.maas_vm_host.default.no
  cpu_count = 2
  memory    = 4096
  storage   = 12
  hostname  = "cloud-hf-24-w${each.key}"
  zone      = "10-3-24-0"
}