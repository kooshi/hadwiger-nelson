# CLAUDE.md compression — the working record (2026-09-21)

**Task** (Kooshi, via the product-owner session): compress `CLAUDE.md` with the goal of losing no fact, working through the
`prompt-compression` skill's seven steps; use formulas where words are longer; de-duplicate what appears in both the ledger and the
grokkings while keeping the distinction *what we found to be true* (ledger) / *what we have come to understand* (grokkings).

**Starting point:** commit `12ab550d` (`CLAUDE.md` last changed in `d0df4f82`), **242,682 bytes**, 1,685 lines.
**Guard:** `tools/claude_md_fact_audit.py` (built first; `--self-test` plants eight faults). `python3 tools/bib_audit.py` before: 0 / 0
unresolved. **Audit every commit against the starting commit:** `python3 tools/claude_md_fact_audit.py --base 12ab550d`.

## Step 1 — Segment (section · bytes at start · illocutionary force)

| section | bytes | force |
|---|---:|---|
| header ("This workspace") | 1,825 | binding meta-rule (current state only; the byte budget; the PROTECTED rule) — **PROTECTED, untouched** |
| The mission (rungs, target, programme, publication) | 7,721 | context + persona (the target, the programme); binding (publication triggers, the naming ban, the embargo on Theorem B) |
| Frontier intro + "Last updated" | 1,156 | context (what changed last) |
| Where the problem stands | 15,544 | context — orientation for a cold reader |
| The novel-results ledger | 57,390 | reference facts; two binding sub-rules (never renumber; `build/` is provenance, never a certificate) |
| Paths forward, ranked | 14,704 | context + preference (the ranking); binding (Kooshi's sequencing) |
| The open structural question | 733 | context |
| Grokkings | 86,907 | context (understanding); the `[method]` entries G21, G30, G46, G49, G50, G51 are **binding working rules** |
| Whose work this is | 904 | persona + two binding instructions |
| Delegation | 1,590 | binding restriction, counter-prior |
| The standard of evidence | 2,464 | binding, counter-prior |
| What compute actually helps | 945 | context + preference |
| The shape of the proof | 1,191 | context |
| Trust ledger | 1,489 | binding; holds the sentence `scripts/gate_report.py` reads |
| Toolchain | 7,264 | inventory (context) + the symmetry-breaking checklist and the Python 3.14 note (binding, counter-prior) |
| Building | 13,117 | binding, counter-prior; **two PROTECTED regions (5,466 bytes)** |
| The kernel's cost model | 3,062 | measured facts that act as preferences |
| Searching | 1,310 | binding, counter-prior (tool quirks that fail silently) |
| The package | 563 | context |
| The gate | 3,188 | binding |
| Make the gate fail, and watch it fail | 19,553 | binding, counter-prior, every paragraph minted from an incident |

Reference material (mission, Frontier, ledger, paths, grokkings): **185 KB, 76 %**. Method material: **57 KB, 24 %**.

## Step 2 — Cost each rule's grain

* **With-prior — compress hard; the constraint is fact preservation, not adherence.** Everything in the reference material is
  *looked up*, not *obeyed*: a model follows it from one mention. The loss mode is a dropped fact or a fact separated from the
  sentence that gave it meaning, which is what the audit tool and the relocation lists below are for.
* **Counter-prior — compress lightly; keep diagnosis, substitute channel, boundary test, and the identifying details of each
  incident (date, milestone, numbers, instance count).** Every method rule fights a trained attractor: build with the obvious
  command; stop a job by pattern; believe a green check or a clean zero; keep a long run because of hours already spent; bound a run
  with a wall instead of a checkpoint; trust `grep`; start helpers. The `[method]` grokkings belong to this class too.
  The file's header records that trimming one such rule's reasoning once cost hours. **These sections are done last, by sentence-level
  tightening only, and nothing in a PROTECTED region moves.**
* **Continuous-salience rules** (bind on every action, so deliberate redundancy stays): "always `./scripts/build.sh`"; "kill by PID,
  verify by effect"; "never let a pattern that can match the matching shell decide anything"; "no child agent spawns children";
  "state the uninformative outcome and confirm it is reachable". Each is said once in bold where it lives and echoed once where the
  temptation arises; those echoes are retained (listed in § Retained redundancy).

## The duplication map (what is told more than once at the start, and the home chosen)

Rule applied: **numbers, certificates, Lean names, file addresses, prior art and "not claimed" live in the ledger row; mechanism,
reading, killing test and demotion record live in the grokking; "Where the problem stands" orients in two to four lines and points
at both.** A grokking keeps the few numbers its argument needs to be readable where it stands.

| topic | told at the start in | home of the facts | home of the understanding |
|---|---|---|---|
| Theorem B's value and `[Fischer1994]` | § Publication, "prior-art position", row 57, paths FS-20 | row 57 (what he proved, what stays ours) | § Publication (the suspended trigger, the embargo) |
| the window for six {23, 27, 31, 43, 47} + U₆₄ | mission target, items 11–12, rows 68–71, G56, G59, paths FS-57/65/17 | rows 68–71 | G56 (window, reciprocity, fields), G59 (finite, fractional, what the conjecture makes of it) |
| real quadratic fields need four | "Last updated", item 14, rows 72–74, G61, G65, paths FS-59/60, mission target | rows 72–74 | G61, G65 |
| six as a value no field attains | rung D cell, mission target, item 15, G64, paths FS-62 | — | G64 |
| twisted bilayers; transcendence is free | item 16, G62, G63, paths FS-63/39 | — | G62, G63 |
| the conjecture's proved range (GPT Astra) | item 10, G48, G55, mission target, "not ours" list, row 63 | — | G55 (G48 keeps the conjecture's statement and falsifiers) |
| the fan gap; the design target has no instance | items 3–4, theory paragraph, G31, G47, G48, rows 55, 66, "closed as directions" | row 66 | G48 (the six-level question), G31 (witnesses) |
| the 2-adic tower; tight or slack | row 67, G54, theory paragraph | row 67 | G54 |
| the type-M rotation family and the ρ₆₃ arena | item 8, rows 64–65, G7, G62, G31 | row 64 (the arena), row 65 (shape dropped) | G7 (the family as a ladder), G62 (coincidence rotations) |
| de Grey's field is 6-open; row 52 is about a proper subfield | rows 52, 53, G43, item 2 | row 53 (the instances) | G43 |
| what "usable prime" means | row 52, G38, G43, G56, item 11 | legend | G56 keeps "27 is the unique non-prime member" |
| Parts's 509-vertex record | item 9, row 62, rows 64–65 | row 62 | — |
| FS-61/FS-58 closes; what is open | "Last updated", "Open milestones", item 14 | "Open milestones" | — |

