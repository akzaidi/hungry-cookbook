pdf:
	Rscript --quiet _render.R "bookdown::pdf_book"
gitbook:
	Rscript --quiet _render.R "bookdown::gitbook"
epub:
	Rscript --quiet _render.R "bookdown::epub_book"

all:
	Rscript --quiet _render.R
