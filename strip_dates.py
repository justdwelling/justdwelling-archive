#!/usr/bin/env python3
import os, re

# Matches “YYYY-MM-” or “YYYY-MM-DD-” at the start of the filename
pattern = re.compile(r'^(\d{4}-\d{2}(?:-\d{2})?)-(.*\.pdf)$')

for fname in os.listdir('.'):
    m = pattern.match(fname)
    if not m:
        continue

    new_name = m.group(2)
    # avoid clobbering an existing file
    if os.path.exists(new_name):
        print(f"⚠️  would overwrite, skipping: {new_name}")
    else:
        print(f"🔁 {fname} → {new_name}")
        os.rename(fname, new_name)