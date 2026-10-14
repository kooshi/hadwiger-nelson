# FS131-IC1 — `Arith/ThreeColourCharacter`: the eight leaves

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wc1` (cut at the skeleton's commit `34d9113b2`). Brief:
`data/fs131/briefs/FS131-IC1-leaves.md`. The plans read: `plans/FS131-KN4-three-four-colours-plan.md` (its dated last section, then
§ 4.1) and `plans/FS131-KN5-three-four-colours-passes.md` (§§ Stage 3, 5, 7). Working files: `data/fs131/ic1/`.*

## Theorems this phase proved

Nine, each **[kernel] on branch `fs131-wc1`** — compiled by `scripts/build.sh` in this tree (stage 5) and printed from the compiled
module — on exactly `[propext, Classical.choice, Quot.sound]`, with no hypothesis standing for an assumption. **Not through the
gate**: the axiom audit, the vacuity scan, the assumptions step and `dupnames` on the joined tree are the landing's. Statements
FS131-KN4's and FS131-KN5's; the proofs this job's. Each line: the declaration, then the informal statement it was read against.

1. `HadwigerNelson.ThreeColourCharacter.exists_int_vector_of_forall_neg` — finitely many real-linear functionals on `ℝ^ι`, all
   negative at one real vector, are all negative at one integer vector (KN5 § Stage 3, C3).
2. `HadwigerNelson.ThreeColour.Winding.exists_box_point` — a winding `W` of `s : Fin m → A` has a point `x ∈ [1/3, 2/3]^m` with
   `Σ_j r_j x_j = W r` for every relation `r` of `s` (NF4-S6, finite form; FS73-T22 ⟹ past the winding).
3. `HadwigerNelson.ThreeColourCharacter.exists_character_of_box_point` — reals `x_j` whose form `Σ_j r_j x_j` is an integer on
   every relation of `s` are the values, modulo 1, of a character of `A` at the `s j`.
4. `HadwigerNelson.ThreeColourCharacter.exists_character_of_properAlong` — a colouring `A → ZMod 3` that changes along every
   `s j` gives a character of `A` with every `θ (s j)` in `[1/3, 2/3]` modulo 1 (FS73-T22 ⟹, character form, finitely many steps;
   every abelian group).
5. `HadwigerNelson.ThreeColourCharacter.isClosed_band` — the image of `[1/k, 1 − 1/k]` in `ℝ/ℤ` is closed.
6. `HadwigerNelson.ThreeColourCharacter.bandSet_nonempty_of_finite` — for a closed `B ⊆ ℝ/ℤ`: if every finite subset of `U ⊆ M`
   has a character of `M` with values in `B` on it, so has `U` (compactness of the character group).
7. `HadwigerNelson.ThreeColourCharacter.bandSet_three_nonempty_of_proper` — a colouring `A → ZMod 3` that changes along every
   step in `U ⊆ A` gives a character of `A` with `θ(U) ⊆ [1/3, 2/3]` modulo 1 (NF4-S6 for a group; `U` any set).
8. `HadwigerNelson.ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` — **the headline, NF4-S6 / FS81-T2**: for
   every subfield `F ⊆ ℝ`, a proper 3-colouring of the unit-distance graph on `F²` gives an additive `θ : ℤ[U_F] → ℝ/ℤ` with
   `θ(u) ∈ [1/3, 2/3]` modulo 1 at every unit vector `u` of `F²`. Read against `data/fs131/claims-NF4.md:20`: the claim starts
   from a winding and the Lean from the colouring (the winding form is 2 above), as the planner's readback already says.
9. `HadwigerNelson.ThreeColourCharacter.exists_character_one_two` — the conclusion of 4 at `ℤ` along `(1, 2)` with `x ↦ x mod 3`
   (a composition the skeleton already proved over the leaves; it rested on `sorryAx` until they were).

Two private helpers, on the same three axioms: `winding_le_vertex` (`W r ≤ r · v` at the vertex `v_j = 2/3` where `0 ≤ r_j`,
`1/3` elsewhere) and `exists_mem_box_of_forall_int` (if every integer combination of the equations `g_i · x = w_i` is non-negative
at some vertex of the box, a point of the box solves them).

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/ic1/readback.py`: the brief's five quoted blocks (Kooshi's W2; the claim list's theorem and its three
dated lines) against their sources in the coordinator's checkout — **5 IDENTICAL**, exit 0 (`data/fs131/ic1/logs/readback.out`).
Control `--control` changes one word of each quotation in memory: 5 of 5 then DIFFER (`logs/readback.control.out`). The module's
docstring quotes NF4-S6; read against `data/fs131/claims-NF4.md:20` by eye: the same words.

**The instruments, each watched failing before it is believed.**

| instrument | what it reads | its control |
|---|---|---|
| `data/fs131/ic1/lean1.sh <file>` | one file through `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false`, under the slot; lean's exit status, messages, wall clock, peak memory | — (a wrapper; the skeleton reads exit 0, eight `declaration uses sorry`, 2.7 s, 3.6 GB) |
| `data/fs131/ic1/statements.sh [file]` with `statement_diff.py`, `lean/StatementFooter.lean` | the skeleton at `34d9113b2` and the working file, each elaborated **at one path** with a footer that prints every constant's kind, name and stored type; every named constant of the skeleton must be in the working file's print with the same kind and type; every `example` of the skeleton must be in the working file as text | `--control` plants three faults in the second print (a statement changed by one character, a declaration removed, a theorem made an axiom): 3 of 3 reported. **On a file**: a copy with `(_hk : 0 < k)` added to `isClosed_band` reads `TYPE THM …isClosed_band: the stored statement differs`, exit 1 (`logs/statements-planted-file.out`) |
| `data/fs131/ic1/probes/NameCheck.lean` | 47 library names the routes read, under the module's own four imports | one name I guessed without its namespace (`planeOverSubring`, which is `Chain.planeOverSubring`) is the one error line: an unknown name is reported |

