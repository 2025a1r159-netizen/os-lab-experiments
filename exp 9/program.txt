EXPERIMENT 9 – CPU-BOUND AND I/O-BOUND PROCESSES

1.  CPU-BOUND C PROGRAM File name: cpu_bound.c

#include <stdio.h>

int main(void) { volatile unsigned long long sum = 0;

    for (unsigned long long i = 1; i <= 100000000ULL; i++) {
        sum += i;
    }

    printf("CPU Bound Process\n");
    printf("Sum = %llu\n", sum);

    return 0;

}

2.  I/O-BOUND C PROGRAM File name: io_bound.c

#include <stdio.h>

int main(void) { FILE *fp = fopen(“output.txt”, “w”);

    if (fp == NULL) {
        perror("fopen");
        return 1;
    }

    for (int i = 1; i <= 100000; i++) {
        fprintf(fp, "Writing data: %d\n", i);
    }

    fclose(fp);

    printf("I/O Bound Process Completed\n");
    return 0;

}

3.  COMPILE AND RUN COMMANDS

Compile: gcc cpu_bound.c -o cpu gcc io_bound.c -o io

Run CPU-bound program: ./cpu

Run I/O-bound program: ./io

To monitor processes: top

To view a process memory map: pmap PID

Replace PID with the actual process ID shown by the system.

NOTE: The CPU-bound program performs repeated calculations. The
I/O-bound program writes data to a file. CPU usage shown by top can vary
depending on the computer and how quickly each program finishes.
