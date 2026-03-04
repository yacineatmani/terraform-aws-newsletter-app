# Projet 2 : Newsletter App - Containerized & Deployed with Terraform

Objectif : déployer une application newsletter Docker sur EC2 avec Terraform (Security Group + User Data + Outputs).

## Stack
- Terraform
- AWS EC2 (t3.micro)
- Docker
- Security Group (HTTP/SSH)

## Infrastructure
- `aws_security_group.sg` : autorise 80/tcp et 22/tcp
- `aws_instance.newsletter` : lance Docker et déploie l'image `yacineatmani/newsletter-app:latest`
- Outputs : IP publique et URL de l'application

## Déploiement
```bash
export AWS_PROFILE=terraform
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

## Vérification
```bash
terraform output instance_public_ip
terraform output app_url
```

Ouvre ensuite l'URL dans le navigateur.

## Captures à ajouter
- Terraform apply
- Console EC2 (instance running)
- Application live dans le navigateur

## Nettoyage (pour éviter les coûts)
```bash
terraform destroy -auto-approve
```
