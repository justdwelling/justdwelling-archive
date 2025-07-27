#!/usr/bin/env bash
shopt -s extglob

# For every PDF in the folder:
for f in *.pdf; do
  # match filenames like YYYY-MM-DD-title-stuff.pdf
  if [[ $f =~ ^([0-9]{4})-([0-9]{2})-[0-9]{2}-(.+)\.pdf$ ]]; then
    year=${BASH_REMATCH[1]}
    month=${BASH_REMATCH[2]}
    rest=${BASH_REMATCH[3]}

    # slugify: lowercase, non-alnum → hyphen, collapse hyphens
    slug=$(echo "$rest" \
      | tr '[:upper:]' '[:lower:]' \
      | sed -E 's/[^a-z0-9]+/-/g' \
      | sed -E 's/-{2,}/-/g' \
      | sed -E 's/^-|-$//g')

    newname="${year}-${month}-${slug}.pdf"

    if [[ -e "$newname" ]]; then
      echo "⚠️  target exists, skipping: $newname"
    else
      echo "🔁  $f → $newname"
      mv -- "$f" "$newname"
    fi
  else
    echo "⏭  no date-title pattern, skipping: $f"
  fi
done
