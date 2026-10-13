#!/usr/bin/env python3
"""FS131-IN1 — read a print of data/fs131/in1/lean/AxiomsCore.lean and check every record.

A record is `AXIOMS <public|private> <name> : [a, b, …]`, followed where `sorryAx` is among the axioms by
`SORRY-FROM <name> : [leaf, …]`.  Checked:
  * every axiom is one of the standard three, the declared outside theorem `HadwigerNelson.StandingFive.kloosterman_bound`,
    or `sorryAx`;
  * the records resting on `kloosterman_bound` are EXACTLY the names in IMPORTED below (the plan's list, § Stage 7 of
    plans/FS131-KN5-three-four-colours-passes.md, with this job's one private helper on that path);
  * a record with `sorryAx` names its sources, and every source is a leaf OUTSIDE this module (an upstream leaf still
    `sorry` in this tree) — a source inside `HadwigerNelson.ThreeColourCriterion` is a `sorry` of this job's: FAIL;
  * with --no-sorry: no record holds `sorryAx` at all (the check for a tree whose upstream is proved).
`--control` appends four records — an undeclared axiom; `kloosterman_bound` under a name not in IMPORTED; a `sorry` whose
source is inside this module; a `sorryAx` with no SORRY-FROM line — and must report exactly four; exit 0 only then.
Usage: read_axioms.py <print.txt> [--no-sorry] [--control]
"""
import re, sys, pathlib
STD = {"propext", "Classical.choice", "Quot.sound"}
KLO = "HadwigerNelson.StandingFive.kloosterman_bound"
NS = "HadwigerNelson.ThreeColourCriterion."
IMPORTED = {NS + n for n in (
    "targetFloor_four_weil", "exists_normOne_zero_of_card_ne_nine", "exists_maximal_card_nine",
    "exists_maximal_of_torsion", "exists_maximal_card_nine_of_colorable_three",
    "exists_maximal_card_nine_of_quotient",   # private: the `𝔽₃` end of `exists_maximal_of_torsion`
)}
control = "--control" in sys.argv
text = pathlib.Path([a for a in sys.argv[1:] if not a.startswith("--")][0]).read_text()
if control:
    text += (f"AXIOMS public {NS}planted_one : [Classical.choice, Some.undeclared_axiom]\n"
             f"AXIOMS public {NS}planted_two : [{KLO}, propext]\n"
             f"AXIOMS public {NS}planted_three : [propext, sorryAx]\nSORRY-FROM {NS}planted_three : [{NS}some_leaf_of_this_module]\n"
             f"AXIOMS public {NS}planted_four : [propext, sorryAx]\n")
lst = lambda s: [a.strip() for a in s.split(",") if a.strip()]
recs = {m.group(2): (m.group(1), lst(m.group(3))) for m in re.finditer(r"^AXIOMS (public|private) (\S+) : \[(.*)\]$", text, flags=re.M)}
srcs = {m.group(1): lst(m.group(2)) for m in re.finditer(r"^SORRY-FROM (\S+) : \[(.*)\]$", text, flags=re.M)}
m = re.search(r"^AXIOMS-COUNT (\d+)$", text, flags=re.M)
if not recs or not m:
    print("NO RECORDS: the print is empty or the footer did not run"); sys.exit(2)
errors = len(re.findall(r": error", text))
bad = []
for name, (_, axs) in recs.items():
    extra = set(axs) - STD - {KLO, "sorryAx"}
    if extra:
        bad.append(f"UNDECLARED AXIOM  {name}: {sorted(extra)}")
    if (KLO in axs) != (name in IMPORTED):
        bad.append(f"IMPORT MISFILED   {name}: rests on Weil's bound = {KLO in axs}, listed as IMPORTED = {name in IMPORTED}")
    if "sorryAx" in axs:
        s = srcs.get(name)
        if "--no-sorry" in sys.argv:
            bad.append(f"SORRY             {name}: from {s}")
        elif not s:
            bad.append(f"SORRY UNSOURCED   {name}: `sorryAx` with no source named")
        elif any(x.startswith(NS) for x in s):
            bad.append(f"SORRY OF THIS JOB {name}: from {[x for x in s if x.startswith(NS)]}")
n_decl = int(m.group(1)) + (4 if control else 0)
if n_decl != len(recs):
    bad.append(f"COUNT             {len(recs)} records read, the footer counted {m.group(1)}")
pub = [n for n, (k, _) in recs.items() if k == "public"]
with_sorry = sorted(n for n, (_, a) in recs.items() if "sorryAx" in a)
imported = sorted(n for n, (_, a) in recs.items() if KLO in a)
print(f"records: {len(recs)} ({len(pub)} public, {len(recs) - len(pub)} private); error lines in the print: {errors}")
print(f"on the standard three alone: {sum(1 for _, a in recs.values() if set(a) <= STD)}")
print(f"resting on the declared outside theorem {KLO}: {len(imported)}")
for n in imported: print(f"  IMPORTED {n}{'  (also sorryAx, from upstream)' if n in with_sorry else ''}")
print(f"holding `sorryAx`: {len(with_sorry)}")
for n in with_sorry: print(f"  SORRY {n} — from {srcs.get(n)}")
for b in bad: print(b)
if control:
    ok = len(bad) == 4
    print(f"CONTROL: {len(bad)} of 4 planted records reported — {'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
    sys.exit(0 if ok else 1)
ok = not bad and errors == 0
print("PASS: every record is filed as planned, and no `sorry` is this module's" if ok else f"FAIL: {len(bad)} finding(s), {errors} error line(s)")
sys.exit(0 if ok else 1)
