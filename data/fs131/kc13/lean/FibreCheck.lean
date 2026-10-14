-- FS131-KC13: the kernel checker for FS-66's fibre-density certificates (core only; no Mathlib).
-- Kernel discipline (measured in data/fs131/kc13/probes): every arithmetic step is a direct `Nat.*` call, never
-- notation (instance chains cost 4-5x in the kernel); every loop is `Nat.rec` over an exact count (structural
-- recursion adds a `brecOn` per step); bulk data is lists of 8-kbit hex literals (a single 1 MB literal takes minutes
-- to parse); signed data is offset-encoded in fixed-width fields.
namespace HadwigerNelson.FibreCert

/-- The low `k` bits of `x`. -/
def lowBits (x k : Nat) : Nat := Nat.land x (Nat.sub (Nat.shiftLeft 1 k) 1)

/-- A field of `k` bits read as a signed integer with offset `2^(k-1)`. -/
def sfield (x k : Nat) : Int := Int.subNatNat x (Nat.shiftLeft 1 (Nat.sub k 1))

/-- A reader over a stream of `k`-bit fields stored as a list of chunks of `per` fields each. -/
structure Rd where
  cur : Nat
  left : Nat
  rest : List Nat

/-- Read one `k`-bit field. -/
def Rd.read (k per : Nat) (r : Rd) : Nat × Rd :=
  cond (Nat.beq r.left 0)
    (let c := r.rest.headD 0
     (lowBits c k, ⟨Nat.shiftRight c k, Nat.sub per 1, r.rest.tail⟩))
    (let c := r.cur
     (lowBits c k, ⟨Nat.shiftRight c k, Nat.sub r.left 1, r.rest⟩))

/-! ### The plane `(ℤ/p)²`, points coded `a·p + b` -/

/-- The point `(a, b)`. -/
def mkP (p a b : Nat) : Nat := Nat.add (Nat.mul a p) b
/-- `x + y`. -/
def addP (p x y : Nat) : Nat :=
  mkP p (Nat.mod (Nat.add (Nat.div x p) (Nat.div y p)) p) (Nat.mod (Nat.add (Nat.mod x p) (Nat.mod y p)) p)
/-- `x - o`. -/
def subP (p x o : Nat) : Nat :=
  mkP p (Nat.mod (Nat.sub (Nat.add (Nat.div x p) p) (Nat.div o p)) p)
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

/-- The power-sum key `p₁ + p₂·2¹¹ + p₃·2³¹ + p₄·2⁶⁰` of `y = f x + 1` over a list of points (dense, so that the kernel's
caches, which hash a literal by its low 64 bits, do not collide); unrolled to length four, a fold beyond. -/
def bagWith (f : Nat → Nat) (m : List Nat) : Nat :=
  let k := fun x => let y := Nat.add (f x) 1; let y2 := Nat.mul y y
    Nat.add (Nat.add y (Nat.shiftLeft y2 11)) (Nat.add (Nat.shiftLeft (Nat.mul y2 y) 31) (Nat.shiftLeft (Nat.mul y2 y2) 60))
  match m with
  | [] => 0
  | [x] => k x
  | [x, y] => Nat.add (k x) (k y)
  | [x, y, z] => Nat.add (Nat.add (k x) (k y)) (k z)
  | [x, y, z, v] => Nat.add (Nat.add (k x) (k y)) (Nat.add (k z) (k v))
  | l => l.foldl (fun a x => Nat.add a (k x)) 0

/-- The units of `(ℤ/p)²` with both maps each: the group `G` as a list of `(c, d, e)`, in code order. -/
def gList (p : Nat) : List (Nat × Nat × Nat) :=
  (List.range (Nat.mul p p)).foldr
    (fun x acc => cond (isUnit p (Nat.div x p) (Nat.mod x p)) ((Nat.div x p, Nat.mod x p, 0) :: (Nat.div x p, Nat.mod x p, 1) :: acc) acc) []

/-- The unit circle as a list of codes, ascending. -/
def sList (p : Nat) : List Nat :=
  (List.range (Nat.mul p p)).filter fun x => isUnit p (Nat.div x p) (Nat.mod x p)

