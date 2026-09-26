#!/usr/bin/env python3
"""J44 stage 2: apply row 88's and FS-67's LEDGER.md drafts, extracted verbatim from their plans' §R-close.

    python3 data/crunch-2026-09-25/j44/apply_ledger.py [--plant]   # --plant: demand a row the plans do not hold; must exit 1
Idempotence guard: refuses to run if any of rows 111-115 is already in LEDGER.md.
"""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
led_p = ROOT / "LEDGER.md"
led = led_p.read_text(encoding="utf-8")
r88 = (ROOT / "plans/FS86-row88-rigidity.md").read_text(encoding="utf-8").splitlines()
f67 = (ROOT / "plans/FS67-tight-products.md").read_text(encoding="utf-8").splitlines()
bdraft = (ROOT / "data/fs86r88/j41/ledger-b-draft.md").read_text(encoding="utf-8").splitlines()

def one(lines, prefix):
    hits = [l for l in lines if l.startswith(prefix)]
    if len(hits) != 1:
        sys.exit(f"FAIL: {prefix!r} found {len(hits)} times (need 1)")
    return hits[0]

want = ["| 111 |", "| 112 |", "| 113 |", "| 114 |", "| 115 |"]
if "--plant" in sys.argv:
    want.append("| 116 |")
for w in want[:5]:
    if any(l.startswith(w) for l in led.splitlines()):
        sys.exit(f"FAIL: {w} already in LEDGER.md (already applied?)")
rows = [one(r88, w) for w in want[:3]] + [one(f67, w) for w in want[3:]]
if "--plant" in sys.argv:
    one(f67, "| 116 |")
b88 = [l for l in bdraft if l.startswith("| R88-")]
b67 = [l for l in f67 if l.startswith("| FS67-")]
assert len(b88) == 19, len(b88)
assert len(b67) == 20, len(b67)
# owner ruling (J44 brief): FS67-CL's grade
old_cl = "| hand (one mind, one-step check) |"
new_cl = "| hand, one mind (J40) + a one-step check (J42) |"
i = [k for k, l in enumerate(b67) if l.startswith("| FS67-CL |")]
assert len(i) == 1 and b67[i[0]].count(old_cl) == 1
b67[i[0]] = b67[i[0]].replace(old_cl, new_cl)

L = led.splitlines()
k110 = [k for k, l in enumerate(L) if l.startswith("| 110 |")]
assert len(k110) == 1
L[k110[0] + 1:k110[0] + 1] = rows
# row 88: V2's finite-index step (row 111, R88-J28V-7)
k88 = [k for k, l in enumerate(L) if l.startswith("| 88 |")][0]
o = "every non-zero ideal has finite index (V2)"
assert L[k88].count(o) == 1
L[k88] = L[k88].replace(o, "every non-zero ideal has finite index (V2; for every real number field, with no Lemma R: `[LevitzMott1972]` Thm 2.3, row 111)")
# row 110: C14.2 (c)'s prior art (row 113)
k110 = [k for k, l in enumerate(L) if l.startswith("| 110 |")][0]
o = "**Prior art:** not found (M3 §R-close R3.10)."
assert L[k110].count(o) == 1
L[k110] = L[k110].replace(o, "**Prior art:** not found (M3 §R-close R3.10), except C14.2 (c) at `q = 2`, partly in print — `[BardestaniMallahiKarai2017]` §3.2 over `ℚ_p` (row 113).")
# header paragraph
hdr_o = "and 108–110\n(M3); its index is"
text = "\n".join(L) + ("\n" if led.endswith("\n") else "")
assert text.count(hdr_o) == 1, text.count(hdr_o)
text = text.replace(hdr_o, "and 108–110\n(M3), then row 88's question (rows 111–113) and FS-67 (rows 114–115), closed later the same day; its index is")
# § B: append after the last line of the table (the file ends with it)
body = text.rstrip("\n").splitlines()
assert body[-1].startswith("| M3-"), body[-1][:40]
body += b88 + b67
led_p.write_text("\n".join(body) + "\n", encoding="utf-8")
print(f"PASS: 5 rows, {len(b88)} + {len(b67)} § B lines, rows 88 and 110 corrected, header updated")
