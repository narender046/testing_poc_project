######################################################
# DATA
######################################################

 
resource "aws_lb" "demo-app-lb" {
    name = "platts-web-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.app-lb-sg.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    enable_deletion_protection = false
    tags = local.common_tags
}

resource "aws_lb_target_group" "demo-app-tg" {
    name = "demo-app-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.demo_vpc.id
    tags = local.common_tags
}

resource "aws_lb_listener" "demo-app-lb-listner" {
    load_balancer_arn = aws_lb.demo-app-lb.arn
    port = 80
    protocol = "HTTP"
    
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.demo-app-tg.arn
    }
    tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "webserver1" {
    target_group_arn = aws_lb_target_group.demo-app-tg.arn
    target_id = aws_instance.webserver1.id
    port = 80
}

resource "aws_lb_target_group_attachment" "webserver2" {
    target_group_arn = aws_lb_target_group.demo-app-tg.arn
    target_id =  aws_instance.webserver2.id
    port = 80
}