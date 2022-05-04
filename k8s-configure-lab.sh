#!/bin/bash -e

vagrant_dir="/vagrant/namespace"

run_namespace ()
{

## RUN MONITORING ENV
kubectl apply -f $vagrant_dir/monitoring/monitoring-namespace.yaml
kubectl apply -f $vagrant_dir/monitoring/k8s-grafana
kubectl apply -f $vagrant_dir/monitoring/k8s-node-exporter
kubectl apply -f $vagrant_dir/monitoring/k8s-prometheus
kubectl apply -f $vagrant_dir/monitoring/kube-state-metrics


## RUN DEVOPS-TOOLS ENV
kubectl apply -f $vagrant_dir/devops-tools/devops-tools-namespace.yaml
kubectl apply -f $vagrant_dir/devops-tools/k8s-jenkins
kubectl apply -f $vagrant_dir/devops-tools/k8s-registry

## RUN HML ENV
kubectl apply -f $vagrant_dir/hml/hml-namespace.yaml
kubectl apply -f $vagrant_dir/hml/test-app

## RUN NGINX ENV
kubectl apply -f $vagrant_dir/nginx-ingress/ingress-nginx-namespace.yaml
kubectl apply -f $vagrant_dir/nginx-ingress/k8s-nginx


}

kubectl_alias()
{
sudo apt update
sudo apt-get install -y bash-completion
echo "Step 1"
source /etc/bash_completion
echo "Step 2"
source <(kubectl completion bash) 
echo "Step 3"
echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "Step 4"
source <(kubectl completion bash)
echo "Step 5"
alias k=kubectl
echo "Step 6"
complete -F __start_kubectl k
}

run_namespace
kubectl_alias