## Step 3 — Primitives applied (running list; details per commit below)

* **Legend declaration / local macro** — a § Notation block after the header: `K`, `Γ_q`, `U_Q`, `L(F)`, usable, k-sealed / 6-open,
  wall standing / broken, "the standard three axioms", the grade tags (hoisted from the two section intros). **Measured worth of the
  macros themselves: small** — `ℚ(√3,√11)` occurs 30× (15 B each → `K` saves ≈ 420 B), `UD(𝔽_q,2)` 30× (16 B → `Γ_q` 8 B, ≈ 240 B),
  the axiom triple 3× (≈ 80 B). The legend earns its place through the repeated *in-line definitions* it lets every section drop and
  through legibility (`Γ₂₇` was already used in rows 70–71 without ever being defined).
* **Hoist to category / default + delta / entailment pruning** — the duplication map above: one home per fact, pointers elsewhere.
* **Parallel fusion, sentence → phrase, words → formula** — inside rows and grokkings, where a sentence restates a relation.
* **Words → symbols** — byte-audited: `𝔽` is 4 B, subscript digits 3 B each, `≤ √ ℚ` 3 B, Greek 2 B. A symbol is credited only where
  it is shorter in UTF-8 bytes than the words it replaces; no existing ASCII spelling is converted to a longer Unicode one.

(Steps 4–7 and the per-commit relocation lists follow below as the work proceeds.)

## Relocation lists — for each rewritten unit, every claim REMOVED from it and where it now lives

*Default: a claim not listed stayed in its unit (possibly re-worded). The mechanical skeleton of these lists is regenerated by
`python3 tools/claude_md_fact_audit.py --base 12ab550d --moves /tmp/moves.txt`; what is written here is the sentence-level part the
tool cannot see.*

### Commit A — § Notation (new), "Last updated", "Where the problem stands" (242,682 → 241,254)

