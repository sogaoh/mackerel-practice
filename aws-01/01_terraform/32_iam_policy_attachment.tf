resource "aws_iam_role_policy_attachment" "ec2-readonly-policy-attach" {
  role       = aws_iam_role.mackerel-aws-integration-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "rds-readonly-policy-attach" {
  role       = aws_iam_role.mackerel-aws-integration-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "es-readonly-policy-attach" {
  role       = aws_iam_role.mackerel-aws-integration-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonESReadOnlyAccess"
}
