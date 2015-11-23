Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.ssh.forward_agent = true
    config.vm.network :private_network, ip: "10.42.42.43"
    config.vm.provider "virtualbox" do |v|
        v.name = "vagrant-magento2-apache"
        v.customize ["modifyvm", :id, "--memory", "4096"]
        v.customize ["modifyvm", :id, "--cpuexecutioncap","60"]
        v.customize ["modifyvm", :id, "--cpus",2]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end

     # Remove the default Vagrant directory sync
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.synced_folder "./config", "/vagrant/config"
    config.vm.provision "shell", path: "shell/setup.sh"

    # Project Setup
    config.vm.provision "shell", path: "shell/prj/magento2-phpmyadmin.local.sh"
    config.vm.provision "shell", path: "shell/prj/magento2.local.sh"

    if Vagrant::Util::Platform.windows?
        config.vm.synced_folder "./servers", "/home/vagrant/servers", create: true, type: "rsync", rsync__exclude: ".git/"
    else
        config.vm.synced_folder "./servers", "/vagrant-nfs", type: "nfs", create: true
        config.bindfs.bind_folder "/vagrant-nfs", "/home/vagrant/servers", :owner => "vagrant", :group => "vagrant", :'create-as-user' => true, :perms => "u=rwx:g=rwx:o=rD", :'create-with-perms' => "u=rwx:g=rwx:o=rD", :'chown-ignore' => true, :'chgrp-ignore' => true, :'chmod-ignore' => true
    end

    config.vm.provision "shell", inline: "service mailcatcher restart", run: "always"
    config.vm.provision "shell", inline: "service apache2 restart", run: "always"
    config.vm.provision "shell", inline: "service mysql restart", run: "always"
end