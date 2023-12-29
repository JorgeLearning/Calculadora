#!/usr/bin/perl
use warnings;
use strict;
use CGI;

my $q = CGI->new;
my $operation = $q->param("expression");


sub operate {
  # Eliminamos los espacios en blanco
  my $expression = $_[0];
  $expression =~ s/\s//g;

  # Validamos la expresión
  if(!verify($expression)) {
    return "Expresion no valida\n";
  }

  return "Expresion valida\n";
}

sub verify {
  my $expression = $_[0];
  if($expression =~ /^[0-9+\-\(\s]+[0-9\s\)]$/) { 
    return 1;  
  }
}

print $q->header("text/html");
print operate($operation)."\n";

