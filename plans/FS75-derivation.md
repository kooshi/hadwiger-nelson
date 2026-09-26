# FS-75's minimal instance (`χ(ℚ(√167)²) ≥ 4` in the kernel) — the kernel register, and the derivation file

*Written 2026-09-26 at the milestone's close (WORKFLOW 2.0 step 9) by crunch job J54 (de Bruijn, Opus 5.5, the close planner), from the
plan `plans/FS75-kernel-167.md` (planner J52) and the kernel record `plans/FS75-K-kernel-167.md` (kernel engineer J52K). The milestone moved
row 79's lower bound from a checker's word to the kernel's, so this file has two parts, in the form M2's close used
(`plans/M2-derivation.md`). **Part I is the kernel register**: the declarations a result rests on, with file, line, axioms, whether the
gate's audit prints them, what they state in plain words, and the hand result they promote. **Part II is the derivation file proper**: one
entry per result, in the form `tools/fs71_ledger_b_check.py` reads — the kernel results graded [kernel] with their Lean addresses (as the
brief asks), and the two statements the records prove outside the kernel graded as they were proved. The § B lines are drafted in the plan's
§R-close, not written into `LEDGER.md`.*

*How the columns were read.* **Lines** at `HEAD` after J52K (`5e4c22a4`; the five modules are unchanged since `a34c9765`). **Axioms** from
the owner's gate run at the milestone's end, `build/gate/axioms/20260926T053431Z-866750.log` (1,209 records: 1,193 clean, 11 axiom-free,
5 declared purchases): `std` means exactly `[propext, Classical.choice, Quot.sound]`; the 63 new public theorems are each printed by
`scripts/Axioms.lean`, all within those three, none on `sorryAx` or a native axiom. **Audit** = printed by the gate. Grades are `CLAUDE.md`
§ Notation's.

## Part I — the kernel register

