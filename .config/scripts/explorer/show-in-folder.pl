#!/usr/bin/env perl

# yay -S perl-net-dbus

use strict;
use warnings;
use feature qw(signatures);

package FileManager1;

use base qw(Net::DBus::Object);
use Net::DBus::Exporter qw(org.freedesktop.FileManager1);

sub new ( $class, $service ) {
  my $self = $class->SUPER::new( $service, "/org/freedesktop/FileManager1" );
  bless $self, $class;
}

sub ShowItems ( $self, $items, $startup_id ) {
  local ($\, $,) = ("\n", " ");
  system("alacritty", "-e", "$ENV{HOME}/.config/scripts/explorer/spawn-explorer-and-focus-file.sh",
  # system( "show-in-folder",
    map { s@^file://@@; s/\+/ /g; s/%([0-9a-fA-F]{2})/chr hex $1/ge; $_ }
      @$items );
}
dbus_method( "ShowItems", [ [qw(array string)], "string" ] );

1;

package main;

use Net::DBus;
use Net::DBus::Reactor;

my $bus    = Net::DBus->find;
my $sv     = $bus->export_service("org.freedesktop.FileManager1");
my $object = FileManager1->new($sv);
Net::DBus::Reactor->main->run();
