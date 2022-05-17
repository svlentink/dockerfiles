FROM svlentink/code-server

RUN apt install -y \
      python3-dev \
      python3-pip \
    && pip3 install \
      black \
      pandas

