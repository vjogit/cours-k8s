en local, faire ansible-galaxy collection install kubernetes.core

Pour l'ip des service, par default voir  https://stackoverflow.com/questions/44190607/how-do-you-find-the-cluster-service-cidr-of-a-kubernetes-cluster
par defautlt, service: 10.96.0.0/12 et cluster: 192.168.0.0/16
Attention de n'avoir aucun element commun a reseau machine et service!
1 carte par sous reseau, sinon le noyau introduit des time-out.

watch kubectl get pod --all-namespaces -o wide
kubectl --namespace istio-system logs istio-egressgateway-69cbcfc4d-9g5s2
kubectl --namespace cybema3-1 describe po my-nginx-646554d7fd-2s85z
kubectl cluster-info dump
kubectl exec --stdin --tty shell-demo -- /bin/bash
kubectl get all -n cybema3-1
kubectl describe ingress -n cybema3-1


inspiree de : https://www.centlinux.com/2022/11/install-kubernetes-master-node-rocky-linux.html

necessaire d'avoir les meme version de package python sur master et local. Pour upgrader tt le monde:
    pip3 list -o | cut -f1 -d' ' | tr " " "\n" | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip3 install -U 

Pour utiliser le dashboard, doit:
    - sur master: kubectl proxy
    - sur hotes: ssh -N -L 8001:127.0.0.1:8001 root@10.54.56.100

Pour agrandi un disque d'une vm,  qui a xfs comme filesystem:
    Vm a l'arret: qemu-img resize Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2 +10G
    Vm en marche:
        xfs_growfs /dev/vda5
        growpart /dev/vda 5
        
Plus d'info sur xfs: https://access.redhat.com/documentation/fr-fr/red_hat_enterprise_linux/6/html/storage_administration_guide/ch-xfs




