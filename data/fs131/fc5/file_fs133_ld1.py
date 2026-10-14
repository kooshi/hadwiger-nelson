# FS131-FC5: file the drafts of plans/FS133-LD1-landing.md § Drafts for the front page (FS133-LD1), each at its slot,
# every slot asserted once before anything is written. Texts are read from the records, never retyped.
# Pattern: data/fs131/fc4/file_fs131_lp1.py.  Usage: file_fs133_ld1.py [--dry]
import re, os, sys, importlib.util
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS133-LD1-landing.md"); i = rec.index("## Drafts for the front page (FS133-LD1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
def block(n):
    a = D.index(f"\n**{n}."); m = re.search(r"\n\*\*\d+[bc]?\.", D[a + 4:]); b = a + 4 + m.start() if m else len(D); return D[a:b]
def flat(s): return re.sub(r"\s+", " ", s).strip()
def fb(n): return flat(block(n))
def pat(s): return r"\s+".join(re.escape(t) for t in s.split())
def swapws(s, old, new, name):
    ms = list(re.finditer(pat(old), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once, replaced"); return s[:ms[0].start()] + new + s[ms[0].end():]
def after(s, anchor, add, name):
    ms = list(re.finditer(pat(anchor), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once, inserted after"); return s[:ms[0].end()] + add + s[ms[0].end():]
def quote_group(n, k=0, inner=False):
    gs = []; cur = None
    for l in block(n).split("\n"):
        if l.startswith("> ") or l == ">": cur = (cur or []) + [l[2:]]
        elif cur: gs.append(cur); cur = None
    if cur: gs.append(cur)
    g = gs[k]
    if inner: g = [x[2:] if x.startswith("> ") else x for x in g]
    return flat(" ".join(g))
sp = importlib.util.spec_from_file_location("slots", R + "data/fs133/ld1/drafts-slots.py"); sm = importlib.util.module_from_spec(sp)
src = open(R + "data/fs133/ld1/drafts-slots.py").read().split("\ndef norm")[0]   # the SLOTS table only
ns = {}; exec(compile(src, "slots", "exec"), ns); SL = {lab: s for lab, f, s in ns["SLOTS"]}
def K(prefix):
    ks = [k for k in SL if k.startswith(prefix)]; assert len(ks) == 1, (prefix, ks); return SL[ks[0]]

# ---------------- CLAUDE.md
C = rd("CLAUDE.md")
# 1
m = re.search(r'\*Replaces\* "(.*?)"\. From', fb(1)); assert flat(m.group(1)) == flat(K("1 the audit")), "D1 old"
C = swapws(C, m.group(1), quote_group(1), "D1")
# 1b
assert fb("1b").startswith('**1b.') and "*Follows* \"" + K("1b ") + "\" *with*" in fb("1b")
C = after(C, K("1b "), " " + quote_group("1b"), "D1b")
# 2
m = re.search(r'\*Replaces\* "(.*?)" From', fb(2)); assert flat(m.group(1)) == flat(K("2 ")), "D2 old"
C = swapws(C, m.group(1), quote_group(2), "D2")
# 3: no change; slot read
assert len(re.findall(pat(K("3 the nine")), C)) == 1; LOG.append("D3: counts stand (slot read once); nothing changed")
# 4
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(4)); assert flat(m.group(1)) == flat(K("4 ")), "D4 old"
C = swapws(C, m.group(1), quote_group(4), "D4")
# 5
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(5)); assert flat(m.group(1)) == flat(K("5 ")), "D5 old"
C = swapws(C, m.group(1), quote_group(5), "D5")
# 6
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(6)); assert flat(m.group(1)) == flat(K("6 ")), "D6 old"
C = swapws(C, m.group(1), quote_group(6), "D6")
# 7
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)"\.?$', fb(7)); assert flat(m.group(1)) == flat(K("7 ")), "D7 old"
C = swapws(C, m.group(1), m.group(2), "D7")
# 8
assert "*Follows* \"" + K("8 ") + "\" *with*" in re.sub(r"\s+", " ", block(8).replace("\n", " "))
C = after(C, K("8 "), " " + quote_group(8), "D8")
OUT["CLAUDE.md"] = C

# ---------------- LEDGER.md
L = rd("LEDGER.md")
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(9)); assert flat(m.group(1)) == flat(K("9 ")), "D9 old"
L = swapws(L, m.group(1), quote_group(9), "D9")
OUT["LEDGER.md"] = L

