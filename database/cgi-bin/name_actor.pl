#!/usr/bin/perl
use strict;
use warnings;
use DBI;

# Establenciendo el IP del servidor
my $ip_address = qx(hostname -I);
chomp($ip_address);
$ip_address =~ s/\s//g;

# Conectarnos a la base de datos
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=$ip_address";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

# Realizamos una insercion
my $id = 5;
my $sth = $dbh->prepare("SELECT * FROM Actor WHERE ActorID=?");
$sth->execute($id);
while(my @row = $sth->fetchrow_array) {
  print "@row\n";
}
$sth->finish;
$dbh->disconnect;
