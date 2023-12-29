#!/usr/bin/perl
use warnings;
use strict;
use CGI;

my $q = CGI->new;
my $operation = $q->param("operation");

print $q->header("text/html");
print $operation;
