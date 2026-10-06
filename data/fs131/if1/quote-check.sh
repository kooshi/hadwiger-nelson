chk() { if grep -qF -- "$1" "$2"; then echo "MATCH  $2 :: ${1:0:70}"; else echo "MISMATCH $2 :: ${1:0:70}"; fi; }
chk 'axiom falconer_lemma2_nonempty {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) :' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk '    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk 'noncomputable def densityRatio (A : Set ℂ) (x : ℂ) (r : ℝ) : ENNReal :=' Proofs/HadwigerNelson/Plane/UnitPairs.lean
chk 'def densitySet (A : Set ℂ) : Set ℂ := {x | Tendsto (densityRatio A x) (𝓝[>] 0) (𝓝 1)}' Proofs/HadwigerNelson/Plane/UnitPairs.lean
chk '- **`[Falconer1981]` Lemma 2 (i) — imported as an axiom** (`Plane.falconer_lemma2_nonempty`): `falconer_reduction` needs a point of `E`' plans/FS131-w2-kernel-plan.md
chk 'theorem exists_mem_falconerE {k : ℕ} {S : Fin k → Set ℂ} (hS : ∀ j, MeasurableSet (S j))' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk 'theorem fan_tip_ae_mem {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk 'theorem falconer_reduction {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk 'theorem le_chiM_of_falconerFan {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)' Proofs/HadwigerNelson/Plane/FalconerReduction.lean
chk '- **A milestone may assume the literature** (Kooshi, 2026-10-03). A published theorem whose formalization would take more than about' LEAN.md
chk '- **At publication** the cost of landing every assumption on the standard three axioms is measured first; Kooshi prefers the three' LEAN.md
chk "548. **Kooshi's word, 2026-10-06: Falconer's lemma is pulled into this milestone; and two questions of his, answered with a" plans/FS131-close-inventory.md
