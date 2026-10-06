#!/usr/bin/env python3
"""FS131-L5 — the tidies that waited for the merge of `fs131-w5z`, as data (rulings 457 (b), 465 (a), (b); FS131-RP1's closing list).

Each entry is (file, old, new): `old` must stand EXACTLY ONCE in the file or nothing is written to any file.
  python3 data/fs131/l5/tidy_edits.py --dry    count the matches, write nothing
  python3 data/fs131/l5/tidy_edits.py          apply (refused unless every entry matches once)
Groups: A — the unread `hF : F.Valid` out of seven lemmas, with their callers; B — `ringPt_ne_of_abs_sub_lt` (`BaseDense`) made one
with `ringPt_inj_of_abs_sub_lt` (`BendAway`, upstream); C — the stale "skeleton" and "open" lines.
"""
import sys

V = 'Proofs/HadwigerNelson/Plane/ValidMap/'
COLLAR, STEP, ARC, GAP, DENSE, AWAY = (V + n + '.lean' for n in ('BendCollar', 'BendStep', 'ArcStep', 'BendGap', 'BaseDense', 'BendAway'))
AX = 'scripts/Axioms.lean'
ARCH = 'ARCHITECTURE.md'
FIT = "(hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'')"
FITO = "(hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'')"

E = []

# ---------------------------------------------------------------- A. the unread hF
E += [
    # BendCollar: the toward four
    (COLLAR, f"theorem CollarFit.sides_end (hF : F.Valid) {FIT} {{Q x : ℂ}} (hQ : Q ≠ P)",
             f"theorem CollarFit.sides_end {FIT} {{Q x : ℂ}} (hQ : Q ≠ P)"),
    (COLLAR, "  have _ := hF\n  have h12 := hfit.ring.1\n  obtain ⟨ρ, hρ, hside⟩ := hfit.exists_one_side hQ hx",
             "  have h12 := hfit.ring.1\n  obtain ⟨ρ, hρ, hside⟩ := hfit.exists_one_side hQ hx"),
    (COLLAR, f"theorem CollarFit.sides_eq (hF : F.Valid) {FIT} {{Q x : ℂ}} (hxΓ : x ∈ F.Γ)",
             f"theorem CollarFit.sides_eq {FIT} {{Q x : ℂ}} (hxΓ : x ∈ F.Γ)"),
    (COLLAR, "      exact hfit.sides_end hF (hQ hend) hend", "      exact hfit.sides_end (hQ hend) hend"),
    (COLLAR, f"theorem CollarFit.map_R1 (hF : F.Valid) {FIT} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}",
             f"theorem CollarFit.map_R1 {FIT} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}"),
    (COLLAR, "      obtain ⟨hin, hout⟩ := hfit.sides_end hF hQ hend", "      obtain ⟨hin, hout⟩ := hfit.sides_end hQ hend"),
    (COLLAR, f"theorem CollarFit.map_R2 (hF : F.Valid) {FIT} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}",
             f"theorem CollarFit.map_R2 {FIT} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}"),
    (COLLAR, "    obtain ⟨hin, hout⟩ := hfit.sides_eq hF (hsub ", "    obtain ⟨hin, hout⟩ := hfit.sides_eq (hsub "),
    # their callers in BendCollar
    (COLLAR, "  have hFA := hfit.map_R1 hF hA", "  have hFA := hfit.map_R1 hA"),
    (COLLAR, "    fun Q a b d d' h => hfit.map_R1 hF h, fun Q a b d d' h hd => hfit.map_R2 hF h hd, fun θ hθ => hfit.map_R3 hθ,",
             "    fun Q a b d d' h => hfit.map_R1 h, fun Q a b d d' h hd => hfit.map_R2 h hd, fun θ hθ => hfit.map_R3 hθ,"),
    # BendStep: a caller of the toward R2, and the toward horn clause
    (STEP, "hfit.free_open (fun _ _ hA => hfit.map_R2 hF hA hdisj) hcolQ hR", "hfit.free_open (fun _ _ hA => hfit.map_R2 hA hdisj) hcolQ hR"),
    (STEP, f"theorem CollarFit.map_hornCount_le (hF : F.Valid) {FIT} {{x : ℂ}} {{j : ℕ}}",
           f"theorem CollarFit.map_hornCount_le {FIT} {{x : ℂ}} {{j : ℕ}}"),
    (STEP, "  -- validity is not read: the clause is geometry of `Γ` (reported: FS131-BA2's record)\n  have _ := hF\n  obtain ⟨hR', hR'R, hR1, hR''⟩ := hfit.params",
           "  obtain ⟨hR', hR'R, hR1, hR''⟩ := hfit.params"),
    # ArcStep: the callers in `CollarFit.arcBend`
    (ARC, "    fun x j hj => hfit.map_hornCount_le hF hj, hfit.map_ringArcsWithin, fun Q a b d d' hD => hfit.map_R1 hF hD,",
          "    fun x j hj => hfit.map_hornCount_le hj, hfit.map_ringArcsWithin, fun Q a b d d' hD => hfit.map_R1 hD,"),
    (ARC, "    fun Q a b d d' hD hd => hfit.map_R2 hF hD hd, fun θ hθ => Or.inr ?_,",
          "    fun Q a b d d' hD hd => hfit.map_R2 hD hd, fun θ hθ => Or.inr ?_,"),
    # BendGap: the outward R1, R2 and their two calls in `CollarFitOut.awayBend`
    (GAP, f"theorem CollarFitOut.map_R1 (hF : F.Valid) {FITO} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}",
          f"theorem CollarFitOut.map_R1 {FITO} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}"),
    (GAP, "    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by\n"
          "  -- validity is not read: the clause is geometry of `Γ` and of the homeomorphism (reported: FS131-BA3's record)\n  have _ := hF\n",
          "    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by\n"),
    (GAP, f"theorem CollarFitOut.map_R2 (hF : F.Valid) {FITO} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}",
          f"theorem CollarFitOut.map_R2 {FITO} {{Q : ℂ}} {{a b : ℝ}} {{d d' : Fin k}}"),
    (GAP, "    hfit.map.IsRingArc Q a b d d' := by\n"
          "  -- validity is not read: the clause is geometry of `Γ` and of the homeomorphism (reported: FS131-BA3's record)\n  have _ := hF\n",
          "    hfit.map.IsRingArc Q a b d d' := by\n"),
    (GAP, "      r1 := fun Q a' b' d d' h => hfit.map_R1 hF h\n      r2 := fun Q a' b' d d' h hd => hfit.map_R2 hF h hd",
          "      r1 := fun Q a' b' d d' h => hfit.map_R1 h\n      r2 := fun Q a' b' d d' h hd => hfit.map_R2 h hd"),
]

