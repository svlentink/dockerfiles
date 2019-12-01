# GPLv3
FROM svlentink/texlive-full:latest

# runs during installation and remove junk, as described in http://docs.docker.com/engine/articles/dockerfile_best-practices/#apt-get
# libre office is used in convert_doc.sh, which enables to embed doc files inside tex
# pandoc is used in convert_md.sh, which enables us to convert markdown to tex
# poppler-utils: pdftoppm, is used for converting pdf to png images, as mentioned http://superuser.com/questions/185880/how-to-convert-a-pdf-document-to-png
# https://github.com/tomduck/pandoc-xnos
RUN apt-get update; \
  apt-get install -y \
    aspell \
    curl \
    libreoffice \
    pandoc \
    pandoc-citeproc \
    python3-pip \
    poppler-utils; \
  pip3 install \
    pandoc-fignos \
    pandoc-eqnos \
    pandoc-tablenos \
    pandoc-secnos; \
  apt remove python3-pip; \
  apt-get autoremove -y; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*; \
  LATEST_PANDOC_DEB_PATH=$(curl \
    --location --silent \
    https://github.com/jgm/pandoc/releases/latest \
    | grep \.deb \
    | grep href \
    | sed 's/.*href="//g' \
    | sed 's/\.deb.*/\.deb/g' \
  ); \
  echo $LATEST_PANDOC_DEB_PATH; \
  LATEST_PANDOC_DEB_URL="https://github.com${LATEST_PANDOC_DEB_PATH}"; \
  curl --silent --location --output /tmp/pandoc.deb $LATEST_PANDOC_DEB_URL; \
  apt install -y /tmp/pandoc.deb; \
  rm /tmp/pandoc.deb; \
  pandoc --version
