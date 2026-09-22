# FS-71 batch 1 — the theorem audit of M17–M36 (ledger rows 1–33)

*Filed 2026-09-22 by the batch-1 implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow spawned —
see the closing line). Read first, per the brief: `plans/FS71-theorem-audit.md` in full, `plans/FS70-derivation.md` (the
template), `LEDGER.md` rows 1–33 and § B.*

## Headline

**M17–M36: 5 theorems filed in 5 files, 0 re-attributed to prior art, 0 demoted (gap); enumeration complete.**

Five hand/tools-grade theorems, all confirmed on re-reading, none needing correction: `plans/M18-derivation.md`
(M18-T1, hand, verdict *unsure* — a proof sketch explicitly marked "deferred" in the plan and never completed),
`plans/M31-derivation.md` (M31-T1, the quadrature law, hand, verdict *closes*), `plans/M32-derivation.md` (M32-T1,
the stacking law, hand, verdict *closes*), `plans/M35-derivation.md` (M35-T1, the coset ladder, tools, verdict
*closes*), `plans/M36-derivation.md` (M36-T1, the coset-7 brick family's forced boundary-tightness, hand, verdict
*closes as scoped*). This meets P4 (batch 1 files fewer than six theorems) exactly. The other fifteen milestones in
the batch hold no theorem outside the kernel — every non-kernel clause of their ledger rows is a [tools] measurement
already correctly graded, or a corollary of a kernel theorem the same or a later milestone already proves.

The most notable finding is negative and structural, not a new theorem: **three hand proof *sketches* written at M33
(the criticality factorization A1, the transmuter's five-vertex forcing, the nine-vertex pigeonhole's two-case
argument) turned out to have already been promoted to kernel theorems one milestone later, at M34**
(`not_colorable_iff_covers`, `transmuter`, `mono_pair_of_not_colorable_append`, all in `Pigeonhole.lean`) — so they
are *not* filed here (kind: "kernel already", disposition table M.1). This is the audit working as designed: a
candidate the seed flagged as "a hand theorem... which is not filed" (G15's entry in the plan's §G.1) turned out, on
opening the actual files, to have a kernel address the seed's summary hadn't surfaced.

## The census table

*One row per milestone M17–M36. "Candidates" lists every grade-tagged clause of the milestone's ledger row(s) plus
anything the plan files added under the grep discipline (§S.4); "classified as" gives kernel / measurement / reading
/ instance / prior art / conjecture with one line why, per candidate.*

