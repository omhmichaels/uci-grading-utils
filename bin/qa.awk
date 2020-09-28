BEGIN{
FS="\n";
#OFS="\n-----\n";
#RS=""
#print "Question\tquestionORanswer\tquestionORanswer\tquestionORanswery";
}


{
	print "-" $1"\n\n";
	#print "ITEM 2: \n" $2  "\n-----\n\n";
	#print "ITEM 3: \n" $3  "\n-----\n\n";
	#print "ITEM 4: \n" $4  "\n-----\n\n";
	# print "-----------------------------\n"
}

END {
	#print NR,"Records Processed";
}