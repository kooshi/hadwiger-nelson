# FS131-FC3: the filing after FS131-LJ1's landing: the drafts of plans/FS131-LJ1-landing.md § Drafts for the front page (FS131-LJ1),
# each applied at its slot, each slot asserted to occur once. Texts are read from the record, never retyped.
# Nothing is written until every slot has been found. Pattern: data/fs131/fc2/file_fs131_lu1.py.
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS131-LJ1-landing.md"); i = rec.index("## Drafts for the front page (FS131-LJ1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
assert D == rd("data/fs131/lj1/drafts.md").rstrip("\n") or D.strip() == rd("data/fs131/lj1/drafts.md").strip(), "record and data copy differ"
def block(n):
    a = D.index(f"\n**{n}. "); m = re.search(r"\n\*\*\d+b?\. ", D[a + 4:]); b = a + 4 + m.start() if m else len(D); return D[a:b]
def flat(s): return re.sub(r"\s+", " ", s).strip()
def fb(n): return flat(block(n))
def pat(s): return r"\s+".join(re.escape(t) for t in s.split())
def swapws(s, old, new, name):
    ms = list(re.finditer(pat(old), s)); assert len(ms) == 1, (name, len(ms))
    LOG.append(f"{name}: slot found once, replaced"); return s[:ms[0].start()] + new + s[ms[0].end():]
def after(s, anchor, add, name, need_nl=False):
    ms = list(re.finditer(pat(anchor), s)); assert len(ms) == 1, (name, len(ms))
    if need_nl: assert s[ms[0].end():ms[0].end() + 1] == "\n", (name, "anchor not at line end")
    LOG.append(f"{name}: slot found once, inserted after"); return s[:ms[0].end()] + add + s[ms[0].end():]
def quote_group(n, k=0):
    gs = []; cur = None
    for l in block(n).split("\n"):
        if l.startswith("> ") or l == ">": cur = (cur or []) + [l[2:]]
        elif cur: gs.append(cur); cur = None
    if cur: gs.append(cur)
    return flat(" ".join(gs[k]))
# the slot strings of the landing agent's own checker, to assert the draft's quoted old text equals them
import importlib.util
sp = importlib.util.spec_from_file_location("slots", R + "data/fs131/lj1/drafts-slots.py"); sm = importlib.util.module_from_spec(sp); sp.loader.exec_module(sm)
SL = {lab: s for lab, f, s in sm.SLOTS}
def draft_old(n):
    m = re.search(r'\*Replaces\* "(.*?)"\. From', fb(n)); return m.group(1)

# ---- CLAUDE.md: drafts 1, 1b, 2, 3, 5, 6, 10
C = rd("CLAUDE.md")
assert flat(draft_old(1)) == flat(SL["1 audit sentence"]), "D1 old"
C = swapws(C, draft_old(1), quote_group(1), "D1")
b1b = fb("1b"); m = re.search(r'\*Replaces\* "(.*?)" \*by\*', b1b); assert flat(m.group(1)) == flat(SL["1b the import's count of records"])
C = swapws(C, m.group(1), quote_group("1b"), "D1b")
m = re.search(r'\*Replaces\* "(.*?)" From', fb(2)); assert flat(m.group(1)) == flat(SL["2 vacuity counts"]), "D2 old"
C = swapws(C, m.group(1), quote_group(2), "D2")
m = re.search(r'\*Replaces\* "(.*?)". From `receipt-assumptions-final.log`', fb(3)); assert flat(m.group(1)) == flat(SL["3 nine counts and their sentence"]), "D3 old"
C = swapws(C, m.group(1), quote_group(3), "D3")
C = after(C, SL["5 what the kernel holds, the sentence it follows"], " " + quote_group(5), "D5")
m = re.search(r'\*by\* "(Last filed: .*?)"\. The rest of the line stands', fb(6)); assert m
C = swapws(C, SL["6 the Frontier's Last filed"], m.group(1), "D6")
m = re.search(r'\*by\* "(and through five the bound is exact.*?)"\. \*\(The slot', fb(10)); assert m
C = swapws(C, SL["10 the theory paragraph"], m.group(1), "D10")
OUT["CLAUDE.md"] = C

