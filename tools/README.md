# Tools

## formatting drive

Use the following command (custom script in (../bash/)):
```
format_drive
```

## making bootable drive

```
sudo dd if=ubuntustudio-22.04.2-dvd-amd64.iso of=/dev/sdc bs=1M status=progress
```
from the following (web page)[https://www.cyberciti.biz/faq/creating-a-bootable-ubuntu-usb-stick-on-a-debian-linux/] 

## compression of pdfs

```
sudo apt install ghostscript
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_PDF_file.pdf input_PDF_file.pdf
```
Settings: `prepress` corresponds to 300dpi, `ebook` to 150dpi, `screen` to 72dpi
