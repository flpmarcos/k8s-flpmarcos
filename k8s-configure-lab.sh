#!/bin/bash -e

vagrant_dir="/vagrant/namespace"

run_namespace ()
{
## RUN NGINX ENV
kubectl apply -f $vagrant_dir/nginx-ingress/ingress-nginx-namespace.yaml
kubectl apply -f $vagrant_dir/nginx-ingress/k8s-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

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

}

kubectl_alias()
{
sudo apt-get install -y bash-completion
source /etc/bash_completion
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
}

run_namespace
kubectl_alias

