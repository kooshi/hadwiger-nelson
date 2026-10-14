#!/usr/bin/env python3
"""FS131-IPD1, the switch for the transfer (plans/FS131-KO1-port-plan.md § 4.4, steps 1 and 2), made and checked as
text.

Step 1: in `Outside/OAI158`, the `axiom proper_to_borel_weak` (with its docstring) is deleted; the five declarations
that use it and the `example` that applies it — MOVED, below — are moved, character for character with their
docstrings, into the new module `Outside/OAI158Collapse` (imports `Outside/OAI158BorelTransfer` and `Plane/YesLimit`,
the same `open` and namespace); the module docstring of `OAI158` is rewritten to say the transfer is a theorem of the
port, and its section heading over the outside theorems says one.  Step 2: in `Plane/RadiusOutside` and
`Plane/LebesgueNumber` the one line `import Proofs.HadwigerNelson.Outside.OAI158` becomes
`import Proofs.HadwigerNelson.Outside.OAI158Collapse`; nothing else.

Usage:
  fs131_ipd1_switch.py apply <rev>     write the four files from their text at <rev> (the switch's base)
  fs131_ipd1_switch.py check <rev>     compare the four files on disk with their text at <rev>: each moved block is the
                                       same bytes in `OAI158Collapse` and absent from `OAI158`; `OAI158` is its text at
                                       <rev> less exactly the moved blocks and the axiom, with exactly the module
                                       docstring and the one heading rewritten; the two imports are the only change in
                                       the two leaf modules.  Exit 0 iff all hold
  fs131_ipd1_switch.py --control <rev> plant four faults in copies (a byte of a moved block changed in the new module;
                                       a moved block left in `OAI158`; another line of `OAI158` changed; a second line
                                       changed in a leaf module) and require each reported
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = "Proofs/HadwigerNelson/Outside"
OAI = f"{OUT}/OAI158.lean"
COL = f"{OUT}/OAI158Collapse.lean"
LEAVES = ["Proofs/HadwigerNelson/Plane/RadiusOutside.lean", "Proofs/HadwigerNelson/Plane/LebesgueNumber.lean"]
OLD_IMPORT = "import Proofs.HadwigerNelson.Outside.OAI158"
NEW_IMPORT = "import Proofs.HadwigerNelson.Outside.OAI158Collapse"
MOVED = ["theorem nonempty_aeColouring_of_colorable", "theorem colorable_iff_nonempty_aeColouring",
         "theorem chiM0_le_chromaticNumber_plane", "theorem chromaticNumber_plane_eq_chiM0",
         "example : ∃ d : ℂ → Fin 7, Measurable d ∧ WeakColoring 7 d", "theorem seven_le_chromaticNumber_plane_iff"]
AXIOM = "axiom proper_to_borel_weak"
OLD_HEADING = "/-! ## The two outside theorems, in the release's form -/"
NEW_HEADING = "/-! ## The outside theorem, in the release's form -/"

NEW_DOC = """/-!
# The plane is not five-colourable: an outside theorem, imported (FS-132); the transfer, a theorem of the port (FS-131)

**The outside theorem of this module** is `[OAIMath2026]` family 158 — a Lean development published at
github.com/openai/math, read here at its commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` — an `axiom` **in the
release's own form, over the release's own definitions, copied**:

* `no_proper_five_coloring` (H): no map `ℂ → Fin 5` gives different colours to every two points at distance `1`.

**The transfer** `proper_to_borel_weak` (T) — a proper `k`-colouring of `ℂ`, for any `k`, gives a Borel `k`-colouring
proper at almost every unit pair — was declared here as a second axiom, over the same copied definitions. It is now the
release's own theorem, its proof ported (`Outside/OAI158BorelTransfer`, under the same name, over these definitions;
FS-131, the port of `plans/FS131-KO1-port-plan.md`) and kernel-checked in this library on the standard three axioms.
The port imports `Outside/OAI158Palette`, which imports this module, so T stands downstream of it: the theorems that use
T — `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, `chiM0_le_chromaticNumber_plane`,
`chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff`, and the `example` that applies it — are in
`Outside/OAI158Collapse`, moved there unchanged (FS131-IPD1).

Everything else in this file is kernel-checked: the passage from the release's definitions to this library's
(`properColoring_iff_colorable`, `weakColoring_iff_unitPairsNull`), and the forms of H this library cites —
`six_le_chromaticNumber_plane`, `chromaticNumber_plane_six_or_seven`, `six_le_chiM0`, `chiM0_six_or_seven`.