### I.1 The winding (`Proofs/HadwigerNelson/ThreeColour.lean`, namespace `HadwigerNelson.ThreeColour`; Mathlib imports only)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `relMap` (def) | 48 | — | — | `r ↦ Σ_j r_j • s_j : (Fin m → ℤ) →+ A`; its kernel is the relation lattice (the Heuberger matrix's lattice, in the Krebs line's words) | FS73-T42's `R` |
| `minRise` (def) | 55 | — | — | `Σ_j min(r_j, 2r_j)`, three times the box minimum (renamed from `boxMin` at J52's experience pass) | T42's box bound |
| `Winding` (structure) | 59 | — | — | an additive `W` on `ker (relMap s)` with `minRise r ≤ 3 W(r)` there | the plan's 1.3 |
| `ProperAlong` (def) | 67 | — | — | `c : A → ZMod 3` with `c (a + s j) ≠ c a` for all `a`, `j` | — |
| `step_mem` … `height_perm` (1a–1d) | 98–147 | std (`height_append`: `[propext, Quot.sound]`) | yes | the lift: steps in `{1, 2}`, heights along words cast to `c` mod 3, bounded by `[n, 2n]`, and path-independent under permutation (`step_square`: the two two-step sums around a square agree) | T42 steps 1–2 |
| `wsum_word`, `length_word`, `count_word`, `word_add_perm` (1e) | 168–181 | std | yes | words of a count vector: their sum is `Σ v_j • s_j`, their length `Σ v_j`, and `word (v + v') ~ word v ++ word v'` | — |
| `wind_shift`, `wind_add_diag`, `wind_add`, `wind_cast`, `minRise_le_wind`, `wind_eq_of_sub_eq` (1f–1g) | 198–236 | std | yes | the winding of a balanced pair `(u, v)` is independent of the base point, additive, `≡ 0 (mod 3)` and at least `minRise` | T42 step 3 |
| **`nonempty_winding`** | 257 | std | yes | **a colouring proper along `s`, of any abelian group, carries a winding** — no torsion-freeness, generation, averaging, compactness or duality | FS73-T42 (⟹, relation form) without its averaging |
| `nonempty_winding_of_colorable` | 286 | std | yes | the same from a proper 3-colouring of `addCayley (Set.range s)`, given `s j ≠ 0` | FS73-T22 (⟹) |
| `properAlong_one_two`, `nonempty_winding_one_two` | 296, 301 | std | yes | the inhabitants: `x ↦ x mod 3` along `(1, 2)` on `ℤ` | G30 (5) |

### I.2 The certificate (`Proofs/HadwigerNelson/ThetaCert.lean`, namespace `HadwigerNelson.ThetaCert`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `Con`, `Tree`, `Cert` (types); `checkTree`, `checkKids`, `leafOk`, `Cert.check` (defs) | 39–125 | — | — | V2's relation-branching format with integer multipliers: a branch names a relation and `lo..hi`, and the checker derives the children's constraints from `(r, lo, hi)`; a leaf's multipliers combine cited constraints into `Q`, `P` with `3P < minRise Q`, the sign guard requiring non-negative multipliers on inequalities | `tools/fs73v2_check.py`'s semantics (`data/fs73/records/verify-P3b-q167.md` §2) |
| `Soundness.leaf_bound`, `leafOk_sound` | 246, 269 | std | yes | at a passing leaf, the combined `Q` lies in the lattice and `W(Q) ≤ P`, so `minRise Q ≤ 3W(Q) ≤ 3P` contradicts the leaf | — |
| `Soundness.exists_holds_childCons` | 286 | std | yes | coverage: for every value of `W(r)` some child's constraint holds (every `lo`, `hi`) | — |
| `Soundness.checkTree_sound`, `checkKids_sound` | 306, 316 | std | yes | the walk, **by mutual structural recursion on the nested `Tree`** (`termination_by structural`), generic in the group and the relation list | — |
| **`Cert.isEmpty_winding`** | 336 | std | yes | **a passing certificate leaves no winding on its units** | FS73-T39's certificate semantics |
| `Cert.not_properAlong` | 346 | std | yes | hence no colouring is proper along the units | — |
| `tinyK4_isEmpty_winding` | 364 | std | yes | the control: `{1, 2, 3} ⊂ ℤ` has no winding (five leaves) | J52 §S.2 |
| `signPlant` (def) and two `example`s | 388–395 | — | no (examples) | `signPlant.check = false`, and `Nonempty (Winding signPlant.gen)`: the certificate the guard-free checker would accept | J52K §5.1 |

### I.3 The plane (`Proofs/HadwigerNelson/ThetaPlane.lean`, namespace `HadwigerNelson.ThetaPlane`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `iota` (def), `iota_re`, `iota_im`, `iota_mem` | 29–38 | std | yes | `(a, b, c, e) ↦ ((a + b√d)/D, (c + e√d)/D)` as an additive map `(ℕ → ℤ) →+ ℂ`, landing in `F²` for every real `F ∋ √d`; no injectivity needed | verify-P3b-q167 §1's subgraph step |
| `unitOk` (def), `norm_iota` | 44, 51 | std | yes | `a² + d·b² + c² + d·e² = D²` and `ab + ce = 0` make `iota` a unit vector | — |
| `properAlong_of_colorable` | 64 | std | yes | a proper colouring of the plane over `F`, read at `iota`, is proper along the certificate's units | — |
| **`four_le_chromaticNumber_of_cert`** | 83 | std | yes | **a passing certificate with `unitOk` units proves `χ(F²) ≥ 4` for every real field `F ∋ √d`** — any `d`, `D ≠ 0` | the stub's shape items 3–4 |

### I.4 The instance (`Proofs/HadwigerNelson/Instances/SqrtOneSixSeven.lean` and `…/SqrtOneSixSeven/Cert.lean`)

| declaration | line | axioms | audit | what it states | ancestor |
|---|---|---|---|---|---|
| `Sqrt167.cert` (def, the literal) | `Cert.lean` | — | — | T41's 36-vector certificate (18 units, 19 relations, 1,050 leaves) in integer form, emitted by `tools/j52_intcert.py` from `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz` (sha256 `d67ffaea…6e78`) | FS73-T41 |
| `Sqrt167.cert_units`, `Sqrt167.cert_check` | 28, 31 | `[propext]` | yes | both by `decide +kernel`; the module in 12.22 CPU s at 5.49 GiB, the literal module 7.12 s at 2.09 GiB (desktop, minimum of three) | FS73-T41's certificate |
| **`four_le_chromaticNumber_planeOver_sqrt167`** | 37 | std | yes | **`4 ≤ χ` of the unit-distance graph on `ℚ(√167)²`** — row 79's bound, no finite graph | row 79, FS73-T39 |
| `four_le_chromaticNumber_planeOver_of_sqrt167_mem` | 43 | std | yes | the same for every real field holding `√167` | — |

### I.5 What the kernel does not prove

- **The criterion's ⟸ direction and its full ⟹ form** (a character `θ` with `θ(S) ⊆ [1/3, 2/3]`): the kernel holds the winding only.
  The real point `x ∈ [1/3, 2/3]^m` with `r·x ∈ ℤ` on the lattice exists by finite LP duality from the winding (J52 §1.3, §M domain pass) —
  stated, **not proved** here or in the kernel.
- **T41's four-case hand proof** (`θ`-space): declined, it needs the full criterion (J52 §S.4).
- **The 60-vector tree** (`L21cc6506-empty.json.gz`, 30,344 leaves, P-60) and **`Ld65c8ee8`** over `d = 11`: V2's format, each a one-line
  instance of `four_le_chromaticNumber_of_cert` once `tools/j52_intcert.py` takes `(d, D)`; not run.
- **ℚ(√47)'s T26 tree**: a `θ`-space tree for Coxeter's `certcheck.py`, not V2's format; it needs a second checker (J52K §5.4).
- **The family theorem** (row 82, `d ≡ 11 (mod 12)`): FS-75's next target.
- **Any upper bound** at ℚ(√167): `≤ 7` only through the plane (row 33); `L = 7` or 6 is G59's.

### I.6 The hand results this register promotes (their `LEDGER.md` § B kernel columns change; drafted in the plan's §R-close)

| § B id or row | the hand statement | now in the kernel as | how much |
|---|---|---|---|
| `FS73-T22` | the three-colour criterion (both directions) | its ⟹ in winding form, `nonempty_winding_of_colorable` | ⟹ only, winding form; not `θ`, not ⟸ |
| `FS73-T42` | the ⟹ by a forward `{1, 2}` lift and Følner averaging; the relation form | `nonempty_winding` | steps 1–3, with no averaging |
| `FS73-T39` | `L21cc6506` has `Θ₃ = ∅`, so `χ(ℚ(√167)²) ≥ 4` | `four_le_chromaticNumber_planeOver_sqrt167`, through T41's sub-lattice | the field bound in full; the 60-vector emptiness not |
| `FS73-T41` | the 36 vectors `{1, v, z}·U_R` have `Θ₃ = ∅` | its 1,050-leaf certificate: `Sqrt167.cert_check`, `Cert.isEmpty_winding` | the certificate; the four-case hand proof not |
| row 79 | `χ(ℚ(√167)²) ≥ 4` [cert + hand] | as above | in full |

## Part II — the results, one entry each

*Seven entries. **None is new mathematics** (standing rule 4, and the close-time gate, plan §R-close stage 2): the bound is row 79's
(FS-73), the criterion T22's, the lift T42's; the kernel forms are this milestone's. Verification: the kernel for the five kernel entries
(the owner's gate re-run, inventory 31; the headline read aloud against the informal claim by J52K §5.2 and by the owner, inventory 32);
FS75-N1 is one mind's hand counterexample, checked here by a second reading (its two lines re-derived at the close, below).*

**FS75-W — the winding form of the three-colour criterion's ⟹ direction: a colouring `c : A → ZMod 3` of an abelian group, proper along `s : Fin m → A`, carries an additive `W` on the relation lattice `ker(r ↦ Σ_j r_j • s_j)` with `Σ_j min(r_j, 2r_j) ≤ 3W(r)`; and from a proper 3-colouring of `addCayley (Set.range s)` when every `s j ≠ 0`. [kernel; derived by hand first (J52 §1.3, one mind), kernel-checked by J52K]**
*Proof:* `plans/FS75-kernel-167.md` §1.3 and §S.3 leaf 1 (1a–1g): the height along words with steps in `{1, 2}`, path-independent by the
square argument, gives `w(r) = height(word r⁺) − height(word r⁻)`, additive, `≡ 0 (mod 3)` and at least `|r⁺| − 2|r⁻| = Σ_j min(r_j, 2r_j)`;
`W = w/3`. *Proof verdict:* kernel-checked — `nonempty_winding` and `nonempty_winding_of_colorable`, standard three axioms (register § I.1);
P-elem met: `List.Perm`, `ZMod 3`, `omega`, `linarith`, `ring`, finite sums, nothing analytic (J52K §5.5). *Rests on it:* FS75-C's use (the
certificate's semantics), FS75-H; FS-75's next target (the family theorem, row 82) as its first input. *Prior art:* FS73-T42's steps 1–3
(V2, `data/fs73/records/verify-P3b-q167.md` §1) without the averaging; the height through `K₃`'s universal cover is `[Chandgotia2017]`'s; the
integer lift of a colouring to a tension with values in `[1, k−1]` is Minty 1962's orientation theorem (listing only) and Tutte's duality;
the grid's three-colouring cocycle is `[CGHO2025coh]` Example 2.4. Not found as a statement for arbitrary abelian groups (the close-time
gate, fourteen zbMATH queries, plan §R-close stage 2); not claimed new. *Kernel:* kernel — `ThreeColour.nonempty_winding`
(`ThreeColour.lean:257`), `ThreeColour.nonempty_winding_of_colorable` (line 286).

**FS75-N1 — the hypothesis `s j ≠ 0` of `nonempty_winding_of_colorable` is necessary: at `s = ![0]` on `ℤ` the Cayley graph is edgeless, so 3-colourable, while no winding exists. [hand; J52K, one mind; re-derived at the close]**
*Proof:* `plans/FS75-K-kernel-167.md` §5.1. `addCayley {0}` has no edges (`x + 0 = y` forces `x = y`); `relMap ![0]` is zero, so its kernel is
all of `ℤ¹`, and a winding needs `1 = min(1, 2) ≤ 3W(1)` and `−2 = min(−1, −2) ≤ 3W(−1) = −3W(1)`, that is `1/3 ≤ W(1) ≤ 2/3` in `ℤ`.
*Proof verdict:* closes (re-derived at the close, the two inequalities above). The kernel saw the proof break for this reason: with `hs`
deleted and its use replaced by `simp_all`, the unsolved goal was `h : s j = 0 ⊢ False` (J52K §5.1). Note the plain `nonempty_winding`
needs no such hypothesis: at `s j = 0` no colouring is proper along `s`. *Rests on it:* the mutation audit's verdict that the hypothesis is
used for its reason (G30 (6)). *Prior art:* none sought (a two-line counterexample). *Kernel:* declined — a counterexample to a deleted
hypothesis has no consumer; the proof's break is recorded.

**FS75-C — a passing relation-branching certificate leaves no winding: if `c.check = true` then `IsEmpty (Winding c.gen)`, so no colouring of `ℕ → ℤ` is proper along the certificate's units; the checker's three well-formedness guards are not used by the proof, and its sign guard is (FS75-N2). [kernel; the obligation pass by hand first (J52 §S.3 leaf 2, one mind)]**
*Proof:* J52 §S.3 2a–2f, as landed in J52K Stage 3: defaults instead of range guards (`cite path i` defaults to the equation `W 0 = 0`, which
every winding satisfies; `getD_induction`), coverage for every `lo`, `hi`, the leaf's tupled induction, and the walk by mutual structural
recursion on the nested `Tree`. *Proof verdict:* kernel-checked — `Cert.isEmpty_winding`, `Cert.not_properAlong`, with
`Soundness.checkTree_sound` generic in the group and the relation list; P-tree met (structural, no `Tree.rec` fallback). Controls: `tinyK4`
passes, its three plants fail, all by `decide +kernel`; two plants on the real certificate refused, the faithful copy accepted
(`tools/j52k_plant.py`, J52K Stage 4). *Rests on it:* FS75-T, FS75-H; FS-60's V2-format certificates. *Prior art:* V2's certificate format
and its Fraction checker (`tools/fs73v2_check.py`, FS-73); the kernel checker ours. *Kernel:* kernel — `ThetaCert.Cert.isEmpty_winding`
(`ThetaCert.lean:336`), `ThetaCert.Cert.not_properAlong` (line 346).

**FS75-N2 — the checker's sign guard is necessary: without "non-negative multipliers on inequalities" the checker accepts `signPlant` (ℤ along `(1, 2)`, relation `(2, −1)`, a branch at `lo = hi = 5` whose child `W(r) ≤ 4` is refuted by the multiplier `−1`) while `Winding signPlant.gen` is inhabited. [kernel (the two facts, as `example`s); the guard-free acceptance by `decide +kernel` in a scratch copy, not committed]**
*Proof:* `plans/FS75-K-kernel-167.md` §5.1. The multiplier `−1` turns `W(r) ≤ 4` into `Q = (−2, 1)`, `P = −4`, and `3P = −12 < −3 =
minRise Q`, so the guard-free leaf passes; but multiplying an inequality by a negative number reverses it. `x ↦ x mod 3` along `(1, 2)` gives
`W = 0` on the lattice (`ThreeColour`'s spec example `wind … = 0`). *Proof verdict:* kernel for `signPlant.check = false` and
`Nonempty (Winding signPlant.gen)` (`ThetaCert.lean` 393–395); the scratch acceptance recorded, not reproducible from the tree. *Rests on it:*
the mutation audit (G30 (6)). *Prior art:* none sought (a plant). *Kernel:* kernel (as above); the guard-free checker is not in the library,
by design.

**FS75-K4 — `{1, 2, 3} ⊂ ℤ` carries no winding, by a five-leaf certificate on the relations `(3, 0, −1)` and `(2, −1, 0)`. [hand (J52 §S.2); kernel]**
*Proof:* J52 §S.2 and §S.3 (the certificate derived by hand); its `check` by `decide +kernel`. *Proof verdict:* kernel —
`tinyK4_isEmpty_winding`; three plants (a leaf's multipliers negated, a non-relation, a dropped child) each return `false`. *Rests on it:*
leaf 2's control. *Prior art:* the graph contains `K₄` (`0, 1, 2, 3`), so the conclusion is immediate; the certificate is the control, not
the fact. *Kernel:* kernel — `ThetaCert.tinyK4_isEmpty_winding` (`ThetaCert.lean:364`).

**FS75-T — the plane transfer: a passing certificate whose units satisfy `a² + d·b² + c² + d·e² = D²` and `ab + ce = 0` proves `χ(F²) ≥ 4` for every real field `F ∋ √d`, any `d` and `D ≠ 0`, with no finite graph and no injectivity. [kernel]**
*Proof:* J52 §S.3 leaf 3 as landed in J52K Stage 4: `iota` additive and into `planeOver F`; `norm_iota` by `linear_combination` of the two
integer identities; a colouring of the plane read at `iota` is proper along the units (FS75-C then refuses it);
`add_one_le_chromaticNumber_iff_not_colorable`. *Proof verdict:* kernel-checked. *Rests on it:* FS75-H; FS-60's quadratic witnesses and
the 60-vector control, each one line once emitted. *Prior art:* the subgraph step of `verify-P3b-q167.md` §1; the statement shape is
`four_le_chromaticNumber_planeOver_eleven`'s (row 73) and the chain theorem's (row 103). *Kernel:* kernel —
`ThetaPlane.four_le_chromaticNumber_of_cert` (`ThetaPlane.lean:83`).

**FS75-H — `χ(ℚ(√167)²) ≥ 4`, and `χ(F²) ≥ 4` for every real field `F ∋ √167`, from T41's 36-vector certificate (18 units of denominator 420, 19 relations, 1,050 leaves) checked by `decide +kernel`, with no finite graph. [kernel]**
*Proof:* FS75-T at `d = 167`, `D = 420`, with `Sqrt167.cert_units` and `Sqrt167.cert_check`. *Proof verdict:* kernel-checked on the standard
three axioms, no native purchase (the certificate facts on `[propext]` alone); 12.22 CPU s and 5.49 GiB for the instance module, 7.12 s and
2.09 GiB for the literal (P-check met); the statement read aloud against the informal claim by J52K (§5.2) and the owner (inventory 32).
*Rests on it:* `LEDGER.md` row 79's bound moves to the kernel (row 119, drafted); the conjecture's widest gap now has its lower end in the
kernel (four proven, six or more predicted, G59). *Prior art:* the bound is FS-73's (row 79; FS73-T39, T41), not found in print before it
(FS-73's close); the kernel form ours. *Kernel:* kernel — `four_le_chromaticNumber_planeOver_sqrt167`
(`Instances/SqrtOneSixSeven.lean:37`), `four_le_chromaticNumber_planeOver_of_sqrt167_mem` (line 43).
