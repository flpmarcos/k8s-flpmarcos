# -*- mode: ruby -*-
# vi: set ft=ruby :


CP_NODE_COUNT = 1

# NODES_NAMES = ["node-1", "node-2", "node-3"]

NODES_NAMES = ["node-1"]

NODES_COUNT = NODES_NAMES.size

NODES_VM_NAMES = (1..NODES_COUNT).map{|i| "node-#{i}"}

Vagrant.require_version ">= 2.2.0"

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/ubuntu2004"
  config.vm.box_version = "1.0.3"
  
  # Shared virtualbox settings
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end


  # Control panel node
  config.vm.define "master" do |cp_node|
    cp_node.vm.hostname = "master"
    cp_node.vm.network  :private_network,
      ip: "172.16.8.10",
      netmask: "255.255.255.0",
      auto_config: true
    

    # Instala dependencias em todas as VMs
    cp_node.vm.provision "shell", path:"./install-kubernetes-dependencies.sh"
    cp_node.vm.provision "shell", path:"./configure-master-node.sh"
    cp_node.vm.provision "shell", path:"./k8s-configure-lab.sh"

    cp_node.vm.provider "virtualbox" do |v|
      v.name = "master"
    end
  end


  # Nodes
  (1..NODES_COUNT).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.network  :private_network,
        ip: "172.16.8.#{10 + i}",
        netmask: "255.255.255.0",
        auto_config: true
      
      
        # Instala dependencias em todas as VMs
      node.vm.provision "shell", path:"./install-kubernetes-dependencies.sh"
      node.vm.provision "shell", path:"./configure-worker-nodes.sh"

      node.vm.provider "virtualbox" do |v|
        v.name = NODES_NAMES[i - 1]
      end
    end
  end

end
