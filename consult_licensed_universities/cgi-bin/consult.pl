#!/usr/bin/perl
use strict;
use warnings;

# Leemos el archivo en un arreglo
open(IN, "Programas_de_Universidades.csv") or die("Error: No se pudo leer el archivo");
my @arr = <IN>;
close(IN);

sub readHeader {
  my $line = $arr[0];
  # La expresion regular captura un flujo de caracteres hasta encontrar el "|". 
  while($line =~ /^([^\|]+)\|(.+)/) {
    # Una vez que se encuentra "|" la cadena se separa en dos partes
    print "$1\n"; 
    # Actualizamos $line para que la subcadena se vuelva a analizar
    $line = $2;
  }
  # Como para la ultima $line no se encontrara "|", el while para y no se 
  # imprime el ultimo item
  print "$line\n";
}

sub generateRegExp {
  my $n = $_[0];
  my $exp = "^";
  # Generamos la expresion regular que divide en n grupos a la linea analizada
  for(my $i = 0; $i < $n - 1; $i++) {
    $exp .= "([^\|]+)\|";
  }
  $exp .= "([^\|]+)";
  return $exp;
}

# En este caso probamos con 4 divisiones, de hecho deberiamos saber el numero de columnas
# de cada linea
print generateRegExp(4)."\n";

