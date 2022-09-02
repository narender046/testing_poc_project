output "aws_elb_public_dns" {
    value = aws_lb.demo-app-lb.dns_name
}