**Why an axiom, and what was checked.** The release proves H at Lean v4.34.1 on Mathlib's tag `v4.34.1`, in 70
modules; this library is at v4.32.0, and its five-colour arm is not ported (`plans/FS131-KO1-port-plan.md` § 2.4). The
release was audited on this machine (`plans/EXT-OAI1-audit.md`): its 70 modules compile from its source, H rests on
`[propext, Classical.choice, Quot.sound]` there (a planted `sorry` reaches the headline), the headline's stored
statement is the release's challenge statement, and the modules replay through `leanchecker`. **The read-back** is
`plans/FS132-I1-implementation.md` (stages 1 and 2): the six copied declarations below and the statements of H and T
are, as the kernel stores them at this pin, the release's as the kernel stores them at the release's pin, term for
term (`tools/fs132_i1_readback.py`, on `data/fs132/i1/readback/`). What no check here reaches is Mathlib itself between
the two tags, below the constants H's statement names; what stands in for it is the equivalences above, which say in
this library's own vocabulary what the axiom asserts at this pin, and nine characterisations of the copied definitions
that elaborate, as one text, at both pins (`SemanticBody.lean.inc` there).

**Licence.** The release is published under the Apache License, Version 2.0, and the declarations copied from it
below are used under that licence: a byte-identical copy of its `LICENSE` file is beside this module,
`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`.

**Read aloud.** H: colour every point of the plane with one of five colours; then some two points exactly one unit
apart have the same colour.

**What the axiom does not say.** H says nothing at six colours. The release's rigidity theorem and its measurable
five-colour theorem are not imported: no statement here cites them.

