# FS-131 — the Lean backlog: the kernel plan (de Bruijn, the planner)

*Job FS131-K1, de Bruijn (Opus 5.5), launched 2026-10-03 at HEAD `8613b932`. Brief `data/fs131/briefs/FS131-K1-opening.md`, with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. Claim list `plans/LEAN-BACKLOG.md` (259 rows; ruling 2 of
`plans/FS131-close-inventory.md`). No phase-1 fence (ruling 1). Working files `data/fs131/k1/`; tools `tools/fs131_k1_*.py`.*

## Theorems this phase proved

None. A planning job: it writes definitions, statements with `sorry` at every leaf, and plans. Any `example` or `theorem` that closes in
the foundation modules is a sanity check of a definition (a spec example), not a backlog row, and is listed under the stage that adds it.

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (exact substring match of each `>`-block against the file its `— source:` line names), 2026-10-03:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "We will of course need to handle the backlog of lean work …" | `plans/STUB-lean-backlog.md` § The request | exact |
| 2 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | exact (a prefix of the paragraph's quotation) |
| 3 | "- **Dated notes**: every paragraph filed under an entry …" | `plans/LEAN-BACKLOG.md` § How to read this file | exact |
| 4 | "- **Never formalized as filed**: the twelve superseded entries …" | `plans/LEAN-BACKLOG.md` § How to read this file | exact |
| 5 | "1. **Every one of the 259 rows of `plans/LEAN-BACKLOG.md` has one disposition** …" | `plans/FS131-close-inventory.md` § What "Closed" means here | exact |

No mismatch; no finding about the brief.

The backlog itself parses as the brief says: `tools/fs131_k1_rows.py` reads the backlog's own machine tags into `data/fs131/k1/rows.json`
and confirms 259 rows — 178 in § The order, 32 in § FS-129's compositions, 26 in § Left the order, 23 in § Named by a merge line or a caution
— each with a statement block (`--self-test` drops a row heading and renames a statement tag; both fire).

### 1.2 What "Closed" means here, in my words

FS-131 is Closed when every one of the backlog's 259 rows has exactly one of four dispositions, with its reason in this plan, and every row
disposed *formalize* has a Lean declaration that passes the whole gate on one commit — build green through `./scripts/build.sh`, no `sorry`,
`#print axioms` clean except for declared purchases, the vacuity scan green with its counts reconciled, linters silent, spec examples passing,
each check's negative control watched — and whose formal statement has been read back against the row in this plan. No hand result of ours may
remain a hypothesis of a backlog declaration at the close unless it is outside the backlog and named. FS-129 closes with this milestone when
its 32 compositions pass. A row the kernel shows wrong is a result (a statement defect, routed to Ephodos), after which it takes one of the
four dispositions like any other row.

The four dispositions:
- **formalize** — the row gets its own declaration, in its merged form where a merge line names one, else in the form its errata and
  cautions govern;
- **merged into** — the row's content is carried by another row's declaration (that row must itself be *formalize*), so it gets none of its own;
- **excluded** — no declaration: the audit's "do not formalize as stated" (an empty class), a superseded form, or a statement shown false
  (with its corrected form a row of its own, or the counterexample named);
- **outside theorem** — a published result entering as an `axiom`, carrying `LEAN.md` § Assumptions' four items.

### 1.3 Registered expectations (written before reading the derivations closely)

Written after reading the backlog's how-to-read section, its cautions and a one-line digest of every row's statement (no derivation file
opened beyond its header). Scored at the milestone's close.

| # | expectation | probability / interval |
|---|---|---|
| E1 | Statement defects the formalization (skeletons plus implementations) finds among the 210 rows of § The order and § FS-129's compositions: median **12**. Most will be hidden hypotheses — non-degeneracy of arcs and tiles, the disc's radius against the fragment's domain, what "vertex" and "sector" mean at a point of a locally finite arc map — rather than false theorems | 80 % interval [4, 30]; P(≥ 5) = 0.8 |
| E2 | At least one of those 210 rows is shown false as written (beyond caution C109's three FS89 rows, which are outside the 210) | 0.55 |
| E3 | The skeleton stage alone (this job's wave 1) finds at least one defect | 0.6 |
| E4 | Outside theorems entering as axioms: the base of row 134 (`[SokolovVoronov2025]` Cor. 1 almost everywhere, with Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE) | 0.6 (else hypothesis or a separate job) |
| E5 | Measure rigidity (`[EinsiedlerLindenstrauss2022]` Thm 1.3) enters as an axiom, if any backlog row's declaration needs it | 0.85 |
| E6 | de Bruijn–Erdős (compactness of colourings) is formalized here or found in Mathlib, not imported | 0.75 |
| E7 | The Lebesgue density theorem is in Mathlib in a usable form for the plane | 0.9 |
| E8 | Euler's formula for cellular torus maps (FS114-N114-EULER's input) is not in Mathlib and enters as a hypothesis on a combinatorial map or as a separate job | 0.7 |
| E9 | Waves | median **9**; 80 % interval [6, 14] |
| E10 | Dispositions | formalize ≈ 195, merged into ≈ 25, excluded ≈ 30, outside theorem ≤ 8 |
| E11 | The hardest part is the foundation for planar maps and fragments (tiles, closure colours, sectors, rings, germs, change points), not the leaves | 0.8 |
