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

variable "extra_tags" {
    type        = map(string)
    description = "extra tags."
}