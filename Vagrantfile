# -*- mode: ruby -*-
# vi: set ft=ruby :

$num = 2 # Number of slaves

Vagrant.configure("2") do |config|

  config.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
(0..$num).each do |i|
	config.vm.define "jenkins#{i}" do |jenkins|
		jenkins.vm.network :private_network, ip: "192.168.57.10#{i}"
		config.vm.synced_folder "jenkins/", "/opt/jenkins"
		if i == 0 
			jenkins.vm.hostname = "master" 		
			jenkins.vm.provision "shell" , path: "./jenkins-master.sh"
		else
			jenkins.vm.hostname = "jenkins-node#{i}" 
			config.vm.provision "shell", inline: "sudo yum install java-1.8.0-openjdk.x86_64 -y && echo 'OpenJDK installed'"
		end
  	end 
end

config.vm.provider "virtualbox" do |v|
  v.memory = 2048
end

end
