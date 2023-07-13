#!/usr/bin/perl -w

############################################################
##                                                        ##
##        MKCUTFAIN_TRUNC2.PL                             ##
##                         Produced by Niimura            ##
##                         Last Modified on '11.3.14      ##
##                                                        ##
############################################################

if ($#ARGV < 0)
{
        print "\nThis program makes a 'cutfasta.pl' input file to extract a sequence from the first Met to stop.\n";
	print "$0  SPECIES_NAME\n\n";
	print "#Simply getting the first Met in cases of noC (not adjust)\n";
	print "#\$spe.besthit, \$spe.len, \$spe.frag2 must be in this directory.\n";
	print "#\$spe.cutfain will be created.\n\n";
	exit;
}

$spe = $ARGV[0];
open(FILE,"$spe.trunc_seq.fa") || die "cannot open $spe.trunc_seq.fa: $!";
open(OUT, ">$spe.cutfain_trunc2");
open(OUT2,">$spe.no_trunc.idlist");
open(OUT3,">$spe.wierd.dat");

while(<FILE>)
{
	chomp;
	@fld = split;
#print ">>$_<<\n";
	if ($fld[0] =~ /^>(.+)/)
	{
		if ($. > 1)
		{
			out();
		}
		$name = $1;
		$seq = "";
	}
	else
	{
		$seq .= $_;
	}
}
if ($. > 0)
{
	out();
}
close(FILE);

sub out
{
#print "name = $name\n";
	$extend = 100;
	$name =~ /^(.+)_(\d+)_(\d+)([+-])P_no([NC]+)$/;
	$contig = $1;
	$init = $2;
	$fin  = $3;
	$dir  = $4;
	$NC   = $5;
	$len = length($seq);
	$flag = 0;
#print "len=$len\n";
#print "init=$init fin=$fin\n";
	if ($NC eq "N")
	{
		$stoppos = index($seq, "*", $len - $extend);
#print "stoppos=$stoppos\n";
		if ($stoppos == -1)
		{
			print OUT3 "No * in $name!!\n";
			$newinit = $init;
			$newfin  = $fin;
		}
		elsif ($dir eq "+")
		{
			$newinit = $init;
			$newfin  = $init + $stoppos * 3 + 2;
		}
		else
		{
			$newinit = $fin - $stoppos * 3 - 2;
			$newfin  = $fin;
		}
	}
	elsif ($NC eq "C")
	{
		$stoppos = rindex($seq, "*", $extend);
		$Mpos = index($seq, "M", $stoppos);
		if ($stoppos == -1)
		{
			print OUT3 "No * in $name!!\n";
			$newinit = $init;
			$newfin  = $fin;
		}
		elsif ($Mpos == -1)
		{
			print OUT3 "No Met in $name!!\n";
			print OUT2 "$name\n";
			$flag = 1;	#Not be output in *.cutfain_trunc2
		}
		elsif ($dir eq "+")
		{
			$newinit = $init + $Mpos * 3;
			$newfin  = $fin;
		}
		else
		{
			$newinit = $init;
			$newfin  = $fin - $Mpos * 3;
		}
	}
	elsif ($NC eq "NC")
	{
		$stoppos = index($seq, "*");
#print "stoppos=$stoppos\n";
		if ($stoppos == -1)
		{
			$newinit = $init;
			$newfin  = $fin;
		}
		elsif ($stoppos < 30)
		{
			print OUT2 "$name\n";
			$flag = 1;	#Not be output in *.cutfain_trunc2	
		}
		else
		{
			print OUT3 "$name may be noN (not noNC)\n";
			if ($dir eq "+")
			{
				$newinit = $init;
				$newfin  = $init + $stoppos * 3 + 2;
			}
			else
			{
				$newinit = $fin - $stoppos * 3 - 2;
				$newfin  = $fin;
			}
		}
	}
	$newname = "${contig}_${newinit}_${newfin}${dir}P_no$NC";
#print "newname=$newname\n\n";
	if ($flag == 0)
	{
		printf OUT "%-20s %-40s %s 1 %9d  %9d\n", $contig, $newname, $dir, $newinit, $newfin;
	}
}
