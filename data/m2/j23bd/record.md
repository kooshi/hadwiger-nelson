# J23bd — `Transcendental.lean` attribution fix (M2 close, inventory row 68)

*Crunch job J23bd, 2026-09-25, de Bruijn (Opus 5.5). Brief: `data/crunch-2026-09-25/briefs/J23bd-M2-docstring-attribution.md`.*

## Theorems this phase proved

None. This job edits one module-doc paragraph (prose only; no declaration changes).

## "Would have searched here" log

None: no move in this job would have been a search.

## Stage 1 — SAVED: the two checks against the sources, and the brief's quotations

**Check 1 — Fischer's volume.** The held PDF `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, page header of p. 181:
"Discrete Mathematics    82 (1990) 181-195". Theorem 6 is on p. 188 (the running head "188 K. G. Fischer" precedes it). `BIBLIOGRAPHY.md`
line 120: "Discrete Math. 82 (1990) 181–195". The module doc (line 23) says "Discrete Math. 81": **wrong; it is 82**. The page, 188, is right.
The quoted statement in the module doc — *"Let α be a real number transcendental over the field F ⊂ ℝ. Then F^d can be k-colored (has an
additive k-coloring) iff F(α)^d can be k-colored"* — matches the PDF's Theorem 6 (it stops before the second "(has an additive k-coloring)").
"Setting x = 0" is the PDF's words (its line "Setting x = 0, one sees that if c(0) = 0, …").

