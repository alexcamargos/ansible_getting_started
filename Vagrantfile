# -*- mode: ruby -*-
# vi: set ft=ruby :

# Define the box configuration.
vagrant_boxs = {
  'srv1' => {'memory' => '512', 'cpus' => 2, 'ip' => '10'},
  'srv2' => {'memory' => '512', 'cpus' => 2, 'ip' => '20'},
  'srv3' => {'memory' => '512', 'cpus' => 2, 'ip' => '30'}
}

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"
  # The time in seconds that Vagrant will wait for the machine to boot and be accessible.
  config.vm.boot_timeout = 600

  vagrant_boxs.each do |name, conf|
    # Create a private network, which allows host-only access to the machine.
    config.vm.define "#{name}" do |m|
      # Configure a hostname.
      m.vm.hostname = "#{name}.ansible.local"
      # Configure a private network IP.
      m.vm.network 'private_network', ip: "172.71.70.#{conf['ip']}"

      # Configuration for VirtualBox
      m.vm.provider 'virtualbox' do |vb|
        # Configure the amount of memory on the VM.
        vb.memory = conf['memory']
        # Configure the number of CPU's.
        vb.cpus = conf['cpus']
      end

      # Update the box.
      m.vm.provision "shell", inline: <<-'UPDATE'
        sudo apt update
        sudo apt upgrade -y

        # Install Vim and Nano.
        sudo apt install -y vim nano
      UPDATE

      # Copy the SSH keys to the servers.
      m.vm.provision "shell", inline: <<-'ID_RSA'
        # Create the .ssh directory.
        mkdir -p /root/.ssh
        mkdir -p /home/vagrant/.ssh

        # Copy the SSH to home directory.
        cp /vagrant/id_rsa/* /root/.ssh
        cp /vagrant/id_rsa/* /home/vagrant/.ssh

        # Change the permissions.
        chmod 400 /root/.ssh/ansible_lab*
        chmod 400 /home/vagrant/.ssh/ansible_lab*

        # Change the owner.
        sudo chown vagrant .ssh/ansible_lab*
        # Change the group.
        sudo chgrp vagrant .ssh/ansible_lab*

        # Create the authorized_keys file.
        cat /root/.ssh/ansible_lab.pub >> /root/.ssh/authorized_keys
        cat /home/vagrant/.ssh/ansible_lab.pub >> /home/vagrant/.ssh/authorized_keys
      ID_RSA
    end
  end
end
