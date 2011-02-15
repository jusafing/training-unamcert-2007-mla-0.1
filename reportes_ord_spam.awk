BEGIN{FS=","}
{
for (i=1;i<NF;i++)
{
	printf("%s\n",$i)
}
}

#criterio[$1]=criterio[$1]+criterio[$2]
#}
#END {
#for (i in criterio)
#{
#	printf("%s:%d\n",i,criterio[i])
#}
#}
