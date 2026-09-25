*Brief for crunch job **J17K2**, milestone M2 (FS-39 phase C's C3 lemmas), kernel. Opus 5.5, 2026-09-25. Written by J17K
(`plans/M2-S4K-bridge.md` §4), whose budget ran out after B1, C4 and B0 landed; this is the remainder of J17K's brief
(`data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` stage 4), unchanged in substance.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a kernel engineer in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No children:
do not use the Agent tool, a fork or a workflow (delegation is one level deep; staffing is Kooshi's budget decision, and the owner can
only review work it knows about). **If your record already exists, you are resuming: read it and this brief, check the last SAVED stage
against `git log -- <record>`, and continue at the first stage not SAVED.**

## The question, and why now
`[Fischer1990]` Remark 1 claims every finitely generated `E ⊂ ℝ` is purely transcendental over a number field; J17 refuted it by hand
with a genus-1 function field, and the one piece of fresh algebra is Lemma NP. Kernel-checking it turns J17-T5/T6 from `[hand]` to
`[kernel]`. **Every outcome counts** (rule 4): a leaf that will not close, named with its obstruction, is a result.

## The statements (verbatim, each with its address)
- **Lemma NP** (`plans/M2-S1D-bridge.md` §2.3): "There is no nonconstant `a ∈ ℂ(t)` for which `a³ − a` is a square in `ℂ(t)`." Its
  hand proof is there in full (`a = p/q` coprime; the four pairwise coprime factors are squares; "`α⁴ = β⁴ + (γδ)²`" contradicts
  Mason–Stothers because "`deg γ + deg δ … ≤ 2D`").
- **C3, one-variable containment form** (J17K's brief, derived from J17-T5, §2.3): for `F : Subfield ℝ` with every element algebraic over
  `ℚ` and `t : ℝ` transcendental over `F`, the two reals `x := 2 + liouvilleNumber 10` and `y := √(x³ − x)` do not both lie in `F⟮t⟯`.
- **C3⁺** (`plans/M2-S1D-bridge.md` §2.3, J17-T6): "`E` embeds in **no** purely transcendental extension `F′(t₁, …, t_m)` of any number
  field `F′`" — last, only if time remains.
- Mathlib, verbatim: `protected theorem Polynomial.abc {a b c : k[X]} (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0) (hab : IsCoprime a b)
  (hsum : a + b + c = 0) : (natDegree a + 1 ≤ (radical (a * b * c)).natDegree ∧ natDegree b + 1 ≤ (radical (a * b * c)).natDegree ∧
  natDegree c + 1 ≤ (radical (a * b * c)).natDegree) ∨ derivative a = 0 ∧ derivative b = 0 ∧ derivative c = 0`
  (`NumberTheory/FLT/MasonStothers.lean:55`); `exists_associated_pow_of_mul_eq_pow'` (`RingTheory/PrincipalIdealDomain.lean:482`).

**Proposed Lean** (refine at the skeleton; record every change with its reason):
```lean
theorem not_isSquare_cube_sub_self {k : Type*} [Field k] [IsAlgClosed k] [CharZero k] {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 3 - a)
```
Suggested decomposition (J17K's, untested): (1) the polynomial core — `p, q` coprime, `p(p−q)(p+q)q` times a unit a square in `k[X]`
⟹ each of `p, q, p − q, p + q` is a unit times a square (`exists_associated_pow_of_mul_eq_pow'` three times; units are squares over an
algebraically closed field); (2) the Fermat-quartic step `α⁴ = β⁴ + (γδ)²` with `α, β` coprime not both constant contradicts
`Polynomial.abc` (radical degree `≤ deg α + deg β + deg γ + deg δ`; `derivative = 0` forces constants in characteristic 0); (3) the
`RatFunc` wrapper (`RatFunc.num`, `RatFunc.denom`, their coprimality). **The plant:** the genus-0 twin — the same statement for
`a ^ 2 - 1` is false (`a = (X² + 1)/(2X)` gives `a² − 1 = ((X² − 1)/(2X))²`); prove that counterexample in the kernel beside NP, and run
NP's proof on the twin to watch it fail for the genus, not for scaffolding. (Dropping `CharZero k` is not a good plant.)

## Read first, from disk
`plans/M2-S1D-bridge.md` §2.3; `plans/M2-S4K-bridge.md` (J17K's record); `Proofs/HadwigerNelson/Transcendental.lean`
(`adjoinTranscendental`, `adjoinTranscendentalEquiv`, `transcendental_liouvilleNumber_bot` — reuse, do not re-define).

## Fenced
Nothing.

## Stages
1. Quotation check; C0; the skeleton of `Proofs/HadwigerNelson/NoParam.lean`, `sorry` at every leaf; price from the first two leaves
   (~40k). Save.
2. Lemma NP, leaf by leaf; the genus-0 twin and the plant watched red, then restored (~120k). Save.
3. C3 one-variable form; C3⁺ only if time remains (~60k). Save.
4. The gate, the module map, the report (~40k).

**Stop rule:** at 3 hours or 300k, land what is green and name the leaves left, each with its obstruction.

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: a new module only; add it to `Proofs.lean`, `ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py` green) and each
public theorem to `scripts/Axioms.lean`'s CLEAN section. `lake lint` is not run by kernel jobs (owner ruling, 2026-09-25). Iteration peak
in this lane about 3.4 GB (`--mem 10` is honest). No `native_decide`, no solver; keep the "would have searched here" log.

## Record and paths
Record: `plans/M2-S5K-noparam.md`, with "Theorems this phase proved". Working files: `data/m2/j17k2/`. Budget 300k (harness); hand back
by 380k. Report (rule 9) to `data/crunch-2026-09-25/reports/J17K2.md`, and SendMessage the same text to `"main"`.
