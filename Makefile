.PHONY: all listen workspace_allocator clean

all: listen workspace_allocator

listen:
	ocamlbuild -use-ocamlfind listen.native

workspace_allocator:
	ocamlbuild -use-ocamlfind workspace_allocator.native

clean:
	ocamlbuild -clean
