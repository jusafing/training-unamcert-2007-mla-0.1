BEGIN{FS="="}
{
	suma=suma+$2
}
END{
printf ("Promedio Cal. SI SPAM: %.2f",suma/NR)
}