# ---------------------------------------------------------------- B. one lemma for "angles under a turn apart, one ring point"
NE_DECL = '''/-- Ring points at angles less than a turn apart differ. -/
theorem ringPt_ne_of_abs_sub_lt (p : ℂ) {s t : ℝ} (h0 : s ≠ t) (h : |s - t| < 2 * π) : ringPt p s ≠ ringPt p t := by
  intro he
  have he' : e s = e t := by simpa [ringPt] using he
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he'
  have hπ := Real.pi_pos
  have h1 : |(n : ℝ)| * (2 * π) < 2 * π := by
    have : s - t = n * (2 * π) := by linarith
    rw [this, abs_mul, abs_of_pos (by positivity : 0 < 2 * π)] at h
    exact h
  have hn0 : n = 0 := by
    by_contra hne
    have : (1 : ℝ) ≤ |(n : ℝ)| := by
      have : (1 : ℤ) ≤ |n| := Int.one_le_abs hne
      exact_mod_cast this
    nlinarith
  rw [hn0] at hn
  exact h0 (by simpa using hn)
'''
E += [
    (DENSE, NE_DECL,
     "-- Ring points at angles less than a turn apart differ: `ringPt_inj_of_abs_sub_lt` (`Plane/ValidMap/BendAway`, upstream); this\n"
     "-- file's contrapositive copy `ringPt_ne_of_abs_sub_lt` was removed by FS131-L5 (inventory items 454, 465 (b)).\n"),
    (DENSE, "    refine ringPt_ne_of_abs_sub_lt P (s := ψ) (t := min θ₁ a) (by rw [hmin]; linarith [hψ.1]) ?_ hψe\n",
            "    have hψne : ψ ≠ min θ₁ a := by rw [hmin]; linarith [hψ.1]\n"
            "    refine hψne (ringPt_inj_of_abs_sub_lt (P := P) ?_ hψe)\n"),
    (DENSE, "    refine ringPt_ne_of_abs_sub_lt P (s := max θ₂ b) (t := ψ) (by rw [hmaxb]; linarith [hψ.2]) ?_ hψe.symm\n",
            "    have hψne : max θ₂ b ≠ ψ := by rw [hmaxb]; linarith [hψ.2]\n"
            "    refine hψne (ringPt_inj_of_abs_sub_lt (P := P) ?_ hψe.symm)\n"),
    (DENSE, "    refine ringPt_ne_of_abs_sub_lt P (s := θ + 1 * t) (t := θ + -1 * t) (by linarith) ?_ (hi.trans hj.symm)\n",
            "    have hθne : θ + 1 * t ≠ θ + -1 * t := by linarith\n"
            "    refine hθne (ringPt_inj_of_abs_sub_lt (P := P) (θ := θ + 1 * t) (θ' := θ + -1 * t) ?_ (hi.trans hj.symm))\n"),
    (AWAY, "/-- Two angles less than a turn apart with one point of `ω(P)` are equal (`e_eq_e_iff`; `ringPt_ne_of_abs_sub_lt` of\n"
           "`Plane/ValidMap/BaseDense`, which this module is upstream of, is its contrapositive). -/",
           "/-- Two angles less than a turn apart with one point of `ω(P)` are equal (`e_eq_e_iff`). The one statement of this fact:\n"
           "`Plane/ValidMap/BaseDense`, downstream, reads it where it once held the contrapositive under a name of its own. -/"),
    (AX, "#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ne_of_abs_sub_lt\n", ""),
]

