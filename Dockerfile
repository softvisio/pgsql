FROM softvisio/core

ENV POSTGRES_VER=13

ENV POSTGRES_HOME="/usr/pgsql-$POSTGRES_VER"

ENV PATH="$POSTGRES_HOME/bin:$PATH"

HEALTHCHECK NONE

RUN \
    # generate additional locales
    # localedef --force -i ru_UA -f UTF-8 ru_UA.UTF-8 \
    dnf install -y langpacks-ru langpacks-uk \
    \
    && dnf install -y \
        postgresql${POSTGRES_VER}-server \
        postgresql${POSTGRES_VER}-llvmjit \
        postgresql${POSTGRES_VER}-contrib \
        pg${POSTGRES_VER}-extensions \
    \
    # install deps
    && npm i --no-fund --omit=dev \
    \
    # clean npm cache
    && rm -rf ~/.npm-cache
