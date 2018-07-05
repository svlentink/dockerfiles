# Steganography

How much data can we store in an image?
Let's find out!

As it turns out, there was already a docker image available doing all of this,
so I should just contribute to that one: https://github.com/DominicBreuker/stego-toolkit

## Introduction videos
The videos are listed in the optimal viewing order:
+ https://www.youtube.com/playlist?list=PLUKFnXUqzA7qeF38-2pAZXR1XN9c5TJW2
+ https://youtu.be/TWEXCYQKyDc
+ https://youtu.be/BQPkRlbVFEs

## Links
+ https://pdfs.semanticscholar.org/0f1a/2d9f295121e3122fa633cb915f0dd682b414.pdf
+ quantization tables: https://www.dfrws.org/sites/default/files/session-files/paper-using_jpeg_quantization_tables_to_identify_imagery_processed_by_software.pdf
+ https://arxiv.org/pdf/1401.5561.pdf
+ https://pdfs.semanticscholar.org/2744/dbf7401b370d07608387b6d0bee1b60389a5.pdf
+ https://stackoverflow.com/questions/1038550/in-python-how-do-i-easily-generate-an-image-file-from-some-source-data
+ https://www.researchgate.net/figure/A-comparison-between-ISA-algorithm-and-DEA-Jsteg-and-F5-algorithm_fig2_281057001


## Actual tools
+ Overview of tools: https://github.com/DominicBreuker/stego-toolkit
+ https://github.com/linyacool/blind-watermark
+ http://www1.chapman.edu/~nabav100/ImgStegano/


### Tools in the toolkit
+ https://github.com/lukechampine/jsteg (LSB)
+ https://github.com/matthewgao/F5-steganography (DCT)
+ https://github.com/jackfengji/f5-steganography
+ https://github.com/henkman/outguess
+ https://github.com/crorvick/outguess
+ https://github.com/livz/cloacked-pixel




## Inspirational links
The following examples are not tools,
they are research projects with most of them containing hard paths
to test images, thus not design to be 'useful'.
We ignored tools that require special propietary software (e.g. written in Matlab).

+ https://github.com/tgsd96/watermarking
+ https://github.com/snehil1703/Image-Recognition-Watermarking
+ https://github.com/j2kun/fft-watermark
+ https://github.com/as3mbus/DWT-Watermarking
+ https://github.com/as3mbus/Image-Watermarking
+ https://github.com/diptamath/DWT-DCT-Digital-Image-Watermarking
+ https://github.com/juhl/dct-image
+ https://github.com/cryptolok/SteCoSteg (does not accept arguments)

## Manual tools
The following tools do not have a CLI interface
and thus are not easily used to do scripted tests with.


## How JPEG compression works
source: https://youtu.be/Q2aEzeMDHMA

We assume the input is an uncompressed (stored loseless) RGB image
in PNG or BMP.

+ Input Image (RGB)
+ Color transformation to Y'CbCr
+ Discrete Cosine Transform (DCT) of 8x8 blocks
  + Quantization
  + Huffman encoding
+ JPEG


#### keywords
Least Significant Bit,
discrete cosine transform,
discrete wavelet transform,
Patchwork,
redundant pattern encoding,
White Noise Storm,
spread spectrum and frequency hopping,
Bit Plane Complexity Slicing (BPS),
Discrete Fourier Transform,
Hough Transforms,
LSB of RGB or LSB of DCT,

