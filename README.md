# thinkr4servier

Des trucs internes pour utiliser chez Servier mais qu'on garde pour nous

## Créer un Docker comme chez Servier
Utiliser le script `build_docker_container.R` ici, ou directement utiliser `use docker pull thinkr/rstudio3_5_2`

> Il n'a besoin d'être créé qu'une fois sur votre ordinateur pour tous les projets Servier. 

## Lancer le container pour le projet
Utiliser le script `load_server_docker.R` dans son package. Ce script ne doit pas être envoyé sur git, ni être dans le package livré. 

- Copier le fichier `load_server_docker.R` à la racine de votre projet
- Cacher de git et build car ça doit rester en interne ThinkR
```r
usethis::use_git_ignore("load_server_docker.R")
usethis::use_build_ignore("load_server_docker.R")
```

> Les packages installés en cours de développement sont persistents dans votre projet (caché de git et de build aussi)

