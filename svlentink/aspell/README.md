# Aspell based on Alpine linux

Tiny container as a spellchecker, just having aspell.

## Example usage

```yaml
version: '2'
services:
  spellchecker:
    image: svlentink/aspell
    volumes:
      - $PWD:/inp:ro
    command: ["cat", "/inp/*.tex", "|", "aspell", "list" "-t", "|", "sort", "|", "uniq"]

```

## TODO

https://academichelp.net/general-writing-tips/essentials/words-avoid.html
https://unilearning.uow.edu.au/academic/2e.html
https://www.scribbr.com/academic-writing/taboo-words/
http://sites.psu.edu/pubhub/wp-content/uploads/sites/36309/2016/04/WordsandPhrasestoAvoid.pdf
http://www.chem.ucla.edu/dept/Faculty/merchant/pdf/Word_Usage_Scientific_Writing.pdf
https://www.freelancewriting.com/copywriting/ten-words-to-avoid-when-writing/
https://homepages.inf.ed.ac.uk/jbednar/writingtips.html
https://library.leeds.ac.uk/info/485/academic_skills/331/academic_writing/5
http://grammar.ccc.commnet.edu/grammar/plague.htm


for file in `find /inp -name *.tex`; do echo $file && cat $file|aspell list -t; done
docker run -it --rm -v /root/cloud9/rp1/tex/proposal:/inp:ro alpine
cat paper/*.tex|aspell list -t|sort|uniq

for tex in `find $PWD -name "*.tex"`;do \
  sed -i 's/\.\ /.\n/g' $tex \
  && sed -i 's/,\ /,\n/g' $tex \
  && sed -i 's/“/"/g' $tex \
  && sed -i 's/”/"/g' $tex \
  && sed -i "s/‘/'/g" $tex \
  && sed -i "s/’/'/g" $tex \
; done


how can to which exists
what to which