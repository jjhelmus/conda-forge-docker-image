FROM msarahan/conda_builder_linux
MAINTAINER Jonathan J. Helmus <jjhelmus@gmail.com>

USER root
RUN mkdir /feedstock_root && chmod 777 /feedstock_root
USER dev

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PATH /opt/miniconda/bin:/usr/local/gcc5_abi4/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/gcc5_abi4/lib64:/usr/local/gcc5_abi4/lib:$LD_LIBRARY_PATH

COPY build_scripts /build_scripts
RUN bash /build_scripts/build_miniconda.sh