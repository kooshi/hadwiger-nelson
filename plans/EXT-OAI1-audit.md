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
