#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAXLEN 200
#define EXTRA  5
// Fichero de salida
#define DATAFILE "/home/dit/registro.txt"

// Funcion para convertir caracteres no alfanumericos dentro de codigo HTML.
void descodifica(char *cini, char *cfin, char *dest);

int main() {
	char *lenstr;
	char input[MAXLEN+EXTRA+1];
	char data[MAXLEN+1];
	long len;
	FILE *fout; // Out stream

	// Obtenemos la longitud de la peticion POST:
	lenstr = getenv("CONTENT_LENGTH");

	if(lenstr == NULL || sscanf(lenstr,"%ld",&len)!=1 || len > MAXLEN+EXTRA)
		printf("<p>Error en la invocacion: revise el formulario.</p>");
	else{
		fgets(input, len+1, stdin);
		//Obtenemos el mensaje descodificado a partir de "data="...
		descodifica(input+EXTRA, input+len, data);

		fout = fopen(DATAFILE, "a");
		if(fout == NULL)
			printf("<p>No ha sido posible almacenar los datos.</p>");

		else {

			time_t timer;
			char fecha_hora[MAXLEN];
			struct tm* tm_info;

			time(&timer);
			tm_info = localtime(&timer);

			strftime(fecha_hora, sizeof(fecha_hora), "%Y-%m-%d %H:%M:%S", tm_info);
			fprintf(fout, "%s > %s\n", fecha_hora, data);
			fclose(fout);
		}
	}
}

void descodifica(char *cini, char *cfin, char *dest) {

	unsigned int cod;
	for(; cini < cfin; cini++, dest++) {
		if(*cini == '+')
			*dest = ' ';
		else if(*cini == '%') {
			if(sscanf(cini+1, "%2x", &cod) != 1)
				cod = '?';

			*dest = cod;
			cini +=2;
		} else
			*dest = *cini;
	}

	*dest = '\0';
}
