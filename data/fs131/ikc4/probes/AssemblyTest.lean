import Proofs.HadwigerNelson.Arith.FibreCert19
import Proofs.HadwigerNelson.Arith.FibreCertFast
-- FS131-IKC4 probe (never a library module): the assembly of cert19_ok with every kernel check stated as an axiom,
-- to test the assembly proof alone. The axioms are this probe's only; the library proves each by decide +kernel.
namespace HadwigerNelson.FibreCert
def cert19_p1s0 : List (List ORow) := (bucket16 (cert19.orbits.map fun o => (o.1, o.2, 0, 0)))
axiom cert19_p1c0 : p1CoreEq ((((repPairs cert19.reps.length).drop 0).take 2081).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s0 true 0 0))
    cert19_p1s1 cert19_p1b1 = true
axiom cert19_p1c1 : p1CoreEq ((((repPairs cert19.reps.length).drop 2081).take 2082).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s1 true cert19_p1b1 2081))
    cert19_p1s2 cert19_p1b2 = true
axiom cert19_p1c2 : p1CoreEq ((((repPairs cert19.reps.length).drop 4163).take 2081).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s2 true cert19_p1b2 4163))
    cert19_p1s3 cert19_p1b3 = true
axiom cert19_p1c3 : p1CoreEq ((((repPairs cert19.reps.length).drop 6244).take 2082).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s3 true cert19_p1b3 6244))
    cert19_p1s4 cert19_p1b4 = true
axiom cert19_p1c4 : p1CoreEq ((((repPairs cert19.reps.length).drop 8326).take 2082).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s4 true cert19_p1b4 8326))
    cert19_p1s5 cert19_p1b5 = true
axiom cert19_p1c5 : p1CoreEq ((((repPairs cert19.reps.length).drop 10408).take 2081).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s5 true cert19_p1b5 10408))
    cert19_p1s6 cert19_p1b6 = true
axiom cert19_p1c6 : p1CoreEq ((((repPairs cert19.reps.length).drop 12489).take 2082).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s6 true cert19_p1b6 12489))
    cert19_p1s7 cert19_p1b7 = true
axiom cert19_p1c7 : p1CoreEq ((((repPairs cert19.reps.length).drop 14571).take 2082).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 cert19_p1s7 true cert19_p1b7 14571))
    cert19_p1s8 cert19_p1b8 = true
axiom cert19_globalP : globalOKP cert19 (cert19_p1s8.flatten, true, cert19_p1b8) = true
axiom cert19_kt0_ok : ktEq (((ktable cert19).drop (5 * 0)).take 5) cert19_kt0 = true
axiom cert19_kt1_ok : ktEq (((ktable cert19).drop (5 * 1)).take 5) cert19_kt1 = true
axiom cert19_kt2_ok : ktEq (((ktable cert19).drop (5 * 2)).take 5) cert19_kt2 = true
axiom cert19_kt3_ok : ktEq (((ktable cert19).drop (5 * 3)).take 5) cert19_kt3 = true
axiom cert19_kt4_ok : ktEq (((ktable cert19).drop (5 * 4)).take 5) cert19_kt4 = true
axiom cert19_kt5_ok : ktEq (((ktable cert19).drop (5 * 5)).take 5) cert19_kt5 = true
axiom cert19_kt6_ok : ktEq (((ktable cert19).drop (5 * 6)).take 5) cert19_kt6 = true
axiom cert19_kt7_ok : ktEq (((ktable cert19).drop (5 * 7)).take 5) cert19_kt7 = true
axiom cert19_psd0 : psdCheck cert19_b0 = true
axiom cert19_psd1 : psdCheck cert19_b1 = true
axiom cert19_psd2 : psdCheck cert19_b2 = true
axiom cert19_psd3 : psdCheck cert19_b3 = true
axiom cert19_psd4 : psdCheck cert19_b4 = true
axiom cert19_psd5 : psdCheck cert19_b5 = true
axiom cert19_psd6 : psdCheck cert19_b6 = true
axiom cert19_psd7 : psdCheck cert19_b7 = true
axiom cert19_psd8 : psdCheck cert19_b8 = true
axiom cert19_psd9 : psdCheck cert19_b9 = true
axiom cert19_psd10 : psdCheck cert19_b10 = true
axiom cert19_psd11 : psdCheck cert19_b11 = true
axiom cert19_psd12 : psdCheck cert19_b12 = true
axiom cert19_psd13 : psdCheck cert19_b13 = true
axiom cert19_psd14 : psdCheck cert19_b14 = true
axiom cert19_psd15 : psdCheck cert19_b15 = true
axiom cert19_psd16 : psdCheck cert19_b16 = true
axiom cert19_psd17 : psdCheck cert19_b17 = true
axiom cert19_psd18 : psdCheck cert19_b18 = true
axiom cert19_psdq0 : psdCheck cert19_q0 = true
axiom cert19_seg0 : segCheckZ cert19 0 = true
axiom cert19_seg1 : segCheckZ cert19 1 = true
axiom cert19_seg2 : segCheckZ cert19 2 = true
axiom cert19_seg3 : segCheckZ cert19 3 = true

