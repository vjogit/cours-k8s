Deployement d'un registre prive sous k8s.
Pour faire un test: 
https://www.paulsblog.dev/how-to-install-a-private-docker-container-registry-in-kubernetes/#push-images-to-private-registry-in-kubernetes-cluster

et pour un docker unsecure:
https://docs.docker.com/registry/insecure/
https://askubuntu.com/questions/1153636/how-to-configure-the-docker-snap-to-accept-a-private-registry-certificate

Dans 
/var/snap/docker/current/etc/docker/10.54.56.39:5000
ajouter le certificat: masterRootCA.crt

se logger dans docker
docker login -u vjo -p vjo 10.54.56.39:5000
 et faire un test

 ATTENTION: le pods ne connait pas masterRootCA.crt qui vient d'etre créer: doit relancer k8s. Autre solution?
