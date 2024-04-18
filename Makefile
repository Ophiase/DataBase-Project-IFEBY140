render:
	cd report; quarto render
	mv report/_output/*.pdf XXX_YYY_report.pdf

render_show: render
	xdg-open XXX_YYY_report.pdf

web_preview:
	cd report; quarto preview