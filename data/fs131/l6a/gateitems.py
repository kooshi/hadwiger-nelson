#!/usr/bin/env python3
"""FS131-L6A: the mechanical part of "the open gate items" — for each head of data/fs131/l6a/heads.txt, does its own docstring
carry an inhabitant note, and does its module's docstring carry an inhabitants paragraph? Read-only; the reading is by hand.
usage: python3 data/fs131/l6a/gateitems.py   (from the worktree root)"""
import importlib.util, os, re
spec = importlib.util.spec_from_file_location("stm", "tools/fs131_l6a_statements.py")
stm = importlib.util.module_from_spec(spec); spec.loader.exec_module(stm)
D = "Proofs/HadwigerNelson/Plane/Saturated/"
NOTE = re.compile(r"[Ii]nhabitant|INHABITANT|[Mm]odel\b|example below|examples? (after|below)|no model|none (is )?expected", re.S)
heads = [l.strip() for l in open("data/fs131/l6a/heads.txt", encoding="utf-8") if l.strip()]
decl = {}
for f in sorted(os.listdir(D)):
    if not f.endswith(".lean"):
        continue
    text = open(D + f, encoding="utf-8").read()
    m = re.search(r"/-!.*?-/", text, re.S)
    moddoc = bool(m and NOTE.search(m.group(0)))
    for qual, kind, doc, stmt, short in stm.chunks(text):
        if kind in ("theorem", "lemma"):
            hyp = bool(re.search(r"\(h\w*\s*:", stmt)) or bool(re.search(r"\(\w+ : [^)]*(Fan|IsolatedAt|TwoColourOn|IsUnitCurve)", stmt))
            decl.setdefault(qual, (f[:-5], bool(NOTE.search(doc)), moddoc, hyp, "False" in stmt.split(":")[-1]))
own = mod = none = nohyp = 0
for h in heads:
    if h not in decl:
        print(f"?? {h}: not found by the reader")
        continue
    f, note, moddoc, hyp, _ = decl[h]
    if not hyp:
        nohyp += 1; tag = "no explicit hypothesis"
    elif note:
        own += 1; tag = "own note"
    elif moddoc:
        mod += 1; tag = "MODULE-ONLY (no note of its own; its module docstring has an inhabitants paragraph)"
    else:
        none += 1; tag = "NO-NOTE"
    print(f"{f:16s} {h.replace('HadwigerNelson.Plane.', ''):48s} {tag}")
print(f"heads {len(heads)}: own note {own}, module only {mod}, no note {none}, no explicit hypothesis {nohyp}")
