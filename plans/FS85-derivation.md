# FS-85 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-24 at the close (WORKFLOW 2.0 step 9) by the close planner (de Bruijn, Opus 5.5), from the plan
(`plans/FS85-rigidity-without-triangles.md` §PA.6, § Stage A), the two competitors' working files (`plans/FS85-C-deBruijn.md`: Task 0,
Route 1, Route 1′, Part 1; `plans/FS85-C-Coxeter.md`: §2–§4, R2.1–R2.12), round 3 (`plans/FS85-R3-five-part.md` §1), the two blind
verifications (`plans/FS85-V-verification.md`, `plans/FS85-V2-verification.md`), the input audit (`plans/FS85-input-audit.md`) and the
advisors' records (`plans/POROS-2026-09-24-fs85-plan.md`, `plans/POROS-2026-09-24-fs85-competition.md`). Grades are `CLAUDE.md` §
Notation's. A proof held in a record is not repeated here; this file is the index that survives the ledger rows' compression (rows
85–87). `LEDGER.md` § B indexes every entry, one line each (`tools/fs71_ledger_b_check.py --strict`). **FS-85 added no Lean**, so nothing
below is kernel-checked, and every kernel decision is recorded per entry.*

**Duplicates are merged, one entry per theorem** (the close brief): an entry carries the id of its first derivation, and its title
names every other id the milestone's records give it (`= FS85-V1`, `= FS85-C7`, …), so a grep for any of them lands here. Every
independent derivation is credited by name.

**Who found what:** the **planner** (stage A); **Poros (plan)**, the plan-phase advisor; the competitors **de Bruijn** and
**Coxeter** (round 1; a fresh Coxeter for round 2 and its extra stint); **Poros (round 1)** and **Poros (round 2)**, the two
competition advisors; **verifier 1** (the stripes-to-periodicity chain, V1–V8), **the round-3 agent** (de Bruijn, R3a–R3b), **the
auditor** (IA1–IA5), **verifier 2** (the whole `F ⊇ 8Λ` chain, V2-T1–T8); and the **owner** (checks cited by close-inventory item).

