FROM rocker/tidyverse:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda activate base" >> ~/.bashrc

WORKDIR /cookbook/
COPY install_pkgs.R /cookbook/install_pkgs.R

# Install all TeX and LaTeX dependences
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    git \
    ca-certificates \
    inotify-tools \
    lmodern \
    make \
    texlive-fonts-recommended \
    # texlive-generic-recommended \
    texlive-lang-english \
    # texlive-lang-portuguese \
    texlive-xetex && \
    apt-get autoclean && apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN conda env update -f environment.yml
RUN Rscript /cookbook/install_pkgs.R