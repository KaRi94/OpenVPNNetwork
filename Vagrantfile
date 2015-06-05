# -*- mode: ruby -*-
# vi: set ft=ruby :

MODE = :tun

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Distribution
	config.vm.box = "debian/jessie64"

	config.vm.define "OVPNServer", primary: true do |ovpn_server|
		INTERNAL_IP_SERVER = "10.0.10.10" if MODE == :tun
		INTERNAL_IP_SERVER = "10.0.0.10" if MODE == :tap

		ovpn_server.vm.hostname = "openvpn-server"
		ovpn_server.vm.network "private_network", ip: "192.168.1.10"
		ovpn_server.vm.network "private_network", ip: INTERNAL_IP_SERVER, virtualbox__intnet: "LOCAL1"
		ovpn_server.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end

		ovpn_server.vm.provision "file", source: "cert/ca.crt", destination: "/tmp/openvpn/ca.crt"
		ovpn_server.vm.provision "file", source: "cert/server/ipp.txt", destination: "/tmp/openvpn/ipp.txt"
		ovpn_server.vm.provision "file", source: "cert/server/staticclients", destination: "/tmp/openvpn/staticclients"
		ovpn_server.vm.provision "file", source: "cert/server/dh2048.pem", destination: "/tmp/openvpn/dh2048.pem"
		ovpn_server.vm.provision "file", source: "cert/server/openvpn-server.crt", destination: "/tmp/openvpn/openvpn-server.crt"
		ovpn_server.vm.provision "file", source: "cert/server/openvpn-server.key", destination: "/tmp/openvpn/openvpn-server.key"
		ovpn_server.vm.provision "file", source: "cert/server/server_III.conf", destination: "/tmp/openvpn/server.conf" if MODE == :tun
		ovpn_server.vm.provision "file", source: "cert/server/server_II.conf", destination: "/tmp/openvpn/server.conf" if MODE == :tap

		ovpn_server.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["III", INTERNAL_IP_SERVER] if MODE == :tun
		ovpn_server.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["II"] if MODE == :tap
		ovpn_server.vm.provision "shell", path: "scripts/openvpn_server.sh"
	end

	config.vm.define "OVPNClient1" do |ovpn_client1|
		INTERNAL_IP_CLIENT1 = "10.0.20.20" if MODE == :tun
		INTERNAL_IP_CLIENT1 = "10.0.0.20" if MODE == :tap

		ovpn_client1.vm.hostname = "openvpn-client1"
		ovpn_client1.vm.network "private_network", ip: "192.168.1.20"
		ovpn_client1.vm.network "private_network", ip: INTERNAL_IP_CLIENT1, virtualbox__intnet: "LOCAL2"
		ovpn_client1.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end

		ovpn_client1.vm.provision "file", source: "cert/ca.crt", destination: "/tmp/openvpn/ca.crt"
		ovpn_client1.vm.provision "file", source: "cert/client1/openvpn-client1.crt", destination: "/tmp/openvpn/openvpn-client1.crt"
		ovpn_client1.vm.provision "file", source: "cert/client1/openvpn-client1.key", destination: "/tmp/openvpn/openvpn-client1.key"
		ovpn_client1.vm.provision "file", source: "cert/client1/client_III.conf", destination: "/tmp/openvpn/client.conf"  if MODE == :tun
		ovpn_client1.vm.provision "file", source: "cert/client1/client_II.conf", destination: "/tmp/openvpn/client.conf"  if MODE == :tap

		ovpn_client1.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["III", INTERNAL_IP_CLIENT1] if MODE == :tun
		ovpn_client1.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["II"] if MODE == :tap
		ovpn_client1.vm.provision "shell", path: "scripts/openvpn_client.sh"
	end

	config.vm.define "OVPNClient2" do |ovpn_client2|
		INTERNAL_IP_CLIENT2 = "10.0.20.20" if MODE == :tun
		INTERNAL_IP_CLIENT2 = "10.0.0.20" if MODE == :tap

		ovpn_client2.vm.hostname = "openvpn-client2"
		ovpn_client2.vm.network "private_network", ip: "192.168.1.30"
		ovpn_client2.vm.network "private_network", ip: INTERNAL_IP_CLIENT2, virtualbox__intnet: "LOCAL3"
		ovpn_client2.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end

		ovpn_client2.vm.provision "file", source: "cert/ca.crt", destination: "/tmp/openvpn/ca.crt"
		ovpn_client2.vm.provision "file", source: "cert/client2/openvpn-client2.crt", destination: "/tmp/openvpn/openvpn-client2.crt"
		ovpn_client2.vm.provision "file", source: "cert/client2/openvpn-client2.key", destination: "/tmp/openvpn/openvpn-client2.key"
		ovpn_client2.vm.provision "file", source: "cert/client2/client_III.conf", destination: "/tmp/openvpn/client.conf"  if MODE == :tun
		ovpn_client2.vm.provision "file", source: "cert/client2/client_II.conf", destination: "/tmp/openvpn/client.conf"  if MODE == :tap

		ovpn_client2.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["III", INTERNAL_IP_CLIENT2] if MODE == :tun
		ovpn_client2.vm.provision "shell", path: "scripts/all_openvpn.sh", args: ["II"] if MODE == :tap
		ovpn_client2.vm.provision "shell", path: "scripts/openvpn_client.sh"
	end

	config.vm.define "LocalClient1" do |local_client1|
		INTERNAL_IP_LOCAL1 = "10.0.10.11" if MODE == :tun
		INTERNAL_IP_LOCAL1 = "10.0.0.11" if MODE == :tap

		local_client1.vm.hostname = "local-client1"
		local_client1.vm.network "private_network", ip: INTERNAL_IP_LOCAL1, virtualbox__intnet: "LOCAL1"

		local_client1.vm.provision "shell", path: "scripts/all_locals.sh", args: ["III", INTERNAL_IP_LOCAL1] if MODE == :tun
		local_client1.vm.provision "shell", path: "scripts/all_locals.sh", args: ["II"] if MODE == :tap
		local_client1.vm.provision "shell", path: "scripts/local1.sh"
	end

	config.vm.define "LocalClient2" do |local_client2|
		INTERNAL_IP_LOCAL2 = "10.0.20.21" if MODE == :tun
		INTERNAL_IP_LOCAL2 = "10.0.0.21" if MODE == :tap

		local_client2.vm.hostname = "local-client2"
		local_client2.vm.network "private_network", ip: INTERNAL_IP_LOCAL2, virtualbox__intnet: "LOCAL2"

		local_client2.vm.provision "shell", path: "scripts/all_locals.sh", args: ["III", INTERNAL_IP_LOCAL2] if MODE == :tun
		local_client2.vm.provision "shell", path: "scripts/all_locals.sh", args: ["III"] if MODE == :tap
		local_client2.vm.provision "shell", path: "scripts/local2.sh"
	end

	config.vm.define "LocalClient3" do |local_client3|
		INTERNAL_IP_LOCAL3 = "10.0.30.31" if MODE == :tun
		INTERNAL_IP_LOCAL3 = "10.0.0.31" if MODE == :tap

		local_client3.vm.hostname = "local-client3"
		local_client3.vm.network "private_network", ip: INTERNAL_IP_LOCAL3, virtualbox__intnet: "LOCAL3"

		local_client3.vm.provision "shell", path: "scripts/all_locals.sh", args: ["III", INTERNAL_IP_LOCAL3] if MODE == :tun
		local_client3.vm.provision "shell", path: "scripts/all_locals.sh", args: ["II"] if MODE == :tap
		local_client3.vm.provision "shell", path: "scripts/local3.sh"
	end

	config.vm.define "Attacker" do |attacker|
		attacker.vm.hostname = "attacker"
		attacker.vm.network "private_network", ip: "192.168.1.50"
		attacker.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end
	end

end
