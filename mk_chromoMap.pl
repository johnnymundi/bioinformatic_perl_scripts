#!/usr/bin/perl -w

############################################################
##                                                        ##
##      chromosomedrawOR.pl                               ##
##                       Produced by JohNNy S. Ferreira   ##
##                       Last Modified on 30/01/2023      ##
##                                                        ##
############################################################


$spe = $ARGV[0];
$directory = $ARGV[1];
@files = glob("*.genelist"); # get all fasta files the comprehends the OGGs;


foreach $file(@files)
{
  $file =~ /$spe\.([a-z12]+)\.total.genelist/;
	$group_name = "${1}";
	print "$group_name\n";
	#print "$file\n";
	open(OUT, ">$spe.$group_name.chromoMap.txt");
	open(FILE, $file);
	{
		$i = 0;
		while(<FILE>)
		{
		chomp;
		@fld = split;
		#print "$fld[3]\n";
		$i++;
		$name = "$group_name$i";
		$contig = $fld[3];
		$init = $fld[5];
		$end = $fld[6];
		$direction = "$fld[4]$fld[8]";
		$color;
		if ($group_name eq "gamma" && $fld[4] eq "F") {
			$color = "#000099";
		} elsif ($group_name eq "gamma" && $fld[4] eq "P") {
			$color = "#0000FF";
		} elsif ($group_name eq "alpha" && $fld[4] eq "F") {
			$color = "#009900";
		} elsif ($group_name eq "alpha" && $fld[4] eq "P") {
			$color = "#00FF00";
		} elsif ($group_name eq "beta" && $fld[4] eq "F") {
			$color = "#FF33FF";
		} elsif ($group_name eq "beta" && $fld[4] eq "P") {
			$color = "#FFCCFF";
		} elsif ($group_name eq "delta" && $fld[4] eq "F") {
			$color = "#FF8000";
		} elsif ($group_name eq "delta" && $fld[4] eq "P") {
			$color = "#FFB266";
		} elsif ($group_name eq "epsilon" && $fld[4] eq "F") {
			$color = "#660066";
		} elsif ($group_name eq "epsilon" && $fld[4] eq "P") {
			$color = "#CC00CC";
		} elsif ($group_name eq "eta" && $fld[4] eq "F") {
			$color = "#00CCCC";
		} elsif ($group_name eq "eta" && $fld[4] eq "P") {
			$color = "#33FFFF";
		} elsif ($fld[4] eq "T") {
			$color = "#FFF000";
		}

		printf OUT "$name$fld[8]\t$contig\t$init\t$end\t$group_name$fld[4]\n";
		
		#print "$direction\n";

		}
	}
}

=comment
cat GCA_019447015.1_UCB_Hboe_1.0_genomic2.alpha.chromoMap.txt GCA_019447015.1_UCB_Hboe_1.0_genomic2.beta.chromoMap.txt GCA_019447015.1_UCB_Hboe_1.0_genomic2.gamma.chromoMap.txt GCA_019447015.1_UCB_Hboe_1.0_genomic2.delta.chromoMap.txt GCA_019447015.1_UCB_Hboe_1.0_genomic2.epsilon.chromoMap.txt GCA_019447015.1_UCB_Hboe_1.0_genomic2.eta.chromoMap.txt > Hboettgeri_ORs_chromoMap.txt


=cut