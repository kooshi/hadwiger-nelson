# FS131-FC7: file the drafts of plans/FS131-LGT1-gate.md § Drafts for the front page (FS131-LGT1), each at its slot,
# every slot asserted once before anything is written. Texts are read from the records, never retyped.
# Pattern: data/fs131/fc6/file_fs131_ldb1.py.  Usage: file_fs131_lgt1.py [--dry] [--20b=key|key|...] [--skip=1,2,..]
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def rd(p): return open(R + p).read()
OUT = {}; LOG = []
SKIP = set()
for a in sys.argv:
    if a.startswith("--skip="): SKIP = set(a[7:].split(","))
rec = rd("plans/FS131-LGT1-gate.md"); i = rec.index("## Drafts for the front page (FS131-LGT1)"); j = rec.index("\n## Open gate items at this landing", i); D = rec[i:j]
def block(n):
    a = D.index(f"\n**{n}."); m = re.search(r"\n\*\*\d+[b]?\.", D[a + 4:]); b = a + 4 + m.start() if m else len(D); return D[a:b]
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
src = open(R + "data/fs131/lgt1/drafts-slots.py").read().split("\n\ndef norm")[0]
src = src.split("\nSLOTS = [", 1); head = src[0]; body = "SLOTS = [" + src[1]
ns = {}; exec(compile(head.split("import re")[0] + "C, N, B, F = 'CLAUDE.md', 'LEAN.md', 'BIBLIOGRAPHY.md', 'tools/claude_md_fact_audit.py'\nL, K = 'LEDGER.md', 'data/fs131/claims-NF2.md'\n" + body, "slots", "exec"), ns)
SL = {lab: s for lab, f, s in ns["SLOTS"]}
def S(prefix):
    ks = [k for k in SL if k.startswith(prefix + " ")]; assert len(ks) == 1, (prefix, ks); return SL[ks[0]]
def old_of(n, pos=0):
    ms = re.findall(r'\*[Rr]eplaces\* "([^"]*)"', fb(n)); return ms[pos]
def by_of(n, pos=0):
    ms = re.findall(r'\*by\* "([^"]*)"', fb(n)); return ms[pos]
def ok(n): return str(n) not in SKIP

# ---------------- CLAUDE.md, in draft order; byte count after each
C = rd("CLAUDE.md")
def sz(): return len(C.encode())
BYTES = [("start", sz())]
def note(n): BYTES.append((n, sz()))
if ok(1):
    assert flat(old_of(1)) == flat(S("1")), "D1 old"; C = swapws(C, old_of(1), quote_group(1), "D1"); note("D1")
if ok(2):
    assert flat(old_of(2)) == flat(S("2")), "D2 old"; C = swapws(C, old_of(2), quote_group(2), "D2"); note("D2")
if ok(3):
    assert flat(old_of(3, 0)) == flat(S("3")), "D3 old"; C = swapws(C, old_of(3, 0), quote_group(3), "D3a")
    assert flat(old_of(3, 1)) == flat(S("3b")), "D3b old"; C = swapws(C, old_of(3, 1), by_of(3, 0), "D3b"); note("D3")
if ok(4):
    assert flat(old_of(4)) == flat(S("4")), "D4 old"; C = swapws(C, old_of(4), quote_group(4), "D4"); note("D4")
if ok(5):
    assert flat(old_of(5)) == flat(S("5")), "D5 old"; C = swapws(C, old_of(5), quote_group(5), "D5"); note("D5")
if ok(6):
    m = re.search(r'\*Follows\* "([^"]*)"', fb(6)); assert flat(m.group(1)) == flat(S("6")), "D6 old"
    C = after(C, m.group(1), " " + quote_group(6), "D6"); note("D6")
if ok(7):
    assert flat(old_of(7)) == flat(S("7")), "D7 old"; C = swapws(C, old_of(7), quote_group(7), "D7"); note("D7")
if ok(8):
    assert flat(old_of(8)) == flat(S("8")), "D8 old"; C = swapws(C, old_of(8), by_of(8), "D8"); note("D8")
for n in (9, 10, 11, 12):
    if ok(n):
        assert flat(old_of(n)) == flat(S(str(n))), f"D{n} old"; C = swapws(C, old_of(n), by_of(n), f"D{n}"); note(f"D{n}")
OUT["CLAUDE.md"] = C

# ---------------- LEDGER.md
L = rd("LEDGER.md")
if ok(13):
    assert flat(old_of(13)) == flat(S("13")), "D13 old"; L = swapws(L, old_of(13), quote_group(13), "D13")
if ok(14):
    assert flat(old_of(14)) == flat(S("14")), "D14 old"; L = swapws(L, old_of(14), by_of(14), "D14")
if ok(15):
    ps = re.findall(r'\*[Rr]eplaces\* "([^"]*)" \*by\* "([^"]*)"', fb(15)); assert len(ps) == 2, len(ps)
    assert flat(ps[0][0]) == flat(S("15")) and flat(ps[1][0]) == flat(S("15b")), "D15 old"
    L = swapws(L, ps[0][0], ps[0][1], "D15a"); L = swapws(L, ps[1][0], ps[1][1], "D15b")
