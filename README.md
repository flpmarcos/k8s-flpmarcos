# k8s-flpmarcos - Lab
K8S lab using vagrant (IAC)


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
| CI/CD - Criar ambiente (Registry ✅ / Jenkins ✅)  |  ✅  |
| Filas - Criar Ambiente  (Rabbitmq / Kafka)  |  ⌛  |
| VOIP - Criar Ambiente  (Kamailio / Asterisk)  |  ⌛  |
| RANCHER - Orquestrar outros clusters  |  ⌛  |
| TERRAFORM - Infra as Code |  ⌛  |
| ISTIO - Service Mesh |  ⌛  |
| IAC - Provisionar ambiente K8S usando Vagrant   |  ✅  |


### Host packages requirements
The host must have :
* __Git__ to clone this repository (you can download and unzip too)
* __Vagrant__ to handle virtual machines
* __VirtualBox__ as Hypervisor


## Usage
## Clone the repo
```sh
# Clone the repo and change directory
git clone git@github.com:thkevin/kubernetes_vms_lab.git

# Get into the project directory
cd kubernetes_vms_lab
```

## VAGRANT

To create VMs and bootstrap your kubernetes cluster

`vagrant up`

After creation of VMs is complete ssh into master and check kubernetes cluster status

`vagrant ssh master`

`kubectl get nodes`

After deployment you can check your page with 

`curl http://<worker-ip>:30080`

Detroy the cluster

`vagrant destroy [-f]`



## WINDOWS virtual host 

c:\WINDOWS\system32\drivers\etc\

172.16.8.12 grafana.k8slocal.com
172.16.8.12 prometheus.k8slocal.com
172.16.8.12 jenkins.k8slocal.com
172.16.8.12 registry.k8slocal.com
172.16.8.12 ui.k8slocal.com
172.16.8.12 demo.k8slocal.com


# k8s-flpmarcos - Code Reference

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



#### JENKINS
```
kubectl create -f k8s-jenkins/
```
host: jenkins.k8slocal.com

Obter Passoword

```
kubectl get pods -n devops-tools
kubectl exec {POD_NAME} cat /var/jenkins_home/secrets/initialAdminPassword
```


# REFERÊNCIAS
```
https://livro.descomplicandokubernetes.com.br/pt/day_one/descomplicando_kubernetes.html

https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/

https://phoenixnap.com/kb/prometheus-kubernetes-monitoring

https://devopscube.com/kubernetes-ingress-tutorial/

https://github.com/flpmarcos/vagrant-kubernetes-cluster

https://cirolini.medium.com/entrega-continua-com-kubernetes-e-jenkins-84bd9834a749

```