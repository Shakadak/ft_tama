# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fdaudre- <fdaudre-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/27 13:37:39 by fdaudre-          #+#    #+#              #
#    Updated: 2015/06/27 15:11:56 by fdaudre-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# PERSO #
NAME		=	tama
BINDIR		=	bin


VPATH		+=	src
SRC			=	main.ml


OBJDIR		=	obj


CAMLC		=	ocamlc
CAMLOPT		=	ocamlopt
CAMLDEP		=	ocamldep


# DONT TOUCH ! #
LIB			=	



OPTOBJ		=	$(addprefix $(OBJDIR)/, $(SRC:.ml=.cmx) )
BYTOBJ		=	$(addprefix $(OBJDIR)/, $(SRC:.ml=.cmo) )

.PHONY: $(OBJDIR)/depend


all: depend $(NAME)

$(NAME): opt byt
	ln -fs $(BINDIR)/$(NAME).opt $(NAME)

opt: $(BINDIR)/$(NAME).opt

byt: $(BINDIR)/$(NAME).byt

$(BINDIR)/$(NAME).opt: $(OPTOBJ)
	@mkdir -p $(BINDIR)
	$(CAMLOPT) -o $@ $(LIB:.cma=.cmxa) $(OPTOBJ)

$(BINDIR)/$(NAME).byt: $(BYTOBJ)
	@mkdir -p $(BINDIR)
	$(CAMLC) -o $@ $(LIBS) $(BYTOBJ)

$(OBJDIR)/%.cmx: %.ml
	@mkdir -p $(OBJDIR)
	$(CAMLOPT) -o $@ -c $<

$(OBJDIR)/%.cmo: %.ml
	@mkdir -p $(OBJDIR)
	$(CAMLC) -o $@ -c $<


depend: $(OBJDIR)/depend
	@mkdir -p $(OBJDIR)
	$(CAMLDEP) $(SRC) > $<


clean:
	rm -rf $(OBJDIR)

fclean: clean
	rm -rf $(BINDIR)
	rm -f $(NAME)

re: fclean all


include $(OBJDIR)/depend
