# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2011 Casper Ti. Vector
# Public domain.

# ����������ļ����ļ�������������չ����
JOBNAME = pkuthss
# ���������ֵ����Ϊ latex��pdflatex �� xelatex��
LATEX = latex
BIBTEX = bibtex
DVIPDF = dvipdfmx

# ����� LaTeX ���룬��ʹ�� dvipdfmx �� dvi ת�� pdf��
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# ������ Windows ���������� UNIX ������
# ����Ǻ��ߣ��� GNU make �����Լ�⵽�Ѿ����� PATH ����������
ifdef PATH
	MAKE = make
	RM = rm -f
else
	MAKE = mingw32-make
	RM = del
endif

all: img doc

img:
	cd img && $(MAKE)

img-clean:
	cd img && $(MAKE) clean

doc:
	$(LATEX) $(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(LATEX) $(JOBNAME)
	$(DODVIPDF)

clear:
	$(RM) $(JOBNAME).log $(JOBNAME).aux $(JOBNAME).out $(JOBNAME).thm\
		$(JOBNAME).toc $(JOBNAME).lof $(JOBNAME).lot $(JOBNAME).blg\
		$(JOBNAME).bbl $(JOBNAME).dvi missfont.log
	$(RM) chap/*.aux

clean: clear img-clean
	$(RM) $(JOBNAME).pdf

.PHONY: img img-clean clear clean
