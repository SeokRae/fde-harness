#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="fde-engagement"
OUT="$ROOT/dist/$SKILL.zip"

mkdir -p "$ROOT/dist"
rm -f "$OUT"
(cd "$ROOT/skills" && zip -qr -X "$OUT" "$SKILL" -x '*.DS_Store')
echo "$OUT"
