#!/bin/bash

### 관련 파일은 git를 통해 설치
### 변수 선언
hostname=$(hostname)
myPriIP=$(ip addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1 | awk -F'.' '{print $3"."$4}')

### [공통 작업] 호스트 파일에 노드 ip, name 추가
sudo sh -c 'cat >> /etc/hosts <<EOF
172.16.11.10 k8s-MASTER
172.16.11.101 k8s-WORKER$myPriIP
172.16.21.101 k8s-WORKER$myPriIP
EOF'

### [공통 작업] k8s setup dir 생성 후 관련 파일 생성
mkdir ~/k8sSetup; cd ~/k8sSetup

### [공통 작업] *.sh 실행
#echo "create iptableset.sh"
#sh iptableset.sh

###### 노드 역할에 따른 *.sh 설치 진행
if [ "$hostname" = "K8S-MASTER" ]; then
    sudo hostnamectl hostname K8S-MASTER
    #sh kubeadminit.sh
	#sh calicosetup.sh
else
    #sudo hostnamectl hostname K8S-WORKER$myPriIP
fi



