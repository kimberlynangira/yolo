# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"  # Using official Ubuntu box instead of geerlingguy's
  config.vm.network "forwarded_port", guest: 3000, host: 3001
  config.vm.network "forwarded_port", guest: 5000, host: 5001
  config.vm.network "forwarded_port", guest: 27017, host: 27018
  
  # Set up a private network for better communication
  config.vm.network "private_network", ip: "192.168.56.10"
  
  # VM resource configuration with nested virtualization in mind
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"  # Reduced memory requirement
    vb.cpus = 1  # Reduced CPU requirement
    vb.name = "yolo-ecommerce"
    
    # Disable 3D acceleration to prevent graphics issues
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]
    
    # Disable USB to prevent potential issues
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  # Provision with shell script instead of ansible_local
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y python3-pip python3-dev libffi-dev libssl-dev
    apt-get install -y ansible
    
    # Clone the repository if not already present
    if [ ! -d "/opt/yolo-ecommerce" ]; then
      apt-get install -y git
      git clone https://github.com/Vinge1718/yolo.git /opt/yolo-ecommerce
    fi
    
    # Run the playbook
    cd /vagrant
    ansible-playbook -i "localhost," -c local playbook.yml
  SHELL
end
