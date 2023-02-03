#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

typedef struct avl{
    int valeur;
    int equilibre;
    struct avl* fg;
    struct avl* fd;
}Avl;


 Avl*creerArbre(int valeur) {
   Avl* pAvl = (Avl*)malloc(sizeof(Avl));
  pAvl->valeur = valeur;
  pAvl->equilibre = 1;
  pAvl->fg = NULL;
  pAvl->fd = NULL;
  return (pAvl);
}


int max(int a, int b) {
  return (a > b) ? a : b;
}



int equilibre(Avl* pAvl) {
  if (pAvl == NULL)
    return 0;
  return pAvl->equilibre;
}




int equilibrage(Avl* pAvl) {
  if (pAvl == NULL)
    return 0;
  return equilibre(pAvl->fg) - equilibre(pAvl->fd);
}


 Avl*fdRotate(Avl*y) {
   Avl*x = y->fg;
   Avl*T2 = x->fd;
  x->fd = y;
  y->fg = T2;
  y->equilibre = max(equilibre(y->fg), equilibre(y->fd)) + 1;
  x->equilibre = max(equilibre(x->fg), equilibre(x->fd)) + 1;
  return x;
}


 Avl*fgRotate(Avl*x) {
   Avl*y = x->fd;
   Avl*T2 = y->fg;
  y->fg = x;
  x->fd = T2;
  x->equilibre = max(equilibre(x->fg), equilibre(x->fd)) + 1;
  y->equilibre = max(equilibre(y->fg), equilibre(y->fd)) + 1;
  return y;
}



 Avl* insertion( Avl* pAvl, int valeur) {
  if (pAvl == NULL)
    return (creerArbre(valeur));
  if (valeur < pAvl->valeur){
    pAvl->fg = insertion(pAvl->fg, valeur);
}
  else if (valeur > pAvl->valeur){
    pAvl->fd = insertion(pAvl->fd, valeur);
}
  else{
    return pAvl;
}
  pAvl->equilibre = 1 + max(equilibre(pAvl->fg), equilibre(pAvl->fd));
  int balance = equilibrage(pAvl);
  if (balance > 1 && valeur < pAvl->fg->valeur){
    return fdRotate(pAvl);
}
  if (balance < -1 && valeur > pAvl->fd->valeur){
    return fgRotate(pAvl);
}
  if (balance > 1 && valeur > pAvl->fg->valeur){
    pAvl->fg = fgRotate(pAvl->fg);
    return fdRotate(pAvl);
  }
  if (balance < -1 && valeur < pAvl->fd->valeur){
    pAvl->fd = fdRotate(pAvl->fd);
return fgRotate(pAvl);
}
return pAvl;
}





void findMaxValue(Avl*pAvl) {
      if (pAvl == NULL) {
    printf("L'arbre AVL est vide.\n");
    return exit(2);
  }
  while (pAvl->fd != NULL) {
    pAvl = pAvl->fd;
  }
  printf("%d",pAvl->valeur) ;
}

void findMinValue(Avl*pAvl) {
      if (pAvl == NULL) {
    printf("L'arbre AVL est vide.\n");
    return exit(3);
  }
  while (pAvl->fg != NULL) {
    pAvl = pAvl->fg;
  }
  printf("%d",pAvl->valeur) ;
}





int main() {
   Avl* pAvl = NULL;
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
        pAvl = insertion(pAvl, valeur);
    }
    fclose(file);
    findMaxValue(pAvl);
         }
      }
      closedir(d);
   }
   return 0;
}


