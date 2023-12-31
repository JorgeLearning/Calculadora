#!/usr/bin/perl
use warnings;
use strict;
use CGI;

my $q = CGI->new;
my $operation = $q->param("expression");
$operation =~ s/%2B/+/g;  # Sustituir %2B por +
$operation =~ s/%2F/\//g;  # Sustituir %2F por /

# Eliminamos los espacios en blanco
$operation =~ s/\s//g;

# Validamos la expresión
if(!validateOverall($operation) && !validateOperators($operation)) {
  return "Expresion no valida\n";
}

sub operate {
  my $expression = $_[0];

  # Aplicamos recurrencia para los parentesis
  while ($expression =~ /\(([^()]+)\)/) {
    my $subexpression = $1;
    my $resultSubexpression = operate($subexpression);
    $expression =~ s/\Q($subexpression)/$resultSubexpression/;
    print "$expression\n";
  }

  # Resolvemos primero divisiones
  while ($expression =~ /(-?\d+(\.\d+)?)([\/])(-?\d+(\.\d+)?)/) {
    my ($left, $operator, $right) = ($1, $3, $4);
    print "$left\n$operator\n$right\n";
    my $result = $left / $right;
    my $subtitution = sprintf("%s%s%s", $left, $operator, $right);
    $expression =~ s/\Q$subtitution/$result/;
    print "$expression\n";
  }

  # Resolver multiplicaciones
  while ($expression =~ /(-?\d+(\.\d+)?)([*])(-?\d+(\.\d+)?)/) {
    my ($left, $operator, $right) = ($1, $3, $4);
    my $result = $left * $right;
    my $subtitution = sprintf("%s%s%s", $left, $operator, $right);
    $expression =~ s/\Q$subtitution/$result/;
  }

  # Resolver sumas y restas
  my $finalResult = eval $expression;
  return $finalResult;
}

sub validateOverall {
  my $expression = $_[0];
  if(($expression =~ /^[0-9+\-\*\/\(\.)]+$/) && ($expression =~ /^[0-9-\(]/) && ($expression =~ /[0-9\)]$/)) {
    return 1;  
  }
  return 0;
}

sub validateOperators {
  my $expression = $_[0];
  my @segments = $expression =~ /(\d+|[+\-*\/]+)/g; 
  foreach my $segment (@segments) {
    if($segment =~ /\D/) {
      if(length($segment) <= 2) {
        if($segment =~ /^[+\-]/ && length($segment) != 1) { 
          return 0;
        } 
        if(length($segment) == 2 && substr($segment, 1, 1) ne "-") {
          return 0; 
        }
      } else {
        return 0;
      }
    } 
  }
  return 1;
}

print $q->header("text/html; charset=UTF-8");
print "\n".operate($operation)."\n";
