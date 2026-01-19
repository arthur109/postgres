FROM ghcr.io/railwayapp-templates/postgres-ssl:16

# Install pg_search extension from ParadeDB
RUN apt-get update && apt-get install -y curl libicu72 \
    && curl -L "https://github.com/paradedb/paradedb/releases/download/v0.21.2/postgresql-16-pg-search_0.21.2-1PARADEDB-bookworm_amd64.deb" -o /tmp/pg_search.deb \
    && apt-get install -y /tmp/pg_search.deb \
    && rm /tmp/pg_search.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy initialization script to create extension on startup
COPY init-pgsearch.sh /docker-entrypoint-initdb.d/
