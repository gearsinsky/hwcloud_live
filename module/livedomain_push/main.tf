terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.73.7"
    }
  }
}

resource "huaweicloud_live_domain" "push_video" {
  name = var.push_domain
  type = "push"
}