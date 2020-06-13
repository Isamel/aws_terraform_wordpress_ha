locals {
  tags  = merge(
      map("key", "project", "value", "wordpress-ha"),
      var.extra_tags
  )
}