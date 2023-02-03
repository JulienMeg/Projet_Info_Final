// Définition des bibliothèques
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

// Définition de la structure de l'ABR
typedef struct abr{
  int valeur;
  struct abr *fg;
  struct abr *fd;
}Abr;

// Création de l'ABR
Abr*creerAbr(int valeur){ 
    Abr* pnoeud;
    pnoeud=malloc(sizeof(Abr));
    pnoeud->valeur=valeur;
    pnoeud->fg=NULL;
    pnoeud->fd = NULL;
    return pnoeud;
}


// Fonction permettant d'insérer un noeud dans l'arbre
Abr* insertion(Abr* pAbr,int valeur){
  if(pAbr==NULL){ 
    return creerAbr(valeur);
}
  if(valeur < pAbr->valeur){
    pAbr->fg=insertion(pAbr->fg, valeur);
}
  else if(valeur>pAbr->valeur){
    pAbr->fd=insertion(pAbr->fd,valeur);
}
  return pAbr;
}

// Classe les noeuds par ordre croissant
void croissant(Abr* pAbr){
  if (pAbr!= NULL){
    croissant(pAbr->fg);
    printf("%d ", pAbr->valeur);
    croissant(pAbr->fd);
  }
}
 
// P'tit main pour tester si tout fonctionne



int main() {
  Abr* pAbr = NULL;
  int valeur;
  DIR *d;
  struct dirent *dir;
  d = opendir(".");
  if (d) {
      while ((dir = readdir(d)) != NULL) {
         if (strstr(dir->d_name, ".txt") != NULL) {
            printf("%s\n", dir->d_name);
    FILE* file = fopen(dir->d_name, "r");
    while (fscanf(file, "%d", &valeur) != EOF) {
        pAbr = insertion(pAbr, valeur);
    }
    fclose(file);
    croissant(pAbr);
         }
      }
      closedir(d);
   }
   return 0;
}