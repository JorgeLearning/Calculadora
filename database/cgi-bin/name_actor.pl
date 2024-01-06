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
my $sth = $dbh->prepare("INSERT INTO Actor(ActorID, Name) VALUES (?,?)");
$sth->execute(5, "Speed Racer");
$sth->finish;
print "Insercion terminada.\n";

# Nos desconectamos del SGBD
$dbh->disconnect;
