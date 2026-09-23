# FS-73 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-23 at the close (WORKFLOW 2.0 step 9) by the close planner (de Bruijn, Opus 5.5), from every phase record's
"Theorems this phase proved" heading and, for Coxeter's competition file (which has no such heading), from its §3, §4 and §6.
Grades are `CLAUDE.md` § Notation's. A proof is not repeated here when a record holds it; this file is the index that survives
the ledger rows' compression (rows 78 and 79). `LEDGER.md` § B indexes every entry, one line each
(`tools/fs71_ledger_b_check.py --strict`).*

**Who found what** (credited per entry): implementer **A** (P1a–P1d′: the lattice layer, the screens, the K census), **A2** (the
`(0, v)` certificate, the `Λ/8Λ` classification, `N = 32`, Poros's card P1g), **B** (P2, the classification table), **C** (P2b,
ℚ(√167)'s screen), **D** (P1e/P1f, the rich lattices and the census checker), **E** (P3b, ℚ(√167)'s last lattice), **F** (P4, rank
6), **K** (P5, the kernel), **V** (the independent verifier of P1d and of P2 at ℚ(√11)), **V2** (the independent verifier of P3b),
**Poros** (the advisor at the plan, the certification and the competition), the competitors **de Bruijn** and **Coxeter** (P3), the
**planner** and the **modeling planner** (the plan's §0, §K, §M), and the **owner** (the product owner's checks).