# ---- tools/claude_md_fact_audit.py: drafts 4, 4b
T = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(4), flags=re.S).group(1)
a = '    (("7395", "5"), ("7447", "5")): '; assert T.count(a) == 1 and '("7531", "5")' not in T
k = T.index(a); e = T.index("\n", k); T = T[:e + 1] + g + "\n" + T[e + 1:]; LOG.append("D4: GATE_CHANGES entry inserted after the LU1 entry")
a2 = '    "twenty-three theorems resting": '
ax = "data/fs131/lj1/gate/receipt-axioms-final.log"
tail = "the vacuity count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in data/fs131/lu1/gate/ and in GATE_CHANGES"
NINE = "axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1"
OLDNINE = "axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1"
sup = [("7447", "7531 clean"), ("7,506", "7,602 records"), ("7506", "7,602 records"), ("26 imported", "38 imported"), ("with eight", "with twenty"),
       ("declarations=16029", "16125"), ("16029", "16125"), ("declarations=16029 refutations-skipped=228 sites=1454", "16125"),
       ("rests=26", "39"), ("inline=15", "14"), ("ours=22", "21"), ("takes=106", "102"), (OLDNINE, "the new nine: " + NINE),
       ("twenty-six theorems resting", "thirty-nine"), ("thirty-four hypotheses", "thirty-three"), ("fifteen written out", "fourteen"),
       ("twenty-two for hand results", "twenty-one"), ("106 (hypothesis, statement) pairs by 52 statements", "102 by 52")]
