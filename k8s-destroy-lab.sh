#!/bin/bash -e

vagrant_dir="/vagrant/namespace"

destroy_all_namespace ()
{

## RUN MONITORING ENV
kubectl delete -f $vagrant_dir/monitoring/k8s-grafana
kubectl delete -f $vagrant_dir/monitoring/k8s-node-exporter
kubectl delete -f $vagrant_dir/monitoring/k8s-prometheus
kubectl delete -f $vagrant_dir/monitoring/kube-state-metrics
kubectl delete -f $vagrant_dir/monitoring/monitoring-namespace.yaml


## RUN DEVOPS-TOOLS ENV
kubectl delete -f $vagrant_dir/devops-tools/k8s-jenkins
kubectl delete -f $vagrant_dir/devops-tools/k8s-registry
kubectl delete -f $vagrant_dir/devops-tools/devops-tools-namespace.yaml

## RUN HML ENV
kubectl delete -f $vagrant_dir/hml/test-app
kubectl delete -f $vagrant_dir/hml/hml-namespace.yaml

## RUN NGINX ENV
kubectl delete -f $vagrant_dir/nginx-ingress/k8s-nginx
kubectl delete -f $vagrant_dir/nginx-ingress/ingress-nginx-namespace.yaml


}

destroy_all_namespace