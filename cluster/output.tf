output "kubernetes-controller" {
  value = "$ ssh -i ${var.private_key_path} ${var.ssh_user}@${openstack_compute_floatingip_v2.controller.0.address}"
}

output "controller_public_ip" {
  value = "${openstack_compute_floatingip_v2.controller.0.address}"
}
