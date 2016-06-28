# LaTeX Docker
This [docker](https://hub.docker.com/r/svlentink/latex/) file has some special features.

+ auto convert files into latex commands (tags) (\*.cmd.tex)
+ auto convert convert docs to latex command (tag), so you can import it
+ auto bundle all .tex files in a directory that ends with '\_forms' into a latex command (tag)
+ auto convert markdown to tex (\*.md)
+ auto convert slides (ppt exported as pdf) to latex table (table of two rows with) (\*.slides.pdf)
+ run scripts you have specified; ./sh/*.sh

For this to work, we use the texlive image as base
and install libreoffice and pandoc. (total size:4.553GB)

## TODO

+ re-factor the md converter (as explained in file) IN PROGRESS
+ change the docs converter, which now hard coded looks in ./content/docs
+ convert_slides is now using a table, but a two column page (package multicol) would allow for easy manipulation in LaTeX, less bash, more latex!


### Update 2016/05/02

The conversion of .slides.pdf files are now caching the conversion step.
To refresh the content, don't mount the docker in you tmp (see example build script)
or just rm the folder in your tmp dir.
