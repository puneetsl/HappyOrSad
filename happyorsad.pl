#!/usr/bin/perl
###############################################################################
# Author: Puneet Singh 
# Script to know if your text's mood is Happy or Sad
###############################################################################
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################
# prints out a list of frequencies and words of an arbitrary text file
#
# I know the code sucks! as there are so many levels of indentations
# I promise to update this in future, clean it and make it faster
###############################################################################
open(MYINPUTFILE, "<@ARGV[0]");
open(MYDB, "<./database.db");
open(EMODB, "<./emotions.db");
@dbcontent = <MYDB>;
@emodbcontent=<EMODB>;
$/ = ""; # paragraph mode on
$i=0;
do "./bigram.pl";
doBigram();
foreach $enter(@bigramArr){
	$enter=~/([a-zA-Z0-9]*) ([a-zA-Z0-9]*)/;
	$first=$1;
	$second=$2;
	foreach $line(@dbcontent) { 
		if($line=~/^[a-zA-Z]/)
		{
			if (($line=~/^$first\*\s/)||($line=~/^$first\s/))
			{
				$numbers=$line;
				$foundWords=$line;
				$numbers=~s/[a-zA-Z\*]*//;#at the end do not have to print word
				$foundWords=~s/[0-9].*//;
				$foundWords=~s/[\s]*//;
				$foundWords=~s/[\s\*(]//;
				@number1=split(/\s/,$numbers);
			}
		}
	}		
	foreach $line(@dbcontent) { 
		if($line=~/^[a-zA-Z]/)
		{
			if (($line=~/^$second\*\s/)||($line=~/^$second\s/))
			{
				$numbers=$line;
				$foundWords=$line;
				$numbers=~s/[a-zA-Z\*]*//;#at the end do not have to print word
				$foundWords=~s/[0-9].*//;
				$foundWords=~s/[\s]*//;
				$foundWords=~s/[\s\*(]//;
				@number2=split(/\s/,$numbers);
			}
		}
	}

	foreach $nu1(@number1)
	{
		foreach $nu2(@number2)
		{
			foreach $line(@emodbcontent)
			{	
				if($line=~/([0-9+\-]*) ([0-9+\-]*) ([0-9+\-]*) ([0-9+\-]*)/)
				{
					if(($1==$nu1 and $2==$nu2)or($1==$nu2 and $2==$nu1))
					{
						if($3>=0 and $4>=0)
						{
							#I know, I know, 6 level of indentation. WTF! :P
							@q1[0]=@q1[0]+$3;
							@q1[1]=@q1[1]+$4;
							$qw1++;
						}
						if($3<0 and $4<0)
						{
							@q3[0]=@q3[0]+$3;
							@q3[1]=@q3[1]+$4;
							$qw3++;
						}
						if($3>=0 and $4<0)
						{
							@q4[0]=@q4[0]+$3;
							@q4[1]=@q4[1]+$4;
							$qw4++;
						}
						if($3<0 and $4>=0)
						{
							@q2[0]=@q2[0]+$3;
							@q2[1]=@q2[1]+$4;
							$qw2++;
						}
					}
					elsif($1==0 and ($2==$nu1 or $2==$nu2))
					{
						if($3>=0 and $4>=0)
						{
							@q1[0]=@q1[0]+$3;
							@q1[1]=@q1[1]+$4;
							$qw1++;
						}
						if($3<0 and $4<0)
						{
							@q3[0]=@q3[0]+$3;
							@q3[1]=@q3[1]+$4;
							$qw3++;
						}
						if($3>=0 and $4<0)
						{
							@q4[0]=@q4[0]+$3;
							@q4[1]=@q4[1]+$4;
							$qw4++;
						}
						if($3<0 and $4>=0)
						{
							@q2[0]=@q2[0]+$3;
							@q2[1]=@q2[1]+$4;
							$qw2++;
						}
					}
				}
			}
		}
	}
	$i=$i+1;
}
$all=(@q1[0]+@q4[0])-(@q2[0]+@q3[0]);
if($all != 0)
{
	$happy = (@q1[0]+@q4[0])*100/$all;
	$sad =((@q2[0]+@q3[0])*-1)*100/$all;
	if($happy>$sad)	
	{
		print "This text is so Happy!\n"
	}
	elsif($happy<$sad)	
	{
		print "This text is so Sad!\n"
	}
	else
	{
		"Not sure if this is Happy or Sad :-( :-)\n";
	}

	printf "Happy:\t%.2f% :-)\nSad:\t%.2f% :-(\n",(@q1[0]+@q4[0])*100/$all,((@q2[0]+@q3[0])*-1)*100/$all;
}
else
{
	printf "Not sure if this is Happy or Sad :-( :-)";
}