#!/usr/bin/env python3

from endesive import pdf
import glob

pems = []
for f in glob.glob('/example-certs/*.pem') + glob.glob('/etc/ssl/certs/*'):
  pem = open(f, 'rt').read()
  pems.append(pem)

fname = 'example.pdf'
data = open(fname, 'rb').read()

(hashok, signatureok, certok) = pdf.verify(data, tuple(pems))
print('signature ok?', signatureok, 'hash', hashok, 'cert', certok)

