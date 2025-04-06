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

resource "ncloud_subnet" "prd_subnet" {
  name           = var.prd_pub_sub_name[0]
  network_acl_no = ncloud_network_acl.network_acl.id
  subnet         = var.prd_sub_ip[1]
  subnet_type    = "PUBLIC"
  usage_type     = "GEN"
  vpc_no         = ncloud_vpc.prd_vpc.id
  zone           = "KR-1"
}

resource "ncloud_access_control_group" "access_control_group" {
  description = "default port open acg config"
  name        = var.acg_name[0]
  vpc_no      = ncloud_vpc.prd_vpc.vpc_no
}

# acg icmp > port_range ??
resource "ncloud_access_control_group_rule" "access_control_group_rule" {
  access_control_group_no = ncloud_access_control_group.access_control_group.id
  inbound = [{
    protocol                       = "TCP"
    ip_block                       = "193.186.4.0/24"
    source_access_control_group_no = ""
    port_range                     = "22"
    description                    = "sanchez cafe icmp test"
  }]
  outbound = [{
    protocol                       = "TCP"
    ip_block                       = "0.0.0.0/0"
    source_access_control_group_no = ""
    port_range                     = "1-65535"
    description                    = "tcp outbound ports"
    },
    {
      protocol                       = "UDP"
      ip_block                       = "0.0.0.0/0"
      source_access_control_group_no = ""
      port_range                     = "1-65535"
      description                    = "udp outbound ports"
  }]
}

# nacl
resource "ncloud_network_acl" "network_acl" {
  description = "default nacl"
  name        = "test-nacl"
  vpc_no      = ncloud_vpc.prd_vpc.id
}

resource "ncloud_network_acl_rule" "nacl_rule" {
  network_acl_no = ncloud_network_acl.network_acl.id
}
