output "icp_pull_domain" {
  value = huaweicloud_live_domain.icp_pull.name
}
output "icp_pull_cname" {
  value = huaweicloud_live_domain.icp_pull.cname
}
output "push_domain" {
  value = huaweicloud_live_domain.icp_pull.ingest_domain_name
}