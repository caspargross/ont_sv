FROM continuumio/miniconda3
MAINTAINER Caspar Gross <mail@caspar.one>
LABEL description="Container that includes all tools necessary for Nanopore basecalling with the latest flappie flipflop caller"

# Install flappie and dependencies
RUN apt update && apt install -y git libcunit1 libhdf5-100 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel
ENV PATH="/flappie:${PATH}"

# Install ont-fast-api
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt install git-lfs && git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
RUN conda install -c bioconda -c conda-forge ont-fast5-api==1.2.0--py_0

SHELL ["/bin/bash", "-ce"]
