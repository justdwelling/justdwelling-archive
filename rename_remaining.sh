#!/usr/bin/env bash
shopt -s extglob

# Loop every PDF that does NOT already start with YYYY-MM-
for f in *.pdf; do
  if [[ ! $f =~ ^[0-9]{4}-[0-9]{2}- ]]; then
    # get creation date YYYY-MM (macOS stat)
    created=$(stat -f "%Sm" -t "%Y-%m" "$f" 2>/dev/null)
    # fallback to modification date if empty
    if [[ -z "$created" ]]; then
      created=$(stat -f "%Sm" -t "%Y-%m" -r "$f")
    fi

    # build slug from original filename (strip .pdf, lowercase, replace non-alphanum with hyphens)
    base="${f%.pdf}"
    slug=$(echo "$base" \
      | tr '[:upper:]' '[:lower:]' \
      | sed -E 's/[^a-z0-9]+/-/g' \
      | sed -E 's/^-|-$//g')

    newname="${created}-${slug}.pdf"

    if [[ -e "$newname" ]]; then
      echo "⚠️  SKIP: target exists → $newname"
    else
      echo "🔁  $f → $newname"
      mv -- "$f" "$newname"
    fi
  fi
done
