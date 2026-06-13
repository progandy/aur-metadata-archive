#!/usr/bin/env bash
set -euo pipefail

URL="https://aur.archlinux.org/packages-meta-ext-v1.json.gz"
OUT="packages-meta-ext-v1.json"

TMP="$(mktemp)"

curl -fsSL "$URL" -o "$TMP"
gzip -dc "$TMP" > "$OUT"

rm "$TMP"

git add "$OUT"

if git diff --cached --quiet; then
    echo "No changes."
    exit 0
fi

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

git commit -m "Update AUR package metadata"
git push
