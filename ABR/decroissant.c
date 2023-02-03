#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

typedef struct abr {
  int valeur;
    struct abr *fg;
    struct abr *fd;
}Abr;

Abr* creerAbr(int valeur){ 

    Abr* pnoeud;
    pnoeud=malloc(sizeof(Abr));
    pnoeud->valeur=valeur;
    pnoeud->fg=NULL;
    pnoeud->fd = NULL;
    return pnoeud;
}

 Abr* insertion( Abr* Abr, int valeur) {
  if (Abr == NULL){ 
    return creerAbr(valeur);
}
  if (valeur < Abr->valeur){
    Abr->fg  = insertion(Abr->fg, valeur);
}
  else if (valeur > Abr->valeur){
    Abr->fd = insertion(Abr->fd, valeur);
}
  return Abr;
}

void decroissant( Abr *pAbr) {
  if (pAbr != NULL) {
    decroissant(pAbr->fd);
    printf("%d ", pAbr->valeur);
    decroissant(pAbr->fg);
  }
}

int main() {
DIR *d;
Abr* pAbr = NULL;
int valeur;
struct dirent *dir;
   d = opendir(".");
   if (d) {
      while ((dir = readdir(d)) != NULL) {
         if (strstr(dir->d_name, ".txt") != NULL) {
            printf("%s\n", dir->d_name);
            FILE* file = fopen(dir->d_name,"r");
              while (fscanf(file, "%d", &valeur) != EOF) {
                pAbr = insertion(pAbr, valeur);
    }
    fclose(file);
    decroissant(pAbr);

         }
      }

   }

   


   return 0;
}



   