On the untouched skeleton the statement check reads 9 theorems compared (the eight leaves and `exists_character_one_two`), 2
`example`s, PASS (`logs/statements-stage1.out`). **The tool defect FS131-IU1 names** — a statement printed from two paths differs in
an instance binder's stored name — is why both prints are made at `stmt/Copy.lean`, in turn. This module has no compiled data in
this tree (its `.olean` was never built here), so the comparison is made from the two source texts as the elaborator stores them,
not from two builds; after the build at the end the stored types are printed once more from the compiled module.

**The eight leaves: each statement read in the source, restated in one line, with the plan's route.** I derived each by hand
before reading its route; every one is true as typed, and no statement disagrees with its plan.

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `exists_int_vector_of_forall_neg` (C3) | finitely many real-linear functionals `ℓ k` on `ι → ℝ` (`ι` a fintype, `κ` finite), all negative at one real vector `c`, are all negative at the cast of one integer vector `N : ι → ℤ` | KN5 § Stage 3, C3: the set is open (a finite intersection of open half-spaces), rational vectors are dense (`Rat.denseRange_cast`, `DenseRange.piMap`), scale by a common denominator |
| `ThreeColour.Winding.exists_box_point` (L1.1) | a winding `W` of `s : Fin m → A` has a real point `x ∈ [1/3, 2/3]^m` with `Σ_j r_j x_j = W r` for every relation `r` | KN5 § Stage 3, C1–C4 (replacing KN4 § 4.1's step (v)): generators `r_1 … r_n` of the relation lattice; were no box point a solution on generators, a functional separates the image of the box from the target (`geometric_hahn_banach_closed_point`); C3 at the `2^m` vertices makes its coefficients integers, giving a relation `r` with `r·v < W r` at every vertex; `W.minRise_le` at `−r` gives a vertex with `W r ≤ r·v` |
| `exists_character_of_box_point` (L1.2) | if `Σ_j r_j x_j` is an integer for every relation `r` of `s`, some character `θ : A →+ ℝ/ℤ` has `θ (s j) = x j mod 1` for every `j` | KN4 § 4.1: `r ↦ ↑(Σ r_j x_j)` on `ℤ^m` kills the relations, so descends to the range of `relMap s`; extend to `A` by Baer (`Module.Baer.of_divisible`, the pattern of `CharacterColouring.exists_ratLinear_extension`) |
| `exists_character_of_properAlong` (L1.3) | a colouring `c : A → ZMod 3` proper along `s` gives a character with every `θ (s j)` in `band 3` | KN4 § 4.1: `nonempty_winding`, L1.1, L1.2 with `n := W.toHom r`; `band 3` is the image of `Icc (1/3) (1 − 1/3)` |
| `isClosed_band` (L1.4) | `band k` is closed in `ℝ/ℤ`, for every `k : ℕ` | KN4 § 4.1: a compact interval's image under the continuous quotient map, in a Hausdorff space |
| `bandSet_nonempty_of_finite` (L1.5) | for closed `B ⊆ ℝ/ℤ` and `U ⊆ M`: if every finite subset of `U` has a character of `M` with values in `B` on it, so has `U` | KN4 § 4.1: closed sets in the compact space `M → ℝ/ℤ` with the finite intersection property |
| `bandSet_three_nonempty_of_proper` (L1.6) | a colouring `c : A → ZMod 3` with `c (a + u) ≠ c a` for every `a` and every `u ∈ U` gives a character of `A` with values in `band 3` on `U` | KN4 § 4.1: L1.5 at `band 3` (L1.4); a finite `S ⊆ U` is `s : Fin m → A` by `S.equivFin`; L1.3 |
| `fieldBandSet_three_nonempty_of_colorable` (L1.7) | for a subfield `F ⊆ ℝ`, a proper 3-colouring of the unit-distance graph on `planeOver F` gives a point of `fieldBandSet F (band 3)`: a character of `unitRing F` with values in `band 3` on the unit vectors of `F²` | KN4 § 4.1: the colouring restricted to `unitRing F ⊆ planeOver F`, read in `ZMod 3`; `dist (a + u) a = ‖u‖ = 1` at a unit vector; L1.6 |

**What the hand derivation saw** (nothing that changes a statement). C3 at `κ` empty is the zero vector; at `ι` empty its hypothesis
forces `κ` empty. L1.1 is true with no hypothesis beyond the winding: `minRise_le` at `r` and at `−r` puts `W r` between the least
and the greatest value of `r·x` on the box, which is the whole content. L1.2's hypothesis names no box (KN5 § Stage 4 weighed it).
L1.5 is true at `U = ∅` (the zero character), which the route's intersection over the empty family must still produce: the
compact set is the additive maps, not the whole space. L1.7 reads `ZMod 3` as `Fin 3` by unfolding, as
`ThreeColour.nonempty_winding_of_colorable` already does.

**Plan of work**, in the plan's dependency order: C3 → L1.1 (with two private children: the vertex bound C1, and the real-linear
statement "if every integer combination is non-negative at some vertex, a box point solves the equations") → L1.2 → L1.3 → L1.4 →
L1.5 → L1.6 → L1.7. Saved stages: after L1.1; after L1.5; at the end.

