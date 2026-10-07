#!/usr/bin/env python3
"""FS131-L8A — the receipt that wave 8 is whole after the join: every record of the line's seven blocks of
`scripts/Axioms.lean`, and every theorem of the line's twelve modules, on a subset of the standard three with no
`sorry` anywhere beneath it (after the sibling implementer's tools/fs131_i8d_axioms.py, another job's, not edited).

Until the join, fourteen records of the block "FS131-I8D" printed `sorryAx`, by leaves proved on the other branch
under the same statements. This tool asks, of the compiled modules (what the last build wrote, never a source):

  * for each `#print axioms` name of the blocks "FS131-K7" (wave 7's foundation `Plane/SimpleOn`, which this line
    carries), "FS131-K8", "-I8A", "-K8b", "-I8B", "-I8C", "-I8D" (each from the line
    holding "## <job> —" to "-- <job> block end"): its axioms (`Lean.collectAxioms`) and its *sorry roots* — the
    declarations beneath it whose own type or proof term mentions `sorryAx`, each with its module;
  * for each module of `Plane/RingCalculus/` (eleven) and `Plane/SimpleOn`: every theorem the kernel holds in it, hand-written or not —
    the same two readings — so that a theorem no block names cannot hide a `sorry` (UNREGISTERED is printed and
    counted, never failed here: registration is the gate's records check).

A record passes when its axioms are a subset of `propext`, `Classical.choice`, `Quot.sound` and it has no sorry root.
`sorryAx` and the roots must agree (one is non-empty exactly when the other is): a disagreement is an instrument
failure, not a pass.

The control: a theorem proved by `sorry` in the scratch file. Its record must print `sorryAx` with itself as its one
root; otherwise the instrument failed (exit 2), as it does on any elaboration error, a name the environment lacks, or a
record count that does not match. `--fault` adds the control to the audited records, so the check itself must exit 1
naming it.

Exit 0: every record and every theorem of the twelve modules passes. Exit 1: one fails (named). Exit 2: the
instrument could not run.

Usage, from the worktree root, after a build: tools/fs131_l8a_axioms.py [--fault] [--out FILE]
"""
import argparse
import os
import re
import subprocess
import sys
import tempfile

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
JOBS = ["FS131-K7", "FS131-K8", "FS131-I8A", "FS131-K8b", "FS131-I8B", "FS131-I8C", "FS131-I8D"]
# the eleven modules of the ring calculus, and wave 7's foundation `Plane/SimpleOn`, which this line carries and lands
MODS = ["RingCalculus." + m for m in
        ["Basic", "Star", "Empty", "HubCount", "TilesAt", "SoleTip", "RingColour", "StarChart", "SemiHub",
         "SemiHubPlaces", "OuterAdj"]] + ["SimpleOn"]
PREFIX = "Proofs.HadwigerNelson.Plane."
CONTROL = "FS131L8AControl.planted_sorry"

