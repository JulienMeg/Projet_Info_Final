#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

void sort_array(int *array, int size) {
    int i, j, temp;
    for (i = 0; i < size - 1; i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (array[j] < array[j + 1]) {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}



int main() {
   DIR *d;
   struct dirent *dir;
   d = opendir(".");
   if (d) {
      while ((dir = readdir(d)) != NULL) {
         if (strstr(dir->d_name, ".txt") != NULL) {
            printf("%s\n", dir->d_name);
                int array[100];
    int size = 0;
    FILE *fp;

    fp = fopen(dir->d_name, "r");
    if (fp == NULL) {
        printf("Error opening file!\n");
        return 1;
    }

    int i = 0;
    while (fscanf(fp, "%d", &array[i]) != EOF) {
        size++;
        i++;
    }

    sort_array(array, size);

    for (i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }

    fclose(fp);
         }
      }
      closedir(d);
   }
   return 0;
}

