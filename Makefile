# -*- Makefile -*-

# --------------------------------------------------------------------
.PHONY: all merlin build build-deps run clean

# --------------------------------------------------------------------
all: build merlin

build: soltoarl

soltoarl:
	$(MAKE) -C src soltoarl.exe
	cp -f src/_build/default/soltoarl.exe .

merlin:
	$(MAKE) -C src merlin

run:
	$(MAKE) -C src run

clean:
	$(MAKE) -C src clean
	rm -fr soltoarl.exe

build-deps:
	opam install dune ppx_deriving ppx_deriving_yojson
