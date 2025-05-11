terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.73.7"
    }
  }
}


resource "huaweicloud_live_domain" "pull_video" {
  name               = var.pull_domain
  type               = "pull"
  #中國境外
  service_area = "outside_mainland_china" 
  ingest_domain_name = var.ingest_domain_name
}