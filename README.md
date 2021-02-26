# vagrant environment for neoan3

This repository is meant to make a zero-configuration development environment possible. It installs all necessary modules, drivers and packages, leaving you with a fresh neoan3 installation on a configured LAMP environment. 

The virtualization includes a MySQL database, the neoan3 cli tool including.


## Requirements
- [virtualbox](https://www.virtualbox.org/)
- [vagrant](https://www.vagrantup.com/)

## Installation / setting up a project

- create project directory 
- - e.g. `mkdir ~/projects/neoan3`
- from within your empty project
- - e.g. `cd ~/projects/neoan3`
- download this repos Vagrantfile
- - e.g. `curl -sS https://raw.githubusercontent.com/neoan3/vagrant/main/Vagrantfile -o Vagrantfile`
- run `vagrant up`
- enjoy
- - serving @ http://192.168.33.10/
- - `vagrant ssh`

