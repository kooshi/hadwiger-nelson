exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KRU1: de Bruijn's planner for part B of FS131-KCS1's plan: row 100's Lemma C' (the ring the unit vectors generate)
# and the asking lane's C8 components clause.
# Usage: mk-fs131-kru1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-KRU1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
MAIN=sh("git","-C",W,"rev-parse","--short=9","HEAD")
POR="plans/POROS-2026-10-13-number-field-findings.md"
KCS="/home/kooshi/source/lean-dir/.claude/worktrees/kcs1/plans/FS131-KCS1-class-plan.md"
for p in ("LEDGER.md","LEAN.md","ROADMAP.md",POR,"plans/FS91-derivation.md","data/fs131/lch1/ring-scope-lemma-c-prime.lean",
          "Proofs/HadwigerNelson/Rigidity/ClassRatio.lean","BIBLIOGRAPHY.md"): assert os.path.exists(W+p),p
assert os.path.exists(KCS)
def wl(path,first,last,must,head=""):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+((" "+head) if head else "")+"\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
RM=wl("ROADMAP.md",99,106,"2. **Lemma C′**","§ 3. Planes over number fields")
R100=Q("LEDGER.md","| 100 |")
P8=wl(POR,435,441,"**Rank 8 — C8. The ring of unit vectors.**","§ 3.3")
I1027=item(1027)
b=f'''# Brief {JOB} — the ring of unit vectors at the kernel: Lemma C′ and the components clause — the skeleton, the plan per leaf, the price

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus
  role: the kernel lane's planner for row 100's Lemma C′ (the additive group the unit vectors of `F²` generate is the ring of elements of `F(i)` integral at every conjugation-fixed prime, when no such prime above 2 ramifies) and the asking lane's components clause beside it — part B of a plan whose map and price exist, so this job makes its skeleton, its plan per leaf and its price, and settles the components clause's two routes
  launch: now, in a worktree of your own cut from `main`; beside you three implementers in other worktrees (the three-colour criterion, the density form of the collapse, the five-colour fields — the last of them on the branch whose record you read), none of which writes a file you write
  mission: § Why this job
  statements: § The result
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once for a statement defect (the result false or misstated as written) or a generalization; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building
  record: `plans/{JOB}-ring-plan.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's build, current for `main`): `plans/{JOB}-ring-plan.md`; skeleton modules under `Proofs/HadwigerNelson/` in files you create, each named in your record, and the import lines that bring them into `Proofs.lean`; `ARCHITECTURE.md` rows for your new modules only; your scripts and outputs under `data/fs131/kru1/`; `data/fs131/reports/{JOB}.md`. Edits to the front files and to existing modules are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard on every commit: if it refuses one, reword what it names and commit again, never `--no-verify`
  budget: about 400k by the harness's count, as guidance; save a stage after each stage below; hand back at a saved stage before about 500k

Hello. The planner before you mapped this lemma and priced it at about 700 lines over eight leaves, then ran out of room
for its skeleton. Its route is written down; you turn it into typed statements and a plan an implementer can follow.

## Why this job

Kooshi's rule for what this project publishes:

{W2}
## The result

The roadmap's entry, with the statement as it was typed when it was taken out of the library:

{RM}
Row 100, quoted whole (Lemma C′ is in its peel):

{R100}
The asking lane's entry, with the components clause and the novelty warning:

{P8}
My ruling on the previous planner's hand-back, whose (2) is this job:

{I1027}
The previous planner's map of this part is its record's § 2.6, on its branch: `{KCS}` (read it there; that worktree is
another job's, so read only). Its route: `R ⊆ O′` and `c·O′ ⊆ R` are held; what is missing is that `R` maps onto
everything at the stable primes dividing `c`, by local Hilbert 90 and the Chinese remainder theorem in place of weak
approximation, then local generation by counting and the Hensel fibre count. The derivation is `plans/FS91-derivation.md`
§ 2; the statement as typed and its hand route, `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate in your record, in your own words,
   the lemma, the components clause, what each rests on, and what the library holds; log any mismatch as a finding.
2. **Stage 2 — the statements and the map, brought to date.** Re-read the previous planner's § 2.6 against the library
   as it is now on `main` (names, privacy of the lemmas it reads in `Rigidity/ClassRatio`; another implementer is making
   some of that module's private lemmas public on its branch, so plan as if they were private and name any you would want
   public); the head statement in Lean, read back aloud against row 100 and the roadmap's typed form, with what is not
   claimed. **The components clause:** state it at every field with an exhibited stable prime, and price beside it the
   route that states it at every real number field with one declared outside theorem (a nontrivial quadratic extension
   of number fields has a non-split prime), with that theorem's four items of `LEAN.md` § Assumptions drafted and the
   printed source you would cite. If the non-split prime can be had without Chebotarev (for a quadratic extension there
   may be an elementary route) and you can price it, that is the better finding.
3. **Stage 3 — the skeleton and the plan.** Every missing piece as a statement with `sorry`, built through
   `./scripts/build.sh` under the slot; a plan per leaf; the price in lines of Lean in total and per module; then the
   experience-modeling pass on the head statements (`debruijn-experience-modeling`). Nothing with a `sorry` reaches
   `main`; the skeleton stays on your branch.
4. **The report**, in the standing rules' form, with front-page drafts in your record, each naming its slot. The lemma's
   novelty is unchecked: word nothing about it as new.

## What is yours to decide

The modules' names and places, the form of every Lean statement, whether a piece is better proved as a general lemma,
and the order of the leaves. If the result is misstated, or holds in a wider form, say so: a wrong statement reported is a
finding, and a better target is welcome with its price.

## The machine

The laptop: 12 cores, 31 GB, shared with three implementers that build and will run full gates. Every Lean build and
every `lake env lean` over about 2 GiB goes through the slot with this machine's settings, from inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 3 -- env MEMMAX=6G BATCH=2 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence that a module is green. The worktree's `.lake/build` is its own copy; never
replace it with a symlink. `/tmp` is a tmpfs: keep anything your record cites under `data/fs131/kru1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-ring.md"
open(out,"w").write(b); print(out)
