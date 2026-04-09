# Fiche TL;DR — Projet 2 (Terraform + EC2 + Docker + CI/CD)

## Pitch (30 secondes)
J’ai déployé une application newsletter conteneurisée sur une instance EC2 provisionnée par Terraform, avec build/push d’image Docker via GitHub Actions, puis redéploiement automatique sur AWS.

## Objectif du projet
- Déployer une app réelle (pas un simple hello world) sur EC2 via Docker.
- Industrialiser le flux image via CI/CD GitHub Actions.
- Obtenir une URL publique stable avec preuve HTTP 200.

## Ce qui a été implémenté
- Terraform pour:
  - Security Group (ports `22` et `80`).
  - Instance EC2 `t3.micro`.
  - `user_data` pour installer Docker et lancer le conteneur.
  - Outputs (`instance_public_ip`, `app_url`).
- Variable `docker_image` pour piloter l’image sans modifier le code.
- Variable `container_port` pour corriger les mappings de ports.
- Lookup AMI dynamique (Amazon Linux 2) au lieu d’un AMI hardcodé.
- CI/CD dans `News_Site`:
  - Build Docker
  - Login Docker Hub
  - Push `yacineatmani/newsletter-app:latest`
- Déploiement final confirmé par endpoint AWS en HTTP 200.

## Difficultés rencontrées
- **AMI invalide**: ID hardcodé non disponible dans la région.
- **Image Docker indisponible/privée**: conteneur ne démarrait pas avec l’image cible.
- **Mismatch de ports**: mapping hôte/conteneur incohérent (`80:3000` vs image qui écoute ailleurs).
- **CI Docker Hub KO**:
  - Secrets/variables mal alignés.
  - Token avec scopes insuffisants.
- **Build Docker échouait sur Composer scripts**.
- **Impact collatéral Railway**: Dockerfile AWS perturbait l’app Railway existante.

## Résolution des difficultés
- AMI dynamique via data source Terraform.
- Variable `container_port` + redéploiement EC2 propre.
- Correction workflow GitHub Actions (auth Docker Hub + scopes corrects).
- Ajustement `composer install --no-scripts` dans le build.
- Séparation des contextes:
  - `Dockerfile.aws` pour AWS
  - `railway.json` pour Railway (Nixpacks + start command adapté)

## Résultat final
- Pipeline Docker opérationnel.
- Image réelle publiée sur Docker Hub.
- EC2 déployée et app accessible publiquement (HTTP 200).
- Projet prêt pour démonstration "infra + delivery".

## Valeur “cloud engineer” à dire demain
- J’ai géré un déploiement de bout en bout (IaC + conteneur + CI/CD + prod).
- J’ai résolu des pannes réelles multi-couches (IAM/AMI/network/CI/runtime).
- J’ai sécurisé la démarche en séparant les environnements AWS et Railway pour éviter les régressions.
