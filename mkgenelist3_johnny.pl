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
open(OUT,">$spe.genelist2");
open(FILE,"$directory/$spe.test.genelist") || die "cannot open $spe.genelist: $!";
$F = $P = 1;
while(<FILE>)
{
	chomp;
	@fld = split;
  #print "@fld\n";
  $n1 = $fld[0];
  $n2 = $fld[1];
  $contig = $fld[3];
  $type = $fld[4];
  $init = $fld[5];
  $end = $fld[6];
  $size = $fld[7];
  $direction = $fld[8];
  $evalue = $fld[9];
  $query = $fld[10];
  if ($type eq "P")
  {
    #print "caiu aqui\n";
    #print "$type\n";
    $name = "${spe}_${contig}_${init}_${end}${direction}pseudogene";
    #print "$name\n";
  } else
  {
    $name = "${spe}_${contig}_${init}_${end}${direction}";
  }
  #print "$type\n";

  open(FILE2,"$directory/Xenopus_OGGs_14_12_2022All_organized.txt") || die "cannot open $spe.genelist: $!";
  while(<FILE2>)
  {
    chomp;
    /^${spe}_(.+)_(\d+)_(\d+)([+-])/;
    @fld2 = split;
    #print "$fld2[0]\n";
    $name2 = $fld2[0];
    if ($type eq "T")
    {
      $name2 = substr($fld2[0], 0, -3);
      #print "$name2\n";
    } else {
      $name2 = $fld2[0];
    }

    if ($name eq $name2)
    {
      #print "é igual";
      #print "$name\n";
      printf OUT "$n1\t$n2\t$contig\t$type\t$init\t$end\t$size\t$direction\t$evalue\t$query\t$fld2[1]\n";
    }
    
    
  }

	
	
}
close(FILE);

=comment

	open(FILE2,"$directory/$spe.alpha.func.idlist") || die "Cannot open $directory/$spe.func.idlist: $!";
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

=cut