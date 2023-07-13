#!/usr/bin/perl -w
use File::Basename;

############################################################
##                                                        ##
##        genelist.pl                                     ##
##                         Produced by JohNNy             ##
##                         Last Modified on 12/10/2022    ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
 	print "\n$0  This program creats a .genelist of each OGG\n";
	print "\n";
	print "The following files are necessary at DIRECTORY:\n";
	print "\$OGG_name.fasta\n";
	print "\n";
	print "This program generates the following files:\n";
	print "\$OGG_name.genelist\n";
	print "\n";
	exit;
}

$dir = $ARGV[0];

@files = glob("*.fasta");

foreach $file (@files) {
	print "$file\n" if -f $file;
	open(FILE, $file) or die "could not open $file: $!\n";
	open(OUT, ">$file.genelist");
	while(<FILE>) {
		chomp;
		@fld = split;
		#print "$fld[0]\n";
		if ($fld[0] =~ /^>(.+)/)
		{
			print "$fld[0]\n";
			$name = substr($fld[0], 1);
			#print "$name\n";

			if ($fld[0] =~ /Xtro/) {
				print OUT "$name\n";
			} elsif ($fld[0] =~ /Xborealis/)
			{
				print OUT "$name	Xbre\n";
			} else
			{
				print OUT "$name	Xle\n";
			}
		}
	}
	close($file);
}

=comment
$query = $fld[0];
	$chr   = $fld[3];
	$init  = $fld[4];
	$fin   = $fld[6];
	$dir   = $fld[7];
	$e     = $fld[13];

	$flag2 = 0;
	open(FILE2,"$directory/$spe.func.idlist") || die "Cannot open $directory/$spe.func.idlist: $!";
	while(<FILE2>)
	{
		/^${spe}_(.+)_(\d+)_(\d+)([+-])/;
		$chr2  = $1;
		$init2 = $2;
		$fin2  = $3;
		$dir2  = $4;
		if ($chr eq $chr2 && abs($init - $init2) < 600 && abs($fin - $fin2) < 600 && $dir eq $dir2) 
		{
			printf OUT "%4d %4d    -  %-22s F  %9d  %9d  %4d  %s  %-10s  %-12s\n", 
				$F+$P-1, $F, $chr2, $init2, $fin2, ($fin2-$init2+1)/3, $dir2, $e, $query;
			$flag2 = 1;
			$F++;
			last;
		}
	}
	if ($flag2 == 0)
	{
		printf OUT "%4d    - %4d  %-22s P  %9d  %9d  %4d  %s  %-10s  %-12s\n", 
			$F+$P-1, $P, $chr, $init, $fin, ($fin-$init+1)/3, $dir, $e, $query;
		$P++;
	}
  =cut