* **§ Notation (new, 2,156 B).** Declares `K`, `χ(F²)`/χ_f/α/ω/ϑ, `Γ_q`, `U_Q`, usable prime, `L(F)`, the conjecture and its bold
  form, k-sealed / 6-open, the wall, the window, `Forces`/`Separated` (checked against `Forcer.lean:41`, `Fan.lean:79`), the standard
  three axioms, the grade tags. `Γ₂₇`, `Γ₂₃` were already used undefined in rows 70–71; `U₆₄` likewise.
* **"Last updated"** (805 → 222). Removed: "14 of the forty … certified", "8 of them fields nobody had reached and 5 new exact values
  (χ = 4 at d = 59, 119, 239, 359, 431)" → row 74; "what decides a field is its supply of unit vectors" → G61 (4), row 74; "a ball's
  average degree, not its size, decides whether a solver answers" → G65; FS-66/FS-67's one-line questions → § Paths forward rows;
  G64's correction in words → G64 (its demotion record); "χ(ℚ(√11)²) = 4 with the lower half in the kernel, and the 3-adic barrier"
  → rows 72–73.
* **"The problem"**: `Instances/Interval.lean`, `chromaticNumber_plane_interval` → row 33; the axiom triple → § Notation.
* **"What the kernel holds"**: the statement of the χ ≥ 6 target (k-colour virtual edges at √3 AND 2, never either alone; one
  √3 gadget over {1,2}) → rows 43, 61 and G26.
* **item 3**: "the sealing plane at 11 has a five-colouring with a fan gap, and a gap at level one…" → shortened to "Γ₁₁'s fan gap,
  repainted along the residue map"; full statement in row 66 and G48.
* **item 4**: "`Forces ↔ =`, `Separated ↔ Adj`, arity floor ≥ 3" → row 66, G31; "(complete sweeps)" → G31, row 43.
* **item 10**: "χ = 4 at 11 (kernel) and 23, χ ≥ 4 at 47" → row 73 (and G48's falsifier sentence).
* **item 11** (2,517 → 1,257). Removed → home: α ≤ 1046 → row 68; α ≤ 1023, 745, 575 and "FS-53 phase B" → row 69, G56; five
  refused at 23/27 (α ≤ 105, ≤ 141, level-3 relaxation, FS-56/FS-54) → rows 71, 70, G56; "106 … five needs" at 23 → row 68; **"146
  five needs" at 27 → ADDED to row 70** (it was nowhere else); ≤ 365 against 370, ≤ 371 against 442 → row 69; the best sets — 87 at
  23 against 89, "about 96,000 restarts over three stages, three seeds, eight rotation orders and a line quotient never produced 88",
  146 at 31 (161), 258 at 43 (309), 265 at 47 (369) → **ADDED to row 69's [search] sentence** (the stage/seed/rotation detail and the
  31 and 47 figures were nowhere else); which of 3, 11 is a non-square at which prime, and 27's case → G56; "what the window decides"
  in full, and "χ(ℝ²) = 7 itself needs only the bold form" → G56; χ_f = q²/α and the thresholds ≤ 88, 121, 160, 308, 368, 682 → G59.
* **item 12**: "the smallest-discriminant real field with no usable prime giving ≤ 5 colours" → G59.
* **item 14** (1,355 → 776): the lists of d → rows 73, 74; "a 204-point triangle-free graph" → row 73; `[Johnson1987]`,
  `[Fischer1990]` Thms 8–9, Thm 10(i), the planes at 7 and 11 → row 74 (prior art), G61; the shape that refuses over ℚ(√11) with 108
  and is 3-colourable over five fields with 20–36 → row 74, G61 (4); "11 and 59 both land at d ≡ 3 (mod 8)" → G61 (4); 167's ball
  "coloured in 3.66 s" and "the chain route seeded on its 7-cycle triangle" → § Paths forward, FS-59.
* **item 15** (1,250 → 838): "trivially (ℝ is a subfield)", "the converse is unproved and unmotivated", the two-colour jump
  ℚ → ℚ(√11), and the exact equivalence through FS-39's bridge → G64.
* **item 16**: "by the same evaluation at 0" → G63; "an arithmetic invariant" → G63.
* **"The prior-art position"**: the five questions Theorem B's value closes (Madore's 4 ≤ χ ≤ 5, Moorhouse §1, Cranston–Rabern,
  Exoo–Ismailescu's closing question, one field of Benda–Perles OP 11.6) → row 57, which lists them with keys; "(summary read, paper
  unread)" → row 57, § Publication.