/-! ### The accumulator: a complete binary tree of leaves of `2^lb` slots -/

/-- A leaf holds the packed keys of its slots and two packed accumulators (positive and negative parts). -/
inductive Tr where
  | leaf (keys pos neg : Nat)
  | node (l r : Tr)

/-- Build a complete tree of depth `d` from a list of leaf keys. -/
def Tr.build (d : Nat) : List Nat → Tr × List Nat :=
  Nat.rec (motive := fun _ => List Nat → Tr × List Nat)
    (fun l => (.leaf (l.headD 0) 0 0, l.tail))
    (fun _ ih l => let a := ih l; let b := ih a.2; (.node a.1 b.1, b.2)) d

/-- At leaf `i` (depth `d`), slot `s`: add `vp`, `vn` (shifted by `w·s`); if the slot's key (width `kb`) is not `kc`,
add `poison` to the positive part. -/
def Tr.upd (kb w poison salt s kc vp vn : Nat) (d : Nat) : Tr → Nat → Tr :=
  Nat.rec (motive := fun _ => Tr → Nat → Tr)
    (fun t _ => match t with
      | .leaf ks ps ns =>
          let sh := Nat.mul w (Nat.add s 1)
          .leaf ks (Nat.add (Nat.add ps (Nat.add (Nat.shiftLeft vp sh) salt))
                      (cond (Nat.beq (lowBits (Nat.shiftRight ks (Nat.mul kb s)) kb) kc) 0 poison))
            (Nat.add ns (Nat.add (Nat.shiftLeft vn sh) salt))
      | .node l r => .node l r)
    (fun d ih t i => match t with
      | .leaf ks ps ns => .leaf ks ps ns
      | .node l r => cond (Nat.beq (Nat.land (Nat.shiftRight i d) 1) 1) (.node l (ih r i)) (.node (ih l i) r)) d

/-- Every leaf balanced: `pos = neg`. -/
def Tr.balanced : Tr → Bool
  | .leaf _ ps ns => Nat.beq ps ns
  | .node l r => Tr.balanced l && Tr.balanced r

/-! ### The certificate -/

/-- One PSD block of the certificate: weight indices, matrix size, field width of `R` (offset), row 0 and the
upper-triangular rows `1..m-1` as streams. -/
structure Blk where
  wts : List Nat
  m : Nat
  wr : Nat
  per : Nat
  row0 : List Nat
  rest : List Nat
  /-- the PSD witness: `s = 2^sb`; the rows of `M`, entries offset by `2^(wm-1)`, packed at spacing `wB` -/
  sb : Nat
  wm : Nat
  wB : Nat
  mrows : List Nat

/-- A certificate, everything a `Nat` or a list of hex chunks. -/
structure Cert where
  p : Nat
  scale : Nat
  unum : Nat
  /-- value slot width: the in-range total must stay below `2^w` -/
  w : Nat
  /-- slots per leaf `2^lb`; segment depth `ds` (leaves per segment `2^ds`); number of segments -/
  lb : Nat
  ds : Nat
  nseg : Nat
  /-- key field width -/
  kb : Nat
  /-- per leaf, the packed bag keys of its slots (`3n` bits each) -/
  keys : List Nat
  reps : List (List Nat)
  /-- weights: offset `c` (`wc` bits), the plane-wave direction `u`, `f` packed (`p` fields of `wf` bits, offset) -/
  wc : Nat
  wf : Nat
  weights : List (Nat × Nat × Nat)
  blocks1 : List Blk
  blocksq : List Blk
  /-- orbit representatives `(A0, A1)` of the unordered rep pairs, and the depth of their tree -/
  orbits : List (List Nat × List Nat)
  od : Nat
  /-- phase-1 stream: per pair `i ≤ j`, `(ρ·|G| + g)·2 + swap`, `k1` bits, `per1` per chunk -/
  k1 : Nat
  per1 : Nat
  p1 : List Nat
  /-- the norm-class representatives `t_ν`, and per `t` the field `ν·|G| + g` with `g(t_ν) = t` -/
  tnu : List Nat
  kq : Nat
  perq : Nat
  qt : List Nat
  /-- rows: field `((lam·2^(4kp) + x3·2^(3kp) + … + x0)·8 + na)·8 + nb`, `kr` bits -/
  kp : Nat
  kr : Nat
  perr : Nat
  nrows : Nat
  rows : List Nat
  /-- op stream: field `slot·2^kw + witness`, witness `((c·p + d)·2 + e)·n + o` -/
  kw : Nat
  ko : Nat
  pero : Nat
  ops : List Nat

