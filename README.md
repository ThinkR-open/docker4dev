# thinkr4dev

Des Dockers avec tout ce qu'il faut pour SantaCruz en formation R.

## Le docker de formation est dans "geospatial-thinkr"

- Lorsqu'on fait un release, le conteneur est créé automatiquement sur Docker Hub

## Créer un Docker pour prestation
Utiliser le script `build_docker_container.R` ici, ou directement utiliser `docker pull thinkr/docker4dev`

## Lancer le container pour le projet avec {devindocker}

https://thinkr-open.github.io/devindocker/

## Rendre ce dépôt automatiquement build avec Docker Hub

- Se connecter sur Docker Hub
- Lier son compte à GitHub (Mon compte > Link Accounts)
	+ Autoriser organisation ThinkR à la connexion
	+ Sinon revoke sur GitHub et recommencer sur DockerHub
- Creer un repo
- Donner un nom
- Create
- Aller dans "Builds"
- Link to GitHub
