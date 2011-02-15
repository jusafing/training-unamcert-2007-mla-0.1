*********************************************************************************
***                   UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO                 ***
***            DIRECCION GENERAL DE SERVICIOS DE COMPUTO ACADEMICO	      ***
***		       DEPARTAMENTO DE SEGURIDAD EN COMPUTO                   ***
***	           		     UNAM-CERT			   	      ***
*********************************************************************************

*********************************************************************************
***	           PROYECTO FINAL DEL CURSO PROGRAMACION EN SHELL 	      ***
***                ANALIZADOR DE BITACORAS DE CORREO ELECTRONICO	      ***
***			   MAIL LOG ANALIZER V 1.0(MLA)			      ***
*********************************************************************************

------
INDICE

1.- Introduccion
2.- Requisitos del sistema
3.- Modulos de la Herramienta MLA
4.- Explicacion de Uso
5.- Consideraciones de USO y Limitaciones
6.- Creditos
7.- Corrida de Ejemplo




-----------------
1.- INTRODUCCION

El proyecto final del curso de Programacion de Shell del programa de Becarios de
Seguridad en Computo, consiste en una herramienta capaz de analizar y procesar 
bitacoras de correo electronico.
La herramienta desarrollada Mail Log Analizer (MLA) en su version 1.0, permite obtener
reportes con informacion sobre aspectos de seguridad y estadisticos tales como:

1.- Numero de correos Recibidos
2.- Numero de correos escaneados por el antivirus
3.- Numero de correos con algun tipo de Malware
4.- Numero de correos escaneados por el ANTISPAM
5.- Numero de correos detectados como SPAM
6.- Promedio de calificacion de correo SPAM
7.- Promedio de Calificacion de correo NO SPAM
8.- Nombre y cantidad de incidencias de criterios de SPAM

La herramienta  tiene un uso sencillo, tanto la instalacion como su uso. El  archivo  de
datos que genera cumple con los requisitos del Proyecto, es decir, extrae la informacion
y la separa por campos (los antes mencionados) organizandolos por periodos para cada 
hora del dia.

--------------------------
2.- REQUISITOS DEL SISTEMA

La herramienta MLA ha sido desarrollada en lenguaje de programacion de SHELL, tanto  Bash
como C shell. Por esto los requisitos para la ejecucion de la herramienta son:

- Bash o Bourne Shell
- C shell




---------------------------------
3.- MODULOS DE LA HERRAMIENTA MLA

La herramienta MLA esta conformada por dos modulos generales cada uno de ellos dependiente
de varios archivos con script de shell y de awk.

La estructura general de la Herramienta es la que sigue:

 -----------
 INSTALACION

 instalar
 |------ mla_calendar
 |	| ------ calendar

 ---------
 OPERACION
 
 load
 |
 |------ inicia	
 |	|------- logs_ordena.csh
 |	|------- mla
 |	|	|------- hits_busca.csh
 |	|	|	|------- hits_promedio_SI.awk
 |	|	|	|------- hits_promedio_NO.awk
 |	|	|------- criterios_busca.csh
 |	|	|	|------- criterios_ordena.awk
 |	|	|	|------- criterios_cuenta.awk
 |----- reportes_inicia
 |	|------ reportes_mla
 |	|	|------- reportes_suma.awk
 |	|	|------- reportes_promedio.awk
 |	|	|------- reportes_ord_spam.awk
 |	|	|------- reportes_cuenta_spam.awk

 El funcionamiento interno de la herramienta es el que sigue:

 Instalacion
 (instalar) : Recibe como entrada los directorios de instalacion de la herramienta.
 	      Verifica los permisos y efectua la copia de los archivos necesarios para el 
	      funcionamiento de la mismo.

 Operacion
 (load):      Modulo maestro el cual recibe los argumentos de entrada de la herramienta.
 	      Este es el que  ejecuta  el modo de operacion de la herramienta  segun los
	      argumentos ingresados (Procesamiento de bitacoras o Reportes).

	      Basicamente el contenido de  este script  evalua los argumentos ingresados,
	      es decir, facilita  que el usuario no tenga  que ingresar los argumentos en
	      un  ORDEN  ESPECIFICO. Con  esto  la  herramienta  funcionara correctamente 
	      siempre y cuando los argumentos sean valido; en  caso  de error se mostrara
	      un mensaje de ERROR. Por ejemplo:
	      ./load -p		---	Inicia procesamiento de bitacoras
	      ./load -r		--- 	Genera Reporte General
		
	      Ejemplos y explicacion con mayor detalles en Seccion 4 (Explicacion de Uso)

