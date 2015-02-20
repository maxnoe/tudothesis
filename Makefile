all: build/thesis.pdf


TeXOptions = -lualatex \
			 -interaction=nonstopmode \
			 -halt-on-error \
			 -output-directory=build
                                                                                
build/thesis.pdf: tudothesis.cls thesis.tex Inhalt/*.tex references.bib Plots/* | build
	lualatex $(TeXOptions) thesis.tex
	biber build/thesis.bcf
	lualatex $(TeXOptions) thesis.tex
	lualatex $(TeXOptions) thesis.tex

build:
	mkdir -p build/

clean:
	rm -rf build
