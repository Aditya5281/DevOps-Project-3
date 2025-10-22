variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "dev_subscription_id" {}
variable "prod_subscription_id" {}


variable "asp_dev" {
  type = string
}

variable "asp_prod" {
  type = string
}

variable "webapp" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "aks_name" {
  type = string
}