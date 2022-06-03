#!env bash
set -euo pipefail
PLUGIN_NAME="${1:-logseq-interval-hints}"
LSAPI_VERSION="${2:-0.0.6}"
mkdir "$PLUGIN_NAME"
cd "$PLUGIN_NAME"
cp ../{README.md,LICENSE,package.json,index.js} .
cp -Ra ../screenshots .
sed 's@https://cdn[^"]*@./logseq-api.js@' ../index.html > ./index.html
curl -fSs \
  "https://cdn.jsdelivr.net/npm/@logseq/libs@${LSAPI_VERSION}" \
  "https://cdn.jsdelivr.net/npm/@logseq/libs@${LSAPI_VERSION}/dist/lsplugin.user.js.LICENSE.txt" \
  -o ./logseq-api.js -O
cd ..
exec zip -r "${PLUGIN_NAME}.zip" "$PLUGIN_NAME"
