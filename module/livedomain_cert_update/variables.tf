variable "region" {
  description = "Region to use with hcloud"
  type        = string
}

variable "account" {
  description = "Region to use with hcloud"
  type        = string
}

variable "domain" {
  description = "Domain name for the live cert"
  type        = string
}

variable "cert_id" {
  description = "The certificate ID to bind"
  type        = string
}

variable "cert_source" {
  description = "Certificate source (usually scm)"
  type        = string
  default     = "scm"
}
variable "access_key" {
  description = "access_key"
  type        = string
}

variable "secret_key" {
  description = "secret_key"
  type        = string
}