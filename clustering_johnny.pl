#!/usr/bin/perl

############################################################
##                                                        ##
##        clustering_johnny.pl                            ##
##                     Produced by Johnny S. Ferreira     ##
##                     Last Modified on 05/03/2023        ##
##                                                        ##
############################################################

=comment
  gives all the clusters, including the ones that are composed of only one
=cut


use strict;
use warnings;

my $threshold = 500000; # minimum distance between adjacent genes to form a cluster
my $prev_end = 0; # variable to keep track of the end of the previous gene
my $cluster_count = 0; # variable to keep track of the number of clusters
my @genes; # array to hold genes in each cluster

my $spe = $ARGV[0];

open(FILE,"$spe.orthodraw_in2") || die "cannot open $spe.orthodraw_in2: $!";
while (<FILE>) {
    chomp;
    my ($start, $end, $direction, $type, $r, $g, $be, $name) = split(/\t/);
    #print "$start and $end\n";
    #155355428 and 155356316
    #155367976 and 155368908
    #155406389 and 155407327

    my $distance = $start - $prev_end - 1; # calculate distance between current gene and previous gene
    #print "$distance\n";
    $prev_end = $end; # update previous gene end position

    if ($distance < $threshold && $cluster_count > 0) {
        push @genes, $name; # add gene to current cluster
    }
    else {
        if ($cluster_count > 0) {
            # print genes in previous cluster
            print "Cluster $cluster_count: " . join(", ", @genes) . "\n";
        }
        $cluster_count++; # increment cluster count
        @genes = ($name); # start new cluster with current gene
    }

    $prev_end = $end; # update previous gene end position

}

# print genes in last cluster
print "Cluster $cluster_count: " . join(", ", @genes) . "\n";
print "Number of clusters: $cluster_count\n";

=comment
my $distance = $start - $prev_end - 1; # calculate distance between current gene and previous gene

    if ($distance < $threshold && $cluster_count > 0) {
        push @genes, $name; # add gene to current cluster
    }
    else {
        if ($cluster_count > 0) {
            # print genes in previous cluster
            print "Cluster $cluster_count: " . join(", ", @genes) . "\n";
        }
        $cluster_count++; # increment cluster count
        @genes = ($name); # start new cluster with current gene
    }

    $prev_end = $end; # update previous gene end position


cut

# print genes in last cluster
print "Cluster $cluster_count: " . join(", ", @genes) . "\n";
print "Number of clusters: $cluster_count\n";