**Notation, fixed once for every entry below (V2's D2–D3).** `E = ℚ(√−3, √−11)`, `O = O_E`, de Grey's lattice `Λ = (1/9)·O`,
`T₀ = ℤ[ζ₆]`, `η = (√33 + i√3)/6` (so `η² = ω₃ = (5 + i√11)/6`, the Moser twist), `U = {ζ₆^a η^b : |b| ≤ 4}` (54 vectors), family `k`
the six vectors `ζ₆^a η^k`, `U_K = ⋃_{|k|≤K}`, `Λ₅ = ⟨U_2⟩` (index 81), `Λ₇ = ⟨U_3⟩` (index 9). The two primes above 2: `β = (5 + √33)/2`
generates `𝔭`, `β̃ = (5 − √33)/2` generates `𝔭̃` (`ββ̃ = −2`), and the **chirality lattices** are `P₊ = (1/9)β³O` and `P₋ = (1/9)β̃³O`
(each of index 64 in `Λ`, `P₊ ∩ P₋ = 8Λ`, `P₊ + P₋ = Λ`). At `P₋`, `η ≡ 3ζ₆` and `η² ≡ ζ₃`; at `P₊`, `η ≡ 3ζ₆²` and `η² ≡ ζ₃⁻¹`.
**Convention:** chirality `−` is `P₋`; Coxeter's `ε = +` (his records) is this file's `P₋`. R3's summary bullets and the V2 brief wrote
`P₋ = (1/9)β^{−3}O`, which contains `Λ`; the ideal is `(1/9)β̃³O` (D2, a typo; R3's own Notation section is right). **NT_k**: no
monochromatic equilateral √3-triple (an alternate triple of a family-`k` hexagon) in a four-colouring. **(S)**: `[Parts2020hv]`'s
theorem that no proper four-colouring of the plane has a monochromatic √3-triple, proved by his 481-vertex graph G481 and nine trees.
**(S″)**: NT_k for `|k| ≤ 2` on `Cay(Λ, U)`, which is (S) placed in `Λ` in the five inner orientations.

**Scope, stated once for every entry below.** A result about `Cay(Λ, U)` is not a result about the Moser ring `R₂` or the literal
ring `ℤ[ζ₆, ω₃]`: forcing is monotone upward, so it restricts to every point set `X` with `X + Λ = X` whose unit vectors include `U`,
and to nothing smaller (V2-T8). "Given (S″)" is part of every grade in §4–§6: the trees are Parts's computer case analysis, walked here
as a fixed certificate (IA1–IA4), never re-found. "Not seen in print" is not "new".

## §1. Stage A and Task 0 (the planner, the owner, de Bruijn, Coxeter)

**FS85-A1 — `η, η², η^{±3}, η^{±4}` lie in `Λ`, `η^{±5}, η^{±6}` do not, and `U = {ζ₆^a η^b : |b| ≤ 4}`. [tools exact; the planner (float), the owner (exact), de Bruijn and Coxeter (Task 0, exact, independently)]**
9η, 9η², 9η³, 9η̄³, 9η⁴ have coordinates `(−3,6,3,−6)`, `(6,0,3,0)`, `(−5,10,2,−4)`, `(3,−6,2,−4)`, `(1,0,5,0)` in the basis
`1, ζ₆, w, ζ₆w` of `O`; 9η⁶ has `(−13/3, 0, 16/3, 0)` (the owner's control, which must land outside; his first control η/3 could not
fail, since 3η ∈ O — an owner slip, caught). *Proof:* plan §PA.6 and §R-review; `plans/FS85-C-deBruijn.md` T0.1 (`tools/task0.py`,
`tools/lam.py` in `data/fs85/comp-debruijn/`); `plans/FS85-C-Coxeter.md` §3. *Proof verdict:* closes. *Rests on it:* the correction of
row 78's and FS73-T6's clause "reached through `η^{±3} ∉ Λ`" (false as written; `Λ` is not closed under *multiplication* by `η`, a
different statement, untouched); Task 0. *Prior art:* none. *Kernel:* declined (four exact memberships; a `decide` would restate them).

**FS85-A2 — The wiki's identities (8) `η = (ζ₆⁴+ζ₆⁵)η² + (ζ₆+ζ₆²)` and (9) `η³ = (2/3)(ζ₆⁴+ζ₆⁵)η² + (ζ₆+ζ₆²)` hold with `ω = ζ₆`, and fail with the page's stated `ω = e^{2πi/3}`. [tools exact; the planner (float, residuals 10⁻¹⁵ against 2.9 and 2.5), de Bruijn and Coxeter (exact)]**
In closed form, `η = √−3·(1 − η²)` and `η³ = √−3·(1 − (2/3)η²)`. *Proof:* plan §PA.6; `plans/FS85-C-deBruijn.md` T0.2. *Proof verdict:* closes. *Rests on it:* reading `[Polymath16wikiR2]` on `Λ` (Task 0). *Prior art:* the page's identities. *Kernel:* declined.

**FS85-A3 — In FS79-T36's committed rank-1 range, no distance set with every phase rigid is triangle-free, and no triangle-free one has a non-zero four-colour forced group. [tools exact, a reading of a committed record; Poros (plan) and the planner independently; the owner]**
In `11 ≤ max D ≤ 14`, `3 ≤ |D| ≤ 5` (2,706 sets): 377 sets have every phase rigid, 0 walls, none sum-free; of the 600 sum-free sets, 550
are three-colourable by the exact rank-1 `Θ₃` test at the endpoints `k/(3d)` and the 50 exactly four-chromatic ones are loose; **27 of
those 50 have a rigid phase beside a loose one** (the owner's addition: an isolated rigid phase exists without triangles in rank 1, a
forced group never did in this range). *Proof:* plan §0.3; close-inventory item 11 (the owner's recomputation from
`data/fs79/comp-debruijn/runs/rank1_scan.jsonl`, md5 `46a1c86a…`). *Proof verdict:* closes **for the range only** — FS85-dB2 is a
triangle-free rank-1 set with `F₄ = 4ℤ` at `|D| = 70`, `max D ≈ 3.7·10¹⁹`, so the range was the whole of the finding (G21). *Rests on it:* nothing (P-rank1 was refuted by dB2). *Prior art:* the scan is FS79-T36. *Kernel:* declined.

**FS85-T0 — Task 0: the held hand tools transfer to `Cay(Λ, U)` as lemmas, not as premises. [tools exact; de Bruijn (T0.3–T0.5), Coxeter (§3), independently]**
(a) Every base point `[Polymath16wikiR2]` Prop. 7 visits (normalised `z₀ = 0`: `η², ωη², −ω²η², (1+ω)η², 2η², (1−ω²)η², 2ωη², −2ω²η²,
(2/3)(1+ω)η², (2/3)(1−ω²)η²`, `ω = ζ₆`) lies in `Λ`, and each of its 17 adjacency relations (Coxeter: 11 coset representatives and 23
edges) joins two points whose difference lies in `U`; its normalisations use `ζ₆` and conjugation, automorphisms of `Cay(Λ, U)`. (b)
Hubai's five-rotation word is exactly translation by `8/3 ∈ Λ`; it stays in `Λ` from starting points in `O`, but its premise is the
uniform chirality, which was the open Part-1 statement. (c) `[Parts2020hv]`'s striping lemma lives on `T₀` alone, so it restricts to
every coset `z + T₀`; its hypothesis is his computer part. **Scope — what Task 0 measured:** membership of points and differences, not
the logic of the proofs: the written proof of Prop. 7 part 1 does not close (FS85-V6), which Task 0 recorded as "runs step by step"
without re-deriving it (a G21 instance: the transfer check measured membership). *Proof:* `plans/FS85-C-deBruijn.md` Task 0;
`plans/FS85-C-Coxeter.md` §3 (`tools/efield.py`, `tools/task0.py`). *Proof verdict:* closes for membership. *Rests on it:* dB11's use
of Prop. 7 (with V6's repair); P-wiki's score. *Prior art:* the three held sources. *Kernel:* declined.

## §2. Part 2: the abstract class and where `𝒰^tf` sits (de Bruijn, Coxeter; Poros (rounds 1, 2); the auditor; the owner)

**FS85-dB1 — The embedding lemma: a B₃ (or balanced-base) embedding of a finite graph `H` into a distance graph on ℤ, congruent to a proper `k`-colouring of `H` mod `k`, keeps `χ ≤ k`, keeps triangle-freeness, and makes every `k`-colour compulsion of `H` translation-invariant (= Coxeter's FS85-C1, the free embedding). [hand; de Bruijn and Coxeter independently, both in first routes written before any contact]**
de Bruijn: `λ = 4μ + t` with `μ` a base-8 B₃ set; Coxeter: `n_i = f(i) + kK·B^i`, `B ≥ 7` odd, `kK > 6(k−1)`, balanced base-`B`
digits. Triangle-freeness: a triangle `s + t = r` in `±D` is a relation among six `λ`'s that the B₃ (resp. base-`B`) condition makes
formal, i.e. three edge vectors of `H` summing to zero — a triangle of `H`. Translation invariance is free: a Cayley graph contains
every translate of its finite subgraphs, and forcing is monotone upward. *Proof:* `plans/FS85-C-deBruijn.md` Route 1;
`plans/FS85-C-Coxeter.md` §2.1. *Proof verdict:* closes (both checked by hand by Poros (round 1)). *Rests on it:* dB2, dB3. *Prior art:*
not found (auditor A3.4: no triangle-free distance graph or circulant with a forced pair in print; the ingredients — a `k`-colourable
graph inside a circulant coloured mod `k`, Sidon sets against short relations — are folklore-grade). *Kernel:* declined (a small
combinatorial lemma; the instance is the interesting object).

**FS85-dB2 — A named triangle-free distance graph `G(ℤ, D)`, `|D| = 70`, with χ = 4 and `F₄ = P₄ = 4ℤ`: every proper four-colouring is `x ↦ f(x mod 4)`, exactly 24 of them (= Coxeter's FS85-C1a, which gives `δ = 120·7²¹ ∈ F₄`, finite index). [hand + tools exact; Mycielski's theorem by hand; de Bruijn and Coxeter independently]**
`H = M(Grötzsch) − A·y_g` (23 vertices; triangle-free; every four-colouring gives `A`, `y_g` one colour, else it four-colours the
five-chromatic Mycielskian); `λ_{y_g} − λ_A = 4 ∉ ±D`; `D mod 4 = {1, 2, 3}`; `gcd D = 1`; `max D = 36,893,488,147,419,103,231`.
Coxeter's instance (the same `H`, base 7): `|D| = 70`, `max D ≈ 7.8·10¹⁹`. *Proof:* `plans/FS85-C-deBruijn.md` Route 1 (`route1.py`);
`plans/FS85-C-Coxeter.md` §2.1 (`part2_rank1.py`). **Checked:** by Poros (round 1) by hand; by the owner in independent code
(`data/fs85/owner-checks/fs85_dB2_check.py`: `|D|`, `D mod 4`, `4 ∉ ±D`, no `s + t ∈ ±D` over all 140² pairs, gcd, `max D` to every
digit, no B₃ violation among all 3-multisets; a planted `D₀ + D₁` detected). *Proof verdict:* closes. *Rests on it:* the killing
test's pass (K4, at two derivations); P-rank1 refuted; row 86. *Prior art:* not found (A3.4); consistent with Zhu's conjecture `χ ≤ |D|`
for triangle-free `G(ℤ, D)` (via Oravcová–Soták 2024). *Kernel:* **stub** — a named finite `D`, the forced pair from the five-chromatic
Mycielskian, and the mod-4 colouring are all small; Mycielski's theorem is the one real lemma.

**FS85-dB3 — For every `k ≥ 3` there is a triangle-free uniquely `k`-colourable circulant (= Coxeter's FS85-C2, with an explicit one at `k = 4`, order `4q`, `q = 58,647,315,699,084,919,633`; = the auditor's FS85-IA5, by the product route). [hand; de Bruijn, Coxeter (+ exact check of the `k = 4` instance, `part2_circulant.py`), the auditor]**
Embedding route (dB, C): reduce the `(k+1)`-critical triangle-free Mycielskian minus an edge, embedded as in dB1, modulo `N = kq` with
`3·max D < N`; the forced pair's difference generates `kℤ/N`, so every colouring factors through `ℤ/k`, whose quotient is `K_k`.
Product route (IA5): for `Y` a connected triangle-free circulant of order prime to `k` with `χ(Y) > k`, `K_k × Y` is a triangle-free
uniquely `k`-colourable circulant, by `[KlotzSander2017]` Thm 4.2 (after Greenwell–Lovász 1974); dB1 supplies such a `Y`. *Proof:*
`plans/FS85-C-deBruijn.md` Route 1; `plans/FS85-C-Coxeter.md` §2.2; `plans/FS85-input-audit.md` A3.3. *Proof verdict:* closes. *Rests on it:* nothing downstream; it answers `[KlotzSander2017]` Problem 3.6 ("is χ = ω for every uniquely colourable circulant?") negatively at
every `k ≥ 3`, extending `[Basic2026]`'s `k = 3`. *Prior art:* **not seen in print, folklore-grade**: a two-line corollary of
Klotz–Sander's own Thm 4.2, printed one page after they pose 3.6 and never drawn; Nešetřil 1973 has triangle-free uniquely
`k`-colourable graphs for every `k`, none circulant; Klotz–Sander's five citing works (OpenAlex ∪ Semantic Scholar) do not bear. Owed
before any novelty claim for `Y`: one query on Cayley graphs of ℤ and Bohr recurrence (A3 debt (d)). Coxeter's first wording ("answers
3.6 at four colours") overclaimed and was corrected by Poros (round 1). *Kernel:* declined (a corollary of a printed theorem, owed a
citation, not a certificate).

**FS85-dB4 — `𝒰^tf` sits exactly at Soifer's Open Problem 55.1: a finite triangle-free unit-distance graph with a four-colour forced pair exists iff a finite triangle-free five-chromatic one does; and a lattice `Cay(Λ, S)` in `𝒰^tf` has `F₄ ≠ 0` iff a finite unit-distance gadget with edge directions in `S` forces a pair whose Cayley closure is four-colourable (= Coxeter's FS85-C3). [hand; de Bruijn and Coxeter independently; the genericity step closed for chains of `m ≥ 4` copies by Poros (round 2)'s constant-modulus lemma]**
⟹: a five-critical subgraph minus an edge. ⟸: chain `m ≥ max(4, ⌈1/δ⌉ + 1)` isometric copies of the forcer at angles on the closing
variety `|Σ e^{iθ_j}| = 1/δ` and add the closing unit edge; every unwanted coincidence or cross unit distance is a non-constant
analytic condition, by the lemma *a trigonometric polynomial in independent angles of constant modulus on an open set has at most one
non-zero term* (Poros (round 2), checked by de Bruijn). At `m = 3` the argument does not run. *Proof:* `plans/FS85-C-deBruijn.md` Route
1′; `plans/FS85-C-Coxeter.md` §2.3; `plans/POROS-2026-09-24-fs85-competition.md` §11. *Proof verdict:* closes (the non-constancy per
event type reduced to the lemma; Poros (round 2) checked the whole). *Rests on it:* the calibration that any `𝒰^tf` "yes" is at Soifer
strength (row 86); `CLOSED-QUESTIONS.md` §3. *Prior art:* the ⟹ half is folklore; the equivalence not found stated. *Kernel:* declined
(real-analytic genericity; no kernel consumer).

## §3. Part 1, round 1: the structure given 8Λ-periodicity (de Bruijn, Coxeter; Poros (rounds 1, 2); the owner)

**FS85-C4 — On de Grey's lattice, a four-colouring's stripes lie in one common direction `ζ₆^j` on every Eisenstein coset iff `2ζ₆^j` is a period. [hand; Coxeter]**
*Proof:* `plans/FS85-C-Coxeter.md` §3 (census-read: exactly one such period per colouring, all three for the residue pair).
*Proof verdict:* closes. *Rests on it:* Coxeter's round-1 plan. *Prior art:* Hubai's description. *Kernel:* declined.

**FS85-dB5 — The level-3 quotient `Cay(Λ/8Λ, U mod 8)` (36 distinct generators) is exactly Hoffman-tight at four colours, `λ_min = −12 = −d/3`, its least eigenspace 42 characters, 21 depending only on one prime above 2 and 21 only on the other, none mixed; the infinite lattice `Cay(Λ, U)` is not tight. [tools exact; the torus minimum numerical, for aiming only; de Bruijn; the owner]**
The owner's recomputation (`data/fs85/owner-checks/fs85_dB5_spectrum.py`): 54 vectors, 36 mod `8Λ`, `λ_min = −12.000000000`, multiplicity
42, Hoffman bound exactly `n/4`; control (one ± pair dropped): `λ_min = −14` against `−11.33`, slack. The symbol's infimum on the
character torus is ≈ −22.3 (Coxeter ≈ −22.41) against −18. *Proof:* `plans/FS85-C-deBruijn.md` Part 1. *Proof verdict:* closes for the
quotient; the infinite-lattice statement is a numerical minimum. *Rests on it:* dB6, dB8; the reading that `F ⊇ 8Λ` is not spectral
on the infinite lattice. *Prior art:* Hoffman's bound and its equality case. *Kernel:* declined.

**FS85-dB6 — Every `8Λ`-periodic four-colouring of `Cay(Λ, U)` factors through `Λ/P_ε` for one prime above 2. [hand; de Bruijn; re-derived by Poros (round 1) and by the owner]**
Hoffman's equality case puts every colour class's indicator in the least eigenspace plus constants, so it is `G(X) + H(Y)` with `X, Y`
the two primes' residues; a `{0,1}`-valued `G(X) + H(Y)` has `G` or `H` constant, and the four classes choose the same prime (the union
of the classes depending on one prime is a function of both coordinates, hence constant — the owner's step). *Proof:*
`plans/FS85-C-deBruijn.md` Part 1. *Proof verdict:* closes. *Rests on it:* dB7's reading; with row 78's certificate (round 1) or R3b
(now), every four-colouring is local at one prime above 2. *Prior art:* the equality case is Blokhuis–Brouwer–Haemers's (G54). *Kernel:*
declined.

**FS85-dB7 — Hubai's chirality is the choice of prime above 2: `η² ≡ ζ₃` modulo `P₋` and `η² ≡ ζ₃⁻¹` modulo `P₊`. [tools exact; de Bruijn; checked by Poros (round 1) in PARI (valuation 3 at each prime, opposite signs; control valuation 0)]**
*Proof:* `plans/FS85-C-deBruijn.md` Part 1. *Proof verdict:* closes. *Rests on it:* the chirality statement on `Λ` (ruling 4 (ii)'s letter);
C9's identification of the chirality with the prime, which is **not independent** of this entry (Coxeter (round 2) saw a commit
subject naming it; close-inventory item 59). *Prior art:* the chirality is `[Hubai2018]`'s (ring, computer). *Kernel:* declined.

**FS85-dB8 — Lemma S: every proper four-colouring of the 64-vertex level-3 dyadic plane `G₃ = Cay(Λ/P_ε, U)` (= Coxeter's `Cay(T₀/8T₀, μ₆ ∪ 3μ₆)`) has a period `2ε` — a stripe pattern. [hand; de Bruijn; re-derived step by step by Poros (round 2)]**
Branch I (a one-colour segment on some line): holonomy round a four-row cycle gives a ±2 shift or a 2-line, which propagates through
unit triangles. Branch II (no one-colour segment) is impossible: tightness forces the three lines through each point to carry the
three pair-partitions, hence a level-2 colouring with every line rainbow — a complete mapping of `ℤ/4`, which does not exist. The
stripes are exactly the four-colourings of `G₃`: 4,560 = 3·1,512 + 24 per prime. *Proof:* `plans/FS85-C-deBruijn.md` Part 1 (addendum).
*Proof verdict:* closes. *Rests on it:* the stripes on `Λ` given `8Λ`-periodicity; Coxeter's C12 count (independently). *Prior art:*
`[Parts2020hv]`'s striping lemma (a different hypothesis: NT on `T₀`); Hall–Paige for `ℤ/4` (no complete mapping). *Kernel:*
declined (FS85-V2-T5 is the better kernel target).

**FS85-C5 — The pair-linear structure theorem: a four-colouring is pair-linear (colours as `𝔽₂²`; the pair it wears is a homomorphism `Λ → 𝔽₂`); every admissible pair-linear colouring is proper and `8Λ`-periodic, exactly six admissible pair maps, 9,120 colourings (⊇); and every four-colouring of `Cay(Λ, U)` is pair-linear (⊆, (PL)). [hand + tools exact for ⊇ (C5a, C5b); (⊆) measured against FS-73's census when stated, now derived (R3b); Coxeter; the owner (by counting)]**
C5a: pair-linear properness ⟺ a parity character on `U₀`; C5b: six admissible pair indices, `Λ/L₀ ≅ ℤ/8`. Given (PL), by exact linear
algebra: `F = 8Λ`, one stripe direction per layer family, Hubai's "extends in exactly two ways", and the chirality `c(p + η²v) = c(p +
ζ₆^{±2}v)`. The owner's check (`data/fs85/owner-checks/fs85_C5_count.py`): the formula-built family has exactly six admissible `π`,
9,120 distinct proper colourings, equal to the census count, so the family *is* the census (a planted recolouring caught);
`6 × 1,536 − 2·48 = 9,120` (the residue pair counted three times). *Proof:* `plans/FS85-C-Coxeter.md` §4.1. *Proof verdict:* (⊇) closes;
(⊆) closed at round 1 only through FS-73's certificate, and now by derivation via R3b (C9 derives (PL) from NT in all nine families).
*Rests on it:* C9's (PL) consequence. *Prior art:* Hubai's description (ring, computer). *Kernel:* declined.

**FS85-C6 — Two striped layer families do not force a common pair type: on `Tri □ Tri` (the piece of `Λ` on `T₀ + ηT₀`, 12 of the 54 unit vectors) `F(t) + G(s)` colourings exist with different pair types. [hand; Coxeter; Poros (round 2) checked it is the right graph]**
*Proof:* `plans/FS85-C-Coxeter.md` §4.2. *Proof verdict:* closes. *Rests on it:* (PL) needs three or more families. *Prior art:* none.
*Kernel:* declined.

## §4. Part 1, round 2: periodicity from Parts's stripes (de Bruijn, verifier 1, Coxeter; Poros (round 2); the owner)

**FS85-dB9 — Given (S″): adjacent striped `T₀`-cosets share a direction unless one is residue-type (both are, if their pair-partitions coincide); with no residue-type coset each orientation `η^kT₀` has one direction `η^kε_k` and the colouring is periodic under `L = ⟨2η^kε_k⟩`; all 243 choices of `L` have finite index, the lcm of their exponents 1680; so every four-colouring with no residue-type coset has `F ⊇ 1680Λ`, `P = F` (= verifier 1's FS85-V1, V2, V3). [hand + tools exact; de Bruijn; verifier 1 independently and blind]**
(a) = V1, proved by the verifier from pointwise distinctness alone (an exact enumeration of stripe data: 0 counterexamples; the
same-direction control 19,584 non-residue pairs, so "directions differ" is load-bearing; a planted fault fires 2,304 times). (b) = V2
(`U` generates `Λ`). (c) = V3: Smith invariants (6,6,6,6) ×162, (6,6,6,12) ×54, (6,6,6,30) ×12, (6,6,6,42) ×6, (6,6,6,48) ×6, (6,6,12,12)
×3, reproduced by the owner (`owner-held/fs85_dB9c_smith.py`), Poros (round 2) and verifier 1 (`v3.py`). (d) 168 of the 243 quotients are
Hoffman-tight with an `8Λ`-pure least eigenspace; the six carrying the real colourings (`Λ/L ≅ (ℤ/6)³ × ℤ/48`) are not ("gap B", now
moot by R3b). *Proof:* `plans/FS85-C-deBruijn.md` Part 1 (dB9); `plans/FS85-V-verification.md` §V1–§V3. *Proof verdict:* closes given
(S″). *Rests on it:* FS85-V7. *Prior art:* the stripe form is `[Parts2020hv]`'s; the disjointness lemma was found neither in the threads
nor on the wiki. *Kernel:* **stub** (V1 is a small finite statement about stripe data, the natural first leaf of a kernel form of V7).

**FS85-dB10 — A residue colouring on one coset of `M = T₀ + η²T₀` spreads pointwise to the global residue colouring on `Λ` (= verifier 1's FS85-V4). [hand + tools exact; de Bruijn (the sublattice chain 729 → 81 → 9 → 3 → 1); verifier 1 independently (an exact coset closure on `Λ/M`, all 729 cosets in 6 rounds at both primes; a thin-start control stops at 3 of 2,916)]**
*Proof:* `plans/FS85-C-deBruijn.md` Part 1 (dB10); `plans/FS85-V-verification.md` §V4 (`v4.py`). *Proof verdict:* closes. *Rests on it:*
dB11. *Prior art:* the wiki's Cor. 9 is the first step on `R₁ + η²R₁`. *Kernel:* stub, with dB11.

**FS85-dB11 — Given (S″): one residue-type coset, in any of the five orientations `|k| ≤ 2`, forces the global residue colouring (= verifier 1's FS85-V5, with its lemmas V-T5 Lemma A, V-T6 Lemma P, V-T8 Lemma X, V-T9 the transversal lemma). [hand + tools exact; de Bruijn (repaired); verifier 1 independently and blind]**
de Bruijn's route: the wiki's Prop. 7/Cor. 8 make every `T₀`-coset of `M` residue-type; the four `η²T₀`-stripe families are
residue-type by a D/C derangement case analysis; a triple-rainbow Latin square on `𝔽₄²` is `y + μβ`, `μ = red_𝔮(η²)`; dB10 spreads it;
the other orientations by the same steps and by the Galois automorphism fixing `√−11` (a graph automorphism). **Repair (verifier 1, C2):**
de Bruijn's step 1 depended on the wiki's *written* Prop. 7, whose last step is dead (FS85-V6); keep the wiki's chain to the six
constant cosets and replace the final `(2/3)(1+ω)η²` step by one line — the `η²T₀`-coset through any point would be striped in no
direction, contradicting (S″), which steps 2–3 already assume; with it steps 1–5 stand, and likewise in orientations −1, −2. Verifier
1's route: Lemmas A, P, X (successor relation symmetric with at most one successor, so `L_{n+2} = L_n`) and the transversal lemma.
*Proof:* `plans/FS85-C-deBruijn.md` Part 1 (dB11); `plans/FS85-V-verification.md` §V5, §C2. *Proof verdict:* closes given (S″), as
repaired. *Rests on it:* V7. *Prior art:* the renormalisation and the chain of cosets are `[Polymath16wikiR2]`'s (Tao, 2018); the
closing step and Lemma X are ours (both derivations). *Kernel:* **stub** (finite and local on `M`; (S″) the one named input).

**FS85-V6 — The written proof of `[Polymath16wikiR2]` Prop. 7 part 1 does not close: a slip (it gives `ρ_{2η²} = 0`, contradicting its previous sentence; the value is 1) and a gap (its last step, the `(2/3)(1+ω)η²` coset, forces nothing with either value); on `Λ`, (S″) closes it in one line. [hand + tools exact; verifier 1]**
A 2,475-point object, **built by formula** (the coset values the proof forces, written down directly; no search), satisfies every
inequality the proof lists and has no monochromatic edge (26,324 unit-distance pairs checked), failing only through (S) on the
`η²T₀`-cosets. *Proof:* `plans/FS85-V-verification.md` §V5 ("the wiki's final step"); `data/fs85/verifier/prop7_points.py`,
`adversary.py`. *Proof verdict:* closes (a finding about a published proof). *Rests on it:* the repair in dB11; P-wiki's score; the
`BIBLIOGRAPHY.md` note on `[Polymath16wikiR2]`. *Prior art:* the page itself (Tao, 12 June 2018). *Kernel:* declined (a finding about a
document).

**FS85-V7 — Given (S″): every four-colouring of `Cay(Λ, U)` is `1680Λ`-periodic; `F ⊇ 1680Λ`, `P = F`, with no solver certificate. [hand + tools exact; de Bruijn (dB9 + dB11, assembled at his gap-A report); verifier 1 (V), blind and independent]**
*Proof:* dB9 when no coset is residue-type; dB11 when one is. `plans/FS85-V-verification.md` §V; `plans/FS85-C-deBruijn.md` Part 1.
*Proof verdict:* closes given (S″). *Rests on it:* `P = F` on `Λ` by a stripe-coupling mechanism (one of three: row 78's certificate,
this, and the spectrum, C10); superseded in strength by R3b. *Prior art:* Mixon's 2018 question (V2-T8 and row 85 give its scope);
no hand proof of periodicity in print (A3.1–A3.2). *Kernel:* stub, conditional on (S″) as a named hypothesis.

**FS85-V8 — G481 rebuilt from a by-eye transcription of Table 3 has 481 points and 2,814 unit edges, every orbit's degree matching the table (29 of 29); `η^k·G481 ⊂ Λ` exactly for `|k| ≤ 2` (150 points outside at `|k| = 3`, 342 at `|k| = 4`); tree S walks. [tools exact; verifier 1; the placement first by Poros (round 1)'s card C2]**
A one-digit plant changes 11 orbits' degrees and is caught. *Proof:* `plans/FS85-V-verification.md` §C3b (`g481.py`, `treeS.py`);
`chk_g481_rot.py` in `data/fs85/poros-comp/`. *Proof verdict:* closes for what it states. *Rests on it:* (S″) on `Λ` (with IA4). *Prior art:* the graph and trees are `[Parts2020hv]`'s. *Kernel:* declined (with IA1).

**FS85-IA1 — Parts's trees S and L1–L8 are valid refutations of their root colourings: for each tree, no proper four-colouring of the unit-distance graph on its vertices (all in G481) extends its root colouring. [tools exact, on a by-eye transcription corroborated by Tables 2 and 3; the auditor]**
All 880 cells of L1–L8 read by eye (none unreadable; one reading corrected before any walk, none after); a new walker with no code shared
with verifier 1's; Table 2's 45 numbers and Table 3's 261 used-vertex counts reproduced exactly; one plant per tree refused for its
planted reason. **787 non-root nodes in all, 783 in L1–L8** (verifier 1's "776" subtracted S's eleven cells instead of its four non-root
ones). The owner re-ran the walker (ALL WALK) and its plants (ALL REFUSED). *Proof:* `plans/FS85-input-audit.md` A1;
`data/fs85/audit/walk_trees.py`, `data/fs85/audit/trees/`. *Proof verdict:* closes (the walk checks the logic; fidelity matters only at
the roots, IA3). *Rests on it:* IA4. *Prior art:* the trees are `[Parts2020hv]` Table 4. *Kernel:* declined for now; a checker for the
nine trees is a stub candidate (FS-87).

**FS85-IA2 — Lemma G: Parts's root case split (Table 1) is exhaustive: every proper four-colouring of the 13-vertex root graph with the triple {2, 3, 4} monochromatic is, up to colours and one of six G481 symmetries, one of his 36. [hand; the auditor]**
*Proof:* `plans/FS85-input-audit.md` A2. *Proof verdict:* closes. *Rests on it:* IA4. *Prior art:* Parts states the split; its
exhaustiveness is proved here. *Kernel:* declined (with IA1).

**FS85-IA3 — Lemma T: each of the 36 root colourings, under the symmetry the proof names (never searched), restricts vertex by vertex to the root of its tree read in IA1; 19 of the 36 have a monochromatic opposite inner-triangle pair (Parts: 19). [tools exact; the auditor; the owner re-ran it]**
*Proof:* `data/fs85/audit/golomb.py` (plant refused). *Proof verdict:* closes. *Rests on it:* IA4. *Prior art:* Parts's Table 1.
*Kernel:* declined.

**FS85-IA4 — (S) for G481: no proper four-colouring of G481 gives vertices 2, 3, 4 one colour; with V8's placement, (S″) holds on `Cay(Λ, U)`. [tools exact + hand; IA1 + IA2 + IA3 + V8]**
*Proof:* `plans/FS85-input-audit.md` A1–A2. *Proof verdict:* closes; **(S″) is checked here in full** (the trees walked as a certificate,
the root split proved by hand, the placement exact). *Rests on it:* V7, R3b and everything they carry. *Prior art:* `[Parts2020hv]`
(2020), whose program found the trees. *Kernel:* declined (a kernel checker for the nine trees is the route, FS-87).

**FS85-V2-T1 — The input's scope: G481 gives NT₀ only on the five-family graph `Cay(Λ, U_2)`, and NT_k for all `|k| ≤ 2` on `Cay(Λ, U)`. [tools exact + hand; verifier 2]**
Every ℤ-linear map `Λ₅ → Λ` carrying `U_2` into `U_2` is one of the 24 point-group maps, each fixing family 0 up to sign (a control into
all of `U` finds family-moving maps); `η^k·G481 ⊂ Λ` with every edge in `U` for `|k| ≤ 2`, so `η^k·G481` uses families `k−2..k+2`.
*Proof:* `plans/FS85-V2-verification.md` §S (`data/fs85/v2/s_prime.py`, `s_prime_hom.py`). *Proof verdict:* closes for linear
transports (a non-linear homomorphism is neither claimed nor excluded). *Rests on it:* R3a's conditional form (D1); (S″). *Prior art:*
the trees are Parts's. *Kernel:* declined.

## §5. Part 1, the spectral route to `8Λ` (Coxeter, round 2; the round-3 agent; verifier 2; Poros (round 2); the owner)

**FS85-C7 — The spectral lemma: with colours as the vertices of a regular tetrahedron, NT_k ⟺ `A_k g = −2g` for the family-`k` hexagon operator; its symbol `X + 1/X + Y + 1/Y + X/Y + Y/X + 2 = (1+X)(1+Y)(X+Y)/(XY)`; so the colouring's Fourier support lies in `Θ_K = ⋂_{|k|≤K} Z_k` (three circles per family), and a bounded function with finite spectral support is a finite sum of characters, periodic under `P(Θ_K) = ⋂ ker θ` (= verifier 2's FS85-V2-T2). [hand; Coxeter; verifier 2 independently, with the stand-alone finite-support lemma]**
The factorisation is where triangles enter: `1 + ζ₆² = ζ₆`. **Presentation gap closed (V2's D4):** Coxeter's R2.1 item 4 restricts to "a
generic line"; a line separating every character need not exist (the three nonzero characters of `ℤ²/2ℤ²`), and the step closes by
verifier 2's generalised-eigenspace proof (§W1) or by linear independence of `{x^α e(θx)}` across base points — the statement is true.
Poros (round 2) re-derived C7 and the tetrahedron splitting by hand; the owner checked the factorisation by hand. *Proof:*
`plans/FS85-C-Coxeter.md` R2.1; `plans/FS85-V2-verification.md` §W1. *Proof verdict:* closes. *Rests on it:* C8–C10, C15, R3a, R3b.
*Prior art:* Schwartz's point-support theorem; the hexagon count is elementary. *Kernel:* stub-worthy in its finite-quotient form
(the distributional step is not needed on a periodic colouring); declined until a kernel consumer is named.

**FS85-C8 — The character tables: `|Θ_all| = 42` (orders 2 ×6, 4 ×12, 8 ×24), generating exactly the dual of `8Λ`; `|Θ_{−3..3}| = 378` (= `Θ_all + Ann(Λ₇)`, so `24Λ`); `|Θ_{−2..2}| = 7,290`, period exactly `120Λ`; three consecutive families give 27 circles and no period; the six order-2 characters are `λ∘r_𝔭`. [tools exact; Coxeter; reproduced by Poros (round 2), verifier 2 and the round-3 agent; the owner checked the 42]**
The owner (`owner-held/fs85_C8_42.py`): among 8-torsion characters exactly 42 satisfy all nine families, the same 42 satisfy the five
inner ones, and they generate `(ℤ/8)⁴` (Smith invariants [1,1,1,1]); not re-checked by him: that every solution is 8-torsion, and the
7,290. Poros (round 2) scores the 42 as Coxeter's own (an exact solve that cannot be steered by the fence event). *Proof:*
`plans/FS85-C-Coxeter.md` R2.2 (`spectral.py`, `spectral3.py`, `spectral5.py`); `plans/FS85-V2-verification.md` §W2. *Proof verdict:*
closes. *Rests on it:* C9, C10, C15, R3a. *Prior art:* none. *Kernel:* declined (Smith forms).

**FS85-C9 — Theorem R, with its full form (= Coxeter's FS85-C12; = verifier 2's FS85-V2-T6): if NT holds in all nine families, the proper four-colourings of `Cay(Λ, U)` are exactly `c₀ ∘ ρ_ε`, `ε` a prime above 2 (one chirality for all of `Λ`) and `c₀` a striped colouring of the 64-vertex torus `Cay(T₀/8T₀, μ₆ ∪ 3μ₆)`; so they are `8Λ`-periodic and pair-linear, `F = P = 8Λ` (with explicit separators), and there are 9,120 of them, counted with no enumeration. [hand + tools exact; Coxeter; verifier 2 independently; the identification of the chirality with the prime not independent of dB7 (close-inventory item 59)]**
Coxeter: equitable layers, the 42-character support, uniform chirality by tetrahedron splitting (if `G(a) + H(b)` is always a vertex of a
regular tetrahedron then `G` or `H` is constant — re-derived by Poros (round 2) and, a second check, by the owner); `ρ₊(ζ^jη^{2m}) =
ζ^{j+2m}`, `ρ₊(ζ^jη^{2m+1}) = 3ζ^{j+2m+1}`; a striped colouring is proper on `3μ₆` (the "⊇" direction, unconditional); count
`9·512 − 2·24 = 4,560` per chirality. Verifier 2: the stripe lemma derived (V2-T5), pair-linearity, and the count as pair-linear
colourings of `Cay(ℤ[ζ₆]/8, μ₆ ∪ 3μ₆)`: `3·1,536 − 3·24 + 24 = 4,560` (the same inclusion–exclusion, two parametrisations, D11). The 64-point
quotient is dB8's `G₃` (Poros (round 2) confirmed by counting). *Proof:* `plans/FS85-C-Coxeter.md` R2.3, R2.9 (`quot64.py`, `patch.py`);
`plans/FS85-V2-verification.md` §W5. *Proof verdict:* closes given NT in all nine families. *Rests on it:* R3b. *Prior art:* the count is
`[Hubai2018]`'s (ring, computer) and FS-73's census (lattice, certificate); its derivation is ours, twice. *Kernel:* declined (with R3a).

**FS85-V2-T5 — The stripe lemma: under NT₀, every proper four-colouring of the triangular lattice is striped (type O/P wheels; propagation along a diagonal line, then line to line). [hand; verifier 2]**
*Proof:* `plans/FS85-V2-verification.md` §W5 item 3. *Proof verdict:* closes. *Rests on it:* verifier 2's pair-linearity and count (C9's
second derivation); in the agents' chain Parts's human lemma is cited instead. *Prior art:* `[Parts2020hv]` §3's second part (the same
lemma, human-verified there); Gibbs's sketch of 30 May 2018; MASCOT-T10. *Kernel:* **stub — a good small kernel target** (a finite
local lemma plus an induction on lines; FS-87).

**FS85-C10 — Corollary U: from G481 placed in `Λ` (NT for `|k| ≤ 2` on `Cay(Λ, U)`), every four-colouring of de Grey's lattice is `120Λ`-periodic; `F ⊇ 120Λ`, `P = F`, with no solver refusal. [hand + tools exact, given (S″); Coxeter]**
The gap to `8Λ` located: a 3-part (the 81 components of the five-family graph, joined only by families ±3, ±4) and a 5-part (48 order-10
characters on `Λ₅`, exactly the non-chiral ones). *Proof:* `plans/FS85-C-Coxeter.md` R2.4. *Proof verdict:* closes given (S″). *Rests on it:* `P = F` by the spectral mechanism (the third, with row 78's certificate and V7's stripe coupling); R3a's frame. *Prior art:* none for
periodicity. *Kernel:* declined.

**FS85-C11 — Family ±4 is indispensable: the graph on `U_3` has proper NT-respecting four-colourings that are not `8Λ`-periodic. [hand (C5a) + tools exact (`pl5.py`); Coxeter]**
*Proof:* `plans/FS85-C-Coxeter.md` R2.5. *Proof verdict:* closes. *Rests on it:* the necessity of `Λ₇`'s step in R3b. *Prior art:* none.
*Kernel:* declined.

**FS85-C13 — The patchwork restatement: under NT_{±3} the gap to `8Λ` is one finite problem on striped colourings of the 8×8 torus over `(ℤ/3)²`, whose first step (uniform chirality) is proved. [hand; Coxeter]**
*Proof:* `plans/FS85-C-Coxeter.md` R2.10. *Proof verdict:* step 1 closes; step 2 superseded by C15. *Rests on it:* nothing now. *Prior art:* none. *Kernel:* declined.

**FS85-C14 — A no-go of a format: the 54 pair-correlation (second-moment) equalities on `U` do not force the spectrum onto `Θ_all`: an order-12 character `(11/12, 1/2, 7/12, 7/12)` and an order-6 one, weighted `1 : (2√3−3)/3` and averaged over the point group, satisfy all 54 off the 42 characters. So on de Grey's lattice a radius-1 averaged certificate cannot lift `120Λ` to `8Λ`. [hand + tools exact (the witness); one float probe (uncertified); Coxeter; verified exactly by Poros (round 2), `chk_r2c1.py`]**
The float probe (HiGHS) adds `R(v) ≥ −1/3` on the second neighbourhood and agrees; it is a derived-shape LP not read back as an identity,
so it is uncertified and nothing rests on it. *Proof:* `plans/FS85-C-Coxeter.md` R2.11. *Proof verdict:* closes for radius 1. *Rests on it:* G73's averaged format narrowed on `Λ`; Poros (round 2)'s 0.4 hunch killed. *Prior art:* none. *Kernel:* declined.

**FS85-C15 — The alternate-triple lemma (= verifier 2's FS85-V2-T4, stronger: no properness needed): if the colouring's frequencies lie in `Θ_all` shifted by the characters of an odd-index sublattice `Λ_K = ⟨U_K⟩`, then on each coset of `Λ_K` it agrees with an `8Λ`-periodic tetrahedron-valued function with spectrum in `Θ_all`, equitable in every family at every point; so a family whose alternate triples each lie in one coset of `Λ_K` has NT. Hence NT for `|k| ≤ 3` gives NT_{±4}, and 24Λ-periodicity gives NT_{±3}. [hand + tools exact; Coxeter; verifier 2 independently (two routes to `Λ₇`: the computed `Θ₇ = Θ_all`, and a no-computation argument that `sin 2πt` at an eighth is never `±√3/2`)]**
The owner's check (`owner-held/fs85_C15_cosets.py`): `[Λ : Λ₇] = 9` (invariants 1,1,3,3), `[Λ : Λ₅] = 81` (3,3,3,3), both odd; families ±4's
even and odd triples each in one coset of `Λ₇`, families ±3's in one coset of `Λ₅`; controls `η⁴ ∉ Λ₇`, `η³ ∉ Λ₅`. *Proof:*
`plans/FS85-C-Coxeter.md` R2.12 (`patch2.py`, `alt.py`, `alt2.py`); `plans/FS85-V2-verification.md` §W4. *Proof verdict:* closes. *Rests on it:* R3b (NT_{±3} over `Λ₅`, NT_{±4} over `Λ₇`). *Prior art:* none. *Kernel:* declined (with R3a).

**FS85-R3a — The 5-part lemma, in its conditional form (V2's D1; = verifier 2's FS85-V2-T3): if NT holds for `|k| ≤ 2`, every proper four-colouring of the five-family graph `Cay(Λ, U_2)` is, on each of its 81 components `y + Λ₅`, a function of `x mod P_ε` for one chirality `ε` (so `8Λ₅`-periodic), hence `24Λ`-periodic; with (S″), every proper four-colouring of `Cay(Λ, U)` is `24Λ`-periodic. [hand + tools exact; the round-3 agent; verifier 2 independently and blind, by a route differing in the residue collapse]**
Route (round 3): `Λ/40Λ = Λ/P₊ × Λ/P₋ × Λ/5Λ`; each order-10 character is an order-2 character at one prime plus a 5-part, so on a
component `g = A(X, b) + B(Y, b)`; tetrahedron splitting slice by slice; one chirality per component by an edge; the dichotomy by Fourier
disjointness of the three pair indices' 5-parts; the residue case by plane complementarity within one prime (`dim Π_i + Π_j = 4`), a
two-line lemma for `±1` functions on `𝔽₅ⁿ`, and 5 being odd. Verifier 2's: the non-residue case needs no properness (D5); in the residue
case the colour-position functions are already `±1`, so the two-line lemma plus full nonzero support on `ℤ/5` suffices with no plane
complementarity (D6); both routes kept. **Plane complementarity, three checks:** `split.py` F5; the owner (`fs85_R3_planes.py`: each
prime's three planes pairwise span `𝔽₅⁴`); verifier 2 (within each prime the three planes meet pairwise only in 0; across primes 3 of
the 9 pairs meet in a line). **What is not established (D1):** the unconditional claim that "the five-family graph alone" forces the
lemma — G481 gives only NT₀ there (V2-T1) — and so R3's answer to Coxeter's R2.12 item 3 ("the five inner families alone kill the
5-part") stands only in the conditional form; the unconditional consequence is on `Cay(Λ, U)`. *Proof:* `plans/FS85-R3-five-part.md` §1
(`data/fs85/r3/split.py`, F0–F6, four plants); `plans/FS85-V2-verification.md` §W3 (`w3_facts.py`, six plants). *Proof verdict:* closes
in the conditional form. *Rests on it:* R3b. *Prior art:* [FS-86's gate: the product step is the vector form of `[GodsilEtAl2020]` Cor. 4.4 — a uniquely vector-colourable `G` times a connected `H` of larger vector chromatic number is uniquely vector colourable — and `[Zhang2012]` Thm 1.8(i) in the colouring form] none found (the CRT slicing, the two-line lemma and the Fourier disjointness are
this milestone's). *Kernel:* declined for now (F0–F7 are small exact tables; the Fourier steps need finite Fourier analysis on
`Λ₅/40Λ₅`).

**FS85-R3b — The theorem: every proper four-colouring of de Grey's lattice `Cay(Λ, U)` is `8Λ`-periodic, local at one prime above 2 (one chirality for all of `Λ`), pair-linear and striped on every `T₀`-coset; `F = P = 8Λ`; there are exactly 9,120 — from Parts's trees by derivation, with no solver refusal of ours (= verifier 2's FS85-V2-T7, the theorem W). [hand + tools exact, given (S″), with (S″) checked here in full (IA1–IA4, V8); two independent derivations: the agents' chain and verifier 2's]**
The agents' chain: C7 → C8 → C10 (`120Λ`) → R3a (`24Λ`) → C15 over `Λ₅` (NT_{±3}) and over `Λ₇` (NT_{±4}) → C9 (Theorem R). Verifier 2's W:
V2-T1 → C7 (V2-T2) → R3a (V2-T3) → C15 (V2-T4) → the stripe lemma (V2-T5) → the collapse and the count (V2-T6), every C1 verdict written
before any agent's proof was opened; no divergence of truth on any statement, twelve of scope, notation and route (D1–D12). Row 78's
2,044-point certificate is **not used**; FS-73's census is not used. *Proof:* `plans/FS85-R3-five-part.md` §1; `plans/FS85-V2-verification.md`
§W. *Proof verdict:* closes given (S″). *Rests on it:* row 85; row 78's `F ⊇ 8Λ` can cite a derivation in place of its certificate;
FS-74's question (why is every four-colouring `8Λ`-periodic?) answered; Mixon's 2018 question at its exact scope (V2-T8). *Prior art:*
the value and the count are `[Hubai2018]`'s (the ring as his computation uses it, by computer, 2018) and FS-73's (the lattice, by
certificate); the forced pair at `8/3` is Harder's; Gibbs announced a hand route from "no monochromatic triangle" to period 16 on `R₂` on
3 June 2018 and dropped it for want of the input (A3.1); Tao's Cor. 9 stops one step in; the input is Parts's (2020). No hand proof of
periodicity for the ring or the lattice was found in print (A3.1–A3.2, 39 zbMATH queries). *Kernel:* declined as a whole for now; the
stubs are V2-T5, dB9's V1 and dB11 (FS-87), and W as a conditional theorem with (S″) a named hypothesis.

**FS85-V2-T8 — The literal ring `ℤ[ω₁, ω₃] = ℤ[ζ₆, η²]` is not closed under conjugation: `ω₃ = (2 + w)/3` with `(2 + w) = 𝔭₃²` for one prime above 3 of `ℚ(√−11)`, so every element of the ring is `𝔭₃`-integral and `ω̄₃ = ω₃⁻¹ ∉` it; it contains no odd family `η^{odd}` and is not a union of `Λ`-cosets. [hand; verifier 2]**
*Proof:* `plans/FS85-V2-verification.md` §C3. *Proof verdict:* closes. *Rests on it:* the scope of R3b's answer to Mixon's question: it
holds for every point set `X` with `X + Λ = X` whose unit vectors include `U` — in particular the ring closed under rotation by `η^{±1}`, as
Hubai's computation uses it — and not for the literal ring; nor does it give Mixon's follow-up (finitely many colourings of the ring).
*Prior art:* Tao's 2018 query whether `V ⊂ R₂` is the same concern. *Kernel:* declined.

## §6. Round-2 observations about quotients (Poros (round 2); the owner)

**FS85-L16 — G54's middle case, observed: `Cay(Λ/16Λ, U mod 16)` (54 distinct generators) is slack at four colours, `λ_min = −18.883106 < −18`, yet every one of its four-colourings is gap-free (it pulls back from the tight `Λ/8Λ`). [tools exact for the spectra; the gap-freedom by R3b (given (S″)) or by row 78's certificate; Poros (round 2); the owner]**
A four-colouring of `Λ/16Λ` pulls back to a `16Λ`-periodic colouring of `Λ`, which is `8Λ`-periodic (R3b; row 78), hence a colouring of
the tight quotient, where every colouring is balanced and gap-free (Hoffman's equality case). The owner (`owner-held/fs85_L16_slack.py`):
mod 8, 36 generators, `λ_min = −12 = −d/3`, tight; mod 16, 54 generators, `λ_min = −18.883106`, slack. *Proof:* close-inventory item 55.
*Proof verdict:* closes. *Rests on it:* G54 rewritten (slackness permits gaps and does not supply one; the sign of `λ_min + d/(k−1)` does
not classify forcing). *Prior art:* the equality case is Blokhuis–Brouwer–Haemers's; the observation is ours. *Kernel:* declined.

## §7. Conjectures and readings this milestone stated and did not prove (the close's sweep)

- **Coxeter's R2.6 reading** [reading]: in a triangle-free lattice the analogues of the hexagon circles `Z_k` are generically non-torsion,
  so the spectral mechanism cannot rigidify there. Killing test: a triangle-free lattice whose NT-type linear identity pins the spectrum
  onto a finite torsion set. → FS-59's and FS-86's stubs.
- **H5, the dyadic tight target** (Poros (plan), held until the competition ended; now public) [reading]: over ℚ(√59), ℚ(√83), ℚ(√131)
  (`d ≡ 11 (mod 24)`, 7 not usable) the only four-colour residue target is the inert dyadic `K₄`, Hoffman-tight at four colours, so G54's
  reading predicts a non-zero `P` of full rank at some 2-adic depth on rich lattices — triangle-free four-colour rigidity in `𝒰^tf`,
  never chainable (FS79-T2). Falsifier: an exact Smith-form derivation that the dyadic tower forces nothing on some rich lattice there, or a
  gapped four-colouring from a target H5 missed. → FS-86.
- **H6** [derived, unwritten as a theorem]: row 66 frees every pair over a field with a usable 3 or 7 or a ramified dyadic prime, so in
  `𝒰^tf` only two arithmetic types stay open: (A) wall-broken with no small gapped plane (ℚ(√47), ℚ(√167)); (B) wall-standing with the
  inert dyadic `K₄` and 7 not usable (ℚ(√59), ℚ(√83)). → FS-86.
- **Poros (round 2)'s product reading** [reading, confirmed in shape by R3a]: the 5-part gap is a sparse product of the tight 2-adic quotient
  with the non-four-colourable mod-5 torus, the Greenwell–Lovász shape (FS-67's three-colour form at four colours). → FS-67.
- **de Bruijn's reading** [numerical]: no orbit weighting of the five orbits makes the infinite lattice Hoffman-tight (best ≈ 0.287 against
  1/4, a Nelder–Mead probe, logged as a borderline search), so `F ⊇ 8Λ` is not spectral on `Λ`. Consistent with R3b, which is pointwise.
- **Gap B** (from `1680Λ` to `8Λ` through the quotients' tightness) — moot after R3b; declined.
- **The unconditional five-family form of R3a** (D1): does `Cay(Λ, U_2)` alone force `24Λ`-periodicity? Open; declined as a stub (nothing
  rests on it).
- **Mixon's follow-up**: does the literal ring have finitely many four-colourings? Open. → FS-88.
- **The abstract "yes" and Zhu's conjecture**: dB2 is consistent with `χ ≤ |D|`; nothing more claimed. Declined.
