FROM alpine:3.20.3

RUN apk --no-cache add \
        alpine-sdk \
        bash \
        ca-certificates \
        cabal \
        fakeroot \
        ghc \
        git \
        gmp-dev \
        libffi \
        libffi-dev \
        yaml \
        zlib-dev

WORKDIR /data
RUN cabal update
RUN git clone --branch=main --depth=1 --quiet \
    https://github.com/jgm/pandoc
WORKDIR /data/pandoc
RUN cabal install pandoc-cli
