# Make a word frequency counter
sub doBigram
{
	while(<MYINPUTFILE>) { 
		chop; 
		tr/A-Z/a-z/; 
		tr/.,:;!?"(){}//d; 
		foreach $word1 (split) { 
		$bigram = "$word2 $word1";
		$word2 = $word1; 
		$bigramcount{$bigram}++; 
		}
	}
	@bigramArr=sort numerically keys %bigramcount;
}


sub numerically { # compare two words numerically 
	$bigramcount{$b} <=> $bigramcount{$a}; # decreasing order 
	# $count{$b} <=> $count{$a}; # increasing order
}