# Phase 1b working notes

## Measurements so far (desktop, `lake env lean` with the lakefile's options, min of 3 unless noted)

| module | instance | table slots | hints | CPU s (min of 3) | peak RSS GB |
|---|---|---|---|---|---|
| `Cnf/Table.lean` | witness 883 v / 3,441 e | 16,262 | — | 31.59 | 6.14 |
| `Cnf/Seg000.lean` (2 segments) | witness | — | 96,820 / 2 | 79.57 | 14.01 |
| `Cnf/Seg000.lean` (8 segments) | witness | — | 96,820 / 8 | 29.32 (1 run) | 5.18 |
| `Cnf/Table.lean` | round0 2,974 v / 14,190 e | 61,484 | — | RUNNING | RUNNING |
| `Cnf/Seg000.lean` (8 segments) | round0 | — | 95,653 / 8 | TODO | TODO |

Observation on the 2-segment triple: CPU rose 79.6 → 97.7 → 119.3 across the three runs at constant
RSS (14.0 GB) — machine fill, not the module. Minimum of three is the right statistic and it is the
first run here.

## Decisions taken
* 8 segments, not the plan's default: peak RSS 14.0 → 5.2 GB, CPU/segment 79.6 → 29.3 s, and 8-way
  parallel elaboration. Total CPU rises 159 → 234 s; memory and wall clock both fall.
* one prefix `zmod121Four` for all the witness data (§L had `zmod121Core*` for the graph and
  `zmod121Four*` for the certificate).
* `Pts.lean` holds the packed literal and imports only `Mathlib.Data.Nat.Notation`, so the geometry is
  not upstream of the certificate (ARCHITECTURE § 3.10).

## The big-instance table run: cause / measurement / forfeit (written BEFORE the stop)
* **Cause.** It blocks the rest of phase 1b (the real build, the controls, the write-up), and its
  marginal value is a sharper ratio, not a different answer.
* **Measurement at the decision.** witness `Cnf/Table.lean` 31.59 CPU s / 6.14 GB at 16,262 table
  slots; round0 `Cnf/Table.lean` still running at **8.5 CPU-minutes / 20.4 GB** at 61,484 slots —
  ≥ 16× the time and ≥ 3.3× the memory for 3.8× the clauses, while the two proofs are the same
  length (96,820 against 95,653 hints). The question ("does the kernel's cost follow the clause
  table or the proof?") is answered by that alone.
* **Forfeit.** The exact completion time and peak of the round0 table, and with it the round0
  segment measurement (segments import `Table`), so the *segment* half of the table-vs-proof
  comparison is not measured at all. Deadline set at 15 minutes elapsed.

### Commit W — the window cluster: rows 68–71, G56–G59 (241,254 → 240,423)

**Discovered here, by a guard firing: the copy of `CLAUDE.md` loaded into my context was the PRE-trim version (`d0df4f82^`, 246,496 B),
not the file on disk.** A must-contain guard on G56 ("conductor-13") failed; `git show d0df4f82` showed that commit had removed that
text. Every entry that commit touched (rows 68, 69; G56, G57, G58, G59, G64) was then re-read from disk and the batch re-based on the
disk text, so nothing the morning trim removed or made current (G57's 371, G59's closed killing test at 19) was re-introduced.
Anything else I rewrote was unchanged between the two versions (word-level diff of `d0df4f82` checked).

* **row 68**: phrasing only. Home of every N, the checker, the SDP's shape, the rounding recipe.
* **row 69**: GAINED from G56 — "each CERTIFIED with its LDL green and 18 of 18 cuts agreeing"; the ceilings 8, 7, 8, 8, 10 with
  their two addresses; "no six-colouring found by local search (23, 31, 43, 47) or by the subgroup-periodic sweep at 27 (exhaustive
  at indices 9 and 27)". LOST to G56 — the list of fields named (23 → ℚ(√167), 31 → ℚ(√1055), 43 → ℚ(√4703), 47 → ℚ(√2351); 27's
  even degree ≥ 6 and the disc-316 cubic with √79): G56 held all of it already, with the argument. The closing "Grokkings: G56, G57,
  G58" became "(the understanding is G56–G58)" in the title.
