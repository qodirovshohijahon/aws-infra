variable "region" {
  type        = string
  # default     = "us-east-1"
  description = "Current Region"
}

variable "access_key" {
  type        = string
  description = "Access Key"
}

variable "secret_key" {
  type        = string
  description = "Secret Access Key"
}

variable "tags" {
  description = "Tags to Apply to Resources"
  type        = map(any)
  default = {
    Owner       = "Mustofa Kodirov"
    Environment = "Dev"
    Project     = "Registry"
  }
}

variable "ecr_name" {
  description = "The list of ecr names to create"
  type        = string
  default     = "edp-dev"
}

variable "image_mutability" {
  description = "Provide image mutability"
  type        = string
  default     = "MUTABLE"
}

variable "encrypt_type" {
  description = "Provide type of encryption here"
  type        = string
  default     = "KMS"
}