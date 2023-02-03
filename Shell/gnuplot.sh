#!/usr/bin/gnuplot -persist

#graphe humidité moyenne par station
reset
set terminal png size 1100, 600
set grid layerdefault lt 0 linecolor 0 linewidth 0.5, lt 0 linecolor 0 linewidth 0.5
set title font ",17"
set xlabel "x"
set xlabel font "0,2"
set xtic(1) rotate 90
set ylabel "y"
set ylabel font "0,2"
set datafile separator ';'
plot "fichier.txt" using 0:2:xtic(1) with linespoint linewidth 3 linecolor 0 title "alt"   

#graphe températures max/moy/min par station -> barres d'erreur
set xrange = [-2:100]
set yrange = [-10:65]
set datafile separator ';'
plot "fichier.txt" using ($1/1000):4:2:3 lt 7 lc 0 with errorbars


#graphe températures moy par date -> ligne simple
set xrange = [2010:2020]
set yrange = [-10:65]
set datafile separator ';'
plot "fichier.txt" using 2:3 lt 7 lc 0 w lp
