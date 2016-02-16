$cleanup_mode = 1;
$out_dir = "build";
$pdflatex = "lualatex -interaction=nonstopmode -halt-on-error %O %S";
$pdf_mode = 1;
@default_files = ("thesis.tex");
$clean_ext = "bbl run.xml"
