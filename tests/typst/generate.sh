#!/usr/bin/env bash
set -euo pipefail

journals=(cic tosc tches)
versions=(preprint submission final)

for journal in "${journals[@]}"; do
  for version in "${versions[@]}"; do
    outfile="typst-iacrj-${journal}-${version}.pdf"
    typst compile --input journal="$journal" --input version="$version" main.typ "$outfile"
  done
done
