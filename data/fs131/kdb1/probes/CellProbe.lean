/-! FS131-KDB1 probe (scratch, not a library module): the J₀ covering check of one or more cells, as the
kernel would run it — core only, integer arithmetic, structural recursion. Mirrors
`data/fs131/kdb1/proto/proto_chain.py`. Data is appended by `gen_probe.py`. -/

namespace KDB1

def P : Nat := 64
def TB : Nat := 20
def S : Int := 2 ^ P
def SC : Int := 2 ^ (P + TB)          -- scale of x-points and of h's numerator

/-- round(num / den), `den > 0`. -/
def rnd (num den : Int) : Int := (2 * num + den) / (2 * den)

/-- ceil(num / den) for `den > 0`. -/
def cdiv (num den : Int) : Int := -((-num) / den)

/-- A rational `num / den`, `den > 0`, never normalised. -/
structure QQ where
  num : Int
  den : Int

namespace QQ
def add (x y : QQ) : QQ := ⟨x.num * y.den + y.num * x.den, x.den * y.den⟩
def sub (x y : QQ) : QQ := ⟨x.num * y.den - y.num * x.den, x.den * y.den⟩
def mul (x y : QQ) : QQ := ⟨x.num * y.num, x.den * y.den⟩
def le (x y : QQ) : Bool := decide (x.num * y.den ≤ y.num * x.den)
end QQ

/-- The state of one term's chain at a cell's left end: `|J(x) − (m0, m1)/S| ≤ r/S`. -/
structure St where
  m0 : Int
  m1 : Int
  r : Int
deriving Inhabited

/-- Accumulators of one term's pass over the Taylor coefficients. -/
structure Acc where
  am1 : Int     -- a_{n-1}
  an : Int      -- a_n
  bn : Int      -- b_n
  gm1 : Int     -- g_{n-1}
  hn : Int      -- HN^n
  hd : Int      -- HD^n
  A0 : Int      -- Σ |δ0_m| HN^m HD^(n−m)  (m < n), over S·HD^n
  A1 : Int      -- Σ |X_m|  HN^m HD^(n−m)  (m < n)
  P0 : Int      -- Σ a_m HN^m HD^(n−m)
  P1 : Int      -- Σ b_m HN^m HD^(n−m)
  dk : Int      -- Dk^n
  q : List Int  -- Q-contributions W·a_m·Dk^m, reversed

/-- One pass, `n = 0 … N`. `C` is the left end at scale `SC`, `HN/HD = h`. At `n = N` the recurrence's last
coefficients close the defect with `δ0_N = b_N`, `g_N = −a_N`. -/
def pass (W Dk C HN HD : Int) : Nat → Nat → Acc → Acc
  | 0, _, acc => acc
  | fuel + 1, n, acc =>
    let last := fuel == 0
    let an1 : Int := if last then 0 else -(rnd acc.bn (n + 1))
    let bn1 : Int := if last then 0 else
      if C == 0 then rnd acc.an (n + 2)
      else rnd (C * acc.an + SC * (acc.am1 - (n + 1) * acc.bn)) (C * (n + 1))
    let d0 : Int := (n + 1) * an1 + acc.bn
    let g : Int := (n + 1) * bn1 - acc.an
    let X : Int := if C == 0 then g + bn1 else C * g + SC * (acc.gm1 + acc.bn)
    let A0 := acc.A0 * HD + d0.natAbs * acc.hn
    let A1 := acc.A1 * HD + X.natAbs * acc.hn
    let P0 := acc.P0 * HD + acc.an * acc.hn
    let P1 := acc.P1 * HD + acc.bn * acc.hn
    pass W Dk C HN HD fuel (n + 1)
      ⟨acc.an, an1, bn1, g, acc.hn * HN, acc.hd * HD, A0, A1, P0, P1, acc.dk * Dk,
        (W * acc.an * acc.dk) :: acc.q⟩

/-- One term over the cell `[t0, t0 + w]` (both at scale `2^TB`): the new state, the cell's error bound
`r + h·D` at scale `S` (rounded up), and the term's Q-coefficients (low degree first; coefficient `n` over
`WS · S · S^n`). For `C ≠ 0` the last `X` (degree N+1) is `C·0 + SC·g_N`. -/
def termCell (W Dk : Int) (st : St) (t0 w : Int) (N : Nat) : St × Int × List Int :=
  let C := t0 * Dk
  let HN := w * Dk
  let HD := SC
  let acc0 : Acc := ⟨0, st.m0, st.m1, 0, 1, 1, 0, 0, 0, 0, 1, []⟩
  let acc := pass W Dk C HN HD (N + 1) 0 acc0
  -- acc.hd = HD^(N+1); sums are over S·HD^(N+1) (the extra HD from the final iteration).
  let A1 := if C == 0 then acc.A1 else acc.A1 * HD + (SC * acc.gm1).natAbs * acc.hn
  let hdA1 := if C == 0 then acc.hd else acc.hd * HD
  -- h·D0 over S: (HN/HD) · A0/(S·hd);   h·D1: (HN/HD) · A1/(S·SC·hdA1) / (C/SC)  (C ≠ 0)
  let hD0 := cdiv (HN * acc.A0) acc.hd
  let hD1 := if C == 0 then cdiv (HN * A1) acc.hd else cdiv (HN * A1) (hdA1 * C)
  -- p(h)·S = P·HD / hd
  let n0 := rnd (acc.P0 * HD) acc.hd
  let n1 := rnd (acc.P1 * HD) acc.hd
  let e0 := cdiv ((acc.P0 * HD - n0 * acc.hd).natAbs) acc.hd
  let e1 := cdiv ((acc.P1 * HD - n1 * acc.hd).natAbs) acc.hd
  let cellErr := st.r + hD0 + hD1
  (⟨n0, n1, cellErr + e0 + e1⟩, cellErr, acc.q.reverse)

