terraform {

}

provider "aws" {
	region = "ap-northeast-1"
}

resource "aws_kms_key" "handson-key" {

}

resource "aws_kms_alias" "a" {
	name          = "alias/handson-key"
	target_key_id = aws_kms_key.handson-key.key_id
}

resource "aws_iam_user" "kms-handson" {
	name = "kms-handson"
}

resource "aws_iam_access_key" "kms-handson-access-key" {
	user = aws_iam_user.kms-handson.name
}

resource "aws_iam_user_policy" "kms-vault" {
	name = "kms-user-vault"
	user = aws_iam_user.kms-handson.name

	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:DescribeKey"
      ],
      "Resource": "${aws_kms_key.handson-key.arn}"
    }
  ]
}
EOF
}
