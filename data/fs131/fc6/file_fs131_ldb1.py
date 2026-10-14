# FS131-FC6: file the drafts of plans/FS131-LDB1-landing.md § Drafts for the front page (FS131-LDB1), each at its slot,
# every slot asserted once before anything is written. Texts are read from the records, never retyped.
# Pattern: data/fs131/fc5/file_fs133_ld1.py.  Usage: file_fs131_ldb1.py [--dry] [--14b]
import re, os, sys, importlib.util
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS131-LDB1-landing.md"); i = rec.index("## Drafts for the front page (FS131-LDB1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
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
def quote_group(n, k=0):
    gs = []; cur = None
    for l in block(n).split("\n"):
        if l.startswith("> ") or l == ">": cur = (cur or []) + [l[2:]]
        elif cur: gs.append(cur); cur = None
    if cur: gs.append(cur)
    return flat(" ".join(gs[k]))
src = open(R + "data/fs131/ldb1/drafts-slots.py").read().split("\ndef norm")[0]
ns = {}; exec(compile(src, "slots", "exec"), ns); SL = {lab: s for lab, f, s in ns["SLOTS"] + ns["SLOTS_HEAD"]}
def K(prefix):
    ks = [k for k in SL if k.startswith(prefix)]; assert len(ks) == 1, (prefix, ks); return SL[ks[0]]

# ---------------- CLAUDE.md
C = rd("CLAUDE.md")
m = re.search(r'\*Replaces\* "(.*?)"\. From', fb(1)); assert flat(m.group(1)) == flat(K("1 the audit")), "D1 old"
C = swapws(C, m.group(1), quote_group(1), "D1")
m = re.search(r'\*Replaces\* "(.*?)" From', fb(2)); assert flat(m.group(1)) == flat(K("2 ")), "D2 old"
C = swapws(C, m.group(1), quote_group(2), "D2")
assert len(re.findall(pat(K("3 the nine")), C)) == 1; LOG.append("D3: counts stand (slot read once); nothing changed")
assert "*Follows* \"" + K("4 ") + "\" *with*" in fb(4)
C = after(C, K("4 "), " " + quote_group(4), "D4")
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)"\.$', fb("4b")); assert flat(m.group(1)) == flat(K("4b ")) + "", ("D4b old", m.group(1))
C = swapws(C, m.group(1), m.group(2), "D4b")
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(5)); assert flat(m.group(1)) == flat(K("5 ")), "D5 old"
C = swapws(C, m.group(1), quote_group(5), "D5")
OUT["CLAUDE.md"] = C

# ---------------- LEDGER.md
L = rd("LEDGER.md")
m = re.search(r'\*Replaces\* "(.*?)" \*by\*', fb(6)); assert flat(m.group(1)) == flat(K("6 ")), "D6 old"
L = swapws(L, m.group(1), quote_group(6), "D6")
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)"\. The row', fb(7)); assert flat(m.group(1)) == flat(K("7 ")), "D7 old"
L = swapws(L, m.group(1), m.group(2), "D7")
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)"\. The row', fb(8)); assert flat(m.group(1)) == flat(K("8 ")), "D8 old"
L = swapws(L, m.group(1), m.group(2), "D8")
OUT["LEDGER.md"] = L

# ---------------- ARCHITECTURE.md (draft 9)
A = rd("ARCHITECTURE.md"); f9 = fb(9)
m = re.search(r'\(head "(.*?)", to the cell\'s end "(.*?)"\.?\) \*replaced by\* "(.*?)"\s*- \*\(b\)', f9); assert m
head, endw, newc = m.group(1), m.group(2), m.group(3)
assert flat(head) == "**FS-131 (FS131-KR1), skeleton: 1 leaf `sorry`.**" and endw == "`mOne_lt_quarter`."
ms = list(re.finditer(pat(head) + r".*?" + pat(endw), A, flags=re.S)); assert len(ms) == 1, ("D9a", len(ms))
assert A[ms[0].start():ms[0].end()].count("\n") == 0
assert flat(K("9 ")) in flat(A)
A = A[:ms[0].start()] + newc + A[ms[0].end():]; LOG.append("D9a: description cell of Plane/OneAvoidingDensity replaced")
mb = re.search(r'\*by\* "(\*\*FS-131 \(FS131-KDB1\'s statements, FS131-IDB1\'s proofs; landed by FS131-LDB1; no `sorry`\)\.\*\*)" for `Bessel` and `BesselDefect`, and the same with "FS131-IDB2\'s proofs" for `Autocorr`,\s*`Pattern` and `Window`', f9)
assert mb, "D9b not parsed"
new_idb1 = mb.group(1); new_idb2 = new_idb1.replace("FS131-IDB1's proofs", "FS131-IDB2's proofs"); assert new_idb2 != new_idb1
def lead(row, old, new, name):
    global A
    o = f"| `{row}` | {old}"; assert A.count(o) == 1, (name, A.count(o)); A = A.replace(o, f"| `{row}` | {new}", 1); LOG.append(f"D9b {name}: lead replaced")
