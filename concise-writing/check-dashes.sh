#!/usr/bin/env bash
# Flag long dashes in text — the loudest AI fingerprint in prose.
#
# Usage:
#   check-dashes.sh FILE          # check a file
#   check-dashes.sh               # check stdin
#   echo "text" | check-dashes.sh
#
# Exit 0 = clean. Exit 1 = at least one long dash found (with line:col report).
#
# Flags: em dash (—), en dash (–), horizontal bar (―), figure dash (‒),
# two-/three-em dashes, and the ASCII tell `--` / `---`.
# A single hyphen between word characters (well-known) is NOT flagged.
set -euo pipefail

if [[ $# -gt 0 && "$1" != "-" && "$1" != "--stdin" ]]; then
  src="$1"
  exec < "$1"
else
  src="<stdin>"
fi

perl -CSD -e '
  my $src = shift;
  my %label = (
    "\x{2014}" => "em dash (\x{2014})",
    "\x{2013}" => "en dash (\x{2013})",
    "\x{2015}" => "horizontal bar (\x{2015})",
    "\x{2012}" => "figure dash (\x{2012})",
    "\x{2E3A}" => "two-em dash (\x{2E3A})",
    "\x{2E3B}" => "three-em dash (\x{2E3B})",
  );
  my @hits;
  my $n = 0;
  while (my $line = <STDIN>) {
    $n++;
    chomp $line;
    while ($line =~ /([\x{2014}\x{2013}\x{2015}\x{2012}\x{2E3A}\x{2E3B}])/g) {
      push @hits, [$n, pos($line), $label{$1}, $line];
    }
    while ($line =~ /(-{2,})/g) {
      push @hits, [$n, pos($line) - length($1) + 1, "ASCII dash ($1)", $line];
    }
  }
  if (!@hits) { print "clean: no long dashes found\n"; exit 0; }
  printf STDERR "FAIL: %d long dash(es) in %s\n", scalar(@hits), $src;
  for my $h (@hits) {
    printf STDERR "  %d:%d  %s  | %s\n", @$h;
  }
  print STDERR "\nReplace with a comma, period, colon, parentheses, or nothing.\n";
  exit 1;
' "$src"
