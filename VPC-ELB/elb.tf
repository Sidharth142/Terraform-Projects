# Create a new load balancer
resource "aws_elb" "terra-elb" {
  name               = "terra-elb"
  subnets = aws_subnet.jette_web1.*.id
  security_groups = [aws_security_group.jette_elb_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = [aws_instance.webservers[0].id, aws_instance.webservers[1].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "terraform-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.terra-elb.dns_name
}