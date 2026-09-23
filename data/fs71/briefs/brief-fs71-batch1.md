# Brief — FS-71 batch 1: the theorem audit of milestones M17–M36

Hello, and welcome. You are the **implementer of batch 1 of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; `CLAUDE.md` changed today, and the results ledger now lives in `LEDGER.md`). I am the
product owner; Kooshi owns the project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name
exists — and it is the first of six, so what you set up (the shape, the discipline) is what the next five copy.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a clean
boundary, commit what you have, write the progress line (below), and tell me what is left — that is a good report, never a
failure. A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch1.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (the plan: §G is the seed inventory, §PA the prior-art procedure, §S the exact
shape, §M the modeling decisions); `plans/FS70-derivation.md` (the template — copy its form); `LEDGER.md` rows 1–33 and § B.

## Your batch

**Milestones M17–M36; ledger rows 1–33.** The files, all under `plans/` (sizes in bytes, so you can budget — 670 KB in all,
which you will grep rather than read whole; §S.4 of the plan gives the discipline):

```
26644 M17-constructing-narrow-fans.md   19933 M18-the-120-degree-class.md      24007 M19-coverage-driven-construction.md
30293 M20-the-extension-problem.md      29310 M21-coupled-circle-systems.md     5828 m21-predictions.md
31650 M22-partner-closure.md            5519 m22-predictions.md                 37089 M23-pivot-triangle.md
42813 M24-completeness.md               31789 M25-triangle-ladders.md           46037 M26-hexagram.md
 2444 M27-tiled-plane.md                 1919 M28-recursion.md                   3607 M29-uncountable-pair.md
29456 M30-degrey-anatomy.md             41204 M31-minimal-five-closure.md       56956 M32-certified-five.md
52090 M33-mechanism-hunt.md              7077 M33-witness-closure.md            43721 M34-act-one-certified.md
 4287 M35-certified-union.md            54574 M35-k5-transfer.md                41938 M36-seven-coloring.md
```

Tools whose docstrings may hold a derivation: `tools/extend.py`, `couple.py`, `anatomy.py`, `rigidity.py`, `closure.py`,
`mechanism.py`, `embed.py`, `verify_defect.py` (read their module docstrings; do not run them). No `data/m17…m36` directories
exist. Lean modules named in the rows are under `Proofs/HadwigerNelson/`; `rg -n "<name>" Proofs/` is how you check a
declaration exists (`lake env lean` is allowed for a `#check`; **never `lake build`** — it takes the machine down).

