# -*- Makefile -*-

# --------------------------------------------------------------------
.PHONY: all run clean merlin __force__

PROFILE  ?= dev
SOLTOARL := soltoarl.exe

# --------------------------------------------------------------------
all: $(SOLTOARL)

run: __force__
	dune exec ./$(SOLTOARL)

soltoral: __force__
	dune build --profile=$(PROFILE) soltoarl.exe

clean: __force__
	dune clean

merlin: .merlin

# --------------------------------------------------------------------
%.exe: __force__
	dune build --profile=$(PROFILE) $@

.merlin: __force__
	dune build --profile=$(PROFILE) $@
