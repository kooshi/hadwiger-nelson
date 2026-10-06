#!/usr/bin/env python3
"""FS131-I8D — the statement check, on elaborated signatures (the form of the wave's tools/fs131_i8a_stmt.py and the
join job's tools/fs131_i8b_stmt.py, which are other jobs' and are not edited; here over the ten modules of the ring
calculus, with a self-test that discriminates: a control fires only if the planted declaration is NEW in the changed
set).

For each module elaborate two sources with one appended command that prints every declaration of the module as the
kernel has it (name, kind, the structural hash of its type, the hash of its value when it is a definition, and its
type pretty-printed with full names):

  * the module as it stood at the base commit (`git show <base>:<path>`), and
  * the module as it stands in the working tree.

Every declaration of the base must be present now with the same kind, the same type hash, the same printed type, and
(a definition) the same value hash. Declarations added since the base are listed, never failed.

Why not a text diff: a section `variable` enters a theorem only if its statement mentions it, and `include … in`
adds a binder while the theorem's text stays byte-identical. A check that compares text passes that whole class;
this one reads `ConstantInfo.type`.

`--expect NAME…`: the declarations expected to have changed (a ruled statement change). Exit 0 only if the changed
set is exactly that set.

Exit 0: every base declaration unchanged (or the changed set is exactly the expected one). Exit 1: a difference
(printed). Exit 2: the instrument could not run (a source failed to elaborate, or printed no signature) — never read
as a pass.

Controls (`--fault NAME`; run by `--self-test`, which first runs with no fault to learn the changed set, then
requires each control's changed set to be that set plus exactly the planted declaration):
  text     a hypothesis of `v6_count` altered in the source text (`Empty`)
  include  `include hbad in` placed above `ringPt_sixth_dist_le_one` (`Empty`): the text of the statement is
           unchanged and the kernel's statement gains the hypothesis `0 = 1`
  binder   a binder added to `star_recip` (`Star`)

Usage, from the worktree root:
  tools/fs131_i8d_stmt.py [--base 6e0cf10d] [--expect NAME ...] [--fault NAME] [--self-test] [--out FILE]
"""
import argparse
import os
import subprocess
import sys
import tempfile

D = "Proofs/HadwigerNelson/Plane/RingCalculus/"
MODULES = [D + m + ".lean" for m in
           ["Empty", "Star", "Basic", "HubCount", "TilesAt", "SoleTip", "RingColour", "SemiHub", "SemiHubPlaces",
            "StarChart"]]
NS = "HadwigerNelson.Plane."

PRINTER = r'''

open Lean Elab Command Meta in
run_cmd do
  let env ← getEnv
  let mut n : Nat := 0
  for (name, ci) in env.constants.map₂.toList do
    if name.isInternalDetail || name.hasMacroScopes then continue
    let kind := match ci with
      | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom" | .opaqueInfo _ => "opaque"
      | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec" | .quotInfo _ => "quot"
    let vh := match ci with | .defnInfo d => toString d.value.hash | _ => "-"
    let fmt ← liftTermElabM (withOptions (fun o => (o.setBool `pp.fullNames true).setBool `pp.deepTerms true) (ppExpr ci.type))
    let s := (fmt.pretty 100000).replace "\n" " "
    IO.println s!"FS131I8DSIG\t{name}\t{kind}\t{ci.type.hash}\t{vh}\t{s}"
    n := n + 1
  IO.println s!"FS131I8DCOUNT\t{n}"
'''

# name: (module, old text, new text, the declaration the fault must make appear in the changed set)
FAULTS = {
    "text": (MODULES[0],
             "(hhug : ∀ i a, tip i a → tip i (a + 1) →",
             "(hhug : ∀ i a, tip i a → tip i (a + 2) →",
             NS + "ArcMap.v6_count"),
    "include": (MODULES[0],
                "theorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}",
                "variable (hbad : 0 = 1)\ninclude hbad in\ntheorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}",
                NS + "ArcMap.ringPt_sixth_dist_le_one"),
    "binder": (MODULES[1],
               "(hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4)\n    (hna : ¬ F.OnRingArc (ringPt p ψ) p)",
               "(hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) (hextra : 0 < ψ)\n    (hna : ¬ F.OnRingArc (ringPt p ψ) p)",
               NS + "ArcMap.star_recip"),
}


def elaborate(src: str, label: str):
    """Elaborate `src` + PRINTER; return ({name: (kind, typehash, valhash, pp)}, [error lines]) or exit 2."""
    with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False, dir=os.environ.get("TMPDIR", None)) as f:
        f.write(src + PRINTER)
        path = f.name
    try:
        r = subprocess.run(["lake", "env", "lean", "-DautoImplicit=false", "-DrelaxedAutoImplicit=false", path],
                           capture_output=True, text=True)
    finally:
        os.unlink(path)
    sigs, count = {}, None
    for line in r.stdout.splitlines():
        if line.startswith("FS131I8DSIG\t"):
            _, name, kind, th, vh, pp = line.split("\t", 5)
            sigs[name] = (kind, th, vh, pp)
        elif line.startswith("FS131I8DCOUNT\t"):
            count = int(line.split("\t")[1])
    errors = [l for l in r.stdout.splitlines() if ": error" in l]
    if count is None or count != len(sigs) or count == 0:
        sys.stderr.write(f"INSTRUMENT FAILURE ({label}): the printer did not report (count={count}, parsed={len(sigs)})\n")
        sys.stderr.write(r.stdout[-3000:] + r.stderr[-3000:])
        sys.exit(2)
    return sigs, errors


