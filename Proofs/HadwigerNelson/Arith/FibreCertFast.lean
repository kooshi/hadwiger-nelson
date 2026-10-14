import Proofs.HadwigerNelson.Arith.FibreCert

/-!
# Faster forms of the certificate checker's parts, each proved equal to the checker's (FS131-IKC4)

**Read aloud.** Nothing here changes what `FibreCert.certOK` checks. Each definition below is a second way to compute one
part of it, and each comes with a theorem saying it computes the same thing for every certificate, so that a proof may
let the kernel evaluate the fast form on a large certificate and rewrite it into the checker's:

* **the K table read, not computed**: `globalOK C = globalOKK C (ktable C)` (`globalOK_eq_K`, by unfolding), and a
  literal compared with `ktable C` piece by piece is `ktable C` (`ktEq_eq`, `eq_flatten_of_pieces`);
* **phase 1 without its zero pairs' work**: `p1stepZ` skips the row increments of a pair whose coefficients are all
  zero (`p1stepZ_eq`), `p1stepF` is that step with no `let` chain and the bound's share skipped too (`p1stepF_eq`),
  `globalOKKZ C kt = globalOKK C kt` (`globalOKKZ_eq`), read through `globalOKP` (`globalOKKZ_eq_P`);
* **phase 1 in chunks**: a chunk of pairs checked from the state after the first `n` pairs (`p1At`) gives the state
  after `n + len` (`fold_chunk`, `fold_drop_chunk`), and that state placed directly — the reader by one shift
  (`rdAt`, `readIter_eq_rdAt`), each block's coefficients decoded from entry `n` (`coefFrom`, `coefFrom_eq`) — is it
  (`p1AtF_eq`, `fold_drop_chunkF`);
* **the identity without its zero ops**: `segCheck C seg = segCheckZ C seg` (`segCheck_eq_Z`): an orbit row that is zero
  and a q-monomial of coefficient zero give ops of value zero, which `St.op` passes by unchanged.

Used by `Arith/FibreCert19Bound`. Core Lean only.
-/

namespace HadwigerNelson.FibreCert

/-! ### Phase 1 over a given K table -/

