#!/usr/bin/env python3
"""FS131-I5q: apply the `bv_l3` move and the `l3_base` extraction to the working tree (run once, from the worktree root).
Reads the compiled scratch `data/fs131/i5q/scratch/BvL3.lean`; edits `BaseWalk.lean` and `HexRing.lean`."""
import re
BW = 'Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean'
HX = 'Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean'
bw = open(BW).read()
hx = open(HX).read()
sc = open('data/fs131/i5q/scratch/BvL3.lean').read()

def cut(text, start, end):
    i = text.index(start); j = text.index(end, i)
    return text[i:j]

# ---- pieces of the scratch
dot_lemma = cut(sc, "/-- A unit vector perpendicular to `i e(θ)` is `± e(θ)`. -/", "namespace CircleColouring")
link_helpers = cut(sc, "/-- Along a path with finite fibres, the parameters whose image meets a locally finite set", "end CircleColouring")
assert link_helpers.count("{C : CircleColouring} (L : C.Lift)") == 2
link_helpers = link_helpers.replace("{C : CircleColouring} (L : C.Lift)", "(L : C.Lift)")
core = cut(sc, "/-- **Lemma 3's band-and-linkage argument**", "variable {k : ℕ} {F : ArcMap k}")
ring3 = cut(sc, "/-- **A finite ring carries no arc of `Γ`**", "/-- **A double switch along the linkage, read by its velocities**")
for a, b in [("theorem not_onRingArc_of_finite {p : ℂ}", "theorem not_onRingArc_of_finite {k : ℕ} {F : ArcMap k} {p : ℂ}"),
             ("theorem ringCircle_val_germ (hF : F.Valid)", "theorem ringCircle_val_germ {k : ℕ} {F : ArcMap k} (hF : F.Valid)"),
             ("theorem ringCircle_noSwap (hF : F.Valid)", "theorem ringCircle_noSwap {k : ℕ} {F : ArcMap k} (hF : F.Valid)")]:
    assert ring3.count(a) == 1, a
    ring3 = ring3.replace(a, b)
dbl = cut(sc, "/-- **A double switch along the linkage, read by its velocities**", "/-- **FS114-BV-HEX, (BV-L3)** — scratch copy")
bvl3_body = cut(sc, "theorem bv_l3' ", "end ArcMap")
bvl3_body = bvl3_body[bvl3_body.index(": False := by\n") + len(": False := by\n"):].rstrip() + "\n"

# ---- HexRing: take `bv_l3` out (docstring, statement, `sorry`)
blk = cut(hx, "/-- **FS114-BV-HEX, (BV-L3)** (`[SokolovVoronov2025]` Lemma 3", "end ArcMap")
assert blk.rstrip().endswith("sorry"), blk[-80:]
doc = blk[:blk.index("theorem bv_l3 ")]
stmt = blk[blk.index("theorem bv_l3 "):blk.index("  sorry")]
assert stmt.rstrip().endswith(": False := by")
hx = hx.replace(blk, "")
old = "Rows: **FS112-ROTHEX** (`rot_noThird`, `rot_out`, `rot_in`, `hex_regular`, `p17_ua`) and **FS114-BV-HEX** (`bv_hex`, `bv_l3`, `bv_nd`,\n`bv_nd1`, with BV-ND's step 1 as `linkage_dot_ne_zero`).\n"
assert hx.count(old) == 1
hx = hx.replace(old, "Rows: **FS112-ROTHEX** (`rot_noThird`, `rot_out`, `rot_in`, `hex_regular`, `p17_ua`) and **FS114-BV-HEX** (`bv_hex`, `bv_nd`, `bv_nd1`, with\nBV-ND's step 1 as `linkage_dot_ne_zero`, and the linkage to first order, `bv_l3`'s children; `bv_l3` itself is in\n`Plane/ValidMap/BaseWalk`, downstream, where its route's inputs live — inventory item 370 (a)).\n")
old = "/-! ### The linkage to first order (children for `bv_l3`'s double events) -/"
assert hx.count(old) == 1
hx = hx.replace(old, "/-! ### The linkage to first order (children for `bv_l3`'s double events; `bv_l3` is in `Plane/ValidMap/BaseWalk`) -/")
# the file's tail: no blank run before `end ArcMap`
hx = re.sub(r"\n\n\n+end ArcMap", "\n\nend ArcMap", hx)