## Stage 2 — SAVED: five leaves proved (C3, L1.1, L1.2, L1.3, L1.4)

Under `lake env lean` with the lakefile's two options the module reads exit 0 and three `declaration uses sorry` (L1.5, L1.6,
L1.7), no other message. Statement check: PASS, 9 compared, control 3 of 3 (`data/fs131/ic1/logs/statements-stage2.out`); two
private helpers new.

| leaf | how it was proved | lines |
|---|---|---|
| `exists_int_vector_of_forall_neg` (C3) | the plan's route as written: `isOpen_iInter_of_finite` with `isOpen_lt` and `LinearMap.continuous_of_finiteDimensional`; `(DenseRange.piMap fun _ => Rat.denseRange_cast).exists_mem_open`; `D = ∏ i, (q i).den`, `N i = (q i).num * (D / (q i).den)`, and `N = D • q` by `Rat.cast_def` | 20 |
| `ThreeColour.Winding.exists_box_point` (L1.1) | the plan's C1–C4, in two private children and a composition. **`winding_le_vertex`** (C1): `W r ≤ Σ_j r_j v_j` at the vertex `v_j = 2/3` where `0 ≤ r_j`, `1/3` elsewhere — `W.minRise_le (-r)` with `min (−t) (2·(−t)) = −(if 0 ≤ t then 2t else t)` (`omega`), cast to `ℝ`. **`exists_mem_box_of_forall_int`** (C2 with C3), a statement about a real matrix and no winding: if every integer combination `Σ_i N_i (g_i · v − w_i)` is non-negative at some vertex `v`, a point of the box solves `g_i · x = w_i` — `geometric_hahn_banach_closed_point` for `Matrix.mulVecLin g '' box` (compact by `isCompact_univ_pi`, convex by `convex_pi` and `Convex.linear_image`) and the point `w`, so no translation; the functional in coordinates by `LinearMap.pi_apply_eq_sum_univ`; C3 read at `κ = Fin m → Bool`. The leaf: generators by `Submodule.fg_iff_exists_fin_generating_family` at `AddSubgroup.toIntSubmodule (relMap s).ker`; every relation an integer combination (`Submodule.mem_span_range_iff_exists_fun`); both sides additive (`hkey`, which is C4 and the hypothesis of the real-linear half at once) | 17 + 40 + 39 |
| `exists_character_of_box_point` (L1.2) | `ψ r = ↑(Σ_j r_j x_j)` by `AddMonoidHom.mk'`; `(relMap s).rangeRestrict.liftOfSurjective` in place of the plan's `QuotientAddGroup.lift` with `quotientKerEquivRange` (one step, and `liftOfRightInverse_comp_apply` is its equation); Baer as planned; `relMap s (Pi.single j 1) = s j` | 27 |
| `exists_character_of_properAlong` (L1.3) | the plan's three lines; `Nat.cast_ofNat` and `linarith` for `2/3 = 1 − 1/3` | 8 |
| `isClosed_band` (L1.4) | `(isCompact_Icc.image (AddCircle.continuous_mk' 1)).isClosed`, as planned | 1 |

**Price.** The plan guessed 150–250 lines for L1.1; it is 96 lines of proof with its children (the counts in this table are proof lines read from the file by script, stage 3), and each of the five leaves elaborated on the
first or second run. Nothing resisted; no route of the plan failed. The whole module elaborates in 5 s at 3.6 GB.

**One difference from the plan, in my favour, said so it is not read as the plan's**: the separation is applied to the image of
the box under the *linear* map and the target point `w`, not to the image under the affine map and the origin — the same theorem
with no translation to carry.

## Stage 3 — SAVED: the last three leaves (L1.5, L1.6, L1.7); the file has no `sorry`

