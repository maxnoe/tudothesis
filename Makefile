all: ./BachelorArbeit.pdf
                                                                                
BachelorArbeit.pdf: BachelorArbeit.tex Inhalt/*.tex references.bib Plots/*
	lualatex BachelorArbeit.tex
	biber BachelorArbeit.bcf
	lualatex BachelorArbeit.tex
	lualatex BachelorArbeit.tex
	mkdir -p logfiles
	mv *.log *.aux *.out *.toc *.bbl *.bcf *.run.xml *.blg ./logfiles

clean:
	rm -rf logfiles
