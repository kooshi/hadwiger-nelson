import Proofs.HadwigerNelson.Plane.DensityBound.BesselDefect
import Proofs.HadwigerNelson.Plane.DensityBound.BesselCheck

/-!
# The `J₀` covering: its checker and the checker's soundness (FS-131, FS131-IDB1)

`[AmbrusEtAl2023]`'s certificate needs `ϕ(t) = w₁ + Σₖ Wₖ J₀(t dₖ) ≥ 1 − µ` for every `t ≥ 0` (its eq. (22) with `w₀`
as the term at `d = 1`). This module turns that into finitely many integer computations the kernel runs, and proves that
an accepted computation implies the inequality. Nothing here trusts the generator of the data
(`tools/fs131_idb1_cells.py`): a wrong datum can only make a check fail.

**One term over one cell.** A *state* `(m₀, m₁, r)` at `x` says `‖J(x) − (m₀ + i m₁)/2⁶⁴‖ ≤ r/2⁶⁴`, `J = J₀ + iJ₁`
(`St.Valid`). On a cell `t ∈ [t₀, t₀ + w]` (`t₀, w` at scale `2²⁰`) the term at distance `D/2⁶⁴` runs over
`x ∈ [c, c + h]`, `c = t₀D/2⁸⁴`, `h = wD/2⁸⁴`. The kernel builds integer coefficient lists `a`, `b` with `a₀ = m₀`,
`b₀ = m₁` (the Taylor recurrence of the Bessel system — **any** lists would do, the soundness proof never reads how they
were made) and puts `p(x) = (a(x − c) + i b(x − c))/2⁶⁴`. Its defect against the system is computed exactly as two
coefficient lists, `δ₀ = a′ + b` and, multiplied by `x`, `δ₁` (`xList`); their coefficient sizes bound the defect on
`(c, c + h)`, and the comparison lemma `norm_Jc_sub_le_of_defect` turns that into `‖J − p‖ ≤ err/2⁶⁴` on the cell
(`coreOf_sound`). The exit state is any state whose radius covers `err` plus its distance to `p(c + h)`.

**All terms over one cell.** `Σₖ Wₖ Re pₖ(t dₖ)` is one polynomial `Q(τ)`, `τ = t − t₀`; it is re-centred at the cell's
midpoint (`shiftL`), its quadratic part minimized exactly on the cell (`quadOk`) and its higher part bounded crudely
(`cellCheck`, `cellCheck_sound`). The distances enter only through `|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴` and `J₀` being `1`-Lipschitz.

**The chain and the tail.** Cells link exit to entry (`Linked`, `chain_sound`); states are stored packed in one `ℕ` per
cell boundary (`decode`), so the kernel reads a literal, never a computed state (`LEAN.md` § The kernel's cost model:
the planner measured chained states at 21.8 s per cell against 1.5 s for literals). Past the last cell, `‖J‖` is
antitone, so the last states bound every later `|J₀|` (`tailCheck_sound`).