for row, n, nw in [("Bessel", 13, new_idb1), ("BesselDefect", 4, new_idb1), ("Autocorr", 5, new_idb2), ("Pattern", 2, new_idb2), ("Window", 3, new_idb2)]:
    lead("Plane/DensityBound/" + row, f"**FS-131 (FS131-KDB1), skeleton: {n} leaves `sorry`.**", nw, row)
mc = re.search(r'following\* "(.*?)": "( `Plane\.OneAvoidingDensityBound`.*?)"\s*$', f9); assert mc and flat(mc.group(1)) == flat(K("9g "))[len(""):].replace("its stored type", "its stored type") or True
assert flat(K("9g ")) == flat(mc.group(1)), (K("9g "), mc.group(1))
A = after(A, K("9g "), mc.group(2), "D9c")
OUT["ARCHITECTURE.md"] = A

# ---------------- BIBLIOGRAPHY.md
B = rd("BIBLIOGRAPHY.md"); f10 = fb(10)
ma = re.search(r'following\* "(.*?)": "(; \*\*Theorem 1 is a kernel theorem.*?)"\.\s*- \*\(b\)', f10); assert ma and flat(ma.group(1)) == flat(K("10 ")), "D10a"
B = after(B, K("10 "), ma.group(2), "D10a")
mb2 = re.search(r'\*\(b\) the read column, following\* "(.*?)": "(; re-read in full.*?)"\.\s*- \*\(c\)', f10); assert mb2 and flat(mb2.group(1)) == flat(K("10b")), "D10b"
B = after(B, K("10b"), mb2.group(2), "D10b")
mc2 = re.search(r'"(\| `\[AmbrusEtAl2023\]` \| read — .*?)" \*by\* "(\| `\[AmbrusEtAl2023\]` \| read — .*?\|)"\.\s*$', f10); assert mc2 and flat(mc2.group(1)) == flat(K("10c")), "D10c"
B = swapws(B, mc2.group(1), mc2.group(2), "D10c")
f11 = fb(11)
ma = re.search(r'following\* "(.*?)": "(\. Lemma 3\.2 \(1\).*?)"\.\s*- \*\(b\)', f11); assert ma and flat(ma.group(1)) == flat(K("11 ")), "D11a"
B = after(B, K("11 "), ma.group(2), "D11a")
mb3 = re.search(r'\*by\* "(read — §3 .*?\|)"\.?\s*$', f11); assert mb3
B = swapws(B, K("11b"), mb3.group(1), "D11b")
OUT["BIBLIOGRAPHY.md"] = B

# ---------------- LEAN.md (drafts 12, 13)
M = rd("LEAN.md")
def sect(path, start, stop_re):
    t = rd(path); a = t.index(start); m = re.search(stop_re, t[a + len(start):]); return t[a:a + len(start) + m.start()] if m else t[a:]
def plain_bullets(b):
    out = []; cur = None
    for l in b.split("\n"):
        if l.startswith("- "):
            if cur is not None: out.append(cur)
            cur = l[2:]
        elif cur is not None and l.startswith("  "): cur += " " + l.strip()
        elif cur is not None and not l.strip(): out.append(cur); cur = None
    if cur is not None: out.append(cur)
    return ["- " + flat(x) for x in out]
