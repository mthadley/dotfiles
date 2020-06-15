#define _POSIX_C_SOURCE 200809L

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "levenshtein.c/levenshtein.h"

static char *base;

static int cmplines(const void *a, const void *b) {
  const char *first = *(const char **)a;
  const char *second = *(const char **)b;

  return levenshtein(base, first) - levenshtein(base, second);
}

static void print_usage() {
  printf("Usage: similar-sort filename\n");
}

static size_t readlines(char ***out) {
  assert(*out == NULL);

  size_t maxlines = 2000;
  size_t numlines = 0;
  char **lines = calloc(maxlines, sizeof(char *));

  char *lineptr = NULL;
  size_t line_buffer_s = 0;
  while (getline(&lineptr, &line_buffer_s, stdin) != -1) {
    if (numlines == maxlines) {
      maxlines *= 2;
      lines = realloc(lines, maxlines * sizeof(char *));
    }

    lines[numlines] = lineptr;
    numlines++;

    lineptr = NULL;
    line_buffer_s = 0;
  }

  *out = lines;
  return numlines;
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

  base = argv[1];

  char **lines = NULL;
  size_t numlines = readlines(&lines);

  qsort(lines, numlines, sizeof(char *), cmplines);

  for (int i = 0; i < numlines; i++)
    printf("%s", lines[i]);

  exit(EXIT_SUCCESS);
}
