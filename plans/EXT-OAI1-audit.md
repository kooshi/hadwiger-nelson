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

## Stage 3 — SAVED: the cone, by text, before any build

**The cone.** `data/external/oai1/cone.py` follows the `import` lines of `OAI.Geometry.PlaneColoring.Five` through the release's
`lean/` tree (an import with no file under it is *outside* and is listed, not followed): **70 modules, 30,336 lines, and one
outside import, `Mathlib`** (11 of the 70 import it directly). Print: `data/external/oai1/cone-five.txt`; file list:
`cone-five-files.txt`; graph: `cone-five.json`. The parser is checked against `rg`: 93 import names parsed, 93 `import` lines in
the 70 files; no `module` or `prelude` header.

| part of the cone | modules | lines |
|---|---|---|
| `OAI.Geometry.PlaneColoring` (37 of the directory's 46) | 37 | 14,142 |
| `OAI.Analysis.PlaneSpectrum` | 19 | 8,466 |
| `OAI.MeasureTheory.CompactFactors` | 14 | 7,728 |

The nine modules of the directory outside the cone are the seven-colour side: `Assembly`, `Basic`, `Covering`, `Lattice`, `Main`,
`MeasurableAssembly`, `MeasurableProper`, `Metric`, `Seven`. The two other parts enter through `BorelTransfer`
(`← PlaneSpectrum.Ergodicity`) and through `Transitions` (`← PlaneSpectrum.CircleOperator`). **None of the release's 29 other
direct requirements is imported by the cone.**

**What a kernel would not check, by text** (`data/external/oai1/conegrep.sh`, `rg -P`, over the 70 files; print:
`conegrep-five.txt`). Every count is zero:

| construct | pattern | hits |
|---|---|---|
| `axiom` as a declaration; the word `axiom` anywhere | `^\s*(@[…])*(private |protected |…)*axiom\b`; `\baxiom\b` | 0; 0 |
| `sorry`, `admit`, `sorryAx` | `\bsorry\b`, `\badmit\b`, `sorryAx` | 0, 0, 0 |
| native evaluation | `native_decide`; `decide\s*\+\s*(native|kernel)`; `bv_decide|ofReduceBool|reduceBool|ofReduceNat|reduceNat|trustCompiler` | 0; 0; 0 |
| `implemented_by`, `extern`, `csimp` | the words | 0, 0, 0 |
| `unsafe`, `opaque`, `partial` | the words | 0, 0, 0 |
| any `set_option`; `debug.` / `bootstrap.` / `skipKernelTC` | `set_option`; `skipKernelTC|bootstrap\.|debug\.` | 0; 0 |
| meta-programs and notation: `elab`, `macro`, `syntax`, `notation`, `infix`, `run_cmd`, `run_elab`, `run_meta`, `initialize`, `elab_rules`, `macro_rules`, `#eval`, `#exit`, `#print`, `#check`, `#reduce` | line-initial keywords, `#…` anywhere | 0 |
| `open Lean`, `import Lean`, `Lean.Elab`, `Lean.Meta`, `addDecl`, `Environment` | the words | 0 |
| `attribute [...]` commands | `^\s*(local |scoped )?attribute\s*\[` | 0 |

*Control* (`conegrep-control.txt`): the same script on a scratch copy of `Coloring.lean` with fourteen planted lines — two
`axiom`s (one `private`), `sorry`, `admit`, `native_decide`, `set_option debug.skipKernelTC true in`, `implemented_by`, `unsafe`,
`opaque`, `extern`, `attribute [instance]`, `local notation`, `Lean.ofReduceBool` — reports each (axiom 2 and 2, sorry 1, admit 1,
native 1, reduceBool 1, implemented_by 1, extern 1, unsafe 1, opaque 1, set_option 1, debug 1, notation 1, attribute 1).

**What is in the cone that changes elaboration, and none of it the kernel's check:**
- 18 `local instance` lines in 7 files, of three kinds: `DecidableEq` from `Classical.decEq` (4), and
  `MeasurableSpace Circle := borel Circle` with `BorelSpace Circle := ⟨rfl⟩` (7 pairs). All `local`: none is visible to the
  headline's statement, which mentions `ℂ`, `Fin 5` and the norm only.
- `open scoped Classical` in 11 files. Inline attributes: `@[simp]` 167, `@[simps]` 4, `@[fun_prop]` 3, `@[ext]` 3,
  `@[instance_reducible]` 1 — none affects the kernel.
- 1,981 `theorem`/`lemma` lines and 569 `def`/`abbrev`/`structure`/`class`/`inductive`/`instance` lines; 363 `variable` lines and
  276 `include`/`omit` lines (hypotheses carried by section variables: the headline is closed, so none can reach its statement;
  its stored type is compared in stage 4).

**The build configuration, by text.** The release's `lakefile.lean` sets one option, `leanOptions := #[⟨`autoImplicit, false⟩]`,
and no `moreLeanArgs`, `weakLeanArgs`, plugin or dynlib (`rg` for those words: the one `leanOptions` line). Its `run_cmd` and
`post_update` blocks run `git clone`, `git checkout` and `git apply` on dependency checkouts under `.lake/packages` and nothing
else; I do not run them (next paragraph).

**The Mathlib revision is the official release tag.** In the working copy's checkout of
`https://github.com/leanprover-community/mathlib4.git`, `d13f23b723b8a846827a245b89c10fc7d3f11612` is the commit "chore: bump
toolchain to v4.34.1" (2026-09-24 22:34:32 +0200), carries the tag `v4.34.1`, is contained in `origin/stable`, and its
`lean-toolchain` reads `leanprover/lean4:v4.34.1`. (It is not an ancestor of `origin/master`, as a release-branch commit is not;
a hash served by GitHub can belong to a fork, which is why the tag and the branch were read.) The checkout is unmodified
(`git status --porcelain`: 0 lines).

**My decision on the build** (the brief leaves it to me): since the cone imports nothing outside but `Mathlib`, the working copy
builds with a lakefile **reduced to the Mathlib requirement** — the same package name, toolchain file and `leanOptions`, the
release's `lakefile.lean` and `lake-manifest.json` kept beside it with the suffix `.release`
(`data/external/oai1/lakefile.reduced.lean` is the copy). The release's 29 other direct requirements are not cloned, and its
lakefile's `run_cmd` is not executed. What this cannot show: that the release's full configuration resolves and builds — its own
instruction is `lake update` on the whole package set.

**What the text cannot decide, and where it is decided:** a `sorryAx` or a native axiom reached through a tactic no pattern names
(`#print axioms`, stage 4); the instance and coercions in the stored statement (stage 4); that the 30,336 lines elaborate (the
build, stage 4).

## Stage 4 — SAVED: the build, the axioms, the control, and the statement as the kernel holds it

**The result in one line.** At the release's own toolchain and Mathlib revision the 70 modules of the cone compile from the
release's source with exit 0 and no warning, and

```
'OAI.EuclideanFiveColor.no_proper_five_coloring' depends on axioms: [propext, Classical.choice, Quot.sound]
```

— the three the release's comparator configuration permits, and this repository's standard three.

**The build.** Working copy `/home/kooshi/.cache/ext-oai1/lean/`, a copy of the release's `lean/` directory (the clone is untouched:
`git rev-parse HEAD` still `adc7f124…`, no `.lake` in it). Lean `4.34.1` (commit `5045d0056413266e57c625dcd7c365b10e377c52`,
installed by `elan`); Lake `5.0.0-src+5045d00`. Lakefile: the reduced one of stage 3. `lake update` resolved nine packages —
Mathlib and its eight dependencies — **each at the revision the release's manifest pins** (script comparison, nine of nine
`SAME`; `data/external/oai1/lake-manifest.reduced.json`), and Mathlib's own hook fetched its build from Mathlib's cache (8,908
files): **Mathlib was not compiled here and not replayed here.** The cone: `data/external/oai1/build_cone.py`, one module per
`lake build` call in dependency order, under `scripts/slot.py --mem 10 --cpus 4`; log `data/external/oai1/build-cone.log`:
`build_cone DONE … modules=70 total=778s exit=0`, each batch `exit=0`, 69 `✔ Built` lines and the first module from
`build-first.log`, no `⚠`, `warning` or `error` line. Peak resident memory of one Lean process importing Mathlib: 7.1 GB
(`build-first.log`). The 70 source files in the working copy are byte-identical to the release's (`cmp`, 70 of 70; their hashes:
`cone-five-sha256.txt`), and 70 `.olean` files exist under `.lake/build/lib/lean/OAI/`. Disk used: 11 GB under
`/home/kooshi/.cache/ext-oai1/` (7.7 GB of it Mathlib and its cache).