# ---------------- plans/FRONTIER-STUBS.md
S = rd("plans/FRONTIER-STUBS.md")
S = swapws(S, K("10a"), quote_group(5), "D10a (the text of D5)")
S = after(S, K("10b"), "\n" + quote_group("10b"), "D10b")
OUT["plans/FRONTIER-STUBS.md"] = S

# ---------------- plans/STUB-one-class-transfer.md
T = rd("plans/STUB-one-class-transfer.md")
new10c = "> " + quote_group("10c", inner=True)
assert new10c.startswith("> **Closed 2026-10-14 (FS133-LD1)")
T = swapws(T, K("10c"), new10c, "D10c")
OUT["plans/STUB-one-class-transfer.md"] = T

# ---------------- ARCHITECTURE.md (draft 11)
A = rd("ARCHITECTURE.md"); f11 = fb(11)
# (a): remove the row whose head is the slot; the row is one line
rows = [l for l in A.split("\n") if l.startswith(K("11a"))]; assert len(rows) == 1 and A.count(rows[0] + "\n") == 1
A = A.replace(rows[0] + "\n", "", 1); LOG.append("D11a: residual_fourier's table row removed (one line)")
# (b)
m = re.search(r'\*\(b\) the paragraph under the table, following\* "(.*?)" \*:\* "( `Outside\.OAI158\.Spectral\.residual_fourier`.*?)"\s*- \*\(c\)', f11); assert m and flat(m.group(1)) == flat(K("11b"))
A = after(A, K("11b"), m.group(2), "D11b")
# (c): the cell from the slot head to "... are proved."
m = re.search(r'\*\(c\) the row of `Outside/OAI158Rigidity`, its description cell\* \(head "(.*?)", to the cell\'s end "… (.*?)"\) \*replaced by\* "(.*?)"\s*- \*\(d\)', f11); assert m
head, tailc, newc = m.group(1), m.group(2), m.group(3)
assert flat(head) == flat("**FS-133 (planned by FS133-K1, proved by FS133-IA1; no `sorry`). One imported outside theorem**")
ms = list(re.finditer(pat(head) + r".*?" + pat(tailc), A, flags=re.S)); assert len(ms) == 1, ("D11c", len(ms))
assert A[ms[0].start():ms[0].end()].count("\n") == 0   # inside one row
A = A[:ms[0].start()] + newc + A[ms[0].end():]; LOG.append("D11c: description cell of Outside/OAI158Rigidity replaced")
# (d): the leads
def lead(row, old, new, name):
    global A
    o = f"| `{row}` | {old}"; assert A.count(o) == 1, (name, A.count(o)); A = A.replace(o, f"| `{row}` | {new}", 1); LOG.append(f"D11d {name}: lead replaced")
LD = "landed by FS133-LD1; no `sorry`"
lead("Plane/OneClass/SectionDensity", "**FS-133 (FS133-K1; a skeleton).**", f"**FS-133 (FS133-K1's statements, FS133-IB1's proofs; {LD}).**", "SectionDensity")
lead("Plane/OneClass/Defs", "**FS-133 (FS133-K1; a skeleton).**", f"**FS-133 (FS133-K1's statements, FS133-IB2's proofs; {LD}).**", "Defs")
lead("Plane/OneClass/InvariantLaw", "**FS-133 (FS133-K1; a skeleton).**", f"**FS-133 (FS133-K1's statements, FS133-IB1's proofs, two lemmas FS133-IB2's; {LD}).**", "InvariantLaw")
lead("Plane/OneClass/Field", "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; no `sorry`), on the imported `Spectral.residual_fourier`.**",
     "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; landed by FS133-LD1; no `sorry`), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**", "Field")
OLDX = "**FS-133 (FS133-K1; a skeleton), on the imported `Spectral.residual_fourier`.**"
lead("Plane/OneClass/Algebraic", OLDX, f"**FS-133 (FS133-K1's statements, FS133-ICD1's proofs; {LD}), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**", "Algebraic")
lead("Plane/OneClass/Fractional", OLDX, f"**FS-133 (FS133-K1's statements, FS133-ICD1's proofs; {LD}), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**", "Fractional")
lead("Plane/OneClass/Pair", OLDX, f"**FS-133 (FS133-K1's statements, FS133-ICD1's proofs and FS133-IPQ1's; {LD}), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**", "Pair")
# (e)
A = swapws(A, K("11k"), "**C133-ALG** `IsInvariantLaw.measure_origin_le_mOne`", "D11e (Algebraic)")
A = swapws(A, K("11l"), "C133-INV-CLASS: `IsShiftInvariantLaw.measure_origin_le` (any graph)", "D11e (InvariantLaw)")
OUT["ARCHITECTURE.md"] = A

