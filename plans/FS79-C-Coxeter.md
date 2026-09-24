# FS-79 — Coxeter's working file

*Competitor: Coxeter (Opus 5.5), 2026-09-24. Brief: `BRIEF-Coxeter.md` (this directory). Sole writer: Coxeter. Poros may read this
file and nothing else here. Grades per `CLAUDE.md` § Notation. Retractions are kept, struck through in words ("RETRACTED:"), never
deleted.*

## §0. First route (written before any message to Poros or de Bruijn)

**Where I start from.** At three colours the height existed because `K₃`'s cycle is not null-homotopic and the square relations close
(T21). At four colours T29 says the only thing left is a winding in `Hom(R, ℤ/2)`. My first observation, before anything else:

- **R1.a (the winding is the parity) [hand, to be written out in §1].** `Q₃ = K₄ × K₂` (the bipartite double cover of `K₄`), and the
  lift of T29 through the cube is `c̃(x) = (c(πx), |x| mod 2)`. So the ℤ/2 winding of every four-colouring on a relation `ρ` is
  `‖ρ‖₁ mod 2`, the same for every colouring: it is a property of the graph, not of the colouring. **Four-colourings carry no
  loop-invariant at all.** (A correction owed to G71/T29's wording "carries only a winding".)

Hence the route G72 names for four colours is "one dimension up, its spheres": `K₄`'s square complex is `ℝP²`, whose universal cover is
`S²` (the cube surface), `π₂ = ℤ` twisted by `π₁ = ℤ/2`. The questions I set myself, in order:

1. **(Q-obs), no-go by kind, for the target class.** Which named kinds are blind on triangle-free rank-4 lattice graphs?
   - **R1.b [to verify against prior art]:** Kind T (Lovász's box/neighbourhood complex, every bound in the Matoušek–Ziegler hierarchy)
     cannot refute four colours on a K_{2,3}-free graph, by the Simonyi–Tardos zig-zag theorem (a topological bound `t` forces a
     `K_{⌈t/2⌉,⌊t/2⌋}` in every colouring). Unit-distance graphs are K_{2,3}-free (two circles meet in ≤ 2 points). So Kind T is blind
     at five colours on every unit-distance graph, ℚ(√167) included.
   - Kind 0₁ is controlled by χ_f (known). Kind 1 (1-cocycles): R1.a kills the topological source; whether every continuous cocycle is
     trivial is CGHO's question for our class — attempt the edge-local case.
2. **(Q-obs), positive, one dimension up.** The skyrmion 2-form: for each grid square of the lifted colouring, its signed area on the
   cube surface (0, or ±1). It is closed except at **monopoles** (3-cubes whose eight vertices map onto the cube with degree ±1). First
   thing to derive: the local criterion for a monopole in a Cayley graph (which four "body diagonal" pairs must be monochromatic), and
   hence a condition `Φ_M` on `S` under which the flux through every even relation torus is a translation-invariant integer — a
   two-dimensional `Θ`. Then: does `Φ_M` hold anywhere interesting, and does it fail at ℚ(√167)? If it fails there, the sphere
   invariant dissolves into window frequencies (Kind 0_W) at the target, and that is the no-go to state.
3. **(Q-rig) at the target, one computation that checks a derived closed form.** For an additive colouring `φ : Λ → ℤ/4`, the Kempe
   period group should be `KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁ − U₁⟩` (`U_j = {u : φ(u) = j}`). Apply to `L21cc6506`'s eight additive colourings: if the
   intersection is 0, `F = P = 0` there (T36), and route (ii) needs richer lattices.
4. **(Q), lowest:** the rank-1 wall criterion (T30) between *rigid* phases would give `P ≠ F` in rank 1; only if time remains.

Prior-art gate for this route (in the disciplines' words): Simonyi–Tardos zig-zag / topological bounds and K_{l,m}-free graphs
(topological combinatorics); four-colourings / 4-state Potts antiferromagnet in three dimensions with ℝP² or S² order parameters,
hedgehogs/monopoles, "height" in 2+ dimensions (statistical mechanics); `π₂` / degree cocycles for ℤ^d shifts (symbolic dynamics).

## §1. Claims

*Scripts: `work/` in this directory (standalone; they import the phase-0 checker's unit enumeration read-only). Notation: a
presentation `(Λ, S)` in canonical form `Λ = ⟨S⟩`; `π : ℤⁿ → Λ` one coordinate per ± pair; `R = ker π`. Colours labelled by
`V₄ = 𝔽₂²` when convenient; the **type** of an edge `xy` is `c(y) − c(x) ∈ V₄ ∖ 0`.*

### C1. The winding of T29 is the parity: four-colourings carry no loop invariant. [hand]

**Class** 𝒞 (every rank). **Statement.** `K₄ × K₂` (tensor product) is `K_{4,4}` minus a perfect matching, which is `Q₃`; so `Q₃ → K₄` is
the bipartite double cover. For a colouring `c` of `Cay(Λ, S)`, the lift of T29 is `c̃(x) = (c(πx), |x| mod 2)` on `ℤⁿ`, and the
monodromy of a closed walk under a bipartite double cover is its length mod 2. Hence the ℤ/2 winding of **every** four-colouring on
`ρ ∈ R` is `ρ₁ + ⋯ + ρₙ mod 2`: a character of the graph, the same for all colourings. *Proof:* the two lines above. **Consequence.**
T29/G71's "a four-colouring carries only a winding in `Hom(R, ℤ/2)`" should read "carries no loop invariant at all": the one
candidate is fixed by the graph. (At three colours the winding `w ∈ 3ℤ` also has this parity, `w ≡ |ρ| (mod 2)`; the information is in
the integer.) **Inhabitant:** `G(ℤ, {1,3,4,5})`: `ρ = 1 + 3 − 4` is odd, winding 1 for all of its colourings. **Grade:** hand.

### C2. Kind T is blind at five colours on every K_{2,3}-free graph; so on every unit-distance graph. [prior art applied]

**Class:** K_{2,3}-free graphs (every unit-distance graph: two unit circles meet in ≤ 2 points), every rank; reaches ℚ(√167).
**Format fixed first (OBS-N1):** a certificate is a finite subgraph `H` and a ℤ₂-map `S^{t−2} → B₀(H)` (or any bound in the
Matoušek–Ziegler hierarchy, `coind(B₀(H)) + 1 ≥ t`); soundness: `χ(H) ≥ coind(B₀(H)) + 1`. **No-go (N-blind):** Simonyi–Tardos's
zig-zag theorem (Combinatorica 2006, arXiv:math/0407075): if the topological bound is `t`, every proper colouring contains a
completely multicoloured `K_{⌈t/2⌉,⌊t/2⌋}`; equivalently a `K_{l,m}`-free graph has Lovász bound ≤ `l + m − 1`. `t = 5` needs a `K_{3,2}`.
So no certificate of this kind proves five colours on any unit-distance graph, in any field. **Scope (OBS-N4):** every topological bound
of the hierarchy (Lovász's `conn(N(G)) + 3` is the strongest of them and below the zig-zag bound). **Prior art:** the theorem is
Simonyi–Tardos's; the corollary for unit-distance graphs is one line and probably folklore (not found stated). **Grade:** prior art + hand.

### C3. The square lemma: at four colours an edge-local height dies on an induced square. [hand; confirmed by exact linear algebra]

**The format (Kind 1_e, "edge-local heights"; fixed before the no-go).** A certificate datum is `F = (F_s)_{s∈S}`, `F_s : {(a,b) ∈
[k]², a ≠ b} → M` (`M` torsion-free abelian), `F_{−s}(b,a) = −F_s(a,b)`, **closed on every commutation square** `x, x+s, x+s+t, x+t` (for
every proper colouring of the square's induced subgraph, the sum around it vanishes). Then the height `h` lives on the grid `ℤⁿ` that
covers the Cayley graph; its **winding** `w(ρ) = h(x + ρ) − h(x)` on `ρ ∈ R` and its mean slope are the invariant datum `(d, m)`.
*[Corrected, R2: the first version demanded closedness on every relation cycle, which forces the winding to be 0 and excludes FS-73's
height, whose winding on odd relations is a nonzero multiple of 3. The theorem below is re-derived for the corrected, weaker format.]* **FS-73's three-colour height is in
this format** (`F(a,b) = ±1` as `b − a = ±1 mod 3`), and so is **Moore–Newman's** four-colour height on the triangular lattice
(`F_s(a,b) = χ(s)·E(b − a)`, `χ : Λ → ℤ/3` additive with `χ(S) = {±1}`, `E(α) + E(β) + E(γ) = 0`).

**Lemma (square).** Let `s, t ∈ S`, `s ≠ ±t`, with `±s ± t ∉ S` (the 4-cycle `x, x+s, x+s+t, x+t` is induced). If `(F_s, F_t)` is closed on
every proper four-colouring `(a, b, c, d)` of that 4-cycle, then `F_s = δg + κ_s`, `F_t = δg + κ_t` with **one** `g : [4] → M ⊗ ℚ`
(`δg(a,b) = g(b) − g(a)`) and constants `κ_s, κ_t`.
*Proof.* Closedness: `F_s(a,b) + F_t(b,c) = F_t(a,d) + F_s(d,c)`. (i) `b = d` (then `b ∉ {a, c}`): `D(a,b) = D(b,c)` for `D = F_s − F_t`
and all `a ≠ b ≠ c`; so `D(a,b)` depends on neither argument (fix `b`: `D(·,b) = D(b,·) = μ_b`; then `D(b,c) = μ_b = μ_c`): `F_t = F_s − μ`.
(ii) `c = a`: `F_s(a,b) + F_t(b,a) = F_t(a,d) + F_s(d,a)` for all `b, d ≠ a`, so `F_s(a,b) + F_s(b,a) = λ_a` is independent of `b`, hence
(symmetric in `a, b`) a constant `λ`; write `F_s = λ/2 + G` with `G` antisymmetric. (iii) `a ≠ c`, `{b, d}` the other two colours:
`G(a,b) + G(b,c) + G(c,d) + G(d,a) = 0` — `G` sums to zero on every 4-cycle of `K₄`. The three oriented 4-cycles of `K₄` are linearly
independent over ℚ (the coefficients on `e₁₂, e₂₃, e₃₄` already force zero), so they span its 3-dimensional cycle space: `G` sums to zero
on every cycle, `G = δg`. ∎ (Over 𝔽₂ the three 4-cycles are dependent — that is `ℝP²`; the lemma is a statement over ℚ, i.e. for
torsion-free `M`.) **Why three colours differ:** with `a ≠ c` there is one middle colour, step (iii) is empty, and one class survives —
the height. **Exact check** (`work/local_forms.py`, rank at two 31-bit primes): closed forms on an induced square have dimension 5 and the
trivial ones 5 at `k = 4` (9 and 9 with parity-dependent values); at `k = 3`: 5 against 4 (8 against 7) — the one extra class is FS-73's
height (the positive control that the instrument can see a class).

**Theorem C3 (Kind 1_e is trivial at four colours on triangle-free graphs).** Let `Cay(Λ, S)` be triangle-free with at least two
± pairs of generators. Then every closed edge-local form is `F = δg + κ` (`κ` a constant per generator): every colouring's height is
`g(c(πx)) + κ·x`, bounded plus a fixed linear map, and its winding and slope are the same for every colouring. So the format's admissible
set is never empty on a graph where it is defined, and its invariant is the same for all colourings. *Proof.* Triangle-free gives
`±s ± t ∉ S` for `s ≠ ±t` (a chord would close a triangle), and the four vertices are distinct, so every two ± pairs span an induced
square (in rank 1 too). The lemma gives each pair a common `g`; two lemmas sharing a generator `u` give `δ(g − g′) = const` on `u`'s
colour pairs, and an antisymmetric constant is 0, so one `g` serves every pair. On the grid, `h(x) = g(c(πx)) + κ·x` with `κ ∈ M^n` the constants, so the
winding is `w(ρ) = κ·ρ` and the slope is `κ` — **the same for every colouring**, fixed by the form. A certificate would need the checker's
admissible set to exclude `(κ|_R, κ)`, which would make it unsound on every four-colourable graph of the class. ∎ **Class** triangle-free (so K₄-free), every rank `r ≥ 1` with two ± pairs (rank 1 included: `G(ℤ,{1,3})`'s square
`0,1,4,3` is induced); **reaches ℚ(√167)** (every lattice there is triangle-free, G57). **Controls (OBS-N3):** the grid `ℤ²` is covered
(no edge-local height; the edge-local case of `[CGHO2025coh]` Thm 1.1); the **triangular lattice is not covered** (its squares have
chords, and Moore–Newman's form is closed and not `δg + κ`: `E(b−a) = E(a−b)` would force `g` constant and `F_s` constant, but
`E(α) ≠ E(β)`); **three colours are not covered** (the lemma fails at `k = 3`). **The controls, computed in the corrected format** (commutation squares only,
each on its induced subgraph's proper colourings): the triangular lattice (`e₁, e₂, e₂ − e₁`) has closed forms of dimension 8 against 6
trivial — **exactly two extra classes, Moore–Newman's `E : V₄ ∖ 0 → ℚ` with `E(α) + E(β) + E(γ) = 0`**; the grid `ℤ²` has 5 against 5;
`G(ℤ, {1,3})` has 5 against 5. (The first version's control, `work/tri_control.py`, also imposed the triangles: 7 against 5, the same two
classes.) **Over 𝔽₂ step (iii) fails:** the three 4-cycles have rank 2 there (each edge lies in two of them) — the lemma is
characteristic-dependent and true over ℚ, which is what a torsion-free height needs (the owner's independent check). **Grade:** hand (lemma and theorem), tools (the rank checks and the controls).

### C4. The cube lemma: one dimension up, the only local class is `π₂`'s, and monopoles kill it. [tools exact + hand]

**The format (Kind 2_f, "face-local fluxes").** A datum is a face-local 2-form `ω_{st}` (a value for each oriented square `x, x+s,
x+s+t, x+t` from its four colours, optionally also from the base vertex's parity in the lift `ℤⁿ`), closed on every proper colouring of
every induced 3-cube (the sum over the six outward faces is 0). If closed, its flux through an even relation torus (the staircase product
of two lattice paths of even relations `ρ₁, ρ₂ ∈ R`) is independent of the base point, and it is an integer datum `d(c)` — the
four-colour analogue of the winding, one dimension up (G72's move 2, "spheres"). The candidate is the **skyrmion form**: lift to `Q₃ ⊂ ℝ³`
(C1), and let `ε = ±1` be the orientation with which a four-coloured square covers a face of the cube surface `S²`, 0 on a degenerate
square; on a closed surface `Σ ε = 6·deg`.

**Lemma (cube) [tools, exact].** `Q₃` has 2,652 proper four-colourings; exactly 24 are **monopoles** (each vertex coloured like its
antipode in the cube; one pattern up to relabelling), and the skyrmion form has boundary `±6` on them (degree ±1). Over ℚ, with values
depending on the square's colours and the base parity (504 unknowns, 5,304 equations): **closed forms = `dη + κ`** (`η` edge-local,
parity-dependent; `κ` constant per face type), i.e. `H² = 0`; **excluding the 24 monopole patterns, `H² = 1`** (the skyrmion class).
(`work/face_forms.py`, `work/face_forms_ctl.py`; rank at two 31-bit primes.) So the `π₂(S²) = ℤ` invariant exists locally, and monopoles
are exactly what kill it. **Without the parity** — the translation-invariant format on `Λ` itself, which is the only one a non-bipartite
Cayley graph admits, since parity is not a function on `Λ` there — `H² = 0` **with or without** the monopoles (252 unknowns;
`work/face_forms_nopar.py`, `work/face_forms_ctl_nopar.py`): the skyrmion needs the sheet, and that is C4′'s sign argument seen locally. A monopole at `(x; s, t, u)` needs the four body-diagonal pairs monochromatic, so a chord `±s ± t ± u ∈ S`
suppresses it.

**Lemma (rhombus) [hand].** Four unit vectors of the plane with zero sum form two opposite pairs. (`a + b = −(c + d) = w`; if `w ≠ 0`, the
two unit vectors with sum `w` are determined up to order, and `−c, −d` are such a pair.) **So in a unit-distance lattice graph no
generator triple has a body-diagonal chord**, and in a triangle-free one every pair of non-parallel generators spans an induced square and
every triple of pairwise non-parallel ones an induced 3-cube. Checked on `L21cc6506` (60 unit vectors: 435 pairs, 4,060 triples, all
induced, 0 chords) and on Λ₂₄₄₈, Λ₂₃₂₈, Λ₂₄₀₀ (all induced, 0 chords): `work/cubes_target.py`.

**Theorem C4 (Kind 2_f is trivial at four colours where every triple spans an induced cube).** If every pair of generator directions of
`(Λ, S)` spans an induced square and every triple an induced 3-cube, every closed **parity-free** face-local 2-form (the Λ-invariant
format) is `dη + κ` **globally**, and its flux
through every even relation torus is the same for every colouring. *Proof (gluing).* For a pair `{i, j}` let `A_{ij}` be the set of
`(η_i, η_j)` with `ω_{ij} − d(η_i, η_j)` constant. If `dζ` is constant then it is 0 (the patterns `abab` and `baba` give opposite values),
so by the square lemma `A_{ij}` is a coset of `{(δg + c, δg + c′)}` (one `g`). (With parity this step fails — `work/dconst.py` finds one
`ζ` with `dζ` a nonzero parity-dependent constant — which is why the global statement is made parity-free.) Its projection to
direction `i` is a coset `η_i + B`, `B = {δg + c}`, and the cube lemma on `{i, j, k}` shows the projections from `{i, j}` and `{i, k}`
meet, hence coincide. Fix representatives `η_i`; on each pair the defect is `(δh_i, δh_j)` with `d_{ij} = h_i − h_j ∈ V = ℚ^{colours}/ℚ`
well defined; on each triple the cube lemma's single primitive makes `d_{ij} + d_{jk} + d_{ki} = 0`; the triangles of the complete graph on
the directions span its cycle space, so `d = δf`, and `η_i − δf_i` is a global primitive. On an even relation torus `dη` telescopes (the
identified boundary edges carry the same parity) and `Σ κ` counts faces by type, independent of `c`. ∎ **Class:** every triangle-free
unit-distance lattice graph (so every lattice over ℚ(√167), `r = 4`); abstractly, the Cayley graphs with the two induced-cell conditions.
**Controls:** with monopoles excluded the class returns (the instrument sees it); the grid `ℤ³` has induced cubes and its additive `V₄`
colouring is a monopole in every cube. **Grade:** tools (the cube lemma's rank), hand (rhombus lemma, gluing, telescoping).

### C4′. The sign kills the flux on every non-bipartite graph, charges or not. [hand; Poros's reading, checked here]

**Poros's premise, checked:** by C1 the lift satisfies `c̃(x + ρ) = c̃(x)` for even `ρ ∈ R` and `c̃(x + ρ) = antipode(c̃(x))` for odd `ρ`,
**for every colouring** (the parity is the graph's). The antipode of `S²` has degree −1. So for an even relation torus `Σ` and an odd
relation `ρ′` (one exists iff the graph is non-bipartite, i.e. unless it is two-colourable): `Σ` and `Σ + ρ′` map to the same torus in the
Cayley complex, and `deg(Σ + ρ′) = −deg(Σ)`; sweeping `Σ` to `Σ + ρ′` changes the degree by the monopole charge `Q` swept. Hence
**`deg(Σ) = −Q/2`**: the flux is slaved to the charges, and 0 where there are none. Averaged signed densities vanish for the same reason.
So the `π₂` invariant dies twice at four colours: by the sign on every graph that matters (Poros), and locally by monopoles (C4).
**Grade:** hand. **Credit:** the reading is Poros's (registered in its record before it read this file); I checked it and adopt it.

### C5. What C1–C4 leave, for (Q-obs) at ℚ(√167). [derived]

At four colours on the target class the target's topology gives nothing that is **local in one cell**: loops give the parity (C1),
spheres give the skyrmion class, which monopoles kill (C4), edge-local heights are trivial (C3), and Lovász's bounds are blind (C2).
Invariants of the G72 shape can live only where cells have **chords**: triangles (face diagonals in `S`: Moore–Newman's height on the
triangular lattice, de Grey's `ℤ[ζ₆]`-layers) or body diagonals (impossible for unit vectors by the rhombus lemma). So a four-colour
certificate at ℚ(√167), if one exists, is (i) averaged — window frequencies, Kind 0_W, or (ii) non-local — a cocycle reading a window of
radius ≥ 2, which C3/C4 do not reach, or (iii) structure-derived (algebraic, counting). **Scope stated (OBS-N4):** C3 and C4 are no-gos for
cell-local formats only; a CGHO-type theorem for cocycles of every radius on our class is not claimed.

### C6. (Q-rig) data at the target: `L21cc6506`'s periodic colourings are Kempe-rigid. [hand + tools exact]

**Lemma (Kempe period of an additive colouring) [hand].** For `φ : Λ → ℤ/4` with `φ(S) ⊆ {1,2,3}` and `U_j = φ^{−1}(j) ∩ S`:
`KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁ − U₁⟩`. *Proof:* a `{p, p+2}`-component is a coset of `⟨U₂⟩`; a `{p, p+1}`-component is `x + (D₁ ∪ (u₀ + D₁))`,
`D₁ = ⟨u − u′ : u, u′ ∈ U₁⟩` (walks alternate `+U₁`, `−U₁`); a translation fixing every component lies in `Per(φ) = ker φ`, so it must lie
in `⟨U₂⟩` and in `D₁`. ∎ **On `L21cc6506`** (`work/kper_additive.py`): each of the 8 additive colourings has `|U₁| = |U₃| = 18`,
`|U₂| = 24`, and `KPer(φ)` of rank 4 and **index 8**; their intersection has index 64. The two `Θ₄` colourings of phase 0 (orders 4,200
and 5,880) have `KPer = Per` for every phase `β` tried (`work/kper_linear.py`, voltage groups on the circulant quotient), and each lies in a
`Θ₄` cell with **empty interior** (`work/theta4_cell.py`: 14 and 12 of 60 constraints tight, maximal slack 0). So no colouring found on
`L21cc6506` is gapped or Kempe-loose; the known periodic colourings leave `P ⊆` a finite-index subgroup. **Not a rigidity claim:** `F` of
finite index needs the whole colouring space finite (T37), which nothing here shows. ~~*Reading, with its killing test:* `L21cc6506` may
have a small four-colouring space; killed by one colouring with `KPer` of rank < 4 (e.g. a gapped one) or a full-dimensional `Θ₄` cell.~~
**RETRACTED (R1, the "small" half), same session:** the colouring space is not small. The admissible periods `N ≤ 8` are `N = 4, 8`
(`N = 2, 3, 5, 6, 7` put a unit vector in `NΛ`); `Λ/4Λ` alone has **266,928** four-colourings with the origin coloured 0 and one
generator coloured 1 (complete enumeration, `work/count_quot.py`, 187 s), so about 3.2·10⁶ colourings in all and about 500 orbits under
translation and relabelling. What survives: **no gapped colouring** at `N = 4` or `N = 8` (`work/gap_probe.py`, UNSAT in 0.0 s and 1.4 s),
and **all 400** 4-periodic colourings whose `KPer` was computed (`work/kper_quot.py`) have `KPer` of rank 4; their `KPer`s meet in a
subgroup of index 2,304. So every colouring examined is Kempe-rigid, yet there are very many of them. `F` is not settled: finitely many
full-rank `KPer`s always meet in a full-rank group, so no periodic sample can show looseness, and nothing here shows forcing.
**Why it matters for route (ii) (the one sharp consequence):** the periods seen are 4, 4,200 = 2³·3·5²·7 and 5,880 = 2³·3·5·7², and
2, 3, 5, 7 are all invertible in `ℤ[U]` over ℚ(√167) (`[Fischer1990]` Ex. 4 for 2, 3, 7; for 5, the two primes above 5 in ℚ(√167, i) come
from `(2 ± i)` and conjugation swaps them). So **if** `L21cc6506`'s four-colouring space were finite with every colouring `N₀Λ`-periodic for
an `N₀` built from 2, 3, 5, 7, then `δ = N₀u ∈ F` has `1/δ ∈ ℤ[U]` and G55's chain would give χ(ℚ(√167)²) ≥ 5. Nothing here says it is
finite; this is a statement of what deciding it would buy (not landed, type (c)).

### C7. Poros's language question on `L21cc6506`: C3 transfers to the colouring shift; monopoles occur. [tools exact on exhibited colourings + hand]

**What was asked.** C3 and C4 quantify over locally proper cell patterns. A cocycle of the colouring shift `X` need only close on the
patterns that occur in `X`. Do they agree on the target instance?
**Check** (`work/language_np.py`, `work/missing_pairs.py`: 3,000 colourings of `Λ/4Λ` and 600 of `Λ/8Λ`, each a proper colouring of the
quotient and hence a 4Λ- or 8Λ-periodic colouring of `L21cc6506`). For each of the 435 pairs of generator directions, which of the four
square types (under relabelling: `abab`, `abac` = monochromatic `s+t` diagonal, `abcb` = monochromatic `s−t` diagonal, `abcd` = rainbow)
occur at some vertex of some sampled colouring.
- **378 pairs show all four types.** Their graph on the 30 directions is **connected**. The square lemma needs only those four types
  (steps (i)–(iii) use `abab`, `abcb`; `abab`, `abac`; `abcd`), relabelling-closed because `X` is. So the gluing of C3 runs on the good
  pairs alone. **Theorem C7:** every continuous edge-local cocycle of `X(L21cc6506, U, 4)` (values in a torsion-free group, closed on the
  patterns that occur) is `δg + κ` with `κ` a homomorphism. The four-colour shift of the lattice that proved χ(ℚ(√167)²) ≥ 4 carries no
  edge-local height. **Grade:** tools (patterns exhibited by colourings any checker can re-verify) + hand (the lemma and the gluing).
- **The other 57 pairs miss some type in the sample, and the misses are sampling artifacts, not compulsions.** They are all pairs inside
  one rational layer (angles 16.26°, 36.87°, 53.13°, 73.74°, 90°). For the 9 pairs where only rainbow squares appeared, the two missing
  identifications (`c(0) = c(s+t)`, `c(s) = c(t)`) were each asked directly and are **SAT at N = 4 and at N = 8** (`work/virtual_probe.py`).
  So there are no virtual edges there. (A G21 instance caught before it was reported: blocking-clause enumeration samples near its first
  solution.)
- **Monopoles occur:** 2,889 of the 4,060 generator triples carry a monopole in some sampled 8Λ-periodic colouring (2,862 at N = 4). So on
  `L21cc6506` the charges that kill the `π₂` class are realized, not merely allowed; C4′ kills the flux there in any case.

## §2. Retractions

- **R2 (C3, 2026-09-24):** the format was misdefined — "closed on every relation cycle" forces winding 0 and excludes FS-73's height,
  which I had said was in it. Corrected to closedness on commutation squares with the winding on `R` as the datum; the square lemma is
  unchanged, the theorem re-derived (the winding is `κ·ρ`, the same for every colouring), the controls recomputed (same verdicts). Found by
  me on re-reading, after Poros's and the owner's checks had passed the lemma.
- **R1 (C6, 2026-09-24):** "`L21cc6506` may have a small four-colouring space" — killed by its own test's spirit within the hour: 266,928
  pinned colourings of `Λ/4Λ`. Kept, struck, in C6. (The Kempe-rigidity observation survives; the size claim does not.)

## §3. Poros's held items and questions: taken and declined

- **H-A (owner) and H-P2 (plan-phase advisor), the flux one dimension up:** reached independently in §0 item 2 before they were sent;
  **its killing test is met** — by monopoles locally (C4: `H² = 0`, and `H² = 1` exactly when the 24 monopole patterns are excluded) and by
  the sign globally (C4′). H-A's "first cheap test" (does the flux see a five-chromatic distance graph on ℤ?) is moot: rank 1 has no
  2-planes, as H-P2 says.
- **H-B (universal triangle-free target):** declined as a route. For the general class the killing test is met by the sparse
  incomparability lemma (Nešetřil–Rödl; Nešetřil–Zhu 2004, *from memory, unchecked*): for finite triangle-free `T`, `K₄ ↛ T`, so some
  triangle-free `G′ → K₄` has `G′ ↛ T`. For Cayley graphs of ℤ^r the question is open, and there it **is** the residue method: the
  residue targets `Γ_q` (triangle-free at 31, 43; `U_Q`) are finite Cayley targets, and "every four-colourable ℚ(√167)-lattice maps to one
  of them" is the local–global conjecture's content at four colours. Not a new route.
- **H-P3 (compositional certificates):** noted, not pursued. C3/C4 say a compositional invariant built from cell-local heights is trivial at
  four colours on the multilayer, so compositionality would have to come from an averaged kind.
- **Poros's second question (local admissibility against the language of `X`):** both cuts matter, for different faces.
  - For **(Q-obs)** a checker sees only `S`, so a certificate format can only demand closedness on locally proper patterns, or on the
    patterns left after **certified exclusions** (each excluded pattern carrying a finite refutation). C3/C4 are no-gos for the first; the
    square lemma says exactly what the second would need: a height is nontrivial on a direction `s` only if **every** square through `s`
    carries a chord, real or certified-virtual (a pair `x, x ± s ± t` separated by every colouring). That is the one way heights could
    return at four colours on a triangle-free graph, and it is a strong requirement (29 other directions at `L21cc6506`).
  - For **(Q-rig)** and cocycles of the colouring shift, the language is the right cut, and C3/C4 transfer exactly when every locally proper
    cell pattern needed by the lemma occurs in `X`. De Grey's lattice is the case where they do not (12 classes: any function of the class
    is an invariant). For `L21cc6506` they agree where it matters (C7).

## §4. Poros's two second questions (answered after the first report)

**Q1. Does the edge-local format certify anything anywhere in 𝒞?** [hand; one part a reading]
- **Degenerately, yes, and it is a plain refutation in disguise.** The datum on `ρ ∈ R` ranges over the sums of `F` along the proper
  colourings of the relation cycle's induced subgraph. If that subgraph has no proper four-colouring (in `G(ℤ, {1,2,3,4})` the cycle
  `1+1+1+1−4` spans a `K₅`), the set is empty and the format accepts: a certificate that *is* the refuting subgraph.
- **Where a nontrivial class can live at all:** by the square lemma, on every component with ≥ 2 directions of the graph "the square
  `(s, t)` is induced", `F = δg_A + κ`. A colour-dependent winding therefore needs chorded squares, which means triangles. Triangle-free
  graphs never qualify (C3). The one K₄-free example with a nontrivial class that I know is the triangular lattice. There `R` is generated
  by triangle relations, Moore–Newman's windings vanish on them, and the graph is four-colourable.
- **Non-degenerate acceptance on a K₄-free graph whose relation cycles are all locally colourable: open.** *Reading:* it never happens,
  so C3's weight is "the edge-local format is empty at four colours except through local refutations, and blind on the target". *Killing
  test:* a K₄-free presentation, every relation cycle locally four-colourable, on which the format's admissible set is empty. Classifying
  presentations in which some direction is chorded with every other direction would decide it. Not done.

**Q2 — C8. The census of `L21cc6506`'s mod-4Λ colourings. [tools exact; complete]** (`work/kper_orbits.py`; checkpointed, one line per
orbit in `work/kper_orbits_lines.jsonl`; run outside the heavy lock under the owner's exception, single process, ~120 MB.)
- The 266,928 pinned four-colourings of `Cay(Λ/4Λ, U)` fall into **4,490 orbits** under translation and relabelling. (My earlier "about
  500" was an estimate that ignored small stabilisers; the count is 4,490.)
- **Every one of the 4,490 orbits has `KPer` of rank 4.** No 4Λ-periodic colouring is Kempe-loose.
- **The intersection of all 4,490 `KPer`s is exactly `12Λ`** (index 20,736).
- With `Per` of the two `Θ₄` colourings (indices 4,200 and 5,880), the intersection has index **1,778,112,000**. The least `m` with
  `mΛ` inside it is **29,400 = 2³·3·5²·7²**.
- **By T36 this is an upper bound for `P`, hence for `F`**: every pair every periodic colouring identifies lies in this subgroup.
- **Answer to Poros's two branches:** the rank-below-4 branch did not happen, so this finite hope survives at `L21cc6506`. The rank-4 branch
  holds, and its bound contains `29400·u` for every unit vector `u`, with `1/(29400u) = ū/29400 ∈ ℤ[U]` because 2, 3, 5, 7 are all
  invertible there.
- **What it does not show:** that the space is finite, or that any pair is forced. Finitely many full-rank groups always meet in a
  full-rank group; the census bounds `P` from above and nothing more. Verification's natural next move is a **forcing certificate** for
  `(0, N₀u)` with `N₀ | 29400`, or a colouring outside the 4Λ family whose `KPer` has rank < 4. That is a run, not a derivation.

**C8′. Poros's follow-up: the second `Θ₄` cell is two-dimensional, and the bound collapses to the rational layer. [tools exact + hand]**
(`work/theta4_dim.py`.)
- **The two cells.** The cell of phase 0's order-4,200 colouring is a **point**: all 60 constraints are fixed on it, rank 4. The cell of
  the order-5,880 colouring has **dimension 2**: 12 constraints are fixed on it, of rank 2, and its coordinate widths reach 6.5·10⁻³.
  So C6's "empty interior" was true and incomplete: empty interior is not a point. *(G21 on my own C6: I measured the slack and not the
  dimension.)*
- **Consequence (T22's ⟸ and T37).** The rational points of that 2-cell give periodic colourings of unbounded period, and `θ(δ) ∈ ℤ`
  on an open piece of a 2-plane `θ₀ + V` forces `V(δ) = 0`. So **`P ⊆ {δ : V(δ) = 0}`, of rank ≤ 2**: `F` has infinite index, and
  **`L21cc6506`'s four-colouring space is infinite**. That ends the "finite space" form of route (ii) there, which C6 never claimed and
  C8 had left open.
- **What survives.** The 12 fixed unit vectors are exactly the **rational pattern `U_R`** (±1, ±i, ±(3±4i)/5, ±(4±3i)/5). So
  `ker V ∩ Λ` contains the rational layer, and **P lies in a rank-2 subgroup that meets C8's bound in a finite-index subgroup of the
  rational layer.** A four-colour forced pair on `L21cc6506`, if any, lies (up to finite index) in the rational layer `Λ_R`, at some
  `N₀u_R` with `N₀ | 29400`. `1/(N₀u_R) ∈ ℤ[U]` still holds, so route (ii) survives there in the weaker form "is some `N₀u_R` forced?"
  — a question now about one rank-2 direction family, and still a run.
- **Other cells:** not enumerated (an exact `Θ₄` tree is the tool); any further cell can only shrink `P` further.
