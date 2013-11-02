include $(GOROOT)/src/Make.inc

TARG=recursive-tree

all:	$(TARG).go
	$(GC) -I. $(TARG).go
	$(LD) -L. -o $(TARG) $(TARG).$(O)
	./$(TARG) > $(TARG).svg
	rm $(TARG) && rm $(TARG).6
