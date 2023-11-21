variable "location" {}
variable "Tags" {}
variable "Org_caps" {}
variable "app_caps" {} 
variable "pcl_caps" {}
variable "env_caps" {}
variable "private_endpoint_rg" {}
variable "private_subnet_id" {}
#variable "private_dns_zone_id" {}
variable "res_conn_id" { }
variable "sub_resource_list" {
    type = list(string)
}
variable "resource_name" {}