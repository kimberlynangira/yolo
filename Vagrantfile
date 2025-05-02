# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/ubuntu2004"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  
  # Set up a private network for better communication
  config.vm.network "private_network", ip: "192.168.33.10"
  
  # VM resource configuration
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "yolo-ecommerce"
  end

  # Provision with Ansible
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.install_mode = "pip"
    ansible.become = true
    ansible.galaxy_role_file = "requirements.yml" if File.exist?("requirements.yml")
  end
end