# ---------------- LEAN.md (draft 12)
M = rd("LEAN.md")
def rec_block(path, tag):
    t = rd(path); a = t.index(f"\n**{tag}."); m = re.search(r"\n\*\*[A-Z]+\d+\.|\n## ", t[a + 4:]); return t[a:a + 4 + m.start()] if m else t[a:]
def sub_bullets(b):
    """bullets '- "…"' of a draft block, joined on one line, quotes stripped"""
    out = []; cur = None
    for l in b.split("\n")[1:]:
        if l.startswith('- "'): 
            if cur is not None: out.append(cur)
            cur = l[2:]
        elif cur is not None and l.startswith("  ") : cur += " " + l.strip()
        elif cur is not None and not l.strip(): out.append(cur); cur = None
    if cur is not None: out.append(cur)
    res = []
    for x in out:
        x = flat(x); assert x.startswith('"') and x.endswith('"'), x[:60] + "..." + x[-30:]; res.append("- " + x[1:-1])
    return res
# (a)
d5 = flat(rec_block("plans/FS133-IA1-implementation.md", "D5")); mm = re.search(r'joined tree\."\)?:?\s*\*"(.*)"\*$', d5); assert mm, d5[-200:]
M = after(M, K("12a"), " " + mm.group(1), "D12a")
# (b)
bul = []
for path, tag, n in [("plans/FS133-IA1-implementation.md", "D6", 4), ("plans/FS133-IB1-implementation.md", "DB6", 6), ("plans/FS133-IB2-implementation.md", "DC5", 3),
                     ("plans/FS133-ICD1-implementation.md", "DD5", 5), ("plans/FS133-IPQ1-implementation.md", "DQ6", 3)]:
    bs = sub_bullets(rec_block(path, tag)); assert len(bs) == n, (tag, len(bs)); bul += bs
f12 = block(12); k = f12.index("and this landing's three:"); tail = f12[k:]
lb = []
for mm in re.finditer(r'\n  - \*"(.*?)"\*(?=\n  - \*"|\n*$)', tail, flags=re.S): lb.append("- " + flat(mm.group(1)))
assert len(lb) == 3, len(lb); bul += lb
M = after(M, K("12b"), "\n" + "\n".join(bul), "D12b (%d bullets)" % len(bul))
OUT["LEAN.md"] = M

# ---------------- tools/claude_md_fact_audit.py (drafts 13, 13b)
F = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(13), flags=re.S).group(1)
assert g.strip().startswith('(("8961", "5"), ("9038", "5")):')
a = '    (("7531", "5"), ("8961", "5")): '; assert F.count(a) == 1 and '("9038", "5")' not in F
k = F.index(a); e = F.index("\n", k); F = F[:e + 1] + g + "\n" + F[e + 1:]; LOG.append("D13: GATE_CHANGES entry inserted after the LP1 entry")
ax = "data/fs133/ld1/gate/receipt-axioms-final.log"
sup = [("8961", "9038 clean"), ("9,024", "9,101 records"), ("9024", "9,101 records"), ("declarations=17785", "17902"), ("17785", "17902"),
       ("refutations-skipped=232", "234"), ("232", "234"), ("declarations=17785 refutations-skipped=232 sites=1454", "17902, 234")]
f13b = fb("13b")
for key, _ in sup:
    assert f'"{key}"' in f13b, ("key not in draft 13b", key)
    assert f'    "{key}":' not in F, ("already a key", key)
tail = "the vacuity count from receipt-vacuity-final.log); the old count stays in data/fs131/lp1/gate/ and in GATE_CHANGES"
anchor_line = [l for l in F.split("\n") if l.startswith('    "ℤ[i]": ')]; assert len(anchor_line) == 1
add = "".join(f'    "{key}": "superseded gate count, refiled at FS133-LD1\'s landing from {ax} ({new}; {tail}",\n' for key, new in sup)
k = F.index(anchor_line[0]); F = F[:k] + add + F[k:]
LOG.append("D13b: superseded-count entries (before the 'ℤ[i]' entry): " + " | ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = F

# ---------------- BIBLIOGRAPHY.md (draft 14)
B = rd("BIBLIOGRAPHY.md"); f14 = fb(14)
m = re.search(r'\*Follows\* "(.*?)" \*with\* "( its rigidity step.*?)"\.?$', f14); assert m and flat(m.group(1)) == flat(K("14 "))
B = after(B, K("14 "), m.group(2), "D14")
OUT["BIBLIOGRAPHY.md"] = B

if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
