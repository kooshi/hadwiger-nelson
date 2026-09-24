# FS-85 stage C — Coxeter's working file

*Only writer: Coxeter. Poros may read this file and nothing else in this directory. Started 2026-09-24 21:05 UTC.*

## State (a fresh agent resumes from here)

- **Round 1 report sent to the owner 2026-09-24 (~23:30 UTC).** Claimed: K4 at the abstract scope (§2.1). Part 1: structure
  theorem C5 (§4.1) — (PL) ⟹ `F = 8Λ`, chirality, Hubai's extension statement, by linear algebra; (PL) itself rests on the census.
- Context at the report ≈ 470k total (≈ 310k working): **a successor should take round 2** (the owner replaces above 500k).
- **Round 2's one open target: derive (PL)** — the pair index of every proper four-colouring of `Cay(Λ, U)` is a homomorphism —
  with no case analysis found by search. Inputs allowed: Parts's stripes on every layer of families `|k| ≤ 2` (prior art, ruling 4),
  the rainbow-triangle / square-parity edge-type formalism (§4.3: colours = `𝔽₂²`, each edge has one of three types, every unit
  triangle has one edge of each type, every cycle has each type with the cycle's length parity), and a relation tying three layer
  families (`3η − 3η̄ = 2ζ − 1`). Killing test for any local argument: `F(t) + G(s)` on `Tri □ Tri` (§4.2) must survive it.
  Negative already known: `Cay(Λ, U)` is **not** Hoffman-tight at four colours (symbol minimum ≈ −22.41 < −18 on the torus,
  `tools/spectrum.py`), so G54's tight mechanism cannot give (PL).
- Tools (all in `tools/` here): `efield.py` (exact `E`), `task0.py`, `census.py`/`fast.py` (read the committed census),
  `part2_rank1.py`, `part2_circulant.py`, `pairlinear.py` (C5b), `pairlinear3.py` (C5 ⊆ check), `plconsequences.py`, `spectrum.py`.

## §1. First route (written before any message to Poros, 2026-09-24 ~16:10)

**Order: Part 2 first, briefly, because I believe it collapses; then Task 0; then Part 1, which is where the week's work is.**

**Part 2, first route — the abstract class is the wrong class.** For any finite graph `H` and any integers `n_i` (one per vertex),
the distance graph `G(ℤ, D)`, `D = {|n_i − n_j| : ij ∈ E(H)}`, contains `H` at the points `n_i`; so any pair `(u, v)` that every
four-colouring of `H` identifies is identified, at *every* translate `x + n_u, x + n_v`, by every four-colouring of `G(ℤ, D)`:
`n_v − n_u ∈ F₄`. Translation invariance is free. Choose `n_i ≡ f(i) (mod 4)` for a proper `ℤ/4`-colouring `f` of `H` (so `x mod 4`
four-colours `G(ℤ, D)`), and the rest of `n_i` super-increasing (so every short relation among the `D` is a relation among edge
vectors `e_i − e_j` of `H`, i.e. a cycle of `H`: triangle-free `H` gives sum-free `D`). With `H` = a triangle-free five-critical graph
minus an edge (Mycielski), this is a **rank-1** member of `𝒞^tf₄` with `F₄ ≠ 0`. So S2 on `𝒞^tf₄` is "yes" at every rank, trivially,
and K3 in rank 1 is false; the content of S2 is entirely the unit-distance class `𝒰^tf`, where by compactness it is exactly the
existence of a finite triangle-free unit-distance *four-colour forcer* — which one spindle turns into a five-chromatic unit-distance
graph, i.e. it sits next to Soifer's Open Problem 55.1. Expected by-product: the same generic embedding into `ℤ/N` answers
Klotz–Sander Problem 3.6 at every `k ≥ 3` from any triangle-free uniquely `k`-colourable graph (Nešetřil) — to be gated for prior
art before any claim.

**Part 1, first route — kill the monochromatic √3-triple, then use Parts's striping lemma on each coset.** Every coset `z + T₀`
induces a triangular lattice; `[Parts2020hv]`'s lemma (MASCOT-T10) says a four-colouring of the triangular lattice with no
monochromatic √3-triple (three alternate neighbours of one vertex) is striped in the pinned form. It is a statement about the
*smaller* graph `ℤ[ζ₆]`, so it transfers to every coset of `Λ` for free. What must be proved on `Λ` is Parts's computer part: **no
four-colouring of `Cay(Λ, U)` has a monochromatic √3-triple.** Plan: a monochromatic triple `{c+1, c+ω, c+ω²}` (colour `a`, centre
colour `b`) with the Moser twist `ρ = η²` (it moves a √3-vector by a unit vector) gives unit edges from the triple's points to
rotated copies; the rhombus-tip compulsions of the triangles around the triple, transported by `η^k`, should close a contradiction
in a bounded number of cosets. Record for each step whether it uses a unit triangle or the reduction to `𝔽₄`. Then the coupling
between cosets (chirality) from the 48 single-matching generators, and `8Λ` from the stripe phases' constraints (stripe period 2
along the row, phase sequence forced 8-periodic).

Alternative first route kept in reserve for Part 1: the wiki's renormalised colouring `ρ_z(a) = c(z+a) + a` and its Props 6–7, if
Task 0 says every vector they use lies in `Λ`.

## §2. Part 2 — derivations

### §2.1 The free embedding (FS85-C1) — the abstract class answers "yes" at every rank, including rank 1

**Theorem C1 (free embedding).** Let `H` be a finite graph, `k ≥ 2`, `f : V(H) → ℤ/k` a proper colouring, and put
`n_i = f(i) + k·K·B^i` (`i` running over `V(H) = {0, …, n−1}`) with `B ≥ 7` odd and `k·K > 6(k−1)`. Let
`D = {|n_i − n_j| : ij ∈ E(H)}` and `G = Cay(ℤ, ±D)` (restricted to `⟨D⟩`). Then:
1. `x ↦ x mod k` is a proper `k`-colouring of `G` (every `d ≡ f(i) − f(j) ≢ 0`);
2. `H` is a subgraph of `G` on the points `n_i`, so `χ(G) = χ(H)` when `χ(H) = k`;
3. **every triangle of `G` comes from a triangle of `H`**: a triangle is `d₁ + d₂ = d₃` in `D`, i.e. a relation
   `Σ c_i n_i = 0` with `c = e_a − e_b + e_c − e_d − e_e + e_f` (`|c_i| ≤ 3`, `Σ|c_i| ≤ 6`); `|Σ c_i f(i)| ≤ 6(k−1) < kK` forces
   `Σ c_i B^i = 0`, and balanced base-`B` digits of size `≤ 3 < B/2` are unique, so `c = 0` formally, i.e. three edge vectors
   `e_x − e_y` of `H` sum to zero — a triangle of `H`;
4. **every pair forced at `k` colours in `H` gives a translation-invariant period**: if every `k`-colouring of `H` has
   `g(u) = g(v)`, then for any `k`-colouring `c` of `G` and any `x`, `i ↦ c(x + n_i)` is a `k`-colouring of `H`, so
   `c(x + n_u) = c(x + n_v)`; hence `n_v − n_u ∈ F_k(G)`.
*Proof:* the four items. *Grade:* [hand; exact check of the instance below]. *Translation invariance is free.*

