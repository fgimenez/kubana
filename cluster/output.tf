output "kubernetes-controller" {
  value = "$ ssh -A ${var.ssh_user}@${openstack_compute_floatingip_v2.controller.0.address}"
}

output "controller_public_ip" {
  value = "${openstack_compute_floatingip_v2.controller.0.address}"
}
