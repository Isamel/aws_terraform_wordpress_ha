region = "us-east-1"
enabled = true

route53_zone_name = "wordpress2020-test.com"

security_group_name = "HTTP ingress"
security_group_vpc_id = "vpc-024414cd4f4d5377b"
security_group_ingress = [{from_port = 80, to_port = 0, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "Security group ingress for alb port 80"}]
security_group_egress = [{from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", description = "Security group egress for alb, all outbound traffic"}]

alb_name = "wordpress"
alb_internal = false
alb_idle_timeout = 60
alb_idle_load_balancer_type = "
alb_idle_enable_deletion_protection = false
alb_idle_enable_cross_zone_load_balancing = true
alb_listener_port = 80
alb_internalb_listener_protocolal = "HTTP"
alb_listener_ssl_policy = null
alb_listener_certificate_arn = null
alb_listener_default_action_type = "fixed-response"
alb_listener_default_action_fixed_response_content_type ="text/plain"
alb_listener_default_action_fixed_response_message_body = "404: page not found"
alb_listener_default_action_fixed_response_status_code = 400
alb_target_group_name = "wordpress"
alb_target_group_port = 80
alb_target_group_protocol = "HTTP"
alb_target_group_stickiness_type = "lb_cooke"
alb_target_group_stickiness_cookie_duration = 86400
alb_target_group_health_check_path = "/wordpress/login"
alb_target_group_health_check_healthy_threshold = 2
alb_target_group_health_check_unhealthy_threshold = 2
alb_target_group_health_check_timeout = 10
alb_target_group_health_check_interval = 30
alb_target_group_health_check_matcher = "200,301,302"
route53_record_name = "devops"
route53_record_type = "A"
route53_record_alias_evaluate_target_health =  true
launch_template_name_prefix = "wordpres"
aunch_template_image_id = "ami-0d95a0efecd52127f" # cambiar por el id de la imagen de packer
launch_template_instance_type = "t2.medium"
autoscaling_group_desired_capacity = 2
autoscaling_group_max_size = 2
autoscaling_group_min_size = 2
autoscaling_group_launch_template_version = "$Latest"
db_instance_allocated_storage = 50
db_instance_max_allocated_storage = 100
db_instance_storage_type = "gp2"
db_instance_engine = "mysql"
db_instance_engine_version = "5.7"
db_instance_instance_class = "db.t2.micro"
variable "db_instance_name = "wordpress"
variable "db_instance_username = "wordpress"
variable "db_instance_password = "wordpress225346564789680r"
variable "db_instance_parameter_group_name = "default.mysql5.7"
variable "db_instance_multi_az = true
extra_tags = {
    ApplicationName = "wordpress"
}