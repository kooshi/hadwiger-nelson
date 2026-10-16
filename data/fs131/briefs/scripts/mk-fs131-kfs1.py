exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KFS1: de Bruijn's planner on the asking lane's last two ranks (item 1073): rank 7, C7 (which distances a
# four-colouring of rational four-space can forbid beside 1) and rank 9, C14 (the fractional chromatic number of the
# plane over Q(sqrt3, sqrt11) is 4).
# Usage: mk-fs131-kfs1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KFS1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
MAIN=sh("git","-C",W,"rev-parse","--short=9","HEAD")
POR="plans/POROS-2026-10-13-number-field-findings.md"; CQ="CLOSED-QUESTIONS.md"
for p in ("LEDGER.md","LEAN.md",POR,CQ,"data/consolidation-2026-09-27/lv/record.md","data/consolidation-2026-09-27/lx/record.md",
          "plans/FS56-field-blowup.md","data/fs56/g27/cert-g27-mrvz.json","tools/fs56_gf_check.py","plans/KERNEL-HOLDS.md",
          "Proofs/HadwigerNelson/Collapse/Density/Headline.lean","BIBLIOGRAPHY.md","plans/FS131-PAS1-prior-art.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must,head=""):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+((" "+head) if head else "")+"\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
P7=wl(POR,428,433,"**Rank 7 — C7. Rational four-space.**","§ 3.3")
P9=wl(POR,445,449,"**Rank 9 — C14.**","§ 3.3")
C7=wl(CQ,674,690,"- **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?**")
C14=wl(CQ,254,272,"### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`")
I1073=item(1073)
b=f'''# Brief {JOB} — rational four-space at four colours, and the fractional chromatic number over ℚ(√3, √11): the map, the skeleton and the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for the asking lane's last two ranks — part A, which distances a four-colouring of `ℚ⁴` can forbid beside 1 (C7); part B, the fractional chromatic number of the plane over ℚ(√3, √11) (C14) — the map of what each rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you a prior-art search on the same two results (Ephodos, FS131-PAS2) and a bibliography filing (a Clerk), neither of which writes a file you write
  mission: § Why this job
  statements: § The results
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (a result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-four-space-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/{JOB}-four-space-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kfs1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`, `RESULTS.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k — if the two parts will not both fit, finish part A's plan and say what part B needs; a successor plans it from your record, and that is a good report

Hello. Today the library took the asking lane's list of number-field results that the literature has asked for, one
rank at a time, to the kernel: the five-colour fields, the three-colour criterion, the `p`-adic plane, the density form
of the collapse, the ring of unit vectors. Two entries are left, and this job maps and prices both.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
My ruling on what runs next:

{I1073}
## The results

**Part A — rational four-space at four colours (rank 7, C7).** The asking lane's entry:

{P7}
The closed-questions entry, with the derivation's outline:

{C7}
The derivation is LV-T3 in `data/consolidation-2026-09-27/lv/record.md` (stage 3 reads `[Zaks1999]` in full), and the
blind second is stage 1 of `data/consolidation-2026-09-27/lx/record.md`. It reads `[BendaPerles2000]` pp. 122–125 for the
description of the component of the origin, and `LEDGER.md` row 57's quaternion remark for the residue `𝔽₄`.

**Part B — the fractional chromatic number over ℚ(√3, √11) (rank 9, C14).** The asking lane's entry:

{P9}
The closed-questions entry:

{C14}
Two things have changed since that entry was written, and both bear on the route. First, the kernel now holds the
density form of the collapse: `χ_f(F²) = 1/α_loc(F)` at every real number field
(`Collapse.fractionalChromaticNumber_planeOver_eq` in `Proofs/HadwigerNelson/Collapse/Density/Headline.lean`, on the
standard three axioms and `[EinsiedlerLindenstrauss2022]` Thm 1.3; stated in `plans/KERNEL-HOLDS.md`), so a second
route to the value runs through the residue targets' independence ratios at ℚ(√3, √11)'s conjugation-fixed primes,
beside the route through `[MatolcsiEtAl2025]`'s graph `G27` (its certificate re-checked by `tools/fs56_gf_check.py`,
data in `data/fs56/g27/`). Second, the prior-art job of this morning found that at the Moser ring the instance
`χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `[MatolcsiEtAl2025]`'s `G27` (`plans/FS131-PAS1-prior-art.md`); FS131-PAS2 is
reading that against C14 now. Which route is cheaper, and which statement is the one to store (the field's `χ_f`, the
supremum over its finite subgraphs, or both), is yours to map.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, each result of parts A and B, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** For each result: each step set against what this library and Mathlib at our pin hold, by
   declaration name and module (Mathlib's quaternions, `QuaternionAlgebra`, and the library's residue and component
   machinery for part A; the density form and Theorem B for part B); what is missing, with your estimate in lines of
   Lean. Any printed theorem a step reads (Zaks's Lemma 1, Benda and Perles's index-2 description, the blow-up of
   `[MatolcsiEtAl2025]`): formalize it if that is about an hour of agent work, and when unsure, formalize; otherwise say
   what declaring it would take (`LEAN.md` § Assumptions, its four items).
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean, read back aloud against the results in your
   record, with what is not claimed; every missing piece as a statement with `sorry`, built through `./scripts/build.sh`
   under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the experience-modeling pass
   on the head statements (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them).
   Nothing with a `sorry` reaches `main`; the skeleton stays on your branch. Part A first; part B in the same stages if it
   fits, as its own module.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your record,
   each naming its slot (C7 has no ledger row: draft one, its number left to me). Novelty is FS131-PAS2's to find: word
   nothing about either result as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, the route for each part, whether a piece is better
proved as a general lemma, and the order of the leaves. If a result is misstated, or holds in a wider form, say so: a
wrong statement reported is a finding, and a better target is welcome with its price. {NOSPAWN}

## The machine

The laptop: 12 cores, 31 GB; no other job builds. Every Lean build and every `lake env lean` over about 2 GiB goes through
the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 6 -- env MEMMAX=10G BATCH=3 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. On exit 75 wait ten minutes and retry.
`lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a
module is green. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep
anything your record cites under `data/fs131/kfs1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-four-space.md"
open(out,"w").write(b); print(out)
