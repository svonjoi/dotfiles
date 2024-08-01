#!/usr/bin/env perl
use strict;
use warnings;

open my $in, "-|", "acpi_listen";
while (<$in>) {
    if (/HEADPHONE unplug/) {
        system "playerctl --all-players pause";
        system `notify-send "playerctl --all-players pause"`;
    }
}
