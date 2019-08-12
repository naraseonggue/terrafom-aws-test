resource "aws_lb" "test" {
    name               = "test-lb-tf"
    internal           = false
    load_balancer_type = "application"
    security_groups    = ["${aws_security_group.lb_sg.id}"]
 #AZ 별로 subnet 하나씩 추가 public으로
    subnets            = ["${aws_subnet.public.*.id}","${aws_subnet.public-B.id"]

    enable_deletion_protection = true

    access_logs {
      bucket  = "${aws_s3_bucket.lb_logs.bucket}"
      prefix  = "test-lb"
      enabled = true
    }

    tags = {
      Environment = "production"
    }
}
    