**The kernel layer is not indexed here** (§ B holds only what the kernel has not checked): `Proofs/HadwigerNelson/Kempe.lean`, zero
`sorry`, standard three axioms, proved by K (`data/fs73/records/phase-P5.md`) — `kempeSwap` and its apply lemmas,
`not_forces_of_kempeClosed`, `exists_coloring_ne_of_forall_finset` (de Bruijn–Erdős by `Finset.rado_selection`),
**`forces_iff_exists_finite`** (R1: a pair is forced iff some finite induced subgraph forces it), the `VoltageEscape` certificate
with `not_forces_of_voltageEscape` (FS70-T10.1), `forces_iff_of_quotient_fanGap` (FS70-T6), `not_forces_of_additiveKempe`
(FS70-T2), `forcedSubgroup` / `periodicForcedSubgroup` with their membership bridges, `exists_finiteIndex_between_notMem`
(residual finiteness of finitely generated abelian groups, through characters), **`notMem_periodicForcedSubgroup_of_voltageEscape`**
(R3's escape direction), `InheritanceQuestion` (a `Prop`, stated, not claimed) and `inheritanceQuestion_iff`, and the named
inhabitant `voltageEscapeZ`. Row 78 carries them.

## §1. Four colours at K: de Grey's lattice (phase P1, verification V)

**T1 — The Kempe period group, computed. [hand; A]** For a colouring `c` periodic under `W = Per(c)`, `KPer(c)` is the intersection,
over every component `Q` of every two-colour subgraph of `Cay(Λ/W, U mod W)` (all six colour pairs), of `Q`'s voltage group `V_Q`.
*Proof:* `KPer ⊆ Per = W`, and `t ∈ W` fixes the lift of `Q` iff `t ∈ V_Q` (FS70-T10 with `W` for `NΛ`); `data/fs73/records/phase-P1.md`
"Theorems this phase proved", sketch in `tools/fs73_screen.py`'s docstring. *Proof verdict:* closes; checked on FS-70's six committed
colourings and by four plants. *Rests on it:* every `P_found` in the census (P1d, P1e, P4). *Prior art:* ours — FS70-T10's voltage
lattice read at every component. *Kernel:* declined — needs Kempe components as a kernel notion (plan §K's reason); the certificate
form `VoltageEscape` covers every use.

**T2 — The re-periodised period `W′`. [hand; A]** For an escape `e = δ − p(δ̄) ∉ V`, the least-index `W′` with `V ⊆ W′ ⊆ W` and
`e ∉ W′` restricts one Smith coordinate of `W/V`: torsion, with the least divisor of `d_j` not dividing `e`'s coordinate, or free,
with the least `ℓ ≥ 2` not dividing it. *Proof:* phase-P1.md, Theorems; asserted by `w_prime` in `tools/fs73_screen.py`
(`V ⊆ W′ ∌ e`). *Proof verdict:* closes. *Rests on it:* every separator's reported period (P1b, P1g). *Prior art:* ours — Smith normal
form arithmetic. *Kernel:* declined (the kernel's R3 takes any finite-index `W′`, `exists_finiteIndex_between_notMem`).

**T3 — P-D3 is refuted: forced differences compose. [hand; A]** If `G` forces `(0, a)`, then `G ∪ (G + a)` forces `(0, 2a)`. With
Harder's `a = 8/3`, the pair `(0, 16/3)` is forced at 2-adic depth 4 at both primes of `E = ℚ(√−3,√−11)` above 2; `16 = 6·(8/3)` and
`48 = 18·(8/3)` follow by longer chains. *Proof:* phase-P1.md § "P-D3 checked against the depths" (the depth table from Theorem B's
2-adic model; the union ask ran to its cap, so the refutation rests on the derivation and the one refusal `force:96,-48,-48,-24:R1.5`).
*Proof verdict:* closes. *Rests on it:* P-D3 (row 67, FS38-derivation) refuted as stated; any depth claim must be about *primitive*
forced vectors. *Prior art:* ours — the group property of forced differences is folklore. *Kernel:* declined (`Forces` composes by
translation; one line over row 42's API if ever needed).

**T4 — Every vector of `8Λ` has 2-adic depth ≥ 3 at both primes above 2; the torsion of `(8/9)ℤ[ζ₆]/(8/3)ℤ[ζ₆]` has two orbits. [derived + hand; A]** `Λ` is 2-integral, so `8Λ` has depth ≥ 3; `(8/9)ℤ[ζ₆]/(8/3)ℤ[ζ₆] ≅ ℤ[ζ₆]/3`, whose unit group of order 6 is
`⟨ζ₆⟩`, so the nonzero classes are `8/9` and `(8/9)√−3` up to rotation. *Proof:* phase-P1.md, Theorems and the P-D3 section.
*Proof verdict:* closes. *Rests on it:* P-C2 won (every H1-found target at K has depth ≥ 3). *Prior art:* ours — elementary.
*Kernel:* declined.

**T5 — `Λ = (1/9)·O_E`, and `8/9 = −(v + v̄)`. [tools exact + hand; A2, Poros's observations]** The four vectors `1/9, ζ₆/9, w/9,
ζ₆w/9` (`w = (1+√−11)/2`) have integer Λ-coordinates of determinant −1, so `Λ = ℤ⟨1, ζ₆, w, ζ₆w⟩/9`, which is `O_E` because the
discriminants −3 and −11 are coprime; and with `v = −(4/9)(1+√−11) = −(8/9)w`, `v + v̄ = −8/9`. So a graph `H` forcing `(0, v)` yields
`H ∪ (conj(H) + v)` forcing `(0, 8/9)`. *Proof:* phase-P1.md, A2's entries; `tools/fs73_certify.py` (`OE_IN_LAMBDA`); re-derived by the
owner. *Proof verdict:* closes. *Rests on it:* T6; the reading of `F` as an ideal (the algebraic-explanation stub). *Prior art:* ours
(Poros). *Kernel:* declined.

**T6 — The pair `(0, v)` is forced at four colours on de Grey's lattice, and `v`'s orbit spans `8Λ`. [cert + tools exact; A2, V]**
A 2,044-point unit-distance graph plus the edge `{0, v}` is not 4-colourable (trimmed LRAT, 383,771 additions, 56.5 MB gzipped,
`data/fs73/census/cert/t-16_8_8_0-R1.5/`, checked by the frozen standard-library `tools/fs73_cert_check.py`); the orbit of `v` under
the order-24 point group `⟨ζ₆·⟩ ⋊ Gal(E/ℚ)` has 12 elements whose Hermite form is `8·I₄`. *Proof:* phase-P1.md, A2's Task 1;
`verify-P1d.md` checks 3–4 (Glucose DRUP proofs accepted by drat-trim on the 39,829-point ball for `8/9`, `v` and the control `8/3`;
Lingeling break-free on `v`; own encoding, own saturation, live negative controls). The owner ran the checker (CERTIFIED, 16 s) and a
planted moved vertex was refused. *Proof verdict:* closes. *Rests on it:* T7. *Prior art:* the forced pair at `8/3` is Harder's
(Polymath16, 2018); **`8/9` is Parts's** — a four-colour mono-pair at `(0,0)–(8/9,0)` in his graph 4H4, and two of them joined by an
edge as a five-chromatic graph in ℚ(√3,√7,√11) (`[Polymath16threads]`, seventeenth thread, February 2021), found at the close in the
archived threads; his twelfth-thread graph (April 2019), `V₄₃ ⊕ V₄₃ ⊕ V₄₃`, forces every vertex at radius `8/√27 = |v|` to the origin's colour —
**checked at the close: `v`'s orbit is not among them**; the six there are `(8/9)√−3·ζ₆^m` (`η³ − η̄³` exactly), in `8Λ` but reached
through `η^{±3} ∉ Λ` (`data/fs73/prior-art/parts_v.py`, floats proposing, sympy confirming). The pair `(0, v)` on the lattice, its certificate and the orbit argument are ours. *Kernel:* **declined** (Kooshi, 2026-09-23: "an attempt at an algebraic explanation in a separate milestone rather than
formalizing a big graph"); the certificate and its checker stand, in `forces_of_not_colorable_append_single`'s form if ever wanted.

**T7 — `F = P = 8Λ` on de Grey's lattice at four colours; every four-colouring is `8Λ`-periodic. [cert + tools + derived; A2, V, D]**
`F ⊇ 8Λ` by T6 and transport (forced differences form a group stable under the graph's automorphisms fixing 0); `P ⊆ 8Λ` because the
point group has three orbits on the 15 nonzero classes of `Λ/2Λ`, and for a representative `λ` of each an exhibited `8Λ`-periodic
proper colouring separates `0` and `4λ`; `F ⊆ P`. So `F = P = 8Λ`, C3-inherit holds at K, and the four-colourings of the lattice
graph are exactly those of `Cay(Λ/8Λ, U mod 8)`: 380 under the pins (9,120 in all), in **12 classes** under translations, the point
group and colour permutations. *Proof:* phase-P1.md (A2's headline, Task 3); `verify-P1d.md` check 5 (`tools/fs73v_quotient.py`);
`data/fs73/census/K-8Lambda-classes.json`; D's `tools/fs73_census_check.py` re-derives `F_known` from the certificate's witness.
*Proof verdict:* closes. *Rests on it:* row 78; the P1d′ pattern (colourings at `N = 2^a·m` are `2^min(a,3)`-periodic; `N = 15, 21`
have none) becomes a theorem; `P_32 = 8Λ` (four UNSAT confirmations, P-C6) becomes a consistency check that could have failed and
did not; Harder's `8/3` and `8/9` are elements of `F`. *Prior art:* the rigidity step over K at `8/3` is `[Polymath16wikiR2]` (2018);
**the headline count is Hubai's** (`[Hubai2018]`, 9 May 2018, computer search, no certificate; FS-73's census reached the same 380 and
9,120 without reading his comment, an independent confirmation): the Moser ring as his computation uses it —
closed under rotation by `η = ω₃^{1/2}`, which `Λ` is not — has exactly 9,120 four-colourings, 380 with a triangle fixed, all
8-periodic, with a stripe-and-chirality structure; on the ring 8-periodicity follows from Harder's `8/3` by transport. The lattice form
is ours: on `Λ` the `8/3` pair transports only to rank 2 (P-C4), so the lattice needed `v`; and the lattice statement implies the ring's 8-periodicity (each coset of `Λ` in
`R₂` carries a four-colouring of `Λ`'s graph), so it is the stronger; the equal counts suggest, and do not prove, that the lattice has no
colouring beyond the ring's restrictions. *Kernel:* declined with T6.

**T8 — G70 holds on de Grey's lattice: the √3-clean four-colourings are Theorem B's two residue colourings, one orbit. [tools exact; A2]** Of the 380 pinned colourings of `Λ/8Λ`, exactly two have no monochromatic pair at any of Λ's 66 vectors of length √3, and they
are the residue colourings at the two primes above 2 (period group `2Λ`, `Λ/Per ≅ (ℤ/2)²`). *Proof:* phase-P1.md, Task 3;
`tools/fs73_classify.py`. *Proof verdict:* closes — and by T7 it is every four-colouring of the lattice, not a sample. *Rests on it:*
G70 held (its falsifiable test at FS-73). *Prior art:* the theorem is Coxeter's (MASCOT-T6); this is its exhaustive instance.
*Kernel:* declined.

**T9 — Poros's card on L3: the index-81 escapes are local at neither 2 nor 3; a rank-deficient voltage group always admits a 2-local separator. [tools exact + hand; A2]** On L3 at `N = 2` (2,304 pinned colourings), the escapes of `2/3, 4/3, 8/3` through the
index-81 component (`2L3/V ≅ (ℤ/9)²`) have separators with `L3/Per ≅ (ℤ/2)⁴ × ℤ/18`, and no 2-power `W′` exists for them; if `V` has a
free Smith coordinate on which `e` has coordinate `y ≠ 0`, `ℓ = 2^(v₂(y)+1)` gives a `W′` of 2-power index. *Proof:* phase-P1.md, A2's
P1g section; `tools/fs73_card.py`, `data/fs73/census/P1g-L3-card.json`. *Proof verdict:* closes. *Rests on it:* P-R1 won for the
index-81 component; T24 explains the 81. *Prior art:* ours. *Kernel:* declined.

**T10 — The rich 2-unit lattices over ℚ(√3,√5), on their generator graphs: `1/p ∈ Λ` for every odd `p` in the denominator; every periodic colouring found is gap-free; the sandwiches. [tools exact + hand; D]** On `twounits:14/30/42`, `1/p ∈ Λ` for `p = 3, 5, 7, 13`
(and 17–41 on the larger two) but `1/11 ∉ Λ`, so `NΛ` is inadmissible for each such `p` — a unit vector's denominator holds no
conjugation-stable prime, so G55's prime inversion puts `1/p` in `ℤ[U]`, here already in the additive span; every exhibited colouring
at `2Λ, 4Λ, 6Λ` and `2Λ ∩ W₁₁` is gap-free (the gap-aimed finder UNSAT at each); `F_known = 0`, `P_found` of rank 8 and finite index
(`Λ/P_found ≅ (ℤ/10)² × (ℤ/20)² × (ℤ/5460)⁴` at `twounits:14`), the odd torsion carried by Kempe period groups at exactly the primes
with `1/p ∈ Λ`; `4/3, 8/3, 4, 4/7, 4/√3 ∈ P_found` and `2, 2/3, i√3 ∉ P_found`. *Proof:* phase-P1.md, D's Theorems;
`data/fs73/census/README.md`, `rich-rows.jsonl`; the frozen `tools/fs73_census_check.py` (the owner ran it, 19 s; a planted dropped
±pair was refused). *Proof verdict:* closes as measured; **rigid-found, forcing undecided** — and Poros's N1: the targets in `4Λ` lie in
`P_found` partly by construction, since every colouring found is `2Λ`- or `4Λ`-periodic. *Rests on it:* P-C3 scored (a void, b lost,
c won); the one abstract four-colour candidate the competition had. *Prior art:* ours. *Kernel:* declined.

**T11 — The soundness split for generator graphs. [hand; D]** `Cay(Λ, S) ⊆ Cay(Λ, U)` spanning, so `F(S) ⊆ F(U)` and `P(S) ⊆ P(U)`: a
forcing refusal on a generator-graph ball carries up to the saturated lattice; a colouring, a period group, a gap or an escape does not.
*Proof:* phase-P1.md, D's Theorems. *Proof verdict:* closes. *Rests on it:* T10's labelling ("generator graph") and what it may claim.
*Prior art:* ours — monotonicity of `Forces` (row 42). *Kernel:* declined (it is `Forces.mono`).

## §2. The classification table (phase P2), and ℚ(√11) at three colours

**T12 — `F = P = 3Λ` on ℚ(√11)'s `Λ₁₀` at three colours, and every three-colouring is affine. [tools, verified independently; B, V]**
`Λ₁₀` is the ℤ-span of the 36 unit vectors of ℚ(√11)² of denominator dividing 10 (rank 4). FS-58's forcers `u₁ = (−3/5, 4/5)` (52
points, orbit rank 2) and `u₂ = ((−3−2√11)/10, (−6+√11)/10)` (65 points, orbit rank 4, index 9 in `3Λ`) together give `F ⊇ 3Λ`; ten
`3Λ`-periodic colourings, one per point-group orbit of lines of `Λ/3Λ`, give `P ⊆ 3Λ`. `Λ₁₀/3Λ₁₀` has exactly 48 proper three-colourings
(8 index-3 partitions × 6 namings), one orbit under the order-16 point group. *Proof:* phase-P2.md, Theorems; `verify-P2-q11.md`
(Glucose DRUP + drat-trim, and exhaustive enumeration with no solver: 122,900 and 1,814,256 colourings, none separating).
*Proof verdict:* closes. *Rests on it:* row 79; the second proved instance of C3-inherit; T20 re-derives it with no forcer. *Prior art:* the
forcers are FS-58's; ours. *Kernel:* declined (T20's route is the kernel candidate: the three-colour criterion stub).

**T13 — `F = P = 3Λ₅₀` on the 100-vector lattice. [tools; forcers verified, `P₁₅` replicated but not independently verified; B]**
`Λ₁₀ = 5Λ₅₀`, so `F ⊇ 15Λ₅₀` by monotonicity, every colouring is `15Λ₅₀`-periodic, and the loop at `N = 15` (50,625 classes) returns
`P₁₅ = 3Λ₅₀`. *Proof:* phase-P2.md, Theorems (`imports.jsonl` `import:q11-close:P15`). *Proof verdict:* closes as measured. *Rests on it:*
row 79. *Prior art:* ours. *Kernel:* declined.

**T14 — The fixed-prime gap lemma, and its scope. [hand; B; scope F]** If a prime `𝔓` of a CM field `E` is fixed by complex conjugation
and its residue target `Cay(O_E/𝔓, circle)` has a gapped `k`-colouring, every lattice of `E` generated by unit vectors is loose at `k`:
`F = P = 0`. **Scope:** it reaches only lattices inside a CM field that has such a prime; `ℚ(√3,√5,i)` has none (its primes above 2, 3,
5 are swapped by conjugation, and a fixed odd unramified prime needs residue field 𝔽_p with `p ≡ 3 (mod 4)` and 3, 5 squares — `p = 11,
59, …`, targets at least 5-chromatic), so it reaches no lattice spanning that field. *Proof:* phase-P2.md, Theorems (every unit vector is
a `𝔓`-unit since `v(z) + v(z̄) = 0 = 2v(z)`; reduction is additive and maps closed neighbourhoods into closed neighbourhoods; FS70-T6);
phase-P4.md, Registration item 1 (the scope). *Proof verdict:* closes. *Rests on it:* every loose verdict in the table; T15; the
owner's P4 brief was wrong to cite it for rank 6. *Prior art:* Theorem A's residue map (row 52) composed with FS70-T6; ours.
*Kernel:* stub-worthy with FS70-T6's composition (the kernel already holds both halves).

**T15 — At five colours the circle targets at `q = 3, 5, 7, 11, 19` have gapped colourings, and 25 of the 28 quartic CM subfields of K(√7)(i) are loose. [tools + derived; B]** Each gapped colouring of `Cay(𝔽_{q²}, μ_{q+1})` is verified from the colouring (13 and 17 ran
to 300 s, UNKNOWN, and decide no subfield); the survivors `ℚ(√3,√−77)`, `ℚ(√7,√−33)`, `ℚ(√11,√−21)` have only ramified fixed primes up
to 23 or are inert at 23, where Γ₂₃ refuses five; the pilot `ℚ(√3,√−77)` is loose anyway, by a gapped colouring at `N = 7`. *Proof:*
phase-P2.md, Theorems; `targets.jsonl`. *Proof verdict:* closes. *Rests on it:* P-T3 (won on the verdict, lost on the mechanism: the gap
came at a ramified prime); the five-colour rigidity table's pilot. *Prior art:* ours. *Kernel:* declined.

**T16 — The table's loose rows, and T5 reproduced with one prose correction. [tools; B]** Every lattice in the table other than de
Grey's (four colours) and ℚ(√11)'s two (three colours) is loose by a gapped periodic colouring at a small period (K's other subfields
at `N ∈ {2, 3, 5}`; ℚ(√3,√5) at `{2, 3, 5}`; ℚ(√3,√23) and ℚ(√3,√47) at `{2, 3, 5, 7}`); `Λ₃₆` of `ℚ(√−3,√−11)` is de Grey's lattice;
FS70-T5's six-subfield counts reproduce exactly, and its prose is corrected: in `ℚ(√5, i)` the prime of `ℚ(√5)` above 3 **splits**
(its own count of 8 unit vectors with a 3-adic pole agrees with the split). *Proof:* phase-P2.md, Theorems; `data/fs73/table/`;
`python3 tools/fs73_table.py t5`. *Proof verdict:* closes. *Rests on it:* P-T1 won (only de Grey's lattice is rigid at four colours).
*Prior art:* ours. *Kernel:* declined.

## §3. ℚ(√167) at three colours (phase P2b)

**T17 — `L3e1c94c6` has a gapped periodic three-colouring of period 23, a residue colouring at `(23, √167 − 11)`. [cert; C]** With
`red` the reduction mod `𝔭 = (23, √167 − 11)` and `ψ(X, Y) = 14X + 9Y`, `c(x) = ⌊3ψ(red x)/23⌋` is proper: the lattice's 36 unit
vectors reduce to 12 of the circle's 24 points, all of which `ψ` sends into `[8, 15]`; every neighbour of the origin has colour 1, a fan
gap; so `F = 0` at three colours (row 66) and every ball three-colours. *Proof:* phase-P2b-q167.md, Theorems 1 (and 8, the lattice-level
residue lemma: the target is the sub-circle the lattice reaches); `tools/fs73_q167_check.py` (standard library; completeness of `U`
proved by two independent enumerations; nine planted faults refused by name); the owner checked the argument. *Proof verdict:* closes.
*Rests on it:* P-C1/P-C1b (C) won; P2's "no periodic colouring" measured its search, which stopped at `N = 20` (least circular period
23, Theorem 2). *Prior art:* Theorem A's residue map (row 52), restricted to the reached sub-circle — ours. *Kernel:* declined.

**T18 — 52 of FS-61's 57 lattices at ℚ(√167) carry certified gapped periodic three-colourings, and 3 more are 3-integral. [cert; C]**
51 by a residue target at one prime (23, 29, 43, 59, 67, 79 or the ramified 167), one by a linear form mod 24; the three 3-integral
ones by the kernel's 3-adic barrier (row 72); only `Ld14c588b` and `L21cc6506` survive every screen, with no periodic colouring at
admissible `N ≤ 30` and no circular one at `N ≤ 120`. *Proof:* phase-P2b-q167.md, Theorems 3 and 9; witnesses under
`data/fs73/q167/witnesses/`, each re-proved by the standalone checker. *Proof verdict:* closes. *Rests on it:* FS-61's null at 167 is
explained; T21, T22 then settle the two survivors' three-colourability by `Θ`. *Prior art:* ours. *Kernel:* declined.

**T19 — The residue-set classification at 23 and at 43. [tools exact, refusals replicated; C]** Of the 224 symmetry classes of
antipodal residue sets on the 24-point circle mod 23, 98 colour and 126 refuse (monotone; 0 Glucose disagreements); every colourable
set has a **gapped** colouring; the seven minimal refusing sets include a coset of `μ₆` (a hexagon: 3 is a square mod 23); the largest
colourable set has 8 pairs. At 43 (up to 6 pairs) the smallest refusing sets have 5 pairs, and every colourable set is gapped. *Proof:*
phase-P2b-q167.md, Theorems 4–5; `classify-23.jsonl`, `classify-43.jsonl`. *Proof verdict:* closes as measured. *Rests on it:* the
design rule for FS-59 (a lattice whose residues at a prime above 23 or 43 miss every refusing set is loose by theorem); the
denominator sweep (Theorem 7: 16 values of `M ≤ 420` pass both primes). *Prior art:* ours. *Kernel:* declined.

**T20 — FS-61's three-colouring of the degree-14 ball is a noisy circular colouring. [tools; C]** Its 4-D Fourier transform has one
dominant character (amplitude 0.74), and the best circular fit — the 23-form shifted by half a period on one coordinate — agrees on
86.37 % of points, with uniform defects. *Proof:* phase-P2b-q167.md, Theorem 6; `fourier.jsonl`, `agree.jsonl`. *Proof verdict:* closes
as measured. *Rests on it:* the method line of G21 (read a solver's colouring's spectrum before searching periods). *Prior art:* ours.
*Kernel:* declined.

## §4. Three colours, every abelian Cayley graph (the competition, phase P3)

*Setting of T21–T27: `Λ` a finitely generated torsion-free abelian group of rank `r`, `S = −S ⊂ Λ ∖ 0` finite and generating, `π : ℤⁿ →
Λ` one generator per ± pair, `R = ker π` (saturated). The two competitors reached the same frame independently; the advisor read both.*

**T21 — The height lift and the slope fibre. [hand; de Bruijn (L1–L2) and Coxeter (Lemmas 1–3), independently; second route to L2 Poros's]** Every proper 3-colouring `c` lifts to a height `h : ℤⁿ → ℤ` with steps `±1`, `h ≡ c∘π (mod 3)`, and a winding homomorphism
`w : R → 3ℤ` with `|w(ρ)| ≤ ‖ρ‖₁`; the slope fibre `A(c) = {a ∈ [−1,1]ⁿ : a·ρ = w(ρ) on R}` is a nonempty rational polytope. *Proof:*
`plans/FS73-C3-deBruijn.md` §2 C1 (L1, L2 by Hahn–Banach for the ℓ¹ norm; Poros's route: the colouring's invariant-mean slope is a
point of its fibre); `plans/FS73-C3-Coxeter.md` §3 Lemmas 1–3 (`K₃`'s universal cover is the line; a grid square's four `±1` steps sum
to an even multiple of 3 in `[−4, 4]`, hence 0). *Proof verdict:* closes. *Rests on it:* T22–T25. *Prior art:* **the lift is the standard
height device for four-cycle-free targets** (Chandgotia 2017, summary read; K. Schmidt's cocycles); not claimed. The passage from the
grid to an arbitrary generating set through `R` is not found in the literature searched. *Kernel:* with T22's stub.

**T22 — The three-colour criterion: `Cay(Λ, S)` is 3-colourable iff some `θ ∈ Hom(Λ, ℝ)` has `‖θ(s)‖_{ℝ/ℤ} ≥ 1/3` on every generator, iff it has a periodic 3-colouring. [hand; de Bruijn (T0) and Coxeter (H-i), independently]** (⟸) `⌊3{θ(x) + β}⌋` is proper (and
periodic for rational `θ`); (⟹) T21's fibre maps onto a cell of `Θ₃ = {θ : θ(s) ∈ [1/3, 2/3] + ℤ}`, a finite union of rational
polytopes, which has a rational vertex. The same proof gives `Cay(Λ, S) → C_{2l+1}` iff some `θ` has `θ(S) ⊆ [l, l+1]/(2l+1)`.
*Proof:* FS73-C3-deBruijn.md §2 C1 and §4; FS73-C3-Coxeter.md §3 H-i. *Proof verdict:* closes; Poros checked both. *Rests on it:*
C3-aper at three colours for the whole class, answering `[AbrishamiEtAl2025]` Problem 4.6 at `χ = 3` for these graphs; the `Θ`
certificate (T26); ℚ(√167)'s survivors (T25, R9). Consistency check: `[FourUnitVectors2025]` Thm 1.2 falls out in one line (Coxeter §3).
*Prior art:* rank 1 (`G(ℤ, D)` 3-colourable iff `κ(D) ≥ 1/3`) is **not found stated in the literature searched** (Poros's recalled
pointer was retracted); circular colourings of distance graphs are classical (Zhu; Liu's 2008 survey, listings only); the arbitrary-`S`
form is ours as far as the gate reached. *Kernel:* **stub** — the ⟹ direction is the kernel route for any `Θ`-emptiness certificate
(`plans/STUB-three-colour-criterion-kernel.md`).

**T23 — Tight directions are affine; if every point of `Θ₃` has order 3, every 3-colouring is affine and `F = P`. [hand; de Bruijn (T1) and Coxeter (H-ii with its rigidity corollary), independently]** A generator on which every slope of the fibre is `±1` is tight: some
relation `σ` has `w(σ) = ‖σ‖₁` (LP duality; **Stiemke's** alternative in de Bruijn's form, Poros's correction), so every monotone path
along `σ` steps `+1` and `c(x + t) − c(x)` is constant. If the fibre is a point at a cube vertex, every step is frozen, `c = φ + const`
with `φ : Λ → 𝔽₃` additive, and `F = P = ⋂ ker φ ⊇ 3Λ`. *Proof:* FS73-C3-deBruijn.md §2 C1 (T1) and C2 (L4, the frozen coordinates);
FS73-C3-Coxeter.md §3 (H-ii and its corollary). The owner checked T1's middle step (Stiemke, tightness). *Proof verdict:* closes.
*Rests on it:* T25; the rigidity dichotomy (T24). *Prior art:* ours. *Kernel:* with T22's stub.

**T24 — Periodic 3-colourings are dense; so `P = F` (C3-inherit) and C3-aper hold at three colours for every such Cayley graph, and `F` has finite index iff every cell of `Θ₃` is a point. [hand; Coxeter (H-iii, H-iv); the closing step checked by Poros and the owner]**
For every 3-colouring `c` and finite `B`, a McShane-type extension `ĥ(m) = min_{β ∈ B̃, ℓ ∈ L} [h(β) + a*·ℓ + ‖m − β − ℓ‖₁]` with `a*`
rational in the relative interior of `A(c)` and `L = R + Nℤⁿ` gives an `NΛ`-periodic colouring agreeing with `c` on `B`, for `N` even, a
multiple of `6·den(a*)`, **and a multiple of the exponent of the torsion of `ℤ^F/pr_F(R)`** — the choice that kills de Bruijn's
unsaturated-frozen residual case (his dB-T2's `sat(Λ_J) ∖ Λ_J`), since `NΛ ∩ sat(Λ_T) ⊆ Λ_T`. H-iv: points ⟹ finitely many colourings; a fat
cell's rational interior points are distinct invariants of periodic colourings, so infinitely many; `F` of finite index ⟺ `X` finite.
**No arithmetic of the lattice enters.** *Proof:* FS73-C3-Coxeter.md §3 H-iii, H-iv; `plans/POROS-2026-09-23-fs73-competition.md` §4
(the choice of `N`); the owner checked that step. *Proof verdict:* closes. *Rests on it:* row 79's headline; C3 is open only from four
colours up; H-iii supersedes de Bruijn's dB-T2 (C3 when every frozen sublattice is saturated, with the lemma dB-L4), which stays proved. *Prior art:* density of
periodic points of the 3-colour hom-shift at the **standard** generators is expected to be known or folklore (Chandgotia–Marcus 2018,
Chandgotia–Meyerovitch 2016: listings only) — not claimed there; the McShane step's natural prior art is Chandgotia–Pak–Tassy 2019
(*Kirszbraun-type theorems for graphs*, unread). *Kernel:* declined for now (the analytic extension is the costly part); the stub for
T22 records it as the second target.

**T25 — `Θ₃(Λ₁₀) = 16` isolated points of order 3, so `F = P = 3Λ` at ℚ(√11) with no forcer and no solver. [tools exact + hand; de Bruijn and Coxeter, independently]** The exact trees (de Bruijn: Fraction simplex with Bland's rule, 1,803 nodes, 24 leaves; Coxeter:
sympy's exact simplex, 651 nodes) find 16 points, each fully tight (an additive `φ : Λ → 𝔽₃` with `φ(U) ∌ 0`) and of zero extent; by
T23 every colouring is `c(0) + φ`, 48 in all (T12's count), and the 16 functionals have rank 4 over 𝔽₃ and common kernel `3Λ`.
*Proof:* FS73-C3-deBruijn.md §2 C1 ("Instance"); FS73-C3-Coxeter.md §4 C-2; scripts `data/fs73/c3-debruijn/`, `data/fs73/coxeter-c3/`.
*Proof verdict:* closes. *Rests on it:* T12 re-derived; row 79; B's tight-prime reading half-explained (G54). *Prior art:* ours.
*Kernel:* with T22's stub (one tree per lattice once T22 is kernel).

**T26 — The `Θ`-emptiness certificate: an exact tree plus a Fraction-only checker. [cert; Coxeter; E added one over `d = 11`]** At every
node the tree records rational multipliers bounding the next unit vector's `θ`-value (the box handled by `u = max(0, −(yA + c))`), its
children cover every integer band the certified range meets, and an infeasible node carries a Farkas vector; the checker recomputes
every bound and child list and **re-enumerates the lattice's unit vectors from its key**. Instance: FS-61's shape
`60|5,1,5,3;0,2,0,2;0,0,10,2;0,0,0,4` over ℚ(√47) — 2,997 nodes, 0 leaves, 653 KB, `CERTIFICATE OK … Θ EMPTY` — an independent proof,
with T22, that the lattice is not 3-colourable (`χ(ℚ(√47)²) ≥ 4`, row 73's known value) with no LRAT file. E's certificate: `Ld65c8ee8`
over `d = 11`, 20,843 nodes, 4.9 MB. *Proof:* FS73-C3-Coxeter.md §4 C-7; `data/fs73/coxeter-c3/certtree.py`, `certcheck.py`,
`cert_47.json`; the owner ran `certcheck` and two plants (a dropped child; the key relabelled to `d = 335`) were refused.
*Proof verdict:* closes. *Rests on it:* FS-60 (the quadratic witnesses without LRAT files); R9. *Prior art:* ours (a certificate type).
*Kernel:* stub with T22.

**T27 — `Ld14c588b` over ℚ(√167) is 3-colourable with period index 1,080. [exact; Coxeter; verified independently by the owner]** With
`x = ((a+b√167)/348, (c+e√167)/348)` and `ψ = (43/108)a + (1309/2160)b − (59/240)c − (301/1080)e`, every unit vector has
`ψ(u) mod 1 ∈ [1/3, 2/3]`, so `⌊3{ψ(x)}⌋` is proper, periodic under `ker(ψ mod 1)` of index 1,080 (cyclic). *Proof:*
FS73-C3-Coxeter.md §4 C-4; `data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json`; the owner's own enumeration of the 44 unit
vectors in Fractions, with a plant. *Proof verdict:* closes. *Rests on it:* FS-59 (one of two survivors settled); the G21 instance "a
periodic search measures its period cap" (P2b stopped at `N ≤ 30` and circular `N ≤ 120`). *Prior art:* ours. *Kernel:* declined.

**T28 — Controls: `Θ₃` agrees with the solver record on nine lattices and with a transfer-matrix decider on 2,299 rank-1 sets. [tools; de Bruijn and Coxeter]** Empty exactly where a solver refused (de Grey's lattice, 7,215 nodes; `Ld65c8ee8` over 11; three
shapes over 47, 95, 119), nonempty where FS-61 coloured (over 35, 59, 131, 179, 371, 335; `Λ₁₀`); in rank 1, `D ⊂ {1..13}`, `2 ≤ |D| ≤ 5`,
917 colourable and 1,382 not, 2,299 of 2,299 agreeing. *Proof:* FS73-C3-deBruijn.md §2 C3, C5; FS73-C3-Coxeter.md §4 C-1, C-3.
*Proof verdict:* closes as measured, both outcomes present. *Rests on it:* trust in T25–T27. *Prior art:* ours. *Kernel:* declined.

**T29 — Four colours have no linear criterion and no height. [tools + hand; Coxeter (C-5, §6), de Bruijn (§4)]** In rank 1 four sets
`D ⊂ {1..10}` are 4-colourable with no `θ` having `‖θd‖ ≥ 1/4` (e.g. `{1,3,4,5}` by the period-8 word `0,1,0,1,2,3,2,3`); structurally,
labelling colours by `V₄`, every closed 4-walk of `K₄` lifts through the cube `Q₃`, whose square complex is a sphere, and `K₄ = Q₃ /
antipode`, so `K₄`'s square complex is `ℝP²`: a 4-colouring carries only a winding in `Hom(R, ℤ/2)` — no integer height, no slope, no
fibre, no McShane extension. So **no `Θ`-type two-sided certificate exists at four colours**; a two-sided finite certificate scheme exists
iff 4-colourability of Cayley graphs of ℤ^r is decidable (refusals by compactness; colourability iff C3-aper holds at four). *Proof:*
FS73-C3-Coxeter.md §4 C-5 and §6; FS73-C3-deBruijn.md §4. The owner checked the `ℝP²` identification. *Proof verdict:* closes (the
decidability equivalence is a reduction, not a decision). *Rests on it:* Kooshi's four-colour question answered; the four-colour
certificate stub. *Prior art:* Chandgotia's dividing line for hom-shifts (four-cycle-free targets have heights); `[Burr1984]`'s
undecidability is for several vertex orbits, not Cayley graphs. *Kernel:* declined.

**T30 — Rank-1 walls at four colours, and the wall criterion. [tools + hand; Coxeter]** A wall between two rigid phases of a common
period `p` separates `p ∈ P`, so it is a rank-1 counterexample to C3 (sufficient, not necessary); at three colours there are no walls
(`max D ≤ 10`, as T24 requires); at four the first walls appear at `max D = 10` (`{1,5,7,10}`, `{3,5,9,10}`, `{3,7,9,10}`, `{5,7,9,10}`)
and in the triangle-chain family (three sets) — every one with `P = F = 0`. *Proof:* FS73-C3-Coxeter.md §4 C-6. *Proof verdict:* the
criterion closes; the scan is a typed null. *Rests on it:* the C3-at-four stub's rank-1 laboratory. *Prior art:*
`[EggletonErdosSkilton1990]` (rank 1: periodic χ-colourings exist, aperiodic ones may coexist). *Kernel:* declined.

## §5. Rank 6 (phase P4)

**T31 — A gapped periodic colouring has `KPer(c) = 0`, and its looseness is periodic; a colouring with `Λ/Per(c)` of exponent 2 is achiral; `c` is additive iff `[Λ : Per(c)] = 4`. [hand; F]** A gapped vertex is a Kempe component with no edge; recolouring the whole
coset `g + W′` (`W′ ⊆ Per` of finite index missing `δ`, holding no unit vector) separates `(0, δ)` periodically; `−x ≡ x (mod 2Λ)`;
additive colour classes are the four cosets of `Per(c)`. *Proof:* phase-P4.md, Registration items 2, 4, 5. *Proof verdict:* closes.
*Rests on it:* L2, L6 loose (`F = P = 0`) before any P4 run. *Prior art:* ours. *Kernel:* declined.

**T32 — L3 is loose at four colours without a gap: `F = P = 0`. [tools exact; F; re-checked by the owner]** One gap-free `2L3`-periodic
colouring has `KPer(c) = 0` (six of the 2,304 period-2 colourings do), so by R3 every `δ ≠ 0` is separated periodically; its exact
period group has `Λ/Per ≅ (ℤ/2)²` (the colouring is additive into `V₄`; the record's "2L3-periodic" is coarser than the truth and
harmless). L2 and L6: `F = P = 0` from their gapped colourings at `N = 5` (7 of 7 read `KPer = 0`). L3 has 96 ℤ/4 and 216 `(ℤ/2)²`
additive colourings and no `5L3`-periodic colouring. *Proof:* phase-P4.md, Theorems; `data/fs73/rank6/rows.jsonl` (`L3|N2|certificate`);
the owner's re-check with D's frozen checker primitives (plants refused). *Proof verdict:* closes. *Rests on it:* G68's gap is
sufficient for looseness, not necessary; P-F1, P-F4 won. *Prior art:* ours. *Kernel:* declined.

**T33 — The fibre-collision sandwich: `D_Q ⊆ V_Q`, and `V_Q/D_Q` is the image of `Q`'s cycle space. [hand; F; measured on L3]** With
`R(Q)` the residues of `U mod W` carried by an edge inside the two-colour component `Q`, `Δ_ρ` the differences of unit vectors in one
residue fibre and `D_Q = Σ_{ρ ∈ R(Q)} Δ_ρ`: out along `u` and back along `−u′` is a closed walk of voltage `u − u′`, and changing a lift
moves a voltage within `D_Q`, so `V_Q = D_Q + (one lift of a cycle basis)`. A target escapes iff `e ∉ V_Q`: membership, not the index.
On L3 at `N = 2` (all 2,304 colourings): the rank-deficient components are exactly the single-residue ones (`V = Δ_ρ`, rank 4); the
cycle correction lies in `(ℤ/2)²`; so the odd part of `[2Λ : V]` is that of `[2Λ : D]`, and Poros's 81 = 3⁴ is colouring-free
arithmetic of L3's unit vectors mod 2. *Proof:* phase-P4.md, § The mechanism; `L3|N2|mechanism` rows. *Proof verdict:* closes.
*Rests on it:* the plan's T10.2 re-wording; P-R2 (the index as an ideal norm) answered by mechanism. *Prior art:* ours — Gross–Tucker's
voltage-graph components are textbook, the collision lattice is not found. *Kernel:* declined.

**T34 — KR6: de Grey's lattice with the ζ₆-orbit of ρ₁₅ has rank 6, 78 unit vectors, `F ⊇ 8Λ_dG`, and no periodic colouring at any `N ≤ 6`. [tools exact + derived; F; Heule-510's check the owner's]** `1/4, 1/3 ∈ KR6` make `N = 2, 3, 4, 6` inadmissible; a
`5KR6`-periodic colouring would restrict to a `5Λ_dG`-periodic one, which K refuses (UNSAT here too); forcing is monotone upward, so
`F ⊇ 8Λ_dG` and KR6 has no gapped colouring; `KR6/Λ_dG ≅ ℤ² × (ℤ/4)²`; Heule-510's given embedding is not in KR6 (30 of its edge
vectors are unit vectors of K(√5) outside KR6's 78). **Its four-colourability is open.** *Proof:* phase-P4.md, Theorems;
`data/fs73/rank6/lattice-KR6.json`. *Proof verdict:* closes. *Rests on it:* the KR6 stub (period groups `W ⊇ 8Λ_dG` missing `U`, or a ℤ²
subshift over de Grey's 4,096-class colourings). *Prior art:* ours. *Kernel:* declined.

**T35 — Chirality: 13 of the 16 colourings found at `N ≥ 4` on the loose rank-6 lattices are chiral and non-additive; Coxeter's C-5 colouring is achiral up to translation. [tools exact; F]** `chirality()` equals its brute-force definition on all 2,343 proper
colourings of `G(ℤ/10, {1,3})` (960 chiral); `01012323` maps to itself under the reflection about 3/2 composed with `(01)(23)`. *Proof:*
phase-P4.md, Theorems and Controls. *Proof verdict:* closes as measured. *Rests on it:* Coxeter's reading (a four-colour counterexample
needs a chiral non-additive phase) — chirality is necessary for that shape and far from sufficient. *Prior art:* ours. *Kernel:* declined.

## §6. The plan's hand theorems (the planner, the modeling planner, Poros)

**T36 — The normal form: `F = ⋂_{c ∈ X} Per(c) = ⋂_{c ∈ X} KPer(c)` and `P = ⋂_{c periodic} Per(c) = ⋂_{c periodic} KPer(c)`, with `F ⊆ P`. [hand; the modeling planner, from the owner's amendments A1–A3 and Poros]** A swap on one Kempe component is again a colouring (for
`F`); a swap on `K₀ + W′`, `W′ ⊇ V` of finite index missing the escape, is periodic (for `P`: R3, H1 ⟺ Kempe-rigid, by residual
finiteness of `NΛ/V`). `KPer ⊆ Per` since `k ≥ 3`; the colour pair must be distinct. *Proof:* `plans/FS73-rigidity-dichotomy.md` §0
("Three reductions", "The normal form"); R3's escape direction is kernel (`notMem_periodicForcedSubgroup_of_voltageEscape`).
*Proof verdict:* closes. *Rests on it:* every census sandwich `F_known ⊆ F ⊆ P ⊆ P_found`. *Prior art:* ours. *Kernel:* the intrinsic forms
declined (plan §K: they need Kempe components as a kernel notion; the certificate form covers every use).

**T37 — Consequences of the normal form. [hand; the planner]** C3-inherit at `Λ` ⟺ `P = F`; it needs `rank F = rank P`; if `P` has
finite index, C3 at `Λ` ⟺ `F` has finite index ⟺ every colouring is periodic (both proved instances are therefore instances of
rigidity, as both competitors observed); `P_found ⊇ lcm(N)·Λ` only when every voltage group has full rank; the census confirms C3 at a
lattice and never refutes it. *Proof:* plan §0, consequences 1–6. *Proof verdict:* closes. *Rests on it:* the census's reading;
consequence 5 ("K may be the instance under test") closed by T7. *Prior art:* ours. *Kernel:* `inheritanceQuestion_iff` is the first
clause; the rest declined.

**T38 — The invariant-measure subgroup: `F ⊆ F_μ ⊆ F_meas ⊆ F_clopen = P`. [hand; the modeling planner at the owner's amendment A4]**
`F_μ = {δ : μ{c(0) ≠ c(δ)} = 0 for every invariant probability measure on X}` is a subgroup containing `F`, inside `P` (a periodic
separator's finite orbit carries a uniform invariant measure); the periodic colourings are the continuous colourings of the odometer `Λ
↷ Λ̂`. So C3-inherit splits into a walls half (`F = F_μ`: fails iff some colouring separates only on a set of zero upper Banach density,
by the Furstenberg correspondence) and a recurrent half (`F_μ = P`: holds when periodic-orbit measures are weak-* dense). *Proof:* plan
§0, "The gap between F and P, split by invariant measures". *Proof verdict:* closes as a restatement, not a result. *Rests on it:* G60
and G66's corrections at this close; at three colours T24 closes both halves. *Prior art:* Furstenberg correspondence;
Gao–Jackson–Krohne–Seward's continuous combinatorics of ℤ^d actions (listing). *Kernel:* declined.

## §7. ℚ(√167)'s last lattice (phase P3b, verification V2)

*From implementer E's record `data/fs73/records/phase-P3b-q167-theta.md` §7 (P3b-T1–T7, final at `909cf054`) and verifier V2's
`data/fs73/records/verify-P3b-q167.md` §6 and §9 (V2-T1–T9, final at `7931a25e`, `0e7b95e7`). V2 wrote and committed its verdict
before reading E's files. `L21cc6506` is FS-61's key `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`: the points `((a+b√167)/420,
(c+e√167)/420)` with `c ≡ b`, `e ≡ a (mod 2)`, and its 60 unit vectors `U`.*

**T39 — `L21cc6506` has `Θ₃ = ∅`, so it is not 3-colourable and `χ(ℚ(√167)²) ≥ 4`. [cert, three independent exact routes, four checkers + hand (T22's ⟹); E, V2]** E's route 1 is a θ-space tree of 605,203 nodes and 0 leaves (7.7 MB gzipped), accepted by Coxeter's unmodified `certcheck.py` and by E's own `tools/fs73_theta_check.py`; E's route 2 uses the product structure (T40): 1,764 lifts × 25 piece pairs = 44,100 cases, 444 left by an exact bounding-box test, 4,768 target combinations each refuted by a Farkas vector, checked by `tools/fs73_theta_struct_check.py`, which re-derives the whole reduction from the key (106 KB gzipped). V2's route, written before reading E, branches on relation values rather than on `θ` (the box `[1/3, 2/3]^30`, 39 relations): 45,516 nodes, 30,344 leaves, 149 KB gzipped, checked in 4 s by the Fraction/int-only `tools/fs73v2_check.py`, which enumerates `U` itself; a structurally different rerun on the 26 basis relations alone also passes (34,398 leaves). The owner re-ran V2's checker (PASS) and planted five faults, each refused for its own reason; E planted eight faults on route 1 and six on route 2, all refused; a fake-empty certificate for a colourable lattice is refused. *Proof:* phase-P3b-q167-theta.md §2, §5; verify-P3b-q167.md §5; `data/fs73/q167/L21cc6506-theta-{tree.json.gz,struct.json}`, `data/fs73/verify-v2/L21cc6506-empty.json.gz`. **No finite non-3-colourable graph is exhibited**: compactness (the kernel's `forces_iff_exists_finite` family) guarantees one, and the mean-slope step of the criterion is not constructive. *Proof verdict:* closes. *Rests on it:* row 79; FS-59's first question answered (the next is five); the conjecture's prediction at 167 (≥ 6) now stands against a proven 4. E's registered prediction (`Θ₃` nonempty, 0.60) **lost**. *Prior art:* not found in print (zbMATH and the held Polymath16 threads; `plans/FS73-rigidity-dichotomy.md` §R-close.10); the certificate type is ours. *Kernel:* **stub** — a box-LP certificate checker over ℚ with its soundness theorem, plus T22's ⟹ direction (`plans/STUB-three-colour-criterion-kernel.md`): this is the route for the bound into the kernel.

**T40 — The product structure of `L21cc6506`, and the rational pattern's rotation set. [hand + tools exact; E; confirmed independently by V2]** `U = {1, v, v̄, z, z̄}·U_R` exactly, with `U_R` the 12 rational unit vectors, `v = (83+i√167)/84` and `z = (1+i)(15−i√167)/28`; `span U = (1/210)ℤ[i] ⊕ (v/5)ℤ[i]` (the whole key lattice); `θ ∈ Θ₃` iff `μ_b(w) ∈ Θ_R` for the five maps `μ_b`, with `μ_v̄ = (83/42)μ₁ − ν`, `μ_z = (1−i)((7/2)μ₁ − 3ν)`, `μ_z̄ = (1+i)(3ν − (17/7)μ₁)` (V2 re-derived them from `m_{cb} = c̄·m_b`); and `Θ_R = (5/2, 5/2) + (D0 ∪ F4) + 5ℤ²`, `D0` the dodecagon `{|⟨δ, x⟩| ≤ 1/6 on U_R}`, `F4 = {(±5/6, ±5/6)}` four isolated degenerate points — exactly one 12-vertex cell and four point cells per period (V2's exact cell enumeration, `tools/fs73v2_thetaR.py`). The torus is `(ℝ²/210ℤ²) × (ℝ²/5ℤ²)`: `μ₁` sees 42² = 1,764 periods of `Θ_R`, which is why a first-cell search in a reduced basis could not finish. *Proof:* phase-P3b-q167-theta.md §3 (P3b-T2, T3); verify-P3b-q167.md §7 (V2-T8). *Proof verdict:* closes. *Rests on it:* T39's route 2 and T41. *Prior art:* ours. *Kernel:* declined (T39's stub carries the certificate instead).

**T41 — A half-page proof: the 36 unit vectors `{1, v, z}·U_R` already have `Θ₃ = ∅`, and they are a minimal obstruction. [hand, checked line by line by V2; cert + tools; E (P3b-T4), V2 (T6, T7, T9)]** Writing `μ₁ = c0 + 5k + δ₁`, `ν = c0 + δ₂` with `δᵢ ∈ D0 ∪ F4`, the third condition reduces mod `5ℤ[i]` to `η = (1−i)((7/2)δ₁ − 3δ₂)` hitting `(5/2)·(i or 1) + (D0 ∪ F4)`, and the four cases (both in `D0`; `δ₂` a point; `δ₁` a point; both points) close by the coordinate bounds `1/6`, `13/12`, `7/6` and the residues of `(5/6)σ`. Among the ten 3-subsets of `{1, v, v̄, z, z̄}` exactly `{1, v, z}` and its conjugate `{1, v̄, z̄}` give an empty `Θ₃` (a 1,050-leaf certificate, 5.7 KB), every other tested sub-configuration colours (an exactly checked `θ` each), and deleting any one of its 18 ± pairs makes `Θ₃` nonempty. So, modulo the criterion's ⟹ direction, **`χ(ℚ(√167)²) ≥ 4` has a half-page proof**: 36 vectors, a 2-D rotation set checkable by hand, four inequality cases. *Proof:* phase-P3b-q167-theta.md §6; verify-P3b-q167.md §8; `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`. *Proof verdict:* closes. *Rests on it:* the kernel stub's cheapest target (the 36-vector certificate in place of the 60-vector one); FS-59's next question (a four-colour question on this lattice). *Prior art:* ours. *Kernel:* with T39's stub (this is its smallest instance).

**T42 — The criterion's ⟹ direction by a forward lift, with no parity step and no generation hypothesis. [hand; V2, independently of both competitors]** For `Λ` torsion-free, `S = −S` finite with `0 ∉ S`: lift colour steps to `{1, 2}` (the two two-step sums around a square lie in `{2, 3, 4}` and agree mod 3, hence agree), average the resulting cocycle over Følner sets for a mean slope in `[1, 2]^m` that equals the winding on the relation lattice, descend through the direct-summand property of `R` (torsion-freeness is essential: `ℤ/3` with `S = {±1}` is 3-colourable with `Hom(ℤ/3, ℝ) = 0`), and extend from `⟨S⟩` to `Λ` by divisibility of ℝ — so `S` need not generate. And the relation form: `Θ₃ ≠ ∅` iff some `x ∈ [1/3, 2/3]^N` has `r·x ∈ ℤ` for every relation `r` (⟹ for any set of relations, ⟸ for a basis), which is what V2's certificate branches on. *Proof:* verify-P3b-q167.md §1–§2 (V2-T1, V2-T2). *Proof verdict:* closes. *Rests on it:* T39 (V2's route); the kernel stub (the relation form keeps every coefficient small, `|r_j| ≤ 3`). *Prior art:* T22's (the competition's) criterion; the forward lift and the relation form are V2's. *Kernel:* with T39's stub.

**T43 — The P3b controls. [tools exact / cert; E (P3b-T5–T7), V2 (V2-T4)]** `Ld65c8ee8` over ℚ(√11) has `Θ₃ = ∅` by exact certificates (E: 20,843 nodes, 4.9 MB, accepted by the unmodified `certcheck.py`; V2 independently) — FS-61's refusal re-derived through the criterion; over ℚ(√59) it has a point `ψ = (5/18, 1/2, 5/18, −1/2)` in a degenerate (slack 0) cell; `Ld14c588b`'s cell is full-dimensional with maximal slack `133/115872`, and V2 exhibits a second colouring `θ`. *Proof:* phase-P3b-q167-theta.md §4; verify-P3b-q167.md §4. *Proof verdict:* closes. *Rests on it:* trust in T39 (both outcomes produced by each pipeline). *Prior art:* ours. *Kernel:* declined.

**T44 — `L21cc6506`'s unit vectors span the key lattice, and no four of them form a basis. [tools + hand; V2]** Every integer unit vector of the key `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2` already lies in the key lattice (a mod-4 parity argument); the 60 unit vectors span it; the least index of four of them is 34,650. *Proof:* verify-P3b-q167.md §3 (V2-T5). *Proof verdict:* closes. *Rests on it:* the graph taken on the key lattice or on `span U` gives the same `Θ₃`. *Prior art:* ours. *Kernel:* declined.

**T45 — `L21cc6506`'s rotation `v = (83 + i√167)/84` is the type-M rotation at `n = 42`, and `[Fischer1990]` Example 4's unit vector. [hand; the close]** `cos θ = 83/84 = (2n − 1)/(2n)` and `sin θ = √167/84 = √(4n − 1)/(2n)` at `n = 42`, so `v` is G7's family member of radicand `4·42 − 1 = 167` — by G62 the `Σ = 42` coincidence rotation of the order of discriminant −167 (with `w = (1 + i√167)/2`, `|w|² = 42`, `w̄/w = −v`) — and `L21cc6506 = {1, v, v̄, z, z̄}·U_R` (T40) is the rational pattern twisted by it and by `z`, whose cosine `(15 + √167)/28` is irrational (not a type-M member). Fischer used the same vector in 1990 to put `1/2, 1/3, 1/7` in the unit-vector ring (no additive `k`-colouring for `k < 11`). *Proof:* the two lines above; `plans/FS73-rigidity-dichotomy.md` §R-close.1. *Proof verdict:* closes. *Rests on it:* G62's multilayer instance; FS-59's §0. *Prior art:* the vector is Fischer's (1990); the family is `[Polymath16wikiMain]`'s; the identification with `L21cc6506`'s structure is ours. *Kernel:* declined.

## §8. Conjectures and readings this milestone stated and did not prove (the close's sweep)

- **B's tight-prime reading** (phase-P2.md): full-rank `F` appears where the lattice is integral at a prime whose residue target is
  Hoffman-tight at `k` and no other prime's quotient has a gap. **Restated at the close:** Poros's N3 — at ℚ(√11) the prime above 3 is
  *split* in `ℚ(√11, i)`, not conjugation-fixed, so the reading's "fixed" clause fails at one of its two instances; at ℚ(√11) T25 now
  explains the instance. Carried into G54 and the algebraic-explanation stub.
- **F's reading** (phase-P4.md): at the smallest admissible period voltage groups are collision lattices; above it, combinatorial.
  Killing test: a lattice whose period-2 components have cycle corrections with odd torsion. Declined as a stub (the rank-6 population is
  a typed null); kept in T33's record.
- **Coxeter's chirality reading** (§6 of his file): a four-colour counterexample periodic in `r − 1` directions needs a chiral,
  non-additive four-colour phase (three-colour phases are never chiral, whenever a winding class is one irreducible component —
  unproved; Chandgotia's pivot property is the tool). Carried into the C3-at-four stub.
- **Baxter's height on hexagonal fabric** (Coxeter §6): the one height a four-colouring of a lattice containing `ζ₆` carries; whether
  the other unit directions act on it by translations is the question. Carried into the algebraic-explanation stub.
- **C3-aper at four colours** and **decidability of 4-colourability of Cayley graphs of ℤ^r**: open; stubs.
- The plan's conjecture sweep (`grep -n -i "conjecture\|not claimed" plans/FS73-rigidity-dichotomy.md`, 4 hits): G48's local–global
  conjecture (its own stubs), G58's antipodal conjecture (FS-55), the periodic tiling conjecture (a prior-art query,
  `[GreenfeldTao2024]`), the FS-66 tower conjecture (FS-68) — none new; declined as stubs.
