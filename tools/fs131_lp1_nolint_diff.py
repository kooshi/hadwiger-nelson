#!/usr/bin/env python3
"""FS131-LP1 (Amendment 1): the regenerated modules differ from REV only by the nolint lines.  For every generated
module whose table has `nolint` entries, the file at REV and the file now are compared line by line
(difflib, no junk heuristic): every difference must be, for one entry each, the comment line
`-- nolint (FS131-LP1, inventory item 831): <reason class>, kept as it is (<linter>)` followed by either the line
`@[nolint <linter>]` directly before the declaration's keyword line, or the keyword line itself with `nolint <linter>, `
inserted at the head of its attribute block; and every entry must be met once.  Any other difference, in any file
under Proofs/ or Proofs.lean, fails.  Usage: fs131_lp1_nolint_diff.py REV [--plant]   (--plant changes one character of
one regenerated line in memory, and adds one stray line to another module, each of which must be reported)"""
import difflib
import importlib.util
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("g", ROOT / "tools/fs131_ko1_port.py")
g = importlib.util.module_from_spec(spec)
spec.loader.exec_module(g)
rev = sys.argv[1]
plant = "--plant" in sys.argv


def show(path):
    r = subprocess.run(["git", "-C", str(ROOT), "show", f"{rev}:{path}"], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else None


changed = subprocess.run(["git", "-C", str(ROOT), "diff", "--name-only", rev, "--", "Proofs", "Proofs.lean"],
                         capture_output=True, text=True).stdout.split()
tables = {p.stem: json.loads(p.read_text()) for p in sorted((ROOT / "data/fs131/ko1/port").glob("*.json"))}
want = {m: t.get("nolint", []) for m, t in tables.items() if t.get("nolint")}
bad, met = [], {}
files = sorted(set(changed) | {f"Proofs/HadwigerNelson/Outside/{m}.lean" for m in want})
planted_once = [False, False]
for f in files:
    mod = Path(f).stem
    old = (show(f) or "").split("\n")
    new = (ROOT / f).read_text().split("\n")
    if plant and mod in want and not planted_once[0]:
        k = next(i for i, x in enumerate(new) if x.lstrip().startswith("@[nolint"))
        new[k] = new[k].replace("@[nolint ", "@[nolint  ", 1)
        planted_once[0] = True
    elif plant and mod in want and not planted_once[1]:
        new.insert(3, "-- a stray line")
        planted_once[1] = True
    ents = want.get(mod, [])
    for op, i1, i2, j1, j2 in difflib.SequenceMatcher(None, old, new, autojunk=False).get_opcodes():
        if op == "equal":
            continue
        added, removed = new[j1:j2], old[i1:i2]
        k, ok = 0, True
        while k < len(added) and ok:
            m = re.fullmatch(r"\s*-- nolint \(FS131-LP1, inventory item 831\): (.+), kept as it is \((\w+)\)", added[k])
            if not m:
                ok = False
                break
            cls, lin = m.group(1), m.group(2)
            nxt = added[k + 1] if k + 1 < len(added) else None
            if nxt is not None and re.fullmatch(rf"\s*@\[nolint {lin}\]", nxt):
                k += 2
                kind = "line"
            elif nxt is not None and removed and nxt == removed[0].replace("@[", f"@[nolint {lin}, ", 1) and nxt != removed[0]:
                removed = removed[1:]
                k += 2
                kind = "merged"
            else:
                ok = False
                break
            hit = [e for e in ents if e[1] == lin and g.NOLINT_REASONS[e[2]] == cls]
            if not hit:
                ok = False
                break
            met.setdefault(mod, []).append((lin, cls, kind))
        if not ok or removed:
            bad.append(f"{f}: an unexplained difference at lines {i1 + 1}–{i2} / {j1 + 1}–{j2}: "
                       f"{[x[:80] for x in old[i1:i2]]} -> {[x[:80] for x in new[j1:j2]]}")
for mod, ents in want.items():
    n_met = len(met.get(mod, []))
    if n_met != len(ents):
        bad.append(f"{mod}: {len(ents)} entries, {n_met} met in the text")
lines = sum(len(v) for v in met.values())
merged = sum(1 for v in met.values() for x in v if x[2] == "merged")
for b in bad:
    print("FAIL", b)
print(f"nolint diff against {rev}: {len(files)} files, {lines} entries met ({merged} merged into an attribute block), "
      f"{len(bad)} unexplained")
print("NOLINT-DIFF " + ("OK" if not bad else "FAILED"))
sys.exit(1 if bad else 0)
