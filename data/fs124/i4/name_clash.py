#!/usr/bin/env python3
"""FS124-I4: every name this job's helper module declares, looked for as a declaration of the same short name in the
same namespace path in `Proofs/` of the main working tree and of every worktree (text scan; `scripts/dupnames.sh` on the
built tree is the gate). Exit 0 iff no other file declares one. `--control` adds the name `fin_three_cases`
(declared by Plane/ThreePiece) to the list and must find it."""
import pathlib, re, sys, subprocess
ROOT = pathlib.Path(__file__).resolve().parents[3]
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
MINE = {"Proofs/HadwigerNelson/Plane/ClosePairWitness.lean"}
DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+|private\s+|protected\s+)*(?:theorem|def|lemma|abbrev|structure|inductive|instance)\s+([A-Za-z_][\w.'₀-₉]*)", re.M)
def names(path):
    text = path.read_text()
    out, ns = [], []
    for ln in text.splitlines():
        m = re.match(r"^namespace\s+(\S+)", ln)
        if m: ns.append(m.group(1)); continue
        m = re.match(r"^end\s+(\S+)", ln)
        if m and ns and ns[-1] == m.group(1): ns.pop(); continue
        m = DECL.match(ln)
        if m: out.append(".".join(ns + [m.group(1)]))
    return out
mine = []
for f in MINE:
    mine += names(ROOT / f)
if "--control" in sys.argv:
    mine.append("HadwigerNelson.Plane.fin_three_cases")
if not mine:
    print("NO NAMES READ: the reader is broken"); sys.exit(2)
trees = [MAIN] + sorted(p for p in (MAIN / ".claude/worktrees").iterdir() if (p / "Proofs").is_dir())
want = set(mine)
hits = []
for t in trees:
    for f in (t / "Proofs").rglob("*.lean"):
        rel = str(f.relative_to(t))
        if rel in MINE and t == ROOT: continue
        try:
            txt = f.read_text()
        except Exception:
            continue
        if not any(n.split(".")[-1] in txt for n in want): continue
        for n in names(f):
            if n in want: hits.append((n, str(f)))
print(f"names declared by this job's helper module: {len(mine)}; trees scanned: {len(trees)}")
for n, f in hits: print(f"CLASH {n}  {f}")
print("PASS: no other file declares one of them" if not hits else f"{len(set(n for n, _ in hits))} name(s) declared elsewhere")
sys.exit(1 if hits else 0)