**Instance (FS85-C1a).** `H = M(M(C₅)) − {21, 22}` (the Mycielskian of the Grötzsch graph, 23 vertices, minus the edge joining
its apex 22 to vertex 21, the shadow of the Grötzsch apex); `χ(M(M(C₅))) = 5` by Mycielski (1955), and `H` is four-coloured by the
formula `f` = (a 3-colouring of `C₅`, copied to shadows, apexes and vertex 21 coloured 3), so every four-colouring of `H` has
`c(21) = c(22)`. With `k = 4, K = 5, B = 7`: `|D| = 70`, `gcd(D) = 1`, `D` sum-free, all `d ≢ 0 (mod 4)`, `max D ≈ 7.8·10¹⁹`,
`δ = n₂₂ − n₂₁ ≈ 6.7·10¹⁹`. So **`G(ℤ, D)` is a rank-1 member of `𝒞^tf₄` with `F₄ ∋ δ ≠ 0`**; in rank 1 this means `F₄` has
finite index and `G(ℤ, D)` has only finitely many proper four-colourings, every one `δ`-periodic.
Checker: `tools/part2_rank1.py` (asserts triangle-freeness of `H`, properness of `f`, sum-freeness of `D`, `D mod 4 ∌ 0`).
*Scope:* `𝒞^tf₄`, rank 1 — the abstract scope. Not realised in `𝒰^tf`.

**Consequences for the challenge as posed.**
- S2 on `𝒞^tf₄` is **yes at every rank ≥ 1**; the arithmetic-free class carries no content. K3 "for a class containing all of
  rank-1 `𝒞^tf₄`" is **false**; P-rank1 (a rank-1 "no") is **refuted**; §0.3's rank-1 record (`max D ≤ 14`, `|D| ≤ 5`) measured its
  range exactly as flagged — the smallest forcer this construction uses has 22+ vertices (a triangle-free 5-chromatic graph).
- The plan's §0.2 located Part 2's content in "translation invariance, then realisability". Translation invariance costs nothing.
  **All of Part 2's content is realisability**, i.e. `𝒰^tf`.

### §2.2 By-product (FS85-C2): Klotz–Sander 2017, Problem 3.6 — Bašić's negative answer (k = 3) extended to every k ≥ 3, with an explicit circulant at k = 4

*Wording corrected on Poros's review (2026-09-24): 3.6 is one yes/no question, already answered NO by Bašić at three colours; C2 is an extension, and stays a prior-art debt (Bašić §4 unread; one-paragraph constructions are often folklore).*

Problem 3.6 (read in the paper, `ks.txt` l. 325, Ars Math. Contemp. 12 (2017) 155–165): *"Is necessarily χ(G) = ω(G) for every
circulant uniquely colorable Cayley graph?"* Bašić (arXiv:2609.03184, 2026) answered it at three colours.
**Theorem C2.** With C1a's `D`, `N = 4q`, `q` the least prime above `3·max D/4` not dividing `δ/4` (`q = 58647315699084919633`),
the circulant `Cay(ℤ/N, ±D)` is triangle-free (`ω = 2`), and **uniquely four-colourable**, its colour classes the residues mod 4.
*Proof:* triangle-free as C1 item 3, since `3·max D < N` makes every `±d₁±d₂±d₃ ≡ 0 (mod N)` an integer relation. `x mod 4` is
proper. For any four-colouring `c`, each translate `x + {n_i}` carries a colouring of `H`, so `c(x + n₂₁) = c(x + n₂₂)`: `c` is
`δ`-periodic, and `gcd(δ, N) = 4` makes `⟨δ⟩ = 4ℤ/N`; so `c` factors through `ℤ/4`, whose quotient graph is `K₄` (`D mod 4` hits
1, 2, 3), so `c` is a bijection of `x mod 4`. ∎ *Grade:* [hand + exact check, `tools/part2_circulant.py`]. The same recipe with
the `(k+1)`-critical triangle-free Mycielski graph minus an edge answers it at every `k ≥ 3`, and with high-girth critical graphs
at every girth. *Prior art:* zbMATH (`ti:"uniquely colorable" & ab:circulant`; `ab:"uniquely colorable" & ab:"Cayley graph"`)
returns only Klotz–Sander and Bašić; OpenAlex lists 4 citing works of Klotz–Sander (orthogonal colourings 2020, strong cliques
2020, clique-partitioned graphs 2022, game chromatic 2021), titles only, none opened yet — **a debt before any claim**.

### §2.3 What is left of Part 2: `𝒰^tf`, and its price (FS85-C3)

**Claim C3 [hand; the genericity step a sketch].** (a) By compactness, a member `Cay(Λ, S)` of `𝒰^tf` has `δ ∈ F₄` iff some finite
subgraph `H` (triangle-free) has every four-colouring identifying `0` and `δ`. (b) Chaining `m ≥ 3` copies of such an `H` by
generic plane rotations about successive chain points, closed by one unit edge, gives a five-chromatic unit-distance graph with no
triangle (a triangle would need a common neighbour of the two ends of the closing edge; generically the copies meet only at chain
points). (c) Conversely a triangle-free five-chromatic unit-distance graph, minus an edge of a 5-critical subgraph, is a
triangle-free four-colour forcer. **So "some finite triangle-free unit-distance graph has a four-colour forced pair" is equivalent
to Soifer's Open Problem 55.1 (a triangle-free five-chromatic UDG), modulo the genericity sketch; a K4 in `𝒰^tf` answers 55.1.**
(Poros reached the same calibration independently.) Price every `𝒰^tf` "yes" at Soifer strength.
*Gap named by Poros (2026-09-24): (b)'s triangle-freeness reason is incomplete — triangles can also form among non-chain vertices of
different copies; each is an algebraic condition on the angles, which lie on the closing constraint surface, so genericity must be
argued on that surface. Still a sketch; to be written before any Soifer claim.*

## §3. Task 0 — the transfer check (done 2026-09-24, exact; `tools/efield.py`, `tools/task0.py`)

- **FS85-A1 re-verified exactly** (own arithmetic on the `O_E`-basis `1, ζ, w, ζw`): `9η = (−3,6,3,−6)`, `9η² = (6,0,3,0)`,
  `9η³ = (−5,10,2,−4)`, `9η⁻³ = (3,−6,2,−4)`, `9η^{±4}` integral, `η^{±5}, η^{±6}` not in `Λ` (control fires: `9η⁶ = (−13/3,0,16/3,0)`).
  `U = {ζ^j η^k : |k| ≤ 4}` equals the committed 54 vectors; `⟨U⟩ = Λ` (HNF index 1). `η = (2ζ−1)(1−w)/3 = i·w̄/√3`, and
  **`η − η̄ = i/√3 = (2ζ−1)/3`**.
- **FS85-A2 re-verified exactly**: (8) and (9) hold with `ω = ζ₆` and fail with `ω = e^{2πi/3}`.
- **Wiki Lemmas 1, 3, 4, Cor. 5, Prop. 6:** use only `T₀` and the six Eisenstein units — transfer to every coset.
- **Wiki Prop. 7 (all three parts), Cor. 8, Cor. 9:** all 11 coset representatives `bη²` it uses lie in `Λ` (incl.
  `(2/3)(1+ω)η²` and `(2/3)(1−ω²)η²`); all 23 unit-edge inequalities are edges of `Cay(Λ, U)` (listed with their vectors
  `ζ^j η^k`, `|k| ≤ 3`); its symmetries (translation by `Λ`, rotation by `ζ`, conjugation, compactness limits of translates) are
  automorphisms/limits within `Cay(Λ, U)`. **P-wiki wins: Prop. 7 runs on `Λ`.** Scope note: Prop. 7 needs `ρ_{z₀}` constant (the
  residue-type colouring on one coset); it propagates `2T₀`-periodicity over `T₀ + η²T₀` (the Moser sublattice, index 729 in `Λ`).
