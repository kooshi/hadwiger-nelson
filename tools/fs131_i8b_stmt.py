#!/usr/bin/env python3
"""FS131-I8B — the statement check, on elaborated signatures (the form of tools/fs131_i8a_stmt.py, the wave's own,
which is another job's and is not edited; here over every module of the ring calculus, a module absent at the base
listed and skipped, and with `--expect NAME…`: the declarations that are expected to have changed — exit 0 only if
the changed set is exactly that set).

For each module of the job (`Plane/RingCalculus/Empty`, `Plane/RingCalculus/Star`) elaborate two sources with one
appended command that prints every declaration of the module as the kernel has it (name, kind, the structural hash of
its type, the hash of its value when it is a definition, and its type pretty-printed with full names):

  * the module as it stood at the base commit (`git show <base>:<path>`), and
  * the module as it stands in the working tree.

Every declaration of the base must be present now with the same kind, the same type hash, the same printed type, and
(a definition) the same value hash. Declarations added since the base are listed, never failed.

Why not a text diff: a section `variable` enters a theorem only if its statement mentions it, and `include … in`
adds a binder while the theorem's text stays byte-identical (`LEAN.md` § Searching — Lean, last bullet). A check that
compares text passes that whole class; this one reads `ConstantInfo.type`.

Exit 0: every base declaration unchanged. Exit 1: a difference (printed). Exit 2: the instrument could not run
(a source failed to elaborate, or printed no signature) — never read as a pass.

Controls (`--fault NAME`, each must exit 1 and name its culprit; run by `--self-test`):
  text     a hypothesis of `v6_count` altered in the source text
  include  `include hbad in` placed above `ringPt_sixth_dist_le_one`: the text of the statement is unchanged and the
           kernel's statement gains the hypothesis `0 = 1`
  def      nothing in these two modules is a definition, so the definition control alters `v6_anti`'s conclusion
           instead (`⊆ {p}` to `⊆ {p, p}`): same kind of fault as `text`, at a proved theorem

Usage, from the worktree root:
  tools/fs131_i8b_stmt.py [--base 8d979793] [--expect NAME ...] [--fault NAME] [--self-test] [--out FILE]
"""
import argparse
import os
import subprocess
import sys
import tempfile

MODULES = [
    "Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/Basic.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/HubCount.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/TilesAt.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/SoleTip.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/RingColour.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean",
    "Proofs/HadwigerNelson/Plane/RingCalculus/SemiHubPlaces.lean",
]

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
    IO.println s!"FS131I8BSIG\t{name}\t{kind}\t{ci.type.hash}\t{vh}\t{s}"
    n := n + 1
  IO.println s!"FS131I8BCOUNT\t{n}"
'''

FAULTS = {
    "text": (MODULES[0],
             "(hhug : ∀ i a, tip i a → tip i (a + 1) →",
             "(hhug : ∀ i a, tip i a → tip i (a + 2) →"),
    "include": (MODULES[0],
                "theorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}",
                "variable (hbad : 0 = 1)\ninclude hbad in\ntheorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}"),
    "binder": (MODULES[1],
               "(hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4)\n    (hna : ¬ F.OnRingArc (ringPt p ψ) p)",
               "(hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) (hextra : 0 < ψ)\n    (hna : ¬ F.OnRingArc (ringPt p ψ) p)"),
}


def elaborate(src: str, label: str):
    """Elaborate `src` + PRINTER; return {name: (kind, typehash, valhash, pp)} or raise."""
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
        if line.startswith("FS131I8BSIG\t"):
            _, name, kind, th, vh, pp = line.split("\t", 5)
            sigs[name] = (kind, th, vh, pp)
        elif line.startswith("FS131I8BCOUNT\t"):
            count = int(line.split("\t")[1])
    errors = [l for l in r.stdout.splitlines() if ": error" in l]
    if count is None or count != len(sigs) or count == 0:
        sys.stderr.write(f"INSTRUMENT FAILURE ({label}): the printer did not report (count={count}, parsed={len(sigs)})\n")
        sys.stderr.write(r.stdout[-3000:] + r.stderr[-3000:])
        sys.exit(2)
    return sigs, errors


def run(base: str, fault, out, expect=()):
    diffs, added, total = [], [], 0
    skipped, changed = [], set()
    lines = []
    for mod in MODULES:
        b = subprocess.run(["git", "show", f"{base}:{mod}"], capture_output=True, text=True)
        if b.returncode != 0:
            if "exists on disk, but not in" in b.stderr or "does not exist in" in b.stderr:
                print(f"ABSENT AT BASE (skipped; every declaration of it is an addition): {mod}")
                skipped.append(mod)
                continue
            sys.stderr.write(f"INSTRUMENT FAILURE: git show {base}:{mod} failed\n{b.stderr}")
            sys.exit(2)
        work = open(mod, encoding="utf-8").read()
        if fault is not None and FAULTS[fault][0] == mod:
            _, old, new = FAULTS[fault]
            if work.count(old) != 1:
                sys.stderr.write(f"INSTRUMENT FAILURE: fault '{fault}' anchor found {work.count(old)} times in {mod}\n")
                sys.exit(2)
            work = work.replace(old, new)
        bs, berr = elaborate(b.stdout, f"base {mod}")
        ws, werr = elaborate(work, f"working {mod}")
        if berr:
            sys.stderr.write(f"INSTRUMENT FAILURE: the base source of {mod} has elaboration errors:\n" + "\n".join(berr[:5]) + "\n")
            sys.exit(2)
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
            print("EXPECTED: the changed declarations are exactly " + ", ".join(sorted(exp)))
            return 0
        print("UNEXPECTED: changed " + (", ".join(sorted(changed)) or "(none)") + "; expected exactly " + ", ".join(sorted(exp)))
        return 1
    return 1 if diffs else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default="8d979793")
    ap.add_argument("--expect", nargs="*", default=[])
    ap.add_argument("--fault", choices=sorted(FAULTS))
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    if a.self_test:
        bad = 0
        for name in sorted(FAULTS):
            rc = run(a.base, name, None)
            ok = rc == 1
            print(f"control '{name}': exit {rc} — {'FIRED' if ok else 'DID NOT FIRE'}")
            bad += 0 if ok else 1
        print("self-test: " + ("OK — every planted fault fired" if bad == 0 else f"FAILED — {bad} control(s) silent"))
        sys.exit(0 if bad == 0 else 1)
    sys.exit(run(a.base, a.fault, a.out, a.expect))


if __name__ == "__main__":
    main()
