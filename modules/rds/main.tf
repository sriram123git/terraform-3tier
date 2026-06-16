resource "aws_db_instance" "mysql" {
  allocated_storage   = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = var.db_instance_class
  username            = "admin"
  password            = "Password123!"
  skip_final_snapshot = true
}
