#include <stdio.h>
#include <stdlib.h>

int main() {
	char hola[3] = "34s";
	double x = atof(hola);
	printf("-- %s -- %g --\n", hola, x);

	return 0;
}
