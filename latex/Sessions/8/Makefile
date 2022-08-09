.PHONY: all viewpdf pdf clean
PROJECT = "ASIP"
TARGET       = main
SOURCE_FILES = $(TARGET).tex $(wildcard */*.tex)
BIB_FILES    = $(wildcard bib/*.bib)
FIGURES      = $(wildcard */images/*)

# Set the pdf reader according to the operating system
SHELL=/bin/bash
DATE = $(shell date +"%d%b%Y")
OS = $(shell uname)
ifeq ($(OS), Darwin)
	PDF_READER = open
endif
ifeq ($(OS), Linux)
	PDF_READER = evince
endif

all: pdf

viewpdf: pdf
	$(PDF_READER) $(TARGET).pdf &

pdf: $(TARGET).pdf
$(TARGET).pdf: $(SOURCE_FILES) $(BIB_FILES) $(FIGURES) wissdoc.cls
	pdflatex -interaction=nonstopmode $(SOURCE_FILES)
	bibtex $(TARGET)
	pdflatex -interaction=nonstopmode $(SOURCE_FILES)
#	pdflatex -interaction=nonstopmode -jobname=$(TARGET) $(SOURCE_FILES)
#	biber $(TARGET)
#	pdflatex -interaction=nonstopmode -jobname=$(TARGET) $(SOURCE_FILES) # For biber
#	@mv $(TARGET).pdf $(TARGET_NAME).pdf

clean:
	-rm -f *.{pdf,log,blg,bbl,bib,aux,out,toc,idx,idx,lof,lot,run,bcf,run.xml,ind,ilg,fls,fdb_latexmk,synctex}
	-rm -f tex/*.aux config/*.aux
	-rm -f *.pdf
#	rm -f $(TARGET).{ps,pdf,bcf,run.xml}
#	for suffix in dvi aux bbl blg toc ind out brf ilg idx synctex.gz log; do \
#		find . -type d -name ".git" -prune -o -type f -name "*.$${suffix}" -print -exec rm {} \;  ; \
#	done


targz:
#	$(MAKE) clean
	$(MAKE) all
#	$(MAKE) clean
	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE_FILES) $(BIB_FILES) $(FIGURES) $(TARGET).pdf

zip:
#	$(MAKE) clean
	$(MAKE) all
#	$(MAKE) clean
	zip -q $(PROJECT)_$(DATE).zip $(SOURCE_FILES) $(BIB_FILES) $(FIGURES) $(TARGET).pdf
	