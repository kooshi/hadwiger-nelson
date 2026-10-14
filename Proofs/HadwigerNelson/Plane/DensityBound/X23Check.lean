/-!
# The certificate's checker: the computations the kernel runs on `[AmbrusEtAl2023]`'s `X₂₃` (FS-131, FS131-IDB3)

Every definition here is integer and list arithmetic in Lean's core, with no import (the first implementer's rule, FS131-IDB1):
the generated modules `Plane/DensityBound/X23Data`, `X23Cong*` and `X23Atoms*` read only this module and their data, so their
`decide +kernel` checks load no Mathlib and do not depend on any proof. What the computations mean, and that an accepted one
makes the certificate valid, is `Plane/DensityBound/X23` (`X23_valid`).

* **The field.** `Q4` is `a + b√3 + c√11 + d√33` with integer coordinates, `C4` a pair of them (real and imaginary part); a
  point is stored as `12·xᵢ`, which is integral for every point of Table 1.
* **Packing.** A point, a congruence row, a term and a DFS state are each one `Nat`, so the data elaborate as plain literals:
  a point or a row in base `2⁷²` digits, a signed digit offset by `OFF = 2⁷⁰`; a term is `mask + 2²³·(c + 2⁷⁰)`; a state is
  `S + 2²³·(acc + 2¹²⁰)`.
* **The atom check** is a DFS over the 23 points that decides each point in or out, refuses a point adjacent (by a listed edge)
  to one already in, and adds a term to the running sum when its highest point is decided (`dfsG`); `collect` is its
  list-valued twin, which the soundness proof reads.

Record: `plans/FS131-IDB3-implementation.md`.
-/

namespace HadwigerNelson.DensityBound
namespace X23Check

/-- `2⁷²`: the digit base of a packed point or row. -/
def B72 : Nat := 4722366482869645213696

/-- `2⁷⁰`: the offset of a signed digit and of a term's coefficient. -/
def OFF : Nat := 1180591620717411303424

/-- `2²³`: one bit per point; the base of a term's or a state's mask. -/
def M23 : Nat := 8388608

/-- `2¹²⁰`: the offset of a DFS state's partial sum. -/
def OFFS : Nat := 1329227995784915872903807060280344576

/-- `2⁶⁴`, the distances' scale (`BesselCert.S`). -/
def S64 : Int := 18446744073709551616

/-- Digit `k` of a packed number in base `2⁷²`. -/
def dg (r k : Nat) : Nat := (r >>> (72 * k)) % B72

/-- Digit `k`, read as a signed integer (offset `OFF`). -/
def sdg (r k : Nat) : Int := (dg r k : Int) - (OFF : Int)

/-- `a + b√3 + c√11 + d√33`, integer coordinates. -/
structure Q4 where
  /-- The rational part. -/
  a : Int
  /-- The coefficient of `√3`. -/
  b : Int
  /-- The coefficient of `√11`. -/
  c : Int
  /-- The coefficient of `√33`. -/
  d : Int

namespace Q4

/-- The integer `n`. -/
def ofInt (n : Int) : Q4 := ⟨n, 0, 0, 0⟩

/-- Sum. -/
def add (x y : Q4) : Q4 := ⟨x.a + y.a, x.b + y.b, x.c + y.c, x.d + y.d⟩

/-- Difference. -/
def sub (x y : Q4) : Q4 := ⟨x.a - y.a, x.b - y.b, x.c - y.c, x.d - y.d⟩

/-- Product, with `√3² = 3`, `√11² = 11`, `√33 = √3·√11`. -/
def mul (x y : Q4) : Q4 :=
  ⟨x.a * y.a + 3 * (x.b * y.b) + 11 * (x.c * y.c) + 33 * (x.d * y.d),
   x.a * y.b + x.b * y.a + 11 * (x.c * y.d + x.d * y.c),
   x.a * y.c + x.c * y.a + 3 * (x.b * y.d + x.d * y.b),
   x.a * y.d + x.d * y.a + x.b * y.c + x.c * y.b⟩

