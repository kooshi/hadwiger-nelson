#!/usr/bin/env python3
"""FS131-E5 readback: every quotation in the brief against the claim list, and every quotation in the claim list against its source.

Usage: python3 tools/fs131_e5_readback.py [--plant]
--plant corrupts one character of one source excerpt in memory, and the check must then fail (the control).
Exit 0 iff every quotation is found verbatim (whitespace runs collapsed) in its source.
"""
import re, subprocess, sys

ROOT = "/home/kooshi/source/lean-dir"
plant = "--plant" in sys.argv

def git_show(rev, path):
    return subprocess.run(["git", "-C", ROOT, "show", f"{rev}:{path}"], capture_output=True, text=True, check=True).stdout

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

claims = open(f"{ROOT}/data/fs131/claims-E5.md").read()
brief = open(f"{ROOT}/data/fs131/briefs/FS131-E5-two-steps.md").read()
inv = open(f"{ROOT}/plans/FS131-close-inventory.md").read()

fails = []
checks = 0

def check(label, quote, source):
    global checks
    checks += 1
    q = norm(quote)
    if plant and checks == 1:
        q = q[:40] + ("X" if q[40] != "X" else "Y") + q[41:]
    if q not in norm(source):
        fails.append(label)
        print(f"  MISMATCH {label}")
    else:
        print(f"  ok       {label}")

# 1. Lean code blocks in the claim list, against their commits.
blocks = re.findall(r"```lean\n(.*?)```", claims, re.S)
lean_src = {
    0: ("a804de21", "Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean"),
    1: ("a804de21", "Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean"),
    2: ("71cca146", "Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean"),
    3: ("71cca146", "Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean"),
    4: ("a804de21", "Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean"),
}
print(f"lean blocks in the claim list: {len(blocks)}")
for i, b in enumerate(blocks):
    rev, path = lean_src[i]
    check(f"claim-list lean block {i} vs {rev}:{path}", b, git_show(rev, path))

# 2. Markdown excerpts against plans/ at HEAD (the files are on main).
def section(after, before):
    i = claims.index(after) + len(after)
    j = claims.index(before, i)
    return claims[i:j]
nb3 = open(f"{ROOT}/plans/FS112-NB3-verification.md").read()
cvb = open(f"{ROOT}/plans/FS114-CVB-verification.md").read()
nb3_ex = section("l. 225–243\n", "### `bend_away`")
for k, para in enumerate([p for p in re.split(r"\n(?=\d\. )", nb3_ex) if p.strip()]):
    # the trailing "### 1.5 Summary of stage 1" heading is in the excerpt too
    for piece in [x for x in para.split("\n\n") if x.strip()]:
        check(f"NB3 excerpt piece {k}", piece, nb3)
cvb5 = section("l. 99–102 (added 2026-10-05: item 307)\n", "### FS114-CVB § 1.7")
check("CVB 1.4 item 5", cvb5, cvb)
cvb7 = section("l. 184–187 (added 2026-10-05: item 307)\n", "### The findings")
check("CVB 1.7 None case", cvb7, cvb)

# 3. The brief's quotations: the questions against the claim list; inventory items' first lines against the inventory.
for m in re.finditer(r"> (\*\*Q[12] .*?)\n> — source: data/fs131/claims-E5.md", brief, re.S):
    check(f"brief question {m.group(1)[:8]}", m.group(1), claims)
for m in re.finditer(r"> (\d{3}\. .*?)\n> — source: plans/FS131-close-inventory.md", brief, re.S):
    check(f"brief inventory {m.group(1)[:4]}", m.group(1), inv)

print(f"checks: {checks}  failures: {len(fails)}")
sys.exit(1 if fails else 0)
