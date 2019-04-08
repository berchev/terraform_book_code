## How to use locking of your state file
- [Install terragrunt](https://github.com/gruntwork-io/terragrunt)
- Instead of use `.terragrunt` file (deprecated), add section `terragrunt {}` in your `terraform.tfvars` file
```
terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket  = "berchev-terraform-book-state"
      key     = "example_locking/terraform.tfstate"
      region  = "us-east-1"
      encrypt = true
      dynamodb_table = "my-lock-table"
    }
  }
}
```
- Add below section to your `main.tf` file in order to point remote location of your state file
```
terraform {
  backend "s3" {
    bucket  = "berchev-terraform-book-state"
    region  = "us-east-1"
    key     = "example_locking/terraform.tfstate"
    encrypt = true
  }
}
```
- Run following commands
    - terraform init
    - terragrunt plan
    - terragrunt apply
    - terragrunt destroy
 
## This is sample output from above commands

```
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ terraform init

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.5"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ 
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ terragrunt plan
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:50:33 Running command: terraform --version
[terragrunt] 2019/04/08 09:50:33 Reading Terragrunt config file at /home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example/terraform.tfvars
[terragrunt] 2019/04/08 09:50:33 Backend config has changed from map[bucket:berchev-terraform-book-state encrypt:%!s(bool=true) key:example_locking/terraform.tfstate region:us-east-1] to map[bucket:berchev-terraform-book-state dynamodb_table:my-lock-table encrypt:%!s(bool=true) key:example_locking/terraform.tfstate region:us-east-1]
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:50:33 Backend config has changed from map[bucket:berchev-terraform-book-state encrypt:%!s(bool=true) key:example_locking/terraform.tfstate region:us-east-1] to map[bucket:berchev-terraform-book-state dynamodb_table:my-lock-table encrypt:%!s(bool=true) key:example_locking/terraform.tfstate region:us-east-1]
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:50:33 Initializing remote state for the s3 backend
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:50:35 Running command: terraform init -backend-config=region=us-east-1 -backend-config=encrypt=true -backend-config=dynamodb_table=my-lock-table -backend-config=bucket=berchev-terraform-book-state -backend-config=key=example_locking/terraform.tfstate

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.5"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[terragrunt] 2019/04/08 09:50:46 Running command: terraform plan
Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.example
      id:                                    <computed>
      ami:                                   "ami-40d28157"
      arn:                                   <computed>
      associate_public_ip_address:           <computed>
      availability_zone:                     <computed>
      cpu_core_count:                        <computed>
      cpu_threads_per_core:                  <computed>
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      get_password_data:                     "false"
      host_id:                               <computed>
      instance_state:                        <computed>
      instance_type:                         "t2.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              "vagrant_nomad_key"
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      password_data:                         <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             <computed>
      tags.%:                                "1"
      tags.Name:                             "terraform-example"
      tenancy:                               <computed>
      user_data:                             "573ae80d6f80170bd2d2a622aaf17be93928944b"
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_security_group.instance
      id:                                    <computed>
      arn:                                   <computed>
      description:                           "Managed by Terraform"
      egress.#:                              <computed>
      ingress.#:                             "2"
      ingress.2541437006.cidr_blocks.#:      "1"
      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"
      ingress.2541437006.description:        ""
      ingress.2541437006.from_port:          "22"
      ingress.2541437006.ipv6_cidr_blocks.#: "0"
      ingress.2541437006.prefix_list_ids.#:  "0"
      ingress.2541437006.protocol:           "tcp"
      ingress.2541437006.security_groups.#:  "0"
      ingress.2541437006.self:               "false"
      ingress.2541437006.to_port:            "22"
      ingress.516175195.cidr_blocks.#:       "1"
      ingress.516175195.cidr_blocks.0:       "0.0.0.0/0"
      ingress.516175195.description:         ""
      ingress.516175195.from_port:           "8080"
      ingress.516175195.ipv6_cidr_blocks.#:  "0"
      ingress.516175195.prefix_list_ids.#:   "0"
      ingress.516175195.protocol:            "tcp"
      ingress.516175195.security_groups.#:   "0"
      ingress.516175195.self:                "false"
      ingress.516175195.to_port:             "8080"
      name:                                  "terraform-example-instance"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                <computed>


Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

Releasing state lock. This may take a few moments...
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ 
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ terragrunt apply
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:52:03 Running command: terraform --version
[terragrunt] 2019/04/08 09:52:03 Reading Terragrunt config file at /home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example/terraform.tfvars
[terragrunt] 2019/04/08 09:52:05 Running command: terraform apply
Acquiring state lock. This may take a few moments...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.example
      id:                                    <computed>
      ami:                                   "ami-40d28157"
      arn:                                   <computed>
      associate_public_ip_address:           <computed>
      availability_zone:                     <computed>
      cpu_core_count:                        <computed>
      cpu_threads_per_core:                  <computed>
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      get_password_data:                     "false"
      host_id:                               <computed>
      instance_state:                        <computed>
      instance_type:                         "t2.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              "vagrant_nomad_key"
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      password_data:                         <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             <computed>
      tags.%:                                "1"
      tags.Name:                             "terraform-example"
      tenancy:                               <computed>
      user_data:                             "573ae80d6f80170bd2d2a622aaf17be93928944b"
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_security_group.instance
      id:                                    <computed>
      arn:                                   <computed>
      description:                           "Managed by Terraform"
      egress.#:                              <computed>
      ingress.#:                             "2"
      ingress.2541437006.cidr_blocks.#:      "1"
      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"
      ingress.2541437006.description:        ""
      ingress.2541437006.from_port:          "22"
      ingress.2541437006.ipv6_cidr_blocks.#: "0"
      ingress.2541437006.prefix_list_ids.#:  "0"
      ingress.2541437006.protocol:           "tcp"
      ingress.2541437006.security_groups.#:  "0"
      ingress.2541437006.self:               "false"
      ingress.2541437006.to_port:            "22"
      ingress.516175195.cidr_blocks.#:       "1"
      ingress.516175195.cidr_blocks.0:       "0.0.0.0/0"
      ingress.516175195.description:         ""
      ingress.516175195.from_port:           "8080"
      ingress.516175195.ipv6_cidr_blocks.#:  "0"
      ingress.516175195.prefix_list_ids.#:   "0"
      ingress.516175195.protocol:            "tcp"
      ingress.516175195.security_groups.#:   "0"
      ingress.516175195.self:                "false"
      ingress.516175195.to_port:             "8080"
      name:                                  "terraform-example-instance"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                <computed>


Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_security_group.instance: Creating...
  arn:                                   "" => "<computed>"
  description:                           "" => "Managed by Terraform"
  egress.#:                              "" => "<computed>"
  ingress.#:                             "" => "2"
  ingress.2541437006.cidr_blocks.#:      "" => "1"
  ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2541437006.description:        "" => ""
  ingress.2541437006.from_port:          "" => "22"
  ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"
  ingress.2541437006.prefix_list_ids.#:  "" => "0"
  ingress.2541437006.protocol:           "" => "tcp"
  ingress.2541437006.security_groups.#:  "" => "0"
  ingress.2541437006.self:               "" => "false"
  ingress.2541437006.to_port:            "" => "22"
  ingress.516175195.cidr_blocks.#:       "" => "1"
  ingress.516175195.cidr_blocks.0:       "" => "0.0.0.0/0"
  ingress.516175195.description:         "" => ""
  ingress.516175195.from_port:           "" => "8080"
  ingress.516175195.ipv6_cidr_blocks.#:  "" => "0"
  ingress.516175195.prefix_list_ids.#:   "" => "0"
  ingress.516175195.protocol:            "" => "tcp"
  ingress.516175195.security_groups.#:   "" => "0"
  ingress.516175195.self:                "" => "false"
  ingress.516175195.to_port:             "" => "8080"
  name:                                  "" => "terraform-example-instance"
  owner_id:                              "" => "<computed>"
  revoke_rules_on_delete:                "" => "false"
  vpc_id:                                "" => "<computed>"
aws_security_group.instance: Creation complete after 6s (ID: sg-0fcf02e1112e1edcb)
aws_instance.example: Creating...
  ami:                               "" => "ami-40d28157"
  arn:                               "" => "<computed>"
  associate_public_ip_address:       "" => "<computed>"
  availability_zone:                 "" => "<computed>"
  cpu_core_count:                    "" => "<computed>"
  cpu_threads_per_core:              "" => "<computed>"
  ebs_block_device.#:                "" => "<computed>"
  ephemeral_block_device.#:          "" => "<computed>"
  get_password_data:                 "" => "false"
  host_id:                           "" => "<computed>"
  instance_state:                    "" => "<computed>"
  instance_type:                     "" => "t2.micro"
  ipv6_address_count:                "" => "<computed>"
  ipv6_addresses.#:                  "" => "<computed>"
  key_name:                          "" => "vagrant_nomad_key"
  network_interface.#:               "" => "<computed>"
  network_interface_id:              "" => "<computed>"
  password_data:                     "" => "<computed>"
  placement_group:                   "" => "<computed>"
  primary_network_interface_id:      "" => "<computed>"
  private_dns:                       "" => "<computed>"
  private_ip:                        "" => "<computed>"
  public_dns:                        "" => "<computed>"
  public_ip:                         "" => "<computed>"
  root_block_device.#:               "" => "<computed>"
  security_groups.#:                 "" => "<computed>"
  source_dest_check:                 "" => "true"
  subnet_id:                         "" => "<computed>"
  tags.%:                            "" => "1"
  tags.Name:                         "" => "terraform-example"
  tenancy:                           "" => "<computed>"
  user_data:                         "" => "573ae80d6f80170bd2d2a622aaf17be93928944b"
  volume_tags.%:                     "" => "<computed>"
  vpc_security_group_ids.#:          "" => "1"
  vpc_security_group_ids.3903175153: "" => "sg-0fcf02e1112e1edcb"
aws_instance.example: Still creating... (10s elapsed)
aws_instance.example: Still creating... (20s elapsed)
aws_instance.example: Still creating... (30s elapsed)
aws_instance.example: Creation complete after 30s (ID: i-07a51067f5dab1906)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ 
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ terragrunt destroy
[terragrunt] [/home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example] 2019/04/08 09:53:38 Running command: terraform --version
[terragrunt] 2019/04/08 09:53:38 Reading Terragrunt config file at /home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example/terraform.tfvars
[terragrunt] 2019/04/08 09:53:40 Running command: terraform destroy
Acquiring state lock. This may take a few moments...
aws_security_group.instance: Refreshing state... (ID: sg-0fcf02e1112e1edcb)
aws_instance.example: Refreshing state... (ID: i-07a51067f5dab1906)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_instance.example

  - aws_security_group.instance


Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.example: Destroying... (ID: i-07a51067f5dab1906)
aws_instance.example: Still destroying... (ID: i-07a51067f5dab1906, 10s elapsed)
aws_instance.example: Still destroying... (ID: i-07a51067f5dab1906, 20s elapsed)
aws_instance.example: Still destroying... (ID: i-07a51067f5dab1906, 30s elapsed)
aws_instance.example: Destruction complete after 34s
aws_security_group.instance: Destroying... (ID: sg-0fcf02e1112e1edcb)
aws_security_group.instance: Destruction complete after 2s

Destroy complete! Resources: 2 destroyed.
Releasing state lock. This may take a few moments...
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ 
gberchev@pc-split24-hp:~/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_3/locking_example$ 
```