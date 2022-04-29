# k8s-flpmarcos
Estudos de k8s utilizando kubernetes local com kind


# kubernetes:

### TIPOS DE SERVIÇOS
- ClusterIP -> Gera comunicacao interna (Banco de dados -> API)

- NodePort -> Cria uma rede com acesso externo, Acesso geralmente realizado por porta
            Range de porta 30000-32777

- LoadBalancer -> Cria um rede com acesso Wan, Geralmente utilizado para servicos em nuvem


## Alias
apt-get install -y bash-completion

source /etc/bash_completion

source <(kubectl completion bash) # configura o autocomplete na sua sessão atual (antes, certifique-se de ter instalado o pacote bash-completion).

echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanentemente ao seu shell.
source <(kubectl completion bash)

alias k=kubectl
complete -F __start_kubectl k

## Teste de stress
EX: Limite no deployment

resources:
  limits:
    memory: "256Mi"
    cpu: "200m"
  requests:
    memory: "128Mi"
    cpu: "50m"

Acessr o pod
kubectl exec -ti nginx-f89759699-77v8b -- /bin/bash
instalar a lib do teste
apt-get update && apt-get install -y stress

executar o teste (Aqui estamos stressando o contêiner, utilizando 128M de RAM e um core de CPU. Brinque de acordo com os limites que você estabeleceu.)
stress --vm 1 --vm-bytes 128M --cpu 1

Atenção!!! 1 core de CPU corresponde a 1000m (1000 milicore). Ao especificar 200m, estamos querendo reservar 20% de 1 core da CPU. Se fosse informado o valor 0.2 teria o mesmo efeito, ou seja, seria reservado 20% de 1 core da CPU.

echo 'Z2lyb3BvcHMgc3RyaWd1cyBnaXJ1cw==' | base64 --decode


## KUBECTL

- Listar servicos

kubectl get services


- Arquivo de configuracao para acesso do kubectl no cluster kubernetes
.kube/config

- Listar nós do cluster
kubectl get nodes

#### POD
- Criar um pod baseado no arquivo 
kubectl create -f meupod.yaml

- Listar pods
kubectl get pods

- Listar informacoes do pod
kubectl describe pod {idpod}

- Comando para fazer bind de porta do pod
kubectl port-forward pod/meupod 8080:80

#### REPLICA SET
- Comando para dar apply em um replicaset
kubectl apply -f meureplicaset.yaml

- Listar todos os replica sets
kubectl get replicaset

#### DEPLOYMENT
- Criar um deployment
kubectl apply -f meudeployment.yaml

- Listar deployment
kubectl get deployment

- Listar versoes do deployment
kubectl rollout history deployment meudeployment

- Voltar versao do deployment
kubectl rollout undo deployment meudeployment




## KIND

- kind é utilizado para simular um ambiente kubernetes local usando container mais parecido com o ambiente de PRD possivel

### Download the latest version of KinD
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/{latest}/kind-linux-amd64
### Make the binary executable
chmod +x ./kind
### Move the binary to your executable path
sudo mv ./kind /usr/local/bin/

- Criar primeiro cluster kubernetes
kind create cluster --name meucluster --config cluster.yaml

- Listar clusters criados
kind get clusters

- Deletar um cluster 
kind delete cluster --name meucluster


## CLUSTER

Define um cluster especifico

k cluster-info --context kind-cluster-rancher




# NAMESPACE
## Monitoramento - Prometheus e Grafana

Para subir a stack de Monitoramento no kubernetes 
Acesse a raiz do repositorio e Execute:

```
kubectl create namespace monitoring

kubectl create -f k8s-prometheus/clusterRole.yaml
kubectl create -f k8s-prometheus/config-map.yaml
kubectl create -f k8s-prometheus/prometheus-deployment.yaml 
kubectl create -f k8s-prometheus/prometheus-deployment.yaml 

kubectl create -f k8s-prometheus/prometheus-service.yaml --namespace=monitoring

kubectl apply -f k8s-node-exporter/
kubectl apply -f kube-state-metrics/
kubectl create -f k8s-grafana/
```

Depois acesse http://localhost/grafana (Grafana)

Usuario: admin

Senha: admin

Importe o dashboard do GrafanaLabs (https://grafana.com/grafana/dashboards/12740)

ID: 12740

![Image of Dashboard on GrafanaLabs](/monitoring/k8s-grafana/GrafanaDashboardImg.png)

ou copie o conteudo desse arquivo "k8s-grafana/grafana-dashboard-kubernetes.json"
e importe no grafana.


Using Kubectl port forwarding

kubectl port-forward prometheus-monitoring-pod 8080:9090 -n monitoring


## TELECOM

Telefonia em ambiente kubernetes utilizando 

Kamalio + Asterisk