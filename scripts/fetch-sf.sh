#!/usr/bin/env bash
# Download a Software Foundations volume's sources into software-foundations/<vol>.
#
# Usage: scripts/fetch-sf.sh [lf|plf|vfa|qc|secf|slf|vc]   (default: plf)
set -euo pipefail

VOL="${1:-plf}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/software-foundations/$VOL"
URL="https://softwarefoundations.cis.upenn.edu/$VOL-current/$VOL.tgz"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Fetching $URL"
curl -fsSL "$URL" -o "$TMP/$VOL.tgz"
tar -xzf "$TMP/$VOL.tgz" -C "$TMP" 2>/dev/null

# Keep the proof scripts and build files; the HTML rendering lives on the website.
mkdir -p "$DEST"
cp "$TMP/$VOL"/*.v "$DEST"/
for f in _CoqProject Makefile LICENSE README; do
  [ -e "$TMP/$VOL/$f" ] && cp "$TMP/$VOL/$f" "$DEST"/
done
echo "Wrote $DEST"
