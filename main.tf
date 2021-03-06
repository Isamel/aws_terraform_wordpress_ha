###
###Modulo para crear el nombre del dominio base
module "route53_zone_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_zone.git"
    
    route53_zone_count      = var.enabled  ? 1 : 0
    route53_zone_depends_on = [""]
    route53_zone_name       = var.route53_zone_name
    extra_tags              = local.tags
}

###
### Modulo para crear el grupo de seguridad para el ALB
### este ALB utiliza el puerto 80 para comunicarse con internet
module "security_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_security_group.git"
    
    security_group_count      = var.enabled  ? 1 : 0
    security_group_depends_on = [""]
    security_group_name       = var.security_group_name
    security_group_vpc_id     = var.security_group_vpc_id
    security_group_ingress    = var.security_group_ingress
    security_group_egress     = var.security_group_egress
    extra_tags                = local.tags
}

###
###Se obtiene las redes disponibles en la cuenta
data "aws_subnet_ids" "subnet_ids_terraform" {
    vpc_id = var.vpc_id
}

###
###Modulo para crear el ALB, que se utilizara para realizar el balanceo de sito en las dos zonas
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
    alb_idle_subnets                          = [
        data.aws_subnet_ids.subnet_ids_terraform[0], 
        data.aws_subnet_ids.subnet_ids_terraform[1]
    ]
    alb_idle_enable_deletion_protection       = var.alb_idle_enable_deletion_protection
    alb_idle_enable_cross_zone_load_balancing = var.alb_idle_enable_cross_zone_load_balancing
    extra_tags                                = local.tags
}

###
###Modulo para crear el listener para el puerto 80 y la respuesta por defecto
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

###
### Modulo para crea un target para enlazar las vm y el ALB
module "alb_target_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_target_group.git"
    
    alb_target_group_count                            = var.enabled ? 1 : 0
    alb_target_group_depends_on                       = [join("", module.alb_terraform.alb.*.arn)]
    alb_target_group_name                             = var.alb_target_group_name
    alb_target_group_port                             = var.alb_target_group_port
    alb_target_group_protocol                         = var.alb_target_group_protocol
    alb_target_group_vpc_id                           = var.alb_target_group_vpc_id
    alb_target_group_stickiness_type                  = var.alb_target_group_stickiness_type
    alb_target_group_stickiness_cookie_duration       = var.alb_target_group_stickiness_cookie_duration
    alb_target_group_health_check_path                = var.alb_target_group_health_check_path
    alb_target_group_health_check_healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
    alb_target_group_health_check_unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
    alb_target_group_health_check_timeout             = var.alb_target_group_health_check_timeout
    alb_target_group_health_check_interval            = var.alb_target_group_health_check_interval
    alb_target_group_health_check_matcher             = var.alb_target_group_health_check_matcher
}

###
### Modulo para crear un alias al ALB
module "route53_record_terraform" {
    source = "git@github.com:Isamel/aws_terraform_route53_record.git"
    
    route53_record_count                        = var.enabled ? 1 : 0
    route53_record_depends_on                   = [
        join("", module.route53_zone_terraform.route53_zone.*.zone_id),
        join("", module.alb_terraform.alb.*.zone_id)
    ]
    route53_record_zone_id                      = join("", module.route53_zone_terraform.route53_zone.*.zone_id)
    route53_record_name                         = var.route53_record_name
    route53_record_type                         = var.route53_record_type
    route53_record_alias_name                   = join("", module.alb_terraform.alb.*.dns_name)
    route53_record_alias_zone_id                = join("", module.alb_terraform.alb.*.zone_id)
    route53_record_alias_evaluate_target_health = var.route53_record_alias_evaluate_target_health
    extra_tags                                  = local.tags
}

###
### Modulo para crear el template que tilizara el grupo de auto escala
module "launch_template_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_launch_template.git"
    
    launch_template_count                        = var.enabled ? 1 : 0
    launch_template_depends_on                   = [""]
    launch_template_name_prefix                 = var.launch_template_name_prefix
    launch_template_image_id                    = var.launch_template_image_id
    launch_template_instance_type               = var.launch_template_instance_type
    extra_tags                                  = local.tags
}

### se obtien el nombre de las zonas
data "aws_availability_zones" "availability_zones_terraform" {
  state = "available"
}

###
### Modulo para crear un grupo de auto escala, este esta configurado para crear dos instancias en dos zonas diferentes
### y asi garantizar la alta disponibilidad
module "autoscaling_group_terraform" {
    source = "git@github.com:Isamel/aws_terraform_autoscaling_group.git"
    
    autoscaling_group_count                   = var.enabled ? 1 : 0
    autoscaling_group_depends_on              = [
        join("", module.launch_template_group_terraform.launch_template.*.id)
    ]
    autoscaling_group_availability_zones      = [
        data.aws_availability_zones.availability_zones_terraform.names[0], 
        data.aws_availability_zones.availability_zones_terraform.names[1]
    ]
    autoscaling_group_desired_capacity        = var.autoscaling_group_desired_capacity
    autoscaling_group_max_size                = var.autoscaling_group_max_size
    autoscaling_group_min_size                = var.autoscaling_group_min_size
    autoscaling_group_launch_template_id      = join("", module.launch_template_group_terraform.launch_template.*.id)
    autoscaling_group_launch_template_version = var.autoscaling_group_launch_template_version
    extra_tags                                = local.tags
}

###
### Modulo para atachear las instancias del grupo de auto escala al ALB
module "autoscaling_attachment_terraform" {
    source = "git@github.com:Isamel/aws_terraform_autoscaling_attachment.git"
    
    autoscaling_attachment_count                  = var.enabled ? 1 : 0
    autoscaling_attachment_depends_on             = [
        join("", module.autoscaling_group_terraform.autoscaling_group.*.id),
        join("", module.alb_target_group_terraform.alb_target_group.*.arn)
    ]
    autoscaling_attachment_autoscaling_group_name = join("", module.autoscaling_group_terraform.autoscaling_group.*.id)
    autoscaling_attachment_alb_target_group_arn   = join("", module.alb_target_group_terraform.alb_target_group.*.arn)
}

###
### Modulo para crear un rds con mysql que esta configurado  para que utilize dos zonas quedando una de las instancias como
### replica por si la instancia principal se cae, el cambio es automatico y como utiliza un LB regional no cambia la URL
module "db_instance_terraform" {
    source = "git@github.com:Isamel/aws_terraform_db_instance.git"
    
    db_instance_count                 = var.enabled ? 1 : 0
    db_instance_depends_on            = [null_resource.depends_on]
    db_instance_allocated_storage     = var.db_instance_allocated_storage
    db_instance_max_allocated_storage = var.db_instance_max_allocated_storage
    db_instance_storage_type          = var.db_instance_storage_type
    db_instance_engine                = var.db_instance_engine
    db_instance_engine_version        = var.db_instance_engine_version
    db_instance_instance_class        = var.db_instance_instance_class
    db_instance_name                  = var.db_instance_name
    db_instance_username              = var.db_instance_username
    db_instance_password              = var.db_instance_password
    db_instance_parameter_group_name  = var.db_instance_parameter_group_name
    db_instance_multi_az              = var.db_instance_multi_az
    extra_tags                        = local.tags
}