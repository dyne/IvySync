# We don't need kludgy automatizations here,
# let's use a simple Makefile.
# Just tweak the values below to fix your paths
#
# $Id: Makefile 60 2004-11-12 15:40:18Z jaromil $


CPP = g++
LINKER = ld

GTKFLAGS = `pkg-config --cflags gtk+-2.0`
GTKLIBS  = `pkg-config --libs   gtk+-2.0`

# debugging flags:
#CPPFLAGS = -I. -Ixmlrpc++ -Wall -g -ggdb $(GTKFLAGS)
# optimized flags:
CPPFLAGS = -I. -Ixmlrpc++ -Wall -O2 -fomit-frame-pointer -ffast-math




LIBS = xmlrpc++/libxmlrpc++.a -lpthread -lssl

IVYSYNC_OBJ = decoder.o thread.o linklist.o utils.o cmdline.o xmlrpc.o

all: xmlrpc ivysync ivysync-nox

xmlrpc: 
	cd xmlrpc++ && $(MAKE)

ivysync: $(IVYSYNC_OBJ) gui.o
	$(CPP) $(CPPFLAGS) -o ivysync $(IVYSYNC_OBJ) $(LIBS) $(GTKLIBS)

ivysync-nox: $(IVYSYNC_OBJ)
	$(CPP) $(CPPFLAGS) -o ivysync-nox $(IVYSYNC_OBJ) $(LIBS)


#make clean
clean:
	rm -rf *.o *~ ivysync 

install: ivysync
	install ivysync /usr/local/bin

# generic make rules
#%: %.c
#	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
#%.o: %.c
#	$(CC) $(CFLAGS) -c -o $@ $<


