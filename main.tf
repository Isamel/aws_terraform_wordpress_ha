module "route53_zone_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_zone.git"
    
    route53_zone_count      = var.route53_zone_count
    route53_zone_depends_on = var.route53_zone_depends_on
    route53_zone_name       = var.route53_zone_name
    extra_tags              = local.tags
}