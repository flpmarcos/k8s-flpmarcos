#!/bin/bash -e

vagrant_dir="/vagrant/namespace"

run_namespace ()
{

## RUN VOIP ENV
kubectl apply -f $vagrant_dir/voip/k8s-asterisk
kubectl apply -f $vagrant_dir/voip/voip-namespace.yaml

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

run_namespace


