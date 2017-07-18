#/usr/bin/perl -w
use strict;

my (@seq1,@seq2,$seq1,$seq2,$count_snp,$i,$len,$PIC);
my ($j,$k,@nseq1,@nseq2,$count_indel);

open (FH, "$ARGV[0]") or die;
open (FH1, "$ARGV[1]") or die;
open (OUT, ">$ARGV[0].$ARGV[1].PIC.txt") or die;

$seq1="";
while (<FH>) {
	chomp;
	if (/^>/) {
	}else{
		$seq1=$seq1.$_;
	}
}

$seq2="";
while (<FH1>) {
	chomp;
	if (/^>/) {
	}else{
		$seq2=$seq2.$_;
	}
}

$PIC=&SNP_gbq+&Indel_gbq;
print OUT "Length\t"."SNP\t"."Indel\t"."PIC\n";
print OUT "$len\t".&SNP_gbq."\t".&Indel_gbq."\t"."$PIC\n";

close FH;
close FH1;
close OUT;

sub SNP_gbq {
	@seq1 = split ("",$seq1);
	@seq2 = split ("",$seq2);
	$count_snp = 0;
	$len = @seq1;
	for ($i=0;$i<$len;$i++) {
		if ($seq1[$i] ne "-" and $seq2[$i] ne "-" and $seq1[$i] ne $seq2[$i]) {
			$count_snp ++;
		}
	}
	$count_snp;
}

sub Indel_gbq {
	@seq1 = split ("",$seq1);
	@seq2 = split ("",$seq2);
	$count_indel = 0;
	$len = @seq1;
	$i=0;
	$j=0;
	while ($i<$len) {
		if ($seq1[$i] eq "-" and $seq2[$i] eq "-") {
			$i ++;
		}else{
			$nseq1[$j]=$seq1[$i];
			$nseq2[$j]=$seq2[$i];
			$j++;$i++
		}
	}
	for ($k=0;$k<=$j;$k++) {
		if ($nseq1[$k] ne "-" and $nseq1[$k+1] eq "-") {
			$count_indel ++;
		}
	}
	for ($k=0;$k<=$j;$k++) {
		if ($nseq2[$k] ne "-" and $nseq2[$k+1] eq "-") {
			$count_indel ++;
		}
	}
	$count_indel;
}