**Check 2 — Madore's Prop. 3.2.** The held PDF `~/source/library/pdf/arXiv-1509.07023-madore-hadwiger-nelson-over-fields.pdf`, p. 6:
"Proposition 3.2. Let A be a valuation ring with valuation v: write m := {x ∈ A : v(x) > 0} for its (unique) maximal ideal, κ := A/m the
residue field, and K := Frac(A) for the field of fractions of A. Assume that the quadratic form z1² + · · · + zd² is anisotropic over κ
(that is, z1² + · · · + zd² = 0 has no solution in κ other than the trivial (z1, . . . , zd) = (0, . . . , 0)). Then there is a graph
homomorphism ψ : Γ(K^d) → Γ(A^d). […] we have: χ(K^d) = χ(A^d) ≤ χ(κ^d)." Its proof opens: "First observe the following fact: if
x1² + · · · + xd² = 1 with xi ∈ K, then in fact xi ∈ A for all i." At d = 2, anisotropy of z1² + z2² over the field κ is exactly "−1 is
not a square in κ". The Lean lemma `mem_valuationSubring_of_sq_add_sq_eq_one` (`Transcendental.lean:141`) assumes
`∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits`, i.e. `1 + x̄² ≠ 0` for every `x̄` in the residue field — the same hypothesis — and concludes the proof's
first paragraph; `unitQuadrance_colorable_of_valuationSubring` (line 177) composes it with the coset step, which is the rest of
Madore's proof. A residue hom into a ring `S` with `1 + s² ≠ 0` factors through `κ`, which embeds in `S`, so the target ring adds
nothing beyond Prop. 3.2. **So the generality the module doc calls ours ("the valuation lemma stated for any valuation subring whose
residue ring has no square root of `−1`") is Madore's Prop. 3.2 at d = 2**, as inventory rows 67–68 say (`plans/M2-close-inventory.md`).

**The brief's quotations, checked verbatim against their sources.**
- "stated for any valuation subring whose residue ring has no square root of −1" — the module doc, line 27–28, reads "the valuation lemma
  stated for any valuation subring whose residue ring has no square root of `−1`": matches (backticks aside).
- "the kernel form … is ours" — the module doc, line 26, reads "What is ours is the kernel form, stated for any formally real `F`, and …":
  the brief's ellipsis form is a rearrangement, not a verbatim quotation; the sense (keep the kernel form credited to us) is unambiguous.
- "about lines 20–28" — the paragraph is lines 23–28.
- J23b's gate counts in the brief (1,130 clean / 11 axiom-free / 5 purchases; declarations 7051, refutations 304, sites 279, generic 257):
  match `data/m2/j23b/axioms-stage0-after.out` line 41 and `data/m2/j23b/vacuity-stage0.out` lines 3–4 (which also give vacuous=0 stale=0
  declared=3 witnessed=17 unknown=2).
- `scripts/vacuity-baseline.txt`'s header **does** record counts: "declarations=6795  refutations-skipped=278  sites=275" and
  "vacuous=0 stale=0 declared=3 witnessed=17 generic=253 unknown=2" — so it is brought to the gate's current counts in stage 2.
- No other Lean file carries "Discrete Math. 81" (`grep -rn "Math\. 81" --include="*.lean" Proofs scripts`: the one line).

## Stage 2 — SAVED: the edit and the gate

**The diff** (`Proofs/HadwigerNelson/Transcendental.lean`, the module doc's "Prior art." paragraph only; no declaration touched):
- "Discrete Math. 81," → "Discrete Math. 82,".
- Removed: "The valuation form of the integrality step is `[Madore2015]` Prop. 3.2's mechanism. What is ours is the kernel form, stated
  for any formally real `F`, and the valuation lemma stated for any valuation subring whose residue ring has no square root of `−1` (it
  covers Theorem A's residue fields `𝔽_q`, `q ≡ 3 (mod 4)`, and the degree-one places of `plans/M2-S1D-bridge.md` C3′ alike)."
- Added: "The valuation lemma in its full generality — any valuation subring whose residue ring has no square root of `−1`, which covers
  Theorem A's residue fields `𝔽_q`, `q ≡ 3 (mod 4)`, and the degree-one places of `plans/M2-S1D-bridge.md` C3′ alike — is `[Madore2015]`
  Prop. 3.2 at `d = 2` (anisotropy of `z₁² + z₂²` over the residue field is exactly `−1` not being a square there): its proof's first step
  is the integrality lemma, and its coset representatives are the coset step. What is ours is the kernel form, stated for any formally
  real `F`."

`scripts/vacuity-baseline.txt`'s header: "declarations=6795  refutations-skipped=278  sites=275" → "declarations=7051  refutations-skipped=304
sites=279"; "generic=253" → "generic=257" (the other five counts unchanged).

**The gate** (desktop; every exit status read from the tool, outputs in this directory):
- build: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh` exit 0; "build: OK — 178 of 178 batches, 4 module(s)
  rebuilt, 0 module(s) with warnings, 3m39s" — rebuilt Transcendental, Bridge, NoParam, Proofs (`build.out`, `build.exit`).
- axioms: exit 0; "audited: 1146 records — 1130 clean on the standard axioms, 11 axiom-free, 5 declared purchase(s)"; purchase ledgers
  agree (`axioms.out`). Unchanged from J23b.
- vacuity: exit 0; "declarations=7051  refutations-skipped=304", "sites=279  vacuous=0  stale=0  declared=3  witnessed=17  generic=257
  unknown=2" (`vacuity.out`); after the header update, "recorded counts (scripts/vacuity-baseline.txt's header, CLAUDE.md § The gate):
  match" (`vacuity-after-baseline.out`). Unchanged from J23b.
- architecture: `tools/check_architecture.py` exit 0, "RESULT: PASS" (`arch.out`).

**Found on the way (not fixed; outside the brief):**
- *Tool defect*: `scripts/gate_report.py` lines 106–117 read only the baseline header, yet its line says "recorded counts
  (scripts/vacuity-baseline.txt's header, CLAUDE.md § The gate): match" — `CLAUDE.md` line 1910 still records "declarations=6795
  refutations-skipped=278" and the check never reads it. A check reporting on a file it did not read.
- *Correction owed (front-page lane)*: `CLAUDE.md` § The gate's vacuity counts (6795/278/275, generic 253 → 7051/304/279, 257) and
  § Trust ledger's "1034 clean" (→ 1130, as the axiom audit's own line says).
