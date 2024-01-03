#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $text = CGI->new;

my $wordA = $text->param("allWords");
$wordA =~ s/\s+/+/g; 

my $wordE = $text->param("exactWords");
$wordE =~ s/\s+/+/g;

my $wordN = $text->param("noneWords");
$wordN =~ s/\s+/+/g; 

print $text->redirect("https://www.google.com/search?as_q=$wordA&as_epq=$wordE&as_eq=$wordN");
