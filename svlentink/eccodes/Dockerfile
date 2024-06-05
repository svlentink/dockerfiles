from python:bookworm as base

RUN curl --location -o /tmp/eccodes.tgz https://github.com/ecmwf/eccodes/archive/refs/tags/2.35.0.tar.gz
WORKDIR /tmp
RUN tar -xvf eccodes.tgz
RUN rm /tmp/eccodes.tgz
RUN mv /tmp/eccodes-* /tmp/eccodes

RUN apt update
RUN apt install -y cmake gfortran ecbuild libaec-dev libeccodes-tools

WORKDIR /tmp/build
RUN mkdir /app
RUN cmake /tmp/eccodes -DCMAKE_INSTALL_PREFIX=/app #-DENABLE_AEC=OFF
RUN make
RUN ctest
RUN make install
RUN pip3 install eccodes

#FROM scratch
#ARG PYTHON_PATH=/usr/local/lib/python3.12/site-packages
#COPY --from=base $PYTHON_PATH $PYTHON_PATH
