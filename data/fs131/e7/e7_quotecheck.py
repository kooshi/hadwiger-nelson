#!/usr/bin/env python3
"""FS131-E7 stage 1: check every quotation in the brief against its source, and every statement/definition in the claim
list against the Lean file it names.  Exit 0 iff all match.  --plant corrupts one quotation to show the check fires."""
import re, sys, pathlib, subprocess
ROOT = pathlib.Path(__file__).resolve().parents[3]
BRIEF = ROOT / "data/fs131/briefs/FS131-E7-models.md"
CLAIMS = ROOT / "data/fs131/claims-E7.md"
plant = "--plant" in sys.argv
def norm(s): return re.sub(r"\s+", " ", s).strip()
fails = 0; n = 0
# 1. brief quotations: blocks of "> text" lines followed by "> — source: <path> [§ ...]"
lines = BRIEF.read_text().splitlines()
i = 0
while i < len(lines):
    if lines[i].startswith("> ") and not lines[i].startswith("> — source:"):
        buf = []
        while i < len(lines) and lines[i].startswith(">") and not lines[i].startswith("> — source:"):
            buf.append(lines[i][1:].lstrip(" ") if not lines[i].startswith(">   ") else lines[i][2:]); i += 1
        src = lines[i] if i < len(lines) and lines[i].startswith("> — source:") else None
        if src is None: print("NO SOURCE for", buf[0][:60]); fails += 1; continue
        path = src.split("source:")[1].strip().split(" ")[0]
        text = "\n".join(buf)
        if plant and n == 0: text = text.replace("structure", "strcuture")
        n += 1
        p = ROOT / path
        body = norm(p.read_text())
        ok = norm(text) in body
        print(("ok   " if ok else "FAIL ") + f"brief quote {n}: {path}: {norm(text)[:70]}…")
        fails += (not ok)
    i += 1
# 2. claim list: fenced lean blocks followed by "*source: `path` l. N*"
txt = CLAIMS.read_text()
for m in re.finditer(r"```lean\n(.*?)```\n\*source: `([^`]+)` l\. (\d+)\*", txt, re.S):
    code, path, ln = m.group(1), m.group(2), int(m.group(3))
    p = pathlib.Path(path) if path.startswith("/") else ROOT / path
    src = p.read_text()
    n += 1
    ok = norm(code) in norm(src)
    # line number: the declaration keyword line
    decl = [l for l in code.splitlines() if re.match(r"\s*(theorem|def|noncomputable def|structure|abbrev)", l)]
    lnok = bool(decl) and src.splitlines()[ln-1].strip() == decl[0].strip()
    # a file in another job's live worktree moves under us: there the text is checked and a drifted line number is reported, not failed
    if not lnok and ok and "/.claude/worktrees/" in str(p):
        now = [i + 1 for i, l in enumerate(src.splitlines()) if l.strip() == decl[0].strip()]
        print(f"note  claim block {n}: line drifted in a live worktree: claim list says {ln}, now {now}")
        lnok = True
    print(("ok   " if ok and lnok else "FAIL ") + f"claim block {n}: {path} l.{ln} text={'ok' if ok else 'MISMATCH'} line={'ok' if lnok else 'MISMATCH'}: {decl[0].strip()[:60] if decl else '?'}")
    fails += (not (ok and lnok))
print(f"quotations checked: {n}  failures: {fails}")
sys.exit(1 if fails else 0)