for key, _ in sup: assert f'    "{key}":' not in T, ("already a key", key)
assert len({k for k, _ in sup}) == len(sup)
fb4 = fb("4b")
for key, _ in sup: assert key in fb4 or key == OLDNINE or key.replace(",", "") in fb4, ("key not in draft 4b", key)
anchor_line = [l for l in T.split("\n") if l.startswith('    "ℤ[i]": ')]; assert len(anchor_line) == 1
add = "".join(f'    "{key}": "superseded gate count, refiled at FS131-LJ1\'s landing from {ax} ({new}; {tail}",\n' for key, new in sup)
k = T.index(anchor_line[0]); T = T[:k] + add + T[k:]
LOG.append("D4b: superseded-count entries (before the 'ℤ[i]' entry): " + " | ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = T

# ---- LEDGER.md: draft 7
L = rd("LEDGER.md"); B7 = block(7)
items = re.split(r"\n- \*\*Row (\d+)\.\*\* ", B7); assert len(items) == 1 + 2 * 6, len(items)
def row_edit(n, fn):
    global L
    rows = [l for l in L.split("\n") if l.startswith(f"| {n} |")]; assert len(rows) == 1, n
    r = rows[0]; r2 = fn(r); assert L.count(r) == 1; L = L.replace(r, r2)
def endq(s):  # strip the closing quote (and optional full stop after it) at the end of a bullet
    s = flat(s); s = s.rstrip(); assert s.endswith('"') or s.endswith('".'), s[-30:]; return s[:-1] if s.endswith('"') else s[:-2]
d = {int(items[1 + 2 * q]): flat(items[2 + 2 * q]) for q in range(6)}; assert sorted(d) == [52, 73, 79, 82, 99, 105]
def inrow(r, old, new, name):
    return swapws(r, old, new, name)
# row 52
m = re.search(r'^\*Replaces\* "(.*?)" \*by\* "(.*?)" The grade bracket', d[52]); assert m and flat(m.group(1)) == flat(SL["7 row 52"])
row_edit(52, lambda r: swapws(r, m.group(1), m.group(2), "D7 row 52"))
# row 73
m = re.search(r'^\*Follows\* "(.*?)" \*with\* "(.*)"\.?$', d[73]); assert m and flat(m.group(1)) == flat(SL["7 row 73"])
row_edit(73, lambda r: after(r, m.group(1), " " + m.group(2), "D7 row 73"))
# row 79
m = re.search(r'^\*Follows\* the grade "(.*?)" \*with\* "(.*)"\.?$', d[79]); assert m and flat(m.group(1)) == flat(SL["7 row 79, the grade"])
row_edit(79, lambda r: after(r, m.group(1), " " + m.group(2), "D7 row 79"))
# row 82
m = re.search(r'^\*Replaces\* the grade "(.*?)" \*by\* "(.*?)"\. \*And replaces\*, in its \*\*Not claimed\*\*, "(.*?)" \*by\* "(.*?)"\. The row\'s prior art stands', d[82]); assert m
assert m.group(1) == "**[hand, two independent derivations]**" and flat(m.group(3)) == flat(SL["7 row 82, not claimed"])
def f82(r):
    r = swapws(r, m.group(1), m.group(2), "D7 row 82 grade"); return swapws(r, m.group(3), m.group(4), "D7 row 82 not claimed")
row_edit(82, f82)
# row 99
m = re.search(r'^\*Replaces\* the grade "(.*?)" \*by\* "(\*\*\[kernel since.*?\]\*\*)"\. \*And replaces\*, in its \*\*Not claimed\*\*, "(.*?)" \*by\* "(.*)"\.?$', d[99]); assert m
assert flat(m.group(1)) == flat(SL["7 row 99, the grade"]) and flat(m.group(3)) == flat(SL["7 row 99, not claimed"])
def f99(r):
    r = swapws(r, m.group(1), m.group(2), "D7 row 99 grade"); return swapws(r, m.group(3), m.group(4), "D7 row 99 not claimed")
row_edit(99, f99)
# row 105
m = re.search(r'^\*Replaces\* "(.*?)" \*by\* "(.*)"\.?$', d[105]); assert m and flat(m.group(1)) == flat(SL["7 row 105"])
row_edit(105, lambda r: swapws(r, m.group(1), m.group(2), "D7 row 105"))
OUT["LEDGER.md"] = L

# ---- LEAN.md: draft 8 (the five records' lines); this landing's two are HELD (see LOG)
M = rd("LEAN.md")
def bullets_after(text, start_marker, stop_re, indent_re):
    i = text.index(start_marker) + len(start_marker); seg = text[i:]
    m = re.search(stop_re, seg); seg = seg[:m.start()] if m else seg
    out = []
    for l in seg.split("\n"):
        if re.match(indent_re, l): out.append([l])
        elif l.strip() and out: out[-1].append(l)
    return [flat(" ".join(b)) for b in out]
def unq(b):
    b = re.sub(r"^- ", "", b); assert b.startswith('"') and b.endswith('"'), b[:30]; return "- " + b[1:-1]
new = []
ic1 = bullets_after(rd("plans/FS131-IC1-implementation.md"), "### D7 — a Lean fact (slot: `LEAN.md` § Searching — Lean, a new line after the one on a filled skeleton's statements)\n", r"\n\*\*A question the same finding", r"^- "); assert len(ic1) == 1; new += ic1
it1 = bullets_after(rd("plans/FS131-IT1-implementation.md"), "- **`LEAN.md` § Searching — Lean**, five lines:\n", r"\n\n", r"^  - "); LOG.append(f"D8 IT1: {len(it1)} bullets under the record's 'five lines' header")
assert len(it1) == 5 and it1[4].startswith("- A control that changes"); new += [re.sub(r"^- ", "- ", b) for b in it1[:4]]
in1 = bullets_after(rd("plans/FS131-IN1-implementation.md"), "### 5. Lines for `LEAN.md` § Searching — Lean\n", r"\n## ", r"^- "); assert len(in1) == 4; new += in1
id1 = bullets_after(rd("plans/FS131-ID1-implementation.md"), "### D6 — `LEAN.md` § Searching — Lean: three lines, if wanted\n", r"\n## ", r"^- "); assert len(id1) == 3; new += [unq(b) for b in id1]
kj1 = bullets_after(rd("plans/FS131-KJ1-joining-module.md"), "**D8. `LEAN.md` § Searching — Lean** (draft lines):\n", r"\n## ", r"^- "); assert len(kj1) == 4; new += [unq(b) for b in kj1]
assert all(b.startswith("- ") for b in new) and len(new) == 16, len(new)
M = after(M, SL["8 LEAN.md § Searching, the bullet the new ones follow"], "\n" + "\n".join(new), "D8 five records (16 bullets: IC1 1, IT1 4, IN1 4, ID1 3, KJ1 4)", True)
LOG.append("D8 'this landing's two' (LEAN.md § The gate, § Trust ledger): HELD - CHECK (slot falls mid-sentence; no slot for the Trust ledger line)")
OUT["LEAN.md"] = M

# ---- BIBLIOGRAPHY.md: draft 9
B = rd("BIBLIOGRAPHY.md"); f9 = fb(9)
m = re.search(r'\*with\*: "(His Thms 8, 9, 10\(i\).*?)" In its reading cell', f9); assert m
B = after(B, SL["9 the bibliography row, what rests on it (with the words before it, to be unique)"], " " + m.group(1), "D9a")
m = re.search(r'the joining job\'s sentence, "(re-read 2026-10-13 by FS131-KJ1.*?)"$', f9); assert m
B = after(B, SL["9 the bibliography row, its reading"], " " + m.group(1), "D9b")
OUT["BIBLIOGRAPHY.md"] = B

if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
