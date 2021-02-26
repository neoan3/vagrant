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

  config.vm.provision "shell", path: "https://gist.githubusercontent.com/sroehrl/cc96779d7de3a8d3c8b1921e51e2b80d/raw/d83ed129706a2f497d8d9d5c31ea1bae7feee9fc/setup.sh"
end
