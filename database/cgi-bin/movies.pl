#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

my $q = CGI->new;
print $q->header("text/html", "charset=UTF-8");
print<<HTML;
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <title>Resultado Universidades</title>
</head>
<body>
  <h2>Actriz</h2>
  <table border="1">
    <tr>
      <th>Title</th>
      <th>Year</th>
    </tr>
HTML

# Estableciendo el IP del servidor
my $ip_address = qx(hostname -I);
chomp($ip_address);
$ip_address =~ s/\s//g;

# Conectarnos a la base de datos
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=$ip_address";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

# Realizamos una insercion
my $year = 1985;
my $sth = $dbh->prepare("SELECT Title, Year FROM Movie WHERE Year=?");
$sth->execute($year);
while(my @row = $sth->fetchrow_array) {
  print "<tr><td>$row[0]</td>\n<td>$row[1]</td></tr>\n";
}
$sth->finish;
$dbh->disconnect;

print "</table></body></html>\n";
