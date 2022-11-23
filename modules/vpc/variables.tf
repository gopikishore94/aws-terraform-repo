variable "vpc_cidr" {}
variable "env" {}
variable "dns_enable" {
  default = "true"
}
variable "public_cidrs" {
  type = list(any)
}
variable "private_cidrs" {
  type = list(any)
}
variable "azs" {}
variable "public_ip_map" {
  default = "true"

}
