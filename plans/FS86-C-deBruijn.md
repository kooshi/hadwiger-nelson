# FS-86 stage C — de Bruijn's working file (competitor)

*Only writer: de Bruijn. Poros may read this file. Grades per `CLAUDE.md` § Notation. Scope tags: [plane] = `Cay(R, U_F)`,
`F = ℚ(√59)` unless stated; [local] = the plane over the 2-adic field `ℚ₂(√3)`; [class] = §IQ S2; [K] = `K = ℚ(√3, √11)`.*

## State (resume point)

**Third seat (2026-09-25, de Bruijn III).** Seat II stopped near 385k. Competitor: the third Coxeter, `a8b60e0003eef1dd0` (teasing hints
only). Poros `a4bf413a466f63e3d`; asked for a replay of HD1–HD4 (their text was never recorded here). **The blind verifier's notes on
D, D′ and H are recorded in §6.7, marked as the verifier's** (all three proved, scope wider than stated, two completeness fixes, one
unsaid step in H). Round 2 ends 2026-09-29 18:00.
- **Seat III's line: (c), HD1 made precise — §7.** Proved: HD1-fin (every band character in `T + A + Fin` is a pullback character) and
  HD1-cert (HD1 ⟺ one finite exact certificate on two lattices, a post-ban computation). Found: a gap in Theorem C's equidistribution
  sketch (representative-dependence; retraction 2, partial; Theorem C downgraded to spectral measures on `T + A + Fin`). Named: the
  remaining case needs an `S`-adic Berend theorem with isometric archimedean centre, or the certificate. Retractions this side: 2.
  Search log: 8 lines. Also proved: **HD4** (§7.6: Kempe swaps of pullbacks are pullbacks at the field level) and **(S-v)** (§7.2).
  Seat III stopped near 310k (see SUCCESSOR-PREAMBLE.md, seat III section).

