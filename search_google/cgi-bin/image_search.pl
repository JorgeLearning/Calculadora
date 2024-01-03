#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $text = CGI->new;

my $word = $text->param("search");
$word =~ s/\s+/+/g;

print $text->redirect("https://images.google.com/images?q=$word");

