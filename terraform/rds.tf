# resource "aws_db_subnet_group" "db_subnet" {
#   name       = "db_subnet"
#   subnet_ids = [module.network.private_1, module.network.private_2]
#   tags = {
#     Name = "db"
#   }
# }
resource "aws_db_instance" "db_1" {
    allocated_storage    = 10
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    db_name                 = "mydb"
    username             = "foo"
    password             = "foobarbaz"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot  = true
    db_subnet_group_name   = "db_subnet" #aws_db_subnet_group.db_subnet.name
    #publicly_accessible    = true
}
