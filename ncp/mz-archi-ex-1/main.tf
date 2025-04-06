# VPC > User scenario > Scenario 1. Single Public Subnet
# https://docs.ncloud.com/ko/networking/vpc/vpc_userscenario1.html

provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}

resource "ncloud_login_key" "tf-mz-key" {
  key_name = var.loginkey_name
}

resource "ncloud_vpc" "vpc_mz" {
  name            = "tf-mz-vpc-1"
  ipv4_cidr_block = "10.0.1.0/24"
}

resource "ncloud_subnet" "tf_mz_pub_sub_01" {
  name   = var.pub_sub_mz[0]
  vpc_no = ncloud_vpc.vpc_mz.id
  #subnet = cidrsubnet(ncloud_vpc.vpc_mz.ipv4_cidr_block, 4, 0)
  subnet = "10.0.1.0/28"
  // 10.0.1.0/28
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.vpc_mz.default_network_acl_no
  subnet_type    = "PUBLIC"
  // PUBLIC(Public) | PRIVATE(Private)
}

resource "ncloud_subnet" "tf_mz_pub_sub_02" {
  name   = var.pub_sub_mz[1]
  vpc_no = ncloud_vpc.vpc_mz.id
  #subnet = cidrsubnet(ncloud_vpc.vpc_mz.ipv4_cidr_block, 4, 16)
  subnet = "10.0.1.16/28"
  // 10.0.1.16/28
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc_mz.default_network_acl_no
  subnet_type    = "PUBLIC"
  // PUBLIC(Public) | PRIVATE(Private)
}

resource "ncloud_access_control_group" "tf_mz_web_acg_01" {
  name        = "tf-mz-web-acg-01"
  description = "test"
  vpc_no      = ncloud_vpc.vpc_mz.id
}

resource "ncloud_access_control_group_rule" "tf_mz_web_acg_01" {
  access_control_group_no = ncloud_access_control_group.tf_mz_web_acg_01.id

  inbound {
    protocol    = "TCP"
    ip_block    = "${var.client_ip}"
    port_range  = "1-65535"
    description = "accept all port"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0" 
    port_range  = "1-65535"
    description = "accept 1-65535 port"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0" 
    port_range  = "1-65535"
    description = "accept 1-65535 port"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "all"
  }
}

resource "ncloud_server" "tf_mz_web_svr_01" {
  subnet_no                 = ncloud_subnet.tf_mz_pub_sub_01.id
  name                      = var.svr_nm
  server_image_number = "16187005"
  server_spec_code = "c2-g2-s50"
  login_key_name            = ncloud_login_key.tf-mz-key.key_name
  access_control_group_configuration_no_list = ["ncloud_access_control_group.tf_mz_web_acg_01.id"]
}

resource "ncloud_public_ip" "public_ip_01" {
  server_instance_no = ncloud_server.tf_mz_web_svr_01.id
  description        = "for test"
}