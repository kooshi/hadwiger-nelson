#!/usr/bin/env python3
"""FS131-LP1 (Amendment 1): the generator tables' `nolint` entries, read from the guarded lint's own log — every finding
the lint reported on a declaration of a generated module, by linter, with its reason class by linter
(defsWithUnderscore: the release's name; unusedArguments: the release's binder; simpNF: simp's normal form of the
release's lemma).  Refuses a finding outside `Proofs/HadwigerNelson/Outside/OAI158*` that is not the lint control's
plant, a linter with no class, and a module whose table already holds a nolint entry.  Writes each table in its own
format (`json.dumps(…, indent=1, ensure_ascii=False)`, no final newline).  Usage: add_entries.py LINT_LOG"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
REASON = {"defsWithUnderscore": "name", "unusedArguments": "binder", "simpNF": "simpnf"}
log = Path(sys.argv[1]).read_text().split("\n")
cur, finds = None, []
for ln in log:
    m = re.match(r"^/- The `(\w+)` linter reports:", ln)
    if m:
        cur = m.group(1)
    m = re.match(r"^\S*?(Proofs/HadwigerNelson/[\w/]+\.lean):\d+:\d+: error: @?(\S+) ", ln)
    if m:
        finds.append((cur, m.group(1), m.group(2)))
by_mod = {}
for lin, path, decl in finds:
    if decl.startswith("zz_lp1_lint_plant"):
        continue
    mm = re.fullmatch(r"Proofs/HadwigerNelson/Outside/(OAI158\w+)\.lean", path)
    if not mm or lin not in REASON:
        raise SystemExit(f"REFUSED: {lin} {path} {decl}")
    by_mod.setdefault(mm.group(1), []).append([decl, lin, REASON[lin]])
n = 0
for mod, ents in sorted(by_mod.items()):
    p = ROOT / "data/fs131/ko1/port" / f"{mod}.json"
    t = json.loads(p.read_text())
    if t.get("nolint"):
        raise SystemExit(f"REFUSED: {mod} already has nolint entries")
    t["nolint"] = ents
    p.write_text(json.dumps(t, indent=1, ensure_ascii=False))
    n += len(ents)
    print(f"{mod}: {len(ents)} — " + ", ".join(f"{e[0].rsplit('.', 1)[-1]} ({e[1]})" for e in ents))
print(f"ENTRIES: {n} in {len(by_mod)} tables")
