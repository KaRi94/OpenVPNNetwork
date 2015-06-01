# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Distribution
	config.vm.box = "debian/jessie64"

	config.vm.define "OVPNServer", primary: true do |ovpn_server|
		ovpn_server.vm.network "private_network", ip: "192.168.1.10"
		ovpn_server.vm.network "private_network", ip: "10.0.0.10", virtualbox__intnet: "LOCAL1"
		ovpn_server.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end

		ovpn_server.vm.provision "shell", path: "scripts/openvpn_server.sh"
	end

	config.vm.define "OVPNClient1" do |ovpn_client1|
		ovpn_client1.vm.network "private_network", ip: "192.168.1.20"
		ovpn_client1.vm.network "private_network", ip: "10.0.0.20", virtualbox__intnet: "LOCAL2"
		ovpn_client1.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end
	end

	config.vm.define "OVPNClient2" do |ovpn_client2|
		ovpn_client2.vm.network "private_network", ip: "192.168.1.30"
		ovpn_client2.vm.network "private_network", ip: "10.0.0.30", virtualbox__intnet: "LOCAL3"
		ovpn_client2.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end
	end

	config.vm.define "LocalClient1" do |local_client1|
		local_client1.vm.network "private_network", ip: "10.0.0.11", virtualbox__intnet: "LOCAL1"
	end

	config.vm.define "LocalClient2" do |local_client2|
		local_client2.vm.network "private_network", ip: "10.0.0.21", virtualbox__intnet: "LOCAL2"
	end

	config.vm.define "LocalClient3" do |local_client3|
		local_client3.vm.network "private_network", ip: "10.0.0.31", virtualbox__intnet: "LOCAL3"
	end

	config.vm.define "Attacker" do |attacker|
		attacker.vm.network "private_network", ip: "192.168.1.50"
		attacker.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end
	end

end
