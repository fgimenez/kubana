variable "kubernetes_image" {
  default = "k8s_base"
}

variable "project" {
  default = "kubestack"
}

variable "ssh_user" {
  default = "ubuntu"
}

variable "compute_count" {
  default = 2
}

variable "cluster_name" {
  default = "kubestack-testing"
}

variable "floatingip_pool" {
  default = "external"
}

variable "kubernetes_flavor" {
  default = "m1.medium"
}

variable "kubernetes_token" {
  default = "5aa3f9.c7acfa51e41f1f7d"
}

variable "username" {
  description = "Your openstack username"
}

variable "password" {
  description = "Your openstack password"
}

variable "tenant" {
  description = "Your openstack tenant/project"
}

variable "auth_url" {
  description = "Your openstack auth URL"
}

variable "public_key_path" {
  description = "The path of the ssh pub key"
  default = "/app/dummy_keypair/cloud.key.pub"
}

variable "private_key_path" {
  description = "The path of the ssh priv key"
  default = "/app/dummy_keypair/cloud.key"
}

variable "whitelist_network" {
  description = "network to allow connectivity from"
  default = "0.0.0.0/0"
}
