#!/usr/bin/perl -w

use strict;

while (<>) { 
    chomp;
    $_ =~ s/^\s+|//g;
    my (undef, undef, $mode) = split(/\s+/, $_);
    my $vmode = $mode;
    $vmode =~ s/`//g;
    printf("%s: videoMode_reg <= VIDEO_%s;\n", $mode, uc($vmode));
}
