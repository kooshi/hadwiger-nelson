# Brief FS131-E1 — two GAPs in the repaired chain of "maps need six": close each, or exhibit the configuration

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive two fixed questions to a verdict each — excluded (the GAP closed, by a derivation), realized (the configuration exists, exhibited exactly), or a GAP at a named step
  launch: now, beside FS131-I3d (wave 3's implementer) and FS131-W (de Bruijn, formalizing Woodall's chain on its own branch)
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation, a closed GAP the formalizer can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E1-derivation.md`
  touches: `plans/FS131-E1-derivation.md`, `tools/fs131_e1_*.py`, `data/fs131/e1/`, `data/fs131/reports/FS131-E1.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. Formalizing "maps need six" — that every five-colour map of the plane has two points at distance exactly 1 in one open region's colour, almost
everywhere — has stopped at two steps of the argument this project assembled from Woodall and Townsend. De Bruijn's planner on that chain (FS131-W) found
them reading the papers' page images, and wrote each as a self-contained question; you derive them.

## Why this job

`LEDGER.md` row 132 and `CLAUDE.md` § The aim (item 4) record "maps need six" as held at [hand]: `[Woodall1973]` Thm 6 with its step 6 repaired by
Townsend's lemma, and Townsend's 1979 manuscript with its step (c) filled by Woodall's. Route M's reductions toward `χ_m⁰(ℝ²) ≥ 6` use it
(FS111-M-REDUCE-I, FS111-M2-REDUCE-C, FS111-VM2-EQ5, `plans/FS111-derivation.md` lines 208–222 and 618) for exactly the maps route M's regularity produces —
segments and arcs of integer radius, unit arcs included (rows 140–141). So whether these steps close bears on the answer: a closed GAP restores the
chain; a realized configuration would be a five-colour map, almost-everywhere proper, against the printed theorems — a result of the first size, to be
checked to the same standard; a GAP at a named step is a precise open question. Kooshi: *"A proven theorem about why its impossible is also valid. All
novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4).

## The questions

The claim list is `data/fs131/claims-E1.md`, copied verbatim by script from FS131-W's record; read it whole — its common setting defines every term. The two
questions open:

> **Q1 (F1) — step 5 at `φ_b = π/3` exactly.** Is the following configuration excluded? A vertex `P` with consecutive sectors `a, b, c` of distinct colours
> — source: data/fs131/claims-E1.md § The questions

> **Q2 (F2) — step 7's terminal vertex.** Is the following configuration excluded? A vertex `P` with exactly four sectors `a, b, c, d` (colours `A, B, C, D`,
> — source: data/fs131/claims-E1.md § The questions

Status of what each question uses: Lemma (L) is FS106-L, held at [hand] and stated in the kernel (`lemmaL`; inventory item 67: it holds only for a change
point inside the open set — false at a frontier point, an adversary records it); the strict step-4 lemma is FS106-WO's, at [hand]; Townsend's ⅔π
counterexample is in his manuscript. The findings and the formalizer's checks behind each question are inventory items 88 and 91, and FS131-W's record
§ 1.4 on branch `fs131-ww` (`.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md`).

## What you work from

- The papers, in the library: `[Woodall1973]` (`~/source/library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`; read its page images for
  inequality signs — the OCR lost them, which is how F1 hid), `[Townsend1981]` (`~/source/library/papers/townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.pdf`),
  `[Townsend1979ms]` (see `BIBLIOGRAPHY.md`), and **`[Townsend2005]`** with `[Soifer2005Townsend]` (`~/source/library/geombinatorics/geombinatorics-v14-n4-2005-04.pdf`,
  pp. 181–193; notes under `~/source/library/notes/`) — the published version of Townsend's proof, which may treat a corner like Q2's or the borderline of
  Q1 explicitly; read it before deriving. `[Coulson2004]` (`BIBLIOGRAPHY.md` row 137) is the tilings predecessor.
- FS-106's records: `plans/FS106-derivation.md` (FS106-L, -TW, -WO, -AE-MAP6 and the TS entries), `plans/FS106-V-verification.md` (V3), and the maps-six
  argument they cite.

## Done means

1. **The readback** (standing rule 3): both quotations checked against the claim list; each question restated in your record; your expected verdict per
   question with a probability, registered before you derive.
2. **Recognition** (`ephodos-recognition`, fresh), as a saved stage, on each question.
3. **A verdict per question**, as entries in your identity's grammar (the derive gate green before each stage's commit): excluded, with the derivation; or
   realized, with the configuration written exactly and checked by an exact script with a planted fault watched firing (no search: computation checks a
   derived shape); or GAP at a named step, with what would close it.
4. **What each verdict does to the chain**: which of FS106-WO, -AE-MAP6, row 132 and route M's reductions it restores, narrows, or refutes — drafted as the
   corrections owed (the record job and Keryx file them).
5. The report, in standing rule 11's form.

## What is yours to decide

The route, the reading, and the attack. If a question is mis-posed — it assumes something Woodall's normal form does not give, or misses a configuration
the normal form allows — that is a finding. If the published Townsend 2005 already settles a question, say so with its page and passage, and grade it as
read. A step a search could decide is a `search request` in your report, never a run.
