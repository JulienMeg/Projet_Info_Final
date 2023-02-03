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




int main() {
  int valeur;
  int nbnb;
  float num, sum, average;
  DIR *d;
  struct dirent *dir;
  d = opendir(".");
   if (d) {
      while ((dir = readdir(d)) != NULL) {
         if (strstr(dir->d_name, ".txt") != NULL) {
            printf("%s\n", dir->d_name);
  FILE* file = fopen(dir->d_name, "r");
  if (file == NULL) {
    printf("Could not open file\n");
    return 1;
  }
nbnb=0;
sum=0;
  while (fscanf(file, "%d", &valeur) != EOF) {
        fscanf(file, "%f", &num);
    sum =sum+num;
    nbnb=nbnb+1;
    }
  average = sum / nbnb;
  printf("La moyenne est de: %.2f\n", average);

  fclose(file);
         }
      }
      closedir(d);
   }
   return 0;
}
