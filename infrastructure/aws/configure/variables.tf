variable "domain" {
  description = "(Required) Specify the Service Domain."
  type        = "string"
}

variable "name" {
  description = "(Required) Specify the Service Name."
  type        = "string"
}

variable "key" {
  description = "TF key"
  type        = "string"
}

variable "region" {
  description = "Region"
  type        = "string"
}

variable "bucket" {
  description = "bucket"
  type        = "string"
}

variable "shared_credentials_file" {
  description = "shared_credentials_file"
  type        = "string"
}