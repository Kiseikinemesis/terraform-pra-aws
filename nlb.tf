NB : Une NLB ne peux contenir que 40 ports d'écoute. Au-delà il convient d'en refaire une ou plusieurs selon le besoin. 

#NLB EIP
data "aws_eip" "eip_nlb_onprem1" {
  tags = {
    Name = var.eip_nlb_onprem1_name
  }
}

data "aws_eip" "eip_nlb_onprem2" {
  tags = {
    Name = var.eip_nlb_onprem2_name
  }
}

data "aws_eip" "eip_nlb_onprem3" {
  tags = {
    Name = var.eip_nlb_onprem3_name
  }
}

#NLB SG
resource "aws_security_group" "nlb_onprem_pra_sg" {
  name   = var.nlb_sg_name
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.nlb_sg_name
  }
}

#NLB
resource "aws_lb" "nlb_onprem" {
  name                       = var.nlb_name
  load_balancer_type         = "network"
  enable_deletion_protection = true
  security_groups            = [aws_security_group.nlb_onprem_pra_sg.id]

  subnet_mapping {
    subnet_id     = values(data.aws_subnet.public)[1].id
    allocation_id = data.aws_eip.eip_nlb_onprem1.id
  }

  subnet_mapping {
    subnet_id     = values(data.aws_subnet.public)[0].id
    allocation_id = data.aws_eip.eip_nlb_onprem2.id
  }

  subnet_mapping {
    subnet_id     = values(data.aws_subnet.public)[2].id
    allocation_id = data.aws_eip.eip_nlb_onprem3.id
  }

  tags = {
    Name         = var.nlb_name
    Environment  = var.environment
    Project      = var.project
    map-migrated = var.map_migrated_tag
  }
}

resource "aws_route53_record" "nlb_remote_onprem_exemple_record" {
  zone_id = data.aws_route53_zone.zone_exemple.zone_id
  name    = "remote-onprem.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_lb.nlb_onprem.dns_name
    zone_id                = aws_lb.nlb_onprem.zone_id
    evaluate_target_health = true
  }
}

#SRV TSE XXX NOM DU CLIENT
resource "aws_lb_listener" "nlb_listener_onprem_xxx" {
  load_balancer_arn = aws_lb.nlb_onprem.arn
  port              = var.listener_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.SRVTSExxx_haproxy_tg.arn
  }
}

resource "aws_vpc_security_group_ingress_rule" "nlb_ingress_internet_33xxx_sg" {
  security_group_id = aws_security_group.nlb_onprem_pra_sg.id
  description       = var.ingress_rule_description
  from_port         = var.listener_port
  to_port           = var.listener_port
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_lb_target_group" "SRVTSExxx_haproxy_tg" {
  name     = var.target_group_name
  port     = var.listener_port
  protocol = "TCP"
  vpc_id   = data.aws_vpc.main.id
  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_target_group_attachment" "SRVTSExxx_haproxy_attachment" {
  target_group_arn = aws_lb_target_group.SRVTSExxx_haproxy_tg.arn
  target_id        = data.aws_instance.ec2_instance_haproxy.id
  port             = var.listener_port
}

resource "aws_lb_target_group_attachment" "SRVTSExxx_haproxy_attachment_2" {
  target_group_arn = aws_lb_target_group.SRVTSExxx_haproxy_tg.arn
  target_id        = data.aws_instance.ec2_instance_haproxy_2.id
  port             = var.listener_port
}
