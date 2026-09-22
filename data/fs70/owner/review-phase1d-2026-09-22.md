# FS-70 — the owner's review of phase 1d (the theory and the controls), 2026-09-22

*Scored by artifact against `data/fs70/records/phase-1d.md` and `phase-1d-predictions.md` (commits `5fb393cf` … `7ed61d78`).
Implementer: Opus 5, ≈530k tokens. Every check below is my own code or hand, none shared with `tools/fs70_*`.*

## 1. Verdict: ACCEPTED — and it changes the milestone's question

| what | how I checked | result |
|---|---|---|
| **The fan-gap closure on Λ′** (record §5.2): a proper four-colouring of `Cay(Λ′/5Λ′, U mod 5)` with a gapped vertex ⟹ `Forces G 4 u v ↔ u = v` for every unit-distance graph on Λ′, and every such graph four-colourable | `po_verify_quotient.py` (mine): my 46 unit vectors of `ℚ(√3,√−5)` at denominator 24, my Hermite basis, my reduction mod 5, my Cayley graph; the committed colouring read from the file | **connection set equal as sets (46); 0 vertices with a monochromatic edge; 597 of 625 gapped, the origin missing colour 3; pulled back to a 43,769-point Minkowski ball of radius 2 that I built, with 471,561 unit-distance edges derived by me: 0 monochromatic.** The plant (recolour a vertex by a neighbour's colour) reads 29 bad vertices and fails |
| **The same on L6** (`group6:u3:2+zeta6:rho15`, the lattice phase 1b spent its budget on) | `po_verify_quotient_L6.py` (mine): my 42 generators, my rank-6 HNF, my 54 unit vectors at denominator 144 (the complete enumeration); the tool's basis used only as the coordinate datum, and every one of my unit vectors checked to lie in it | **connection set equal (54); 0 monochromatic; 1,250 of 15,625 gapped; pulled back to phase 1b's committed 11,593-point word ball with my own 63,444 edges (= the file's): 0 monochromatic** |
| **The theorem chain** | `Proofs/HadwigerNelson/FanGap.lean` read: `FanGap C v γ := γ ≠ C v ∧ ∀ w, P.Adj v w → C w ≠ γ` (the closed neighbourhood); `slack_addCayley_of_fanGap` from one gap by translation; `Slack.forces_iff_of_hom` for any `G →g P`, no surjectivity | as claimed. The homomorphism hypothesis — reduction `Λ → Λ/NΛ` is a graph homomorphism of the *whole* unit-distance graph on Λ — holds because every unit vector in `Λ′(24)` has denominator dividing 24 and is among the 46, and every unit vector in L6 has denominator dividing 144 and is among the 54 (both enumerations complete by the box); the "generators only" caveat bites only on the rank-8 rich lattices, as the record says |
| **The falsification control, asked the hard way** (record §5.3 read six gap-free colourings on de Grey's K-lattice and called the control passed; that is one-sided — a gap-free colouring proves nothing) | `po_gap_finder_K.py` (mine): a finder with the clause *colour 3 is absent from the closed neighbourhood of the origin* on my K-lattice (radicand 11, 54 unit vectors), N = 2 … 12 | **UNSAT at every admissible N ≤ 12** — no gapped quotient colouring exists there, as Harder's forced pair requires; the finder's plant (L1 at N = 5, where phase 1d reports 50 gapped vertices) returns **SAT** |
| The split-prime tower (§3): tight at every level, `d₀ = 3`, the kill of `2` and `2/3` by an exhibited additive colouring | the ring's five validation checks read; the kill's logic re-derived (an additive four-colouring of `P₃` separating the image of `δ` pulls back along the reduction to every 2-unit fabric); **the valuation correction accepted: `v_𝔭(4/3) = 4`, mine said 2 — owner error 9**; consistency with my own rich-lattice screen: its 32 of 48 additive colourings with `φ(1) ∈ {1, 3}` separate `(0, 2)`, and `φ(2/3) = 2φ(1) = φ(2)` on any lattice holding `1/3`, so `2` and `2/3` die together, as the table says | consistent; the tower's positive half (forcing at depth ≥ 3 from level 4, 756 minimisers stabilising) rests on the implementer's character computation and one SAT refusal with its negative control — not re-derived by me, and nothing the milestone decides rests on it |
| Harder's control (§4): `forces 8/3` UNSAT at 23,083 points on the plan's §3.3 shape; `V + V + H` at 2,341 points does not force | the record's own controls (unpinned SAT, depth-0 pair SAT); the 745-vertex correction checked against the held thread text — **owner error 10: the brief conflated Harder's smallest forcing subgraph with the Minkowski sum** | the `forces` encoding has now refused a pair known to be forced, in the field where it is known — the milestone's first positive control of that encoding |
| The Kempe reach of the rich 2-unit lattices (§6): rigid at `4/3, 8/3, 4, 4/7, 4/√3`, escapes at `2, 2/3` | the join with the tower checked by hand (`v_𝔭 ∈ {4, 6}` on the rigid five, `2` on the escaping two) | consistent, and the two instruments' agreement is the strongest thing in the record |

## 2. What phase 1d established

1. **The quotient–fan-gap screen** (row 56 + row 66, both kernel): one gapped periodic four-colouring closes `Forces` on a
   whole lattice at every distance and radius and four-colours it everywhere. **Closed by it:** Λ′(24) (mine, at N = 5 and 10),
   L6 (N = 5), L2 (N = 5), L1 (N = 5, 7), `zeta12+rho15` (N = 3). **Not closed:** the rank-6 L3 (`group6:u3:2+zeta6:w4` —
   gap-free colourings at N = 2, 4, 6, hence four-colourable everywhere but with `Forces` open), and the rank-8 lattices
   (`N⁸` unrun). de Grey's K-lattice, with a forced pair in print, has no gapped colouring at any N ≤ 12 (my finder).
2. **The split-prime tower is tight at every level and forces from 𝔭-depth 3**; `2` and `2/3` are dead on every 2-unit
   fabric over ℚ(√3,√5); the five remaining targets are forced in the local plane, and the rich 2-unit lattices are
   Kempe-rigid at exactly those five.
3. **The `forces` encoding and the plan's §3.3 shape are validated** on Harder's pair over K; the lens `T₅` there is thin
   (466 points, SAT).
4. **Nine in-field type-M members**; `n = 34` and `n = 94` are wall-breaking and were outside phase 1c's enumeration
   (denominators 68, 188).

## 3. What it means, and the frame for phase 1e

The chain route needs a four-colourable lattice with a **forced** pair — a rigid colouring space. de Grey's lattice over K is
rigid because Theorem B's residue colouring is essentially its only four-colouring (Polymath's "Coloring R_2", Cor. 9, proves
one step of that by hand). Over ℚ(√3,√5) every lattice the plan built, and the one I added, has a *loose* colouring space:
a non-additive periodic four-colouring with a gap. **The live fabric is exactly what the screen leaves: the rank-6 L3 and the
rich 2-unit lattices**, and the question on them is rigidity, not colourability. The phase-1d record's §8 item 3 — what
separates the gap-free lattices (de Grey's, rank-6 L3) from the gapped ones — is the mechanism question for the close.

Owner's addition for 1e: **the Kempe screen generalises from additive to periodic colourings.** For a period-`N` colouring
`c` and a target `δ` with `c(δ) = c(0)`, the `(c(0), b)`-Kempe component of the origin in the infinite lattice graph is the
lift of a component of the quotient's two-colour subgraph, and the lattice points it reaches are computable exactly from the
quotient (the voltages of closed walks generate a sublattice; `δ` is reached iff its class lies in the component and its
voltage lies in the right coset). If the component misses `δ`, the swap is a proper colouring separating `(0, δ)` on every
finite graph, and `Forces` at `δ` is dead on the lattice — with de Grey's N = 2 colouring at `8/3` as the control that must
read rigid. On the rank-6 L3 this is the instrument that decides which of `2, 4/3, 8/3, 4` are worth a solver.

## 4. Owner errors this milestone (running list)

1–8 as before. **9.** `v_𝔭(4/3) = 2` in the brief; it is 4 (the implementer). **10.** "Harder reports 745 vertices" read as the
size of `V + V + H`; it is his smallest forcing subgraph (the implementer, from our own held thread text). **11.** The
phase-1d brief's item 7 predicted the Λ′ control would colour "at medium confidence"; it colours by theorem, and the
quotient screen that proves it was item 3 of the same brief — the two items were not joined until the implementer joined them.

## 5. Files

`po_verify_quotient.py` (Λ′: the quotient, the gap, the pullback to a ball I build; ~2.5 min at R = 2), `po_verify_quotient_L6.py`
(L6: the same on the committed word ball; the 54 unit vectors cached in `L6-units-mine.json`; ~6 min on first run),
`po_gap_finder_K.py` (the gap-aimed finder, with its plant), this note. The leftover Λ′ quotient sweep (N ≤ 30) was stopped by
process group at N = 18 after the record's rows were in; it forfeits nothing the record rests on (its N = 15, 16 colourings are
committed beside the others).
