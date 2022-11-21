# PB DevSecOps Compass.uol - Atividade de Kubernetes
### Realizada por Amadeu Chacar, Luiz Gustavo Albuquerque e Rodrigo Pacheco

## Objetivo
*Aplicar os conhecimentos adquiridos na trilha de Kubernetes, subindo uma aplicação Wordpress com banco de dados MySQL utilizando a ferramenta de orquestração de containers*

Esta documentação explicitará os passos para serem executados tanto no sistema operacional Linux e Windows.

## Windows

### 🔨 Configurando Docker Desktop 
*Atividade realizada no Windows 10*

### Requisitos
- [**Docker Desktop**](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)
- 4GB de RAM
- Windows 11 de 64 bits: Home ou Pro versão 21H2 ou superior, ou Enterprise ou Education versão 21H2 ou superior
- Windows 10 de 64 bits: Home ou Pro 21H1 (build 19043) ou superior, ou Enterprise ou Education 20H2 (build 19042) ou superior
- Kubernetes (este pode ser utilizado via [**kubeadm**](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) e [**mikikube**](https://minikube.sigs.k8s.io/docs/start/) ou via Docker Desktop for Windows)

*Ao longo desta documentação será explicitado o passo a passo para utilização via Docker Desktop for Windows, porém para minikube não existem muitas diferenças.*

### 1. Configuração
1. Abra o docker desktop

2. Vá no ícone de configuração

3. Aba Kubernetes

4. "Enable Kubernetes"

5. "Apply & restart"

![Conf kubernetes](https://user-images.githubusercontent.com/91745101/203157780-e1f68a61-ab98-49fe-b812-87221d655718.png)

### 🖥 Executando a aplicação 
*Todos os arquivos .yaml que serão citados estão versionados neste repositório*

### 2. Execução
1. Abra o PowerShell e entre no local onde os arquivos .yaml estão presentes
2. Como solicitado, crie um namespace labwordpress

```
 kubectl create namespace labwordpress
```  
3. Entre no namespace criado

```
kubectl config set-context --current --namespace=labwordpress
```  
4. Suba o arquivo de serviço MySQL 

```
kubectl apply -f mysql-service.yaml
```  
5. Crie um arquivo password.txt contendo a senha para o MySQL
6. Use o comando abaixo para criar o secret

*Lembre-se de criar uma senha forte, com no mínimo 8 caracteres e ao menos 1 letra minúscula, 1 letra maiúscula, 1 número e 1 sinal de pontuação*

```
kubectl create secret generic mysql-pass --from-file=password.txt -n labwordpress
```  

7. Suba o arquivo Persistent Volume Claim (PVC) do MySQL

```
kubectl apply -f mysql-pvc.yaml
```  
8. Suba o arquivo deployment MySQL

```
kubectl apply -f mysql-deployment.yaml
```  
9. Suba o arquivo de serviço wordpress
```
kubectl apply -f wordpress-service.yaml
``` 
10. Suba o arquivo PersistentVolumeClaim (PVC) do wordpress
```
kubectl apply -f wordpress-pvc.yaml
``` 
11. Suba o arquivo deployment wordpress
```
kubectl apply -f wordpress-pvc.yaml
``` 
12. Suba o aquivo deployment wordpress
```
kubectl apply -f wordpress-deployment.yaml
``` 
13. Habilitar o ingress fazendo deployment do Nginx, que fará o trabalho de controller
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml
```
**SE ESTIVER UTILIZANDO MINIKUBE**
```
minikube addons enable ingress
```
14. Suba o arquivo ingress
```
kubectl apply -f wordpress-ingress-2.yaml
``` 
15. Por fim, acesse o arquivo hosts (como administrador) contido no diretório: C:\Windows\System32\drivers\etc e adicione o localhost com o endereço contido no arquivo ingress que foi aplicado na etapa anterior.


![config hosts](https://user-images.githubusercontent.com/91745101/203161971-8761d83d-3884-47c2-b07f-e65054430c54.png)


 
 



