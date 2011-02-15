#!/bin/csh

set dir_mla = $argv[2]

grep SPAM $argv[1] | grep Yes | awk '{print $6}' | uniq > $dir_mla/tmp/ids.log

if ( -e $dir_mla/tmp/criterios_ids.log ) then
	rm $dir_mla/tmp/criterios_ids.log
endif
foreach id (`cat $dir_mla/tmp/ids.log`)
	set criterios_tmp=`grep "$id" $argv[1] | grep SPAM-TAG | grep -o test.\* `
	set criterios=`echo "$criterios_tmp" | awk 'BEGIN{FS="="} {print $2}'`
	echo "$id =$criterios" >> $dir_mla/tmp/criterios_ids.log
end
awk 'BEGIN{FS="="} {print $2}' $dir_mla/tmp/criterios_ids.log | awk -f $dir_mla/criterios_ordena.awk | awk -f $dir_mla/criterios_cuenta.awk
