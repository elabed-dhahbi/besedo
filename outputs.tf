output "ariane_instance_ip" {
  value = aws_instance.technical_test_ariane.public_ip
}

output "falcon_instance_ip" {
  value = aws_instance.technical_test_falcon.private_ip
}

output "redis_instance_ip" {
  value = aws_instance.technical_test_redis.private_ip
}