**The seed** (plan §G.2, batch 1): the rows' grade-tagged clauses outside the kernel — row 13 ("pentagon exclusion is a fact
about the coordinate field"), row 21 ("the triple-kill population is provably empty"), row 27 (**the quadrature law**, G12,
"derived and then confirmed at 26 exact censuses" — find the derivation), row 29 (**the stacking law**, G14 — "a matching is
1-regular and carries no colour pressure, even composed into forced-rainbow triangles"), row 30 (**the criticality
factorisation** `χ(G) ≥ k+1 ⟺ the fan at a vertex whose deletion is k-colourable`, G15), row 31 (`core9_plane`/`core122_plane`
vacuous — a finding about a kernel statement), row 32 (the hex-shell pigeonhole, "folklore, formalisation ours"), rows 33/G20 (the
brick certificate: which half is kernel — `check_pos` — and which is a derivation, "boundary-tight by force, cell diagonal
exactly 1"). The seed is a floor, not the census: the files will hold theorems the rows compressed away, and some seed items will
turn out to be measurements or kernel facts — classify them and say so. **Expected density is low** (plan P4 predicts you file
fewer than six theorems); a low count with a complete enumeration is a fine result, and a high count would be interesting.

## What you produce

1. **`plans/<milestone>-derivation.md`** for every milestone of the batch that proved at least one theorem outside the kernel —
   the shape of `plans/FS70-derivation.md`, with the six sections and the entry skeleton of plan §S.1 (pasted here so the shape is
   exact; the checker reads the five italic labels):

   ```
   **M<nn>-T<n> — <title>. [<hand | derived (rows …) | tools | cert>; <who proved it>]** <the statement, quantifiers explicit,
   hypotheses named; a [tools] statement quantifies over exactly the set checked>. *Proof:* <file §section — a proof, not an
   assertion; or "not on disk — looked in …">. *Proof verdict:* <closes | gap: <the step> | unsure — owner to re-derive>.
   *Rests on it:* <rows, grokkings, stubs, later ids>. *Prior art:* <ours | prior art `[key]` §n | partly: … | check owed:
   `[key]`> — nearest held `[key]`; zbMATH: `<query 1>` (<hits>), `<query 2>` (<hits>). *Kernel:* <kernel (`decl`, module) |
   stub (<which>) | declined — <reason> | priced — <cost>>.
   ```

   Ids `M33-T1`, `M33-T2`, … (the file is `plans/M33-derivation.md`, always that name for that prefix). A milestone with no theorem
   gets **no file** — it gets a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, inserted above the FS-70 lines (the format is the table's; the
   theorem column is a *statement* under ~250 characters; the kernel column carries its reason in a word: `declined (instance)`).
   § B lists only entries whose proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in
   the file's section 4 and never a § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone — batch 5 removes it.
3. **`data/fs71/batch-1.md`** — the batch report, plan §S.3: the census table with **one row per milestone M17–M36, the empty
   ones included**; the progress/resume line; the heading **"Theorems this phase proved"** (expected empty — say so; an audit
   proves nothing new, and if you did prove something, say what); proposed edits to `CLAUDE.md` (exact current sentence →
   proposed sentence, with the reason — you do not edit `CLAUDE.md` or `plans/FRONTIER-STUBS.md`; I do); where the brief was
   wrong; the enumeration (files read in full; files grepped, with the patterns; files skipped and why). Create `data/fs71/`.
4. Bibliography rows touched (a new paper found → an entry marked *listing only*; a theorem found to be prior art → the held
   paper's row gains "what of ours rests on it"), with `tools/bib_audit.py` green. Stub lines for *stub* kernel decisions go into
   the existing stub file they belong to under a heading "Kernel targets from FS-71", or a new `plans/STUB-*.md` if none fits.

## How to work each theorem (plan §PA.1 and §M — the parts that matter most)

- **Kind before grade.** Is it a theorem at all? A *measurement* (checked on a sample of a general claim), a *reading*, an
  *instance of a held theorem* (name it), a *method rule*, or *kernel already* (the row's) — each goes to the file's section 3 (or
  the census table) and never to § B. A `[tools]` theorem's statement quantifies over exactly what was checked; the general claim
  is a separate reading.
- **The proof address points at a proof, never at an assertion.** If the only places the theorem appears state it, write *not on
  disk — looked in …* and *proof verdict: unsure*; do not repair or invent a proof — every derivation is mine, and *unsure* is
  the right word for "I could not find or follow it". Re-read the proof you do find against its objects (G21): does it use a
  hypothesis narrower than the statement, or prove the statement only for the instance at hand (G30 #6)? Say so in the entry.
- **Prior art, in the discipline's words** (G46, G49): restate the theorem as a graph theorist, a number theorist or a geometer
  would — *Cayley graph*, *unit-distance graph*, *valuation ring*, *ratio bound* — never in this project's coined words ("fan",
  "compulsion", "seam", "field wall" appear in no paper; `BIBLIOGRAPHY.md` § E is the translation table). Check the held
  bibliography first (§ A and § B — name the nearest held paper whether or not it has the theorem; if its row says the relevant
  section is unread, that is a *check owed*, not a zero). Then zbMATH Open, two queries in two disciplines' vocabulary, recorded
  verbatim with hit counts:
  `curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=ab:"unit distance" & ab:"coloring"' --data-urlencode 'results_per_page=50'`
  (fields `ab:`, `ti:`, `au:"Last, First"`, `py:1985-2000`, `cc:05C15`, joined by `&`/`|`; the JSON's `result` is empty and
  `status.nr_total_results` null on no match; a hit's review text is in the JSON, and `editorial_contributions` says whether it is
  a reviewer's review or the author's summary — record which). Verified live today: `ti:"chromatic number" & ab:"additive" &
  ab:"coloring" & py:1985-2000` returns exactly one paper, Zbl 0836.05030.
- **Kernel decision**: *kernel* (the declaration and module, checked with `rg`), *stub* (which stub; add the line), *declined* with
  the reason, or *priced*. "Rests on it" is what decides between declined and stub.
- **Read the final statement aloud** against the sentence in the row or grokking it came from; a mismatch is a finding for the
  report, not something to smooth over.

## Gates and commits

After each milestone filed: `python3 tools/fs71_ledger_b_check.py` (every entry ↔ one § B row; zero warnings on your own
`M<nn>` prefixes — the FS-70 warnings and the placeholder are known), `python3 tools/claude_md_fact_audit.py --base cfc87d40`
(it audits `CLAUDE.md` and `LEDGER.md` as one corpus; a lost token it names must be either restored or explained to me),
`python3 tools/check_architecture.py`, and `python3 tools/bib_audit.py` if you touched the bibliography. **Commit after each
milestone, by explicit path** (`git add plans/M33-derivation.md LEDGER.md data/fs71/batch-1.md …`), never `git add -A`, never
push, never amend; end each message with the trailer `Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>`. Before staging
`LEDGER.md` or `BIBLIOGRAPHY.md`, `git diff -- <path>` and confirm every hunk is yours.

## Acceptance (what I score, plan §S.5)

Every grade-tagged clause of rows 1–33 accounted for (filed or classified with a reason) · every file above in your enumeration
section · every entry with all seven fields, five sampled by me against their sources · every *prior art* and *gap* verdict
checked by me · one theorem re-derived by me from its recorded proof · gates green · commits by path. Budget ~300k tokens; if
you approach it, stop at a milestone boundary and write the progress line. Hand back with the headline: *M17–M36: N theorems filed
in K files, P re-attributed, Q demoted; enumeration complete / stopped at M<nn>.* In your final report, say what (if anything)
you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape in §S fights the material, say
so in "where the brief was wrong" and do what the material needs. Thank you.
