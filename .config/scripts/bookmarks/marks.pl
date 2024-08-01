#!/usr/bin/env perl

use strict;
use warnings;
use feature "say";

my $bookmarks_file =
  $ENV{"BOOKMARKS_FILE"} || $ENV{'HOME'} . "/.local/share/bookmarks/data";

sub open_bmarks {
    open my $fh, shift, $bookmarks_file
      or die "ur bookmarks file sucks: " . $!;
    $fh;
}

sub del {
    my $cmd = join " ", map { "-e ${_}d" } @_;
    exec "sed -i $cmd $bookmarks_file";
}

sub get_tags ($) {
    chomp;
    my ( $url, $tags ) = split /\t/;
    if ( defined $tags ) {
        return split /,/, $tags;
    }
    ();
}

sub get {
    my @req_tags = @_;
    my $fh       = open_bmarks "<";
    my $i        = 1;
    foreach (<$fh>) {
        my $show = 1;
        my @tags = get_tags $_;
        if ( scalar @tags ) {
            my %lookup = map { $_ => undef } @tags;
            for my $tag (@req_tags) {
                unless ( exists $lookup{$tag} ) {
                    $show = 0;
                    last;
                }
            }
        }
        elsif ( scalar @req_tags ) {
            $show = 0;
        }
        say "$_\t$i" if $show;
        $i++;
    }
}

sub add {
    my ( $url, @tags ) = @_;
    my $fh = open_bmarks ">>";
    say $fh join "\t", $url, join ',', @tags;
}

sub tags {
    my $fh = open_bmarks "<";
    my %tags;
    for (<$fh>) {
        for my $tag ( get_tags $_) {
            $tags{$tag} = undef;
        }
    }
    say for ( sort keys %tags );
}

my $cmd = shift
  or die "No command specified";
my %hash = (
    get  => \&get,
    del  => \&del,
    add  => \&add,
    tags => \&tags
);

$hash{$cmd}->(@ARGV);
