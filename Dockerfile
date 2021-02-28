FROM bigredreevz/biocontainer-mash

#FROM nfcore/base:1.12.1
#MAINTAINER Pablo P <pablo@lifebit.ai>

#COPY ./environment.yml /
#RUN conda env create -f /environment.yml && conda clean -a && apt-get update && (apt-get install -t buster-backports -y mash || apt-get install -y mash) && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

#ENV PATH /opt/conda/envs/star-nf/bin:$PATH
