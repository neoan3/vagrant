# -*- mode: ruby -*-
# vi: set ft=ruby :

# neoan3 vagrant box
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder ".", "/var/www/html"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "neoan3-app"
  end

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/neoan3/vagrant/main/setup.sh"
end
