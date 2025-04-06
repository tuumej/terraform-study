variable "loginkey_name" {
  default = "tf-mz-loginkey"
}

variable "vpc_mz" { # 10.0.1.0/24
  default = ["tf-mz-vpc-1", "tf-mz-vpc-2", "tf-mz-vpc-3"]
}

variable "pub_sub_mz" {
  default = ["tf-mz-pub-sub-web-a-01", "tf-mz-pub-sub-web-c-01"]
}

variable "pri_sub_mz" {
  default = ["tf-mz-pri-sub-was-a-01", "tf-mz-pri-sub-was-c-01", "tf-mz-pri-sub-db-a-01", "tf-mz-pri-sub-db-c-01"]
}

variable "ipv4_cidr" { # 10.0.1.0/28 => 16개로 구분 / 0, 16, 32, 64, 80, 96, ... 224, 240 :::: /26 => 0, 32, 64, 96, ... 
  default = ["10.0.1.0/26", "10.0.1.32/26"]
}

variable "svr_nm" {
  default = "tf-mz-web-svr-a-1"
}

variable "client_ip" {
  default = "210.92.14.0/24"
}

variable "access_key" {
  default = "ncp_iam_BPASKR1Z4ioI8a7YwakF"
}

variable "secret_key" {
  default = "ncp_iam_BPKSKRqeUbYOOCTvAupEYeM5Y6GtILQBob"
}