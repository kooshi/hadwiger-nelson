# FS133-IA1 — lane A of the one-class transfer's kernel module: the outside side

*de Bruijn, the implementer; job FS133-IA1 (brief: `data/fs133/briefs/FS133-IA1-lane-a.md`, committed on `main` at
`a2fac50e2`). Branch `fs133-wa1`, cut from `fe95f704d` (the planner's head) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.1. Working files: `data/fs133/ia1/`.
The outside release is `[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of
`/home/kooshi/source/math` (read, never written), compiled at its own pin by the audit (`~/.cache/ext-oai1/lean`).*

## Theorems this phase proved

*(filled as the leaves close; one line per kernel theorem, with its declaration and its axioms)*

## Stage 1 — SAVED: the readback, the leaves restated, the statements as the kernel holds them before any proof

**1.1 The brief's quotations.** `tools/fs133_ia1_readback.py` (each quoted line a substring of its source, read in
the coordinator's tree, where the brief is committed): **4 matched, 0 mismatched**, exit 0
(`data/fs133/ia1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ALG, K133-NC-ALG and
K133-NC-ALL against `data/fs133/claims-K1.md`. With `--fault` (the last character of each quoted line changed):
0 matched, 4 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make
the gate fail; the plan whole (`plans/FS133-kernel-plan.md`, 600 lines) and the planner's report; the three files
of the lane's statements (`Outside/OAI158Rigidity.lean`, `Plane/OneClass/Field.lean`, and `IsPlaneSystem` in
`Plane/OneClass/Defs.lean`); the last port's generator whole (`tools/fs132_i2_port.py`); the release's
`Analysis/PlaneSpectrum/Representations.lean` and `Geometry/PlaneColoring/BorelTransfer.lean` whole, and
`Analysis/PlaneSpectrum/Basic.lean` ll. 1–70, 215–240.

**1.3 Each leaf, in one line, beside the plan's route.**