**The axioms** (`data/external/oai1/audit/Axioms.lean`, run with `lake env lean` under a slot, exit 0; output `Axioms.out`):

```
'OAI.EuclideanFiveColor.no_proper_five_coloring' depends on axioms: [propext, Classical.choice, Quot.sound]
'OAI.EuclideanFiveColor.proper_to_borel_weak' depends on axioms: [propext, Classical.choice, Quot.sound]
'OAI.EuclideanFiveColor.no_measurable_weak_five_coloring' depends on axioms: [propext, Classical.choice, Quot.sound]
'OAI.PlaneFiveColor.Spectral.wild_fourier' depends on axioms: [propext, Classical.choice, Quot.sound]
AXIOM-SET PASS OAI.EuclideanFiveColor.no_proper_five_coloring: 3 axioms, all among the three permitted: …
```

The last line is a positive signal from a set check (`Lean.collectAxioms` against the three names), which throws on any other
axiom; it passes for the headline and for both halves.

**The control fires** (`data/external/oai1/control_sorry.sh`, output `control-sorry.out`). A second tree
(`/home/kooshi/.cache/ext-oai1/control/`: the 70 cone files, the same lakefile, `.lake/packages` symlinked, `.lake/build`
copied) with one line changed — the last line of `OAI.EuclideanFiveColor.positiveSelect_pos` (`BorelTransfer.lean:396`),
`exact (Finset.mem_filter.mp hmem).2`, replaced by `sorry`. Lake rebuilt two modules (`⚠ … BorelTransfer`, `declaration uses
'sorry'`; `✔ … Five`), and the same `Axioms.lean` printed:

```
'OAI.EuclideanFiveColor.no_proper_five_coloring' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]
'OAI.EuclideanFiveColor.proper_to_borel_weak' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]
'OAI.EuclideanFiveColor.no_measurable_weak_five_coloring' depends on axioms: [propext, Classical.choice, Quot.sound]
error: AXIOM-SET FAIL OAI.EuclideanFiveColor.no_proper_five_coloring: outside the permitted three: [sorryAx]
```

exit 1. The plant is two modules below the headline and reaches it; the half that does not use the planted lemma stays clean.

**The statement as the kernel holds it — by elaborated signature, not by name.**
`data/external/oai1/audit/ChallengeDump.lean` imports the release's *challenge* module (built here: `⚠ … declaration uses
'sorry'`, as a challenge must) and `SolutionDump.lean` imports the *solution* module; each prints, from its own environment,
the stored type and value of `OAI.EuclideanFiveColor.ProperColoring` and the stored type of
`OAI.EuclideanFiveColor.no_proper_five_coloring` in a canonical form of my own (de Bruijn indices, full constant names with
universe arguments, every implicit and instance argument, binder kinds, and no bound-variable names). Both exit 0, and
**the two prints are byte-identical** (`cmp` exit 0; sha256 `24aea7aa…0416fca` both). *Control*: `ControlDump.lean`, the
challenge with `Measurable coloring →` added inside the definition, prints differently (`cmp` exit 1). The print:

```
ProperColoring : def levels=[]
  type  = (pi.d (c Nat []) (pi.d (pi.d (c Complex []) ((c Fin []) #1)) (Sort 0)))
  value = λ (k : Nat) (c : Complex → Fin k), ∀ x y : Complex,
            @Eq Real (@Norm.norm Complex Complex.instNorm (@HSub.hSub Complex Complex Complex (@instHSub Complex Complex.instSub) x y))
                     (@OfNat.ofNat Real 1 (@One.toOfNat1 Real Real.instOne))
            → @Ne (Fin k) (c x) (c y)                                   -- transcribed from the dump; the dump itself is in SolutionDump.dump
no_proper_five_coloring : theorem levels=[]
  type  = Not (@Exists (Complex → Fin 5) (λ c, OAI.EuclideanFiveColor.ProperColoring 5 c))        -- `5` is `@OfNat.ofNat Nat 5 (instOfNatNat 5)`
```

So the norm is Mathlib's `Complex.instNorm`, the subtraction `Complex.instSub`, the `1` the real number one, the colours `Fin 5`,
and there is no hidden argument, coercion or instance beyond those. The proved theorem is the challenge's statement.

**Restatements, each closed by the release's theorem and checked by the kernel here** (`data/external/oai1/audit/Statement.lean`,
`lake env lean`, exit 0, every `#print axioms` the standard three; output `Statement.out`):

| name (the audit's) | statement |
|---|---|
| `AuditChallenge.no_proper_five_coloring` | the challenge's two declarations, text copied character for character into another namespace, closed by `OAI.EuclideanFiveColor.no_proper_five_coloring`; and `example : @AuditChallenge.ProperColoring = @OAI.EuclideanFiveColor.ProperColoring := rfl` |
| `audit_unfolded` | `¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y` |
| `audit_norm` | `∀ z : ℂ, ‖z‖ = Real.sqrt (z.re ^ 2 + z.im ^ 2)` — the norm in the statement is the Euclidean modulus |
| (example) | `ProperColoring k c → c 0 ≠ c 1` — the definition's premise is not vacuous |
| `audit_mono` | `∀ c : ℂ → Fin 5, ∃ x y : ℂ, ‖x - y‖ = 1 ∧ c x = c y` |
| **`audit_real`** | **`∀ c : ℝ × ℝ → Fin 5, ∃ p q : ℝ × ℝ, (p.1 - q.1) ^ 2 + (p.2 - q.2) ^ 2 = 1 ∧ c p = c q`** — no `ℂ`, no norm, no square root: real pairs and a polynomial identity |
| `audit_euclidean` | `¬ ∃ c : EuclideanSpace ℝ (Fin 2) → Fin 5, ∀ x y, dist x y = 1 → c x ≠ c y` — the model of the release's own seven-colour theorem and of this repository's row 33 |
| `audit_chromaticNumber` | `6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`, with this repository's `unitDistance` copied in |

`audit_real` is the reading I would hand a sceptic: every map from `ℝ × ℝ` to five colours gives one colour to two points whose
coordinate differences satisfy `Δ₁² + Δ₂² = 1`.

**What stage 4 did not check.** (1) Mathlib's compiled declarations: taken from Mathlib's cache for the tag `v4.34.1`, loaded
by the kernel as stored, not re-checked here. (2) The release's full configuration — its 42-package manifest and its lakefile's
patching hooks — was not resolved or built; the cone needs none of it. (3) The release's comparator was not run (stage 5).
(4) Nothing here says anything about the 9.2 million other lines of the release's library, or about the manuscript's prose.

**An incident of mine during this stage, reported to the coordinator at once.** To read the usage of `leanchecker` (the
kernel-replay tool shipped in the toolchain) I ran `lake env leanchecker --help` outside a slot, three times between 02:00:15
and 02:02:50 UTC. The binary knows no such flag and, with no module named, replays every module on the search path on all
threads: the kernel's OOM killer fired globally twice (pids 790279 and 793251, anon-rss 119.1 GB and 118.1 GB), killing only
those two processes; the third I killed by PID at 95 GB. The first kill was hidden from me by a pipe into `head` (rule 9's pipe
clause, broken). Kernel and journal lines: `data/external/oai1/incident-oom.txt`. No other process was killed; my slotted build
survived (one batch took 83 s against a usual 7 s). Nothing of mine has run outside a slot since.
