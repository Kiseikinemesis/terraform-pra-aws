data "aws_security_group" "onprem_pra_sg" {
  name = "onprem_pra_sg"
}

data "aws_security_group" "global_app_sg" {
  name = "global_app_sg"
}

data "aws_security_group" "srvtsexxx" {
  name = "SRVTSExxx_sg"
}

resource "aws_launch_template" "srvtsexxx" {
  name          = "created-and-used-by-elastic-disaster-recovery-service-s-xxxxxxxxx-xxxx-xxxxxxxxx"
  instance_type = "c5.xlarge"
  #  vpc_security_group_ids = [module.security_groups.sg_ids["SRVTSExxx_sg"]]
  description            = "SRVTSExxx - Managed by Terraform"
  update_default_version = true
  disable_api_termination = true

  # Beware : order of mappings matters
  block_device_mappings {
    device_name = "c:0"
    ebs {
      volume_size           = 60
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
    }
  }

  block_device_mappings {
    device_name = "d:0"
    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
    }
  }

  iam_instance_profile {
    arn = data.aws_iam_instance_profile.basic.arn
  }

  network_interfaces {
    interface_type = "interface"
    #    ipv4_addresses = ["10.0.x.xxx"]
    private_ip_address = "10.0.x.xxx"
    subnet_id          = tolist(data.aws_subnets.private_az_1.ids)[0]
    security_groups = [
      data.aws_security_group.srvtsexxx.id,
      data.aws_security_group.global.id,
      data.aws_security_group.global_app.id
    ]

    delete_on_termination       = true
    description                 = "SRVTSExxx"
    device_index                = 0
    associate_public_ip_address = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name                                     = "SRVTSExxx"
      AWSElasticDisasterRecoveryManaged        = "drs.amazonaws.com"
      AWSElasticDisasterRecoverySourceServerID = "s-xxxxxxxxxxx"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name                                     = "SRVTSExxx"
      AWSElasticDisasterRecoveryManaged        = "drs.amazonaws.com"
      AWSElasticDisasterRecoverySourceServerID = "s-xxxxxxxxxxx"
    }
  }

  tag_specifications {
    resource_type = "network-interface"
    tags = {
      Name                                     = "SRVTSExxx"
      AWSElasticDisasterRecoveryManaged        = "drs.amazonaws.com"
      AWSElasticDisasterRecoverySourceServerID = "s-xxxxxxxxx"
    }
  }

  tags = {
    Name                              = "SRVTSExxx"
    Environment                       = "onprem-pra"
    Project                           = "onprem-pra"
    map-migrated                      = var.map_migrated_tag
    AWSElasticDisasterRecoveryManaged = "drs.amazonaws.com"
  }
}
