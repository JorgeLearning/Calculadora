#!/usr/bin/perl
use strict;
use warnings;

# Leemos el archivo en un arreglo
open(IN, "Programas_de_Universidades.csv") or die("Error: No se pudo leer el archivo");
my @arr = <IN>;
close(IN);

# Verificamos la correcta lectura
my $line = $arr[0];
print "$line\n";
