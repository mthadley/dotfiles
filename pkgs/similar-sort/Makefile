CFLAGS = -Wall -Werror -pedantic

all: similar-sort

install:
	mkdir -p $(out)/bin
	cp similar-sort $(out)/bin

similar-sort: similar-sort.c levenshtein.c/levenshtein.c
	$(CC) $(CFLAGS) -o $@ $^
