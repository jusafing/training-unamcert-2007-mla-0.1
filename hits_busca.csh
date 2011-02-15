#!/bin/csh

set dir_mla = $argv[3]
grep SPAM $argv[1] | grep $argv[2] | awk '{print $6}' | uniq > $dir_mla/tmp/ids.log

if ( -e $dir_mla/tmp/hits_ids.log ) then
	rm $dir_mla/tmp/hits_ids.log
endif
foreach id (`cat $dir_mla/tmp/ids.log`)
	set hits=`grep $id $argv[1] | grep SPAM | grep -o hits.....| uniq`
	echo "$id $hits" >> $dir_mla/tmp/hits_ids.log
end
if ( "$argv[2]" == "Yes" ) then
	awk '{print $2}' $dir_mla/tmp/hits_ids.log | awk -f $dir_mla/hits_promedio_SI.awk
else
	awk '{print $2}' $dir_mla/tmp/hits_ids.log | awk -f $dir_mla/hits_promedio_NO.awk
endif
