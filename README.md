# (CompassPB) - Atividade Kubernetes - DevSecOps
### Atividade realizada por Amadeu Chacar, Luiz Gustavo e Rodrigo Pacheco

## Objetivo
*Aplicar os conhecimentos adquiridos na trilha de Kubernetes*

# 🔨 Configurando Docker Desktop 
*Atividade realizada no Windows 10*

## Requisitos
- Docker Desktop: https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
- 4GB de RAM
- Windows 11 de 64 bits: Home ou Pro versão 21H2 ou superior, ou Enterprise ou Education versão 21H2 ou superior
- Windows 10 de 64 bits: Home ou Pro 21H1 (build 19043) ou superior, ou Enterprise ou Education 20H2 (build 19042) ou superior

## 1. Configuração
### 1.1 Abra o docker desktop 
### 1.2 Vá no ícone de configuração
### 1.3 Aba Kubernetes 
### 1.4 "Enable Kubernetes"
### 1.5 "Apply & restart"
![Conf kubernetes](https://user-images.githubusercontent.com/91745101/203157780-e1f68a61-ab98-49fe-b812-87221d655718.png)

# 🖥 Executando a aplicação 
*Todos os arquivos .yaml que serão citados estão versionados neste repositório*

## 2. Execução
### 2.1 Abra o PowerShell e entre no local onde os arquivos .yaml estão presentes
### 2.2 Como solicitado, crie um namespace labwordpress
```
 kubectl create namespace labwordpress
```  
### 2.3 Entre no namespace criado
```
kubectl config set-context --current --namespace=labwordpress
```  
### 2.4 Suba o arquivo de serviço MySQL 
```
kubectl apply -f mysql-service.yaml
```  
### 2.5 Crie um arquivo secret password.txt com uma senha dentro
### 2.6 Use o comando para criar o sescret
```
kubectl create secret generic mysql-pass --from-file=password.txt -n labwordpress
```  
### 2.7 Verifique se secret foi criado 
```
kubectl get secret
```  
### 2.8 Suba o arquivo Persistent Volume Claim (PVC) do MySQL
```
kubectl apply -f mysql-pvc.yaml
```  
### 2.9 Suba o arquivo deployment MySQL
```
kubectl apply -f mysql-deployment.yaml
```  
### 2.10 Suba o arquivo de serviço wordpress
```
kubectl apply -f wordpress-service.yaml
``` 
### 2.11 Suba o arquivo Persistent Volume Claim (PVC) do wordpress
```
kubectl apply -f wordpress-pvc.yaml
``` 
### 2.12 Suba o arquivo deployment wordpress
```
kubectl apply -f wordpress-pvc.yaml
``` 
### 2.13 Suba o aquivo deployment wordpress
```
kubectl apply -f wordpress-deployment.yaml
``` 
### 2.14 Por fim, suba o arquivo ingress
```
kubectl apply -f wordpress-ingress.yaml
``` 


 
 



