#!/bin/bash

### git clone 이후 테라폼 최초 배포시 사용을 권장합니다 ###

### <KTS 시간 동기화>
echo "time check"
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date
### </KTS 시간 동기화>

### <키페어 체크>
echo "Check mykey"
if [ -f "mykey" ] && [ -f "mykey.pub" ]; then
  ls | grep my
  echo "already key pairs. next process"
else
  echo "create mykey"
  ssh-keygen -m PEM -f mykey -N ""
  ls | grep my
fi
### </키페어 체크>

terraform init
export TF_VAR_uptime="MIR-$(date +'%H%M')"
terraform apply -auto-approve;