| leaf | the statement, in one line (the file's is the statement) | the plan's route (§ 5.1) |
|---|---|---|
| **P** | no statement of ours: twenty-five of the release's lemmas and definitions, with what their proofs name, in a generated module `Outside/OAI158Transfer` | the cone from the release's compiled constants; copy by line range with a generator that refuses a patch to a statement or a definition; the definitions `op` and `space` not repeated (they are upstream in `OAI158Rigidity`) |
| **F** `OneClass.exists_field` (`Plane/OneClass/Field.lean`) | for a plane system `(P, τ, ρ)` and finitely many measurable `[0, 1]`-valued `f i` each fixed by every `ρ u`: there are jointly measurable `H i : ℂ × Ω → ℝ` in `[0, 1]` with (a) `∫ H i (x, ·) = ∫ f i` at every `x`, (b) every almost-sure affine relation `∑ c i · f i = d` holding among the `H i (x, ·)` at every `x`, (c) if `f i · (f j ∘ τ z) = 0` almost surely at one `z ≠ 0` of the algebraic plane then `H i (x, ·) · H j (x + w, ·) = 0` almost surely at every `x` and every `w` with `‖w‖ = ‖z‖` | Koopman unitaries on `Lp ℂ 2 P`; the observables' vectors; their projections on the continuous vectors; **one use of the import** (`inner_proj_shift`, through X); the orbit extension to `ℂ`; the closed-circle induction, scaled; the constant vector; a jointly measurable version and `positive_orthogonal` |
| **X** `Spectral.residual_fourier_cross` (`Outside/OAI158Rigidity.lean`) | under the import's hypotheses on `U`, `W`: two `W`-fixed vectors `v`, `w` of `(space U)ᗮ` have `⟪v, op U z w⟫ = 0` at every `z ≠ 0` | polarisation (`inner_map_polarization`) of the import at `v ± w`, `v ± I • w` |
| **M** `Spectral.residual_fourier_model` (same file) | there are a Hilbert space `H : Type`, `U`, `W`, `v` with the import's three hypotheses, `v ≠ 0`, and the import's conclusion at every `z ≠ 0` | the regular representation on `ℓ²` of the algebraic plane; `v` the point mass at `0`; `v ⟂ space U` because a continuous vector's coordinate at `0` is a limit of coordinates along distinct points, which are square-summable; **its axioms must be the standard three** |

**1.4 The statements as the kernel holds them, before any proof of mine** (the build as the planner left it, for
`fe95f704d`; made before the first rebuild). `data/fs133/ia1/lean/StatementDump.lean` prints every constant stored
in the compiled data of `Outside/OAI158Rigidity` (37) and `Plane/OneClass/Field` (1):
`data/fs133/ia1/statements-before.txt` — 11 named constants (six definitions and the derived instance, the axiom,
the three leaves) and 27 internal ones. The reader, `tools/fs133_ia1_statements.py`, compared the dump with itself
(PASS, 11 compared) and, with `--control`, reported 5 of 5 planted faults (a character of `exists_field`'s stored
type; a definition's value; a character of the axiom's type; the axiom become a theorem; a leaf gone).

## Stage 2 — SAVED: P, the port; the finding about the declared theorem's imports, and the ruling on it

*Everything in this stage is from `lake env lean` and from oleans written by `lean -o` (iteration: `LEAN.md`
§ Building); the build under the slot and the prints from the built tree are stage 5's.*

**2.1 The cone.** `data/fs133/ia1/cone/ConeDump.lean` (FS132-I2's dumper with this job's import and the plan's
twenty-five targets), run at the release's pin on the audit's compiled copy: `SUMMARY targets=25 cone-constants=102
decl-lines=1492`, 194 s. The 102 constants lie in three files and nowhere else — `Basic` 32, `Representations` 45,
`BorelTransfer` 25 — and one of them is not a declaration of the selection:
`OAI.PlaneFiveColor.LabelModel.projected._proof_1`, a generated auxiliary of the label model's `projected`
(`BorelTransfer.lean` l. 46), which the release's elaborator shares with `approxIndex`, `approxField`,
`measurableField` and `index_measurable` further down the file. Its stored statement at the release's pin
(`cone/AuxProbe.out`) is `IsTopologicalAddGroup ℂ`, its value Mathlib's instance
`SeminormedAddCommGroup.toIsTopologicalAddGroup ℂ`: a proof the elaborator abstracts for itself at this pin, so the
label model's definition is not needed.

**2.2 The generator** — `tools/fs133_ia1_port.py` (this job's own; FS132-I2's is the pattern and is not edited).
One module, `Outside/OAI158Transfer`, from three release files in their dependency order. It differs from the pattern
in four places, each said in its docstring: the release's two root namespaces (`OAI.EuclideanFiveColor`,
`OAI.PlaneFiveColor`) are one namespace here, and a collision of two ported names is refused; the six definitions
already in `Outside/OAI158Rigidity` are replaced by a `--` comment each, after a check that the upstream module
declares them; the listed auxiliary of an unported declaration is checked to be a generated proof and left out; every
copied `instance` must be in exactly one of two tables — `SCOPED` (`Spectral.E_countable : Countable E`, on Mathlib's
`algebraicClosure ℚ ℂ`: the keyword `scoped`, nothing else) or `GLOBAL_INSTANCES` (`CompleteSpace (space U)`, on the
subtype of the release's own `space`) — and the script refuses one in neither.
`--check`: `OK … 682 lines`, licence copy byte for byte, `CHECK OK`. `--self-test`
(`data/fs133/ia1/port-selftest.out`): **17 plants refused and 1 partner accepted** — a changed generated line, the
file absent, a cone declaration dropped, one added, a cone line in a fourth file, the label model's `projected`
itself in the cone, a patch that does not apply, a patch into a statement, a patch into a definition, the scoped
instance in neither table, the global instance in neither table, a `SCOPED` entry that changes more than the keyword,
an upstream definition absent, the upstream `deriving` clause absent, the licence copy changed by a byte, absent, the
clone at another commit; the partner (a patch into a proof) is accepted by the generator and then the file differs.

**2.3 The measurement: what the port needed at this pin.**

| section of the release (a declaration group) | declarations | lines | patches on proof lines | refused |
|---|---|---|---|---|
| `Basic.lean` 5–733, `Spectral` (`E_countable`, `imagUnit`, `kCoeff_ne_zero`) | 3 of 110 | 14 | 0 | 0 |
| `Representations.lean` 132–163, `Koopman` | 4 | 25 | 0 | 0 |
| `Representations.lean` 165–231, `ContinuousVectors` (the `op` lemmas, `isClosed_space`, `op_mem`, `orbit_continuous`) | 9 | 44 | 0 | 0 |
| `Representations.lean` 280–297 (`projection_fixed_of_contraction`) | 1 | 12 | 0 | 0 |
| `Representations.lean` 299–348, `ContinuousVectors` (`nonlinear_mem`, `clamp`, `projection_range`) | 7 | 37 | 1 | 0 |
| `Representations.lean` 350–395, `ContinuousVectors` (`covariance_mem` … `projection_coefficient`) | 4 | 37 | 0 | 0 |
| `BorelTransfer.lean` 98–123, `Spectral` (`dense_E`, `algebraic_norm`) | 2 | 20 | 2 | 0 |
| `BorelTransfer.lean` 125–165, `Spectral` (the orbit extension) | 5 | 32 | 0 | 0 |
| `BorelTransfer.lean` 167–197, `Spectral` (`normalized_algebraic`, `circle_closed_induction`) | 2 | 26 | 1 | 0 |
| `BorelTransfer.lean` 247–310 (`exists_measurable_field` and its nine) | 10 | 51 | 1 | 0 |
| `BorelTransfer.lean` 312–334 (`positive_orthogonal`) | 1 | 16 | 0 | 0 |
| **all** | **48** | **314** | **5** | **0** |

The five patches, each on a proof line, none on a statement or a definition (the generator refuses those):
two Mathlib renames — `Isometry.lipschitzWith` (v4.34.1, since 2026-08-16) is `Isometry.lipschitz` here
(`Representations.lean:323`); `isAlgebraic_ratCast` (since 2026-07-14) is `isAlgebraic_rat` here
(`BorelTransfer.lean:113`, `:114`) —, one unused simp argument that this pin's linter reports
(`BorelTransfer.lean:186`), and one Mathlib lemma whose statement differs: `summable_norm_of_tsum_eLpNorm_ne_top`
takes the functions' measurability as a hypothesis at v4.32.0 and derives it at v4.34.1 (`BorelTransfer.lean:284`;
the hypothesis is `Lp.aestronglyMeasurable`). No renamed constant in a statement; no definition touched; nothing
refused. None of `LEAN.md`'s four recorded renames was met in the text (`Set.ofPred` only through the set-builder
notation, which elaborates to each pin's name).

