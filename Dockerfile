FROM alpine:3.21 AS builder

LABEL description="NIST Speech Recognition Scoring Toolkit (SCTK)"

RUN apk add --no-cache \
    alpine-sdk \
    git \
    perl

WORKDIR /opt

# Build and install all SCTK tools
RUN git clone https://github.com/usnistgov/SCTK \
 && cd SCTK \
 && make config \
 && make all \
 && make install

FROM alpine:3.21

RUN apk add --no-cache \
    libgcc \
    libstdc++ \
    perl

COPY --from=builder /opt/SCTK/bin/* /usr/local/bin/

CMD ["sclite"]