/-- Integer multiple. -/
def smul (m : Int) (x : Q4) : Q4 := ⟨m * x.a, m * x.b, m * x.c, m * x.d⟩

/-- Negation. -/
def neg (x : Q4) : Q4 := ⟨-x.a, -x.b, -x.c, -x.d⟩

/-- Equality, coordinatewise. -/
def beq (x y : Q4) : Bool := x.a == y.a && x.b == y.b && x.c == y.c && x.d == y.d

end Q4

/-- A complex number with coordinates in `ℤ[√3, √11]`. -/
structure C4 where
  /-- The real part. -/
  re : Q4
  /-- The imaginary part. -/
  im : Q4

namespace C4

/-- Sum. -/
def add (x y : C4) : C4 := ⟨x.re.add y.re, x.im.add y.im⟩

/-- Difference. -/
def sub (x y : C4) : C4 := ⟨x.re.sub y.re, x.im.sub y.im⟩

/-- Product. -/
def mul (x y : C4) : C4 := ⟨(x.re.mul y.re).sub (x.im.mul y.im), (x.re.mul y.im).add (x.im.mul y.re)⟩

/-- Complex conjugate. -/
def conj (x : C4) : C4 := ⟨x.re, x.im.neg⟩

/-- `x̄` when `b`, else `x`. -/
def cond (b : Bool) (x : C4) : C4 := bif b then x.conj else x

/-- Integer multiple. -/
def smul (m : Int) (x : C4) : C4 := ⟨x.re.smul m, x.im.smul m⟩

/-- `|x|² = re² + im²`. -/
def normSq (x : C4) : Q4 := (x.re.mul x.re).add (x.im.mul x.im)

/-- Equality, coordinatewise. -/
def beq (x y : C4) : Bool := x.re.beq y.re && x.im.beq y.im

end C4

/-- Four signed digits from digit `k` on. -/
def q4At (r k : Nat) : Q4 := ⟨sdg r k, sdg r (k + 1), sdg r (k + 2), sdg r (k + 3)⟩

/-- Eight signed digits from digit `k` on: the real part, then the imaginary part. -/
def c4At (r k : Nat) : C4 := ⟨q4At r k, q4At r (k + 4)⟩

/-- The point `12·xᵢ` (0-based `i`) of a packed point list. -/
def pt (pts : List Nat) (i : Nat) : C4 := c4At (pts.getD i 0) 0

/-- `|p − q|²`. -/
def sqd (p q : C4) : Q4 := (p.sub q).normSq

/-! ### Congruence rows

Digit 0 is `c + OFF` (the weight at scale `10²¹`), digit 1 the reflection bit, digit 2 the denominator `m > 0`, digits 3–10
`U` and 11–18 `V` (signed), digit 19 the length `n`, digits `20 …` the list `I` and then the list `J` (0-based). The row
claims `u = U/m`, `v = V/(12m)`: `|U|² = m²` and `U·(b ? P̄ᵢ : Pᵢ) + V = m·P_j` for the `k`-th entries `i` of `I`, `j` of `J`.
-/

/-- `n` digits from digit `s` on. -/
def digits (r : Nat) : Nat → Nat → List Nat
  | _, 0 => []
  | s, n + 1 => dg r s :: digits r (s + 1) n

/-- The row's weight `w_c(I, J)·10²¹`. -/
def rowC (r : Nat) : Int := sdg r 0
/-- The row's reflection bit. -/
def rowB (r : Nat) : Bool := dg r 1 == 1
/-- The row's denominator. -/
def rowM (r : Nat) : Nat := dg r 2
/-- The row's `U`. -/
def rowU (r : Nat) : C4 := c4At r 3
/-- The row's `V`. -/
def rowV (r : Nat) : C4 := c4At r 11
/-- The row's length. -/
def rowN (r : Nat) : Nat := dg r 19
/-- The row's `I` (0-based). -/
def rowI (r : Nat) : List Nat := digits r 20 (rowN r)
/-- The row's `J` (0-based), in the order corresponding to `I`. -/
def rowJ (r : Nat) : List Nat := digits r (20 + rowN r) (rowN r)

