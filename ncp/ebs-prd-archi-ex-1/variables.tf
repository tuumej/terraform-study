# ncp_key
variable "access_key" {
  type    = string
  default = "ncp_iam_BPASKR1Z4ioI8a7YwakF"
}

variable "secret_key" {
  type    = string
  default = "ncp_iam_BPKSKRqeUbYOOCTvAupEYeM5Y6GtILQBob"
}

# loginkey
variable "loginkey_name" {
  type    = string
  default = "prd-loginkey"
}

# vpc_info / 소속-리소스명-용도
variable "prd_vpc_name" {
  type    = string
  default = "prd-vpc"
}

# ipv4_cidr_info
variable "prd_vpc_ip" {
  type    = string
  default = "172.26.0.0/18"
}

variable "prd_sub_ip" {
  # 10.0.1.0/28 => 16개로 구분 / 0, 16, 32, 64, 80, 96, ... 224, 240 :::: /26 => 0, 32, 64, 96, ... 
  type    = list(string)
  default = ["172.26.0.0/24", "172.26.16.0/24", "172.26.32.0/24", "172.26.64.0/24"]
}

# subnet_info 소속-리전-용도-종류-리소스명-번호
variable "prd_pub_sub_name" {
  type    = list(string)
  default = ["prd-kr1-web-pub-sub-1", "prd-kr2-web-pub-sub-1"]
}

variable "prd_pri_sub_name" {
  type    = list(string)
  default = ["prd-kr1-was-pri-sub-1", "prd-kr2-was-pri-sub-1"]
}

# acg_info
variable "acg_name" {
  type    = list(string)
  default = "asdasd"
}

