use strict;
use warnings;
use utf8;

my $HOME = $ENV{"HOME"};

my $options = "";
foreach my $arg (@ARGV) {
    if (! -d $arg) {
        next;
    }
    my @files = glob("$arg/*");
    @files = map { if ( /\/([^\/]+)\Z/ ){ $1; } else { $_; } } @files;
    foreach my $f (@files) {
        $options .= " -v $arg/$f:$HOME/.ssh/$f";
    }
}

print($options);

