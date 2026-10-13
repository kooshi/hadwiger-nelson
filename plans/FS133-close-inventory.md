# FS-133 — the one-class transfer: close inventory

*Keryx's file (Workflow 3.1). Opened 2026-10-07 (UTC) with the milestone. One item per result, ruling, correction owed, prediction,
slip or stub, each with its source address; every line ticked done or declined with its reason by the close. Prehistory: FS-131's
inventory, items 607–625 (an outside proof of six became this project's literature; this consequence was spotted at item 613 (1)).*

## The rules that judge this milestone (written before any report)

1. **The claim list** is `data/fs133/claims.md`, fixed 2026-10-07 from the asking lane's stub `plans/STUB-one-class-transfer.md`:
   C133-DENS, C133-INV, C133-ONE, C133-HOM, each posed. A change is a dated line there.
2. **The announcement rule.** `α₁(ℝ²) = m₁(ℝ²)` (C133-ONE) is announced as "derived, one mind" only when every step of its
   derivation is in a saved stage with its grade and the deriver's gate is green; as **a result of this project's** only when the
   prior-art search of the derivation's §PA, run before the derivation and again before its report, finds no earlier statement —
   and then with the date of that search; as **held** only when its Lean module passes the gate, with the outside theorems it
   imports named. A stall at a named step is announced as that.
3. **What it rests on** is named at its grade every time: the release's rigidity theorem is [kernel, outside] (built and audited
   here, `plans/EXT-OAI1-audit.md`); this milestone's own steps are [hand] until formalized.
4. **Nothing in this milestone is blind**; the kernel is the second check.

## Registered predictions

- The asking lane's: `plans/STUB-one-class-transfer.md` § Registered expectations (before any derivation).
- The deriver's: registered in its plan before the derivation (its brief, item 1); scored at the close.

## Items

1. **Opened 2026-10-07**: the stub read (its headings and its four posed claims; minted by FS132-P1, FS-131 inventory item 625);
   the claim list fixed; the deriver's job FS133-E1 briefed (`data/fs133/briefs/FS133-E1-opening-and-derivation.md`, generator
   `data/fs131/briefs/scripts/mk-fs133-e1.py`, gate exit 0, 7 quotations) — a short opening (§G, §PA, §IQ) and the derivation of
   the four claims in order, the unchecked step first; launched into a free slot. **The order, the asking lane's and adopted**:
   FS-133 takes the deriver's first slot because its value decays with the calendar (the proof it follows from is public);
   FS-132 follows at its first hand-back at the latest. Alternative: FS-132 first, by bearing on the answer. Confidence: medium-high.

2. **FS133-E1, first message: C133-DENS — the step the reading left unchecked — is derived, as posed and at a wider class**
   (source: its message to "main", 2026-10-07; record `plans/FS133-E1-derivation.md` Stage 3, § Argument for C133-DENS; commits
   `5447beb5` (stage 1), `d0cd352a` (stage 2), `472fbaf5` (stage 3), on `main`; its gate exit 0 by its word). **[hand], one
   mind.** The step is the reverse Fatou lemma on window averages of `1_{H>0} ≥ H`: the mean over `ω` of the upper density is at
   least `α`, so a positive-measure set of `ω` has upper density at least `α`, and it meets the full-measure event on which the
   set is unit-avoiding almost everywhere. **A generalization, its own entry C133-DENS-CLASS**: the posed hypothesis "`= α` for
   every `x`" is stronger than what the transfer's field gives (its mean is `α` only at almost every `x`); the argument needs
   "`≥ α` for almost every `x`", any σ-finite space, any window sequence — and that is the form C133-ONE consumes. **Not
   claimed, each with an example**: "for almost every `ω`" (false: a half-and-half mixture); lower density (false: alternating
   annuli, with an exact control). **It was already held in words** at the same place of row 129's chain
   (`plans/FS103-F-fractional-shadow.md` § 3.4, link 1), so nothing new stands or falls on it. **Prior art, the opening pass**:
   fifteen arXiv queries newest-first, two web searches, the four printed questions read at their pages — no statement of
   `α₁(ℝ²) = m₁(ℝ²)` found, no listing in these vocabularies dated after 2026-09-28; zbMATH's interface answered 503, owed at the
   second pass. **My receipt**: the three commits are on `main`; Stage 3 read whole; the Fatou step redone by me (Fatou on
   `1 − A_n` gives `∫ D ≥ limsup ∫ A_n ≥ α`; `μ{D ≥ α} = 0` would give `∫ D < α`, `μ` a probability); its two controls re-run
   with their faults (`tools/fs133_e1_dens_control.py`: `upper` True, `lower` False; `packing 2` True, `packing 19/10` False).
   Not checked by me: stages 1 and 2; its §PA queries; the citation of the transfer's line 223–224. **Rulings.** (a) **The claim
   list gains a dated line**: C133-DENS-CLASS is the deriver's generalization and the form C133-ONE consumes; C133-DENS stays as
   posed (`data/fs133/claims.md`). Alternative: restate C133-DENS. Why not: the posed claim is true as posed, and the list's
   rule is a dated line for a later change. Confidence: high. (b) **Nothing is announced**: by this inventory's rule 2 the
   headline is C133-ONE's, and the prior-art search has one pass of two done with one source down. (c) Its scripts go under
   `data/fs133/e1/` from now on, not `tools/`: a landing will be in flight within hours, and `tools/` is not exempt during one.

