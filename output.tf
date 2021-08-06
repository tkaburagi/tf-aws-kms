output "kms" {
  value = [
    aws_kms_key.handson-key.key_id,
    aws_kms_key.handson-key.arn
  ]
}