# The 2026-09-08 consolidation of Theorem A — the theorem audit (FS-71 batch 3b; ledger row 57)

*Filed 2026-09-22 by the batch-3b implementer. Enumeration: `plans/A1-theorem-A-kernel.md` (grepped per §S.4's
discipline; §10 "Results" read in full, lines 415–499, including R1–R7; §11 "Literature check" skimmed for the
Moorhouse/Madore/Fischer1990b finds, already attributed by row 57 and by batch 3a — not re-filed here; §12–§13
skimmed, method content, no new theorems found); `plans/STUB-theorem-A-kernel.md` (grepped — a pre-subplan stub
superseded by A1's actual shape, per batch 3a's precedent for near-identical stub files; read for context only,
not mined for new theorems); `LEDGER.md` row 57 (in full — its own text already carries the Hurwitz-order
argument's statement); `tools/quaternion_q4_check.py` (docstring and the module's exact-arithmetic checks read in
full, not re-run); `Proofs/HadwigerNelson/ResidueColouring.lean`, `FieldWall4.lean` (declaration lists by `rg`,
to confirm which of §10 R1's names are the ones row 57 already cites). **No separate plan file documents the
Hurwitz-order instance**: `rg -n "Hurwitz|quaternion|BendaPerles|ℚ⁴"` across `plans/`, `data/` returns nothing
outside `LEDGER.md` itself and `tools/quaternion_q4_check.py` — the mathematical write-up lives in the ledger row,
composed directly there, with the tool as its exact-arithmetic check. This batch treats the ledger row's own text
as the theorem's statement and proof sketch (per `plans/FS71-theorem-audit.md` §M.3: a proof address points at a
proof, and the tool's exact check plus the row's own argument together constitute one here, even with no separate
plan file).*

## The theorems

