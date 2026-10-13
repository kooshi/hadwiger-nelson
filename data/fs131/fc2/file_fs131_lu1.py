# FS131-FC2: the filing after FS131-LU1's landing: the drafts of plans/FS131-LU1-landing.md § Drafts for the front page (FS131-LU1),
# each applied at its slot, each slot asserted to occur once. Texts are read from the record, never retyped.
# Nothing is written until every slot has been found. Pattern: data/fs131/fc1/file_fs131_lc1.py.
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS131-LU1-landing.md"); i = rec.index("## Drafts for the front page (FS131-LU1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
def block(n):
    a = D.index(f"\n**{n}. "); m = re.search(r"\n\*\*%d\. " % (n + 1), D); b = m.start() if m else len(D); return D[a:b]
def groups(n, ind=False):
    out = []; cur = None
    for l in block(n).split("\n"):
        s = l.lstrip() if ind else l
        if s.startswith("> ") or s == ">": cur = (cur or []) + [s[2:] if s.startswith("> ") else ""]
        else:
            if cur: out.append(cur); cur = None
    if cur: out.append(cur)
    return out
def flat(lines): return re.sub(r"\s+", " ", " ".join(lines)).strip()
def fb(n): return re.sub(r"\s+", " ", block(n)).strip()
def pat(s): return r"\s+".join(re.escape(t) for t in s.split())
def swapws(s, old, new, name):
    ms = list(re.finditer(pat(old), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once, replaced"); return s[:ms[0].start()] + new + s[ms[0].end():]
def after(s, anchor, add, name, need_nl=False):
    ms = list(re.finditer(pat(anchor), s)); assert len(ms) == 1, (name, len(ms))
    if need_nl: assert s[ms[0].end():ms[0].end() + 1] == "\n", (name, "anchor not at line end")
    LOG.append(f"{name}: slot found once, inserted after"); return s[:ms[0].end()] + add + s[ms[0].end():]
def bullets(lines):
    out = []
    for l in lines:
        if l.startswith("- "): out.append([l])
        else: out[-1].append(l)
    return [flat(b) for b in out]

# ---- CLAUDE.md: drafts 1, 2, 3, 5, 6, 7, 14
C = rd("CLAUDE.md")
def old1(n):  # the *Replaces* "..." text of a one-quote-group draft
    m = re.search(r'\*Replaces\* "(.*?)"(?: — from| \*by\*|$)', fb(n)); return m.group(1)
C = swapws(C, old1(1), flat(groups(1)[0]), "D1")
C = swapws(C, "`declarations=15969 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.", flat(groups(2)[0]), "D2")
m3 = re.search(r'\*Replaces\* "(.*?)" — from `receipt-assumptions-final.log`', fb(3)); C = swapws(C, m3.group(1), flat(groups(3)[0]), "D3")
C = swapws(C, "A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [hand]), and through", flat(groups(5)[0]), "D5")
C = swapws(C, "**χ(ℚ(√11)²) ≥ 4** and the 3-adic barrier (rows 72–73);", flat(groups(6)[0]), "D6")
C = swapws(C, "**FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause through five over named hypotheses (row 127);", flat(groups(7)[0]), "D7")
# draft 14, the Frontier clause, placed first; the list's own connector "; before it " joins it to the clause that was first
g14 = groups(14); assert len(g14) == 1
a14 = "Last filed: "; k = C.index(a14 + "**the landing of FS-131's measurable number**"); assert C.count(a14 + "**the landing of FS-131's measurable number**") == 1
C = C[:k + len(a14)] + flat(g14[0]) + "; before it " + C[k + len(a14):]; LOG.append("D14a: Frontier 'Last filed' clause inserted first, joined by '; before it '")
OUT["CLAUDE.md"] = C

# ---- tools/claude_md_fact_audit.py: draft 4
T = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(4), flags=re.S).group(1)
a = '    (("7364", "5"), ("7395", "5")): '; assert T.count(a) == 1 and '("7447", "5")' not in T
k = T.index(a); e = T.index("\n", k); T = T[:e + 1] + g + "\n" + T[e + 1:]; LOG.append("D4a: GATE_CHANGES entry inserted after the LC1 entry")
a2 = '    "twenty-three theorems resting": '; assert T.count(a2) == 1; k = T.index(a2); e = T.index("\n", k)
ax = "data/fs131/lu1/gate/receipt-axioms-final.log"
sup = [("7395", "7447 clean"), ("7,454", "7,506 records"), ("declarations=15969", "16029"), ("inline=16", "15"), ("ours=23", "22"), ("takes=98", "106"),
       ("thirty-five hypotheses", "thirty-four"), ("sixteen written out", "fifteen"), ("twenty-three for hand results", "twenty-two"),
       ("98 (hypothesis, statement) pairs by 51 statements", "106 by 52")]
for key, _ in sup: assert f'    "{key}":' not in T, key
tail = "the vacuity count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in data/fs131/lc1/gate/ and in GATE_CHANGES"
add = "".join(f'    "{key}": "superseded gate count, refiled at FS131-LU1\'s landing from {ax} ({new}; {tail}",\n' for key, new in sup)
T = T[:e + 1] + add + T[e + 1:]; LOG.append("D4b: superseded-count entries: " + ", ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = T

# ---- LEDGER.md: draft 8
L = rd("LEDGER.md"); B8 = block(8)
items = re.split(r"\n- \*\*Row (\d+)\.\*\* ", B8); assert len(items) == 1 + 2 * 10, len(items)
def row_edit(n, fn):
    global L
    rows = [l for l in L.split("\n") if l.startswith(f"| {n} |")]; assert len(rows) == 1, n
    r = rows[0]; r2 = fn(r); assert L.count(r) == 1; L = L.replace(r, r2)
for q in range(10):
    n = int(items[1 + 2 * q]); txt = items[2 + 2 * q]
    qlines = [l.strip() for l in txt.split("\n") if l.strip().startswith("> ")]; quote = flat([l[2:] for l in qlines])
    ins = re.sub(r"\s+", " ", " ".join(l.strip() for l in txt.split("\n") if not l.strip().startswith(">")))
    nm = f"D8 row {n}"
    if n == 52:
        m = re.search(r'\*Replaces the grade at the row\'s head\* "(.*?)" \*by\* "(.*?)"\. \*Follows\* "(.*?)" —', ins); assert m, "52"
        def f(r, m=m, quote=quote):
            r = swapws(r, m.group(1), m.group(2), nm + " grade"); return after(r, m.group(3), " " + quote, nm + " text")
        row_edit(52, f)
    elif n in (57, 63, 73, 105, 127):
        m = re.search(r'\*Replaces\* "(.*?)" \*by\*', ins); assert m, n
        row_edit(n, lambda r, m=m, quote=quote, nm=nm: swapws(r, m.group(1), quote, nm))
    elif n in (99, 119, 121, 123):
        m = re.search(r'\*Follows\* "(.*?)"', ins); assert m, n
        sep = "" if quote.startswith(";") else " "
        row_edit(n, lambda r, m=m, quote=quote, sep=sep, nm=nm: after(r, m.group(1), sep + quote, nm))
    else: raise AssertionError(n)
OUT["LEDGER.md"] = L

# ---- LEAN.md: drafts 9, 11
M = rd("LEAN.md")
M = swapws(M, "on a declared hypothesis no statement takes, or one a theorem proves over its own variables;", flat(groups(9)[0]), "D9")
g11 = groups(11); assert len(g11) == 3, len(g11)
M = after(M, "(FS131-LC1, its record's stage 5: seven and nine; five and below; six).", " " + flat(g11[0]), "D11a")
bb = bullets(g11[1]); assert len(bb) == 1
M = after(M, "plan a cap from the largest process's resident set (`data/fs131/lc1/in-scope.sh` records both) (FS131-LC1).", "\n" + bb[0], "D11b", True)
sb = bullets(g11[2]); assert len(sb) == 16, len(sb)
M = after(M, "both stored-term comparisons with the release are run again (FS131-LC1).", "\n" + "\n".join(sb), "D11c", True)
OUT["LEAN.md"] = M

# ---- plans/FS131-KN1-number-field-kernel-map.md: draft 12
K = rd("plans/FS131-KN1-number-field-kernel-map.md"); F12 = fb(12); parts = F12.split(" - § "); assert len(parts) == 4, len(parts)
m1 = re.search(r'X1, row `\[S1b\]`, size column\. \*Replaces\* "(.*?)" \*by\* "(.*?)"\.$', parts[1]); assert m1
K = swapws(K, m1.group(1), m1.group(2), "D12a")
m2 = re.search(r'X1, row `\[S2\]`\. \*Follows\* "(.*?)" — "(.*)"$', parts[2]); assert m2
K = after(K, m2.group(1), " " + m2.group(2), "D12b")
m3 = re.search(r'X8\. \*Follows\* "(.*?)" — "(.*)"$', parts[3]); assert m3
K = after(K, m3.group(1), " " + m3.group(2), "D12c")
OUT["plans/FS131-KN1-number-field-kernel-map.md"] = K

# ---- data/fs131/claims-NF1.md: draft 13
N = rd("data/fs131/claims-NF1.md"); g13 = groups(13); assert len(g13) == 1
ms = list(re.finditer(pat('a draft that says "onto" is wrong and is not filed.'), N)); assert len(ms) == 1
e = N.index("\n", ms[0].end()); N = N[:e] + "\n" + flat(g13[0]) + N[e:]; LOG.append("D13: dated line inserted after the whole 20:39 UTC line")
OUT["data/fs131/claims-NF1.md"] = N
for l in ["D10: no slot named ('the list is the coordinator's') - HELD - CHECK", "D14 atlas: HELD (brief choice 4; no facts for the atlas) - CHECK",
          "D15: nothing to file", "D16 BIBLIOGRAPHY.md: HELD (not in the brief's touches; no slot named) - CHECK", "D7 optional sentence on row 119: not drafted as a replacement - nothing filed"]: LOG.append(l)
if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