/-- `cert19`'s modulus. -/
theorem cert19_p : cert19.p = 19 := rfl

/-- `cert19`'s numerator `U`. -/
theorem cert19_unum : cert19.unum = 8864340098471101020193379809808304 := rfl

/-- `cert19`'s scale `L`. -/
theorem cert19_scale : cert19.scale = 100000000000000000000000000000000 := rfl

/-- `cert19`'s number of identity segments. -/
theorem cert19_nseg : cert19.nseg = 4 := rfl

/-- The checker's K table at `p = 19` is the literal, piece by piece (`cert19_kt0_ok` …). -/
theorem ktable_cert19 : ktable cert19 = cert19_kt := by
  have hlen : (ktable cert19).length = 40 := by decide +kernel
  refine (eq_flatten_of_pieces 5 [cert19_kt0, cert19_kt1, cert19_kt2, cert19_kt3, cert19_kt4, cert19_kt5, cert19_kt6, cert19_kt7] (ktable cert19) (fun i hi => ?_)
    (by rw [hlen]; decide)).trans rfl
  match i, hi with
  | 0, _ => exact ktEq_eq _ _ cert19_kt0_ok
  | 1, _ => exact ktEq_eq _ _ cert19_kt1_ok
  | 2, _ => exact ktEq_eq _ _ cert19_kt2_ok
  | 3, _ => exact ktEq_eq _ _ cert19_kt3_ok
  | 4, _ => exact ktEq_eq _ _ cert19_kt4_ok
  | 5, _ => exact ktEq_eq _ _ cert19_kt5_ok
  | 6, _ => exact ktEq_eq _ _ cert19_kt6_ok
  | 7, _ => exact ktEq_eq _ _ cert19_kt7_ok
  | n + 8, h => exact absurd h (by simp)