OUT["LEDGER.md"] = L

# ---------------- LEAN.md (16, 17)
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
lch = plain_bullets(sect("plans/FS131-LCH1-join.md", "## Drafts for `LEAN.md`", r"\n## "))
assert len(lch) == 4, len(lch)
ikl = plain_bullets(sect("plans/FS131-IKL1-implementation.md", "### 4.6 `LEAN.md`", r"\n###? "))
assert len(ikl) == 4, len(ikl)
if ok(16):
    b16 = block(16)
    mm = re.search(r'\n- "(.*?)"\n- and this job\'s: "(.*?)"', b16, flags=re.S); assert mm
    first = "- " + flat(mm.group(1)); second = "- " + flat(mm.group(2))
    assert first == lch[0], ("D16 first bullet differs from the LCH1 record", first, lch[0])
    M = after(M, S("16"), "\n" + first + "\n" + second, "D16 (2 bullets)")
if ok(17):
    b17 = block(17); k = b17.index("and this job's:")
    mine = ["- " + flat(x) for x in re.findall(r'\n- "(.*?)"(?=\n- "|\s*$)', b17[k:], flags=re.S)]; assert len(mine) == 4, len(mine)
    b = lch[1:] + ikl + mine
    M = after(M, S("17"), "\n" + "\n".join(b), "D17 (%d bullets: 3 LCH1, 4 IKL1, 4 this job's)" % len(b))
OUT["LEAN.md"] = M

# ---------------- BIBLIOGRAPHY.md (18, 19)
B = rd("BIBLIOGRAPHY.md")
for n in (18, 19):
    if ok(n):
        m = re.search(r'\*following\* "([^"]*)": "([^"]*)"', fb(n)); assert m and flat(m.group(1)) == flat(S(str(n))), f"D{n}"
        B = after(B, m.group(1), m.group(2), f"D{n}")
OUT["BIBLIOGRAPHY.md"] = B

# ---------------- tools/claude_md_fact_audit.py (20, 20b)
F = rd("tools/claude_md_fact_audit.py")
if ok(20):
    g = re.search(r"```python\n(.*?)\n```", block(20), flags=re.S).group(1)
    assert g.lstrip().startswith('(("9438", "5"), ("10650", "5")):') and "\n" not in g and "10650" not in F
    a = '    (("9038", "5"), ("9438", "5")): '; assert F.count(a) == 1
    k = F.index(a); e = F.index("\n", k); F = F[:e + 1] + g + "\n" + F[e + 1:]; LOG.append("D20: GATE_CHANGES entry inserted after the FS131-LDB1 entry")
for x in sys.argv:
    if x.startswith("--20b="):
        keys = x[6:].split("|"); f20b = fb("20b")
        newv = {"9438": "10650 clean", "9,824": "11,284 records", "9824": "11,284 records", "declarations=20563": "22238", "20563": "22238",
                "declarations=20563 refutations-skipped=234 sites=1454": "22238, 240, 1455",
                "axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1": "axioms=3 rests=74 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2"}
        anchor_line = [l for l in F.split("\n") if l.startswith('    "ℤ[i]": ')]; assert len(anchor_line) == 1
        add = ""
        for key in keys:
            assert f'"{key}"' in f20b, ("key not in draft 20b", key); assert f'    "{key}":' not in F, ("already a key", key)
            add += f'    "{key}": "superseded gate count, refiled at FS131-LGT1\'s landing from data/fs131/lgt1/gate/receipt-axioms-final.log ({newv[key]}; the vacuity count from receipt-vacuity-final.log, the nine from receipt-assumptions-final.log); the old count stays in data/fs131/ldb1/gate/ and in GATE_CHANGES",\n'
        k = F.index(anchor_line[0]); F = F[:k] + add + F[k:]
        LOG.append("D20b: superseded-count entries (before the 'ℤ[i]' entry): " + " | ".join(keys))
OUT["tools/claude_md_fact_audit.py"] = F

# ---------------- data/fs131/claims-NF2.md (21)
N = rd("data/fs131/claims-NF2.md")
if ok(21):
    ml = re.search(r'\n> (- 2026-10-15 — \*\*The five-colour chain is landed\*\*.*?)(?=\n\n|\Z)', block(21), flags=re.S); assert ml
    line = flat(re.sub(r"\n> ?", " ", "\n" + ml.group(1)))
    ms = list(re.finditer(pat(S("21")), N)); assert len(ms) == 1
    e = N.find("\n", ms[0].end()); assert e == len(N) - 1 or e == -1, "slot line is not the last line"
    N = N.rstrip("\n") + "\n" + line + "\n"; LOG.append("D21: dated line appended after the slot's line (the file's last)")
OUT["data/fs131/claims-NF2.md"] = N

if "--dry" not in sys.argv:
    for p, t in OUT.items(): open(R + p, "w").write(t)
for l in LOG: print(l)
for n, b in BYTES: print(f"CLAUDE.md bytes after {n}: {b}")
print("D3 note: the nine counts changed (draft 3 is not a 'stands' draft)")
print("filed:" if "--dry" not in sys.argv else "would file:", ", ".join(sorted(OUT)))
