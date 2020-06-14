module "route53_zone_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_zone.git"
    
    route53_zone_count      = var.enabled  ? 1 : 0
    route53_zone_depends_on = var.route53_zone_depends_on
    route53_zone_name       = var.route53_zone_name
    extra_tags              = local.tags
}

module "security_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_security_group.git"
    
    security_group_count      = var.enabled  ? 1 : 0
    security_group_depends_on = var.security_group_depends_on
    security_group_name       = var.security_group_name
    security_group_vpc_id     = var.security_group_vpc_id
    security_group_ingress    = var.security_group_ingress
    security_group_egress     = var.security_group_egress
    extra_tags                = local.tags
}

data "aws_subnet_ids" "subnet_ids_terraform" {
    vpc_id = var.vpc_id
}

module "alb_terraform" {
    source = "git@github.com:Isamel/aws_terraform_application_load_balancer.git"
    
    alb_count                                 = var.enabled ? 1 : 0
    alb_depends_on                            = [
        join("", module.route53_zone_terraform.route53_zone.*.zone_id),
        join("", module.security_group_terraform.security_group.*.id)
    ]
    alb_name                                  = var.alb_name
    alb_internal                              = var.alb_internal
    alb_idle_timeout                          = var.alb_idle_timeout
    alb_idle_load_balancer_type               = var.alb_idle_load_balancer_type
    alb_idle_security_groups                  = [join("", module.security_group_terraform.security_group.*.id)]
    alb_idle_subnets                          = [data.aws_subnet_ids.subnet_ids_terraform[0], data.aws_subnet_ids.subnet_ids_terraform[1],]
    alb_idle_enable_deletion_protection       = var.alb_idle_enable_deletion_protection
    alb_idle_enable_cross_zone_load_balancing = var.alb_idle_enable_cross_zone_load_balancing
    extra_tags                                = local.tags
}

module "alb_listener_terraform" {
    source = "git@github.com:Isamel/aws_terraform_load_balancer_listener.git"
    
    alb_listener_count                                      = var.enabled ? 1 : 0
    alb_listener_depends_on                                 = [join("", module.alb_terraform.alb.*.arn)]
    alb_listener_load_balancer_arn                          = join("", module.alb_terraform.alb.*.arn)
    alb_listener_port                                       = var.alb_listener_port
    alb_listener_protocol                                   = var.alb_listener_protocol
    alb_listener_ssl_policy                                 = var.alb_listener_ssl_policy
    alb_listener_certificate_arn                            = var.alb_listener_certificate_arn
    alb_listener_default_action_type                        = var.alb_listener_default_action_type
    alb_listener_default_action_fixed_response_content_type = var.alb_listener_default_action_fixed_response_content_type
    alb_listener_default_action_fixed_response_message_body = var.alb_listener_default_action_fixed_response_message_body
    alb_listener_default_action_fixed_response_status_code  = var.alb_listener_default_action_fixed_response_status_code
}

module "alb_listener_rule_terraform" {
    source = "git@github.com:Isamel/aws_terraform_load_balancer_listener_rule.git"
    
    alb_listener_rule_count                       = var.enabled ? 1 : 0
    alb_listener_rule_depends_on                  = [join("", module.alb_listener_terraform.alb_listener.*.arn)]
    alb_listener_rule_listener_arn                = join("", module.alb_listener_terraform.alb_listener.*.arn)
    alb_listener_rule_condition_field             = var.alb_listener_rule_condition_field
    alb_listener_rule_condition_values            = var.alb_listener_rule_condition_values
    alb_listener_rule_action_type                 = var.alb_listener_rule_action_type
    alb_listener_rule_action_redirect_port        = var.alb_listener_rule_action_redirect_port
    alb_listener_rule_action_redirect_protocol    = var.alb_listener_rule_action_redirect_protocol
    alb_listener_rule_action_redirect_status_code = var.alb_listener_rule_action_redirect_status_code
    alb_listener_rule_action_target_group_arn     = 
}