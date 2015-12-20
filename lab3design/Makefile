
CFLAGS = -Wall -g

# This is the tarball name.
DIST = lab3design

# When adding .c files, append them to this list. 
SRCS = main.c fsfixer.c

# When adding .h files, append them to this list.
HDRS = ospfs.h fsfixer.h

# When adding other files, append them to this list.
OTHERS = Makefile README.md lab3design-tester

fsfixer: clean $(SRCS)
	gcc $(CFLAGS) -o fsfixer $(SRCS)

dist: fsfixer clean
	rm -rf $(DIST)
	mkdir $(DIST)
	cp $(SRCS) $(HDRS) $(OTHERS) $(DIST)/
	tar cvf $(DIST).tar.gz $(DIST)

clean:
	rm -rf fsfixer
	rm -rf $(DIST).tar.gz
	rm -rf $(DIST)

test: fsfixer
	./lab3design-tester	
