FROM ubuntu:19.10
FROM quay.io/biocontainers/ont-fast-api:1.2.0--py_0

RUN apt update && apt install -y git git-lfs libcunit1 libhdf5-103 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel
RUN git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
ENV PATH="/flappie:${PATH}"
