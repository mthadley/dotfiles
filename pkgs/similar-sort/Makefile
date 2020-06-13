CFLAGS = -Wall -Werror -pedantic

all: bin/similar-sort

bin/similar-sort: similar-sort.c levenshtein.c/levenshtein.c
	mkdir -p bin
	$(CC) $(CFLAGS) -o $@ $^
