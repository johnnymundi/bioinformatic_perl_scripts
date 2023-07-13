#!/usr/bin/perl

############################################################
##                                                        ##
##        clustering2_johnny.pl                            ##
##                     Produced by Johnny S. Ferreira     ##
##                     Last Modified on 05/03/2023        ##
##                                                        ##
############################################################

=comment
  gives all the big clusters, excluding the singletons and give the length of the cluster, as well
=cut




use strict;
use warnings;

my $min_dist = 500000;
my $prev_chr = "";
my $prev_pos = "";
my $cluster_start = "";
my $cluster_end = "";
my $num_clusters = 0;

my @cluster;
my $spe = $ARGV[0];

open(FILE,"$spe.orthodraw_in2") || die "cannot open $spe.orthodraw_in2: $!";

while (<FILE>) {
    chomp;
    my ($start, $end, $direction, $type, $r, $g, $be, $name) = split(/\t/);
    if ($start - $prev_pos - 1 < $min_dist) {
        $prev_pos = $end;
        $cluster_end = $end;
    } else {
        if ($cluster_end - $cluster_start + 1 >= $min_dist) {
            print "Cluster $num_clusters ($prev_chr:$cluster_start-$cluster_end):\n";
            print "$_\n" for (@cluster);
            print "Cluster length: " . ($cluster_end - $cluster_start + 1) . " bp\n\n";
            $num_clusters++;
        }
        $prev_pos = $end;
        $cluster_start = $start;
        $cluster_end = $end;
        @cluster = ();
    }
    push(@cluster, $_);
}

# print the last cluster if it meets the distance criteria
if ($cluster_end - $cluster_start + 1 >= $min_dist) {
    print "Cluster $num_clusters ($prev_chr:$cluster_start-$cluster_end):\n";
    print "$_\n" for (@cluster);
    print "Cluster length: " . ($cluster_end - $cluster_start + 1) . " bp\n";
}
print "Number of clusters found: $num_clusters\n";
