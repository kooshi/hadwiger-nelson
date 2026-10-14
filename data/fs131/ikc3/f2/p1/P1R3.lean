import Proofs.HadwigerNelson.Arith.FibreCert11
/-!
FS131-IKC3, a probe (not a library module): F2's phase 1 cut by orbit range, against the library's unchanged
`FibreCert.p1step`. A pair whose orbit `ρ` lies in `[lo, hi)` is exactly `p1step`; any other pair only advances the
stream and the blocks' coefficients. A piece passes when its in-range transporters check, its bound share is the
certificate's, and its in-range rows equal the literal `orows`. The rows of the other orbits stay zero and are not read.
-/
namespace FS131IKC3P1
open HadwigerNelson.FibreCert

/-- F2's phase-1 step restricted to the orbits `[lo, hi)`. -/
def p1stepR (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (km : List Nat) (lo hi : Nat)
    (s : P1St) (ij : Nat × Nat) : P1St :=
  cond (Nat.ble lo (Nat.div (Nat.div (s.2.2.2.1.read C.k1 C.per1).1 2) (Nat.mul 2 (Nat.add C.p 1))) &&
      Nat.blt (Nat.div (Nat.div (s.2.2.2.1.read C.k1 C.per1).1 2) (Nat.mul 2 (Nat.add C.p 1))) hi)
    (p1step C kt km s ij)
    (s.1, s.2.1, s.2.2.1, (s.2.2.2.1.read C.k1 C.per1).2, s.2.2.2.2.map List.tail)

/-- Phase 1 over every pair, processing only the orbits `[lo, hi)`. -/
def phase1R (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (lo hi : Nat) : List ORow × Bool × Nat :=
  let r := (repPairs C.reps.length).foldl (p1stepR C kt (C.blocks1.map (kmax C)) lo hi)
    (bucket16 (C.orbits.map (fun o => (o.1, o.2, 0, 0))), true, 0, ⟨0, 0, C.p1⟩, C.blocks1.map Blk.pairCoefs)
  (r.1.flatten, r.2.1, r.2.2.1)

/-- One piece of F2's phase 1: verdict, bound share `b`, and the in-range rows against the literal. -/
def p1Chk (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (lo hi b : Nat) : Bool :=
  let r := phase1R C kt lo hi
  r.2.1 && Nat.beq r.2.2 b &&
    (((r.1.zip C.orows).drop lo).take (Nat.sub hi lo)).all fun x =>
      Nat.beq x.1.2.2.1 x.2.1 && Nat.beq x.1.2.2.2 x.2.2

/-- Piece 3 of phase 1 at p = 11, orbits [165, 16384). -/
theorem piece : p1Chk cert11 (ktable cert11) 165 16384 474622218135719495944080676271464 = true := by decide +kernel
end FS131IKC3P1
