CFLAGS = -std=c99 -Wall -Werror -pedantic

all: similar-sort

similar-sort: similar-sort.c levenshtein.c/levenshtein.c
	$(CC) $(CFLAGS) -o $@ $^

install:
	mkdir -p $(out)/bin
	cp similar-sort $(out)/bin

.PHONY: clean
clean:
	rm -f similar-sort