- **Parts's striping lemma** (triple-free ⟹ striped): on `T₀` — transfers. His computer part: Poros reports (exact check, his
  message of 2026-09-24) that `G481` lies in `Λ` with edges `μ₆·η^{−2..2} ⊂ U`, so "no monochromatic √3-triple" is TRUE on `Λ` — by
  his coloring trees (case analysis), i.e. K1 by prior art under ruling 4.
- **Hubai's five-rotation word:** a statement about the ring `R₂` under the chirality hypothesis; its intermediate points leave `Λ`
  (row 78: `8/3` transports only to rank 2) — does not transfer as a proof.

**Reformulation found in Task 0 (FS85-C4) [hand + census read].** On one coset, "striped in direction `ζ^j`" is exactly
"`c(y + 2ζ^j) = c(y)` on that coset" (period 2 along the row, and the adjacent row is then forced onto the complementary pair by
the two edges `ζ` and `ζ − 1 = ζ²`). **So stripes in a common direction on every coset ⟺ `2ζ^j ∈ Per(c)`.** Read from the
committed census (not recomputed): every one of the 380 pinned colourings has exactly one period among `2, 2ζ, 2ζ²`, except the two
residue colourings, which have all three (126/126/126/2). K1's target restated: **every proper four-colouring of `Cay(Λ, U)` has
a period `2ζ^j`.**

## §4. Part 1 — derivations

### §4.1 The structure theorem: every four-colouring of de Grey's lattice is *pair-linear* (FS85-C5)

**Definitions.** Identify the four colours with `𝔽₂²` by a bijection `β`. A colouring `c` is **pair-linear** if `c(z) = β(π(z), σ(z))`
with `π ∈ Hom(Λ, 𝔽₂)` a group homomorphism — the *pair index*: which of two complementary colour pairs `z` wears — and
`σ : Λ → 𝔽₂` arbitrary.

**Lemma C5a (properness of a pair-linear colouring) [hand].** With `U₀ = U ∩ ker π`: `c` is proper iff `σ(z + u) = σ(z) + 1` for
every `u ∈ U₀` and every `z`. (An edge `u` with `π(u) = 1` joins different pairs, so is proper for free.) Hence `σ` is, on each
coset of `L₀ = ⟨U₀⟩`, an affine function with linear part the **parity character** `ℓ : L₀ → 𝔽₂`, `ℓ(U₀) = 1` — which must exist
(every integer relation among `U₀` has an even coefficient sum) — plus an arbitrary offset per coset: `σ = ℓ̃ + h∘κ`,
`κ : Λ → Λ/L₀`, `h : Λ/L₀ → 𝔽₂` free.