**Models** (`LEAN.md` § Assumptions, item 3). H has no hypothesis; its sentence at four colours is this library's own
theorem and at seven it is false (the two `example`s under H). T's hypothesis is inhabited at `k = 7`
(`exists_properColoring_seven`, row 33's upper end), and there its conclusion is a theorem with no axiom
(`proper_to_borel_weak_model`).
-/"""

COL_HEAD = """import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer
import Proofs.HadwigerNelson.Plane.YesLimit

/-!
# The transfer's consumers: the plane's chromatic number is its measurable one (FS-132; moved by FS-131)

`proper_to_borel_weak` (T), `[OAIMath2026]` family 158's transfer of colourability, is a theorem of this library: its
proof is ported (`Outside/OAI158BorelTransfer`, under its name; FS-131, the port of `plans/FS131-KO1-port-plan.md`).
The declarations below are this library's forms of it — `χ(ℝ²) = χ_m⁰(ℝ²)` and the criterion
`7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1` among them. They stood in `Outside/OAI158` while T was declared there as an axiom, and moved
here unchanged, character for character with their docstrings (FS131-IPD1, the switch of the plan's § 4.4), because the
ported theorem is downstream of that module. Where a docstring below says a theorem "rests on the standard three axioms
and `proper_to_borel_weak`", it now names a theorem: each rests on the standard three axioms.
-/

open MeasureTheory

namespace HadwigerNelson.Outside.OAI158
"""
COL_TAIL = "\nend HadwigerNelson.Outside.OAI158\n"


def at_rev(rev, path):
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{rev}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def block(lines, key):
    """(first, last) line indices of the declaration whose first code line starts with `key`, its docstring included:
    from the `/--` above it to the last non-blank line before the next blank line."""
    k = next(i for i, ln in enumerate(lines) if ln.startswith(key))
    a = k
    while not lines[a].startswith("/--"):
        a -= 1
    b = k
    while b + 1 < len(lines) and lines[b + 1] != "":
        b += 1
    return a, b


def make(text):
    """-> (the new OAI158 text, the new OAI158Collapse text, the moved blocks' texts)."""
    ls = text.split("\n")
    spans = [block(ls, k) for k in MOVED] + [block(ls, AXIOM)]
    drop = set()
    for a, b in spans:
        drop.update(range(a, b + 2))          # the block and the blank line after it
    moved = ["\n".join(ls[a:b + 1]) for a, b in spans[:-1]]
    keep = [ln for i, ln in enumerate(ls) if i not in drop]
    s = keep.index("/-!")
    e = next(i for i in range(s, len(keep)) if keep[i] == "-/")
    keep = keep[:s] + NEW_DOC.split("\n") + keep[e + 1:]
    h = [i for i, ln in enumerate(keep) if ln == OLD_HEADING]
    if len(h) != 1:
        raise SystemExit(f"the heading {OLD_HEADING!r} is not there exactly once")
    keep[h[0]] = NEW_HEADING
    col = COL_HEAD + "\n" + "\n\n".join(moved) + "\n" + COL_TAIL
    return "\n".join(keep), col, moved


def leaf(text):
    ls = text.split("\n")
    hits = [i for i, ln in enumerate(ls) if ln == OLD_IMPORT]
    if len(hits) != 1:
        raise SystemExit(f"`{OLD_IMPORT}` is not there exactly once")
    ls[hits[0]] = NEW_IMPORT
    return "\n".join(ls)


def check(rev, files=None, quiet=False):
    files = files or {}
    rd = lambda p: files[p] if p in files else (ROOT / p).read_text()
    old = at_rev(rev, OAI)
    new_oai, new_col, moved = make(old)
    bad = []
    got_oai, got_col = rd(OAI), rd(COL)
    for k, m in zip(MOVED, moved):
        if got_col.count(m) != 1:
            bad.append(f"moved block `{k}` is not, byte for byte, once in OAI158Collapse")
        if m in got_oai or got_oai.count("\n" + k) != 0:
            bad.append(f"moved block `{k}` is still in OAI158")
    if got_oai != new_oai:
        bad.append("OAI158 is not its text at the base less the moved blocks and the axiom, with the docstring and "
                   "the heading rewritten")
    if got_col != new_col:
        bad.append("OAI158Collapse is not the moved blocks under its header")
    if AXIOM in got_oai:
        bad.append("the axiom is still in OAI158")
    for p in LEAVES:
        o, g = at_rev(rev, p).split("\n"), rd(p).split("\n")
        diff = [i for i in range(max(len(o), len(g))) if (o[i] if i < len(o) else None) != (g[i] if i < len(g) else None)]
        if len(o) != len(g) or len(diff) != 1 or o[diff[0]] != OLD_IMPORT or g[diff[0]] != NEW_IMPORT:
            bad.append(f"{p}: the diff is not exactly the import line ({len(diff)} lines differ)")
    if not quiet:
        for x in bad:
            print("FAIL:", x)
        print(f"SWITCH-CHECK {'OK' if not bad else 'FAILED'}: {len(MOVED)} blocks moved, "
              f"{sum(m.count(chr(10)) + 1 for m in moved)} lines; the axiom gone; two imports changed")
    return bad


def main():
    if sys.argv[1] == "apply":
        rev = sys.argv[2]
        new_oai, new_col, _ = make(at_rev(rev, OAI))
        (ROOT / OAI).write_text(new_oai)
        (ROOT / COL).write_text(new_col)
        for p in LEAVES:
            (ROOT / p).write_text(leaf(at_rev(rev, p)))
        print("wrote", OAI, COL, *LEAVES)
        return 0
    if sys.argv[1] == "check":
        return 1 if check(sys.argv[2]) else 0
    if sys.argv[1] == "--control":
        rev = sys.argv[2]
        base = {p: (ROOT / p).read_text() for p in [OAI, COL] + LEAVES}
        ok = not check(rev, base, quiet=True)
        print(f"unplanted: {'PASS' if ok else 'FAILED'}")
        _, _, moved = make(at_rev(rev, OAI))
        plants = []
        f1 = dict(base)
        m = moved[2]
        i = len(m) // 2
        f1[COL] = base[COL].replace(m, m[:i] + ("X" if m[i] != "X" else "Y") + m[i + 1:])
        plants.append(("a byte of a moved block changed in OAI158Collapse", f1))
        f2 = dict(base)
        f2[OAI] = base[OAI].replace("\nend HadwigerNelson.Outside.OAI158", "\n" + moved[0] + "\n\nend HadwigerNelson.Outside.OAI158")
        plants.append(("a moved block left in OAI158", f2))
        f3 = dict(base)
        f3[OAI] = base[OAI].replace("theorem not_colorable_five", "theorem not_colorable_five ", 1)
        plants.append(("another line of OAI158 changed", f3))
        f4 = dict(base)
        f4[LEAVES[0]] = base[LEAVES[0]].replace("\nnamespace ", "\n-- planted\nnamespace ", 1)
        plants.append(("a second line changed in RadiusOutside", f4))
        for label, fs in plants:
            r = check(rev, fs, quiet=True)
            print(f"plant '{label}': {'REPORTED' if r else 'SILENT'}")
            ok = ok and bool(r)
        print("CONTROL OK" if ok else "CONTROL FAILED")
        return 0 if ok else 1
    raise SystemExit(__doc__)


if __name__ == "__main__":
    sys.exit(main())
