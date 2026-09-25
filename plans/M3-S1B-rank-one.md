# M3 S1B — FS-76 in rank one, second mind on J18's stalled step (crunch job J19, derivation)

*Brief: `data/crunch-2026-09-25/briefs/J19-M3-rank-one-second-mind.md` with `STANDING-RULES.md`. Owner's ruling at launch: the target is
**A-T1 (R2) itself**; KE is the recommended route, a counterexample to KE is a finding about KE only; J18-DC's side is open to derivation
or explicit construction, never search. A proof of A-T1, a counterexample to A-T1, or a sharper named obstruction are all complete
outcomes. First mind: J18, `plans/M3-S1A-rank-one.md`.*

## Theorems this phase proved

*(one line per theorem, grade (`CLAUDE.md` § Notation), address; filled at each stage)*

| id | statement (one line) | grade | address |
|---|---|---|---|

---

## Stage 1 — SAVED (the quotation check, C0, the reading log)

### 1.1 The quotation check (standing rule 5)

Every quotation in the brief and in the owner's launch message, against its source, read from disk 2026-09-25:

| # | quotation (brief's place) | source | result |
|---|---|---|---|
| Q1 | KE, verbatim | `plans/M3-S1A-rank-one.md` §3.5, first paragraph | **identical**, character for character |
| Q2 | KE1, KE2, verbatim | same, bullet "Its two halves" | **identical** |
| Q3 | "KE ⟹ A-T1 [hand]: in an all-rigid shift no phase fails …" | same, first bullet | **identical** |
| Q4 | A-T1, verbatim | `plans/M3-exotic-colourings.md` §S, line "A-T1 (R2)" | **identical** |
| Q5 | "A-K3 is logically equivalent to A-T1 … (§2.5, "J18-EQ")" (a gloss, marked statements only) | J18's theorem table, row J18-EQ: "A-T1 ⟺ A-T1′ ⟺ A-T2 (T35 re-derived) ⟺ A-K3; …" | **faithful** (the row states more: A-T1′ and A-T2 are in the same chain) |
| Q6 | "KE is *stronger* than A-T1 and can fail where A-T1 holds (§3.5)" | §3.5 bullet "Warnings for J19": "KE is *stronger* than A-T1: it constrains shifts that have entropy. It can be false while A-T1 is true." | **faithful** |
| Q7 | the definitions, verbatim | `plans/M3-exotic-colourings.md` §S, "Definitions for Q1" | **identical** |
| Q8 | "J18's record fixes the reading as the labelled quotient, or the unquotiented graph; the plain quotient differs (§2.4)" | §2.4 heading and A-Kq (labelled): "Every phase of `G̃` is rigid iff every phase of `G_lab` is; a wall exists in `G̃` iff one exists in `G_lab`." | **faithful** |
| Q9 | owner: "J18-DC … A-T1 fails iff some heteroclinic four-colouring has an all-rigid Δ-completion" | §3.2, Theorem J18-DC: "A-T1 fails iff there are a four-colouring `c` of ℤ that is eventually periodic in both directions and not periodic, and an `M ≥ 1` with `D_c(M) ≠ ∅`, such that every phase of `X₄(D_c(M))` is a single cycle." | **faithful** (the gloss omits `D_c(M) ≠ ∅`, harmless: `D_c(M) = ∅` gives the full shift, never all-rigid) |
| Q10 | FS79-T34, T35, T36; FS73-T24, T30; FS85-dB1, dB2; FS86-dB-H (cited by name only) | their derivation files | all present, statements read |

**Reading discipline, and one slip of mine (logged, not hidden).** The brief allowed J18's §2.0, the *statement* of K0-loc, the
statement of A-Kq, J18-DC's statement, §3.3's bullets, and §3.5's KE statement and its "Warnings" bullet, and forbade §3.5's "Routes tried
and dropped" and every proof. I read those sections with `sed` line ranges, and two ranges were wider than the allowance: **I read
K0-loc's proof (§2.1), and §3.5's "Routes tried and dropped" bullet** (three routes: (a) swap the `{p(0), c(0)}`-component of the
departure vertex to push the departure right; (b) a strand count across the junction per colour pair; (c) route (ii) of §3.1). I also
read the first lines of A-Kq's proof. So this derivation is **not blind to J18's dropped routes**; it avoids them deliberately rather than
by ignorance, and a reviewer should weigh any overlap accordingly. I read no other proof in J18's record.

### 1.2 C0 — registered before the derivation (both outcomes of each reachable)

| id | prediction | prior | both outcomes reachable? |
|---|---|---|---|
| C0-1 | this job proves A-T1 for every finite `D` | 0.08 | yes: a proof, or none |
| C0-2 | this job constructs a counterexample to A-T1 (a named `D`, all-rigid, with a wall), checked exactly on the one derived `D` the brief allows | 0.05 | yes: the one exact check can come back all-rigid-with-wall, or with a non-rigid phase, or with no wall |
| C0-3 | this job ends at a named obstruction sharper than J18's KE (a statement strictly weaker than KE that still implies A-T1, or an exact reformulation with fewer quantifiers), or at a proof of A-T1 on a named subclass | 0.80 | yes |
| C0-4 | KE (J18's statement, not A-T1) is refuted by a derived argument or a derived instance | 0.10 | yes |
| C0-5 | on the control `{1,5,7,10}`, every rigid–rigid wall runs from a chiral phase to a phase of the mirror family (so the control's rigid–rigid walls are "twin boundaries") | 0.6 | yes (checked in §2 on the one given control; the tool is J18's, frozen) |

Priors are mine and uncalibrated. The standing warning (rule 4, G21): a proof I like is audited as hard as a counterexample.

### 1.3 The owner's mid-stage message (2026-09-25)

The owner reports `[EggletonErdosSkilton1985]` (R. B. Eggleton, P. Erdős, D. K. Skilton, "Colouring the Real Line", J. Combin. Theory
Ser. B 39 (1985) 86–100) newly held at `~/source/library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf` (15 pages, a scan
with an OCR layer), and asks me to read its sections on periodic and non-periodic colourings when they serve the target, record per
section what I read, and say whether the 1990 paper (`[EggletonErdosSkilton1990]`, "Colouring prime distance graphs", Graphs Combin. 6,
still unheld) is still needed. Done in §2.1 below, before the derivation.

### 1.4 The would-have-searched log (opened)

| # | move I would have made by search | what I did instead |
|---|---|---|
| W1 | enumerate candidate distance sets `D` (or candidate heteroclinic colourings `c`) and test each for all-rigid-with-wall | nothing; the counterexample side is attempted only by derivation (§2), with at most the one exact check the brief allows |