/-- `phase1 C` with the K table `kt` in place of `ktable C`. -/
def phase1K (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : List ORow × Bool × Nat :=
  let r := (repPairs C.reps.length).foldl (p1step C kt (C.blocks1.map (kmax C)))
    (bucket16 (C.orbits.map (fun o => (o.1, o.2, 0, 0))), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs)
  (r.1.flatten, r.2.1, r.2.2.1)

/-- `orowsOK C` with the K table `kt`. -/
def orowsOKK (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : Bool :=
  let r := (phase1K C kt).1
  Nat.beq r.length C.orows.length && Nat.beq C.orbits.length C.orows.length &&
    (r.zip C.orows).all fun x => Nat.beq x.1.2.2.1 x.2.1 && Nat.beq x.1.2.2.2 x.2.2

/-- `globalOK C` with the K table `kt`. -/
def globalOKK (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : Bool :=
  let ph := phase1K C kt
  Nat.ble 2 C.p && Nat.blt 0 C.scale && Nat.blt 0 C.nseg && ph.2.1 && Nat.blt ph.2.2 (Nat.shiftLeft 1 C.w) &&
    orowsOKK C kt &&
    (qcoefs C).2.2.2 && C.blocks1.all (fun b => Nat.beq b.m (Nat.add C.reps.length 1)) &&
    C.blocksq.all (fun b => Nat.ble 2 b.m) &&
    (C.blocks1 ++ C.blocksq).all (fun b => b.wts.all fun wi => Nat.blt wi C.weights.length)

/-- `0 : ℤ`, as a `Bool`. -/
def izero (z : Int) : Bool :=
  match z with
  | .ofNat n => Nat.beq n 0
  | .negSucc _ => false

/-- `p1step` with the row increments not computed when every coefficient of the pair is zero (they are zero then). -/
def p1stepZ (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat)
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
  let z := coefs.all izero
  let addP := cond z 0
    (prs.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0)
  let addN := cond z 0
    (prs.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0)
  (bmod s.1 rho (fun o => (o.1, o.2.1, Nat.add o.2.2.1 addP, Nat.add o.2.2.2 addN)),
   s.2.1 && good, Nat.add s.2.2.1 bnd, rf.2, s.2.2.2.2.map List.tail)

/-- `phase1K` with `p1stepZ`. -/
def phase1KZ (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : List ORow × Bool × Nat :=
  let r := (repPairs C.reps.length).foldl (p1stepZ C kt (C.blocks1.map (kmax C)))
    (bucket16 (C.orbits.map (fun o => (o.1, o.2, 0, 0))), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs)
  (r.1.flatten, r.2.1, r.2.2.1)

/-- `orowsOKK` with `phase1KZ`. -/
def orowsOKKZ (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : Bool :=
  let r := (phase1KZ C kt).1
  Nat.beq r.length C.orows.length && Nat.beq C.orbits.length C.orows.length &&
    (r.zip C.orows).all fun x => Nat.beq x.1.2.2.1 x.2.1 && Nat.beq x.1.2.2.2 x.2.2

/-- `globalOKK` with `phase1KZ`. -/
def globalOKKZ (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) : Bool :=
  let ph := phase1KZ C kt
  Nat.ble 2 C.p && Nat.blt 0 C.scale && Nat.blt 0 C.nseg && ph.2.1 && Nat.blt ph.2.2 (Nat.shiftLeft 1 C.w) &&
    orowsOKKZ C kt &&
    (qcoefs C).2.2.2 && C.blocks1.all (fun b => Nat.beq b.m (Nat.add C.reps.length 1)) &&
    C.blocksq.all (fun b => Nat.ble 2 b.m) &&
    (C.blocks1 ++ C.blocksq).all (fun b => b.wts.all fun wi => Nat.blt wi C.weights.length)

/-! ### Phase 1's step without `let` chains

The kernel instantiates a `let` by copying the rest of its body, so `p1step`'s chain of lets is copied per pair. Each
quantity below is a small function of the state, the pair and the stream field; the kernel's caches share the repeated
calls. `p1stepF` is `p1stepZ` (`p1stepF_eq`), with the bound's sum also skipped for a pair whose coefficients are zero. -/

/-- The pair's stream field and the reader after it. -/
def p1rd (C : Cert) (s : P1St) : Nat × Rd := s.2.2.2.1.read C.k1 C.per1
/-- The orbit row named by a field. -/
def p1rhoF (C : Cert) (f : Nat) : Nat := Nat.div (Nat.div f 2) (Nat.mul 2 (Nat.add C.p 1))
/-- The K-table entry named by a field. -/
def p1entF (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (f : Nat) : (Nat × Nat × Nat) × List (Nat × Nat) :=
  kt.getD (Nat.mod (Nat.div f 2) (Nat.mul 2 (Nat.add C.p 1))) ((0, 0, 0), [])
/-- The pair's multiplicity. -/
def p1mult (ij : Nat × Nat) : Int := cond (Nat.beq ij.1 ij.2) 1 2
/-- The pair's coefficients, one per times-1 block. -/
def p1coefs (s : P1St) (ij : Nat × Nat) : List Int := s.2.2.2.2.map fun l => Int.mul (p1mult ij) (l.headD 0)
/-- Every coefficient of the pair is zero (read from the heads: the multiplicity is 1 or 2). -/
def p1zero (s : P1St) : Bool := s.2.2.2.2.all fun l => izero (l.headD 0)
/-- The pair's share of the bound. -/
def p1bndF (km : List Nat) (s : P1St) (ij : Nat × Nat) : Nat :=
  cond (p1zero s) 0 (((p1coefs s ij).zip km).foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) 0)
/-- The pair's positive row increment. -/
def p1incP (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (s : P1St) (ij : Nat × Nat) (f : Nat) : Nat :=
  cond (p1zero s) 0 (((p1coefs s ij).zip (p1entF C kt f).2).foldl
    (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0)
/-- The pair's negative row increment. -/
def p1incN (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (s : P1St) (ij : Nat × Nat) (f : Nat) : Nat :=
  cond (p1zero s) 0 (((p1coefs s ij).zip (p1entF C kt f).2).foldl
    (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0)
/-- The transporter's images of the orbit row's representative. -/
def p1img (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (l : List Nat) (f : Nat) : List Nat :=
  l.map (gmap C.p (p1entF C kt f).1.1 (p1entF C kt f).1.2.1 (p1entF C kt f).1.2.2)
/-- The pair's transporter check. -/
def p1goodF (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (s : P1St) (ij : Nat × Nat) (f : Nat) : Bool :=
  (cond (Nat.beq (Nat.mod f 2) 0)
      (Nat.beq (bag (p1img C kt (bget s.1 (p1rhoF C f)).1 f)) (bag (C.reps.getD ij.1 [])) &&
        Nat.beq (bag (p1img C kt (bget s.1 (p1rhoF C f)).2.1 f)) (bag (C.reps.getD ij.2 [])))
      (Nat.beq (bag (p1img C kt (bget s.1 (p1rhoF C f)).1 f)) (bag (C.reps.getD ij.2 [])) &&
        Nat.beq (bag (p1img C kt (bget s.1 (p1rhoF C f)).2.1 f)) (bag (C.reps.getD ij.1 [])))) &&
    bmem s.1 (p1rhoF C f) && isUnit C.p (p1entF C kt f).1.1 (p1entF C kt f).1.2.1 &&
    Nat.blt (p1img C kt (bget s.1 (p1rhoF C f)).1 f).length 8 &&
    Nat.blt (p1img C kt (bget s.1 (p1rhoF C f)).2.1 f).length 8 &&
    Nat.blt (C.reps.getD ij.1 []).length 8 && Nat.blt (C.reps.getD ij.2 []).length 8
/-- `p1stepZ` without `let`s, the bound's sum skipped for a zero pair. -/
def p1stepF (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat)
    (s : P1St) (ij : Nat × Nat) : P1St :=
  (bmod s.1 (p1rhoF C (p1rd C s).1) (fun o => (o.1, o.2.1, Nat.add o.2.2.1 (p1incP C kt s ij (p1rd C s).1),
      Nat.add o.2.2.2 (p1incN C kt s ij (p1rd C s).1))),
   s.2.1 && p1goodF C kt s ij (p1rd C s).1, Nat.add s.2.2.1 (p1bndF km s ij), (p1rd C s).2, s.2.2.2.2.map List.tail)

/-- The stream reader after `n` reads of `k`-bit fields. -/
def readIter (k per n : Nat) (r : Rd) : Rd :=
  Nat.rec (motive := fun _ => Rd) r (fun _ r' => (r'.read k per).2) n

/-- The phase-1 state after the first `n` pairs, from its core `(rows, verdict, bound)`: the reader `n` fields in, every
block's coefficient list `n` entries in. -/
def p1At (C : Cert) (B : List (List ORow)) (v : Bool) (bd n : Nat) : P1St :=
  (B, v, bd, readIter C.k1 C.per1 n ⟨0, 0, C.p1⟩, C.blocks1.map fun b => (Blk.pairCoefs b).drop n)

/-- Bool equality of two lists of naturals. -/
def natsEq : List Nat → List Nat → Bool
  | [], [] => true
  | a :: l, b :: l' => Nat.beq a b && natsEq l l'
  | _, _ => false

/-- Bool equality of two orbit rows. -/
def orowEq (a b : ORow) : Bool :=
  natsEq a.1 b.1 && natsEq a.2.1 b.2.1 && Nat.beq a.2.2.1 b.2.2.1 && Nat.beq a.2.2.2 b.2.2.2

/-- Bool equality of two buckets of orbit rows. -/
def bucketEq : List ORow → List ORow → Bool
  | [], [] => true
  | a :: l, b :: l' => orowEq a b && bucketEq l l'
  | _, _ => false

/-- Bool equality of two lists of buckets. -/
def bucketsEq : List (List ORow) → List (List ORow) → Bool
  | [], [] => true
  | a :: l, b :: l' => bucketEq a b && bucketsEq l l'
  | _, _ => false

/-- A phase-1 state's core is `(B, true, bd)`. -/
def p1CoreEq (s : P1St) (B : List (List ORow)) (bd : Nat) : Bool := bucketsEq s.1 B && s.2.1 && Nat.beq s.2.2.1 bd

/-- `globalOK`'s conjuncts read from a given phase-1 result `ph` (rows, verdict, bound). -/
def globalOKP (C : Cert) (ph : List ORow × Bool × Nat) : Bool :=
  Nat.ble 2 C.p && Nat.blt 0 C.scale && Nat.blt 0 C.nseg && ph.2.1 && Nat.blt ph.2.2 (Nat.shiftLeft 1 C.w) &&
    (Nat.beq ph.1.length C.orows.length && Nat.beq C.orbits.length C.orows.length &&
      (ph.1.zip C.orows).all fun x => Nat.beq x.1.2.2.1 x.2.1 && Nat.beq x.1.2.2.2 x.2.2) &&
    (qcoefs C).2.2.2 && C.blocks1.all (fun b => Nat.beq b.m (Nat.add C.reps.length 1)) &&
    C.blocksq.all (fun b => Nat.ble 2 b.m) &&
    (C.blocks1 ++ C.blocksq).all (fun b => b.wts.all fun wi => Nat.blt wi C.weights.length)

/-! ### A reader placed directly, and a block's coefficients from a position

A chunk of phase 1 starts `n` pairs in: its reader `n` fields into the stream and each block's coefficient list `n`
entries in. Read from the start, both cost the kernel `n` reads; `rdAt` places a reader at field `n` with one shift
(`readIter_eq_rdAt`), and `coefFrom` decodes a block's coefficients from there (`coefFrom_eq`). -/

/-- A reader at field `n` of a stream of `per` fields per chunk. -/
def rdAt (k per n : Nat) (chunks : List Nat) : Rd :=
  cond (Nat.beq n 0) ⟨0, 0, chunks⟩
    ⟨Nat.shiftRight (chunks.getD (Nat.div (Nat.sub n 1) per) 0) (Nat.mul k (Nat.add (Nat.mod (Nat.sub n 1) per) 1)),
      Nat.sub per (Nat.add (Nat.mod (Nat.sub n 1) per) 1), chunks.drop (Nat.add (Nat.div (Nat.sub n 1) per) 1)⟩

/-- The number of entries of a block's coefficient list: `(m - 1) + (m - 2) + ⋯ + 1`. -/
def triCount (m : Nat) : Nat := Nat.div (Nat.mul m (Nat.sub m 1)) 2

/-- A block's coefficients from entry `n` on, decoded from the reader placed there. -/
def coefFrom (b : Blk) (n : Nat) : List Int :=
  (Rd.readK b.wr b.per (Nat.sub (triCount b.m) n) (rdAt b.wr b.per n b.rest)).1.map fun x => sfield x b.wr

/-- `p1At` with the reader and the coefficient lists placed directly. -/
def p1AtF (C : Cert) (B : List (List ORow)) (v : Bool) (bd n : Nat) : P1St :=
  (B, v, bd, rdAt C.k1 C.per1 n C.p1, C.blocks1.map fun b => coefFrom b n)

/-! ### The K table compared with a literal -/

/-- Bool equality of two lists of packed row pairs. -/
def rowsEq : List (Nat × Nat) → List (Nat × Nat) → Bool
  | [], [] => true
  | a :: l, b :: l' => Nat.beq a.1 b.1 && Nat.beq a.2 b.2 && rowsEq l l'
  | _, _ => false

/-- Bool equality of two K-table entries. -/
def entEq (a b : (Nat × Nat × Nat) × List (Nat × Nat)) : Bool :=
  Nat.beq a.1.1 b.1.1 && Nat.beq a.1.2.1 b.1.2.1 && Nat.beq a.1.2.2 b.1.2.2 && rowsEq a.2 b.2

/-- Bool equality of two lists of K-table entries. -/
def ktEq : List ((Nat × Nat × Nat) × List (Nat × Nat)) → List ((Nat × Nat × Nat) × List (Nat × Nat)) → Bool
  | [], [] => true
  | a :: l, b :: l' => entEq a b && ktEq l l'
  | _, _ => false

/-! ### The identity without its zero ops -/

/-- (O3) with the ops of a zero orbit row left out. -/
def opsO3Z (C : Cert) (rows : List (List Nat × List Nat × Nat × Nat)) : List Op :=
  rows.flatMap fun o => cond (Nat.beq o.2.2.1 0 && Nat.beq o.2.2.2 0) []
    ((List.range (Nat.mul C.p C.p)).map fun t => ⟨o.1, t, o.2.1, digit o.2.2.1 C.w t, digit o.2.2.2 C.w t⟩)

/-- (O4) with the ops of a q-monomial of coefficient zero left out. -/
def opsO4Z (C : Cert) (qc : Int × Int × List Int × Bool) : List Op :=
  let sl := sList C.p
  (qmonos C qc).flatMap fun mc => cond (izero mc.2) [] ((List.range (Nat.mul C.p C.p)).flatMap fun x =>
    opI mc.1 0 [x] (Int.mul 2 mc.2) :: opI mc.1 0 [x, x] (Int.neg (Int.mul 2 mc.2)) ::
      sl.map fun s => opI mc.1 0 [x, addP C.p x s] (Int.neg mc.2))

/-- `opList` with the zero ops of (O3) and (O4) left out. -/
def opListZ (C : Cert) (rows : List (List Nat × List Nat × Nat × Nat)) (qc : Int × Int × List Int × Bool) : List Op :=
  opsO1 C ++ opsO2 C ++ opsO3Z C rows ++ opsO4Z C qc ++ opsO5 C

/-- `segCheck` over `opListZ`. -/
def segCheckZ (C : Cert) (seg : Nat) : Bool :=
  let leaves := (List.range (Nat.shiftLeft 1 C.ds)).map fun k =>
    (C.keys.getD (Nat.add (Nat.mul seg (Nat.shiftLeft 1 C.ds)) k) 0, 0, 0)
  let st := (opListZ C (orbRows C) (qcoefs C)).foldl (St.op C seg) ⟨⟨0, 0, C.ops⟩, leaves, 0, true⟩
  st.ok && Nat.blt st.tot (Nat.shiftLeft 1 C.w) && st.leaves.all fun l => Nat.beq l.2.1 l.2.2


/-! ### The three forms agree -/

/-- The shape check is `globalOKK` at the checker's own K table (both unfold to one term). -/
theorem globalOK_eq_K (C : Cert) : globalOK C = globalOKK C (ktable C) := rfl

/-- `izero z` says `z = 0`. -/
theorem izero_eq (z : Int) (h : izero z = true) : z = 0 := by
  match z, h with
  | .ofNat n, h => simp only [izero, Nat.beq_eq] at h; subst h; rfl
  | .negSucc _, h => simp [izero] at h

/-- A fold of `a + (x⁺·u + x⁻·v)` over entries with `x = 0` adds nothing. -/
theorem foldl_zero_add (l : List (Int × Nat × Nat)) (hl : ∀ x ∈ l, x.1 = 0) (a : Nat) :
    l.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) a
      = a := by
  induction l generalizing a with
  | nil => rfl
  | cons x l ih =>
    rw [List.foldl_cons, ih (fun y hy => hl y (List.mem_cons_of_mem _ hy)), hl x List.mem_cons_self]
    show a + (0 * _ + 0 * _) = a
    simp

/-- The same with the two parts swapped. -/
theorem foldl_zero_add' (l : List (Int × Nat × Nat)) (hl : ∀ x ∈ l, x.1 = 0) (a : Nat) :
    l.foldl (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) a
      = a := by
  induction l generalizing a with
  | nil => rfl
  | cons x l ih =>
    rw [List.foldl_cons, ih (fun y hy => hl y (List.mem_cons_of_mem _ hy)), hl x List.mem_cons_self]
    show a + (0 * _ + 0 * _) = a
    simp

private theorem zip_fst_zero {β : Type} (c : List Int) (r : List β) (h : c.all izero = true) :
    ∀ x ∈ c.zip r, x.1 = 0 := by
  intro x hx
  exact izero_eq _ (List.all_eq_true.1 h _ (List.of_mem_zip hx).1)

/-- The skipped increment is the increment, when it is skipped. -/
theorem cond_addP (c : List Int) (r : List (Nat × Nat)) :
    cond (c.all izero) 0 ((c.zip r).foldl
      (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0) =
    (c.zip r).foldl
      (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.1) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.2))) 0 := by
  cases h : c.all izero
  · rfl
  · exact (foldl_zero_add _ (zip_fst_zero c r h) 0).symm

/-- The same for the negative part. -/
theorem cond_addN (c : List Int) (r : List (Nat × Nat)) :
    cond (c.all izero) 0 ((c.zip r).foldl
      (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0) =
    (c.zip r).foldl
      (fun a x => Nat.add a (Nat.add (Nat.mul (Int.toNat x.1) x.2.2) (Nat.mul (Int.toNat (Int.neg x.1)) x.2.1))) 0 := by
  cases h : c.all izero
  · rfl
  · exact (foldl_zero_add' _ (zip_fst_zero c r h) 0).symm

/-- `p1stepZ` is `p1step`. -/
theorem p1stepZ_eq (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat) (s : P1St)
    (ij : Nat × Nat) : p1stepZ C kt km s ij = p1step C kt km s ij := by
  simp only [p1stepZ, p1step, cond_addP, cond_addN]

/-- `izero` reads `0 : ℤ` exactly. -/
theorem izero_iff (z : Int) : izero z = true ↔ z = 0 :=
  ⟨izero_eq z, fun h => by subst h; rfl⟩

/-- Multiplying by a pair's multiplicity keeps zero and non-zero apart. -/
theorem izero_mul_mult (ij : Nat × Nat) (x : Int) : izero (Int.mul (p1mult ij) x) = izero x := by
  apply Bool.eq_iff_iff.2
  rw [izero_iff, izero_iff]
  unfold p1mult
  cases Nat.beq ij.1 ij.2
  · show 2 * x = 0 ↔ x = 0
    omega
  · show 1 * x = 0 ↔ x = 0
    omega

/-- A pair is zero exactly when its coefficients are. -/
theorem p1zero_eq (s : P1St) (ij : Nat × Nat) : p1zero s = (p1coefs s ij).all izero := by
  unfold p1zero p1coefs
  rw [List.all_map]
  exact congrArg _ (funext fun l => (izero_mul_mult ij _).symm)

/-- The skipped bound share is the share, when it is skipped. -/
theorem cond_bnd (c : List Int) (km : List Nat) :
    cond (c.all izero) 0 ((c.zip km).foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) 0) =
      (c.zip km).foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) 0 := by
  cases h : c.all izero
  · rfl
  · have hz : ∀ x ∈ c.zip km, x.1 = 0 := zip_fst_zero c km h
    show 0 = _
    generalize c.zip km = l at hz
    suffices ∀ a, l.foldl (fun a x => Nat.add a (Nat.mul (Int.natAbs x.1) x.2)) a = a from (this 0).symm
    induction l with
    | nil => intro a; rfl
    | cons x l ih =>
      intro a
      rw [List.foldl_cons, ih (fun y hy => hz y (List.mem_cons_of_mem _ hy)), hz x List.mem_cons_self]
      show a + 0 * _ = a
      simp

/-- `p1stepF` is `p1stepZ`. -/
theorem p1stepF_eq (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat) (s : P1St)
    (ij : Nat × Nat) : p1stepF C kt km s ij = p1stepZ C kt km s ij := by
  have hz := p1zero_eq s ij
  simp only [p1stepF, p1stepZ, p1incP, p1incN, p1bndF, p1goodF, p1img, p1entF, p1rhoF, p1rd, hz, p1coefs, p1mult,
    cond_bnd]

/-- `globalOKKZ` is `globalOKK`. -/
theorem globalOKKZ_eq (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) :
    globalOKKZ C kt = globalOKK C kt := by
  have h : p1stepZ C kt (C.blocks1.map (kmax C)) = p1step C kt (C.blocks1.map (kmax C)) :=
    funext fun s => funext fun ij => p1stepZ_eq C kt _ s ij
  simp only [globalOKKZ, globalOKK, orowsOKKZ, orowsOKK, phase1KZ, phase1K, h]

/-- `rowsEq` is equality. -/
theorem rowsEq_eq : ∀ l l' : List (Nat × Nat), rowsEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [rowsEq, Bool.and_eq_true, Nat.beq_eq] at h
    obtain ⟨⟨h1, h2⟩, h3⟩ := h
    rw [rowsEq_eq l l' h3, Prod.ext h1 h2]
  | [], _ :: _, h => by simp [rowsEq] at h
  | _ :: _, [], h => by simp [rowsEq] at h

/-- `entEq` is equality. -/
theorem entEq_eq (a b : (Nat × Nat × Nat) × List (Nat × Nat)) (h : entEq a b = true) : a = b := by
  obtain ⟨⟨c, d, e⟩, r⟩ := a
  obtain ⟨⟨c', d', e'⟩, r'⟩ := b
  simp only [entEq, Bool.and_eq_true, Nat.beq_eq] at h
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := h
  subst h1; subst h2; subst h3
  rw [rowsEq_eq r r' h4]

/-- `ktEq` is equality. -/
theorem ktEq_eq : ∀ l l' : List ((Nat × Nat × Nat) × List (Nat × Nat)), ktEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [ktEq, Bool.and_eq_true] at h
    rw [entEq_eq a b h.1, ktEq_eq l l' h.2]
  | [], _ :: _, h => by simp [ktEq] at h
  | _ :: _, [], h => by simp [ktEq] at h

/-- A list is the concatenation of its pieces `(l.drop (k·i)).take k`, once they cover its length. -/
theorem eq_flatten_of_pieces {α : Type} (k : Nat) : ∀ (ps : List (List α)) (l : List α),
    (∀ i (h : i < ps.length), (l.drop (k * i)).take k = ps[i]) → l.length ≤ k * ps.length → l = ps.flatten
  | [], l, _, hl => by simpa using hl
  | p :: ps, l, h, hl => by
    have h0 : l.take k = p := by
      have := h 0 (Nat.succ_pos _)
      simp only [Nat.mul_zero, List.drop_zero, List.getElem_cons_zero] at this
      exact this
    have ih := eq_flatten_of_pieces k ps (l.drop k) (fun i hi => by
      have := h (i + 1) (by simp; omega)
      simpa [List.drop_drop, Nat.mul_add, Nat.add_comm] using this)
      (by simp [List.length_drop]; simp [Nat.mul_add] at hl; omega)
    rw [List.flatten_cons, ← h0, ← ih, List.take_append_drop]

/-- A zero op leaves the scatter state unchanged. -/
theorem St.op_zero (C : Cert) (seg : Nat) (st : St) (o : Op) (h : Nat.add o.vp o.vn = 0) : St.op C seg st o = st := by
  have h' : o.vp + o.vn = 0 := h
  simp [St.op, h']

/-- A fold over zero ops leaves the scatter state unchanged. -/
theorem foldl_op_zero (C : Cert) (seg : Nat) : ∀ (l : List Op), (∀ o ∈ l, Nat.add o.vp o.vn = 0) →
    ∀ st, l.foldl (St.op C seg) st = st
  | [], _, _ => rfl
  | o :: l, h, st => by
    rw [List.foldl_cons, St.op_zero C seg st o (h o List.mem_cons_self)]
    exact foldl_op_zero C seg l (fun x hx => h x (List.mem_cons_of_mem _ hx)) st

/-- A digit of `0` is `0`. -/
theorem digit_zero (wB k : Nat) : digit 0 wB k = 0 := by
  simp [digit, lowBits]

/-- Zero ops in front of a list are passed by. -/
theorem foldl_append_zero (C : Cert) (seg : Nat) {l₁ l₂ : List Op} (h : ∀ o ∈ l₁, Nat.add o.vp o.vn = 0) (st : St) :
    (l₁ ++ l₂).foldl (St.op C seg) st = l₂.foldl (St.op C seg) st := by
  rw [List.foldl_append, foldl_op_zero C seg l₁ h st]

/-- (O3) and (O3) without its zero rows fold to one state. -/
theorem foldl_O3 (C : Cert) (seg : Nat) : ∀ (rows : List (List Nat × List Nat × Nat × Nat)) (st : St),
    (opsO3 C rows).foldl (St.op C seg) st = (opsO3Z C rows).foldl (St.op C seg) st
  | [], _ => rfl
  | o :: rows, st => by
    show ((List.range (Nat.mul C.p C.p)).map (fun t => (⟨o.1, t, o.2.1, digit o.2.2.1 C.w t, digit o.2.2.2 C.w t⟩ : Op))
        ++ opsO3 C rows).foldl (St.op C seg) st =
      ((cond (Nat.beq o.2.2.1 0 && Nat.beq o.2.2.2 0) []
        ((List.range (Nat.mul C.p C.p)).map fun t => (⟨o.1, t, o.2.1, digit o.2.2.1 C.w t, digit o.2.2.2 C.w t⟩ : Op)))
        ++ opsO3Z C rows).foldl (St.op C seg) st
    cases h : (Nat.beq o.2.2.1 0 && Nat.beq o.2.2.2 0)
    · rw [cond_false, List.foldl_append, List.foldl_append]
      exact foldl_O3 C seg rows _
    · simp only [Bool.and_eq_true, Nat.beq_eq] at h
      rw [foldl_append_zero C seg (fun x hx => by
        rw [List.mem_map] at hx
        obtain ⟨t, -, hx⟩ := hx
        subst hx
        show Nat.add (digit o.2.2.1 C.w t) (digit o.2.2.2 C.w t) = 0
        rw [h.1, h.2, digit_zero]), cond_true, List.nil_append]
      exact foldl_O3 C seg rows st

/-- (O4) and (O4) without its zero q-monomials fold to one state. -/
theorem foldl_O4 (C : Cert) (seg : Nat) (qc : Int × Int × List Int × Bool) (st : St) :
    (opsO4 C qc).foldl (St.op C seg) st = (opsO4Z C qc).foldl (St.op C seg) st := by
  simp only [opsO4, opsO4Z]
  generalize qmonos C qc = ms
  induction ms generalizing st with
  | nil => rfl
  | cons mc ms ih =>
    simp only [List.flatMap_cons]
    cases h : izero mc.2
    · rw [cond_false, List.foldl_append, List.foldl_append]
      exact ih _
    · have h0 := izero_eq _ h
      rw [foldl_append_zero C seg (fun x hx => by
        rw [List.mem_flatMap] at hx
        obtain ⟨y, -, hy⟩ := hx
        rw [List.mem_cons, List.mem_cons, List.mem_map] at hy
        rcases hy with hy | hy | ⟨s, -, hy⟩
        · subst hy; rw [h0]; rfl
        · subst hy; rw [h0]; rfl
        · subst hy; rw [h0]; rfl), cond_true, List.nil_append]
      exact ih st

/-- `segCheckZ` is `segCheck`. -/
theorem segCheck_eq_Z (C : Cert) (seg : Nat) : segCheck C seg = segCheckZ C seg := by
  simp only [segCheck, segCheckZ, opList, opListZ, List.foldl_append, foldl_O3, foldl_O4]

/-! ### Phase 1 in chunks -/

/-- `globalOKKZ` reads phase 1 through `globalOKP`. -/
theorem globalOKKZ_eq_P (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) :
    globalOKKZ C kt = globalOKP C (phase1KZ C kt) := rfl

/-- One more read, first or last. -/
theorem readIter_read (k per : Nat) : ∀ (n : Nat) (r : Rd), readIter k per n (r.read k per).2 = readIter k per (n + 1) r
  | 0, _ => rfl
  | n + 1, r => by
    show ((readIter k per n (r.read k per).2).read k per).2 = ((readIter k per (n + 1) r).read k per).2
    rw [readIter_read k per n r]

/-- Reads compose. -/
theorem readIter_add (k per : Nat) (m : Nat) : ∀ (n : Nat) (r : Rd), readIter k per n (readIter k per m r) = readIter k per (m + n) r
  | 0, _ => rfl
  | n + 1, r => by
    show ((readIter k per n (readIter k per m r)).read k per).2 = ((readIter k per (m + n) r).read k per).2
    rw [readIter_add k per m n r]

/-- Over a list of pairs, phase 1's reader advances one field a pair and every coefficient list one entry a pair, whatever
else the step does. -/
theorem fold_p1stepZ_rd_co (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat) :
    ∀ (l : List (Nat × Nat)) (s : P1St),
      (l.foldl (p1stepZ C kt km) s).2.2.2.1 = readIter C.k1 C.per1 l.length s.2.2.2.1 ∧
      (l.foldl (p1stepZ C kt km) s).2.2.2.2 = s.2.2.2.2.map (List.drop l.length)
  | [], s => ⟨rfl, by
    show s.2.2.2.2 = s.2.2.2.2.map (List.drop 0)
    rw [show (List.drop 0 : List Int → List Int) = id from funext fun _ => rfl, List.map_id]⟩
  | ij :: l, s => by
    obtain ⟨h1, h2⟩ := fold_p1stepZ_rd_co C kt km l (p1stepZ C kt km s ij)
    rw [List.foldl_cons, h1, h2, List.length_cons]
    refine ⟨readIter_read _ _ _ _, ?_⟩
    show (s.2.2.2.2.map List.tail).map (List.drop l.length) = _
    rw [List.map_map]
    exact List.map_congr_left fun x _ => List.drop_tail

/-- `natsEq` is equality. -/
theorem natsEq_eq : ∀ l l' : List Nat, natsEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [natsEq, Bool.and_eq_true, Nat.beq_eq] at h
    rw [h.1, natsEq_eq l l' h.2]
  | [], _ :: _, h => by simp [natsEq] at h
  | _ :: _, [], h => by simp [natsEq] at h

/-- `orowEq` is equality. -/
theorem orowEq_eq (a b : ORow) (h : orowEq a b = true) : a = b := by
  obtain ⟨a1, a2, a3, a4⟩ := a
  obtain ⟨b1, b2, b3, b4⟩ := b
  simp only [orowEq, Bool.and_eq_true, Nat.beq_eq] at h
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := h
  rw [natsEq_eq _ _ h1, natsEq_eq _ _ h2, h3, h4]

/-- `bucketEq` is equality. -/
theorem bucketEq_eq : ∀ l l' : List ORow, bucketEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [bucketEq, Bool.and_eq_true] at h
    rw [orowEq_eq a b h.1, bucketEq_eq l l' h.2]
  | [], _ :: _, h => by simp [bucketEq] at h
  | _ :: _, [], h => by simp [bucketEq] at h

/-- `bucketsEq` is equality. -/
theorem bucketsEq_eq : ∀ l l' : List (List ORow), bucketsEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [bucketsEq, Bool.and_eq_true] at h
    rw [bucketEq_eq a b h.1, bucketsEq_eq l l' h.2]
  | [], _ :: _, h => by simp [bucketsEq] at h
  | _ :: _, [], h => by simp [bucketsEq] at h

/-- **One chunk.** If the kernel finds the core of phase 1 after the pairs `l`, from the state after the first `n` pairs,
to be `(B', true, bd')`, the state after them is the state after the first `n + |l|` pairs with that core. -/
theorem fold_chunk (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat) (l : List (Nat × Nat))
    (B : List (List ORow)) (bd n : Nat) (B' : List (List ORow)) (bd' : Nat)
    (h : p1CoreEq (l.foldl (p1stepZ C kt km) (p1At C B true bd n)) B' bd' = true) :
    l.foldl (p1stepZ C kt km) (p1At C B true bd n) = p1At C B' true bd' (n + l.length) := by
  obtain ⟨hr, hc⟩ := fold_p1stepZ_rd_co C kt km l (p1At C B true bd n)
  simp only [p1CoreEq, Bool.and_eq_true, Nat.beq_eq] at h
  obtain ⟨⟨hB, hv⟩, hb⟩ := h
  have e : l.foldl (p1stepZ C kt km) (p1At C B true bd n) =
      ((l.foldl (p1stepZ C kt km) (p1At C B true bd n)).1, (l.foldl (p1stepZ C kt km) (p1At C B true bd n)).2.1,
        (l.foldl (p1stepZ C kt km) (p1At C B true bd n)).2.2.1, (l.foldl (p1stepZ C kt km) (p1At C B true bd n)).2.2.2.1,
        (l.foldl (p1stepZ C kt km) (p1At C B true bd n)).2.2.2.2) := rfl
  rw [e, hr, hc, bucketsEq_eq _ _ hB, hv, hb]
  simp only [p1At, readIter_add, List.map_map]
  refine congrArg _ (congrArg _ (congrArg _ (congrArg _ ?_)))
  exact List.map_congr_left fun x _ => by simp only [Function.comp_apply, List.drop_drop]

/-- **Chunks in sequence**: the rest of phase 1 from the state after `n` pairs is the rest from the state after
`n + len` pairs, once the chunk of `len` pairs at `n` is checked and lies inside the pairs. -/
theorem fold_drop_chunk (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat)
    (pairs : List (Nat × Nat)) (B : List (List ORow)) (bd n len : Nat) (B' : List (List ORow)) (bd' : Nat)
    (hlen : n + len ≤ pairs.length)
    (h : p1CoreEq (((pairs.drop n).take len).foldl (p1stepZ C kt km) (p1At C B true bd n)) B' bd' = true) :
    (pairs.drop n).foldl (p1stepZ C kt km) (p1At C B true bd n) =
      (pairs.drop (n + len)).foldl (p1stepZ C kt km) (p1At C B' true bd' (n + len)) := by
  have hl : ((pairs.drop n).take len).length = len := by
    rw [List.length_take, List.length_drop]; omega
  rw [← List.take_append_drop len (pairs.drop n), List.foldl_append, fold_chunk C kt km _ B bd n B' bd' h, hl,
    List.drop_drop]

/-! ### Placing a reader, and coefficients from a position -/

/-- Reading `a + c` fields is reading `a`, then `c` more. -/
theorem readK_add (k per : Nat) (c : Nat) : ∀ (a : Nat) (r : Rd),
    Rd.readK k per (a + c) r = ((Rd.readK k per a r).1 ++ (Rd.readK k per c (Rd.readK k per a r).2).1,
      (Rd.readK k per c (Rd.readK k per a r).2).2)
  | 0, r => by simp only [Nat.zero_add]; rfl
  | a + 1, r => by
    have ih := readK_add k per c a (r.read k per).2
    rw [show a + 1 + c = (a + c) + 1 by omega]
    show ((r.read k per).1 :: (Rd.readK k per (a + c) (r.read k per).2).1, (Rd.readK k per (a + c) (r.read k per).2).2) =
      (((r.read k per).1 :: (Rd.readK k per a (r.read k per).2).1) ++
        (Rd.readK k per c (Rd.readK k per a (r.read k per).2).2).1,
        (Rd.readK k per c (Rd.readK k per a (r.read k per).2).2).2)
    rw [ih]; rfl

/-- The reader after `readK` is `readIter`. -/
theorem readK_snd (k per : Nat) : ∀ (a : Nat) (r : Rd), (Rd.readK k per a r).2 = readIter k per a r
  | 0, _ => rfl
  | a + 1, r => by
    show (Rd.readK k per a (r.read k per).2).2 = readIter k per (a + 1) r
    rw [readK_snd k per a, readIter_read]

/-- `readK` reads exactly `a` fields. -/
theorem readK_len (k per : Nat) : ∀ (a : Nat) (r : Rd), (Rd.readK k per a r).1.length = a
  | 0, _ => rfl
  | a + 1, r => by
    show ((r.read k per).1 :: (Rd.readK k per a (r.read k per).2).1).length = a + 1
    rw [List.length_cons, readK_len k per a]

/-- `Nat.beq a 0` is `false` off zero. -/
theorem beq_zero_false (a : Nat) (h : a ≠ 0) : Nat.beq a 0 = false :=
  Bool.eq_false_iff.2 fun hb => h (Nat.eq_of_beq_eq_true hb)

/-- One read inside a chunk: the field and the reader one field on. -/
theorem read_inside (k per c j : Nat) (d : List Nat) (hj : j < per) :
    ((⟨Nat.shiftRight c (Nat.mul k j), Nat.sub per j, d⟩ : Rd).read k per).2 =
      ⟨Nat.shiftRight c (Nat.mul k (j + 1)), Nat.sub per (j + 1), d⟩ := by
  have hl : Nat.beq (Nat.sub per j) 0 = false := beq_zero_false _ (by show per - j ≠ 0; omega)
  simp only [Rd.read, hl, cond_false, Rd.mk.injEq]
  refine ⟨?_, ?_, trivial⟩
  · show (c >>> (k * j)) >>> k = c >>> (k * (j + 1))
    rw [← Nat.shiftRight_add, Nat.mul_succ]
  · show per - j - 1 = per - (j + 1); omega

/-- One read at a chunk's end: the next chunk's first field. -/
theorem read_next (k per c : Nat) (d : List Nat) (q : Nat) (chunks : List Nat) (hd : d = chunks.drop q) :
    ((⟨c, Nat.sub per per, d⟩ : Rd).read k per).2 =
      ⟨Nat.shiftRight (chunks.getD q 0) (Nat.mul k 1), Nat.sub per 1, chunks.drop (q + 1)⟩ := by
  have hl : Nat.beq (Nat.sub per per) 0 = true := by rw [Nat.beq_eq]; show per - per = 0; omega
  subst hd
  simp only [Rd.read, hl, cond_true, Rd.mk.injEq]
  refine ⟨?_, trivial, ?_⟩
  · rw [List.headD_eq_head?_getD, List.head?_drop, List.getD_eq_getElem?_getD]
    show _ = (chunks[q]?.getD 0) >>> (k * 1)
    rw [Nat.mul_one]; rfl
  · rw [List.tail_drop]

/-- Inside chunk `q`, after its `j`-th field (`1 ≤ j ≤ per`), the reader holds the chunk shifted by `j` fields. -/
theorem readIter_qj (k per : Nat) (chunks : List Nat) :
    ∀ q j, 1 ≤ j → j ≤ per → readIter k per (q * per + j) ⟨0, 0, chunks⟩ =
      ⟨Nat.shiftRight (chunks.getD q 0) (Nat.mul k j), Nat.sub per j, chunks.drop (q + 1)⟩ := by
  intro q
  induction q with
  | zero =>
    intro j hj1 hjp
    induction j with
    | zero => omega
    | succ j ihj =>
      rcases Nat.eq_zero_or_pos j with h0 | hpos
      · subst h0
        rw [show 0 * per + (0 + 1) = 0 + 1 by omega]
        show ((⟨0, 0, chunks⟩ : Rd).read k per).2 = _
        have := read_next k per 0 chunks 0 chunks (by rw [List.drop_zero])
        rw [show (0 : Nat) = Nat.sub per per by show 0 = per - per; omega] at this
        simpa using this
      · rw [show 0 * per + (j + 1) = (0 * per + j) + 1 by omega]
        show ((readIter k per (0 * per + j) ⟨0, 0, chunks⟩).read k per).2 = _
        rw [ihj hpos (by omega)]
        exact read_inside k per _ j _ (by omega)
  | succ q ihq =>
    intro j hj1 hjp
    induction j with
    | zero => omega
    | succ j ihj =>
      rcases Nat.eq_zero_or_pos j with h0 | hpos
      · subst h0
        rw [show (q + 1) * per + (0 + 1) = (q * per + per) + 1 by rw [Nat.succ_mul]]
        show ((readIter k per (q * per + per) ⟨0, 0, chunks⟩).read k per).2 = _
        rw [ihq per (by omega) (Nat.le_refl _)]
        exact read_next k per _ _ (q + 1) chunks rfl
      · rw [show (q + 1) * per + (j + 1) = ((q + 1) * per + j) + 1 by omega]
        show ((readIter k per ((q + 1) * per + j) ⟨0, 0, chunks⟩).read k per).2 = _
        rw [ihj hpos (by omega)]
        exact read_inside k per _ j _ (by omega)

/-- **The reader placed directly** is the reader after `n` reads. -/
theorem readIter_eq_rdAt (k per : Nat) (hper : 0 < per) (chunks : List Nat) (n : Nat) :
    readIter k per n ⟨0, 0, chunks⟩ = rdAt k per n chunks := by
  rcases Nat.eq_zero_or_pos n with h0 | hpos
  · subst h0; rfl
  · have hb : Nat.beq n 0 = false := beq_zero_false n (by omega)
    have hdm := Nat.div_add_mod (n - 1) per
    have hml := Nat.mod_lt (n - 1) hper
    have e : n = (n - 1) / per * per + ((n - 1) % per + 1) := by rw [Nat.mul_comm]; omega
    unfold rdAt
    rw [hb, cond_false]
    conv => lhs; rw [e]
    rw [readIter_qj k per chunks _ _ (by omega) (by omega)]
    rfl

/-- `S n len = len + (len - 1) + ⋯` (`n` terms): the fields `n` rows of decreasing length read. -/
def rowsCount : Nat → Nat → Nat
  | 0, _ => 0
  | n + 1, len => len + rowsCount n (len - 1)

/-- The rows of a block's triangle below row 0, flattened, are the first `rowsCount` fields of its stream, decoded. -/
theorem rows_flatten (wr per : Nat) : ∀ (n len : Nat) (r : Rd),
    (Nat.rec (motive := fun _ => Nat → Rd → List (List Int)) (fun _ _ => [])
      (fun _ ih len r => let x := Rd.readK wr per len r; (x.1.map fun y => sfield y wr) :: ih (Nat.sub len 1) x.2)
      n len r).flatten = (Rd.readK wr per (rowsCount n len) r).1.map fun y => sfield y wr
  | 0, _, _ => rfl
  | n + 1, len, r => by
    show ((Rd.readK wr per len r).1.map fun y => sfield y wr) ++
        (Nat.rec (motive := fun _ => Nat → Rd → List (List Int)) (fun _ _ => [])
          (fun _ ih len r => let x := Rd.readK wr per len r; (x.1.map fun y => sfield y wr) :: ih (Nat.sub len 1) x.2)
          n (Nat.sub len 1) (Rd.readK wr per len r).2).flatten = _
    rw [rows_flatten wr per n (Nat.sub len 1), rowsCount, readK_add, List.map_append]
    rfl

/-- `rowsCount n n` is `n (n + 1) / 2`. -/
theorem two_mul_rowsCount : ∀ n, 2 * rowsCount n n = n * (n + 1)
  | 0 => rfl
  | n + 1 => by
    show 2 * ((n + 1) + rowsCount n (n + 1 - 1)) = (n + 1) * (n + 1 + 1)
    rw [Nat.add_sub_cancel, Nat.mul_add, two_mul_rowsCount n, Nat.mul_comm (n + 1) (n + 1 + 1),
      Nat.add_mul (n + 1) 1 (n + 1), Nat.add_mul n 1 (n + 1)]
    omega

/-- The block's coefficient count is `triCount`. -/
theorem rowsCount_eq_triCount (m : Nat) : rowsCount (m - 1) (m - 1) = triCount m := by
  unfold triCount
  have h := two_mul_rowsCount (m - 1)
  show _ = m * (m - 1) / 2
  rcases Nat.eq_zero_or_pos m with h0 | hpos
  · subst h0; rfl
  · have e : m * (m - 1) = (m - 1) * (m - 1 + 1) := by
      rw [Nat.sub_add_cancel hpos, Nat.mul_comm]
    rw [e, ← h, Nat.mul_div_cancel_left _ (by decide)]

/-- A block's coefficient list, read as one stream. -/
theorem pairCoefs_eq (b : Blk) :
    Blk.pairCoefs b = (Rd.readK b.wr b.per (triCount b.m) ⟨0, 0, b.rest⟩).1.map fun y => sfield y b.wr := by
  rw [← rowsCount_eq_triCount]
  exact rows_flatten b.wr b.per (b.m - 1) (b.m - 1) ⟨0, 0, b.rest⟩

/-- **Coefficients from a position** are the list with its first `n` entries dropped. -/
theorem coefFrom_eq (b : Blk) (hper : 0 < b.per) (n : Nat) (hn : n ≤ triCount b.m) :
    coefFrom b n = (Blk.pairCoefs b).drop n := by
  rw [pairCoefs_eq, coefFrom, ← readIter_eq_rdAt _ _ hper, ← readK_snd]
  have e : triCount b.m = n + Nat.sub (triCount b.m) n := by show _ = n + (triCount b.m - n); omega
  conv => rhs; rw [e, readK_add]
  rw [List.map_append, List.drop_append_of_le_length (by rw [List.length_map, readK_len]; exact Nat.le_refl _),
    List.drop_eq_nil_of_le (by rw [List.length_map, readK_len]; exact Nat.le_refl _), List.nil_append]

/-- The state placed directly is `p1At`, under conditions the kernel checks on the certificate. -/
theorem p1AtF_eq (C : Cert) (B : List (List ORow)) (v : Bool) (bd n : Nat) (h1 : 0 < C.per1)
    (hb : C.blocks1.all (fun b => Nat.blt 0 b.per && Nat.ble n (triCount b.m)) = true) :
    p1AtF C B v bd n = p1At C B v bd n := by
  unfold p1AtF p1At
  rw [← readIter_eq_rdAt _ _ h1]
  refine congrArg _ (congrArg _ (congrArg _ (congrArg _ ?_)))
  refine List.map_congr_left fun b hbm => ?_
  have := List.all_eq_true.1 hb b hbm
  simp only [Bool.and_eq_true, Nat.blt_eq, Nat.ble_eq] at this
  exact coefFrom_eq b this.1 n this.2

/-- **A chunk, as the kernel checks it**: `p1stepF` from the state placed directly. -/
theorem fold_drop_chunkF (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat)
    (pairs : List (Nat × Nat)) (B : List (List ORow)) (bd n len : Nat) (B' : List (List ORow)) (bd' : Nat)
    (hlen : n + len ≤ pairs.length) (h1 : 0 < C.per1)
    (hb : C.blocks1.all (fun b => Nat.blt 0 b.per && Nat.ble n (triCount b.m)) = true)
    (h : p1CoreEq (((pairs.drop n).take len).foldl (p1stepF C kt km) (p1AtF C B true bd n)) B' bd' = true) :
    (pairs.drop n).foldl (p1stepZ C kt km) (p1At C B true bd n) =
      (pairs.drop (n + len)).foldl (p1stepZ C kt km) (p1At C B' true bd' (n + len)) := by
  have hF : p1stepF C kt km = p1stepZ C kt km := funext fun s => funext fun ij => p1stepF_eq C kt km s ij
  rw [hF, p1AtF_eq C B true bd n h1 hb] at h
  exact fold_drop_chunk C kt km pairs B bd n len B' bd' hlen h

end HadwigerNelson.FibreCert
