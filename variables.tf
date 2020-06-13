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

variable "extra_tags" {
    type        = map(string)
    description = "extra tags."
}