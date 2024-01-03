#!/usr/bin/perl
use strict;
use warnings;

open(IN, "Programas_de_Universidades.csv") or die("Error: No se pudo leer el archivo");
my @arr = <IN>;
close(IN);

my $line = $arr[0];
print "$line\n";
