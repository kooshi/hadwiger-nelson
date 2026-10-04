"""Readback of the brief's quotations (standing rule 3): exact substring check against each named source."""
import sys, re
BRIEF = "data/fs129/briefs/FS129-MA2-pass2.md"
brief = open(BRIEF).read()
# extract the three blockquotes with their sources
quotes = re.findall(r"^> (.+)\n> — source: (\S+) § (.+)$", brief, re.M)
checks = [(q, src, sec) for q, src, sec in quotes]
# plus two inline quotations
checks.append(("where else can we use that identity?", "plans/FS116-close-inventory.md", "item 142"))
checks.append(('take a held composition, read off what its argument actually uses, and restate it at that class (identity: "state the class the argument carries"); then list every target or field the record holds that meets the wider hypothesis.', "plans/FS129-MA1-audit.md", "§ 5.4 note (3)"))
fault = "--fault" in sys.argv
bad = 0
for q, src, sec in checks:
    text = open(src).read()
    norm = lambda s: re.sub(r"\s+", " ", s)
    qq = q + (" PLANTED" if fault else "")
    ok = norm(qq) in norm(text)
    bad += not ok
    print(("verbatim" if ok else "MISMATCH"), "|", src, "§", sec, "|", q[:70])
print("mismatches:", bad, "of", len(checks))
