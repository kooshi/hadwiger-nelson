exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-PAS2: the prior-art searches owed by the asking lane's last two ranks (item 1073): C7 (rational four-space at
# four colours, nothing after 2006 searched) and C14 (the fractional chromatic number over Q(sqrt3, sqrt11), against
# [Ducz2026] Thm 3.1).
# Usage: mk-fs131-pas2.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-PAS2"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
POR="plans/POROS-2026-10-13-number-field-findings.md"; CQ="CLOSED-QUESTIONS.md"; PAS="plans/FS131-PAS1-prior-art.md"
for p in ("LEDGER.md","BIBLIOGRAPHY.md",CQ,POR,PAS,"README.md","RESULTS.md","plans/FS56-field-blowup.md",
          "data/consolidation-2026-09-27/lv/record.md","data/consolidation-2026-09-27/lx/record.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must,head=""):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert must in ls[0],(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+((" "+head) if head else "")+"\n"
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
C7=wl(CQ,674,690,"- **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?**")
C14=wl(CQ,254,272,"### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`")
P7=wl(POR,428,433,"**Rank 7 — C7. Rational four-space.**","§ 3.3")
P9=wl(POR,445,449,"**Rank 9 — C14.**","§ 3.3")
I1073=item(1073)
b=f'''# Brief {JOB} — the prior-art searches the asking lane's last two ranks owe: two statements, each searched in the field's own words, read, and recorded

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this job is the prior-art gate (§PA) of your opening job, run on two statements already derived, with no derivation of its own
  role: the prior-art searcher for two results whose entries say "nothing after 2006 searched" (C7) or that the literature may already hold (C14)
  launch: now, in a worktree of your own cut from `main`; beside you a kernel planner on the same two results (de Bruijn, FS131-KFS1) and a bibliography filing (a Clerk), none of which writes a file you write
  mission: § Why this job
  statements: § The two statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if you find a statement already in print (that changes a public page and the planner's job), and when the record is done; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `plans/{JOB}-prior-art.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{HEAD}`; no Lean build): `plans/{JOB}-prior-art.md`; your scripts and query logs under `data/fs131/pas2/`; `data/fs131/reports/{JOB}.md`. Papers you fetch go to the document library `~/source/library/` (other authors' documents never go into this repository). `BIBLIOGRAPHY.md`, `LEDGER.md`, `README.md`, `RESULTS.md` and `CLOSED-QUESTIONS.md` rows are drafted in your record, each naming its slot, never edited. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after each statement; hand back at a saved stage before about 350k

Hello. This morning's prior-art job (FS131-PAS1, `{PAS}`) searched five of this week's results and found two of them
already in print, which is a good outcome: the front page now credits their authors. Two results on the asking lane's
list were not in it, and a kernel planner starts on both today. This job finds what the literature says about them.

## Why this job

{W2}
My ruling on what runs next, which names this job:

{I1073}
The project's wording rule: for its own results it says "prior art: not found in print", backed by searches recorded in
the ledger, and never "first"; where a search was not run, it says so. A result found in print is credited to its
authors, and that is a good outcome of this job, not a bad one.

## The two statements

1. **C7, rational four-space** — the asking lane's entry:

{P7}
   The closed-questions entry, with the derivation's outline and what was searched:

{C7}
2. **C14, the fractional chromatic number of the plane over ℚ(√3, √11)** — the asking lane's entry:

{P9}
   The closed-questions entry, with the 2026-09-16 search:

{C14}
   Since then, FS131-PAS1 found that at the Moser ring the instance `χ_gf = 4` is `[Ducz2026]` Thm 3.1 with
   `[MatolcsiEtAl2025]`'s `G27` (`{PAS}`; its query logs under `data/fs131/pas1/`). Read `[Ducz2026]` against C14 first:
   whether it states the field's value, the supremum over finite subgraphs, the geometric fractional chromatic number of a
   lattice, or something else, and how each relates.

## How to search (my instruction, from this project's prior-art rule)

- Search in the **field's own words**, never this project's coined terms (`BIBLIOGRAPHY.md` § E translates them), and in
  **two disciplines** for each object (for C7: rational distance graphs and colourings of `ℚⁿ`, and quaternion orders and
  lattices; for C14: fractional colouring and independence ratios of distance graphs, and harmonic analysis of
  distance-avoiding sets); search for the **question**, not only the method.
- **zbMATH**: its web pages refuse scripted fetches; its API works:
  `https://api.zbmath.org/v1/document/_search?search_string=...&results_per_page=60`, with `au:"Last, First"`, `ti:"…"`,
  `ab:"…"`, `py:1985-2000` joined by `&` and `|`. For every author who posed or worked the question (for C7: Johnson,
  Zaks, Benda, Perles, and — from my memory, unchecked — Chow, on distances forbidden by colourings of `ℚⁿ`; for C14: Cranston, Rabern, Matolcsi, Ruzsa, Varga, Zsámboki, Ducz, Ambrus), pull
  their **complete listing** there. Pre-2000 proceedings are in no citation graph; Geombinatorics issues are in
  `~/source/library/geombinatorics/`.
- **Read what you find** — abstract, results and references at least — before you write a verdict; a title seen only in
  a listing is recorded as such. Mine the reference lists of what you read. Record every query and every negative.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate the two statements in your
   record in the field's own words, with the query terms each suggests.
2. **One stage per statement:** the queries run (database, string, hit count), what was read and how far, and a verdict —
   *found* (the citation, what it states, how it relates: same, weaker, stronger, special case) or *not found in print*
   (with the searches that back it) — and the drafts it implies: a `BIBLIOGRAPHY.md` row for every work read, and the
   novelty line for the ledger and the public pages, each naming its slot.
3. **The report**, in the standing rules' form.

## What is yours to decide

The queries, the order, and how far to read. If a statement turns out to be misstated as a reader of the literature would
state it, say so: that is a finding. {NOSPAWN}
'''
out=ROOT+f"data/fs131/briefs/{JOB}-prior-art.md"
open(out,"w").write(b); print(out)
