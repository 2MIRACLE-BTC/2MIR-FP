#!/bin/bash
sudo kubeadm init --token-ttl 0 --pod-network-cidr=192.168.0.0/16 --cri-socket unix:///var/run/containerd/containerd.sock >> kubeadm-init-result.txt


cat kubeadm-init-result.txt | tail -10 > k8s-token.txt

sudo rm kubeadm-init-result.txt


mkdir -p $HOME/.kube
sudo rm -f $HOME/.kube/config
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
