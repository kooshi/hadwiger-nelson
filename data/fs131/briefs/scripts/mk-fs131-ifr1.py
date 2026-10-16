exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IFR1: de Bruijn's implementer proves the density form of the collapse (ledger row 129's field clause) from
# FS131-KFR1's skeleton and plan, with item 1021's three rulings.
# Usage: mk-fs131-ifr1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IFR1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KFR1-density-plan.md"
H="Proofs/HadwigerNelson/Collapse/Density/Headline.lean"
for p in (PLAN,"data/fs131/reports/FS131-KFR1.md",H,"Proofs/HadwigerNelson/Collapse/Density/Defs.lean",
          "Proofs/HadwigerNelson/Collapse/Density/Upper.lean","Proofs/HadwigerNelson/Plane/TriangularPacking.lean",
          "Proofs/HadwigerNelson/Collapse/Headline.lean","Proofs/HadwigerNelson/Rigidity/ClassRatio.lean",
          "data/fs131/clone1/run-gate.sh","data/fs131/ico2/gate/run-pass.out","data/fs131/ico2/statements.py",
          "data/fs131/kfr1/d7_crt.py","LEAN.md"): assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    t="".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
    assert must in t,(path,first,must); return t
T1=wl(H,49,50,"theorem finIndepRatio_planeOver_eq_localRatio [NumberField F] :")
T2=wl(H,54,55,"theorem finIndepRatio_planeOver_eq_iSup_density [NumberField F] :")
T3=wl(H,70,71,"theorem fractionalChromaticNumber_planeOver_eq [NumberField F] :")
T4=wl(H,95,97,"theorem fractionalChromaticNumber_planeOver_eq_plane_of_thick [NumberField F]")
T5=wl(H,126,128,"theorem IndepLaw.density_le_notThick [NumberField F]")
T6=wl(H,172,174,"theorem exists_finite_triangleFree_six_chromatic :")
LOC=wl("Proofs/HadwigerNelson/Collapse/Density/Defs.lean",47,47,"def localRatio : ℝ≥0∞ := max mOne (⨆ P : StablePrime F, stableRatio P)")
R129=Q("LEDGER.md","| 129 |")
TJ=Q("plans/FS103-derivation.md","**FS103-F-TJ")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1008=item(1008); I1017=item(1017); I1021=item(1021); I1022=item(1022)
b=f'''# Brief {JOB} — prove the density form of the collapse: the independence ratio of the plane over every real number field, from the skeleton and its plan

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of four modules a planner typed and planned — ledger row 129's field clause in the kernel, at every real number field and with no hypothesis of ours — every `sorry` replaced by a proof without changing a statement (but for the three ruled changes below), then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you two implementers taking other modules to the gate in their own worktrees (the `p`-adic plane, the three-colour criterion); none writes another's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-density.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's skeleton with `main` merged in, no Lean from `main` since the planner's build; `.lake/build` current for the skeleton): the four new modules `Proofs/HadwigerNelson/Collapse/Density/{{Defs, Upper, Headline}}.lean` and `Proofs/HadwigerNelson/Plane/TriangularPacking.lean` (their proofs; their statements only as ruled below); in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` the one word `private` before `ratioAtMost_of_charBound` (l. 92) and a docstring for it, nothing else; in `Proofs/HadwigerNelson/Collapse/Headline.lean` the two splits and the model at `k = 7`, added and nothing changed; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/{JOB}-density.md`; your scripts and logs under `data/fs131/ifr1/`; `data/fs131/reports/{JOB}.md`. Front-file edits (`LEDGER.md` row 129, `CLAUDE.md`, `ROADMAP.md`, `README.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules found that every use of measure rigidity in the four derivation entries
behind row 129 is discharged by a theorem the library already proves (`Rigidity.mrPlus`), so the row's field clause can
be a kernel theorem at every real number field, with no hypothesis of ours and wider than the row. The skeleton builds
green, with 81 `sorry` leaves over four modules and a plan for each; you prove them.

## Why this job

{W2}
Row 129 is that kind of finding: this project's derivation, [hand], given measure rigidity. Its plane clause is already
in the kernel (FS-133: the plane's finitary independence ratio is `m₁(ℝ²)`); its field clause — the independence ratio
of the plane over a number field is the larger of the plane's and the best ratio at one of the field's primes — is what
this module adds, with the fractional chromatic number of every such plane beside it, and the fractional collapse at
the two fields where the colouring collapse already holds.

## The statements

The row, as the ledger states it now:

{R129}
The skeleton's head statements, on your branch (the plan names every other):

{T1}
{T2}
{T3}
{T4}
{T5}
{T6}
The right side of the first:

{LOC}
TJ's derivation entry, whose second clause my ruling (1) below adds:

{TJ}
The plan is `{PLAN}` on your branch: § 3.1 lists the skeleton; § 3.2 reads the head statements aloud against row 129;
§ 3.3 is the plan per leaf; § 3.4 the price (about 2,650 lines, D2 `Collapse/Density/Upper` the long pole at 1,370, two
thirds of it copy-and-adapt of `Collapse/Dichotomy` and `Collapse/Slice`) and the order — D1 and D4 first (no measure
rigidity, no spectral theory), then D2's count and Følner leaves, then D2's dichotomy and extension, then D3; § 3.5 its
choices; §§ 3.6–3.7 its modeling passes, with one spec example owed to you (`localRatio ⊥ = 2⁻¹`, the one field where the
right side is not `m₁`). Its report is `data/fs131/reports/FS131-KFR1.md`.

## My rulings

The planner's mid-job findings, which I adopted:

{I1008}
Its hand-back:

{I1017}
My review and the three rulings on what it held for me:

{I1021}
So, in short: (1) state and prove TJ's second clause (about 110 lines; if it needs far more, stop at it and message
me); (2) make `ratioAtMost_of_charBound` public in `Rigidity/ClassRatio` with a docstring, and call it by name — its
dependents recompile, so do this edit in the first build, not the last; (3) put the two splits and the model at `k = 7`
in `Collapse/Headline` beside `chromaticNumber_planeOver_sqrt635087_six_or_seven`, unless that needs an import it lacks.
Each of the three is a ruled change in the statement comparison.

The wording rule of the day:

{I1022}
In your files and messages the pause is "a pause Kooshi called", nothing more.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the three rulings and
   the order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind (a copy leaf, a new leaf) and
   writing the re-price into your record; every module built through `./scripts/build.sh` under the slot; a saved stage
   after each module. The owed spec example `localRatio ⊥ = 2⁻¹` in D1.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/ifr1/`, its logs there),
   every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on `7c72b9bf7`,
   unless I tell you another landed first); the statement comparison against a dump of the skeleton's stored statements
   that you take before your first proof edit (a comparator shaped like `data/fs131/ico2/statements.py`, with a planted
   control watched), the ruled changes listed; the vacuity scan's new sites with each structure hypothesis's inhabitant
   named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected, from the plan: the field clause, B-AMEN,
   `χ_f` and TJ on the standard three and `Rigidity.positive_entropy_rigidity`, with `StandingFive.kloosterman_bound`
   where Weil's bound is read; the two instances and the triangle-free graph as their proofs read; the splits on the
   six-or-seven corollary's list — the record says which, as printed). Commit any statement dump gzipped (inventory item
   1011: two uncompressed 48.7 MB dumps went public before this rule).
4. **The read-aloud** of each head statement against row 129 and the entries FS103-F-FRAC, -F-TJ, -F-ROUND, -F-TF and
   -B-AMEN (`plans/FS103-derivation.md`), in your record, with what is not claimed (a value of `m₁` or `χ_f(ℝ²)`; anything
   at six colours beyond the corollary).
5. **The drafts** for the front files, each naming its slot. No novelty wording: the prior-art search for the fractional
   forms and the triangle-free six-chromatic graph has not been run (item 1021) — write "prior art not yet searched"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. The planner recommended against the pattern-law refactor of
the collapse's modules (one `PatternLaw F Λ N` for colourings and independent sets) for now; if the copies in D2 convince you
otherwise, say so with a price, but do not refactor landed modules. Not yours: any stored statement of the skeleton or of
`main` beyond the three ruled changes (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers that will run full gates. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/ifr1/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-density.md"
open(out,"w").write(b); print(out)