# ---------------------------------------------------------------- C. the stale "skeleton" and "open" lines
E += [
    # the six module titles
    (AWAY, "# The away bend's clause package and its composition over a subdivision (FS131-KA1's skeleton)",
           "# The away bend's clause package and its composition over a subdivision (FS131-KA1's plan; proved by FS131-BA1)"),
    (V + 'LensOut.lean', "# The outward radial push and the outward lens (FS131-KA1's skeleton for the away collar bend)",
                         "# The outward radial push and the outward lens (for the away collar bend; FS131-KA1's plan, proved by FS131-BA1)"),
    (V + 'CollarMapOut.lean', "# The outward collar bend's map (FS131-KA1's skeleton; mirror of `Plane/ValidMap/CollarMap`)",
                              "# The outward collar bend's map (FS131-KA1's plan, proved by FS131-BA1; mirror of `Plane/ValidMap/CollarMap`)"),
    (V + 'HornChart.lean', "# Horn counts where a collar bend needs them (FS131-KA1's skeleton; both collar bends)",
                           "# Horn counts where a collar bend needs them (FS131-KA1's plan, proved by FS131-BA2; both collar bends)"),
    (V + 'R2Cap.lean', "# The radius-2 circle over a constant-sided unit arc: the crescent, the dichotomy, the subdivision (FS131-KA1's skeleton)",
                       "# The radius-2 circle over a constant-sided unit arc: the crescent, the dichotomy, the subdivision (FS131-KA1's plan, proved by FS131-BA2)"),
    (GAP, "# The away bend of one gap: the outward collar bend (FS131-KA1's skeleton; mirror of `Plane/ValidMap/BendCollar`)",
          "# The away bend of one gap: the outward collar bend (FS131-KA1's plan, proved by FS131-BA2 and FS131-BA3; mirror of `Plane/ValidMap/BendCollar`)"),
    # BendStep
    (STEP, "* **The horn clause for the collar bend** (`CollarFit.map_hornCount_le`, open: its children are `Plane/ValidMap/HornChart`'s) and **the",
           "* **The horn clause for the collar bend** (`CollarFit.map_hornCount_le`, over `Plane/ValidMap/HornChart`'s children) and **the"),
    (STEP, "/-! ## The away bend, in the form the arc step reads (open) -/", "/-! ## The away bend, in the form the arc step reads -/"),
    (STEP, "about the angle). **Proved from open children**\n(`plans/FS131-bendaway-kernel-plan.md` § 3): the finite subdivision",
           "about the angle). **Proved from FS131-KA1's children**\n(`plans/FS131-bendaway-kernel-plan.md` § 3; FS131-BA1, BA2, BA3): the finite subdivision"),
    (STEP, "Model of the hypotheses: none in Lean on this branch; `isoFrag`", "Model of the hypotheses: none in Lean yet; `isoFrag`"),
    # ArcStep
    (ARC, "(the spec example at the end), which rests on the open child\n`CollarFit.map_hornCount_le` (`BendStep`). No Lean model",
          "(the spec example at the end; its horn clause is\n`CollarFit.map_hornCount_le`, `BendStep`). No Lean model"),
    (ARC, "`left` is vacuous (R3, `CollarFit.map_R3`). It rests\non the open child `CollarFit.map_hornCount_le` (`BendStep`) for `horn`. -/",
          "`left` is vacuous (R3, `CollarFit.map_R3`); `horn` is\n`CollarFit.map_hornCount_le` (`BendStep`). -/"),
    (ARC, "the outer colour `1` gaining. (It rests on `CollarFit.map_hornCount_le`, open.) -/", "the outer colour `1` gaining. -/"),
    # scripts/Axioms.lean: the four block headers that still describe open children
    (AX, "The last two records are open children (`sorry`): the horn clause for the collar bend, and the away bend in collar form. -/",
         "The last two records — the horn clause for the collar bend, and the away bend in collar form — were this module's open children;\n"
         "both are proved (FS131-BA2; FS131-BA1, BA2, BA3 over FS131-KA1's plan). -/"),
    (AX, "The last two records rest on the open child `CollarFit.map_hornCount_le` (`BendStep`, `sorry`): the toward collar bend's\ninstance of the interface. -/",
         "The last two records are the toward collar bend's instance of the interface; its horn clause is `CollarFit.map_hornCount_le`\n(`BendStep`), proved by FS131-BA2. -/"),
    (AX, "/-! ## FS-131 wave 5 (job FS131-KA1) — the away bend's skeleton (`Plane/ValidMap/BendAway`, `LensOut`, `HornChart`, `CollarMapOut`, `R2Cap`, `BendGap`)\n\n"
         "The first six records are proved. The rest are the plan's open children (`sorry`) and the three theorems proved from them\n"
         "(`bend_away_gap`, `bend_away_subdiv`, `CollarFitOut.pushOutProfiles`; `bend_away_part` is in FS131-IA1's block above): the gate fails on\n"
         "each until its children land. -/",
         "/-! ## FS-131 wave 5 (job FS131-KA1) — the away bend as FS131-KA1 laid it out (`Plane/ValidMap/BendAway`, `LensOut`, `HornChart`, `CollarMapOut`, `R2Cap`, `BendGap`)\n\n"
         "The plan's children and the three theorems proved from them (`bend_away_gap`, `bend_away_subdiv`, `CollarFitOut.pushOutProfiles`;\n"
         "`bend_away_part` is in FS131-IA1's block above). Every record is proved: lanes G and D by FS131-BA1, lanes C and H by FS131-BA2,\n"
         "`CollarFitOut.map_R1` and `map_R2` by FS131-BA3 (their helpers are in those jobs' blocks below). -/"),
    (AX, "of the bent arc. `exists_arcStep` itself has its record above (once); it holds no `sorry` of its own now and rests, through\n"
         "`bend_away_part` and `exists_arcBend_toward`, on the open declarations of the six bend modules (`BendAway`, `LensOut`,\n"
         "`CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`) and on `BendStep`'s `CollarFit.map_hornCount_le`, so the gate fails on it, and on\n"
         "what is proved over it, until they land. Moved by the join, in FS131-IA2's block above: `CollarFit.map_localStep` is through `sorryAx` until\n"
         "`Plane/ValidMap/BendAway`'s `LocalStep.of_cutArcs` is proved (its proof stood in `ArcStep` on `fs131-w5y`; inventory item 448 (a)). -/",
         "of the bent arc. `exists_arcStep` itself has its record above (once); it rests, through `bend_away_part` and\n"
         "`exists_arcBend_toward`, on the six bend modules (`BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`) and on\n"
         "`BendStep`'s `CollarFit.map_hornCount_le`, all proved since FS131-L5 merged `fs131-w5z`. Moved by the join, in FS131-IA2's block\n"
         "above: `CollarFit.map_localStep` reads `Plane/ValidMap/BendAway`'s `LocalStep.of_cutArcs` (its proof stood in `ArcStep` on\n"
         "`fs131-w5y`; inventory item 448 (a)). -/"),
]

