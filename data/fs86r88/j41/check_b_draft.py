#!/usr/bin/env python3
"""J41 — run FS-71's ledger check with the drafted § B lines appended to LEDGER.md's text in memory (the file is not touched).

    python3 data/fs86r88/j41/check_b_draft.py [--plant]   # --plant drops one drafted line; the check must then FAIL
"""
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
import fs71_ledger_b_check as c  # noqa: E402

draft = (Path(__file__).parent / "ledger-b-draft.md").read_text(encoding="utf-8").strip().splitlines()
if "--plant" in sys.argv:
    draft = draft[1:]
entries = {}
for f in sorted((ROOT / "plans").glob("*-derivation.md")):
    prefix = f.name[: -len("-derivation.md")]
    entries.update(c.parse_entries(f.read_text(encoding="utf-8"), prefix))
text = (ROOT / "LEDGER.md").read_text(encoding="utf-8").rstrip("\n") + "\n" + "\n".join(draft) + "\n"
rows, placeholders = c.parse_ledger_b(text)
# Only this milestone's ids are judged here (other closes' derivation files may be mid-close in the shared tree).
entries = {k: v for k, v in entries.items() if k.startswith("R88-")}
rows = {k: v for k, v in rows.items() if k.startswith("R88-")}
n = c.check(entries, rows, placeholders, strict=True)
r88 = sorted(k for k in entries if k.startswith("R88-"))
print(f"R88 entries: {len(r88)}; drafted lines: {len(draft)}; failures: {n}")
print("RESULT:", "PASS" if n == 0 else "FAIL")
sys.exit(0 if n == 0 else 1)
