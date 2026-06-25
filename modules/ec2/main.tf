resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  iam_instance_profile = var.iam_instance_profile

  user_data = <<EOF
#!/bin/bash
dnf update -y
dnf install httpd -y

systemctl enable httpd
systemctl start httpd

cat > /var/www/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
  <title>Terraform 3-Tier Project</title>
</head>
<body>
  <h1>Terraform HTTPS Project</h1>
  <h2>Web Tier: ALB</h2>
  <h2>App Tier: EC2</h2>
  <h2>DB Tier: RDS MySQL</h2>
  <p>Successfully deployed using Terraform</p>
</body>
</html>
HTML
EOF

  tags = {
    Name = "${var.environment}-app"
  }
}

#resource "aws_ebs_volume" "data" {
  #availability_zone = aws_instance.app.availability_zone
  #size              = 30

  #tags = {
    #Name = "${var.environment}-data-volume"
  #}
#}

#resource "aws_volume_attachment" "data_attach" {
 # device_name = "/dev/sdf"
  #volume_id   = aws_ebs_volume.data.id
  3instance_id = aws_instance.app.id
#}
