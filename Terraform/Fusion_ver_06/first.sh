#!/bin/bash

### git clone 이후 테라폼 최초 배포시 사용을 권장합니다 ###

### <KTS 시간 동기화>
echo "time check"
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date
### </KTS 시간 동기화>

### <키페어 체크>
echo "Check mykey"
cd ./Origin/Origin_infra;
if [ -f "mykey" ] && [ -f "mykey.pub" ]; then
  ls | grep my
  echo "already key pairs. next process"
else
  echo "create mykey"
  ssh-keygen -m PEM -f mykey -N ""
  ls | grep my
fi
### </키페어 체크>

### <.terraform/ 체크>
cd ../../DEV/DEV_infra;
if [ -d ".terraform" ]; then
	read -p ".terraform is exists. Do you want to continue? (Y/N): " choice
		case "$choice" in
			[Yy])
				echo "terragrunt init -migrate-state";
				cd ../../;
				terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-working-dir "./" init -migrate-state;
				;;
			[Nn])
				echo "Exiting..."
				exit 1
				;;
			*)
				echo "Invalid choice. Exiting..."
				exit 1
				;;
		esac
	else
		echo "start Terragrunt";
		cd ../../;
		echo "init";
		sleep "5";
		terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-working-dir "./" init;
fi
### </.terraform/ 체크>

### 배포 진행
# apply
echo "fmt"
sleep "5"
terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-working-dir "./" fmt
terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-working-dir "./" apply



### 삭제[각주 해제 금지] terragrunt run-all --terragrunt-ignore-external-dependencies --terragrunt-working-dir "./" destroy