/-!
# The `J₀` covering's checker: the computations the kernel runs (FS-131, FS131-IDB1)

Every definition here is integer and list arithmetic in Lean's core, with no import: the generated cell modules
`Plane/DensityBound/Cells/*` read only this module and their data, so their `decide +kernel` checks neither load Mathlib nor
depend on the proofs of the Bessel lemmas (an edit there does not invalidate the 46 parts' 41 minutes of kernel time).
What the computations mean, and that an accepted one implies the bound, is `Plane/DensityBound/BesselCert`
(`covering_sound`); the Taylor recurrence `taylor` and the rounding `rnd`, `termNext` are untrusted — no proof reads them.

Scales: a state's coordinates and the distances at `S = 2⁶⁴`, the `t`-grid at `T2 = 2²⁰`, a cell's left end in `x` at
`SC = 2⁸⁴`, the cell variable at `K = 2⁸⁵`. Record: `plans/FS131-IDB1-implementation.md`.
-/

namespace HadwigerNelson.DensityBound
namespace BesselCert

/-- `S = 2⁶⁴`: the scale of a state's coordinates and of the distances. -/
def S : Int := 18446744073709551616

/-- `T2 = 2²⁰`: the scale of the `t`-grid. -/
def T2 : Int := 1048576

/-- `SC = T2·S = 2⁸⁴`: the scale of a cell's left end `t₀·D` in `x`. -/
def SC : Int := 19342813113834066795298816

/-- `K = 2·T2·S = 2⁸⁵`: the scale of the cell variable `u = 2·T2·τ` against `y = τ/S`. -/
def K : Int := 38685626227668133590597632

/-- Horner evaluation at an integer: the kernel's. -/
def evZ : List Int → Int → Int
  | [], _ => 0
  | a :: l, x => a + x * evZ l x

/-- `pw b n = bⁿ` by recursion (the kernel's: `^` on `Int` elaborates through `Monoid.npow` under Mathlib). -/
def pw (b : Int) : Nat → Int
  | 0 => 1
  | n + 1 => pw b n * b

/-- Coefficientwise sum. -/
def addL : List Int → List Int → List Int
  | [], m => m
  | a :: l, [] => a :: l
  | a :: l, b :: m => (a + b) :: addL l m

/-- Multiplication by a constant. -/
def smulL (c : Int) : List Int → List Int
  | [] => []
  | a :: l => (c * a) :: smulL c l

/-- Absolute values of the coefficients. -/
def absL : List Int → List Int
  | [] => []
  | a :: l => (a.natAbs : Int) :: absL l

/-- `derivAux k [l₀, l₁, …] = [k l₀, (k + 1) l₁, …]`. -/
def derivAux : Int → List Int → List Int
  | _, [] => []
  | k, a :: l => (k * a) :: derivAux (k + 1) l

/-- The derivative's coefficients: `dL [l₀, l₁, l₂, …] = [l₁, 2 l₂, …]`. -/
def dL (l : List Int) : List Int := derivAux 1 l.tail

/-- `affX w a L` holds the coefficients of `a + (w + v)·L(v)`. -/
def affX (w : Int) : Int → List Int → List Int
  | a, [] => [a]
  | a, c :: L => (a + w * c) :: affX w c L

/-- The Taylor shift: `shiftL w l` holds the coefficients of `v ↦ l(w + v)`. -/
def shiftL (w : Int) : List Int → List Int
  | [] => []
  | a :: l => affX w a (shiftL w l)

/-- `powScale D p [l₀, l₁, …] = [p l₀, p D l₁, p D² l₂, …]`. -/
def powScale (D : Int) : Int → List Int → List Int
  | _, [] => []
  | p, a :: l => (a * p) :: powScale D (p * D) l

/-- `homogL K l = [lₙ K^(L−1−n)]` (`L` the length): `ev (homogL K l) u · K = K^L · ev l (u/K)`. -/
def homogL (K : Int) : List Int → List Int
  | [] => []
  | a :: l => (a * pw K l.length) :: homogL K l

/-- `Wh hn hd l = Σₙ lₙ hnⁿ hd^(L−n)` (`L` the length), so `Wh/hd^L = ev l (hn/hd)`. -/
def Wh (hn hd : Int) : List Int → Int
  | [] => 0
  | a :: l => a * pw hd (l.length + 1) + hn * Wh hn hd l

/-- `Wh` forward, with accumulators: what the kernel runs. -/
def evF (hn hd : Int) : Int → Int → Int → List Int → Int × Int
  | v, _, q, [] => (v, q)
  | v, p, q, a :: l => evF hn hd ((v + a * p) * hd) (p * hn) (q * hd) l

/-- `⌈num/den⌉` for `den > 0`. -/
def cdiv (num den : Int) : Int := -((-num) / den)

/-- Rounding to nearest, for the generator's states (not read by any proof). -/
def rnd (num den : Int) : Int := (2 * num + den) / (2 * den)

/-- The Taylor coefficients `a_{n+1}, b_{n+1}` of the Bessel system at `x = C/SC` from `(a_{n−1}, a_n, b_n)`:
`(n+1) a_{n+1} = −b_n`, `c (n+1) b_{n+1} = c a_n + a_{n−1} − (n+1) b_n` (`c > 0`), `b_{n+1} = a_n/(n+2)` (`c = 0`), rounded.
Any lists would serve the soundness proof; these make the defect small. -/
def taylorAux (C : Int) : Nat → Nat → Int → Int → Int → List Int × List Int
  | 0, _, _, _, _ => ([], [])
  | fuel + 1, n, am1, an, bn =>
    let an1 := -(rnd bn ((n : Int) + 1))
    let bn1 := if C = 0 then rnd an ((n : Int) + 2)
      else rnd (C * an + SC * (am1 - ((n : Int) + 1) * bn)) (C * ((n : Int) + 1))
    match taylorAux C fuel (n + 1) an an1 bn1 with
    | (la, lb) => (an1 :: la, bn1 :: lb)

/-- `N` further coefficients of `a` and of `b` from `a₀ = m0`, `b₀ = m1` at `x = C/SC`. -/
def taylor (C : Int) (N : Nat) (m0 m1 : Int) : List Int × List Int := taylorAux C N 0 0 m0 m1

/-- A state of one term's chain: `‖J(x) − (m0 + i m1)/2⁶⁴‖ ≤ r/2⁶⁴` (`St.Valid`). -/
structure St where
  /-- `2⁶⁴ ·` the real part. -/
  m0 : Int
  /-- `2⁶⁴ ·` the imaginary part. -/
  m1 : Int
  /-- `2⁶⁴ ·` the radius. -/
  r : Int
  deriving DecidableEq, Repr

/-- A term's pass over a cell: side conditions, its error `err` (scale `S`), `p(c + h)` as `P0/R0 + i P1/R1` (scale `S`),
and its contribution `q` to the cell polynomial. -/
structure Core where
  /-- `D > 0`, and `b₀ = 0` at a cell starting at `0`. -/
  ok : Bool
  /-- `r + h·sup‖δ‖` at scale `S`, rounded up. -/
  err : Int
  /-- numerator of `Re p(c + h)` at scale `S`. -/
  P0 : Int
  /-- its denominator. -/
  R0 : Int
  /-- numerator of `Im p(c + h)`. -/
  P1 : Int
  /-- its denominator. -/
  R1 : Int
  /-- `[W aₙ Dⁿ]`. -/
  q : List Int

/-- `δ₁`'s list. At `C ≠ 0` (cell start `c = C/SC > 0`): `X = C g + SC (s g + b)`, so that `SC·S·x·δ₁ = X(s)`. At `C = 0`
(and `b₀ = 0`): `g + b/s`, so that `S·δ₁ = X(s)`. Here `g = b′ − a`. -/
def xList (C : Int) (g b tb : List Int) : List Int :=
  if C = 0 then addL g tb else addL (smulL C g) (smulL SC (addL (0 :: g) b))

/-- One term over the cell `[t0, t0 + w]` (scale `T2`) at distance `D` (scale `S`) from the state `st`, with the
polynomials' higher coefficients `ta`, `tb`. -/
def coreOf (W D : Int) (st : St) (t0 w : Int) (ta tb : List Int) : Core :=
  match evF (w * D) SC 0 1 1 (absL (addL (dL (st.m0 :: ta)) (st.m1 :: tb))),
      evF (w * D) SC 0 1 1 (absL (xList (t0 * D) (addL (dL (st.m1 :: tb)) (smulL (-1) (st.m0 :: ta))) (st.m1 :: tb) tb)),
      evF (w * D) SC 0 1 1 (st.m0 :: ta), evF (w * D) SC 0 1 1 (st.m1 :: tb) with
  | (V0, Q0), (V1, Q1), (P0, R0), (P1, R1) =>
    ⟨decide (0 < D) && (decide (t0 * D ≠ 0) || decide (st.m1 = 0)),
      st.r + cdiv (w * D * V0) (SC * Q0) + cdiv (w * D * V1) (SC * Q1 * (if t0 * D = 0 then 1 else t0 * D)),
      P0, R0, P1, R1, powScale D W (st.m0 :: ta)⟩

/-- One term over one cell, its polynomials from the Taylor recurrence. -/
def core (W D : Int) (st : St) (t0 w : Int) (N : Nat) : Core :=
  match taylor (t0 * D) N st.m0 st.m1 with
  | (ta, tb) => coreOf W D st t0 w ta tb

/-- The exit state `st'` is accepted: its radius covers the error and its distance to `p(c + h)`. -/
def termOk (c : Core) (st' : St) : Bool :=
  c.ok && decide (c.err + cdiv ((c.P0 - st'.m0 * c.R0).natAbs) c.R0 + cdiv ((c.P1 - st'.m1 * c.R1).natAbs) c.R1 ≤ st'.r)

/-- The generator's exit state (rounded `p(c + h)` and the least accepted radius); not read by any proof. -/
def termNext (c : Core) : St :=
  let m0 := rnd c.P0 c.R0
  let m1 := rnd c.P1 c.R1
  ⟨m0, m1, c.err + cdiv ((c.P0 - m0 * c.R0).natAbs) c.R0 + cdiv ((c.P1 - m1 * c.R1).natAbs) c.R1⟩

/-- All terms over one cell: `(every exit state accepted, Σₖ qₖ, Σₖ |Wₖ|·(T2·errₖ + t0 + w))`, the last at scale
`S·T2`; its `t0 + w` is the distances' allowance (`|dₖ − Dₖ/S| ≤ 1/S` and `J₀` `1`-Lipschitz). -/
def termsOut (t0 w : Int) (N : Nat) : List Int → List Int → List St → List St → Bool × List Int × Int
  | W :: Ws, D :: Ds, st :: sts, st' :: sts' =>
    match core W D st t0 w N, termsOut t0 w N Ws Ds sts sts' with
    | c, (ok, q, e) => (termOk c st' && ok, addL c.q q, W.natAbs * (T2 * c.err + (t0 + w)) + e)
  | [], [], [], [] => (true, [], 0)
  | _, _, _, _ => (false, [], 0)

/-- `q0 + q1 v + q2 v² ≥ L` on `|v| ≤ w`, decided exactly: both endpoints, and the vertex when it lies inside. -/
def quadOk (q0 q1 q2 w L : Int) : Bool :=
  decide (L ≤ q0 - q1 * w + q2 * w * w) && decide (L ≤ q0 + q1 * w + q2 * w * w) &&
    (if 0 < q2 ∧ (q1.natAbs : Int) ≤ 2 * q2 * w then decide (4 * q2 * L ≤ 4 * q0 * q2 - q1 * q1) else true)

/-- A covering's parameters: the weights' scale `WS`, `w₁·WS`, the target `TN/TD`, and per term its weight `Wₖ` (scale
`WS`) and distance `Dₖ` (scale `S`). -/
structure Params where
  /-- The weights' scale. -/
  WS : Int
  /-- `w₁·WS`. -/
  w1N : Int
  /-- The target's numerator. -/
  TN : Int
  /-- The target's denominator. -/
  TD : Int
  /-- `Wₖ·WS`. -/
  Ws : List Int
  /-- `Dₖ·S`. -/
  Ds : List Int

/-- **The cell check**: every term's exit state accepted, and the cell polynomial `w₁·S + Σ qₖ`, homogenized at scale
`K` and re-centred at the cell's midpoint, at least the target plus every error on the cell. -/
def cellCheck (P : Params) (sts : List St) (t0 w : Int) (N : Nat) (sts' : List St) : Bool :=
  match termsOut t0 w N P.Ws P.Ds sts sts' with
  | (ok, q, e) =>
    let R := shiftL w (homogL K (addL [P.w1N * S] q))
    ok && decide (0 ≤ t0) && decide (0 < w) && decide (0 < P.TD) && decide (0 < P.WS) &&
      quadOk (R.getD 0 0) (R.getD 1 0) (R.getD 2 0) w
        (w * w * w * evZ (absL (R.drop 3)) w +
          cdiv ((P.TN * S * P.WS * T2 + e * P.TD) * pw K (addL [P.w1N * S] q).length) (K * P.TD * T2))

/-- `2⁷²`, one packed field's width. -/
def F72 : Nat := 4722366482869645213696

/-- `2¹⁴⁴`. -/
def F144 : Nat := 22300745198530623141535718272648361505980416

/-- `2²¹⁶`, one packed state's width. -/
def F216 : Nat := 105312291668557186697918027683670432318895095400549111254310977536

/-- `2⁷¹`, a packed field's offset. -/
def H71 : Int := 2361183241434822606848

/-- `k` states packed in one `Nat`, three `72`-bit fields each (`m0`, `m1`, `r`, each offset by `2⁷¹`), state `0` lowest. -/
def decodeAux : Nat → Nat → List St
  | 0, _ => []
  | k + 1, n =>
    ⟨((n % F72 : Nat) : Int) - H71, ((n / F72 % F72 : Nat) : Int) - H71, ((n / F144 % F72 : Nat) : Int) - H71⟩ ::
      decodeAux k (n / F216)

/-- One state per term, read from its packed code. -/
def decode (P : Params) (n : Nat) : List St := decodeAux P.Ds.length n

/-- A cell of the covering: its left end and width (scale `T2`), its degree, its packed entry and exit states. -/
structure CellSpec where
  /-- The left end, scale `T2`. -/
  t0 : Int
  /-- The width, scale `T2`. -/
  w : Int
  /-- The polynomials' degree. -/
  N : Nat
  /-- The packed entry states. -/
  entry : Nat
  /-- The packed exit states. -/
  exit : Nat

/-- The cell is accepted. -/
def CellOk (P : Params) (c : CellSpec) : Prop :=
  cellCheck P (decode P c.entry) c.t0 c.w c.N (decode P c.exit) = true

instance (P : Params) (c : CellSpec) : Decidable (CellOk P c) := inferInstanceAs (Decidable (_ = true))

/-- Every cell of a list is accepted. -/
def AllOk (P : Params) : List CellSpec → Prop
  | [] => True
  | c :: cs => CellOk P c ∧ AllOk P cs

/-- The cells follow one another from time `t` and packed states `e`: each starts where and with what the last ended. -/
def Linked : Int → Nat → List CellSpec → Bool
  | _, _, [] => true
  | t, e, c :: cs => decide (c.t0 = t) && decide (c.entry = e) && Linked (t + c.w) c.exit cs

/-- The time a chain ends. -/
def chainEnd : Int → List CellSpec → Int
  | t, [] => t
  | t, c :: cs => chainEnd (t + c.w) cs

/-- The packed states a chain ends with. -/
def chainExit : Nat → List CellSpec → Nat
  | e, [] => e
  | _, c :: cs => chainExit c.exit cs

/-- The tail's sum `Σₖ |Wₖ|(uₖ + rₖ + E)` with its side conditions (`Dₖ ≥ 0`, `uₖ² ≥ m0² + m1²`). -/
def tailSum (E : Int) : List Int → List Int → List St → List Nat → Bool × Int
  | W :: Ws, D :: Ds, st :: sts, u :: us =>
    match tailSum E Ws Ds sts us with
    | (ok, s) => (ok && decide (0 ≤ D) && decide (st.m0 * st.m0 + st.m1 * st.m1 ≤ (u : Int) * u),
        W.natAbs * ((u : Int) + st.r + E) + s)
  | [], [], [], [] => (true, 0)
  | _, _, _, _ => (false, 0)

/-- **The tail check** at `tEnd` (scale `T2`) from the chain's last states and integer bounds `uₖ ≥ ‖(m0, m1)‖`. -/
def tailCheck (P : Params) (tEnd : Int) (sts : List St) (us : List Nat) : Bool :=
  match tailSum (cdiv tEnd T2) P.Ws P.Ds sts us with
  | (ok, s) => ok && decide (0 ≤ tEnd) && decide (0 < P.TD) && decide (0 < P.WS) &&
      decide (P.TN * P.WS * S ≤ P.TD * (P.w1N * S - s))

/-- The initial states: `J(0) = (1, 0)` exactly. -/
def initStates (n : Nat) : List St := List.replicate n ⟨S, 0, 0⟩

example : evZ [1, 2, 3] 2 = 17 := by decide

example : addL [1, 2] [3] = [4, 2] := by decide

example : dL [5, 3, 2] = [3, 4] := by decide

example : shiftL 1 [0, 0, 1] = [1, 2, 1] := by decide

example : homogL 2 [1, 1, 1] = [4, 2, 1] := by decide

example : evF 1 2 0 1 1 [1, 1] = (6, 4) := by decide

example : powScale 3 2 [1, 1, 1] = [2, 6, 18] := by decide

example : cdiv 7 2 = 4 ∧ cdiv (-7) 2 = -3 ∧ rnd 7 2 = 4 := by decide

example : quadOk 0 0 1 1 0 = true ∧ quadOk 0 0 1 1 1 = false := by decide

example : decodeAux 1 (H71.toNat + 5 + F72 * (H71.toNat - 3) + F144 * (H71.toNat + 2)) = [⟨5, -3, 2⟩] := by decide

example : taylor 0 2 S 0 = ([0, -4611686018427387904], [9223372036854775808, 0]) := by decide

end BesselCert
end HadwigerNelson.DensityBound
