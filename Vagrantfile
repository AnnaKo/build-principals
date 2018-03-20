Vagrant.configure("2") do |config|  
    config.vm.define :master do |loadbalancer|
        loadbalancer.vm.provider :virtualbox do |v|
            v.name = "master"
            v.customize [
                "modifyvm", :id,
                "--name", "master",
                "--memory", 1024,
                "--natdnshostresolver1", "on",
                "--cpus", 2,
            ]
        end

        loadbalancer.vm.box = "bento/centos-7.3"
        loadbalancer.vm.network :private_network, ip: "192.168.10.10"
        loadbalancer.ssh.forward_agent = true
        loadbalancer.vm.synced_folder "jenkins/", "/opt/jenkinks"
	loadbalancer.vm.provision "shell", path: "install.sh"
end

(1..2).each do |i|
    config.vm.define "application_#{i}" do |application|
        application.vm.provider :virtualbox do |v|
            v.name = "application_#{i}"
            v.customize [
                "modifyvm", :id,
                "--name", "application_#{i}",
                "--memory", 512,
                "--natdnshostresolver1", "on",
                "--cpus", 1,
            ]
        end

        application.vm.box = "bento/centos-7.3"
        application.vm.network :private_network, ip: "192.168.30.2#{i}"
        application.ssh.forward_agent = true
        application.vm.synced_folder "jenkins#{i}/", "/opt/jenkinks"
	application.vm.provision "shell", path: "install.sh"
	end
    end
end

