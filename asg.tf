

resource "aws_autoscaling_group" "project-asg" {
  availability_zones = ["us-east-2a"]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2

  launch_template {
    id      = aws_launch_template.project_launch_template.id
    version = "$Latest"
  }
}