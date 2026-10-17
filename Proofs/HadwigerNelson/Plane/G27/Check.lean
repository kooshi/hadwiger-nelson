import Proofs.HadwigerNelson.Plane.DensityBound.X23Check

/-!
# `G27`'s certificate checker: the computations the kernel runs (FS-131, FS131-ISF1)

Every definition here is integer and list arithmetic in Lean's core: the module imports only `Plane/DensityBound/X23Check`
(core, no Mathlib), whose `ℤ[√3, √11]` arithmetic (`Q4`, `C4`), digit packing (`dg`, `sdg`, `c4At`, `pt`, `sqd`) and
congruence rows (`rowOk`: an isometry `z ↦ (U/m)·(b ? z̄ : z) + V/(12m)` carrying the points `I` onto the points `J`, entry by
entry) it reads unchanged. The generated modules `Plane/G27/Data`, `Cong*`, `Atoms*` read only this module and their data, so
their `decide +kernel` checks load no Mathlib. What the computations mean, and that accepted checks make the certificate
valid, is `Plane/G27/Valid`.

* **Points and edges.** `[MatolcsiEtAl2025]`'s 27 points, each stored as `12·xᵢ` in `X23Check`'s packing, relabelled in the
  DFS's order and translated so that point 0 is the origin. `adjOk`: every bit of a point's adjacency mask is a unit pair.
  `pathsOk`: every point is joined to point 0 by a path of listed edges (so every point lies in `ℤ[U]`).
* **Terms.** A term is one `Nat`, `key + 2²⁷·(c + OFFC)`: `key` is a mask of points, `c` an integer coefficient (`OFFC = 2¹⁰⁰⁰`).
  The certificate's terms are the 27 singletons and, for each congruence row, `−c` on its `I` and `+c` on its `J`
  (`expand`); `sortR` merges them, adding equal keys, into one list sorted by key.
* **The residual DFS** (`dfsR`) decides the points in order, refuses a point adjacent to one already in, and carries the
  *residual* of the term list: the terms whose decided part lies in the chosen set, their decided part removed, equal keys
  merged (`stepOut`, `stepIn`, `mergeR`). At a leaf the residual's constant term is the sum of the terms inside the set,
  and `leafOk` bounds it. `collectR` is its list-valued twin, which the soundness proof and the frontier read.

Record: `plans/FS131-ISF1-seam-fractional.md`.
-/

namespace HadwigerNelson.G27

open HadwigerNelson.DensityBound.X23Check

/-! ### Terms -/

/-- `2²⁷`: one bit per point; the base of a term's key. -/
def M27 : Nat := 134217728

/-- `2¹⁰⁰⁰`: the offset of a term's coefficient. -/
def OFFC : Nat :=
  10715086071862673209484250490600018105614048117055336074437503883703510511249361224931983788156958581275946729175531468251871452856923140435984577574698574803934567774824230985421074605062371141877954182153046474983581941267398767559165543946077062914571196477686542167660429831652624386837205668069376

/-- A term's key: its mask of points. -/
def key (t : Nat) : Nat := t % M27

/-- A term's coefficient. -/
def cf (t : Nat) : Int := ((t / M27 : Nat) : Int) - (OFFC : Int)

/-- The value of a list of terms on a set `U` of points (a mask): the sum of the coefficients of the terms inside `U`. -/
def val (U : Nat) (L : List Nat) : Int := (L.map fun t => bif key t &&& U == key t then cf t else 0).sum

/-! ### The residual's steps

Written with `Nat.rec`/`List.rec` and direct `Nat` calls, not structural recursion and notation: the kernel pays a `brecOn`
per step of structural recursion and an instance chain per operator (`LEAN.md` § The kernel's cost model; FS131-ISF1's
benchmark, 86 µs against 24 µs per element of a pass). `List.rec` does not compile, so these are `noncomputable`: the
kernel evaluates them, nothing runs them. -/

/-- Merge two lists of terms sorted by key, adding the coefficients of equal keys (when the sum's packing cannot underflow;
else both are kept). With no fuel left the lists are appended; the value is preserved either way. -/
noncomputable def mergeR (f : Nat) : List Nat → List Nat → List Nat :=
  Nat.rec (motive := fun _ => List Nat → List Nat → List Nat) (fun l₁ l₂ => l₁ ++ l₂)
    (fun _ ih l₁ l₂ =>
      match l₁, l₂ with
      | [], l₂ => l₂
      | a :: l₁, [] => a :: l₁
      | a :: l₁, b :: l₂ =>
        cond (Nat.blt (Nat.mod a M27) (Nat.mod b M27)) (a :: ih l₁ (b :: l₂))
          (cond (Nat.blt (Nat.mod b M27) (Nat.mod a M27)) (b :: ih (a :: l₁) l₂)
            (cond (Nat.ble OFFC (Nat.add (Nat.div a M27) (Nat.div b M27)))
              (Nat.add (Nat.mod a M27) (Nat.mul M27 (Nat.sub (Nat.add (Nat.div a M27) (Nat.div b M27)) OFFC)) ::
                ih l₁ l₂)
              (a :: b :: ih l₁ l₂)))) f

