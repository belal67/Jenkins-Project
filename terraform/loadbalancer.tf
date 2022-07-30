resource "aws_lb" "lb" {
  name               = "lb1"
  internal           = false
  load_balancer_type = "application"
  security_groups = [module.network.sg_allow_http]
  subnets            = [module.network.private_1 , module.network.private_2 ]

  enable_deletion_protection = true

  tags = {
    name = "loadbalancer"
  }
}
resource "aws_lb_target_group" "target-group" {
    health_check {
      interval = 10
      path = "/"
      protocol = "HTTP"
      timeout = 5
      healthy_threshold = 5
      unhealthy_threshold = 2
    }

    name = "TG-1"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = module.network.vpc
}

resource "aws_lb_listener" "aws_lb_listener" {
    load_balancer_arn = aws_lb.lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.target-group.arn
      type = "forward"
    }
}

resource "aws_lb_target_group_attachment" "ec2-attach" {
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id = aws_instance.linux-server.id
    port = 80
  
}