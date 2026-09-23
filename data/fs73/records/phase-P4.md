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

---

## Headline (after the runs)

- **Every rank-6 lattice held is uninformative for C3 at four colours, and each for a stated reason (a typed null).**
  - **L3 is loose: F = P = 0.** One gap-free 2L3-periodic colouring has Kempe period group KPer(c) = 0. So by R3 every δ ≠ 0 is
    separated by a periodic colouring. Six of the 2,304 period-2 colourings do this; the certificate row stores one.
    - Before this, L3 was known only to have no compulsion at the chainable targets (FS70-T11).
    - It is the first lattice loose **without a gap**: FS70-T6's gap is sufficient for looseness, not necessary.
  - **L2 and L6: F = P = 0**, from their gapped colourings at N = 5 (every gapped colouring read KPer = 0, 7 of 7).
  - **KR6** (de Grey's 30 generators plus the ζ₆-orbit of ρ₁₅ over K(√5); rank 6, 78 unit vectors, point group 48):
    - **No periodic colouring at any N ≤ 6.** N = 2, 3, 4, 6 are inadmissible, because 1/4 and 1/3 lie in the lattice (so −1 ∈ 4Λ
      and −1 ∈ 3Λ). N = 5 is refused, as the restriction theorem below predicts (UNSAT, 1.4 s).
    - **And F ⊇ 8Λ_dG**, by monotonicity, so it is not loose.
    - Whether it is four-colourable at all is **open**. Heule-510 does not sit in it by its given embedding: 30 of its distinct
      edge vectors (468 of 2,504 edges) are unit vectors of K(√5) outside KR6's 78 (the PO's check).
- **The mechanism, in the owner's words ("what determines NΛ/V and the targets' images"):** the fibre-collision sandwich below. At
  period 2, NΛ/V is colouring-free arithmetic of U mod 2, up to a 2-group. At periods 4 and 6, cycles carry the rank.
- **Chirality: chiral non-additive four-colourings are common, and all of them sit on loose lattices.** Chirality is necessary for
  Coxeter's shape and nowhere near sufficient.
  - The counts: L3 at N = 4, 1 of 3; L3 at N = 6, 3 of 4; L2 at N = 4, 2 of 2; L2 at N = 5, 3 of 3; L6 at N = 5, 4 of 4.
  - Every period-2 colouring is achiral, as −x ≡ x (mod 2Λ) forces.
  - **Correction for Coxeter's §6:** his C-5 colouring `01012323` is chiral about the origin but **achiral up to translation**. The
    reflection about 3/2, composed with τ = (01)(23), maps it to itself (the selftest asserts this).

## Rows (`data/fs73/rank6/rows.jsonl`; the summary is `summary.json`)

| lattice | rank, U, M, point group | N: colourings found (admissible N ≤ 6) | P_found (closed under the point group) | targets in P_found |
|---|---|---|---|---|
| L3 `group6:u3:2+zeta6:w4` | 6, 42, 72, 24 | 2: all 2,304 pinned; 3: inadmissible; 4: 3; 5: **none** (UNSAT, 2.9 s); 6: 4 | **0** | none |
| L2 `group6:u3:2+zeta6:v4` | 6, 42, 72, 48 | 2, 3, 6: inadmissible; 4: 2 (gap-free, KPer rank 6); 5: 3 (gapped) | **0** | none |
| L6 `group6:u3:2+zeta6:rho15` | 6, 54, 144, 48 | 2, 3, 4, 6: inadmissible; 5: 4 (gapped) | **0** | none |
| KR6 | 6, 78, 144, 48 | 2, 3, 4, 6: inadmissible; 5: none (UNSAT) | vacuous (no periodic colouring, R2) | — |

**Additive colourings.** L3 has 96 additive colourings into ℤ/4 and 216 into (ℤ/2)², so the rank-6 L3 is **not** silent to the
additive screen. FS-70 1b's "silent" was said of phase 1's rank-8 lattices, which share its name. 36 of the 2,304 period-2
colourings are additive (the (ℤ/2)² family: 216 / |Aut V₄| = 36). L2 and L6 have none.

**L3's period-2 table.**
- KPer ranks over the 2,304 colourings: 6 (432), 4 (864), 2 (6), 1 (18), 0 (6).
- Targets 2 and 4 escape in 995 colourings and 2/3, 4/3 and 8/3 in 1,296. This reproduces P1g's counts: 995 escapes; 1,008
  rigid for the thirds.
- i√3 is never in KPer.

## The mechanism: the fibre-collision sandwich ([hand] + [tools])

