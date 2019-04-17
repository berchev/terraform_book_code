## Description

This chapter contain ruby script located in live/prod/services/webserver-cluster directory. 

Purpose of this script is to test terraform code which deploy webserver-cluster.

In order to run the script you need to do the following:
- change to **chapter_6/live/prod/services/webserver-cluster** directory
- run `terraform init`
- construct command **ruby terraform-test.rb your_region your_bucket_name path_to_database_state** in my case `ruby terraform-test.rb us-east-1 berchev-terraform-book-state prod/data-stores/mysql/terraform.tfstate`
- note that after running the above command, script will NOT prompt you to type `yes` in order to create resources. You need to type `yes` and to hit `enter`!
- script should create 11 resources and then to destroy them
- script output
```
gberchev@pc-split24-hp webserver-cluster (ch_6_start) $ ruby terraform-test.rb us-east-1 berchev-terraform-book-state prod/data-stores/mysql/terraform.tfstateDeploying code in /home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_6/live/prod/services/webserver-cluster
- module.webserver_cluster
yes
data.terraform_remote_state.db: Refreshing state...
data.aws_availability_zones.all: Refreshing state...
data.aws_ami.ubuntu: Refreshing state...
data.template_file.user_data: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + module.webserver_cluster.aws_autoscaling_group.example
      id:                                     <computed>
      arn:                                    <computed>
      availability_zones.#:                   "6"
      availability_zones.1252502072:          "us-east-1f"
      availability_zones.1305112097:          "us-east-1b"
      availability_zones.2762590996:          "us-east-1d"
      availability_zones.3551460226:          "us-east-1e"
      availability_zones.3569565595:          "us-east-1a"
      availability_zones.986537655:           "us-east-1c"
      default_cooldown:                       <computed>
      desired_capacity:                       <computed>
      force_delete:                           "false"
      health_check_grace_period:              "300"
      health_check_type:                      "ELB"
      launch_configuration:                   "${aws_launch_configuration.example.id}"
      load_balancers.#:                       "1"
      load_balancers.3603464733:              "terraform-asg-example"
      max_size:                               "10"
      metrics_granularity:                    "1Minute"
      min_elb_capacity:                       "2"
      min_size:                               "2"
      name:                                   "${var.cluster_name}-${aws_launch_configuration.example.name}"
      protect_from_scale_in:                  "false"
      service_linked_role_arn:                <computed>
      tag.#:                                  "1"
      tag.3541701189.key:                     "Name"
      tag.3541701189.propagate_at_launch:     "true"
      tag.3541701189.value:                   "QXUFYH"
      target_group_arns.#:                    <computed>
      vpc_zone_identifier.#:                  <computed>
      wait_for_capacity_timeout:              "10m"

  + module.webserver_cluster.aws_autoscaling_schedule.scale_in_at_night
      id:                                     <computed>
      arn:                                    <computed>
      autoscaling_group_name:                 "${aws_autoscaling_group.example.name}"
      desired_capacity:                       "2"
      end_time:                               <computed>
      max_size:                               "10"
      min_size:                               "2"
      recurrence:                             "0 17 * * *"
      scheduled_action_name:                  "scale-in-at-night"
      start_time:                             <computed>

  + module.webserver_cluster.aws_autoscaling_schedule.scale_out_during_business_hours
      id:                                     <computed>
      arn:                                    <computed>
      autoscaling_group_name:                 "${aws_autoscaling_group.example.name}"
      desired_capacity:                       "10"
      end_time:                               <computed>
      max_size:                               "10"
      min_size:                               "2"
      recurrence:                             "0 9 * * *"
      scheduled_action_name:                  "scale-out-during-business-hours"
      start_time:                             <computed>

  + module.webserver_cluster.aws_cloudwatch_metric_alarm.high_cpu_utilization
      id:                                     <computed>
      actions_enabled:                        "true"
      alarm_name:                             "QXUFYH-high-cpu-utilization"
      arn:                                    <computed>
      comparison_operator:                    "GreaterThanThreshold"
      dimensions.%:                           <computed>
      evaluate_low_sample_count_percentiles:  <computed>
      evaluation_periods:                     "1"
      metric_name:                            "CPUUtilization"
      namespace:                              "AWS/EC2"
      period:                                 "300"
      statistic:                              "Average"
      threshold:                              "90"
      treat_missing_data:                     "missing"
      unit:                                   "Percent"

  + module.webserver_cluster.aws_cloudwatch_metric_alarm.low_cpu_credit_balance
      id:                                     <computed>
      actions_enabled:                        "true"
      alarm_name:                             "QXUFYH-low-cpu-credit-balance"
      arn:                                    <computed>
      comparison_operator:                    "LessThanThreshold"
      dimensions.%:                           <computed>
      evaluate_low_sample_count_percentiles:  <computed>
      evaluation_periods:                     "1"
      metric_name:                            "CPUCreditBalance"
      namespace:                              "AWS/EC2"
      period:                                 "300"
      statistic:                              "Minimum"
      threshold:                              "10"
      treat_missing_data:                     "missing"
      unit:                                   "Count"

  + module.webserver_cluster.aws_elb.example
      id:                                     <computed>
      arn:                                    <computed>
      availability_zones.#:                   "6"
      availability_zones.1252502072:          "us-east-1f"
      availability_zones.1305112097:          "us-east-1b"
      availability_zones.2762590996:          "us-east-1d"
      availability_zones.3551460226:          "us-east-1e"
      availability_zones.3569565595:          "us-east-1a"
      availability_zones.986537655:           "us-east-1c"
      connection_draining:                    "false"
      connection_draining_timeout:            "300"
      cross_zone_load_balancing:              "true"
      dns_name:                               <computed>
      health_check.#:                         "1"
      health_check.0.healthy_threshold:       "2"
      health_check.0.interval:                "30"
      health_check.0.target:                  "HTTP:8080/"
      health_check.0.timeout:                 "3"
      health_check.0.unhealthy_threshold:     "2"
      idle_timeout:                           "60"
      instances.#:                            <computed>
      internal:                               <computed>
      listener.#:                             "1"
      listener.3931999347.instance_port:      "8080"
      listener.3931999347.instance_protocol:  "http"
      listener.3931999347.lb_port:            "80"
      listener.3931999347.lb_protocol:        "http"
      listener.3931999347.ssl_certificate_id: ""
      name:                                   "terraform-asg-example"
      security_groups.#:                      <computed>
      source_security_group:                  <computed>
      source_security_group_id:               <computed>
      subnets.#:                              <computed>
      zone_id:                                <computed>

  + module.webserver_cluster.aws_launch_configuration.example
      id:                                     <computed>
      associate_public_ip_address:            "false"
      ebs_block_device.#:                     <computed>
      ebs_optimized:                          <computed>
      enable_monitoring:                      "true"
      image_id:                               "ami-028d6461780695a43"
      instance_type:                          "t2.micro"
      key_name:                               <computed>
      name:                                   <computed>
      root_block_device.#:                    <computed>
      security_groups.#:                      <computed>
      user_data:                              "a9af257b9bc7f0832b4a9c1c6d55f0545b6c2897"

  + module.webserver_cluster.aws_security_group.elb
      id:                                     <computed>
      arn:                                    <computed>
      description:                            "Managed by Terraform"
      egress.#:                               <computed>
      ingress.#:                              <computed>
      name:                                   "QXUFYH-elb"
      owner_id:                               <computed>
      revoke_rules_on_delete:                 "false"
      vpc_id:                                 <computed>

  + module.webserver_cluster.aws_security_group.instance
      id:                                     <computed>
      arn:                                    <computed>
      description:                            "Managed by Terraform"
      egress.#:                               <computed>
      ingress.#:                              "1"
      ingress.516175195.cidr_blocks.#:        "1"
      ingress.516175195.cidr_blocks.0:        "0.0.0.0/0"
      ingress.516175195.description:          ""
      ingress.516175195.from_port:            "8080"
      ingress.516175195.ipv6_cidr_blocks.#:   "0"
      ingress.516175195.prefix_list_ids.#:    "0"
      ingress.516175195.protocol:             "tcp"
      ingress.516175195.security_groups.#:    "0"
      ingress.516175195.self:                 "false"
      ingress.516175195.to_port:              "8080"
      name:                                   "QXUFYH-instance"
      owner_id:                               <computed>
      revoke_rules_on_delete:                 "false"
      vpc_id:                                 <computed>

  + module.webserver_cluster.aws_security_group_rule.allow_all_outbound
      id:                                     <computed>
      cidr_blocks.#:                          "1"
      cidr_blocks.0:                          "0.0.0.0/0"
      from_port:                              "0"
      protocol:                               "-1"
      security_group_id:                      "${aws_security_group.elb.id}"
      self:                                   "false"
      source_security_group_id:               <computed>
      to_port:                                "0"
      type:                                   "egress"

  + module.webserver_cluster.aws_security_group_rule.allow_http_inbound
      id:                                     <computed>
      cidr_blocks.#:                          "1"
      cidr_blocks.0:                          "0.0.0.0/0"
      from_port:                              "80"
      protocol:                               "tcp"
      security_group_id:                      "${aws_security_group.elb.id}"
      self:                                   "false"
      source_security_group_id:               <computed>
      to_port:                                "80"
      type:                                   "ingress"


Plan: 11 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 
module.webserver_cluster.aws_security_group.elb: Creating...
  arn:                    "" => "<computed>"
  description:            "" => "Managed by Terraform"
  egress.#:               "" => "<computed>"
  ingress.#:              "" => "<computed>"
  name:                   "" => "QXUFYH-elb"
  owner_id:               "" => "<computed>"
  revoke_rules_on_delete: "" => "false"
  vpc_id:                 "" => "<computed>"
module.webserver_cluster.aws_security_group.instance: Creating...
  arn:                                  "" => "<computed>"
  description:                          "" => "Managed by Terraform"
  egress.#:                             "" => "<computed>"
  ingress.#:                            "" => "1"
  ingress.516175195.cidr_blocks.#:      "" => "1"
  ingress.516175195.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.516175195.description:        "" => ""
  ingress.516175195.from_port:          "" => "8080"
  ingress.516175195.ipv6_cidr_blocks.#: "" => "0"
  ingress.516175195.prefix_list_ids.#:  "" => "0"
  ingress.516175195.protocol:           "" => "tcp"
  ingress.516175195.security_groups.#:  "" => "0"
  ingress.516175195.self:               "" => "false"
  ingress.516175195.to_port:            "" => "8080"
  name:                                 "" => "QXUFYH-instance"
  owner_id:                             "" => "<computed>"
  revoke_rules_on_delete:               "" => "false"
  vpc_id:                               "" => "<computed>"
module.webserver_cluster.aws_security_group.elb: Creation complete after 5s (ID: sg-05026f138192ddab3)
module.webserver_cluster.aws_security_group_rule.allow_all_outbound: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "0"
  protocol:                 "" => "-1"
  security_group_id:        "" => "sg-05026f138192ddab3"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "0"
  type:                     "" => "egress"
module.webserver_cluster.aws_security_group_rule.allow_http_inbound: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "80"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-05026f138192ddab3"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "80"
  type:                     "" => "ingress"
module.webserver_cluster.aws_elb.example: Creating...
  arn:                                    "" => "<computed>"
  availability_zones.#:                   "" => "6"
  availability_zones.1252502072:          "" => "us-east-1f"
  availability_zones.1305112097:          "" => "us-east-1b"
  availability_zones.2762590996:          "" => "us-east-1d"
  availability_zones.3551460226:          "" => "us-east-1e"
  availability_zones.3569565595:          "" => "us-east-1a"
  availability_zones.986537655:           "" => "us-east-1c"
  connection_draining:                    "" => "false"
  connection_draining_timeout:            "" => "300"
  cross_zone_load_balancing:              "" => "true"
  dns_name:                               "" => "<computed>"
  health_check.#:                         "" => "1"
  health_check.0.healthy_threshold:       "" => "2"
  health_check.0.interval:                "" => "30"
  health_check.0.target:                  "" => "HTTP:8080/"
  health_check.0.timeout:                 "" => "3"
  health_check.0.unhealthy_threshold:     "" => "2"
  idle_timeout:                           "" => "60"
  instances.#:                            "" => "<computed>"
  internal:                               "" => "<computed>"
  listener.#:                             "" => "1"
  listener.3931999347.instance_port:      "" => "8080"
  listener.3931999347.instance_protocol:  "" => "http"
  listener.3931999347.lb_port:            "" => "80"
  listener.3931999347.lb_protocol:        "" => "http"
  listener.3931999347.ssl_certificate_id: "" => ""
  name:                                   "" => "terraform-asg-example"
  security_groups.#:                      "" => "1"
  security_groups.262250599:              "" => "sg-05026f138192ddab3"
  source_security_group:                  "" => "<computed>"
  source_security_group_id:               "" => "<computed>"
  subnets.#:                              "" => "<computed>"
  zone_id:                                "" => "<computed>"
module.webserver_cluster.aws_security_group.instance: Creation complete after 6s (ID: sg-02298133fab223af0)
module.webserver_cluster.aws_launch_configuration.example: Creating...
  associate_public_ip_address: "" => "false"
  ebs_block_device.#:          "" => "<computed>"
  ebs_optimized:               "" => "<computed>"
  enable_monitoring:           "" => "true"
  image_id:                    "" => "ami-028d6461780695a43"
  instance_type:               "" => "t2.micro"
  key_name:                    "" => "<computed>"
  name:                        "" => "<computed>"
  root_block_device.#:         "" => "<computed>"
  security_groups.#:           "" => "1"
  security_groups.755472701:   "" => "sg-02298133fab223af0"
  user_data:                   "" => "a9af257b9bc7f0832b4a9c1c6d55f0545b6c2897"
module.webserver_cluster.aws_security_group_rule.allow_all_outbound: Creation complete after 2s (ID: sgrule-2678127625)
module.webserver_cluster.aws_launch_configuration.example: Creation complete after 2s (ID: terraform-20190417080826188400000001)
module.webserver_cluster.aws_security_group_rule.allow_http_inbound: Creation complete after 4s (ID: sgrule-219721362)
module.webserver_cluster.aws_elb.example: Still creating... (10s elapsed)
module.webserver_cluster.aws_elb.example: Creation complete after 13s (ID: terraform-asg-example)
module.webserver_cluster.aws_autoscaling_group.example: Creating...
  arn:                                "" => "<computed>"
  availability_zones.#:               "" => "6"
  availability_zones.1252502072:      "" => "us-east-1f"
  availability_zones.1305112097:      "" => "us-east-1b"
  availability_zones.2762590996:      "" => "us-east-1d"
  availability_zones.3551460226:      "" => "us-east-1e"
  availability_zones.3569565595:      "" => "us-east-1a"
  availability_zones.986537655:       "" => "us-east-1c"
  default_cooldown:                   "" => "<computed>"
  desired_capacity:                   "" => "<computed>"
  force_delete:                       "" => "false"
  health_check_grace_period:          "" => "300"
  health_check_type:                  "" => "ELB"
  launch_configuration:               "" => "terraform-20190417080826188400000001"
  load_balancers.#:                   "" => "1"
  load_balancers.3603464733:          "" => "terraform-asg-example"
  max_size:                           "" => "10"
  metrics_granularity:                "" => "1Minute"
  min_elb_capacity:                   "" => "2"
  min_size:                           "" => "2"
  name:                               "" => "QXUFYH-terraform-20190417080826188400000001"
  protect_from_scale_in:              "" => "false"
  service_linked_role_arn:            "" => "<computed>"
  tag.#:                              "" => "1"
  tag.3541701189.key:                 "" => "Name"
  tag.3541701189.propagate_at_launch: "" => "true"
  tag.3541701189.value:               "" => "QXUFYH"
  target_group_arns.#:                "" => "<computed>"
  vpc_zone_identifier.#:              "" => "<computed>"
  wait_for_capacity_timeout:          "" => "10m"
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (30s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (40s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (50s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m0s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m30s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m40s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (1m50s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m0s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m30s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m40s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (2m50s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (3m0s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (3m10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still creating... (3m20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Creation complete after 3m28s (ID: QXUFYH-terraform-20190417080826188400000001)
module.webserver_cluster.aws_autoscaling_schedule.scale_out_during_business_hours: Creating...
  arn:                    "" => "<computed>"
  autoscaling_group_name: "" => "QXUFYH-terraform-20190417080826188400000001"
  desired_capacity:       "" => "10"
  end_time:               "" => "<computed>"
  max_size:               "" => "10"
  min_size:               "" => "2"
  recurrence:             "" => "0 9 * * *"
  scheduled_action_name:  "" => "scale-out-during-business-hours"
  start_time:             "" => "<computed>"
module.webserver_cluster.aws_autoscaling_schedule.scale_in_at_night: Creating...
  arn:                    "" => "<computed>"
  autoscaling_group_name: "" => "QXUFYH-terraform-20190417080826188400000001"
  desired_capacity:       "" => "2"
  end_time:               "" => "<computed>"
  max_size:               "" => "10"
  min_size:               "" => "2"
  recurrence:             "" => "0 17 * * *"
  scheduled_action_name:  "" => "scale-in-at-night"
  start_time:             "" => "<computed>"
module.webserver_cluster.aws_cloudwatch_metric_alarm.high_cpu_utilization: Creating...
  actions_enabled:                       "" => "true"
  alarm_name:                            "" => "QXUFYH-high-cpu-utilization"
  arn:                                   "" => "<computed>"
  comparison_operator:                   "" => "GreaterThanThreshold"
  dimensions.%:                          "" => "1"
  dimensions.AutoScalingGroupName:       "" => "QXUFYH-terraform-20190417080826188400000001"
  evaluate_low_sample_count_percentiles: "" => "<computed>"
  evaluation_periods:                    "" => "1"
  metric_name:                           "" => "CPUUtilization"
  namespace:                             "" => "AWS/EC2"
  period:                                "" => "300"
  statistic:                             "" => "Average"
  threshold:                             "" => "90"
  treat_missing_data:                    "" => "missing"
  unit:                                  "" => "Percent"
module.webserver_cluster.aws_cloudwatch_metric_alarm.low_cpu_credit_balance: Creating...
  actions_enabled:                       "" => "true"
  alarm_name:                            "" => "QXUFYH-low-cpu-credit-balance"
  arn:                                   "" => "<computed>"
  comparison_operator:                   "" => "LessThanThreshold"
  dimensions.%:                          "" => "1"
  dimensions.AutoScalingGroupName:       "" => "QXUFYH-terraform-20190417080826188400000001"
  evaluate_low_sample_count_percentiles: "" => "<computed>"
  evaluation_periods:                    "" => "1"
  metric_name:                           "" => "CPUCreditBalance"
  namespace:                             "" => "AWS/EC2"
  period:                                "" => "300"
  statistic:                             "" => "Minimum"
  threshold:                             "" => "10"
  treat_missing_data:                    "" => "missing"
  unit:                                  "" => "Count"
module.webserver_cluster.aws_autoscaling_schedule.scale_in_at_night: Creation complete after 2s (ID: scale-in-at-night)
module.webserver_cluster.aws_autoscaling_schedule.scale_out_during_business_hours: Creation complete after 2s (ID: scale-out-during-business-hours)
module.webserver_cluster.aws_cloudwatch_metric_alarm.high_cpu_utilization: Creation complete after 2s (ID: QXUFYH-high-cpu-utilization)
module.webserver_cluster.aws_cloudwatch_metric_alarm.low_cpu_credit_balance: Creation complete after 3s (ID: QXUFYH-low-cpu-credit-balance)

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

elb_dns_name = terraform-asg-example-919027110.us-east-1.elb.amazonaws.com
Output from http://terraform-asg-example-919027110.us-east-1.elb.amazonaws.com/: <h1>Hello, World</h1>
<p>DB address: terraform-20190417063806106500000001.ceoioaluzef0.us-east-1.rds.amazonaws.com</p>
<p>DB port: 3306</p>
Success!
Undeploying code in /home/gberchev/spreadsheet/terraform_up_and_running_book/terraform_book_code/chapter_6/live/prod/services/webserver-cluster
data.terraform_remote_state.db: Refreshing state...
aws_security_group.instance: Refreshing state... (ID: sg-02298133fab223af0)
aws_security_group.elb: Refreshing state... (ID: sg-05026f138192ddab3)
data.aws_availability_zones.all: Refreshing state...
data.aws_ami.ubuntu: Refreshing state...
aws_security_group_rule.allow_all_outbound: Refreshing state... (ID: sgrule-2678127625)
aws_security_group_rule.allow_http_inbound: Refreshing state... (ID: sgrule-219721362)
aws_elb.example: Refreshing state... (ID: terraform-asg-example)
data.template_file.user_data: Refreshing state...
aws_launch_configuration.example: Refreshing state... (ID: terraform-20190417080826188400000001)
aws_autoscaling_group.example: Refreshing state... (ID: QXUFYH-terraform-20190417080826188400000001)
aws_cloudwatch_metric_alarm.high_cpu_utilization: Refreshing state... (ID: QXUFYH-high-cpu-utilization)
aws_autoscaling_schedule.scale_in_at_night: Refreshing state... (ID: scale-in-at-night)
aws_cloudwatch_metric_alarm.low_cpu_credit_balance: Refreshing state... (ID: QXUFYH-low-cpu-credit-balance)
aws_autoscaling_schedule.scale_out_during_business_hours: Refreshing state... (ID: scale-out-during-business-hours)
module.webserver_cluster.aws_security_group_rule.allow_http_inbound: Destroying... (ID: sgrule-219721362)
module.webserver_cluster.aws_cloudwatch_metric_alarm.low_cpu_credit_balance: Destroying... (ID: QXUFYH-low-cpu-credit-balance)
module.webserver_cluster.aws_autoscaling_schedule.scale_in_at_night: Destroying... (ID: scale-in-at-night)
module.webserver_cluster.aws_security_group_rule.allow_all_outbound: Destroying... (ID: sgrule-2678127625)
module.webserver_cluster.aws_cloudwatch_metric_alarm.high_cpu_utilization: Destroying... (ID: QXUFYH-high-cpu-utilization)
module.webserver_cluster.aws_autoscaling_schedule.scale_out_during_business_hours: Destroying... (ID: scale-out-during-business-hours)
module.webserver_cluster.aws_autoscaling_schedule.scale_in_at_night: Destruction complete after 1s
module.webserver_cluster.aws_autoscaling_schedule.scale_out_during_business_hours: Destruction complete after 1s
module.webserver_cluster.aws_cloudwatch_metric_alarm.low_cpu_credit_balance: Destruction complete after 1s
module.webserver_cluster.aws_cloudwatch_metric_alarm.high_cpu_utilization: Destruction complete after 1s
module.webserver_cluster.aws_autoscaling_group.example: Destroying... (ID: QXUFYH-terraform-20190417080826188400000001)
module.webserver_cluster.aws_security_group_rule.allow_http_inbound: Destruction complete after 2s
module.webserver_cluster.aws_security_group_rule.allow_all_outbound: Destruction complete after 4s
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 30s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 40s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 50s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 1m0s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 1m10s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Still destroying... (ID: QXUFYH-terraform-20190417080826188400000001, 1m20s elapsed)
module.webserver_cluster.aws_autoscaling_group.example: Destruction complete after 1m29s
module.webserver_cluster.aws_elb.example: Destroying... (ID: terraform-asg-example)
module.webserver_cluster.aws_launch_configuration.example: Destroying... (ID: terraform-20190417080826188400000001)
module.webserver_cluster.aws_launch_configuration.example: Destruction complete after 1s
module.webserver_cluster.aws_security_group.instance: Destroying... (ID: sg-02298133fab223af0)
module.webserver_cluster.aws_elb.example: Destruction complete after 3s
module.webserver_cluster.aws_security_group.elb: Destroying... (ID: sg-05026f138192ddab3)
module.webserver_cluster.aws_security_group.instance: Destruction complete after 2s
module.webserver_cluster.aws_security_group.elb: Still destroying... (ID: sg-05026f138192ddab3, 10s elapsed)
module.webserver_cluster.aws_security_group.elb: Still destroying... (ID: sg-05026f138192ddab3, 20s elapsed)
module.webserver_cluster.aws_security_group.elb: Still destroying... (ID: sg-05026f138192ddab3, 30s elapsed)
module.webserver_cluster.aws_security_group.elb: Still destroying... (ID: sg-05026f138192ddab3, 40s elapsed)
module.webserver_cluster.aws_security_group.elb: Still destroying... (ID: sg-05026f138192ddab3, 50s elapsed)
module.webserver_cluster.aws_security_group.elb: Destruction complete after 57s

Destroy complete! Resources: 11 destroyed.
gberchev@pc-split24-hp webserver-cluster (ch_6_start) $
```
