#!/usr/bin/env python3
"""FS131-I8D — the stage's axioms print, with the debt beneath each record named (the form of the join job's
tools/fs131_i8b_axioms.py, another job's, not edited — and one question more than it asks).

This job's leaves cite statements of `Plane/RingCalculus/SemiHub`, which another implementer proves in a tree of its
own; until the wave's join those statements are `sorry`, so `#print axioms` of a leaf proved here shows `sorryAx`
and cannot say whose. So for each record of this job's block of `scripts/Axioms.lean` (from the line holding
"## FS131-I8D" to "-- FS131-I8D block end") this tool reads, from the compiled modules (what the last build wrote,
never a source):

  * its axioms (`Lean.collectAxioms`), and
  * its *sorry roots*: the declarations beneath it whose own type or proof term mentions `sorryAx`, each with the
    module that declares it.

A record passes when its axioms are a subset of `propext`, `Classical.choice`, `Quot.sound`, `sorryAx`, and every
sorry root is declared in `Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub` (the sibling's module); `sorryAx` and
the roots must agree (one is non-empty exactly when the other is). A root in any other module — this job's above all —
fails the record.

The control: a theorem proved by `sorry` in the scratch file. Its record must print `sorryAx` with itself as its one
root, in no module; otherwise the instrument failed (exit 2), as it does on any elaboration error or a record count
that does not match. `--fault` adds the control to the audited records, so the check itself must exit 1 naming it.

Exit 0: every record passes. Exit 1: a record fails (named). Exit 2: the instrument could not run.

Usage, from the worktree root, after a build: tools/fs131_i8d_axioms.py [--fault] [--out FILE]
"""
import argparse
import os
import re
import subprocess
import sys
import tempfile

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
SIBLING = "Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub"
IMPORTS = ["Proofs"]
CONTROL = "FS131I8DControl.planted_sorry"

PRINTER = r'''
open Lean Elab Command in
partial def FS131I8D.roots (env : Environment) (n : Name) : StateM (Std.HashMap Name NameSet) NameSet := do
  if let some r := (← get)[n]? then return r
  modify fun m => m.insert n {}
  let some ci := env.find? n | return {}
  let cs := ci.type.getUsedConstants ++ (match ci.value? (allowOpaque := true) with
    | some v => v.getUsedConstants | none => #[])
  let mut r : NameSet := {}
  if cs.contains ``sorryAx then r := r.insert n
  for c in cs do
    for x in (← FS131I8D.roots env c).toList do r := r.insert x
  modify fun m => m.insert n r
  return r

open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let mut memo : Std.HashMap Name NameSet := {}
  let mut cnt : Nat := 0
  for n in FS131I8D.names do
    unless env.contains n do
      IO.println s!"FS131I8DMISSING\t{n}"
      continue
    let axs ← Lean.collectAxioms n
    let (r, memo') := (FS131I8D.roots env n).run memo
    memo := memo'
    let rs := r.toList.map fun x =>
      let m := match env.getModuleIdxFor? x with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      s!"{x}@{m}"
    IO.println s!"FS131I8DAX\t{n}\t{",".intercalate (axs.toList.map toString)}\t{",".intercalate rs}"
    cnt := cnt + 1
  IO.println s!"FS131I8DCOUNT\t{cnt}"
'''


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fault", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    src = open("scripts/Axioms.lean", encoding="utf-8").read()
    m = re.search(r"## FS131-I8D.*?-- FS131-I8D block end", src, re.S)
    if not m:
        sys.stderr.write("INSTRUMENT FAILURE: the FS131-I8D block is not in scripts/Axioms.lean\n")
        sys.exit(2)
    names = re.findall(r"^#print axioms (\S+)$", m.group(0), re.M)
    if not names:
        sys.stderr.write("INSTRUMENT FAILURE: the block has no `#print axioms` line\n")
        sys.exit(2)
    audited = names + ([CONTROL] if a.fault else [])
    asked = audited + [CONTROL]
    body = "\n".join(f"import {i}" for i in IMPORTS) + "\n"
    body += f"theorem {CONTROL} : (1 : Nat) = 2 := sorry\n"
    body += "def FS131I8D.names : List Lean.Name := [" + ", ".join("`" + n for n in asked) + "]\n"
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
    errors = [l for l in out.splitlines() if ": error" in l or l.startswith("FS131I8DMISSING")]
    if errors:
        sys.stderr.write("INSTRUMENT FAILURE: elaboration errors or missing names:\n" + "\n".join(errors[:8]) + "\n")
        sys.exit(2)
    recs, count = [], None
    for line in out.splitlines():
        if line.startswith("FS131I8DAX\t"):
            _, n, axs, roots = line.split("\t")
            recs.append((n, set(x for x in axs.split(",") if x), [x for x in roots.split(",") if x]))
        elif line.startswith("FS131I8DCOUNT\t"):
            count = int(line.split("\t")[1])
    if count != len(asked) or len(recs) != len(asked):
        sys.stderr.write(f"INSTRUMENT FAILURE: {len(recs)} records printed (count line {count}) for {len(asked)} asked\n{out[-2000:]}\n")
        sys.exit(2)
    cname, caxs, croots = recs[-1]
    if cname != CONTROL or "sorryAx" not in caxs or croots != [f"{CONTROL}@(this file)"]:
        sys.stderr.write(f"INSTRUMENT FAILURE: the planted control did not print sorryAx with itself as its root: {cname} {sorted(caxs)} {croots}\n")
        sys.exit(2)
    bad, clean, resting = [], 0, 0
    debt = set()
    for n, axs, roots in recs[:-1]:
        why = []
        if not axs <= STANDARD | {"sorryAx"}:
            why.append("axioms outside the three: " + ", ".join(sorted(axs - STANDARD - {"sorryAx"})))
        if ("sorryAx" in axs) != bool(roots):
            why.append(f"sorryAx {'present' if 'sorryAx' in axs else 'absent'} but roots = {roots}")
        foreign = [x for x in roots if x.split("@")[1] != SIBLING]
        if foreign:
            why.append("a sorry beneath it outside the sibling's module: " + ", ".join(foreign))
        if why:
            bad.append((n, why))
        elif roots:
            resting += 1
            debt |= {x.split("@")[0] for x in roots}
            print(f"RESTS  {n}: the standard three and, until the join, {len(roots)} open leaf/leaves of SemiHub: "
                  + ", ".join(sorted(x.split('@')[0].replace('HadwigerNelson.Plane.ArcMap.', '') for x in roots)))
        else:
            clean += 1
            print(f"CLEAN  {n}: {sorted(axs)}")
    print(f"axioms print: {len(recs) - 1} records — {clean} on a subset of the standard three, {resting} resting besides on open "
          f"leaves of {SIBLING.split('.')[-1]} only ({len(debt)} distinct), {len(bad)} bad; control `{CONTROL}` prints "
          f"{sorted(caxs)} with root {croots}")
    for n, why in bad:
        print(f"BAD {n}: " + "; ".join(why))
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
