#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SIZE 1000

//int main(int argc, char *argv[]) {
int main(void)
{
	double y_current = 0,y_prev=0;
	double input = 0;
	int output = 0;

	for(int i=1;i<SIZE;i++)
	{
		input = 0.5-(sin(2*M_PI*i/SIZE)/2);
		y_current = input - output + y_prev;
		(y_current > 0) ? (output = 1): (output = 0);
		y_prev = y_current;
		printf("%d : %+d\n",i,output);
	}

    return 0;
}