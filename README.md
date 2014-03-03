HappyOrSad
==========

Sentiment Analysis of a file (if text inside file contains happy or sad mood?)
The same code is the working for determining your twitter mood at:<br>
http://mytwitmood.tutafuta.com/

## Requirements ##
* perl

## How to use ##

* To run this perl script all you have to do is:<p>
  $perl happyorsad.pl &lt;file name&gt;<p>
  it would print output in following format:<p>
  This text is so Happy!<br>
  Happy:	82.56% :-)<br>
  Sad:	17.44% :-(<br>

## Dictionary taken from ##
Created my own dictionary for bigram analysis also used LIWC2007 dictionary from this source<br>
https://code.google.com/p/negotiations-ling773/source/browse/trunk/resources/LIWC2007.dic?r=2

## Cite me ##
<b>In case you use this project please cite me using this citation:</b><br>
Puneet Singh, et al. "Architecture for Automated Tagging and Clustering of Song Files According to Mood." International Journal of Computer Science Issues (IJCSI) 7.4 (2010).

## References ##
Pennebaker, J.W., Francis, M.E., & Booth, R.J. (2001). Linguistic Inquiry and Word Count: LIWC2001. Mahwah, NJ: Erlbaum Publishers (www.erlbaum.com).
