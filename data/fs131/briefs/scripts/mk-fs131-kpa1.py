exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KPA1: de Bruijn's planner on the p-adic plane (the asking lane's rank 4, C5; ledger row 75 and FS66-T7/T8):
# the Borel chromatic number of the anisotropic p-adic plane is unbounded in p, with its values at 7, 11, 19, 23.
# Usage: mk-fs131-kpa1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KPA1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
POR="plans/POROS-2026-10-13-number-field-findings.md"
for p in ("LEDGER.md","LEAN.md","plans/FS66-derivation.md","plans/FS66-residue-tower-drop.md","plans/FS66-phase2-certificate.md",
          "data/fs66/b1/SOUNDNESS.md","CLOSED-QUESTIONS.md","BIBLIOGRAPHY.md",POR,
          "Proofs/HadwigerNelson/Arith/FloorPlanes.lean"): assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+" § 3.3 The first ten, each as the theorem a reader would look for\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
THM=wl(POR,392,394,"- *The theorem.* For every prime `p ≡ 3 (mod 4)`")
OBJ=wl(POR,402,403,"- *The first objection.* \"Why did the posers not see it?\"")
DEF=Q(POR,"**If he says nothing:**","§ 3.5 The recommendation")
R75=Q("LEDGER.md","| 75 |")
OLD=Q("plans/FS66-derivation.md","| FS66-T7 | declined")
b=f'''# Brief {JOB} — the p-adic plane at the kernel: the Borel chromatic number of the anisotropic p-adic plane is unbounded in p, and its values at 7, 11, 19 and 23 — the map, the skeleton and the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for one hand result of ours, the p-adic Borel bound (FS66-T7) and the values beside it (ledger row 75) — the map of what it rests on, the statements in Lean, the skeleton with `sorry` at every leaf, a plan per leaf, priced in lines of Lean
  launch: now, in a worktree of your own cut from `main`; beside you two other jobs (an implementer finishing another module, and a planner of an unrelated theorem), neither of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-padic-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build): `plans/{JOB}-padic-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kpa1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `ROADMAP.md`, `README.md`) and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after each of the stages below; hand back at a saved stage before about 500k

Hello. The library has formalized the project's results about planes over number fields one by one this week; this
one is about the p-adic plane instead, and a published question asks for it by name.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
The asking lane ranked the project's findings by interest to the field. Of the three ranked above this one, two are in
the kernel and the third is being finished there (all but its density form, which waits for that module); its default
order names this one next:

{DEF}
An earlier triage of the derivation's theorems for the kernel declined this one, before that rule existed:

{OLD}
W2 replaces that: the bound is a finding of ours, so it is formalized.

## The result

The theorem a reader would look for, as the asking lane wrote it:

{THM}
The objection it must meet, from the same entry:

{OBJ}
The values and the tower, as the ledger states them now (its row 75, quoted whole; the kernel already holds
`χ(UD(ℤ/121, 2)) = 5`):

{R75}
The derivation is `plans/FS66-derivation.md`: FS66-T7 (the Borel bound) and FS66-T8 (the tower's limit is the clopen
chromatic number of `ℤ_p²`), with the hand links L1–L6 that join the certificates to the values; the soundness note of
the certificates' checker is `data/fs66/b1/SOUNDNESS.md`, and the milestone's plan `plans/FS66-residue-tower-drop.md`
(its § PA.2 found the posers' question). The posers' paper is `[BardestaniMallahiKarai2017]` in `BIBLIOGRAPHY.md`, with
where our copy is and what of it has been read; `CLOSED-QUESTIONS.md` § 1.8 records the answer. Weil's bound is already
a declared outside theorem of this library (`StandingFive.kloosterman_bound`); whether T7 reads it in the declared form is
part of the map.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own
   words, the result, each hypothesis it rests on (each printed theorem, each certificate, each hand link), and what
   the library holds; log any mismatch as a finding.
2. **Stage 2 — the map.** Each step of T7, of T8 as far as the values need it, and of L1–L6, set against what this
   library, Mathlib at our pin and the outside release under `~/source/math` hold, by declaration name and module; what is
   missing, with your estimate of each piece in lines of Lean. For each printed theorem the result reads (the posers'
   Theorem 2.5, Weil's bound): formalize it if that is about an hour of agent work, and when unsure, formalize; otherwise
   say what declaring it would take (`LEAN.md` § Assumptions, its four items). For the certificates: their size, and
   the route by which the kernel would check them with no `native_decide` (the density bound's 13,552 atoms went
   through `decide +kernel` in core-only modules; `plans/FS131-LDB1-landing.md` is that job's record), with a measured cost on
   one certificate if it is cheap to measure.
3. **Stage 3 — the skeleton and the plan.** The head statements in Lean — the Borel bound for every prime
   `p ≡ 3 (mod 4)` and its unboundedness, and the values at 7, 11, 19 and 23 that the certificates reach — read back
   aloud against the result in your record, with what is not claimed (the plain chromatic number of `ℚ_p²`); every
   missing piece as a statement with `sorry`, built through `./scripts/build.sh` under the slot; a plan per leaf; the
   price in lines of Lean in total and per module; then the experience-modeling pass on the head statements
   (`debruijn-experience-modeling`: their names and docstrings as a mathematician would cite them). Nothing with a
   `sorry` reaches `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with the front-page lines your reading finds owed drafted in your
   record, each naming its slot; novelty as the ledger words it ("prior art: not found in print" where that is the
   finding), and the posers' question credited to them.

## What is yours to decide

The definitions (in particular how "Borel chromatic number" is stated over `ℚ_p²` with Mathlib's topology), the
modules' names and places, the form of every Lean statement, whether a piece is better proved as a general lemma, which
values ride in the first module, and the order of the leaves. If the result is misstated, or holds in a wider form (for
instance at every non-archimedean local field with the same anisotropy, or with a better constant), say so: a wrong
statement reported is a finding, and a better target is welcome with its price.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kpa1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-padic.md"
open(out,"w").write(b); print(out)
