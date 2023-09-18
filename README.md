<!-- !!! DO NOT EDIT, THIS FILE IS GENERATED AUTOMATICALLY !!!  -->

> :information_source: Please, see the full project documentation here: [https://zerocluster.github.io/postgresql/](https://zerocluster.github.io/postgresql/).

# PosrgreSQL

### Debug

```shell
docker run --rm -it --network main -p 5432:5432 -v /var/local/zerocluster/postgresql:/var/local/package -v /var/run/postgresql:/var/run/postgresql -v postgresql:/var/llocal/packagedata --entrypoint bash ghcr.io/zerocluster/postgresql/16
```

### Upgrade cluster

-   Make sure, that old and new clusters use the same versions of timescaledb. If not - upgrade old cluster to the new version first.

-   Migrate

```shell
docker stack rm postgresql

docker run --rm -it -v postgresql:/var/local/package/data --entrypoint bash ghcr.io/zerocluster/postgresql/16

/var/local/package/bin/migrate.sh

# test run
/var/local/package/bin/main.js
```

-   After successful upgrade old cluster can be removed:

```shell
# remove old cluster
rm -rf /var/lib/docker/volumes/postgresql/_data/data-backup
```

### Upgrade timescaledb

-   Upgrade docker container to the latest version, contained new `timescaledb` extension version.

-   From `psql` execute:

```sql
psql -h <HOST>

# install and update softvisio_admin extension
CREATE EXTENSION IF NOT EXISTS softvisio_admin CASCADE;
ALTER EXTENSION softvisio_admin UPDATE;

# update all extensions for all databases to the latest available versions
CALL update_extensions();
```
