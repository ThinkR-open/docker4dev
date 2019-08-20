# thinkr4servier

Des trucs internes pour utiliser chez Servier mais qu'on garde pour nous

## Docker comme chez Servier
Utiliser le script `install_server_docker.R` dans son package. Ce script ne doit pas être envoyé sur git, ni être dans le package livré. 

- Copier le fichier `install_server_docker.R` à la racine de votre projet
- Cacher de git et build
```r
usethis::use_git_ignore("install_server_docker.R")
usethis::use_build_ignore("install_server_docker.R")
```

- Exécuter la partie `firsttime` à la première utilisation pour créer le Docker
- Les fois suivantes, il suffit de le lancer directement

> Les packages installés en cours de développement sont persistents dans votre projet (caché de git et de build aussi)

