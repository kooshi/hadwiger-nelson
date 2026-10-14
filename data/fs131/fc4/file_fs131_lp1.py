# FS131-FC4: the filing after FS131-LP1's landing: the drafts of plans/FS131-LP1-landing.md § Drafts for the front page (FS131-LP1),
# each applied at its slot, each slot asserted to occur once. Texts are read from the record, never retyped.
# Nothing is written until every slot has been found. Pattern: data/fs131/fc3/file_fs131_lj1.py.
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
rec = rd("plans/FS131-LP1-landing.md"); i = rec.index("## Drafts for the front page (FS131-LP1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
dc = rd("data/fs131/lp1/drafts.md")
# the record's text is the filed source; its data copy differs only in draft 4's gated-commit placeholder (reported)
def block(n):
    a = D.index(f"\n**{n}."); m = re.search(r"\n\*\*\d+[bc]?\.", D[a + 4:]); b = a + 4 + m.start() if m else len(D); return D[a:b]
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
import importlib.util
sp = importlib.util.spec_from_file_location("slots", R + "data/fs131/lp1/drafts-slots.py"); sm = importlib.util.module_from_spec(sp); _argv = sys.argv; sys.argv = ["slots", "HEAD"]
try: sp.loader.exec_module(sm)
except SystemExit: pass
sys.argv = _argv
SL = {lab: s for lab, f, s in sm.SLOTS}
def K(prefix):
    ks = [k for k in SL if k.startswith(prefix)]; assert len(ks) == 1, (prefix, ks); return SL[ks[0]]
def rep_by(n, lead="Replaces"):
    """draft n has *Replaces* "OLD" *by* "NEW". -> (OLD, NEW); OLD is checked against the draft's own slot elsewhere."""
    f = fb(n); m = re.search(r'\*' + lead + r'\* "(.*?)" \*by\* "(.*?)"(?:\.(?=\s|$)|\s*$)', f); assert m, n
    return m.group(1), m.group(2)

# ---- CLAUDE.md
C = rd("CLAUDE.md")
# 1
m = re.search(r'\*Replaces\* "(.*?)"\. From', fb(1)); assert flat(m.group(1)) == flat(K("1 the audit")), "D1 old"
C = swapws(C, m.group(1), quote_group(1), "D1")
# 1b
m = re.search(r'\*Replaces\* "(.*?)" \(the whole run of the slot\) \*by\*', fb("1b")); assert m and m.group(1).startswith("The library declares three outside axioms: … run again")
C = swapws(C, K("1b "), quote_group("1b"), "D1b")
# 1c
m = re.search(r'\*Replaces\* "(.*?)" \*by\* "(.*?)" \(one of the two is gone\)\.', fb("1c")); assert m; o, n_ = m.group(1), m.group(2); assert flat(o) == flat(K("1c ")); C = swapws(C, o, n_, "D1c")
# 2
m = re.search(r'\*Replaces\* "(.*?)" From', fb(2)); assert flat(m.group(1)) == flat(K("2 ")), "D2 old"
C = swapws(C, m.group(1), quote_group(2), "D2")
# 3
m = re.search(r'\*Replaces\* "(.*?)" \*by\* \(from', fb(3)); assert flat(m.group(1)) == flat(K("3 the nine")), "D3 old"
C = swapws(C, m.group(1), quote_group(3), "D3")
# 3b
m = re.search(r'\*Follows\* "(.*?)" \*with\* "( One outside theorem.*?)" Two of the nine', fb("3b")); assert m and flat(m.group(1)) == flat(K("3b "))
C = after(C, m.group(1), m.group(2), "D3b")
# 5 - 12
for n, lab in [(5, "5 "), (6, "6 "), (7, "7 "), (8, "8 "), (9, "9 "), ("10a", "10a"), ("10b", "10b"), (11, "11 "), (12, "12 ")]:
    o, n_ = rep_by(n)
    if n == 12:  # new text ends with the slot's own tail; the draft's *by* string ends at `2026-10-14:"` then ". The later clause"
        f = fb(12); m = re.search(r'\*by\* "(Last filed: .*?)"\. The later clause', f); assert m; n_ = m.group(1)
    assert flat(o) == flat(K(lab)), ("old != slot", n)
    C = swapws(C, o, n_, f"D{n}")
OUT["CLAUDE.md"] = C

# ---- tools/claude_md_fact_audit.py: drafts 4, 4b
T = rd("tools/claude_md_fact_audit.py")
g = re.search(r"```python\n(.*?)\n```", block(4), flags=re.S).group(1)
assert g.strip().startswith('(("7531", "5"), ("8961", "5")):') and "gated commit 75a0035f1)" in g
a = '    (("7447", "5"), ("7531", "5")): '; assert T.count(a) == 1 and '("8961", "5")' not in T
k = T.index(a); e = T.index("\n", k); T = T[:e + 1] + g + "\n" + T[e + 1:]; LOG.append("D4: GATE_CHANGES entry inserted after the LJ1 entry")
ax = "data/fs131/lp1/gate/receipt-axioms-final.log"
tail = "the vacuity count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in data/fs131/lj1/gate/ and in GATE_CHANGES"
NINE_OLD = "axioms=3 rests=39 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1"
NINE_NEW = "axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1"
sup = [("7531", "8961 clean"), ("7,602", "9,024 records"), ("7602", "9,024 records"), ("38 imported", "26 imported"), ("28 axiom-free", "32 axiom-free"),
       ("declarations=16125", "17785"), ("16125", "17785"), ("refutations-skipped=228", "232"),
       ("declarations=16125 refutations-skipped=228 sites=1454", "17785, 232"),
       ("axioms=3 rests=39", "axioms=2 rests=27"), ("rests=39", "27"), (NINE_OLD, "the new nine: " + NINE_NEW),
       ("three outside theorems declared as axioms", "two"), ("thirty-nine theorems resting", "twenty-seven"), ("three outside axioms", "two")]
fb4 = fb("4b")
for key, _ in sup:
    assert f'    "{key}":' not in T, ("already a key", key)
    assert f'"{key}"' in fb4 or key == NINE_OLD, ("key not in draft 4b", key)
assert len({k for k, _ in sup}) == len(sup)
anchor_line = [l for l in T.split("\n") if l.startswith('    "ℤ[i]": ')]; assert len(anchor_line) == 1
add = "".join(f'    "{key}": "superseded gate count, refiled at FS131-LP1\'s landing from {ax} ({new}; {tail}",\n' for key, new in sup)
k = T.index(anchor_line[0]); T = T[:k] + add + T[k:]
LOG.append("D4b: superseded-count entries (before the 'ℤ[i]' entry): " + " | ".join(s[0] for s in sup))
OUT["tools/claude_md_fact_audit.py"] = T

# ---- ARCHITECTURE.md: draft 13
A = rd("ARCHITECTURE.md"); f13 = fb(13)
rows = [l for l in A.split("\n") if l.startswith("| `Outside.OAI158.proper_to_borel_weak` (`Outside/OAI158`) | `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean` lines 436–437 at commit `adc7f124`")]
assert len(rows) == 1; assert A.count(rows[0] + "\n") == 1
A = A.replace(rows[0] + "\n", "", 1); LOG.append("D13a: the transfer's table row removed (one line)")
m = re.search(r'\*replaced by\* "(Two at present\..*?)"\.?$', f13); assert m
A = swapws(A, "Three at present.", m.group(1), "D13b")
OUT["ARCHITECTURE.md"] = A

# ---- LEAN.md: draft 14
M = rd("LEAN.md"); B14 = block(14)
parts = re.split(r"\n- \*\((a|b|c|d)\) ", B14); assert len(parts) == 1 + 2 * 4, len(parts)
P = {parts[1 + 2 * q]: parts[2 + 2 * q] for q in range(4)}
def strip_q(s):
    s = flat(s); assert s.startswith('*"') and s.endswith('"*'), s[:40] + " ... " + s[-20:]; s = s[2:-2]; assert '"*' not in s and '*"' not in s; return s
# (a)
ta = flat(P["a"]); mm = re.search(r'following\* "[^"]*": (\*".*"\*)$', ta); assert mm, ta[:200]
newa = "- " + strip_q(mm.group(1))
M = after(M, K("14a"), "\n" + newa, "D14a", True)
# (b): six sub-bullets
tb = P["b"]; head, rest = tb.split("\n", 1); assert head.startswith("Searching") or "following" in head
subs = re.split(r"\n  - (?=\*\")", "\n" + rest.strip("\n")); subs = [s for s in subs if s.strip()]; assert len(subs) == 6, len(subs)
newb = ["- " + strip_q(s) for s in subs]
M = after(M, K("14b"), "\n" + "\n".join(newb), "D14b (6 bullets)", True)
# (c)
tc = flat(P["c"]); mm = re.search(r'following\* "[^"]*": (\*".*"\*)$', tc); assert mm
M = after(M, K("14c"), "\n- " + strip_q(mm.group(1)), "D14c", True)
# (d)
td = flat(P["d"]); mm = re.search(r'following\* "[^"]*": (\*".*"\*)$', td); assert mm
M = after(M, K("14d"), "\n- " + strip_q(mm.group(1)), "D14d", True)
OUT["LEAN.md"] = M

# ---- BIBLIOGRAPHY.md: draft 15
Bb = rd("BIBLIOGRAPHY.md"); f15 = fb(15)
m = re.search(r'What rests on it, replaces\* "(.*?)" \*by\* "(.*?)"\. - \*\(b\)', f15); assert m
oa, na = m.group(1), m.group(2); assert flat(oa) == flat(K("15a"))
Bb = swapws(Bb, oa, na, "D15a")
m = re.search(r'Its reading, replaces\* "(.*?)" \*by\* "(.*)"\.?$', f15); assert m
ob, nb = m.group(1), m.group(2); assert flat(ob) == flat(K("15b"))
Bb = swapws(Bb, ob, nb, "D15b")
OUT["BIBLIOGRAPHY.md"] = Bb

if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT))); print("CLAUDE.md bytes", len(OUT["CLAUDE.md"].encode()))