*Wall time.* From the first line of the generator to a module that elaborates with no error and no warning:
**11 min 32 s** (16:30:46 to 16:42:18), of which the cone at the release's pin 3 min 14 s. The first elaboration
(8 s) gave four errors and one warning; the five patches took 43 s. The module elaborates in 8–9 s and 4 GiB.
The read-back, the instance tables and the import question (2.4) took about another twenty minutes.

*What this says about porting the rest of the transfer's cone* (one paragraph, a reading from 314 lines of
16,600). The generic analysis ports at about one patch per 60 lines, every patch a rename or a one-hypothesis change
that the error message names, and the generator's refusal rules never fired: at that rate the transfer's 1,997
declarations would need a few hundred proof-line patches, each seconds of work once seen, and the cost is the
number of elaborate-and-patch rounds, not thought. Three things this sample does **not** measure, and each could move
the price: (i) the modules below these three (`CompactFactors`, the stationary mean, the spectral measure,
`Ergodicity`) lean on Mathlib's harmonic analysis, Pontryagin duality and the Riesz–Markov theorem, where a
definition that differs between the pins costs more than a rename — one such difference in a *definition's* body
would be a refusal, and none of the 8 definitions here met one; (ii) long proofs meet `simp`-set differences in
bulk, and this sample's longest proof is 16 lines; (iii) the release's elaborator shares generated proofs across a
file (2.1), so a cone computed for part of a file can name a constant of a declaration that is not wanted — found
once in 102 constants here, handled by a table, and automatic to handle when whole files are ported. A port of the
whole cone would also retire two declared theorems (`plans/FS133-kernel-plan.md` § 2.6) and with them every
question of 2.4–2.6 below, since a ported theorem is checked here and its stored term need not be the release's.

**2.4 The finding (a statement of the plan corrected), and the ruling.** The plan's § 2.4 and the axiom's docstring
gave as the cause of the axiom's difference from the release's stored statement that "Mathlib reaches the inner
product of `H` through another class at the release's pin"; the plan's leaf R says four constants
(`CStarModule.toInner`, `WithCStarModule.instCStarModuleComplex`, `instCommCStarAlgebraComplex`,
`CommCStarAlgebra.toNormedCommRing`) "do not exist at this pin". **They exist at this pin** — in
`Mathlib.Analysis.CStarAlgebra.Module.Constructions` and `Mathlib.Analysis.CStarAlgebra.Classes` — and
`Outside/OAI158Rigidity` did not import those modules; the planner's probe (`RebuildProbe.lean`) asked under that
module's own five imports. Found from the port: with the release-side import list two ported statements
(`projection_coefficient`, `orbitExtension_inner`) stored another term than with a smaller list
(`data/fs133/ia1/imports/hashes-full.txt` against `hashes-min.txt`; `raw-full.out`, `raw-min.out`). Measured on a
scratch copy of the module with the two import lines added and the axiom's text untouched, by the planner's own
comparator: the constants by which the axiom differs from the release's drop from 24 there / 4 here to **4 there / 2
here**, and with `import Mathlib` whole the same 4 / 2 (`data/fs133/ia1/imports/axiom-readback-RigDump.out`,
`-RigMathlib.out`). So the path is chosen by the import list as well as by the pin, and "cannot be term for term by
imports alone" stands. Sent to the coordinator at once; its ruling is the brief's **Amendment 1**: the two import
lines go into the module now, the ported module imports as the release's side does, leaf R returns to this lane
after F.

**2.5 The ruling carried out** (Amendment 1, items 1–3).

1. `Outside/OAI158Rigidity`: two import lines added (`Mathlib.Analysis.CStarAlgebra.Classes`,
   `Mathlib.Analysis.CStarAlgebra.Module.Constructions`); **not one character of the axiom's text changed**; the
   docstring's sentence on the cause replaced by what was measured (the one path that still differs, by name; the two
   imports and what they are for).
