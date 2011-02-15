{
criterio[$1]++
}
END {
for (i in criterio)
{
	printf("%s:%d,",i,criterio[i])
}
}