/-- The correspondence `I[k] ↦ J[k]`: `U·(b ? P̄ : P) + V = m·Q` entry by entry, the two lists of one length. -/
def corrOk (pts : List Nat) (b : Bool) (U V : C4) (m : Int) : List Nat → List Nat → Bool
  | [], [] => true
  | i :: I, j :: J => ((U.mul ((pt pts i).cond b)).add V).beq ((pt pts j).smul m) && corrOk pts b U V m I J
  | _, _ => false

/-- One congruence row is an isometry of the plane carrying `X|I` onto `X|J`. -/
def rowOk (pts : List Nat) (r : Nat) : Bool :=
  decide (0 < rowM r) && (rowU r).normSq.beq (Q4.ofInt ((rowM r : Int) * (rowM r : Int))) &&
    corrOk pts (rowB r) (rowU r) (rowV r) (rowM r : Int) (rowI r) (rowJ r)

/-! ### Edges -/

/-- Every bit `u` of point `w`'s adjacency mask (`u, w < 23`) is a unit pair: `|Pw − Pu|² = 144`. -/
def adjOk (pts : List Nat) (vs : List (Nat × List Nat)) : Bool :=
  (List.range 23).all fun w => (List.range 23).all fun u =>
    !((vs.getD w (0, [])).1.testBit u) || (sqd (pt pts w) (pt pts u)).beq (Q4.ofInt 144)

/-! ### Terms -/

/-- A term: `mask + 2²³·(c + 2⁷⁰)`. -/
def pack (m : Nat) (c : Int) : Nat := m + M23 * (c + (OFF : Int)).toNat

/-- A term's value on a set `S` (a mask): its coefficient if its mask is inside `S`, else `0`. -/
def tval (S t : Nat) : Int := bif t % M23 &&& S == t % M23 then ((t / M23 : Nat) : Int) - (OFF : Int) else 0

/-- The mask of a list of points. -/
def maskL : List Nat → Nat
  | [] => 0
  | i :: I => maskL I ||| 2 ^ i

/-- The term of a `w₂` row `(i, j, c)`. -/
def w2Term (e : Nat × Nat × Int) : Nat := pack (2 ^ e.1 ||| 2 ^ e.2.1) e.2.2

/-- The two terms of a congruence row: `−c` on `I`, `+c` on `J`. -/
def rowTerms (r : Nat) : List Nat := [pack (maskL (rowI r)) (-rowC r), pack (maskL (rowJ r)) (rowC r)]

/-- All terms of `L(S)·10²¹`: `w₁` at point 0, the `w₂` rows, the congruence rows. -/
def terms (w1N : Int) (w2T : List (Nat × Nat × Int)) (rows : List Nat) : List Nat :=
  pack 1 w1N :: (w2T.map w2Term ++ rows.flatMap rowTerms)

/-- A term packs `(m, c)` faithfully. -/
def termOk (m : Nat) (c : Int) : Bool :=
  pack m c % M23 == m && decide ((((pack m c / M23 : Nat) : Int) - (OFF : Int)) = c)

/-- Every term packs faithfully and names only points `< 23`. -/
def termsOk (w1N : Int) (w2T : List (Nat × Nat × Int)) (rows : List Nat) : Bool :=
  termOk 1 w1N &&
    w2T.all (fun e => decide (e.1 < 23) && decide (e.2.1 < 23) && termOk (2 ^ e.1 ||| 2 ^ e.2.1) e.2.2) &&
    rows.all (fun r => (rowI r).all (fun i => decide (i < 23)) && (rowJ r).all (fun i => decide (i < 23)) &&
      termOk (maskL (rowI r)) (-rowC r) && termOk (maskL (rowJ r)) (rowC r))