* **row 70**: the trichotomy's one-line statement stays, its argument is G56's; "U₃₂'s 44 hyperplanes" and "inert towers keep
  λ_min/d" stay as statements with "both G54"; "(G59)" added to the two derived sentences. "Cay(𝔽_{Q²}, μ_{Q+1})" → `U_Q` (legend).
* **row 71**: "capped by every usable residue plane's χ_f (3 at 𝔽₃, 3.5 at 𝔽₇) and by 4.36" → now "The route's cap (3 at 𝔽₃, 3.5 at
  𝔽₇, 4.36) is G60's" (numbers kept in both; the sentence about what the cap means is G60's).
* **G56**: LOST to row 69 — the three items above (certification detail, ceilings, where six-colourings were sought). LOST to G59 —
  "the fractional wall W_f … rules six out for every CRT product of first-level targets; a composite target with χ = 6 needs a factor
  of residue size in {23, …, 83} at some tower level" (G59's "Escape hatches" now says both; G56 keeps a one-line pointer and W_f's
  killing test). "Cayley graph of 𝔽_{Q²} on the (Q+1)-st roots of unity" → `U_Q`, whose legend line carries those words.
* **G57, G58**: phrasing only. **G59**: GAINED "(the wall W_f)" and the CRT sentence from G56; "~96,000 restarts" → "row 69"; U₃₂'s
  hyperplane rigidity → "(G54)", which holds the argument (Sidon set, Fourier support, eleven four-colourings).

### Commit B — macros and four pointers (240,423 → 239,348)

* Scripted: `ℚ(√3,√11)` → `K` and its extensions → `K(√d)`, `UD(𝔽_q,2)` → `Γ_q`; 45 sites; not inside § Notation, § The shape of
  the proof (written for a reader meeting the field for the first time) or the sentence quoting Fischer "in those words".
* **Rung D cell**: "under the conjecture's bold form, if the wall at six holds, no field is exactly six-chromatic … the next rung above
  five is seven, first reachable at K(√7) where L = 7" → the target paragraph (1) two paragraphs below, and G64.
* **row 57**: Fischer's theorem (the ℤ/4 colouring, the congruences on p and q, "summary read, paper unread", what stays ours) → § Publication,
  its home; row 57 keeps the finding date, the pointer, and the rule for reading "B answers".
* **"Open milestones"**: FS-66's pilot question → its row in the table below; "14 of forty certified" → row 74; "χ(ℚ(√11)²) = 4 with
  the lower half in the kernel" → row 73.

### Commit C and after — intros, the home rule, the legend corrected (239,348 → 239,565)

* **Ledger intro, Grokkings intro**: the definitions of `[tools]`, `[hand]`, `[kernel]`, `[measured]`, `[reading]`, `[external]`,
  `[method]` → § Notation "Grades" (one codebook; `[cert]` and `[derived]`, used in rows 69–71 and G56–G61 and never defined, got
  a gloss there). Both intros keep their rules (never renumber; a reading names its killing test; a dead grokking keeps its record).
* **Frontier intro**: GAINED the one-home-per-fact rule and the audit tool's name (+395 B) — the rule every pointer above relies on.
* **Paths FS-62**: the exact equivalence spelled out → "(G64)", which states it with both directions' proofs.
* **§ Notation, corrected on re-reading**: "k-sealed: some *usable plane* is k-colourable" was wrong for the file's own "sealed at 4"
  (K and K(√35) are sealed by the residue target at 2, which is not a usable plane); now "some residue target — a usable plane, or the
  target at a prime above 2". **Owed a look by the PO:** the glosses of `L(F)`, `[cert]` and `[derived]` are mine, written from
  G48/G59 and rows 68–71; they are the only sentences in the file that are new claims rather than re-homed ones.
* **G57**: "The tension this creates is the milestone's" restored after the vocabulary diff showed "creates" had vanished (the
  attribution to the milestone went with it).

## Step 4 — Audit: bytes, a token proxy, and the measured ceiling

