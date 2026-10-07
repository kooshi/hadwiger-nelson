# EXT-OAI1 — audit of an outside release's Lean proof that the plane is not five-colourable

*de Bruijn, an outside-audit job (brief: `data/external/briefs/EXT-OAI1-outside-five-colour-lean.md`). The record reports what the
files state and what the kernel says of them. Everything under `/home/kooshi/source/math` is outside content, read and never written;
the working copy is `/home/kooshi/.cache/ext-oai1/`; scripts, logs and prints are under `data/external/oai1/`.*

## Theorems this phase proved

None of ours. What the kernel checked here of the release's theorems is stated stage by stage, and collected in the last stage.

## Stage 1 — SAVED: the readback, and the object

**The brief's quotations.** `data/external/oai1/readback.py` reads every quotation of the brief (a run of `> ` lines closed by
`> — source: <path>`) and looks for its whitespace-normalized text in its source: `quotations=13 missing=0`, exit 0
(`data/external/oai1/readback.log`). Control: one letter changed in the third quotation (the catalogue's claim) gives
`MISS [3]`, `missing=1`, exit 1 (`readback-control.log`). The brief's listed facts also hold: the directory
`lean/OAI/Geometry/PlaneColoring/` has 46 `.lean` files and 14,661 lines; `formalization.yaml` lines 1146–1148 name
`OAI.EuclideanFiveColor.no_proper_five_coloring` in `OAI/Geometry/PlaneColoring/Five.lean` with the comparator configuration
`ComparatorChallenges/EuclideanFiveColor.json`.

**The object.**

| item | value |
|---|---|
| clone | `/home/kooshi/source/math`, of `https://github.com/openai/math` |
| commit | `adc7f1241b42e322a6451854ab7e4b4c146bf78a`, "Initial commit", author "Anonymous", 2026-10-06 14:58:50 -0700; `git rev-list --count HEAD` = 1 |
| Lean toolchain | `leanprover/lean4:v4.34.1` (`lean/lean-toolchain`) |
| Mathlib | `https://github.com/leanprover-community/mathlib4.git` at `d13f23b723b8a846827a245b89c10fc7d3f11612` (`lean/lake-manifest.json`, and the same hash in `lean/lakefile.lean`'s `require mathlib`) |
| other packages | the manifest pins 42 packages in all: 30 direct requirements (Mathlib, 11 from `github.com/lana-agents`, PrimeNumberTheoremAnd, carleson, sphere-eversion, and others) and 12 inherited (batteries, aesop, Qq, proofwidgets, plausible, importGraph, LeanSearchClient, Cli, and doc-gen4's four). `lakefile.lean` clones and patches eleven of them from a `run_cmd` at configuration time and patches twelve more in a `post_update` hook, from `lean/patches/*-lean4341.patch` |
| options | `leanOptions := #[⟨`autoImplicit, false⟩]`; one `lean_lib OAI` and per-area libraries; `lean_lib ComparatorChallenges where globs := #[`ComparatorChallenges.+]` |
| licence | Apache License, Version 2.0, January 2004 (`LICENSE`, and a byte-identical `lean/LICENSE`); the catalogue's `license: "Apache-2.0"`, `authors: ["OpenAI"]` |
| the manuscript | `preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/paper.pdf` (sha256 `607c2601…5111d36`, 450,880 bytes), with its TeX under `build/` (`main.tex`, eight sections: introduction, transfer, spectral, transitions, palettes, rigidity, angular, interfaces). "**Author:** OpenAI", "**Date:** September 23, 2026" (its `README.md`) |
| sha256 | `Five.lean` `d08f4265…337c2309`; the challenge `.lean` `7055ba6e…bbe957cd`; the challenge `.json` `46b5d2c6…edf81b39`; `lake-manifest.json` `cf6105a2…cccc0794`; `lakefile.lean` `4cca977e…c7279e74` |

**What the release says about checking a result** (each quoted whole).

> This directory contains Lean formalizations of some results in this repository.
> They are organized in a single large library, so we recommend compiling only small portions at a time.
>
> See the [Comparator README](ComparatorChallenges/README.md) for more information about how to verify the results.
> — source: /home/kooshi/source/math/lean/README.md

> # [Comparator](https://github.com/leanprover/comparator) challenges
>
> Install `comparator`, `landrun`, and `lean4export`, and make them available on `PATH`.
> Then, from `lean/`:
>
> ```sh
> lake update
> lake exe cache get
> lake env comparator ComparatorChallenges/QuasiRiemannHypothesis.json
> ```
> — source: /home/kooshi/source/math/lean/ComparatorChallenges/README.md

The comparator configuration for this result, whole (`lean/ComparatorChallenges/EuclideanFiveColor.json`): challenge module
`ComparatorChallenges.EuclideanFiveColor`, solution module `OAI.Geometry.PlaneColoring.Five`, `theorem_names`
`["OAI.EuclideanFiveColor.no_proper_five_coloring"]`, `definition_names` `["OAI.EuclideanFiveColor.ProperColoring"]`,
`permitted_axioms` `["propext", "Quot.sound", "Classical.choice"]`, `"enable_nanoda": false`.

And of the collection, from its `README.md`: "This repository contains mathematical manuscripts and supporting proof artifacts
produced by an internal OpenAI model."; "This collection includes results at different stages of verification. Not all have
accompanying Lean formalizations."; "The current catalogue contains 722 manuscripts organized into 372 families."

**First sight of the solution module, by listing** (no finding yet): `Five.lean` is 131 lines; its headline's proof is three
lines — `proper_to_borel_weak` (a proper colouring gives a Borel one proper at almost every unit pair) and
`no_measurable_weak_five_coloring`.

## Stage 2 — SAVED: the statement, read aloud (by text; the elaborated comparison is stage 4's)

**The challenge file, whole** (`/home/kooshi/source/math/lean/ComparatorChallenges/EuclideanFiveColor.lean`, 15 lines):

```lean
import Mathlib

namespace OAI

namespace EuclideanFiveColor

def ProperColoring (colorCount : ℕ) (coloring : ℂ → Fin colorCount) : Prop :=
  ∀ point otherPoint : ℂ, ‖point - otherPoint‖ = 1 → coloring point ≠ coloring otherPoint

theorem no_proper_five_coloring : ¬ ∃ coloring : ℂ → Fin 5, ProperColoring 5 coloring := by
  sorry

end EuclideanFiveColor

end OAI
```

**Read aloud.** A map `coloring` from `ℂ` to `Fin colorCount` is a *proper colouring* when, for every two points of `ℂ` whose
difference has norm exactly `1`, the two points get different values. The theorem: there is no map from `ℂ` to `Fin 5` that is a
proper colouring. That is the informal claim — "every five-colouring of the plane has two points at distance exactly 1 of one
colour" — with the plane as `ℂ` under its norm, and by text nothing weaker:

- **No hypothesis in the definition.** `ProperColoring` has one clause, the universally quantified implication. Its premise is
  satisfiable (`‖0 − 1‖ = 1`), so it constrains every map; nothing restricts `point ≠ otherPoint` beyond the distance itself, and
  nothing excludes a set of pairs.
- **No restriction on the map.** The existential ranges over all of `ℂ → Fin 5`: no measurability, continuity or Borel
  hypothesis, no structure, no class argument, no instance argument. `Fin 5` has five elements; the colour count `5` appears twice
  and is the same literal both times.
- **No trick of notation, by text.** The file imports `Mathlib` and nothing else, opens nothing, and declares no notation,
  instance, attribute, macro or option; so `ℂ`, `‖·‖`, `-`, `=`, `1`, `≠`, `Fin` are Mathlib's at the pinned revision. Its non-ASCII
  characters are the eight expected code points and no look-alike (U+00AC ¬, U+2016 ‖, U+2102 ℂ, U+2115 ℕ, U+2192 →, U+2200 ∀,
  U+2203 ∃, U+2260 ≠). The `1` is a real number, because the norm is real-valued. Which `Norm ℂ` instance elaboration picks, and
  that it is the Euclidean modulus `√(re² + im²)`, is checked by the kernel in stage 4, not asserted here.
- **`ℂ` against `ℝ²`.** The claim is about the Euclidean plane; `ℂ` with its norm is isometric to `EuclideanSpace ℝ (Fin 2)`
  (in this repository, `chromaticNumber_plane_eq_complex`, `Proofs/HadwigerNelson/Reduction.lean:51`, through
  `Complex.orthonormalBasisOneI`). The release does not state that bridge in the cone; see the note below.

**The proved theorem, by text.** `OAI/Geometry/PlaneColoring/Coloring.lean:7–8` (imports `Mathlib` only; nothing precedes it
but the two `namespace` lines):

```lean
def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y
```

and `OAI/Geometry/PlaneColoring/Five.lean:123–127`, inside `namespace OAI`, `noncomputable section`, `open scoped Classical`,
`open Set Filter Topology MeasureTheory`, `namespace EuclideanFiveColor`:

```lean
/-- No unrestricted five-coloring separates all unit-distance pairs in the Euclidean plane. -/
theorem no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c := by
  rintro ⟨c,hc⟩
  obtain ⟨d,hd,hw⟩ := proper_to_borel_weak hc
  exact no_measurable_weak_five_coloring hd hw
```

Both are the challenge's declarations with the bound variables renamed (`colorCount`/`k`, `coloring`/`c`, `point`/`x`,
`otherPoint`/`y`) and nothing else changed. In the cone the name `ProperColoring` is declared once
(`rg "def ProperColoring"` over the 70 files: `Coloring.lean:7` only), so the theorem's `ProperColoring` is that definition unless
an opened namespace supplies another — which the elaborated comparison of stage 4 decides, by signature and not by name.

**Two notes, neither a defect of the theorem.**
1. *The two ends are stated in two models and never joined.* The release's seven-colour theorem
   (`OAI.Problem160.properColoring_seven`, `OAI/Geometry/PlaneColoring/Seven.lean:36`, outside this cone) is about
   `EuclideanSpace ℝ (Fin 2)` with `dist x y = 1`, in a different namespace with its own `ProperColoring (k : ℕ) : Prop`
   (`Basic.lean:26`, an existential); the five-colour theorem is about `ℂ` with `‖x − y‖ = 1`. `rg` over the whole library finds
   `no_proper_five_coloring` in two files only, the challenge and `Five.lean`: the catalogue's sentence "only six and seven remain
   possible chromatic numbers of the plane" is not a Lean statement in the release. It follows from the two theorems by the
   isometry `ℂ ≃ᵢ EuclideanSpace ℝ (Fin 2)`, one line here (stage 7).
2. *The proof's second line is a theorem this project holds only conditionally.* `proper_to_borel_weak`
   (`BorelTransfer.lean:436`) is stated for every `k` with `[NeZero k]`: a proper `k`-colouring of `ℂ` gives a Borel `k`-colouring
   `d` with `WeakColoring k d` — `AEMeasurable d ∧ ∀ᵐ p ∂(volume.prod angularMeasure), d p.1 ≠ d (p.1 + direction p.2)`
   (`Coloring.lean:27–29`), proper at almost every unit pair. That is `χ_m⁰(ℝ²) ≤ χ(ℝ²)`, the direction `LEDGER.md` rows 128 and
   130 hold given MR, at [hand]. Listed, not judged; stage 6 reads it.
