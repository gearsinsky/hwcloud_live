output "push_domain" {
  value = huaweicloud_live_domain.push_video.name
}
output "push_cname" {
  value = huaweicloud_live_domain.push_video.cname
}
#output "push_domain" {
#  value = huaweicloud_live_domain.push_video.ingest_domain_name
#}