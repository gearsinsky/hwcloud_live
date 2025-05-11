# 推流 CNAME
output "push_cnames" {
  value = {
    for k, mod in module.push_domains :
    k => mod.push_cname
  }
}

# 拉流 CNAME
output "pull_cnames" {
  value = {
    for k, mod in module.pull_domains :
    k => mod.pull_cname
  }
}

# ICP 拉流 CNAME
output "icp_pull_cnames" {
  value = {
    for k, mod in module.icp_pull_domains :
    k => mod.icp_pull_cname
  }
}

# 憑證 ID（一般）
output "certificate_id" {
  value = huaweicloud_ccm_certificate_import.general.id
}

# 憑證 ID（ICP）
output "certificate_icp_id" {
  value = huaweicloud_ccm_certificate_import.icp.id
}