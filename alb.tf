resource "aws_lb_target_group" "tf-target" {
    vpc_id = aws_vpc.project-vpc.id
  name     = "tf-target"
  port     = 80
  protocol = "HTTP"
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.project-asg.name
  lb_target_group_arn   = aws_lb_target_group.tf-target.arn
}

data "aws_subnet" "subnet-pub-1" {
  id = aws_subnet.private_subnet.id
}
data "aws_subnet" "subnet-pub-2" {
  id = aws_subnet.public_subnet2.id
}



resource "aws_lb" "class" {
  name               = "test-elb"

  subnets            = [data.aws_subnet.subnet-pub-1.id, data.aws_subnet.subnet-pub-2.id]
    security_groups     = [aws_security_group.project-security-group.id]
 

   

}

output "alb_arn" {
  value = aws_lb.class.arn
}
resource "aws_lb_listener" "class" {
  load_balancer_arn = aws_lb.class.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = aws_lb_target_group.tf-target.arn
    type             = "forward"
  }
}


