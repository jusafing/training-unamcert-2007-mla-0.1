BEGIN{FS=":"}
{
criterio[$1]=criterio[$1]+$2
}
END {
for (i in criterio)
{
	printf("\t>> %s ............ %d\n",i,criterio[i])
}
}
