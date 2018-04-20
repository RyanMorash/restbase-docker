# Have to use node 7 as there is no pre-build binary binding for SQLite 3
# ref: https://github.com/mapbox/node-sqlite3/blob/master/appveyor.yml
FROM node:7-alpine

ENV RESTBASE_VERSION v0.17.0

EXPOSE 7231 2222

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY sshd_config /etc/ssh/

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk add --no-cache git \
    && npm install -g --only=production restbase@${RESTBASE_VERSION} restbase-mod-table-sqlite \
    && npm cache clean --force \
    && rm -rf /tmp/npm* /root/.node* /root/.npm

# ------------------------
# SSH Server support
# ------------------------
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd

CMD ["node", "/usr/local/lib/node_modules/restbase/server.js", "--config=/config.yaml"]
