terraform {
  required_version = ">= 0.12"
}

output "terraform_version" {
  value = "${terraform.version}"
}

