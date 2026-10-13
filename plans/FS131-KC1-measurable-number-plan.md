# FS131-KC1 — the plane's chromatic number equals its Lebesgue-measurable chromatic number: the kernel plan

*Job record of FS131-KC1 (brief: `data/fs131/briefs/FS131-KC1-measurable-number-plan.md`; de Bruijn, the planner; branch
`fs131-wkc`). Claim list: `data/fs131/claims-NF3.md`. The mathematics is other people's: a printed lemma
(`[Davies2026]` Lemma B.1, p. 44, with its proof), a density-point step this library already holds, and a declared outside
theorem (`Outside.OAI158.proper_to_borel_weak`, `[OAIMath2026]`); what is done here is typing, composing and planning.
Working files: `data/fs131/kc1/`.*

## Theorems this phase proved

Filled at the last stage (below, "Theorems this phase proved — the list").

## Stage 1 — SAVED: readback

**The brief's quotations, by script** (`data/fs131/kc1/readback_check.py`: each block quote of the brief must occur
character for character in the file its source line names). Nine of nine MATCH; with `--fault` (one character of each
altered) nine of nine read MISMATCH, so the check can fire. The brief's § Done means says "the eight quoted lines": there
are nine block quotes (two of Kooshi's words, four claims, three library lines) — a count, not a mismatch.

**One quotation is cut where the defect is.** The brief quotes `Plane.chiM` as `noncomputable def chiM : ℕ∞ :=` and stops
at `:=`; the body, on the next line of `Proofs/HadwigerNelson/Plane/FalconerReduction.lean` (27–28), is

```lean
noncomputable def chiM : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ f : ℂ → Fin k, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), (k : ℕ∞)
```

**The lemma, read on the page** (`[Davies2026]`, the rendered p. 44, which is the PDF's page 44). The statement, the
standing hypotheses and the sentence before the lemma are as NF3-PRINTED has them, word for word. The proof, in its six
steps: (1) make the sets disjoint, `A_i ∖ ⋃_{j<i} A_j`; (2) keep of each `A_i` only its density-one points — a null change
by the Lebesgue density theorem — so the sets still avoid `D`, their union `A` is conull, every point of `A_i` is a
density-one point of `A_i`, and `c : A → [k]` gives `A_i` colour `i`; (3) for a finite `F ⊆ ℝ^d` the set
`⋂_{x∈F∩A} (A_{c(x)} − x) ∩ ⋂_{x∈F∖A} (A − x)` "has positive measure near 0: the first part has density one there and the
second is conull"; (4) "A translation ξ in this intersection gives a proper colouring x ↦ c(x + ξ) of F agreeing with c on
F ∩ A"; (5) "The compactness principle for graph colourings [20] then gives a proper colouring of ℝ^d extending c"; (6)
"Each colour class differs from A_i only within the null set ℝ^d ∖ A, so the colouring is Lebesgue measurable." The
paper's measurable chromatic number, p. 2: "Requiring the colour classes to be Lebesgue measurable gives the measurable
chromatic number χ^(m)(ℝ^d)" — classes **Lebesgue** measurable, proper at **every** pair.

**The two definitions, read from the Lean source.**

| | σ-algebra | where proper | classes or a map | is it the paper's? |
|---|---|---|---|---|
| `Plane.chiM0` (`Plane/AeColouring.lean:32`), over `Plane.AeColouring k` (lines 23–29) | **Borel**: the field `measurable : Measurable col`, and `ℂ`'s σ-algebra is `Complex.measurableSpace := borel ℂ` (the docstrings say "Lebesgue-measurable") | **almost every** unit pair: `∀ j, UnitPairsNull (col ⁻¹' {j})`, i.e. `(volume.prod arcLength) {(x, θ) | x ∈ A ∧ x + e θ ∈ A} = 0` for each fibre `A` | a map `col : ℂ → Fin k`; the classes are its fibres | the paper has no almost-everywhere number. As a number it is the Lebesgue almost-everywhere one: a null change makes a Lebesgue weak colouring Borel (`UnitPairsNull.congr_ae`, `Plane/Cover.lean:259`) |
| `Plane.chiM` (`Plane/FalconerReduction.lean:27–28`) | **Borel**: `Measurable f` | **every** unit pair: `∀ x y, dist x y = 1 → f x ≠ f y` | a map `f : ℂ → Fin k` | **no.** It is row 130's `χ_B`, not `χ_m`; its docstring calls it "`χ_m(ℝ²)` (Falconer's, everywhere-proper)" |

**The statement defect** (sent to "main" at once; accepted, with a dated line in `data/fs131/claims-NF3.md`). The claim
list names `Plane.chiM` as the library's object for Falconer's number, and it is the Borel number. Lemma B.1's colouring
is Lebesgue measurable and no more (step 6: the null set is coloured by a compactness argument), so `chiM0 = Plane.chiM`
and `χ(ℝ²) = Plane.chiM` are not what the lemma gives, and NF3-NC excludes Borel statements. **Resolution:** a new
definition for the Lebesgue number, both headlines over it, the inequality to `Plane.chiM` beside them, `Plane.chiM`
untouched. Whether `Plane.chiM` equals the Lebesgue number is not claimed and not attempted: it asks a Borel colouring of
the null set under lists, which compactness does not give.

**The reader's record** (`plans/FS131-ER1-davies-reading.md` on `main`, untracked there; read at its § 2.1, § 2.7, § M):
its M.0 table already separates `χ_m` (Lebesgue) from `χ_B` (Borel) and its ER1-WEAK-TO-PROPER hand-off says "the equality
with Falconer's number, which the library does not yet define" — so the reader had it right and the slip was in the claim
list's header. Its M.3 names the reach of the lemma's argument (translation invariance, the density theorem, compactness;
no use of the distance set, of `d ⩾ 2`, or of the norm); the plan below types that reach as the core statement.
