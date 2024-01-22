all: tls.key tls.crt

masterRootCA.key:
	openssl genrsa  -out masterRootCA.key 4096

masterRootCA.crt: masterRootCA.key
	openssl req -x509 -new -nodes -key  masterRootCA.key -sha256 -days 10240 -out masterRootCA.crt  -subj '/C=US/ST=CA/L=SanFrancisco/O=MyCompany/OU=RND/CN=localhost/'

tls.key:
	openssl genrsa -out tls.key 2048

tls.csr: tls.key
	 openssl req -new -sha256 -key tls.key -addext 'subjectAltName = IP:$(ip_value)' -subj '/C=US/ST=CA/L=SanFrancisco/O=MyCompany/OU=RND/CN=localhost/' -out tls.csr

tls.crt:  tls.csr  masterRootCA.crt  masterRootCA.key
	echo 'subjectAltName=IP:$(ip_value)' > altName.txt
	openssl x509 -req -in tls.csr -CA masterRootCA.crt -CAkey masterRootCA.key -CAcreateserial -out tls.crt -days 5000 -sha256   -extfile  altName.txt




