# -*- mode: ruby -*-
# vi: set ft=ruby :  

Vagrant.configure("2") do |config|
  config.vm.box = "mokote/debian-7"
  
  config.vm.network "private_network", ip: "192.168.56.107"

  config.vm.synced_folder "~/Development/web/demostand", "/var/www/demostand", id: "vagrant-root", :nfs => true

  config.vm.provider "virtualbox" do |v|
    v.name = "demostand"
    v.memory = 1024

    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.synced_folder "salt/roots/", "/srv/"

  config.vm.provision :salt do |salt|
    salt.minion_config = 'salt/minion'
    salt.run_highstate = true

    salt.pillar({
      "database" => {
        "withUser" => true,
        "name" => "demostand",
        "password" => "fm2QTqimWUrk"
      }
    })

    salt.pillar({"projectName" => "demostand"})
  end
end

