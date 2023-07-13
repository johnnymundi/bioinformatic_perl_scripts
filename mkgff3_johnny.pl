#!/usr/bin/perl -w

############################################################
##                                                        ##
##        MKGFF3_JOHNNY.PL                                ##
##                     Produced by Johnny S. Ferreira     ##
##                     Last Modified on 10/0/72023        ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
 	print "\n$0  SPECIES_NAME  DIRECTORY\n";
	print "\n";
	print "The following files are necessary at DIRECTORY:\n";
	print "\$spe.\$group_namelist.txt, \$spe.\$group_name.genelist";
	print "\n";
	print "This program generates the following files:\n";
	print "\$spe.\$group_name.gff of each \$group_name and a cat of everything in \$pe.func.fasta and \$spe.func.gff\n";
	print "\n";
	exit;
}
=comment
This program generates a .gff of each group using a .genelist file and a .list.txt file

=cut

my $spe = $ARGV[0];
my $directory = $ARGV[1];
@files = <$spe.*.list.txt>;


foreach $file (@files)
{
  $file =~ /$spe\.([a-z12]+)\.list.txt/;
	$group_name = "${1}";
  #print "$group_name\n";
  #print "$file\n";

	open(OUT,">$spe.$group_name.gff");
  open(FILE, $file) || die "cannot open $spe.$group_name.list.txt: $!";
  while(<FILE>)
	{
		chomp;
		@fld = split;
		#print "$fld[3]\n";
		$seq_name = $fld[0];
		$gene_name = $fld[1];
		$length = $fld[2];
		$aa = $fld[3];

		open(FILE2,"$spe.$group_name.genelist") || die "cannot open $spe.$group_name.genelist: $!";
		while(<FILE2>)
		{
			chomp;
			@fld2 = split;
			#print "$fld2[8]\n";
			$start = $fld2[5];
			$end = $fld2[6];
			$direction = $fld2[8];
			printf OUT "$seq_name\t.\tgene\t$start\t$end\t.\t$direction\t.\tID=$seq_name;Name=$gene_name $length $aa\n";
			last;


			#"$seq_name\t.\tgene\t$start\t$end\t.\t$direction\tID=$seqname;Name=$gene_name\n";
			#last;
		}

	}
}

# cat of the results in the order: alpha, beta, delta, epsilon, eta, gamma
`cat $spe.alpha.func2.fasta $spe.beta.func2.fasta $spe.delta.func2.fasta $spe.epsilon.func2.fasta $spe.eta.func2.fasta $spe.gamma.func2.fasta > $spe.func.fasta;`;

`cat $spe.alpha.gff $spe.beta.gff $spe.delta.gff $spe.epsilon.gff $spe.eta.gff $spe.gamma.gff > $spe.func.gff;`;