**Bytes (the budget Kooshi set).** `𝔽` 4 B; subscript and superscript digits, `ℚ ℝ ℤ √ ≤ ≥ ≡ ∈ ⟹ ⟺ ⌈ ⌉` 3 B; Greek, `× · ²` 2 B. So
`UD(𝔽₂₃,2)` (16 B) → `Γ₂₃` (8 B) saves 8 B a use and `ℚ(√3,√11)` (15 B) → `K` saves 14 B; no ASCII spelling was converted to a longer
Unicode one. **Tokens.** No tokenizer is available offline and none was sought. `token_proxy()` in the audit tool (ASCII word =
⌈len/6⌉, digit run = ⌈len/3⌉, other ASCII = 1, non-ASCII = ⌈UTF-8 bytes/2⌉) reads **75,988 → 74,739 (−1.6 %)** against **−1.3 %** in
bytes: the macros remove exactly the multi-token glyphs (`𝔽`, subscripts), so tokens fall slightly faster than bytes. It is a proxy.

**The measured ceiling — why the result is 1.3 % and not the 25–35 % guessed.** Four measurements, each reproducible:
1. **Literal repetition at the start was 2–4 % of the file**: 8-word runs occurring twice or more covered 4,970 B, 6-word runs
   9,241 B (both tellings counted, so at most half is removable). Now: 1,511 B and 3,338 B (`--dupes`). What looked like triple
   telling at section level is *paraphrase carrying different facts*.
2. **The experiment on the most-duplicated cluster** (the window: rows 68–71, G56–G59; 28.3 KB, every entry re-typed under
   one-home-per-fact): **−3.2 %.** Orientation item 11 alone held two facts that existed nowhere else (the best sets at 31 and 47; the
   search's stages, seeds and rotation orders), and row 69 and G56 each held measurements the other lacked. De-duplicating *moved*
   as many bytes as it removed.
3. **Fact density.** Distinct fact tokens per KB, by entry: ledger rows 36–53, grokkings 18–48, "Where the problem stands" 42 — one
   fact token every 20–50 bytes, so there is little connective prose to remove. The *lowest* densities are "Make the gate fail" (5.3),
   G21 (6.9), § The standard of evidence (10.6), § Delegation (11.3), § Building (13.3): the method sections, where the prose **is** the
   payload (diagnosis, substitute channel, boundary test) and the brief and the file's header both say not to cut.
4. **Phrase-level tightening, calibrated on G31**: 10 % with every fact kept. On the 185 KB of reference text that is a ceiling of
   roughly 8–12 KB more (about 3–5 %), at ~7 bytes re-typed per byte saved and with a drift risk the token audit cannot see (a
   dropped "not", "sampled", "measured"). **Not done: the hard constraint is "no fact lost", and the file was already tightened twice
   (`fd658af`, `d0df4f82`).** It is the PO's call, priced: ~40k tokens of agent time for one milestone-close of headroom.
5. Mechanical options priced and declined: un-backticking pure mathematics (266 safe spans, 532 B); removing bold (835 spans,
   3.3 KB — it is the skim path through 4 KB entries); unwrapping the grokkings' hard line breaks (≈ 1.4 KB — it would wreck diffs);
   brace-factoring the ledger's path lists (< 1 KB — it breaks `rg <path> CLAUDE.md`).

## Step 5 — Introspection: where adherence or comprehension could leak

* **§ Notation is now load-bearing.** `K`, `Γ_q`, `U_Q`, "usable", "sealed", "6-open", `L(F)` are read top-down by a model, so a cold
  agent is fine; the leak is a *search habit*: `rg "UD\(𝔽" CLAUDE.md` and `rg "ℚ\(√3,√11\)" CLAUDE.md` now find only the legend, the
  quotation of Fischer, and § The shape of the proof. The audit tool's `NORMALISE` table is the record of every re-spelling.
* **Orientation items now point instead of telling.** An agent that reads only "Where the problem stands" no longer sees the window's
  certificate numbers or the census's list of d. Each item kept its decision-relevant sentence (floors, what is decided, what is
  excluded); the leak would be an agent acting on an item without dereferencing `row 69` / `G56`. The dangling-pointer check in the
  audit tool guards the other half of that risk.
* **The one-home rule is stated once, in the Frontier's intro.** It binds only at a milestone close, so one mention suffices; its
  tripwire is `--dupes`, which sees literal retelling only.
