# FS131-FC1: the filing after FS131-LC1's landing: the drafts of plans/FS131-LC1-landing.md § Drafts for the front page (FS131-LC1),
# each applied at its slot, each slot asserted to occur once. Texts are read from the record's block quotes, never retyped.
# Nothing is written until every slot has been found. Pattern: data/fs124/f2/file_fs124_l2.py.
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS131-LC1-landing.md"); i = rec.index("## Drafts for the front page (FS131-LC1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
def block(n):
    a = D.index(f"\n**{n}. "); m = re.search(r"\n\*\*%d\. " % (n + 1), D); b = m.start() if m else len(D); return D[a:b]
def groups(n):
    out = []; cur = None
    for l in block(n).split("\n"):
        s = l.strip()
        if l.startswith("> ") or l == ">": cur = (cur or []) + [l[2:] if l.startswith("> ") else ""]
        else:
            if cur: out.append(cur); cur = None
    if cur: out.append(cur)
    return out
def flat(lines): return re.sub(r"\s+", " ", " ".join(lines)).strip()
def fb(n): return re.sub(r"\s+", " ", block(n))
def pat(s): return r"\s+".join(re.escape(t) for t in s.split())
def swapws(s, old, new, name):
    ms = list(re.finditer(pat(old), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once"); return s[:ms[0].start()] + new + s[ms[0].end():]
def after(s, anchor, add, name):
    ms = list(re.finditer(pat(anchor), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once"); return s[:ms[0].end()] + add + s[ms[0].end():]
def bullets(lines):
    out = []
    for l in lines:
        if l.startswith("- "): out.append([l])
        else: out[-1].append(l)
    return [flat(b) for b in out]

C = rd("CLAUDE.md")
C = swapws(C, "the current audit reads 7364 clean and 5 declared purchases, and 23 imported (and 28 axiom-free; 7,420 records at the landing of FS-124's second module, FS124-L2, 2026-10-07)", flat(groups(1)[0]), "D1")
C = swapws(C, "— a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with nine; no record rests on two of the three", flat(groups(2)[0]), "D2")
C = swapws(C, "`axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with twenty-three theorems resting on them", flat(groups(3)[0]), "D3")
C = swapws(C, "`declarations=15928 refutations-skipped=228 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`.", flat(groups(4)[0]), "D4")
C = swapws(C, "Falconer's everywhere-proper `χ_m` is one step further, a GAP; by Thm 1.4 `χ_m(ℝ²) ≥ χ_m⁰(ℝ²) ≥ 6`.", flat(groups(6)[0]), "D6")
OUT["CLAUDE.md"] = C
# ---- the audit tool (draft 5)
T = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(5), flags=re.S).group(1)
a = '    (("6967", "5"), ("7364", "5")): '; assert T.count(a) == 1 and '("7395", "5")' not in T
k = T.index(a); e = T.index("\n", k); T = T[:e + 1] + g + "\n" + T[e + 1:]; LOG.append("D5a: GATE_CHANGES entry inserted after the L2 entry")
a2 = '    "refutations-skipped=226": "superseded gate count, refiled at FS124-L2'; assert T.count(a2) == 1; k = T.index(a2); e = T.index("\n", k)
ax = "data/fs131/lc1/gate/receipt-axioms-final.log"; vc = "data/fs131/lc1/gate/receipt-vacuity-final.log"; asm = "data/fs131/lc1/gate/receipt-assumptions-final.log"
tail = "; the old count stays in data/fs124/l2/gate/ and in GATE_CHANGES"
sup = [("7364", ax, "7395 clean"), ("7,420", ax, "7,454 records"), ("23 imported", ax, "26 imported"),
       ("declarations=15928", vc, "15969"), ("sites=1448", vc, "1454"), ("generic=1405", vc, "1411"),
       ("rests=23", asm, "26"), ("with nine", asm, "twelve"), ("twenty-three theorems resting", asm, "twenty-six")]
for key, _, _ in sup: assert f'    "{key}":' not in T, key
add = "".join(f'    "{key}": "superseded gate count, refiled at FS131-LC1\'s landing from {src} ({new}){tail}",\n' for key, src, new in sup)
T = T[:e + 1] + add + T[e + 1:]; LOG.append("D5b: superseded-count entries: " + ", ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = T
# ---- LEDGER.md row 130 (draft 7)
L = rd("LEDGER.md"); B7 = fb(7)
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)"\s*- \*Follows\* "(.*?)" — the closing clause: "(.*?)"\s*- \*In the row\'s chain\*, "(.*?)" \*becomes\* "(.*?)"', B7)
assert m, "D7 parse"; o1, n1, fol, clause, o3, n3 = m.groups()
rows = [l for l in L.split("\n") if l.startswith("| 130 |")]; assert len(rows) == 1; r = rows[0]
r2 = swapws(r, o1, n1, "D7a"); r2 = after(r2, fol, " " + clause, "D7b"); assert o3.startswith("`") and n3.startswith("`"); r2 = swapws(r2, o3[1:], n3[1:], "D7c")  # the draft quotes a leading backtick the row does not have (CHECK in the report); the slot script drops it too
assert L.count(r) == 1; OUT["LEDGER.md"] = L.replace(r, r2)
# ---- LEAN.md (draft 8)
M = rd("LEAN.md"); g8 = groups(8); assert len(g8) == 3, len(g8)
sb = bullets(g8[0]); assert len(sb) == 4; bb = bullets(g8[1]); assert len(bb) == 1
M = after(M, "a module from another branch with a dump made in that branch's worktree (FS124-L2).", "\n" + "\n".join(sb), "D8a")
M = after(M, "`lake build --no-build` under the cap says so in two seconds. (FS124-K1).", "\n" + "\n".join(bb), "D8b")
M = after(M, "a landing reads each skipped declaration of its modules.", " " + flat(g8[2]), "D8c")
OUT["LEAN.md"] = M
# ---- BIBLIOGRAPHY.md (draft 9, first entry only)
Bb = rd("BIBLIOGRAPHY.md"); g9 = groups(9); assert len(g9) == 1
Bb = swapws(Bb, "**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`** (2026-10-13, from a text extraction; FS131-PN1); the proofs unread.", flat(g9[0]), "D9a")
OUT["BIBLIOGRAPHY.md"] = Bb
# ---- claim list (draft 11)
N = rd("data/fs131/claims-NF3.md"); g11 = groups(11); assert len(g11) == 1
anchor = "it is the step from \"almost every pair\" to sets with no pair at the distance that the library holds for the plane only.)"
ms = list(re.finditer(pat(anchor), N)); assert len(ms) == 1; e = N.index("\n", ms[0].end())
N = N[:e] + "\n" + flat(g11[0]) + N[e:]; LOG.append("D11: dated line inserted after the 18:00 UTC line"); OUT["data/fs131/claims-NF3.md"] = N
LOG.append("D12 Frontier clause: HELD (no slot named) - CHECK"); LOG.append("D12 atlas: HELD - CHECK"); LOG.append("D9b DeCorte reading line: HELD (position in the cell not named) - CHECK")
LOG.append("D10: no file or slot named - HELD - CHECK"); LOG.append("D13: not drafted as a replacement - nothing filed (correction owed)"); LOG.append("D14: nothing to file")
if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
