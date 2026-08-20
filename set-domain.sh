#!/usr/bin/env bash
# Rewrites every hardcoded URL to your real domain, and writes the CNAME file.
#
#   ./set-domain.sh www.yourdomain.com
#
# Run this from inside the site/ folder, once, before your first push.
set -euo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "usage: ./set-domain.sh www.yourdomain.com"
  exit 1
fi

OLD="hbapuram.github.io"

# index.html: canonical, og:url, og:image, twitter:image, JSON-LD url
sed -i.bak "s|https://${OLD}|https://${DOMAIN}|g" index.html
# sitemap + robots
sed -i.bak "s|https://${OLD}|https://${DOMAIN}|g" sitemap.xml robots.txt
rm -f index.html.bak sitemap.xml.bak robots.txt.bak

# CNAME tells GitHub Pages which domain to serve
echo "$DOMAIN" > CNAME

echo "Done. All URLs now point at https://${DOMAIN}"
echo "CNAME written:"
cat CNAME
