all: install serve

.PHONY : help
help :
	@echo "install				: Install renv and restore virtual environment."
	@echo "restore				: Restore virtual environment to state in lock file."
	@echo "serve				: Start a http server to serve the book."
	@echo "serverefresh			: Clear cache and start a http server to serve the book."
	@echo "html					: Render book as html."
	@echo "clean				: Remove auto-generated files."

install:
	Rscript -e 'install.packages("renv")' \
			-e 'renv::activate(".")' \
			-e 'renv::restore(".", prompt = FALSE)'

restore:
	Rscript -e 'renv::restore(".", prompt = FALSE)'

serve:
	Rscript -e 'renv::restore(".", prompt = FALSE)'
	quarto preview

serverefresh:
	Rscript -e 'renv::restore(".", prompt = FALSE)'
	quarto preview --cache-refresh

serveref: serverefresh

clean:
	$(RM) -r output .quarto site_libs;\
	find . -name "*.ps" -type f -delete;
	find . -name "*.dvi" -type f -delete;
	find . -type d -name "*_files" -exec rm -rf {} \;
	find . -type d -name "*_cache" -exec rm -rf {} \;

html:
	Rscript -e 'renv::restore(".", prompt = FALSE)'
	quarto render --to html