/-- Phase 1 at `p = 19` is its last chunk's result (`cert19_p1c0` … `cert19_p1c7`). -/
theorem cert19_phase1 : phase1KZ cert19 cert19_kt = (cert19_p1s8.flatten, true, cert19_p1b8) := by
  have h1 : 0 < cert19.per1 := by decide +kernel
  have hpl : (repPairs cert19.reps.length).length = 16653 := by decide +kernel
  have hs : ((bucket16 (cert19.orbits.map fun o => (o.1, o.2, 0, 0))), true, 0, (⟨0, 0, cert19.p1⟩ : Rd), cert19.blocks1.map Blk.pairCoefs) =
      p1At cert19 cert19_p1s0 true 0 0 := by
    simp only [p1At, cert19_p1s0, List.drop_zero]
    try rfl
  have e : (repPairs cert19.reps.length).foldl (p1stepZ cert19 cert19_kt (cert19.blocks1.map (kmax cert19)))
      (p1At cert19 cert19_p1s0 true 0 0) = p1At cert19 cert19_p1s8 true cert19_p1b8 16653 := by
    rw [← List.drop_zero (l := repPairs cert19.reps.length)]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s0 0 0 2081 cert19_p1s1 cert19_p1b1
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c0, show 0 + 2081 = 2081 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s1 cert19_p1b1 2081 2082 cert19_p1s2 cert19_p1b2
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c1, show 2081 + 2082 = 4163 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s2 cert19_p1b2 4163 2081 cert19_p1s3 cert19_p1b3
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c2, show 4163 + 2081 = 6244 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s3 cert19_p1b3 6244 2082 cert19_p1s4 cert19_p1b4
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c3, show 6244 + 2082 = 8326 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s4 cert19_p1b4 8326 2082 cert19_p1s5 cert19_p1b5
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c4, show 8326 + 2082 = 10408 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s5 cert19_p1b5 10408 2081 cert19_p1s6 cert19_p1b6
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c5, show 10408 + 2081 = 12489 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s6 cert19_p1b6 12489 2082 cert19_p1s7 cert19_p1b7
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c6, show 12489 + 2082 = 14571 from rfl]
    rw [fold_drop_chunkF cert19 cert19_kt _ _ cert19_p1s7 cert19_p1b7 14571 2082 cert19_p1s8 cert19_p1b8
      (by rw [hpl]; decide) h1 (by decide +kernel) cert19_p1c7, show 14571 + 2082 = 16653 from rfl]
    rw [List.drop_eq_nil_of_le (by rw [hpl]; exact Nat.le_refl _), List.foldl_nil]
  simp only [phase1KZ]
  rw [hs, e]
  rfl

/-- The shape check at `p = 19`, through the K table's literal and phase 1's chunks. -/
theorem cert19_global : globalOK cert19 = true := by
  rw [globalOK_eq_K, ktable_cert19, ← globalOKKZ_eq, globalOKKZ_eq_P, cert19_phase1]
  exact cert19_globalP

/-- **The `p = 19` certificate passes**: the shape (`cert19_global`), the identity segments (`cert19_seg0` …) and
positive definiteness (`cert19_psd0` …), each checked by the kernel in its own module. -/
theorem cert19_ok : certOK cert19 = true := by
  have hs : segAll cert19 = true := by
    change (List.range cert19.nseg).all (segCheck cert19) = true
    rw [cert19_nseg]
    refine List.all_eq_true.2 fun k hk => ?_
    rw [List.mem_range] at hk
    rw [segCheck_eq_Z]
    match k, hk with
    | 0, _ => exact cert19_seg0
    | 1, _ => exact cert19_seg1
    | 2, _ => exact cert19_seg2
    | 3, _ => exact cert19_seg3
    | n + 4, h => exact absurd h (by omega)
  have hp : psdAll cert19 = true := by
    change (cert19.blocks1 ++ cert19.blocksq).all psdCheck = true
    rw [show cert19.blocks1 = [cert19_b0, cert19_b1, cert19_b2, cert19_b3, cert19_b4, cert19_b5, cert19_b6, cert19_b7, cert19_b8, cert19_b9, cert19_b10, cert19_b11, cert19_b12, cert19_b13, cert19_b14, cert19_b15, cert19_b16, cert19_b17, cert19_b18] from rfl, show cert19.blocksq = [cert19_q0] from rfl]
    simp only [List.cons_append, List.nil_append, List.all_cons, List.all_nil, cert19_psd0, cert19_psd1, cert19_psd2, cert19_psd3, cert19_psd4, cert19_psd5, cert19_psd6, cert19_psd7, cert19_psd8, cert19_psd9, cert19_psd10, cert19_psd11, cert19_psd12, cert19_psd13, cert19_psd14, cert19_psd15, cert19_psd16, cert19_psd17, cert19_psd18, cert19_psdq0, Bool.and_self]
  change (globalOK cert19 && segAll cert19 && psdAll cert19) = true
  rw [cert19_global, hs, hp]
  rfl

end HadwigerNelson.FibreCert
#print axioms HadwigerNelson.FibreCert.cert19_ok
