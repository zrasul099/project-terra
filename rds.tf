resource "aws_db_subnet_group" "example_subnet_group" {
  name       = "example-subnet-group"
  subnet_ids = ["${aws_subnet.private_subnet.id}","${aws_subnet.private_subnet1.id}"]
}
resource "aws_db_instance" "example_db_instance" {
  identifier           = "example-db-instance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"

  username             = "admin"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.example_subnet_group.name
  vpc_security_group_ids = [aws_security_group.project-security-group.id] # Replace with your security group ID

  
  skip_final_snapshot     = true
  final_snapshot_identifier = "final-snapshot-name"
}