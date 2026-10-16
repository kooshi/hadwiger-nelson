# FS131-FC9: file the rest of the second filing. Every slot is asserted (dry pass, in memory) before any file is written.
# Drafts are extracted from their records by script, line wraps joined to one space (a wrap inside a path joined with none).
import re, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def flat(s): return re.sub(r"\s+", " ", s).strip()
def rd(p): return open(R + p).read()

def quote(path, anchor, start_marker=None):
    """text between the first '"' after `anchor` (or the exact start_marker) and the next '"', flattened."""
    t = flat(rd(path))
    a = flat(anchor)
    assert t.count(a) == 1, ("anchor not found exactly once", path, anchor, t.count(a))
    i = t.index(a) + len(a)
    j = t.index('"', i)
    k = t.index('"', j + 1)
    return t[j + 1:k]

# --- the drafts ---
D = {}
D["BIB-EL-KN7"] = quote("plans/FS131-KN7-chain-next.md", "reading status: ")
D["BIB-OAI-KN7"] = quote("plans/FS131-KN7-chain-next.md", "And `[OAIMath2026]`: ")
D["BIB-EL-KN3"] = quote("plans/FS131-KN3-chain-plan.md", "`[EinsiedlerLindenstrauss2022]`, reading status**, to follow the present text: ")
D["BIB-OAI-KN3"] = quote("plans/FS131-KN3-chain-plan.md", "**`[OAIMath2026]`**, family 015: ").replace("PrimePackets/ ShannonEntropy", "PrimePackets/ShannonEntropy")
D["BIB-KR1-Ambrus"] = quote("plans/FS131-KR1-chain-map.md", "`[AmbrusEtAl2023]`, reading status, to follow the present text: ")
D["BIB-KR1-Kakutani"] = quote("plans/FS131-KR1-chain-map.md", "`[Rudin1962]` and `[Kakutani1938]`: ")
D["BIB-KR1-Levitz"] = quote("plans/FS131-KR1-chain-map.md", "`[LevitzMott1972]`: ")
D["BIB-K12A-Zhang"] = quote("plans/FS131-K12A-count.md", "`[Zhang2012]`, to follow its reading status: ")
D["BIB-K12A-Bachoc"] = quote("plans/FS131-K12A-count.md", "`[BachocEtAl2014]`: ")
D["BIB-K12A-Ambrus"] = quote("plans/FS131-K12A-count.md", "`[AmbrusEtAl2023]`: ")
# the KMOR bullet has no quoted words: its bullet text, from the first key to the full stop
_t = flat(rd("plans/FS131-KR1-chain-map.md"))
_a = "`[KMOR2016]` (Lemma 3.2 (1)"
assert _t.count(_a) == 1
_s = _t.index(_a); _e = _t.index("not read by FS131-KR1.", _s) + len("not read by FS131-KR1.")
D["BIB-KR1-KMOR"] = _t[_s:_e]
D["LEAN-KN7-A"] = quote("plans/FS131-KN7-chain-next.md", "item 2, an instance: ")
D["ERR-FS84-N1"] = quote("plans/FS131-EN1-derivation.md", "a dated erratum under J45-N1's \"Rests on it\" line** (the original left standing): ")
D["ERR-FS100-Q47"] = quote("plans/FS131-EN1-derivation.md", "a dated erratum under FS100-Q47** (the original left standing): ")
for k, v in D.items(): print("DRAFT", k, "::", v)

# --- appliers ---
def bib_append(key, text):
    def fn(src):
        lines = src.split("\n")
        idx = [i for i, l in enumerate(lines) if l.startswith("| **[%s]**" % key)]
        assert len(idx) == 1, ("bib row", key, len(idx))
        l = lines[idx[0]]
        assert l.endswith(" |"), ("row does not end in ' |'", key)
        lines[idx[0]] = l[:-2].rstrip() + "; " + text + " |"
        return "\n".join(lines)
    return fn

def lean_kn7(text):
    def fn(src):
        old = "(`Outside/OAI158`, since FS124-L1)."
        assert src.count(old) == 1, ("LEAN item 2 end", src.count(old))
        i = src.index(old) + len(old)
        assert src[i:i+1] == ";", ("expected ';' after item 2's last sentence", src[i:i+20])
        return src[:i] + " " + text + src[i:]
    return fn

def after_paragraph(regex, text):
    def fn(src):
        m = list(re.finditer(regex, src, re.S))
        assert len(m) == 1, ("slot", regex[:60], len(m))
        e = m[0].end()
        return src[:e] + "\n\n" + text + src[e:]
    return fn

plan = [
 ("BIBLIOGRAPHY.md", "BIB-EL-KN7", bib_append("EinsiedlerLindenstrauss2022", D["BIB-EL-KN7"])),
 ("BIBLIOGRAPHY.md", "BIB-EL-KN3", bib_append("EinsiedlerLindenstrauss2022", D["BIB-EL-KN3"])),
 ("BIBLIOGRAPHY.md", "BIB-OAI-KN7", bib_append("OAIMath2026", D["BIB-OAI-KN7"])),
 ("BIBLIOGRAPHY.md", "BIB-OAI-KN3", bib_append("OAIMath2026", D["BIB-OAI-KN3"])),
 ("BIBLIOGRAPHY.md", "BIB-KR1-Ambrus", bib_append("AmbrusEtAl2023", D["BIB-KR1-Ambrus"])),
 ("BIBLIOGRAPHY.md", "BIB-K12A-Ambrus", bib_append("AmbrusEtAl2023", D["BIB-K12A-Ambrus"])),
 ("BIBLIOGRAPHY.md", "BIB-KR1-Kakutani", bib_append("Kakutani1938", D["BIB-KR1-Kakutani"])),
 ("BIBLIOGRAPHY.md", "BIB-KR1-Levitz", bib_append("LevitzMott1972", D["BIB-KR1-Levitz"])),
 ("BIBLIOGRAPHY.md", "BIB-KR1-KMOR", bib_append("KMOR2016", D["BIB-KR1-KMOR"])),
 ("BIBLIOGRAPHY.md", "BIB-K12A-Zhang", bib_append("Zhang2012", D["BIB-K12A-Zhang"])),
 ("BIBLIOGRAPHY.md", "BIB-K12A-Bachoc", bib_append("BachocEtAl2014", D["BIB-K12A-Bachoc"])),
 ("LEAN.md", "LEAN-KN7-A", lean_kn7(D["LEAN-KN7-A"])),
 ("plans/FS84-SI-D-derivation.md", "ERR-FS84-N1",
  after_paragraph(r"Rests on it: J45-N2, J45-SI-J \(through N1 \(c\)\)[^\n]*\n[^\n]*FS100-Q47 \(row 121\)\.(?=\n\nderivation: J45-N2)", D["ERR-FS84-N1"])),
 ("plans/FS100-derivation.md", "ERR-FS100-Q47",
  after_paragraph(r"X11K's lane \(Kooshi's request\); nothing of the chain is kernel yet\.(?=\n\n\*\*FS100-EFG)", D["ERR-FS100-Q47"])),
]
texts = {}
def cur(f): return texts[f] if f in texts else rd(f)
for f, rid, fn in plan: texts[f] = fn(cur(f))
if "--dry" in sys.argv: print("dry pass OK:", len(plan), "rows"); sys.exit(0)
for f, t in texts.items(): open(R + f, "w").write(t)
for f, rid, fn in plan: print("filed", rid, "->", f)
print(len(plan), "rows filed")