**R57-T1 — `χ(ℚ⁴) ≤ 4`: Theorem A's reach is not limited to the plane. [tools, exact; the mathematics is prior
art; the 2026-09-08 session]** Theorem A (`colorable_of_residue`, kernel) asks only for an abelian group `M`, a
subgroup `A`, and an additive map `ψ : A →+ G` nonzero on every edge difference — no ring, no metric, and (because
`colorable_of_residue`'s statement never invokes commutativity) **no commutativity**, so it takes a quaternionic
input unchanged. With `M = ℚ⁴` the rational quaternions, `A` the Hurwitz order localised away from 2, and `ψ` the
reduction at the unique two-sided prime `𝔓 = (1+i)H` above 2 (`H/𝔓 ≅ 𝔽₄`): **(H1)** every rational quaternion of
norm 1 lies in `A`; **(H2)** every one has nonzero residue (a norm-one element of a σ-stable subring is a unit of
it — Theorem A's own mechanism, `isUnit_of_mem_normOne`); **(H3)** `ψ` is well-defined and additive on `A`,
`|G| = 4`; **(LB)** four rational points pairwise at distance 1 exist (the rational unit tetrahedron
`0, 1, (1+i+j+k)/2, (1+i+j−k)/2`), giving `χ(ℚ⁴) ≥ 4`. Together: **`χ(ℚ⁴) = 4` exactly**, `[BendaPerles2000]`'s
value. *Proof:* `LEDGER.md` row 57's own text (the mathematical argument, composed directly there — see this
file's header note); `tools/quaternion_q4_check.py` (exact-arithmetic verification: `ψ` additive with four
values, `N` odd `⟺` unit mod `𝔓` checked over 28,561 elements of `H`; two independent families of rational unit
quaternions, 7,096 generated as `ab̄/n` and 2,448 exhaustive at denominator `≤ 7`, neither contained in the other,
all in `A` with nonzero residue; the enumeration cross-checked against the Hurwitz theta series `24·σ(odd part)`;
the Lipschitz order planted as a negative control, and it fires — 982 of 7,096 unit quaternions escape it,
Benda–Perles's own index-2 observation). *Proof verdict:* closes, at `[tools, exact]` grade over the checked
finite families named above (not an exhaustive enumeration of all rational unit quaternions, which is infinite;
the theorem's kernel half, `colorable_of_residue`, is a `∀`-statement and needs no such caveat — only `(H1)`,
`(H2)`, `(H3)`, `(LB)` are checked on finite samples). *Rests on it:* row 57's own "not new" scope note (§3's
`normOne` lemmas in `ResidueColouring.lean` are stated over commutative rings and would need the noncommutative
form to formalise this instance — not done); `CLAUDE.md` G35's identification of the 2-adic wall with the
quaternion algebra `(−1,−1)_F`'s ramification (the same noncommutative anisotropy this instance exploits, at a
different field). *Prior art:* the value `χ(ℚ⁴) = 4` and its lower bound (the rational unit tetrahedron) are
`[BendaPerles2000]`'s (already row 57's attribution); `[Madore2015]` Remark 3.5 excludes dimension `> 2` because a
quadratic form in `≥ 3` variables over a finite **field** is always isotropic — this instance escapes that bound
because the anisotropy sits in a **noncommutative** division algebra at 2, not in a residue field, which is a
scope correction to Madore's remark rather than a new value (already row 57's own framing, "a scope fact... for
FS-20"); zbMATH: `ab:"quaternion" & ab:"chromatic number"` (checked 2026-09-22: 0 hits), `ti:"unit distance" &
ab:"quaternion"` (0 hits) — no paper found stating the residue-colouring route through the Hurwitz order for this
value; the value itself is not re-derived from a fresh search, only from the held `[BendaPerles2000]` attribution
already in row 57. *Kernel:* declined — row 57's own words: "**Not formalized and not new**: a scope fact about
what A already covers, for FS-20" (the project's planned Theorem-B write-up). Formalising it needs the
noncommutative form of `normOne_subset_valuationSubring`, not attempted.

## Readings and measurements that were called theorems

- **The vacuity argument for `colorable_of_valuationSubring`'s scope** (`plans/A1-theorem-A-kernel.md` §10 R6,
  lines 483–491): `colorable_of_valuationSubring` cannot be widened to `A : ValuationSubring ℂ` because a
  homomorphism from a valuation ring to a finite nontrivial ring has a prime kernel whose quotient is a finite
  domain hence a field hence the maximal ideal, and the residue field of a valuation subring of an algebraically
  closed field is algebraically closed hence infinite — so the hypotheses would be unsatisfiable over `ℂ`, and the
  subfield hypothesis in `colorable_unitDistance_induce_of_valuationSubring` is load-bearing rather than
  decorative. **The module's own docstring marks this "an argument and not a theorem, because it is not
  formalized"** — self-graded by its author, not filed as a theorem here; recorded because it fixes the shape of
  what the kernel statement's hypotheses are for (a finding about necessity, not a proved impossibility).

## Conjectures surfaced, not claimed

- **The field-level gap, row 57's own words: "Not proved: that a number field with a conjugation-fixed prime
  supplies the valuation subring with residue field of size `N(𝔭)`."** `plans/A1-theorem-A-kernel.md` §10 R2
  (lines 441–448) states it precisely: the σ-stability half is proved (`conj_mem_valuationSubringAtPrime`); what
  remains is the finiteness and the count (`Ideal.absNorm`, `NumberField` instances) and the typing that places an
  abstract number field inside `ℂ` — "classical arithmetic and Mathlib plumbing with no new content" per the
  module's own docstring, not attempted in this session (§10 R3: phase 3 was deliberately re-aimed away from the
  full number-field instantiation once the marginal content over the valuation form was seen to be exactly these
  two classical facts). **Home of the closure: `CLAUDE.md`'s stub FS-47** ("the unit-vector ring in the kernel"),
  already named by row 57 and by `plans/FS71-theorem-audit.md`'s own G.1 table entry for this row. Not a § B line
  — no proof exists yet to index.

## Prior art re-attributed

None beyond what row 57's own text already attributes (`[BendaPerles2000]`, `[Madore2015]` Remark 3.5's scope
correction) — this batch's zbMATH queries (above) confirm no closer match, adding a negative finding rather than
a new attribution.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| R57-T1 (the Hurwitz instance) | declined (row 57's own verdict: "not formalized and not new"; needs the noncommutative form of `normOne_subset_valuationSubring`) |
| the field-level gap | **stub** (FS-47, already named) |
