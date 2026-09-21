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
