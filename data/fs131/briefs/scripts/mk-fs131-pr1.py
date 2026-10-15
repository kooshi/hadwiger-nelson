exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-PR1: de Bruijn's planner drafts the public README and the public roadmap of what is left to formalize (W6).
# Usage: mk-fs131-pr1.py <item of the chain's landing> <item of the front page's filing>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KL,KF=int(sys.argv[1]),int(sys.argv[2])
TREE="fs131-wq1"; BR="fs131-pr1"; JOB="FS131-PR1"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR and [l for l in sh("git","-C",W,"status","--porcelain").splitlines() if not l.startswith("??")]==[]
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
assert sh("git","-C",ROOT,"diff","--stat","eee71c74c","main","--","Proofs","Proofs.lean","lakefile.lean","lake-manifest.json","lean-toolchain")==""
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
for p in ("LEDGER.md","LEAN.md","ARCHITECTURE.md","BIBLIOGRAPHY.md","plans/LEAN-BACKLOG.md","plans/STUB-lean-backlog.md",
          "data/fs131/lch1/ring-scope-lemma-c-prime.lean","data/fs131/lgt1/gate/receipt-axioms-final.log"): assert os.path.exists(W+p),p
W6=Q("data/fs131/REQUEST-2026-10-13.md","Once the chain lands, we'll do some sanitization")
NAME=Q("CLAUDE.md","- **Naming is a first-class deliverable**","§ The mission, Publication")
WHO=Q("CLAUDE.md","The mathematics and the engineering here are the agents'","§ Whose work this is")
b=f'''# Brief {JOB} — draft the public README and the public roadmap of what is left to formalize

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you run on Opus. Here your plan is not a skeleton: it is an honest public account of what the library proves and what it does not yet
  role: the author of two public pages of a Lean repository about to go on GitHub — its front README and a readable roadmap of what is left to formalize — and of any short directory READMEs a stranger needs to find their way; every claim on them traced to the ledger, the gate's logs or the kernel's print
  launch: now, in the tree that holds `main`'s compiled library; one other job runs, a read-only sweep of the history, in another tree
  mission: § Why this job
  statements: § What the pages rest on
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the ledger, the front page and the kernel's print disagree about any result, or if a page would need a decision that is Kooshi's (a licence, a name, what is public); the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full
  record: `plans/{JOB}-readme.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{MAIN}`; its compiled library is current for `main`'s Lean sources, gated as `eee71c74c`): `README.md` and `ROADMAP.md` at the root (new); at most five new `README.md` files in directories you choose, each named in your record; `plans/{JOB}-readme.md`; your scripts and outputs under `data/fs131/pr1/`; `data/fs131/reports/{JOB}.md`. **Not** `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md` or any file under `Proofs/` — where one of them is wrong or stale, draft the correction in your record. No build. Nothing on `main`; no push
  budget: about 300k by the harness's count, as guidance; save a stage after the readback, after the inventory of results, after each page's draft, and at the hand-back; hand back at a saved stage before about 450k

Hello. This repository has spent eighty-five days building a kernel-checked account of the Hadwiger–Nelson problem.
Kooshi now wants it on GitHub, readable by a stranger, before the work goes on. You write the two pages that stranger
reads first.

## Why this job

Kooshi's word for this step:

{W6}
The trigger is met. My log of the landing, and of the front page's filing that brought `CLAUDE.md` and `LEDGER.md`
current with it:

{item(KL)}
{item(KF)}
"Not a full writeup": the README says what is here, what it proves at what grade, what it rests on, whose it is, and how
to check it; the roadmap lists what is not yet formalized. Neither argues the mathematics.

## What the pages rest on

The project's rule for words a stranger reads:

{NAME}
Whose work this is, in the project's own words:

{WHO}
**The sources, in order of authority:** the kernel's print from this tree's compiled library (statements and
`#print axioms`; one file through `lake env lean`, below); the gate's logs on `main` (`data/fs131/lgt1/gate/`, the last
full gate, green on `eee71c74c`); `LEDGER.md` (one row per result, its grade, its address, its prior art, § The claim
list for what is ours); `CLAUDE.md` § The mission and § Frontier (current state); `LEAN.md` § Trust ledger and
§ Assumptions (the declared outside theorems and the hypotheses); `ARCHITECTURE.md` (the module map);
`BIBLIOGRAPHY.md` (every cited work; its § E maps this project's words to the literature's);
`plans/LEAN-BACKLOG.md` and `plans/STUB-lean-backlog.md` (what the Lean backlog holds). Lemma C′ (row 100), deleted from
the library at the chain's landing, has its statement kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.

## Done means

1. **Readback** (a saved stage): the quotations above checked against their sources; your record restates, one line
   each, what the README must say and what the roadmap must list.
2. **The inventory of results** (a saved stage), in your record: every headline result the README will name — at least
   the interval `5 ≤ χ(ℝ²) ≤ 7` on the standard three axioms, `6 ≤ χ(ℝ²)` on `[OAIMath2026]`'s declared theorem,
   `χ(ℝ²) = χ_m⁰(ℝ²)`, the density equality, the density bound, the number-field values through four, and the
   five-colour chain (`min(L(F), 5) ≤ χ(F²)`, `χ(ℚ(√47)²) = 5` and the other instances) — each with its Lean name, its
   stored statement and its axioms as you print them now, its ledger row and grade, and its whose-is-it line in the
   ledger's words. Print every statement and axiom list yourself: one scratch file under `data/fs131/pr1/`, run from
   inside the tree, `env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8
   --cpus 2 --wait 3600 --name pr1 -- lake env lean -DautoImplicit=false <file>`.
3. **`README.md`** (a saved stage): what the repository is, in a paragraph; the results table (plain-words statement, Lean
   name, what it rests on, whose it is); what the library assumes (the declared outside theorems by name and citation, and
   the audit that checks it); how to build and check it (the pin, `scripts/build.sh`, the axiom audit — machine-independent,
   no path of this laptop); how the repository is laid out; how it was made (the agents and Kooshi's part, from the
   quotation above). Novelty in the ledger's words: "prior art: not found in print", the parts that are not ours named;
   never "new", "first" or "novel" as a claim, and never "not new" for a result of ours. A few screens, not a paper.
4. **`ROADMAP.md`** (a saved stage): what is left to formalize, complete and plain — every ledger row whose grade is not
   `[kernel]` (or the part of a row that is not), grouped by what it bears on; the declared outside theorems (Weil's bound,
   Einsiedler–Lindenstrauss Theorem 1.3, the release's five-colouring theorem) and what landing each on the standard three
   axioms would mean; Lemma C′; `χ(F²) = L(F)` at `L(F) ≤ 5` as one named theorem (a two-line composition, not yet stored);
   the milestones whose Lean phase is open (`CLAUDE.md` § Paths forward). Each item with its source address. No time or
   difficulty estimate: rank by bearing on the answer (`CLAUDE.md` § Counter-priors, rule 1).
5. **Directory READMEs**, only where a stranger would be lost without one, each a few lines.
6. **The report** in the standing rules' form, with every place the ledger, the front page and the print disagree, and
   every decision you left to Kooshi (a licence among them: the repository has no licence file).

## What is yours to decide

The pages' structure, wording and length; which results are headline; which directories get a README; how to translate
in-house terms (with § E's table). Do not mention the session-transcript folder `chats-bak/` or any personal detail of
Kooshi's: whether the transcripts stay in the public history is undecided. If a ledger row and the kernel's print
disagree, the print wins on the page and the disagreement goes to me.

## The machine

Laptop, 12 cores, 31 GB; one other job runs. This tree's compiled library is current for `main`'s Lean sources: do not
build, and do not edit any file under `Proofs/`. `/tmp` is wiped at power-off: keep what your record cites under
`data/fs131/pr1/`. Commit on your branch by explicit path and **do not push**: the remote is down and the
coordinator copies the branches to a backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-readme.md","w").write(b); print("ok",len(b))
