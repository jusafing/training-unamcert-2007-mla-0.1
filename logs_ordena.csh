#!/bin/csh

set dir_mla = $1
set dir_logs = `cat $dir_mla/mladirs.conf | grep "logs=" | awk 'BEGIN {FS="="} {print $2}' `

echo "Ejecutando logs_ordena.csh ....."

if ( -e $dir_mla/tmp/logs.log ) then
        rm $dir_mla/tmp/logs.log
endif

foreach log (`ls $dir_logs`)
	set fecha = `head -1 $dir_logs/$log | awk '{print $1,$2,$3}' `
	echo "$fecha $dir_logs/$log" >> $dir_mla/tmp/logs.log
end

cat $dir_mla/tmp/logs.log | sort -M > $dir_mla/tmp/logs_ord.log
set archivo = `cat $dir_mla/tmp/logs_ord.log | awk '{print $4}'`

foreach log ( $archivo )
	echo " "
	echo "Creando bitacoras de archivo $log"
	foreach i (`seq 0 23`)
		echo -n "Creando bitacoras para Hora $i $dir_mla/tmp/logs/hora$i.tmp ..... "
		if ($i < 10) then
			cat $log | grep 0$i':..:...correo' >> $dir_mla/tmp/logs/hora_$i.tmp
		else
			cat $log | grep $i':..:...correo' >> $dir_mla/tmp/logs/hora_$i.tmp
		endif
		echo "OK"
	end
end
