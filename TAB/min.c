#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

#define MAX_SIZE 100




int main() {
   DIR *d;
   struct dirent *dir;
   d = opendir(".");
   if (d) {
      while ((dir = readdir(d)) != NULL) {
         if (strstr(dir->d_name, ".txt") != NULL) {
            printf("%s\n", dir->d_name);
            int array[MAX_SIZE];
  int i, n, min;
  FILE *fp;

  fp = fopen(dir->d_name, "r");
  if (fp == NULL) {
    printf("Erreur lors de l'ouverture du fichier.\n");
    return 1;
  }

  for (i = 0; i < MAX_SIZE && fscanf(fp, "%d", &array[i]) == 1; i++);
  n = i;
  fclose(fp);

  min = array[0];
  for (i = 1; i < n; i++) {
    if (array[i] < min) {
      min = array[i];
    }
  }

  printf("La valeur minimale est: %d\n", min);
         }
      }
      closedir(d);
   }
   return 0;
}