/-- Pointwise sum of two coefficient lists. -/
def addL : List Int → List Int → List Int
  | [], l => l
  | l, [] => l
  | a :: l, b :: m => (a + b) :: addL l m

/-- Bring coefficient `n` (over `WS·S^(n+1)`) to the common denominator `WS·S^(N+1)·2^((TB+1)N)` after the
substitution `τ = (w + v)/2^(TB+1)`: multiply by `S^(N−n) · 2^((TB+1)(N−n))`. -/
def commonDen (N : Nat) : Nat → List Int → List Int
  | _, [] => []
  | n, c :: l => (c * (S * 2 ^ (TB + 1)) ^ (N - n)) :: commonDen N (n + 1) l

/-- Synthetic division: coefficients of `Q(w + v)` from those of `Q(·)` (low degree first), integer `w`. -/
def shiftStep (w : Int) : List Int → List Int
  | [] => []
  | [c] => [c]
  | c :: l =>
    let l' := shiftStep w l
    match l' with
    | [] => [c]
    | d :: _ => (c + w * d) :: l'

def shiftAll (w : Int) : Nat → List Int → List Int
  | 0, l => l
  | k + 1, l =>
    match shiftStep w l with
    | [] => []
    | c :: rest => c :: shiftAll w k rest

/-- Lower bound (numerator over the common denominator) of `Q̂0 + Q̂1 v + Q̂2 v² − Σ_{i≥3} |Q̂i| w^i`
on `|v| ≤ w`, as a rational `num/den` (den relative to the common denominator). -/
def higher (w : Int) : Nat → Int → List Int → Int
  | _, _, [] => 0
  | 0, wp, c :: l => c.natAbs * wp + higher w 0 (wp * w) l
  | k + 1, wp, _ :: l => higher w k (wp * w) l

def quadMin (q0 q1 q2 w : Int) : QQ :=
  let e1 : QQ := ⟨q0 - q1 * w + q2 * w * w, 1⟩
  let e2 : QQ := ⟨q0 + q1 * w + q2 * w * w, 1⟩
  let m := if QQ.le e1 e2 then e1 else e2
  if q2 > 0 && decide (q1.natAbs ≤ 2 * q2 * w) then
    let v : QQ := ⟨4 * q0 * q2 - q1 * q1, 4 * q2⟩
    if QQ.le v m then v else m
  else m

/-- The cell check: all terms, then the lower bound against `TARGET`. Returns the new states if it passes. -/
def cellTerms (Ws Ds : List Int) (sts : List St) (t0 w : Int) (N : Nat) :
    List St × Int × List Int :=
  match Ws, Ds, sts with
  | W :: Ws', Dk :: Ds', st :: sts' =>
    let (st', err, q) := termCell W Dk st t0 w N
    let (rest, errs, qs) := cellTerms Ws' Ds' sts' t0 w N
    (st' :: rest, W.natAbs * err + errs, addL q qs)
  | _, _, _ => ([], 0, [])

/-- `WS` is the weights' scale; `w1N` is `w1·WS`; target `TN/TD`; `etaErr` the `|d − d~|` allowance over
`WS·S` (computed by the caller). -/
def cellOk (WS w1N TN TD : Int) (Ws Ds : List Int) (sts : List St) (t0 w : Int) (N : Nat) (etaErr : Int) :
    Option (List St) :=
  let (sts', errs, q) := cellTerms Ws Ds sts t0 w N
  -- q_n over WS·S^(n+1); add w1 to the constant term: w1N over WS → w1N·S over WS·S.
  let q := match q with | [] => [] | c :: l => (c + w1N * S) :: l
  let qc := commonDen N 0 q
  let qs := shiftAll w (N + 1) qc
  let den : Int := (S * 2 ^ (TB + 1)) ^ N * S   -- common denominator / WS
  match qs with
  | q0 :: q1 :: q2 :: rest =>
    let qm := quadMin q0 q1 q2 w
    let hi := higher w 0 (w * w * w) rest
    -- LB over WS·den: qm − hi
    let lb : QQ := QQ.sub qm ⟨hi, 1⟩
    -- error over WS·S: errs + etaErr  →  over WS·den: ×(den / S)
    let errQ : QQ := ⟨(errs + etaErr) * (den / S), 1⟩
    let lhs : QQ := QQ.sub lb errQ                       -- over WS·den
    let target : QQ := ⟨TN * WS * den, TD⟩               -- TN/TD over 1 → ×WS·den
    if QQ.le target lhs then some sts' else none
  | _ => none

/-- A run of cells: `(t0, w, N)` triples. -/
def cellsOk (WS w1N TN TD : Int) (Ws Ds : List Int) (etaOf : Int → Int) :
    List St → List (Int × Int × Nat) → Option (List St)
  | sts, [] => some sts
  | sts, (t0, w, N) :: cs =>
    match cellOk WS w1N TN TD Ws Ds sts t0 w N (etaOf (t0 + w)) with
    | some sts' => cellsOk WS w1N TN TD Ws Ds etaOf sts' cs
    | none => none

end KDB1