(inicio):     Modulo que ejecuta el procesamiento de la bitacoras de correo electronico.
	      El procedimiento que se sigue para la generacion del archivo de datos es el
	      siguiente:
	      1.- Lee el todos los archivos del directorio de bitacoras, segun la fecha de 
	          la  primer linea de cada uno, decide cual se procesara  primero. Una vez 
		  teniendo el orden, separa los sucesos de cada archivo para cada hora del
		  dia (0 Hrs-23 Hrs) y crea un archivo temporal para cada hora (horax.tmp)
		  dentro del directorio tmp/ en el directorio de instalacion de MLA.
	      2.- Una vez generados los archivos para cada hora, los verifica ciclicamente
	          para obtener posibles registros para dias diferentes, es decir, primero
		  se dividio por hora, despues, si existen registros para una misma hora X
		  en  un dia  A  y en un dia B, divide la hora X para dia A y B, generando
		  otros  archivos  temporales  segun  los  dias  diferentes  en  esa  hora 
		  (horaXdiaA.tmp, horaXdiaB.tmp, etc...)
	      3.- Terminado esto ya se tienen divididos por hora y por dia los registros 
	      	  sin procesar, por lo que ahora solo se ejecuta el script mla sobre cada
		  uno de estos archivos. Este script generara un archivo de salida (.out)
		  de cada archivo temporal generado, de los cuales se tomaran cada una de
		  las lineas que se agregaran al archivo final de datos de salida.

(reportes_inicio)
	      Modulo  que  genera  los reportes personalizados basandose  en el archivo de
	      datos generado en la fase de procesamiento de las bitacoras. La finalidad de
	      este modulo es de separar del archivo de datos de procesamiento de bitacoras
	      solo las lineas en donde se tenga coincidencia con los  criterios ingresados
	      como argumentos de fechas de inicio, final y nombre de archivo de salida  de
	      los reportes. Esto lo hace mediante el numero de mes y aplicando filtros.
	      Una vez que ha generado un archivo con las lineas especificas de fechas , se
	      ejecuta sobre este archivo el script reportes_mla, que da como resultado la
	      generacion del archivo del reporte. El funcionamiento interno del script se 
	      basa en el uso de awk para el manejo de cada uno de los campos de las lineas
	      del archivo de datos, al que basicamente solo se obtienen sumas y promedios.


(mladirs.conf)
	      Este  es  el archivo  de configuracion que se crea mediante el proceso de la
	      instalacion de la herramienta . Este archivo contiene las rutas absolutas de
	      los directorios de trabajo ( bitacoras , reportes , datos , etc) y los demas
	      modulos  de  la  herramienta se basan en este archivo para colocar tanto los
	      archivos temporales como los archivos de salida de datos.

	      Se puede modificar manualmente para cambiar los directorios  de  trabajo una
	      vez que se ha instalado la herramienta, sin embargo se debe tener cuidado de
	      asignar directorios con los permisos  de  lectura y escritura adecuados para 
	      que el funcionamiento de la herramienta sea el correcto.

	      El contenido del archivo contiene el seguiente formato:
	      ------------------------------
		dir_trabajo=ruta_directorio
	      ------------------------------

	      En cuanto a las lineas de opciones de calendarizacion:
	      freq=0	Indica que se configura ejecucion cada hora . Cuando freq esta con
	      		este valor, los campos de "hora" y "mins" no tienen ningun efecto.
	      freq=1 	Indica que se configura ejecucion diaria a la hora indicada en los
	      		campos "hora" y "mins". Cuando freq este con este valor, deben ser
			completados los campos de "hora" y "mins" o de lo contrario podria
			haber funcionamientos inesperados de la herramienta.
	      
	      En una instalacion default el contenido de mladirs.conf es la siguiente:

	      ----------------------------------------------------------------------------
	      #DIRECTORIO DE BITACORAS
	      logs=HOME_DEL_USUARIO/mla/logs
	      #DIRECTORIO DE REPORTES
	      reportes=HOME_DEL_USUARIO/mla/reportes
	      #DIRECTORIO DE DATOS
	      datos=HOME_DEL_USUARIO/mla/datos
	      #DIRECTORIO DE INSTALACION
	      mla=HOME_DEL_USUARIO/mla
	      #FRECUENCIA DE EJECUCION DE LA HERRAMIENTA
	      freq=1
	      hora=12
	      mins=00	      
	      ----------------------------------------------------------------------------





----------------------
4.- EXPLICACION DE USO

