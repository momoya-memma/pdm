CC = gcc
CFLAGS = -Wall -Wextra
SRCDIR = src
BINDIR = bin

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst $(SRCDIR)/%.c, $(BINDIR)/%.o, $(SOURCES))
EXECUTABLES = $(patsubst $(SRCDIR)/%.c, $(BINDIR)/%, $(SOURCES))

.PHONY: all clean

all: $(EXECUTABLES)

$(BINDIR)/%: $(BINDIR)/%.o
	$(CC) $(CFLAGS) $< -o $@ -lm

$(BINDIR)/%.o: $(SRCDIR)/%.c | $(BINDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -lm

$(BINDIR):
	mkdir -p $(BINDIR)

clean:
	rm -rf $(BINDIR)