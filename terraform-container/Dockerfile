FROM golang:1.7-alpine

ENV TERRAFORM_SRC_DIR /go/src/github.com/hashicorp/terraform
ENV TERRAFORM_VERSION 0.7.13
ENV TERRAFORM_TMP_DIR /tmp/terraform-$TERRAFORM_VERSION
ENV TERRAFORM_DOWNLOAD_URL https://github.com/hashicorp/terraform/archive/v$TERRAFORM_VERSION.tar.gz

RUN mkdir -p $TERRAFORM_SRC_DIR /tmp/terraform

RUN apk add --update curl && \
      rm -rf /var/cache/apk/*

RUN curl -fsSL "$TERRAFORM_DOWNLOAD_URL" -o terraform.tar.gz \
    && tar -C /tmp -xzf terraform.tar.gz \
    && cp -ar $TERRAFORM_TMP_DIR/. "$TERRAFORM_SRC_DIR" \
    && rm terraform.tar.gz  && rm -r $TERRAFORM_TMP_DIR

WORKDIR $TERRAFORM_SRC_DIR
COPY files/floatingip_results.go $TERRAFORM_SRC_DIR/vendor/github.com/gophercloud/gophercloud/openstack/compute/v2/extensions/floatingips/results.go
COPY files/secgroups_results.go $TERRAFORM_SRC_DIR/vendor/github.com/gophercloud/gophercloud/openstack/compute/v2/extensions/secgroups/results.go
COPY files/resource_openstack_compute_floatingip_v2.go $TERRAFORM_SRC_DIR/builtin/providers/openstack/resource_openstack_compute_floatingip_v2.go
COPY files/resource_openstack_compute_secgroup_v2.go $TERRAFORM_SRC_DIR/builtin/providers/openstack/resource_openstack_compute_secgroup_v2.go
RUN go-wrapper download
RUN go-wrapper install

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
