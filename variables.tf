variable "region" {
    type        = string
    description = "region."
}

variable "enabled" {
    type        = bool
    default     = true
    description = "enabled."
}

variable "route53_zone_depends_on" {
    type        = list(string)
    default     = []
    description = "route53 zone depends on."
}

variable "route53_zone_name" {
    type        = string
    description = "route53 zone name."
}

variable "security_group_depends_on" {
    type        = list(string)
    description = "security group depends on."
}

variable "security_group_name" {
    type        = string
    description = "security group name."
}

variable "security_group_vpc_id" {
    type        = string
    description = "security group vpc id."
}

variable "security_group_ingress" {
    type        = list(map(string))
    description = "security group ingress."
}

variable "security_group_egress" {
    type        = list(map(string))
    description = "security group egress."
}

variable "alb_name" {
    type        = string
    description = "alb name."
}

variable "alb_internal" {
    type        = bool
    description = "alb internal."
}

variable "alb_idle_timeout" {
    type        = number
    description = "alb idle timeout."
}

variable "alb_idle_load_balancer_type" {
    type        = string
    description = "alb idle load balancer type."
}

variable "alb_idle_security_groups" {
    type        = list(string)
    description = "alb idle security groups."
}

variable "alb_idle_enable_deletion_protection" {
    type        = bool
    description = "alb idle enable deletion protection."
}

variable "alb_idle_enable_cross_zone_load_balancing" {
    type        = bool
    description = "alb idle enable cross zone load balancing."
}

variable "alb_listener_port" {
    type        = number
    description = "alb listener port."
}

variable "alb_internalb_listener_protocolal" {
    type        = string
    description = "alb listener protocol."
}

variable "alb_listener_ssl_policy" {
    type        = string
    description = "alb listener ssl policy."
}

variable "alb_listener_certificate_arn" {
    type        = string
    description = "alb listener certificate arn."
}

variable "alb_listener_default_action_type" {
    type        = string
    description = "alb listener default action type."
}

variable "alb_listener_default_action_fixed_response_content_type" {
    type        = string
    description = "alb listener default action fixed response content type."
}

variable "alb_listener_default_action_fixed_response_message_body" {
    type        = string
    description = "alb listener default action fixed response message body."
}

variable "alb_listener_default_action_fixed_response_status_code" {
    type        = number
    description = "alb listener default action fixed response status code."
}

variable "alb_listener_rule_condition_field" {
    type        = string
    description = "alb listener rule condition field."
}

variable "alb_listener_rule_condition_values" {
    type        = list(string)
    description = "alb listener rule condition values."
}

variable "alb_listener_rule_action_type" {
    type        = string
    description = "alb listener rule action type."
}

variable "alb_listener_rule_action_redirect_port" {
    type        = number
    description = "alb listener rule action redirect port."
}

variable "alb_listener_rule_action_redirect_protocol" {
    type        = string
    description = "alb listener rule action redirect protocol."
}

variable "alb_listener_rule_action_redirect_status_code" {
    type        = string
    description = "alb listener rule action redirect status code."
}

variable "alb_target_group_name" {
    type        = string
    description = "alb target group name."
}

variable "alb_target_group_port" {
    type        = number
    description = "alb target group port."
}

variable "alb_target_group_protocol" {
    type        = string
    description = "alb target group protocol."
}

variable "alb_target_group_stickiness_type" {
    type        = string
    description = "alb target group stickiness type."
}

variable "alb_target_group_stickiness_cookie_duration" {
    type        = number
    description = "alb target group stickiness cookie duration."
}

variable "alb_target_group_health_check_path" {
    type        = string
    description = "alb target group health check path."
}

variable "alb_target_group_health_check_healthy_threshold" {
    type        = number
    description = "alb target group health check healthy threshold."
}

variable "alb_target_group_health_check_unhealthy_threshold" {
    type        = number
    description = "alb target group health check unhealthy threshold."
}

variable "alb_target_group_health_check_timeout" {
    type        = number
    description = "alb target group health check timeout."
}

variable "alb_target_group_health_check_interval" {
    type        = number
    description = "alb target group health check interval."
}

variable "alb_target_group_health_check_matcher" {
    type        = string
    description = "alb target group health check matcher."
}

variable "route53_record_zone_id" {
    type        = string
    description = "route53 record zone id."
}

variable "route53_record_name" {
    type        = string
    description = "route53 record name."
}

variable "route53_record_type" {
    type        = string
    description = "route53 record type."
}

variable "route53_record_alias_name" {
    type        = string
    description = "route53 record alias name."
}

variable "route53_record_alias_evaluate_target_health" {
    type        = string
    description = "route53 record alias evaluate target health."
}

variable "launch_template_name_prefix" {
    type        = string
    description = "launch template name prefix."
}

variable "launch_template_image_id" {
    type        = string
    description = "launch template image id."
}

variable "launch_template_instance_type" {
    type        = string
    description = "launch template instance type."
}

variable "autoscaling_group_desired_capacity" {
    type        = number
    description = "autoscaling group desired capacity."
}

variable "autoscaling_group_max_size" {
    type        = number
    description = "autoscaling group max size."
}

variable "autoscaling_group_min_size" {
    type        = number
    description = "autoscaling group min size."
}

variable "autoscaling_group_launch_template_id" {
    type        = string
    description = "autoscaling group launch template id."
}

variable "autoscaling_group_launch_template_version" {
    type        = string
    description = "autoscaling group launch template version."
}

variable "extra_tags" {
    type        = map(string)
    description = "extra tags."
}