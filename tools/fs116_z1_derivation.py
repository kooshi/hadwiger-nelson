#!/usr/bin/env python3
"""FS116-Z1: assemble plans/FS116-derivation.md from the FS-116 job records' own `derivation:` blocks (copied verbatim, field by field), with
the close's changes made explicit below: qualified ids, record-prefixed argument addresses, the minds the verifiers counted, the corrected
statements the verifiers drafted (each a named string substitution on the frozen text, applied only if the frozen text is found — else the run
fails), and a prose paragraph under every entry ending in "Rests on it:". Usage: python3 tools/fs116_z1_derivation.py > plans/FS116-derivation.md"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
P = ROOT / "plans"

def blocks(path):
    out, lines, i = {}, (P / path).read_text(encoding="utf-8").split("\n"), 0
    fence = False
    while i < len(lines):
        l = lines[i]
        if l.startswith("```"): fence = not fence
        m = re.match(r"^(derivation|control): (\S+)", l)
        if m and not fence:
            j = i
            while j < len(lines) and lines[j].strip(): j += 1
            out.setdefault((m.group(1), m.group(2)), lines[i:j]); i = j
        else: i += 1
    return out

def fields(blk):
    fs, cur = [], None
    for l in blk[1:]:
        m = re.match(r"^  ([a-z][a-z ]*): ?(.*)$", l)
        if m: cur = [m.group(1), m.group(2)]; fs.append(cur)
        elif cur: cur[1] += " " + l.strip()
    return fs

def wrap(name, val, width=150):
    words, out, line = val.split(), [], f"  {name}:"
    for w in words:
        if len(line) + 1 + len(w) > width and line.strip() != f"{name}:":
            out.append(line); line = "    " + w
        else: line += " " + w
    out.append(line); return out

REC = {"O1": "FS116-local-exclusion.md", "N1": "FS116-N1-proof.md", "N2": "FS116-N2-proof.md", "N3": "FS116-N3-proof.md",
       "S1": "FS116-S1-proof.md", "Y1": "FS116-Y1-construction.md", "Y2": "FS116-Y2-construction.md", "Y3": "FS116-Y3-construction.md",
       "Y4": "FS116-Y4-construction.md", "V3": "FS116-V3-verification.md", "V4": "FS116-V4-verification.md", "V5": "FS116-V5-verification.md"}
RENAME = {"RING-TWIST-C": "FS116-RING-TWIST-C", "RING-GERM": "FS116-RING-GERM", "RING-Q-PRIME": "FS116-RING-Q-PRIME",
          "RING-TWIST-Q": "FS116-RING-TWIST-Q", "RING-Q": "FS116-RING-Q", "RING-Q-PRIME-S": "FS116-RING-Q-PRIME-S", "SAT-QFREE": "FS116-SAT-QFREE",
          "SAT-STRIP": "FS116-SAT-STRIP", "Y-SAT": "FS116-Y-SAT", "RING-TRANSFER-C": "FS116-RING-TRANSFER-C", "RING-TRANSFER-QC": "FS116-RING-TRANSFER-QC",
          "RING-TRANSFER-Q": "FS116-RING-TRANSFER-Q", "SEMI-PAR3": "FS116-SEMI-PAR3"}
for n in ("CHORD", "DICHOTOMY", "MEET", "TWIST", "PARTNER", "OUTER"): RENAME[f"V4-{n}"] = f"FS116-V4-{n}"
for n in ("NE1", "RING", "GERM", "OUT", "TIPSET", "LENS", "QCOL", "U1", "OUT2", "DICHO"): RENAME[f"V5-{n}"] = f"FS116-V5-{n}"
def nid(n): return RENAME.get(n, n)
def ren(text):
    return re.sub(r"(?<![\w-])(" + "|".join(sorted(map(re.escape, RENAME), key=len, reverse=True)) + r")(?![\w-])", lambda m: RENAME[m.group(1)], text)

from fs116_z1_notes import SECTIONS, HAND, MINDS, SUBS, FIELD, NOTE, EXTRA, CONTROLS, HEADER

cache, entries = {}, []   # entries: (section, id, [(field, value)], record key or None)
for sec, items in SECTIONS:
    for key, old in items:
        if key == "HAND":
            entries.append((sec, old, HAND[old], None)); continue
        if key not in cache: cache[key] = blocks(REC[key])
        blk = cache[key].get(("derivation", old))
        if blk is None: sys.exit(f"FAIL: no block {old} in {REC[key]}")
        fs = fields(blk); new = nid(old)
        for f in fs:
            if f[0] == "argument" and f[1].startswith("§"): f[1] = f"{REC[key]} {f[1]}"
            if f[0] == "converse" and f[1].startswith("§"): f[1] = f"{REC[key]} {f[1]}"
            if f[0] == "grade": f[1] = ren(f[1])
            if f[0] == "minds" and new in MINDS: f[1] = MINDS[new]
            if f[0] == "statement" and new in SUBS:
                for a, b in SUBS[new]:
                    if a not in f[1]: sys.exit(f"FAIL: {new}: the frozen text {a!r} is not in the statement")
                    f[1] = f[1].replace(a, b)
            if (new, f[0]) in FIELD: f[1] = FIELD[(new, f[0])]
        have = {f[0] for f in fs}
        for (eid, fname), val in FIELD.items():
            if eid == new and fname not in have:
                at = next(i for i, f in enumerate(fs) if f[0] == "not claimed") + 1
                fs.insert(at, [fname, val])
        entries.append((sec, new, fs, key))

ids = [e[1] for e in entries]
def cites(fs, target, olds):
    txt = " ".join(v for k, v in fs if k in ("uses only", "grade"))
    return any(re.search(r"(?<![\w-])" + re.escape(t) + r"(?![\w-])", txt) for t in [target] + olds)
INV = {}
for k, v in RENAME.items(): INV.setdefault(v, []).append(k)

print(HEADER)
cur = None
for sec, new, fs, key in entries:
    if sec != cur: print(f"## {sec}\n"); cur = sec
    print(f"derivation: {new}")
    for k, v in fs: print("\n".join(wrap(k, v)))
    print()
    users = [e[1] for e in entries if e[1] != new and cites(e[2], new, INV.get(new, []))]
    rest = ("; ".join(users) if users else "nothing in this file") + (("; " + EXTRA[new]) if new in EXTRA else "")
    print((NOTE.get(new, "") + " " if NOTE.get(new) else "") + f"Rests on it: {rest}.\n")
    for c in CONTROLS.get(new, []):
        ck, cname, newof = c
        if ck not in cache: cache[ck] = blocks(REC.get(ck, ck))
        cb = cache[ck].get(("control", cname))
        if cb is None: sys.exit(f"FAIL: no control {cname}")
        out = []
        for l in cb:
            if l.startswith("  of: "): l = "  of: " + newof + " — " + l[6:].split(" — ", 1)[-1]
            out.append(l)
        print("\n".join(out)); print()