3. **FS133-E1 done at its Stage 7: all four claims derived — `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, with no hypothesis of this project's, over one outside theorem; [hand], one mind, kernel pending** (deriver; 477k and 33
   minutes by the task notice; record `plans/FS133-E1-derivation.md` Stages 1–7, 13 entries, 6 controls; plan
   `plans/FS133-one-class-transfer.md`; report `data/fs133/reports/FS133-E1.md`; eight commits, `5447beb5` to `b2d58e31`, on `main`,
   pushed). **What it derived**: C133-DENS (item 2). **C133-INV**, with equality and for every rotation-invariant connection set
   on the algebraic plane: an invariant random independent set of density `α₁(𝒜²)` exists (Følner pieces, a weak limit); it reads
   no statement of the release. **C133-ALG**, the core: every `E ⋊ K`-invariant law on independent sets of the algebraic plane has
   `P(0 ∈ I) ≤ m₁(ℝ²)` — the release's transfer steps run for one indicator: split it into its part continuous in the plane's
   topology and a rest; the rest's spectral measure is rotation-invariant and null on the continuous characters, so by the
   release's rigidity theorem its correlation at unit vectors vanishes; the continuous part then has zero unit correlation on the
   whole circle, is sampled as a measurable field, and C133-DENS with a density-point step gives a measurable 1-avoiding set of
   density at least `P(0 ∈ I)`. **C133-ONE** then closes by a chain: `α₁(𝒜²) ≤ m₁(ℝ²)` (ALG) `≤ α₁(ℝ²)` (averaging) `≤ α₁(𝒜²)`
   (fewer graphs) — so no redrawing lemma and no Tarski; the fractional line by a squeeze through `χ_f(ℝ²) ≤ 1/m₁(ℝ²)`.
   **C133-FN**: `f(n)/n → m₁(ℝ²)` (Fekete) — the first clause of `[DuczVarga2026]`'s Conjecture 1. **C133-HOM**, both directions,
   as an instance of **C133-PAIR**: a transfer for forbidden label pairs at any countable set of algebraic distances. **The
   control that matters**: run at `ℚ(√3,√11)`, where the conclusion is false (`1/4 > m₁`), every step runs but the rigidity
   theorem — the field enters there and nowhere else. **What it rests on**: the release's Theorem 2.3 (`wild_fourier`,
   [kernel, outside]), **read itself — so the import gains a third outside theorem; the transfer theorem already imported cannot
   stand in, it carries no density**; and **the manuscript's Lemma 4.1, read by its proof and re-run for an arbitrary invariant
   law** — the release's Lean holds that step only for its own label model, in pieces, so this is hand work here. **Prior art**:
   two passes on 2026-10-07 (fifteen arXiv queries, four repeated; two web searches) found no statement of either equality and
   no listing after 2026-09-28; **zbMATH was down at both passes — not searched**; MathOverflow and blogs not searched;
   neighbours named and unread. **Its predictions**: five of five met — written after a first pass through the routes, by its
   own account no measure. **Slips**: the stub cites a Følner step as "two blind minds" where the cited line grades one mind
   (the asking lane's); its own — predictions not blind to the routes, no token count readable, three scripts in `tools/` before
   my word (they stay).
   **My receipt**: the eight commits are on `main`; its gate run by me — exit 0, 0 failures, 0 warnings, six controls each
   firing on its fault; Stage 5's arguments for C133-ALG, C133-ONE and C133-FN and Stage 7 read whole. **Checked by me**: F6's use
   of the outside theorem against the theorem itself — the release's Lean statement as the audit quotes it (`wild_fourier (μ :
   Measure D) [IsProbabilityMeasure μ] (hw : IsWild μ) (z : E) (hz : z ≠ 0) : ∫ d, (eval z d : ℂ) ∂μ = 0`, with `IsWild ν` =
   rotation-invariant and `ν C = 0`) and the manuscript's Theorem 2.3 at its lines, read by me: the three things F5 establishes
   of the rest's spectral measure are that statement's hypotheses; F3's bookkeeping (`T_z f` is the indicator of `z ∈ I`, so the
   unit correlation is the probability that two adjacent points both lie in an independent set, zero); F6's cross terms; the
   closing chain's three inequalities, each in its direction. **Not checked by me**: Lemma 4.1 run for a general invariant law —
   **the heaviest link no second reader and no kernel has seen**; Stage 4 (the invariant law); Stage 6; the relay-results; any
   search query.
   **Credit**: the control at `ℚ(√3,√11)` — the chain run where its conclusion is false, to show the one step that must fail
   is the outside theorem and only it; the closed chain that makes Tarski unnecessary; each posed claim tested at a wider class
   and all three held; "a search this shallow says 'not found', not 'first'", written by the mind with most reason to write the
   other word; and the note that the already-imported theorem cannot carry this.
   **Rulings.** (a) **Announced to Kooshi now as "derived, one mind; over one outside theorem; not found in print by a search
   that lacks one source"** — rule 2's first clause is met (every step saved; the gate green, run by me). **Not announced as "a
   result of this project's"** until a zbMATH search has been run: both passes were made, as the rule asks, and both lacked it.
   Alternative: call the rule met, since two passes were run. Why not: the rule's point is the search, and the reviewing
   database is where an earlier statement would most likely sit. Confidence: high. (b) **`plans/FS133-E1-derivation.md` is the
   milestone's derivation file**; no separate record job — thirteen entries, and its Stage 7 holds the trace as eight drafts.
   FS-133 is **Derived when those drafts are filed**, which waits for the front-page filing's branch to merge (row 129 and the
   grokkings file are on it) and is then done by me: D1–D8, three bibliography rows, the claim list's lines, and the state
   words on the front page. (c) **The claim list gains dated lines** for C133-INV-CLASS, C133-ALG, C133-PAIR, C133-FN and the
   four relay-results, statements by address. (d) **Its Lean form waits on Kooshi's word** (FS-131 inventory item 630: what is
   formalized is reprioritized after the exploration). My recommendation to him: first among Lean jobs when he reprioritizes —
   a planner on C133-ONE over the import with `wild_fourier` as its third outside theorem — because nothing is published
   before Lean and the proof it follows from is public. (e) **A blind second mind before the kernel is his word** (rule 4);
   my recommendation: none — but if the result is to be told to anyone before its Lean module passes, one first, aimed at
   Lemma 4.1's general form. (f) **To the asking lane's next job**: two candidate stubs — does any three-point constraint
   transfer; the field form of the measure-rigidity test (`α₁(ℚ(√635087)²) = m₁(ℝ²)`?). (g) The stub's "two blind minds" line
   is corrected at the filing (D8). (h) **Slot: held** (FS-131 inventory ruling 630 (c): two Opus agents at once; the next
   launch is FS-132's split).

4. **Filed, 2026-10-07: FS-133 is Derived.** After the front-page filing's branch merged (`73e203fe`; FS-131 inventory item
   631), FS133-E1's eight drafts were filed by me, each copied from its record by script with the replaced passage asserted to
   occur once: `LEDGER.md` row 129 (D1 the plane clause with no MR; D2 the finite-graph killing test for MR withdrawn, its
   field form kept; D3 the grade bracket and the prior-art sentence) — and the sentence the front-page filing had put there
   an hour earlier ("would give … a sketch, one step unchecked") removed as superseded; the grokkings file, G60 (D4) and G80
   (D5); `CLOSED-QUESTIONS.md`, the Ducz–Varga and Johnson entry (D6, five replacements, and one word of mine: "given MR its
   value is" reads "its value is … (FS-133, with no MR)"); `plans/EXT-OAI2-reading.md` § 2.6, an erratum line (D7); the stub —
   a banner of mine saying Derived, its bearings (D8) and the corrected citation. Three rows in `BIBLIOGRAPHY.md` § C for the
   neighbours seen at abstracts (`[Bernshteyn2021]`, `[Bekker2026]`, `[AlonBucicDavies2026]`), their verdicts in the plan's own
   words. **The front page's state words** (mine): FS-133 "Derived" and FS-132 "Opened" in the open-milestones paragraph of
   `CLAUDE.md` and `plans/FRONTIER-STUBS.md`, with Kooshi's word that what is formalized is reprioritized after FS-132's
   exploration; the "Last filed" line; and § Publication's sentence, where row 129's answers to the two printed questions
   leave "all given MR". **Audits on `main`**: the fact audit against the merge — two figures of the withdrawn test's window
   (`0.00297`, `0.0176`) allow-listed with the file that keeps them (`plans/FS105-W-walk.md`), then exit 0; `--dupes` exit
   0; the bibliography audit exit 0, "every cited work resolves"; the derive gate on the record exit 0. **Not filed, owed**:
   an instance for G92 (three widenings attempted, three held — its Stage 7.3 states it, and drafts no text); the atlas's
   node for row 129; the ledger's row 129 is not regraded — [hand], one mind, kernel pending. **Slips of mine at this
   filing**: the stub's corrected citation was first written with its address twice (fixed in the same pass); the allow-list's
   reason first named a file that does not exist (fixed before the commit).

- **2026-10-13 20:25 UTC — the Lean phase starts, at Kooshi's word of 2026-10-13** (`data/fs131/REQUEST-2026-10-13.md` lines W2 and W3; FS-131 inventory items 650 and 690): the kernel planner FS133-K1 is launched on the kernel claim list `data/fs133/claims-K1.md` (six statements, by script from the derivation's entries); brief `data/fs133/briefs/FS133-K1-kernel-plan.md`; tree and branch `fs133-wk1`; record `plans/FS133-kernel-plan.md` on that branch. Not blind (ruling in FS-131 item 690). New since this milestone was derived: `[Davies2026]` proves the same sentence in dimension four and up and names the plane as its aim (`plans/FS131-ER1-davies-reading.md`).