/-- The merges' fuel: more than any list here. -/
def FUEL : Nat := 1073741824

/-- Point `k` out (`bit = 2ᵏ`): the terms that need it are dropped. -/
noncomputable def stepOut (bit : Nat) (L : List Nat) : List Nat :=
  List.rec [] (fun t _ r => cond (Nat.beq (Nat.land t bit) 0) (t :: r) r) L

/-- Point `k` in, the terms without it: those with no point adjacent to `k` are kept (`ba = 2ᵏ ||| a`). -/
noncomputable def keepIn (ba : Nat) (L : List Nat) : List Nat :=
  List.rec [] (fun t _ r => cond (Nat.beq (Nat.land t ba) 0) (t :: r) r) L

/-- Point `k` in, the terms with it: those with no point adjacent to `k` (mask `a`) lose it. -/
noncomputable def shiftIn (bit a : Nat) (L : List Nat) : List Nat :=
  List.rec [] (fun t _ r => cond (Nat.beq (Nat.land t a) 0) (cond (Nat.beq (Nat.land t bit) 0) r (Nat.xor t bit :: r)) r) L

/-- Point `k` in (`bit = 2ᵏ`, `a` its adjacency mask): the two parts merged. -/
noncomputable def stepIn (bit a : Nat) (L : List Nat) : List Nat :=
  mergeR FUEL (shiftIn bit a L) (keepIn (Nat.lor bit a) L)

/-! ### The DFS -/

/-- The residual DFS from point `k`, the set `S` chosen below `k`, the residual `L`; `as` lists the adjacency masks of the
points `k, k + 1, …`. -/
noncomputable def dfsR (leaf : Nat → List Nat → Bool) (as : List Nat) : Nat → Nat → List Nat → Bool :=
  List.rec (motive := fun _ => Nat → Nat → List Nat → Bool) (fun _ S L => leaf S L)
    (fun a _ ih k S L =>
      and (ih (Nat.succ k) S (stepOut (Nat.pow 2 k) L))
        (or (bne (Nat.land a S) 0) (ih (Nat.succ k) (Nat.lor S (Nat.pow 2 k)) (stepIn (Nat.pow 2 k) a L)))) as

/-- The states the DFS reaches at its leaves, in its order. -/
noncomputable def collectR (as : List Nat) : Nat → Nat → List Nat → List (Nat × List Nat) :=
  List.rec (motive := fun _ => Nat → Nat → List Nat → List (Nat × List Nat)) (fun _ S L => [(S, L)])
    (fun a _ ih k S L =>
      ih (Nat.succ k) S (stepOut (Nat.pow 2 k) L) ++
        cond (bne (Nat.land a S) 0) [] (ih (Nat.succ k) (Nat.lor S (Nat.pow 2 k)) (stepIn (Nat.pow 2 k) a L))) as

/-- The residual's constant term: the coefficients of its terms with the empty key. -/
noncomputable def val0 (L : List Nat) : Int :=
  List.rec 0 (fun t _ r => cond (Nat.beq (Nat.mod t M27) 0) (Int.add (Int.subNatNat (Nat.div t M27) OFFC) r) r) L

/-- The leaf test: the residual's value on the empty set (its constant term) is at most `D`. -/
noncomputable def leafOk (D : Int) (_S : Nat) (L : List Nat) : Bool := decide (val0 L ≤ D)

/-- A frontier state, as one list: the set, then the residual. -/
def stateL (p : Nat × List Nat) : List Nat := p.1 :: p.2

/-- The DFS below one frontier state (`st = S :: L`) from point `k` on. -/
noncomputable def subtreeOk (D : Int) (as : List Nat) (k : Nat) (st : List Nat) : Bool :=
  dfsR (leafOk D) as k (st.headD 0) st.tail

/-- Equality of lists of lists of naturals, as a `Bool`. -/
def eqLL : List (List Nat) → List (List Nat) → Bool
  | [], [] => true
  | a :: as, b :: bs => a == b && eqLL as bs
  | _, _ => false

/-! ### Sorting the terms -/

/-- One round of merging neighbours. -/
noncomputable def mergePairs : List (List Nat) → List (List Nat)
  | l₁ :: l₂ :: ls => mergeR FUEL l₁ l₂ :: mergePairs ls
  | ls => ls

/-- Bottom-up merge sort in at most `r` rounds (then flattened). -/
noncomputable def sortRounds : Nat → List (List Nat) → List Nat
  | 0, ls => ls.flatten
  | _ + 1, [] => []
  | _ + 1, [l] => l
  | r + 1, l₁ :: l₂ :: ls => sortRounds r (mergePairs (l₁ :: l₂ :: ls))

/-- The terms sorted by key, equal keys merged. -/
noncomputable def sortR (L : List Nat) : List Nat := sortRounds 20 (L.map fun t => [t])

