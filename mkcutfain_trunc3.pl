#!/usr/bin/perl -w

############################################################
##                                                        ##
##        MKCUTFAIN_TRUNC3.PL                             ##
##                         Produced by Niimura            ##
##                         Last Modified on '11.3.14      ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
        print "\nThis program makes a 'cutfasta.pl' input file.\n";
	print "$0  SPECIES_NAME\n\n";
	print "#The first Met position is adjusted.\n";
	print "#\$spe.preTM1 muct be in this directory.\n";
	print "#\$spe.cutfain_trunc3 & \$spe.adjustM will be created.\n\n";
	exit;
}

$spe = $ARGV[0];
open(FILE,"$spe.preTM1") || die "cannot open $spe.preTM1: $!";
open(OUT,">$spe.cutfain_trunc3");
open(OUT2,">$spe.adjustM");
while(<FILE>)
{
	@fld = split;
	if ($fld[0] =~ /HsOR/)
	{
		next;
	}
	$fld[0] =~ /^(.+)_(\d+)_(\d+)([+-])P_no([NC]+)$/;
	$chr  = $1;
	$init = $2;
	$fin  = $3;
	$dir  = $4;
	$NC   = $5;
	$len1 = $fld[1];
	if ($fld[1] < 35)
	{
		$len2 = $fld[1];
	}
	elsif ($fld[$#fld] >= 35)
	{
		$len2 = $fld[$#fld];
	}
	else
	{
		for ($i = 2; $i <= $#fld; $i++)
		{
			if ($fld[$i] < 35 && $fld[$i] > 20)
			{
				$len2 = $fld[$i];
				last;
			}
			elsif ($fld[$i] <= 20)
			{
				$len2 = $fld[$i-1];
				last;
			}
		}	
	}
	if ($len1 != $len2)
	{
		printf OUT2 "%-30s %3d %3d\n",$fld[0],$len1,$len2;
	}
		

	if ($dir eq "+")
	{
		$newinit = $init + ($len1 - $len2) * 3;
		$newfin  = $fin;
	}
	else
	{
		$newinit = $init;
		$newfin  = $fin - ($len1 - $len2) * 3;
	}
	$newname = "${chr}_${newinit}_${newfin}${dir}P_no$NC";
	printf OUT "%-20s %-40s %s 1 %9d  %9d\n", $chr, $newname, $dir, $newinit, $newfin;
}
