# k8s-flpmarcos
Estudos de k8s utilizando kubernetes local com kind no WSL (Debian)


## K8S -  TRAILHEAD

| Feature  | Status |
| ------------- | ------------- |
| KIND - Instalacao  | ✅  |
| KIND - Cluster  | ✅  |
| Kubectl - Instalando | ✅  |
| Kubectl - Alias | ✅  |
| Kubectl - Comandos  | ✅  |
| Deployment - Teste de Stress no POD  | ✅  |
| Ingress - Definir sub-dominio para as aplicações   | ✅  |
| Monitoramento - Criar ambiente (Grafana / Prometheus)  | ✅  |
| Monitoramento - Config map grafana.ini   | ✅  |
| CI/CD - Criar ambiente (Harbor / Repositório / Jenkins ✅)  |  ⌛  |
| Filas - Criar Ambiente  (Rabbitmq / Kafka)  |  ⌛  |
| VOIP - Criar Ambiente  (Kamailio / Asterisk)  |  ⌛  |
| RANCHER - Orquestrar outros clusters  |  ⌛  |
| TERRAFORM - Infra as Code |  ⌛  |
| ISTIO - Service Mesh |  ⌛  |
| IAC - Provisionar ambiente K8S usando Vagrant   |  ⌛  |

## KIND

kind é utilizado para simular um ambiente kubernetes local usando container mais parecido com o ambiente de PRD possivel

```
### Download the latest version of KinD
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/{latest}/kind-linux-amd64
### Make the binary executable
chmod +x ./kind
### Move the binary to your executable path
sudo mv ./kind /usr/local/bin/
```


## CLUSTER

- Criar cluster kubernetes
```
kind create cluster --name meucluster --config cluster.yaml
```

- Listar clusters criados
```
kind get clusters
```

- Define um cluster especifico
```
k cluster-info --context kind-cluster-rancher
```
- Deletar um cluster 
```
kind delete cluster --name meucluster
```

## VAGRANT

# Usage

To create VMs and bootstrap your kubernetes cluster

`vagrant up`

After creation of VMs is complete ssh into master and check kubernetes cluster status

`vagrant ssh master`

`kubectl get nodes`

After deployment you can check your page with 

`curl http://<worker-ip>:30080`


## KUBECTL

#### Instalação
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

windowsUser=$1

mkdir -p ~/.kube
ln -sf "/mnt/c/users/$windowsUser/.kube/config" ~/.kube/config

kubectl version
```


#### Alias - Para facilitar o trabalho

```
apt-get install -y bash-completion

source /etc/bash_completion

source <(kubectl completion bash) # configura o autocomplete na sua sessão atual (antes, certifique-se de ter instalado o pacote bash-completion).

echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanentemente ao seu shell.
source <(kubectl completion bash)

alias k=kubectl
complete -F __start_kubectl k
```

- Arquivo de configuracao para acesso do kubectl no cluster kubernetes
```
.kube/config
```

- Listar servicos
```
kubectl get services
```

- Listar nós do cluster
```
kubectl get nodes
```
#### POD
- Criar um pod baseado no arquivo 
```
kubectl create -f meupod.yaml
```
- Listar pods
```
kubectl get pods
```

- Listar informacoes do pod
```
kubectl describe pod {idpod}
```

- Comando para fazer bind de porta do pod
```
kubectl port-forward pod/meupod 8080:80
```
#### REPLICA SET
- Comando para dar apply em um replicaset
```
kubectl apply -f meureplicaset.yaml
```
- Listar todos os replica sets
```
kubectl get replicaset
```

#### DEPLOYMENT
- Criar um deployment
```
kubectl apply -f meudeployment.yaml
```
- Listar deployment
```
kubectl get deployment
```

- Listar versoes do deployment
```
kubectl rollout history deployment meudeployment
```

- Voltar versao do deployment
```
kubectl rollout undo deployment meudeployment
```



### Teste de stress
EX: Limite no deployment

resources:
  limits:
    memory: "256Mi"
    cpu: "200m"
  requests:
    memory: "128Mi"
    cpu: "50m"

Acessr o pod

```
kubectl exec -ti nginx-f89759699-77v8b -- /bin/bash
```
instalar a lib do teste
```
apt-get update && apt-get install -y stress
```
executar o teste (Aqui estamos stressando o contêiner, utilizando 128M de RAM e um core de CPU. Brinque de acordo com os limites que você estabeleceu.)
stress --vm 1 --vm-bytes 128M --cpu 1

Atenção!!! 1 core de CPU corresponde a 1000m (1000 milicore). Ao especificar 200m, estamos querendo reservar 20% de 1 core da CPU. Se fosse informado o valor 0.2 teria o mesmo efeito, ou seja, seria reservado 20% de 1 core da CPU.

echo 'Z2lyb3BvcHMgc3RyaWd1cyBnaXJ1cw==' | base64 --decode




## NAMESPACE
### Monitoring - Prometheus e Grafana

#### Criando namespace

```
kubectl create -f monitoring-namespace.yaml
```

#### PROMETHEUS
```
kubectl create -f k8s-prometheus/
```
host: prometheus.localhost

#### GRAFANA
```
kubectl create -f k8s-grafana/
```
host: grafana.localhost
Importe o dashboard do GrafanaLabs (https://grafana.com/grafana/dashboards/12740)

#### NODE EXPORTER
```
kubectl apply -f k8s-node-exporter/
```

#### STATE METRICS
```
kubectl apply -f kube-state-metrics/
```

### DEVOPS-TOOLS 
#### Criando namespace

```
kubectl create -f devops-tools-namespace.yaml
```

#### JENKINS
```
kubectl create -f k8s-jenkins/
```
host: jenkins.localhost

### MESSAGE-QUEUE 
#### Criando namespace

```
kubectl create -f message-queue-namespace.yaml
```

#### RABBITMQ
```
kubectl create -f k8s-rabbitmq/
```


### VOIP - KAMAILIO / ASTERISK (BETA)

#### Criando namespace

```
kubectl create -f voip-namespace.yaml
```

#### KAMAILIO / ASTERISK
```
kubectl create -f k8s-kamailio-asterisk/
```


# REFERÊNCIAS
```
https://livro.descomplicandokubernetes.com.br/pt/day_one/descomplicando_kubernetes.html

https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/

https://phoenixnap.com/kb/prometheus-kubernetes-monitoring

https://devopscube.com/kubernetes-ingress-tutorial/

https://github.com/flpmarcos/vagrant-kubernetes-cluster


```