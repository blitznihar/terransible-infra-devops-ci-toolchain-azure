variable "env" {
  description = "env: dev or prod"
}

variable "client_id" {
  description = "azure client id"
  type        = "map"
}

variable "client_secret" {
  description = "azure client secret"
  type        = "map"
}

variable "subscription_id" {
  description = "azure subscription id"
  type        = "map"
}

variable "tenant_id" {
  description = "azure tenant id"
  type        = "map"
}
