#!/bin/bash

# a execução do script será encerrada caso a quantidade de argumentos é diferente de 1
if [[ $# != 1 ]]; then
  echo "ERRO: o script deve receber exatamente 1 argumento — a senha do MySQL."
  exit 1
fi

# a execução do script será encerrada caso a senha não satisfaça os requisitos definidos abaixo
if ! [[ 
  ${#1} -ge 8 &&
  $1 =~ [a-z] &&
  $1 =~ [A-Z] &&
  $1 =~ [0-9] &&
  $1 =~ [[:punct:]]
]]; then
  echo "ERRO: a senha dever ter no mínimo 8 characters e conter ao menos 1 letra minúscula, 1 letra maíuscula, 1 número e 1 sinal de pontuação."
  exit 1
fi

# 1. crie um namespace labwordpress, tudo o que for feito deverá estar dentro deste namespace
kubectl create namespace labwordpress
kubectl config set-context --current --namespace=labwordpress

printf "\n"

# 2. faça o apply do arquivo de service do MySQL mude a porta padrão do banco MySQL para 3308
kubectl apply -f mysql-service.yaml

# 3. crie o arquivo secret que deverá conter a senha do banco MySQL c/ fortes padrões de segurança
echo -n $1 > password.txt
kubectl create secret generic mysql-pass --from-file=password.txt -n labwordpress

# 4. faça o apply do arquivo de PersistentVolumeClaim do MySQL para um capacity de 3GB
kubectl apply -f mysql-pvc.yaml

# 5. faça o apply do arquivo de deployment do MySQL, crie também um volume
# mount no deployment do MySQL chamado “mysql-persistent-storage-lab", apontando para
# /var/lib/mysql; lembre-se de criar o volume em si com o mesmo nome do volume mount
kubectl apply -f mysql-deployment.yaml

# 6. faça o apply do arquivo de service do Wordpress altere para a TCP Port 80;
kubectl apply -f wordpress-service.yaml

# 7. faça o apply do arquivo de PersistentVolumeClaim do Wordpress, para um capacity de 3GB
kubectl apply -f wordpress-pvc.yaml

# 8. no arquivo de deployment do Wordpress, crie um volume mount no deployment
# do Wordpress chamado “wordpress-persistent-storage-lab", apontando para
# /var/www/html. Lembre-se de criar o volume em si com o mesmo nome do volume mount;
#
# 9. no arquivo de deployment do wordpress, insira o secret contendo o password do MySQL
#
# 10. faça o apply do arquivo de deployment do wordpress
kubectl apply -f wordpress-deployment.yaml

printf "\n"

# 11. verifque se os pods, os services e os pvcs foram criados da forma correta dentro namespace
kubectl get pods,services,pvc -n labwordpress

printf "\n"

# 12. verifique qual foi a URI gerada através do ingress do Kubernetes
minikube addons enable ingress
kubectl apply -f wordpress-ingress.yaml

echo -n "Ingress address: "

# após a criação do ingress, demora alguns segundos para que o IP seja gerado
# no loop abaixo, checamos se o IP já foi gerado, se não, aguardamos 3 segundos e tentamos novamente
while [[ true ]]; do
  ip=$(kubectl get ingress wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}' -n labwordpress)

  if [[ $ip != '' ]]; then
    echo "http://${ip}:80"
    exit 0
  fi

  sleep 3
done