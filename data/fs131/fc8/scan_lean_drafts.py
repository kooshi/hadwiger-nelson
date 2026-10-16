# FS131-FC8: list the LEAN.md draft bullets each owed record carries, and whether each already stands in LEAN.md.
import re, glob, os, sys
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
def flat(s): return re.sub(r"\s+", " ", s).strip()
L = flat(open(R + "LEAN.md").read())
jobs = "KN7 KN8 KN9 KT1 K8B1 KPD1 KR1 K12A KDB1 KC13 KM11 ITK1 IJ1 IJ2 IJ3 IM11 ILA1 ICL1 ICL2 ICM1 ICM2 IKC1 IKC2 IKC3 IDB1 IDB2 IDB3 IN1L IDG1 IG1 IPA1 IPB1 IPD1 IP23 ITT1 IKC4".split()
for j in jobs:
    f = sorted(glob.glob(R + f"plans/FS131-{j}-*.md"))[0]
    t = open(f).read().split("\n")
    print("=====", j, os.path.basename(f))
    for i, l in enumerate(t):
        if re.search(r"LEAN\.md", l) and re.search(r"(§ Searching|§ The kernel|§ Building|§ Assumptions|§ The gate|§ Trust|lines)", l) and (l.startswith("#") or l.startswith("**") or l.startswith("- **")) and "read" not in l[:40].lower():
            print(f"-- line {i+1}: {l[:160]}")
