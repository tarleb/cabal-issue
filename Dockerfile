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
COPY <<EOF cabal.project.freeze
active-repositories: hackage.haskell.org:merge
constraints: lua  +system-lua +pkg-config +hardcode-reg-keys -export-dynamic,
             lpeg  -rely-on-shared-lpeg-library,
             aeson-pretty  +lib-only,
             pandoc  +embed_data_files,
             pandoc-cli  +lua +nightly +server,
EOF
RUN cabal build pandoc-cli
