# FS-73 phase P4 — the rank-6 mechanism, re-aimed by the competition

*Implementer F (Opus 5.5), 2026-09-23, desktop (16 physical cores / 32 threads, 128 GB). Specification:
`plans/FS73-rigidity-dichotomy.md` §S.2 row P4 and §S.3's P4 acceptance row, re-aimed by the product owner's brief
(`…/scratchpad/fs73-implF/BRIEF.md`): after the competition, three colours is settled for every lattice (Coxeter's H-iii), so the
live question is four colours; two additions — a chirality column and a statement of what the rank-6 data says about four colours.*

## Registration (written 2026-09-23, before any P4 run, after reading only the records listed in the brief)

**What is already known before any run, and what it does to the spec (pre-run reading, [hand]).**
1. **The fixed-prime gap lemma does not reach the rank-6 lattices.** L2, L3 and L6 span 6-dimensional subspaces of the degree-8
   field E = ℚ(√3,√5,i), so they lie in no quartic CM subfield, and the lemma needs a conjugation-fixed prime of E itself whose target
   four-colours with a gap. E has none: the primes of E above 2, 3 and 5 are swapped by conjugation (above 2 because 15 ≡ 7 (mod 8)
   breaks the wall; above 3 and 5 because the one prime of ℚ(√3,√5) there has residue field 𝔽₉ or 𝔽₂₅, which contains i); a fixed
   odd unramified prime needs residue field 𝔽_p with p ≡ 3 (mod 4) and 3, 5 both squares mod p — p = 11, 59, … — whose targets Γ_p
   are at least 5-chromatic. So the brief's "loose (F = 0) by the fixed-prime gap lemma" is not the reason, for any of the three.
2. **L2 and L6 are loose by their own gapped colourings** (FS-70 phase 1d: gapped at N = 5), through FS70-T6. And **the loose
   verdict is periodic**: recolouring the whole coset g + W′ of a gapped class g (W′ ⊆ 5Λ of finite index, δ ∉ W′; no two points of
   g + W′ are adjacent because W′ holds no unit vector) gives a W′-periodic separator of (0, δ) for every δ ≠ 0. So **F = P = 0 on L2
   and L6 before any P4 run**, and C3-inherit holds there trivially. Equivalently, in the normal form: a gapped vertex is a Kempe
   component with no edge, so **a gapped colouring has KPer(c) = 0**.
3. **L3 is the one rank-6 lattice whose four-colour F and P are not known.** It is gap-free at every admissible N ≤ 8 (FS-70 1e,
   P3), every chainable target escapes (T11), and P1g found rank-4 voltage groups at N = 2. So on L3 the P4 table decides between:
   (a) P_found = 0 — L3 loose, F = P = 0, certified by finitely many periodic colourings whose Kempe period groups (and their images
   under the point group, since g·c is again a periodic colouring) intersect in 0; or (b) P_found ≠ 0 with F unknown — the first
   rank-6 instance of "rigid-found, forcing undecided" at four colours.
4. **N = 2 colourings are never chiral**: −x ≡ x (mod 2Λ), so c(−x) = c(x). Chirality needs Λ/Per(c) of exponent > 2.
5. **Additive ⟺ [Λ : Per(c)] = 4** (the colour classes are then the four cosets of Per(c)); so the additive column is read off Per.

**Predictions (each with both outcomes reachable).**

| id | prediction | confidence | outcomes |
|---|---|---|---|
| P-F1 | On L3, P_found over the colourings found at the admissible N ≤ 6, closed under L3's point group, is **0**: L3 is loose (F = P = 0), by the rank-4 voltage groups rotated by ζ₆ | medium (0.6) | 0 / a nonzero subgroup (rank 2 or 4 most likely, a ℚ(√−3)-stable span) |
| P-F2 | Some non-additive colouring found on L2, L3 or L6 at N = 4 or 6 is **chiral** (no colour permutation τ and translation t with c(t − x) = τ(c(x))) | medium (0.65) | at least one chiral non-additive / none |
| P-F3 | The rank-6 K-lattice (de Grey's 30 generators plus the ζ₆-orbit of ρ₁₅, over K(√5)) has rank 6 and a **gapped** periodic colouring at some admissible N ≤ 6 (loose) | low-medium (0.5) | gapped / gap-free at every admissible N ≤ 6 |
| P-F4 | Whatever P_found is on L3, **no chainable target lies in it** (T11 already says they escape) and the escapes' W′ are 2-power or {2,3}-composite exactly as P1g found at N = 2 | high (0.85) | as stated / a target in P_found (would contradict T11's committed colourings: a tool defect) |

**Budget and stop rule (plan):** ≤ 4 core-hours, ≤ 250k tokens; stop when every rank-6 lattice held has its NΛ/V table at N ≤ 6.
**Checkpoint:** `data/fs73/rank6/rows.jsonl` (append-only, fsynced per row; a key present is never recomputed); resume command in the
Regenerate section. A kill redoes at most one lattice-period pair.
