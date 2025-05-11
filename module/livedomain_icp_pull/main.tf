terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.73.7"
    }
  }
}

#provider "huaweicloud" {
#  access_key = var.access_key
#  secret_key = var.secret_key
#  region     = var.region
#}


resource "huaweicloud_live_domain" "icp_pull" {
  name               = var.icp_pull_domain
  type               = "pull"
  #全球加速
  service_area = "global" 
  ingest_domain_name = var.ingest_domain_name
}