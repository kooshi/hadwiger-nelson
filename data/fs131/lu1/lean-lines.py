#!/usr/bin/env python3
"""FS131-LU1: the `LEAN.md` § Searching — Lean lines the module's four records drafted, copied by script (never
retyped), and each backticked identifier of each line looked for in the three gated modules.

Sources (each a bulleted list under a heading of its record):
  plans/FS131-KN2-upper-half-plan.md      "### Drafts — `LEAN.md` § Searching — Lean (Keryx's)"         lines 1-3 of 4
  plans/FS131-IU1-implementation.md       "- **`LEAN.md` § Searching — Lean**, four lines:"              4
  plans/FS131-IQ1-implementation.md       "### For `LEAN.md` § Searching — Lean …"                       4
  plans/FS131-IV1-implementation.md       "### 7. `LEAN.md` § Searching — Lean …"                        lines 1-5 of 6
Prints each line as a blockquoted bullet, then for each line the dotted identifiers it names in backticks and whether
each occurs in the three modules (by its last component): `in the modules`, or `NOT in the modules` — a name of a
tool, a file, a deprecated lemma the line warns against, or a statement's own text is expected there and is read by
hand.  Exit 0 always: this is a copy and a listing, not a gate."""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
MODS = "".join((ROOT / "Proofs/HadwigerNelson" / f).read_text(encoding="utf-8") for f in
               ("Arith/UpperHalf.lean", "Arith/QuadraticPrime.lean", "Instances/UpperHalfValues.lean"))


def bullets(path, start, stop, indent):
    """the bulleted items between the line containing `start` and the first line matching `stop`, at `indent`."""
    lines = (ROOT / path).read_text(encoding="utf-8").split("\n")
    i = next(k for k, ln in enumerate(lines) if start in ln) + 1
    out, cur = [], None
    for ln in lines[i:]:
        if re.match(stop, ln):
            break
        if ln.startswith(indent + "- "):
            if cur is not None:
                out.append(cur)
            cur = ln[len(indent) + 2:]
        elif cur is not None and ln.strip():
            cur += " " + ln.strip()
    if cur is not None:
        out.append(cur)
    return out


SRC = [
    ("FS131-KN2", "plans/FS131-KN2-upper-half-plan.md", "### Drafts — `LEAN.md` § Searching — Lean (Keryx's)", r"^### ", "", slice(0, 3)),
    ("FS131-IU1", "plans/FS131-IU1-implementation.md", "- **`LEAN.md` § Searching — Lean**, four lines:", r"^- \*\*", "  ", slice(0, 4)),
    ("FS131-IQ1", "plans/FS131-IQ1-implementation.md", "### For `LEAN.md` § Searching — Lean", r"^#", "", slice(0, 4)),
    ("FS131-IV1", "plans/FS131-IV1-implementation.md", "### 7. `LEAN.md` § Searching — Lean", r"^#", "", slice(0, 5)),
]
quoted, report = [], []
for job, path, start, stop, indent, sl in SRC:
    items = bullets(path, start, stop, indent)[sl]
    report.append(f"{job}: {len(items)} line(s) from {path}")
    for it in items:
        quoted.append("> - " + it)
        for name in sorted(set(re.findall(r"`([A-Za-z_][\w']*(?:\.[\w']+)+)`", it))):
            if name.endswith((".py", ".lean", ".sh", ".txt", ".md")) or "/" in name:
                continue
            last = name.split(".")[-1]
            report.append(f"    {'in the modules    ' if re.search(r'(?<![\w.])' + re.escape(last) + r'(?![\w])', MODS) or name in MODS else 'NOT in the modules'} {name}")
print("\n".join(quoted))
print("=== identifiers", file=sys.stderr)
print("\n".join(report), file=sys.stderr)
