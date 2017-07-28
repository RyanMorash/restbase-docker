#!/bin/sh

MEDIAWIKI_API_URL="${MEDIAWIKI_API_URL:-http://localhost/w/api.php}"
MEDIAWIKI_URL="${MEDIAWIKI_URL:-http://localhost}"
PARSOID_URL="${PARSOID_URL:-http://localhost:8142}"
#NUM_WORKERS="${NUM_WORKERS:-4}"

cat /usr/local/lib/node_modules/restbase/config.example.yaml \
    | sed -e "s@http://localhost/w/api.php@${MEDIAWIKI_API_URL}@" \
    | sed -e "s@http://localhost:8142@${PARSOID_URL}@" \
    | sed -e "s@{domain:localhost}@{domain:$MEDIAWIKI_URL}@" \
    > /config.yaml

exec "$@"
