#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use warnings;
use strict;
use CGI;
use CGI::Session;
use DBI;

my $q = CGI->new;
my $sessionId = $q->cookie('sessionId');

if(defined $sessionId) {
  print $q->header(-type => 'text/html', -charset => 'UTF-8');
  print "$sessionId\n";
  my $session = CGI::Session->load($sessionId);

  my $name = $session->param("userName");
  my $surname1 = $session->param("userSurname1");
  my $surname2 = $session->param("userSurname2");

  # print $q->header(-type => 'text/html', -charset => 'UTF-8');
  print "<h1> Hola $name $surname1 $surname2 </h1>";
} else {
  print $q->header(-type => 'text/html', -charset => 'UTF-8');
  print "<h1> No se encontro la sesion :C </h1>";
}
