all: build/BachelorArbeit.pdf


TeXOptions = -lualatex \
			 -interaction=nonstopmode \
			 -halt-on-error \
			 -output-directory=build
                                                                                
build/BachelorArbeit.pdf: header.tex BachelorArbeit.tex Inhalt/*.tex references.bib Plots/* | build
	latexmk $(TeXOptions) BachelorArbeit.tex

build:
	mkdir -p build/

clean:
	rm -rf build
