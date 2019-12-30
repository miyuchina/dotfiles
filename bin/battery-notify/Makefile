PREFIX = /usr/local

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)

CC = gcc
CFLAGS = -O2 -march=native -pipe -Wall -Werror -Wpedantic `pkg-config --cflags --libs libnotify`

battery-notify: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

-include $(DEP)

%.d: %.c
	@$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

.PHONY: clean
clean:
	rm -f $(OBJ) battery-notify
	rm -f $(DEP)

.PHONY: install
install: battery-notify
	-mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $< $(DESTDIR)$(PREFIX)/bin/battery-notify

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/battery-notify