**Lemma C5b (the admissible pair indices) [exact integer linear algebra, `tools/pairlinear.py`; no search].** Of the 15 non-zero
`π ∈ Hom(Λ/2Λ, 𝔽₂)`, exactly **six** admit a parity character: two for each Eisenstein direction `ζ^j` (`π(ζ^j) = 0`, the other
two Eisenstein units `π = 1`). For each: `|U₀| = 18` (one antipodal pair `±u_k` in each of the nine layers `η^k T₀`), **`Λ/L₀ ≅ ℤ/8`**
(cyclic), `ℓ` exists (the relation lattice's sum-gcd is 2), and **`ℓ(8Λ) = 0`**. The other nine fail: `|U₀| = 30`, some relation
among `U₀` has odd coefficient sum (sum-gcd 1) — three of them also put a whole unit triangle in one pair.

**Theorem C5 (classification) — two halves of different grade.**
- **(⊇) [hand + exact linear algebra; no census, no solver].** Every pair-linear colouring with one of the six `π` and any
  `h : ℤ/8 → 𝔽₂` is a proper four-colouring of `Cay(Λ, U)`, and it is `8Λ`-periodic (`8Λ ⊆ L₀`, `ℓ(8Λ) = 0`, `π(8Λ) = 0`). Count:
  `6 × 24 × 2⁸ / 4` minus the residue overlaps `= 9216 − 96 = 9120`; pinned at `(0, 1, ζ)`: `6 × 64 − 4 = 380`.
- **(⊆) [measured: equality with the committed census].** Built from the linear algebra and compared with FS-73's 380 pinned
  colourings (re-pinned at the same triangle): **the two sets are equal** (`tools/pairlinear3.py`). So *every* four-colouring of
  `Cay(Λ, U)` is pair-linear — **as a theorem this half rests on FS-73's certificate (`F ⊇ 8Λ`, one solver refusal) plus the
  finite enumeration of `Λ/8Λ`**. Call the statement **(PL)**: *the pair index of every proper four-colouring of `Cay(Λ, U)` is a
  group homomorphism.*

**Consequences, each exact linear algebra given (PL) (`tools/plconsequences.py`):**
1. **`F = 8Λ` exactly.** For fixed `π` the translations preserving every colouring are `K_π = ker ℓ` (index 16 in `Λ`); the
   intersection of the six `K_π` is `8Λ` (one element of `Λ/8Λ` survives: 0). *So FS-73's certificate is replaced by (PL): **(PL) ⟹
   F ⊇ 8Λ** by linear algebra, and conversely `F = 8Λ` + census ⟹ (PL).*
2. **Hubai's stripes, on `Λ`:** in each layer `η^k T₀` the stripe direction is `u_k ∈ U₀` — one direction per family, global
   (`π(ζ^j η^k)` has exactly one zero among `j = 0, 1, 2` for each `k`); on `T₀` the direction is `ζ^{j}` with `π(ζ^j) = 0`.
3. **Hubai's "any stripe pattern periodic by 8 extends in exactly two ways":** `L₀ + T₀ = Λ`, so `κ(T₀) = ℤ/8` and the restriction
   to `T₀` (the phase sequence) determines `h` completely; the "two ways" are the two admissible `π` for the direction.
4. **The chirality on `Λ` (Hubai's, stated here without the ring):** for each admissible `π`, `(η² − ζ^{2ε}) T₀ ⊆ K_π` with
   `ε = +1` for one of the two `π` of a direction and `ε = −1` for the other; hence **`c(p + η² v) = c(p + ζ^{2ε} v)` for every
   `p ∈ Λ`, `v ∈ T₀`, every colouring with that `π`** — rotation by the Moser twist acts on colours as rotation by `±120°`, the same
   sign at every centre. No Eisenstein multiplier `m` has `(η − m) T₀ ⊆ K_π`: the odd layers carry no such rule.
5. The period groups of the census (`Λ/Per ≅ ℤ/2 × ℤ/8` for generic `h`, smaller for special `h`) are `Λ/K_π` and its quotients.

**What this does to the challenge.** Part 1's content is **(PL)** and nothing else: everything Hubai described, `8Λ` included, is
linear algebra over (PL). **(PL) is not derived here.** Parts's trees (prior art, ruling 4) give stripes on each layer of families
`|k| ≤ 2` (Poros's transfer check); stripes on layers do not by themselves give (PL): see §4.2.

### §4.2 A negative, recorded so it is not rediscovered: two families of striped layers do not force a common pair (FS85-C6) [hand]

On `Tri □ Tri = Cay(T₀ ⊕ T₀, {(ζ^j, 0), (0, ζ^j)})` (in `Λ`: `P + T₀ + ηT₀`), `c(t, s) = F(t) + G(s)` (colours in `𝔽₂²`) is proper for
**any** proper colourings `F`, `G` of the triangular lattice; with `F`, `G` striped of *different* pair types, every horizontal and
every vertical layer is striped but no global pair type exists. So (PL) is not a two-layer fact: it needs the relations among at
least three layer families (e.g. `3η − 3η̄ = 2ζ − 1`, which ties the layers `k = 1, −1, 0`). Consistent with FS79-T37 ("a many-layer
effect"). *Killing test of any proposed local proof of (PL): it must fail on `F(t) + G(s)`.*

### §4.3 Where triangles enter (the brief's question), as far as C5 goes
- C5a, C5b, (⊇) and every consequence use **no triangle and no reduction to `𝔽₄`**: they are statements about a functional `π`, a
  parity character `ℓ` and `Λ/L₀`. The residue map enters only as the two special colourings (all three directions admissible).
- Triangles enter C5b's *exclusion* of nine functionals only through parity: three put a unit triangle inside one pair; the other
  six excluded ones fail the parity character (an odd relation among `U₀`).
- (PL) itself — the load-bearing step — is where the triangles must enter: on a rainbow-triangle layer, "pair-linear" and "striped"
  coincide (every unit triangle has one edge inside each of the three partitions), so (PL) = stripes on every layer + a global
  pair type + one direction per family. The controls: `ℤ[ζ₆]` alone has non-pair-linear four-colourings (any non-striped one), so an
  account of (PL) that works on one layer proves too much; C6 shows two layers are not enough either.

## Theorems this phase proved
- **FS85-C1** (free embedding; rank-1 `𝒞^tf₄` member with `F₄ ≠ 0`, instance C1a). [hand + exact check] §2.1, `tools/part2_rank1.py`.
- **FS85-C2** (Klotz–Sander 3.6 negative at four colours: an explicit triangle-free uniquely 4-colourable circulant). [hand + exact
  check; prior-art gate partial] §2.2, `tools/part2_circulant.py`.
- **FS85-C3** (`𝒰^tf`-yes ⟺ Soifer 55.1 modulo genericity). [hand; genericity a sketch] §2.3.
- **FS85-C4** (stripes in a common direction ⟺ `2ζ^j ∈ Per(c)`). [hand] §3.
- **FS85-C5a** (pair-linear properness ⟺ parity character on `U₀`). [hand] §4.1.
- **FS85-C5b** (exactly six admissible pair indices; `Λ/L₀ ≅ ℤ/8`; `ℓ(8Λ) = 0`). [tools exact] §4.1.
- **FS85-C5 (⊇)** (every admissible pair-linear colouring is proper and `8Λ`-periodic; 9120 of them). [hand + tools exact] §4.1.
- **FS85-C5 (⊆)** (every colouring is pair-linear, (PL)). [measured: equal to the committed census; rests on FS-73's certificate] §4.1.
- **FS85-C5 consequences 1–4** ((PL) ⟹ `F = 8Λ`; stripes per family; "extends in exactly two ways"; chirality on `Λ`). [tools
  exact, given (PL)] §4.1.
- **FS85-C6** (two striped layer families do not force a common pair type: `F(t) + G(s)`). [hand] §4.2.
- Task 0: FS85-A1, A2 re-verified [tools exact]; Prop. 7's 11 representatives and 23 edges in `Λ`/`U` [tools exact]. §3.

## Retractions
- 0 retractions of claims. Two internal slips caught before any claim, recorded: (1) a slow trial-division primality loop
  (stopped, verified gone by `ps`, replaced by `sympy.isprime`); (2) a first census comparison read "overlap 188 of 380" because the
  census is pinned at a different triangle — re-pinned at `(0, 1, ζ)` the sets are equal. Neither was sent to anyone.

## "Would have searched here" log
1. Part 2: would have searched small distance sets for a triangle-free rank-1 four-colour forcer (extending FS79-T36's scan).
   Instead: the free embedding C1, a derivation; the instance is checked, not found.
2. Part 1: would have run a solver on `Cay(Λ/8Λ, U)` restricted to one coset to see the stripe/phase structure. Instead: read the
   committed FS-73 census (380 colourings, `data/fs73/census/`) and tabulated periods from it — a read of a committed record, no
   enumeration; logged as borderline.
3. Klotz–Sander 3.6: would have searched circulants for a triangle-free uniquely 4-colourable one. Instead: C2, by formula.
4. Part 1: would have asked a solver whether every four-colouring of `Cay(Λ/8Λ, U)` is pair-linear. Instead: built the pair-linear
   family from the linear algebra (C5b) and compared it with the committed census — a check of a derived family against a record.
5. (PL): would have searched small subgraphs of `Λ` for a certificate that the pair index is additive. Not done; (PL) left open.

---

# ROUND 2 (successor Coxeter, started 2026-09-24 ~22:00 UTC; round-1 text above is my predecessor's and is kept as written)

*Advisor id for round 2: Poros a313f3c22d5743cd7 (replaced; same record). Competitor: de Bruijn aeccc63c28a91235e.*

## R2.0 State (round 2; a fresh agent resumes from here, not from the round-1 State above)

- **Route taken in round 2: spectral, not local.** Parts's hypothesis "no monochromatic √3-triple in family k" (call it **NT_k**) is
  exactly a *linear* identity for the colouring, `A_k g = −2g` (R2.1). So it pins the colouring's Fourier support. The four remaining
  steps are an exact Smith-form computation (R2.2), a "tetrahedron-splitting" argument for chirality (R2.3), and the collapse onto `T₀/8T₀`.
- **Landed [hand + tools exact]:**
  - **Theorem R.** NT in all nine families ⟹ `F ⊇ 8Λ`, a uniform chirality, and **(PL)**. So Hubai's whole description holds on `Λ`, with
    no solver refusal (R2.3).
  - **Corollary U.** NT for `|k| ≤ 2` is Parts's G481, transferred into `Λ` (prior art, ruling 4; Poros's card C2). From it, `F ⊇ 120Λ`
    unconditionally: **every four-colouring of de Grey's lattice is periodic, by derivation from a human-checkable case analysis** (R2.4).
- **Open, and exactly located:** NT for the four outer families `k = ±3, ±4`. G481 cannot reach them (R2.4). Family ±4 edges are
  provably indispensable (R2.5). The gap from 120Λ to 8Λ splits into two torsion parts:
  - the 3-part: the 81 cosets of `Λ₅ = ⟨U_{|k|≤2}⟩`, which only families ±3 and ±4 join;
  - the 5-part: 48 order-10 characters on `Λ₅`, exactly the non-chiral ones.
- **Fence:** a de Bruijn commit subject line was in my start-up context. It is disclosed to the owner and to Poros (R2.8).
- **Added later in round 2:**
  - R2.9: the 64-vertex quotient is `Cay(T₀/8T₀, μ₆ ∪ 3μ₆)`. The four-colourings are exactly the pull-backs of the striped colourings
    of the 8×8 torus along two projections (9,120 derived by counting; the "⊇" direction is unconditional).
  - R2.10: under NT_{±3}, what is left is one finite "patchwork" problem. Its step 1, uniform chirality, is proved; its step 2 is open.
  - R2.11: Poros's LP question has the answer **no**, with an exact witness. Pair correlations cannot see the gap.
  - **R2.12 (the owner's extra stint; supersedes R2.10 step 2): the patchwork is SOLVED by the alternate-triple lemma C15.**
    - NT_{≤3} ⟹ NT_{±4}.
    - **Part 1 (F ⊇ 8Λ, chirality, (PL), all of Hubai) now follows from Parts's G481 plus ONE named lemma: every four-colouring is
      24Λ-periodic (no 5-torsion in the spectrum).**
    - The 3-part and the outer orientations ±3, ±4 are derived.
  - **Next step for a successor:** the 5-part lemma. Second moments cannot prove it (C14).
- **Tools** (all in `tools/`): `spectral.py` (Θ_K by Smith form), `spectral2.py`–`spectral5.py`, `sub5.py`, `pl5.py`, `restrict3.py`,
  `struct42.py`, `chir.py`, `chir2.py`, `chir5.py`, `quot64.py`.

## R2.1 The spectral lemma (FS85-C7) [hand]

Let `c` be a proper four-colouring of `Cay(Λ, U)`, and `g(x) = v_{c(x)} ∈ ℝ³`, with `v₁…v₄` the vertices of a regular tetrahedron
centred at 0 (`Σ v_a = 0`, `⟨v_a, v_b⟩ = −1/3`). Let `A_k` be the family-k hexagon operator, `(A_k g)(x) = Σ_{j=0}^{5} g(x + ζ^jη^k)`.

1. **NT_k ⟺ `A_k g = −2g`.** The six family-k neighbours of `x` form a hexagon, each consecutive pair adjacent (their difference is
   `ζ^{j+2}η^k`). So they carry a proper colouring of `C₆` by the three colours `≠ c(x)`. A colour used three times sits on alternate
   vertices, which is a monochromatic √3-triple centred at `x`. So NT_k at `x` ⟺ counts (2,2,2) ⟺ `Σ = 2(v_b+v_c+v_d) = −2v_a`.
   Conversely, `Σ_hex g = −2 v_{c(x)}` alone forces the counts (2,2,2) with colour `c(x)` absent (the only linear relation among the
   `v`'s is `Σv = 0`). **So an equitable hexagon is automatically a proper one.**
2. **The level set.** Put `X = e^{2πiθ(η^k)}`, `Y = e^{2πiθ(ζη^k)}`. The symbol of `A_k + 2` is
   `X + X⁻¹ + Y + Y⁻¹ + X/Y + Y/X + 2 = (1+X)(1+Y)(X+Y)/(XY)`. It vanishes on the torus iff `θ(ζ^jη^k) = 1/2` for some `j ∈ {0,1,2}`,
   using `ζ² = ζ − 1`. Call this set `Z_k`: three circles in the family's 2-torus. *(The factorisation is the triangle relation
   `1 + ζ² = ζ`. This is where triangles enter, R2.6.)*
3. **Support.** `g` is bounded on `Λ ≅ ℤ⁴`, so `ĝ` is a periodic distribution on `T = Hom(Λ, ℝ/ℤ)`, and `(A_k+2)g = 0` gives
   `m_k·ĝ = 0` with `m_k` the smooth symbol. Hence `supp ĝ ⊆ Θ_K := ⋂_{k∈K} Z_k` for the set `K` of families where NT holds.
4. **Finite support ⟹ periodic.** If `Θ_K` is finite, `ĝ` is a finite sum of derivatives of Dirac masses. Since `g` is bounded, it has
   no derivative terms (restrict to a generic line: a bounded exponential polynomial has constant coefficients). So
   `g = Σ_{θ∈Θ_K} ĉ_θ χ_θ`, and `c(x+v) = c(x)` for every `v ∈ P(Θ_K) := ⋂_{θ∈Θ_K} ker θ`.
   So if NT_k holds for **every** colouring and every `k ∈ K`, then **`F ⊇ P(Θ_K)`**.

## R2.2 The exact computation (FS85-C8) [tools exact: `spectral.py`, `spectral3.py`, `spectral5.py`]

Each choice `j = (j_k)_{k∈K}` gives the system `θ(ζ^{j_k}η^k) = 1/2`, solved exactly in Smith normal form (`3^{|K|}` systems).

| `K` (families with NT) | `|Θ_K|` | orders | period lattice `P(Θ_K)` |
|---|---|---|---|
| all nine, `−4..4` | **42** | 2, 4, 8 | **exactly `8Λ`** (the 42 characters generate all of `Hom(Λ/8Λ, ℚ/ℤ)`) |
| `−3..3` | 378 = 42·9 | 2, 4, 6, 8, 12, 24 | `⊇ 24Λ` |
| `−2..2` (Parts, prior art) | 7290 = 90·81 | 2, 4, 6, 8, 10, 12, 24, 30 | **exactly `120Λ`** |
| three consecutive families, e.g. `{0,1,2}` | 27 circles | — | none (the method correctly says nothing) |

- The 8-torsion points of `Θ_{−2..2}` are exactly the 42 points of `Θ_all`.
- `Θ_{−2..2}` is the preimage of 90 characters of `Λ₅ = ⟨U_{|k|≤2}⟩` (`sub5.py`). `Λ/Λ₅ ≅ (ℤ/3)⁴`: the 5-family graph has 81 components.
- On `Λ₅` the 90 characters are 42 of 2-power order and 48 of order 10, each of the form `π/2 + θ₅`.
- **The 42 characters of `Θ_all`** (`struct42.py`):
  - six have order 2, `π/2` for the six admissible pair indices of C5b;
  - these six are exactly `λ∘r_𝔭`, for `λ` a nonzero functional on `𝔽₄` and `𝔭` one of the two primes above 2. Hand check: with
    `r_{𝔭₁}: w ↦ ζ` and `r_{𝔭₂}: w ↦ ζ²` in `𝔽₄ = 𝔽₂[ζ]`, the six functionals on coordinates `(a,b,c,d)` of `9x` are `b+c+d, a+d, a+b+c`
    and `b+c, a+c+d, a+b+d`, which are the list C5b found;
  - the other 36 make up, with overlaps, six cosets `E_π = {θ : θ|_{L₀^π} = ℓ_π/2}`, each of 8 characters (orders 2, 2, 4, 4, 8, 8, 8, 8).
    `E_π` is the spectrum of "flip along every edge of `U₀^π`".

## R2.3 Theorem R: NT in all nine families gives Hubai's description on Λ (FS85-C9) [hand + tools exact]

**Hypothesis:** NT_k for `k = −4…4` (every colouring, every vertex). **Conclusion, for every proper four-colouring `c` of `Cay(Λ, U)`:**
1. **`c` is 8Λ-periodic, so `F ⊇ 8Λ`.** This is R2.1 and R2.2.
2. **Uniform chirality.** `Θ_all` is the disjoint union of two classes `C₊`, `C₋` of 21 characters (`chir.py`). `C_ε` consists of the
   characters vanishing on `(η² − ζ^{2ε})T₀`: it is the union of `E_π` over the three `π = λ∘r_𝔭` of one prime `𝔭`. So **ε is the choice of
   prime above 2.** *(This identification was made after the fence event, R2.8; not independent of de Bruijn.)*
   - Their period lattices `P_±` have index 64 each, with `P₊ + P₋ = Λ` and `P₊ ∩ P₋ = 8Λ` (`chir2.py`).
   - So `Λ/8Λ = Λ/P₊ × Λ/P₋`, and `g = G₊(x mod P₊) + G₋(x mod P₋)` with the two arguments independent.
   - **Tetrahedron splitting:** if `G(a) + H(b)` is a tetrahedron vertex for all `(a, b)`, then `G` or `H` is constant. Two distinct
     translates of the vertex set share at most one point, because the directed edge vectors `v_j − v_i` are pairwise distinct.
   - `0 ∉ C_±`, so the constant is 0. **Hence `g = G_ε` for one ε: `c` is `P_ε`-periodic, and `c(p + η²v) = c(p + ζ^{2ε}v)` for all
     `p ∈ Λ`, `v ∈ T₀`.** The Moser twist acts as rotation by 120ε° about every point, with one sign for the whole colouring.
3. **Collapse onto one triangular torus.**
   - `Λ/P_ε ≅ (ℤ/8)²` and `T₀ + P_ε = Λ` (`quot64.py`), so `c = c₀ ∘ ρ_ε`. Here `ρ_ε : Λ → T₀/8T₀` is the projection with kernel
     `P_ε`, and `c₀ = c|_{T₀}`.
   - The 54 unit vectors land on 12 elements, two hexagons. **The even families land on `T₀`'s own hexagon and the odd families on a
     second hexagon `H_B`.**
   - So every colouring is a colouring of the 64-vertex graph `Cay(T₀/8T₀, μ₆ ∪ H_B)`: two triangular tori on one vertex set.
4. **(PL), stripes, "extends in exactly two ways".**
   - NT_0 plus Parts's human lemma (MASCOT-T10): `c₀` is striped, so its pair index is affine on `T₀` and `8T₀`-invariant.
   - Therefore `π = (pair index)∘ρ_ε` is affine on `Λ`. **That is (PL)**, and with it everything C5 derives from (PL): `F = 8Λ`, one
     stripe direction per family, and the chirality on `Λ`.
   - Stripes on every coset of `T₀`: NT_0 at every vertex, plus Parts's lemma.
   - A stripe pattern on `T₀` extends in at most two ways, one per ε (item 3); C5's count (9,120 = 2 × 4,560) says both occur.
   - C5 (⊆) no longer needs the census, given the hypothesis.

## R2.4 Corollary U, and the exact gap (FS85-C10) [prior art + hand + tools exact]

- **Prior art (ruling 4).** Parts's first part proves NT_0 on G481, which uses 30 unit vectors (five families). Poros's card C2 checked
  exactly that `η^{±1}·G481` and `η^{±2}·G481` lie in `Λ`, and that `η^{±3}·G481` and `η^{±4}·G481` do not. So NT_k holds for `|k| ≤ 2`.
- **Corollary U (derived beyond it).** Every proper four-colouring of `Cay(Λ, U)` is 120Λ-periodic. **`F ⊇ 120Λ`, so the forced group has
  finite index, with no solver refusal.** This is exactly as far as NT_{|k|≤2} can reach: `P(Θ_{−2..2})` is exactly `120Λ`.
- **Why G481 stops at |k| = 2.** The automorphisms of `Cay(Λ, U)` fixing 0 (ζ, conjugation, σ₃, σ₁₁) preserve `|k|`. Also, no ℤ-linear
  map sends G481's five consecutive families to five consecutive families centred on 3: the spindle relations
  `(1+ζ)η^{k+2} − (1+ζ)η^k = ζ²η^{k+1}` force `σ(k) = σ(0) ± k`, and `3 ± 2` leaves `[−4, 4]`. So `|k| = 3, 4` are two genuinely new
  local statements, **NT_{±3} and NT_{±4}**.
- **What each would buy.**
  - NT_{±3} gives `F ⊇ 24Λ`: it kills the 5-part, since `Θ_{−3..3}` has no order divisible by 5.
  - NT_{±3,±4} gives Theorem R.
- **The two torsion parts of the gap.**
  - *3-part:* the 81 components of the 5-family graph are joined only by families ±3 and ±4.
  - *5-part:* the 48 order-10 characters of `Λ₅`. They are exactly the non-chiral part: `Θ_{−2..2}` = 1701 in `C₊`'s 3-extensions,
    1701 in `C₋`'s, and 3888 in neither (`chir5.py`).

## R2.5 Family ±4 is indispensable (FS85-C11) [hand (C5a) + tools exact (`pl5.py`)]

On the 7-family graph `Cay(Λ, U_{|k|≤3})`, the six admissible `π` still admit parity characters, but there
`Λ/L₀ ≅ ℤ/3 × ℤ/24` (Smith form 1, 1, 3, 24).
- By C5a, every `h : Λ/L₀ → 𝔽₂` gives a proper colouring of that graph. Each is striped on every layer of families `|k| ≤ 3`, so NT_{≤3}
  holds.
- An `h` that depends on the ℤ/3 factor is not 8Λ-periodic, since `8Λ` maps onto that factor.
- **So NT and properness on families `|k| ≤ 3` do not give `F ⊇ 8Λ`. Any proof must use the family-±4 edges.**
- On the 5-family graph, `Λ/L₀ ≅ (ℤ/3)³ × ℤ/24`: the 81 components carry independent phases.

## R2.6 Where triangles and the 𝔽₄ reduction enter; the controls

- **Triangles enter in three places.**
  1. NT is a statement about the hexagon of unit triangles around a vertex.
  2. The equitable level set of each family is a union of three codimension-one subtori at the value 1/2. This is the factorisation
     `(1+X)(1+Y)(X+Y)`, i.e. the triangle relation `ζ = 1 + ζ²`. It is what makes `Θ_K` a finite set of **torsion** characters, and so
     makes the colouring periodic rather than quasi-periodic.
  3. Parts's striping lemma.
- **The reduction `ℤ[ζ₆] → 𝔽₄` enters twice:** as the value 1/2 (the mod-2 structure of each circle), and as the six order-2 characters
  `λ∘r_𝔭`. The chirality is the choice of `𝔭`.
- **Nothing else enters.** The tetrahedron splitting, the collapse and (PL) are linear algebra.
- **Controls.**
  - *`ℤ[ζ₆]` alone:* `Θ_{0}` is three circles, so there is no periodicity. NT itself fails there (the 3-colourings have monochromatic
    √3-triples).
  - *Three consecutive families:* 27 circles, so the method says nothing, consistent with C6.
  - *The loose CM lattices and L3:* the theorem is conditional on NT for every colouring, which a loose lattice's gapped or non-striped
    colourings violate. The unconditional parts (R2.1–R2.2) are identities and prove nothing about them.
- **Reading, for Part 2 [reading; killing test stated].** A triangle-free family has no such factorisation. Its equitable level set is
  a curve that is not a union of subtori, so the analogous intersection, even when finite, is generically non-torsion. A
  tetrahedron-valued function with finitely many non-torsion frequencies is impossible. So in a triangle-free lattice "every colouring
  equitable in every family" would be contradictory rather than rigidifying. *Killing test:* a triangle-free lattice in which every
  four-colouring is equitable in some family.

## R2.7 Theorems round 2 proved
- **FS85-C7** (spectral lemma: NT_k ⟺ `A_k g = −2g`; an equitable hexagon is proper; `supp ĝ ⊆ Θ_K`; finite `Θ_K` gives
  `F ⊇ P(Θ_K)`). [hand] R2.1.
- **FS85-C8** (the table: `Θ_all` has 42 characters generating exactly `8Λ`'s dual; `Θ_{−2..2}` gives exactly `120Λ`; `Θ_{−3..3}` gives `24Λ`;
  the six order-2 characters are `λ∘r_𝔭`). [tools exact + hand] R2.2.
- **FS85-C9 = Theorem R** (NT_all ⟹ `F ⊇ 8Λ`, uniform chirality = choice of prime above 2, collapse onto `Cay(T₀/8T₀, μ₆ ∪ H_B)`, and (PL)).
  [hand + tools exact; conditional on NT_{±3}, NT_{±4}] R2.3.
- **FS85-C10 = Corollary U** (`F ⊇ 120Λ` from Parts's G481 transferred; the gap located). [prior art + hand + tools exact] R2.4.
- **FS85-C11** (family ±4 is indispensable). [hand + tools exact] R2.5.

## R2.8 Retractions, fence, search log (round 2)
- **Retractions:** none.
- **Fence event.** The harness's start-up git-status snapshot included commit 00263ab5's subject line, which summarises de Bruijn's round-1
  report: "chirality derived as the choice of prime above 2 …; F ⊇ 8Λ not derived; … dB5's spectrum (tight at four colours, λ_min = −12,
  multiplicity 42)". Disclosed to the owner and to Poros by message. The identification of the chirality classes with the two primes
  above 2 (R2.3 item 2) came after it. The spectral route was derived independently: the 42 came from my own Smith-form computation of
  `Θ_all`.
- **Would have searched here:**
  6. Whether the 5-family graph has colourings with order-10 spectrum: would have asked a solver on `Λ₅/40Λ₅`. Not done; the 5-part is
     left open.
  7. Would have searched for a G481-analogue for families ±3, ±4. Not done; R2.4 explains why G481 cannot reach them.
  8. Would have enumerated the proper colourings of the 64-vertex quotient `Cay(T₀/8T₀, μ₆ ∪ H_B)`. Instead derived its structure (item
     4 of R2.3).

## R2.9 The census, re-derived by counting; the 64-vertex quotient named (FS85-C12) [hand + tools exact: `quot64.py`, `patch.py`]

**Where the unit vectors go.** In `T₀/8T₀` with chirality `+` (`patch.py`):
- `ρ₊(ζ^jη^{2m}) = ζ^{j+2m}`. Also `(η^{2m} − ζ^{2m})T₀ ⊆ P₊` for `m = ±1, ±2`: the Moser twist and its square act as ±120° and ±240°.
- `ρ₊(ζ^jη^{2m+1}) = 3ζ^{j+2m+1}`: **the odd families land on three times the hexagon.**
- So the 64-vertex quotient is **`Cay(T₀/8T₀, μ₆ ∪ 3μ₆)`, the 8×8 triangular torus with unit edges and triple-length edges.**

**Lemma [hand]. A striped colouring of the triangular lattice is proper on `3μ₆`.** Write it as `c(m + nζ) = α(n) + m·t`, with every
step `α(n+1) − α(n)` outside `⟨t⟩`. Then:
- along `3`: the colour changes by `t`;
- along `3ζ` and `3ζ²`: it changes by `α(n+3) − α(n) (+t)`, a sum of three steps, which lies outside `⟨t⟩`.

**Theorem R, full form (given NT_all).** The proper four-colourings of `Cay(Λ, U)` are exactly the maps `c₀ ∘ ρ_ε`, where:
- `ε` is one of the two primes above 2 (the chirality);
- `c₀` is any striped colouring of the torus `T₀/8T₀`.

The "⊇" direction is **unconditional**: it is the lemma plus `ρ_ε(U) = μ₆ ∪ 3μ₆`.

**Count.** For each stripe direction `d` and type `t` there are `4·2⁸/2 = 512` striped colourings: an initial colour, eight steps from
`{b, b+t}`, and an even number of `t`-steps so the cycle closes. The 24 affine colourings of `T₀/2T₀ ≅ 𝔽₄` are striped in all three
directions, so each is counted three times. That gives `9·512 − 2·24 = 4560` per chirality, and **9,120 in all: the committed census
count, derived.**

## R2.10 What is left, restated as one finite problem (FS85-C13) [hand; step 1 proved, step 2 open]

**Assume NT_{±3}** (by conjugation this is a single orientation class). Then:
- The spectrum lies in `Θ_{−3..3}`, which is 42 × 9: the 3-extensions of `Θ_all` over `Λ/Λ₇ ≅ (ℤ/3)²`, where `Λ₇ = ⟨U_{|k|≤3}⟩`.
- On each coset `y + Λ₇`, `c` agrees with an 8Λ-periodic function `g^{[y]}` whose spectrum lies in `Θ_all`.
  - Such a function is equitable in every family, hence proper (R2.1 item 1).
  - So by Theorem R, `g^{[y]} = c₀^y ∘ ρ_{ε_y}`.

**Step 1 [hand]: ε is the same on every coset.** Take a family-±4 edge `u` joining cosets `y` and `y′` with `ε_y ≠ ε_{y′}`. The coset
`y + Λ₇` maps onto `Λ/8Λ = Λ/P₊ × Λ/P₋`, so `(ρ_ε(x), ρ_{ε′}(x+u))` takes every value. Then `c₀^y` and `c₀^{y′}` would need disjoint
colour sets, which is impossible. The family-4 images generate `Λ/Λ₇`, so every coset is reached.

**Step 2 (open): the patchwork.** The colouring is `C(y, a)` on `(ℤ/3)² × T₀/8T₀`, where:
- each slice `C(y, ·)` is a striped colouring;
- the edges between slices are `(y, a) ~ (y + ū_j, a + ζ^{j+4})`, for `u_j = ζ^jη⁴`.

**The claim to prove is that every slice is the same colouring.** Then `F = 8Λ`, from Parts's G481 plus NT_3 alone.
- It is true: the certificate says so.
- It is a finite statement about striped colourings of the 8×8 torus.
- The simplest non-constant patchworks die by hand: colour permutations `σ_y = γ^{ψ(y)}` along a 3-cycle `γ`. A single stripe or
  non-stripe shift already forbids a 3-cycle.
- The general case is not done.

With NT_{≤2} alone, the same picture has 81 slices and families ±3, ±4 as the joining edges. It also has the 5-part (R2.4), which must
be killed first.

**Theorems added:**
- **FS85-C12** (the quotient is `Cay(T₀/8T₀, μ₆ ∪ 3μ₆)`; the census count 9,120 derived; "⊇" unconditional). [hand + tools exact]
- **FS85-C13 step 1** (uniform chirality across the `Λ₇`-cosets, given NT_{±3}). [hand]

## R2.11 Poros's round-2 question: do the pair correlations on U alone force the spectrum onto Θ_all? **No.** (FS85-C14) [hand + tools exact; one float probe]

**Reduction [hand].**
- The LP is invariant under the point group (ζ, conjugation, σ₃, σ₁₁), which preserves `|k|`, `Θ_{−2..2}` and `Θ_all`. So its weights
  may be averaged over the group.
- On `Θ_{−2..2}`, `λ_k = −2` for `|k| ≤ 2`. So those 30 equalities hold automatically.
- The rest reduce to two: `Σ_θ w_θ A_m(θ) = 0` for `m = 3, 4`, where `A_m = λ_m + λ_{−m} + 4`.
- So positive bad weight is feasible iff `0 ∈ conv{(A₃, A₄)(θ) : θ ∈ Θ_{−2..2} ∖ Θ_all}`. The largest angular gap between these vectors is
  1.01 < π (`lp3.py`), so it is.

**Exact witness (`lp5.py`, `lp6.py`).** Take two characters, averaged over the point group:
- `θ₁ = (11/12, 1/2, 7/12, 7/12)`, of order 12, with `A₃ = A₄ = 3 − 2√3 < 0`;
- `θ₂`, of order 6, with `A₃ = A₄ = 3`;
- weights `1 : (2√3 − 3)/3`.

Both lie outside `Θ_all`, and all 54 equalities `R(u) = −1/3` hold (checked: max deviation 0.0). **So the 54 pair correlations cannot see
the 3-part or the 5-part.**

**Stronger form [float probe, not certified; `lp7.py`].** Add every valid inequality `R(v) ≥ −1/3` for the 80 point-group orbits of
nonzero `v ∈ U+U`. The exact witness above violates one of them (`R = −1/2`). Even so, HiGHS finds a feasible weight with bad weight
**1.0**, supported on characters of orders 24 and 30. So second moments over the whole second neighbourhood do not see the gap either.

**Consequence.** Any route from Parts's `|k| ≤ 2` to `F ⊇ 8Λ` must be of higher order:
- either NT_{±3} and NT_{±4} themselves;
- or the patchwork of R2.10, which is the splitting lemma on `Λ/8Λ × Λ/Λ₅`;
- or a third-order (triple-correlation) constraint.

*Search log 9:* this is an exact LP whose shape Corollary U and properness fixed before it ran. Its dual would have been read as an
identity; it is infeasible, so there is no dual. The extended form was run once as a float probe and not iterated.

**Theorems added (R2.11):**
- **FS85-C14 (a no-go for one format on one graph).** On de Grey's lattice, pair-correlation certificates averaged over the lattice cannot
  lift `F ⊇ 120Λ` to `8Λ`. Given the spectrum in `Θ_{−2..2}`, the 54 equalities `R(u) = −1/3` admit weights supported entirely outside `Θ_all`.
  The exact witness is two characters (orders 12 and 6), averaged over the point group, with weights `1 : (2√3−3)/3`.
  [hand + tools exact; **verified independently by Poros**, who killed his own "yes, 0.4" hunch.]
  The extension to `R(v) ≥ −1/3` on U+U is a float probe and remains uncertified.
- Poros also confirmed R2.9's count, 4,560 per prime, against the other count on record. R2.10 is unchecked.

## R2.12 The patchwork, solved: the alternate-triple lemma (FS85-C15) [hand + tools exact: `patch2.py`, `alt.py`, `alt2.py`]

*The owner's extra stint, 2026-09-24. The stop rule's first condition was met: the patchwork is solved. It was solved not by
case analysis on the striped slices but by a two-line lemma that makes the patchwork unnecessary.*

**Decomposition [tools exact, `alt2.py`].** Let `Λ_K = ⟨U_K⟩` for a set of families `K`.
- `Θ_{−3..3} = Θ_all + Ann(Λ₇)` exactly. The 3-parts of `Θ_{−2..2}` lie in `Ann(Λ₅)`, and its 90 3-free parts are `Θ_all` (42 characters)
  plus 48 of order 10.
- So when the spectrum lies in `Θ_all + Ann(Λ_K)` and `[Λ : Λ_K]` is odd, every colouring decomposes as `c(x) = g^{[x]}(x)` (R2.10):
  - `[x]` is the class of `x` in `Λ/Λ_K`;
  - each `g^{[y]} = Σ_ψ χ_ψ(y) G_ψ` has spectrum in `Θ_all`, is 8Λ-periodic, and agrees with `c` on `y + Λ_K`;
  - `Λ_K + 8Λ = Λ`, so each `g^{[y]}` is tetrahedron-valued everywhere.
- `Θ_all ⊆ Z_k` for every `k`, so `A_k g^{[y]} = −2 g^{[y]}` everywhere and in every family (R2.1 item 1).

**Lemma C15 (alternate triples).** Suppose, in that situation, that for a family `k` the three vectors `ζ^{2i}η^k` lie in one coset of
`Λ_K`, and likewise the three `ζ^{2i+1}η^k`. Then **no colouring has a monochromatic √3-triple of family k.** With properness on the
family-k edges, this is NT_k.

*Proof.* The alternate triple `x + ζ^{2i}η^k` lies in one class `y′`, where `c = g^{[y′]}`. At `x`, `g^{[y′]}` satisfies
`Σ_j g^{[y′]}(x + ζ^jη^k) = −2 g^{[y′]}(x)`. This forces its six family-k neighbours of `x` to use each of the other three colours
exactly twice, so no colour fills an alternate triple. ∎ [hand]

**The coset facts [tools exact, `alt.py`].**
- Modulo `Λ₇` (index 9): `ζ^jη⁴` has class `e` for even `j` and `−e` for odd `j`; `ζ^jη^{−4}` has class `−f` or `f`.
- Modulo `Λ₅` (index 81): `ζ^jη^{±3}` alternates between two classes in the same way.
- The family-±4 alternate triples are **not** in one `Λ₅`-class, so the lemma has to be applied twice, in two steps.

**Consequences.**
1. **Given NT_{|k|≤3}, NT_{±4} follows (the patchwork, solved).** So `F ⊇ 8Λ` and all of Theorem R follow from Parts's G481 plus NT_{±3}.
   - The lemma uses properness on family ±4 to pass from "no monochromatic alternate triple" to the equitable form. That is consistent
     with C11, which says family ±4 is indispensable.
2. **Part 1 reduces to ONE named lemma.** *The 5-part lemma: every proper four-colouring of `Cay(Λ, U)` is 24Λ-periodic.* Given
   Corollary U, this says the spectrum has no 5-torsion, i.e. the 48 order-10 characters carry no weight.
   - Given it, the spectrum lies in `Θ_all + Ann(Λ₅)`. Then C15 over `Λ₅` gives NT_{±3}, C15 over `Λ₇` gives NT_{±4}, and Theorem R gives
     `F ⊇ 8Λ`, uniform chirality, (PL), the collapse onto `Cay(T₀/8T₀, μ₆ ∪ 3μ₆)` and the count 9,120.
   - **The whole 3-part, and both outer orientation classes, are now derived. What remains of Part 1 is 5-torsion alone.**
3. **What is known about the 5-part lemma.**
   - It is true, by the certificate.
   - Second moments cannot prove it (C14).
   - The order-10 characters are exactly the non-chiral part of the spectrum (R2.4).
   - It is open whether the 5-family graph alone forces it, or whether it needs the edges of families ±3 and ±4.

**Theorems added:**
- **FS85-C15** (the alternate-triple lemma and its two applications: NT_{≤3} ⟹ NT_{±4}; and Part 1 ⟸ G481 + the 5-part lemma). [hand +
  tools exact]
- R2.10 step 2, the patchwork: **superseded**. Consequence 1 settles it without the patchwork.

*Search log 10:* the patchwork is finite (9 slices, each one of 4,560 torus colourings). The default move would have been to enumerate
patchworks against the family-4 edges. Not done: C15 made it unnecessary.