Under `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false` the module reads **exit 0 and no message at
all** (`data/fs131/ic1/logs/ThreeColourCharacter.out`, 0 bytes; 5.8 s, 3.6 GB); with `-Dlinter.missingDocs=true` added (the
lakefile's third option) a copy reads 0 warnings (`logs/axioms-footer.out`, first line). Not yet the build.

| leaf | how it was proved | proof lines |
|---|---|---|
| `bandSet_nonempty_of_finite` (L1.5) | the plan's compactness, by the finite intersection property in place of a directed family: the additive maps are closed in `M → ℝ/ℤ` (`AddMonoidHom.isClosed_range_coe`), hence compact; one closed condition `{φ | φ u ∈ B}` per `u ∈ U` (`hB.preimage (continuous_apply u)`); `IsCompact.inter_iInter_nonempty`, whose hypothesis at a finite set `t` of points of `U` is `h` at `t.image Subtype.val`. `U = ∅` needs no case: the compact set is the additive maps | 13 |
| `bandSet_three_nonempty_of_proper` (L1.6) | as planned: L1.5 at `band 3` with L1.4; `S.equivFin`; L1.3 | 5 |
| `fieldBandSet_three_nonempty_of_colorable` (L1.7) | as planned: `UnitRing.unitRingOver_le_planeOverSubring` puts `ℤ[U_F]` in the plane; the colouring read in `ZMod 3` by unfolding; `dist (a + u) a = ‖u‖ = 1` | 8 |

**No statement changed** (`data/fs131/ic1/statements.sh`, `logs/statements-stage3.out`): the skeleton at `34d9113b2` and the working
file, each elaborated at one path with the footer — 9 named constants compared (9 theorems: the eight leaves and
`exists_character_one_two`), kind and stored type character for character, **PASS**; 2 `example`s of the skeleton, both in the
working file as text; new: two private theorems (`winding_le_vertex`, `exists_mem_box_of_forall_int`), no new public name, no
`axiom`. Control: 3 of 3 planted faults reported; and on a real file (stage 1) a hypothesis added to one leaf is reported by name.
The diff against the skeleton is 196 insertions and 9 deletions, the deletions being the eight `sorry` lines with their `:= by` and
one `:= by` that became `:=`.

**Axioms, before the build** (`data/fs131/ic1/axioms_footer.sh`, `axioms-footer.txt`, `logs/axioms-footer.out`): a copy of the module
with `lean/AxiomsFooter.lean` appended prints the axioms of all **11** theorems the file declares (9 public, 2 private): each is
exactly `[Classical.choice, Quot.sound, propext]`. No declared outside theorem is read, and none was expected: the plan names none
for this module. Control: the same on a copy where `isClosed_band` is `sorry` reports `sorryAx` on exactly that leaf and the two
that read it (`bandSet_three_nonempty_of_proper`, `fieldBandSet_three_nonempty_of_colorable`), and on nothing else
(`axioms-footer.control.txt`).

**Models of the hypotheses** (`data/fs131/ic1/lean/ModelsBody.lean`, `models.sh copy`: exit 0, 8 `example`s; control: the first
model moved to `c = 1/2`, where the functional is positive, is an error, `logs/Models-control.out`). § Drafts has the table.

**Theorems this phase proved**, at the top of this record, is filled from the build's print at the last stage.

## Stage 4 — SAVED: the first build, what its compiled module showed, and two proof lines changed for it

**The build** (`data/fs131/ic1/build_sampled.sh data/fs131/ic1/logs/build1 8`, which is
`slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` with the process tree's memory sampled): **exit 0**,
`==> build: OK — 248 of 248 batches, 39 module(s) rebuilt, 3 module(s) with warnings, 9m44s` (19:37:11Z to 19:47:01Z;
`logs/build1.out`, the gate's whole log copied to `logs/build1.gate.log`). The 39: this tree's compiled library was two landings
behind its branch (`Plane/…`, `Outside/OAI158…`), plus this line's four modules and `Proofs`. `Arith.ThreeColourCharacter` compiled
in 7.6 s with **no message**. The three modules with warnings are the line's other three skeletons as they stand in this tree —
33 `declaration uses sorry` (`DyadicQuadratic` 10, `TorsionExtraction` 10, `ThreeColourCriterion` 13) — and the run holds no other
warning. The `✖ … ThreeColourCharacter` at the head of the gate's log is the up-to-date check naming a stale target, not a failure.

**Memory, with what it measures**: the sum of resident memory over the build's process tree, sampled every 2 s, peaked at 15.6 GB
(293 samples). Pages of `.olean` files mapped by several `lean` processes are counted once per process, and up to four ran at once
(batches that rebuilt four modules), so this is an upper estimate; the cap of 10 GiB on the build's scope was not reached (no
retry, exit 0). KN5's 5.2–5.4 GB was read by the same instrument with two to five modules stale.

**Read from the compiled module** (`data/fs131/ic1/after_build.sh`, `logs/after_build1.out`): 22 constants, 9 of them the named
theorems; the statement check against the skeleton PASS (9 compared; control 3 of 3); the nine public theorems each on
`[propext, Classical.choice, Quot.sound]`, the names being the audit block's in order (control 2 of 2); the nine model theorems
likewise (control 2 of 2). Environment linters (`lake lint --no-build -- --no-build --trace` under the slot): exit 0,
`-- Linting passed for Proofs.`, fourteen linters each `(2/2) Passed!` (`logs/lint.out`; 14 s, 5.1 GB). I planted no fault in the
house's linters: their controls are the gate's, and a plant would cost a build.

**What the dump showed that no check of mine had looked for.** Two of the 22 constants are not this file's:
`HadwigerNelson.ThreeColour.relMap.eq_1` and `HadwigerNelson.ThreeColour.minRise.eq_1` — equation theorems of the *upstream*
module's definitions, which Lean generates on demand in whichever module first asks; my proofs asked with `simp [relMap, …]` and
`simp only [minRise, …]`. `data/fs131/ic1/probes/OnDemand.lean` (the whole built library imported, read-only; controls: a name
declared once reads 1, a name declared nowhere reads 0) finds each of the two in **two** modules: `Proofs.HadwigerNelson.ThetaCert`
and this one, siblings that do not import each other. That is the class `scripts/dupnames.sh` counts and lists as `GENERATED`
without failing (`LEAN.md` § The gate) — no fault, and two new rows for the landing to read on the joined tree. I removed them at
the source instead: the two definitions are now read by unfolding (`change … at h`; `change …` before a `simp` that no longer
names `relMap`), in `winding_le_vertex` and in `exists_character_of_box_point`, each with a comment saying why. Two proof lines;
no statement touched (`logs/statements-stage4.out`: PASS, 9 compared, control 3 of 3).

**The instrument that now sees it**: `statement_diff.py` lists every constant of the working file's print that lies under no
declaration of the file (`FOREIGN`). On the first build's dump (kept as `statements-built1.txt`) it lists the two; on the revised
file it lists none. The revised file under `lake env lean`: exit 0, no message; all 11 theorems on the standard three from a copy
(control fires on the planted leaf and the two that read it); the models elaborate.

**So one build was not enough, and I say why rather than ship text the build did not compile**: the revised file differs from the
built one in two proof lines, and `lake env lean` is not the build. A second build follows (stage 5); it compiles this module, the
three skeletons downstream of it or beside it, and `Proofs`.

## Stage 5 — SAVED: the second build; the compiled module read back; the module as it stands

**The second build** (`data/fs131/ic1/build_sampled.sh data/fs131/ic1/logs/build2 8`; the same command under the slot): it waited
about seven minutes behind a landing's gate steps (`logs/build2.err`: the ledger at 14 to 18 GiB of 22), then **exit 0**,
`==> build: OK — 248 of 248 batches, 4 module(s) rebuilt, 3 module(s) with warnings, 7m8s` (launched 19:51:54Z, ended
20:05:57Z; `logs/build2.out`, the gate's log copied to `logs/build2.gate.log`). Rebuilt: `Arith.ThreeColourCharacter` (4.2 s, **no
message**), `Arith.TorsionExtraction`, `Arith.ThreeColourCriterion`, `Proofs`. The warnings are the same 33
`declaration uses sorry` of the three other skeletons (one of them replayed, not rebuilt), and nothing else. Peak of the sampled
sum of resident memory: 4.6 GB (419 samples), against 15.6 GB when 39 modules were stale.

**Read from the compiled module** (`data/fs131/ic1/after_build.sh`, `logs/after_build.out`; every step and control as expected):

| what | reading | control |
|---|---|---|
| the module's constants (`lean/StatementDump.lean` → `statements-built.txt`) | 20: the 9 named theorems, and 11 that Lean generated inside them or that are private (the two helpers among them) | a module not imported is an error, not an empty dump |
| **no statement changed**: `statements-skeleton.txt` (the skeleton at `34d9113b2`, elaborated from source — it was never compiled in this tree) against the built module's dump, kind and stored type of each of the 9 theorems, character for character after 452 hygienic binder names are replaced by `✝` in both | **PASS**, 0 differences; both `example`s of the skeleton in the file as text; no new public name, no `axiom` | 3 of 3 planted faults reported (a type changed by one character, a declaration removed, a theorem made an axiom); on a file, stage 1: a hypothesis added to `isClosed_band` is reported by name |
| constants under no declaration of this file (`FOREIGN`) | **0** — and `probes/OnDemand.lean` on the rebuilt library reads one holder, `ThetaCert`, for each of `relMap.eq_1`, `minRise.eq_1` (`logs/OnDemand.out`) | the first build's dump lists the two (`statements-built1.txt`; `logs/OnDemand-build1.out` reads two holders each) |
| **axioms of the nine public theorems**, `#print axioms` under the module's import (`lean/Axioms.lean`, `logs/Axioms.out`) | each `[propext, Classical.choice, Quot.sound]`; the names are the audit block's, in order | 2 of 2 planted records reported (one on `sorryAx`, one on an undeclared axiom); before the build, a planted `sorry` in a copy was reported on its leaf and the two that read it |
| the models (`lean/Models.lean`, `logs/Models-built.out`) | 9 theorems, each on the standard three | 2 of 2; a false model (stage 3) is an error |
| environment linters, `lake lint --no-build -- --no-build --trace` (`logs/lint.out`) | exit 0, `-- Linting passed for Proofs.`, 14 of 14 linters `(2/2) Passed!` (13 s, 5.1 GB) | none planted by me: the house's, and a plant costs a build |

**The module as it stands**: 297 lines (105 at the skeleton), 201 inserted and 9 deleted — the eight `sorry` lines, and the head
line of `isClosed_band`, whose `:= by` became `:=` with its statement untouched. 184 lines of proof in eleven theorems; the
longest line is 121 characters, the skeleton's own longest. Zero `sorry`; zero warnings from the file in either build.

**A probe downstream, not a gate** (`logs/downstream-probe.out`, `.what`): the proved text of `Arith/TorsionExtraction` as the
tree `fs131-wr2` holds it (`926d70f3d`, the file last changed at `c007de223`; no `sorry`), elaborated in this tree against the
second build's `ThreeColourCharacter`: exit 0, no message, and **all 28 of its theorems print
`[propext, Classical.choice, Quot.sound]`** — among them the five compositions that read this module's headline
(`colorable_two_of_inv_three_mem`, `four_le_chromaticNumber_planeOver_of_inv_three_mem`,
`chromaticNumber_planeOver_ne_three_of_inv_three_mem`, `four_le_chromaticNumber_planeOver_of_sqrt_mem`,
`four_le_chromaticNumber_planeOver_fieldOfRadicands`). That is `lake env lean` on another tree's file, read once: it says the
two modules meet; the join's build and gate say the rest.

**Prices.** The plan guessed 150–250 lines for the one hard leaf; it took 99 lines of proof with its two children, and every leaf
elaborated on its first or second run. No route of the plan failed; no library name the plan cites was missing; three routes were
shortened (the separation with no translation; `liftOfSurjective` for the descent; the finite intersection property in place of a
directed family). The cost I did not foresee was the second build.

## The job's id is not new: what I did about it

`FS131-IC1` was the id of the implementer that proved part of `Plane/ValidMap/Contact` on 2026-10-04 (brief
`data/fs131/briefs/FS131-IC1-contact.md`; record `plans/FS131-IC-implementation.md`; data `data/fs131/ic/`; eight commits headed
`FS131-IC1:`; a block of `scripts/Axioms.lean` headed "job FS131-IC1"). Today's brief reuses it, and the report path it names,
`data/fs131/reports/FS131-IC1.md`, **holds that job's report** on this branch and on `main`. I found this at the last step, when
my write to that path showed in `git status` as a modification; I restored the older report unchanged (`git checkout --`, nothing
of it was committed over) and wrote mine to **`data/fs131/reports/FS131-IC1-leaves.md`**, after the brief's own file name. My
record and data paths (`plans/FS131-IC1-implementation.md`, `data/fs131/ic1/`) were new and collide with nothing. What I could
not undo: my commits are headed `FS131-IC1:` like the older job's eight; a reader of `git log` tells them apart by date and
by the words "stage n" against "stage n SAVED". The audit block's header (D1) says which job it is.

## Drafts for the front page

*Each draft names its slot. Nothing here is filed by me: `scripts/Axioms.lean`, `ARCHITECTURE.md`, `LEDGER.md`, `CLAUDE.md` and
the gate on the joined tree are the landing's. A grade moves only when the module is on `main` through the gate.*

### D1 — the audit block (slot: `scripts/Axioms.lean`, the CLEAN section, appended just above the PURCHASED banner)

`data/fs131/ic1/audit-block.txt`, generated by `data/fs131/ic1/make_audit.py` from the compiled module's dump and the source at
once (it fails if a written public declaration is not exactly one named constant of the dump, or the reverse):

```
-- FS131-IC1 of 2026-10-13 (brief FS131-IC1-leaves; not the job of that id that proved `Contact` on 2026-10-04):
-- Arith/ThreeColourCharacter (9: 9 theorems, 0 definitions; every public declaration a
-- person typed, in the file's order — the kernel's list, data/fs131/ic1/statements-built.txt, through
-- data/fs131/ic1/make_audit.py).  Statements FS131-KN4's and FS131-KN5's; the eight leaves' proofs FS131-IC1's.
-- The file's 2 private helpers (winding_le_vertex, exists_mem_box_of_forall_int) are not nameable here;
-- each is read by `ThreeColour.Winding.exists_box_point` below.  Every record CLEAN: no declared outside theorem
-- is read.  One name is declared outside the module's namespace: HadwigerNelson.ThreeColour.Winding.exists_box_point.
#print axioms HadwigerNelson.ThreeColourCharacter.exists_int_vector_of_forall_neg
#print axioms HadwigerNelson.ThreeColour.Winding.exists_box_point
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_of_box_point
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_of_properAlong
#print axioms HadwigerNelson.ThreeColourCharacter.isClosed_band
#print axioms HadwigerNelson.ThreeColourCharacter.bandSet_nonempty_of_finite
#print axioms HadwigerNelson.ThreeColourCharacter.bandSet_three_nonempty_of_proper
#print axioms HadwigerNelson.ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_one_two
```

**Counts this module moves** (slot: `CLAUDE.md` § Trust ledger, the sentence "the current audit reads … clean and … declared
purchases, and … imported"): **nine more clean records; no purchase, no import, no `axiom`.** The audit's own totals are the
landing's to read on the joined tree; I did not run `scripts/axioms.sh`. **The assumptions step** (slot: the nine counts of the
same section): this module declares no hypothesis former and takes no closed hypothesis — every hypothesis is over the theorem's
own variables (a winding of `s`, a colouring proper along `s`, integrality on relations, a closed band, characters on finite
subsets, a colouring of a plane) — so I expect no count to move; not run by me. **The vacuity scan** (slot: `CLAUDE.md` § The
gate, the counts line): not run by me; what it will meet is D2's table. **`scripts/dupnames.sh`**: this module adds no name another
module declares, and since stage 4 no on-demand theorem either (`statement_diff.py`'s `FOREIGN` list is empty on the built module).

### D2 — an inhabitant or a model for each hypothesis of the module's theorems

`data/fs131/ic1/lean/ModelsBody.lean` holds each as a named theorem that reads the leaf at the model (so it is the leaf's
conclusion at an object the kernel holds), elaborated against the built module (`models.sh built`), each on the standard three.
It is not part of the library; the landing may lift any of them into the module's spec section.

| theorem | hypothesis | model | where the kernel holds it |
|---|---|---|---|
| `exists_int_vector_of_forall_neg` | `h : ∀ k, ℓ k c < 0` | the coordinate functional on `Fin 1 → ℝ` at `c = −1/2`, which is no integer vector | `FS131IC1Models.int_vector_model` (not library) |
| `ThreeColour.Winding.exists_box_point` | `W : Winding s` | `ℤ` along `(1, 2)` | `ThreeColour.nonempty_winding_one_two` (library, upstream); read at it in `box_point_model` |
| `exists_character_of_box_point` | `hx`: the form is an integer on every relation | `ℤ` along `(1, 2)`, `x = (1/3, 2/3)`: on `r₀ + 2r₁ = 0` the form is `0` | `character_of_box_point_model` (not library); in the library the hypothesis is met inside `exists_character_of_properAlong`, from a winding |
| `exists_character_of_properAlong` | `hc : ProperAlong s c` | `ℤ` along `(1, 2)`, `x ↦ x mod 3` | `ThreeColour.properAlong_one_two` (library); `exists_character_one_two` in this file is the conclusion there |
| `isClosed_band` | none | — | — |
| `bandSet_nonempty_of_finite` | `hB : IsClosed B`; `h`: a character on every finite subset | `M = ℤ`, `U = {1}`, `B = band 2`, the character `half` | `finite_model` (not library), over `isClosed_band 2` and `CharacterColouring.half_mem_bandSet` |
| `bandSet_three_nonempty_of_proper` | `hc`: the colouring changes along every step in `U` | `ℤ`, `U = {1, 2}`, `x mod 3`; and with torsion, `ZMod 5`, `U = {1}`, `(0, 1, 0, 1, 2)` | `proper_model`, `proper_model_torsion` (not library) |
| `fieldBandSet_three_nonempty_of_colorable` | `h`: the plane over `F` is 3-colourable | **no declaration of this branch exhibits one.** In mathematics: `F = ℚ` (two colours, hence three) and `F = ℚ(√3)` (exactly three) | on other branches of this line: any two-colourable plane through `SimpleGraph.Colorable.mono` — `DyadicQuadratic.colorable_two_planeOver_sqrt` (another job's leaf) — or `UpperHalf.colorable_planeOver_of_finitePlane` on `fs131-wnf`; the landing after the join can state the model in one line |

The module's docstring says of its inhabitants that `ThreeColour.properAlong_one_two` "inhabits every hypothesis here". It
inhabits the hypothesis of `exists_character_of_properAlong`; the table above is the whole account. **Draft** (slot: the module
docstring's last paragraph, replacing its two lines; a docstring, so it recompiles the module and its dependents):

> **Inhabitants.** `ThreeColour.properAlong_one_two` (`ℤ` along `(1, 2)`, `x ↦ x mod 3`) inhabits `exists_character_of_properAlong`,
> and `exists_character_one_two` is its conclusion there; `ThreeColour.nonempty_winding_one_two` inhabits
> `Winding.exists_box_point`. `bandSet_three_nonempty_of_proper` has the same model as a set of steps (`U = {1, 2}`), and
> `bandSet_nonempty_of_finite` the character `half` on `U = {1}` at `band 2`. No declaration of this module exhibits a subfield
> of `ℝ` whose plane is three-colourable — the hypothesis of `fieldBandSet_three_nonempty_of_colorable`; `ℚ` is one (two colours),
> and the joining module states it.

### D3 — what a reader of the statements should be told that the docstrings do not say

1. **Whose each thing is.** This module states **no chromatic number, no upper bound and no unit vector**: nothing in it is an
   outside model's, `[Fischer1990]`'s or `[Johnson2000]`'s, and it reads no declared outside theorem (Weil's bound enters the
   line only in `Arith/ThreeColourCriterion`). What it holds is the ⟹ half of the three-colour criterion in character form —
   this project's FS73-T22 with FS81-T2's passage to all generators, `[hand; two independent derivations]` in `LEDGER.md` row 79
   and § B — now with a kernel proof on this branch. The docstring's "not found in print" is the planner's sentence; the
   ledger's claim list uses those words (`LEDGER.md:27`) of "the passage from additive to all three-colourings at the field
   level" (rows 82–83), which is this module's § 3. I copy both and raise neither. The proof's three tools are classical and are
   named so in the docstrings except the first: `Winding.exists_box_point` is a finite-dimensional separation (Hahn–Banach for a
   compact convex set and a point, with the passage real → rational → integer coefficients), a theorem of the alternative of
   Farkas's kind; `exists_character_of_box_point` is the divisibility of `ℝ/ℤ` (Baer); `bandSet_nonempty_of_finite` is Tychonoff's
   theorem (the docstring's "de Bruijn–Erdős in character form"). The stub `plans/STUB-three-colour-criterion-kernel.md` names the
   literature's words for the winding itself (a circulation of an integer tension; Minty, Tutte) — recalled from that stub, not
   read by me.
2. **The scope is wider than the ledger's sentence.** Row 79 states the criterion for a finitely generated torsion-free group and
   a finite symmetric generating set. `exists_character_of_properAlong` and `bandSet_three_nonempty_of_proper` hold for **every
   abelian group and every set of steps** — torsion allowed, `U` infinite, not symmetric, not generating (`proper_model_torsion`
   is the 5-cycle). The ⟸ half (a character with `θ(U) ⊆ [1/3, 2/3]` gives the colouring "which third of the circle `θ a` lies
   in") is five lines for every abelian group (`[hand, one mind, the implementer]`; prior art not searched by me). It is **not**
   in this module, and at three colours not in the library (`rg -i bandset Proofs/` beside `Colorable`: at two colours both
   directions are `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty`; at three, only this module's ⟹). Clause (b)
   of the line's theorem reaches its ⟸ another way, through a finite plane.
3. **The headline reads the colouring only on `ℤ[U_F]`.** `fieldBandSet_three_nonempty_of_colorable` assumes a 3-colouring of
   the whole plane over `F`; its proof restricts it to `unitRing F` and never looks elsewhere. The statement is true, with the
   same proof, under the weaker hypothesis `((unitDistance ℂ).induce (unitRing F : Set ℂ)).Colorable 3`. The skeleton's form is
   kept; it is the form every consumer on this line holds.
4. **`band k` at `k = 0` and `k = 1`** (a definition of `Arith/CharacterColouring`, read here by `isClosed_band` at every `k`):
   `1 / (0 : ℝ) = 0`, so `band 0` is the whole circle, and `band 1` is the image of `Icc 1 0`, the empty set. Both are closed and
   the theorem is true of them; a reader should not take `band k` for `[1/k, 1 − 1/k]` below `k = 2`.
5. **The spec section's comment promises more than the file checks**: "The band at 3 holds `1/3`, `1/2` and `2/3`, and not `0`"
   stands above two `example`s (`1/3`, `1/2`). The other two are proved in `ModelsBody.lean` (`band_two_thirds`,
   `band_zero_not_mem`) and can be pasted as `example`s; `0 ∉ band 3` is the one that says a point of a band set is a condition.
6. **Nothing here is conditional**: no hypothesis stands for a hand result, an outside theorem or an open question.

### D4 — ledger rows, regraded at the landing (slot: `LEDGER.md` § B, the last cell of each row)

- Row `FS73-T22` — replaces "kernel for ⟹ in winding form (`ThreeColour.nonempty_winding_of_colorable`, row 119); ⟸ and the `θ`
  form stub (`plans/STUB-three-colour-criterion-kernel.md`)" with: "kernel for ⟹ in winding form
  (`ThreeColour.nonempty_winding_of_colorable`, row 119) and in `θ` form, for every abelian group and every set of steps
  (`ThreeColour.Winding.exists_box_point`, `ThreeColourCharacter.exists_character_of_properAlong`,
  `ThreeColourCharacter.bandSet_three_nonempty_of_proper`; FS131-IC1; `[propext, Classical.choice, Quot.sound]`, no assumption);
  ⟸ stub (`plans/STUB-three-colour-criterion-kernel.md`)".
- Row `FS81-T2` — replaces "stub (FS-75)" with: "kernel: `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`, every
  subfield `F ⊆ ℝ` (FS131-IC1; `[propext, Classical.choice, Quot.sound]`, no assumption)". Its grade cell "hand, two independent
  derivations" gains "; kernel".
- Row 79 (the claim list's sentence) is not mine to reword; D3 item 2 is the fact its "finitely generated torsion-free" does not
  need for the ⟹ half.

### D5 — the module map (slot: `ARCHITECTURE.md`, the row of `Arith/ThreeColourCharacter`)

Replaces "**FS-131, NF4 (FS131-KN4, passes FS131-KN5; a skeleton: eight leaves are `sorry` until its implementer lands).**" with
"**FS-131, NF4 (statements FS131-KN4, passes FS131-KN5; proofs FS131-IC1; no `sorry`).**" The rest of the row stands: no
declaration was added to the public surface and no import changed.

### D6 — the Frontier line and the Proof Atlas (slots: `CLAUDE.md` § Frontier, where FS-131's NF4 line is reported; the Atlas's
nodes for FS73-T22 and FS81-T2)

This module alone moves no value. Its sentence: "NF4-S6 is kernel-checked: a proper 3-colouring of the plane over any subfield
`F ⊆ ℝ` gives a character of `ℤ[U_F]` with values in `[1/3, 2/3]` on every unit vector
(`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`), on the standard three axioms with no assumption." Atlas: the
nodes FS73-T22 (⟹, `θ` form) and FS81-T2 move from [hand] to [kernel] at the landing; FS73-T22's ⟸ stays [hand].

### D7 — a Lean fact (slot: `LEAN.md` § Searching — Lean, a new line after the one on a filled skeleton's statements)

- `simp [f]` or `simp only [f]` on a definition `f` of an **upstream** module makes Lean generate `f.eq_1` in the module that
  asks; if a sibling module asked first, the library then holds two copies — a `GENERATED` row of `scripts/dupnames.sh`, not a
  failure, and a row the landing has to read. Read the definition by unfolding instead (`change <its body> at h`, or `change`
  before a `simp` that no longer names `f`), or give `f` its equation as a stated lemma where it is defined. A dump of the
  compiled module shows it — a constant under no declaration of the file — and no check of the source does: FS131-IC1's first
  build held `ThreeColour.relMap.eq_1` and `ThreeColour.minRise.eq_1`, which `ThetaCert` already held
  (`data/fs131/ic1/statement_diff.py`'s `FOREIGN` list; `data/fs131/ic1/probes/OnDemand.lean`) (FS131-IC1).

**A question the same finding leaves, for the planner's lane, not answered here**: `ThreeColour.relMap` and `ThreeColour.minRise`
are public definitions with no stated equation — `ThetaCert` unfolds them by `simp` too. A `relMap_apply` and a `minRise_def`
beside the definitions would end the class at its source; that is an edit to a module outside this job's touches.
