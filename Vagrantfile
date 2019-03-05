boxes = [
    {
        :name => :node1,
        :ip => '10.10.100.10',
        :hostname => 'node1',
        :ssh_port => '10222',
    },
    {
        :name => :node2,
        :ip => '10.10.100.11',
        :hostname => 'node2',
        :ssh_port => '10223',
    },
    {
        :name => :node3,
        :ip => '10.10.100.12',
        :hostname => 'node3',
        :ssh_port => '10224',
    },
]

Vagrant.configure(2) do |config|
    boxes.each do |opts|
        config.vm.define opts[:name] do |config|
            # Box basics
            config.vm.box = "centos/7"
            config.vm.network "private_network", ip: opts[:ip]
            config.vm.hostname = opts[:hostname]
            config.ssh.forward_agent = true

            config.vm.network :forwarded_port, guest: 22, host: opts[:ssh_port], id: "ssh"
            config.vm.provision "shell", path: "manifests/puppet.sh"
        end
    end
end
