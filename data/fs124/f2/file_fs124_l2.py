# FS124-F2: the filing after FS124-L2's landing: drafts 1-15 of plans/FS124-L2-landing.md § Drafts for the front page (FS124-L2),
# each applied at its slot, each slot asserted to occur once. Texts are read from the record's block quotes, never retyped.
# Nothing is written until every slot has been found. Pattern: data/fs124/l1/file_fs124_landed.py.
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS124-L2-landing.md"); i = rec.index("## Drafts for the front page (FS124-L2)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
def block(n):
    a = D.index(f"\n**{n}. "); m = re.search(r"\n\*\*%d\. " % (n + 1), D); b = m.start() if m else len(D); return D[a:b]
def quotes(n, B=None):
    out = []; cur = None
    for l in (B or block(n)).split("\n"):
        s = l.strip()
        if s.startswith("> "): cur = (cur or []) + [s[2:]]
        elif s == ">" and cur is not None: cur.append("")
        else:
            if cur: out.append(cur); cur = None
    if cur: out.append(cur)
    return out
def flat(lines): return re.sub(r"\s+", " ", " ".join(lines)).strip()
def fb(n): return re.sub(r"\s+", " ", block(n))
def swapws(s, old, new, name):
    pat = r"\s+".join(re.escape(t) for t in old.split()); ms = list(re.finditer(pat, s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once"); return s[:ms[0].start()] + new + s[ms[0].end():]
def after(s, anchor, add, name):
    pat = r"\s+".join(re.escape(t) for t in anchor.split()); ms = list(re.finditer(pat, s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once"); return s[:ms[0].end()] + add + s[ms[0].end():]
def repl_pairs(n):  # *replaces* "old" *by* "new" in the flattened block
    return re.findall(r'\*replaces\* "(.*?)" \*by\* "(.*?)"(?=[;.]| —)', fb(n), flags=re.I)

# ---- CLAUDE.md
C = rd("CLAUDE.md")
C = swapws(C, "the current audit reads 6967 clean and 5 declared purchases, and 23 imported (and 20 axiom-free; 7,015 records at the landing of FS-124's disc criterion, FS124-L1, 2026-10-07)", flat(quotes(1)[0]), "D1")
LOG.append("D2: the nine counts stand; nothing changed")
C = swapws(C, "`declarations=15370 refutations-skipped=226 sites=1448`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`.", flat(quotes(3)[0]), "D3")
old5 = "its second is being planned; Closed when its modules pass the gate."
new5 = flat(quotes(5)[0])
C = swapws(C, old5, new5, "D5-CLAUDE")
p6 = repl_pairs(6); assert len(p6) == 3, p6
for k, (o, n) in enumerate(p6): C = swapws(C, o, n, f"D6.{k+1}")
p7 = repl_pairs(7); assert len(p7) == 1, p7
C = swapws(C, p7[0][0], p7[0][1], "D7")
OUT["CLAUDE.md"] = C
# ---- plans/FRONTIER-STUBS.md
F = rd("plans/FRONTIER-STUBS.md"); F = swapws(F, old5, new5, "D5-STUBS"); OUT["plans/FRONTIER-STUBS.md"] = F
# ---- the audit tool
T = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(4), flags=re.S).group(1)
a = '    (("6910", "5"), ("6967", "5")): '; assert T.count(a) == 1 and '("7364", "5")' not in T
k = T.index(a); e = T.index("\n", k); T = T[:e + 1] + g + "\n" + T[e + 1:]; LOG.append("D4a: GATE_CHANGES entry inserted after the L1 entry")
a2 = '    "6953": "superseded gate count, refiled at FS124-L1\'s landing'; assert T.count(a2) == 1; k = T.index(a2); e = T.index("\n", k)
ax = "data/fs124/l2/gate/receipt-axioms-final.log"; vc = "data/fs124/l2/gate/receipt-vacuity-final.log"
tail = "; the old count stays in data/fs124/l1/gate/ and in GATE_CHANGES"
sup = [("6967", ax, "7364 clean"), ("7,015", ax, "7,420 records"), ("20 axiom-free", ax, "28 axiom-free"),
       ("declarations=15370", vc, "15928"), ("refutations-skipped=226", vc, "228")]
add = "".join(f'    "{key}": "superseded gate count, refiled at FS124-L2\'s landing from {src} ({new}){tail}",\n' for key, src, new in sup)
T = T[:e + 1] + add + T[e + 1:]; LOG.append("D4b: superseded-count entries: " + ", ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = T
# ---- LEDGER.md rows 162-164
L = rd("LEDGER.md")
g8 = "**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; C124-SHADOW-OPEN, C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE are in the kernel lane's second module, being planned."
g9 = "**Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; **a second mind is owed on C124-LONE's Step II**, on which C124-BOTH, C124-FOUR and C124-SECOND rest (its deriver's line; the kernel lane's second module is that mind, blind first); one topological input of C124-FORCED is recalled, not read."
g10 = "**Grade:** [hand] with an exact check, one mind, kernel pending; it rests on C124-TYPE and on no entry of row 163."
def row_edit(L, rown, old, new, addr, name):
    rows = [l for l in L.split("\n") if l.startswith(f"| {rown} |")]; assert len(rows) == 1
    r = rows[0]; pat = r"\s+".join(re.escape(t) for t in old.split()); assert len(re.findall(pat, r)) == 1, name
    r2 = re.sub(pat, lambda m: new, r)
    if addr:
        assert r2.endswith(" | FS-124 (2026-10-07) |"); h = r2.rindex(" | FS-124 (2026-10-07) |")
        r2 = r2[:h] + "; " + addr + r2[h:]
    LOG.append(f"{name}: slot found once in row {rown}"); return L.replace(r, r2)
ad8 = re.search(r'\*add\* "(.*?)"\.', fb(8)).group(1); ad9 = re.search(r'\*add\* "(.*?)"\.', fb(9)).group(1)
L = row_edit(L, 162, g8, flat(quotes(8)[0]), ad8, "D8a+b")
L = row_edit(L, 163, g9, flat(quotes(9)[0]), ad9, "D9a+b")
L = row_edit(L, 164, g10, flat(quotes(10)[0]), None, "D10")
OUT["LEDGER.md"] = L
# ---- the theorem record
d = rd("plans/FS124-derivation.md"); q11 = quotes(11); assert len(q11) == 2, len(q11)
d = swapws(d, 'nine entries (marked "second module") are being planned blind on branch `fs124-wk2`; the rest have no kernel job.',
           'nine entries (marked "second module") are kernel theorems through the gate (FS124-L2; eight modules, 340 theorems); the rest have no kernel job.', "D11b")
d = swapws(d, "(the θ-curve form of the Jordan–Schoenflies theorem: recalled, not read)", flat(q11[1]), "D11c")
# (a) one dated line, placed once: after the head paragraph that states the kernel lane's state, before the FS-136 dated paragraph
anchor = "by its\nderiver's own line, before what rests on it is built on outside this milestone (§ 3).\n"
assert d.count(anchor) == 1, d.count(anchor)
d = d.replace(anchor, anchor + "\n" + flat(q11[0]) + "\n"); LOG.append("D11a: dated line inserted after the head paragraph")
OUT["plans/FS124-derivation.md"] = d
# ---- LEAN.md
M = rd("LEAN.md"); q12 = quotes(12)
assert len(q12) == 3, len(q12)
t4 = rd("plans/FS124-I4-implementation.md"); a4 = t4.index("7. **`LEAN.md` § Searching — Lean**, three lines:")
# I4's section runs to the next numbered item or the next heading
m4 = re.search(r"\n(?:\d+\. \*\*|## )", t4[a4 + 10:]); s4 = t4[a4: a4 + 10 + (m4.start() if m4 else len(t4) - a4)]
def parse_bul(sec, want, name):
    out = []; cur = None
    for l in sec.split("\n"):
        if cur is None and re.match(r'^\s+- "', l): cur = [l.strip()[3:]]
        elif cur is not None: cur.append(l.strip())
        if cur is not None and cur[-1].endswith('"'):
            out.append(re.sub(r"\s+", " ", " ".join(cur)).strip()[:-1]); cur = None
    assert cur is None and len(out) == want, (name, len(out)); return out
b2 = parse_bul(rd("plans/FS124-I2-implementation.md").split("- **`LEAN.md` § Searching — Lean**, three lines:")[1].split("\n## Drafts for the front page")[0], 3, "I2")
b3 = parse_bul(rd("plans/FS124-I3-implementation.md").split("- **`LEAN.md` § Searching — Lean**, lines offered")[1].split("\n## Drafts for the front page")[0], 6, "I3")
b4 = parse_bul(s4, 3, "I4")
k3 = re.search(r'one line: "(.*?\(FS124-K3\)\.)"', rd("plans/FS124-kernel-plan-3.md"), flags=re.S).group(1); b_k3 = [re.sub(r"\s+", " ", k3).strip()]
t5 = rd("plans/FS124-I5-implementation.md"); s5 = t5.split("7. **`LEAN.md` § Searching — Lean**, two lines beside the planner's (§ 4.5, second item):")[1]
b5 = parse_bul(s5.split("\n\n")[0] if False else s5[:s5.index("\n\n")] if "\n\n" in s5 else s5, 2, "I5")
lines = [f"- {x}" for x in b2 + b3 + b4 + b_k3 + b5]; assert len(lines) == 15
land = flat(q12[0]); assert land.startswith("- A landing shows"); lines.append(land)
anchor = "`LinearIsometryEquiv.measurePreserving` is in the closure (FS124-I1)."
assert M.count(anchor) == 1; M = M.replace(anchor, anchor + "\n" + "\n".join(lines)); LOG.append("D12a: 16 bullets inserted after the FS124-I1 bullet")
M = after(M, "(FS124-L1, its record's stage 6: seven, six, five).", " " + flat(q12[1]), "D12b")
ls = M.split("\n"); s = [n for n, l in enumerate(ls) if l.startswith("- **`./scripts/assumptions.sh` and")]; assert len(s) == 1
e = s[0] + 1
while e < len(ls) and ls[e].startswith("  "): e += 1
ls[e - 1] = ls[e - 1].rstrip() + " " + flat(q12[2]); LOG.append("D12c: appended at the end of the assumptions.sh bullet"); M = "\n".join(ls)
OUT["LEAN.md"] = M
LOG.append("D13: the Proof Atlas: not filed by this script (see the report)")
LOG.append("D14: ARCHITECTURE.md: nothing to file"); LOG.append("D15: BIBLIOGRAPHY.md: nothing to file")
if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
