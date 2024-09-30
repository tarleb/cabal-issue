FROM alpine:3.20.3

RUN apk --no-cache add \
        alpine-sdk \
        bash \
        ca-certificates \
        cabal \
        fakeroot \
        ghc \
        gmp-dev \
        libffi \
        libffi-dev \
        yaml \
        zlib-dev
RUN cabal update
RUN cabal install pandoc-cli
