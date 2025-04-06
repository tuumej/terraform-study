provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}

resource "ncloud_login_key" "prd_login_key" {
  key_name = var.loginkey_name
}

resource "local_file" "prd_login_key_file" {
  content         = ncloud_login_key.prd_login_key.private_key
  filename        = "${ncloud_login_key.prd_login_key.key_name}.pem"
  file_permission = 0400
}

resource "ncloud_vpc" "prd_vpc" {
  name            = var.prd_vpc_name
  ipv4_cidr_block = var.prd_vpc_ip
}

resource "ncloud_access_control_group" "access_control_group" {
  description = ""
  name        = ""
  vpc_no      = ncloud_vpc.prd_vpc.vpc_no

}