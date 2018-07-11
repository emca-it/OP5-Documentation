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

## Formatting Notes

### Markdown Standard

We follow the Pandoc Markdown standard since we're using pandoc to render the `.md` files into something useable.

### Table of Contents

Pandoc keys off of the headings in the Markdown files to create the table of contents (ToC).

Each file needs to have a single level 1 header (`#`) which will act as the title. Pandoc will recognize multiple level one headers (`#`) as different sections, but by convention, each file is a dedicated to a single topic.

Once a title has been established, each section and its subsections need to be level 2 header (`##`) or higher in order for the ToC to render correctly.

For instance, the example below will create an asthetically pleasing (usable) ToC when rendered.

```
# Title

Here are some words.

## Section 1

### Subsection 1.1

More words.

### Subsection 1.2

Something something mumble mumble ack....

## Section 2

This is section #2. Say it with me. What section is this?!

### Subsection 2.1

#### Subsubsection 2.1.1

This means something. This is important!

## Section 3

Here is nothing.
```

### Figures/Screenshots

Figures need to separated from the paragraph by a blank line because Markdown is whitespace sensative. Without the blank line, the figures are considered part of the paragraph, and they are positioned at the end of the paragraph which results in the figure running off of the page.

Figures have a tendency to endup in random locations, so they need to be proofed to make sure they are in the correct location. We can help Latex put the figures in the correct spot by adding a linebreak and two empty lines before the next piece of content.

Correctly formatted example:

```
This is my ant farm. These little guys can lift fifty times their own weight. They also spend weeks digging these intricate little tunnels. And oh yeah, they really hate it when you do this!

![alt text](/path/to/image.ext) \


Oh, look! They're really mad now!
```

### Tables

```
| Column Heading | Column Heading |
| ---- | ---- |
| 1 | Text here |
| 2 | More text here |
```
