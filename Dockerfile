FROM alpine:3.4

MAINTAINER Dave Sperling <dsperling@smithmicro.com>
LABEL Description="NIST Speech Recognition Scoring Toolkit (SCTK)"

ENV SCTK_FILENAME sctk-2.4.10-20151007-1312Z.tar.bz2
ENV SCTK_PATH /opt/sctk-2.4.10
ENV PATH $PATH:${SCTK_PATH}/bin

RUN apk add --update \
  alpine-sdk \
  perl \
  && rm -rf /var/cache/apk/*

# Fetch
RUN mkdir /opt \
  && cd /opt \
  && wget ftp://jaguar.ncsl.nist.gov/pub/${SCTK_FILENAME} \
  && tar -xvf ${SCTK_FILENAME} \
  && rm ${SCTK_FILENAME}

# Build and install all SCTK tools
RUN cd ${SCTK_PATH} \
  && make config \
  && make all \
  && make install

WORKDIR /var/sctk

CMD ["sclite"]
