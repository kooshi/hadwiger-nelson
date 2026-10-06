#!/usr/bin/env python3
"""FS131-MC1 — which of wave 5's sixty-two open gate items this tree closes, read from the docstrings.

The list is FS131-L5's `data/fs131/l5/open-gate-items.txt` (62 theorems of `Plane/ValidMap` whose docstring named a hand model, an owed
model or an open gate item at wave 5's landing). For each name this tool reads the docstring in the given tree and says
  CLOSED  it names a Lean model of this lane (`hornModel`, `twoHornModel`, `stuckModel`, `shadowModel`, `awayModel`) and carries no
          sentence that something is still open (OPEN below);
  REMAIN  otherwise.
It reads what the docstrings say; that a named model meets the hypotheses is checked by elaboration, in `Plane/Models/Applied`.

  fs131_mc_gateitems.py [--tree DIR] [--list FILE]   the two lists by name, and their counts
  fs131_mc_gateitems.py --self-test MAIN_TREE        on `main`'s tree at wave 5's landing every one of the 62 must read REMAIN and be
                                                     found; a planted docstring must read CLOSED and its partner REMAIN
"""
import os, re, sys

MODEL = re.compile(r"`(hornModel|twoHornModel|stuckModel|shadowModel|awayModel)`")
OPEN = re.compile(r"open\s+gate\s+item|[Nn]o\s+Lean\s+model|none\s+in\s+Lean|not\s+proved|\bowed\b|no\s+Lean\s+object|not\s+stated\s+in\s+Lean|"
                  r"no\s+model\s+expected|not\s+on\s+file\s+for")
L5 = "data/fs131/l5/open-gate-items.txt"


def names_of(path):
    out = []
    for line in open(path):
        p = line.rstrip("\n").split("\t")
        if len(p) >= 2 and p[0].endswith(".lean"):
            out.append((p[0], p[1]))
    return out


def doc_of(tree, mod, name):
    src = open(os.path.join(tree, "Proofs/HadwigerNelson", mod)).read()
    cands = [name, name.split(".")[-1]]
    for n in cands:
        m = re.search(r"^(?:@\[[^\]]*\]\s*)?(?:theorem|def|noncomputable def) " + re.escape(n) + r"(?![\w.'])", src, re.M)
        if m:
            end = src.rfind("-/", 0, m.start())
            start = src.rfind("/--", 0, end)
            return src[start:end]
    # a note kept on the structure the field belongs to (`CollarFitOut.pushOutProfiles`)
    m = re.search(r"^structure " + re.escape(name.split(".")[0]) + r"\b", src, re.M)
    if m:
        end = src.rfind("-/", 0, m.start()); start = src.rfind("/--", 0, end)
        return src[start:end]
    return None


def verdict(doc):
    return "CLOSED" if (MODEL.search(doc) and not OPEN.search(doc)) else "REMAIN"


def run(tree, lst):
    rows = []
    for mod, name in names_of(lst):
        doc = doc_of(tree, mod, name)
        rows.append((mod, name, "NOT-FOUND" if doc is None else verdict(doc)))
    return rows


def main(argv):
    tree = argv[argv.index("--tree") + 1] if "--tree" in argv else os.getcwd()
    if "--self-test" in argv:
        mt = argv[argv.index("--self-test") + 1]
        rows = run(mt, os.path.join(mt, L5))
        bad = [r for r in rows if r[2] != "REMAIN"]
        print(f"on {mt}: {len(rows)} names, {len(bad)} not REMAIN {bad[:5]}")
        p1 = verdict("/-- Inhabitant: `hornModel` at `plantPt` (`hornModel_shave`). ")
        p2 = verdict("/-- In Lean `stuckModel` meets every hypothesis but `hT`, which is not proved for it. ")
        p3 = verdict("/-- Inhabitant: owed with the away bend's model. ")
        p4 = verdict("/-- Inhabitant: `shadowModel`, its band doubly shadowed, the cone allowed. ")   # `owed` inside a word is no sentence
        print("plants:", p1, p2, p3, p4)
        ok = len(rows) == 62 and not bad and (p1, p2, p3, p4) == ("CLOSED", "REMAIN", "REMAIN", "CLOSED")
        print("self-test:", "OK" if ok else "FAIL"); return 0 if ok else 1
    lst = argv[argv.index("--list") + 1] if "--list" in argv else os.path.join(tree, L5)
    rows = run(tree, lst)
    for k in ("CLOSED", "REMAIN", "NOT-FOUND"):
        s = [r for r in rows if r[2] == k]
        print(f"{k} {len(s)}")
        for mod, name, _ in s:
            print(f"  {mod}\t{name}")
    return 1 if any(r[2] == "NOT-FOUND" for r in rows) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
