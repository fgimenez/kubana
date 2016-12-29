#!/bin/sh
echo "==> Detected Ubuntu"
echo "----> Installing Kubernetes apt repo"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF > kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo mv kubernetes.list /etc/apt/sources.list.d
sudo apt-get -yq update > /dev/null
echo "----> Installing Kubernetes requirements"
sudo apt-get install -yq docker.io kubelet kubeadm kubectl kubernetes-cni > /dev/null
