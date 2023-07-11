#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SIZE 1000000
#define LTSPICE_FORMAT
#define DBG_MODE
#define THREASH 0.5//default 0.5
#define SATURATION_CLK 217*2


static int file_output(FILE *file, double time, int output_signal);

//int main(int argc, char *argv[]) {
int main(void)
{
	double y_current = 0,y_prev=0;
	double input = 0;
	int output = 0;
	FILE *file;
	file = fopen("output.txt", "w");
	file_output(file, 0, output);/*すべての項が初期値の0である最初の出力は、ループで計算しないのでここで出力しておく。*/

#if 0
	for(int i=1;i<SIZE;i++)
	{
		input = 0.5+(sin(2*M_PI*i/SIZE)/2);//sine wave
		//input = (double)i/(double)SIZE;//slope
#else
	for(int i=1;i<SIZE*1.5/SATURATION_CLK;i++)
	{
		if(i<SIZE/SATURATION_CLK)
		{
			input = (double)i*SATURATION_CLK/(double)SIZE;//slope
		}
		else
		{
			input = 1;			
		}
#endif
		y_current = input - output + y_prev;
		(y_current > THREASH) ? (output = 1): (output = 0);
		y_prev = y_current;
#ifdef DBG_MODE
		if(i<1000)
		{
			printf("%d : y_prev = %f, y_current = %f, input = %f, output = %d\n", i,y_prev,y_current,input,output);
		}
#endif

#ifdef LTSPICE_FORMAT
		//printf("%f %d\n",(double)i/(double)SIZE,output);
		file_output(file, (double)i/(double)SIZE, output);
#else
		printf("%d : %+d\ n",i,SIZE,output);
#endif
	}
	fclose(file);

    return 0;
}

static int file_output(FILE *file, double time, int output_signal)
{
    //FILE *file;
    //char string[] = "Hello, World!"; // 出力する文字列
    //char filename[] = "output.txt"; // 出力するファイル名

    // ファイルを書き込みモードで開く（存在しない場合は新規作成）
    //file = fopen(filename, "w");
    if (file == NULL) {
        printf("ファイルを開くことができませんでした。\n");
        return 1;
    }

    // 文字列をファイルに書き込む
	fprintf(file, "%0.8f %i\n", time, output_signal);
	//fprintf(file, "%f %i\n", time+(double)1/(double)(SIZE*10), output_signal);
	fprintf(file, "%0.8f %i\n", time+(double)99/(double)SIZE/(double)100, output_signal);
    // ファイルを閉じる
    //fclose(file);

    //printf("ファイルに文字列を出力しました。\n");

    return 0;
}
