FROM continuumio/miniconda3
MAINTAINER Caspar Gross <mail@caspar.one>
LABEL description="Container that includes all tools necessary for Nanopore basecalling with the latest flappie flipflop caller"


RUN apt update && apt install -y git git-lfs libcunit1 libhdf5-103 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel
ENV PATH="/flappie:${PATH}"
RUN git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
RUN conda install -c bioconda -c conda-forge ont-fast5-api==1.3.0--py_0
