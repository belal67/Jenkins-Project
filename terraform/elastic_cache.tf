# resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
#     name       = "elasticache-subnet-group"
#     subnet_ids = [module.network.private_1]
# }

# resource "aws_elasticache_cluster" "example" {
#     cluster_id           = "cluster-example"
#     engine               = "redis"
#     node_type            = "cache.t2.micro"
#     num_cache_nodes      = 1
#     parameter_group_name = "default.redis3.2"
#     engine_version       = "3.2.10"
#     port                 = 6379
#     subnet_group_name    = "elasticache-subnet-group"#aws_elasticache_subnet_group.elasticache-subnet-group.name

# }