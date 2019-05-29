FROM ubuntu:19.10

RUN apt update && apt install -y git git-lfs libcunit1 libhdf5-103 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev
RUN git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
ENV PATH="/flappie:${PATH}"
