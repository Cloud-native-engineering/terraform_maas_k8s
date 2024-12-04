# Terraform Automation of K0s Setup on MAAS

Provisioning with Terraform to deploy a High Availability Kubernetes cluster using K0s on [MAAS](https://maas.io) (Metal as a Service) from Canonical.

## Usage

1. **Initialize Terraform:**

   ```sh
   terraform init
   ```

2. **Export necessary variables:**

   ```sh
   export TF_VAR_url=<MAAS-URL>
   export TF_VAR_key=<API-KEY-4-MAAS>
   export TF_VAR_hostname_prefix=<KVM-HOST>
   ```

3. **Plan the deployment:**

   ```sh
   terraform plan
   ```

4. **Apply the deployment:**

   ```sh
   terraform apply
   ```

5. **Destroy the deployment:**

   ```sh
   terraform destroy
   ```

## Configuration

- **cloud_init_k0s.tftpl:** Cloud-init template configuration for K0s setup.
- **main.tf:** Main Terraform configuration file.
- **provider.tf:** Provider configuration for Terraform.
- **variables.tf:** Variable definitions for Terraform.

### How to Change Kubernetes Nodes

To change the nodes, follow these steps:

1. Update the following variables:

   ```hcl
   worker_instances_count     = 3
   controller_instances_count = 2
   ```

> Yes really that's all you need to do...

## Disclaimer

This code is intended for educational purposes only and includes a publicly known SSH key. It should not be used in production environments.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](LICENSE) file for details.

## Author Information

This code was created in 2024 by [Yves Wetter](mailto:yves.wetter@edu.tbz.ch).