*Statement.* Let c be W-periodic, and let Q be a component of the (a, b)-subgraph of Cay(Λ/W, U mod W). Define:
- R(Q) = the residues ρ of U mod W that are carried by an edge with both ends in Q;
- Δ_ρ = ⟨u − u′ : u, u′ ∈ U, u ≡ u′ ≡ ρ (mod W)⟩;
- D_Q = Σ_{ρ ∈ R(Q)} Δ_ρ.

Then **D_Q ⊆ V_Q**, and **V_Q / D_Q is the image of Q's cycle space** under the voltage map into W/D_Q.

*Proof.*
- Out along u and back along −u′ is a closed walk of voltage u − u′, so Δ_ρ ⊆ V_Q.
- Changing the lift of any edge changes a closed walk's voltage by an element of D_Q.
- So V_Q = D_Q + the voltages of one lift of a cycle basis. ∎

*So NΛ/V_Q has three inputs:*
1. the arithmetic of U mod W: the fibre lattices Δ_ρ, which involve no colouring;
2. which residues the component uses: R(Q), the colouring's only input to D_Q;
3. a cycle correction.

A target escapes exactly when e = δ − p(δ̄) ∉ D_Q + (cycle part). Membership, not the index, decides.

*Measured on L3* (every component of every colouring found; `mechanism L3 N` rows):
- **N = 2** (2,304 colourings):
  - The cycle correction V_Q/D_Q is 0, ℤ/2 or (ℤ/2)².
  - The **rank-deficient components are exactly the single-residue ones**: V_Q = Δ_ρ, rank 4, 11,880 components. The residues
    are those of the three 10-vector fibres; U mod 2 has three fibres of 10 and six of 2.
  - V_Q = D_Q exactly when a component uses 7 residues.
  - **So the odd part of [2Λ : V_Q] is the odd part of [2Λ : D_Q].** P1g's 81 = 3⁴ is colouring-free arithmetic of L3's unit
    vectors mod 2.
- **N = 4 and 6:** U mod N has 24 and 27 residues, mostly singletons, so D_Q is often of rank 2–5 below V_Q's rank 6. There the
  voltage groups are carried by cycles, and the cycle correction has 2- and 3-torsion at N = 6.

*Reading (not claimed):* at the smallest admissible period, voltage groups are collision lattices, an arithmetic mechanism. Above
it, they are combinatorial. *Killing test:* a lattice whose period-2 components have cycle corrections with odd torsion.

## What the rank-6 data says about four colours

**It bears on C3 at four colours only as a typed null.**
- None of the four rank-6 lattices held is an informative instance:
  - L2, L3 and L6 have P = F = 0, so C3 holds there trivially;
  - KR6 has no periodic colouring at N ≤ 6, which is R2's vacuous case at the periods searched.
- This is a null about **this population**, not about the question.
- Two findings carry over to the question:
  1. Chirality of periodic phases is abundant even where C3 cannot fail, so it cannot by itself mark a candidate.
  2. **KR6 is the one rank-6 lattice with a known nonzero F (8Λ_dG, rank 4).** It is where a four-colour instance could live, if
     it is four-colourable and has periodic colourings at all.
- **The next measurement at KR6** is period groups W with 8Λ_dG ⊆ W and W ∩ U = ∅, since every colouring is 8Λ_dG-periodic.
  The quotient is 4,096 × (index in the ρ₁₅ directions) classes. Not run.

## Theorems this phase proved

