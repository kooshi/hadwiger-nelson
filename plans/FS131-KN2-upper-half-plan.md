# FS131-KN2 — the residue upper half: statements typed, the skeleton, and a plan per leaf

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-KN2-upper-half-plan.md`; branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`. Opened 2026-10-13. Working files: `data/fs131/kn2/`. Successor of FS131-KN1, whose record is
`plans/FS131-KN1-number-field-kernel-map.md`. The stages below are saved in order; a successor resumes at the first stage not
marked SAVED.*

## Theorems this phase proved

A planning job; what it proved is what typing showed to be a corollary of the library. Each is in
`Proofs/HadwigerNelson/Arith/UpperHalf.lean`, namespace `HadwigerNelson.UpperHalf`, elaborated by `lake env lean` and by the
build of stage 3; none has been through the gate (no axiom audit was run by this job).

- `nonempty_hom_unitQuadrance`, `nonempty_hom_finitePlane` — the residue homomorphism at a usable prime, with no transcendental.
- `chromaticNumber_planeOver_le_unitQuadrance`, `chromaticNumber_planeOver_le_finitePlane` — **NF1-S1A, both clauses**.
- `colorable_planeOver_of_finitePlane` — the form the instances call.
- `coe_conjO`, `conjO_conjO`, `conjO_mem_iff`, `mem_localRing_of_mul_conj_eq_one`, `residue_algebraMap` — API of the
  definitions.
- Proved **from leaves that are still `sorry`** (so not theorems yet): `nonempty_hom_levelTarget_one`,
  `chromaticNumber_planeOver_le_levelTarget`, `chromaticNumber_planeOver_le_localBound`,
  `chromaticNumber_eq_localBound_of_chain`, and the instances of stage 3.

## Stage 1 — SAVED: the readback

**The brief's quotations.** Nine blocks: `W2` against `data/fs131/REQUEST-2026-10-13.md`, and `NF1-S1A`, `NF1-S1B`, `NF1-S2`,
`NF1-MODULE`, `NF1-WAIT-S1A`, `NF1-WAIT-S1B`, `NF1-WAIT-S2`, `NF1-NC` against `data/fs131/claims-NF1.md`, compared character for
character by `data/fs131/kn2/readback.py`: nine `IDENTICAL`. The claim list's three leaves and their waiting rows against the
second and third columns of the map's § X1 table (`[S1a]`, `[S1b]`, `[S2]`): six `IDENTICAL`. Control (`--control`: one word
changed in every quotation): fifteen `DIFFERS`. **No mismatch.** (The brief says "the eight quoted lines"; eight are from the
claim list and the ninth is Kooshi's word.)

**What each statement is typed over, read from the source.**

| symbol | declaration | where | what it is, as declared |
|---|---|---|---|
| `planeOver F` | `HadwigerNelson.planeOver (F : Subfield ℝ) : Set ℂ` | `SquareClass.lean:63` | `{z | z.re ∈ F ∧ z.im ∈ F}` |
| `χ(planeOver F)` | `((unitDistance ℂ).induce (planeOver F)).chromaticNumber` | `UnitDistance.lean:40`; Mathlib | `unitDistance V` has `Adj x y := dist x y = 1`; `chromaticNumber : ℕ∞` |
| `unitQuadrance R` | `SimpleGraph (R × R)` | `UnitQuadrance.lean:51` | the Cayley graph on `{v | v.1² + v.2² = 1}` |
| `finitePlane p` | `abbrev … := unitQuadrance (ZMod p)` | `UnitQuadrance.lean:57` | |
| `Arith.IsUsablePrime 𝔭` | `{F : Subfield ℝ} (𝔭 : Ideal (𝓞 F)) : Prop` | `Arith/PlaceHom.lean:25` | `𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) % 4 = 3` |
| `fieldI F` | `abbrev … : Subfield ℂ := UnitRing.planeOverSubfield F` | `SpectralChain.lean:254` | carrier `planeOver F` (`mem_fieldI` is `Iff.rfl`) |
| `conjO F` | `𝓞 (fieldI F) →+* 𝓞 (fieldI F)` | `SpectralChain.lean:276` | `RingOfIntegers.mapRingHom (conjOn (fieldI_conj F))` |
| `StablePrime F` | structure | `SpectralChain.lean:279` | `P : Ideal (𝓞 (fieldI F))`, `isMaximal`, `comap_conj : P.comap (conjO F) = P` |
| `levelTarget P m` | `SimpleGraph (𝓞 (fieldI F) ⧸ P.P ^ m)` | `SpectralChain.lean:294` | `fromRel fun x y => (x − y) * quotientMap (P.P ^ m) (conjO F) _ (x − y) = 1` |
| `localBound F` | `ℕ∞` | `SpectralChain.lean:301` | `⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber` |
| `ℚ(√d)`, `ℚ(√D)` | `SquareClass.fieldOfRadicands (D : Set ℕ) : Subfield ℝ` | `SquareClass.lean:306` | `Subfield.closure ((fun d : ℕ => √d) '' D)` |

Three things the source shows that the map's summary does not:

1. **`levelTarget P 1` lives on `𝓞 ⧸ P.P ^ 1`, not on `𝓞 ⧸ P.P`**: every statement about level one is a statement about the
   ideal `P.P ^ 1`. Typed at a general level `m` this costs nothing and removes the mismatch (stage 2).
2. **The library holds no `NumberField` instance for `fieldOfRadicands D`** (grep: the only instances on a `Subfield ℝ` or
   `Subfield ℂ` are `fieldI F` and `StandingFive.standingField`). The claim's "with its `NumberField` instance" is a leaf.
3. **Mathlib at the pin holds the localization at a prime of a Dedekind domain as a valuation subring**
   (`IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, with its `IsLocalization` instance, and
   `ValuationSubring.eq_of_le_of_ne_top`), so `[S1b]` needs no restatement of `Arith/PlaceHom`'s two localization lemmas — the
   map's estimate ("must be restated for a number field given as `fieldI F`") is retired.

**The first measurement of this machine** (laptop, 12 cores, 31 GiB; `data/fs131/kn2/logs/`): one `lake env lean` under the
slot at `--mem 8 --cpus 2` on a probe importing `Arith/PlaceHom`, `SpectralChain` and Mathlib's `Padics` — **23.8 s wall, 3.56 GB
peak** (first read of the `.olean`s); `Arith/UpperHalf.lean` (225 lines, eleven `sorry`) afterwards — **3.0 s, 3.59 GB**.