The computations themselves are `Plane/DensityBound/BesselCheck` (core only, so the cells' kernel checks load no Mathlib);
this module gives them their meaning and proves them sound. The data and the cells are generated modules
`Plane/DensityBound/Cells/*`. Plan: `plans/FS131-KDB1-density-bound.md`
§ 2.1 R4; record `plans/FS131-IDB1-implementation.md`.
-/

namespace HadwigerNelson.DensityBound
namespace BesselCert

open Real Set

/-! ### Scales -/

theorem S_real : (S : ℝ) = 2 ^ 64 := by norm_num [S]

theorem S_pos : (0 : ℝ) < S := by norm_num [S]

theorem T2_pos : (0 : ℝ) < T2 := by norm_num [T2]

theorem SC_eq : (SC : ℝ) = T2 * S := by norm_num [SC, T2, S]

theorem SC_pos : (0 : ℝ) < SC := by norm_num [SC]

theorem K_eq : (K : ℝ) = 2 * T2 * S := by norm_num [K, T2, S]

theorem K_pos : (0 : ℝ) < K := by norm_num [K]

/-! ### Integer polynomials: coefficient lists, low degree first -/

/-- Horner evaluation at a real point, `ev [l₀, l₁, …] x = l₀ + x (l₁ + x (…))`: the semantics of a list. -/
noncomputable def ev : List ℤ → ℝ → ℝ
  | [], _ => 0
  | a :: l, x => a + x * ev l x

theorem ev_nil (x : ℝ) : ev [] x = 0 := rfl

theorem ev_cons (a : ℤ) (l : List ℤ) (x : ℝ) : ev (a :: l) x = a + x * ev l x := rfl

theorem cast_evZ (l : List ℤ) (x : ℤ) : ((evZ l x : ℤ) : ℝ) = ev l x := by
  induction l with
  | nil => simp [evZ, ev]
  | cons a l ih => simp [evZ, ev, ih]

theorem pw_eq (b : ℤ) (n : ℕ) : pw b n = b ^ n := by
  induction n with
  | zero => simp [pw]
  | succ n ih => simp [pw, ih, pow_succ]

theorem ev_addL (l m : List ℤ) (x : ℝ) : ev (addL l m) x = ev l x + ev m x := by
  induction l generalizing m with
  | nil => simp [addL, ev]
  | cons a l ih =>
    cases m with
    | nil => simp [addL, ev]
    | cons b m => simp only [addL, ev, ih]; push_cast; ring

theorem ev_smulL (c : ℤ) (l : List ℤ) (x : ℝ) : ev (smulL c l) x = c * ev l x := by
  induction l with
  | nil => simp [smulL, ev]
  | cons a l ih => simp only [smulL, ev, ih]; push_cast; ring

theorem cast_natAbs_eq (a : ℤ) : (((a.natAbs : ℤ)) : ℝ) = |(a : ℝ)| := by
  rw [Int.natCast_natAbs, Int.cast_abs]

theorem ev_absL_nonneg (l : List ℤ) {h : ℝ} (hh : 0 ≤ h) : 0 ≤ ev (absL l) h := by
  induction l with
  | nil => simp [absL, ev]
  | cons a l ih =>
    simp only [absL, ev, cast_natAbs_eq]
    exact add_nonneg (abs_nonneg _) (mul_nonneg hh ih)

/-- On `|x| ≤ h` a polynomial is bounded by its absolute coefficients at `h`. -/
theorem abs_ev_le (l : List ℤ) {x h : ℝ} (hx : |x| ≤ h) : |ev l x| ≤ ev (absL l) h := by
  have hh : 0 ≤ h := (abs_nonneg x).trans hx
  induction l with
  | nil => simp [absL, ev]
  | cons a l ih =>
    simp only [absL, ev, cast_natAbs_eq]
    calc |(a : ℝ) + x * ev l x| ≤ |(a : ℝ)| + |x| * |ev l x| := by
          rw [← abs_mul]; exact abs_add_le _ _
      _ ≤ |(a : ℝ)| + h * ev (absL l) h := by
          gcongr

theorem ev_derivAux_succ (k : ℤ) (l : List ℤ) (x : ℝ) :
    ev (derivAux (k + 1) l) x = ev l x + ev (derivAux k l) x := by
  induction l generalizing k with
  | nil => simp [derivAux, ev]
  | cons a l ih =>
    simp only [derivAux, ev, ih (k + 1)]; push_cast; ring

theorem ev_dL_cons (a : ℤ) (l : List ℤ) (x : ℝ) : ev (dL (a :: l)) x = ev l x + x * ev (dL l) x := by
  cases l with
  | nil => simp [dL, derivAux, ev]
  | cons b l =>
    have h := ev_derivAux_succ 1 l x
    simp only [dL, List.tail_cons, derivAux, ev] at h ⊢
    rw [h]; push_cast; ring

theorem hasDerivAt_ev (l : List ℤ) (x : ℝ) : HasDerivAt (fun y => ev l y) (ev (dL l) x) x := by
  induction l with
  | nil =>
    simp only [ev, dL, List.tail_nil, derivAux]
    exact hasDerivAt_const x 0
  | cons a l ih =>
    have h := ((hasDerivAt_id' x).mul ih).const_add (a : ℝ)
    have e1 : (fun y => ev (a :: l) y) = fun x => (a : ℝ) + (((fun x => x) * fun y => ev l y : ℝ → ℝ)) x := by
      funext y; simp only [ev, Pi.mul_apply]
    rw [e1, ev_dL_cons, show ev l x + x * ev (dL l) x = 1 * ev l x + x * ev (dL l) x by ring]
    exact h

theorem ev_affX (w : ℤ) (L : List ℤ) : ∀ (a : ℤ) (v : ℝ), ev (affX w a L) v = a + (w + v) * ev L v := by
  induction L with
  | nil => intro a v; simp [affX, ev]
  | cons c L ih => intro a v; simp only [affX, ev, ih]; push_cast; ring

theorem ev_shiftL (w : ℤ) (l : List ℤ) (v : ℝ) : ev (shiftL w l) v = ev l (w + v) := by
  induction l with
  | nil => simp [shiftL, ev]
  | cons a l ih => simp only [shiftL, ev_affX, ih, ev]

theorem ev_powScale (D : ℤ) (l : List ℤ) : ∀ (p : ℤ) (y : ℝ), ev (powScale D p l) y = p * ev l (D * y) := by
  induction l with
  | nil => intro p y; simp [powScale, ev]
  | cons a l ih => intro p y; simp only [powScale, ev, ih]; push_cast; ring

theorem ev_homogL (K : ℤ) (hK : (K : ℝ) ≠ 0) (l : List ℤ) (u : ℝ) :
    ev (homogL K l) u * K = (K : ℝ) ^ l.length * ev l (u / K) := by
  induction l with
  | nil => simp [homogL, ev]
  | cons a l ih =>
    simp only [homogL, ev, List.length_cons]
    push_cast [pw_eq]
    rw [add_mul, mul_assoc u, ih]
    field_simp
    ring

theorem evF_eq (hn hd : ℤ) : ∀ (v p q : ℤ) (l : List ℤ),
    evF hn hd v p q l = (v * pw hd l.length + p * Wh hn hd l, q * pw hd l.length)
  | v, p, q, [] => by simp [evF, Wh, pw]
  | v, p, q, a :: l => by
    rw [evF, evF_eq hn hd _ _ _ l]
    simp only [List.length_cons, Wh, pw, Prod.mk.injEq]
    constructor <;> ring

theorem evF_zero (hn hd : ℤ) (l : List ℤ) : evF hn hd 0 1 1 l = (Wh hn hd l, pw hd l.length) := by
  rw [evF_eq]; simp

theorem cast_Wh (hn hd : ℤ) (h : (hd : ℝ) ≠ 0) (l : List ℤ) :
    (Wh hn hd l : ℝ) = (hd : ℝ) ^ l.length * ev l (hn / hd) := by
  induction l with
  | nil => simp [Wh, ev]
  | cons a l ih =>
    simp only [Wh, ev, List.length_cons]
    push_cast [pw_eq, ih]
    field_simp
    ring

/-- `ev l (hn/hd) = Wh/hd^L` with `hd > 0`. -/
theorem ev_eq_Wh_div {hn hd : ℤ} (h : 0 < hd) (l : List ℤ) :
    ev l (hn / hd) = (Wh hn hd l : ℝ) / (pw hd l.length : ℤ) := by
  have h' : (hd : ℝ) ≠ 0 := by exact_mod_cast h.ne'
  have hp : (0 : ℝ) < (hd : ℝ) ^ l.length := pow_pos (by exact_mod_cast h) _
  rw [cast_Wh hn hd h', pw_eq]; push_cast; field_simp

theorem pw_pos {b : ℤ} (hb : 0 < b) (n : ℕ) : 0 < pw b n := by
  rw [pw_eq]; exact pow_pos hb n

/-- The split `l(v) = l₀ + l₁ v + l₂ v² + v³ (l₃ + …)`. -/
theorem ev_split (l : List ℤ) (v : ℝ) :
    ev l v = (l.getD 0 0 : ℤ) + (l.getD 1 0 : ℤ) * v + (l.getD 2 0 : ℤ) * v ^ 2 + v ^ 3 * ev (l.drop 3) v := by
  rcases l with _ | ⟨a, _ | ⟨b, _ | ⟨c, l⟩⟩⟩ <;> simp [ev] <;> ring

/-! ### Rounding -/

theorem le_cdiv {num den : ℤ} (h : 0 < den) : (num : ℝ) / den ≤ cdiv num den := by
  have h1 := Int.ediv_mul_le (-num) h.ne'
  have hd : (0 : ℝ) < den := by exact_mod_cast h
  have h2 : (((-num) / den : ℤ) : ℝ) * den ≤ -num := by exact_mod_cast h1
  rw [div_le_iff₀ hd]
  simp only [cdiv]; push_cast; linarith

/-! ### States -/

/-- The state is valid at `x`. -/
def St.Valid (st : St) (x : ℝ) : Prop :=
  ‖Jc x - ⟨(st.m0 : ℝ) / 2 ^ 64, (st.m1 : ℝ) / 2 ^ 64⟩‖ ≤ (st.r : ℝ) / 2 ^ 64

/-- A term's states at the time `T`: state `k` valid at `x = T·Dₖ/2⁶⁴`. -/
def StatesValid (Ds : List ℤ) (sts : List St) (T : ℝ) : Prop :=
  List.Forall₂ (fun (D : ℤ) (st : St) => St.Valid st (T * ((D : ℝ) / S))) Ds sts

/-- The distances `d` are within `2⁻⁶⁴` of `D/2⁶⁴` and nonnegative. -/
def Close (Ds : List ℤ) (d : List ℝ) : Prop :=
  List.Forall₂ (fun (D : ℤ) (x : ℝ) => |x - (D : ℝ) / S| ≤ 1 / (S : ℝ) ∧ 0 ≤ x) Ds d

/-- **A model of `Close`**: the listed distances themselves, when nonnegative. -/
theorem close_self (Ds : List ℤ) (h : ∀ D ∈ Ds, 0 ≤ D) : Close Ds (Ds.map fun D => (D : ℝ) / S) := by
  induction Ds with
  | nil => exact List.Forall₂.nil
  | cons D Ds ih =>
    refine List.Forall₂.cons ⟨?_, ?_⟩ (ih fun E hE => h E (List.mem_cons_of_mem D hE))
    · simp only [sub_self, abs_zero]; exact div_nonneg zero_le_one S_pos.le
    · exact div_nonneg (by exact_mod_cast h D List.mem_cons_self) S_pos.le

/-- `Σₖ Wₖ J₀(t dₖ)`. -/
noncomputable def jsum : List ℤ → List ℝ → ℝ → ℝ
  | W :: Ws, x :: d, t => W * J0 (t * x) + jsum Ws d t
  | _, _, _ => 0

/-- `jsum` as a list sum, the form a consumer's `ϕ` reads. -/
theorem jsum_eq_sum (Ws : List ℤ) (d : List ℝ) (t : ℝ) :
    jsum Ws d t = ((Ws.zip d).map fun p => (p.1 : ℝ) * J0 (t * p.2)).sum := by
  induction Ws generalizing d with
  | nil => simp [jsum]
  | cons W Ws ih =>
    cases d with
    | nil => simp [jsum]
    | cons x d => simp [jsum, ih]

/-! ### One term over one cell -/

theorem core_eq (W D : ℤ) (st : St) (t0 w : ℤ) (N : ℕ) :
    core W D st t0 w N = coreOf W D st t0 w (taylor (t0 * D) N st.m0 st.m1).1 (taylor (t0 * D) N st.m0 st.m1).2 := by
  unfold core
  generalize taylor (t0 * D) N st.m0 st.m1 = p
  rfl

/-- The polynomial pair `p(x) = (a(x − c) + i b(x − c))/S`. -/
noncomputable def pp (a b : List ℤ) (c x : ℝ) : ℂ := ⟨ev a (x - c) / S, ev b (x - c) / S⟩

theorem hasDerivAt_pp (a b : List ℤ) (c x : ℝ) : HasDerivAt (pp a b c) (pp (dL a) (dL b) c x) x := by
  have ha := ((hasDerivAt_ev a (x - c)).comp_sub_const x c).div_const (S : ℝ)
  have hb := ((hasDerivAt_ev b (x - c)).comp_sub_const x c).div_const (S : ℝ)
  have h := ha.ofReal_comp.add (hb.ofReal_comp.mul_const Complex.I)
  have h1 : pp a b c = fun y => ((ev a (y - c) / S : ℝ) : ℂ) + ((ev b (y - c) / S : ℝ) : ℂ) * Complex.I := by
    funext y; exact Complex.mk_eq_add_mul_I _ _
  rw [h1, show pp (dL a) (dL b) c x =
    ((ev (dL a) (x - c) / S : ℝ) : ℂ) + ((ev (dL b) (x - c) / S : ℝ) : ℂ) * Complex.I from Complex.mk_eq_add_mul_I _ _]
  exact h

theorem besselField_eq (x : ℝ) (w : ℂ) : besselField x w = ⟨-w.im, w.re - w.im / x⟩ := by
  apply Complex.ext <;> simp [besselField]

theorem defect_re (a b : List ℤ) (c x : ℝ) :
    (pp (dL a) (dL b) c x - besselField x (pp a b c x)).re = ev (addL (dL a) b) (x - c) / S := by
  simp only [Complex.sub_re, besselField_eq, pp, ev_addL]; ring

theorem defect_im (a b : List ℤ) (c x : ℝ) :
    (pp (dL a) (dL b) c x - besselField x (pp a b c x)).im =
      ev (addL (dL b) (smulL (-1) a)) (x - c) / S + ev b (x - c) / S / x := by
  simp only [Complex.sub_im, besselField_eq, pp, ev_addL, ev_smulL]; push_cast; ring

theorem defect_im_mul (a tb : List ℤ) {m1 C : ℤ} {c x : ℝ} (hC0 : C ≠ 0) (hC : (C : ℝ) = SC * c) (hx : x ≠ 0) :
    (pp (dL a) (dL (m1 :: tb)) c x - besselField x (pp a (m1 :: tb) c x)).im * (SC * S * x) =
      ev (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb) (x - c) := by
  rw [defect_im]
  simp only [xList, if_neg hC0, ev_addL, ev_smulL, ev_cons]
  rw [hC]
  have hS : (S : ℝ) ≠ 0 := S_pos.ne'
  field_simp
  ring

theorem defect_im_zero (a tb : List ℤ) {x : ℝ} (hx : x ≠ 0) :
    (pp (dL a) (dL ((0 : ℤ) :: tb)) 0 x - besselField x (pp a ((0 : ℤ) :: tb) 0 x)).im =
      ev (xList 0 (addL (dL ((0 : ℤ) :: tb)) (smulL (-1) a)) ((0 : ℤ) :: tb) tb) x / S := by
  rw [defect_im, xList, if_pos rfl]
  simp only [sub_zero, ev_addL, ev_cons]
  have hS : (S : ℝ) ≠ 0 := S_pos.ne'
  field_simp
  push_cast
  ring

/-- **The defect bound** on `(c, c + h)`: `‖p′ − F(x, p)‖ ≤ Σ|δ₀ₙ| hⁿ/S + Σ|Xₙ| hⁿ/(S·C)` (`C ≠ 0`, `C = SC·c`), and
at `C = 0` (so `c = 0`, and `b₀ = 0` asked) the same with `1` for `C`. -/
theorem defect_bound {a tb : List ℤ} {m1 C : ℤ} {c hh : ℝ} (hCc : (C : ℝ) = SC * c) (hC : 0 ≤ C)
    (hC0 : C ≠ 0 ∨ m1 = 0) {x : ℝ} (hx : x ∈ Ioo c (c + hh)) :
    ‖pp (dL a) (dL (m1 :: tb)) c x - besselField x (pp a (m1 :: tb) c x)‖ ≤
      ev (absL (addL (dL a) (m1 :: tb))) hh / S +
        ev (absL (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb)) hh /
          (S * ((if C = 0 then 1 else C : ℤ) : ℝ)) := by
  have hS := S_pos
  have hSC := SC_pos
  have hCr : (0 : ℝ) ≤ C := by exact_mod_cast hC
  have hc0 : 0 ≤ c := by nlinarith
  have hs : |x - c| ≤ hh := by rw [abs_le]; constructor <;> linarith [hx.1, hx.2]
  have hxpos : 0 < x := by linarith [hx.1]
  refine (Complex.norm_le_abs_re_add_abs_im _).trans (add_le_add ?_ ?_)
  · rw [defect_re, abs_div, abs_of_pos hS]
    exact div_le_div_of_nonneg_right (abs_ev_le _ hs) hS.le
  · by_cases h0 : C = 0
    · have hm1 : m1 = 0 := hC0.resolve_left (not_not.mpr h0)
      subst hm1
      subst h0
      have hc : c = 0 := by
        have h' : (0 : ℝ) = SC * c := by simpa using hCc
        rcases mul_eq_zero.mp h'.symm with h | h
        · exact absurd h hSC.ne'
        · exact h
      subst hc
      rw [defect_im_zero a tb hxpos.ne', if_pos rfl]
      simp only [Int.cast_one, mul_one]
      rw [abs_div, abs_of_pos hS]
      exact div_le_div_of_nonneg_right (abs_ev_le _ (by simpa using hs)) hS.le
    · rw [if_neg h0]
      have hCpos : (0 : ℝ) < C := by exact_mod_cast lt_of_le_of_ne hC (Ne.symm h0)
      have hm := defect_im_mul a tb (m1 := m1) h0 hCc hxpos.ne'
      have hden : 0 < (SC : ℝ) * S * x := by positivity
      have him : (pp (dL a) (dL (m1 :: tb)) c x - besselField x (pp a (m1 :: tb) c x)).im =
          ev (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb) (x - c) / (SC * S * x) := by
        rw [← hm]; field_simp
      rw [him, abs_div, abs_of_pos hden, div_le_div_iff₀ hden (by positivity)]
      have h1 := abs_ev_le (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb) hs
      have h2 := ev_absL_nonneg (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb) ((abs_nonneg _).trans hs)
      have h3 : (C : ℝ) ≤ SC * x := by rw [hCc]; nlinarith [hx.1]
      calc |ev (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb) (x - c)| * (S * C)
          ≤ ev (absL (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb)) hh * (S * C) := by gcongr
        _ ≤ ev (absL (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb)) hh * (S * (SC * x)) := by gcongr
        _ = ev (absL (xList C (addL (dL (m1 :: tb)) (smulL (-1) a)) (m1 :: tb) tb)) hh * (SC * S * x) := by ring

/-- `h · (l(h)/E) ≤ ⌈hn·Wh/(hd·hd^L·E)⌉` at `h = hn/hd`: the rounded bound the kernel computes. -/
theorem mul_ev_le_cdiv {hn hd E : ℤ} (hhd : 0 < hd) (hE : 0 < E) (l : List ℤ) :
    (hn : ℝ) / hd * (ev l (hn / hd) / E) ≤ cdiv (hn * Wh hn hd l) (hd * pw hd l.length * E) := by
  have hp := pw_pos hhd l.length
  refine le_trans (le_of_eq ?_) (le_cdiv (by positivity))
  rw [ev_eq_Wh_div hhd]
  have : (0 : ℝ) < hd := by exact_mod_cast hhd
  have : (0 : ℝ) < (pw hd l.length : ℤ) := by exact_mod_cast hp
  have : (0 : ℝ) < E := by exact_mod_cast hE
  push_cast
  field_simp

theorem mul_ev_le_cdiv' {hn hd : ℤ} (hhd : 0 < hd) (l : List ℤ) :
    (hn : ℝ) / hd * ev l (hn / hd) ≤ cdiv (hn * Wh hn hd l) (hd * pw hd l.length) := by
  simpa using mul_ev_le_cdiv (E := 1) hhd one_pos l

/-- `|P/R − m| ≤ ⌈|P − mR|/R⌉`. -/
theorem abs_div_sub_le_cdiv {P R m : ℤ} (hR : 0 < R) : |(P : ℝ) / R - m| ≤ cdiv ((P - m * R).natAbs) R := by
  refine le_trans (le_of_eq ?_) (le_cdiv hR)
  have hRr : (0 : ℝ) < R := by exact_mod_cast hR
  rw [cast_natAbs_eq, show (P : ℝ) / R - m = (P - m * R) / R by field_simp, abs_div, abs_of_pos hRr]
  push_cast; ring

theorem valid_iff (st : St) (x : ℝ) :
    st.Valid x ↔ ‖Jc x - ⟨(st.m0 : ℝ) / S, (st.m1 : ℝ) / S⟩‖ ≤ (st.r : ℝ) / S := by
  rw [St.Valid, S_real]

/-- **One term over one cell.** If the exit state is accepted and the entry state is valid at the cell's left end,
the exit state is valid at its right end, and on the cell `W·J₀(t D/S)` is at least `(q(y) − |W|·err)/S` at
`y = (t − t₀)/S`. Inhabited by every cell of the generated covering (`Cells/Part00`, its first cell from
`statesValid_init`). -/
theorem coreOf_sound {W D : ℤ} {st st' : St} {t0 w : ℤ} {ta tb : List ℤ} (ht0 : 0 ≤ t0) (hw : 0 < w)
    (hok : termOk (coreOf W D st t0 w ta tb) st' = true) (hv : st.Valid ((t0 / T2 : ℝ) * (D / S))) :
    st'.Valid (((t0 + w) / T2 : ℝ) * (D / S)) ∧
    ∀ t ∈ Icc ((t0 : ℝ) / T2) ((t0 + w) / T2),
      (ev (coreOf W D st t0 w ta tb).q ((t - t0 / T2) / S) - W.natAbs * (coreOf W D st t0 w ta tb).err) / S ≤
        W * J0 (t * (D / S)) := by
  simp only [coreOf, evF_zero, termOk, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at hok ⊢
  obtain ⟨⟨hD, hC0⟩, hr'⟩ := hok
  have hS := S_pos
  have hT2 := T2_pos
  have hSC := SC_pos
  have hDr : (0 : ℝ) < D := by exact_mod_cast hD
  have ht0r : (0 : ℝ) ≤ t0 := by exact_mod_cast ht0
  have hwr : (0 : ℝ) < w := by exact_mod_cast hw
  have hCnn : 0 ≤ t0 * D := mul_nonneg ht0 hD.le
  have hCd : 0 < (if t0 * D = 0 then 1 else t0 * D : ℤ) := by
    split_ifs with h
    · exact one_pos
    · exact lt_of_le_of_ne hCnn (Ne.symm h)
  set c : ℝ := (t0 / T2 : ℝ) * (D / S) with hc
  set hh : ℝ := ((w * D : ℤ) : ℝ) / SC with hhh
  have hc0 : 0 ≤ c := by positivity
  have hhpos : 0 < hh := by rw [hhh]; push_cast; positivity
  have hx1 : ((t0 + w) / T2 : ℝ) * (D / S) = c + hh := by
    rw [hc, hhh, SC_eq]; push_cast; field_simp
  have hCc : ((t0 * D : ℤ) : ℝ) = SC * c := by rw [hc, SC_eq]; push_cast; field_simp
  set a : List ℤ := st.m0 :: ta with ha
  set b : List ℤ := st.m1 :: tb with hb
  set X : List ℤ := xList (t0 * D) (addL (dL b) (smulL (-1) a)) b tb with hX
  set d0 : List ℤ := addL (dL a) b with hd0
  set Cd : ℤ := if t0 * D = 0 then 1 else t0 * D with hCd_def
  set Dt : ℝ := ev (absL d0) hh / S + ev (absL X) hh / (S * Cd) with hDt
  have hDt0 : 0 ≤ Dt := by
    have := ev_absL_nonneg d0 hhpos.le
    have := ev_absL_nonneg X hhpos.le
    have : (0 : ℝ) < Cd := by exact_mod_cast hCd
    positivity
  -- the comparison lemma on the cell
  have hdef : ∀ x ∈ Ioo c (c + hh), ‖pp (dL a) (dL b) c x - besselField x (pp a b c x)‖ ≤ Dt :=
    fun x hx => defect_bound hCc hCnn hC0 hx
  have hcmp : ∀ x ∈ Icc c (c + hh), ‖Jc x - pp a b c x‖ ≤ ‖Jc c - pp a b c c‖ + (x - c) * Dt :=
    fun x hx => norm_Jc_sub_le_of_defect hc0 (fun y _ => hasDerivAt_pp a b c y) hdef hx
  have hpc : pp a b c c = ⟨(st.m0 : ℝ) / S, (st.m1 : ℝ) / S⟩ := by simp [pp, ev, a, b]
  have hv' : ‖Jc c - pp a b c c‖ ≤ (st.r : ℝ) / S := by rw [hpc]; exact (valid_iff st c).1 hv
  -- the rounded error
  have hhD : hh * Dt ≤ ((cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
      cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ) / S := by
    have e1 := mul_ev_le_cdiv' (hn := w * D) (by norm_num [SC] : (0 : ℤ) < SC) (absL d0)
    have e2 := mul_ev_le_cdiv (hn := w * D) (by norm_num [SC] : (0 : ℤ) < SC) hCd (absL X)
    rw [le_div_iff₀ hS]
    push_cast
    have : hh * Dt * S = hh * ev (absL d0) hh + hh * (ev (absL X) hh / Cd) := by
      rw [hDt]; field_simp
    rw [this]
    exact add_le_add e1 e2
  have herr : ∀ x ∈ Icc c (c + hh), ‖Jc x - pp a b c x‖ ≤
      ((st.r + cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
        cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ) / S := by
    intro x hx
    have h1 := hcmp x hx
    have h2 : (x - c) * Dt ≤ hh * Dt := mul_le_mul_of_nonneg_right (by linarith [hx.2]) hDt0
    have h3 : ((st.r + cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
        cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ) / S =
        (st.r : ℝ) / S + ((cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
          cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ) / S := by
      push_cast; ring
    rw [h3]
    linarith
  refine ⟨?_, ?_⟩
  · -- the exit state
    rw [valid_iff, hx1]
    have hmem : c + hh ∈ Icc c (c + hh) := ⟨by linarith, le_rfl⟩
    have he := herr _ hmem
    have hp1 : pp a b c (c + hh) = ⟨ev a hh / S, ev b hh / S⟩ := by simp [pp]
    have hq : ‖pp a b c (c + hh) - ⟨(st'.m0 : ℝ) / S, (st'.m1 : ℝ) / S⟩‖ ≤
        ((cdiv ((Wh (w * D) SC a - st'.m0 * pw SC a.length).natAbs) (pw SC a.length) +
          cdiv ((Wh (w * D) SC b - st'.m1 * pw SC b.length).natAbs) (pw SC b.length) : ℤ) : ℝ) / S := by
      rw [hp1]
      refine (Complex.norm_le_abs_re_add_abs_im _).trans ?_
      simp only [Complex.sub_re, Complex.sub_im]
      have ea := abs_div_sub_le_cdiv (P := Wh (w * D) SC a) (m := st'.m0) (pw_pos (b := SC) (by norm_num [SC]) a.length)
      have eb := abs_div_sub_le_cdiv (P := Wh (w * D) SC b) (m := st'.m1) (pw_pos (b := SC) (by norm_num [SC]) b.length)
      rw [hhh, ev_eq_Wh_div (hd := SC) (by norm_num [SC]), ev_eq_Wh_div (hd := SC) (by norm_num [SC])]
      rw [← sub_div, ← sub_div, abs_div, abs_div, abs_of_pos hS]
      push_cast at ea eb ⊢
      rw [add_div]
      exact add_le_add (div_le_div_of_nonneg_right ea hS.le) (div_le_div_of_nonneg_right eb hS.le)
    have hr'' : ((st.r + cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
        cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ) / S +
        ((cdiv ((Wh (w * D) SC a - st'.m0 * pw SC a.length).natAbs) (pw SC a.length) +
          cdiv ((Wh (w * D) SC b - st'.m1 * pw SC b.length).natAbs) (pw SC b.length) : ℤ) : ℝ) / S ≤
        (st'.r : ℝ) / S := by
      rw [← add_div]
      refine div_le_div_of_nonneg_right ?_ hS.le
      have h := (Int.cast_le (R := ℝ)).2 hr'
      push_cast at h ⊢
      linarith
    calc ‖Jc (c + hh) - ⟨(st'.m0 : ℝ) / S, (st'.m1 : ℝ) / S⟩‖
        ≤ ‖Jc (c + hh) - pp a b c (c + hh)‖ + ‖pp a b c (c + hh) - ⟨(st'.m0 : ℝ) / S, (st'.m1 : ℝ) / S⟩‖ :=
          norm_sub_le_norm_sub_add_norm_sub _ _ _
      _ ≤ _ := add_le_add he hq
      _ ≤ _ := hr''
  · -- the lower bound on the cell
    intro t ht
    have hDS : (0 : ℝ) ≤ D / S := by positivity
    have hxm : t * (D / S) ∈ Icc c (c + hh) := by
      refine ⟨?_, ?_⟩
      · rw [hc]; exact mul_le_mul_of_nonneg_right ht.1 hDS
      · rw [← hx1]; exact mul_le_mul_of_nonneg_right ht.2 hDS
    have he := herr _ hxm
    have hre : |J0 (t * (D / S)) - ev a (t * (D / S) - c) / S| ≤ ‖Jc (t * (D / S)) - pp a b c (t * (D / S))‖ :=
      abs_J0_sub_re_le (t * (D / S)) (pp a b c (t * (D / S)))
    have hq : ev (powScale D W a) ((t - t0 / T2) / S) = W * ev a (t * (D / S) - c) := by
      rw [ev_powScale]; congr 2; rw [hc]; ring
    rw [hq]
    have hW : ((W.natAbs : ℕ) : ℝ) = |(W : ℝ)| := by rw [Nat.cast_natAbs, Int.cast_abs]
    rw [hW]
    have hb := hre.trans he
    set E := ev a (t * (D / S) - c)
    set R := ((st.r + cdiv (w * D * Wh (w * D) SC (absL d0)) (SC * pw SC (absL d0).length) +
        cdiv (w * D * Wh (w * D) SC (absL X)) (SC * pw SC (absL X).length * Cd) : ℤ) : ℝ)
    have k1 : |(W : ℝ) * (J0 (t * (D / S)) - E / S)| ≤ |(W : ℝ)| * (R / S) := by
      rw [abs_mul]; exact mul_le_mul_of_nonneg_left hb (abs_nonneg _)
    have k2 := neg_abs_le ((W : ℝ) * (J0 (t * (D / S)) - E / S))
    have k3 : ((W : ℝ) * E - |(W : ℝ)| * R) / S = (W : ℝ) * (E / S) - |(W : ℝ)| * (R / S) := by ring
    rw [k3]
    nlinarith

/-! ### All terms over one cell -/

theorem termsOut_cons (t0 w : ℤ) (N : ℕ) (W D : ℤ) (Ws Ds : List ℤ) (st st' : St) (sts sts' : List St) :
    termsOut t0 w N (W :: Ws) (D :: Ds) (st :: sts) (st' :: sts') =
      (termOk (core W D st t0 w N) st' && (termsOut t0 w N Ws Ds sts sts').1,
        addL (core W D st t0 w N).q (termsOut t0 w N Ws Ds sts sts').2.1,
        W.natAbs * (T2 * (core W D st t0 w N).err + (t0 + w)) + (termsOut t0 w N Ws Ds sts sts').2.2) := by
  simp only [termsOut]

/-- `W·J₀(t x)` from one term's cell bound, with `|x − D/S| ≤ 1/S`. -/
theorem term_le_of_close {W D : ℤ} {E R t x : ℝ} {t0 w : ℤ} (ht0 : (0 : ℝ) ≤ t0 / T2) (ht : t ∈ Icc ((t0 : ℝ) / T2) ((t0 + w) / T2))
    (hx : |x - D / S| ≤ 1 / S) (hb : (E - W.natAbs * R) / S ≤ W * J0 (t * (D / S))) :
    (E - W.natAbs * (T2 * R + (t0 + w)) / T2) / S ≤ W * J0 (t * x) := by
  have hS := S_pos
  have hT2 := T2_pos
  have htn : 0 ≤ t := ht0.trans ht.1
  have hW : ((W.natAbs : ℕ) : ℝ) = |(W : ℝ)| := by rw [Nat.cast_natAbs, Int.cast_abs]
  have hL := abs_J0_sub_le (t * x) (t * (D / S))
  have h1 : |t * x - t * (D / S)| ≤ ((t0 + w) / T2) / S := by
    rw [← mul_sub, abs_mul, abs_of_nonneg htn]
    calc t * |x - D / S| ≤ ((t0 + w) / T2) * (1 / S) := mul_le_mul ht.2 hx (abs_nonneg _) (ht0.trans (ht.1.trans ht.2))
      _ = ((t0 + w) / T2) / S := by ring
  have k1 : |(W : ℝ) * (J0 (t * x) - J0 (t * (D / S)))| ≤ |(W : ℝ)| * (((t0 + w) / T2) / S) := by
    rw [abs_mul]; exact mul_le_mul_of_nonneg_left (hL.trans h1) (abs_nonneg _)
  have k2 := neg_abs_le ((W : ℝ) * (J0 (t * x) - J0 (t * (D / S))))
  have k3 : (E - W.natAbs * (T2 * R + (t0 + w)) / T2) / S =
      (E - W.natAbs * R) / S - |(W : ℝ)| * (((t0 + w) / T2) / S) := by
    rw [hW]; field_simp; ring
  rw [k3]
  nlinarith

/-- **All terms over one cell**: accepted exit states are valid at the cell's right end, and on the cell
`Σₖ Wₖ J₀(t dₖ) ≥ (q(y) − e/T2)/S` at `y = (t − t₀)/S`, for any distances within `2⁻⁶⁴` of the `Dₖ`. -/
theorem termsOut_sound {t0 w : ℤ} {N : ℕ} (ht0 : 0 ≤ t0) (hw : 0 < w) :
    ∀ (Ws Ds : List ℤ) (sts sts' : List St) (q : List ℤ) (e : ℤ),
      termsOut t0 w N Ws Ds sts sts' = (true, q, e) → StatesValid Ds sts (t0 / T2) →
      StatesValid Ds sts' ((t0 + w) / T2) ∧ ∀ d : List ℝ, Close Ds d → ∀ t ∈ Icc ((t0 : ℝ) / T2) ((t0 + w) / T2),
        (ev q ((t - t0 / T2) / S) - e / T2) / S ≤ jsum Ws d t
  | [], Ds, sts, sts', q, e, h, _ => by
    rcases Ds with _ | ⟨D, Ds⟩ <;> rcases sts with _ | ⟨st, sts⟩ <;> rcases sts' with _ | ⟨st', sts'⟩ <;>
      simp [termsOut] at h
    obtain ⟨rfl, rfl⟩ := h
    refine ⟨List.Forall₂.nil, fun d hd t _ => ?_⟩
    cases hd
    simp [ev, jsum]
  | W :: Ws, Ds, sts, sts', q, e, h, hv => by
    rcases Ds with _ | ⟨D, Ds⟩ <;> rcases sts with _ | ⟨st, sts⟩ <;> rcases sts' with _ | ⟨st', sts'⟩ <;>
      simp only [termsOut, Prod.mk.injEq, Bool.false_eq_true, false_and] at h
    simp only [Bool.and_eq_true] at h
    obtain ⟨⟨hok, hrok⟩, hq, he⟩ := h
    have hrest : termsOut t0 w N Ws Ds sts sts' =
        (true, (termsOut t0 w N Ws Ds sts sts').2.1, (termsOut t0 w N Ws Ds sts sts').2.2) := by
      rw [← hrok]
    obtain ⟨hv1, hvs⟩ := List.forall₂_cons.1 hv
    have ih := termsOut_sound ht0 hw Ws Ds sts sts' _ _ hrest hvs
    rw [core_eq] at hok
    have hc := coreOf_sound ht0 hw hok (by exact_mod_cast hv1)
    refine ⟨List.Forall₂.cons (by exact_mod_cast hc.1) ih.1, fun d hd t ht => ?_⟩
    rcases d with _ | ⟨x, d⟩
    · cases hd
    obtain ⟨hx, hds⟩ := List.forall₂_cons.1 hd
    have h1 := term_le_of_close (W := W) (D := D) (E := ev (core W D st t0 w N).q ((t - t0 / T2) / S))
      (R := (core W D st t0 w N).err) (div_nonneg (by exact_mod_cast ht0) T2_pos.le) ht hx.1 (by rw [core_eq]; exact_mod_cast hc.2 t ht)
    have h2 := ih.2 d hds t ht
    rw [← hq, ← he]
    simp only [jsum, ev_addL]
    push_cast
    have hS := S_pos
    have hT2 := T2_pos
    have hW : ((W.natAbs : ℕ) : ℝ) = |(W : ℝ)| := by rw [Nat.cast_natAbs, Int.cast_abs]
    rw [hW] at h1
    have k : (ev (core W D st t0 w N).q ((t - t0 / T2) / S) + ev (termsOut t0 w N Ws Ds sts sts').2.1 ((t - t0 / T2) / S) -
        (|(W : ℝ)| * ((T2 : ℝ) * (core W D st t0 w N).err + (t0 + w)) + (termsOut t0 w N Ws Ds sts sts').2.2) / T2) / S =
        (ev (core W D st t0 w N).q ((t - t0 / T2) / S) - |(W : ℝ)| * (T2 * (core W D st t0 w N).err + (t0 + w)) / T2) / S +
        (ev (termsOut t0 w N Ws Ds sts sts').2.1 ((t - t0 / T2) / S) - (termsOut t0 w N Ws Ds sts sts').2.2 / T2) / S := by
      field_simp; ring
    rw [k]
    exact add_le_add h1 h2

/-! ### The cell polynomial's lower bound -/

theorem quadOk_sound {q0 q1 q2 w L : ℤ} (h : quadOk q0 q1 q2 w L = true) (hw : 0 ≤ w) {v : ℝ} (hv : |v| ≤ w) :
    (L : ℝ) ≤ q0 + q1 * v + q2 * v ^ 2 := by
  simp only [quadOk, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨h1, h2⟩, h3⟩ := h
  have h1' : (L : ℝ) ≤ q0 - q1 * w + q2 * w * w := by exact_mod_cast h1
  have h2' : (L : ℝ) ≤ q0 + q1 * w + q2 * w * w := by exact_mod_cast h2
  have hwr : (0 : ℝ) ≤ w := by exact_mod_cast hw
  have hvl : -(w : ℝ) ≤ v := by linarith [neg_abs_le v]
  have hvu : v ≤ w := by linarith [le_abs_self v]
  by_cases hq : 0 < q2 ∧ (q1.natAbs : ℤ) ≤ 2 * q2 * w
  · rw [if_pos hq, decide_eq_true_eq] at h3
    have h3' : (4 * q2 * L : ℝ) ≤ 4 * q0 * q2 - q1 * q1 := by exact_mod_cast h3
    have hq2 : (0 : ℝ) < q2 := by exact_mod_cast hq.1
    nlinarith [sq_nonneg (2 * (q2 : ℝ) * v + q1)]
  · by_cases hq2 : q2 ≤ 0
    · have hq2r : (q2 : ℝ) ≤ 0 := by exact_mod_cast hq2
      have k1 : 0 ≤ ((w : ℝ) - v) * ((q0 : ℝ) - q1 * w + q2 * w * w - L) := mul_nonneg (by linarith) (by linarith)
      have k2 : 0 ≤ ((w : ℝ) + v) * ((q0 : ℝ) + q1 * w + q2 * w * w - L) := mul_nonneg (by linarith) (by linarith)
      have k4 : 0 ≤ (w : ℝ) ^ 2 - v ^ 2 := by nlinarith
      have k3 : 0 ≤ (w : ℝ) * (-(q2 : ℝ)) * ((w : ℝ) ^ 2 - v ^ 2) := mul_nonneg (mul_nonneg hwr (by linarith)) k4
      rcases hwr.lt_or_eq with hwp | hw0
      · have k5 : 0 ≤ 2 * (w : ℝ) * ((q0 : ℝ) + q1 * v + q2 * v ^ 2 - L) := by nlinarith
        have := (mul_nonneg_iff_of_pos_left (by linarith : (0 : ℝ) < 2 * w)).1 k5
        linarith
      · have hv0 : v = 0 := by
          have : |v| ≤ 0 := by rw [hw0]; exact hv
          exact abs_nonpos_iff.1 this
        rw [hv0]; rw [← hw0] at h2'; simp at h2' ⊢; linarith
    · push Not at hq2
      have hq1 : 2 * q2 * w < |q1| := by
        rw [← Int.natCast_natAbs]
        by_contra hc; push Not at hc; exact hq ⟨hq2, hc⟩
      have hq2r : (0 : ℝ) < q2 := by exact_mod_cast hq2
      rcases le_or_gt 0 q1 with hq1p | hq1n
      · rw [abs_of_nonneg hq1p] at hq1
        have hq1r : 2 * (q2 : ℝ) * w < q1 := by exact_mod_cast hq1
        have k1 : 0 ≤ (v + w) * ((q1 : ℝ) + q2 * (v - w)) := mul_nonneg (by linarith) (by nlinarith)
        nlinarith
      · rw [abs_of_neg hq1n] at hq1
        have hq1r : 2 * (q2 : ℝ) * w < -q1 := by exact_mod_cast hq1
        have k1 : 0 ≤ (w - v) * (-(q1 : ℝ) - q2 * (v + w)) := mul_nonneg (by linarith) (by nlinarith)
        nlinarith

/-! ### One cell -/

/-- **One cell is sound**: if the check accepts, valid entry states give valid exit states, and on the cell
`w₁ + Σₖ Wₖ J₀(t dₖ) ≥ TN/TD` (all at their scales) for any distances `dₖ` within `2⁻⁶⁴` of `Dₖ/2⁶⁴`. Inhabited by every
generated cell (`Cells/Part00`, its first cell from `statesValid_init`). -/
theorem cellCheck_sound {P : Params} {sts sts' : List St} {t0 w : ℤ} {N : ℕ}
    (h : cellCheck P sts t0 w N sts' = true) (hv : StatesValid P.Ds sts (t0 / T2)) :
    StatesValid P.Ds sts' ((t0 + w) / T2) ∧ ∀ d : List ℝ, Close P.Ds d →
      ∀ t ∈ Icc ((t0 : ℝ) / T2) ((t0 + w) / T2), (P.TN : ℝ) / P.TD ≤ P.w1N / P.WS + jsum P.Ws d t / P.WS := by
  rcases hr : termsOut t0 w N P.Ws P.Ds sts sts' with ⟨ok, q, e⟩
  simp only [cellCheck, hr, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨⟨⟨hok, ht0⟩, hw⟩, hTD⟩, hWS⟩, hquad⟩ := h
  subst hok
  have hts := termsOut_sound ht0 hw P.Ws P.Ds sts sts' q e hr hv
  refine ⟨hts.1, fun d hd t ht => ?_⟩
  have hS := S_pos
  have hT2 := T2_pos
  have hK := K_pos
  have hwr : (0 : ℝ) < w := by exact_mod_cast hw
  have hTDr : (0 : ℝ) < P.TD := by exact_mod_cast hTD
  have hWSr : (0 : ℝ) < P.WS := by exact_mod_cast hWS
  set q' := addL [P.w1N * S] q with hq'
  set R := shiftL w (homogL K q') with hR
  set u : ℝ := 2 * T2 * (t - t0 / T2) with hu
  set v : ℝ := u - w with hv'
  have hvw : |v| ≤ w := by
    rw [abs_le]
    have h1 := ht.1
    have h2 := ht.2
    constructor
    · rw [hv', hu]
      have : (t0 : ℝ) / T2 ≤ t := h1
      have k : 0 ≤ 2 * (T2 : ℝ) * (t - t0 / T2) := mul_nonneg (by linarith) (by linarith)
      linarith
    · rw [hv', hu]
      have : t ≤ ((t0 : ℝ) + w) / T2 := h2
      have k : 2 * (T2 : ℝ) * (t - t0 / T2) ≤ 2 * T2 * (((t0 : ℝ) + w) / T2 - t0 / T2) :=
        mul_le_mul_of_nonneg_left (by linarith) (by linarith)
      have k2 : 2 * (T2 : ℝ) * (((t0 : ℝ) + w) / T2 - t0 / T2) = 2 * w := by field_simp; ring
      linarith
  -- the cell polynomial at y = u/K
  have hy : (t - t0 / T2) / S = u / K := by rw [hu, K_eq]; field_simp
  have hRv : ev R v = ev (homogL K q') u := by rw [hR, ev_shiftL]; congr 1; rw [hv']; ring
  have hhom := ev_homogL K hK.ne' q' u
  -- the lower bound on R(v)
  have hsplit := ev_split R v
  have hq0 := quadOk_sound hquad hw.le hvw
  have hhi : |v ^ 3 * ev (R.drop 3) v| ≤ (w * w * w * evZ (absL (R.drop 3)) w : ℤ) := by
    push_cast
    rw [cast_evZ, abs_mul, abs_pow]
    have := abs_ev_le (R.drop 3) hvw
    have h3 : |v| ^ 3 ≤ (w : ℝ) ^ 3 := pow_le_pow_left₀ (abs_nonneg v) hvw 3
    calc |v| ^ 3 * |ev (R.drop 3) v| ≤ (w : ℝ) ^ 3 * ev (absL (R.drop 3)) w :=
          mul_le_mul h3 this (abs_nonneg _) (by positivity)
      _ = _ := by ring
  have hcd := le_cdiv (num := (P.TN * S * P.WS * T2 + e * P.TD) * pw K q'.length) (den := K * P.TD * T2)
    (mul_pos (mul_pos (by norm_num [K]) hTD) (by norm_num [T2]))
  have hRlow : (((P.TN * S * P.WS * T2 + e * P.TD) * pw K q'.length : ℤ) : ℝ) / ((K * P.TD * T2 : ℤ) : ℝ) ≤ ev R v := by
    have k := neg_abs_le (v ^ 3 * ev (R.drop 3) v)
    push_cast at hq0 hhi hcd ⊢
    linarith
  -- assemble
  have hpw : ((pw K q'.length : ℤ) : ℝ) = (K : ℝ) ^ q'.length := by rw [pw_eq]; push_cast; ring
  have hpwpos : (0 : ℝ) < (K : ℝ) ^ q'.length := pow_pos hK _
  have hq'v : ev q' (u / K) = P.w1N * S + ev q (u / K) := by
    rw [hq', ev_addL]; simp [ev]
  have hmain : (P.TN : ℝ) * S * P.WS / P.TD + e / T2 ≤ ev q' (u / K) := by
    have k1 : ev q' (u / K) = ev R v * K / (K : ℝ) ^ q'.length := by
      rw [hRv]; field_simp; linarith [hhom]
    rw [k1, le_div_iff₀ hpwpos]
    have k2 : ((P.TN : ℝ) * S * P.WS / P.TD + e / T2) * (K : ℝ) ^ q'.length =
        (((P.TN * S * P.WS * T2 + e * P.TD) * pw K q'.length : ℤ) : ℝ) / ((K * P.TD * T2 : ℤ) : ℝ) * K := by
      push_cast; rw [pw_eq]; push_cast; field_simp
    rw [k2]
    exact mul_le_mul_of_nonneg_right hRlow hK.le
  have hj := hts.2 d hd t ht
  rw [hy] at hj
  rw [hq'v] at hmain
  rw [div_le_iff₀ hTDr]
  have k3 : ((P.w1N : ℝ) / P.WS + jsum P.Ws d t / P.WS) * P.TD = (P.w1N + jsum P.Ws d t) * P.TD / P.WS := by ring
  rw [k3, le_div_iff₀ hWSr]
  have k4 : (ev q (u / K) - e / T2) / S ≤ jsum P.Ws d t := hj
  have k5 : (P.TN : ℝ) * S * P.WS / P.TD - P.w1N * S ≤ ev q (u / K) - e / T2 := by linarith
  have k6 : ((P.TN : ℝ) * S * P.WS / P.TD - P.w1N * S) / S ≤ jsum P.Ws d t :=
    le_trans (div_le_div_of_nonneg_right k5 hS.le) k4
  have k7 : ((P.TN : ℝ) * S * P.WS / P.TD - P.w1N * S) / S = P.TN * P.WS / P.TD - P.w1N := by
    field_simp
  rw [k7] at k6
  have k8 : (P.TN : ℝ) * P.WS / P.TD * P.TD = P.TN * P.WS := by field_simp
  nlinarith

/-! ### Packed states, the chain, the tail -/

theorem allOk_append (P : Params) (l₁ l₂ : List CellSpec) : AllOk P (l₁ ++ l₂) ↔ AllOk P l₁ ∧ AllOk P l₂ := by
  induction l₁ with
  | nil => simp [AllOk]
  | cons c l ih => simp only [List.cons_append, AllOk, ih, and_assoc]

/-- **The chain is sound**: linked accepted cells carry valid states from the start to the end, and bound
`w₁ + Σ Wₖ J₀(t dₖ)` on `[start, end)`. -/
theorem chain_sound (P : Params) : ∀ (cs : List CellSpec) (t : ℤ) (e : ℕ), AllOk P cs → Linked t e cs = true →
    StatesValid P.Ds (decode P e) (t / T2) →
    StatesValid P.Ds (decode P (chainExit e cs)) (chainEnd t cs / T2) ∧
      ∀ d : List ℝ, Close P.Ds d → ∀ t' ∈ Ico ((t : ℝ) / T2) (chainEnd t cs / T2),
        (P.TN : ℝ) / P.TD ≤ P.w1N / P.WS + jsum P.Ws d t' / P.WS
  | [], t, e, _, _, hv => by
    refine ⟨by simpa [chainExit, chainEnd] using hv, fun d _ t' ht' => ?_⟩
    simp only [chainEnd, mem_Ico] at ht'
    exact absurd ht'.2 (not_lt.2 ht'.1)
  | c :: cs, t, e, hall, hlink, hv => by
    simp only [Linked, Bool.and_eq_true, decide_eq_true_eq] at hlink
    obtain ⟨⟨ht, he⟩, hrest⟩ := hlink
    obtain ⟨hc, hcs⟩ := hall
    subst ht
    subst he
    have h1 := cellCheck_sound hc hv
    have h2 := chain_sound P cs (c.t0 + c.w) c.exit hcs hrest (by push_cast; exact h1.1)
    refine ⟨by simpa [chainExit, chainEnd] using h2.1, fun d hd t' ht' => ?_⟩
    simp only [chainEnd, mem_Ico] at ht'
    by_cases hle : t' ≤ ((c.t0 : ℝ) + c.w) / T2
    · exact h1.2 d hd t' ⟨ht'.1, hle⟩
    · exact h2.2 d hd t' ⟨by push_cast; linarith, ht'.2⟩

/-- Past the chain's end, `|J₀(t x)| ≤ (u + r + E)/S`: `‖J‖` is antitone, the state is within `r/S` of `J` at the end,
and `|x − D/S| ≤ 1/S` costs at most `E/S` where `t x` falls short of the end. -/
theorem abs_J0_tail {D : ℤ} {st : St} {u : ℕ} {E T x t : ℝ} (hD : 0 ≤ D)
    (hu : st.m0 * st.m0 + st.m1 * st.m1 ≤ (u : ℤ) * u) (hT : 0 ≤ T) (hE : T ≤ E) (hv : st.Valid (T * (D / S)))
    (hx : |x - D / S| ≤ 1 / S) (hx0 : 0 ≤ x) (ht : T ≤ t) :
    |J0 (t * x)| ≤ ((u : ℝ) + st.r + E) / S := by
  have hS := S_pos
  have hDr : (0 : ℝ) ≤ D := by exact_mod_cast hD
  set xe := T * (D / S) with hxe
  have hxe0 : 0 ≤ xe := by positivity
  set z : ℂ := ⟨(st.m0 : ℝ) / S, (st.m1 : ℝ) / S⟩
  have hv' : ‖Jc xe - z‖ ≤ (st.r : ℝ) / S := (valid_iff st xe).1 hv
  have hz : ‖z‖ ≤ (u : ℝ) / S := by
    have h2 : ‖z‖ ^ 2 ≤ ((u : ℝ) / S) ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_mk, div_pow]
      have : ((st.m0 : ℝ) * st.m0 + st.m1 * st.m1) ≤ (u : ℝ) * u := by exact_mod_cast hu
      rw [le_div_iff₀ (by positivity)]
      field_simp
      nlinarith
    nlinarith [norm_nonneg z, show (0 : ℝ) ≤ (u : ℝ) / S by positivity]
  have hE0 : 0 ≤ E := hT.trans hE
  have hJe : |J0 xe| ≤ (u : ℝ) / S + st.r / S := (abs_J0_le_of_le hxe0 le_rfl z).trans (add_le_add hz hv')
  by_cases hcase : xe ≤ t * x
  · have h1 := (abs_J0_le_of_le hxe0 hcase z).trans (add_le_add hz hv')
    have h2 : 0 ≤ E / S := div_nonneg hE0 hS.le
    have h3 : ((u : ℝ) + st.r + E) / S = (u : ℝ) / S + st.r / S + E / S := by ring
    rw [h3]; linarith
  · push Not at hcase
    have hL := abs_J0_sub_le (t * x) xe
    have h1 : T * x ≤ t * x := mul_le_mul_of_nonneg_right ht hx0
    have h2 : D / S - x ≤ 1 / S := by linarith [neg_abs_le (x - D / S)]
    have h3 : xe - t * x ≤ E / S := by
      have : T * (D / S - x) ≤ T * (1 / S) := mul_le_mul_of_nonneg_left h2 hT
      have : T * (1 / S) ≤ E / S := by rw [mul_one_div]; exact div_le_div_of_nonneg_right hE hS.le
      rw [hxe]; nlinarith
    have h4 : |t * x - xe| ≤ E / S := by rw [abs_sub_comm, abs_of_pos (by linarith)]; exact h3
    have h5 : |J0 (t * x)| ≤ |J0 xe| + |t * x - xe| := by
      have := abs_sub_abs_le_abs_sub (J0 (t * x)) (J0 xe)
      linarith
    calc |J0 (t * x)| ≤ (u : ℝ) / S + st.r / S + E / S := by linarith
      _ = ((u : ℝ) + st.r + E) / S := by ring

theorem tailSum_sound {E : ℤ} {T : ℝ} (hT : 0 ≤ T) (hE : T ≤ E) : ∀ (Ws Ds : List ℤ) (sts : List St) (us : List ℕ)
    (s : ℤ), tailSum E Ws Ds sts us = (true, s) → StatesValid Ds sts T →
      ∀ d : List ℝ, Close Ds d → ∀ t : ℝ, T ≤ t → -(s : ℝ) / S ≤ jsum Ws d t
  | [], Ds, sts, us, s, h, _ => by
    rcases Ds with _ | ⟨D, Ds⟩ <;> rcases sts with _ | ⟨st, sts⟩ <;> rcases us with _ | ⟨u, us⟩ <;>
      simp [tailSum] at h
    subst h
    intro d hd t _
    cases hd
    simp [jsum]
  | W :: Ws, Ds, sts, us, s, h, hv => by
    rcases Ds with _ | ⟨D, Ds⟩ <;> rcases sts with _ | ⟨st, sts⟩ <;> rcases us with _ | ⟨u, us⟩ <;>
      simp only [tailSum, Prod.mk.injEq, Bool.false_eq_true, false_and] at h
    simp only [Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨⟨⟨hrok, hD⟩, hu⟩, hs⟩ := h
    have hrest : tailSum E Ws Ds sts us = (true, (tailSum E Ws Ds sts us).2) := by rw [← hrok]
    obtain ⟨hv1, hvs⟩ := List.forall₂_cons.1 hv
    have ih := tailSum_sound hT hE Ws Ds sts us _ hrest hvs
    intro d hd t ht
    rcases d with _ | ⟨x, d⟩
    · cases hd
    obtain ⟨hx, hds⟩ := List.forall₂_cons.1 hd
    have hJ := abs_J0_tail hD hu hT hE hv1 hx.1 hx.2 ht
    have h2 := ih d hds t ht
    have hS := S_pos
    have hW : ((W.natAbs : ℕ) : ℝ) = |(W : ℝ)| := by rw [Nat.cast_natAbs, Int.cast_abs]
    have k1 : |(W : ℝ) * J0 (t * x)| ≤ |(W : ℝ)| * (((u : ℝ) + st.r + E) / S) := by
      rw [abs_mul]; exact mul_le_mul_of_nonneg_left hJ (abs_nonneg _)
    have k2 := neg_abs_le ((W : ℝ) * J0 (t * x))
    rw [← hs]
    simp only [jsum]
    push_cast
    have k3 : -(|(W : ℝ)| * ((u : ℝ) + st.r + E) + (tailSum E Ws Ds sts us).2) / S =
        -(|(W : ℝ)| * (((u : ℝ) + st.r + E) / S)) + -((tailSum E Ws Ds sts us).2 : ℝ) / S := by ring
    rw [k3]
    linarith

/-- **The tail is sound**: past `tEnd`, states valid at `tEnd` and an accepted tail check bound
`w₁ + Σ Wₖ J₀(t dₖ) ≥ TN/TD`. -/
theorem tailCheck_sound {P : Params} {tEnd : ℤ} {sts : List St} {us : List ℕ} (h : tailCheck P tEnd sts us = true)
    (hv : StatesValid P.Ds sts (tEnd / T2)) : ∀ d : List ℝ, Close P.Ds d → ∀ t : ℝ, (tEnd : ℝ) / T2 ≤ t →
      (P.TN : ℝ) / P.TD ≤ P.w1N / P.WS + jsum P.Ws d t / P.WS := by
  rcases hr : tailSum (cdiv tEnd T2) P.Ws P.Ds sts us with ⟨ok, s⟩
  simp only [tailCheck, hr, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨⟨hok, hT⟩, hTD⟩, hWS⟩, hfin⟩ := h
  subst hok
  have hT2 := T2_pos
  have hS := S_pos
  have hTr : (0 : ℝ) ≤ tEnd / T2 := div_nonneg (by exact_mod_cast hT) hT2.le
  have hE := le_cdiv (num := tEnd) (den := T2) (by norm_num [T2])
  intro d hd t ht
  have hj := tailSum_sound hTr hE P.Ws P.Ds sts us s hr hv d hd t ht
  have hTDr : (0 : ℝ) < P.TD := by exact_mod_cast hTD
  have hWSr : (0 : ℝ) < P.WS := by exact_mod_cast hWS
  have hf : (P.TN : ℝ) * P.WS * S ≤ P.TD * (P.w1N * S - s) := by exact_mod_cast hfin
  rw [div_le_iff₀ hTDr]
  have k3 : ((P.w1N : ℝ) / P.WS + jsum P.Ws d t / P.WS) * P.TD = (P.w1N + jsum P.Ws d t) * P.TD / P.WS := by ring
  rw [k3, le_div_iff₀ hWSr]
  have k4 : (P.w1N : ℝ) - s / S ≤ P.w1N + jsum P.Ws d t := by rw [neg_div] at hj; linarith
  have k5 : (P.TN : ℝ) * P.WS ≤ P.TD * (P.w1N - s / S) := by
    have : (P.TD : ℝ) * (P.w1N - s / S) = P.TD * (P.w1N * S - s) / S := by field_simp
    rw [this, le_div_iff₀ hS]; linarith
  nlinarith

theorem statesValid_init (Ds : List ℤ) : StatesValid Ds (initStates Ds.length) 0 := by
  induction Ds with
  | nil => exact List.Forall₂.nil
  | cons D Ds ih =>
    refine List.Forall₂.cons ?_ ih
    rw [valid_iff]
    have hS := S_pos
    have hJ : Jc (0 * ((D : ℝ) / S)) = ⟨(S : ℝ) / S, ((0 : ℤ) : ℝ) / S⟩ := by
      rw [zero_mul]; apply Complex.ext <;> simp [Jc, J0_zero, J1_zero, hS.ne']
    simp only [hJ, sub_self, norm_zero]
    simp

/-- **The covering is sound**: an accepted chain from the initial states at `t = 0` and an accepted tail at its end give
`w₁ + Σₖ Wₖ J₀(t dₖ) ≥ TN/TD` (at their scales) for every `t ≥ 0` and all distances within `2⁻⁶⁴` of the `Dₖ`. -/
theorem covering_sound (P : Params) (cs : List CellSpec) (e0 : ℕ) (us : List ℕ) (hall : AllOk P cs)
    (hlink : Linked 0 e0 cs = true) (hinit : decode P e0 = initStates P.Ds.length)
    (htail : tailCheck P (chainEnd 0 cs) (decode P (chainExit e0 cs)) us = true) :
    ∀ d : List ℝ, Close P.Ds d → ∀ t : ℝ, 0 ≤ t → (P.TN : ℝ) / P.TD ≤ P.w1N / P.WS + jsum P.Ws d t / P.WS := by
  have h0 : StatesValid P.Ds (decode P e0) ((0 : ℤ) / T2) := by
    rw [hinit]; simpa using statesValid_init P.Ds
  have hc := chain_sound P cs 0 e0 hall hlink h0
  intro d hd t ht
  by_cases hlt : t < (chainEnd 0 cs : ℝ) / T2
  · exact hc.2 d hd t ⟨by simpa using ht, hlt⟩
  · exact tailCheck_sound htail hc.1 d hd t (not_lt.1 hlt)

end BesselCert
end HadwigerNelson.DensityBound