/-- A term's group test: its highest point is `v`. -/
def inGroup (v t : Nat) : Bool := (t % M23) >>> v == 1

/-- The terms grouped by their highest point. -/
def groupsOf (T : List Nat) : List (List Nat) := (List.range 23).map fun v => T.filter (inGroup v)

/-- A term lies in exactly one group. -/
def oneGroup (t : Nat) : Bool := ((List.range 23).filter fun v => inGroup v t).length == 1

/-! ### The DFS -/

/-- The terms of one group added to `a` on the set `S`. -/
def addGroup (S : Nat) : List Nat → Int → Int
  | [], a => a
  | t :: l, a => addGroup S l (a + tval S t)

/-- The leaf test: the set is empty, or its sum is at most the bound. -/
def final (bound : Int) (S : Nat) (acc : Int) : Bool := S == 0 || decide (acc ≤ bound)

/-- The DFS from point `v` with the set `S` chosen below `v` and the partial sum `acc`; each entry of `vs` is a point's
adjacency mask and its group of terms. -/
def dfsG (leaf : Nat → Int → Bool) : List (Nat × List Nat) → Nat → Nat → Int → Bool
  | [], _, S, acc => leaf S acc
  | (a, g) :: vs, v, S, acc =>
    dfsG leaf vs (v + 1) S acc &&
      (a &&& S != 0 || dfsG leaf vs (v + 1) (S ||| 2 ^ v) (addGroup (S ||| 2 ^ v) g acc))

/-- The states the DFS reaches at its leaves, in its order. -/
def collect : List (Nat × List Nat) → Nat → Nat → Int → List (Nat × Int)
  | [], _, S, acc => [(S, acc)]
  | (a, g) :: vs, v, S, acc =>
    collect vs (v + 1) S acc ++
      (bif a &&& S != 0 then [] else collect vs (v + 1) (S ||| 2 ^ v) (addGroup (S ||| 2 ^ v) g acc))

/-- A state, packed: `S + 2²³·(acc + 2¹²⁰)`. -/
def packSt (p : Nat × Int) : Nat := p.1 + M23 * (p.2 + (OFFS : Int)).toNat

/-- A packed state, read back. -/
def decSt (q : Nat) : Nat × Int := (q % M23, ((q / M23 : Nat) : Int) - (OFFS : Int))

/-- The DFS below a frontier state. -/
def subtreeOk (bound : Int) (vs : List (Nat × List Nat)) (v q : Nat) : Bool :=
  dfsG (final bound) vs v (decSt q).1 (decSt q).2

/-! ### Distances -/

/-- Integer enclosures at scale `K`: `l² ≤ n·K² ≤ u²` for `n = 3, 11, 33`. -/
structure Encl where
  /-- The scale. -/
  K : Nat
  /-- `⌊√3·K⌋`. -/
  l3 : Nat
  /-- `⌈√3·K⌉`. -/
  u3 : Nat
  /-- `⌊√11·K⌋`. -/
  l11 : Nat
  /-- `⌈√11·K⌉`. -/
  u11 : Nat
  /-- `⌊√33·K⌋`. -/
  l33 : Nat
  /-- `⌈√33·K⌉`. -/
  u33 : Nat

/-- The enclosures are enclosures, at a positive scale. -/
def Encl.ok (e : Encl) : Bool :=
  decide (0 < e.K) && decide (e.l3 * e.l3 ≤ 3 * (e.K * e.K)) && decide (3 * (e.K * e.K) ≤ e.u3 * e.u3) &&
    decide (e.l11 * e.l11 ≤ 11 * (e.K * e.K)) && decide (11 * (e.K * e.K) ≤ e.u11 * e.u11) &&
    decide (e.l33 * e.l33 ≤ 33 * (e.K * e.K)) && decide (33 * (e.K * e.K) ≤ e.u33 * e.u33)

