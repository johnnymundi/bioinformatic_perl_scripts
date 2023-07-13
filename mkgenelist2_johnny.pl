#!/usr/bin/perl -w

############################################################
##                                                        ##
##        MKGENELIST_JOHNNY.PL                            ##
##                     Produced by Johnny S. Ferreira     ##
##                     Last Modified on 17/08/2022        ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
 	print "\n$0  SPECIES_NAME  DIRECTORY\n";
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
Esse programa gera um .genelist geral contendo intactos, pseudogenes e truncados identificados por suas respectivas letras, F, P e T

pra pegar o genelist de intactos:
trocar por:
open(FILE2,"$directory/$spe.func.idlist") 
printf OUT "%4d %4d    -  %-22s F  %9d  %9d  %4d  %s  %-10s  %-12s\n", 


pra pegar o genelist de pseudogenes:
trocar por:
open(FILE2,"$directory/$spe.pseudogenes.idlist") 
printf OUT "%4d %4d    -  %-22s P  %9d  %9d  %4d  %s  %-10s  %-12s\n", 


pra pegar o genelist de truncados:
trocar por:
open(FILE2,"$directory/$spe.truncated.idlist") 
printf OUT "%4d %4d    -  %-22s T  %9d  %9d  %4d  %s  %-10s  %-12s\n", 

=cut

$spe = $ARGV[0];
$directory = $ARGV[1];
@files = <$spe.*.Tcand2.fasta>;

foreach $file (@files)
{
	$file =~ /$spe\.([a-z12]+)\.Tcand2.fasta/;
	$group_name = "${1}";
	print "$group_name\n";
	open(OUT,">$spe.$group_name.trunc.genelist");
	open(FILE,"$directory/$spe.besthit") || die "cannot open $spe.besthit: $!";
	while(<FILE>)
	{
		chomp;
		@fld = split;
		$query = $fld[0];
		$chr   = $fld[3];
		$init  = $fld[4];
		$fin   = $fld[6];
		$dir   = $fld[7];
		$e     = $fld[13];


		$flag2 = 0;
		open(FILE2,"$directory/$spe.$group_name.trunc.idlist") || die "Cannot open $directory/$spe.$group_name.idlist: $!";
		while(<FILE2>)
		{
			/^${spe}_(.+)_(\d+)_(\d+)([+-])/;
			$chr2  = $1;
			#print "$chr2\n";
			$init2 = $2;
			$fin2  = $3;
			$dir2  = $4;
			if ($chr eq $chr2 && abs($init - $init2) < 400 && abs($fin - $fin2) < 400 && $dir eq $dir2) 
			{
				printf OUT "%4d %4d    -  %-22s T  %9d  %9d  %4d  %s  %-10s  %-12s\n",
					$F+$P-1, $F, $chr2, $init2, $fin2, ($fin2-$init2+1)/3, $dir2, $e, $query;
				$flag2 = 1;
				$F++;
				last;
			} 
		}
	}
}

close(FILE);

=comment
Essa parte ia dpois do while em cima do FILE2, mas não é necessária
if ($flag2 == 0)
	{
		printf OUT "%4d    - %4d  %-22s P  %9d  %9d  %4d  %s  %-10s  %-12s\n", 
			$F+$P-1, $P, $chr, $init, $fin, ($fin-$init+1)/3, $dir, $e, $query;
		$P++;
	}

	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.alpha.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.alpha.total2.genelist;
	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.beta.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.beta.total2.genelist;
	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.delta.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.delta.total2.genelist;
	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.epsilon.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.epsilon.total2.genelist;
	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.eta.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.eta.total2.genelist;
	sort -k4 GCA_019512145.1_UCB_Epus_1.0_genomic2.gamma.total.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.gamma.total2.genelist;


	awk '$4 == "CM033641.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033642.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033643.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033644.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033645.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033646.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033647.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033648.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033649.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033650.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;
	awk '$4 == "CM033651.1" {print}' GCA_019512145.1_UCB_Epus_1.0_genomic2.genelist | wc;

=cut
