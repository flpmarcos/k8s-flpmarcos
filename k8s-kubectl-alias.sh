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

kubectl_alias