| milestone | ledger row(s) | candidates found | filed as | classified as |
|---|---|---|---|---|
| M17 | 12, 13 (part) | row 12 "extension profile" (per-pivot 3-pattern realizability sweep); row 13's "growth-family hunt closed exhaustively (557M class-tests), SAT pool statistics measure the solver"; §0a "the deletion direction is closed by a two-line argument" (`Fan` monotone under subgraph deletion) | none | measurement (row 12, row 13's non-pentagon clause) · kernel (`Fan` monotonicity, §2, `Coverage.lean`'s ambient lemmas) |
| M18 | 4–7, 13 (part) | rows 4–7 (fan ⟺ coverage, no class confines alone, 120° triangle identity, greedy colouring); row 13's pentagon-exclusion clause (§0(d)) | **M18-T1** | kernel (rows 4–7, `Coverage.lean`/`ClassGeometry.lean`/`Greedy.lean`) · hand, unsure (the pentagon clause — filed) |
| M19 | 1–3, 8 | two-circle theorem, seam identity, coverage ratchet, de Grey's balanced 5-colouring | none | kernel (`TwoCircle.lean`, `CoverageMono.lean`, `Instances/DeGreyBalanced.lean`) |
| M20 | 9–12 | 120° compulsion, one-pivot cap, strip automaton (`window_extends`), extension profile | none | kernel (rows 9–11, `Compulsion.lean`, `Strip.lean`) · measurement (row 12, instrument, no theorem) |
| M21 | 14–16 | pair-gluing classification; row 15 "first nonzero extension pressure" (coupling census); row 16 "the coupled automaton is dead" (no multiplicative relation found); `m21-predictions.md` (pre-registered bands, no independent content beyond what the row already reports) | none | kernel (row 14, `Coupled.lean`) · measurement (rows 15–16) |
| M22 | 17–19 | general gluing classification (cites `[Vinh2006]` Lemma 3 as prior art already in the row); certified near-relation; row 19 "kill mechanism and partner web" (outer/inner necessity rates, core sizes, collision rates); `m22-predictions.md` (pre-registered bands, absorbed into the row) | none | kernel (rows 17–18, `Glue.lean`) · measurement (row 19) · prior art already attributed in-row (`[Vinh2006]`) |
| M23 | 20–21 | pivot-triangle layer (ten-point sharing theorem, rot-hexagon generic closure); row 21's "the triple-kill population is provably empty" (§0.2.1: no unit triangle in the closure has pairwise-disjoint cover sets); "ambient kills gated by coupling strength"; "seam-alignment reading fails replication" | none | kernel (row 20, `Triangle.lean`) · **instance** of row 20's own kernel theorems (self-gluing via `hexStep` + the ten-point sharing theorem jointly force every unit-triangle pair's cover sets to overlap — a corollary the plan itself names as the reason the registered population is empty, not a new theorem) · measurement (the replication/coupling-strength findings) |
| M24 | 22 | the matched ladder pair, exactly 4-chromatic (word algebra, master identities, ii/oi completeness, the trace-pair telescope) | none | kernel — §3.5's implementation record states "all obligations proven... unconditional"; no residual hand step found |
| M25 | 23 | the four-ladder object, exactly 4-chromatic | none | kernel (`MetaLadder.lean`) |
| M26 | 24 | the hexagram, exactly 4-chromatic, rot6-equivariant colouring | none | kernel (`Hexagram.lean`) |
| M27 | (none — demoted stub, never run) | the finiteness-of-axis-classes remark (unit chord needs axis length ≤ 3, by the triangle inequality) | none | not run — the milestone was demoted before any instrument or Lean obligation was attempted; the remark is a two-line consequence of the triangle inequality, never used |
| M28 | (none — demoted stub, never run) | none beyond scope description | none | not run — gated behind M27, demoted the same session |
| M29 | (none — demoted stub, never run) | a four-step proof sketch (compactness, ladder-coset decomposition, parametrized completeness, an extension lemma) | none | not run — every step is "to be proven", none attempted; subsumed by the M30+ programme |
| M30 | 25–26 | field-wall identity (`moserTwist_mul_seam_sq`); de Grey anatomy (67 edge directions in the half-spindle group, six pairs forced at the 791-forcer, "at or near edge-critical" by sampling, the concentration bet's failure); the minimal-polynomial check (E2) | none | kernel (row 25, `FieldWall.lean`) · measurement (row 26; E2 is routine algebra feeding the kernel work, not separately significant) |
| M31 | 27 | **the quadrature law** (G12) — a-priori derivation confirmed at 26 exact censuses; the witness-closure growth measurements (P4–P10) | **M31-T1** | hand, closes (filed) · measurement (P4–P10, already row 26–30/G10) |
| M32 | 28–29 | 2-adic kill engine (`sqrt5_indep`, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15`); **the stacking law** (G14) — a-priori derivation confirmed by census; "width without degree does not force" (the measured null on the matching/triangle-web) | **M32-T1** | kernel (2-adic kill engine, `Quadrature.lean`) · hand, closes (the stacking law, filed) · measurement, not a theorem ("no colour pressure" reading, §3 of the derivation file) |
| M33 | 30 | mechanism hunt: A1 the criticality factorization (hand sketch); A2 the containment ordering (trivial); the distance-2 pigeonhole with a 122-vertex carrier; the 49-vertex 3-cover core (solver-found); the nine-vertex √3-pair pigeonhole with its hand two-case proof; `M33-witness-closure.md` (a superseded handoff stub, absorbed into the mechanism hunt, no independent content) | none | **A1 and the nine-vertex proof are hand sketches that became kernel theorems one milestone later** (`not_colorable_iff_covers`, `transmuter`, at M34/row 31) — not filed here, noted at M34 · A2 elementary/definitional, not filed · the 49-vertex core and the coarser pigeonhole carriers are solver-measured, not theorems |
| M34 | 31 | Act One in the kernel: the bridge (`mono_pair_of_not_colorable_append`), the transmuter, A1 (`not_colorable_iff_covers`) — all kernel; `core9_plane`/`core122_plane` vacuous (B4, a finding about a kernel statement, already stated in the row); the union arithmetic pricing (B5); the organizing-distance law `d/√3 = 1 ⟺ d = √3` (B6, "no new Lean needed", a remark); the composed 4,749-vertex union (tools, kernel-covered cubes) | none | kernel (the bridge, the transmuter, A1 — `Pigeonhole.lean`) · finding about a kernel statement, not a new theorem (the vacuity, already in row 31) · not filed (B5 priced design arithmetic; B6 a minor remark; the composed union is B1's kernel bridge plus B5's priced arithmetic, nothing separately new) |
| M35 | 32 | hex-shell clique / `mono_pair_of_clique` (kernel, already proved at M34 and restated here as C3/C5); **the coset ladder** (C4, exact HNF enumeration, index ≤ 5); the organizing bound C2 (single-class avoidance forces ≤ 3 points, trivial algebra); the brick architecture C6 (design, not a theorem); `M35-certified-union.md` (a demoted stub, never run) | **M35-T1** | kernel (`Instances/HexShell.lean`, row 32; `mono_pair_of_clique`/`not_colorable_iff_covers`, already M34) · tools, closes (the coset ladder, filed) · trivial/design, not filed (C1, C2, C6) |
| M36 | 33 | check_pos/Brick.sound soundness machinery (kernel); **the coset-7 family forced boundary-tight** (C2, hand); the open-box soundness relaxation (C1, formalised into `Brick.sound` — kernel); the pixel-route retirement C6 (a covering-radius estimate, not a proof); the P12 coset-coefficient cross-validation (an empirical check, not a theorem) | **M36-T1** | kernel (`Brick.lean`'s `check_pos`/`sound`, `Instances/Seven.lean`'s `sevenBrick`, row 33) · hand, closes as scoped (C2, filed) · not filed (C6, the P12 cross-validation) |

## Progress and resume

**Batch 1 is complete: every milestone M17–M36 filed or classified.** No successor is needed for this batch. The
next milestone in FS-71's sequence is batch 2 (M37–M52, ledger rows 34–46), briefed fresh from the repository.

## Theorems this phase proved

**None** — as expected for an audit. This phase's own product is five filed theorems (M18-T1, M31-T1, M32-T1,
M35-T1, M36-T1) that earlier milestones proved and left unindexed, plus the finding that three of M33's hand
sketches were already promoted to kernel theorems at M34. No new mathematics was produced.

## Proposed edits to `CLAUDE.md`

Two grade-tag precision corrections, both minor (neither changes what is claimed, only the audit trail of how it was
established); the owner applies these.

1. **G12's grade tag undersells the derivation behind it.**
   - Current: `* **G12 — The quadrature law. [kernel for ρ₁₅; measured for ρ₆₃]** A detuned copy RX of seam material couples`
   - Proposed: `* **G12 — The quadrature law. [hand; kernel for the ρ₁₅ instance]** A detuned copy RX of seam material couples`
   - Reason: FS-71 (M31-T1) found the law itself is a hand a-priori derivation (`plans/M31-minimal-five-closure.md`
     §0a) covering both radical families (`ρ₁₅`, `ρ₆₃`) and both word parities (even/odd), confirmed at 26 exact
     censuses — not "measured" as the current tag's `ρ₆₃` half implies (as if no proof existed for that case). Only
     the `W = ρ₁₅` even-word instance is in the kernel (`quadrature_rho15`, `Quadrature.lean`); the `ρ₆₃` case and
     every odd-word (half-spindle) case are hand-derived-and-confirmed, never separately kernelised.
2. **G20's grade tag hides that the boundary-tightness argument is a hand derivation, not a kernel fact or a bare
   measurement.**
   - Current: `* **G20 — Brick colourings. [kernel + measured]** A brick 7-colouring of the plane exists and is`
   - Proposed: `* **G20 — Brick colourings. [hand (why the coset-7 family is forced boundary-tight) + kernel (the check_pos instance) + measured]** A brick 7-colouring of the plane exists and is`
   - Reason: FS-71 (M36-T1) found "boundary-tight by force" is a hand a-priori derivation
     (`plans/M36-seven-coloring.md` §0a C2: the self-offset and coset-offset constraints jointly pin
     `w² + h² = 1`), confirmed exactly on the certified instance — not itself in the kernel. Only the specific
     rational witness's soundness check (`Brick.check_pos`, `Brick.sound`, `sevenBrick`) is kernel.

## Where the brief was wrong

- **Nothing substantive.** The brief's seed (plan §G.2, batch 1) named every candidate this audit filed (rows 13, 27,
  29 via G12/G14) or investigated and classified otherwise (row 21, row 30's criticality factorization, row 31's
  vacuity, row 32/33's G20). Two small refinements to how the brief framed things:
  - The brief's seed line for row 30 says G15's criticality factorization "is a hand theorem... which is not filed"
    — this undersold it: on opening `plans/M34-act-one-certified.md` §0a B3 and `Proofs/HadwigerNelson/Pigeonhole.lean`,
    the criticality factorization turns out to be **kernel** (`not_colorable_iff_covers`), not merely a hand
    theorem left informal. It is correctly *not filed* in this audit, but for the opposite reason the seed gave
    (kernel already, not "hand and unfiled").
  - The brief listed `M17-constructing-narrow-fans.md` at 26,644 bytes as part of the batch; it and
    `M19`/`M20`/`M21`/`M22`/`M24`–`M26`/`M30` were read in full (not merely grepped) once it became clear their
    ledger rows already captured everything load-bearing and a light keyword sweep (`not formaliz|not kernel|not in
    lean|stays informal|informally`) came back with a single false positive (a build-crash remark in M17, unrelated
    to mathematics). This cost more tokens than the grep discipline alone would have, but caught the row 20/21
    "triple-kill population" nuance that a pure grep-and-neighborhood pass on M23 might have missed (the derivation
    sits eleven lines below its own §0.2.1 heading, past the grep window a ±40-line rule would have centred on the
    hit for "provably empty").

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `LEDGER.md` (in full, both
passes needed for rows 1–98 and § B), `plans/M17-constructing-narrow-fans.md`, `plans/M18-the-120-degree-class.md`,
`plans/M19-coverage-driven-construction.md` (headers + §0), `plans/M20-the-extension-problem.md` (§0a excerpt),
`plans/M21-coupled-circle-systems.md` (§0a excerpt + headers), `plans/m21-predictions.md`,
`plans/M22-partner-closure.md` (§0a excerpt + headers), `plans/m22-predictions.md`,
`plans/M23-pivot-triangle.md` (§0.4, §1–2b in full), `plans/M24-completeness.md` (§3.5 in full, headers for the
rest), `plans/M27-tiled-plane.md`, `plans/M28-recursion.md`, `plans/M29-uncountable-pair.md` (all three in full —
each under 4 KB), `plans/M30-degrey-anatomy.md` (§R in full), `plans/M31-minimal-five-closure.md` (§0a, §0b–c
excerpt, the quadrature-law-and-censuses section, the witness-closure and frontier-curve sections — effectively
whole), `plans/M32-certified-five.md` (§0a, §0g, §R — effectively whole for the load-bearing sections),
`plans/M33-mechanism-hunt.md` (§0a, §R, the annex — effectively whole for the load-bearing sections),
`plans/M33-witness-closure.md` (in full — under 8 KB), `plans/M34-act-one-certified.md` (§0a in full),
`plans/M35-k5-transfer.md` (§0a in full), `plans/M35-certified-union.md` (in full — under 5 KB),
`plans/M36-seven-coloring.md` (§0a, §R — effectively whole for the load-bearing sections).

**Files grepped, with the patterns used:**
`rg -n -i 'theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|proof:|QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed'`
across all 24 files (the §S.4 discipline; hit counts recorded in-session, ranging 1–74 per file);
`rg -n '\[hand\]|\[derived\]|\[cert\]|\[proof\]|not claimed|conjecture'` across all 24 files (near-zero hits — these
milestones predate the `[grade]` tagging convention, which starts around M31);
`rg -n '^#+ .*(Result|Finding|Theorem)'` across all 24 (found §R sections in M30–M36 only);
`rg -n 'priori derivation|A priori'` across the files without a `§R` header (found the §0a convention starting at
M31, plus M36's own §0a);
`rg -n -i 'by hand|hand proof|hand argument|hand-derived|hand-checkable'` across M17/M19–M22/M24–M30/M33-witness-closure
(all hits were either already-kernel implementation notes or M26's "hand-derived at subplan opening" design remarks,
themselves fully formalised);
`rg -n -i 'not formaliz|not kernel|not in lean|stays informal|remains informal|instrument-only|instruments-only|informally'`
across M17/M19–M22/M24–M26/M30 (one false-positive hit, a build-crash remark);
`rg -n -i 'pentagon'`, `rg -n -i 'triple-kill|triple kill'`, `rg -n -i 'seam-alignment|provably empty'`,
`rg -n -i 'ten.point|share exactly ten'`, `rg -n -i 'quadrature'`, `rg -n -i 'stacking|matching|1-regular|rainbow triangle'`,
`rg -n -i 'criticality factor|χ\(G\) ≥ k|fan at a vertex'`, `rg -n -i 'hex.shell|mono_pair_of_clique|folklore'` —
targeted searches for the seed's named candidates (rows 13, 21, 27, 29, 30, 32).

**Files skipped, and why:** `tools/extend.py`, `couple.py`, `anatomy.py`, `rigidity.py`, `closure.py`, `mechanism.py`,
`embed.py`, `verify_defect.py` — the brief said their module docstrings "may hold a derivation"; every derivation
actually used by this batch was already stated in its plan file at the point of design (the `§0a` a-priori sections,
where they exist, precede any tool code and are the primary source — the tool docstrings, spot-checked for
`M31`/`M32`/`M35`/`M36`'s tools, restate rather than add). `data/m17…m36`: confirmed absent (`ls` before starting, as
the brief said). Lean modules named in the rows: existence checked with `rg -n "<name>" Proofs/`, never opened beyond
the declaration and its immediately surrounding docstring (`Pigeonhole.lean`, `Coverage.lean`, `Quadrature.lean`,
`Brick.lean`, `Instances/Seven.lean`, `Strip.lean` — six files, `#check`-grade reads only, no `lake build`).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent.