INSTALACION:
Para la instalacion de la Herramienta se siguen los siguientes pasos:
	- Desempaquetar el archivo mla_1.0.tar.gz
		$ tar -zxvf mla_1.0.tar.gz
	- Ejecutar el script de instalacion (instalar)
		$ ./instalar
          El programa de instalacion solicitara 5 entradas de datos:
	  	- Directorio de ubicacion de las bitacoras
			Directorio  donde  se localizaran los archivos de bitacoras que se
			van a procesar con la herramienta.
		  IMPORTANTE : Es esta primera version se debe especificar a un	directorio
		  	dedicado a los archivos  de  bitacoras, es decir, un directorio el 
			cual solo debera contener dichos archivos que se van a procesar.
			La herramienta  funcionara  correctamente siempre y cuando en este
			directorio no se encuentren archivos con formatos diferentes a los
			archivos de bitacoras. Si no se especifica ningun  directorio, por
			default se toma ($/mla/logs).
		- Directorio de Reportes
			Directorio el cual contendra todos los archivos de salida para los
			Reportes de las bitacoras procesadas. La herramienta verificara si
			se tienen los permisos adecuados para lectura y escritura. Si no 
			se especifica ningun directorio, se toma default (~/mla/reportes).
		- Directorio de Datos
			Directorio el cual contendra el archivo general de datos de salida
			de las bitacoras procesadas. De este archivo se basa la generacion
			de los reportes. Tambien contendra un archivo de log que tendra la
			hora de inicio y termino de cada ejecucion de la herramienta. Si
			no se especifica ningun directorio se toma default (~/mla/datos).
		- Directorio de Instalacion
			Directorio en el que se copiaran todos los archivos necesarios por
			la herramienta para su funcionamiento. Si no se especifica ningun
			directorio se toma default (~/mla)
		- Opcion de Calendarizacion de la Herramienta
			Se podra optar la calendarizacion de la herramienta en dos modos:
			- Ejecucion cada hora
			- Ejecucion diaria a una hora determinada
			El  programa  de  instalacion  generara un archivo para ejecutarlo 
			como cron.

OPERACION

	Una vez instalada la herramienta, se podra ejecutar en sus dos modos de operacion
	mediante "load" . Las opciones disponibles para load son:
	-p : Procesamiento de bitacoras
	-r : Generacion de Reportes
	   [ -fi mm/dd ] : Especifica la fecha de inicio para los Reportes
	   [ -ff mm/dd ] : Especifica la fecha de termino para los Reportes
	   [ -o  nombre] : Especifica el nombre del archivo de salida para los Reportes
	   		   Si no se especifica ninguno se toma el default Reporte.dat
	
	El diseño de la herramienta permite ingresar argumentos sin un orden especifico. 
	MLA automaticamente tomara los argumentos y verificara si son validos. Esto es 
	importante ya que el usuario no se debe preocupar por ingresar primero la fecha
	inicial seguida de la fecha final, etc, solo antecedera al argumento la opcion.
	Solo se debe cumplir que el archivo de salida se indique al final.
	Ejemplo, para obtener un reporte del 28 de Junio al 1 de Julio  se puede hacer
	de las siguientes formas:
		$ ./load -r -fi 6/28 -ff 7/1 -o junio28-julio1
		$ ./load -r -ff 07/01 -fi 06/28 -o junio28-julio1
		$ ./load -r -ff 7/1 -fi 6/28 -o junio28-julio1
	
	Otros ejemplos para la generacion de Reportes son:

		$ ./load -r
			Reporte general de todo el archivo de datos
		$ ./load -r -o ReporteGeneral
			Reporte general pero se le especifica el nombre ReporteGeneral
		$ ./load -r -fi 7/1 -o julio-fin
			Reporte a partir de Jul 1 hasta la ultima fecha en el archivo
		$ ./load -r -ff 11/2 -o ini-nov2
			Reporte a partir de la fecha inicial del archivo hasta Nov 2
		$ ./load -r -fi 7/2 -ff 5/3
			Devolveria un error ya que la fecha inicial debe ser anterior
			a la fecha final
		



------------------------------------------------------------
5.- CONSIDERACION DE USO Y LIMITACIONES PARA LA VERSION 1.0

Para esta version se tienen las siguientes consideraciones importantes y limitaciones
para el buen funcionamiento de la herramienta

- En  el momento de instalacion, asegurarse  de que el directorio de bitacoras sea un 
  directorio  dedicado  a  las  bitacoras  que se procesaran. No importa el numero de 
  bitacoras a procesar, el proceso ciclico de la herramienta se encargara  de ordenar
  y procesar todas,sin embargo, si en el directorio existen otros archivos que posean
  un  formato  diferente al de las bitacoras, se podrian tener resultados inesperados
  en el funcionamiento  de  la herramienta. Esto se debe a una parte en el codigo que
  se  basa  en  el listado  del contenido de directorio, y que en una posible version 
  futura se corregira.
- En la fase de procesamiento de las bitacoras , en el dado caso de que para una hora
  determinada no existan registros coincidentes , la  herramienta mostrara un mensaje
  de error de awk , sin embargo NO AFECTA en nada los resultados del archivo de datos
  procesados , es simplemente  una omision de los mensajes de error dentro del codigo
  que en una posible version futura se corregira.
- Para ver el log de la ejecucion en el caso de la calendarizacion , puede visualizar
  el archivo MailDir en el Home del usuario




------------
6.- CREDITOS

Desarrollado por:

DGSCA - UNAM
DSC / UNAM-CERT
Plan de Becarios de Seguridad en Computo

Javier Ulises Santillan Arenas
bec_jsantillan@correo.seguridad.unam.mx
jusafing@gmail.com

Fecha: 16/07/07





-----------------------------------------
7.- CORRIDA DE EJEMPLO (OPCIONES DEFAULT)

Para visualizar ejemplos de corrida ejemplos, puede revisar los archivos dentro del
directorio Ejemplos/ dentro del directorio de instalacion de MLA.
