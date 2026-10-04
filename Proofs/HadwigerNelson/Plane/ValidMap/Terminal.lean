import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.Contact
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps

/-!
# The terminal modification `M*` and the stuck chains' ends (FS112-N2-TERM, -C-ENDS, -C-DOUBLE, FS114-CV-HD)

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3), over the foundation `Plane/ValidMap/Chain`. Frames as in wave 4: at a vertex
`v` with axis `e α`, `n = e (α + π/2)`, `N = v + n`, `S = v − n`; a horn along `e (α + π)` has `n` reversed in its own frame, so its
arc on the `N` side is its *lower* arc (curvature `−1` there means "on `ω(N)`"). Rows:

* **FS112-N2-TERM** (`exists_terminal`), with **FS112-N2-RED** merged as its lemma (`exists_red`);
* **FLANK-Q unconditional** (wave 4's obligation, inventory item 79): `flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly`;
* **FS114-CV-HD** (`cv_hd_main`, `cv_hd`, `cv_class`, `cv_l0`; CV-ENDS is `c_ends`);
* **FS112-C-ENDS** in its erratum's form (`c_ends`), **FS112-C-DOUBLE** (`c_double`);
* supporting lemmas: the unit-arc stuck structure (`stuck_structure_ua`, FS112-WALK's row 5 — not a backlog row), the corrected
  **FS112-Y3-END-NEEDS** (`y3_end_needs`, inventory item 69), and **FS112-N3-END's chain clause** (`n3_end_chain`, item 74);
* the inhabitant of `IsTerminalMap` at seven colours (`sevenBrickMap_isTerminalMap`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- `z` lies on a (Q) or an (R2) arc of some unit circle. -/
def OnQR2Arc (z : ℂ) : Prop :=
  ∃ P θ₁ θ₂, (F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂) ∧ z ∈ ringArc P θ₁ θ₂

/-- A horn bound of exactly `±1` at `w` along `e β` sits on a (Q) or (R2) arc: an upper arc on `ω(w + e(β + π/2))` is the start (at
`w`, angle `β − π/2`) of a (Q) or (R2) arc of that circle on the `+e β` side, and a lower arc on `ω(w − e(β + π/2))` likewise
(FLANK-Q's form). -/
def HornBoundsQR (w : ℂ) (β : ℝ) : Prop :=
  (∀ κ₁ d, F.IsHorn w β κ₁ 1 d → ∃ θ₂, β - π / 2 < θ₂ ∧
      (F.IsQArc (w + e (β + π / 2)) (β - π / 2) θ₂ ∨ F.IsR2Arc (w + e (β + π / 2)) (β - π / 2) θ₂)) ∧
    ∀ κ₂ d, F.IsHorn w β (-1) κ₂ d → ∃ θ₁, θ₁ < β + π / 2 ∧
      (F.IsQArc (w - e (β + π / 2)) θ₁ (β + π / 2) ∨ F.IsR2Arc (w - e (β + π / 2)) θ₁ (β + π / 2))

end ArcMap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The unit-arc stuck structure (supporting lemma: FS112-WALK's row 5, N4-STUCK (i)–(ii) with unit arcs) -/

/-- **N4-STUCK (i)–(ii) with unit arcs** (FS112-WALK, row 5; used by FS114-CV's and CVB's arguments as "N4-STUCK's structure (i)–(ii) …
in `[−1, 1]`", `plans/FS114-CVB-verification.md` § 1.3). Not a backlog row (FS112-WALK is declined, a verdict table): a supporting lemma
of wave 5. At a stuck vertex `v` of a valid map with at most three colours there, the colour `c` with two or more sectors has exactly two,
cusp horns along `±e α` with bounding curvatures in `[−1, 1]`, out-type `c`-contacts at `v ± n`; `P_cl(v) = {c, g, h}` with degree `4`,
the interior points near `v` above the axis of colour `g` or `c` and below it of colour `h` or `c`, `g` the upper flank and `h` the lower
flank of both horns. Inhabitant of the hypotheses: `bowtie` at `0` (`bowtie_isStuck`, `bowtie_coloursAt_zero`). -/
theorem stuck_structure_ua (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard ≤ 3) {c : Fin k} {m : ℕ} (hm : 2 ≤ m) (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, ∃ g h : Fin k,
      F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 ≤ κ₁ ∧ κ₂ ≤ 1 ∧ -1 ≤ κ₃ ∧ κ₄ ≤ 1 ∧
      F.HasSectors v c 2 ∧ F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ F.IsFlankAbove v (α + π) κ₄ h ∧ F.IsFlankBelow v (α + π) κ₃ g ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (0 < frameY v α z → F.col z = g ∨ F.col z = c) ∧ (frameY v α z < 0 → F.col z = h ∨ F.col z = c)) ∧
      (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  sorry

/-! ## FS112-N2-TERM, with FS112-N2-RED as its lemma -/

/-- **FS112-N2-RED** (merged into FS112-N2-TERM as its lemma, SR2 item 13): every valid map of the plane has a valid modification —
the same domain, no unit arc created, every point of at least four colours carrying those colours in the map itself — in which every
unit arc is (Q) or (R2). "By W-MERGE and whole-arc bends" and "the procedure terminates with no stubs" are the proof's content (the
modification is the limit of the procedure). Inhabitant of the hypotheses: `sevenBrickMap` at seven colours (no unit arc: itself). -/
theorem exists_red (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap k, F.IsModification M ∧ M.Valid ∧ M.QROnly := by
  sorry

/-- **FS112-N2-TERM**: every valid six-coloured map of the plane has a valid modification `M*` (the same domain, no unit arc created,
four-colour points' colours kept) which is a terminal valid map (`IsTerminalMap`: no MERGE, MERGE-RAY or SHAVE anywhere, every unit
arc (Q) or (R2)), in which (clause 2) every vertex — a point of at least three colours or with a repeated colour — is cubic
trichromatic, carries at least four colours (an NB4P exception), or is stuck; and (clause 3) every vertex stuck along `e α` lies on a
stuck run that is not bi-infinite, each finite end (the last chain vertex) within distance `1` of a point of a (Q) or (R2) arc or of a
point of at least four colours, and every horn bound `±1` at a vertex of the run, along `±e α`, a (Q) or (R2) arc. "One-sided infinite
chains are a GAP" is a not-claimed clause: nothing is stated about them. Inhabitant of the hypotheses: none at six colours is known
(a valid six-map of the plane is FS-114's open question); the statement's class at seven colours is inhabited by `sevenBrickMap`. -/
theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap 6, F.IsModification M ∧ M.IsTerminalMap ∧
      (∀ x ∈ M.dom, 3 ≤ (M.coloursAt x).ncard ∨ M.HasRepeatedColour x →
        M.IsCubicTrichromatic x ∨ 4 ≤ (M.coloursAt x).ncard ∨ M.IsStuck x) ∧
      ∀ v α, M.StuckAlong v α → (M.coloursAt v).ncard ≤ 3 →
        M.stuckRun v α ≠ univ ∧
        (∀ j ∈ M.stuckRun v α, (j + 1 ∉ M.stuckRun v α ∨ j - 1 ∉ M.stuckRun v α) →
          ∃ z, dist z (v + (j : ℂ) * e (α + π / 2)) ≤ 1 ∧ (M.OnQR2Arc z ∨ 4 ≤ (M.coloursAt z).ncard)) ∧
        ∀ j ∈ M.stuckRun v α, M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) α ∧
          M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) (α + π) := by
  sorry

/-! ## FLANK-Q unconditional (wave 4's obligation, inventory item 79) -/

/-- **FS112-N2-FLANK-Q, the upper bound, unconditional** in any map whose unit arcs are all (Q) or (R2) (`QROnly`, N2-TERM's clause 1,
so in every `M*`): wave 4's `flankQ_upper` with its named hypothesis `hQR` discharged. Inhabitant of the local hypotheses: `bowtie` at
`0` (its arcs at `i` are (Q)); `QROnly` on the whole map is inhabited by the one-colour plane (`const_qrOnly`). -/
theorem flankQ_upper_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c ∧
      ((F.IsQArc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧
          ∃ T, F.TileOf g T ∧ T ⊆ ball v 1 ∧ v + e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧ g ∉ F.coloursAt (v + e (α + π / 2)) ∧
          v - e (α + π / 2) ∈ closure (F.region g) ∧ F.OutType v g (v - e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g))) :=
  flankQ_upper hF hv hH hg hcN fun _ _ _ _ h => hQR _ _ _ _ _ h

/-- **FS112-N2-FLANK-Q, the lower bound, unconditional** (the mirror; `flankQ_lower` with `hQR` discharged by `QROnly`). -/
theorem flankQ_lower_of_qrOnly (hF : F.Valid) (hQR : F.QROnly) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h)
    (hcS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c ∧
      ((F.IsQArc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧
          ∃ T, F.TileOf h T ∧ T ⊆ ball v 1 ∧ v - e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧ h ∉ F.coloursAt (v - e (α + π / 2)) ∧
          v + e (α + π / 2) ∈ closure (F.region h) ∧ F.OutType v h (v + e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h))) :=
  flankQ_lower hF hv hH hh hcS fun _ _ _ _ h => hQR _ _ _ _ _ h

/-! ## FS114-CV-HD: CV-L0, the main clause, the equivalences, CV-CLASS -/

/-- **FS114-CV-HD, (CV-L0)**: in a terminal valid map a stuck vertex with at most three colours centres no unit arc, so `Γ ∩ ω(E)` is
finite. No model of a stuck vertex in a terminal valid plane map is known (`GENERIC`: FS-115's question); `bowtie` inhabits the local
hypotheses on a fragment. -/
theorem cv_l0 (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard ≤ 3) :
    (∀ x, ¬ F.OnRingArc E x) ∧ (F.Γ ∩ sphere E 1).Finite := by
  sorry

/-- **FS114-CV-HD, the main clause**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours whose two-sector
colour `c` has horns along `±e α`, both upper bounds `1` (the `+e α` horn's upper arc and the `−e α` horn's arc on the `N` side on
`ω(N)`: `κ₂ = 1`, `κ₃ = −1`) and no in-type lower-flank tile at `E − n` is impossible. A step inside a proof by contradiction where no
model is expected (`cv_hd`'s cycle consumes it). -/
theorem cv_hd_main {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {h : Fin 6} (hh : F.IsFlankBelow E α κ₁ h)
    (hυ : κ₂ = 1 ∧ κ₃ = -1)
    (hnoHS : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  sorry

/-- **FS114-CV-HD, the equivalences**: in a terminal valid six-coloured map, at a stuck vertex `E` with three colours (horns of `c` along
`±e α`, upper flank `g`, lower flank `h`), the four conditions are equivalent — `G_N` (an in-type `g`-contact at `N`), `H_S` (an in-type
`h`-contact at `S`), `υ± = 1` (`κ₂ = 1 ∧ κ₃ = −1`: both horns' `N`-side arcs on `ω(N)`) and `λ± = −1` (`κ₁ = −1 ∧ κ₄ = 1`: both `S`-side
arcs on `ω(S)`). Model of the local hypotheses with all four conditions: `bowtie` at `0` (a fragment; `GENERIC` on terminal plane maps). -/
theorem cv_hd {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    ((F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ↔
        (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) ∧
      ((F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ↔ (κ₂ = 1 ∧ κ₃ = -1)) ∧
      ((κ₂ = 1 ∧ κ₃ = -1) ↔ (κ₁ = -1 ∧ κ₄ = 1)) := by
  sorry

/-- **FS114-CV-HD, (CV-CLASS)**: a stuck vertex of a terminal valid six-coloured map (three colours, horns of `c` along `±e α`, upper
flank `g`, lower flank `h`) is a bowtie — all four horn arcs unit arcs, both neighbours carrying at least four colours and centring
both-kind arcs, a one-vertex chain — or carries `g` twice at `E − n` and `h` twice at `E + n`, each neighbour stuck or with at least four
colours. Model of the local hypotheses (the bowtie case): `bowtie` at `0`. -/
theorem cv_class {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₂ κ₃ κ₄ : ℝ} (hH : F.IsHorn E α κ₁ κ₂ c)
    (hH' : F.IsHorn E (α + π) κ₃ κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α κ₂ g) (hh : F.IsFlankBelow E α κ₁ h) :
    (κ₂ = 1 ∧ κ₃ = -1 ∧ κ₁ = -1 ∧ κ₄ = 1 ∧
        4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
        (∃ θ₁ θ₂, F.BothKind (E + e (α + π / 2)) θ₁ θ₂) ∧ (∃ θ₁ θ₂, F.BothKind (E - e (α + π / 2)) θ₁ θ₂) ∧
        F.stuckRun E α = {0}) ∨
      ((∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E - e (α + π / 2)) r g).encard) ∧
        (∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (E + e (α + π / 2)) r h).encard) ∧
        (F.IsStuck (E + e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard) ∧
        (F.IsStuck (E - e (α + π / 2)) ∨ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard)) := by
  sorry

/-! ## FS112-Y3-END-NEEDS (corrected), FS112-C-ENDS, FS112-C-DOUBLE, FS112-N3-END's chain clause -/

/-- **FS112-Y3-END-NEEDS, corrected** (`plans/FS112-YB3-verification.md` § 3.1, YB3-NEEDS; the form FS114-CVB's `¬G_N` branch reads,
`plans/FS114-CVB-verification.md` § 1.6): in a terminal valid six-coloured map of the plane, a stuck vertex `E` with three colours whose
horns' `N`-side arcs both lie on `ω(N)` (`κ₂ = 1`, `κ₃ = −1`), with no in-type upper-flank contact at `N` and no in-type lower-flank
contact at `S` (so `λ_E > −1` on the in-type side: YB3's correction, the bowtie excluded), is impossible — its levels need a seventh
colour. Inventory item 69's supporting lemma (not a backlog row). A step inside a proof by contradiction: no model expected. -/
theorem y3_end_needs {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
    (h3 : (F.coloursAt E).ncard = 3) {c : Fin 6} (hc2 : F.HasSectors E c 2) {α κ₁ κ₄ : ℝ}
    (hH : F.IsHorn E α κ₁ 1 c) (hH' : F.IsHorn E (α + π) (-1) κ₄ c) {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g)
    (hh : F.IsFlankBelow E α κ₁ h)
    (hnoG : ¬ (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))))
    (hnoH : ¬ (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2)))) : False := by
  sorry

/-- **FS112-C-ENDS** in its erratum's form (caution C116; `plans/FS112-derivation.md:443` item 2) — FS114-CV-HD's (CV-ENDS): in a
terminal valid six-coloured map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours.
The chain is the stuck run through a vertex stuck along `e α`; its upper end is a member `j` with `j + 1` outside, its lower end a member
with `j − 1` outside. No model of a stuck chain in a terminal valid plane map is known (`GENERIC`, FS-115). -/
theorem c_ends {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α) {j : ℤ}
    (hj : j ∈ F.stuckRun v α) :
    (j + 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j + 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) ∧
      (j - 1 ∉ F.stuckRun v α → 4 ≤ (F.coloursAt (v + ((j - 1 : ℤ) : ℂ) * e (α + π / 2))).ncard) := by
  sorry

/-- **FS112-C-DOUBLE** (caution C116: a regrade only): in a terminal valid six-coloured map (`IsTerminalMap` — the reading of "terminal
valid map" settled here, § 2.2 of the plan: wave 4's `Terminal` and N2-TERM's clause 1), a stuck vertex `E` with three colours all
four of whose horn arcs are unit arcs (the `+e α` horn between `ω(S)` and `ω(N)`, curvatures `−1` and `1`, and the `−e α` horn likewise
in its own frame) carries an in-type tile of its upper flank colour `g` at `N` and of its lower flank colour `h` at `S`, and both `N`
and `S` carry at least four colours and centre (Q) arcs — the four horn-bounding arcs. Model of the local hypotheses: `bowtie` at `0`
(a fragment; on terminal plane maps `GENERIC`, FS-115). -/
theorem c_double {F : ArcMap 6} (hM : F.IsTerminalMap) {E : ℂ} (hst : F.IsStuck E) (h3 : (F.coloursAt E).ncard = 3)
    {c : Fin 6} (hc2 : F.HasSectors E c 2) {α : ℝ} (hH : F.IsHorn E α (-1) 1 c) (hH' : F.IsHorn E (α + π) (-1) 1 c)
    {g h : Fin 6} (hg : F.IsFlankAbove E α 1 g) (hh : F.IsFlankBelow E α (-1) h) :
    (F.IsContact E g (E + e (α + π / 2)) ∧ F.InType E g (E + e (α + π / 2))) ∧
      (F.IsContact E h (E - e (α + π / 2)) ∧ F.InType E h (E - e (α + π / 2))) ∧
      4 ≤ (F.coloursAt (E + e (α + π / 2))).ncard ∧ 4 ≤ (F.coloursAt (E - e (α + π / 2))).ncard ∧
      (∃ θ₂, α - π / 2 < θ₂ ∧ F.IsQArc (E + e (α + π / 2)) (α - π / 2) θ₂) ∧
      (∃ θ₁, θ₁ < α - π / 2 ∧ F.IsQArc (E + e (α + π / 2)) θ₁ (α - π / 2)) ∧
      (∃ θ₁, θ₁ < α + π / 2 ∧ F.IsQArc (E - e (α + π / 2)) θ₁ (α + π / 2)) ∧
      (∃ θ₂, α + π / 2 < θ₂ ∧ F.IsQArc (E - e (α + π / 2)) (α + π / 2) θ₂) := by
  sorry

/-- **FS112-N3-END's chain clause** ("and the chain is the single vertex", inventory item 74; wave 4's `n3_end` states the rest): in
n3_end's setting (a terminal valid plane map, `v` stuck with three colours, `c`'s horn along `e α` with lower bound `−1`), in its second
disjunct — the upper flank `g` in-type at `N` and `κ₂ = 1` — the stuck run through `v` is `{0}`: neither neighbour is a chain vertex.
Model of the local hypotheses: `bowtie` at `0` (`bowtie_isStuck`: `E` stuck, `±i` not). -/
theorem n3_end_chain (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α : ℝ} {c g : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) 1 c)
    (hg : F.IsFlankAbove v α 1 g) (hgN : F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2))) :
    F.stuckRun v α = {0} := by
  sorry

end ArcMap

/-! ## The inhabitant of `IsTerminalMap` -/

/-- **The inhabitant of `IsTerminalMap`** (every clause at once, at seven colours, where no theorem of this module refutes it):
the seven-brick map is valid, of the plane, has no horn and no point of a repeated colour (so no move is available anywhere: `Terminal`),
and no arc of `Γ` on any unit circle (so `QROnly` holds vacuously in its arcs' sense — every constant-sided unit arc, of which there are
none, is (Q) or (R2)). -/
theorem sevenBrickMap_isTerminalMap : sevenBrickMap.IsTerminalMap := by
  sorry

end HadwigerNelson.Plane