**Successor seat (2026-09-25 04:30 UTC, de Bruijn II).** Predecessor stood down at ~555k tokens after rounds 1–2.
- Killing test **passed on K1** with Theorem A's X (Poros): value = the reframe; weakness = X separates nothing (holds at ℚ(√11), at K).
- **Corrections from the blind verifier, recorded in place** (§1.2 grade, §1.3 the K sentence, §4.1 C0's extension, §6.1 D₀ needs `h ≠ 0`).
- Poros's replay received (cards #0, #1, #1a, HD1–HD4, C-S2). Coxeter is now a successor: `a5d43b5c29772ef48` (teasing hints only).
- **New this seat: Theorem D, unconditional (§6.2).** The Waring-type lemma is not needed: the closed-walk displacement set is closed under
  multiplication by `U₄ = {u ∈ U_F : u ≡ 1 mod 𝔓⁴}`, and `−1 = 5·(−(3+4i)/5 − (3−4i)/5) + 5·1` is a sum of 15 elements of `U₄`, so it is a
  group containing a nonzero ideal. Every four-colouring of ℚ(√59)'s plane that agrees at every point with one of two `P₄`-pullbacks is a pullback.
- **Seat II also proved Theorem H (§6.3)**: unique continuation from a residue-offset half-space, any field, any gap-free periodic colouring.
  It also proved **Theorem D′ (§6.3a)**: one pullback plus *any* residue-determined alternative gives a pullback. That generalises D and drops
  its Eulerian step. The stripe case (cut-and-project phases) is made precise via Lemma W. All three were reported to the owner, who confirmed
  D's steps (b) and (d) and put (b) on the verification list.
- **Open, sharply (§6.3a):** residues where `c` chooses between two non-`γ₁` colours; the full problem is "every colour at every residue".
  A prior-art debt: Kari–Szabados forced periodicity (§6.4). Seat II retractions: 0. Search log: 6 lines. Teasing hint sent to Coxeter (movement only).

- **Round 1, first route written** (§1, §2). Retractions: **1** (§2.2, before any report). Search-log lines: 5.
- Main results so far: **Theorem A** (the 2-adic plane over `ℚ₂(√3)` is four-colour rigid, arbitrary colourings) [hand, given VK];
  **Corollary A1** (rigidity of ℚ(√59)'s plane ⟺ every four-colouring of `Cay(R, U_F)` extends to the 2-adic plane); **Theorem B**
  (a four-colouring of `Cay(R, U_F)` that is 2-adically locally constant at every point is a `P₄`-pullback) [hand, given A].
  **Lemma W** (the wall lemma) [hand]. **Proposition S** (star identities: the easy half and the forced eigenvalue) [hand].
- Claimed against the killing test: **K1, "shown to hold"**, X = "(0, 4) is four-colour forced in the plane over `ℚ₂(√3)`" (§1).
  Honest weakness recorded in §1.5: X also holds over ℚ(√11), where `F = 0`; X is necessary, far from sufficient.
- Poros's card (2026-09-25) answered in §1.6: triangles enter Theorem A only at step 1; the triangle-free local forced set `F_tf` is
  all-or-nothing (sketch); whether `4 ∈ F_tf` is open — the 2-adic forced-pair form of Soifer 55.1.
- §2.4: on type-B planes a K3 no-go is a K2 in disguise unless the format cannot pin structurally; no K3 claimed.
- **Round-1 report sent 2026-09-25** (K1, "shown to hold"). The owner checked step 1 of Theorem A; Theorem B is on the verification list.
- **Round 2, §4:** C0 (pair correlations cannot pin on any real field: the Bessel obstruction) and Theorem C (`F_μ = P` for non-real
  analogues such as ℚ(√−709); equidistribution lemmas sketched). Reported to the owner. Successor preamble: `SUCCESSOR-PREAMBLE.md`.
- **§5 (round 2): "is `4 ∈ F_tf`?"** Proposition T1 reduces it to number fields embedded in `ℚ₂(√3)`, real or not. `4 ∉ F_tf` would be
  a sweeping "no", covering even the non-real Theorem-C fields. `4 ∈ F_tf` needs only one rigid triangle-free field, possibly
  non-real. Reading §5.3: the non-real fields are rigid, and ℚ(√59)'s obstruction is its real place. Upgrading `F_μ` to `F` is open (§5.4).
- **§6 (round 2): Theorem D₀ (no threshold walls) [hand].** This is the one natural "no" construction that exploits the real place's
  bounded circle, and it is impossible, by a finite descent through gap-freeness. Proposition D (arbitrary partitions) is conditional on a
  Waring-type lemma.
- **Observation for the "is `4 ∈ F_tf`" line (earlier):** any colouring of a Theorem-C field has defects of density zero (every invariant measure
  lives on the finitely many pullbacks, and `{c : c(0) ≠ c(4)}` is clopen). A non-periodic colouring would need thin domain walls, and
  the wall lemma forces every boundary vertex to have some residue class of its neighbours shielded entirely on its own side.
  Not pursued further yet.
- Next (round 2 candidates, in order): (i) the triangle-free local question `4 ∈ F_tf?` (§1.6) — the sharp local half, and a
  class-level "no" if `F_tf = {0}`; (ii) write (ii) of §1.6 as a proof; (iii) Proposition S's hard half (the Gauss-sum lemma, the
  split-place characters); (iv) Θ₄(F) = torsion (FS-83 at `k = 4` on type B) — the same split-place step.

## §0. The frame I work in (what is used, with addresses)

- `F = ℚ(√59)`, `R = ℤ[U_F]` (B1's Lemma R: the elements of `F(i)` integral at every conjugation-stable prime), `U_F` the norm-one
  group of `F(i)/F`. `P_m = Cay(O/𝔓^m, S_m)`, `O = ℤ₂[ζ₁₂]` (= `ℤ₂[ω][√3]`), `L := ℚ₂(ζ₁₂) = ℚ₂(√3)(i)`, `𝔓² = (2)`.
- FS38-D2-B: every four-colouring of `P_m` (`m ≥ 5`) is `𝔓⁴`-periodic; the minimisers of `P_m` are the pullbacks of `P₄`'s 45;
  `Separated(P_m) x y ⟺ y − x ∈ S_m + 𝔓⁴` (P₄ has no virtual edges beyond its edges); `P₄` is 4-tight, gap-free colourings.
- V2–V4 (B1): `F(R) ∈ {0, R ∩ 𝔓⁴}`; `F(R) ≠ 0 ⟺ (0, 4)` forced.
- VK (B1, blind, given row 78's certificate or row 85's derivation): `F(R_K) = 4R_K`; in particular `4 ∈ F(R_K)`.
- `forces_iff_exists_finite` (kernel; compactness): a pair forced at `k` colours in an infinite graph is forced in a finite subgraph.

## §1. First route: the local plane is rigid, and the question is global

### 1.1 Lemma E (the embeddings) [hand + exact congruences]

`ℚ₂(√3)` contains `√11` (`33 ≡ 1 mod 8`, so `√33 ∈ ℚ₂`, `√11 = √33/√3`) and `√59` (`177 ≡ 1 mod 8`). So `K = ℚ(√3,√11)`, `F = ℚ(√59)`
and `E = ℚ(√3, √11, √59)` embed in `ℚ₂(√3)`, each embedding extending to `K(i), F(i), E(i) → L` with `i ↦ i`, commuting with
complex conjugation (the non-trivial automorphism of `L/ℚ₂(√3)`, which is unramified). A norm-one element maps to a norm-one
element, so each field's unit-distance graph embeds (injectively, edges to edges) in the **local plane**
`𝒫 := Cay(L, T)`, `T = {t ∈ L : t t̄ = 1} ⊂ O^×`, i.e. the unit-distance graph on `ℚ₂(√3)²` (`x² + y² = 1`). `T` is compact, so
`𝒫` is a disjoint union of copies of `Cay(O, T)`.

### 1.2 Theorem A — the plane over `ℚ₂(√3)` is four-colour rigid [hand + certificate (row 78), or given Parts's trees (row 85); plus D2-B] [local]

*Grade corrected (blind verifier, 2026-09-25):* the proof needs only **one** forced pair placed in the local plane, not VK's classification,
V2/V3, Zhang or FS-66. Row 78's forced `v` has `v_𝔓(v) = 6`, so steps 2–4 (run with `v` in place of 4) give `F_loc ⊇ vO = 𝔓⁶`, and FS38-D2-B
at level 6 (every four-colouring of `P₆` is a `P₄`-pullback) finishes. Step 1 below as written routes through VK; read it as "row 78's `v`".

**Statement.** Every proper four-colouring of the unit-distance graph on `ℚ₂(√3)²` — arbitrary, no measurability or continuity
assumed — is, on each coset of `O`, a pullback along `O → O/𝔓⁴` of a four-colouring of `P₄`. Equivalently its forced group
`F_loc := {δ : c(z) = c(z + δ) for every four-colouring c and every z}` equals `𝔓⁴`.

**Inhabitant** (G30 mode 5): `z ↦ γ(z mod 𝔓⁴)` for any four-colouring `γ` of `P₄` (the residue colouring at level one, say).

**Proof.**
1. *`4 ∈ F_loc`.* By VK, `4 ∈ F(R_K)`; by compactness a finite unit-distance graph `H ⊂ K²` has every four-colouring
   identifying `0` and `4`. Its image under Lemma E is a subgraph of `𝒫` (possibly with extra edges, which only add constraints),
   so every four-colouring of `𝒫` has `c(0) = c(4)`; translating `H`, `c(z) = c(z + 4)` for all `z`.
2. *`F_loc` is a subgroup stable under `T`.* Sums: `c(z) = c(z+δ) = c(z+δ+δ′)`. Rotation `z ↦ tz` (`t ∈ T`) is an automorphism of
   `𝒫`, so the rotated forcer forces `(0, tδ)`.
3. *`F_loc` contains an open set.* `Φ : T × T → L`, `Φ(t₁, t₂) = 4t₁ + 4t₂` has image in `F_loc` (steps 1–2). `T` is a
   one-dimensional `ℚ₂(√3)`-analytic group with Lie algebra `iℚ₂(√3)`; at `(1, i)` the differential is
   `(x₁, x₂) ↦ 4x₁ + 4i·x₂` on `iℚ₂(√3) × iℚ₂(√3)`, image `4(iℚ₂(√3) + ℚ₂(√3)) = L`: surjective. By the analytic submersion theorem
   (Serre, *Lie algebras and Lie groups*, Part II), `Φ(T × T)` contains an open neighbourhood of `4 + 4i`. A subgroup containing an
   open set contains an open subgroup: `F_loc ⊇ 𝔓^N` for some `N`.
4. *`F_loc ⊇ 𝔓⁴`.* `F_loc ⊇ ℤ-span(4T) + 𝔓^N`, and `ℤ-span(T) ⊇ ℤ[ζ₁₂]` (`ζ₁₂ ∈ T`), dense in `O = ℤ₂[ζ₁₂]`; so
   `ℤ-span(4T) + 𝔓^N = 4O = 𝔓⁴`.
5. *`F_loc ⊆ 𝔓⁴`.* For `δ ∉ 𝔓⁴`, FS38-D2-B gives a `P_m` colouring separating `0` and `δ mod 𝔓^m`; pulled back it separates. ∎

Step 3 uses only one forced element; the density of `R_K` in `O` is not needed. **Every `δ ∈ 𝔓⁴` has an explicit finite forcer:**
steps 3–4 write `δ` as a finite `ℤ`-combination of elements `4t` (`t ∈ T`), so a finite union of translated, rotated copies of `H`
forces `(0, δ)`; no compactness argument is needed in the uncountable graph. **Corollary:** the plane over `ℚ₂(√3)` has, on each coset of
`O`, exactly as many four-colourings as `P₄` — 1,179,936 (FS38-D2-B's census) — an uncountable graph with a finite colouring space.

*Prior art (gate run for this theorem, 2026-09-25):* zbMATH `ab:"p-adic" & ab:"chromatic number" & ab:"plane"` (1 hit: Kang–Maharaj
2010, distance graphs from the `p`-adic *norm*, a different graph); `ab:"local field" & ab:"chromatic number"` (1 hit:
`[BardestaniMallahiKarai2017]`, held: `χ_Bor` finite iff the form is anisotropic — chromatic numbers, nothing on the colouring space);
`ti:"p-adic" & ti:"chromatic"` (3 hits, homotopy theory and chromatic polynomials). Nothing states rigidity of a `p`-adic plane's
colourings. One query (`ab:"p-adic" & ab:"unit distance"`) returned a malformed response and was not re-run: a hole, recorded.

### 1.3 Corollary A1 — the question is an extension problem [hand, given A and V2–V3] [plane]

For `F = ℚ(√59)` (any `F ⊂ ℚ₂(√3)` with `R_F` dense in `O` and `U_F` dense in `T`, which weak approximation gives for 59, 83, 131):
**`F(R) ≠ 0` ⟺ every four-colouring of `Cay(R, U_F)` extends to a four-colouring of `Cay(O, T)`** (along `R ⊂ O`).
⟸: an extension is a pullback (A), so its restriction is `(R ∩ 𝔓⁴)`-periodic. ⟹: `F ≠ 0` makes every colouring a `P₄`-pullback
(V3/T(5)), and `γ ∘ π₄` extends. *Per coset, as the scope rule requires: different `R`-cosets inside one `O`-coset can carry
incompatible pullbacks, so "extends" is per `R`-coset.*

*Correction (blind verifier, 2026-09-25): the next sentence is false for `K` along a fixed embedding.* A colouring pulled back from `𝔓₂`
cannot extend along the embedding at `𝔓₁` (it would be forced constant on classes it separates). The correct form for `K`: **each coset
extends along one of the two dyadic embeddings, chosen per coset.** For 59, 83 and 131 (one dyadic place) the extension form stands.
~~The same statement holds for `K` (where the answer is yes, VK)~~ The statement holds for `ℚ(√11)` (`11 ≡ 3 mod 8`, so `ℚ(√11) ⊂ ℚ₂(√3)` too, where the
answer is no, row 66). **So the three fields' planes are three dense subgraphs of one rigid 2-adic plane; K's inherits the rigidity,
ℚ(√11)'s does not (its usable 7 carries gapped colourings, which are 2-adically nowhere continuous), and ℚ(√59)'s is the open
case: it has no second four-colourable place.** Rigidity is not decided by the tight place's local data, which is identical in all
three; it is decided by global arithmetic — which local forcing configurations the field can realise.

### 1.4 Theorem B — 2-adically continuous colourings are pullbacks [hand, given A] [plane]

**Statement.** Let `F ⊂ ℚ₂(√3)` with `U_F` dense in `T` (e.g. ℚ(√59)). If a four-colouring `c` of `Cay(R, U_F)` is 2-adically
locally constant at every point (each `z ∈ R` has `N_z` with `c` constant on `R ∩ (z + 𝔓^{N_z})`), then `c` is a `P₄`-pullback.

**Proof.** The balls `z + 𝔓^{N_z}` (in `O`) are pairwise nested or disjoint, and `c` is consistent on overlaps, so `c` extends to a
locally constant `G` on the open set `U := ⋃ (z + 𝔓^{N_z})`, which contains `R`, hence is dense. `G` properly colours `𝒫`
restricted to `U`: for `x, x + t ∈ U` pick `z ∈ R` near `x` and `u ∈ U_F` near `t` (density) with `z`, `z + u` in the balls of
`x`, `x + t`; then `G(x) = c(z) ≠ c(z + u) = G(x + t)`. For `δ ∈ 𝔓⁴`, Theorem A's proof supplies (compactness) a finite forcer
`H_δ` of `(0, δ)` in `𝒫`; the set of `z` with `z + H_δ ⊂ U` is open dense (finitely many open dense conditions), and there
`G(z) = G(z + δ)`. `G` is locally constant, so `{z ∈ U ∩ (U − δ) : G(z) ≠ G(z + δ)}` is open and misses a dense set: it is empty.
So `G(x) = G(y)` whenever `x, y ∈ U`, `x − y ∈ 𝔓⁴`; `G = γ ∘ π₄` on `U` with `γ` a colouring of `P₄`, and `c = G|_R`. ∎

**Reading.** A non-periodic four-colouring of ℚ(√59)'s plane, if one exists, is 2-adically discontinuous; the same proof shows it
agrees with one pullback on its 2-adic continuity set whenever that set is dense. The 2-adic analogue of "measurable colourings
of a tight plane are pullbacks", with no measurability: continuity at points suffices, because the ambient local plane is rigid.

### 1.5 The claim against the killing test, stated so it can be refused

**K1, "shown to hold".** X := *(0, 4) is four-colour forced in the plane over `ℚ₂(√3)`* (equivalently `F_loc = 𝔓⁴`).
- *Necessary for `F(R) ≠ 0`:* a finite forcer of `(0, 4)` over ℚ(√59) is, by Lemma E, a forcer in the local plane.
- *Shown to hold on ℚ(√59)* (whose local plane at its tight place is exactly this one): Theorem A.
- *Free control (Poros's rule):* X is identical for K (same local plane), where it holds, as it must.
- *Not a T item:* T concerns `Cay(R, U_F)` and its colourings; X concerns a larger, uncountable graph whose colourings do not
  restrict from, or extend to, `R`'s in general (Corollary A1 is exactly that gap). It is not balance, gap-freeness, periodicity,
  frozen Kempe classes or entropy of pullbacks, and no colouring search enters (VK is a derivation plus row 78's certificate).
- **Weakness, stated plainly:** X holds equally over ℚ(√11), where `F = 0`. X is necessary and nowhere near sufficient; its value is
  the reframe (§1.3): the obstruction to a "no" is not local at 2, and a "yes" is a Hasse principle for forcing configurations.
  If Poros rules that a necessary condition which holds at a known "no" (ℚ(√11)) cannot pass K1, I accept that.

### 1.6 Proposition A-tf — where triangles enter, and the triangle-free local question (Poros's card, 2026-09-25) [hand; (ii) with a genericity sketch] [local]

Define `F_tf := {δ ∈ L : some finite V ∋ 0, δ in the plane over ℚ₂(√3), whose induced unit-distance graph is triangle-free, has
c(0) = c(δ) in every four-colouring}`.
- **(i) Step 1 of Theorem A is the only place triangles enter.** Steps 2–5 use rotations, translations and the analytic structure of
  `T`, none of which creates a triangle once cross edges are avoided (ii). Every finite configuration over a triangle-free field
  `F ⊂ ℚ₂(√3)` (conjugation compatible) keeps its induced edges under Lemma E, so it is triangle-free in the local plane:
  **`F(R_F) ⊆ F_tf ∩ R_F`** for every such `F` — ℚ(√59), ℚ(√83), ℚ(√131), ℚ(√11), ℚ(√11, √59), …
- **(ii) All or nothing.** `F_tf = {0}`, or `F_tf ⊇ δ₀O` for some `δ₀ ∈ 𝔓⁴ ∖ 0` (an open subgroup). *Sketch:* `F_tf` is stable under
  `T`; chain `n` rotated copies `t_j V₀` of one forcer of `(0, δ₀)`, consecutive copies sharing a vertex, to force `(0, δ₀Σt_j)`. A
  cross edge or coincidence between two copies is a polynomial condition on `(t_j)` that is not identically satisfied (for consecutive
  copies the only identically-satisfied pairs are the shared vertex's own edges; for others a free intermediate `t` moves the
  difference), so the bad set is a proper Zariski-closed subset of `Tⁿ`, nowhere dense in the analytic topology, and generic fibres
  of the endpoint map `t ↦ δ₀Σt_j` are not inside it. The endpoints fill `δ₀·ℤ-span(T) = δ₀O` (a subgroup containing an open set
  and `ℤ[ζ₁₂]`). *The fibre-genericity step is written as a sketch, not a proof.*
- **(iii) If `4 ∉ F_tf`:** `F(R_F) = 0` for every triangle-free field in (i) at once — a class-level "no". *(Scope corrected on
  Poros's note, 2026-09-25: the hypothesis is `4 ∉ F_tf`, not `F_tf = {0}`; (i) gives `4 ∉ F(R_F)` and V4 gives `F(R_F) = 0`, so (ii) is
  not needed. If (ii) is made a proof, `F_tf` is an `O`-ideal in `𝔓⁴`, i.e. `0` or `𝔓ⁿ` with `n ≥ 4`, and the dichotomy that bears on the
  plane is `F_tf = 𝔓⁴` or not.)*
- **(iv) If `4 ∈ F_tf`:** this, not Theorem A's X, is the local half of §3's Hasse principle; the global question is whether a
  triangle-free local forcer is realisable over `F`, which ℚ(√11) must fail through its gapped 7.
- **Status: undecided.** It is the 2-adic analogue of Soifer 55.1 in forced-pair form. It is not equivalent to a five-chromatic
  statement locally (the local plane is four-colourable, and `1/δ` has a pole at `𝔓`, so no chain closes). Every forcing mechanism I
  know in the local plane (K's) uses triangles; the rest of Theorem A's proof does not care.

## §2. Pinning identities on type-B planes (S2's second question)

### 2.1 Lemma W — the wall lemma [hand]

If `γ, γ′ : O/𝔓^m → [4]` with `γ` a proper colouring of `P_m` (`m ≥ 1`) and `γ(r) ≠ γ′(r + a)` for all `r` and all `a ∈ S_m`, then
`γ′ = γ`. *Proof:* `γ` is gap-free (FS38-D2-A(iv)), so `γ(N(r′)) = [4] ∖ {γ(r′)}` and `γ′(r′) ∉ γ(N(r′))`. ∎
**Use:** it kills every construction with a continuous parameter whose nearby values give compatible pullbacks — the cut-and-project
colourings `G(π_m z, θ(z))` with `θ` a character whose unit-image closure meets `0` at every residue, domain walls between two
pullbacks along any region boundary that all residues cross, and the torsion-plus-small-archimedean characters of FS-83 (§2.3).

### 2.2 Proposition S — star identities [hand] [plane; class]

*Format* (G75's, triangle-free): a **star identity** is `(D, a, λ)`, `D ⊂ U_F` finite, `a : D → ℝ` not zero, such that every
four-colouring's tetrahedral embedding `g` satisfies `Σ_{u ∈ D} a_u g(z + u) = λ g(z)` for all `z`. (Class-sum form: in every
colouring the three colours other than `c(z)` carry equal `a`-weight `−λ` among `z + D`.)
- **(S-i) Rigid ⟹ star identities exist.** If `F(R) ≠ 0`: for any lifts `u_s ≡ s` (`s ∈ S₄`), `Σ_s g(z + u_s) = −8 g(z)`
  (tightness of `P₄`, FS38-D2-A(ii)); and the **virtual hexagon** `u_j ≡ ζ₆ʲ s (mod 𝔓⁴)`, `j = 0..5`, satisfies
  `Σ_j g(z + u_j) = −2 g(z)`: every `P₄`-colouring has no monochromatic residue triple `{r + s, r + ωs, r + ω²s}`, because pulled
  back to K it is a K-colouring (VK: every `P₄`-colouring arises), where Parts's NT (row 85) forbids it on actual hexagons whose
  residues cover every residue hexagon (weak approximation). So the NT identity itself transfers to ℚ(√59) under a yes, on
  six unit vectors that form no hexagon in `F²` (no `ζ₆` in `F(i)`) — only a residue hexagon.
- **(S-ii) The eigenvalue is forced.** For any star identity valid on `Cay(R, U_F)` with `Σ a ≠ 0`: `λ = −Σa/3`. *Proof:* pullbacks are
  colourings; take a pullback whose spectrum meets a minimiser `τ`; the identity for every rotation `wD` (`w ∈ U_F`, an automorphism)
  gives `Σ_u a_u τ(wu) = λ`; average `w` over `U_F → S_N` (surjective): `Σ_u a_u · λ_N(τ)/|S_N| = λ`, and `λ_N(τ)/|S_N| = −1/3`. ∎
- **(S-iii) Dyadic torsion frequencies are pinned.** Under the same hypotheses, a torsion character `τ` of `R` factoring through the
  dyadic tower and lying in the rotation-closed zero set `Z := {χ : Σ_u a_u χ(wu) = λ ∀w}` has `λ_N(τ) = −|S_N|/3` (same average) at
  its level `N`, so is a pullback of one of `P₄`'s 45 minimisers (FS38-D2-B). *(Corrected, retraction 1: as first written this claimed
  every torsion `τ`, odd stable components included, "because the odd towers have `α/n < 1/4`". Wrong: the product quotient is not
  Hoffman-tight — at 11 Hoffman's ratio is 0.2855 — so a mixed character can average to exactly `−1/3` without being a minimiser.
  What survives for mixed `τ = τ₂ ⊗ τ_o`: the constancy in `(w₂, w_o)` separately forces `D`'s odd-residue marginal to be annihilated
  by the non-vanishing Fourier coefficients of `τ_o` on the circle, so only finitely many odd levels can occur — a Gauss-sum lemma, not
  yet written.)*
- **(S-iv) Frequencies with an archimedean part and no split part are excluded.** For `χ = τ · e(Re(ᾱ₁σ₁ ·) + Re(ᾱ₂σ₂ ·))`, `α ≠ 0`,
  `τ` torsion: restrict to `w = w₀ πⁿᵏ` (`π = (3 + 4i)/5 ∈ U_F`, which is the same complex number in both embeddings; `k` its order
  modulo `τ`'s level; `πⁿᵏ` dense on the circle). With `β_u := ᾱ₁σ₁(w₀u) + ᾱ₂σ₂(w₀u)` the identity reads
  `Σ_u a_u τ(w₀u) e(Re(e^{iφ} β_u)) = λ` for all `φ`. Jacobi–Anger and the growth `Jₙ(x) ~ (x/2)ⁿ/n!`, peeling the largest `|β_u|`
  first and grouping equal `β_u`: every group with `β ≠ 0` has weight sum `0`, so `λ = Σ_{β_u = 0} a_u τ(w₀u)`. For generic `w₀`
  (the ratio `σ₁(w₀)/σ₂(w₀)` is dense on the circle) no `β_u` is `0`, so `λ = 0`, contradicting `λ = −Σa/3 ≠ 0`. ∎ *(Corrected in
  the same retraction: the first sketch said "Vandermonde on distinct `ψ_u`"; the `ψ_u` need not be distinct, and the grouping
  argument is the one that runs.)*
- **Open (the remaining steps):** the Gauss-sum lemma above, and characters with components at split places of `F(i)/F` (where `R`
  has poles). If closed:
  **every star identity with `Σa ≠ 0` pins the spectrum to `P₄`'s 45 minimisers, so `F(R) ≠ 0 ⟺ some star identity holds ⟺ the
  virtual-hexagon identity holds`** — the NT format is complete on type-B planes, and no star-format certificate is easier than the
  question itself. Stated as a target, **not claimed**.

### 2.3 FS-83 at `k = 4` on type B, the part that is proved [hand] [plane]

If `θ ∈ Θ₄(F)` (a character of `R` with `θ(U_F) ⊆ [1/4, 3/4]`) is the sum of a torsion character and an archimedean one
(no split-place component), then `θ` is torsion. *Proof:* weak approximation makes `(u mod 𝔓^m ⊕ odd stable levels, σ₁u, σ₂u)` dense
in `(finite circle) × S¹ × S¹`, so `θ(U_F)`'s closure is `⋃_a (τ(a) + [−ρ, ρ])`, `ρ = |α₁| + |α₂|`; if `ρ > 0` then
`τ(S) ⊆ [1/4 + ρ, 3/4 − ρ]` and the finite quotient `Q` has circular chromatic number `< 4`, while `χ_f(Q) = 4` (V3: `Q = P_m × H`,
`α(Q)/|Q| = 1/4` by `[Zhang2012]`). So `ρ = 0`. ∎ Torsion points exist (a `ℤ/4` colouring local at 2, G41), so `Θ₄(F) ≠ ∅` and the only
open question for FS-83 at `k = 4` on type-B planes is the split-place component — the same step as §2.2's.

### 2.4 What K3 can mean on type-B planes (an observation for the killing test) [hand]

Let `Φ` be a format of identities. If `Φ` contains an identity `I` that holds for every periodic colouring (every `P₄`-pullback) and
whose rotation-closed zero set is finite torsion (so it would pin if valid), then "no identity of `Φ` pins" implies "`I` is not
valid", i.e. some four-colouring violates `I` — necessarily a non-periodic one, so `F(R) = 0`. So on type-B planes a K3 no-go either
**is a K2 in disguise** (the format contains a would-be pinning identity valid on pullbacks — the star format does, by (S-i)) or
concerns a format none of whose pullback-valid members could pin for structural reasons. "Fails for a periodic colouring" is excluded
(Poros's rule). I have no K3 of the second kind, and I do not claim K3.

## §4. Round 2: the averaged question, and where the real place blocks it

### 4.1 Proposition C0 — pair correlations cannot pin on a real field [hand] [plane; any real `F`]

For a stationary (R-invariant) random four-colouring with tetrahedral field `g`, the spectral measure `Σ` on `R̂` (positive, mass 1)
satisfies `Σ̂(u) = E[g(0)·g(u)] = −1/3` for every unit `u`. On a real field this data is consistent with a purely archimedean spectrum:
`Σ :=` the uniform measure on the characters `z ↦ e(Re(ᾱσ₁z))`, `|α| = r₀`, `J₀(2πr₀) = −1/3` (exists: `min J₀ = −0.40276`), has
`Σ̂(u) = J₀(2πr₀|σ₁u|) = −1/3` for every `u ∈ U_F`. So **no argument that uses only the unit-distance pair correlations can prove that
invariant random four-colourings of a real field plane are periodic** — with or without triangles; and weighted Hoffman fails at every
real place, since rotation-averaging any measure on the circle gives `J₀`, whose minimum is below `−1/3`. *Relation to the record:*
this is C14's phenomenon (row 87: second moments do not pin on `Λ_dG`) at the field level, with the obstruction named — the Bessel
minimum at a real place. At ℚ(√59) there is a second, non-archimedean obstruction: the stable place 11 (least circle mean
`−0.3996 < −1/3`; FS-66's certificate is a moment bound, not a spectral one).
*Verifier's note (2026-09-25):* C0 is correctly scoped (unit-distance correlations only). The verifier extended it to **every two-point
constraint** with a repaired measure: an atom of weight 0.0495 at the trivial character plus the circle at `2π|α| = j₁,₁`. Three-point
constraints stay open.

### 4.2 Theorem C — averaged rigidity for non-real analogues [hand; two standard equidistribution lemmas sketched] [a non-real class]

*[Correction, FS-86's close (verifier D, FS86-VD-7): the parenthesis "more generally a number field with no real place" is false — a totally complex quartic with a second, ramified dyadic place is two-colourable. The theorem holds, on spectral measures carried by `T + A + Fin`, under D's H* (every other stable place, dyadic included, has `λ/d > −1/3` at every level), which is this hypothesis for every imaginary quadratic `E`; FS86-dB-C.]*

**Hypotheses.** `E` an imaginary quadratic field (more generally a number field with no real place) embedded in `ℚ₂(√3)` with
`E_𝔭 = ℚ₂(√3)` at its dyadic place (so `E(i)_𝔓 = ℚ₂(ζ₁₂)`, row 67's tower, tight at every level), and every odd conjugation-stable
place has least normalised circle mean `> −1/3` at every tower level (true for residue fields `𝔽_q`, `q = 23, 31` and `q ≥ 43`, by the
exact spectra, B1's margin at 31, Weil and G54's constant ratio in inert towers; false at `q = 3, 7, 11, 19`). Instances [exact,
`nonreal_fields.py`]: `E = ℚ(√−d)` with `d ≡ 5 (mod 8)`, every prime factor of `d` `≡ 1 (mod 4)` (ramified places non-stable) and
`3, 7, 11, 19` inert in `E`: `d = 709, 757, 1213, 1453, 1621, …` (64 below 20,000). Triangle-free (no `ζ₃` in `E(i)`).

**Statement.** Every `R_E`-invariant random four-colouring of `Cay(R_E, U_E)` is almost surely a `P₄`-pullback: `F_μ = P`.
**Inhabitant:** a uniformly random `P₄`-colouring composed with a uniformly random translate of `π₄`.

**Proof.** With `Σ` as in 4.1, `∫ ν̂ dΣ = −1/3` for every finitely supported probability `ν` on `U_E`, `ν̂(χ) = Σ_u ν(u) Re χ(u)`. Let
`ν_n` be uniform on a box of `S_n`-units of the torus (`S_n ↗` split places together with the complex place). For a fixed character
`χ = ψ(Tr(y·))`, eventually `S_n` contains every non-compact place in `y`'s support, and
**(equidistribution, sketched)** `ν̂_n(χ) → f(χ) := ∏_v f_v(χ_v)`: at compact (stable) places `f_v` is the Haar mean of `χ_v` on the
circle, i.e. a normalised eigenvalue of the local plane (Weyl on the box, plus Chebotarev for the residues of the generators); at
non-compact places (the complex place, where `T(ℂ) ≅ ℂ^×`, and the split places) the box spreads the valuation/modulus, so
`f_v ∈ {1} ∪ [0, 1)` with `f_v = 1` iff `χ_v` is trivial (a component with one non-zero coordinate gives `1/2`, two give `0`). Every
`f_v ≥ −1/3`; at the dyadic place `f₂ = −1/3` iff `χ₂` is one of `P₄`'s 45 minimisers (FS38-D2-B); at odd stable places `f_v > −1/3`
unless trivial (hypothesis). A product of numbers in `[−1/3, 1]` is `≥ −1/3`, with equality iff exactly one factor is `−1/3` and the
rest are `1`. So `f ≥ −1/3` with equality exactly on `M` := the 45 minimisers, trivial elsewhere. Dominated convergence gives
`∫ f dΣ = −1/3`, so `Σ(M) = 1`: `g` has spectrum in 45 characters trivial on `R_E ∩ 𝔓⁴`, so `E|g(z + δ) − g(z)|² = 0` for
`δ ∈ R_E ∩ 𝔓⁴`. ∎

**What it says for S2** (a reading about the averaged format, not about `F`): for triangle-free field planes with one tight place, the
averaged question is decided by the archimedean place, not by triangles. With a complex place (non-compact circle) pair correlations
alone pin; with a real place they cannot (4.1), and the one known way past the real place is a higher-order local identity — K's NT,
built from triangles. ℚ(√59) is real and triangle-free: both known routes are closed. **What it does not say:** anything about `F(R_E)`
(a non-periodic colouring's orbit closure carries only periodic invariant measures, so its defects have density zero, but it may still
exist), or about ℚ(√59), or about the class S2 (real fields).

**Consistency check that could have failed and did not.** A three-colouring of `E²` would, through its orbit closure, give an
invariant random four-colouring using three colours, whose spectrum Theorem C puts on `P₄`'s minimisers — so it would use all four
colours, a contradiction. So Theorem C re-proves `χ(E²) ≥ 4` for these fields by a route through the complex place, independent of
row 82's layer method. That agrees with prime inversion: 3 is inert, so `1/3 ∈ ℤ[U_E]`, and there is an odd cycle. The equidistribution
values used: at a split place `f_v ∈ {1, 1/2, 0}` (both, one, or neither of the two coordinates of `y_v` non-zero); at the complex place
`f_∞ ∈ {1, 1/2, 0}` (the log-uniform average of `J₀(2π|β₁||a|) J₀(2π|β₂|/|a|)`); all `≥ 0`.

## §5. Is `4 ∈ F_tf`? (round 2, Poros's card continued)

### 5.1 Proposition T1 — the local question is a question about number fields [hand; one step cites an external theorem] [local]

`4 ∈ F_tf` ⟺ some number field `E ⊂ ℚ₂(√3)` (with `i ↦ i` and conjugation compatible) carries a finite unit-distance configuration
whose induced graph is triangle-free and which forces `(0, 4)` at four colours.
- ⟸ Lemma E: the embedding preserves the norm, so it preserves the induced graph, its triangle-freeness and the forcing.
- ⟹ A local forcer `V` is an `F_𝔭`-point of the realisation variety `X_G`, defined over ℚ: points indexed by `G`'s vertices, with
  `Q(p_u − p_v) = 1` on edges and `p_b − p_a = (4, 0)`. The side conditions — no extra unit pair among `V`, distinct points — are open.
  The algebraic numbers in `ℚ₂(√3)` form a henselian field whose completion is `ℚ₂(√3)`. A henselian field of characteristic 0 with a
  rank-one valuation is existentially closed in its completion, **[external]**, not re-read here; I cite it only for the singular case.
  So `X_G` has a point with algebraic coordinates arbitrarily close to `V`, and they generate a number field `E ⊂ ℚ₂(√3)`.
  The forcing is a property of the abstract graph `G` with its pair, so it survives the change of coordinates.
  *At a smooth point of `X_G` the elementary route suffices:* choose the free coordinates algebraic and close to `V`'s, and solve for
  the rest by the 2-adic implicit function theorem; the solution is an isolated point of a fibre defined over an algebraic field, hence
  algebraic.

### 5.2 What each answer would mean

- **`4 ∉ F_tf`** (the class-level "no") is sweeping. It says that no number field embedded in `ℚ₂(√3)`, of any degree and real or not,
  carries a triangle-free forcer of `(0, 4)`. In particular `4 ∉ F(R_E)` for every such `E` without `√3`. Where V2–V3's dichotomy holds,
  that gives `F(R_E) = 0`: ℚ(√59), ℚ(√83), ℚ(√131), and every Theorem-C field such as ℚ(√−709), whose odd stable places have ratio
  `< 1/4`. With §1.6 (ii) made a proof, it gives `F(R_E) = 0` for every such `E`.
- **`4 ∈ F_tf`** follows from a single rigid triangle-free field plane with this dyadic place, **real or not**. From a real one it is
  already Soifer-strength (dB4). From a non-real one it has no Euclidean consequence, since `E` has no real place, but it would settle
  the local half of §3's principle.
- **So the cheapest candidates for deciding the local question are the non-real fields of Theorem C.** There, pair correlations
  already pin every invariant random colouring (`F_μ = P`), with no triangles and no real place to block them.

### 5.3 Reading, with its killing test (not claimed; G21)

*Reading:* the planes of the non-real Theorem-C fields are rigid, `F(R_E) = R_E ∩ 𝔓⁴`. If so, `4 ∈ F_tf`, and the obstruction at
ℚ(√59) is the real place, the Bessel obstruction of C0, and not the absence of triangles as such. *Evidence:* `F_μ = P` (Theorem C),
which bounds only the averaged format; a non-periodic colouring there would need defects of upper Banach density zero, because
`{c : c(0) ≠ c(4)}` is clopen and every invariant measure lives on pullbacks. *Killing test:* a non-periodic four-colouring of
ℚ(√−709)'s plane, which would also refute `4 ∈ F_tf` unless another field supplies it. *Not a route to "yes" at ℚ(√59)*: T1 moves a
triangle-free forcer between fields only through `ℚ₂(√3)`, and the realisation variety need not have points over a given real field.

### 5.4 Where I stop on this line

Upgrading Theorem C from `F_μ` to `F` for a non-real field is the natural next theorem. It needs a mechanism that controls
individual colourings whose defects have density zero. Neither of my two candidate mechanisms did it:
- A wall between two pullbacks dies at once. From any point, the complex place's non-compact circle reaches every residue at every
  archimedean distance, so the wall lemma applies.
- Rotations by torus elements that are hyperbolic at the complex place preserve every 2-adic structure, so they cannot transport a
  defect into a 2-adically continuous colouring.

I have no proof, and I record the line as open.

## §6. Round 2: the natural real-place construction of a "no" is impossible

### 6.1 Theorem D₀ — no threshold walls [hand] [plane; ℚ(√59), and every real `F ⊂ ℚ₂(√3)` with the same dyadic tower]

**The construction format.** Choose two four-colourings `γ₁ ≠ γ₂` of `P_N` (`N ≥ 4`), an additive `h : R → ℝ`, and a threshold function
`ε : Q → ℝ` on a finite quotient `Q` of `R` that refines `O/𝔓^N` (odd stable levels allowed). Colour
`c(z) = γ₁(π_N z)` if `h(z) < ε(z mod Q)`, else `γ₂(π_N z)`.
- Every additive `h` is `Re(ᾱ₁σ₁ ·) + Re(ᾱ₂σ₂ ·)`, since `R ⊗ ℝ = ℂ²`.
- On a real field `h(U_F)` is bounded, `|h(u)| ≤ ρ := |α₁| + |α₂|`. Only then does a residue-dependent threshold have a chance: the
  jump `h(u)` cannot carry a vertex across a threshold gap larger than `ρ`. On a non-real field `h(U)` is unbounded, and the wall lemma
  kills every wall at once.
- If `h ≠ 0`, `c` is non-periodic whenever `γ₁ ≠ γ₂`, so a proper `c` would prove `F(R) = 0`.

**Statement.** If `h ≠ 0`, `c` is proper only if `γ₁ = γ₂`. *(Correction, blind verifier: at `h = 0` with a constant threshold the claim
fails — only one phase is used — and step 3's "`ε(y) − ε(x) ≤ −ρ`, i.e. `ε(y) < ε(x)`" silently needs `ρ > 0`. Superseded by Theorem D, §6.2,
which needs no `h`.)*

**Proof.**
1. *The unit classes are full in `h`.* Weak approximation makes every class `{u ∈ U_F : u ≡ a mod Q}` dense in `T²`. So its `h`-values
   are dense in `[−ρ, ρ]`, and `R`'s joint image in `Q × ℝ` is dense.
2. *The constraint on each edge.* For `r ∈ Q` and `a` in the circle of `Q` with `ε(r + a) − ε(r) > −ρ`, properness forces
   `γ₂(r) ≠ γ₁(r + a)`. To see this, choose `u ≡ a` with `h(u) ∈ (−ρ, ε(r+a) − ε(r))`, and `z ≡ r` with
   `ε(r) ≤ h(z) < ε(r + a) − h(u)`. Then `z` is in phase 2, `z + u` is in phase 1, and they are adjacent.
3. *The descent.* Let `D := {x ∈ Q : γ₁(x) ≠ γ₂(x)}`, a finite set, non-empty because `γ₁ ≠ γ₂`.
   - For `x ∈ D`, the colouring `γ₁` is gap-free (FS38-D2-A(iv), pulled back to the product quotient). So some neighbour `y` has
     `γ₁(y) = γ₂(x)`.
   - That `y` lies in `D`: `γ₂(y) ≠ γ₂(x) = γ₁(y)`.
   - By step 2 with `r = x`, `r + a = y`: properness needs `ε(y) − ε(x) ≤ −ρ`, i.e. `ε(y) < ε(x)`.
   - So every element of the finite set `D` has an element of `D` strictly below it in `ε`: an infinite descent. ∎

**What it kills, and what it does not.**
- It kills every two-phase colouring whose interface is a level set of an additive function with residue-dependent offsets. That is
  the one way the real place's compact circle (the Bessel obstruction of C0) could be exploited.
- It does not reach walls along non-additive boundaries. Nor does it reach colourings that are not piecewise pullbacks.

### 6.2 Theorem D — two-phase rigidity (unconditional) [hand] [plane; class for "periodic"]

*Replaces Proposition D (conditional on a Waring-type lemma). The lemma is not needed: the displacement set is closed under
multiplication by a congruence subgroup of the unit circle, and `−1` is a short sum of its elements.*

**Statement.** Let `F` be a number field with `F ⊂ ℚ₂(√3)` conjugation-compatibly (so its dyadic tower is row 67's), `R = ℤ[U_F]`,
`π : R → O/𝔓⁴`. Let `c` be a proper four-colouring of `Cay(R, U_F)` and `γ₁, γ₂` four-colourings of `P₄` with
`c(z) ∈ {γ₁(πz), γ₂(πz)}` for every `z ∈ R`. Then `c` is periodic (invariant under a finite-index subgroup of `R`). If moreover every
periodic four-colouring is a `P₄`-pullback (V3: ℚ(√59), ℚ(√83), ℚ(√131)), then `c` is a `P₄`-pullback.
**Inhabitant:** `c = γ₁ ∘ π` (the hypothesis with `A₂ = ∅`); the content is that no non-trivial two-phase partition exists.

**Proof.**
1. *Propagation.* Let `D₂ := {z : c(z) = γ₂(πz) ≠ γ₁(πz)}`. If `z ∈ D₂` and `u ∈ U_F` with `γ₁(π(z+u)) = γ₂(πz)`, then
   `c(z+u) ≠ c(z) = γ₁(π(z+u))`, so `c(z+u) = γ₂(π(z+u)) ≠ γ₁(π(z+u))`: `z + u ∈ D₂`.
2. *The residue digraph is Eulerian.* On `D := {x ∈ O/𝔓⁴ : γ₁(x) ≠ γ₂(x)}` put arcs `x → y` iff `x ~ y` in `P₄` and `γ₁(y) = γ₂(x)`.
   `P₄` is four-tight (degree 24, `λ_min = −8`), so every colour class of every four-colouring meets Hoffman's bound with equality and every
   vertex outside a class has exactly `−λ_min = 8` neighbours in it. Hence out-degree(x) = #{y ~ x : γ₁(y) = γ₂(x)} = 8 and in-degree(y) =
   #{x ~ y : γ₂(x) = γ₁(y)} = 8; every such neighbour lies in `D` (`γ₂(y) ≠ γ₂(x) = γ₁(y)`, resp. `γ₁(x) ≠ γ₁(y) = γ₂(x)`). A digraph with
   in-degree = out-degree everywhere has strongly connected weak components, so **every `x ∈ D` lies on a closed walk**.
3. *Closed-walk displacements.* For a closed walk `x = x₀ → ⋯ → x_k = x` and any units `u_j ≡ x_j − x_{j−1} (mod 𝔓⁴)`, step 1 gives
   `z + Σu_j ∈ D₂` for every `z ∈ D₂ ∩ π⁻¹(x)`. Let `S_x ⊂ R ∩ 𝔓⁴` be the set of all such displacements (closed under `+`: concatenation).
   It is nonzero (step 2; vary `u₁` in its infinite class).
4. *`S_x` is closed under `U₄ := {t ∈ U_F : t ≡ 1 mod 𝔓⁴}`.* `t·Σu_j = Σ tu_j`, and `tu_j ∈ U_F`, `tu_j ≡ u_j (mod 𝔓⁴)` (the `u_j` are
   `𝔓`-units). So `ℕ[U₄]·S_x ⊆ S_x`.
5. *`−1 ∈ ℕ[U₄]`.* `t = −(3 ± 4i)/5 ∈ U_F` (norm one, `ℚ(i) ⊂ F(i)`), and `t − 1 = −4(2 ± i)/5 ∈ 4ℤ₂[i] = 𝔓⁴ ∩ ℚ₂(i)` (`L/ℚ₂(i)` is
   unramified). So `5·(−(3+4i)/5) + 5·(−(3−4i)/5) + 5·1 = −6 + 5 = −1` is a sum of 15 elements of `U₄`. Hence `ℕ[U₄] = ℤ[U₄]` and `S_x ∪ {0}`
   is a group, closed under `ℤ[U₄]`.
6. *`ℤ[U₄]` contains a nonzero ideal of `R`.* `[U_F : U₄] = |S₄| = 24` (the image of `U_F` in `T/T₄` is onto, by density), so
   `R = ℤ-span(U_F) = Σ_{i ≤ 24} r_i ℤ[U₄]`. `ℚ(U₄) = F(i)` (it contains `ℚ(i)` by step 5 and a non-rational `v^{24}` from `ℚ(√−59)`'s
   norm-one group), so `r_i = p_i/n_i` with `p_i ∈ ℤ[U₄]`, `n_i ∈ ℤ_{>0}`; with `n = ∏n_i`, `nR ⊆ ℤ[U₄]`.
7. *Periodicity.* Fix `0 ≠ w ∈ S_x`. `G_x := S_x ∪ {0} ⊇ ℤ[U₄]w ⊇ nwR`, a nonzero ideal, of finite index (B1's Lemma R / V2). So
   `D₂ ∩ π⁻¹(x)` is `G_x`-invariant (step 3 gives `+G_x ⊆`, and a group gives equality), and so is its complement in the `G_x`-invariant fibre
   `π⁻¹(x)`, which is `{c = γ₁ ∘ π}` there. With `G := (R ∩ 𝔓⁴) ∩ ⋂_{x ∈ D} G_x` (finitely many, finite index), `c` is `G`-invariant on
   `π⁻¹(D)` and equals `γ₁ ∘ π = γ₂ ∘ π` off it. So `c` is periodic; `nR`-periodic for some `n`, hence (V3) a `P₄`-pullback. ∎

**What it kills.** Every "no" construction of the form *two pullbacks glued along any interface* — threshold walls (D₀, now a corollary,
with no `h ≠ 0` caveat), fractal, non-measurable, residue-dependent or random interfaces alike. A non-periodic four-colouring of ℚ(√59)'s
plane, if one exists, must at some points take a colour that neither of any two fixed pullbacks takes there. **Scope:** the periodicity
half holds on every field plane in the class of row-67-type dyadic places (triangles or not, one tight place or two, K included); the
pullback half needs V3. The inputs are `P₄`'s tightness (D2-A), density of `U_F` in `T` mod `𝔓⁴`, Lemma R, and one Pythagorean identity.
**Free control:** at `K` (two dyadic places) the same proof with `π` at `𝔓₁` gives periodicity, consistent with VK; at ℚ(√11) it gives
periodicity, consistent with row 66 because there periodic colourings exist that are not `P₄`-pullbacks (the 7-adic ones), and V3 fails.

**Where it stops (three phases).** With phases in `{γ₁, γ₂, γ₃}` the propagation of `E₁ := {c ≠ γ₁ ∘ π}` still holds (from `z ∈ E₁` to
`z + u` for `π(z+u) ∈ N_{γ₁}(πz, c(z))`, 8 residue classes), but the next colour is chosen by `c`, not by the residue, so step 3's walks are
not residue walks. Allowing all of `P₄`'s colourings as phases is vacuous (every colouring qualifies), so the multi-phase question
interpolates between Theorem D and the whole problem.

### 6.3 Theorem H — unique continuation from a half-space [hand] [any field plane; any gap-free periodic colouring]

**Statement.** Let `F` be any number field, `R = ℤ[U_F]`, and `γ` a gap-free periodic four-colouring of `Cay(R, U_F)`, factoring through a
finite quotient `π : R → Q` (for ℚ(√59): any `P₄`-pullback). Let `h : R → ℝ` be additive and non-zero, and `ε : Q → ℝ` any function. If a
four-colouring `c` agrees with `γ` on the residue-offset half-space `{z : h(z) ≤ ε(πz)}`, then `c = γ` everywhere.
Equivalently: **if `c ≠ γ`, the disagreement set `E_γ := {z : c(z) ≠ γ(z)}` is unbounded below in every non-zero additive `h`** (on some
residue class). **Inhabitant:** `c = γ`; the content is that no colouring agrees with a pullback on a half-space and differs elsewhere.

**Proof.**
1. *Propagation (any colouring).* If `z ∈ E_γ` and `u ∈ U_F` with `γ(z + u) = c(z)`, then `c(z+u) ≠ c(z) = γ(z+u)`: `z + u ∈ E_γ`.
2. *Enough moves.* For `z ∈ E_γ` with `κ = c(z) ≠ γ(z)`, gap-freeness of `γ` gives a residue `a` (a class of `S = U_F mod Q`) with
   `γ(πz + a) = κ`, i.e. every `u` in the class `C_a` is a move from `z` (for `P₄`, eight such `a`, by tightness).
3. *Additive functions are archimedean and bounded on circles.* `h = Re(ᾱ₁σ₁·) + Re(ᾱ₂σ₂·)` (`R ⊗ ℚ = F(i)`, and every `ℚ`-linear map
   `F(i) → ℝ` has this form, with `σ_j` the complex embeddings up to conjugation; for a non-real `F` the same with its archimedean places).
   By weak approximation for the norm-one torus, each class `C_a` is dense in the archimedean circles jointly with its residue, so
   `inf h(C_a) = −ρ < 0` (real `F`: `ρ = Σ|α_j|`; non-real `F`: `h(C_a)` is unbounded below and the argument is shorter).
4. *Descent.* For `x ∈ π(E_γ)` let `M(x) := inf{h(z) : z ∈ E_γ, πz = x}`; `E_γ ⊆ {h > ε}` gives `M(x) ≥ ε(x) > −∞`. Take `z` over `x` with
   `h(z) < M(x) + ρ/4`, a move class `C_a` from step 2, and `u ∈ C_a` with `h(u) < −ρ + ρ/4`: then `z + u ∈ E_γ` over `x + a` and
   `M(x + a) < M(x) − ρ/2`. Iterating inside the finite set `π(E_γ)` revisits a residue with strictly smaller `M`: contradiction. So
   `E_γ = ∅`. ∎

**Scope and controls.** It uses only gap-freeness of `γ` (not tightness, not V3), so it holds at K, at ℚ(√11) for its gap-free periodic
colourings, and at every field plane. **Gapped `γ` escapes it, as it must**: at a gap `(x, κ)` step 2 has no move, and row 66's gap
transport indeed modifies such colourings locally. **It subsumes D₀** (take `E_{γ₁} ⊆ {h > ε}`), with any number of phases, any colours,
on the far side.
**Consequence (a reformulation, no new content):** at ℚ(√59), `F(R) ≠ 0` **iff every four-colouring agrees with some `P₄`-pullback on some
residue-offset half-space**. A non-periodic colouring, if one exists, disagrees with every pullback in every archimedean direction.

### 6.3a Beyond two phases: what is settled, what is open [hand where marked; the rest a sketch, not claimed]

- **Stripes die, with any number of phases [hand, via Lemma W; §2.1's use made explicit].** If the phase is a function of `(πz, ℓ(z) mod 1)`
  for an additive `ℓ` (cut-and-project) **with windows `f(x, ·)` piecewise constant, finitely many breakpoints** (for arbitrary `f` the slices
  below are not defined: each residue sees its own dense coset of `t`-values), then by joint density and local constancy the colouring
  gives a proper colouring `C(x, t)` of `P₄ × L` off the breakpoints, `L` the reflexive circle graph `t ~ t + s`, `|s| < ρ`. Each slice `C(·, t)` is a `P₄`-colouring (loops of `L`),
  adjacent slices are equal by Lemma W, and `L` is connected: `C` factors through `P₄`. H and D do not cover this case; W does.
- **Theorem D′ — one pullback plus any residue-determined alternative [hand; supersedes D's Eulerian step].** Let `F` satisfy V3 (ℚ(√59),
  ℚ(√83), ℚ(√131)), `γ₁` a `P₄`-pullback, and `β : O/𝔓⁴ → [4]` **any** function (not necessarily a colouring). If `c(z) ∈ {γ₁(πz), β(πz)}`
  for every `z`, then `c` is a `P₄`-pullback. (D is `β = γ₂`.)
  *Proof.* Let `D₂ := {c = β∘π ≠ γ₁∘π}`, `Δ_β` the arcs `x → y` (`x ~ y`, `γ₁(y) = β(x)`). (1) `D₂` is forward-closed under lifted arcs
  (D step 1, verbatim: `c(z+u) ≠ β(x) = γ₁(y)` forces `c(z+u) = β(y) ≠ γ₁(y)`). (2) On every residue lying on a cycle of `Δ_β`
  ("recurrent"), D steps 3–7 give `D₂(x)` invariant under a finite-index `G`. (3) Let `Φ` be the forward closure of `D₂(recurrent)`. It is
  `G`-invariant (a `G`-invariant set plus classes `C_a`), contained in `D₂`, forward-closed, and free of `β`-conflicts. So
  `c^min := β∘π on Φ, γ₁∘π elsewhere` is proper and periodic, hence (V3) a gap-free pullback. (4) `Y := D₂ ∖ Φ` lies over
  non-recurrent residues, on which `Δ_β` is acyclic. If `Y ≠ ∅`, take `x ∈ π(Y)` with no arc into `π(Y)`, and `z ∈ Y(x)`. A neighbour `w`
  over `y` with `c^min(w) = β(x)` is either in `Φ ⊆ D₂` with `β(y) = β(x)`, which is a conflict in `c`, or in the `γ₁`-part with
  `γ₁(y) = β(x)`, an arc `x → y`. Then `w ∈ D₂` by (1) and `w ∉ Φ`, so `y ∈ π(Y)`, against the choice of `x`. So `c^min` has a gap at `z`
  (`c^min(z) = γ₁(x) ≠ β(x)` and colour `β(x)` is missing around `z`), a contradiction. So `Y = ∅` and `c = c^min`. ∎
  *Reach:* every multi-phase colouring in which, at each residue, at most one colour other than `γ₁`'s occurs. This includes three phases
  whose disagreements with `γ₁` sit on disjoint residue sets.

- **Genuinely three-phase (open).** When `|{γ₁(x), γ₂(x), γ₃(x)}| = 3` on a set of residues, the next colour after a move is chosen by `c`,
  not by the residue. So closed walks are not residue walks and the `U₄` trick has nothing to act on. The fibre-bundle view: sections of
  `B ⊂ P₄ × K₄` with fibre `B_x`. D is fibres of size ≤ 2 from two colourings. The whole problem is fibres `= [4]`, and it is equivalent to
  `r` = all 1,179,936 phases (every colouring qualifies). **What any non-periodic colouring must do, now proved:** disagree with every pullback
  in every archimedean direction (H); not be a two-pullback patchwork (D); not be a cut-and-project phase pattern (W).

### 6.4 Prior-art gate for D and H (2026-09-25, light; the owner confirmed D's steps (b) and (d))

zbMATH Open API: `ab:"unique continuation" & ab:"coloring"` — 0 hits; `ab:"half-space" & ab:"proper coloring" & ab:"periodic"` — 0 hits;
`ab:"frozen" & ab:"colorings" & ab:"Cayley graph"` — 1 hit (colourings/subshifts on ascending HNN extensions, 2022; not the object);
`ab:"colorings" & ab:"periodic" & ab:"forced" & py:2000-2026` — returns Herva–Kari (2023), the **forced-periodicity / algebraic method for
multidimensional configurations** (Kari–Szabados: a configuration with a non-trivial annihilating polynomial is a sum of periodic ones). *Read in part at the owner's request: §6.6.* It bears on §2.2 (a star identity is an annihilator) and on G75's `A_k g = −2g`, more than on D and H.
Nothing found stating D or H. The search measured its words (G21); the symbolic-dynamics words "one-sided rigidity", "expansive direction"
were not run.

### 6.5 Poros's card C-S2, levels 1–5 [exact; `cs2_tower.py`]

The dyadic tower of ℚ(√2,√3) is `L = ℚ₂(ζ₂₄)` over `K = ℚ₂(√2,√3)`, with conjugation `ζ ↦ ζ⁻¹` and `P_m = Cay(O/𝔓^m, S_m)`. Exact integer
lattice arithmetic in `ℤ[ζ₂₄]` gives `|S_m| = 3·2^{m−1}`, and **Hoffman-tight at four colours at every level m = 1, …, 5**:
`λ_min = −1, −2, −4, −8, −16 = −|S_m|/3`, least-eigenspace multiplicities 3, 9, 21, 45, 45. Row 67's tower gives the same numbers, and
the multiplicity of 45 is stable from level 4. The eigenvalues are FFT floats that are integer-valued, with no rounding at 1e-6. **Not claimed
for all levels:** G54's propagation sentence is withdrawn. The stabilised multiplicity of 45 is the shape FS38-D2-B's induction uses, which
is suggestive only. If every level is tight, ℚ(√2,√3) is an S2 member with triangles (ζ₆ ∈ F(i)), and Theorems H and D′'s periodicity half
apply to it verbatim.

### 6.6 Prior art read: the annihilator method (owner's named item, 2026-09-25)

**Held here** (scratch copies of the arXiv PDFs): Kari–Szabados, *An algebraic geometric approach to Nivat's conjecture*, arXiv:1605.05929;
Herva–Kari, *On forced periodicity of perfect colorings*, arXiv:2301.05232; Herva–Kari, *On the periodic decompositions of multidimensional
configurations*, arXiv:2409.14948. **Reading status, honestly:**
- 1605.05929: abstract; the statements of Thm 13 (decomposition: a non-trivial annihilator makes `c` a finite sum of periodic
  configurations, any dimension) and Cor 24–25 (in 2D, `Ann(c) = φ₁⋯φ_m·H` with line polynomials `φ_i` and `H` an intersection of maximal
  ideals; `m = 0` iff doubly periodic). No proofs read.
- 2301.05232: abstract; Thm 1, Thm 2, Lemma 14 (a `D`-perfect colouring's vector presentation is annihilated by `Σ_{u∈D} I X^{−u} − B`),
  Thm 10 with its proof, Cor 18–19 (Puzynina `[29]`: a 1-perfect colouring of the triangular grid is two-periodic **when
  `det(B + I) ≠ 0`**). The rest not read.
- 2409.14948: abstract only. Puzynina's paper `[29]`: not held.

**(i) G75 in their language.** "No monochromatic √3-triple in family `k`" says each hexagon holds exactly two vertices of each other colour and
none of its own. That is a **perfect colouring** of the family's triangular sublattice with hexagon matrix `2(J − I)`, and with the centre
included `B = 2J − I`. Then `det(B + I) = det(2J) = 0`: **exactly the exceptional case where Puzynina's forced periodicity fails.** The
tetrahedral part satisfies `(f_hex + 2)g = 0`, and `f_hex + 2 = (1 + x)(1 + y)(1 + xy)/(xy)` [checked by expansion]: a product of three line
polynomials, i.e. G75's "three circles per family", and in Kari–Szabados's terms `g` is a sum of three line-periodic (period-2) stripes on
each family's slice (Gibbs's stripes). **So one family's identity cannot give periodicity, by their theorem's own exception.** Row 85's step
is to intersect nine families' annihilators in rank 4 to a zero-dimensional torsion variety (42 points), then kill the 5-part at the tight
quotient. That is the annihilator-ideal method with a finite variety. **Could row 85 have cited them?** For the framework, the one-family
structure and the stripes: yes. It should cite Kari–Szabados (the method) and Herva–Kari/Puzynina (the exceptional case). For the 8Λ
conclusion: no. Their structure theorems are two-dimensional, and the nine-family intersection and the dyadic kill are row 85's own. The
finite-variety step itself ("annihilator ideal with finitely many torsion zeros ⟹ periodic") is elementary in any dimension.
*The d-dimensional version was not located in what I read. Kari's "Expansivity and periodicity in algebraic subshifts" (arXiv:2301.06868)
is the likely home; not read.*

**(ii) What they give on ℚ(√59).** They supply no identity. They convert one:
- If a star identity (§2.2) held for every four-colouring, then on every finitely generated sublattice `Λ ⊇ D` each colouring's `g` would
  have the annihilator `Σ a_u X^u − λ`, and Thm 13 would make it a finite sum of one-direction-periodic configurations.
- **Full periodicity needs the annihilator ideal's variety to be finite torsion.** That is precisely what Proposition S (ii)–(iv) analyses:
  the rotation-closed zero set `Z`.
- Herva–Kari's Lemma 14 says perfect colourings have annihilators. On ℚ(√59) the pullbacks are perfect (Hoffman equality, D step 2), but
  whether **every** colouring of a finitely generated piece is perfect for some finite shape *is* the pinning question. Their theory does not
  answer it.
- Theorems D, D′ and H use no annihilator and lie outside their framework.
- **Bearing:** the natural K3 format — "a finite-shape perfect-colouring identity valid for all colourings" — is their object. §2.4's
  dichotomy (a no-go of this format is a K2 in disguise) stands.

### 6.7 The blind verifier's notes on D, D′ and H (relayed by the owner, 2026-09-25; recorded verbatim in substance, marked as the verifier's)

*Everything in this subsection is the verifier's, not ours.*
- **All three proved; no step false.** Theorems D (§6.2), D′ (§6.3a) and H (§6.3).
- **Scope wider than this file stated.**
  - *D′, and D's pullback half, need no V3.* The verifier's **Lemma C′**: the group generated by the unit-vector sums around any cycle of
    residues contains `R ∩ 𝔓^m` with `m ≤ 10`. So the intermediate colouring (`c^min` in D′; `c` itself in D) is `(R ∩ 𝔓^m)`-periodic, hence
    by density a pullback from the tight `P_m`; that makes it gap-free (FS38-D2-A), and FS38-D2-B finishes (every colouring of `P_m`, `m ≥ 5`,
    is a `P₄`-pullback). This holds **for every real field with row 67's dyadic tower and B1's Lemma R(b), ℚ(√11) included**: there every
    two-phase colouring is a `P₄`-pullback. (Our §6.2 "free control" sentence about ℚ(√11) said only "periodic"; the verifier's form is
    stronger and correct: the 7-adic periodic colourings are not two-phase relative to `P₄`-pullbacks.)
  - *H holds for every number field and any number of colours* (gap-freeness of `γ` is all it uses).
- **Completeness, two steps to fix (fixed here by the verifier's routes):**
  - *D step 6* ("`ℚ(U₄) = F(i)`") was justified only for ℚ(√59) (the `v^{24}` from `ℚ(√−59)`). **Density closes it for every real field**
    (the verifier's claim; its argument was not relayed; my reconstruction, seat III): `U₄` has finite index in `U_F`, so it is dense in an
    open subset of the archimedean torus `(S¹)^{[F:ℚ]} ⊂ F(i) ⊗ ℝ`; an open subset of that torus spans `F(i) ⊗ ℝ` over `ℝ`, while a proper
    subfield `L′ ⊊ F(i)` lies in the proper subspace `L′ ⊗ ℝ`. So `ℚ(U₄) = F(i)`.
  - *D step 7* cites Lemma R for finite index; **finite rank alone suffices** (the verifier's claim; my reconstruction): `R` is Galois-stable
    (the Galois group of `F(i)/ℚ` permutes `U_F`), so `N_{F(i)/ℚ}(w) ∈ wR ∩ ℚ`; and for a torsion-free group `R` of rank `r`, `R/mR` has order
    at most `m^r`. So `nwR ⊇ n N(w) R` has finite index.
- **One unsaid step in H.** The move classes `C_a` are cosets of `ker π`, and `ker π` need not be an ideal. **Density still holds**, since
  `ker π ⊇ |Q|·R` (the verifier's step): the units congruent to a given unit modulo the ideal `|Q|R` form a weak-approximation class, dense
  in the archimedean circles, and each `C_a` contains one.
- **Where our route beat the verifier's:** the 15-term identity `−1 = 5·(−(3+4i)/5) + 5·(−(3−4i)/5) + 5·1` (D step 5), and the Eulerian step
  (D step 2), which makes every residue recurrent in D.

## §7. Seat III: HD1 made precise — what is proved, what is finitely certifiable, and a gap in Theorem C

*Owner's item (c). HD1 (Poros's replay, 2026-09-25): "Θ₄(F) has no point with nonzero archimedean part", via (a) "a component at a
non-stable place has dense range". Poros's caution: a character of `R` is defined only modulo the global dual lattice, so "a component at a
non-stable place" needs a definition. This section supplies it, proves the case it covers, and names what is left.* Scope: [plane], `F` a
real field in `ℚ₂(√3)` with row 67's tower and V3 (ℚ(√59), ℚ(√83), ℚ(√131)); `S` := the non-stable (split) finite places of `F(i)`.

### 7.1 The intrinsic classes [hand]

- **The adelic model.** `R = ℤ[U_F]` is the ring of `S`-integers of `F(i)` (B1's Lemma R: integral at every stable place, arbitrary on `S`).
  So `R̂ = A_S / R^*`, `A_S = F(i)_∞ × ∏′_{v∈S} F(i)_v`, `θ_y(z) = ψ_∞(y_∞z) + Σ_{v∈S} ψ_v(y_v z)`, and `R^* ⊂ F(i)` is the dual lattice
  (elements in the inverse different at every stable place).
- **Why "a component at a place" is not intrinsic.** For `x ∈ F(i)`, the product formula gives `θ_x(z) = −Σ_{stable v} ψ_v(xz)`, a
  torsion character. So `y` and `y − x` differ by a torsion character, and by strong approximation `x` can cancel `y` to any precision at
  any finite set of places of `S`. **Every character, torsion ones included, has representatives with nonzero components at infinitely many
  places of `S`** (the dyadic `ℤ/4` colouring, written with no dyadic component, is `y = −x` at `∞` and at every `v ∈ S`).
- **The intrinsic classes.** `T` = torsion characters = `{θ_x : x ∈ F(i)}`. `A` = archimedean characters `θ_{(y_∞,0)}`. `Fin` = characters
  `θ_{(0, δ)}` with `δ` supported on a finite subset of `S`. A character is in `T + A` iff its `S`-part is **principal**: `y_v = X` for one
  `X ∈ F(i)` at every `v ∈ S`. Equivalently (a check, not used below): iff `θ` is continuous for the topology `𝒯` that `R` inherits from
  `F(i)_∞ × ∏_{stable} O_v` (`R` is dense there, so a `𝒯`-continuous character extends to that locally compact group, whose characters are
  torsion plus linear).
- **HD1, stated intrinsically:** `Θ₄(R) ⊆ T`. Its bullet (a) is the claim `Θ₄(R) ⊆ T + A`; its bullet (c) is §2.3.

### 7.2 Theorem HD1-fin — the case with finitely many genuine split places [hand] [plane; every real `F` with row 67's tower and V3]

**Statement.** `Θ₄(R) ∩ (T + A + Fin) = Θ₄(R) ∩ T`, and that set is finite: it consists of characters vanishing on `R ∩ 𝔓⁴`
(pullback characters of `P₄`). **Inhabitant:** the `ℤ/4` colouring local at 2 (G41) is a point of `Θ₄(R) ∩ T`, so the statement is not vacuous.

**Proof.** Let `θ = τ + ℓ + σ ∈ Θ₄`, `τ ∈ T` factoring through `R/𝔪`, `ℓ ∈ A`, `σ(z) = Σ_{v∈V} ψ_v(δ_v z)`, `V ⊂ S` finite.
1. *Every `δ_v` is zero.* Suppose `δ_{v₀} ≠ 0`; let `w₀` be the place of `F` below `v₀`, so `F(i) ⊗ F_{w₀} = F_{w₀} × F_{w₀}` with
   coordinates `(v₀, v̄₀)` and `T(F_{w₀}) = {(a, a^{−1})}`. The norm-one torus is a conic with a rational point, so it has weak approximation.
   Choose `u ∈ U_F` with: `u ≡ 1 (mod 𝔪)`, so `τ(u) = τ(1)`; archimedean components within `ε` of 1, so `|ℓ(u) − ℓ(1)| < ε`; `u_w` so close
   to 1 at every other place below `V` that `ψ_v(δ_v u_v) = ψ_v(δ_v)` there (`ψ_v` is locally constant); and `u_{w₀} = (a, a^{−1})` with
   `v(a) = −k`, `k ≫ 0`, `a` otherwise free in an open set. Then `ψ_{v̄₀}(δ_{v̄₀}a^{−1}) = 0` (integral), and `δ_{v₀}a` ranges over
   `ϖ^mO^×`, `m = v(δ_{v₀}) − k`. `ψ_{v₀}` maps `ϖ^mO` onto a cyclic group `C` of order `N → ∞` and `ϖ^{m+1}O` onto its index-`p` subgroup
   `C′`, so its values on `ϖ^mO^×` contain `C ∖ C′`, which meets every arc of length `2/N`. Poles of `u` at places outside `V ∪ {w₀}` are
   irrelevant: `τ`, `ℓ` and `σ` do not read them. So `θ(u)` comes within `2/N + ε` of every point of the circle, against `θ(u) ∈ [1/4, 3/4]`.
2. *So `θ = τ + ℓ`, and §2.3 gives `ℓ = 0`* (the archimedean spread `[−ρ, ρ]` would make `τ` a circular colouring of the tight product
   quotient with ratio `< 4`, against `χ_f = 4`; V3 and `[Zhang2012]` for the product).
3. *A torsion point of `Θ₄` vanishes on `R ∩ 𝔓⁴`.* `c_s = ⌊4(θ + s)⌋` is then periodic, hence (V3) a `P₄`-pullback, so `c_s(z) = c_s(z + δ)`
   for `δ ∈ R ∩ 𝔓⁴` and every `s`, which forces `θ(δ) = 0`. The pullback characters are finitely many. ∎

**What it leaves.** A band character outside `T + A + Fin`: a non-principal `S`-part with genuine components at infinitely many places. For
those, step 1 fails: any unit with a deep pole at `w₀` has other poles, whose contributions the approximation cannot hold fixed.

**Two consequences of step 1's argument, which uses only weak approximation and never the band's width** [hand]:
- *Every band, every field.* For any number field `F` and any closed arc `J ⊊ 𝕋`, a character in `T + A + Fin` with `θ(U_F) ⊆ J` has zero
  `Fin`-part. So FS-83's question at every `k` reduces, on `T + A + Fin`, to the torsion-plus-archimedean case. At `k = 4` on type-B
  planes that case is §2.3; at other `k` it is the circular-chromatic question of the finite product quotient.
- *(S-v), a new case of Proposition S (§2.2).* A frequency `χ ∈ T + A + Fin` with a nonzero split part cannot lie in a star identity's
  rotation-closed zero set `Z` when `Σa ≠ 0`. Proof: take `w ∈ U_F` with a deep pole at `w₀`, its unit part at `v₀` Haar-distributed on a
  coset (weak approximation approximates any finite average), and everything else held fixed. Each term `χ(wu)` then averages to 0,
  because `χ_{v₀}` is a nontrivial additive character on a compact open subgroup. So `λ = 0`, against `λ = −Σa/3`. Proposition S's open
  part is now: the Gauss-sum lemma for mixed odd torsion, and frequencies outside `T + A + Fin`. The latter is the same obstruction as
  HD1's.

### 7.3 Theorem HD1-cert — HD1 is equivalent to one finite exact certificate [hand] [plane]

For lattices `Λ₀ ⊆ Λ₁ ⊂ R` (finitely generated; `U_Λ := U_F ∩ Λ`, finite), let `Θ₄(Λ) = {θ ∈ Hom(Λ, 𝕋) : θ(U_Λ) ⊆ [1/4, 3/4]}`, a finite
union of polytopes in a 4-torus.

**Statement.** `Θ₄(R) ⊆ T` (HD1) **iff** there are lattices `1 ∈ Λ₀ ⊆ Λ₁` with `res_{Λ₀} Θ₄(Λ₁) = res_{Λ₀}(Z)`, where `Z` is the finite
set of pullback characters of 7.2.

**Proof.**
- ⟸ Let `θ ∈ Θ₄(R)`. For `u ∈ U_F`, `θ_u := θ(u·)` is again in `Θ₄(R)` (`uU_F = U_F`). Its restriction to `Λ₁` lies in `Θ₄(Λ₁)`, so
  `θ_u` vanishes on `Λ₀ ∩ 𝔓⁴`. Hence `θ` vanishes on `I := Σ_{u∈U_F} u(Λ₀ ∩ 𝔓⁴)`, an `R`-submodule of `R ∩ 𝔓⁴` (because `ℤ[U_F] = R`).
  It is nonzero, so it has finite index (V2, or finite rank as in §6.7). So `θ` is torsion.
- ⟹ *Isolation.* Take `Λ₀` so rich that, for each `τ ∈ Z`, the units of `Λ₀` with `τ(u) = 1/4` have archimedean images whose convex
  hull contains 0 in its interior. That is possible because each residue class is dense in the torus `S¹ × S¹ ⊂ ℂ²`, whose hull is a
  product of discs. On a lattice, the characters near `τ` are `τ + η` with `η` a small real form, and every real form on `Λ₀` is
  archimedean. Membership in `Θ₄` needs `η ≥ 0` on those units, so `η = 0`. Hence each `τ|_{Λ₀}` is isolated in `Θ₄(Λ₀)`: some open
  `N ⊇ res(Z)` has `Θ₄(Λ₀) ∩ N = res(Z)`.
- ⟹ *Compactness.* The sets `res_{Λ₀}Θ₄(Λ₁)` are compact and decrease in `Λ₁`. Their intersection is `res_{Λ₀}Θ₄(R)`, the inverse limit,
  which is `res(Z) ⊆ N` given HD1. So some `Λ₁` has `res_{Λ₀}Θ₄(Λ₁) ⊆ N ∩ Θ₄(Λ₀) = res(Z)`. ∎

**Reading.** HD1 is a Σ₁ statement: if it is true, a finite exact polytope computation proves it. The computation is the cell
structure of `Θ₄(Λ₁)` on two rich lattices over ℚ(√59), `Λ₅₁₀` and a saturation of it. That is a Θ relation tree, **banned until
2026-10-01**, so it is recorded here as the post-ban computation that decides HD1 (search log line 7). If HD1 is false, its witness is a
band character outside `T + A + Fin`. Its colouring `⌊4(θ + s)⌋` is non-periodic, so it would prove `F(R) = 0`: a "no" at the field level.

### 7.4 A gap in Theorem C's sketch (§4.2), found while writing 7.1 [self-audit; retraction 2 of this side's file, partial]

- **What the sketch assumes.** Theorem C's proof uses `ν̂_n(χ) → ∏_v f_v(χ_v)` "for a fixed character `χ = ψ(Tr(y·))`", once `S_n`
  contains "every non-compact place in `y`'s support". That presumes a representative `y` with **finitely many** split components, that
  is, `χ ∈ T + A + Fin` (7.1).
- **Why the product is ill-defined.** The formula depends on the representative. The dyadic minimiser written at the dyadic place gives
  `f = −1/3`. The same character written as `(−x at ∞, −x on S)` gives a product of split factors `0`. The product formula correlates
  the split, archimedean and stable data of every global element.
- **What the proof covers.** It is sound for invariant random colourings whose spectral measure is carried by `T + A + Fin`, when the
  representative is chosen with no split component on the `T + A` part.
- **What it needs besides.** `liminf_n ν̂_n(χ) > −1/3` for every character with a non-principal, infinitely supported `S`-part. The
  natural mechanism: averaging over the other generators' exponents equidistributes each unit part in an open subgroup of `O_v^×`, which
  kills a deep-pole contribution. That is plausible, **not proved**.
- **Two checks that the gap is real, not cosmetic** [hand].
  - *(i) A global vector is not archimedean-generic.* On a box of `S_n`-units, every character of `R` equals exactly
    `u ↦ ψ_∞((y_∞ − X_n)u)`. Here `X_n ∈ F(i)` agrees with `y` on `S_n` to the box's precision and is integral elsewhere (strong
    approximation). Take a dyadic minimiser `τ = ψ₂(x·)`. The vector `y_∞ − X_n = −x − X_n` is global, and the product formula turns its
    archimedean phase back into `τ(u)`, whose average is `−1/3`. The sketch's per-place rule gives `f_∞ ∈ {0, 1/2, 1}` for the same
    vector. So a per-place product cannot be read off a representative. The joint closure of the box image, product-formula
    constraint included, is the object to average over.
  - *(ii) Split-place factors can be very negative.* If instead the approximant keeps poles at a split place `w ∉ S_n`, then the unit
    part `a ∈ O_w^×` of `u` meets it through a Kloosterman average `E_a e(ψ(ca + c′a^{−1}))`. At level 5 with `(c, c′) = (1, 2)` that
    average is `(4 cos(4π/5))/4 = −0.809 < −1/3`. So "every factor is at least −1/3" is false for such representatives, and a repair
    must choose them without split poles, as in (i).
- **Consequences.**
  - Theorem C's grade becomes "hand, for spectral measures on `T + A + Fin`; the general case needs the equidistribution lemma above".
  - Its corollaries inherit the gap: `F_μ = P` for ℚ(√−709), and the re-proof of `χ(E²) ≥ 4`.
  - So does the implication "HD1 holds for non-real `E`", which I had derived from Theorem C: a band character gives the invariant random
    colouring `c_s`, `s` uniform, whose spectrum lies on `{nθ}`.
  - HD1-fin (7.2) does not use Theorem C.

### 7.5 Why weak approximation cannot finish HD1 (a no-go of a method, named) [hand, a sketch of an obstruction; not a theorem]

Any unit `u` with a controlled pole at one place has uncontrolled poles elsewhere. So an HD1 proof by weak approximation must first move
the character's `S`-part off the places it wants to control, using a global `X ≈ y` there. The product formula prices that.
- If `X` is integral outside those places, the lattice `O[1/pq]` forces `|X|_∞ ≳ p^{cM}` for precision `M`. The archimedean term then
  needs return times of order `p^{c′M}`, while the controlled range of the second pole is only of order `M`.
- If instead `X` is allowed a pole at an auxiliary place `w*` to keep `|X|_∞` bounded, the torsion part's period grows like `N(w*)^t` with
  `N(w*)^t ≳ p^{cM}`.

Either way the controlled window is logarithmic against a polynomial requirement. What would work is **an `S`-adic Berend-type theorem
with an isometric archimedean centre**: closed `U_F`-invariant subsets of `R̂` are contained in `T + A`, or contain a leaf segment in a
split direction. The leaf case contradicts the band by 7.2 step 1's coset count, but only once the leaf is attached to a torsion base
point. The alternative is the finite certificate of 7.3 after the ban. Berend's theorem (*Multi-invariant sets on compact abelian groups*,
Trans. AMS 286 (1984)) needs expansion in every direction. It fails here exactly at the archimedean circles, which are compact for a real
field. **Not read; recorded as the prior-art debt of this line.**

### 7.6 HD4 proved: Kempe swaps of pullbacks are pullbacks [hand] [plane; every real `F` with row 67's tower (V3 or Lemma C′ + D2-B)]

**Statement.** Let `γ = γ̄ ∘ π₄` be a `P₄`-pullback colouring of `Cay(R, U_F)`, with `i ≠ j` colours. Then every connected component of
the `{i, j}`-Kempe subgraph of `γ` is a union of full `π₄`-fibres. So swapping a Kempe component of a pullback yields a pullback. The
voltage-escape screen (FS-70, row 78) therefore finds nothing at the field level, and any escape from the pullbacks is non-Kempe (Poros's
HD4, which was stated there as derived for the walk and prior for the generation).
**Inhabitant:** any pullback (FS38-D2-B's census).

**Proof.**
1. *Components are unions of cosets of finite-index groups.* The Kempe subgraph is `π₄^{−1}(K̄)`, with `K̄` the `{i, j}`-subgraph of `P₄`
   and its edges the unit pairs over `K̄`'s edges. For a residue `x`, the closed-walk displacements `V_x` from `x` back to `x` form a
   group (concatenation, reversal). A walk stays valid when every step `u_j` is replaced by `t·u_j`, `t ∈ U₄`, because validity depends
   only on residues mod `𝔓⁴` (the argument of §6.2 step 4). So `V_x` is a `ℤ[U₄]`-module, and it contains a nonzero ideal (§6.2 steps
   5–6, with §6.7's density fix). Hence it has finite index. The component of `z` over `x` is `⋃_y (z + D_{x→y})`, each `D_{x→y}` a coset
   of `V_x`. So the swapped colouring is periodic.
2. *Periodic implies pullback* (V3; or, with no V3, the verifier's Lemma C′ plus D2-B). So the swapped colouring `c′` is constant on
   `π₄`-fibres, as `γ` is. The two colourings differ exactly on the component, so the component is a union of `π₄`-fibres. ∎

## §3. A conjecture, with its killing test (not claimed)

**The colouring-level Hasse principle at L = 4.** For a real field `F` with exactly one stable place whose local planes are
four-colourable, that place Hoffman-tight at every level and its local plane rigid **through triangle-free configurations** (§1.6:
`4 ∈ F_tf`; Theorem A's triangle-using rigidity is not enough, since no triangle-free field realises it): `F(R_F) ≠ 0`.
Evidence: none toward the conclusion. K has two such places and triangles; ℚ(√11) fails the hypothesis (a second place, 7) and the
conclusion; §1.4 and §2.3 exclude two natural non-periodic constructions, which bounds constructions, not the answer (G21; Poros's
note, adopted). **Killing test:** a non-periodic four-colouring of
ℚ(√59)'s plane. **Its cost if true:** a yes over ℚ(√59) answers Soifer 55.1; so this conjecture, like G48's bold form, predicts a
triangle-free five-chromatic unit-distance graph (over ℚ(√59, √7), by the spindle at distance 4) — a prediction I record, not a
reason to believe it.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| dB-E | `K`, `ℚ(√59)`, `ℚ(√3,√11,√59)` embed in `ℚ₂(√3)`, unit-distance graphs into the 2-adic plane | [hand + exact congruences] | §1.1 |
| dB-A | every four-colouring of the plane over `ℚ₂(√3)` is a `P₄`-pullback; `F_loc = 𝔓⁴` | [hand + certificate (row 78) or Parts's trees (row 85); plus D2-B — corrected grade] | §1.2 |
| dB-A1 | `F(R) ≠ 0` ⟺ every four-colouring of `Cay(R, U_F)` extends to `Cay(O, T)` (per coset) | [hand, given A, V2–V3] | §1.3 |
| dB-B | 2-adically locally constant four-colourings of `Cay(R, U_F)` are `P₄`-pullbacks | [hand, given A] | §1.4 |
| dB-Atf | triangles enter Theorem A only at step 1; `F(R_F) ⊆ F_tf ∩ R_F` for triangle-free `F ⊂ ℚ₂(√3)`; `F_tf ∈ {0} ∪ {⊇ δ₀O}` | [hand; the dichotomy a sketch] | §1.6 |
| dB-W | the wall lemma | [hand] | §2.1 |
| dB-K3 | on type-B planes a K3 no-go of a format containing a pullback-valid would-be pinning identity implies `F(R) = 0` | [hand] | §2.4 |
| dB-C0 | on any real field plane, unit-distance pair correlations are consistent with a purely archimedean spectrum (the Bessel obstruction) | [hand] | §4.1 |
| dB-C | non-real `E ⊂ ℚ₂(√3)` with no bad odd stable place (e.g. `ℚ(√−709)`): `F_μ = P`, every invariant random four-colouring periodic; corollary `χ(E²) ≥ 4` through the complex place | **[hand for spectral measures carried by `T + A + Fin`; the general case needs an equidistribution lemma — downgraded by seat III, §7.4]** | §4.2, §7.4 |
| dB-D0 | no threshold walls: a colouring equal to two distinct pullbacks on the two sides of a residue-offset level set of an additive function is improper | [hand; needs `h ≠ 0` (verifier)] | §6.1 |
| dB-D | **two-phase rigidity, unconditional**: a four-colouring of `Cay(R, U_F)` agreeing at every point with one of two `P₄`-pullbacks is periodic (class of row-67-type dyadic places), hence a pullback where V3 holds (59, 83, 131); D₀ is a corollary | [hand] | §6.2 |
| dB-D′ | one pullback plus any residue-determined alternative `β`: a colouring with `c(z) ∈ {γ₁(πz), β(πz)}` is a pullback (V3 fields); D is `β = γ₂` | [hand] | §6.3a |
| dB-H | **unique continuation from a half-space**: a four-colouring agreeing with a gap-free periodic colouring on a residue-offset additive half-space equals it (any field plane) | [hand] | §6.3 |
| dB-T1 | `4 ∈ F_tf` ⟺ some number field `E ⊂ ℚ₂(√3)` carries a finite triangle-free forcer of `(0, 4)` | [hand; ⟹ cites existential closedness of henselian fields in their completions, external, for the singular case] | §5.1 |
| dB-S | star identities: (i) exist if rigid (incl. the virtual hexagon), (ii) `λ = −Σa/3`, (iii) dyadic torsion frequencies pinned, (iv) split-free frequencies with an archimedean part excluded | [hand] | §2.2 |
| dB-Θ | `Θ₄(F)`'s split-free points are torsion | [hand, given V3 and `[Zhang2012]`] | §2.3 |
| dB-HDfin | **HD1 on `T + A + Fin`**: a band character (`θ(U_F) ⊆ [1/4,3/4]`) that is torsion plus archimedean plus finitely many split components is a pullback character; `Θ₄(R) ∩ (T+A+Fin)` is finite | [hand; uses §2.3, V3] | §7.2 |
| dB-HDcert | **HD1 ⟺ one finite certificate**: `Θ₄(R) ⊆ T` iff some lattices `1 ∈ Λ₀ ⊆ Λ₁ ⊂ R` have `res_{Λ₀}Θ₄(Λ₁)` = the pullback characters; HD1 is Σ₁ | [hand] | §7.3 |
| dB-HDint | the intrinsic form of HD1's bullet (a): a character's split part is defined only modulo global elements; `T + A` = principal `S`-part = `𝒯`-continuous | [hand] | §7.1 |
| dB-HD4 | **HD4 proved**: every Kempe component of a `P₄`-pullback colouring of `Cay(R, U_F)` is a union of `π₄`-fibres; Kempe swaps of pullbacks are pullbacks (voltage-escape screens are blind at the field level) | [hand; §6.2 steps 4–6 plus V3, or Lemma C′ + D2-B] | §7.6 |
| dB-Sv | Proposition S (S-v): frequencies in `T + A + Fin` with a nonzero split part lie in no star identity's zero set (`Σa ≠ 0`); and on `T + A + Fin`, for every band and every field, the `Fin`-part of a band character is zero | [hand] | §7.2 |

## Retractions

1. §2.2 (S-iii), within the hour of writing, before any report: "every torsion frequency in `Z` is a `P₄` minimiser" overreached to
   odd stable components (the product quotient is not Hoffman-tight); restricted to dyadic torsion, the mixed case left open.
   Same entry, (S-iv): the "Vandermonde on distinct angles" sketch was wrong (angles can coincide); replaced by the grouping argument.
2. (seat III, 2026-09-25) §4.2 Theorem C, **partial**: its equidistribution step presumed every character has a representative with
   finitely many split components; false in general (§7.1), and the product `∏ f_v` is representative-dependent. Downgraded to spectral
   measures on `T + A + Fin`; the general case needs the lemma named in §7.4. Found by this side, before any report of it.

## Would have searched here

1. Enumerating `P₄`'s colourings to list their Fourier supports — instead: FS38-D2-B's 45 minimisers and the averaging argument (S-ii, S-iii).
2. A lattice-level quotient screen for a non-periodic colouring of `Λ₅₁₀` — instead: Theorem B and the wall lemma say which constructions cannot work.
3. A SAT ask for a finite triangle-free forcer over ℚ(√59) — instead: Theorem A's reframe (forcers exist locally; the question is realisability).
4. A SAT or colouring search on finite pieces of ℚ(√−709)'s plane for a non-periodic colouring, or for a triangle-free forcer — instead:
   Theorem C (`F_μ = P` by derivation) and the reduction T1; the upgrade to `F` left open (§5.4).
5. A 2-adic numerical search for a triangle-free local forcer by realising the Mycielskian of the Grötzsch graph minus an edge in
   `ℚ₂(√3)²` — instead: the dimension count (every five-critical graph has at least `2n` edges against `2n − 3` degrees of freedom, so
   any realisation is a coincidence of an arithmetic structure) sent the question to number fields (T1).
6. (successor) Enumerating closed walks of the residue digraph `Δ` and trying unit lifts until a displacement set generated `R ∩ 𝔓⁴` — instead:
   the multiplicative closure under `U₄` and one Pythagorean identity (Theorem D, steps 4–6).
7. (seat III) The exact cell tree of `Θ₄(Λ)` on `Λ₅₁₀` and a saturation of it, to decide HD1 outright — instead: Theorem HD1-cert (§7.3)
   proves that this finite computation decides HD1 when HD1 is true, and records it as the post-ban computation.
8. (seat III) A float scan of band characters `θ = τ + (split part at one or two primes)` on units with poles above 5 and 13 — instead: HD1-fin
   (§7.2) excludes every finitely supported split part by weak approximation, and §7.5 derives why that method stops there.
