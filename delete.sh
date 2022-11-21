#!/bin/bash

kubectl delete \
  -f mysql-deployment.yaml \
  -f mysql-service.yaml \
  -f mysql-pvc.yaml \
  -f wordpress-deployment.yaml \
  -f wordpress-ingress.yaml \
  -f wordpress-service.yaml \
  -f wordpress-pvc.yaml

kubectl delete secret mysql-pass -n labwordpress
rm password.txt