PRINTER = r'''
open Lean Elab Command in
partial def FS131L8A.roots (env : Environment) (n : Name) : StateM (Std.HashMap Name NameSet) NameSet := do
  if let some r := (← get)[n]? then return r
  modify fun m => m.insert n {}
  let some ci := env.find? n | return {}
  let cs := ci.type.getUsedConstants ++ (match ci.value? (allowOpaque := true) with
    | some v => v.getUsedConstants | none => #[])
  let mut r : NameSet := {}
  if cs.contains ``sorryAx then r := r.insert n
  for c in cs do
    for x in (← FS131L8A.roots env c).toList do r := r.insert x
  modify fun m => m.insert n r
  return r

open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let mut memo : Std.HashMap Name NameSet := {}
  let mut cnt : Nat := 0
  -- the theorems of the wave's modules, from the kernel's own list
  let mut modThms : Array (Name × Name) := #[]
  let mut idxs : Std.HashMap Nat Name := {}
  for m in FS131L8A.mods do
    match env.getModuleIdx? m with
    | some idx => idxs := idxs.insert idx.toNat m
    | none => IO.println s!"FS131L8AMISSINGMOD\t{m}"
  for (n, ci) in env.constants.map₁.toList do
    if let .thmInfo _ := ci then
      if let some idx := env.getModuleIdxFor? n then
        if let some m := idxs[idx.toNat]? then modThms := modThms.push (m, n)
  let asked : List (String × Name) :=
    (FS131L8A.names.map fun n => ("REC", n)) ++ (modThms.toList.map fun (m, n) => (s!"MOD:{m}", n))
  for (tag, n) in asked do
    unless env.contains n do
      IO.println s!"FS131L8AMISSING\t{n}"
      continue
    let axs ← Lean.collectAxioms n
    let (r, memo') := (FS131L8A.roots env n).run memo
    memo := memo'
    let rs := r.toList.map fun x =>
      let m := match env.getModuleIdxFor? x with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      s!"{x}@{m}"
    IO.println s!"FS131L8AAX\t{tag}\t{n}\t{",".intercalate (axs.toList.map toString)}\t{",".intercalate rs}"
    cnt := cnt + 1
  IO.println s!"FS131L8ACOUNT\t{cnt}\t{modThms.size}"
'''

