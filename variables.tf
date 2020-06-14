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

variable "extra_tags" {
    type        = map(string)
    description = "extra tags."
}