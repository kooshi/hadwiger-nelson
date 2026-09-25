*Brief for crunch job **J16**, milestone M2 (FS-47, `plans/STUB-unit-vector-ring-kernel.md`; then FS-87 target 1,
`plans/STUB-de-grey-chain-kernel.md`), kernel. Opus 5.5, 2026-09-25. Written by J04 (`plans/M2-kernel-lane.md` §S, §3.2's choice).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for FS-47's prime inversion, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No
children: do not use the Agent tool, a fork or a workflow (delegation is one level deep; staffing is Kooshi's budget decision and the owner can
only review work it knows about). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against
`git log -- <record>`, and continue at the first stage not SAVED. Redo nothing saved.**

## The question, and why now
Which denominators can a field's unit vectors sum to? GPT Astra's Theorem 1.2 says `1/p` can exactly when no conjugation-stable prime lies above `p`
— the ring the character results stand on, and "the 2-adic wall is broken" read as "`1/2 ∈ ℤ[U]`". J04 found it has a **valuation form** that
Mathlib carries in one lemma (Chevalley domination), with the number-field reading left as row 57's named gap. Then, with the time left, the first
leaves of FS-87's stripe lemma. **Every outcome counts** (rule 4).

## The statements (verbatim)
- The stub (§1): "hence `1/p ∈ R` **iff** no stable prime lies above `p`". `plans/ASTRA-2026-09-14-derivation.md` T2: "For every real number
  field `F`, `E = F(i)`, `R` its unit-vector ring, and every rational prime `p`: `1/p ∈ R` iff no conjugation-stable prime of `E` lies above `p`."
- The Lean statements: `data/m2/j04/K3PrimeInversion.lean` (elaborates today; leaves `normOne_subset_iff_stable` and
  `inv_mem_iff_forall_valuationSubring` closed; `inv_natCast_mem_unitRing_iff` and the spec example open), plus, per `plans/M2-kernel-lane.md`
  §S: `inv_two_mem_unitRing_iff` (the wall, same form), and over `K(√7)` the explicit `1/2 = (w + w̄) + 2 ∈ ℤ[U]`, `w = (−3 + i√7)/4`, whence
  `3/8 ∈ ℤ[U]` — the number J14's conditional theorem chains along.
- FS-87 target 1 (the stub): "**V2-T5, the stripe lemma** — under NT₀ every proper four-colouring of the triangular lattice is striped (type O/P
  wheels; propagation along a line, then line to line)". Proof: `plans/FS85-V2-verification.md` §W5 item 3. Skeleton `data/m2/j04/K3Stripe.lean`
  (leaf S1, the wheel classification, checked in the kernel over all `4⁷` wheels, 18 s, 9.8 GB with a whole-`Mathlib` import — import less).

## Read first, from disk
`plans/M2-kernel-lane.md` §2.2 (the finding that reshapes K3), §3.2 (prices: K3-B about an hour; the stripe lemma 4–6 hours), §4.4 (obligation
items 4–5: the three-line composition; S2 as a wheel statement at S1's cost, the line and line-to-line inductions). `Proofs/HadwigerNelson/ResidueColouring.lean`
(`normOne`, `normOne_subset_valuationSubring`, `mem_normOne_conj_iff`); Mathlib `RingTheory/Valuation/LocalSubring.lean`.

## Fenced
Nothing is fenced from you.

## Stages
1. The quotation check; C0 (P-J16a–b); price from the next two leaves (`inv_natCast_mem_unitRing_iff`, the `1/5` spec) (~30k). Save.
2. `Proofs/HadwigerNelson/UnitRing.lean`: the ring, the two leaves, prime inversion in valuation form, the wall form, the `K(√7)` explicit
   memberships; a planted fault watched red (drop the involution hypothesis from leaf 1: the converse must fail to elaborate) (~90k). Save and
   **commit this module alone** before starting the stripe work.
3. `Proofs/HadwigerNelson/Stripe.lean`: the definitions, S1 (with a minimal import), S2 as the wheel statement, then the line induction as far as the
   budget goes, each leaf saved (~150k). Save.
4. The gate, the module map, the report; if the stripe lemma is not complete, a Q-line and brief for J16b with its leaves named (~40k).

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: new modules only; `Proofs.lean`, `ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py`), `scripts/Axioms.lean`. The stripe
checks are complete enumerations of sets a derivation fixed — in under the ban, and logged as such; no solver, no `native_decide`. The docstring of
`inv_natCast_mem_unitRing_iff` says the number-field reading is row 57's gap and is not proved.

## Record and paths
Record: `plans/M2-S3K-unit-ring.md`, with "Theorems this phase proved". Working files: `data/m2/j16/`. Budget 350k (harness); hand back by 420k.
Stop rule: prime inversion committed first; at 3 hours or 350k stop, with the stripe lemma's remaining leaves proposed as J16b. Report (rule 9) to
`data/crunch-2026-09-25/reports/J16.md`, SendMessage to `"main"`.
