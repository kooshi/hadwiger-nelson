# FS129-IX1 — the index: record

*The Clerk, Sonnet 5.5, 2026-10-03. Brief: `data/fs129/briefs/FS129-IX1-index.md`. Script: `tools/fs129_index.py`. Everything below is read from files by that script or by the commands shown; nothing is judged.*

## Stage 1 — SAVED (readback, script, self-test)

### The readback

The brief's two quotations were checked against their sources by exact substring comparison (read as one line, line breaks joined):

| quotation in the brief | source | result |
|---|---|---|
| Kooshi 2026-10-03, "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." | `plans/STUB-cross-application-audit.md` § The request (line 9) | identical |
| Kooshi's four answers, "1. yes, we don't want O(N^2) here. … so it'll pick up the latest changes." | `plans/FS129-cross-application-audit.md` § 1 (the decisions block) | identical |

No mismatch. One small finding about the brief: it cites the second quotation's source as `§ 1. Kooshi's words`; the section is headed `## 1. Kooshi's words`, so the address is right.

**What `edges.csv` must contain, in my words.** One row per ordered pair (Y, X) of theorems such that X uses Y, so the edge points from the used result to its user (from "what is upstream" to "what is downstream"). A pair is there if X's `uses only:` line names Y (source `uses`), or if Y's "Rests on it" paragraph names X (source `rests`), and `both` if the two records agree. Where one direction says it and the other direction's text exists and omits it, the pair is still an edge (it has one source), and is also listed in `disagreements.md`. Only ids that resolve to an entry make an edge; everything else is in `unresolved.md`.

**What `lean-order.md` must contain.** The theorems whose `handoff:` field names de Bruijn (the results whose next stop is Lean), and every theorem they depend on, directly or through any chain of edges, in one list ordered so that each theorem stands after every theorem it uses. A dependency cycle is printed with its members together and flagged, never silently broken.

### The corpus recount

The plan's § 2 commands, run 2026-10-03 on commit `c791976a6c`'s tree:

| pile | plan's count | recount | note |
|---|---|---|---|
| `ls plans/*-derivation.md \| wc -l` | 99 | 99 | same |
| `awk 'NR>=195' LEDGER.md \| grep -cP '^\s*[-\|]'` | 1,297 | 1,297 | the 1,297 lines are 1,295 theorem rows plus the table's header line and its `---` line; the census finds 1,295 § B rows and 1,295 entries |
| `cat plans/*-derivation.md \| grep -cP '^derivation: '` | 292 | 292 | same; the census reads 292 new-grammar entries in 5 files (FS111, FS114, FS116, FS121, TC1) |
| `grep -oF 'Rests on it' plans/*-derivation.md \| wc -l` | 1,304 | 1,304 | same; in 78 files (`grep -lF`, 78) |
| files with no "Rests on it" | 21 | 21 | same |
| `handoff:` lines naming de Bruijn (the plan's grep) | 77 | 77 | the script's field-based count is 78: see CHECK 1 |
| ledger rows | 148 | 148 | `## A.` has 148 `\| N \|` rows |
| grokkings | G1–G91 | 91 | `^\* \*\*G\d+ — ` headers, G1 to G91 with no gap |
| derivation files holding at least one entry | — | 77 (of 99) | `fs71_ledger_b_check.py`'s census; the other 22 files hold no entry in either grammar |

### Resolution rules and encodings the script fixed (what is mine to decide)

- **An id.** Every entry's id is the census's `full_id` (a name with a hyphen stands as written, a bare one takes the file's prefix). Ids are unique corpus-wide; a duplicate is a failure of the run (exit 1), the first is indexed and the second dropped. The run found none.
- **A token in `uses only:` or a "Rests on it" paragraph resolves** in this order: (1) it is exactly an entry id; (2) `<prefix of the file the text sits in>-<token>` is an entry id (a bare `T3`, `V5-RING`); (3) otherwise it does not resolve. A token that is the tail of some entry id (`C-HULL` for `FS111-C-HULL`) is **not** resolved: choosing it would be a guess, so it is printed beside the token in `unresolved.md` as a "suffix candidate", with every candidate id.
- **What counts as an id-shaped token** for `unresolved.md`: a token beginning with a milestone prefix and a hyphen (`prefixed`); another capitalised hyphenated name (`hyphenated`: claim names, constants, shorthand); a short bare token like `T3`, `R7` (`bare`; `G<n>` excluded); a milestone pointer like `FS-126` (`milestone`). A token that is a file name (ends `.md`, `.py`, …, or follows a `/`) is skipped. Ordinary words never count.
- **Rows and grokkings in `uses only:`** are *not* graph nodes. The numbers after `row`/`rows` are kept in the record's `uses_rows`, the `G<n>` tokens in `uses_grokkings`; the raw text is in `uses_raw`. **Lean declarations**: none occurs in any `uses only:` line (checked: no `Proofs/`, `.lean`, `HadwigerNelson`, `Mathlib`, `Lean` in any), so there is nothing to represent and none is.
- **The "Rests on it" paragraph.** New grammar: the text from the first "Rests on it" in the prose between the entry's block and the next heading or `derivation:` header, to the end of that paragraph (blank line); old grammar: the text of the `*Rests on it:*` field up to the next of the five markers. `rests_form` records `label`; a fallback to the phrase "rests on" with no "it" exists in the script and fired for no entry.
- **Old-format entries** (1,003): `statement` is the text between the header and `*Proof:*`; `title` is the header's title; `grade` is the header's bracket, verbatim (it carries the prover and the verdict words, so `minds` is left empty, never read from it); `verdict` is the `*Proof verdict:*` field; `kernel` is the `*Kernel:*` field; `not_claimed`, `uses_raw`, `handoff` are empty (no such field). `verdict_class` is the verdict's first word lower-cased (old verdicts begin with `closes`, `TRUE`, `the`, …; open-steps takes a class of `gap`, `stalls` or `refuted` only).
- **Era.** M<n> prefixes, and FS<n> with n ≤ 103, are `A`; FS<n> with n ≥ 104 is `R`. A prefix with no number (`ASTRA-2026-09-14`, `MASCOT`, `R52`, `R57`, `R59`, `R88`, `TC1`) is placed by the § B milestone column only if that holds `M<n>` or `FS-<n>`; those columns hold dates, `row 88` or `TC1`, so all of those are `CHECK`. (§ B is one flat table, not sections; the milestone column is the placement it offers.)
- **Citations.** A ledger row cites a theorem when the row's text (§ A) contains its id as a whole token; likewise a grokking's entry text. A theorem *mentions* a grokking when the token `G<n>` is anywhere in its entry text (`mentions_grokkings`); `grokking-uses.md` is built from mentions.
- **Output encodings.** `theorems.jsonl`'s first line is a `{"_header": …}` object and `edges.csv`'s first line begins `#`; consumers skip them. The `.md` files carry the header as an HTML comment on line 1. Extra files beyond the brief's list: `cycles.md` (the dependency cycles), `checks.md` (every CHECK the script raised), `statements-CHECK.md` (the statements of era-CHECK theorems, which the two era files would otherwise drop).

### The tool and its negative controls

`python3 tools/fs129_index.py --self-test` plants, in memory, beside a clean corpus of two new-grammar and two older-grammar entries: an entry with no statement, a `uses only:` id that resolves to nothing, a dependency cycle, an id defined in two files, a header the census rejects, a disagreement, an unplaceable era, the era boundary FS103/FS104, and a cycle among handed-off results. Each plant fires once and for its own reason; the clean corpus is indexed field by field (each field compared with its expected value) with no defect and no unresolved token; exit 0, `RESULT: PASS`.

The test's own sensitivity: six mutants of the script (duplicate-id detection off, cycle detection off two ways, no-statement off, unresolved listing off, census-failure capture off) each made `--self-test` print `False` for the matching plant and exit 1; the mutant files lived in the session scratch directory, not in the repository. The first run of the self-test also caught one flaw in my own plant (an era plant that the planted ledger's milestone column placed after all), fixed in the test, not in the script.

## Stage 2 — SAVED (the run: `data/fs129/index/` written by one run of `python3 tools/fs129_index.py`; exit 0)

The run's own consistency checks, all read from its output files (not from the script's belief): the script's id set equals the census's id set (1,295 = 1,295; a mismatch exits 1 and none occurred); every `edges.csv` endpoint is an entry id; no edge is listed twice; every `uses_ids` / `rests_ids` entry in `theorems.jsonl` has its edge with the right source; `lean-order.md` lists every seed and puts every dependency before its user, with no violation outside a flagged cycle, and no upstream result outside its closure (checked by a second script reading the written files). The files and what each is are in § Files below.

