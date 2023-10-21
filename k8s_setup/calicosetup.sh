#!/bin/bash

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml

timeout=300  # 타임아웃 시간(초)
start_time=$(date +%s)  # 시작 시간

while true; do
  output=$(kubectl get pods -n calico-system)
  ready_pods=$(echo "$output" | awk 'NR>1 {print $2}' | grep -vE '^([0-9]+)/\1$')

  if [ -z "$ready_pods" ]; then
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    if [ $elapsed_time -ge $timeout ]; then
      echo "calico-system unready"
      break
    fi

    echo "Waiting for all pods to be ready..."
    sleep 5
  else
    echo "All pods are ready!"
    echo "Complete"
    break
  fi
done