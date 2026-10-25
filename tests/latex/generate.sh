#!/usr/bin/env bash
set -euo pipefail

curdir="$(pwd)"
srcdir="$(cd -- "$(dirname -- "$0")" && pwd)"
tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT

journals=(cic tosc tches)
versions=(preprint submission final)

# Copy the shared content into the temporary build directory.
cp "$srcdir/"* "$tmpdir/"

cd "$tmpdir"

for journal in "${journals[@]}"; do
  for version in "${versions[@]}"; do
    infile="latex-iacrj-${journal}-${version}.tex"
    outfile="latex-iacrj-${journal}-${version}.pdf"

    cat > "$infile" <<EOF
\\PassOptionsToClass{journal=${journal},version=${version}}{iacrj}
\\input{content}
EOF

    echo "Generating $outfile ..."
    latexmk -pdf "$infile" > /dev/null
    mv "$outfile" "$curdir/"
  done
done

echo "All documents compiled successfully."
