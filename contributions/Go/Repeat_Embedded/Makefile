include $(GOROOT)/src/Make.inc

TARG=repeat

all:	$(TARG).go
	$(GC) -I. $(TARG).go
	$(LD) -L. -o $(TARG) $(TARG).$(O)

	./$(TARG) 1 > stitch.svg	
	./$(TARG) 2 > perspective.svg	
	./$(TARG) 3 > circles.svg	
	./$(TARG) 4 > arcs.svg	
	./$(TARG) 5 > tally.svg
	rm $(TARG) && rm $(TARG).6
