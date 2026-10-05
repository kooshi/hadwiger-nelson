#!/usr/bin/env python3
"""FS131-K4: list the theorems of wave 4's skeleton modules with their full names, and check scripts/Axioms.lean records each.

`--check` fails if any theorem lacks a `#print axioms` record; `--plant` drops the namespace tracking (so names come out
unqualified) and shows the check firing.

A name written `_root_.X` inside a namespace declares `X` itself (FS131-G4, inventory item 281 (b)): it is resolved to `X`, never
`<namespace>._root_.X`. `--plant-root` turns that resolution off and must fire on exactly the `_root_.` theorems of the five modules
(at least one), beside the faithful `--check`, which must pass.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
MODS = ["Proofs/HadwigerNelson/Plane/StuckChain.lean", "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean",
        "Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean", "Proofs/HadwigerNelson/Plane/SVMap.lean",
        "Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean"]
# Definitions built from `sorry` leaves (FS131-K4b): recorded like theorems, so their axioms are audited when the leaves land.
DEFS = {"toAeProperRegions", "sevenBrickMap", "sevenBrickRegions", "bowtie", "l60Frag", "isoFrag"}


def qualify(ns, name, root=True):
    """The declared name: `_root_.X` is `X` whatever the open namespaces (with `root=False`, the old textual join)."""
    if root and name.startswith("_root_."):
        return name[len("_root_."):]
    return ".".join(ns + [name])


def names(track=True, root=True):
    out = []
    for m in MODS:
        ns = []
        for line in (ROOT / m).read_text().split("\n"):
            mo = re.match(r"namespace (\S+)", line)
            if mo and track:
                ns.append(mo.group(1)); continue
            mo = re.match(r"end (\S+)", line)
            if mo and track and ns and ns[-1] == mo.group(1):
                ns.pop(); continue
            mo = re.match(r"theorem (\S+)", line)
            if mo:
                out.append(qualify(ns, mo.group(1), root))
            mo = re.match(r"(?:noncomputable )?def (\S+)", line)
            if mo and mo.group(1) in DEFS:
                out.append(qualify(ns, mo.group(1), root))
    return out


def check(ns):
    ax = (ROOT / "scripts" / "Axioms.lean").read_text()
    missing = [n for n in ns if f"#print axioms {n}\n" not in ax]
    return missing


if __name__ == "__main__":
    if "--plant-root" in sys.argv:
        roots = [n for n in names() if n not in names(root=False)]
        miss = check(names(root=False))
        # two-sided: the plant fires, and on exactly the `_root_.` names (none of the others goes missing with it)
        ok = len(roots) > 0 and len(miss) == len(roots) and all(any(m.endswith("._root_." + r) for m in miss) for r in roots)
        print(f"plant (_root_ resolution off): {'FIRED' if ok else 'MISSED'} ({len(miss)} missing, {len(roots)} _root_ names)",
              *miss, sep="\n  ")
        sys.exit(0 if ok else 1)
    if "--plant" in sys.argv:
        miss = check(names(track=False))
        print("plant (namespaces dropped):", "FIRED" if miss else "MISSED", f"({len(miss)} missing)")
        sys.exit(0 if miss else 1)
    ns = names()
    if "--check" in sys.argv:
        miss = check(ns)
        print(f"check: {len(ns)} names, {len(miss)} missing", *miss, sep="\n  ")
        sys.exit(1 if miss else 0)
    print("\n".join(f"#print axioms {n}" for n in ns))
