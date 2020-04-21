FROM alpine:latest as builder

ARG VERSION=devel

RUN apk add --update alpine-sdk

RUN wget -q  https://github.com/z3APA3A/3proxy/archive/${VERSION}.zip && \
    unzip -q ${VERSION}.zip && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux

FROM alpine:latest

ARG VERSION=devel

COPY --from=builder /3proxy-${VERSION}/bin/* /usr/bin/
COPY 3proxy.cfg /etc/3proxy.cfg

CMD 3proxy /etc/3proxy.cfg