# ---- BaseWalk
# (1) the path helpers, at the end of the `LinkAux` section
anchor = "end LinkAux\n"
assert bw.count(anchor) == 1
bw = bw.replace(anchor, link_helpers + anchor)

# (2) `l3_core` before `l3_base`, and `l3_base` over it
l3doc = "/-- **Lemma 3 in pseudo-colour form** (`[SokolovVoronov2025]` Lemma 3; BASE-V's BV-L3 route"
assert bw.count(l3doc) == 1
old_l3 = cut(bw, l3doc, "/-- **The hexagon is excluded** (Prop. 17 with unit arcs)")
i_band = old_l3.index("  -- lifts, and the band of the second (BV-H1)\n")
i_link = old_l3.index("  -- the linkage\n")
i_gen = old_l3.index("  -- the generic sets: change points and non-singleton points of each ring\n")
i_hgen = old_l3.index("  have hgen : ∀ s, φ s ∉ C₁.S ∪ N₁ → χ s ∉ C₂'.S ∪ N₂ → (L₁.f (φ s) - L₂.f (χ s)) % 3 ≠ 0 := by\n")
i_hdbl = old_l3.index("  -- (hdbl) a double event carries one pair, against FS112-N3-PAIRS (ii) under H, unless `y` turns\n")
i_ex = old_l3.index("    exfalso\n", i_hdbl)
i_sides = old_l3.index("  -- sides at the ends of the two paths\n")
head = old_l3[:i_band]
lifts = "  -- lifts\n  obtain ⟨L₁⟩ := CircleColouring.exists_lift C₁\n  obtain ⟨L₂⟩ := CircleColouring.exists_lift C₂'\n"
assert "  obtain ⟨L₁⟩ := CircleColouring.exists_lift C₁\n  obtain ⟨L₂⟩ := CircleColouring.exists_lift C₂'\n" in old_l3[i_band:i_link]
gen = old_l3[i_gen:i_hgen]
hgen_old = old_l3[i_hgen:i_hdbl]
hgen_new = hgen_old
for a, b in [("  have hgen : ∀ s, φ s ∉ C₁.S ∪ N₁ → χ s ∉ C₂'.S ∪ N₂ → (L₁.f (φ s) - L₂.f (χ s)) % 3 ≠ 0 := by\n    intro s hs1 hs2 h0\n",
              "  have hgen : ∀ a b : ℝ, dist (ringPt u₁ a) (ringPt u₂ b) = 1 → a ∉ C₁.S ∪ N₁ → b ∉ C₂'.S ∪ N₂ →\n      (L₁.f a - L₂.f b) % 3 ≠ 0 := by\n    intro a b hd hs1 hs2 h0\n"),
             ("    have hS1 : φ s ∉ C₁.S := fun h => hs1 (Or.inl h)\n", "    have hS1 : a ∉ C₁.S := fun h => hs1 (Or.inl h)\n"),
             ("    have hS2 : χ s ∉ C₂'.S := fun h => hs2 (Or.inl h)\n", "    have hS2 : b ∉ C₂'.S := fun h => hs2 (Or.inl h)\n"),
             ("    have hc : C₁.c (φ s) = C₂'.c (χ s) := by\n", "    have hc : C₁.c a = C₂'.c b := by\n"),
             ("      have h3 : ((L₁.f (φ s) - L₂.f (χ s) : ℤ) : ZMod 3) = 0 :=\n", "      have h3 : ((L₁.f a - L₂.f b : ℤ) : ZMod 3) = 0 :=\n"),
             ("    have hp2 := hpseudo2 (χ s) hS2 fun h => hs2 (Or.inr h)\n", "    have hp2 := hpseudo2 b hS2 fun h => hs2 (Or.inr h)\n"),
             ("(dist_ringPt _ _) (dist_ringPt _ _) (hdist s)\n      (hpseudo1 (φ s) hS1 fun h => hs1 (Or.inr h)) hp2\n",
              "(dist_ringPt _ _) (dist_ringPt _ _) hd\n      (hpseudo1 a hS1 fun h => hs1 (Or.inr h)) hp2\n")]:
    assert hgen_new.count(a) == 1, a
    hgen_new = hgen_new.replace(a, b)
