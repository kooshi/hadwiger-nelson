/-!
# FS-66's fibre-density certificates, checked by the kernel (FS-131; jobs FS131-KC13 and FS131-IKC1)

**Read aloud.** `certOK C = true` says: the certificate `C` — FS-66's integer sum-of-squares certificate
(`data/fs66/b1/SOUNDNESS.md` § 4), re-encoded by `tools/fs131_ikc1_gen.py` — passes these checks, every one by kernel
reduction.

* **The identity** (`segCheck`). FS-66's (★), `U_num·y([]) − L·n·y([0]) = Σ T_block(y) + Σ lam·box(y)`, coefficient by
  coefficient. Its terms are the list `opList`. Every op of non-zero value takes one entry of the op stream: a slot and a
  witness `(c, d, e, o)`. In the segment owning the slot the kernel checks `c² + d² ≡ 1`, that the op's monomial has at
  most seven points, and that the bag key `Σ 8^x` of its image `g(x − o)` is the slot's key; in every segment it checks
  that the slot is owned by one of the `nseg` segments. The times-1 quadratic part is first summed over the orbits of rep
  pairs (`phase1`, each pair's transporter checked).
* **Positive definiteness** (`psdCheck`), by `s·R − M·Mᵀ` diagonally dominant, every digit of `M`'s packed rows bounded
  so that the Kronecker product carries nothing.
* **The shape** (`globalOK`): `p ≥ 2`, `L > 0`, `nseg > 0`, phase 1's transporters and bound, the q-part's transporters,
  every times-1 block of size `|reps| + 1`, every times-q block of size at least 2, every weight index in range.

What it implies is `FibreCertSound.sum_le_of_certOK`: every `φ : (ℤ/p)² → [0,1]` with `q(φ) ≥ 0` has
`Σφ ≤ U_num/L`.

**Kernel discipline** (measured, `plans/FS131-KC13-certificates.md` § 2.1): arithmetic by direct `Nat.*` calls; bulk data
as lists of 8-kbit hex literals; leaves salted in their low bits (the kernel's caches hash a literal by its low 64 bits).
-/

namespace HadwigerNelson.FibreCert

/-- The low `k` bits of `x`. -/
def lowBits (x k : Nat) : Nat := Nat.land x (Nat.sub (Nat.shiftLeft 1 k) 1)

/-- A field of `k` bits read as a signed integer with offset `2^(k-1)`. -/
def sfield (x k : Nat) : Int := Int.subNatNat x (Nat.shiftLeft 1 (Nat.sub k 1))

/-- Digit `k` of `x` at width `wB`. -/
def digit (x wB k : Nat) : Nat := lowBits (Nat.shiftRight x (Nat.mul wB k)) wB

/-- A reader over a stream of `k`-bit fields stored as a list of chunks of `per` fields each. -/
structure Rd where
  /-- the current chunk, already shifted past the fields read -/
  cur : Nat
  /-- fields left in the current chunk -/
  left : Nat
  /-- the chunks not yet started -/
  rest : List Nat

/-- Read one `k`-bit field. -/
def Rd.read (k per : Nat) (r : Rd) : Nat × Rd :=
  cond (Nat.beq r.left 0)
    (let c := r.rest.headD 0
     (lowBits c k, ⟨Nat.shiftRight c k, Nat.sub per 1, r.rest.tail⟩))
    (let c := r.cur
     (lowBits c k, ⟨Nat.shiftRight c k, Nat.sub r.left 1, r.rest⟩))

/-- Read `cnt` fields. -/
def Rd.readK (k per cnt : Nat) : Rd → List Nat × Rd :=
  Nat.rec (motive := fun _ => Rd → List Nat × Rd) (fun r => ([], r))
    (fun _ ih r => let x := r.read k per; let y := ih x.2; (x.1 :: y.1, y.2)) cnt

/-- The first `cnt` fields of a stream. -/
def readN (k per cnt : Nat) (chunks : List Nat) : List Nat := (Rd.readK k per cnt ⟨0, 0, chunks⟩).1

/-! ### The plane `(ℤ/p)²`, points coded `a·p + b` -/

/-- The point `(a, b)`. -/
def mkP (p a b : Nat) : Nat := Nat.add (Nat.mul a p) b
/-- `x + y`. -/
def addP (p x y : Nat) : Nat :=
  mkP p (Nat.mod (Nat.add (Nat.div x p) (Nat.div y p)) p) (Nat.mod (Nat.add (Nat.mod x p) (Nat.mod y p)) p)
/-- `x - o`. -/
def subP (p x o : Nat) : Nat :=
  mkP p (Nat.mod (Nat.sub (Nat.add (Nat.div x p) p) (Nat.mod (Nat.div o p) p)) p)
    (Nat.mod (Nat.sub (Nat.add (Nat.mod x p) p) (Nat.mod o p)) p)
/-- The linear map `z ↦ s z` (`e = 0`) or `z ↦ s z̄` (`e ≠ 0`), `s = c + d i`, with `c, d < p`. -/
def gmap (p c d e x : Nat) : Nat :=
  let a := Nat.div x p
  let b := Nat.mod x p
  cond (Nat.beq e 0)
    (mkP p (Nat.mod (Nat.add (Nat.mul a c) (Nat.mul b (Nat.sub p d))) p) (Nat.mod (Nat.add (Nat.mul a d) (Nat.mul b c)) p))
    (mkP p (Nat.mod (Nat.add (Nat.mul a c) (Nat.mul b d)) p) (Nat.mod (Nat.add (Nat.mul a d) (Nat.mul b (Nat.sub p c))) p))
/-- `c² + d² ≡ 1 (mod p)`. -/
def isUnit (p c d : Nat) : Bool := Nat.beq (Nat.mod (Nat.add (Nat.mul c c) (Nat.mul d d)) p) 1
/-- `⟨u, x⟩ mod p`. -/
def dotP (p u x : Nat) : Nat :=
  Nat.mod (Nat.add (Nat.mul (Nat.div u p) (Nat.div x p)) (Nat.mul (Nat.mod u p) (Nat.mod x p))) p

/-- The bag key `Σ_x 8^x` of a list of points: for at most seven points its base-8 digits are their multiplicities. -/
def bag (l : List Nat) : Nat := l.foldl (fun a x => Nat.add a (Nat.shiftLeft 1 (Nat.mul 3 x))) 0

/-- The units of `(ℤ/p)²` with both maps each: the group `G` as a list of `(c, d, e)`, in code order. -/
def gList (p : Nat) : List (Nat × Nat × Nat) :=
  (List.range (Nat.mul p p)).foldr
    (fun x acc => cond (isUnit p (Nat.div x p) (Nat.mod x p)) ((Nat.div x p, Nat.mod x p, 0) :: (Nat.div x p, Nat.mod x p, 1) :: acc) acc) []

/-- The unit circle as a list of codes, ascending. -/
def sList (p : Nat) : List Nat :=
  (List.range (Nat.mul p p)).filter fun x => isUnit p (Nat.div x p) (Nat.mod x p)

/-! ### The certificate -/

/-- One PSD block of the certificate: weight indices, matrix size, field width of `R` (offset), row 0 and the
upper-triangular rows `1..m-1` as streams, and the PSD witness. -/
structure Blk where
  /-- the indices of the block's weight vectors -/
  wts : List Nat
  /-- the matrix size -/
  m : Nat
  /-- the field width of `R` (offset `2^(wr-1)`) -/
  wr : Nat
  /-- fields per chunk -/
  per : Nat
  /-- row 0 of `R` -/
  row0 : List Nat
  /-- rows `1..m-1` of `R`, upper-triangular -/
  rest : List Nat
  /-- the PSD witness's scale: `s = 2^sb + 1` -/
  sb : Nat
  /-- every digit of a row of `M` is below `2^wm` (offset `2^(wm-1) + 1`) -/
  wm : Nat
  /-- the Kronecker spacing -/
  wB : Nat
  /-- the rows of `M`, each with a 60-bit tag in digit 0 -/
  mrows : List Nat

/-- A certificate, everything a `Nat` or a list of hex chunks. -/
structure Cert where
  /-- the modulus `p` (the plane is `(ℤ/p)²`, `n = p²` points coded `a·p + b`) -/
  p : Nat
  /-- `L`: the bound is `U_num / L` -/
  scale : Nat
  /-- `U_num` -/
  unum : Nat
  /-- the value slot width: every in-range total stays below `2^w` -/
  w : Nat
  /-- `2^lb` slots per leaf -/
  lb : Nat
  /-- `2^ds` leaves per segment -/
  ds : Nat
  /-- the number of segments -/
  nseg : Nat
  /-- the key field width -/
  kb : Nat
  /-- per leaf, the packed keys of its slots -/
  keys : List Nat
  /-- the representative monomials of the times-1 blocks (at most two points each) -/
  reps : List (List Nat)
  /-- the field width of a weight's constant entry `c` (offset) -/
  wc : Nat
  /-- the field width of `f` (offset) -/
  wf : Nat
  /-- per weight vector `(c, u, f)`: `w_x = f(⟨u, x⟩)` -/
  weights : List (Nat × Nat × Nat)
  /-- the times-1 blocks -/
  blocks1 : List Blk
  /-- the times-q blocks -/
  blocksq : List Blk
  /-- the orbit representatives `(A0, A1)` of the unordered rep pairs -/
  orbits : List (List Nat × List Nat)
  /-- the orbit rows phase 1 computes, packed `(P, N)` over `t` at width `w`, as literals (checked once by `globalOK`,
  then read by every segment instead of recomputing phase 1) -/
  orows : List (Nat × Nat)
  /-- the phase-1 field width -/
  k1 : Nat
  /-- phase-1 fields per chunk -/
  per1 : Nat
  /-- the phase-1 stream: per pair `i ≤ j`, `(ρ·|G| + g)·2 + swap` -/
  p1 : List Nat
  /-- the norm-class representatives `t_ν` (`t_0 = 0`) -/
  tnu : List Nat
  /-- the q-transporter field width -/
  kq : Nat
  /-- q-transporter fields per chunk -/
  perq : Nat
  /-- per `t`, the field `ν·|G| + g` with `g(t_ν) = t` -/
  qt : List Nat
  /-- the point field width in a row -/
  kp : Nat
  /-- the row field width -/
  kr : Nat
  /-- row fields per chunk -/
  perr : Nat
  /-- the number of rows -/
  nrows : Nat
  /-- the rows: field `((lam·2^(4kp) + x3·2^(3kp) + … + x0)·8 + na)·8 + nb` -/
  rows : List Nat
  /-- the witness field width -/
  kw : Nat
  /-- the slot field width -/
  ko : Nat
  /-- op fields per chunk -/
  pero : Nat
  /-- the op stream: field `slot·2^kw + witness`, witness `((c·p + d)·2 + e)·n + o` -/
  ops : List Nat

/-! ### Matrices -/

/-- A block's matrix, decoded once from its streams: row `i` holds `R[i][i..m-1]`. Every check reads this copy. -/
def Blk.tri (b : Blk) : List (List Int) :=
  let toI := fun (l : List Nat) => l.map fun x => sfield x b.wr
  let rows := Nat.rec (motive := fun _ => Nat → Rd → List (List Int)) (fun _ _ => [])
    (fun _ ih len r => let x := Rd.readK b.wr b.per len r; toI x.1 :: ih (Nat.sub len 1) x.2)
    (Nat.sub b.m 1) (Nat.sub b.m 1) ⟨0, 0, b.rest⟩
  toI (readN b.wr b.per b.m b.row0) :: rows

/-- The symmetric matrix of a triangle: `R[i][j]` for `i ≤ j` from row `i`, else from row `j`. -/
def triGet (tri : List (List Int)) (i j : Nat) : Int :=
  cond (Nat.ble i j) ((tri.getD i []).getD (Nat.sub j i) 0) ((tri.getD j []).getD (Nat.sub i j) 0)

/-! ### Weights: `w_x = f(⟨u, x⟩)` -/

/-- `f(r)` of a weight. -/
def fval (C : Cert) (fp r : Nat) : Int := sfield (lowBits (Nat.shiftRight fp (Nat.mul C.wf r)) C.wf) C.wf

/-- `A(r) = p · Σ_j f(j) f(j + r)` (for `u ≠ 0`); `n · f(0)²` for `u = 0`. Then `κ(x) = A(⟨u, x⟩)`. -/
def autoc (C : Cert) (u fp r : Nat) : Int :=
  cond (Nat.beq u 0)
    (Int.mul (Int.ofNat (Nat.mul C.p C.p)) (Int.mul (fval C fp 0) (fval C fp 0)))
    (Int.mul (Int.ofNat C.p) ((List.range C.p).foldl
      (fun a j => Int.add a (Int.mul (fval C fp j) (fval C fp (Nat.mod (Nat.add j r) C.p)))) 0))

/-- Per weight: its direction `u` and `A(0), …, A(p-1)`; computed once (a closed term, shared by the kernel's cache). -/
def wtab (C : Cert) : List (Nat × List Int) :=
  C.weights.map fun (_, u, fp) => (u, (List.range C.p).map (autoc C u fp))

/-- `κ(x)` from a weight's table entry. -/
def kap (C : Cert) (e : Nat × List Int) (x : Nat) : Int :=
  e.2.getD (cond (Nat.beq e.1 0) 0 (dotP C.p e.1 x)) 0

/-- `κ(x)` of weight `wi`. -/
def kappa (C : Cert) (wi x : Nat) : Int := kap C ((wtab C).getD wi (0, [])) x

/-- `σ = Σ_x w_x`. -/
def sigma (C : Cert) (wi : Nat) : Int :=
  match C.weights.getD wi (0, 0, 0) with
  | (_, u, fp) => cond (Nat.beq u 0) (Int.mul (Int.ofNat (Nat.mul C.p C.p)) (fval C fp 0))
      (Int.mul (Int.ofNat C.p) ((List.range C.p).foldl (fun a j => Int.add a (fval C fp j)) 0))

/-- The weight's constant entry `c`. -/
def cval (C : Cert) (wi : Nat) : Int :=
  match C.weights.getD wi (0, 0, 0) with
  | (c, _, _) => sfield c C.wc

/-! ### Ops -/

/-- One term of the identity: the monomial `a ∪ (b + t)` with value `vp − vn`. -/
structure Op where
  /-- points -/
  a : List Nat
  /-- the shift of `b` -/
  t : Nat
  /-- points, shifted by `t` -/
  b : List Nat
  /-- the positive part of the value -/
  vp : Nat
  /-- the negative part of the value -/
  vn : Nat

/-- The op's monomial `a ∪ (b + t)`, as a list of codes. -/
def Op.mono (p : Nat) (o : Op) : List Nat := o.a ++ o.b.map fun x => addP p x o.t

/-- An op with an integer value. -/
def opI (a : List Nat) (t : Nat) (b : List Nat) (v : Int) : Op := ⟨a, t, b, Int.toNat v, Int.toNat (Int.neg v)⟩

/-! ### Phase 1: the orbit rows -/

/-- The table entries of a block's weights. -/
def btab (C : Cert) (b : Blk) : List (Nat × List Int) := let wt := wtab C; b.wts.map fun wi => wt.getD wi (0, [])

/-- `K_b(x) = Σ_{ŵ ∈ b} κ_ŵ(x)`, from the block's table entries `bt = btab C b`. -/
def kblock (C : Cert) (bt : List (Nat × List Int)) (x : Nat) : Int := bt.foldl (fun a e => Int.add a (kap C e x)) 0

/-- The packed rows `t ↦ max(±K_b(g t), 0)` (width `w`) for one map `g` and one block. -/
def krow (C : Cert) (bt : List (Nat × List Int)) (c d e : Nat) : Nat × Nat :=
  (List.range (Nat.mul C.p C.p)).foldr
    (fun t acc =>
      let v := kblock C bt (gmap C.p c d e t)
      (Nat.add (Nat.shiftLeft acc.1 C.w) (Int.toNat v), Nat.add (Nat.shiftLeft acc.2 C.w) (Int.toNat (Int.neg v))))
    (0, 0)

/-- For each map of `G`, its `(c, d, e)` and the packed `K` rows of every times-1 block. -/
def ktable (C : Cert) : List ((Nat × Nat × Nat) × List (Nat × Nat)) :=
  let bts := C.blocks1.map (btab C)
  (gList C.p).map fun g => (g, bts.map fun bt => krow C bt g.1 g.2.1 g.2.2)

/-- `max_x |K_b(x)|`: bounds every slot of every `K` row of the block. -/
def kmax (C : Cert) (b : Blk) : Nat :=
  let bt := btab C b
  (List.range (Nat.mul C.p C.p)).foldl (fun a x => Nat.max a (Int.natAbs (kblock C bt x))) 0

/-- The unordered pairs `i ≤ j` of rep indices, in row order. -/
def repPairs (nr : Nat) : List (Nat × Nat) :=
  (List.range nr).flatMap fun i => (List.range' i (Nat.sub nr i)).map fun j => (i, j)

/-- Rows `1..m-1` of a block's triangle, flattened: for a block of size `|reps| + 1` this is `R[1+i][1+j]` over the
pairs `i ≤ j` in row order (`repPairs`). -/
def Blk.pairCoefs (b : Blk) : List Int := (b.tri.drop 1).flatten

/-- An orbit row: its representative pair `(A0, A1)` and the packed positive and negative parts over `t`. -/
abbrev ORow := List Nat × List Nat × Nat × Nat

/-- A list cut into buckets of 16 (`fuel` buckets at most). -/
def bucket16 {α : Type} (l : List α) : List (List α) :=
  Nat.rec (motive := fun _ => List α → List (List α)) (fun _ => [])
    (fun _ ih l => cond l.isEmpty [] (l.take 16 :: ih (l.drop 16))) (Nat.add (Nat.div l.length 16) 1) l

/-- Orbit row `r` of a bucketed list. -/
def bget (l : List (List ORow)) (r : Nat) : ORow := (l.getD (Nat.div r 16) []).getD (Nat.mod r 16) ([], [], 0, 0)

/-- Orbit row `r` is present. -/
def bmem (l : List (List ORow)) (r : Nat) : Bool :=
  Nat.blt (Nat.div r 16) l.length && Nat.blt (Nat.mod r 16) (l.getD (Nat.div r 16) []).length

/-- Update orbit row `r`. -/
def bmod (l : List (List ORow)) (r : Nat) (f : ORow → ORow) : List (List ORow) :=
  l.modify (Nat.div r 16) fun b => b.modify (Nat.mod r 16) f

/-- The phase-1 state: the orbit rows in buckets, the transporters' verdict, the bound, the stream reader, and per
times-1 block the coefficients not yet used. -/
abbrev P1St := List (List ORow) × Bool × Nat × Rd × List (List Int)

/-- One pair `(i, j)` of phase 1: read its orbit `ρ`, map `g` and swap; check the transporter (`g A0 = a_i`,
`g A1 = a_j`, or swapped, as bag keys, every list of at most seven points); add
`mult · Σ_b R_b[1+i][1+j] · K_b(g t)` into row `ρ`, and its bound. -/
def p1step (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat)
    (s : P1St) (ij : Nat × Nat) : P1St :=
  let ng := Nat.mul 2 (Nat.add C.p 1)
  let rf := s.2.2.2.1.read C.k1 C.per1
  let f := rf.1
  let sw := Nat.mod f 2
  let f2 := Nat.div f 2
  let rho := Nat.div f2 ng
  let ent := kt.getD (Nat.mod f2 ng) ((0, 0, 0), [])
  let g := ent.1
  let mult : Int := cond (Nat.beq ij.1 ij.2) 1 2
  let coefs := s.2.2.2.2.map fun l => Int.mul mult (l.headD 0)
  let prs := coefs.zip ent.2
  let bnd := (coefs.zip km).foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) 0
  let ai := C.reps.getD ij.1 []
  let aj := C.reps.getD ij.2 []
  let orb := bget s.1 rho
  let g0 := orb.1.map (gmap C.p g.1 g.2.1 g.2.2)
  let g1 := orb.2.1.map (gmap C.p g.1 g.2.1 g.2.2)
  let good := (cond (Nat.beq sw 0) (Nat.beq (bag g0) (bag ai) && Nat.beq (bag g1) (bag aj))
      (Nat.beq (bag g0) (bag aj) && Nat.beq (bag g1) (bag ai))) &&
    bmem s.1 rho && isUnit C.p g.1 g.2.1 &&
    Nat.blt g0.length 8 && Nat.blt g1.length 8 && Nat.blt ai.length 8 && Nat.blt aj.length 8
  let addP := prs.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0
  let addN := prs.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0
  (bmod s.1 rho (fun o => (o.1, o.2.1, Nat.add o.2.2.1 addP, Nat.add o.2.2.2 addN)),
   s.2.1 && good, Nat.add s.2.2.1 bnd, rf.2, s.2.2.2.2.map List.tail)

/-- Phase 1 over the pairs `i ≤ j` of reps: the orbit rows, whether every transporter checked, and a bound
`Σ_pairs Σ_b |coef|·max|K_b|` on every slot of every orbit row. -/
def phase1 (C : Cert) : List ORow × Bool × Nat :=
  let r := (repPairs C.reps.length).foldl (p1step C (ktable C) (C.blocks1.map (kmax C)))
    (bucket16 (C.orbits.map (fun o => (o.1, o.2, 0, 0))), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs)
  (r.1.flatten, r.2.1, r.2.2.1)

/-! ### The q-part -/

/-- The q-part: `α_[]`, `α_[0]`, `β_ν`, and whether every `t` has a checked class (`g(t_ν) = t`, `ν` in range). -/
def qcoefs (C : Cert) : Int × Int × List Int × Bool :=
  let n := Nat.mul C.p C.p
  let ng := Nat.mul 2 (Nat.add C.p 1)
  let gl := gList C.p
  let fs := readN C.kq C.perq n C.qt
  let ok := ((List.range n).zip fs).all fun x =>
    let g := gl.getD (Nat.mod x.2 ng) (0, 0, 0)
    Nat.blt (Nat.div x.2 ng) C.tnu.length && isUnit C.p g.1 g.2.1 &&
      Nat.beq (gmap C.p g.1 g.2.1 g.2.2 (C.tnu.getD (Nat.div x.2 ng) 0)) x.1
  let cls := (List.range n).zip (fs.map fun f => Nat.div f ng)
  let qb := C.blocksq.map fun b => (b.wts, b.tri)
  let a0 := qb.foldl (fun a b => b.1.foldl (fun a wi =>
      Int.add a (Int.mul (triGet b.2 0 0) (Int.mul (cval C wi) (cval C wi)))) a) 0
  let a1 := qb.foldl (fun a b => b.1.foldl (fun a wi =>
      Int.add a (Int.mul (Int.mul 2 (triGet b.2 0 1)) (Int.mul (cval C wi) (sigma C wi)))) a) 0
  let beta := (List.range C.tnu.length).map fun nu => qb.foldl (fun a b => b.1.foldl (fun a wi =>
      Int.add a (Int.mul (triGet b.2 1 1)
        (cls.foldl (fun s x => cond (Nat.beq x.2 nu) (Int.add s (kappa C wi x.1)) s) 0))) a) 0
  (a0, a1, beta, ok)

/-! ### The rows -/

/-- The rows `(A, B, lam)`, decoded. -/
def rowList (C : Cert) : List (List Nat × List Nat × Nat) :=
  (readN C.kr C.perr C.nrows C.rows).map fun f =>
    let nb := Nat.mod f 8
    let na := Nat.mod (Nat.div f 8) 8
    let pts := Nat.div f 64
    let xs := (List.range 4).map fun i => lowBits (Nat.shiftRight pts (Nat.mul C.kp i)) C.kp
    (xs.take na, (xs.drop na).take nb, Nat.shiftRight pts (Nat.mul 4 C.kp))

/-- The ops of `lam·Π_A φ·Π_B (1 − φ)` (negated if `neg`), by expanding `B` from the front:
`Π_{b::B}(1 − φ) = Π_B(1 − φ) − φ_b Π_B(1 − φ)`. -/
def boxOps (A : List Nat) (lam : Nat) : List Nat → Bool → List Op
  | [], neg => [⟨A, 0, [], cond neg 0 lam, cond neg lam 0⟩]
  | b :: B, neg => boxOps A lam B neg ++ boxOps (A ++ [b]) lam B (!neg)

/-! ### The identity's terms -/

/-- (O1) the left side, moved over: `−U_num` at `[]`, `L·n` at `[0]`. -/
def opsO1 (C : Cert) : List Op := [⟨[], 0, [], 0, C.unum⟩, ⟨[0], 0, [], Nat.mul C.scale (Nat.mul C.p C.p), 0⟩]

/-- (O2) the times-1 blocks' constant and linear terms. -/
def opsO2 (C : Cert) : List Op :=
  C.blocks1.flatMap fun b =>
    let tri := b.tri
    b.wts.flatMap fun wi =>
      let c := cval C wi
      let sg := sigma C wi
      opI [] 0 [] (Int.mul (triGet tri 0 0) (Int.mul c c)) ::
        (List.range C.reps.length).map fun a =>
          opI (C.reps.getD a []) 0 [] (Int.mul (Int.mul 2 (triGet tri 0 (Nat.add 1 a))) (Int.mul c sg))

/-- (O3) phase 2: every orbit row's slots. -/
def opsO3 (C : Cert) (rows : List (List Nat × List Nat × Nat × Nat)) : List Op :=
  rows.flatMap fun o => (List.range (Nat.mul C.p C.p)).map fun t =>
    ⟨o.1, t, o.2.1, digit o.2.2.1 C.w t, digit o.2.2.2 C.w t⟩

/-- The q-part's monomials and coefficients: `Σ cf · Q(m)`. -/
def qmonos (C : Cert) (qc : Int × Int × List Int × Bool) : List (List Nat × Int) :=
  ([], qc.1) :: ([0], qc.2.1) :: (C.tnu.zip qc.2.2.1).map fun x => ([0, x.1], x.2)

/-- (O4) the q-part: `Q(m) = 2 Σ_x y(m ∪ x) − 2 Σ_x y(m ∪ x ∪ x) − Σ_x Σ_{s ∈ S} y(m ∪ x ∪ (x + s))`. -/
def opsO4 (C : Cert) (qc : Int × Int × List Int × Bool) : List Op :=
  let sl := sList C.p
  (qmonos C qc).flatMap fun mc => (List.range (Nat.mul C.p C.p)).flatMap fun x =>
    opI mc.1 0 [x] (Int.mul 2 mc.2) :: opI mc.1 0 [x, x] (Int.neg (Int.mul 2 mc.2)) ::
      sl.map fun s => opI mc.1 0 [x, addP C.p x s] (Int.neg mc.2)

/-- (O5) the rows. -/
def opsO5 (C : Cert) : List Op := (rowList C).flatMap fun r => boxOps r.1 r.2.2 r.2.1 false

/-- The orbit rows as the segments read them: `(A0, A1, P, N)` from the certificate's literals. -/
def orbRows (C : Cert) : List ORow := (C.orbits.zip C.orows).map fun x => (x.1.1, x.1.2, x.2.1, x.2.2)

/-- Phase 1's rows are the certificate's literals. -/
def orowsOK (C : Cert) : Bool :=
  let r := (phase1 C).1
  Nat.beq r.length C.orows.length && Nat.beq C.orbits.length C.orows.length &&
    (r.zip C.orows).all fun x => Nat.beq x.1.2.2.1 x.2.1 && Nat.beq x.1.2.2.2 x.2.2

/-- Every term of the identity, in the stream's order. -/
def opList (C : Cert) (rows : List (List Nat × List Nat × Nat × Nat)) (qc : Int × Int × List Int × Bool) : List Op :=
  opsO1 C ++ opsO2 C ++ opsO3 C rows ++ opsO4 C qc ++ opsO5 C

/-! ### The segment check -/

/-- The scatter state: the op-stream reader, the segment's leaves `(keys, pos, neg)`, the in-range total, the verdict. -/
structure St where
  /-- the op-stream reader -/
  rd : Rd
  /-- the segment's leaves -/
  leaves : List (Nat × Nat × Nat)
  /-- the in-range total magnitude -/
  tot : Nat
  /-- every check so far -/
  ok : Bool

/-! The hot path is written without `let` chains: the kernel instantiates a `let` by copying the rest of its body,
so a chain of `k` lets costs `k` copies per op. Each decoded quantity is a small function of the stream field. -/

/-- The witness part `((c·p + d)·2 + e)·n + o` of an op-stream field. -/
def fwit (C : Cert) (f : Nat) : Nat := lowBits f C.kw
/-- The witness's origin `o`. -/
def fO (C : Cert) (f : Nat) : Nat := Nat.mod (fwit C f) (Nat.mul C.p C.p)
/-- `(c·p + d)·2 + e`. -/
def fR (C : Cert) (f : Nat) : Nat := Nat.div (fwit C f) (Nat.mul C.p C.p)
/-- The witness's `e`. -/
def fE (C : Cert) (f : Nat) : Nat := Nat.mod (fR C f) 2
/-- The witness's `d`. -/
def fD (C : Cert) (f : Nat) : Nat := Nat.mod (Nat.div (fR C f) 2) C.p
/-- The witness's `c`. -/
def fC (C : Cert) (f : Nat) : Nat := Nat.mod (Nat.div (Nat.div (fR C f) 2) C.p) C.p
/-- The field's slot. -/
def fSlot (C : Cert) (f : Nat) : Nat := Nat.shiftRight f C.kw
/-- The field's leaf. -/
def fLeaf (C : Cert) (f : Nat) : Nat := Nat.shiftRight (fSlot C f) C.lb
/-- The field's segment. -/
def fSeg (C : Cert) (f : Nat) : Nat := Nat.shiftRight (fLeaf C f) C.ds
/-- The witness map `x ↦ g(x − o)` of a field. -/
def fImg (C : Cert) (f x : Nat) : Nat := gmap C.p (fC C f) (fD C f) (fE C f) (subP C.p x (fO C f))
/-- `bag (l.map g)`, unrolled to four points (structural recursion on a list costs the kernel a `brecOn` per step). -/
def bagMap (g : Nat → Nat) (l : List Nat) : Nat :=
  match l with
  | [] => 0
  | [x] => Nat.shiftLeft 1 (Nat.mul 3 (g x))
  | [x, y] => Nat.add (Nat.shiftLeft 1 (Nat.mul 3 (g x))) (Nat.shiftLeft 1 (Nat.mul 3 (g y)))
  | [x, y, z] => Nat.add (Nat.add (Nat.shiftLeft 1 (Nat.mul 3 (g x))) (Nat.shiftLeft 1 (Nat.mul 3 (g y))))
      (Nat.shiftLeft 1 (Nat.mul 3 (g z)))
  | [x, y, z, v] => Nat.add (Nat.add (Nat.shiftLeft 1 (Nat.mul 3 (g x))) (Nat.shiftLeft 1 (Nat.mul 3 (g y))))
      (Nat.add (Nat.shiftLeft 1 (Nat.mul 3 (g z))) (Nat.shiftLeft 1 (Nat.mul 3 (g v))))
  | l => bag (l.map g)

/-- `l.length`, unrolled to four. -/
def lenU (l : List Nat) : Nat :=
  match l with
  | [] => 0
  | [_] => 1
  | [_, _] => 2
  | [_, _, _] => 3
  | [_, _, _, _] => 4
  | l => l.length

/-- The bag key of an op's monomial `a ∪ (b + t)` under a field's witness. -/
def fKey (C : Cert) (f : Nat) (o : Op) : Nat :=
  Nat.add (bagMap (fImg C f) o.a) (bagMap (fun x => fImg C f (addP C.p x o.t)) o.b)
/-- The key the field's slot holds in a leaf's packed keys. -/
def slotKey (C : Cert) (f keys : Nat) : Nat := lowBits (Nat.shiftRight keys (Nat.mul C.kb (lowBits (fSlot C f) C.lb))) C.kb
/-- The op's checks in its own segment: key, unit, at most seven points. -/
def opGood (C : Cert) (f keys : Nat) (o : Op) : Bool :=
  Nat.beq (slotKey C f keys) (fKey C f o) && isUnit C.p (fC C f) (fD C f) && Nat.blt (Nat.add (lenU o.a) (lenU o.b)) 8
/-- Add `vp`, `vn` into the field's slot of a leaf, with a salt in the low bits of both parts. -/
def leafAdd (C : Cert) (f vp vn salt : Nat) (l : Nat × Nat × Nat) : Nat × Nat × Nat :=
  (l.1, Nat.add l.2.1 (Nat.add (Nat.shiftLeft vp (Nat.mul C.w (Nat.add (lowBits (fSlot C f) C.lb) 1))) salt),
    Nat.add l.2.2 (Nat.add (Nat.shiftLeft vn (Nat.mul C.w (Nat.add (lowBits (fSlot C f) C.lb) 1))) salt))

/-- An op of non-zero value with its stream field `rf.1` read: every segment checks the slot is owned by a segment
below `nseg`; the owning segment checks the witness and the key, and adds the value into the slot. -/
def St.op1 (C : Cert) (seg : Nat) (st : St) (o : Op) (rf : Nat × Rd) : St :=
  cond (Nat.beq (fSeg C rf.1) seg)
    ⟨rf.2, st.leaves.modify (lowBits (fLeaf C rf.1) C.ds) (leafAdd C rf.1 o.vp o.vn (Nat.add 1 (lowBits st.tot 16))),
      Nat.add st.tot (Nat.add o.vp o.vn),
      st.ok && Nat.blt (fSeg C rf.1) C.nseg &&
        opGood C rf.1 (st.leaves.getD (lowBits (fLeaf C rf.1) C.ds) (0, 0, 0)).1 o⟩
    ⟨rf.2, st.leaves, st.tot, st.ok && Nat.blt (fSeg C rf.1) C.nseg⟩

/-- One op. A zero value reads nothing; otherwise `St.op1` with its stream field. -/
def St.op (C : Cert) (seg : Nat) (st : St) (o : Op) : St :=
  cond (Nat.beq (Nat.add o.vp o.vn) 0) st (St.op1 C seg st o (st.rd.read (Nat.add C.kw C.ko) C.pero))

/-- One segment of the identity check: every op through `St.op`, then every leaf balanced and the total in range. -/
def segCheck (C : Cert) (seg : Nat) : Bool :=
  let leaves := (List.range (Nat.shiftLeft 1 C.ds)).map fun k =>
    (C.keys.getD (Nat.add (Nat.mul seg (Nat.shiftLeft 1 C.ds)) k) 0, 0, 0)
  let st := (opList C (orbRows C) (qcoefs C)).foldl (St.op C seg) ⟨⟨0, 0, C.ops⟩, leaves, 0, true⟩
  st.ok && Nat.blt st.tot (Nat.shiftLeft 1 C.w) && st.leaves.all fun l => Nat.beq l.2.1 l.2.2

/-! ### Positive definiteness: `s·R − M·Mᵀ` diagonally dominant -/

/-- An integer is non-negative. -/
def nonneg : Int → Bool
  | .ofNat _ => true
  | .negSucc _ => false

/-- The full symmetric rows of a triangle of size `m`: row `i` is `R[i][0..m-1]`, its part left of the diagonal read
down the columns (the tails of the rows above, one entry dropped per step). -/
def symRows (tri : List (List Int)) (m : Nat) : List (List Int) :=
  (Nat.rec (motive := fun _ => List (List Int) × List (List Int) × List (List Int) → List (List Int) × List (List Int) × List (List Int))
    (fun s => s)
    (fun _ ih s =>
      let r := s.2.1.headD []
      ih (s.1 ++ [s.2.2.map (fun t => t.headD 0) ++ r], s.2.1.tail, s.2.2.map List.tail ++ [r.tail]))
    m ([], tri, [])).1

/-- The block's PSD check. The rows of `M` are packed at width `wB` with a tag in digit 0 and `M[i][k] + Cm` in digit
`k + 1`, `Cm = 2^(wm-1) + 1`; every digit is below `2^wm`, each row below `2^(wB(m+1))`, and `(m+1)·4^wm < 2^wB`, so
digit `m + 1` of `row_i · rev_j` (`rev_j` the row reversed, tag kept) is `Σ_k (M + Cm)[i][k] (M + Cm)[j][k]` exactly.
With `R` the block's matrix (`symRows b.tri m`) and `s = 2^sb + 1`, every row of `E = s·R − M·Mᵀ` has
`E_ii ≥ Σ_{j≠i} |E_ij|`. -/
def psdCheck (b : Blk) : Bool :=
  let m := b.m
  let B := Nat.shiftLeft 1 b.wB
  let A := Nat.shiftLeft 1 b.wm
  let Cm := Nat.add (Nat.shiftLeft 1 (Nat.sub b.wm 1)) 1
  let rows := b.mrows
  let digs := rows.map fun f => (List.range (Nat.add m 1)).map (digit f b.wB)
  let okB := Nat.beq rows.length m && rows.all (fun f => Nat.blt f (Nat.shiftLeft 1 (Nat.mul b.wB (Nat.add m 1)))) &&
    digs.all (fun ds => ds.all fun x => Nat.blt x A) && Nat.blt (Nat.mul (Nat.add m 1) (Nat.mul A A)) B
  let rev := digs.map fun ds => Nat.add (ds.headD 0) (Nat.mul (ds.tail.foldl (fun a d => Nat.add (Nat.mul a B) d) 0) B)
  let sig := digs.map fun ds => ds.tail.foldl Nat.add 0
  let s : Int := Int.ofNat (Nat.add (Nat.shiftLeft 1 b.sb) 1)
  let corr : Int := Int.ofNat (Nat.mul m (Nat.mul Cm Cm))
  let rj := rev.zip sig
  let rowOK := fun (i : Nat) (fi si : Nat) (Ri : List Int) =>
    let r := (Ri.zip rj).foldl (fun (a : Nat × Int × Int) x =>
      let e := Int.sub (Int.mul s x.1)
        (Int.add (Int.subNatNat (digit (Nat.mul fi x.2.1) b.wB (Nat.add m 1)) (Nat.mul Cm (Nat.add si x.2.2))) corr)
      cond (Nat.beq a.1 i) (Nat.add a.1 1, e, a.2.2) (Nat.add a.1 1, a.2.1, Int.add a.2.2 (Int.ofNat (Int.natAbs e))))
      (0, 0, 0)
    nonneg (Int.sub r.2.1 r.2.2)
  let all := ((rows.zip sig).zip (symRows b.tri m)).foldl (fun (a : Nat × Bool) x =>
      (Nat.add a.1 1, a.2 && rowOK a.1 x.1.1 x.1.2 x.2)) (0, true)
  okB && all.2

/-- Every block of the certificate passes `psdCheck`. -/
def psdAll (C : Cert) : Bool := (C.blocks1 ++ C.blocksq).all psdCheck

/-- Every segment of the identity passes. -/
def segAll (C : Cert) : Bool := (List.range C.nseg).all (segCheck C)

/-- The shape: `p ≥ 2`, `L > 0`, `nseg > 0`; phase 1's transporters and its bound below `2^w`, its rows the
certificate's literals; the q-part's
transporters; every times-1 block of size `|reps| + 1` and every times-q block of size at least 2; every weight
index in range. -/
def globalOK (C : Cert) : Bool :=
  let ph := phase1 C
  Nat.ble 2 C.p && Nat.blt 0 C.scale && Nat.blt 0 C.nseg && ph.2.1 && Nat.blt ph.2.2 (Nat.shiftLeft 1 C.w) &&
    orowsOK C &&
    (qcoefs C).2.2.2 && C.blocks1.all (fun b => Nat.beq b.m (Nat.add C.reps.length 1)) &&
    C.blocksq.all (fun b => Nat.ble 2 b.m) &&
    (C.blocks1 ++ C.blocksq).all (fun b => b.wts.all fun wi => Nat.blt wi C.weights.length)

/-- **The certificate check**: the shape, the identity and positive definiteness. -/
def certOK (C : Cert) : Bool := globalOK C && segAll C && psdAll C

end HadwigerNelson.FibreCert