_base_cache = {}


def base_sigs(base, mod):
    key = (base, mod)
    if key not in _base_cache:
        b = subprocess.run(["git", "show", f"{base}:{mod}"], capture_output=True, text=True)
        if b.returncode != 0:
            if "exists on disk, but not in" in b.stderr or "does not exist in" in b.stderr:
                _base_cache[key] = None
            else:
                sys.stderr.write(f"INSTRUMENT FAILURE: git show {base}:{mod} failed\n{b.stderr}")
                sys.exit(2)
        else:
            bs, berr = elaborate(b.stdout, f"base {mod}")
            if berr:
                sys.stderr.write(f"INSTRUMENT FAILURE: the base source of {mod} has elaboration errors:\n" + "\n".join(berr[:5]) + "\n")
                sys.exit(2)
            _base_cache[key] = bs
    return _base_cache[key]


def run(base: str, fault, out, expect=(), quiet=False):
    """Return (exit code, changed set)."""
    diffs, added, total = [], [], 0
    skipped, changed = [], set()
    lines = []
    for mod in MODULES:
        bs = base_sigs(base, mod)
        if bs is None:
            if not quiet:
                print(f"ABSENT AT BASE (skipped; every declaration of it is an addition): {mod}")
            skipped.append(mod)
            continue
        work = open(mod, encoding="utf-8").read()
        if fault is not None and FAULTS[fault][0] == mod:
            _, old, new, _ = FAULTS[fault]
            if work.count(old) != 1:
                sys.stderr.write(f"INSTRUMENT FAILURE: fault '{fault}' anchor found {work.count(old)} times in {mod}\n")
                sys.exit(2)
            work = work.replace(old, new)
        ws, werr = elaborate(work, f"working {mod}")
        if werr and fault is None:
            sys.stderr.write(f"INSTRUMENT FAILURE: the working source of {mod} has elaboration errors:\n" + "\n".join(werr[:5]) + "\n")
            sys.exit(2)
        for name, (kind, th, vh, pp) in sorted(bs.items()):
            total += 1
            if name not in ws:
                diffs.append(f"{mod}: {name}: MISSING now")
                changed.add(name)
                continue
            k2, th2, vh2, pp2 = ws[name]
            if (kind, th, vh, pp) != (k2, th2, vh2, pp2):
                what = [w for w, a, c in (("kind", kind, k2), ("type hash", th, th2), ("value hash", vh, vh2), ("printed type", pp, pp2)) if a != c]
                diffs.append(f"{mod}: {name}: CHANGED ({', '.join(what)})\n    base: {pp}\n    now:  {pp2}")
                changed.add(name)
            lines.append(f"{name}\t{kind}\t{th}\t{vh}\t{pp}")
        for name in sorted(ws):
            if name not in bs:
                added.append(f"{mod}: {name}")
    if out:
        with open(out, "w", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")
    if total == 0:
        sys.stderr.write("INSTRUMENT FAILURE: no base declaration was compared\n")
        sys.exit(2)
    if not quiet:
        print(f"statement check against {base}: {total} base declarations compared in {len(MODULES) - len(skipped)} modules; "
              f"{len(diffs)} changed or missing; {len(added)} added since the base")
        for d in diffs:
            print("DIFF " + d)
        if fault is None:
            for a in added:
                print("ADDED " + a)
    if expect:
        exp = set(expect)
        if changed == exp:
            if not quiet:
                print("EXPECTED: the changed declarations are exactly " + ", ".join(sorted(exp)))
            return 0, changed
        if not quiet:
            print("UNEXPECTED: changed " + (", ".join(sorted(changed)) or "(none)") + "; expected exactly " + ", ".join(sorted(exp)))
        return 1, changed
    return (1 if diffs else 0), changed


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default="6e0cf10d")
    ap.add_argument("--expect", nargs="*", default=[])
    ap.add_argument("--fault", choices=sorted(FAULTS))
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    if a.self_test:
        _, clean = run(a.base, None, None, quiet=True)
        print("with no fault the changed set is: " + (", ".join(sorted(clean)) or "(empty)"))
        bad = 0
        for name in sorted(FAULTS):
            culprit = FAULTS[name][3]
            if culprit in clean:
                print(f"control '{name}': UNREACHABLE — its culprit {culprit} is already in the changed set")
                bad += 1
                continue
            _, ch = run(a.base, name, None, quiet=True)
            ok = ch == clean | {culprit}
            print(f"control '{name}': changed set gains {sorted(ch - clean)} — {'FIRED' if ok else 'DID NOT FIRE as planted'}")
            bad += 0 if ok else 1
        print("self-test: " + ("OK — every planted fault fired, each adding exactly its culprit" if bad == 0 else f"FAILED — {bad} control(s)"))
        sys.exit(0 if bad == 0 else 1)
    rc, _ = run(a.base, a.fault, a.out, a.expect)
    sys.exit(rc)


if __name__ == "__main__":
    main()