assert "φ s" not in hgen_new and "χ s" not in hgen_new
dbl_tail = old_l3[i_ex:i_sides]     # from `exfalso` to the end of the old `hdbl`
# de-indent by one level (the old body sat inside `have hdbl ... := by`)
dbl_lines = dbl_tail.split("\n")
assert all(l == "" or l.startswith("    ") for l in dbl_lines)
dbl_tail = "\n".join(l[2:] if l else l for l in dbl_lines)
new_tail = ("  -- (hdbl) a double event carries one pair, against FS112-N3-PAIRS (ii) under H: no sense of motion is read\n"
            "  refine l3_core ht ht' L₁ L₂ hns₂'' hT₁ hT₂ subset_union_left subset_union_left hgen ?_\n"
            "  intro φ χ _ _ _ _ hdist s h2 l₁ r₁ l₂ r₂ hs1 hs2 hj1 hj2 hpair\n" + dbl_tail)
new_doc_l3 = old_l3[:old_l3.index("theorem BaseCtx.l3_base")]
old_sent = "needs no sense of motion), read along the linkage `exists_linkage` by the band lemma `link_path`. No velocity argument is used, so neither\n`linkage_dot_ne_zero` nor `bv_nd` is an input. -/\n"
assert new_doc_l3.count(old_sent) == 1
new_doc_l3 = new_doc_l3.replace(old_sent, "needs no sense of motion), fed to the band-and-linkage argument `l3_core` (the linkage `exists_linkage` read by the band lemma `link_path`).\nNo velocity argument is used, so neither `linkage_dot_ne_zero` nor `bv_nd` is an input. -/\n")
stmt_l3 = head[len(new_doc_l3_orig := old_l3[:old_l3.index("theorem BaseCtx.l3_base")]):]
new_l3 = new_doc_l3 + stmt_l3 + lifts + gen + hgen_new + new_tail.rstrip("\n") + "\n\n"

# (3) after `l3_base`: the rings' bridge, the double switch, `bv_l3`
new_doc_bv = doc.rstrip()
assert new_doc_bv.endswith("-/")
new_doc_bv = new_doc_bv[:-2].rstrip() + ("\n**Moved here from `Plane/ValidMap/HexRing`**, statement verbatim (inventory item 370 (a)), downstream of its route's inputs.\n"
    "**The proof** (FS131-I5m's route): both rings are circle colourings through one labelling `g` of the three\n"
    "absent colours (`ringCircleColouring`, with no arc of `Γ` on a finite ring, `not_onRingArc_of_finite`); the second has no swap point\n"
    "(`ringCircle_noSwap`, `RingProper`'s (ii)); generic pairs at distance `1` are never congruent (two interior points of one absent colour,\n"
    "against validity); a double switch makes `y` turn (`bv_l3_dbl`: the velocity reading, `bv_nd` under H); `l3_core` concludes. -/\n")
ring_hdr = ("/-! ### `bv_l3` (FS114-BV-HEX, moved here from `HexRing` by inventory item 370 (a)): the ring of a proper vertex as a circle colouring, the\n"
            "double switch by the linkage's velocities, and the theorem over `l3_core` -/\n\n")
after = ring_hdr + ring3 + dot_lemma + dbl + new_doc_bv + stmt + bvl3_body + "\n"
bw = bw.replace(old_l3, core + new_l3 + after)

# (4) the module docstring's line on `bv_l3`
old = "  out-contact unit arcs, so wave 5's `bv_l3` with `RingProper` does not apply — plan § 2.2), `hex_base` (Prop. 17 through `p17_ua`).\n"
assert bw.count(old) == 1
bw = bw.replace(old, "  out-contact unit arcs, so wave 5's `bv_l3` with `RingProper` does not apply — plan § 2.2; both are proofs over `l3_core`, the\n  band-and-linkage argument, and `bv_l3` follows `l3_base` here, moved from `HexRing` by inventory item 370 (a)), `hex_base` (Prop. 17\n  through `p17_ua`).\n")
open(BW, 'w').write(bw)
open(HX, 'w').write(hx)
print("applied")
