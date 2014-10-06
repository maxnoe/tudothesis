all: build/BachelorArbeit.pdf


TeXOptions = --interaction=nonstopmode \
			 --halt-on-error \
			 --output-directory=build
                                                                                
build/BachelorArbeit.pdf: header.tex BachelorArbeit.tex Inhalt/*.tex references.bib Plots/* | build
	lualatex $(TeXOptions) BachelorArbeit.tex
	biber build/BachelorArbeit.bcf
	lualatex $(TeXOptions) BachelorArbeit.tex
	lualatex $(TeXOptions) BachelorArbeit.tex

build:
	mkdir -p build/

clean:
	rm -rf build