/-! ### The certificate's terms -/

/-- A packed coefficient `c + OFFC` fits: `0 ≤ c + OFFC ≤ 2·OFFC`. -/
def cpkOk (cpk : Nat) : Bool := Nat.ble cpk (2 * OFFC)

/-- The singletons' terms: point `i` with the packed coefficient `cpk`. -/
def singTerms : Nat → List Nat → List Nat
  | _, [] => []
  | i, cpk :: cs => (2 ^ i + M27 * cpk) :: singTerms (i + 1) cs

/-- A congruence row's two terms: `−c` on `I`, `+c` on `J` (`cpk = c + OFFC`). -/
def rowTerms (r cpk : Nat) : List Nat := [maskL (rowI r) + M27 * (2 * OFFC - cpk), maskL (rowJ r) + M27 * cpk]

/-- The rows' terms, row by row. -/
def rowsTerms : List Nat → List Nat → List Nat
  | r :: rs, cpk :: cs => rowTerms r cpk ++ rowsTerms rs cs
  | _, _ => []

/-- All the certificate's terms. -/
def expand (sing rows coefs : List Nat) : List Nat := singTerms 0 sing ++ rowsTerms rows coefs

/-- Every row names only points `< 27`, and its coefficient fits; the two lists have one length. -/
def rowsFit : List Nat → List Nat → Bool
  | [], [] => true
  | r :: rs, cpk :: cs =>
    (rowI r).all (fun i => Nat.blt i 27) && (rowJ r).all (fun i => Nat.blt i 27) && cpkOk cpk && rowsFit rs cs
  | _, _ => false

/-- The singletons' coefficients sum to `w·D`: `Σ (cpk − OFFC) = w·D`. -/
def singSumOk (w D : Int) (sing : List Nat) : Bool :=
  sing.length == 27 && sing.all cpkOk && decide ((sing.map fun cpk : Nat => (cpk : Int) - (OFFC : Int)).sum = w * D)

/-! ### Edges and paths -/

/-- Every bit `u` of point `w`'s adjacency mask (`u, w < 27`) is a unit pair: `|Pw − Pu|² = 144`; no bit at or above 27. -/
def adjOk (pts : List Nat) (adj : List Nat) : Bool :=
  adj.length == 27 &&
    (List.range 27).all fun w => Nat.blt (adj.getD w 0) M27 && (List.range 27).all fun u =>
      !((adj.getD w 0).testBit u) || (sqd (pt pts w) (pt pts u)).beq (Q4.ofInt 144)

/-- A path of listed edges from `v`. -/
def pathFrom (adj : List Nat) : Nat → List Nat → Bool
  | _, [] => true
  | v, w :: p => (adj.getD v 0).testBit w && pathFrom adj w p

/-- The `i`-th path joins point 0 to point `i` by listed edges, for every `i < 27`. -/
def pathsOk (adj : List Nat) (paths : List (List Nat)) : Bool :=
  paths.length == 27 &&
    (List.range 27).all fun i => pathFrom adj 0 (paths.getD i []) && (0 :: paths.getD i []).getLast? == some i

/-! ### Spec examples -/

example : key (5 + M27 * 7) = 5 ∧ (5 + M27 * 7) / M27 = 7 := by decide
example : val 5 [5 + M27 * (OFFC + 3), 2 + M27 * (OFFC - 1), 4 + M27 * OFFC] = 3 := by decide
example : mergeR 10 [1 + M27 * (OFFC + 2), 4 + M27 * OFFC] [1 + M27 * (OFFC + 5)] =
    [1 + M27 * (OFFC + 7), 4 + M27 * OFFC] := by decide
example : stepOut 2 [1, 2, 3, 4] = [1, 4] := by decide
example : stepIn 2 4 [1 + M27 * OFFC, 3 + M27 * (OFFC + 1), 6 + M27 * OFFC] = [1 + M27 * (OFFC + 1)] := by decide
example : sortR [4 + M27 * OFFC, 1 + M27 * (OFFC + 1), 4 + M27 * (OFFC + 2)] = [1 + M27 * (OFFC + 1), 4 + M27 * (OFFC + 2)] := by
  decide
example : collectR [0, 0] 0 0 [3 + M27 * (OFFC + 1)] =
    [(0, []), (2, []), (1, []), (3, [M27 * (OFFC + 1)])] := by decide
example : collectR [0, 1] 0 0 [3 + M27 * (OFFC + 1)] = [(0, []), (2, []), (1, [])] := by decide
example : dfsR (leafOk 1) [0, 0] 0 0 [3 + M27 * (OFFC + 1), 1 + M27 * OFFC] = true ∧
    dfsR (leafOk 0) [0, 0] 0 0 [3 + M27 * (OFFC + 1), 1 + M27 * OFFC] = false := by decide
example : pathFrom [2, 1] 0 [1] = true ∧ pathFrom [2, 1] 0 [0] = false := by decide

end HadwigerNelson.G27