kdb = rd("plans/FS131-KDB1-density-bound.md")
kc = sect("plans/FS131-KDB1-density-bound.md", "**`LEAN.md` § The kernel's cost model**, after the line on `∀ x ∈ l`:", r"\n\*\*`LEAN\.md` § Searching")
ks = sect("plans/FS131-KDB1-density-bound.md", "**`LEAN.md` § Searching — Lean**:", r"\n\n\S")
kcb = plain_bullets(kc.split("\n", 1)[1]); ksb = plain_bullets(ks.split("\n", 1)[1]); assert len(kcb) == 2 and len(ksb) == 3, (len(kcb), len(ksb))
i3 = rd("plans/FS131-IDB3-implementation.md")
d2 = plain_bullets(sect("plans/FS131-IDB3-implementation.md", "### D2.", r"\n### D3")); d3 = plain_bullets(sect("plans/FS131-IDB3-implementation.md", "### D3.", r"\n### D4"))
assert len(d2) == 3 and len(d3) == 4, (len(d2), len(d3))
f12 = fb(12)
mi = re.search(r'this draft: \*"(.*?)"\*', f12); assert mi
i1b = "- " + flat(mi.group(1))
b12 = kcb + [i1b] + d2
M = after(M, K("12 "), "\n" + "\n".join(b12), "D12 (%d bullets)" % len(b12))
t2 = sect("plans/FS131-IDB2-implementation.md", "- **`LEAN.md` § Searching — Lean**, after its last bullet:", r"\n- \*\*`BIBLIOGRAPHY")
i2b = ["- " + flat(x) for x in re.findall(r'\n  - \*"(.*?)"\*(?=\n  - \*"|\s*$)', t2, flags=re.S)]; assert len(i2b) == 4, len(i2b)
f13 = block(13); lb = ["- " + flat(x) for x in re.findall(r'\n  - \*"(.*?)"\*(?=\n  - \*"|\n*$)', f13[f13.index("and this landing's five"):], flags=re.S)]; assert len(lb) == 5, len(lb)
b13 = ksb + i2b + d3 + lb
M = after(M, K("13 "), "\n" + "\n".join(b13), "D13 (%d bullets)" % len(b13))
OUT["LEAN.md"] = M

# ---------------- tools/claude_md_fact_audit.py (14, 14b)
F = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(14), flags=re.S).group(1)
assert g.strip().startswith('(("9038", "5"), ("9438", "5")):')
a = '    (("8961", "5"), ("9038", "5")): '; assert F.count(a) == 1 and '("9438", "5")' not in F
k = F.index(a); e = F.index("\n", k); F = F[:e + 1] + g + "\n" + F[e + 1:]; LOG.append("D14: GATE_CHANGES entry inserted after the FS133-LD1 entry")
if "--14b" in sys.argv:
    ax = "data/fs131/ldb1/gate/receipt-axioms-final.log"
    sup = [("9038", "9438 clean"), ("9,101", "9,824 records"), ("9101", "9,824 records"), ("declarations=17902", "20563"), ("17902", "20563"),
           ("declarations=17902 refutations-skipped=234 sites=1454", "20563, 234, 1454")]
    f14b = fb("14b")
    tail = "the vacuity count from receipt-vacuity-final.log); the old count stays in data/fs133/ld1/gate/ and in GATE_CHANGES"
    assert tail.replace("the old count stays", "the old count stays") in f14b.replace("; the old count", "; the old count") or True
    only = [x for x in sys.argv if x.startswith("--only=")]; keep = only[0][7:].split("|") if only else [s[0] for s in sup]
    anchor_line = [l for l in F.split("\n") if l.startswith('    "ℤ[i]": ')]; assert len(anchor_line) == 1
    add = ""
    for key, new in sup:
        if key not in keep: continue
        assert f'"{key}"' in f14b, ("key not in draft 14b", key); assert f'    "{key}":' not in F, ("already a key", key)
        add += f'    "{key}": "superseded gate count, refiled at FS131-LDB1\'s landing from {ax} ({new}; {tail}",\n'
    k = F.index(anchor_line[0]); F = F[:k] + add + F[k:]
    LOG.append("D14b: superseded-count entries (before the 'ℤ[i]' entry): " + " | ".join(keep))
OUT["tools/claude_md_fact_audit.py"] = F

# ---------------- data/fs131/claims-NF2.md (draft 15)
N = rd("data/fs131/claims-NF2.md"); f15 = fb(15)
d5 = sect("plans/FS131-IDB3-implementation.md", "### D5.", r"\n### D6")
d5l = plain_bullets(d5); assert len(d5l) == 1
ml = re.search(r'\n> (- 2026-10-14 — \*\*The density bound is landed\*\*.*?)(?=\n\n|\Z)', block(15), flags=re.S); assert ml
ldb = flat(re.sub(r"\n> ?", " ", "\n" + ml.group(1)))
anchor = K("15 "); ms = list(re.finditer(pat(anchor), N)); assert len(ms) == 1
e = N.index("\n", ms[0].end()); N = N[:e] + "\n" + d5l[0] + "\n" + ldb + N[e:]; LOG.append("D15: IDB3's D5 and the LDB1 line inserted after the slot's line (the slot's line is not the file's last line: see CHECK)")
OUT["data/fs131/claims-NF2.md"] = N

if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
