resource "openstack_compute_floatingip_v2" "controller" {
  pool = "${var.floatingip_pool}"
}

resource "openstack_compute_keypair_v2" "kubernetes" {
  name = "${var.project}"
  public_key = "${file(var.public_key_path)}"
}

resource "openstack_compute_instance_v2" "controller" {
  name = "${var.cluster_name}-controller${count.index}"
  count = "1"
  image_name = "${var.kubernetes_image}"
  flavor_name = "${var.kubernetes_flavor}"
  key_pair = "${openstack_compute_keypair_v2.kubernetes.name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.kubernetes_base.name}",
    "${openstack_compute_secgroup_v2.kubernetes_controller.name}"
  ]
  floating_ip = "${element(openstack_compute_floatingip_v2.controller.*.address, count.index)}"

  provisioner "remote-exec" {
    inline = [
      "echo '----> Starting Kubernetes Controller'",
      "sudo kubeadm init --token ${var.kubernetes_token} --skip-preflight-checks",
      "echo '----> Installing Weave'",
      "kubectl apply -f https://git.io/weave-kube"
    ]
    connection {
      user = "${var.ssh_user}"
      private_key = "${file(var.private_key_path)}"
    }
  }
}

resource "openstack_compute_instance_v2" "compute" {
  name = "${var.cluster_name}-compute${count.index}"
  count = "${var.compute_count}"
  image_name = "${var.kubernetes_image}"
  flavor_name = "${var.kubernetes_flavor}"
  key_pair = "${openstack_compute_keypair_v2.kubernetes.name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.kubernetes_base.name}",
    "${openstack_compute_secgroup_v2.kubernetes_compute.name}"
  ]
  provisioner "remote-exec" {
    inline = [
      "echo '----> Joining K8s Controller'",
      "sudo kubeadm join --token ${var.kubernetes_token} ${openstack_compute_instance_v2.controller.0.network.0.fixed_ip_v4} --skip-preflight-checks"
    ]
    connection {
      user = "${var.ssh_user}"
      private_key = "${file(var.private_key_path)}"
      bastion_host = "${openstack_compute_floatingip_v2.controller.0.address}"
    }
  }
  depends_on = [
    "openstack_compute_instance_v2.controller"
  ]
}

output "kubernetes-controller" {
  value = "$ ssh -A ${var.ssh_user}@${openstack_compute_floatingip_v2.controller.0.address}"
}
