ENV['VAGRANT_NO_PARALLEL'] = 'yes'
NETWORK_PREFIX = "10.54.56"

class Machine
  attr_accessor :name, :ip, :mac

  def initialize(name, ip, mac)
    @name = name
    @ip = ip
    @mac = mac
  end
end

# mac doivent etre identique a celle du  fichier "bridge-kvm.xml"
machines = [
    Machine.new("master", "100", "0a:54:20:4c:fb:62"),
    Machine.new("node1", "101", "4e:e3:05:5d:92:5d"),
    Machine.new("node2", "102", "8a:fe:35:ca:7c:61"),
    Machine.new("node3", "103", "3e:10:50:4d:06:13"),
 #  Machine.new("node4", "104", "ce-0d-ec-08-d4-f8")
]

# virsh net-destroy bridge-kvm
# virsh net-list --all
system("virsh net-define bridge-kvm.xml")
system("virsh net-autostart bridge-kvm")
system("virsh net-start bridge-kvm")

machines.each do |aMachine|
    system("ssh-keygen -f \"/home/etudiant/.ssh/known_hosts\" -R \"#{NETWORK_PREFIX}.#{aMachine.ip}\"")
end

Vagrant.configure("2") do |config|

  # partie commune à toutes les VM. Peux aussi utiliser generic/rocky8
  # La Rocky-9-Vagrant-Libvirt-9.3 passera dans le repertoire https://dl.rockylinux.org/vault/rocky/9.3 quand la 9.4 sortira.

  config.vm.box_url = "https://download.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-Vagrant-Libvirt-9.3-20231113.0.x86_64.box"
  config.vm.box = "Rocky-9-Vagrant-Libvirt-9.3-20231113.0.x86_64.box"
  config.vm.box_download_checksum = "19fa2171a8b37a910c8839a95ab5502be2d9a892cb33bbbeaab7ade94859b31c"

  #config.vm.box_url = "https://download.rockylinux.org/pub/rocky/8.9/images/x86_64/Rocky-8-Vagrant-Libvirt-8.9-20231119.0.x86_64.box"
  #config.vm.box = "Rocky-8-Vagrant-Libvirt-8.9-20231119.0.x86_64.box"
  #config.vm.box_download_checksum = "cdc1608e30cd3bbac1de52722c597780aa4c44018f92aa5734505eec9476a450"

  config.vm.box_download_checksum_type = "sha256"
  config.vm.synced_folder ".", "/vagrant",  disabled: true  #type: "virtiofs"

  machines.each do |aMachine|
    config.vm.define aMachine.name do |app1|
      
      app1.vm.hostname = aMachine.name
      app1.vm.network :private_network,
     #    ip: "#{NETWORK_PREFIX}.#{aMachine.ip}" ,
         libvirt__network_name: "bridge-kvm"
      
      app1.vm.provider :libvirt do |libvirt|
        libvirt.cpus = 2
        libvirt.memory = 4096
        libvirt.keymap= "fr"
# necessaire pour virtiofs
        #libvirt.memorybacking :access, :mode => "shared"

#https://stackoverflow.com/questions/60521252/setting-static-ip-for-management-network-in-vagrant-libvirt-provider
        libvirt.management_network_address = "10.54.56.0/24"
        libvirt.management_network_name = "bridge-kvm"
        libvirt.management_network_mac = aMachine.mac
      end

      app1.vm.provision "shell", inline: <<-SHELL
        # peut se retrouver avec la meme adresse mac sur 2 ip.
        # Pour eviter ainsi une attente sur  ssh, réinitialise le cache arp
        sudo ip -s -s neigh flush all 2> /dev/null
      SHELL

      app1.vm.provision :ansible do |ansible|
        # https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_intro
        ansible.playbook = "provisioning/playbook.yml"

      end
    end
  end


end
