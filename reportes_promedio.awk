BEGIN{FS=":"}
{
	suma=suma+$2
}
END{
printf ("%.2f",suma/NR)
}
