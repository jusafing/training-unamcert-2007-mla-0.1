BEGIN{FS=":"}
{
	suma=suma+$2
}
END{
printf ("%d",suma)
}
