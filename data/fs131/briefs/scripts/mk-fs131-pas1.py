exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-PAS1: the prior-art searches owed by this week's landings and plans (items 1000, 1021, 1027, 1044).
# Usage: mk-fs131-pas1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-PAS1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
for p in ("LEDGER.md","BIBLIOGRAPHY.md","CLOSED-QUESTIONS.md","README.md","RESULTS.md","plans/FS131-KTC1-three-colour-plan.md",
          "plans/POROS-2026-10-13-number-field-findings.md","plans/FS103-derivation.md","plans/FS100-derivation.md","plans/FS91-derivation.md"):
    assert os.path.exists(W+p),p
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1021=item(1021); I1027=item(1027); I1043=item(1043); I1044=item(1044)
b=f'''# Brief {JOB} — the prior-art searches this week's results owe: five statements, each searched in the field's own words, read, and recorded

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity; this job is the prior-art gate (§PA) of your opening job, run on five statements already derived or proved, with no derivation of its own
  role: the prior-art searcher for five results whose front-page wording now says "prior art not yet searched" or "novelty unchecked"
  launch: now, in a worktree of your own cut from `main`; beside you three Lean implementers in other worktrees, none of which writes a file you write
  mission: § Why this job
  statements: § The five statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if you find a statement already in print (that changes a public page), and when the record is done; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `plans/{JOB}-prior-art.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (cut from `main` at `{HEAD}`; no Lean build): `plans/{JOB}-prior-art.md`; your scripts and query logs under `data/fs131/pas1/`; `data/fs131/reports/{JOB}.md`. Papers you fetch go to the document library `~/source/library/` (other authors' documents never go into this repository). `BIBLIOGRAPHY.md`, `LEDGER.md`, `README.md`, `RESULTS.md` and `CLOSED-QUESTIONS.md` rows are drafted in your record, each naming its slot, never edited. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 300k by the harness's count, as guidance; save a stage after each statement; hand back at a saved stage before about 400k

Hello. The repository's front page went public today, and five of its results — or results about to land — carry the
words "prior art not yet searched". This job replaces those words with what the literature actually says.

## Why this job

{W2}
Publishing a finding means saying, accurately, whether it is new. The project's wording rule: for its own results it says
"prior art: not found in print", backed by searches recorded in the ledger, and never "first"; where a search was not run,
it says so. A result found in print is credited to its authors, and that is a good outcome of this job, not a bad one.

## The five statements

Each with where the debt was logged.

1. **The three-colour criterion past row 79's class** (inventory item 1043): for every abelian group `A` and every set of
   steps `S ∌ 0`, the Cayley graph `Cay(A, S)` is 3-colourable exactly when some character `θ : A → ℝ/ℤ` maps every step
   into `[1/3, 2/3]`; for `A` finitely generated and `S` finite, exactly when it has a periodic 3-colouring; for `S` finite
   and generating (torsion and asymmetric `S` allowed), periodic 3-colourings are dense. Row 79's own class
   (finitely generated torsion-free, `S = −S` finite generating) was searched (`CLOSED-QUESTIONS.md` § 2.4); the widening
   was not (`plans/FS131-KTC1-three-colour-plan.md` § 3.6 says what to search).

{I1043}
2. **A finite triangle-free unit-distance graph with chromatic number 6, and the fractional forms** (item 1021): given
   `[OAIMath2026]`'s `6 ≤ χ(ℝ²)`, a finite triangle-free six-chromatic unit-distance graph exists (de Bruijn–Erdős over a
   field with no `√3`); and `χ_f(F²) = 1/α_loc(F)` at every real number field, with `χ_f(F²) = χ_f(ℝ²)` at the fields where
   the colouring collapse holds (`LEDGER.md` row 129; `plans/FS103-derivation.md`, entries FS103-F-FRAC and FS103-F-TF).

{I1021}
3. **CLS, the classification of four-colour places** (item 1027): for every real number field, `L(F) ≥ 5` exactly when no
   conjugation-fixed prime of `F(i)` has residue field `𝔽₃` or `𝔽₇`, none above 2 is inert of norm at most 32, and none
   above 2 ramifies in `F(i)/F` (`LEDGER.md` row 123; `plans/FS100-derivation.md`).
4. **Lemma C′** (items 1027, 1044): for a real number field with no ramified conjugation-fixed prime above 2, the additive
   group generated by the unit vectors of `F²` is the ring of elements of `F(i)` integral at every conjugation-fixed prime
   (`LEDGER.md` row 100; `plans/FS91-derivation.md` § 2). The asking lane names where a number theorist would look first:
   `[Fischer1990b]`, prime inversion, `[Shimura1964]` (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3, rank 8).
5. **Infinitely many degree-one primes of norm `≡ 3 (mod 4)` in every real number field, by a sign change** (item 1044):
   the minimal polynomial of a primitive element changes sign at its real root, so a value of its homogenized form is
   `≡ −1 (mod 4M)` and has a prime factor `q ≡ 3 (mod 4)` at which the polynomial has a root. Probably classical; the job is
   to find where.

{I1027}
{I1044}
## How to search (my instruction, from this project's prior-art rule)

- Search in the **field's own words**, never this project's coined terms (`BIBLIOGRAPHY.md` § E translates them), and in
  **two disciplines** for each object (for 1: symbolic dynamics and homomorphism shifts as well as graph colouring; for 3
  and 4: algebraic number theory as well as geometric graph theory); search for the **question**, not only the method.
- **zbMATH**: its web pages refuse scripted fetches; its API works:
  `https://api.zbmath.org/v1/document/_search?search_string=...&results_per_page=60`, with `au:"Last, First"`, `ti:"…"`,
  `ab:"…"`, `py:1985-2000` joined by `&` and `|`. For every author who posed or worked a question, pull their **complete
  listing** there. Pre-2000 proceedings are in no citation graph.
- **Read what you find** — abstract, results and references at least — before you write a verdict; a title seen only in a
  listing is recorded as such. Mine the reference lists of what you read. Record every query and every negative.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate the five statements in your
   record in the field's own words, with the query terms each suggests.
2. **One stage per statement:** the queries run (database, string, hit count), what was read and how far, and a verdict —
   *found* (the citation, what it states, how it relates: same, weaker, stronger, special case) or *not found in print*
   (with the searches that back it) — and the drafts it implies: a `BIBLIOGRAPHY.md` row for every work read, and the
   novelty line for the ledger row and the public pages, each naming its slot.
3. **The report**, in the standing rules' form.

## What is yours to decide

The queries, the order, and how far to read. If a statement turns out to be misstated as a reader of the literature would
state it, say so: that is a finding.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-prior-art.md"
open(out,"w").write(b); print(out)
