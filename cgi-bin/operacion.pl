#!/usr/bin/perl
use warnings;
use strict;
use CGI;

my $q = CGI->new;
my $operation = $q->param("expression");
$operation =~ s/%2B/+/g;  # Sustituir %2B por +
$operation =~ s/%2F/\//g;  # Sustituir %2F por /

sub operate {
  # Eliminamos los espacios en blanco
  my $expression = $_[0];
  print "$expression\n";
  $expression =~ s/\s//g;

  # Validamos la expresión
  if(!validateOverall($expression)) {
    return "Expresion no valida\n";
  }

  validateOperators($expression);

  return "Expresion valida\n";
}

sub validateOverall {
  my $expression = $_[0];
  if(($expression =~ /^[0-9+\-\*\/\(\)]+$/) && ($expression =~ /^[0-9-\(]/) && ($expression =~ /[0-9\)]$/)) {
    return 1;  
  }
}

sub validateOperators {
  my $expression = $_[0];
  print "$expression\n\n";
  my @segments = $expression =~ /(\d+|[+\-*\/]+)/g; 
  foreach my $segment (@segments) {
    print "$segment\n";
  }
}

print $q->header("text/html; charset=UTF-8");
print "\n".operate($operation)."\n";
