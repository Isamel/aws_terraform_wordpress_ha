module "route53_zone_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_zone.git"
    
    route53_zone_count      = var.enabled
    route53_zone_depends_on = var.route53_zone_depends_on
    route53_zone_name       = var.route53_zone_name
    extra_tags              = local.tags
}

module "security_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_zone.git"
    
    security_group_count      = var.enabled
    security_group_depends_on = var.security_group_depends_on
    security_group_name       = var.security_group_name
    security_group_vpc_id     = var.security_group_vpc_id
    security_group_ingress    = var.security_group_ingress
    security_group_egress     = var.security_group_egress
    extra_tags                = local.tags
}