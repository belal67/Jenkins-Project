resource "aws_secretsmanager_secret" "secret2" {
  name = "secret2"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "version" {
  secret_id     = aws_secretsmanager_secret.secret2.id
  secret_string = tls_private_key.key_pair.id
}

output "instance_id" {
  value = aws_instance.linux-server.id
}

output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.secret2.id
}

output "secretsmanager_secret_version" {
  value = aws_secretsmanager_secret_version.version.id
}