### The counts the run produced

| count | value |
|---|---|
| theorems indexed | 1295 |
| per era (A / R / CHECK) | 770 / 474 / 51 |
| per grammar (older / block) | 1003 / 292 |
| block-format verdicts | derived 267, gap 20, refuted 3, stalls 2 (the plan's 267 derived, 20 gap, 3 refuted, 2 stalls) |
| older-format verdict classes (first word, lower-cased) | closes 719, true 172, the 43, a 10, one 9, not 7, agree 5, gap 5, accept 4, kernel-checked 4, as 3, (empty) 2, false 2, holds 2, kernel 2, no 2, all 1, both 1, certified 1, corrected 1, first 1, l 1, solver 1, step 1, ts 1, v 1, valid 1, x 1 |
| edges (rows of edges.csv) | 1328: rests 931, uses 153, both 244 |
| entries with a resolved `uses only:` id / a Rests-on-it paragraph / a resolved Rests-on-it id | 190 / 1295 / 725 |
| Rests-on-it paragraphs naming no resolvable id (text kept in `rests_text`) | 570 |
| entries naming themselves in their own uses/rests text (self-reference dropped) | 11 |
| disagreements | 257: 104 where A's Rests-on-it names B but B's `uses only:` omits A, 153 where B's `uses only:` names A but A's Rests-on-it paragraph omits B; 39 of them where the omitting side names no id at all |
| unresolved references | 1127: prefixed 57, hyphenated 450, bare 328, milestone pointers 292; 197 of them have a suffix candidate listed |
| orphans (nothing uses them) | 563 (93 block-format, 470 older) |
| dependency cycles | 45 components, 110 members (`cycles.md`) |
| open steps | 30 entries with verdict class gap/stalls/refuted; lines naming a stall: 12; capital GAP: 372; gap in another case: 418 |
| lean-order | 78 seeds, 197 results in the closure (the length of the list), 43 of them members of a flagged cycle |
| grokkings no entry mentions / with an era tie | 2 / 1 |
| ledger rows citing a theorem id (entries with none cited) | 134 entries are cited by at least one row; 1161 are not |
| CHECK lines raised (`checks.md`) | 100 |

### Files

| file | what it is |
|---|---|
| `theorems.jsonl` | one record per theorem (1,295), first line a `_header` object |
| `edges.csv` | `from,to,source`; an edge from a result to each result that uses it; first line begins `#` |
| `disagreements.md` | pairs the `uses only:` and "Rests on it" directions disagree on |
| `unresolved.md` | id-shaped references that resolve to no entry, with addresses and suffix candidates |
| `orphans.md`, `hubs.md` | results nothing uses; results by dependents (top 100) |
| `open-steps.md` | verdict gap/stalls/refuted entries; every "stalls at" and GAP line, with address |
| `grokking-uses.md` | per grokking: mentioning entries, milestones, era by majority |
| `lean-order.md` | the results handed to de Bruijn and everything they rest on, dependencies first |
| `statements-A.md`, `statements-R.md`, `statements-CHECK.md` | one line per theorem, statement cut at 400 characters |
| `cycles.md`, `checks.md` | extra: dependency cycles; every CHECK the script raised |


*Note on the headers: each output file's header names the commit the tree stood at when the script ran (21bf0b1d90, stage 1); the script's last two edits (the CHECK-line aggregation and the handoff wording) were committed together with the data in stage 2, so `git log -- tools/fs129_index.py` is the exact script. Re-running `python3 tools/fs129_index.py` rewrites every file; the self-test is `python3 tools/fs129_index.py --self-test`.*

## Stage 3 — SAVED (five records by chance, beside their sources)

**How chosen.** `random.Random(1791068007).sample(records, 5)` over the records of `theorems.jsonl` in file order (sorted by id); the seed is `date +%s` read at the moment of choosing. Each is shown below as the index holds it (statement and long fields cut at 300 characters here only), then the source lines it was read from, copied by script from the derivation file at the stated line (cut at 300 characters per line, at most 26 lines; the cut is marked `⟨cut⟩`).

### FS121-Z1-NOCURVED — plans/FS121-derivation.md:1167 — new grammar, era R

Index record:

- `milestone`: 144
- `era_how`: prefix FS121
- `title`: (empty)
- `statement`: if no honest saturated colouring in D-NF satisfying REG-J′ has a tangent-type interface arc of finite radius at least 2, then in every such colouring no (R2) arc occurs (so C121-R2-FOUR holds vacuously), ¬LRA holds, and every curved interface is a split unit arc of kind both
- `not_claimed`: the hypothesis (C121-CURVED's negation with cusps allowed, open); anything about REG-J′ itself or about honest saturation at six
- `grade`: derived from: FS121-O1-OUT, FS121-D2-INCURVED
- `minds`: 1
- `verdict`: derived
- `verdict_class`: derived
- `uses_raw`: FS121-O1-OUT (an (R2) arc's outward parallel is a tangent-type arc of radius 2); FS121-D2-INCURVED; FS111-M-C11 (iii)
- `uses_ids`: ['FS121-O1-OUT', 'FS121-D2-INCURVED', 'FS111-M-C11']
- `uses_rows`: (empty)
- `uses_grokkings`: (empty)
- `rests_text`: Rests on it: FS-126's frame; the observation (`FS121-Z1-close.md` § 2.5) that three of the milestone's six open claims are one question.
- `rests_ids`: (empty)
- `handoff`: none — the frame of stub FS-126, not a statement a proof consumes yet
- `kernel`: (empty)
- `ledger_rows`: [144]
- `grokkings`: [88]
- `mentions_grokkings`: (empty)
- `n_dependents_direct`: 0
- `n_dependents_transitive`: 0
- `check`: (empty)

Source, plans/FS121-derivation.md from line 1167:

```text
derivation: FS121-Z1-NOCURVED
  statement: if no honest saturated colouring in D-NF satisfying REG-J′ has a tangent-type interface arc of finite radius at least 2, then in every such
    colouring no (R2) arc occurs (so C121-R2-FOUR holds vacuously), ¬LRA holds, and every curved interface is a split unit arc of kind both
  uses only: FS121-O1-OUT (an (R2) arc's outward parallel is a tangent-type arc of radius 2); FS121-D2-INCURVED; FS111-M-C11 (iii)
  not claimed: the hypothesis (C121-CURVED's negation with cusps allowed, open); anything about REG-J′ itself or about honest saturation at six
  argument: § The close's composition (FS121-Z1)
  verdict: derived
  grade: derived from: FS121-O1-OUT, FS121-D2-INCURVED
  minds: 1
  model: k = 7: R7; k = 9: SQ9 and HEX9 (each meets the hypothesis and the conclusion)
  prior art: partly: D2 § 3.3 records that an obstruction to curved tangent interfaces decides C121-NOLRA; the (R2) half and the composition not found
  handoff: none — the frame of stub FS-126, not a statement a proof consumes yet

Rests on it: FS-126's frame; the observation (`FS121-Z1-close.md` § 2.5) that three of the milestone's six open claims are one question.

```

### R88-TA2 — plans/R88-derivation.md:74 — old grammar, era CHECK

Index record:

- `milestone`: row 88
- `era_how`: prefix `R88` carries no milestone number and § B's milestone column reads `row 88`
- `title`: A FALSE for T-B1 or for T-B2 exhibits a four-colouring outside Pull, so `F(R) = 0`: either counterexample answers row 88 "no". (= J28D T-A2, L-A2; J28V-8 (B2-b), J28V-9 (B1-b).)
- `statement`: Non-pullbacks converging to `p` cannot lie in the finite Pull (a convergent sequence there is eventually constant); a sparse defect `D` against `p` cannot come from `c ∈ Pull`, since two pullbacks differ on a union of `R ∩ 𝔓⁴`-cosets. **Consequence for the plan's §P:** its FALSE prices for P-TB1 and⟨cut⟩
- `not_claimed`: (empty)
- `grade`: hand; two derivations, J28D and J28V blind
- `minds`: (empty)
- `verdict`: closes.
- `verdict_class`: closes
- `uses_raw`: (empty)
- `uses_ids`: (empty)
- `uses_rows`: (empty)
- `uses_grokkings`: (empty)
- `rests_text`: the §P coherence note; the reading of T-B1 and T-B2 as no easier than row 88 on the "no" side.
- `rests_ids`: (empty)
- `handoff`: (empty)
- `kernel`: declined (elementary; no consumer).
- `ledger_rows`: (empty)
- `grokkings`: (empty)
- `mentions_grokkings`: (empty)
- `n_dependents_direct`: 0
- `n_dependents_transitive`: 0
- `check`: ["era: prefix `R88` carries no milestone number and § B's milestone column reads `row 88`"]

Source, plans/R88-derivation.md from line 74:

```text
**R88-TA2 — A FALSE for T-B1 or for T-B2 exhibits a four-colouring outside Pull, so `F(R) = 0`: either counterexample answers row 88 "no". (= J28D T-A2, L-A2; J28V-8 (B2-b), J28V-9 (B1-b).) [hand; two derivations, J28D and J28V blind]**
Non-pullbacks converging to `p` cannot lie in the finite Pull (a convergent sequence there is eventually constant); a sparse defect `D` against `p`
cannot come from `c ∈ Pull`, since two pullbacks differ on a union of `R ∩ 𝔓⁴`-cosets. **Consequence for the plan's §P:** its FALSE prices for
P-TB1 and P-TB2 (0.10, 0.15) were incoherent with P-decide "no" (0.02) — flagged by J28D §1.2, made again in J28V's own C0 (J28V §4 row V7).
*Proof:* J28D §Stage 2 "T-A2"; J28V §2.4 (B2-b), §2.5 (B1-b). *Proof verdict:* closes. *Rests on it:* the §P coherence note; the reading of
T-B1 and T-B2 as no easier than row 88 on the "no" side. *Prior art:* not gated (elementary). *Kernel:* declined (elementary; no consumer).

## §2. Theorem C over the real fields, and its type-(A) form

**R88-TC — Theorem C over the real fields of S2: every translation-invariant Borel probability measure on `X₄(F)` whose spectral measure is carried by `T + A + Fin_S`, for a finite set `S` of split places, is carried by Pull; the real place enters only as an input, through `m₁(ℝ²) ≤ 0.2470 < 1/4`. (⟨cut⟩
**Scope, exactly.** J28D proves the class form — "`F` real; one stable place `𝔓` whose tower is row 67's (tight at four colours at every level,
every minimiser killing `𝔓⁴`); every other stable place of all-levels ratio `< 1/4` (this is S2); `S` a finite set of split places" (J28D §3.2
TC-class). J28V proves it over the three type-(B) fields (J28V-4) and records at its stage 5, row V11: "J28D's statement is the wider one, and my
route reaches it unchanged" — a verifier's reading from J28D's statement, not a blind derivation of the class form. **Inputs** (the grade line both
records give): C14.1–C14.3 and C14.2 (a)–(c) (window lemmas, two derivations at FS-86); `[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`; external,
computer-assisted; its certificate re-checked, cert + hand, `m₁(ℝ²) ≤ 0.246989`: exact on H1–H3 and H6 by J26,
`plans/PA-ambrus2023-audit.md`, ball arithmetic on H4 and H5 by J49, `plans/FS100-KT1-ambrus-ball.md`); FS-66's certificates at 11 (ℚ(√59)) and 19 (ℚ(√83), ℚ(√131));
Lemmas D and P; FS38-D2-A/B; V3ram; VC-C2; weak and strong approximation; and, in J28D, Lemma R (b) (or J07's Lemma C), Bochner, Doob–Cohn and
Lebesgue differentiation on doubling spaces. **Not used:** J21-MX, J21-RED, V3, C14's main count or C14′ as black boxes (J28D §3.1: C14 reads
`𝔓` at finite level only and C14′'s conull-`Ω` format is not the edge-a.e. format a random extension produces; J21-MX selects a colouring of the
other factors and says nothing about `c`). **Two routes** (J28V §Stage 5, rows V12–V16): both extend the colouring to `G_S` (R88-TC-ext), make it
a.e.-proper, split off the finitely many Hoffman-failing stable places (11 or 19) with the real places and `S` into a factor `X` of ratio `< 1/4`,
count against a compact tight factor, and propagate by gap-freeness. J28D absorbs every other stable place into the tight factor (R88-TC-Yp),
regularises only inside `X` (R88-TC-reg), counts stationarily from the start (R88-TC-count) and returns to `R` by `C(δ) = 1` on `R ∩ 𝔓⁴`; J28V keeps
those places as one compact tail factor (R88-J28V-3), regularises on all of `G_S` to a conull `Ω` (R88-J28V-2), counts samplewise and then uses
stationarity, and returns to `R` by continuity of `h ↦ P(G(h) = γ(π₄h))`. "Neither uses the other's new steps"; they share the architecture and every
```

### FS111-M2-DISCK7 — plans/FS111-derivation.md:1045 — new grammar, era R

Index record:

- `milestone`: row 140
- `era_how`: prefix FS111
- `title`: (empty)
- `statement`: translates of the smooth non-circular body K of constant width 1 with support function 1/2 + sin³(3θ)/200, placed at the colour lattices of the hexagonal seven-colouring oriented so that the hexagons' vertices lie in the directions where sin 3θ = 0, form a regular maximal seven-cover with a locally ⟨cut⟩
- `not_claimed`: the same at M2 §1.6's lattice with vertices at 30° + 60k (FALSE: FS111-M2-DISCK7-AS-PLACED)
- `grade`: computed over: one period of the hexagonal lattice, 7 bodies, exact (sympy and rational bounds)
- `minds`: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2's hand argument and body checks, VM2's exact rebuild in the corrected orientation
- `verdict`: derived
- `verdict_class`: derived
- `uses_raw`: constant width 1 (identically); radius of curvature in [37/100, 63/100]; K passes through every hexagon vertex in this orientation; same-colour bodies more than 1 apart; every point within 1 of every colour (maximal); exact arithmetic (sympy and rationals)
- `uses_ids`: (empty)
- `uses_rows`: (empty)
- `uses_grokkings`: (empty)
- `rests_text`: Rests on it: NO-PAR's place in FS-121 (the cover route at six needs a NO larger than Q-NO).
- `rests_ids`: (empty)
- `handoff`: none — a counterexample to a universal form; exact and periodic, formalizable on demand
- `kernel`: (empty)
- `ledger_rows`: (empty)
- `grokkings`: (empty)
- `mentions_grokkings`: (empty)
- `n_dependents_direct`: 0
- `n_dependents_transitive`: 0
- `check`: (empty)

Source, plans/FS111-derivation.md from line 1045:

```text
derivation: FS111-M2-DISCK7
  statement: translates of the smooth non-circular body K of constant width 1 with support function 1/2 + sin³(3θ)/200, placed at the colour lattices
    of the hexagonal seven-colouring oriented so that the hexagons' vertices lie in the directions where sin 3θ = 0, form a regular maximal seven-cover
    with a locally finite arrangement; so the cover form of REG-A is FALSE at seven, and on the cover route the NO at six must cover self-parallel curved
    boundaries (NO-PAR)
  uses only: constant width 1 (identically); radius of curvature in [37/100, 63/100]; K passes through every hexagon vertex in this orientation;
    same-colour bodies more than 1 apart; every point within 1 of every colour (maximal); exact arithmetic (sympy and rationals)
  not claimed: the same at M2 §1.6's lattice with vertices at 30° + 60k (FALSE: FS111-M2-DISCK7-AS-PLACED)
  argument: FS111-VM2-verification.md § 1.3
  verdict: derived
  grade: computed over: one period of the hexagonal lattice, 7 bodies, exact (sympy and rational bounds)
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2's hand argument and body checks, VM2's exact rebuild in the corrected
    orientation
  model: the corrected DISCK7 itself
  prior art: partly: bodies of constant width and coverings are classical; this cover not found — “constant width & cover* & (unit distance |
    chromatic)” (1)
  handoff: none — a counterexample to a universal form; exact and periodic, formalizable on demand

Rests on it: NO-PAR's place in FS-121 (the cover route at six needs a NO larger than Q-NO).

control: FS111-M2-DISCK7-ORIENT
  of: FS111-M2-DISCK7 — the checks pass in the corrected orientation and fail at the record's lattice (vertices at 30° + 60k), where a tiling vertex is
    uncovered
  run: python3 ../tools/fs111_vm2_disc7.py 2>&1 | tail -1
  expect: ALL PASS (plant = None)
  fault: python3 ../tools/fs111_vm2_disc7.py --object disck7-m2 2>&1 | tail -1
```

### M48-T1 — plans/M48-derivation.md:12 — old grammar, era A

Index record:

- `milestone`: M48
- `era_how`: prefix M48
- `title`: No arity-3 pigeonhole exists in the hex-shell's own distance vocabulary
- `statement`: A point set all of whose mutual distances lie in `{1, √3, 2}` has diameter `≤ 2` and minimum distance `≥ 1`, hence (Jung's theorem bounding it in a closed disc of radius `≤ 2/√3`, then a disjoint-open-disc packing argument: the `n` disjoint open discs of radius `1/2` about the points all lie in a di⟨cut⟩
- `not_claimed`: (empty)
- `grade`: hand; the M48 implementer
- `minds`: (empty)
- `verdict`: closes (both steps are standard and stated in full; the arithmetic `4(2/√3+1/2)² ≈ 10.95` is a direct computation).
- `verdict_class`: closes
- `uses_raw`: (empty)
- `uses_ids`: (empty)
- `uses_rows`: (empty)
- `uses_grokkings`: (empty)
- `rests_text`: §0c's registered interpretation clause, honoured at the close — "a compulsion found at arity 3 from below is a statement about mechanism... and NOT a rung toward χ(ℝ²) ≥ 6" — which is exactly how M45's arity-3 compulsions (`plans/M45- derivation.md` T1, on a *different*, richer-vocabulary stage) and⟨cut⟩
- `rests_ids`: (empty)
- `handoff`: (empty)
- `kernel`: declined — no module states this bound; it functions as an interpretive guardrail for arity-3 findings (M45, and this milestone's own §R), never as a hypothesis or conclusion any Lean statement needs.
- `ledger_rows`: [77]
- `grokkings`: (empty)
- `mentions_grokkings`: (empty)
- `n_dependents_direct`: 0
- `n_dependents_transitive`: 0
- `check`: (empty)

Source, plans/M48-derivation.md from line 12:

```text
**M48-T1 — No arity-3 pigeonhole exists in the hex-shell's own distance vocabulary. [hand; the M48 implementer]**
A point set all of whose mutual distances lie in `{1, √3, 2}` has diameter `≤ 2` and minimum distance `≥ 1`, hence
(Jung's theorem bounding it in a closed disc of radius `≤ 2/√3`, then a disjoint-open-disc packing argument: the
`n` disjoint open discs of radius `1/2` about the points all lie in a disc of radius `2/√3 + 1/2`, so by area
`n·(1/2)² ≤ (2/√3+1/2)²`) **at most `⌊4(2/√3+1/2)²⌋ = 10` points**. Since forcing a monochromatic *triple* by
pigeonhole at five colours needs `⌈n/5⌉ ≥ 3`, i.e. `n ≥ 11`, **no configuration drawn from `{1, √3, 2}` alone can
force a monochromatic triple at five colours by counting** — an arity-3 analogue of the hex-shell's Act One (which
uses `n = 7 ≥ 6` for a pair) cannot exist in this vocabulary. Widening to diameter `3` (radicands `4·7−1 = 27`,
`4·9−1 = 35`, neither a square, hence non-spindleable) admits up to `19` points, still short of the growth the kill
burden would need. *Proof:* `plans/M48-from-below-arity.md` §0a D2, a complete two-step argument (Jung's theorem,
textbook; a disjoint-disc packing/area comparison, elementary). *Proof verdict:* closes (both steps are standard
and stated in full; the arithmetic `4(2/√3+1/2)² ≈ 10.95` is a direct computation). *Rests on it:* §0c's registered
interpretation clause, honoured at the close — "a compulsion found at arity 3 from below is a statement about
mechanism... and NOT a rung toward χ(ℝ²) ≥ 6" — which is exactly how M45's arity-3 compulsions (`plans/M45-
derivation.md` T1, on a *different*, richer-vocabulary stage) and this milestone's own arity-3/4 zeros on the 1581
were read; without D2 a from-below arity-3 hit could have been mis-sold as a second route to the from-below reduction
D1 formalizes. *Prior art:* Jung's theorem (covering radius of a bounded-diameter set) is textbook convex geometry,
not itself cited here; the disjoint-disc packing bound on a bounded-diameter, bounded-minimum-distance point set is
a standard technique (a relative of the kissing-number / sphere-packing family of arguments), not searched as a
citable source for this exact application. zbMATH: `ti:"Jung theorem" & ab:"packing" & ab:"pigeonhole"` (0 hits,
2026-09-22), `ab:"monochromatic" & ab:"diameter" & ab:"pigeonhole" & ab:"coloring"` (0 hits). Nearest held key: none
on point. *Kernel:* declined — no module states this bound; it functions as an interpretive guardrail for arity-3
findings (M45, and this milestone's own §R), never as a hypothesis or conclusion any Lean statement needs.

## Readings and measurements that were called theorems

```

### FS67-DC1 — plans/FS67-derivation.md:99 — old grammar, era A

Index record:

- `milestone`: FS-67
- `era_how`: prefix FS67
- `title`: DC-1 (= J27D #8, J27V-T7): "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H` is pulled back from `G`"; for 1-walk-regular `G`, `χv(G) = k` ⟺ `G` is Hoffman-tight at `k` (GRR2017 Thm 4.9, external), so DC-1 reads "1-walk-regul⟨cut⟩
- `statement`: (empty)
- `not_claimed`: (empty)
- `grade`: hand, conditional on GodsilEtAl2020 Results 1 and 4 with its §1.2 (J27D) or Thm 4.16(1) (J27V), external, read; two blind derivations
- `minds`: (empty)
- `verdict`: closes, twice, given the external input; finite graphs (GRRSV's SDP setting). *Reach:* `χv(H) ≤ χ_f(H)`, so DC-1 never sees the gap `χ_f(H) ≤ k < χ(H)`; it needs no vertex-transitivity of `H`, unlike `[Zhang2012]` Thm 1.8 (i) (J27D).
- `verdict_class`: closes
- `uses_raw`: (empty)
- `uses_ids`: (empty)
- `uses_rows`: (empty)
- `uses_grokkings`: (empty)
- `rests_text`: FS67-DD2N (the 1-walk-regular negation); FS67-DC3's `Y` column; FS67-DB2's consumer sentence (every tight 3-adic level against every `H` with `χv(H) > 3`).
- `rests_ids`: ['FS67-DD2N', 'FS67-DC3', 'FS67-DB2']
- `handoff`: (empty)
- `kernel`: declined — rests on semidefinite duality results [external].
- `ledger_rows`: [115]
- `grokkings`: (empty)
- `mentions_grokkings`: (empty)
- `n_dependents_direct`: 3
- `n_dependents_transitive`: 5
- `check`: ['older entry: no text between the header and *Proof:*; statement left empty']

Source, plans/FS67-derivation.md from line 99:

```text
**FS67-DC1 — DC-1 (= J27D #8, J27V-T7): "If `G` is 1-walk-regular with `χv(G) = k` and `H` is connected with `χv(H) > k`, then every proper `k`-colouring of `G × H` is pulled back from `G`"; for 1-walk-regular `G`, `χv(G) = k` ⟺ `G` is Hoffman-tight at `k` (GRR2017 Thm 4.9, external), so DC-1 reads ⟨cut⟩
*Proof:* J27D §Stage 3 "DC-1" (the simplex vector colouring is optimal by Result 1; Result 4 makes its Gram matrix induced by `G`; unit vectors
with inner product 1 coincide); J27V §2.7 (the same colouring in GEA's normalisation; Thm 4.16(1)). *Proof verdict:* closes, twice, given the
external input; finite graphs (GRRSV's SDP setting). *Reach:* `χv(H) ≤ χ_f(H)`, so DC-1 never sees the gap `χ_f(H) ≤ k < χ(H)`; it needs no
vertex-transitivity of `H`, unlike `[Zhang2012]` Thm 1.8 (i) (J27D). *Rests on it:* FS67-DD2N (the 1-walk-regular negation); FS67-DC3's `Y`
column; FS67-DB2's consumer sentence (every tight 3-adic level against every `H` with `χv(H) > 3`). *Prior art:* J40, `plans/FS67-PA-close.md` Stage 3: "**partly in print**: the vector statement is `[GodsilEtAl2020]` **Thm 4.16(1)**" … "**the integral corollary is not stated** in GRRSV" (nor in its ⟨cut⟩
declined — rests on semidefinite duality results [external].

**FS67-DC2 — DC-2 at Pak–Vilenchik's threshold (= J27D #10 with #9's steps, J27V-T8): "If `G` is connected and `k`-gap-free, and `H = Cay(A, T)` for a finite abelian group `A` with `λ* = max_{χ ≠ 1} |Σ_{t ∈ T} χ(t)|/|T| < τ_k`, then every proper `k`-colouring of `G × H` is pulled back from `G`", wit⟨cut⟩
*Proof:* J27D §Stage 3 "DC-2": (M) mixing, `r(m_c(x))·r(m_c(y)) ≤ λ*²` for `x ∼ y`, `r(μ) = μ/(1−μ)`; (P) the plurality colouring is proper, hence
gap-free; (B) the bootstrap `e ↦ F(e) = se/(1 − (k−1−s)e)`, `s = (k−1)λ*²`, with `e* − e₀ = (1 − (k−1)s)/((1+s)(k−1−s))` positive iff `λ* < 1/(k−1)`.
J27V §2.8: the same bootstrap from J21-MX's threshold selection, `F(ε)/ε < 1` ⟺ `((k−1)λ* − 1)(λ* + 1) < 0`. Checks `tools/crunch_j27d_dc.py`
part A → `data/fs67/j27d/dc.out`: both identities reduce to 0 in sympy; exact rational iteration at `λ* = 1/(k−1) ∓ 1/1000`, `k = 3, 4, 5, 8`,
descends below the threshold (`e₄₀ ≤ 5·10⁻¹¹`) and does not start above it. *Proof verdict:* closes, twice. `H`'s connectivity,
non-bipartiteness and `χ(H) > k` are consequences of `λ* < 1/(k−1)`, not hypotheses (both records). With `A` compact abelian and `β` measurable the
conclusion holds almost everywhere on each fibre (J27D, one mind, a remark). *Rests on it:* FS67-DC2S; FS67-DC3's reading; FS67-DD2N (the
abelian-Cayley negation); the drafted `CLAUDE.md` G54 line and G61 (3) edit (the 11 half). *Prior art:* J40, `plans/FS67-PA-close.md` Stage 3: "**partly in print**: the case `G = K_k` is `[PakVilenchik2013]` Thm 3" (for every `r`-regular `H`, not only Cayley); "**Arbitrary gap-free `G`: not found by⟨cut⟩
(no consumer in the kernel; the gate first); a candidate in this finite form (Parseval on a finite abelian group and a contraction).

**FS67-DC2S — DC-2's constant is sharp for the claim (J27V's addition, §2.8, §4.2): `H = K_k = Cay(ℤ/k, ℤ/k ∖ 0)` has `λ* = 1/(k−1)` exactly, and `(x, a) ↦ a` is a proper `k`-colouring of `G × K_k` not pulled back from `G`; so no `τ_k > 1/(k−1)` makes DC-2 true. [hand, one mind (J27V); J27D showed o⟨cut⟩
*Proof:* J27V §2.8 "Sharpness". *Proof verdict:* closes (one line: `λ*(K_k) = |−1|/(k−1)`; the colouring ignores `G`). *Rests on it:* the
drafted ledger row's "sharp". *Prior art:* not gated by J40 (not in its list); the `K_n` case of the mixing selection is Burr–Erdős–Lovász (`[Tardif2008]` Thm 3.2), as M3-J21-MX records. *Kernel:* declined (a two-line remark; no consumer).

**FS67-DC3 — DC-3, the residue planes as `H` (= J27D #11; three rows re-computed by J27V): among `Γ_p = UD(𝔽_p, 2)` for primes `p ≡ 3 (mod 4)`, `p ≤ 103`, DC-1's and DC-2's hypotheses on `H` hold together at `k = 3` from `p = 11`, at `k = 4` from `p = 23` (at 31 by `1/3 − λ* = 4.88·10⁻⁶`), at `k = 5⟨cut⟩
*Proof:* J27D §Stage 3 "DC-3" and `data/fs67/j27d/dc.out` part B (controls: `λ_min/d = −1/2` at 3; `λ_min + d/3 = 1.5617·10⁻⁴` at 31, G54's number;
plant, one antipodal pair dropped from every circle, fires at the 31 control); J27V §4.3, `tools/crunch_j27v_dc3.py` → `data/fs67/j27v/dc3.out`
```

## Theorems this phase proved

none — a mechanical job

## Held for the coordinator: every CHECK

CHECK 1 (seeds, 78 against the plan's 77): the plan's count is of `handoff:` lines that name de Bruijn; the script reads the field. The field of FS116-Y4-SPOKE (`plans/FS116-derivation.md`, handoff at line 1661) begins `none` and names de Bruijn on its continuation line (", after its blind check, a candidate for de Bruijn"); the script counts it as a seed and flags it in `lean-order.md` and in its record's `check`. Two more seeds, TC1-SQRT3-DYADIC and TC1-STANDING-FIVE, and FS116-Y4-SPOKE all have a handoff that begins `none` yet names de Bruijn: whether a result handed off as `none` belongs in the Lean order is a judgement for the coordinator. Drop them by deleting the three ids from the seeds, or keep.

CHECK 2 (era, 51 theorems): placed `CHECK` because the file prefix carries no milestone number and § B's milestone column holds a date or `row 88` or `TC1`: R88 (19), MASCOT (11), ASTRA-2026-09-14 (10), TC1 (4), R52 (4), R59 (2), R57 (1). They are in `statements-CHECK.md`, and in neither era's file; nothing about their era is claimed. (R88's `row 88` is a ledger-row address, not a milestone; the index does not infer an era from a row number.)

CHECK 3 (statements, 497 older-format entries): no text stands between the header and `*Proof:*`, so `statement` is empty. The statement, if there is one, is the header's own title (kept in `title`, and printed after `[title only, statement empty]` in `statements-*.md`). By file: FS100 57, FS112 56, FS89 51, FS110 49, FS106 46, M3 41, FS86 35, FS103 33, FS91 29, FS67 20, FS105 19, FS107 16, M2 12, FS85 12, FS79 8, FS75 7, R88 6. Not filled from the title: that is a judgement about what the title is.

CHECK 4 (older verdicts and open steps): older-format `*Proof verdict:*` fields begin with `closes` (719), `TRUE` (172) or a sentence word (`the` 43, `a` 10, `one` 9, `not` 7, …, and a letter that starts a symbol); `open-steps.md` § 1 takes an older entry only when its first word is `gap` (5 entries) — an older verdict that says "GAP" or "FALSE" later in the text is caught only by the line scans (§§ 2–4), and two older verdicts begin `false`, not counted as open. Two older entries have no verdict field at all (their `check` lists it).

CHECK 5 (dependency cycles, 45 components, 110 members): the three I opened (ASTRA-2026-09-14-T5/T6, FS100-K0/MR, FS106-EQ/SUP) are pairs whose two "Rests on it" paragraphs name each other; I did not open the other 42; `lean-order.md` lists the 43 cyclic members inside its closure together and flagged, not broken. Whether a mutual mention is a mathematical cycle or loose language is not the Clerk's to say. `cycles.md` has the members.

CHECK 6 (the graph is sparse and this is the format): 570 "Rests on it" paragraphs name no resolvable id (what they contain instead was not classified); the older format has no `uses only:` field at all, so an older result's upstream edges come only from other entries' Rests-on-it text. So the 563 orphans, 470 of them older-format, mean "no id-naming record points here", not "unused". Hub counts understate the older results' reach for the same reason.

CHECK 7 (unresolved, 1,127 references): 57 `prefixed` tokens (begin with a milestone prefix and a hyphen yet match no entry; the cause of each was not examined; 22 derivation files hold no entry at all, listed in CHECK 8), 450 `hyphenated` (claim names such as `C121-ENDS`, constants, shorthand), 328 `bare`, 292 milestone pointers like `FS-126`. 197 have a suffix candidate (`C-HULL` for `FS111-C-HULL`, `A2` for `FS85-A2`/`FS86-A2`); none was resolved, because choosing is a guess. The suffix candidates are the first thing for a reader to read.

CHECK 8 (22 derivation files hold no entry in either grammar): FS100-J51D, FS100-X01D, FS100-X02D, FS100-X03D, FS100-X12B, FS100-X21D, FS100-X22D, FS100-X23D, FS100-X25B, FS100-X26B, FS100-X27D, FS100-X28D, FS103-M, FS105-B, FS106-TQ, FS106-TS, FS67-J27D, FS84-S1, FS84-SI-D, FS86-R88-D, FS89-S1D, M37 (all `plans/<name>-derivation.md`). Their theorems, if any, are not in the index; the census (`tools/fs71_ledger_b_check.py`) does not read them either. Whether they are job-level files whose theorems live in the milestone's own derivation file I did not check (not asked).

CHECK 9 (disagreements, 257): listed in `disagreements.md`, each with both addresses; 39 are cases where the omitting side names no id at all (so "omits" is weak there). Whether a disagreement is a missing edge or a loose phrase is for the reader. Edges are kept either way.

CHECK 10 (what is not an edge): the `grade:` field of a derived block-format entry can name entries ("derived from: FS121-O1-OUT, FS121-D2-INCURVED"). The brief names `uses only:` and "Rests on it" as the two sources, so grade-field ids are not read as edges. Three entries have a grade naming an entry id absent from their `uses only:`: FS111-M2-NOSEL, FS111-M4-CUT, FS111-W-FILL-FREE. Also not read: `converse:`, `argument:`, `model:`, `prior art:`, `not claimed:` (ids in `not claimed:` are things the entry does not claim, so would be a wrong edge).

CHECK 11 (grokking mentions): G87 and G88 are mentioned by no entry; G80 is mentioned by two entries, one in each era (tie, `CHECK` in `grokking-uses.md`). A "mention" is the token `G<n>` in an entry's text; a graph named G1 would count, so the counts are upper bounds. The grokkings file's own header says "G1 to G87" in its description while the file holds G1–G91 (not mine to edit; a defect in `.claude/skills/grokkings/SKILL.md`'s front matter).

CHECK 12 (the brief and the plan): the plan's § 2 calls LEDGER § B "1,297 lines"; the table holds 1,295 rows, the other two lines being the header and the `---` line (§ B's own header text says 254 entries in 53 files for the M17–FS-66 backfill, a different number).

CHECK 13 (declared non-entry): `M53-derivation.md` has a header that declares itself "NOT given a fresh id" (Proposition 6.4); the census notes it and does not count it, so neither does the index.

CHECK 14 (the era of `FS105`): the script puts FS105 in era R by its number (105 ≥ 104), as the plan's § 5 says ("by milestone number"); its § B milestone column holds ledger-row addresses (rows 120, 128, 129). Flagged only so the coordinator can say whether the number or something else decides.

## Search requests, prior-art debts, bibliography

none.

## Stage 4 — SAVED (the amendment of 2026-10-03 23:00 UTC: roots, grade edges, FS100-TCA, eras, the files with no entry)

Brief amendment read at commit 7d097195. Re-run: `python3 tools/fs129_index.py` (exit 0) after `--self-test` (exit 0, 16 checks). This stage supersedes the Stage 2 counts and CHECK list where it says so; the Stage 3 spot-check records stay as they were chosen (they were read before the changes, and FS100-TCA, the coordinator's failing record, is the item-3 fix below).

1. **Roots.** `depth_down` and `depth_up` are in every record of `theorems.jsonl` (header says: longest chains on `edges.csv` with each dependency cycle condensed to one node). `roots.md`: top 100 by `depth_down`, ties by transitive dependents then id, each with direct count, transitive count, `depth_up`, address, and one longest chain written out id by id (`{a|b}` for a condensed cycle); the header states that older-format edges come from prose, so every depth is a lower bound. Result: the longest chain of dependents has 13 edges, starting at FS111-V0-ID1 (3 direct dependents, 84 transitive) and FS111-C-HULL-SO (1 direct, 78 transitive), and ending at FS121-Z1-NOCURVED; 6 results have `depth_down` ≥ 10 (FS111-V0-ID1 and FS111-C-HULL-SO at 13, FS111-C-HULL 12, FS111-M-HULL2 11, FS111-M-PINCH and FS121-D4-HOLE 10). The histogram of `depth_down` (0: 594, 1: 242, 2: 149, 3: 103, 4: 83, 5: 48, 6: 31, 7: 22, 8: 11, 9: 6, 10: 2, 11: 1, 12: 1, 13: 2) is in the run's output; 607 results rest on something (`depth_up` > 0), the longest upstream chain being 13.
2. **Grade edges.** A `derived from:` grade names its ids; each is an edge from the named result to the entry carrying the grade, source `grade`. Source labels in `edges.csv` are now: `uses`, `rests`, `both` (= uses and rests, as before), `grade`, and `+` joins when grade is among them (`grade+uses`, `grade+rests`, `grade+rests+uses`). Counts: 1,330 rows — rests 929, uses 125, both 94, grade 2, grade+uses 28, grade+rests 2, grade+rests+uses 150; 182 rows carry a grade source: 150 also come from uses and rests, 28 from uses, 2 from rests, and 2 from the grade alone (the only new edges). Disagreements (still 257: 104 and 153) are computed on the two prose directions only; a grade source takes no part. `grade_ids` is a field of each record. Hubs, cycles (still 45 components, 110 members), orphans (563) and lean-order (78 seeds, 197 in the closure, 43 cyclic members) were recomputed on the new edge set.
3. **FS100-TCA and `*Also:*`.** An older entry whose body opens with `*Also:*` now has an empty `statement` (the statement is the header's title, as for the other older entries with none): FS100-TCA's statement is `''` and its `title` begins "R88-TCA@∅ in every degree". Empty older statements are therefore 498 (the 497 and TCA). `checks.md` § `*Also:*` lists every `*Also:*` clause in an older entry, with address and the ids it names: FS100-TCA at `plans/FS100-derivation.md:289` names X25B-PZ and X25B-LP (neither resolves to an entry); M3-J21-D1-43p at `plans/M3-derivation.md:246` names M3-J21-UNIF (resolves to an entry). Two clauses in all.
4. **Eras.** The eight prefixes the coordinator ruled on (ASTRA-2026-09-14, MASCOT, Q8, R52, R57, R59, R88, TC1) are era A with `era_how` = `plans/FS129-close-inventory.md item 11`; FS105 is era R with `era_how` = `… item 12`. Era counts: A 821, R 474, CHECK 0 (the CHECK mechanism stays and is tested). `statements-CHECK.md` is deleted; its lines are in `statements-A.md` (sorted by file and line with the rest).
5. **The 22 files with no entry**: `checks.md` § "The 22 derivation files that define no indexed entry". Rule: an id is defined by a bold entry header, a table row's first cell or a leading bold bullet id under a heading "Theorems this phase proved" / "The theorems". It is looked for, with its job-qualified forms (`J27D-3`, `J27D #3` for a bare number; a bare number alone is never searched, it would match any digit), as a whole token in the text of the indexed entries; aliases such as `(= X23D-TCA)` are tokens there. Result: 230 ids/headers defined in 21 files (M37 defines none), 68 appear in no indexed entry — the finding, listed with addresses first — and 15 appear only as a bare token with no hyphen (listed separately as weak; many are table labels such as `Lemma` or `claim` that the first-cell rule picked up, not ids). Files with no matches at all: FS100-X28D (7 of 7 not found), FS84-S1 (8 of 8), FS84-SI-D (14 of 14); largest unmatched counts elsewhere: FS106-TQ 10, FS100-X27D 6, FS100-X25B 4. Whether any of these is a theorem is not judged.
6. **The 78 seeds stand.** The three `none`-led ones (FS116-Y4-SPOKE, TC1-SQRT3-DYADIC, TC1-STANDING-FIVE) are marked `conditional: handoff begins none` in `lean-order.md`.

**New self-test plants** (all in `--self-test`, which now prints 16 `True` lines and `RESULT: PASS`): depth on a chain with one offshoot (A→B→C→D, B→E: down A 3, B 2, C 1, D 0, E 0; up D 3, E 2; the chain written A, B, C, D), depth with a cycle inside a chain (A→{B,C}→D: A 2, B and C 1, D 0; up D 2; chain `A → {B|C} → D`; exactly one cycle defect), a grade edge, an `*Also:*` opener, a file with no entry (one id found in an entry, one not). Mutants: depth one too long (down and up), cycle condensation off, grade edges off, the `*Also:*` fix off, the appearance test always true — each turned the self-test red (exit 1).

**CHECK list after the amendment** (supersedes Stage 3's where it differs): item 2 (era, 51) closed by ruling; item 3's count is 498 and TCA is fixed; item 8 (the 22 files) is now the list in `checks.md`; item 10 (grade edges) is done; the rest stand as written (the 78-seed note, older verdict classes, cycles, sparse graph for older entries, 1,127 unresolved references — now 1,130 with the grade text read, bare 331 and 199 with a suffix candidate — 257 disagreements, G87/G88/G80, the FS105 note now ruled). New CHECKs: (a) the first-cell rule for defined ids picks table labels (`Lemma`, `claim`, `Haar`, `NR`): they are in the weak list, not mine to filter; (b) depths on older-format graphs are lower bounds (stated in `roots.md`); (c) 2 of the 182 grade-bearing edge rows are edges that no prose direction gives (source `grade` alone); the other 180 also have uses or rests.
