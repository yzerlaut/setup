# Tools

## compression of pdfs

```
sudo apt install ghostscript
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_PDF_file.pdf input_PDF_file.pdf
```
Settings: `prepress` corresponds to 300dpi, `ebook` to 150dpi, `screen` to 72dpi