| statement (one line) | grade | where |
|---|---|---|
| The fixed-prime gap lemma reaches no lattice spanning ℚ(√3,√5,i): that field has no conjugation-fixed prime whose target four-colours | hand | Registration, item 1 |
| A gapped periodic colouring has KPer(c) = 0, and its looseness is periodic: recolouring g + W′ separates every δ ≠ 0 | hand | Registration, item 2 |
| A periodic colouring with Λ/Per(c) of exponent 2 is achiral (−x ≡ x); c is additive ⟺ [Λ : Per(c)] = 4 | hand | Registration, items 4 and 5 |
| **L3 is loose at four colours: F = P = 0**, by one gap-free 2L3-periodic colouring with KPer = 0 | tools, exact (KPer computation, not independently verified) | `rows.jsonl` `L3\|N2\|certificate` |
| L2 and L6: F = P = 0 (gapped at N = 5; KPer = 0 read on 7 of 7 gapped colourings) | tools + FS70-T6 | `L2\|N5\|pair`, `L6\|N5\|pair` |
| L3 has 96 ℤ/4 and 216 (ℤ/2)² additive colourings; L2 and L6 have none | tools, exact | `additive_family` |
| L3 has no 5L3-periodic four-colouring | tools (kissat UNSAT, CNF sha `00accf5be517…`) | `L3\|seeded:N5:plain` |
| **The fibre-collision sandwich**: D_Q ⊆ V_Q, and V_Q/D_Q is the image of Q's cycle space | hand | the mechanism section |
| On L3 at N = 2: rank-deficient ⟺ single-residue (V = Δ_ρ, rank 4); cycle correction ⊆ (ℤ/2)²; odd part of [2Λ : V] = odd part of [2Λ : D] | tools, exact, all 2,304 colourings | `L3\|N2\|mechanism` |
| KR6 has rank 6 and 78 unit vectors; 1/4, 1/3 ∈ KR6; Λ_dG ⊆ KR6 with KR6/Λ_dG ≅ ℤ² × (ℤ/4)² | tools, exact | `lattice-KR6.json` |
| KR6: F ⊇ 8Λ_dG (forcing is monotone upward; U_dG ⊆ U_KR6), so KR6 has no gapped colouring | derived, from the certified v | this record |
| KR6 has no 5KR6-periodic colouring: its restriction to Λ_dG would be 5Λ_dG-periodic, which K refuses (P1d, N = 5); UNSAT here too | derived + tools | `KR6\|seeded:N5:plain` |
| Heule-510's given embedding is not in KR6: 30 distinct edge vectors outside U | tools, exact | this record |
| chirality() equals its brute-force definition on all 2,343 proper colourings of G(ℤ/10, {1,3}) (960 chiral); C-5 is achiral up to translation | tools, exact | `selftest` |

## Predictions scored

| id | outcome |
|---|---|
| P-F1 (L3's P_found is 0) | **won**, by one colouring at N = 2 |
| P-F2 (a chiral non-additive colouring on L2, L3 or L6) | **won**: 13 of the 16 colourings found at N ≥ 4 |
| P-F3 (KR6 gapped at some N ≤ 6) | **void, a registration defect.** F ⊇ 8Λ_dG by monotonicity, so "gapped" was unreachable when I registered it. Found after registration, before any KR6 run |
| P-F4 (no chainable target in P_found) | **won**: P_found = 0 on L2, L3 and L6 |

## Controls and plants

`python3 tools/fs73_rank6.py selftest --plants`: every check passes, and both plants fire.
- `chir_noneg` turns the ℤ/10 positive control achiral.
- `add_index` moves L3's additive count from 36 to 2,304.
- Also: P1g's 2,304 is reproduced; the first 200 period-2 colourings read achiral; [Fischer1994]'s ℤ/4 colouring reads additive and
  achiral.

In-run controls:
- the period-2 escape counts reproduce P1g;
- every gapped colouring reads KPer = 0;
- KR6 at N = 5 is UNSAT, as the restriction theorem predicts.

## Proposed plan edits (for the PO; the plan has one writer)

1. **T10.2's wording:** "δ escapes through Q ⟺ e ∉ V_Q, and V_Q = D_Q + (cycle voltages), with D_Q the fibre-collision lattice of
   the residues Q uses".
2. **§0:** "a lattice is loose (P = 0) exactly when finitely many periodic colourings have ⋂ KPer = 0. A gap is one way (an
   isolated Kempe component). L3 is loose by the other way: collision lattices in independent directions".
3. **§S.2 P4's lattice list:** "de Grey's lattice with one ρ₁₅ word" is KR6. It is not loose, and at N ≤ 6 it is vacuous.

## Budget spent (desktop)

| item | cost |
|---|---|
| L3 pairs | 3 min 38 s wall |
| L2, L6 and KR6 pairs | about 1 min |
| certificate, mechanism and summary | about 4 min |
| selftests | about 1 min |
| total | under 0.2 core-hours |

Every run over 2 minutes went under the shared lock. The token budget (250k) is spent, and this is the hand-back.

## Regenerate / resume

```
python3 tools/fs73_rank6.py selftest --plants
python3 tools/fs73_rank6.py all --only L3,L2,L6,KR6     # resumes: a (lattice, N) pair already in rows.jsonl is never recomputed
python3 tools/fs73_rank6.py certificate L3 2; python3 tools/fs73_rank6.py mechanism L3 2   # (and 4, 6)
python3 tools/fs73_rank6.py summary
```

A kill redoes at most one lattice-period pair. Solver asks inside a pair are cached individually.

## What is left

1. **KR6's four-colourability.** Search period groups W ⊇ 8Λ_dG with W ∩ U = ∅. Or reduce it to the ℤ² subshift over de Grey's
   4,096-class colourings, which KR6/Λ_dG ≅ ℤ² × (ℤ/4)² makes available.
2. **An independent check of L3's KPer = 0 colouring.** Construct, for each basis vector δ, the periodic separator by R3 and verify
   it with the census checker's primitives.
