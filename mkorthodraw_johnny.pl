#!/usr/bin/perl -w
use File::Basename;

############################################################
##                                                        ##
##        mkorthodraw_johnny.pl                           ##
##                     Produced by Johnny S. Ferreira     ##
##                     Last Modified on 17/08/2022        ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
 	print "\n$0  SPECIES_NAME  DIRECTORY\n";
  print "This program takes a .genelist and create a .orthodraw_in file format for orthodrawOR.pl\n",
	print "\n";
	print "The following files are necessary at DIRECTORY:\n";
	print "\$spe.besthit, \$spe.func.idlist \$spe.pseudogenes.idlist\n \$spe.truncated.idlist";
	print "\n";
	print "This program generates the following files:\n";
	print "\$spe.genelist\n";
	print "\n";
	exit;
}
=comment
Esse programa pega um .genelist com a última coluna sendo o OGG e devolve um output com o formato de input
do orthodrawOR.pl

=cut


$directory = $ARGV[1];
@files = glob("*.genelist"); # get all fasta files the comprehends the OGGs;

foreach $file (@files)
{
	open(FILE, $file) || die "cannot open $spe.genelist: $!";
	$title = basename($file, ".genelist");
	print "$title\n";

	open(OUT,">$title.orthodraw_in2");
	while(<FILE>)
	{
		chomp;
		@fld = split;
		print "@fld\n";
		$init = $fld[4];
		$end = $fld[5];
		$direction = $fld[7];
		$type = $fld[3];
		$ogg = $fld[10];

		#printf OUT "$init $end $direction 0.000 0.796 1.000 $ogg\n";
	}
	
	close(FILE);
}


=comment

open(OUT,">$spe.orthodraw_in2");
	while(<FILE>)
	{
		chomp;
		@fld = split;
		print "@fld\n";
		$init = $fld[4];
		$end = $fld[5];
		$direction = $fld[7];
		$type = $fld[3];
		$ogg = $fld[10];

		open(LATEX, "$directory/RGBcolors_OGGs.txt");
		while(<LATEX>)
		{
			chomp;
			@fld2 = split;
			#print "@fld2[3]\n";
			$ogg_name = $fld2[0];
			$R = $fld2[1];
			$G = $fld2[2];
			$B = $fld2[3];

			if ($ogg eq $ogg_name)
			{
				printf OUT "$init $end $direction $R $G $B $ogg\n";
			}
		}


		#printf OUT "$init $end $direction 0.000 0.796 1.000 $ogg\n";
	}