# ARCHITECTURE.md: the rows that still list open children
E += [
    (ARCH, "`LocalStep.union` (two local steps in a row), proved. **Open children (`sorry`)**: `LocalStep.of_cutArcs` (FS131-IA1's W1 and W2, for both collar bends), `AwayBend.idle`, `AwayBend.next`, `AwayBend.join`, `AwayBend.r2_of_onRingArc`.",
           "`LocalStep.union` (two local steps in a row). **Proved (FS131-BA1)**: `LocalStep.of_cutArcs` (FS131-IA1's W1 and W2, for both collar bends), `AwayBend.idle`, `AwayBend.next`, `AwayBend.join`, `AwayBend.contact_of_onRingArc`; `ringPt_inj_of_abs_sub_lt`."),
    (ARCH, "FS131-E5's Claim E and END-CAP (`claim_e`, `end_cap`), proved. **Open children (`sorry`)**: `pushOutHomeo`'s proof fields and its three access lemmas, `pushOutProfiles_collar`, `collarOutArcs_carrier`, `dist_lt_one_of_thin`.",
           "FS131-E5's Claim E and END-CAP (`claim_e`, `end_cap`). **Proved (FS131-BA1)**: `pushOutHomeo`'s proof fields and its three access lemmas, `pushOutProfiles_collar`, `collarOutArcs_carrier`, `dist_lt_one_of_thin`."),
    (ARCH, "`IsSectorChart.hasHornCount` (the count at any sector chart), proved. **Open children (`sorry`)**: `hasHornCount_iff_of_agree`,",
           "`IsSectorChart.hasHornCount` (the count at any sector chart). **Proved (FS131-BA2)**: `hasHornCount_iff_of_agree`,"),
    (ARCH, "the bent map `CollarFitOut.map`. **Open children (`sorry`)**: `homeo_image_dom`,", "the bent map `CollarFitOut.map`. **Proved (FS131-BA1)**: `homeo_image_dom`,"),
    (ARCH, "(laid out by FS131-KA1). **Open children (`sorry`)**: `exists_r2_crescent_free`", "(laid out by FS131-KA1). **Proved (FS131-BA2)**: `exists_r2_crescent_free`"),
    (ARCH, "as an `AwayBend`, proved from its children. **Open children (`sorry`)**: `exists_lensOut_clear`",
           "as an `AwayBend`, proved from its children. **Proved (FS131-BA2; `map_R1`, `map_R2` by FS131-BA3)**: `exists_lensOut_clear`"),
    (ARCH, "**One open child here (`sorry`)**: the horn clause for the collar bend (`CollarFit.map_hornCount_le`), planned over `Plane/ValidMap/HornChart`.",
           "The horn clause for the collar bend (`CollarFit.map_hornCount_le`), proved by FS131-BA2 over `Plane/ValidMap/HornChart`."),
    (ARCH, "(`CollarFit.arcBend`, `exists_arcBend_toward`, over the open child `CollarFit.map_hornCount_le`)",
           "(`CollarFit.arcBend`, `exists_arcBend_toward`, over `CollarFit.map_hornCount_le`)"),
    (ARCH, "| `Plane/ValidMap/Terminal` | **FS-131 wave 5, skeleton** (job FS131-K5).", "| `Plane/ValidMap/Terminal` | **FS-131 wave 5** (laid out by job FS131-K5; no `sorry`)."),
]


def main():
    dry = '--dry' in sys.argv
    texts, bad = {}, 0
    for path, old, new in E:
        t = texts.setdefault(path, open(path).read())
        n = t.count(old)
        if n != 1:
            bad += 1
            print(f'REFUSED ({n} matches) {path}: {old[:90]!r}')
            continue
        assert old != new
        texts[path] = t.replace(old, new, 1)
    print(f'{len(E)} edits, {len(E) - bad} matched once, {bad} refused, in {len(texts)} files')
    if bad:
        print('nothing written')
        return 1
    if dry:
        print('dry run: nothing written')
        return 0
    for path, t in texts.items():
        open(path, 'w').write(t)
    print('written')
    return 0


if __name__ == '__main__':
    sys.exit(main())
