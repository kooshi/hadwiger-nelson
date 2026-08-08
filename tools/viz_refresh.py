#!/usr/bin/env python3
"""Re-inject the exact M23 exporter data into the visualization page.

The page is self-contained (no fetches), so the JSON from
`python3 tools/couple.py --export-viz` is spliced into the
`<script id="m23data" type="application/json">` block. This tool is the ONLY
sanctioned way to update that block — hand-editing it violates the
never-hand-copied rule (plan §6)."""
import json
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
PAGE = REPO / "visualizations" / "two-circle-theorem.html"
DATA = REPO / "build" / "m23-viz-data.json"


def main():
    subprocess.run([sys.executable, str(REPO / "tools" / "couple.py"),
                    "--export-viz", "--out", str(DATA)], check=True)
    data = json.dumps(json.loads(DATA.read_text()))
    html = PAGE.read_text()
    new, count = re.subn(
        r'(<script id="m23data" type="application/json">).*?(</script>)',
        lambda m: m.group(1) + data + m.group(2), html, flags=re.S)
    if count != 1:
        raise SystemExit(f"expected exactly one m23data block, found {count} — "
                         f"page structure drifted; refusing to write")
    PAGE.write_text(new)
    print(f"refreshed m23data in {PAGE.name} ({len(data)} bytes)")


if __name__ == "__main__":
    main()
