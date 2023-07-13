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
open(OUT,">$spe.genelist");
open(FILE,"$directory/$spe.besthit") || die "cannot open $spe.besthit: $!";
$F = $P = 1;
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
	open(FILE2,"$directory/$spe.func.idlist") || die "Cannot open $directory/$spe.func.idlist: $!";
	while(<FILE2>)
	{
		/^${spe}_(.+)_(\d+)_(\d+)([+-])/;
		$chr2  = $1;
		$init2 = $2;
		$fin2  = $3;
		$dir2  = $4;
		if ($chr eq $chr2 && abs($init - $init2) < 300 && abs($fin - $fin2) < 300 && $dir eq $dir2)
		{
			printf OUT "%4d %4d    -  %-22s F  %9d  %9d  %4d  %s  %-10s  %-12s\n",
				$F+$P-1, $F, $chr2, $init2, $fin2, ($fin2-$init2+1)/3, $dir2, $e, $query;
			$flag2 = 1;
			$F++;
			last;
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




	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.alpha.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.alpha.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.alpha.total.genelist ;
	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.beta.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.beta.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.beta.total.genelist ;
	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.delta.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.delta.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.delta.total.genelist ;
	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.epsilon.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.epsilon.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.epsilon.total.genelist ;
	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.eta.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.eta.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.eta.total.genelist ;
	cat GCA_019512145.1_UCB_Epus_1.0_genomic2.gamma.genelist GCA_019512145.1_UCB_Epus_1.0_genomic2.gamma.pseudogenes.genelist > GCA_019512145.1_UCB_Epus_1.0_genomic2.gamma.total.genelist ;



	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.alpha.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.alpha.unligned.func2.fasta ;
	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.beta.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.beta.unligned.func2.fasta ;
	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.gamma.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.gamma.unligned.func2.fasta ;
	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.delta.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.delta.unligned.func2.fasta ;
	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.epsilon.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.epsilon.unligned.func2.fasta ;
	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.eta.func2.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.eta.unligned.func2.fasta ;


	*** MEME ***

	awk '{ if ($0 !~ /^>/) { gsub("-", "",$0); } print $0; }' GCA_019447015.1_UCB_Hboe_1.0_genomic2.func.fasta > GCA_019447015.1_UCB_Hboe_1.0_genomic2.unligned.func.fasta ;
=cut
