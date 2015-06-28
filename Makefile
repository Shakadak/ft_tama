NAME := tama

SOURCES := Engine.mli Engine.ml \
	Draw.mli \
	Draw.ml \
	Event.mli Event.ml \
	main.ml

LIBS := -I +sdl bigarray.cma sdl.cma sdlgfx.cma sdlttf.cma sdlloader.cma -cclib "-framework Cocoa"

CAMLC := ocamlc
CAMLOPT := ocamlopt
CAMLDEP := ocamldep

OBJS := $(SOURCES:.ml=.cmo)
OPTOBJS = $(SOURCES:.ml=.cmx)

.PHONY: .depend

.SUFFIXES:

.SUFFIXES: .ml .mli .cmo .cmi .cmx

all: depend $(NAME)

$(NAME): opt byt
	ln -sf $(NAME).opt $(NAME)

opt: $(NAME).opt

byt: $(NAME).byt

$(NAME).byt: $(OBJS)
	$(CAMLC) -o $@ $(LIBS) $(OBJS)

$(NAME).opt: $(OPTOBJS)
	$(CAMLOPT) -o $@ $(LIBS:.cma=.cmxa) $(OPTOBJS)

.SUFFIXES:

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(CAMLC) $(LIBS) -c $<

.mli.cmi:
	$(CAMLC) $(LIBS) -c $<

.ml.cmx:
	$(CAMLOPT) $(LIBS:.cma=.cmxa) -c $<

clean:
	rm -f *.cm[iox] *.o *~ .*~

fclean: clean
	rm -f $(NAME)
	rm -f $(NAME).opt
	rm -f $(NAME).byt

depend: .depend
	$(CAMLDEP) $(SOURCES) > .depend

re: fclean all

release: all clean

run: all
	./tama

include .depend
