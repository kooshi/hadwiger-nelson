#!/usr/bin/env python3
"""FS131-LU1: the compiled library of this tree, `.olean` by `.olean`, against a manifest of itself.

Why: at stage 1 the compiled files of the tree the last landing gated in (`.claude/worktrees/fs131-wkc`) were copied
into this tree by checksum, and the comparison made then (`rsync-dry.out`, `rsync-real.out`, and the dry run after)
showed every file of that tree's build byte for byte in this one.  About four minutes later the coordinator moved
that tree to `.claude/worktrees/fs133-wk1` for the next job, and it was built in there (this docstring first said
"removed by another hand": a wrong reading of a path that had stopped existing), so the comparison cannot be made
again against the files it was made with.  What can be
shown at the pass is that nothing has rewritten a copied file since: this tool.

  compiled_unchanged.py manifest            print `<sha256> <mtime, UTC> <path>` for every `.olean` under
                                            .lake/build/lib/lean/Proofs* (the manifest: made once, after the first build)
  compiled_unchanged.py check MANIFEST      recompute and compare.  A file may differ only if it belongs to a module in
                                            MAY_REBUILD (the landing's three and the root, which later builds recompile
                                            from texts whose docstrings moved); every other `.olean` must have the
                                            manifest's SHA-256 AND its mtime — and that mtime must be earlier than COPIED,
                                            the moment of the copy: no compiler has written it in this tree.  The files
                                            NAMED (the import's ten modules and the last landing's three) are printed.
  compiled_unchanged.py check MANIFEST --plant
                                            in memory: one hash of the manifest altered, one mtime moved past COPIED, one
                                            file dropped from the tree's list, one added.  Each must be reported.
Exit 0 when the check holds (or every plant fired); 1 otherwise."""
import datetime
import hashlib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
LIB = ROOT / ".lake" / "build" / "lib" / "lean"
COPIED = "2026-10-13T20:21:30Z"   # the copy ended before this (rsync-real.out, its after-check; stage 1)
MAY_REBUILD = {"Proofs.olean", "Proofs/HadwigerNelson/Arith/UpperHalf.olean", "Proofs/HadwigerNelson/Arith/QuadraticPrime.olean",
               "Proofs/HadwigerNelson/Instances/UpperHalfValues.olean"}
NAMED = ["Proofs/HadwigerNelson/Outside/" + m + ".olean" for m in (
    "OAI158 OAI158Palette OAI158CircleMaps OAI158CircleTransport OAI158Expansion OAI158PaletteDensity "
    "OAI158PaletteTransport OAI158AngularBoundary OAI158BinaryPalettes OAI158States").split()] + [
        "Proofs/HadwigerNelson/Plane/" + m + ".olean" for m in "AeColouring FalconerReduction LebesgueNumber".split()]


def scan():
    out = {}
    for f in sorted(LIB.rglob("*.olean")):
        rel = f.relative_to(LIB).as_posix()
        if not (rel == "Proofs.olean" or rel.startswith("Proofs/")):
            continue
        t = datetime.datetime.fromtimestamp(f.stat().st_mtime, datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
        out[rel] = (hashlib.sha256(f.read_bytes()).hexdigest(), t)
    return out


def read(path):
    out = {}
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if len(p) == 3:
            out[p[2]] = (p[0], p[1])
    return out


def check(man, now):
    bad = []
    for rel in sorted(set(man) | set(now)):
        if rel not in now:
            bad.append(f"GONE {rel}: in the manifest, not in the tree")
        elif rel not in man:
            bad.append(f"NEW {rel}: in the tree, not in the manifest")
        elif rel in MAY_REBUILD:
            continue
        else:
            if man[rel][0] != now[rel][0]:
                bad.append(f"CONTENT {rel}: {man[rel][0][:16]} in the manifest, {now[rel][0][:16]} now")
            if man[rel][1] != now[rel][1]:
                bad.append(f"REWRITTEN {rel}: mtime {man[rel][1]} in the manifest, {now[rel][1]} now")
            elif now[rel][1] >= COPIED:
                bad.append(f"WRITTEN-HERE {rel}: mtime {now[rel][1]} is not earlier than the copy ({COPIED})")
    return bad


def main(argv):
    if argv[:1] == ["manifest"]:
        for rel, (h, t) in scan().items():
            print(h, t, rel)
        return 0
    if argv[:1] != ["check"] or len(argv) < 2:
        print(__doc__)
        return 2
    man, now = read(argv[1]), scan()
    if not man or not now:
        print(f"UNREADABLE: manifest {len(man)}, tree {len(now)}")
        return 2
    bad = check(man, now)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted pair already fails ({len(bad)})")
            return 1
        victim = NAMED[0]
        other = sorted(r for r in man if r not in MAY_REBUILD and r != victim)[0]
        plants = [
            ("a hash of the manifest altered", "CONTENT " + victim, {**man, victim: ("0" * 64, man[victim][1])}, now),
            ("a file written after the copy", "WRITTEN-HERE " + other,
             {**man, other: (man[other][0], "2026-10-13T21:00:00Z")}, {**now, other: (now[other][0], "2026-10-13T21:00:00Z")}),
            ("a file gone from the tree", "GONE " + victim, man, {r: v for r, v in now.items() if r != victim}),
            ("a file the manifest does not hold", "NEW Proofs/HadwigerNelson/Plane/zz_lu1_plant.olean", man,
             {**now, "Proofs/HadwigerNelson/Plane/zz_lu1_plant.olean": ("1" * 64, "2026-10-13T21:00:00Z")}),
        ]
        ok = True
        for label, prefix, m, n in plants:
            fired = [b for b in check(m, n) if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else ''}")
            ok = ok and bool(fired)
        print(f"plants: {'every one of 4 fired; the unplanted pair passes' if ok else 'FAILED'}")
        return 0 if ok else 1
    rebuilt = sorted(r for r in MAY_REBUILD if r in man and r in now and man[r] != now[r])
    print(f".olean files of Proofs: {len(now)} in the tree, {len(man)} in the manifest; allowed to move: {len(MAY_REBUILD)} "
          f"(moved since the manifest: {len(rebuilt)}: {', '.join(rebuilt) if rebuilt else 'none'})")
    latest = max(v[1] for r, v in now.items() if r not in MAY_REBUILD)
    print(f"every other file: same SHA-256, same mtime, written before the copy ({COPIED}); the latest of them: {latest}")
    for rel in NAMED:
        print(f"  {'identical' if rel in man and rel in now and man[rel] == now[rel] else 'MOVED    '} "
              f"{now.get(rel, ('?' * 16, '?'))[0][:16]} {now.get(rel, ('', '?'))[1]} {rel}")
    for b in bad:
        print("FAIL", b)
    print("compiled-unchanged: PASS" if not bad else f"compiled-unchanged: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