* **Nothing in a method section changed** (§ Toolchain differs by one macro, `ω(Γ_q)`), so no counter-prior rule's adherence moved.
* **Suspected mis-stated intent, flagged not fixed:** G56 still says "five is CDCL-undecided or spectrally refused at every one" two
  clauses after saying five is refused *by certificate* at four of the five; "Where the problem stands" item 12 says "no uniform
  independence bound can carry it" while G59 now shows a uniform bound would close three of the six (it cannot close 23). Both are
  the file's words, kept; both read as stale to a cold reader.

## Step 6 — Verification

* `tools/claude_md_fact_audit.py --self-test`: nine plants, each fires for its own reason; the faithful copy and the declared
  re-spelling pass. `--base 12ab550d`: **PASSED** — 0 lost tokens in ten classes, all 65 grokking status tags unchanged, the three
  PROTECTED regions (1,495 + 2,567 + 2,899 B) byte-identical, the gate sentence matching with 1004 / 5, no heading gone, no dangling
  pointer; one reviewed allowance (`ℚ(√p,√q)²`, a spelling of Fischer's plane whose home says "the plane over ℚ(√p,√q)").
* `python3 tools/bib_audit.py`: 0 / 0 unresolved before and after (the totals moved 243 → 247 rows because the prover is writing
  `BIBLIOGRAPHY.md` beside me).
* `--words` (vocabulary that vanished entirely): 8 words, each traced — it is how G57's lost attribution was found and restored.
* **The guard that mattered was not the audit.** A must-contain guard on G56 refused my window batch because the copy of `CLAUDE.md`
  in my context was the **pre-trim** file (`d0df4f82^`): an agent is handed the file as its parent session first loaded it, not as it is
  on disk. Every entry that commit had touched was re-read from disk before anything was written.
* **Not done: a behavioural A/B** (old file against new, on prompts that stress each rule). It needs agents, and this task's
  head-count was one. No method rule changed, so what an A/B would test is comprehension of the pointers; the cheap form is to give a
  fresh agent the new file and ask it for the best independent set found at q = 31 (row 69, reached from item 11).

## Step 7 — Report

**242,682 → 239,565 bytes (−3,117, −1.3 %); proxy tokens −1.6 %.** Per section: "Where the problem stands" −3,211; Grokkings
−1,299; ledger −351; mission −247; Paths forward −233; Frontier intro −188; § Notation +2,222 (new); everything else 0 (§ Toolchain −8).

**Redundancy deliberately retained.** (1) Every method section, whole. (2) The "Theory in one paragraph" at the head of the grokkings
— it retells G1, G43, G48, G54 and row 66 in 2 KB, and is the one place a cold reader gets the whole argument in order. (3) The
bold one-line conclusions inside long entries. (4) Item 9 ("`[Parts2020a]`'s record") and item 8's last sentence, which are *homes*
(row 64 points at item 8; no row holds M62–M63's reproduction numbers). (5) The window's member list {23, 27, 31, 43, 47} in item 11,
row 69, G56 and G59: four tellings of 25 bytes that make each entry readable where it stands.

**Could not be compressed without loss:** everything in steps 4.3–4.4 above. **Believed to belong elsewhere, left in place:** the
ledger's long method narratives (row 65's six side-results, row 68's rounding recipe, row 57's quaternion paragraph) are plan-file
material; the Paths-forward table is only 28 % verbatim in `plans/FRONTIER-STUBS.md`, so it is not the mirror its heading calls it.

**The rule proposed for the header** (the header paragraph is PROTECTED, so it is proposed, not made): *"One home per fact; the
other places point. At every close run `python3 tools/claude_md_fact_audit.py --base <last close>` (nothing lost, no pointer
dangling) and `--dupes` (nothing retold). A new recurring term gets a line in § Notation, never a second in-line definition."* The
first sentence is already in the Frontier's intro.

**The structural finding, for Kooshi.** The file is within about 5 % of its no-loss floor (≈ 228 KB) and grows ≈ 6 KB per close, so
250,000 bytes is reached again in one or two closes whatever is compressed. What is paid per agent is 76 KB of method and orientation
that every agent needs and 160 KB of ledger, paths and grokkings that only a hunting session needs. The options are a budget that
tracks the ledger's growth, or a split by reader — `CLAUDE.md` keeping the method sections, § Notation, the mission, "Where the
problem stands" and an index, with the ledger and the grokkings in files a hunting session imports — which loses nothing and cuts what
an implementer or a prover pays by two thirds. That is a decision about what every agent must know, and it is not mine.
