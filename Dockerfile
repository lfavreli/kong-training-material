FROM debian:bullseye-slim

# Update packages and install wget
RUN apt-get update && apt-get install -y wget

# Download the Kong Gateway & Docker entrypoint - June 2024 v3.7.1.0
RUN wget -O /tmp/kong.deb https://packages.konghq.com/public/gateway-37/deb/debian/pool/bullseye/main/k/ko/kong-enterprise-edition_3.7.1.0/kong-enterprise-edition_3.7.1.0_amd64.deb
RUN wget -O /docker-entrypoint.sh https://raw.githubusercontent.com/Kong/docker-kong/7c1f670b717d308affd4843c8cf2f5c4402b6794/docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Install Kong, Node.js and npm and setup appropriate configuration
RUN set -ex; \
    apt-get install --yes /tmp/kong.deb \
    && apt-get install -y nodejs npm \
    && npm install -g kong-pdk \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/kong.deb \
    && chown kong:0 /usr/local/bin/kong \
    && chown -R kong:0 /usr/local/kong \
    && ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/luajit \
    && ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/lua \
    && ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
    && kong version

USER kong

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8001 8002

STOPSIGNAL SIGQUIT

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health

CMD ["kong", "docker-start"]
