FROM alpine:3.11 as builder

LABEL maintainer="Dave Sperling <dsperling@smithmicro.com>"
LABEL Description="NIST Speech Recognition Scoring Toolkit (SCTK)"

RUN apk add --update \
    alpine-sdk \
    git \
    perl \
 && rm -rf /var/cache/apk/*

WORKDIR /opt

# Build and install all SCTK tools
RUN git clone https://github.com/usnistgov/SCTK \
 && cd SCTK \
 && make config \
 && make all \
 && make install

FROM alpine:3.11

RUN apk add --update \
    perl \
 && rm -rf /var/cache/apk/*

COPY --from=builder /opt/SCTK/bin/* /usr/local/bin/

WORKDIR /var/sctk

CMD ["sclite"]
