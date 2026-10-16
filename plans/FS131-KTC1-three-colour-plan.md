# FS131-KTC1 — three-colourings of lattice Cayley graphs at the kernel: the criterion's converse, periodicity, density

*Planner: de Bruijn (Opus 5.5), job FS131-KTC1, brief `data/fs131/briefs/FS131-KTC1-three-colour.md` (on `main` at `9a545b3c4`).
Worktree `.claude/worktrees/kel1`, branch `fs131-ktc1`, cut from `main` at `99e78e428`. Started 2026-10-16 13:33 UTC. No fence
(`plans/FS131-close-inventory.md` § Rulings in force, ruling 1).*

## Theorems this phase proved

None. A planning job: the skeleton's statements carry `sorry` at every leaf, and nothing of it reaches `main`.

## Stage 1 — SAVED: the readback

### 1.1 The quotations of the brief, checked against their sources

Each quotation was compared byte for byte by a script against its source in this worktree (`main` at `99e78e428`; the brief
itself is on `main` at `9a545b3c4`, after the cut, and was read there).

| quotation | source | result |
|---|---|---|
| W2 (2026-10-13) | `data/fs131/REQUEST-2026-10-13.md` l. 4 | identical |
| *The theorem.* (Rank 5, C6) | `plans/POROS-2026-10-13-number-field-findings.md` § 3.3, l. 406–408 | identical |
| *The first objection.* (Rank 5, C6) | the same file, l. 415–416 | identical |
| ledger row 79, whole | `LEDGER.md` row 79 (unchanged since `d859ff5ec`, the same on `main`) | identical |
| `bandSet_three_nonempty_of_proper`, docstring and signature | `Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean` l. 272–275 | identical |

No mismatch. One observation about the brief's frame, not a mismatch: the Poros statement it quotes has **no generation
hypothesis** on `S`, and row 79 has one ("`S = −S` finite generating"); the two are compared in § 1.3.

### 1.2 The result, in my words

For an abelian group `A` and a set `S ⊆ A ∖ {0}` of steps, the Cayley graph `Cay(A, S)` joins `a` and `a + s`. Row 79, at three
colours and for `A` finitely generated torsion-free with `S = −S` finite and generating, says four things.

1. **The criterion.** `Cay(A, S)` has a proper 3-colouring exactly when some character `θ : A → ℝ/ℤ` sends every step into the
   closed arc `[1/3, 2/3]`; and exactly when it has a 3-colouring that is constant on the cosets of some subgroup of finite index
   (a *periodic* colouring). The colouring a character gives is `x ↦ ⌊3·{θ(x)}⌋`, the circular colouring.
2. **Density.** For every proper 3-colouring `c` and every finite set `B`, some periodic proper 3-colouring agrees with `c` on `B`:
   the periodic colourings are dense in the space of colourings with the product topology (agreement on finite sets). With it, a
   difference `δ` identified by every periodic colouring is identified by every colouring: `P = F`, the inheritance question
   (C3-inherit) at three colours, and C3-aper (a colourable graph has a periodic colouring).
3. **The dichotomy.** The forced group `F` has finite index ⟺ there are finitely many colourings ⟺ every cell of `Θ₃` is a point;
   and when every point of `Θ₃` has order 3, every 3-colouring is affine.
4. **The instances**: `F = 3Λ` at `ℚ(√11)`'s `Λ₁₀`, the certificates, `χ(ℚ(√167)²) ≥ 4` and the four-colour no-gos — not this
   job's (the `ℚ(√167)` bound is row 119's kernel theorem).

**What the kernel holds of it** (all on the standard three axioms, `Arith/ThreeColourCharacter`, `ThreeColour`, `ThetaCert`,
`Kempe`):
- the criterion's ⟹ in character form, **for every abelian group and every set of steps**: `bandSet_three_nonempty_of_proper`
  (a colouring changing along every step of `U` gives `θ` with `θ(U) ⊆ [1/3, 2/3]`), through `nonempty_winding` (the integer
  height's winding on the relation lattice), `Winding.exists_box_point` (the winding is realised by a point of `[1/3, 2/3]^m`),
  `exists_character_of_box_point` and `bandSet_nonempty_of_finite` (compactness of the character group);
- the vocabulary of the inheritance question: `periods`, `IsPeriodic` (period group of finite index), `forcedSubgroup` (`F`),
  `periodicForcedSubgroup` (`P`), `InheritanceQuestion S k` (`P ≤ F` given a periodic colouring), and residual finiteness
  `exists_finiteIndex_between_notMem` (`Kempe`);
- the `Θ₃`-emptiness certificate checker (`ThetaCert`, row 119).

**What is left**: the criterion's ⟸ (the circular colouring), the periodic form, density, `P = F` at three colours, the
dichotomy and the rigidity clause.

### 1.3 Two readings made during the readback (findings, sent to the coordinator at once; § 2.6 has the argument)

- **The class is wider than row 79 says, in every clause this job plans.** (i) The criterion in character form needs only
  `0 ∉ S`: the ⟸ (circular colouring) holds for every abelian group and every set of steps, and the held ⟹ already does. (ii) The
  periodic form needs `A` finitely generated and `S` finite, and neither torsion-freeness, nor symmetry, nor generation; finite
  generation is necessary (`A = ℚ`, `S = {1}`: colourable, and no proper subgroup of finite index exists). (iii) The density route
  planned here (§ 2.4) uses no torsion-freeness and no symmetry: it needs `S` finite and generating, and by a coset reduction not
  even generation. Grade of (i), (ii): [hand, this planner; short]. Of (iii): a reading of the route, [hand, one mind], to be
  checked by the kernel when the module lands.
- **The derivation's `θ ∈ Hom(Λ, ℝ)` form (T22) needs torsion-freeness; the character form does not** (T42 records the reason:
  `ℤ/3` is 3-colourable with `Hom(ℤ/3, ℝ) = 0`). The kernel states the character form, which is row 79's own wording.