# the pattern of tools/fs131_l5_records.py (theorems Lean generates), and the kernel's auxiliary names
GENERATED = re.compile(r"\.(eq_\d+|eq_def|congr_simp|brecOn|binductionOn)$|\.mk\.(inj|injEq|sizeOf_spec)$"
                       r"|\.(match|proof)_\d+|\._[A-Za-z]")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fault", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    src = open("scripts/Axioms.lean", encoding="utf-8").read()
    names, per_job = [], {}
    for job in JOBS:
        m = re.search(r"## " + re.escape(job) + r" —.*?-- " + re.escape(job) + r" block end", src, re.S)
        if not m:
            sys.stderr.write(f"INSTRUMENT FAILURE: the {job} block is not in scripts/Axioms.lean\n")
            sys.exit(2)
        ns = re.findall(r"^#print axioms (\S+)$", m.group(0), re.M)
        if not ns:
            sys.stderr.write(f"INSTRUMENT FAILURE: the {job} block has no `#print axioms` line\n")
            sys.exit(2)
        per_job[job] = ns
        names += ns
    if len(set(names)) != len(names):
        dup = sorted({n for n in names if names.count(n) > 1})
        sys.stderr.write("INSTRUMENT FAILURE: a name has two records in the wave's blocks: " + ", ".join(dup) + "\n")
        sys.exit(2)
    job_of = {n: j for j, ns in per_job.items() for n in ns}
    audited = names + ([CONTROL] if a.fault else [])
    asked = audited + [CONTROL]
    body = "import Proofs\n"
    body += f"theorem {CONTROL} : (1 : Nat) = 2 := sorry\n"
    body += "def FS131L8A.names : List Lean.Name := [" + ", ".join("`" + n for n in asked) + "]\n"
    body += "def FS131L8A.mods : List Lean.Name := [" + ", ".join("`" + PREFIX + m for m in MODS) + "]\n"
    body += PRINTER
    with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False, dir=os.environ.get("TMPDIR")) as f:
        f.write(body)
        path = f.name
    try:
        r = subprocess.run(["lake", "env", "lean", path], capture_output=True, text=True)
    finally:
        os.unlink(path)
    out = r.stdout
    if a.out:
        with open(a.out, "w", encoding="utf-8") as f:
            f.write(out)
    errors = [l for l in out.splitlines() if ": error" in l or l.startswith("FS131L8AMISSING")]
    if errors:
        sys.stderr.write("INSTRUMENT FAILURE: elaboration errors or missing names:\n" + "\n".join(errors[:8]) + "\n")
        sys.exit(2)
    recs, mods, count, nmod = [], [], None, None
    for line in out.splitlines():
        if line.startswith("FS131L8AAX\t"):
            _, tag, n, axs, roots = line.split("\t")
            row = (n, set(x for x in axs.split(",") if x), [x for x in roots.split(",") if x])
            (recs if tag == "REC" else mods).append(row + (tag,))
        elif line.startswith("FS131L8ACOUNT\t"):
            _, c, k = line.split("\t")
            count, nmod = int(c), int(k)
    if count != len(recs) + len(mods) or len(recs) != len(asked) or nmod != len(mods) or nmod == 0:
        sys.stderr.write(f"INSTRUMENT FAILURE: {len(recs)} records and {len(mods)} module theorems printed "
                         f"(count line {count}, {nmod}) for {len(asked)} asked\n{out[-2000:]}\n")
        sys.exit(2)
    cname, caxs, croots, _ = recs[-1]
    if cname != CONTROL or "sorryAx" not in caxs or croots != [f"{CONTROL}@(this file)"]:
        sys.stderr.write(f"INSTRUMENT FAILURE: the planted control did not print sorryAx with itself as its root: "
                         f"{cname} {sorted(caxs)} {croots}\n")
        sys.exit(2)

    def judge(n, axs, roots):
        why = []
        if ("sorryAx" in axs) != bool(roots):
            sys.stderr.write(f"INSTRUMENT FAILURE: {n}: sorryAx {'present' if 'sorryAx' in axs else 'absent'} "
                             f"but roots = {roots}\n")
            sys.exit(2)
        if not axs <= STANDARD:
            why.append("axioms outside the three: " + ", ".join(sorted(axs - STANDARD)))
        if roots:
            why.append("a sorry beneath it: " + ", ".join(roots))
        return why

    bad = []
    exact = {j: 0 for j in JOBS}
    sub = {j: 0 for j in JOBS}
    for n, axs, roots, _ in recs[:-1]:
        why = judge(n, axs, roots)
        j = job_of.get(n, "(control)")
        if why:
            bad.append((f"record [{j}] {n}", why))
        elif axs == STANDARD:
            exact[j] += 1
            print(f"CLEAN  [{j}] {n}: exactly the standard three")
        else:
            sub[j] += 1
            print(f"CLEAN  [{j}] {n}: a subset — {sorted(axs)}")
    for j in JOBS:
        print(f"BLOCK  {j}: {len(per_job[j])} records — {exact[j]} on exactly the standard three, {sub[j]} on a proper subset")
    recorded = set(names)
    hand, gen, unreg, per_mod = 0, 0, [], {}
    for n, axs, roots, tag in mods:
        why = judge(n, axs, roots)
        m = tag[4:][len(PREFIX):]
        per_mod.setdefault(m, [0, 0])
        if why:
            bad.append((f"theorem of {m} {n}", why))
        if GENERATED.search(n):
            gen += 1
            per_mod[m][1] += 1
        else:
            hand += 1
            per_mod[m][0] += 1
            if n not in recorded:
                unreg.append(f"{m}: {n}")
    for m in MODS:
        h, g = per_mod.get(m, [0, 0])
        print(f"MODULE {m}: {h} hand-written theorems, {g} generated")
    for u in unreg:
        print("UNREGISTERED (no record in the line's seven blocks; the gate's records check decides) " + u)
    total = len(recs) - 1
    print(f"axioms receipt: {total} records in {len(JOBS)} blocks — {sum(exact.values())} on exactly the standard three, "
          f"{sum(sub.values())} on a proper subset, {sum(1 for b in bad if b[0].startswith('record'))} bad; "
          f"{len(mods)} theorems in {len(MODS)} modules ({hand} hand-written, {gen} generated; {len(unreg)} hand-written "
          f"with no record in the seven blocks), {sum(1 for b in bad if b[0].startswith('theorem'))} bad; control `{CONTROL}` "
          f"prints {sorted(caxs)} with root {croots}")
    for n, why in bad:
        print(f"BAD {n}: " + "; ".join(why))
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
