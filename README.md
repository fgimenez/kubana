kubana lets you deploy easily a kubernetes cluster over an openstack installation without neutron enabled (tested on the havana release). It is based on https://github.com/openstack/osops-tools-contrib. [terraform](https://www.terraform.io/) takes care of the infrastructure setup and [kubeadm](http://kubernetes.io/docs/getting-started-guides/kubeadm/) of the installation of the k8s services.

First of all, a base image must be available on the openstack side to be used by the k8s nodes. Given the usual openstack access environment variables are present you can create it using [packer](https://www.packer.io/) from the `images` directory, executing:

    $ packer build -var 'source_image_name=<my_source_image_name>' k8s_base.json

being `my_source_image_name` an image available on your openstack installation and suitable to be used with k8s (tested with ubuntu 16.04).

For the actual deplyment kubana uses a container with a prebuilt terraform version patched to play well with old openstack api responses. You should create a `terraform.tfvars` file with variables customized to your environment, for example:

    floatingip_pool = "my_floating_ip_pool"
    compute_count = 6
    whitelist_network = "aa.bb.cc.dd/ee"

With that in place you can spin up the cluster with:

    $ sudo docker run --rm -v ${PWD}:/app \
    -e OS_USERNAME=${OS_USERNAME} \
    -e OS_PASSWORD=${OS_PASSWORD} \
    -e OS_TENANT_NAME=${OS_TENANT_NAME} \
    -e OS_AUTH_URL=${OS_AUTH_URL} \
    -e OS_REGION_NAME=${OS_REGION_NAME} \
    fgimenez/terraform-kubana apply

The output from the execution let's you know how to access the controller node, something like:

    kubernetes-controller = $ ssh -i ./dummy_keypair/cloud.key ubuntu@xx.xx.xx.xx

From there you can copy the `/etc/kubernetes/admin.conf` file to your host on `~/.kube/config` to access the cluster with the `kubectl` cli tool.

You can teardown the cluster with:

    $ sudo docker run --rm -v ${PWD}:/app \
    -e OS_USERNAME=${OS_USERNAME} \
    -e OS_PASSWORD=${OS_PASSWORD} \
    -e OS_TENANT_NAME=${OS_TENANT_NAME} \
    -e OS_AUTH_URL=${OS_AUTH_URL} \
    -e OS_REGION_NAME=${OS_REGION_NAME} \
    fgimenez/terraform-kubana destroy
