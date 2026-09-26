# FS-103 — the collapse: at a field with no non-thick stable place, is `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`, given MR? (stub; the next milestone)

*Minted 2026-09-26 by job R3 (brief `data/rerank-2026-09-26/briefs/R3-apply-rerank.md`) from R1's N1 (`plans/RERANK-2026-09-26.md` §1.1, §2.2,
§3.1) and the advisor's record (`plans/POROS-2026-09-26-rerank.md` stages 1–3). Rank 1 in `plans/FRONTIER-STUBS.md`. **Solver column: none** —
derivation, PARI and reading; no finite-witness search at any stage. Written for a session with zero conversation memory.*

## Kooshi's words (2026-09-26, verbatim)

- On the re-rank that minted this stub: *"I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll focus on
  that as the milestone."*
- The target (`CLAUDE.md` § The mission): *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be
  fascinating) and potentially answer the HN problem definitively."*
- What this milestone may produce: *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a
  writeup."*

## The question — a candidate composition, not a result

**F1, as R1 stated it** (§1.1, *"Candidate composition, not a result: [hand], conditional on MR (row 120) and T-J39-3; two minds blind to each
other"*): given MR and T-J39-3, at a real field `F` with no non-thick stable place,

> **χ(ℝ²) = χ_CP(ℝ²) = χ(F²),**

so six at any field is rung D (`χ(ℝ²) ≥ 6`), and S (no subfield of ℝ has `χ(F²) = 6`, `CLAUDE.md` G64) implies `χ(ℝ²) ≠ 6`. **Nothing here is
held.** R1 and the advisor reached it blind to each other and each attacked it against the record; no derivation of its own exists. It is
this milestone's question until two blind verifiers say otherwise.

**The chain, each link at its source's grade** (R1 §1.1; the advisor's stage 2):
1. **T-J39-3** (`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2, quoted in `plans/FS100-X21D-derivation.md`): *"Let `N_k(F)` be the finite
   set of stable places of `F` that are not `k`-thick, and `Y_{F,k} = UD(ℝ²) × ∏_{v ∈ N_k(F)} G_v`. … **So, given MR(F): `F²` is `k`-colourable
   iff `Y_{F,k}` has a CP `k`-colouring.**" (every `k`, every totally real `F`)*. Grade: [hand], J39 with J48's blind check (BC-3, BC-4; J48's
   correction to step 5, the theorem unchanged). Exercised only at ℚ(√167), `k = 5`, where `N_5 = {23, 43}` (row 125's B-1, [hand, two blind
   (X21D; X21V)]).
2. **`k`-thick** (`plans/M3-derivation.md`, M3-J21-TH): *"A place is **5-thick** if its local graph contains a compact open subgroup `K` and a
   probability `ν` on `T_v ∩ K` with `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/4`"* — `k`-thick at `λ* < 1/(k−1)`, so 6-thick below `1/5`.
3. **MR** (`LEDGER.md` row 120): *"[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021 Thm 1.2 by statement (external, in
   print; its proof in EL2021 §§2–9, unread here); EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading (X01V, after its
   blind GAP, withdrawn as its own error); MR a composition, three minds]"*, for every real number field with `R_F = O′`. Its hardening is FS-105.
4. **`χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`** (row 125; X21V B-2 (i) re-derived with no input) — [hand, two blind].
5. **De Grey's field** `F_dG = ℚ(√3,√5,√7,√11)` (`CLAUDE.md` G43): the wall is broken and **no prime below 131 is usable** (the sieve,
   `tools/fplane.py`); by Weil `λ* ≤ 2√q/(q+1) ≤ 2√131/132 = 0.1734 < 1/5`, and new tower levels are bounded by `2/(q+1)` (X26B-L1, row 123).
   So `N₅(F_dG) = N₆(F_dG) = ∅` and `Y = UD(ℝ²)`; real places merge (row 125, X21V Lemma M — two there, sixteen here).
6. Hence, given MR, `χ(F_dG²) ≤ k ⟺ χ_CP(ℝ²) ≤ k` for `k = 5, 6`; with `χ(F²) ≤ χ(ℝ²) ≤ χ_CP(ℝ²) ≤ 7` (row 125; FS100-BC §2.10), F1.

**`χ_CP(ℝ²)`** (FS100-BC's definition, verbatim): *"a random map `c : G → [k]` (a family of random variables on one probability space) whose
law is invariant under every translation of `G`, with `P(c(x) ≠ c(y)) → 0` as `y → x`, and `P(c(x) = c(x + w)) = 0` for every `x ∈ G` and
`w ∈ T`. No joint measurability is part of the definition. `χ_CP(ℝ²)`: the least `k` for which `UD(ℝ²)` carries one."* Its relation to
Falconer's measurable chromatic number `χ_m(ℝ²)` (`[Falconer1981]`, **not held**, second-hand: `5 ≤ χ_m ≤ 7`) and to row 110's Borel format
`χ_B` is open. **`χ_CP ≤ χ_m`; F1 claims `χ = χ_CP`, never `χ = χ_m`** (the advisor's caution, agreed by R1).

**Where it could break** (R1 and the advisor agree): the thick-deletion step of T-J39-3's proof (J21-MX in random form, J48-MXcp) run over
infinitely many thick places at once at `k = 6`, which no instance has exercised; the stable-place list of `F_dG`; MR's own grade (FS-105).
X21V §2.9 calls `χ_CP(ℝ²) ≥ 6` "weaker than rung D" — true without MR, and the reason nobody had stated F1 (R1's and the advisor's greps: nothing).

## What the milestone must do

1. **Two blind verifiers**, each re-deriving F1 from the statements above, never from R1's or the advisor's text:
   - **the checkable instance first — ℚ(√635087)** (the advisor's computation, re-checked by R1 with exact Legendre symbols): `635087` prime,
     `≡ 7 (mod 8)`, so the wall is broken and `R = O′`; every prime `p ≡ 3 (mod 4)` below 103 inert, so its usable places are 103, 107, 127,
     163, 191, … and the ramified 635087; `2√103/104 = 0.1952 < 1/5`, so `N₅ = N₆ = ∅` with MR used only at degree 2, where MR and T-J39-3 have
     been exercised (the next four such `d`: 823415, 1017623, 1598231, 1971119);
   - **then de Grey's field**, the statement to publish, with the three extra steps the advisor names: **MR at degree 16** (admissibility of
     PE-2's pieces), **merging sixteen real places** (Lemma M, sixteen-fold), and **its stable-place list** (PARI, exactly; the exact spectrum at
     131 as a control beside Weil; the ramified places included).
   - One verifier re-walks the thick deletion at `k = 6` over infinitely many places; the other writes S's exact form given MR (R1 §1.1; the
     advisor's formulation: `χ_CP(ℝ²) ≠ 6`, and if `χ_CP(ℝ²) = 7` a finite family of CP product statements at the non-6-thick places — FS-62).
2. **The prior-art gate** (WORKFLOW 3.2), in the words of the disciplines where `χ_CP(ℝ²)` lives — *measurable chromatic number of the plane*,
   *Borel chromatic number*, *stationary / translation-invariant random colourings*, *factor of IID colourings*, *continuity in probability*,
   *harmonic analysis of distance-avoiding sets* (Oliveira–Vallentin; Bachoc–Nebe–Oliveira–Vallentin; `[AmbrusEtAl2023]`), Kechris–Marks's
   survey (`[KechrisMarks2020]`), Soifer's measurability chapter and Shelah–Soifer — and the question itself: *is it known that the chromatic
   number of the plane equals the least `k` admitting a translation-invariant random `k`-colouring continuous in probability?* `[Falconer1981]`
   is owed first (not held; a fetch). Aperiodic order is **not** this question's home (with `N_k = ∅` there is no `p`-adic factor; FS-63).
3. **Where `χ_CP(ℝ²)` sits** against `χ_m(ℝ²)` and `χ_B(ℝ²)` (row 110): Doob's measurable modification gives a measurable colouring proper for
   almost every pair — can it be made proper everywhere, and does a measurable colouring give a stationary one continuous in probability?
   If CP colourings admit measurable versions proper everywhere, F1 reads `χ(ℝ²) = χ_m(ℝ²) = χ_B(ℝ²)` given MR — **not claimed**.
4. **A kernel form over named hypotheses**, as an FS-101 slot, only once the verifiers agree.

## What it does to the target, if it holds (R1 §1.1; nothing here is held)

- **Six at a field is exactly rung D**: `χ(F²) ≥ 6` for some `F` ⟺ `χ(ℝ²) ≥ 6` ⟺ `χ_CP(ℝ²) ≥ 6`. No field is cheaper than the plane;
  ℚ(√167) is dearer (it adds `PL_∃(23, 43)`, row 125).
- **S is HN-hard too**: S ⟹ `χ(ℝ²) ≠ 6` (else `F_dG` is exactly six).
- **The problem is archimedean**: what decides six is stationary colourings of `ℝ²` (FS-104) or product locality at the few non-thick places
  (FS-67, FS-59). If `χ_CP(ℝ²)` can be tied to `χ_m(ℝ²)`, this is the wall Kooshi named: HN collapsed to Falconer's 1981 problem, a write-up
  (FS-102's headline, or its own paper).

## Registered expectations (both outcomes reachable; carried from R1 §3 and the advisor)

- F1 survives two blind verifiers at [hand] conditional on MR: R1 0.70, the advisor 0.80 (its stage 2); a named gap at the thick deletion at
  `k = 6` or in T-J39-3's scope: R1 0.20, the advisor 0.12; F1 or `χ = χ_m` for the plane found in print: R1 0.05, the advisor 0.08.
- A proved inequality between `χ_CP(ℝ²)` and `χ_m(ℝ²)` in one direction beyond `χ_CP ≤ χ_m`: 0.50 (R1); equality `χ_CP = χ_m`: 0.15 (R1).
- *Killing tests:* a step of T-J39-3's proof that fails with `N_k(F) = ∅` over infinitely many thick places at `k = 6`; a stable place of
  `F_dG` with `λ* ≥ 1/5`; the claim in print.

## Provisional bearings (replaced by the re-grokking at the opening)

G64 (S and W kept apart; given F1, S contains `χ(ℝ²) ≠ 6`), G48 (the conjecture; F1 is its local–global statement at a field with no small
place), G43 and G35 (the sieve and the wall at `F_dG`), G54 and G76 (thickness is mixing, `λ* < 1/(k−1)`; the mixing selection), G80 (MR),
G60 and G24 (density caps and integrality: a CP five-colouring needs `m_j(ℝ²) ≥ j/5`, and Croft's `m₁` kills `j = 1` only), G56 and G59 (the
window: what the non-6-thick places are), G49 and G50 (the gate; Falconer unread), G21 (a candidate liked by two minds is audited at the
rate of one disliked), G51 (two blind verifiers), G72 (the structural form is F1 itself), G79. Stubs: FS-104, FS-105, FS-62, FS-59, FS-67,
FS-102, FS-101, FS-39 (F1 attains `χ(ℝ²)` at a named field, given MR).

## Bearing on χ ≥ 6

Derived, if it holds: it decides what "six" means for every other row — six at a field becomes rung D, and S becomes HN-hard. It does not
advance six itself. Cost: one to two days (R1).

*Would have searched here:* nothing — no step needs a finite-witness search.
