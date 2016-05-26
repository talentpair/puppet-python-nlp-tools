# Example Vagrantfile

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Enable the Puppet provisioner, which will look in manifests
  config.vm.provision :puppet do |puppet|
    puppet.options = '--parser future'
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "puppet.pp"
    puppet.module_path = "modules"
  end

  config.vm.provision :puppet do |puppet|
    puppet.options = '--parser future'
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "tutorial.pp"
    puppet.module_path = "modules"
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty64-python-nlp-tools"

  # These are used to provision the original version of the box directly from a vanilla ubuntu vagrant box
  # $ vagrant box add trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
  # config.vm.box = "trusty64"
  # config.ssh.insert_key = false

  # Forward guest port 8000 to host port 8080 and name mapping
  config.vm.network :forwarded_port, guest: 8000, host: 8080
  # config.vm.network "private_network", type: "dhcp"
  # config.vm.network :forwarded_port, guest: 8000, host: 8080, host_ip:'127.0.0.1'

  # allow copy/paste
  config.ssh.forward_x11 = true

  # Use VBoxManage to customize the VM. For example to change memory:
  # config.vm.provider :virtualbox do |vb|
  #   vb.customize ["modifyvm", :id, "--memory", 2048]
  #   vb.customize ["modifyvm", :id, "--cpus", 2]
  # end

  # Configure synced folder
  # config.vm.synced_folder "~/data", "/data", :owner => "vagrant"
end
