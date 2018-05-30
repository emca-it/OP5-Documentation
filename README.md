# Doc Pipeline Readme

Pandoc command to create the DLC PDF. It's important that `../template/metadata.yaml` comes first as it overrides any other YAML blocks in the files (even though there isn't other YAML blocks), and the order of files on the command line determines the order of sections in the PDF.

```bash
pandoc --latex-engine=lualatex -sf markdown --template=../template/dlc-custom-latex.template -o ../output/dlc-op5-monitor-doc-`date +%F`.pdf ../template/metadata.yaml `ls . | grep -ve "ZZ" -e attachments -e images | sort -t '-' -k 1 -k 2 -k 3 | tr '\n' ' '`
```

`ZZ-` prefixed files are files I’m not sure what they are, and they need to be filed.

`doc_tree.txt` describes the naming convention used, which is loosely based on the Dewey Decimal system.

## Dependencies

- perl 5.10.1+
- OpenSans fonts
- LiberationSans font
- LiberationMono font
- luatex
- pandoc
