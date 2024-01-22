Pour que les vm fonctionne, doit définir un réseau:

virsh net-destroy bridge-kvm
virsh net-list --all

virsh net-define bridge-kvm.xml
virsh net-autostart bridge-kvm
virsh net-start bridge-kvm