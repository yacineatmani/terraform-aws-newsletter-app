# Captures écran — Projet 2 (Checklist rapide)

Dépose toutes les images dans `screenshots/` avec **exactement** ces noms:

1. `01-terraform-apply.png`
   - Contenu: terminal montrant `terraform apply -auto-approve` terminé avec succès.

2. `02-terraform-output.png`
   - Contenu: terminal montrant `terraform output` avec `instance_public_ip` et `app_url`.

3. `03-ec2-instance-running.png`
   - Contenu: console AWS EC2, état de l’instance = `running`.

4. `04-security-group-http-ssh.png`
   - Contenu: inbound rules du Security Group (`80` et `22`).

5. `05-app-live-browser.png`
   - Contenu: application ouverte dans le navigateur via l'URL renvoyée par `terraform output app_url`.

## Ordre de prise (2-3 min)
- Lance les commandes Terraform (captures 1 et 2).
- Ouvre AWS EC2 (captures 3 et 4).
- Ouvre l’URL de l’app (capture 5).

## Vérification finale
- Les 5 fichiers existent dans `screenshots/`.
- Le README affiche bien les 5 images.
- Les captures sont lisibles (nom de l’instance, URL, status).
- L'URL visible dans la capture correspond bien à la dernière valeur de `terraform output app_url`.
