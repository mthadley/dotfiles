#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "levenshtein.c/levenshtein.h"

static int cmplines(const void *a, const void *b, void *z) {
  const char *first = *(const char **)a;
  const char *second = *(const char **)b;
  const char *base = z;

  size_t first_d = levenshtein(base, first);
  size_t second_d = levenshtein(base, second);

  if (first_d > second_d) return 1;
  if (first_d < second_d) return -1;
  return 0;
}

void print_usage() {
  printf("Usage: similar-sort filename\n");
}

int main(int argc, char **argv) {
  if (strcmp("-h", argv[1]) == 0) {
    print_usage();
    exit(EXIT_SUCCESS);
  }

  if (argc < 2) {
    print_usage();
    exit(EXIT_FAILURE);
  }

  size_t maxlines = 2000;
  size_t numlines = 0;
  char **lines = calloc(maxlines, sizeof(char *));

  char *lineptr = NULL;
  size_t line_buffer_s = 0;
  while (getline(&lineptr, &line_buffer_s, stdin) != -1) {
    if (numlines == maxlines) {
      maxlines *= 2;
      lines = reallocarray(lines, maxlines, sizeof(char *));
    }

    lines[numlines] = lineptr;
    numlines++;

    lineptr = NULL;
    line_buffer_s = 0;
  }

  qsort_r(lines, numlines, sizeof(char *), cmplines, argv[1]);

  for (int i = 0; i < numlines; i++)
    printf("%s", lines[i]);

  exit(EXIT_SUCCESS);
}
