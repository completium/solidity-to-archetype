# -*- Makefile -*-

# --------------------------------------------------------------------
.PHONY: all merlin build build-deps run clean

# --------------------------------------------------------------------
all: build soltoarl merlin

build:
	@dune build

soltoarl:
	$(MAKE) -C src soltoarl.exe
	cp -f _build/default/src/soltoarl.exe .

merlin:
	$(MAKE) -C src merlin

check:
	./check.sh

clean:
	@dune clean
	rm -fr soltoarl.exe

install:
	@dune install
