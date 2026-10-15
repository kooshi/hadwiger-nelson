# Hadwiger–Nelson in Lean 4

How many colours does the plane need so that no two points at distance exactly 1 get the same colour? This number, χ(ℝ²), is
called the chromatic number of the plane. It has been known since 1950 to be one of 4, 5, 6 or 7. De Grey (2018) ruled out 4. An
outside Lean development, `[OAIMath2026]`, ruled out 5 in 2026. So today χ(ℝ²) is 6 or 7.

This repository is a Lean 4 library on Mathlib. Lean's kernel has checked every theorem in it, and nothing it rests on is hidden:
its few outside assumptions are named, cited and audited. The library holds the classical bounds `5 ≤ χ(ℝ²) ≤ 7` on Lean's three
standard axioms alone. It also holds `6 ≤ χ(ℝ²) ≤ 7` on one more axiom: the outside development's theorem that no proper
five-colouring of the plane exists. It reduces the question of six against seven to one statement about measurable colourings.
And it holds exact chromatic numbers for planes over number fields, `F²` for subfields `F ⊂ ℝ` of finite degree over ℚ.

This page says what the library proves, what each result rests on, whose mathematics it is, and how to check it. It does not argue
the mathematics. [`ROADMAP.md`](ROADMAP.md) lists what is not yet formalized.

## Results

