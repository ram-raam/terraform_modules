#variable  "storage_account_id_synapse" {}
variable "Org" {}
variable "AZRegion"{}
variable "LZType" {}
variable "Env" {}
variable "resource_group_name" {}
variable "location"{}
variable "sql_administrator_login_synapse" {}
variable "sql_administrator_login_password_synapse" {}
variable "Tags" {}


#For storage
variable "bypass_internal_network_rules" {}
variable "permitted_virtual_network_subnet_ids" {}
#variable "enable_data_lake_filesystem" {}
variable "storage_account_replication_type" {}
variable "storage_account_tier" {}
variable "storage_rg" {}
variable "storage_account_name" {}
#variable "storage_account_name_synap" {}

variable "account_kind" {}
variable "default_action_nw_rule" {}


/* #Private ENdpoint
variable "private_endpoint_rg" {}
variable "private_subnet_id" {}
#variable "storage_private_dns_zone_id" {}
variable "private_dns_zone_id_dfs" {}
variable "private_dns_zone_id" {}
#variable "res_conn_id" { }
variable "sub_resource_list" {
    type = list(string)
} */
/* variable "pe_res_name" {}
variable "res_end_name" {} */
