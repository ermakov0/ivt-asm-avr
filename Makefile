DPI = 300

#project=''

SVG := $(shell find images -type f -name '*.svg')
DIA := $(shell find images -type f -name '*.dia')
# SOURCES := $(shell find examples -type f -name '*.c')

SVG2PNG := $(SVG:images/%.svg=images-gen/svg_%.png)
DIA2PNG := $(DIA:images/%.dia=images-gen/dia_%.png)

#all: myc.pdf

main.pdf: main.tex $(SVG2PNG) $(DIA2PNG)
	pdflatex main.tex
	pdflatex main.tex
	cp $@ $(shell date +%Y%m%d)_$@

book: main.pdf
	pdfbook --short-edge $<

images-gen/dia_%.eps: images/%.dia
	dia $< -e $@

images-gen/svg_%.png: images/%.svg
	convert -density $(DPI) -monochrome $< $@

images-gen/dia_%.png: images-gen/dia_%.eps
	convert -density $(DPI) -monochrome $< $@

clean:
	rm -f *.aux *.log *.nav *.snm *.toc *.vrb *.out
#	rm -f *.ilg *.ind *.idx
#	rm -f *.i *.s *.o *.bc
	find images-gen -type f -not -name '.placeholder' -exec rm {} \;
#	find examples -type f -not -name '*.c' -exec rm {} \;
