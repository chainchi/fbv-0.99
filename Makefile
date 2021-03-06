#
# Makefile
#
# Makefile for fbv

include Make.conf

CC	= arm-linux-gcc -O2 -Wall

SOURCES	= main.c jpeg.c gif.c png.c bmp.c fb_display.c resize.c
OBJECTS	= ${SOURCES:.c=.o}

OUT	= fbv
#add png ingif again
#20140602
LIBS	=  -ljpeg -lpng -lungif 

all: $(OUT)
	@echo Build DONE.

$(OUT): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $(OUT) $(OBJECTS) $(LIBS)

clean:
	rm -f $(OBJECTS) *~ $$$$~* *.bak core config.log $(OUT)

distclean: clean
	@echo -e "error:\n\t@echo Please run ./configure first..." >Make.conf
	rm -f $(OUT) config.h

install: $(OUT)
	cp $(OUT) $(DESTDIR)$(bindir)
	gzip -9c $(OUT).1 > $(DESTDIR)$(mandir)/man1/$(OUT).1.gz

uninstall: $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(mandir)/man1/$(OUT).1.gz