2. *What moved, in all eight modules* (`data/fs133/ia1/lean/StatementDumpErased.lean`: FS132-I2's dumper over every
   named constant of the eight modules, full print and print with instance and proof arguments erased; reader
   `tools/fs133_ia1_moved.py`; prints `data/fs133/ia1/moved/*.out.xz`). The dump `before` was made on the planner's
   build before anything was recompiled; `after-A` after the two import lines (the seven dependent modules
   re-elaborated); `after-B` after `Plane/OneClass/Field` also imports the ported module.
   - `before` → `after-A`: **114 constants, 110 IDENTICAL, 4 INSTANCES-ONLY, 0 DIFFERENT** (`moved/moved-A.txt`).
     The four: `Spectral.residual_fourier` (the axiom), `residual_fourier_cross`, `residual_fourier_model` — the
     inner product now on the release's path, twenty constants entering and `InnerProductSpace.toInner`,
     `NormedField.toNormedCommRing` leaving —, and, in another lane's file, **`Plane.isIndepSet_ball_half`**
     (`Plane/OneClass/Defs`, lane B's leaf): the normed ring `ℂ` of its ball is now reached through
     `CommCStarAlgebra.toNormedCommRing instCommCStarAlgebraComplex` in place of `NormedField.toNormedCommRing`.
     Each of the four has the same print once instance and proof arguments are erased.
   - `after-A` → `after-B`: **114 IDENTICAL** (`moved/moved-A-to-B.txt`): importing the ported module into `Field`
     moves no stored statement of any of the eight modules — the answer to the question put to the coordinator.
   - Control (`moved/control.txt`): a constant changed in an erased print reads DIFFERENT, one changed in a full
     print only reads INSTANCES-ONLY (a move never reads as identical), a constant removed reads MISSING, a theorem
     become an axiom reads DIFFERENT — each as planted.
3. *The declared statement's read-back, run again on the module as it stands* (the planner's two comparators and
   dumpers, unchanged, on new prints; `data/fs133/ia1/axiom-readback/`). Full terms (`decls.out`): **six of eight
   IDENTICAL** — `E`, `K`, `DiscreteE`, `kCoeff`, `op`, `space` —; the derived instance differs as before (the two
   `deriving` handlers); **the axiom differs: at the release only `CommSemiring.toSemiring`,
   `Complex.instCommSemiring`, `Semifield.toCommSemiring`, `SubsemiringClass.toCommSemiring`; here only
   `DivisionSemiring.toSemiring`, `Semifield.toDivisionSemiring`**. Erased (`erased.out`): all eight alike, the axiom
   `UP-TO-INSTANCES` with exactly those six constants. Controls: the four plants of the full comparator and the two
   of the erased one each refused (`decls-control.out`, `erased-control.out`; the full comparator's own exit is 1
   with or without a plant, because its unplanted pair is not identical — as in the planner's run).

**2.6 The port's read-back** — `tools/fs133_ia1_readback_port.py` (FS132-I2's comparator imported as a module, with
this job's table: both release namespaces written `§.`, the upstream six and the unported auxiliary listed and not
compared here). 67 cone constants printed at each pin by one dumper (`data/fs133/ia1/readback/`). On the module as
it stands (`compare.out`): **`READBACK OK` — no DIFFERENT, none absent.**

| class | IDENTICAL | UP-TO-INSTANCES | other |
|---|---|---|---|
| the 25 targets | 16 | 9 | — |
| the definitions under them | 2 | 4 | — |
| the other lemmas | 17 | — | — |
| generated auxiliaries | 8 | 3 | 3 absent under the release's name, 5 another statement under it (counted, as in FS132-I2) |

The nine targets that are the release's up to instance arguments: `projection_fixed_of_contraction`,
`projection_covariance_fixed`, `op_orthogonal`, `projection_coefficient` — the `Semifield → Semiring` path of 2.5
and nothing else —, and `Koopman.unitary`, `unitary_apply`, `nonlinear_commute`, `nonlinear_mem`,
`projection_range` — also the path by which the additive structure of `Lp ℂ 2 μ` is reached
(`AddSubgroup.instAddSubgroupClass` there, `AddSubgroup.toAddGroup` here). The differing constants are recorded and
read: 37 (`instance-constants.txt`), every one Mathlib's or a generated proof. On the first import list (before the
ruling) the same comparison read 15 / 10 targets and 55 constants (`data/fs133/ia1/pathA/`).
`--self-test` (`selftest.out`): **11 plants refused, the unplanted pair passes.** Level one (`level1.out`: the 84
Mathlib and core constants the targets' statements and the definitions under them name outside instance arguments,
each printed one level down at both pins): 63 IDENTICAL, 8 MOVED to another module, 13 DIFFERENT, the one rename
(`Set.ofPred` → `setOf`) IDENTICAL. The 13 were read **at their first difference only**: five are the
`Semifield → Semiring` path inside Mathlib's own signatures (`IntermediateField`, `Submodule.orthogonal`,
`HasOrthogonalProjection`, `starProjection`, `Unitary.linearIsometryEquiv`), three the projection to `Add`
(`AddCommGroup`, `NormedAddCommGroup`, `InnerProductSpace`), three an order of universe levels under `max`
(`LinearIsometry`, `LinearIsometryEquiv`, its constructor), and two are `MeasureTheory.Lp` (its `eLpNorm` takes one
more argument at v4.34.1) and `Lp.compMeasurePreserving`. That Mathlib's `Lp` means one thing at the two pins is
what this comparison leaves to trust, and it is said here because it is the largest such item.

