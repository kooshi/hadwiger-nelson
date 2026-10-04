#!/usr/bin/env python3
"""FS131-K3b: list the fully qualified theorem/def names of wave 3's skeleton modules (for scripts/Axioms.lean).

Tracks `namespace X` / `end X` / `section` / `end`; prints one `#print axioms` line per `theorem` and per `def` whose body
uses a theorem of the module (passed with --defs). Plant: `--plant` drops the namespace tracking, and the check
(`--check`, every printed name occurs in scripts/Axioms.lean) must then fail."""
import re, sys
MODS = ["LocalStructure", "SixFragment", "Tiles", "RingGerm", "Lens", "RingBand"]
DEFS = {"sixFrag", "ringCircleColouring"}
def names(path, plant=False):
    stack, out = [], []
    for line in open(path):
        m = re.match(r"^namespace (\S+)", line)
        if m: stack.append(("ns", m.group(1))); continue
        if re.match(r"^section\b", line): stack.append(("sec", None)); continue
        if re.match(r"^end\b", line):
            if stack: stack.pop()
            continue
        m = re.match(r"^(?:private |protected )?(theorem|noncomputable def|def) (\S+)", line)
        if m:
            kind, n = m.group(1), m.group(2)
            if kind != "theorem" and n not in DEFS: continue
            ns = ".".join(x for k, x in stack if k == "ns") if not plant else ""
            out.append((ns + "." + n) if ns else n)
    return out
def main():
    plant = "--plant" in sys.argv
    allnames = []
    for m in MODS:
        allnames += names(f"Proofs/HadwigerNelson/Plane/{m}.lean", plant)
    if "--check" in sys.argv:
        ax = open("scripts/Axioms.lean").read()
        missing = [n for n in allnames if f"#print axioms {n}\n" not in ax]
        print(f"{len(allnames)} names, {len(missing)} missing"); [print(" missing:", n) for n in missing]
        sys.exit(1 if missing else 0)
    for n in allnames: print(f"#print axioms {n}")
main()
