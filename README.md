# AWS WordPress Terraform

A [Terraform](https://en.wikipedia.org/wiki/Terraform_(software)) configuration to provision [WordPress](https://wordpress.org/download/) image into [AWS EC2](https://aws.amazon.com/ec2/).

## Prerequisites

* Have an AWS account - [Free Tier](https://aws.amazon.com/us/free/)
* An access key in [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) with enough permissions to create resources
* AWS CLI
* Terraform cli `>= 0.12.20`
* Public/private ssh key pair

## Steps

### 1. Clone the repository
```bash
git clone git@github.com:0xnu/aws_wordpress_terraform.git
cd aws_wordpress_terraform
```

### 2. Set environment vars

* Update `{repository}/config/aws-credentials` with `access_key` and `access_secret`
* Update the ssh public key in var `public_key` at `{repository}config/vars.tfvars`

### 3. Init the backend
```bash
terraform init
```

### 4. Show the plan
```bash
terraform plan -var-file=config/vars.tfvars
```

### 5. Build the infra with apply
```bash
terraform apply -var-file=config/vars.tfvars
```

### 6. Unlock

* Get the public ip/dns address from terraform output vars: `wordpress_public_ip` or `wordpress_public_dns`
* Access to the wp-admin console at: `https://{server_address}`. Unlock your WordPress setup with the `Instance ID`.

### 7. SSH: connect to terminal

Connect to the instance by using `root` user at {server_address} with the private key generated {private_pair_key}

```bash
ssh root@{server_address} -i {private_pair_key}
```

## How to Uninstall

To uninstall the instance destroy all resources with a single terraform command

```bash
terraform destroy -var-file=config/vars.tfvars
```

## Authors

- **Finbarrs Oketunji** _aka 0xnu_ - _Main Developer_ - [0xnu](https://github.com/0xnu)

## License

This project is licensed under the [WTFPL License](LICENSE) - see the file for details.

## Copyright

(c) 2020 [Finbarrs Oketunji](https://finbarrs.eu).