**2.7 The port's axioms** (from the olean written by `lean -o`; stage 5 prints them again from the built tree):
`tools/fs133_ia1_axioms.py` on `data/fs133/ia1/port-axioms.out` — **48 records, each
`[propext, Classical.choice, Quot.sound]`**, none the declared theorem's, none `sorryAx`; its control reports a
planted `sorryAx`, a planted import and a removed record.

**2.8 The imports of the ported module.** The release-side dump (`cone/ImportsDump.out`) less four that are not
needed and move no stored term of the module (`imports/hashes-B-dump.txt` is `hashes-B-min.txt`): every import
enters the closure of the modules downstream of `Field`. `Plane/OneClass/Field` now imports the ported module
(2.5, item 2: nothing moved). `ARCHITECTURE.md`: one row for `Outside/OAI158Transfer`, and `Field`'s imports;
`Proofs.lean`: one line; `tools/check_architecture.py`: PASS.

**2.9 Slips.** (a) My first probe of the unported auxiliary called `ConstantInfo.value!`, which panics on a theorem
at v4.34.1; under `LEAN_ABORT_ON_PANIC` the run aborted (exit 134) with the panic's own message. The cause was in
the message and in my probe; the probe reads the value by cases now. (b) Before reading that probe's output I had
written, in the generator's table, that the auxiliary was `Fact (1 ≤ 2)`; it is `IsTopologicalAddGroup ℂ`. Corrected
before anything was generated from it.

## Stage 3 — SAVED: X and M

*From `lake env lean` (stage 5 prints again from the built tree).* `Outside/OAI158Rigidity` elaborates with exit 0,
no error, no warning, no `sorry` (`data/fs133/ia1/rigidity-elab.out`).

- **X, `Spectral.residual_fourier_cross`** — proved. `inner_map_polarization` for `T := op U z` writes
  `⟪T w, v⟫` as a combination of the four values `⟪T x, x⟫` at `x = v ± w`, `v ± I • w`; each such `x` is in
  `(space U)ᗮ` (a submodule) and fixed by every `W k` (`map_add`, `map_sub`, `map_smul`), so each value is `0` by the
  import; `inner_conj_symm` turns the slots. Its axioms (`data/fs133/ia1/lane-axioms-stage3.out`):
  `[propext, Classical.choice, Quot.sound, HadwigerNelson.Outside.OAI158.Spectral.residual_fourier]`.
- **M, `Spectral.residual_fourier_model`** — proved, on `[propext, Classical.choice, Quot.sound]` **and nothing
  else: the model does not read the declared theorem.** `H := lp (fun _ : E => ℂ) 2` (`ℓ²` of the algebraic plane, a
  `Type`); `(U z f) x = f (x + z)`; `(W k f) x = f (k⁻¹ x)` — **the inverse rotation on the points**: with
  `f (k x)` the covariance `W k ∘ U z = U (k z) ∘ W k` fails (it gives `f (k x + z)` against `f (k x + k² z)`);
  `v := lp.single 2 0 1`. Three private helpers build the unitaries by hand, since the ported `Koopman.unitary` is
  downstream of this file: `lpReindex` (composition with a bijection of the index set as a linear isometric
  equivalence of `ℓ²`), `lpUnitary`, `turnEquiv`. Every clause of the model is exercised: covariance (a pointwise
  identity); `v ∈ (space U)ᗮ` — for `w` in the continuous vectors the coordinate at `0` of the translate by `a` is
  `w a` and tends to `w 0` as `a → 0`, while along the distinct points `1 / (n + 1)` of the algebraic plane the
  values `w (1 / (n + 1))` are square-summable, so tend to `0`; hence `w 0 = 0 = ⟪w, v⟫` —; `W k v = v`; `v ≠ 0`;
  and `⟪v, U z v⟫ = v z = 0` at `z ≠ 0`.

The module docstring's sentence that called the two "a leaf of FS-133's skeleton" now says they are kernel-checked
(a docstring, not a statement).

## Stage 4 — SAVED: F, the field theorem

*From `lake env lean` (stage 5 is the build and the prints from the built tree).* `Plane/OneClass/Field` elaborates
with exit 0, no error, no warning, no `sorry`; `exists_field` prints
`[propext, Classical.choice, Quot.sound, HadwigerNelson.Outside.OAI158.Spectral.residual_fourier]`.

**F, `OneClass.exists_field`** — proved, on the plan's route (§ 5.1, children 1–7), over the ported module; P did not
stall, so the plan's fallback was not taken. The statement's text is untouched; two `open … in` lines stand before
its docstring (the proof names the ported lemmas and writes inner products), and the stored statement is the same
term as before them (below). The private layer (`section FieldAux`, 25 private declarations, about 300 lines), each
the release's label-model lemma rewritten for an arbitrary plane system:

