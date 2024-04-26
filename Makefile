render:
	cd report; quarto render

update_pdf: render
	cp report/_output/*.pdf XXX_YYY_report.pdf
	xdg-open XXX_YYY_report.pdf

update_web: render
	cp report/_output/*.pdf XXX_YYY_report.pdf
	rm -rf docs
	mkdir -p docs
	cp -r report/_output/* docs

preview_web:
	cd report; quarto preview