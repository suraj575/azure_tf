

variable "location" {
  type        = string
  description = "Name of the region for this infreastructure"
  default     = "East US 2"
}

# variable "vnet_name" {
#   type        = string
#   description = "Name for this infrastructure"
# }

# variable "address_space" {
#   type        = string
#   description = "Name for this infrastructure"
# }


variable "resource_group_name" {
  type        = string
  description = "Name for this infrastructure"
}

# variable "nat_name" {
#   type        = string
#   description = "Name for this infrastructure"
# }


variable "cosmos_db_cluster_name" {
}

variable "kubernetes_cluster_name" {

}

variable "availability_zones" {

}
variable "enable_auto_scaling" {

}
variable "min_count" {

}
variable "max_count" {

}
variable "max_pods" {

}
variable "acr_name" {

}
variable "node_pool_name" {
  
}
variable "storage_account_name" {
  
}

# variable "frontend_acr_name" {

# }