| child of the plan | here (private) | what carries it |
|---|---|---|
| 1 the representation | `shiftEquiv`, `turnEquiv` (measurable equivalences from `shift_zero`/`shift_add`, `turn_one`/`turn_mul`), `planeRep` (`(U z g) ω = g (τ z ω)`), `planeTurn` (`(W u g) ω = g (ρ u ω)`), `turn_covariance` (from `IsPlaneSystem.cov`, as written) | ported `Koopman.unitary` |
| 2 the observables | `obsVec`, `obsVec_ae`, `obsVec_turn_fixed`, `inner_obsVec_zero` | `L2.inner_def`; **the direction**: the ported unitary composes with `τ z` itself, which is the statement's `f j (τ z ω)` — no inverse, no change of sign |
| 3 the projections | `contSpace`, `proj_turn_fixed`, `proj_range`, **`inner_proj_shift`** | ported `projection_covariance_fixed`, `projection_range`, `op_mem`, `op_orthogonal`; **the one use of the import**, through `residual_fourier_cross` at `v − proj v`, `w − proj w` |
| 4 the fields | `orbit_range` | ported `orbitExtension`, `orbitExtension_continuous`, `orbitExtension_eq`, `clamp_lipschitz`, `clamp_eq`, `clamp_range`: the release's `fieldVector_range` |
| 5 the circle | `inner_orbit_circle` | ported `orbitExtension_inner`, `circle_closed_induction` at `c ↦ c · z`, **scaled**: `w = (w / z) · z` with `‖w / z‖ = 1`; the unit case is not re-proved |
| 6 the constant | `oneVec`, `one_fixed`, `one_mem`, `inner_one`, `inner_one_orbit` (clause (a)), `sum_orbit` (clause (b)) | density of the algebraic plane, `Unitary.inner_map_map`, `starProjection_eq_self_iff` |
| 7 measurability | in the theorem's proof: `exists_measurable_field` per `i`, real part clamped to `[0, 1]` so that the bound holds at every point; `positive_orthogonal` (clause (c)) | ported |

**Priced against the plan.** The plan priced F at 4–8 implementer-hours after P; from the first line of its private
layer to a clean elaboration it took three elaborations (the `noncomputable` marker; one lemma name,
`integral_complex_ofReal` for `integral_ofReal`). The two things the plan called hard were each one line: the
direction convention (the unitary composes with `τ z`; nothing to invert) and the scaling of the circle (the
ported induction applied to `c ↦ ⟪p, field (c · z)⟫`).

**No statement moved by the proofs** (iteration; stage 5 repeats it on the built tree): the dump of all eight
modules after the three proofs against `after-A` (the skeleton with the two ruled imports): **114 named constants,
114 IDENTICAL in the full print**. *A planted change, end to end:* `0 ≤ f i ω` made `0 < f i ω` in `exists_field`'s
hypothesis in the module itself, re-elaborated, dumped: read `DIFFERENT` (`LT.lt` entering), exit 1
(`data/fs133/ia1/moved/planted-read.txt`); the file restored from its copy and re-elaborated, and `git diff` of the
module shows the proof and nothing of the plant.

## Stage 6 — SAVED: leaf R, the rebuilt-type comparison (Amendment 1, item 4) — the full form

*Run on the tree while stage 5's build walked, and again on the built tree (stage 5).* Two instruments, each with
its control; the aim is the amendment's: nothing left to trust beyond "a Mathlib constant of one name means one thing
at both pins".

**6.1 Where the two stored statements differ, subterm by subterm** — `tools/fs133_ia1_rebuild.py emit`
(`data/fs133/ia1/rebuild/emit.out`). The release's stored type of `residual_fourier` (the planner's print made at
the release's pin, 264,349 characters, names mapped, `Set.ofPred` written `setOf`) and this library's (264,423
characters, the module as it stands) are parsed into trees and walked in parallel; two applications whose heads
differ are one pair and are not descended into. **They differ at 4 places, in 2 distinct closed subterms:**

| | the release's term | this library's | of type | occurrences |
|---|---|---|---|---|
| pair 1 | `CommSemiring.toSemiring ↥E (SubsemiringClass.toCommSemiring …)` (3,471 characters) | `DivisionSemiring.toSemiring ↥E (Semifield.toDivisionSemiring ↥E …)` (3,521) | `Semiring ↥E` | 1 |
| pair 2 | `CommSemiring.toSemiring ℂ (Semifield.toCommSemiring ℂ (Field.toSemifield ℂ …))` | `DivisionSemiring.toSemiring ℂ (Semifield.toDivisionSemiring ℂ (Field.toSemifield ℂ …))` | `Semiring ℂ` | 3 |

**The release's print with each pair rewritten is this library's print, character for character.** Control
(`--control`): one constant changed elsewhere in this library's print (`kCoeff`) shows as a third pair, where a
reader sees it.