/-! ### Weights: `w_x = f(⟨u, x⟩)` -/

/-- `f(r)` of a weight. -/
def fval (C : Cert) (fp r : Nat) : Int := sfield (lowBits (Nat.shiftRight fp (Nat.mul C.wf r)) C.wf) C.wf

/-- `A(r) = p · Σ_j f(j) f(j + r)` (for `u ≠ 0`); `n · f(0)²` for `u = 0`. Then `κ(x) = A(⟨u, x⟩)`. -/
def autoc (C : Cert) (u fp r : Nat) : Int :=
  cond (Nat.beq u 0)
    (Int.mul (Int.ofNat (Nat.mul C.p C.p)) (Int.mul (fval C fp 0) (fval C fp 0)))
    (Int.mul (Int.ofNat C.p) ((List.range C.p).foldl
      (fun a j => Int.add a (Int.mul (fval C fp j) (fval C fp (Nat.mod (Nat.add j r) C.p)))) 0))

/-- The width of a packed autocorrelation field, and its offset. -/
def wa : Nat := 160

/-- Per weight: its direction `u` and `A(0), …, A(p-1)` packed in `wa`-bit fields with offset `2^(wa-1)`; computed
once (the table is a closed term, so the kernel's cache shares it). -/
def wtab (C : Cert) : List (Nat × Nat) :=
  C.weights.map fun (_, u, fp) =>
    (u, (List.range C.p).foldr (fun r acc => Nat.add (Nat.shiftLeft acc wa)
          (Int.toNat (Int.add (autoc C u fp r) (Int.ofNat (Nat.shiftLeft 1 (Nat.sub wa 1)))))) 0)

/-- `κ(x)` from a weight's table entry. -/
def kap (C : Cert) (e : Nat × Nat) (x : Nat) : Int :=
  sfield (lowBits (Nat.shiftRight e.2 (Nat.mul wa (cond (Nat.beq e.1 0) 0 (dotP C.p e.1 x)))) wa) wa

/-- `κ(x)` of weight `wi`. -/
def kappa (C : Cert) (wi x : Nat) : Int := kap C ((wtab C).getD wi (0, 0)) x

/-- `σ = Σ_x w_x`. -/
def sigma (C : Cert) (wi : Nat) : Int :=
  match C.weights.getD wi (0, 0, 0) with
  | (_, u, fp) => cond (Nat.beq u 0) (Int.mul (Int.ofNat (Nat.mul C.p C.p)) (fval C fp 0))
      (Int.mul (Int.ofNat C.p) ((List.range C.p).foldl (fun a j => Int.add a (fval C fp j)) 0))

/-- The weight's constant entry `c`. -/
def cval (C : Cert) (wi : Nat) : Int :=
  match C.weights.getD wi (0, 0, 0) with
  | (c, _, _) => sfield c C.wc

/-! ### The main state of a segment -/

/-- The scatter state: the op-stream reader, the segment's tree, the in-range total, and the failure flag. -/
structure St where
  rd : Rd
  tr : Tr
  tot : Nat
  ok : Bool

/-- The bag key of the image of `pts + sh` under the witness `(c, d, e, o)`: `Σ 8^(g(x + sh - o))`. -/
def keyW (p c d e o sh : Nat) (pts : List Nat) : Nat := bagWith (fun x => gmap p c d e (subP p (addP p x sh) o)) pts

/-- One op: a monomial given by its key function `kf c d e o` (the bag key of its image under a witness), value
`vp - vn`. A zero value reads nothing; an out-of-segment slot is skipped. -/
def St.op (C : Cert) (seg : Nat) (kf : Nat → Nat → Nat → Nat → Nat) (vp vn : Nat) (st : St) : St :=
  cond (Nat.beq (Nat.add vp vn) 0) st
    (let n := Nat.mul C.p C.p
     let rf := st.rd.read (Nat.add C.kw C.ko) C.pero
     let f := rf.1
     let slot := Nat.shiftRight f C.kw
     let leaf := Nat.shiftRight slot C.lb
     cond (Nat.beq (Nat.shiftRight leaf C.ds) seg)
       (let wit := lowBits f C.kw
        let o := Nat.mod wit n
        let r1 := Nat.div wit n
        let e := Nat.mod r1 2
        let cd := Nat.div r1 2
        let d := Nat.mod cd C.p
        let c := Nat.mod (Nat.div cd C.p) C.p
        ⟨rf.2, Tr.upd C.kb C.w (Nat.shiftLeft 1 (Nat.mul C.w (Nat.add (Nat.shiftLeft 1 C.lb) 1)))
                 (Nat.add 1 (lowBits st.tot 16)) (lowBits slot C.lb) (kf c d e o) vp vn C.ds st.tr (lowBits leaf C.ds),
         Nat.add st.tot (Nat.add vp vn), st.ok && isUnit C.p c d⟩)
       ⟨rf.2, st.tr, st.tot, st.ok⟩)

/-- An op with an integer value. -/
def St.opI (C : Cert) (seg : Nat) (kf : Nat → Nat → Nat → Nat → Nat) (v : Int) (st : St) : St :=
  St.op C seg kf (Int.toNat v) (Int.toNat (Int.neg v)) st

/-- The key function of a monomial given as a list. -/
def kfL (p : Nat) (m : List Nat) : Nat → Nat → Nat → Nat → Nat := fun c d e o => keyW p c d e o 0 m

/-! ### Phase 1: the orbit rows -/

/-- An orbit row: its representative pair and the packed positive and negative parts over `t`. -/
inductive OT where
  | leaf (a0 a1 : List Nat) (P N : Nat)
  | node (l r : OT)

/-- Build the orbit tree of depth `d` from the orbit list (missing leaves are empty). -/
def OT.build (d : Nat) : List (List Nat × List Nat) → OT × List (List Nat × List Nat) :=
  Nat.rec (motive := fun _ => List (List Nat × List Nat) → OT × List (List Nat × List Nat))
    (fun l => (.leaf (l.headD ([], [])).1 (l.headD ([], [])).2 0 0, l.tail))
    (fun _ ih l => let a := ih l; let b := ih a.2; (.node a.1 b.1, b.2)) d

/-- At orbit leaf `i`: check the transporter (`g a0 = ai`, `g a1 = aj`, or swapped, as bag keys) and add the packed
rows. Returns the tree and whether the transporter checked. -/
def OT.upd (p c d e sw ki kj : Nat) (addP addN : Nat → Nat → Nat) (dd : Nat) : OT → Nat → OT × Bool :=
  Nat.rec (motive := fun _ => OT → Nat → OT × Bool)
    (fun t _ => match t with
      | .leaf a0 a1 P N =>
          let g0 := bagWith (gmap p c d e) a0
          let g1 := bagWith (gmap p c d e) a1
          let good := cond (Nat.beq sw 0) (Nat.beq g0 ki && Nat.beq g1 kj) (Nat.beq g0 kj && Nat.beq g1 ki)
          (.leaf a0 a1 (addP P N) (addN P N), good)
      | .node l r => (.node l r, false))
    (fun dd ih t i => match t with
      | .leaf a0 a1 P N => (.leaf a0 a1 P N, false)
      | .node l r => cond (Nat.beq (Nat.land (Nat.shiftRight i dd) 1) 1)
          (let x := ih r i; (.node l x.1, x.2)) (let x := ih l i; (.node x.1 r, x.2))) dd

/-- The orbit rows in order. -/
def OT.toList : OT → List (List Nat × List Nat × Nat × Nat)
  | .leaf a0 a1 P N => [(a0, a1, P, N)]
  | .node l r => OT.toList l ++ OT.toList r

/-- The table entries of a block's weights. -/
def btab (C : Cert) (b : Blk) : List (Nat × Nat) := let wt := wtab C; b.wts.map fun wi => wt.getD wi (0, 0)

/-- `K_b(x) = Σ_{ŵ ∈ b} κ_ŵ(x)`, from the block's table entries `bt = btab C b`. -/
def kblock (C : Cert) (bt : List (Nat × Nat)) (x : Nat) : Int := bt.foldl (fun a e => Int.add a (kap C e x)) 0

/-- The packed rows `t ↦ max(±K_b(g t), 0)` (width `w`) for one map `g` and one block. -/
def krow (C : Cert) (bt : List (Nat × Nat)) (c d e : Nat) : Nat × Nat :=
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

/-- Phase 1 over the pairs `i ≤ j` of reps: returns the orbit tree, whether every transporter checked, and a bound
`Σ_pairs Σ_b |coef|·max|K_b|` on every slot of every orbit row. -/
def phase1 (C : Cert) : OT × Bool × Nat :=
  let nr := C.reps.length
  let ng := Nat.mul 2 (Nat.add C.p 1)
  let kt := ktable C
  let km := C.blocks1.map (kmax C)
  let t0 := (OT.build C.od C.orbits).1
  let rd0 : List Rd := C.blocks1.map fun b => (⟨0, 0, b.rest⟩ : Rd)
  -- state: orbit tree, ok, bound, p1 reader, per-block readers of the upper-triangular rows (positioned at row 1)
  let outer := Nat.rec (motive := fun _ => List (List Nat) → OT × Bool × Nat × Rd × List Rd → OT × Bool × Nat × Rd × List Rd)
    (fun _ s => s)
    (fun _ ih reps s =>
      match reps with
      | [] => s
      | ai :: tl =>
        let ki := bagWith id ai
        -- inner loop over j ≥ i (the list `ai :: tl`); `mult` is 1 on the diagonal, 2 off it
        let inner := Nat.rec (motive := fun _ => List (List Nat) → Nat → OT × Bool × Nat × Rd × List Rd → OT × Bool × Nat × Rd × List Rd)
          (fun _ _ s => s)
          (fun _ ihj js mult s =>
            match js with
            | [] => s
            | aj :: jtl =>
              let rf := s.2.2.2.1.read C.k1 C.per1
              let f := rf.1
              let sw := Nat.mod f 2
              let f2 := Nat.div f 2
              let gi := Nat.mod f2 ng
              let rho := Nat.div f2 ng
              let ent := kt.getD gi ((0, 0, 0), [])
              let g := ent.1
              let reads := (s.2.2.2.2.zip C.blocks1).map fun (r, b) => r.read b.wr b.per
              let coefs := (reads.zip C.blocks1).map fun (x, b) => Int.mul (Int.ofNat mult) (sfield x.1 b.wr)
              let pairs := coefs.zip ent.2
              let bnd := (coefs.zip km).foldl (fun a (cf, m) => Nat.add a (Nat.mul (Int.natAbs cf) m)) 0
              let addP := fun (P _ : Nat) => pairs.foldl (fun a (cf, kp, kn) =>
                Nat.add a (Nat.add (Nat.mul (Int.toNat cf) kp) (Nat.mul (Int.toNat (Int.neg cf)) kn))) P
              let addN := fun (_ N : Nat) => pairs.foldl (fun a (cf, kp, kn) =>
                Nat.add a (Nat.add (Nat.mul (Int.toNat cf) kn) (Nat.mul (Int.toNat (Int.neg cf)) kp))) N
              let res := OT.upd C.p g.1 g.2.1 g.2.2 sw ki (bagWith id aj) addP addN C.od s.1 rho
              ihj jtl 2 (res.1, s.2.1 && res.2 && isUnit C.p g.1 g.2.1, Nat.add s.2.2.1 bnd, rf.2,
                reads.map (·.2)))
          nr (ai :: tl) 1 s
        ih tl inner)
    nr C.reps (t0, true, 0, ⟨0, 0, C.p1⟩, rd0)
  (outer.1, outer.2.1, outer.2.2.1)

/-! ### The segment check -/

/-- The q-part coefficients `α_[]`, `α_[0]`, `β_ν`, and whether every transporter `g(t_ν) = t` checked. -/
def qcoefs (C : Cert) : Int × Int × List Int × Bool :=
  let n := Nat.mul C.p C.p
  let ng := Nat.mul 2 (Nat.add C.p 1)
  let gl := gList C.p
  -- the class of every t, checked
  let cls := (List.range n).foldl (fun (acc : List Nat × Rd × Bool) t =>
      let rf := acc.2.1.read C.kq C.perq
      let nu := Nat.div rf.1 ng
      let g := gl.getD (Nat.mod rf.1 ng) (0, 0, 0)
      (acc.1 ++ [nu], rf.2, acc.2.2 && Nat.beq (gmap C.p g.1 g.2.1 g.2.2 (C.tnu.getD nu 0)) t && isUnit C.p g.1 g.2.1))
    ([], ⟨0, 0, C.qt⟩, true)
  let init : Int × Int × List Int := (0, 0, List.replicate C.p 0)
  let wt := wtab C
  let r := C.blocksq.foldl (fun acc b =>
      let rd := (⟨0, 0, b.row0⟩ : Rd)
      let r00 := rd.read b.wr b.per
      let r01 := r00.2.read b.wr b.per
      let r11 := ((⟨0, 0, b.rest⟩ : Rd).read b.wr b.per).1
      b.wts.foldl (fun acc wi =>
        let c := cval C wi
        let a0 := Int.add acc.1 (Int.mul (sfield r00.1 b.wr) (Int.mul c c))
        let a1 := Int.add acc.2.1 (Int.mul (Int.mul 2 (sfield r01.1 b.wr)) (Int.mul c (sigma C wi)))
        let e := wt.getD wi (0, 0)
        let be := (cls.1.zip (List.range n)).foldl (fun (bl : List Int) (nu, t) =>
            bl.modify nu (fun v => Int.add v (Int.mul (sfield r11 b.wr) (kap C e t)))) acc.2.2
        (a0, a1, be)) acc) init
  (r.1, r.2.1, r.2.2, cls.2.2)

/-- One segment of the identity check. -/
def segCheck (C : Cert) (seg : Nat) : Bool :=
  let n := Nat.mul C.p C.p
  let tr0 := (Tr.build C.ds ((C.keys.drop (Nat.mul seg (Nat.shiftLeft 1 C.ds))).take (Nat.shiftLeft 1 C.ds))).1
  let st0 : St := ⟨⟨0, 0, C.ops⟩, tr0, 0, true⟩
  -- (O1) the left side, moved over
  let st := St.op C seg (kfL C.p []) 0 C.unum st0
  let st := St.op C seg (kfL C.p [0]) (Nat.mul C.scale n) 0 st
  -- (O2) times-1 constants and linear terms
  let st := C.blocks1.foldl (fun st b =>
      let r0 := (List.range b.m).foldl (fun (acc : List Int × Rd) _ =>
          let x := acc.2.read b.wr b.per; (acc.1 ++ [sfield x.1 b.wr], x.2)) ([], ⟨0, 0, b.row0⟩)
      b.wts.foldl (fun st wi =>
        let c := cval C wi
        let sg := sigma C wi
        let st := St.opI C seg (kfL C.p []) (Int.mul (r0.1.getD 0 0) (Int.mul c c)) st
        (C.reps.zip (r0.1.drop 1)).foldl (fun st (a, r) => St.opI C seg (kfL C.p a) (Int.mul (Int.mul 2 r) (Int.mul c sg)) st) st)
        st) st
  -- (O3) phase 1, then phase 2 over the orbit rows
  let ph := phase1 C
  let st := (OT.toList ph.1).foldl (fun st (a0, a1, P, N) =>
      (Nat.rec (motive := fun _ => Nat × Nat × Nat × St → Nat × Nat × Nat × St) (fun s => s)
        (fun _ ih s =>
          let t := s.1
          let pt := lowBits s.2.1 C.w
          let nt := lowBits s.2.2.1 C.w
          ih (Nat.add t 1, Nat.shiftRight s.2.1 C.w, Nat.shiftRight s.2.2.1 C.w,
              St.op C seg (fun c d e o => Nat.add (keyW C.p c d e o 0 a0) (keyW C.p c d e o t a1)) pt nt s.2.2.2)) n (0, P, N, st)).2.2.2) st
  -- (O4) the q-part
  let qc := qcoefs C
  let qmonos : List (List Nat × Int) := ([], qc.1) :: ([0], qc.2.1) ::
      ((List.range C.p).zip qc.2.2.1).map (fun (nu, b) => ([0, C.tnu.getD nu 0], b))
  let sl := sList C.p
  let st := qmonos.foldl (fun st (m, cf) =>
      cond (Int.decEq cf 0).decide st
        ((List.range n).foldl (fun st x =>
          let st := St.opI C seg (fun c d e o => Nat.add (keyW C.p c d e o 0 m) (keyW C.p c d e o 0 [x])) (Int.mul 2 cf) st
          let st := St.opI C seg (fun c d e o => Nat.add (keyW C.p c d e o 0 m) (keyW C.p c d e o 0 [x, x]))
            (Int.neg (Int.mul 2 cf)) st
          sl.foldl (fun st s => St.opI C seg (fun c d e o => Nat.add (keyW C.p c d e o 0 m) (keyW C.p c d e o 0 [x, addP C.p x s]))
            (Int.neg cf) st) st) st)) st
  -- (O5) the rows
  let rr := (List.range C.nrows).foldl (fun (acc : St × Rd × Bool) _ =>
      let rf := acc.2.1.read C.kr C.perr
      let f := rf.1
      let nb := Nat.mod f 8
      let na := Nat.mod (Nat.div f 8) 8
      let pts := Nat.div f 64
      let xs := (List.range 4).map fun i => lowBits (Nat.shiftRight pts (Nat.mul C.kp i)) C.kp
      let lam := Nat.shiftRight pts (Nat.mul 4 C.kp)
      let A := xs.take na
      let B := (xs.drop na).take nb
      let st := (List.range (Nat.shiftLeft 1 nb)).foldl (fun st mask =>
          let sub := (B.zip (List.range nb)).filterMap fun (x, i) => cond (Nat.testBit mask i) (some x) none
          let kf := fun c d e o => Nat.add (keyW C.p c d e o 0 A) (keyW C.p c d e o 0 sub)
          cond (Nat.beq (Nat.mod (sub.length) 2) 0) (St.op C seg kf lam 0 st) (St.op C seg kf 0 lam st))
        acc.1
      (st, rf.2, acc.2.2 && Nat.ble (Nat.add na nb) 4)) (st, ⟨0, 0, C.rows⟩, true)
  let st := rr.1
  st.ok && rr.2.2 && ph.2.1 && Nat.blt ph.2.2 (Nat.shiftLeft 1 C.w) && qc.2.2.2 &&
    Nat.blt st.tot (Nat.shiftLeft 1 C.w) && st.tr.balanced

/-! ### Positive definiteness: `s·R − M·Mᵀ` diagonally dominant -/

/-- Digit `k` of `x` at width `wB`. -/
def digit (x wB k : Nat) : Nat := lowBits (Nat.shiftRight x (Nat.mul wB k)) wB

/-- The reversal of a tagged row: digit 0 (the tag) stays, digits `1..m` go to `m..1`. Chain-free, and the tag keeps
the low 64 bits of distinct rows distinct (the kernel's caches hash a literal by them: 33 s against 1.3 s measured). -/
def revRow (wB m x : Nat) : Nat :=
  (List.range m).foldl (fun a k => Nat.add a (Nat.shiftLeft (digit x wB (Nat.add k 1)) (Nat.mul wB (Nat.sub m k)))) (digit x wB 0)

/-- The block's PSD check (`s = 2^sb + 1` and the offset `2^(wm-1) + 1` are odd: a power of two times anything has zero
low bits, and the kernel's caches hash a literal by its low 64 bits): with `M` the offset-decoded rows and `R` the symmetric matrix of the upper-triangular
streams, every row of `E = 2^sb·R − M·Mᵀ` has `E_ii ≥ Σ_{j≠i} |E_ij|`. Dot products are one Kronecker product each:
digit `m−1` of `fwd_i · rev_j`, corrected for the offsets. -/
def psdCheck (b : Blk) : Bool :=
  let m := b.m
  let Cm := Nat.add (Nat.shiftLeft 1 (Nat.sub b.wm 1)) 1
  let mid := Nat.add m 1
  let ones := (List.range m).foldl (fun a k => Nat.add a (Nat.shiftLeft 1 (Nat.mul b.wB (Nat.add k 1)))) 0
  let fwd := b.mrows
  let rev := fwd.map (revRow b.wB m)
  let sig := fwd.map fun f => digit (Nat.mul f ones) b.wB mid
  let wS := Nat.add (Nat.add b.sb b.wr) (Nat.add (Nat.mul 2 b.wm) 24)
  let lim := Nat.shiftLeft 1 (Nat.sub wS 8)
  let corr := Int.ofNat (Nat.mul m (Nat.mul Cm Cm))
  -- state: R reader, column accumulator, ok; the outer loop runs over the tails of fwd, rev, sig
  let outer := Nat.rec (motive := fun _ => List Nat → List Nat → List Nat → Nat → Rd × Nat × Bool → Rd × Nat × Bool)
    (fun _ _ _ _ s => s)
    (fun _ ih fs rs ss i s =>
      match fs, ss with
      | fi :: ftl, si :: stl =>
        -- inner loop over j ≥ i: (rev tail, sig tail, j, R reader, diag, rowabs, colacc, ok)
        let inner := Nat.rec (motive := fun _ => List Nat → List Nat → Nat × Rd × Int × Nat × Nat × Bool →
            Nat × Rd × Int × Nat × Nat × Bool)
          (fun _ _ t => t)
          (fun _ ihj rj sj t =>
            match rj, sj with
            | r :: rtl, sjv :: sjtl =>
              let rd := t.2.1.read b.wr b.per
              let dot := Int.add (Int.subNatNat (digit (Nat.mul fi r) b.wB mid)
                  (Nat.mul Cm (Nat.add si sjv))) corr
              let e := Int.sub (Int.mul (Int.ofNat (Nat.add (Nat.shiftLeft 1 b.sb) 1)) (sfield rd.1 b.wr)) dot
              let j := t.1
              cond (Nat.beq j i)
                (ihj rtl sjtl (Nat.add j 1, rd.2, e, t.2.2.2.1, t.2.2.2.2.1, t.2.2.2.2.2))
                (ihj rtl sjtl (Nat.add j 1, rd.2, t.2.2.1, Nat.add t.2.2.2.1 (Int.natAbs e),
                  Nat.add t.2.2.2.2.1 (Nat.add (Nat.shiftLeft (Int.natAbs e) (Nat.mul wS (Nat.add j 1))) 1),
                  t.2.2.2.2.2 && Nat.blt (Int.natAbs e) lim))
            | _, _ => t)
          m rs ss (i, s.1, 0, 0, s.2.1, s.2.2)
        let diag := inner.2.2.1
        let okRow := Nat.ble (Nat.add inner.2.2.2.1 (digit inner.2.2.2.2.1 wS (Nat.add i 1))) (Int.toNat diag) &&
          Nat.blt 0 (Int.toNat diag)
        let rd := cond (Nat.beq i 0) (⟨0, 0, b.rest⟩ : Rd) inner.2.1
        ih ftl (rs.tail) stl (Nat.add i 1) (rd, inner.2.2.2.2.1, inner.2.2.2.2.2 && okRow)
      | _, _ => s)
    m fwd rev sig 0 (⟨0, 0, b.row0⟩, 0, true)
  outer.2.2 && Nat.beq fwd.length m

/-- Every block of the certificate passes `psdCheck`. -/
def psdAll (C : Cert) : Bool := (C.blocks1 ++ C.blocksq).all psdCheck

end HadwigerNelson.FibreCert