/-- A lower bound of `b·x` for `l ≤ x ≤ u`. -/
def lowMul (b : Int) (l u : Nat) : Int := bif decide (0 ≤ b) then b * (l : Int) else b * (u : Int)

/-- An upper bound of `b·x` for `l ≤ x ≤ u`. -/
def highMul (b : Int) (l u : Nat) : Int := bif decide (0 ≤ b) then b * (u : Int) else b * (l : Int)

/-- A lower bound of `K·(a + b√3 + c√11 + d√33)`. -/
def evLo (e : Encl) (q : Q4) : Int :=
  q.a * (e.K : Int) + lowMul q.b e.l3 e.u3 + lowMul q.c e.l11 e.u11 + lowMul q.d e.l33 e.u33

/-- An upper bound of `K·(a + b√3 + c√11 + d√33)`. -/
def evHi (e : Encl) (q : Q4) : Int :=
  q.a * (e.K : Int) + highMul q.b e.l3 e.u3 + highMul q.c e.l11 e.u11 + highMul q.d e.l33 e.u33

/-- `(12(D − 1))² ≤ q·S² ≤ (12(D + 1))²` with `D ≥ 1`: the distance `√q/12` is within `1/S` of `D/S`. -/
def distOk (e : Encl) (D : Int) (q : Q4) : Bool :=
  decide (1 ≤ D) && decide (144 * ((D - 1) * (D - 1)) * (e.K : Int) ≤ evLo e q * (S64 * S64)) &&
    decide (evHi e q * (S64 * S64) ≤ 144 * ((D + 1) * (D + 1)) * (e.K : Int))

/-- Each `w₂` row's distance against the covering's listed distance, in order. -/
def distsOk (pts : List Nat) (e : Encl) : List Int → List (Nat × Nat × Int) → Bool
  | [], [] => true
  | D :: Ds, (i, j, _) :: w2 => distOk e D (sqd (pt pts i) (pt pts j)) && distsOk pts e Ds w2
  | _, _ => false

/-! ### Spec examples -/

example : (Q4.mul ⟨0, 1, 0, 0⟩ ⟨0, 1, 0, 0⟩).beq (Q4.ofInt 3) = true := by decide
example : (Q4.mul ⟨0, 1, 0, 0⟩ ⟨0, 0, 1, 0⟩).beq ⟨0, 0, 0, 1⟩ = true := by decide
example : (Q4.mul ⟨0, 0, 0, 1⟩ ⟨0, 0, 0, 1⟩).beq (Q4.ofInt 33) = true := by decide
example : dg (5 + 7 * B72) 1 = 7 := by decide
example : sdg (OFF - 3) 0 = -3 := by decide
example : maskL [0, 2] = 5 := by decide
example : tval 5 (pack 5 (-2)) = -2 ∧ tval 4 (pack 5 (-2)) = 0 := by decide
example : groupsOf [pack 5 1] = [[], [], [pack 5 1]] ++ List.replicate 20 [] := by decide
example : decSt (packSt (6, -9)) = (6, -9) := by decide
example : collect [(0, [pack 1 1]), (1, [pack 2 1])] 0 0 0 = [(0, 0), (2, 1), (1, 1)] := by decide
example : dfsG (final 1) [(0, [pack 1 1]), (1, [pack 3 5])] 0 0 0 = true ∧
    dfsG (final 0) [(0, [pack 1 1]), (0, [pack 3 5])] 0 0 0 = false := by decide
example : (sqd ⟨Q4.ofInt 12, Q4.ofInt 0⟩ ⟨Q4.ofInt 0, Q4.ofInt 0⟩).beq (Q4.ofInt 144) = true := by decide

end X23Check
end HadwigerNelson.DensityBound
