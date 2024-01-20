#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use strict;
use warnings;
use CGI;
use DBI;
use CGI::Session;
use CGI::Carp qw(fatalsToBrowser);
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("passw");
utf8::decode($password);

# Validamos las cadenas y despues los credenciales del usuario
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/ && userValidate($dni, $password)) {
  my @date = dates($dni);
  my $session = CGI::Session->new();
  my $sessionId = $session->id;

  $session->param('userName', $date[0]);
  $session->param('userSurname1', $date[1]);
  $session->param('userSurname2', $date[2]);

  print "userName: ", $session->param('userName'), "\n";
  print "userSurname1: ", $session->param('userSurname1'), "\n";
  print "userSurname2: ", $session->param('userSurname2'), "\n";
  
  $session->flush;
  print "Set-Cookie: sessionId=$sessionId; path=/\n";
  print $q->redirect('aulaVirtual-priv.pl');
} else {
  print $q->redirect('../login.html');
}


#Subrutina que comprueba el usuario y la contraseña
sub userValidate {
  my $dni = $_[0];
  my $password = $_[1];
  my $dbh = connectDb();
  
  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT dni, password FROM users WHERE dni = ?");
  $sth->execute($dni);

  # Comprobamos los credenciales
  if (my $dniRow = $sth->fetchrow_hashref) {
    if ($password eq $dniRow->{password}) {
      return 1;
    }
  }
  return 0;
}

# Subrutina que extrae informacion del usuario
sub dates {
  my $dni = $_[0];
  my $dbh = connectDb();

  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT dni, nombre, apellido1, apellido2 FROM alumno WHERE dni = ?");
  $sth->execute($dni);

  # Obetenemos informacion
  my $dniRow = $sth->fetchrow_hashref;
  my @arr = ($dniRow->{nombre}, $dniRow->{apellido1}, $dniRow->{apellido1});
  return @arr;
}

# Subrutina que hace la conexion a la base de datos
sub connectDb {
  my $user = "pweb1";
  my $password = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.102";
  my $dbh = DBI->connect($dsn, $user, $password) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}
