
resource "aws_launch_template" "project_launch_template" {
 
  description    = "Example Launch Template"
  
  image_id = var.insAMI
   
  instance_type = var.insType

  key_name = aws_key_pair.deployer.key_name

  

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id      = aws_subnet.private_subnet.id
    security_groups     = [aws_security_group.project-security-group.id]
  }
   

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ExampleInstance"
    }
  }
  user_data = filebase64("web-script.sh")
}



# resource "aws_launch_template" "prject-template" {
#   name = "prject-template"

#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }

#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options {
#     core_count       = 4
#     threads_per_core = 2
#   }

#   credit_specification {
#     cpu_credits = "standard"
#   }

#   disable_api_stop        = true
#   disable_api_termination = true

#   ebs_optimized = true

#   elastic_gpu_specifications {
#     type = "test"
#   }

#   elastic_inference_accelerator {
#     type = "eia1.medium"
#   }

#   iam_instance_profile {
#     name = "test"
#   }

#   image_id = var.insAMI

#   instance_initiated_shutdown_behavior = "terminate"


#   instance_type = var.insType

#   key_name = aws_key_pair.deployer.key_name

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#     instance_metadata_tags      = "enabled"
#   }

#   monitoring {
#     enabled = true
#   }

#   network_interfaces {
#     associate_public_ip_address = true
#   }

#   placement {
#     availability_zone = "${var.region}a}"
#   }

#   ram_disk_id = "test"

#   vpc_security_group_ids = [aws_security_group.project-security-group.id]

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       Name = "test"
#     }
#   }

#   user_data = filebase64("web-script.sh")
# }