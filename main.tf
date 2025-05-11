terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.73.7"
    }
  }
}

provider "huaweicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

locals {
  stream_profiles = {
    "1080" = {
      push_domain     = var.push_domain_1080
      pull_domain     = var.pull_domain_1080
      icp_pull_domain = var.icp_pull_domain_1080
    }
    "720" = {
      push_domain     = var.push_domain_720
      pull_domain     = var.pull_domain_720
      icp_pull_domain = var.icp_pull_domain_720
    }
  }

  certs = {
    general = {
      domain_name = var.domain_name
      cert_file   = var.cert_file
      key_file    = var.key_file
    }
    icp = {
      domain_name = var.icp_domain_name
      cert_file   = var.icp_cert_file
      key_file    = var.icp_key_file
    }
  }
}

module "push_domains" {
  for_each    = local.stream_profiles
  source      = "./modules/livedomain_push"
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = var.region
  push_domain = each.value.push_domain
}

module "pull_domains" {
  for_each           = local.stream_profiles
  source             = "./modules/livedomain_pull"
  access_key         = var.access_key
  secret_key         = var.secret_key
  region             = var.region
  pull_domain        = each.value.pull_domain
  ingest_domain_name = module.push_domains[each.key].push_domain
  depends_on         = [module.push_domains]
}

module "icp_pull_domains" {
  for_each           = local.stream_profiles
  source             = "./modules/livedomain_icp_pull"
  access_key         = var.access_key
  secret_key         = var.secret_key
  region             = var.region
  icp_pull_domain    = each.value.icp_pull_domain
  ingest_domain_name = module.push_domains[each.key].push_domain
  depends_on         = [module.push_domains]
}


resource "huaweicloud_ccm_certificate_import" "general" {
  name        = local.certs.general.domain_name
  certificate = file(local.certs.general.cert_file)
  region      = "ap-southeast-1"
  private_key = file(local.certs.general.key_file)
  depends_on  = [module.pull_domains]
}

resource "huaweicloud_ccm_certificate_import" "icp" {
  name        = local.certs.icp.domain_name
  certificate = file(local.certs.icp.cert_file)
  region      = "ap-southeast-1"
  private_key = file(local.certs.icp.key_file)
  depends_on  = [module.icp_pull_domains]
}

module "cert_bind_general" {
  for_each    = local.stream_profiles
  source      = "./modules/livedomain_cert_update"
  region      = var.region
  domain      = each.value.pull_domain
  access_key  = var.access_key
  secret_key  = var.secret_key
  account = var.account
  cert_id     = huaweicloud_ccm_certificate_import.general.id
  cert_source = "scm"
  depends_on  = [huaweicloud_ccm_certificate_import.general]
}

module "cert_bind_icp" {
  for_each    = local.stream_profiles
  source      = "./modules/livedomain_cert_update"
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
  account = var.account
  domain      = each.value.icp_pull_domain
  cert_id     = huaweicloud_ccm_certificate_import.icp.id
  cert_source = "scm"
  depends_on  = [huaweicloud_ccm_certificate_import.icp]
}