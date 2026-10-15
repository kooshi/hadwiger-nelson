#!/usr/bin/env python3
"""FS131-IKC4: the landing's `scripts/Axioms.lean` CLEAN block for this job's modules, from their sources' public
`def`/`theorem` names, each checked present in the built tree's print (`data/fs131/ikc4/axioms.txt`) with axioms a subset
of the standard three. Exit 1 if a name is missing from the print or reads otherwise. Usage: axioms_block.py AXIOMS OUT"""
import re, sys, glob
STD = {"propext", "Classical.choice", "Quot.sound"}
ax = {}
for l in open(sys.argv[1]):
    m = re.match(r"AX (\S+) : \[(.*)\]$", l.strip())
    if m: ax[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
files = ["Proofs/HadwigerNelson/Arith/FibreCertFast.lean"] + sorted(glob.glob("Proofs/HadwigerNelson/Arith/FibreCert19*.lean"))
names, bad = [], []
for f in files:
    ns = "HadwigerNelson.FibreCert"
    for line in open(f):
        if line.startswith("namespace "): ns = line.split()[1].strip()
        m = re.match(r"(?:theorem|def) (\S+)", line)
        if m:
            n = f"{ns}.{m.group(1)}"
            names.append(n)
            if n not in ax or not ax[n] <= STD: bad.append(n)
out = ["-- FS131-IKC4 block: `Arith/FibreCertFast`, `Arith/FibreCert19*` — %d records: the reduced p = 19 certificate accepted, the bound at p = 19" % len(names)]
out += [f"#print axioms {n}" for n in names] + ["-- FS131-IKC4 block end"]
open(sys.argv[2], "w").write("\n".join(out) + "\n")
print(f"{len(names)} records; missing or not clean: {bad}")
sys.exit(1 if bad or not names else 0)
