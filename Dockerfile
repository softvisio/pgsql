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
        citus_${POSTGRES_VER} \
        timescaledb_${POSTGRES_VER} \
    \
    # install deps
    && npm i --omit=dev \
    \
    # clean npm cache
    && rm -rf ~/.npm-cache