**6.2 The kernel's check** — `data/fs133/ia1/rebuild/Rebuild.lean` (`Rebuild.out`). The release's print is parsed
into a term at this pin: **all 120 constants it names exist here under the module's imports** (the four the plan's
leaf R called absent among them). Then this pin's kernel is asked, synchronously and with its check on
(`Environment.addDeclCore … (doCheck := true)`), for

    theorem rebuilt_release_type : (the release's statement, rebuilt) = (the declared axiom's statement) := Eq.refl _

**KERNEL ACCEPTED.** So the release's stored statement, rebuilt constant by constant at this pin, type-checks here
and is definitionally the declared statement; `#print axioms rebuilt_release_type`:
`[propext, Classical.choice, Quot.sound]` — it does not rest on the axiom it is about. Each of the two pairs on its
own: **KERNEL ACCEPTED** `(the release's instance) = (this pin's) := Eq.refl _`, at `Semiring ↥E` and at
`Semiring ℂ`. Controls, three planted variants of the release's print: `≠` made `=` in the hypothesis `z ≠ 0` — a
well-typed other statement — **refused** (`declaration type mismatch`); a numeral changed — **refused**, but as
ill-typed (the literal no longer fits its `OfNat` instance), so this plant shows the kernel type-checks the rebuilt
term and is not a second instance of a wrong statement refused; a binder kind changed (`(U : …)` made implicit) —
**accepted, as it must be**: the kernel does not read binder kinds or binder names. Those are read by the print
comparison, which is why it stays: `axiom-readback/erased.out` (binders, names and every non-instance argument
alike) and its control (a binder kind planted: refused).

