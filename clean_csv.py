import pandas as pd

CSV_FILE = "archive_working.csv"
df = pd.read_csv(CSV_FILE)

# Ensure .pdf at the end of each filename in current_name
df['current_name'] = df['current_name'].apply(
    lambda x: x if isinstance(x, str) and x.lower().endswith('.pdf') else f"{x}.pdf"
)

df.to_csv(CSV_FILE, index=False)
print("✅ CSV cleaned and saved.")
