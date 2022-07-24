use strict;
use warnings;
use utf8;

my @mount_points = ();
my $exclude_flag = undef;
foreach my $arg (@ARGV) {
    if ($arg eq "-v") {
        $exclude_flag = 1;
        next;
    }
    if ($arg eq "." || $arg eq "..") {
        next;
    }
    if ($arg !~ /\A\//) {
        $arg = $ENV{"HOME"} . "/" . $arg;
    }
    if ($exclude_flag) {
        my @mount_points2 = ();
        foreach my $m (@mount_points) {
            if ($m ne $arg) {
                push(@mount_points2, $m);
            }
        }
        @mount_points = (@mount_points2);
        next;
    }
    if (grep {$_ eq $arg} @mount_points) {
        next;
    }
    push(@mount_points, $arg);
}

my $options = "";
foreach my $mount_point (@mount_points) {
    $options .= " -v $mount_point:$mount_point";
}

print($options);

