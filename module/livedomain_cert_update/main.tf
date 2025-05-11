#resource "null_resource" "update_https_cert" {
#  provisioner "local-exec" {
#    command = <<EOT
#      echo "b" | hcloud Live UpdateDomainHttpsCert \
#        --cli-region="${var.region}" \
#        --domain="${var.domain}" \
#        --tls_certificate.cert_id="${var.cert_id}" \
#        --tls_certificate.source="${var.cert_source}" \
#        --force_redirect=true
#    EOT
# }
#}
resource "null_resource" "update_https_cert" {
  provisioner "local-exec" {
    command = <<EOT
     # echo -e "y\nb" | hcloud Live UpdateDomainHttpsCert \
      echo -e "b" | hcloud --profile="${var.account}" Live UpdateDomainHttpsCert \
        --cli-region="${var.region}" \
        --domain="${var.domain}" \
        --tls_certificate.cert_id="${var.cert_id}" \
        --tls_certificate.source="${var.cert_source}" \
        --force_redirect=true
    EOT
  }

  triggers = {
    cert_id = var.cert_id
    #deleted_at = timestamp()  # 每次都觸發
  }
}