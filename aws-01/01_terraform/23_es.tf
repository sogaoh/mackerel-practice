resource "aws_elasticsearch_domain" "test-world-es-domain" {
  domain_name           = "test-world-es"
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type = var.instance_type_es
    instance_count = var.instance_count_es
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.ebs_volume_type_es
    volume_size = var.ebs_volume_size_es
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "test-world-es"
  }
}

resource "aws_elasticsearch_domain_policy" "test-world-es_access_policy" {
  domain_name = aws_elasticsearch_domain.test-world-es-domain.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {
                  "aws:SourceIp": [
                    "${var.myhome_gip}/32",
                    "10.1.0.0/16",
                    "${aws_nat_gateway.default.public_ip}/32",
                    "${aws_instance.docker-01.public_ip}/32"
                  ]
                }
            },
            "Resource": "${aws_elasticsearch_domain.test-world-es-domain.arn}/*"
        }
    ]
}
POLICIES
}


output "es_arn" {
  value = aws_elasticsearch_domain.test-world-es-domain.arn
}

output "es_endpoint" {
  value = aws_elasticsearch_domain.test-world-es-domain.endpoint
}

output "kibana_endpoint" {
  value = aws_elasticsearch_domain.test-world-es-domain.kibana_endpoint
}