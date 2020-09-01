FROM alpine:latest

MAINTAINER Abstra LLC <admin@abstraconsulting.com>

ENV KUBE_VERSION=v1.16.10
ENV HELM_VERSION=v3.2.4
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk update \
 && apk upgrade \
 && apk add ca-certificates \
 && apk add -t deps curl  \
 && apk add gettext tar gzip \
 && apk add git \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://get.helm.sh/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

CMD ["helm"]
