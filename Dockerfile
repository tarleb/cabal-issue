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
        lua5.4-dev \
        pkgconfig \
        yaml \
        zlib-dev

WORKDIR /data
RUN git clone --branch=main --depth=1 --quiet \
    https://github.com/jgm/pandoc
WORKDIR /data/pandoc
COPY cabal.config /root/.config/cabal/config
RUN cabal update
COPY <<EOF cabal.project.freeze
active-repositories: hackage.haskell.org:merge
constraints: lua  +system-lua +pkg-config +hardcode-reg-keys -export-dynamic,
             lpeg  -rely-on-shared-lpeg-library,
             aeson-pretty  +lib-only,
             pandoc  +embed_data_files,
             pandoc-cli  +lua +nightly +server,
EOF
RUN cabal build pandoc-cli
