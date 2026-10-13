# FS133-K1 — the kernel plan for the one-class transfer

*de Bruijn, the planner; job FS133-K1 (brief: `data/fs133/briefs/FS133-K1-kernel-plan.md`). The claim list is
`data/fs133/claims-K1.md`; the derivation is `plans/FS133-E1-derivation.md` (thirteen entries, one mind), read from the
start — this job is not blind. Working files: `data/fs133/k1/`. The outside release is `[OAIMath2026]` family 158 at
commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written), compiled at its
own pin by the audit (`~/.cache/ext-oai1/lean`, EXT-OAI1).*

## Theorems this phase proved

None: a planning job. The skeleton's statements are typed and compile with `sorry` at every leaf (stage 4).

## Stage 1 — SAVED: the readback

**1.1 The brief against the claim list, the claim list against the derivation.** `data/fs133/k1/readback.py` (the
E1 job's tool does not read a source address that carries a `§` section, and is another job's; this one does both
readbacks):

- `readback.py brief` — the nine quotations of the brief, each quoted line a substring of its source: **9 matched,
  0 mismatched**, exit 0 (`readback-brief.out`). With `--fault` (the last character of each quoted line changed):
  0 matched, 9 mismatched, exit 1 (`readback-brief-fault.out`).
- `readback.py claims` — each `K133-<ID>` line of `data/fs133/claims-K1.md` against the `statement:` field of the
  entry `C133-<ID>` at the line number the claim list gives, wrapped lines joined; each `K133-NC-<ID>` against that
  entry's `not claimed:` field: **12 matched, 0 mismatched**, exit 0 (`readback-claims.out`); `K133-NC-ALL` has no
  entry (a line of the claim list's own) and is reported as such. With `--fault`: 0 matched, 12 mismatched, exit 1.

No mismatch, so no finding about the brief's quotations or the claim list's copies.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; both claim lists; the derivation whole
(894 lines); the release's `Ergodicity.lean` ll. 325–415, `Representations.lean` (outline, and ll. 165–193),
`Basic.lean` ll. 1–60 and 222–228, `BorelTransfer.lean` (outline, and ll. 59–68); `plans/EXT-OAI1-audit.md` stage 8's
"Not imported, and why"; the heads of `tools/fs132_k1_port.py` and `tools/fs132_i1_readback.py`.

**1.3 Each statement, its symbols resolved** — in § Stage 3, beside the Lean statement it became.

## Stage 2 — SAVED: how the outside theorem enters

**2.1 The decision** (the coordinator's rulings: the brief's Amendments 1 and 2). The outside theorem enters as the
release's Lean lemma **`OAI.PlaneFiveColor.Spectral.residual_fourier`**
(`lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean` l. 403), declared as an `axiom` in a module of its own,
`Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean`, over copies of the release's definitions. It is the library's
fourth declared axiom and the release's third. It is **not** the manuscript's Theorem 2.3 (`wild_fourier`, l. 335): it
is that theorem composed, in the release's Lean, with the spectral theorem for a unitary representation of the
discrete algebraic plane — the derivation's steps F5–F6 in one line ("`b ⊥ 𝓗_c`, `V_u b = b`, so `⟨b, T_z b⟩ = 0`"),
and the one statement the release's own transfer consumes (`BorelTransfer.lean` l. 61).

**2.2 The statement as the release's kernel stores it** (`data/fs133/k1/readback/ReleaseDump.lean`, run at the
release's pin on the audit's compiled copy; binders read from the stored type, not from the file, where they stand on
a `variable` line, ll. 377–380, with `include hcov`):
`{H : Type u_1} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H] (U : DiscreteE →* unitary (H →L[ℂ] H))
(W : K → unitary (H →L[ℂ] H)) (hcov : ∀ k z w, (W k) (op U z w) = op U (kCoeff k * z) ((W k) w)) (v : H)
(hv : v ∈ (space U)ᗮ) (hfix : ∀ k, (W k) v = v) (z : E) (hz : z ≠ 0) : ⟪v, op U z v⟫_ℂ = 0`.
The declaration here writes every binder in the axiom's own signature. It names seven of the release's constants, all
copied: `E` (`Basic.lean` l. 9), `K` (ll. 11–15), `DiscreteE` (l. 44) with its derived `instCommGroupDiscreteE`,
`kCoeff` (l. 224), `ContinuousVectors.op` (`Representations.lean` l. 171), `ContinuousVectors.space` (ll. 182–192).
None pulls in anything further of the release (the dump's `USES` lines: Mathlib and core only, and each other). The
release's discrete topology on `DiscreteE` is not copied: the statement does not read it.

**2.3 Its axioms at the release's pin**, from the compiled constant (`ReleaseAxioms.lean`, `ReleaseAxioms.out`):
`'OAI.PlaneFiveColor.Spectral.residual_fourier' depends on axioms: [propext, Classical.choice, Quot.sound]`.

**2.4 The read-back across the two pins — six of eight term for term, two up to instance arguments.** One dumper
at both pins (`DumpBody.lean.inc`, FS132-I1's), compared by `readback_terms.py` (a wrapper over
`tools/fs132_i1_readback.py` with this job's table and both namespace pairs; `decls.out`):

| declaration | verdict |
|---|---|
| `Spectral.E`, `Spectral.K`, `Spectral.DiscreteE`, `Spectral.kCoeff`, `ContinuousVectors.op`, `ContinuousVectors.space` | **IDENTICAL**, kind, universes, type, value and constants named (the one rename applied to the release's print: `Set.ofPred` there is `setOf` here) |
| `Spectral.instCommGroupDiscreteE` (derived) | **UP TO INSTANCES**: the two toolchains' `deriving` handlers package the same structure differently (`Monoid.mk` over `One.mk` there, over `Semigroup.mk` here — Mathlib's `Monoid` has other parents at the two pins) |
| `Spectral.residual_fourier` (`theorem` there, `axiom` here) | **UP TO INSTANCES**: binders, kinds, names and every explicit and implicit argument agree; the stored types differ only inside instance arguments |

The second comparison (`readback_erased.py`, over FS132-I2's dumper `ErasedBody.lean.inc`, which writes every
instance argument and every proof argument `_`; `erased.out`) reads all eight alike, and lists the constants named
at one pin only. For the axiom: there `CStarModule.toInner`, `WithCStarModule.instCStarModuleComplex`,
`instCommCStarAlgebraComplex`, `CommSemiring.toSemiring`, `SubsemiringClass.toCommSemiring` and nineteen more of
Mathlib's instance projections; here `InnerProductSpace.toInner`, `DivisionSemiring.toSemiring`,
`Semifield.toDivisionSemiring`, `NormedField.toNormedCommRing`. **So the axiom is not the release's stored statement
term for term, and cannot be at these two pins**: Mathlib's `InnerProductSpace` reaches its inner product through
another class at v4.34.1 than at v4.32.0. What this leaves to trust, as for the ported modules (`LEAN.md`
§ Assumptions): that Mathlib's instances for one class on one type agree at each pin — here the inner product of
`H`, the ring structure of the algebraic plane and of `ℂ`. The library's other two declared theorems of the release
are term for term; this one is at the weaker grade, and its docstring and `ARCHITECTURE.md` line must say so.

*Controls.* `readback_terms.py --control` plants four faults in this pin's print (the axiom's first explicit binder
made implicit; its first instance binder made explicit; a constant changed in the definition `K`; a declaration
missing): each refused (`decls-control.out`). `readback_erased.py --control` plants a binder kind and a constant
(`kCoeff` for `K`) in the axiom's erased type: each refused (`erased-control.out`). The prints are kept compressed
(`*.out.xz`; `xz -dk` before a re-run). The landing runs both again on the module as recompiled on the joined tree.

**2.5 The four items of `LEAN.md` § Assumptions.** (1) The docstring names `[OAIMath2026]`, the file and line at the
pin, and says what the lemma is and is not. (2) This stage. (3) The model: `Spectral.residual_fourier_model`, in the
same file — the regular representation on `ℓ²` of the algebraic plane, the point mass at the origin, `v ≠ 0`, with
the conclusion proved there by computation; a leaf (plan: § Stage 5, leaf M). (4) The `ARCHITECTURE.md` § Trust line
is drafted in § Drafts; `scripts/Axioms.lean` needs one `AxiomAudit.declareImport` line at the landing.

**2.6 Against a port** (measured from the release's compiled constants, `ReleaseDump.lean`'s second block and
`ReleaseAxioms.lean`; `cones.txt`):

| statement | the release's declarations it rests on | modules | |
|---|---|---|---|
| the headline (`no_proper_five_coloring`) | 3,520 | 70 | the audit's row: "every module of the cone is used" |
| `proper_to_borel_weak` (the transfer) | 1,997 | 32 | the audit's row: "six to eight jobs; about 16,600 lines" |
| **`residual_fourier`** | **1,802** | **30** | this job; wholly inside the transfer's cone (0 of its declarations outside) |
| `wild_fourier` | 1,644 | 29 | the audit's row; wholly inside `residual_fourier`'s |

So one port of the transfer's cone would discharge **two** of the release's three declared theorems here — the
transfer and this lemma — under their present names; the five-colour obstruction needs the rest of the release. (My
message to the coordinator said "all three"; that was wrong, and Amendment 2 corrects it.) A port is declined for
this job and is a decision for the publication pass.

**2.7 What is ported instead: the generic lemmas of the transfer's proof** (kernel-checked here, no axiom) — the
plan is § Stage 5, leaf P. Their cones, from the same run: `exists_measurable_field` 14 declarations (one module),
`orbitExtension_inner` 41 (three), `projection_range` 21, `projection_covariance_fixed` 14,
`projection_coefficient` 18, `positive_orthogonal` 1, `circle_closed_induction` 13, `Koopman.nonlinear_commute` 1 —
all in `Representations.lean`, `BorelTransfer.lean` and `Basic.lean`, none in the label model.
