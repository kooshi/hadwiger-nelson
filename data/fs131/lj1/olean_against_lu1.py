#!/usr/bin/env python3
"""FS131-LJ1: the compiled library of this tree, `.olean` by `.olean`, against the manifest the last landing made of
its own gated tree (`data/fs131/lu1/olean-manifest.txt`: SHA-256, mtime and path of the 1,902 `.olean` files of
`Proofs` in `.claude/worktrees/fs131-wnf`, made after that landing's first build).

Why: this tree's compiled library is a copy of that tree's (`rsync -a --checksum --delete`, by the joining job:
`data/fs131/kj1/copy_build.sh`), in which the joining job and this landing then compiled only the line's six modules
and the root.  What this shows at the pass, from the bytes: every `.olean` the last landing's manifest lists is in this
tree with the manifest's SHA-256, except those of the modules in MAY_DIFFER — the last landing's three and the root,
which that landing recompiled after it made the manifest (its record, stage 8: "allowed to move: 4") — and the files
this tree has that the manifest has not are exactly those of the line's six modules.  So no other module of the
library has been recompiled or rewritten since the last landing's gate read it: `Outside/OAI158` and the nine ported
modules, and `Plane/LebesgueNumber`, are named and must be identical.

  olean_against_lu1.py [--plant]
With --plant, in memory, one at a time: a manifest hash altered (CHANGED), a tree file dropped (GONE), a file added
outside the six modules (EXTRA), one of the six modules' files removed from the tree's list (SIX-MISSING).  Each must
be reported, after the unplanted comparison passes.  Exit 0 when the check holds (or every plant fired); 1 otherwise."""
import hashlib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
LIB = ROOT / ".lake" / "build" / "lib" / "lean"
MAN = ROOT / "data" / "fs131" / "lu1" / "olean-manifest.txt"
H = "Proofs/HadwigerNelson/"
MAY_DIFFER = {"Proofs", H + "Arith/UpperHalf", H + "Arith/QuadraticPrime", H + "Instances/UpperHalfValues"}
SIX = {H + "Arith/ThreeColourCharacter", H + "Arith/TorsionExtraction", H + "Arith/ThreeColourCriterion",
       H + "Arith/DyadicQuadratic", H + "Arith/ThreeFourColours", H + "Instances/UpperHalfCorollaries"}
NAMED = [H + "Outside/OAI158", H + "Plane/LebesgueNumber", H + "Plane/AeColouring", H + "Arith/WeilKloosterman",
         H + "SpectralChain"]


def module(path):
    """Proofs/X/Y.olean -> Proofs/X/Y"""
    return path[:-len(".olean")]


def tree():
    out = {}
    for f in sorted(LIB.rglob("*.olean")):
        rel = f.relative_to(LIB).as_posix()
        if rel == "Proofs.olean" or rel.startswith("Proofs/"):
            out[rel] = hashlib.sha256(f.read_bytes()).hexdigest()
    return out


def manifest():
    out = {}
    for ln in MAN.read_text().splitlines():
        h, _, p = ln.split(" ", 2)
        out[p] = h
    return out


def check(t, m):
    bad = []
    for p, h in m.items():
        if p not in t:
            bad.append(f"GONE {p}: in the last landing's manifest, not in this tree")
        elif t[p] != h and module(p) not in MAY_DIFFER:
            bad.append(f"CHANGED {p}: SHA-256 differs from the last landing's manifest")
    extra = sorted(p for p in t if p not in m)
    for p in extra:
        if module(p) not in SIX:
            bad.append(f"EXTRA {p}: not in the manifest and not one of the six modules")
    have = {module(p) for p in extra}
    for s in sorted(SIX - have):
        bad.append(f"SIX-MISSING {s}: no compiled file of this module in the tree")
    return bad, extra


def main():
    t, m = tree(), manifest()
    if len(t) < 1000 or len(m) < 1000:
        print(f"UNREADABLE: tree {len(t)} files, manifest {len(m)}")
        return 2
    bad, extra = check(t, m)
    if "--plant" in sys.argv:
        if bad:
            print("PLANT NOT RUN: the unplanted comparison fails")
            return 1
        some = next(p for p in m if module(p) not in MAY_DIFFER)
        six = next(p for p in t if module(p) in SIX)
        plants = [("a manifest hash altered", "CHANGED", t, {**m, some: "0" * 64}),
                  ("a tree file dropped", "GONE", {p: h for p, h in t.items() if p != some}, m),
                  ("a file added outside the six", "EXTRA", {**t, "Proofs/HadwigerNelson/ZzPlanted.olean": "1" * 64}, m),
                  ("the six modules' files of one module absent", "SIX-MISSING",
                   {p: h for p, h in t.items() if module(p) != module(six)}, m)]
        ok = True
        for label, prefix, tt, mm in plants:
            b, _ = check(tt, mm)
            fired = [x for x in b if x.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else b[:1]}")
            ok = ok and bool(fired)
        print("plants: " + (f"every one of {len(plants)} fired; the unplanted comparison passes" if ok else "FAILED"))
        return 0 if ok else 1
    differ = sorted(p for p, h in m.items() if p in t and t[p] != h)
    print(f".olean files of Proofs: {len(t)} in the tree, {len(m)} in the last landing's manifest; "
          f"same SHA-256: {sum(1 for p, h in m.items() if t.get(p) == h)}; differing: {len(differ)} "
          f"(allowed: the modules {sorted(MAY_DIFFER)}); in the tree only: {len(extra)}")
    for p in differ:
        print(f"  differs: {p}")
    for p in extra:
        print(f"  in the tree only: {p}")
    for n in NAMED:
        ps = [p for p in m if module(p) == n]
        print(f"  named: {n}: {len(ps)} file(s), {'identical' if ps and all(t.get(p) == m[p] for p in ps) else 'NOT IDENTICAL'}")
    for b in bad:
        print("FAIL", b)
    print("olean-against-lu1: PASS" if not bad else f"olean-against-lu1: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
