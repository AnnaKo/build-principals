Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.synced_folder "/home/student/vagrant/jenkins1/master", "/opt/jenkins/master"
    master.vm.box = "./centos-7.4-x86_64-minimal.box"
    master.vm.hostname = 'master'
    master.vm.network :private_network, ip: "192.168.56.10"
    master.vm.provision :shell, :path => "/home/student/vagrant/jenkins1/script_master.sh"
    master.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "master"]
    end
  end


  config.vm.define "slave1" do |slave1|
    slave1.vm.box = "./centos-7.4-x86_64-minimal.box"
    slave1.vm.hostname = 'slave1'
    slave1.vm.network :private_network, ip: "192.168.56.20"
    slave1.vm.provision :shell, :path => "/home/student/vagrant/jenkins1/script_slave.sh"
    slave1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "slave1"]
    end
  end


  config.vm.define "slave2" do |slave2|
    slave2.vm.box = "./centos-7.4-x86_64-minimal.box"
    slave2.vm.hostname = 'slave2'
    slave2.vm.network :private_network, ip: "192.168.56.30"
    slave2.vm.provision :shell, :path => "/home/student/vagrant/jenkins1/script_slave.sh"
    slave2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "slave2"]
    end
  end
end

