#/bin/bash


cd /mnt/cours/k8s/cours-k8s/plateform/0-test
ansible-playbook test.yaml

cd /mnt/cours/k8s/cours-k8s/plateform/1-containerd
ansible-playbook containerd.yaml

cd /mnt/cours/k8s/cours-k8s/plateform/2-kube-tools
ansible-playbook kube-tools.yaml

cd /mnt/cours/k8s/cours-k8s/plateform/3-master
ansible-playbook master.yaml

cd /mnt/cours/k8s/cours-k8s/plateform/4-nodes
ansible-playbook nodes.yaml

cd /mnt/cours/k8s/cours-k8s/plateform/5-cluster-tools
ansible-playbook cluster-tools.yaml

