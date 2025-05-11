output "pull_domain" {
  value = huaweicloud_live_domain.pull_video.name
}
output "pull_cname" {
  value = huaweicloud_live_domain.pull_video.cname
}
output "push_domain" {
  value = huaweicloud_live_domain.pull_video.ingest_domain_name
}