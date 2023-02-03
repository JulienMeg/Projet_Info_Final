#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
typedef struct abr{
    int valeur;
    struct abr* fg;
    struct abr* fd;
}Abr;

Abr* creerAbr(int valeur){ 
    Abr* pnoeud;
    pnoeud=malloc(sizeof(Abr));
    pnoeud->valeur=valeur;
    pnoeud->fg=NULL;
    pnoeud->fd = NULL;
    return pnoeud;
}



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


void trouv_min(Abr* pAbr) {
    if (pAbr == NULL) {
        return exit(2);
    }
    while (pAbr->fg != NULL) {
        pAbr = pAbr->fg;
    }
    printf("%d",pAbr->valeur);
}


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
    trouv_min(pAbr);
         }
      }
      closedir(d);
   }
   return 0;
}
