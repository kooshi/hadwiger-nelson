import Proofs.HadwigerNelson.Plane.SixRing.ChartMeasure
import Proofs.HadwigerNelson.Plane.SixRing.StepLemma

/-!
# No label tips two adjacent hubs: the analytic core (FS-132, C132-M-ORBIT steps M8, M9)

`chart_step_false` is the derivation's V6-HUG restated ("no label is the tip at two adjacent hubs"), with no
palette in its statement: a weak colouring `c` of **the whole plane** (any number of labels), a measurable set `S`
of angles that changes at `t`, and the two statements `HubColours` at the hub charted about `t` and — with the
state flipped — at the next hub, charted about `t + π/3`. These cannot all hold.

It is proved here from `exists_shiftBounds` (M7), `no_double_change` (M8: the derivation's (†)), `step_lemma`
(Lemma S), `step_at_of_change`, and `step_kill` (M9). `plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

**Both leaves are proved from the statements they cite** (job FS132-I4); this module has no `sorry` of its own.
`no_double_change` and `step_kill` read the two hub statements at the triples `(α, d, d')` — the first hub along the
projection to `(α, d)`, the second along the shear to `(α + ε + d', d')` (`HubColours.shift_back`,
`HubColours.ae_partner`) — and separate the two chart points by `unitPair_chart_ae`. `step_kill` is
`step_kill_left` (the step falls) and the same after exchanging the two outside labels and passing to the complement
(`HubColours.swap`). Neither uses measurability of `S`; `no_double_change` does not use `0 < κ'`.
-/

open MeasureTheory Set

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

variable {k : ℕ} {c : ℂ → Fin k}

/-- `HubColours` with the two outside labels exchanged is `HubColours` for the complement of the set. -/
theorem HubColours.swap {p : ℂ} {b X Y : Fin k} {S : Set ℝ} {t κ : ℝ} (h : HubColours c p b X Y S t κ) :
    HubColours c p b Y X Sᶜ t κ := by
  filter_upwards [h] with x hx h1 h2 h3
  obtain ⟨hcol, hnX, hnY⟩ := hx h1 h2 h3
  exact ⟨hcol.imp_right Or.symm, fun hS => hnY hS, fun hS => hnX (hS.imp not_not.mp not_not.mp)⟩

/-- **The second hub's statement in the coordinates `(β, d')`, `β` the chart angle less `π/3`**: `HubColours` about
`t + π/3` for the flipped set says, for almost every `(β, d')` with `|β − t| < κ` and `0 < d' < κ`, that the colour
at `Z(β + π/3, d')` is `b`, `X` or `Y`, not `X` when `β` or `β − d'` is outside `S`, and not `Y` when one of them is
in `S` (the derivation's "the second line shifts both arguments by `−π/3`, which flips both values", undone). -/
theorem HubColours.shift_back {p : ℂ} {b X Y : Fin k} {S : Set ℝ} {t κ : ℝ}
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) :
    ∀ᵐ x : ℝ × ℝ, |x.1 - t| < κ → 0 < x.2 → x.2 < κ →
      (c (chart p (x.1 + π / 3) x.2) = b ∨ c (chart p (x.1 + π / 3) x.2) = X ∨
        c (chart p (x.1 + π / 3) x.2) = Y) ∧
      (x.1 ∉ S ∨ x.1 - x.2 ∉ S → c (chart p (x.1 + π / 3) x.2) ≠ X) ∧
      (x.1 ∈ S ∨ x.1 - x.2 ∈ S → c (chart p (x.1 + π / 3) x.2) ≠ Y) := by
  have hmp : MeasurePreserving (fun x : ℝ × ℝ => (x.1 + π / 3, x.2))
      ((volume : Measure ℝ).prod (volume : Measure ℝ)) ((volume : Measure ℝ).prod volume) :=
    (measurePreserving_add_right volume (π / 3)).prod (MeasurePreserving.id volume)
  filter_upwards [hmp.quasiMeasurePreserving.ae h1] with x hx hx1 hx2 hx3
  have e1 : x.1 + π / 3 - (t + π / 3) = x.1 - t := by ring
  have e2 : x.1 + π / 3 - x.2 - π / 3 = x.1 - x.2 := by ring
  simp only [e1, e2, add_sub_cancel_right] at hx
  obtain ⟨hcol, hnX, hnY⟩ := hx hx1 hx2 hx3
  exact ⟨hcol, hnX, fun hS => hnY (hS.imp (fun a b => b a) (fun a b => b a))⟩

/-- **The second hub's statement at the triples**: the same for the partner point of `Z(α, d)`, at
`β = α + ε(d, d') + d'`. -/
theorem HubColours.ae_partner {p : ℂ} {b X Y : Fin k} {S : Set ℝ} {t κ : ℝ}
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) :
    ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 + shift y.2.1 y.2.2 + y.2.2 - t| < κ → 0 < y.2.2 → y.2.2 < κ →
      (c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) = b ∨
        c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) = X ∨
        c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) = Y) ∧
      (y.1 + shift y.2.1 y.2.2 + y.2.2 ∉ S ∨ y.1 + shift y.2.1 y.2.2 ∉ S →
        c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) ≠ X) ∧
      (y.1 + shift y.2.1 y.2.2 + y.2.2 ∈ S ∨ y.1 + shift y.2.1 y.2.2 ∈ S →
        c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) ≠ Y) := by
  have hq := shear_quasiMeasurePreserving (f := fun w : ℝ × ℝ => shift w.1 w.2 + w.2)
    (measurable_shift.add measurable_snd)
  filter_upwards [hq.ae h1.shift_back] with y hy
  simp only [← add_assoc, add_sub_cancel_right] at hy
  exact hy

/-- **M8, (†)** ("Almost every point of `W_0(κ_1)` and of `W_1(κ_1)` carries `a`. Properness and `Φ` give: for
almost every `(α, d, d′)` … not both `s(α − d) ≠ s(α)` and `s(α + ε) ≠ s(α + ε + d′)`"): on the box of size `κ'`
with `3κ' ≤ κ`, `κ' ≤ 1/4`. Where a pair is split by `S`, `HubColours` leaves the one label `b`; the two chart
points are a unit pair, and `unitPair_chart_ae` separates almost every one. (The planner's hypothesis `0 < κ'` is not
used and is dropped: for `κ' ≤ 0` the box is empty.) -/
theorem no_double_change (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    {t κ κ' : ℝ} (h3 : 3 * κ' ≤ κ) (h4 : κ' ≤ 1 / 4) (hb : ShiftBounds shift κ')
    (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) : NoDoubleChange shift S t κ' := by
  filter_upwards [quasiMeasurePreserving_triple_fst.ae h0, h1.ae_partner, unitPair_chart_ae hc hw p]
    with y hA hB hU hy1 hy2 hy3 hy4 hy5 hsplit
  obtain ⟨hs1, hs2⟩ := hsplit
  have hpos := hb.pos y.2.1 y.2.2 hy2 hy3 hy4 hy5
  have hle := hb.le_right y.2.1 y.2.2 hy2 hy3 hy4 hy5
  rw [abs_lt] at hy1
  obtain ⟨hcol0, hnX0, hnY0⟩ := hA (by rw [abs_lt]; constructor <;> linarith) hy2 (by linarith)
  obtain ⟨hcol1, hnX1, hnY1⟩ := hB (by rw [abs_lt]; constructor <;> linarith) hy4 (by linarith)
  -- where both pairs are split, both points carry the one label `b`
  have hz : c (chart p y.1 y.2.1) = b := by
    have h5 : (y.1 ∈ S ∨ y.1 - y.2.1 ∈ S) ∧ (y.1 ∉ S ∨ y.1 - y.2.1 ∉ S) := by
      by_cases hα : y.1 ∈ S
      · exact ⟨Or.inl hα, Or.inr fun h => hs1.mp h hα⟩
      · exact ⟨Or.inr (hs1.mpr hα), Or.inl hα⟩
    rcases hcol0 with h | h | h
    · exact h
    · exact absurd h (hnX0 h5.1)
    · exact absurd h (hnY0 h5.2)
  have hz' : c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) = b := by
    have h5 : (y.1 + shift y.2.1 y.2.2 + y.2.2 ∉ S ∨ y.1 + shift y.2.1 y.2.2 ∉ S) ∧
        (y.1 + shift y.2.1 y.2.2 + y.2.2 ∈ S ∨ y.1 + shift y.2.1 y.2.2 ∈ S) := by
      by_cases hβ : y.1 + shift y.2.1 y.2.2 + y.2.2 ∈ S
      · exact ⟨Or.inr fun h => hs2.mp h hβ, Or.inl hβ⟩
      · exact ⟨Or.inl hβ, Or.inr (hs2.mpr hβ)⟩
    rcases hcol1 with h | h | h
    · exact h
    · exact absurd h (hnX1 h5.1)
    · exact absurd h (hnY1 h5.2)
  exact hU hy2 (by linarith) hy4 (by linarith) (hz.trans hz'.symm)

/-- **M9, the kill, for a step that falls** (steps (a)–(d) with `V = X`, `V′ = Y`, `κ_3 = κ'/128`): if almost every
`θ` within `κ'/4` of `t` lies in `S` exactly when `θ < t`, the hypotheses are contradictory.

(a) the label `b` is null on `V_0 = {Z(α, d) : t − κ_3 < α < t, 0 < d < κ_3}`: for `d'` between `h = t − α` and `16h`
the partner point lies where the second pair is split, so it carries `b`, and a unit pair is not monochromatic;
(b) so `V_0` carries `Y`; (c) the label `b` is null on `V_1 = {Z(β + π/3, d') : t < β − d', β < t + κ_3,
0 < d' < κ_3}`: for `d` between `h' = β − d' − t` and `16h'` the partner point, at `α = β − d' − ε`, lies where the
first pair is split; so `V_1` carries `Y`; (d) the triples with `0 < d, d' < κ_3/2` and `t − ε < α < t` have positive
measure (`ε > 0`), their two points lie in `V_0` and `V_1` and are a unit pair. -/
theorem step_kill_left (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    {t κ κ' : ℝ} (hκ' : 0 < κ') (h3 : 3 * κ' ≤ κ) (h4 : κ' ≤ 1 / 4)
    (hb : ShiftBounds shift κ') (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ)
    (hstep : ∀ᵐ θ : ℝ, |θ - t| < κ' / 4 → (θ ∈ S ↔ θ < t)) : False := by
  have hsh : Measurable fun w : ℝ × ℝ => shift w.1 w.2 := measurable_shift
  have hchart : Measurable fun x : ℝ × ℝ => chart p x.1 x.2 := (continuous_chart p).measurable
  -- the statements at the triples `(α, d, d')`
  have hU := unitPair_chart_ae hc hw p
  have hH0 := quasiMeasurePreserving_triple_fst.ae h0
  have hH1 := h1.ae_partner
  have hsα : ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 - t| < κ' / 4 → (y.1 ∈ S ↔ y.1 < t) :=
    (Measure.quasiMeasurePreserving_fst (μ := (volume : Measure ℝ)) (ν := (volume : Measure (ℝ × ℝ)))).ae hstep
  have hsαd : ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 - y.2.1 - t| < κ' / 4 → (y.1 - y.2.1 ∈ S ↔ y.1 - y.2.1 < t) := by
    filter_upwards [(quasiMeasurePreserving_triple_add (f := fun w : ℝ × ℝ => -w.1) measurable_fst.neg).ae hstep]
      with y hy
    simpa only [← sub_eq_add_neg] using hy
  have hsε : ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 + shift y.2.1 y.2.2 - t| < κ' / 4 →
      (y.1 + shift y.2.1 y.2.2 ∈ S ↔ y.1 + shift y.2.1 y.2.2 < t) :=
    (quasiMeasurePreserving_triple_add hsh).ae hstep
  have hsεd : ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 + shift y.2.1 y.2.2 + y.2.2 - t| < κ' / 4 →
      (y.1 + shift y.2.1 y.2.2 + y.2.2 ∈ S ↔ y.1 + shift y.2.1 y.2.2 + y.2.2 < t) := by
    filter_upwards [(quasiMeasurePreserving_triple_add (f := fun w : ℝ × ℝ => shift w.1 w.2 + w.2)
      (hsh.add measurable_snd)).ae hstep] with y hy
    have e : y.1 + (shift y.2.1 y.2.2 + y.2.2) = y.1 + shift y.2.1 y.2.2 + y.2.2 := (add_assoc _ _ _).symm
    rw [e] at hy
    exact hy
  have hs2 : ∀ᵐ x : ℝ × ℝ, |x.1 - t| < κ' / 4 → (x.1 ∈ S ↔ x.1 < t) :=
    (Measure.quasiMeasurePreserving_fst (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℝ))).ae hstep
  -- (a) the label `b` is null on `V_0`
  have hA3 : ∀ᵐ y : ℝ × ℝ × ℝ, t - κ' / 128 < y.1 → y.1 < t → 0 < y.2.1 → y.2.1 < κ' / 128 →
      t - y.1 < y.2.2 → y.2.2 < 16 * (t - y.1) → c (chart p y.1 y.2.1) ≠ b := by
    filter_upwards [hU, hH1, hsε, hsεd] with y hU hH1 hsε hsεd ha1 ha2 hd1 hd2 hd'1 hd'2
    have hdκ : y.2.1 < κ' := by linarith
    have hd'pos : 0 < y.2.2 := by linarith
    have hd'κ : y.2.2 < κ' := by linarith
    have hpos := hb.pos _ _ hd1 hdκ hd'pos hd'κ
    have hle := hb.le_right _ _ hd1 hdκ hd'pos hd'κ
    have h1S : y.1 + shift y.2.1 y.2.2 ∈ S :=
      (hsε (by rw [abs_lt]; constructor <;> linarith)).mpr (by linarith)
    have h2S : y.1 + shift y.2.1 y.2.2 + y.2.2 ∉ S := fun h => by
      have h5 := (hsεd (by rw [abs_lt]; constructor <;> linarith)).mp h
      linarith
    obtain ⟨hcol, hnX, hnY⟩ := hH1 (by rw [abs_lt]; constructor <;> linarith) hd'pos (by linarith)
    have hcb : c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) = b := by
      rcases hcol with h | h | h
      · exact h
      · exact absurd h (hnX (Or.inl h2S))
      · exact absurd h (hnY (Or.inr h1S))
    intro hzb
    exact hU hd1 (by linarith) hd'pos (by linarith) (hzb.trans hcb.symm)
  have hA : ∀ᵐ x : ℝ × ℝ, t - κ' / 128 < x.1 → x.1 < t → 0 < x.2 → x.2 < κ' / 128 →
      c (chart p x.1 x.2) ≠ b := by
    have hmeas : MeasurableSet {x : ℝ × ℝ | t - κ' / 128 < x.1 → x.1 < t → 0 < x.2 → x.2 < κ' / 128 →
        c (chart p x.1 x.2) ≠ b} :=
      (measurableSet_lt measurable_const measurable_fst).imp ((measurableSet_lt measurable_fst measurable_const).imp
        ((measurableSet_lt measurable_const measurable_snd).imp ((measurableSet_lt measurable_snd measurable_const).imp
          (measurableSet_eq_fun (hc.comp hchart) measurable_const).compl)))
    rw [Measure.volume_eq_prod, Measure.ae_prod_iff_ae_ae hmeas]
    filter_upwards [Measure.ae_ae_of_ae_prod hA3] with α hα
    filter_upwards [Measure.ae_ae_of_ae_prod hα] with d hd ha1 ha2 hd1 hd2
    obtain ⟨d', hd'mem, hd'P⟩ := exists_mem_Ioo_of_ae (a := t - α) (b := 16 * (t - α)) (by linarith) hd
    exact hd'P ha1 ha2 hd1 hd2 hd'mem.1 hd'mem.2
  -- (b) so `V_0` carries `Y`
  have hV0 : ∀ᵐ x : ℝ × ℝ, t - κ' / 128 < x.1 → x.1 < t → 0 < x.2 → x.2 < κ' / 128 →
      c (chart p x.1 x.2) = Y := by
    filter_upwards [hA, h0, hs2] with x hxA hx0 hxs ha1 ha2 hd1 hd2
    obtain ⟨hcol, hnX, -⟩ := hx0 (by rw [abs_lt]; constructor <;> linarith) hd1 (by linarith)
    have hαS : x.1 ∈ S := (hxs (by rw [abs_lt]; constructor <;> linarith)).mpr ha2
    rcases hcol with h | h | h
    · exact absurd h (hxA ha1 ha2 hd1 hd2)
    · exact absurd h (hnX (Or.inl hαS))
    · exact h
  -- (c) the label `b` is null on `V_1`: first at the triples
  have hC3 : ∀ᵐ y : ℝ × ℝ × ℝ, 0 < y.2.2 → y.2.2 < κ' / 128 → t < y.1 + shift y.2.1 y.2.2 →
      y.1 + shift y.2.1 y.2.2 + y.2.2 < t + κ' / 128 → y.1 + shift y.2.1 y.2.2 - t < y.2.1 →
      y.2.1 < 16 * (y.1 + shift y.2.1 y.2.2 - t) →
      c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) ≠ b := by
    filter_upwards [hU, hH0, hsα, hsαd] with y hU hH0 hsα hsαd hd'1 hd'2 hβ1 hβ2 hd1 hd2
    have hdpos : 0 < y.2.1 := by linarith
    have hdκ : y.2.1 < κ' := by linarith
    have hd'κ : y.2.2 < κ' := by linarith
    have hpos := hb.pos _ _ hdpos hdκ hd'1 hd'κ
    have hle := hb.le_left _ _ hdpos hdκ hd'1 hd'κ
    have hαS : y.1 ∉ S := fun h => by
      have h5 := (hsα (by rw [abs_lt]; constructor <;> linarith)).mp h
      linarith
    have hαdS : y.1 - y.2.1 ∈ S := (hsαd (by rw [abs_lt]; constructor <;> linarith)).mpr (by linarith)
    obtain ⟨hcol, hnX, hnY⟩ := hH0 (by rw [abs_lt]; constructor <;> linarith) hdpos (by linarith)
    have hcb : c (chart p y.1 y.2.1) = b := by
      rcases hcol with h | h | h
      · exact h
      · exact absurd h (hnX (Or.inr hαdS))
      · exact absurd h (hnY (Or.inl hαS))
    intro hzb
    exact hU hdpos (by linarith) hd'1 (by linarith) (hcb.trans hzb.symm)
  -- then in the coordinates `(β, d', d)`, `β = α + ε + d'`: a shear and an exchange of the last two coordinates
  have hτ : MeasurePreserving
      (fun z : ℝ × ℝ × ℝ => (z.1 + -(shift z.2.2 z.2.1 + z.2.1), (z.2.2, z.2.1))) volume volume :=
    (shear_measurePreserving (f := fun w : ℝ × ℝ => -(shift w.1 w.2 + w.2)) (hsh.add measurable_snd).neg).comp
      ((MeasurePreserving.id volume).prod Measure.measurePreserving_swap)
  have hC3' : ∀ᵐ z : ℝ × ℝ × ℝ, 0 < z.2.1 → z.2.1 < κ' / 128 → t < z.1 - z.2.1 → z.1 < t + κ' / 128 →
      z.1 - z.2.1 - t < z.2.2 → z.2.2 < 16 * (z.1 - z.2.1 - t) → c (chart p (z.1 + π / 3) z.2.1) ≠ b := by
    filter_upwards [hτ.quasiMeasurePreserving.ae hC3] with z hz
    have e1 : z.1 + -(shift z.2.2 z.2.1 + z.2.1) + shift z.2.2 z.2.1 = z.1 - z.2.1 := by ring
    simp only [e1, sub_add_cancel] at hz
    exact hz
  have hC : ∀ᵐ x : ℝ × ℝ, t < x.1 - x.2 → x.1 < t + κ' / 128 → 0 < x.2 → x.2 < κ' / 128 →
      c (chart p (x.1 + π / 3) x.2) ≠ b := by
    have hchart' : Measurable fun x : ℝ × ℝ => chart p (x.1 + π / 3) x.2 :=
      hchart.comp ((measurable_fst.add_const _).prodMk measurable_snd)
    have hmeas : MeasurableSet {x : ℝ × ℝ | t < x.1 - x.2 → x.1 < t + κ' / 128 → 0 < x.2 → x.2 < κ' / 128 →
        c (chart p (x.1 + π / 3) x.2) ≠ b} :=
      (measurableSet_lt measurable_const (measurable_fst.sub measurable_snd)).imp
        ((measurableSet_lt measurable_fst measurable_const).imp
          ((measurableSet_lt measurable_const measurable_snd).imp
            ((measurableSet_lt measurable_snd measurable_const).imp
              (measurableSet_eq_fun (hc.comp hchart') measurable_const).compl)))
    rw [Measure.volume_eq_prod, Measure.ae_prod_iff_ae_ae hmeas]
    filter_upwards [Measure.ae_ae_of_ae_prod hC3'] with β hβ
    filter_upwards [Measure.ae_ae_of_ae_prod hβ] with d' hd' hb1 hb2 hd'1 hd'2
    obtain ⟨d, hdmem, hdP⟩ := exists_mem_Ioo_of_ae (a := β - d' - t) (b := 16 * (β - d' - t)) (by linarith) hd'
    exact hdP hd'1 hd'2 hb1 hb2 hdmem.1 hdmem.2
  have hV1 : ∀ᵐ x : ℝ × ℝ, t < x.1 - x.2 → x.1 < t + κ' / 128 → 0 < x.2 → x.2 < κ' / 128 →
      c (chart p (x.1 + π / 3) x.2) = Y := by
    filter_upwards [hC, h1.shift_back, hs2] with x hxC hx1 hxs hb1 hb2 hd'1 hd'2
    obtain ⟨hcol, hnX, -⟩ := hx1 (by rw [abs_lt]; constructor <;> linarith) hd'1 (by linarith)
    have hβS : x.1 ∉ S := fun h => by
      have h5 := (hxs (by rw [abs_lt]; constructor <;> linarith)).mp h
      linarith
    rcases hcol with h | h | h
    · exact absurd h (hxC hb1 hb2 hd'1 hd'2)
    · exact absurd h (hnX (Or.inl hβS))
    · exact h
  -- (d) the triples with `t − ε < α < t`: their two points lie in `V_0` and `V_1`, and are a unit pair
  have hD : ∀ᵐ y : ℝ × ℝ × ℝ, 0 < y.2.1 → y.2.1 < κ' / 256 → 0 < y.2.2 → y.2.2 < κ' / 256 →
      t - shift y.2.1 y.2.2 < y.1 → y.1 < t → False := by
    have hV1' := (shear_quasiMeasurePreserving (f := fun w : ℝ × ℝ => shift w.1 w.2 + w.2)
      (hsh.add measurable_snd)).ae hV1
    filter_upwards [hU, quasiMeasurePreserving_triple_fst.ae hV0, hV1'] with y hU hV0 hV1 hd1 hd2 hd'1 hd'2 hα1 hα2
    have hdκ : y.2.1 < κ' := by linarith
    have hd'κ : y.2.2 < κ' := by linarith
    have hle := hb.le_left _ _ hd1 hdκ hd'1 hd'κ
    have hz : c (chart p y.1 y.2.1) = Y := hV0 (by linarith) hα2 hd1 (by linarith)
    have hz' : c (chart p (y.1 + (shift y.2.1 y.2.2 + y.2.2) + π / 3) y.2.2) = Y :=
      hV1 (by linarith) (by linarith) hd'1 (by linarith)
    have e : y.1 + (shift y.2.1 y.2.2 + y.2.2) + π / 3 = y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3 := by ring
    rw [e] at hz'
    exact hU hd1 (by linarith) hd'1 (by linarith) (hz.trans hz'.symm)
  -- and they have positive measure: for each `(d, d')` the interval `(t − ε, t)` has length `ε > 0`
  have hD' : ∀ᵐ w : ℝ × ℝ, ∀ᵐ α : ℝ, 0 < w.1 → w.1 < κ' / 256 → 0 < w.2 → w.2 < κ' / 256 →
      t - shift w.1 w.2 < α → α < t → False :=
    Measure.ae_ae_of_ae_prod ((Measure.measurePreserving_swap (μ := (volume : Measure (ℝ × ℝ)))
      (ν := (volume : Measure ℝ))).quasiMeasurePreserving.ae hD)
  obtain ⟨d, hdmem, hd⟩ := exists_mem_Ioo_of_ae (a := 0) (b := κ' / 256) (by positivity)
    (Measure.ae_ae_of_ae_prod hD')
  obtain ⟨d', hd'mem, hd'⟩ := exists_mem_Ioo_of_ae (a := 0) (b := κ' / 256) (by positivity) hd
  have hpos := hb.pos d d' hdmem.1 (by linarith [hdmem.2]) hd'mem.1 (by linarith [hd'mem.2])
  obtain ⟨α, hαmem, hα⟩ := exists_mem_Ioo_of_ae (a := t - shift d d') (b := t) (by linarith) hd'
  exact hα hdmem.1 hdmem.2 hd'mem.1 hd'mem.2 hαmem.1 hαmem.2

/-- **M9, the kill** (steps (a)–(d)): if `S` is a half-line with end `t` on the interval of radius `κ'/4` about `t`
— a clean step of the state at `t` — then the two regions flanking the hubs just inside the ring carry one outside
label almost everywhere, and they hold a set of unit pairs of positive measure. A step inside a proof by
contradiction: the hypotheses are jointly unsatisfiable, and this theorem is what says so. (The planner's hypothesis
`MeasurableSet S` is not used and is dropped.) -/
theorem step_kill (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    {t κ κ' : ℝ} (hκ' : 0 < κ') (h3 : 3 * κ' ≤ κ) (h4 : κ' ≤ 1 / 4)
    (hb : ShiftBounds shift κ') (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ)
    (hstep : (∀ᵐ θ : ℝ, |θ - t| < κ' / 4 → (θ ∈ S ↔ θ < t)) ∨
      (∀ᵐ θ : ℝ, |θ - t| < κ' / 4 → (θ ∈ S ↔ t < θ))) : False := by
  rcases hstep with hstep | hstep
  · exact step_kill_left hc hw p hκ' h3 h4 hb h0 h1 hstep
  · -- a step that rises is a step of the complement that falls, with the two outside labels exchanged
    refine step_kill_left hc hw p hκ' h3 h4 hb h0.swap h1.swap ?_
    filter_upwards [hstep, compl_mem_ae_iff.mpr (measure_singleton t)] with θ hθ hne hlt
    have hne' : θ ≠ t := hne
    refine ⟨fun hS => lt_of_le_of_ne (not_lt.mp fun h => hS ((hθ hlt).mpr h)) hne', fun h hS => ?_⟩
    exact lt_asymm h ((hθ hlt).mp hS)

/-- **No label tips two adjacent hubs, in the chart** (the derivation's V6-HUG restated; steps M7–M9 together): for
a weak colouring of the plane with any number of labels, a measurable set `S` of angles every neighbourhood of `t`
meets, with its complement, in positive measure, and labels `b`, `X`, `Y`, the statements `HubColours` at `t` for
`S` and at `t + π/3` for the flipped set cannot both hold.

A refutation. Its hypotheses other than weakness are met by no colouring this library holds; whether a weak
colouring exists at six labels is the open question, and at `k = 7` (`proper_to_borel_weak_model`) the statement
says that the hexagonal colouring has no such pair of hubs. -/
theorem chart_step_false (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
    (hS : MeasurableSet S) {t κ : ℝ} (hκ : 0 < κ)
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    (h0 : HubColours c p b X Y S t κ)
    (h1 : HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ S} (t + π / 3) κ) : False := by
  obtain ⟨κ₁, hκ₁, hκ₁4, hb⟩ := exists_shiftBounds
  have hκ'pos : 0 < min (κ / 3) κ₁ := lt_min (by positivity) hκ₁
  have h3 : 3 * min (κ / 3) κ₁ ≤ κ := by
    have := min_le_left (κ / 3) κ₁
    linarith
  have h4 : min (κ / 3) κ₁ ≤ 1 / 4 := (min_le_right _ _).trans hκ₁4
  have hb' : ShiftBounds shift (min (κ / 3) κ₁) := hb.mono (min_le_right _ _)
  have hdc := no_double_change hc hw p h3 h4 hb' h0 h1
  obtain ⟨t', ht'⟩ := step_lemma hκ'pos hb' hS hdc
  have ht : t' = t := step_at_of_change (by positivity) hchange ht'
  rw [ht] at ht'
  exact step_kill hc hw p hκ'pos h3 h4 hb' h0 h1 ht'

end HadwigerNelson.SixRing
