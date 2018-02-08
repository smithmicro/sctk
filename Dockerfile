FROM alpine:3.7

MAINTAINER Dave Sperling <dsperling@smithmicro.com>
LABEL Description="NIST Speech Recognition Scoring Toolkit (SCTK)"

ENV SCTK_FILENAME sctk-2.4.10-20151007-1312Z.tar.bz2
ENV SCTK_PATH /opt/sctk-2.4.10

RUN apk add --update \
    alpine-sdk \
    perl \
  && rm -rf /var/cache/apk/*

WORKDIR /opt
COPY ${SCTK_FILENAME} /opt/

# Build and install all SCTK tools
RUN curl -O ftp://jaguar.ncsl.nist.gov/pub/$SCTK_FILENAME \
  && tar -xvf $SCTK_FILENAME \
  && rm $SCTK_FILENAME \
  && cd $SCTK_PATH \
  && make config \
  && make all \
  && make install \
  && make clean \
  && cp $SCTK_PATH/bin/* /usr/local/bin/

WORKDIR /var/sctk

CMD ["sclite"]