**6.3 What is left to trust for the declared statement, after R.** (i) That a Mathlib or core constant of one name
means one thing at the two pins — 120 constants, among them the two pairs' six; level one of stage 2.6 printed 84 of
this kind one step down for the ported statements and found Mathlib's own signatures differing on the same
`Semifield → Semiring` path. (ii) The one rename, `Set.ofPred` there for `setOf` here (one definition at both pins:
`level1.out`). (iii) That the print of the release's side is the release's stored term (the planner's dump, made by
the dumper whose text is in the repository, on the audit's compiled copy). Not left to trust any more: that the two
instance paths agree — the kernel checked it here.

## Drafts for the landing (files this job does not write; each names its slot)

**D1. `scripts/Axioms.lean`** (the landing's; the planner's § Drafts has the same line for the import).
- IMPORTED section, one line with the four items beside it: `#eval AxiomAudit.declareImport
  ``HadwigerNelson.Outside.OAI158.Spectral.residual_fourier`; and under IMPORTED the two records of this lane:
  `#print axioms HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_cross`,
  `#print axioms HadwigerNelson.OneClass.exists_field` (each: the standard three and the import).
- CLEAN: `#print axioms HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_model` (the standard three; it must
  not print the import), and the port's block as generated — `data/fs133/ia1/axioms-block.txt`
  (`tools/fs133_ia1_port.py --axioms-block`): 47 records, every ported declaration but the one anonymous instance
  (`ContinuousVectors.instCompleteSpaceSubtypeMemSubmoduleComplexSpace`, printed apart in
  `data/fs133/ia1/lane-axioms-built.out`: the standard three).

**D2. The model for each hypothesis** (`LEAN.md` § The gate).
- `Spectral.residual_fourier` (the import) and `residual_fourier_cross`: **`Spectral.residual_fourier_model`**, same
  file, kernel-checked on the standard three — `U`, `W`, `hcov`, `v ∈ (space U)ᗮ`, `hfix`, all at once, with `v ≠ 0`
  and at every `z ≠ 0`; for the two-vector form take `w := v`.
- `OneClass.exists_field`: its docstring names `IsInvariantLaw.isPlaneSystem` (lane B's leaf, `sorry` on this branch)
  at an invariant law, with the indicator at the origin. **The kernel does not hold that model until lane B lands**,
  and the model that exercises clause (c)'s premise (an almost-sure zero product at some `z ≠ 0`) is the law of
  `exists_isInvariantLaw_unitDistance` at `z = 1`, not the point mass at the empty set (`isInvariantLaw_dirac`),
  where the observable is `0` and the clause is exercised only trivially. The landing names which it relies on.
- The ported module: its hypotheses are parameters (a measure-preserving family `s` with `hU`, a covariant unitary
  `W` with `φ`, a continuous `f : T → Lp`); each is met at a real instance inside `Plane/OneClass/Field`
  (`op_planeRep`, `turn_covariance` with `Homeomorph.mulLeft₀`, the fields), which is their consumer. The vacuity
  scan will read them `GENERIC`.

**D3. What a reader of the declared theorem's docstring should be told that it does not yet say.** The docstring
now names the one path that still differs and the two imports (stage 2.5). After leaf R it can also say — a sentence
this job adds if the coordinator wants the module recompiled once more for it, and drafts here otherwise: *"The
release's stored statement, rebuilt at this pin from its print (120 constants, each present here), is accepted by
this pin's kernel as definitionally equal to this statement, and each of the two instance terms that differ
(`Semiring ↥E`, `Semiring ℂ`) is kernel-equal to its counterpart (`data/fs133/ia1/rebuild/`); what the comparison
leaves to trust is that a Mathlib constant of one name means one thing at the two pins."* Also not said there: the
statement is about `ContinuousVectors.space U` for the topology the algebraic plane has **as a subset of `ℂ`** (the
module docstring says it; the axiom's own docstring says "continuous vectors" only).

**D4. A dated note for `plans/FS133-kernel-plan.md` § 2.4** (the planner's record; *following* its last sentence
"… and its docstring and `ARCHITECTURE.md` line must say so."): *"**2026-10-13, corrected by FS133-IA1 (the
coordinator's Amendment 1 to that job's brief).** The cause given above is wrong as stated. The inner product of `H`
is reached through `CStarModule` at this pin too, when `Mathlib.Analysis.CStarAlgebra.Module.Constructions` is
imported; the four constants § 5.1's leaf R lists as absent at this pin exist here, in that module and in
`Mathlib.Analysis.CStarAlgebra.Classes`, which `Outside/OAI158Rigidity` did not import — `RebuildProbe.lean` asked
under the module's own five imports. With the two imports added (the axiom's text untouched) the two stored
statements differ at four places, in two instance terms, on one path — the `Semiring` of a `Semifield`, through
`CommSemiring` at v4.34.1 and through `DivisionSemiring` at v4.32.0 — and no import list changes that. The release's
statement, rebuilt at this pin, is kernel-equal to the declared one (`plans/FS133-IA1-implementation.md` stages 2
and 6)."*

**D5. `LEAN.md` § Assumptions: outside theorems and our own, item 2** — one sentence, *following* the sentence the
planner drafted for the same item (or, if that draft is not filed, following "…the landing runs it again on the
module as recompiled on the joined tree."): *"Before blaming the pin for a stored statement that differs from its
source's, ask whether each constant the source names exists at this pin under `import Mathlib` — not under the
module's own imports — and, for each that does, add the Mathlib module that declares it and compare again: which
instance a statement stores is chosen by the import list as well as by the pin (`Outside/OAI158Rigidity`: two
import lines took the difference from 24 constants against 4 to 4 against 2); then rebuild the source's stored
statement at this pin from its print and let the kernel check it equal to the declared one, so that what is left to
trust is only that a Mathlib constant of one name means one thing at the two pins
(`data/fs133/ia1/rebuild/Rebuild.lean`, `tools/fs133_ia1_rebuild.py`, FS133-IA1)."*

**D6. `LEAN.md` § Searching — Lean**, new bullets.
- "Between Mathlib `v4.32.0` and `v4.34.1`, further: `Isometry.lipschitz` became `Isometry.lipschitzWith`
  (2026-08-16), `isAlgebraic_rat` became `isAlgebraic_ratCast` (2026-07-14), and
  `summable_norm_of_tsum_eLpNorm_ne_top` lost its measurability hypothesis (here it is asked: `fun n =>
  Lp.aestronglyMeasurable (g n)`). `∫ (↑(f x) : ℂ)` is `integral_complex_ofReal`; `integral_ofReal` is stated for the
  `RCLike` coercion and does not rewrite it (FS133-IA1)."
- "A cone computed for part of a release file can name a generated proof of a declaration outside it: the
  release's elaborator shares `X._proof_n` between declarations of one file (`LabelModel.projected._proof_1 :
  IsTopologicalAddGroup ℂ` in four declarations of `BorelTransfer.lean`). Print its stored statement at the source's
  pin before deciding; a proof of a Mathlib proposition needs no port (FS133-IA1)."
- "At the pin the kernel is called synchronously by `Environment.addDeclCore env 0 decl none` (its check on by
  default); there is no `Environment.addDecl`. `ConstantInfo.value!` panics on a theorem at v4.34.1: read a value by
  cases (FS133-IA1)."
- "On the regular representation `(U z f) x = f (x + z)`, the rotations that satisfy `W k ∘ U z = U (k z) ∘ W k` act
  by the inverse on the points, `(W k f) x = f (k⁻¹ x)`; on a plane system, where `τ z ∘ ρ u = ρ u ∘ τ (u z)`, the
  Koopman operators compose with `τ z` and `ρ u` themselves (FS133-IA1)."

**D7. Not run in this job** (the landing's, on the joined tree): `scripts/axioms.sh` (it fails by design until the
import is declared to it), `vacuity.sh`, `dupnames.sh`, `assumptions.sh`, the lint, and the planner's two read-backs
on the module as recompiled there. The ported names were checked against this branch's library by the build only
(the ported module's upstream is `Outside/OAI158Rigidity` alone); `dupnames.sh` on the joined tree is what shows
that no other module declares one of its 48 names.
