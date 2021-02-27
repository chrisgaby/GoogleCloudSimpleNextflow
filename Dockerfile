FROM biocontainers/mash:v2.1dfsg-2-deb_cv1
MAINTAINER Pablo P <pablo@lifebit.ai>

COPY ./environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/star-nf/bin:$PATH
