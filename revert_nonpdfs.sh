#!/bin/bash
for file in *.pdf; do
  base="${file%.pdf}"
  if [[ ! -f "$base" && ! "$file" =~ ^20[0-9]{2}-[0-9]{2}-[0-9]{2}_ ]]; then
    echo "Reverting: $file -> $base"
    mv "$file" "$base"
  fi
done
