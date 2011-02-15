BEGIN{FS="="}
{
	suma=suma+$2
}
END{
printf ("Promedio Cal. NO SPAM: %.2f",suma/NR)
}
