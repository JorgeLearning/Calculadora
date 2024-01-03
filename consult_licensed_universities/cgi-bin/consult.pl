#!/usr/bin/perl
use strict;
use warnings;
use CGI;

# Leemos el archivo en un arreglo
open(IN, "Programas_de_Universidades.csv") or die("Error: No se pudo leer el archivo");
my @arr = <IN>;
close(IN);

# Recibir los datos
my $q = CGI->new;
my $kind = $q->param("kind");
my $keyword = $q->param("keyword");

print $q->header("text/html", "charset=UTF-8");
print "$kind\n$keyword\n";
search($kind, $keyword, \@arr);

# Esta es la subrutina general que hace la busqueda, recibe los campos y el
# array que almacena el archivo .csv
sub search {
  my $kind = $_[0];
  my $keyword = $_[1];
  my $arrayRef = $_[2];
  my @array = @$arrayRef;
  my $size = readHeader(@array);
  my $pattern = generateRegExp($size);
  print "$size\n$pattern\n";
  print "Antes del 1er foreach\n";

  my %results = ();
  foreach my $line (@array) {
    if($line =~ /$pattern/) {
      my @items = ($2, $5, $11, $17);
      my $item = kindSearch($kind, \@items);

      if($item eq $keyword) {
        my $cont = $results{$items[0]};
        if(!defined($cont)) {
          $results{$items[0]} = 1;
        } else {
          $cont++;
          $results{$items[0]} = $cont;
        }
      }
    }
  }
  print "Despues del 2do foreach\n";

  foreach my $result (keys %results) {
    print "$result : $results{$result}\n";
  }
}

sub kindSearch {
  # Recibe como parametro al arreglo de items y el kind
  my $itemsRef = $_[1];
  my @items = @$itemsRef;
  my $kind = $_[0];
  
  if($kind eq "name") {
    return $items[0];
  }
  if($kind eq "license") {
    return $items[1];
  }
  if($kind eq "department") {
    return $items[2];
  }
  if($kind eq "denomination") {
    return $items[3];
  }
}

sub readHeader {
  my $line = $_[0];
  # La expresion regular captura un flujo de caracteres hasta encontrar el "|". 
  my $count = 1;
  while($line =~ /^([^\|]+)\|(.+)/) {
    # Una vez que se encuentra "|" la cadena se separa en dos partes
    # print "$1\n"; 
    $count++;
    # Actualizamos $line para que la subcadena se vuelva a analizar
    $line = $2;
  }
  # Como para la ultima $line no se encontrara "|", el while para y no se 
  # imprime el ultimo item
  # print "$line\n";
  return $count;
}

sub generateRegExp {
  my $n = $_[0];
  my $exp = "^";
  # Generamos la expresion regular que divide en n grupos a la linea analizada
  for(my $i = 0; $i < $n - 1; $i++) {
    $exp .= '([^\|]+)\|';
  }
  $exp .= "([^\|]+)";
  return $exp;
}

