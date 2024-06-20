module "nwchi" {
  source = "./nw"

  route53_zone_id = aws_route53_zone.jjxu-dev.zone_id
}