Each statement below is a plain-words reading of the stored type of the theorem named beside it. The axiom lists are exactly
what `#print axioms` printed on 2026-10-15 from the library as gated at commit `eee71c74c`. Keys in brackets, like
`[Fischer1990]`, are entries of `BIBLIOGRAPHY.md`. **std3** means `[propext, Classical.choice, Quot.sound]`, Lean's
standard three axioms. **W**, **EL** and **O5** are the three outside theorems the library declares as axioms (see
[What the library assumes](#what-the-library-assumes)). Every name is under the namespace `HadwigerNelson`. The "ledger" column gives
the row of `LEDGER.md` where the result, its grade and its sources are recorded.

### The plane

| statement, in words | Lean name | rests on | whose | ledger |
|---|---|---|---|---|
| The plane needs at least 4 colours (the Moser spindle). | `four_le_chromaticNumber_plane` | std3 | classical; the kernel proof checks all `3⁷` colourings | rung A |
| The plane needs at least 5 colours. | `chromaticNumber_plane_ge_five` (de Grey's 1581-vertex graph); also `chromaticNumber_plane_ge_five_510` and `_553` (Heule's two smaller graphs) | std3 | the graphs and the bound are de Grey's (2018) and Heule's. The kernel check, through an LRAT checker the kernel can run, is this project's | rung B |
| `5 ≤ χ(ℝ²) ≤ 7` | `chromaticNumber_plane_interval` | std3 | the seven-colouring is classical: "The colouring is classical; ours is the certificate." | 33 |
| `6 ≤ χ(ℝ²) ≤ 7` | `Outside.OAI158.chromaticNumber_plane_six_or_seven` | std3 + **O5** | `[OAIMath2026]`'s theorem. It is kernel-checked in that release's own library, which was built and audited here, and it enters this library as a declared axiom | 33 |
| χ(ℝ²) equals `χ_m⁰(ℝ²)`: the least `k` for which some Borel `k`-colouring of the plane is proper at almost every unit-distance pair (in each colour class, the pairs at distance 1 form a null set). | `Outside.OAI158.chromaticNumber_plane_eq_chiM0` | std3 | `[OAIMath2026]` Thm 1.3 (its transfer theorem, whose proof is ported here and checked by this kernel), together with the direction `χ ≤ χ_m⁰`, whose argument is in print (`[GwynStavrianos2022]` Lemma 2, Thm 2). Not this project's mathematics | 130 |
| χ(ℝ²) also equals Falconer's measurable chromatic number: Lebesgue-measurable colour classes, proper at every pair. | `Plane.chromaticNumber_plane_eq_chiLebesgue` | std3 | `[Davies2026]` Lemma B.1 composed with `[OAIMath2026]`'s transfer: other people's mathematics, composed and formalized here | 130 |
| `7 ≤ χ(ℝ²)` exactly when `µ₆(ε)` stays below 1 as ε → 0. Here `µ₆(ε)` is the largest upper density that six disjoint measurable classes can cover when, in each class, the pairs at distances in `[1 − ε, 1 + ε]` form a null set. Stored as `7 ≤ χ ↔ ⨆ ε > 0, µ₆(ε) < 1`. | `Outside.OAI158.seven_le_chromaticNumber_plane_iff` | std3 | prior art: not found in print as an equivalence. The conditional form is in `[SokolovVoronov2025]` §9 | 131 |
| `7 ≤ χ(ℝ²)` exactly when some open disc about the origin has no measurable six-colouring that is proper at almost every unit pair inside it. | `Plane.seven_le_chromaticNumber_plane_iff_exists_ball` | std3 | the disc form for such colourings: prior art not found in print. The direction toward seven is `[OAIMath2026]`'s transfer, restricted to a disc | 161 |
| The density equality: `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`. In words, the infimum of `α(G)/|G|` over finite point sets of the plane (and of the algebraic plane `𝒜²`) equals the supremum of the upper densities of measurable sets with no two points at distance 1. Also `χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, and `f(n)/n → m₁(ℝ²)`, where `f(n)` is the least independence number of a unit-distance graph on `n` points of the plane. | `OneClass.finIndepRatio_plane_eq_mOne`, `OneClass.finIndepRatio_algPlane_eq_mOne`, `OneClass.fractionalChromaticNumber_plane`, `OneClass.fractionalChromaticNumber_algPlane`, `OneClass.tendsto_minIndepNum_div` | std3 | For the plane: prior art not found in print. `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up. In the plane, `f(n)/n → m₁(ℝ²)` is the first clause of `[DuczVarga2026]`'s Conjecture 1, and `χ_f(ℝ²) = 1/m₁(ℝ²)` is the equality that `[MatolcsiEtAl2025]` §2 calls not known. The rigidity step is `[OAIMath2026]`'s, ported. The kernel proof is this project's | 129 |
| The density bound: every Lebesgue-measurable planar set with no two points at distance 1 has upper density at most `0.2470` about every centre. So `m₁(ℝ²) ≤ 0.2470 < 1/4`. | `Plane.oneAvoidingDensityBound`, `Plane.mOne_le_0_2470`, `Plane.mOne_lt_one_quarter` | std3 | `[AmbrusEtAl2023]` Theorem 1. The proof starts from the paper's own certificate and needs no Bessel-function citation; the route, the formalization and the kernel check are this project's | 129 |

### Planes over number fields

`χ(F²)` is the chromatic number of the unit-distance graph on `F² = {z ∈ ℂ : Re z, Im z ∈ F}`. **L(F)**, the *local bound*,
is defined as follows. For each prime ideal of `F(i)` that complex conjugation maps to itself, take the residue ring `𝓞/P`. Form
the finite graph on it whose edges are the differences `x` with `x·x̄ = 1`. L(F) is the least chromatic number of these finite
graphs (`SpectralChain.localBound`).

| statement, in words | Lean name | rests on | whose | ledger |
|---|---|---|---|---|
| `χ(ℚ(√3, √11)²) = 4` ("Theorem B") | `chromaticNumber_seamPlane` | std3 | the value is `[Fischer1994]`'s. The kernel proof is this project's, by a residue colouring with values in 𝔽₄, which is a different colouring from his | 57 |
| `χ(F²) ≤ L(F)` for every real number field. Also `χ(F²) ≤ χ(UD(𝔽_p, 2))`, the unit-distance graph of the finite plane `𝔽_p²`, at any prime of `F` whose residue field is `𝔽_p` with `p ≡ 3 (mod 4)`. | `UpperHalf.chromaticNumber_planeOver_le_localBound`, `UpperHalf.chromaticNumber_planeOver_le_finitePlane` | std3 | the bound is `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19 and `[Madore2015]` Cor. 3.4. The kernel proof is this project's | 52 |
| `χ(ℚ²) = 2`. `χ(ℚ(√11)²) = 4`. | `UpperHalf.chromaticNumber_planeOver_rat`, `UpperHalf.chromaticNumber_planeOver_eleven` | std3 | `χ(ℚ²) = 2` is Woodall's value; the mechanism is in `[Fischer1990]` Thm 8 and `[Moorhouse2010]` Thm 7. For ℚ(√11), the upper bound is `[Moorhouse2010]`'s and `[Fischer1990]`'s, and a lower bound above three for a real quadratic field: prior art not found in print | 63, 73 |
| For squarefree `m`, `χ(ℚ(√m)²)` is 2 when `m ≢ 3 (mod 4)` and 3 when `m ≡ 3, 7 (mod 12)`. When `m ≡ 11 (mod 12)` it is at least 4, and exactly 4 unless `m ≡ 47, 143, 167 (mod 168)`. | `ThreeFourColours.chromaticNumber_planeOver_sqrt_table` | std3 | the values 2 and 3 and the upper bounds are `[Fischer1990]`'s (Thms 8, 9, 10(i)). The lower bound of four: prior art not found in print | 73, 82, 99 |
| A non-bipartite `F²` is 3-colourable exactly when some prime of `F` has residue field 𝔽₃. `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`. And `χ(F²) = L(F)` whenever `L(F) ≤ 4`. | `ThreeFourColours.chromaticNumber_planeOver_eq_three_iff`, `…_le_three_iff`, `…_eq_localBound_of_le_four` | std3 + **W** | The question is `[Fischer1990]` §1's: is there an algebraic criterion for χ(F²)? It is also `[Johnson2000]`'s Problem 4.4. The answer at this range: prior art not found in print | 99 |
| `min(L(F), 5) ≤ χ(F²)` for every real number field, with no further hypothesis. With the upper bound `χ(F²) ≤ L(F)` it gives `χ(F²) = L(F)` whenever `L(F) ≤ 5`; that composition is not yet stored as one theorem. | `Rigidity.min_localBound_five_le_chromaticNumber` | std3 + **EL** + **W** | The "local–global" conjecture `χ(F²) = L(F)` is this project's. The question is `[Fischer1990]` §1's. Measure rigidity for the unit-vector group of a number field, and the five: prior art not found in print. The route from **EL** to the number field (two deductions of this project's) is kernel-checked here | 123 |
| `χ(ℚ(√47)²) = 5`. Also `χ = 5` over ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3, √5), and `χ(ℚ(√167)²) ≥ 5`. | `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`; `SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five` (and `…311…`, `…335…`, `…sqrt3_sqrt5…`), `SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167` | std3 + **EL** + **W** | The lower half: prior art not found in print. The upper half `≤ 5` is prior art (the plane at 11) and holds on std3 alone (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`). `[Moorhouse2010slides]` asks for χ(ℚ(√47)²) by name. `[Davies2026]` p. 5 asks the question by residue class modulo 168, and the field of √47 lies in one of those classes. No finite five-chromatic graph is exhibited | 121, 123 |
| Adding a transcendental changes nothing: `χ(F(t)²) = χ(F²)`. | `RouteC.chromaticNumber_planeOver_adjoin_transcendental_eq` | std3 | `[Fischer1990]` Thm 6. The kernel proof is this project's | 104 |

`LEDGER.md` holds 167 rows. Each row is one result with its grade, where it lives in the library or the records, and its
attributions; its "claim list" says what is this project's and what is not. A row that the ledger marks `[hand]`, `[tools]` or
`[cert]` is not, or not wholly, in the kernel, and [`ROADMAP.md`](ROADMAP.md) lists those rows.

"Prior art: not found in print" is a statement about searches that are recorded in the ledger. It is not a claim of priority.

## What the library assumes

Everything here reduces to what Lean's kernel checked plus what is listed in this section.

**Three outside theorems, declared as axioms.** Each axiom is stated in its source's own form. Its statement is read back against
the source, it has a model of its hypotheses in its file, and it is listed in `ARCHITECTURE.md` § 5:

- **W**, `StandingFive.kloosterman_bound`: Weil's bound for Kloosterman sums. Over a finite field of characteristic not 2, with
  `ψ` a nontrivial additive character and `4cd = a ≠ 0`, it says `‖Σ_{x≠0} ψ(cx + dx⁻¹)‖ ≤ 2√q` (`[Weil1948]` p. 207).
- **EL**, `Rigidity.positive_entropy_rigidity`: Einsiedler and Lindenstrauss's positive-entropy rigidity for `ℤ^d`-actions
  (`d ≥ 2`) on solenoids with no virtually cyclic factors (`[EinsiedlerLindenstrauss2022]` Theorem 1.3).
- **O5**, `Outside.OAI158.no_proper_five_coloring`: no map `ℂ → Fin 5` gives different colours to every two points at distance 1
  (`[OAIMath2026]` family 158). The axiom's statement is the release's stored statement, term for term.

Two more pieces of `[OAIMath2026]` are not assumed: their proofs are ported into `Proofs/HadwigerNelson/Outside/` and checked by
this kernel. They are its transfer theorem `Outside.OAI158.proper_to_borel_weak` and its rigidity step
`Outside.OAI158.Spectral.residual_fourier`. The ported files keep the release's Apache 2.0 licence
(`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`).

**Five native-evaluation purchases.** These are declarations that use `native_decide`, so they trust Lean's compiler rather than
its kernel. All five are in `Instances/SpindleBound.lean`. They are cross-checks of the SAT encoding on the Moser spindle, and
no headline theorem rests on them.

**Hypotheses.** Some theorems take an outside result, or a result of this project not yet formalized, as an explicit hypothesis.
An example is "if Herglotz–Bochner holds, then …". Such a theorem prints the standard three axioms, so `scripts/assumptions.sh`
lists every one: 33 hypotheses, taken in 108 (hypothesis, theorem) pairs. None of the results in the tables above takes any.

**The audit at the last full gate** (2026-10-15) checked 11,284 records. 10,650 rest on the standard three axioms or fewer, 569
on no axiom at all, 60 on at least one of W, EL, O5, and 5 are the purchases. (The 10,650 rest on a subset of the standard
three.) No record rests on `sorry`. The independent replay
`lean4checker` has not been run on the current tree; it is the publication gate and is listed in the roadmap.

## How to check it

**Toolchain.** Lean `v4.32.0` and Mathlib at tag `v4.32.0`, pinned by `lean-toolchain` and `lakefile.toml`. Install
[elan](https://github.com/leanprover/elan) (`./install-toolchain.sh` does it). Then fetch Mathlib's prebuilt files:

```bash
lake exe cache get
```

**Build.** Use `./scripts/build.sh`; never run a bare `lake build`. Some modules peak near 9 GB of memory, and Lake sizes its
job pool from the machine, so an unbounded build can ask for hundreds of gigabytes. The script builds modules in dependency
order, in batches of `BATCH` (default 10), each under a memory cap of `MEMMAX` (default `100G`). It needs Linux with `systemd`
user scopes and `python3`. Set both variables for your machine:

```bash
BATCH=2 MEMMAX=24G ./scripts/build.sh      # --plan prints the batches and builds nothing
```

On Arch Linux, `source scripts/dev-env.sh` first: the toolchain's bundled `clang` fails against Arch's system LLVM.

**The gate**, after a build. Each step is a script, and each script has a `--self-test` that plants faults and checks that every
one is caught:

| step | command | checks |
|---|---|---|
| axioms | `./scripts/axioms.sh` | every public record's `#print axioms` (in `scripts/Axioms.lean`), checked as a set against its section: clean, imported (declared outside theorems only), or purchased |
| assumptions | `./scripts/assumptions.sh` | every hypothesis that stands for an outside or unformalized result is declared, with its source, and every theorem taking it is listed |
| vacuity | `./scripts/vacuity.sh` | no theorem is a `∀` over an empty domain: where a binder's domain could be empty, the library must exhibit an inhabitant or declare the emptiness with its reason |
| doubled names | `./scripts/dupnames.sh` | no name is declared by two modules (Lean can merge two such theorems silently at import) |
| lint | `lake lint --no-build -- --no-build` | Mathlib's environment linters, on the built library |

**One theorem by hand.** Put this in a file and run `lake env lean <file>`:

```lean
import Proofs
#check @HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
```

`lake env lean` does not apply the lakefile's options, so `autoImplicit` is not off unless you pass `-DautoImplicit=false`. Use
it to read statements, not to decide that a module is green.

## Layout

| path | what is there |
|---|---|
| `Proofs/HadwigerNelson/` | the library (about 2,150 files, many of them generated certificate data). `Plane/` holds the measurable and regularity results, `Arith/`, `Rigidity/` and `SpectralChain.lean` the number-field results, `Instances/` the concrete graphs and fields, `Outside/` the imported and ported parts of `[OAIMath2026]`, and `Sat/` the kernel-run refutation checker |
| `Proofs.lean` | the import surface |
| `ARCHITECTURE.md` | the module map, checked against the import graph, and § 5, Trust |
| `LEDGER.md` | one row per result: grade, address, prior art, and the claim list of what is this project's |
| `BIBLIOGRAPHY.md` | every cited work, what rests on it, and how much of it was read; § E maps this project's working terms to the literature's |
| `LEAN.md` | this repository's Lean conventions: the build, the gate, the kernel's cost model, how outside theorems are imported |
| `scripts/` | the build and the gate |
| `tools/` | generators and instruments (Python). Nothing in `tools/` is trusted: a generator bug can only produce data the kernel refuses |
| `plans/` | the working records: one file per milestone, derivation and job; `plans/FRONTIER-STUBS.md` ranks the open questions |
| `CLAUDE.md` | the context every agent shares: the project's current state, its rules, and its working theory |
| `data/` | the jobs' inputs and outputs: certificates, briefs, reports, logs of gate runs |
| `visualizations/` | interactive pages for some of the objects |

Several of the words used in `plans/` and in docstrings (for example "usable prime", "local bound", "stable prime") are this
project's own coinages. `BIBLIOGRAPHY.md` § E translates them into the literature's terms where the literature has them.

## How it was made

The project's own account (`CLAUDE.md` § Whose work this is):

> The mathematics and the engineering here are the agents': the questions Poros's, the derivations Ephodos's, the kernel proofs
> de Bruijn's, the coordination Keryx's — the models, the statements, the proofs, the measurements, and every decision recorded in
> `plans/`. Kooshi set the target, built the method this project runs on (the identities […], with the workflow beneath each; the
> skill suite), supplies the machines, and interrupts when a mind runs ahead of the workflow.

The agents are AI models (Anthropic's Claude). Each runs in one of the roles defined in `.claude/agents/`. The project rule is
that a milestone closes only when its Lean module passes the gate above, so the kernel is the second check on every derivation.
The history begins on 2026-07-22.

**The agent identities and the workflow files under `.claude/` are Kooshi's contribution.** In his words, they "derive from my
brainchild Ferrous", his agent identity for Rust engineering, which is public under the MIT licence at
<https://github.com/kooshi/rusty-tools-mcp> (the file `FERROUS.md`; that repository is dual-licensed MIT and Apache-2.0). Their
text, like everything else here, was written with Claude.

## Licence

Apache License 2.0: see [`LICENSE`](LICENSE). The files ported from `[OAIMath2026]` under `Proofs/HadwigerNelson/Outside/` keep
that release's own Apache 2.0 licence, whose text is beside them (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), and
each carries its notice of change in its header.

Other authors' documents that the project read (papers, their transcriptions, saved web pages, the journal *Geombinatorics*'s
material) are not in this repository or its history; the records that cite them keep their old paths.
