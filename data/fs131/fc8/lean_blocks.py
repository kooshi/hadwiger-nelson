# FS131-FC8: the LEAN.md draft blocks of the owed records: (job, record, start line (1-based), section the block names).
import re, glob, os
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def flat(s): return re.sub(r"\s+", " ", s).strip()
BLOCKS = [  # (job, start line of the heading, section)
 ("KN8", 498, "S"), ("KN9", 438, "S"), ("KT1", 381, "S"), ("K8B1", 408, "S"), ("KPD1", 377, "S"), ("KR1", 416, "S"), ("K12A", 347, "S"),
 ("KM11", 356, "S"), ("ITK1", 286, "S"), ("IJ1", 248, "S"), ("IJ2", 226, "S"), ("IJ3", 282, "S"), ("IM11", 271, "S"), ("ILA1", 260, "S"),
 ("ICL1", 306, "S"), ("ICL2", 333, "S"), ("ICM1", 262, "S"), ("ICM2", 223, "S"), ("IKC2", 181, "S"), ("IN1L", 473, "S"), ("IDG1", 389, "S"),
 ("IG1", 313, "S"), ("ITT1", 256, "S"), ("IKC4", 263, "S"), ("IP23", 301, "S"), ("KC13", 368, "C"), ("IKC1", 196, "C"), ("IKC3", 301, "C"),
 ("IKC4", 245, "C"), ("IKC3", 290, "B"),
]
def rec(job): return sorted(glob.glob(R + f"plans/FS131-{job}-*.md"))[0]
def bullets(job, start):
    t = open(rec(job)).read().split("\n"); i = start  # line after heading (0-based index start)
    # a heading line may itself carry text; begin after it
    out = []; cur = None
    for l in t[i:]:
        if re.match(r"^(#{1,4} |\*\*\S|---)", l) and not l.startswith("- "): break
        if re.match(r"^- \*\*`?(LEAN|ARCH|BIBL|CLAUDE|LEDGER)", l): break
        m = re.match(r"^(\s*)- (.*)$", l)
        if m:
            if cur is not None: out.append(cur)
            cur = m.group(2)
        elif cur is not None and l.strip() and l.startswith("  "): cur += " " + l.strip()
        elif cur is not None and not l.strip():
            out.append(cur); cur = None
        elif l.strip() and cur is None and not l.startswith(" "): 
            pass
    if cur is not None: out.append(cur)
    res = []
    for b in out:
        b = flat(b)
        b = re.sub(r"^\*?\"(.*?)\"\*?[.]?$", r"\1", b) if re.match(r"^\*?\".*\"\*?\.?$", b) else b
        res.append(b)
    return res
if __name__ == "__main__":
    L = flat(open(R + "LEAN.md").read())
    for job, st, sec in BLOCKS:
        bs = bullets(job, st)
        print(f"== {job} line {st} sec {sec}: {len(bs)} bullets; filed {sum(1 for b in bs if b[:70] in L)}")
        for b in bs: print("   ", ("F " if b[:70] in L else "  "), b[:100])
