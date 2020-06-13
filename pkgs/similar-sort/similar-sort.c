#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "levenshtein.c/levenshtein.h"

struct Line {
  char *data;
  size_t buffer_s;
  size_t len;
};

static int cmplines(const void *a, const void *b, void *z) {
  const struct Line *first = a;
  const struct Line *second = b;
  const struct Line *base = z;

  size_t first_d = levenshtein_n(base->data, base->len, first->data, first->len);
  size_t second_d = levenshtein_n(base->data, base->len, second->data, second->len);

  if (first_d > second_d) return -1;
  if (first_d < second_d) return 1;
  return 0;
}

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("Usage: similar-sort filename\n");
    exit(EXIT_FAILURE);
  }

  char *base = argv[1];
  size_t base_len = strlen(base);
  struct Line baseline = { .data = base, .len = base_len, .buffer_s = base_len };

  size_t maxlines = 2000;
  size_t numlines = 0;
  struct Line *lines = calloc(maxlines, sizeof(struct Line));

  char *lineptr = NULL;
  size_t line_buffer_s = 0;
  while (1) {
    size_t len = getline(&lineptr, &line_buffer_s, stdin);
    if (len == -1) break;

    if (numlines == maxlines) {
      maxlines *= 2;
      lines = reallocarray(lines, maxlines, sizeof(struct Line));
    }

    lines[numlines] = (struct Line){ .data = lineptr, .len = len, .buffer_s = line_buffer_s };
    numlines++;

    lineptr = NULL;
    line_buffer_s = 0;
  }

  qsort_r(lines, numlines, sizeof(struct Line), cmplines, &baseline);

  for (int i = 0; i < numlines; i++)
    printf("%s", lines[i].data);

  exit(EXIT_SUCCESS);
}
