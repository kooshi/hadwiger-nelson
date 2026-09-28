# FS114-NB — blind verification of FS-114's proof side (the unit-arc question)

*Job FS114-NB, blind verifier (de Bruijn, Opus 5.5), 2026-09-27 night. Brief `data/fs114/briefs/NB114-verify-proof.md`; instance
`data/fs114/briefs/NB114-instance.md` (the ten statements, FS114-N's, quoted by the owner with proofs, grades and verdicts withheld); standing rules
`data/fs114/briefs/STANDING-RULES.md`. Touches only this file, `data/fs114/fs114-nb/`, `tools/fs114_nb_*.py`. Grades are `CLAUDE.md` § Notation's;
"minds" counts independent derivations. Every verdict in stage 1 is derived from the statements alone, before the side's record was opened.*

**Status:** Stage 1 — SAVED (blind verdicts on all ten statements, the controls, the positive control).

## Theorems this phase proved

| id | statement (one line) | grade | minds | address |
|---|---|---|---|---|
| NB-FAR | Two distinct same-colour tiles of a valid map are close or far; touching ones are close; every tile has diameter ≤ 1 | [hand] | 1 | §1.2 item 10 |
| NB-ANCHOR | A point of `cl x` met by another tile at that point alone is a vertex of ≥ 4 sectors, so in `F ∪ R` when a repeated colour counts any two sectors | [hand] | 1 | §1.2 item 0 |
| NB-RD | Every repeat at a tile is (S) close, (A) the whole shared boundary with one member on `ω(q)`, `q` the other's only contact, or (B) vertex contacts all at distance exactly `1 = diam x`; reads `B̄(j_x, 1 + 1/√3)` | [hand] | 1 | §1.2 item 1 |
| NB-EULER | The torus identity `Σ_f (deg_M − (k−1)) = (7−k)F + Σ_v (d−2)(d−3) − μ` holds exactly with `μ_f` the excess multiplicity (self-meetings included); fails under "distinct neighbours met twice" | [hand; tools exact, 17 torus maps] | 1 | §1.2 item 2 |
| NB-A1 | In a non-Siamese valid map each edge supplies at most one type-(A) repeat, and a supplying edge is one whole unit arc | [hand] | 1 | §1.2 item 3 |
| NB-ABSENT | In a non-Siamese valid map with `μ = 0`, a colour absent from a tile's edge-neighbourhood carries at most 3 tiles of `N[x]` (excess ≤ 2); a colour present carries excess ≤ 1, and then an (A) edge | [hand] | 1 | §1.2 item 3 |
| NB-COUNT | On a non-Siamese valid map cellular on a torus with `μ = 0` and `k` colours: `Σ_v [2d² + (2 − 3k)d + 6k − 6] ≤ 0` and `deg_D ≤ k − 1`; at `k = 5` impossible (every term positive); at `k = 6` exactly `V₄ ≥ 3V₆` with `V₃ ≤ 2V₄ + 5V₅ + 8V₆` | [hand; tools exact algebra] | 1 | §1.2 items 3–4 |
| NB-CUBIC | No cubic non-Siamese valid six-map is cellular on a torus with `μ = 0` (Euler + edge-rainbow) | [hand] | 1 | §1.2 item 8 |
| NB-DUAL | Sirgedas's 80%: unit-arc edges `≥ Σ_v d(d−3) = 2F + 2V₅ + 6V₆` of `E′ = 2.5F`; with absent colours `Σ_v (d−3) = (F + Σa)/2` | [hand] | 1 | §1.2 item 9 |
| NB-VOR | A valid map's closed classes realise distance 1 in every closed disc of radius 3 (three cases); Voronov's argument cannot refute a valid map: the band is what closedness buys | [hand] | 1 | §1.2 item 6 |
| NB-TOP | Thomassen's topological steps hold for every valid map in the plane after one colour-free repair (holes as 1-separators with finite interiors); "`M − x` connected" holds at a pinch point | [hand] | 1 | §1.2 item 7 |

## Would-have-searched-here log (standing rule 3)

- Would have searched torus maps for a counterexample to the six-colour room (a map with `V₄ < 3V₆` passing the count) — derived the per-vertex
  polynomial instead and checked its sign table exactly (`tools/fs114_nb_count.py`).
- Would have searched for a local fragment realising a type-(B) repeat, to settle C114-RAINBOW as FALSE — left it as a stated open case with the
  derivation that nothing local excludes it (§1.2 item 9).
- Would have enumerated small cellular tori to test N114-EULER — checked named lattice tilings of named tori instead (17 maps, by formula).

## Fence log

- `ls data/fs114/` and `ls data/fs114/briefs` at start-up listed directory and file names of fenced paths (`fs114-n`, `fs114-y`, `reports`, and the
  other briefs' file names); no fenced file was opened.
- `git log --oneline -8` at start-up showed three commit subjects older than the start-up snapshot's five (`40947416 FS111-P: stage 4`, `1dd325be FS-114
  inventory: BASE-V's result; construction side launched`, `01542162 BASE-V: report`). None newer than the snapshot.
- `grep -n '^#' plans/FS114-unit-arc-question.md` printed the heading line of stage 5's 5.3 (its title only, "Registered expectations … fenced from N, Y,
  NB, YB and CV until each has committed its stage 1 (D5)"); its body was not read.
- Read, not fenced: `plans/BASE-V-verification.md` (header table only; the owner's note 2), `plans/FS112-*`, `plans/FS106-V-verification.md`,
  `plans/FS107-derivation.md`, `data/fs112/*`, the Google-group threads, the held papers.

## Stage 1 — SAVED: the quotation check, and my verdicts, blind

### 1.1 The quotation check (standing rule 5)

`tools/fs114_nb_quotes.py` over `data/fs114/fs114-nb/quotes.tsv` (26 quotations my brief, my instance file and this record rely on; normalised for
markdown, typographic quotes, OCR line-break hyphens and whitespace): **26 of 26 FOUND** (`data/fs114/fs114-nb/quotes.out`); the self-test (one word
altered in the first quotation) turns it MISSING while its faithful twin stays FOUND. Voronov's and S–V's texts are `pdftotext -layout` extracts of the
held PDFs, committed beside the TSV. Findings:
1. **The ten statements** are the owner's quotation of FS114-N's record, which is fenced until this stage is committed: checked at stage 2.
2. **"Anchoring: FS-112's statement that a point of `cl x` met by another tile at that point alone lies in `F ∪ R`"** (instance, Terms): **no statement in
   those words exists in `plans/FS112-derivation.md` or `data/fs112/claims.md`** (grepped: "anchor", "alone", "at a single point"); FS-112's "anchored"
   (`plans/FS112-N-proof.md` N3-4) is about stuck chains' ends. The content is used implicitly in FS112-N3-DENSE3's proof ("if `w` is cubic trichromatic,
   N3-BASE …": a vertex of degree ≥ 3 that is not cubic trichromatic is in `F ∪ R`). Derived below (item 0), with its reading of "repeated colour".
3. `[Voronov2023]` Thm 1.3 is for the **closed** disc: "Denote by Ur (x) closed unit disc of radius r centered at x." (the proof of Thm 1.3). Bears on N114-VOR.
4. Thomassen's OCR line "any two consecutive vertices in the sequence xI, x2, .. ., Xk, x1 are neighbors in M and so M is locally connected" found with
   its OCR damage; the statement I rely on ("M − x … is connected" follows from local connectivity) is his.
5. The brief's radius "`≈ 1.834` about a midline four-colour vertex": `√15/4 + √3/2 = 1.8342…`, half the strip's height `√15/2 + √3`; FS112-DENSE3's entry
   reads "four-colour midline vertices within 1.834 of every point of the strip" — FOUND.

**Reading of "Siamese" used throughout** (de Grey, `[06.104]`, verbatim in `data/fs112/fs112-pa/extracts.md`: "The set of points at unit distance from some
point in a tile T of diameter less than 1 forms an annulus-like shape around T. Let’s call it the annulus of exclusion of T, AE_T."; "tiles that lie entirely
within each other’s annulus of exclusion"): two same-colour tiles each inside the other's annulus's interior (hole) — for tiles of diameter ≤ 1, exactly
a **close** pair of N114-FAR (union of diameter ≤ 1). "Non-Siamese" = no close pair of distinct same-colour tiles. The claim list's own gloss agrees ("A vertex
at which two tiles of one colour meet carries a repeated colour", touching same-colour tiles being close).

### 1.2 Verdicts, statement by statement (blind; each [hand, one mind: NB] unless marked)

**0. Anchoring (a term the side uses).** *Claim:* if `cl y ∩ cl x = {p}` near `p` for tiles `x ≠ y`, then `p ∈ F ∪ R`. *Derivation:* around `p` the sectors
are in cyclic order; a sector of `x` cyclically next to a sector of `y` shares with it the boundary edge leaving `p` between them, so `x` and `y` would meet
along an arc. Hence no `x`-sector is next to a `y`-sector, and `p` has at least four sectors (`x, a, y, b, …`); a point interior to a boundary arc has two,
so `p` is a vertex. Four sectors carry four colours or some colour twice. **TRUE**, when "a repeated colour" counts a colour in **any** two sectors (the same
tile twice included) — the reading FS112-N3-DENSE3's proof needs as well. **Under the narrow reading** (a colour in two non-adjacent sectors only) it is
**FALSE**: sectors `x, a, z, b` with `c(b) = c(z)` and three colours in all. The counterexample's `z, b` touch, so it is Siamese; in the non-Siamese class
the two readings agree (all sectors at a vertex then carry distinct colours). Radius: an infinitesimal neighbourhood of `p`.

**10. N114-FAR — TRUE.** "Two distinct tiles of one colour in a valid map are close (`T ∪ T′` of diameter `≤ 1`) or far (`inf |a − b| ≥ 1`); touching
tiles of one colour are close; every tile has diameter `≤ 1`." *Derivation.* A tile is a face: open and connected. For one tile `T`: `int T × int T` is
connected and `|a − b|` is continuous on it with range an interval `[0, diam T)`; validity keeps 1 out of it, so `diam T ≤ 1`. For `T ≠ T′` of one colour:
`int T × int T′` is connected, the range of `|a − b|` is an interval missing 1, so it lies in `(0, 1)` (then `sup ≤ 1` and, with the two diameters,
`diam(T ∪ T′) ≤ 1`: close) or in `(1, ∞)` (`inf ≥ 1`: far). Touching gives `inf = 0`, so close. Reads the two tiles (radius `1 + 1/√3` about one's Jung
centre when they touch).

**1. N114-RD — TRUE (one precision).** "In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member and
centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with
`|p − q| = 1 = diam x`; at most one member of a far pair shares an arc with `x`."
*Derivation.* Let `{y, z} ⊂ N[x]` be a repeat. By NB-FAR it is close — (S) — or far. If far, neither is `x` (a neighbour touches `x`, hence is close to
it). Put `Y = cl y ∩ cl x`, `Z = cl z ∩ cl x`, both non-empty. For `a ∈ Y`, `b ∈ Z`: `|a − b| ≥ inf|y − z| ≥ 1` and `|a − b| ≤ diam x ≤ 1`, so **every cross
distance is exactly 1** and `diam x = 1`. If `Z` had two points, `Y ⊂ ω(b) ∩ ω(b′)` would have at most two points; so if `Y` is infinite, `Z = {q}` and
`Y ⊂ ω(q)`. `Y` infinite contains a point interior to a boundary edge, and then the whole edge (the two faces along an edge interior are fixed), so `y`
shares with `x` an arc of positive length on `ω(q)`: a unit arc centred at `q`, and **the whole of `cl x ∩ cl y` lies on `ω(q)`**; `z` touches `x` at `q`
alone, and `q ∈ F ∪ R` by anchoring — (A). `Y`, `Z` both infinite is impossible (an arc on two unit circles) — the last clause. `Y`, `Z` both finite: each
point is an isolated contact, hence a vertex in `F ∪ R` by anchoring, all cross distances 1 — (B). In (A), `x` lies in `B̄(q, 1)` (`q ∈ cl x`,
`diam x ≤ 1`), so `x` is the **inner** tile of the arc, `y` the outer: the tactic of `[Polymath2021]` p. 194 (self in-contact plus out-contact).
*Precision.* (B) as stated reads "touching `x` only at vertices `p, q`": a member may touch at two vertices (`|Y| = 2, |Z| = 1`, both points of `Y` on
`ω(q)`); `|Y| = |Z| = 2` is impossible (a unit rhombus with both diagonals `≤ diam x = 1`). The statement holds with "at vertices, among them `p` and `q`".
*The radius it reads.* Deciding close or far reads `y` and `z` whole; each has diameter ≤ 1 and meets `cl x`, which lies in a disc of radius `1/√3` (Jung),
so **RD reads `B̄(j_x, 1 + 1/√3) ≈ B̄(j_x, 1.577)`**, `j_x` the Jung centre of `x` (or `B̄(c, 2)` for any `c ∈ cl x`); the anchoring reads only the contact
points' sectors. Below the strip's 1.834: RD is a local statement and must hold on every fragment containing `N[x]`.
*Controls.* **Strip** (`tools/fs112_yb2_objects.py`, the arch `U_0`, colour P): `N[U_0] = {U_{−1}, U_1, D_{−1}, D_0, D_1, T_0, T_1}` with colours B, G, O, M,
R, R, O — `deg_M = 7`, two repeats, `{D_1, T_0}` (R) and `{D_{−1}, T_1}` (O), each (A): `T_0` shares `U_0`'s arc of `ω(P_1)`, `D_1` touches `U_0` at `P_1` alone,
`P_1` four-coloured; likewise at `P_0`. **Disk:** the Reuleaux centre `Z` has `N[Z] = Z ∪ {P_k} ∪ {W_k}`, `deg_M = 10`, five repeats `{W_k, P_{k+2}}`
(colours `c(k)`), each (A) with centre `A_k` (the Reuleaux arc opposite `A_k` lies on `ω(A_k)`). **BOWTIE:** its two horns of colour 2 touch at `E`, a close
pair — (S) is realised locally. **Hexagonal seven-colouring:** no repeats (`N[x]` has 7 tiles, 7 colours). No control refutes RD; (A) and (S) are realised
exactly by held objects, **(B) by none**.
*Prior art.* The non-Siamese content is in the Polymath16 threads as search rules: Mixon `[08.14]` (two same-colour edge-neighbours give a unit rhombus)
and Gibbs's "vertex-edge" and "vertex-vertex constraints" (`[09.11]`, `[09.28]`, verbatim in `data/fs112/fs112-pa/extracts.md`) are (A) and (B); de Grey
`[08.15]`, `[08.16]` names the Siamese exception. The trichotomy as a theorem for valid maps with unit arcs: not found in print.

**2. N114-EULER — TRUE with `μ` read as the excess multiplicity; MISSTATED under the other reading.** "`Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v
(d(v) − 2)(d(v) − 3) − μ`." *Derivation.* Walk `∂f`: at each corner (vertex `v`) list the faces of the other `d(v) − 1` corners at `v`; the face across
each edge of the walk is listed at both of its ends, so remove one copy per edge. The list `L_f` has `Σ_{corners of f} (d(v) − 2)` entries and
`deg_M(f)` distinct faces other than `f`; **define `μ_f = |L_f| − deg_M(f)`** (every extra meeting of a neighbour, and every meeting of `f` with itself).
Summing, `Σ_f deg_M(f) = Σ_v d(v)(d(v) − 2) − μ`. The identity then reads `Σ_v [d(d−2) − (d−2)(d−3)] = 6F`, i.e. `3Σ_v (d − 2) = 6F`, i.e.
`2E − 2V = 2F`: Euler's formula on the torus. Degree-2 vertices contribute 0 on both sides. *Exact check* (`tools/fs114_nb_count.py`, part 1;
`data/fs114/fs114-nb/count.out`): 17 torus maps by formula (square, triangular, brick-hexagonal, a mixed-degree tiling; tori from `1 × 1` to `9 × 4`,
nine with `μ > 0`), `k = 5, 6, 7`: all hold, `deg_M` also computed directly. Plants: `drop_mu` fails exactly the nine maps with `μ > 0`; `seven_six` fails
all 17; `mu_alt` (μ read as "the number of distinct neighbours met more than once", self-meetings not counted) **fails 7 maps** — so the instance's gloss
"`μ_f ≥ 0` counting the neighbours a face meets more than once" is right only as "counting the meetings beyond the first, with multiplicity, `f`'s meetings
with itself included". **`μ = 0` in that sense** (no tile meets another twice or itself) is the hypothesis FIVE, ROOM and CUBIC need; on a torus quotient
it is the plane map's property after passing to a finite cover.

**3. N114-FIVE — TRUE, all three clauses; and C114-FIVE-COUNT passes as a positive control, with one step the statement does not contain.** "At `k = 5`, on a
non-Siamese valid map that is cellular on a torus with `μ = 0`, where each face needs at least `deg_M(x) − (k − 1)` repeats, the type-(A) supply is at most
`E`, and the type-(B) repeats number at least `F + V₄ + 4V₅`."
*Facts of the class* (non-Siamese, `μ = 0`; each derived): at a vertex all sectors are distinct tiles pairwise touching, hence distinct colours: `d ≤ k`,
and `R = ∅`, so `F ∪ R = {d ≥ 4}`. **Edge-rainbow:** `x` and its edge-neighbours carry distinct colours (C114-EDGE-RAINBOW, item 9), so
`deg_D(x) ≤ k − 1`; with `μ = 0`, `deg_D(x) = s(x)` counted with vertices of degree ≥ 3 only, and `2E′ = Σ_x deg_D(x)`, `E′ = F + V′` (`V′` the vertices of
degree ≥ 3). `deg_M(x) = deg_D(x) + Σ_{v ∈ ∂x} (d(v) − 3)`: the tiles at `v` not next to `x` in the rotation touch `x` at `v` alone.
*Clause 1* (each face needs ≥ `deg_M − (k−1)` repeats): pigeonhole on `N[x]` (`deg_M + 1` tiles, `k` colours) — as excess and hence as pairs. TRUE.
*Clause 2* (A-supply ≤ E) — **NB-A1:** an (A) repeat at `x` puts the **whole** boundary `cl x ∩ cl y` on `ω(q)` with `x` inner; the same edge cannot supply
`y` as well (it would lie on `ω(q′)` with `y` inner, and an arc lies on one unit circle, with one inner side); two (A) repeats at `x` with the same member
`y` and centres `q ≠ q′` would put `cl x ∩ cl y` on `ω(q) ∩ ω(q′)`; and the other member is unique (two tiles of `y`'s colour touching `x` at `q` touch each
other). So each edge supplies at most one (A) repeat: `A ≤ E′ ≤ E`. TRUE, with either convention for `E` (arcs, or edges between vertices of degree ≥ 3).
*Clause 3* (B ≥ F + V₄ + 4V₅): Σ of clause 1 with N114-EULER at `μ = 0`, `d ≤ 5`: needed `≥ 2F + 2V₄ + 6V₅`; minus `A ≤ E′ = F + V₃ + V₄ + V₅` gives
`B ≥ F − V₃ + V₄ + 5V₅`; edge-rainbow `2E′ ≤ 4F` is `V₃ ≤ V₅`, so `B ≥ F + V₄ + 4V₅`. TRUE (with `E′`; with `E` counting arcs the same bound follows from
`A ≤ E′`). Checked on an integer grid in `tools/fs114_nb_count.py` part 2.
*The positive control* (C114-FIVE-COUNT: "it must yield that non-Siamese valid five-colour maps do not exist (a known value, row 132), and name the step
where six's room enters"). Clauses 1–3 alone leave `B` unbounded and so decide nothing. **The step that closes it — NB-ABSENT:** a colour `c` absent from
`c(N_D[x])` is carried in `N[x]` only by tiles touching `x` at vertices alone, pairwise far (non-Siamese), so by the cross-distance argument of RD their
contact points are pairwise at distance exactly 1: at most 3 such tiles (four points pairwise at distance 1 do not exist in the plane) — excess ≤ 2, pairs
≤ 3. A present colour `c = c(e)` carries at most one more tile (an (A) partner of `e`), and `c(x)` none. So **`deg_M(x) + 1 − k ≤ A_x + 2a(x)`,
`a(x) = k − 1 − deg_D(x) ≥ 0`**, i.e. `3 deg_D(x) + Σ_{v∈∂x}(d(v) − 3) ≤ 3(k − 1) + A_x`. Summing with `Σ A_x ≤ E′` and `F = E′ − V′`:
**`Σ_v p_k(d(v)) ≤ 0`, `p_k(d) = 2d² + (2 − 3k)d + 6k − 6`**. At `k = 5`: `p_5(3), p_5(4), p_5(5) = 3, 4, 9`, all positive, and `V′ ≥ 1` on a cellular torus
map: **no non-Siamese valid five-colour map is cellular on a torus with `μ = 0`** — the count reproduces the known value. Equivalently FIVE's own bound
meets the supply: `F + V₄ + 4V₅ ≤ B` against `B ≤ 2Σa = 4F − 4V′` counted as excess, or `B ≤ 3Σa = 6F − 6V′` counted as pairs — each impossible
(`F = (V₃ + 2V₄ + 3V₅)/2`). **Six's room enters here:** `p_6(d) = 2(d − 3)(d − 5)` — zero at cubic and
five-colour vertices, `−2` at four-colour vertices, positive from six. Sirgedas's post (`J_Tw1_hUxQI`, 2020-01-21: "assuming all degree-4 edges, and only
quads", "so 200% of the edges are curved, so a 5-coloring is impossible") is this count at `a ≡ 0` and `V₃ = V₅ = 0`; his general case ("I think isn't
allowed, because pentagons mean 5 colors are meeting a vertex") is a GAP that NB-ABSENT and `V₃ ≤ V₅` close.
*Controls.* Strip: every arch `U_j` meets its tile inequality with equality (`deg_D = 5`, `a = 0`, two four-colour corners, `A = 2`). Hexagonal
seven-colouring at `k = 7`: `p_7(3) = −3`, room; at `k = 6` it fails edge-rainbow (`deg_D = 6 > 5`): six is spent there.

**4. N114-ROOM — TRUE; sharpened.** "At `k = 6`, on the same class, the same count forces type-(B) repeats only when `V₄ < 3V₆`." *Derivation.* At `k = 6`
needed `≥ F + 2V₄ + 6V₅ + 12V₆`, `A ≤ E′`, so `B ≥ −V₃ + V₄ + 5V₅ + 11V₆`; edge-rainbow `2E′ ≤ 5F` is `V₃ ≤ 2V₄ + 5V₅ + 8V₆`, so `B ≥ 3V₆ − V₄`, and the
lower bound can be ≤ 0 exactly when `V₄ ≥ 3V₆` (the interval `[V₄ + 5V₅ + 11V₆, 2V₄ + 5V₅ + 8V₆]` for `V₃` is non-empty). TRUE (checked on the integer grid).
**Sharpened (NB-COUNT):** with NB-ABSENT the same class is **excluded outright** when `V₄ < 3V₆` (`Σ p_6 = −2V₄ + 6V₆ ≤ 0` fails), and the count's whole
room is `V₄ ≥ 3V₆` with `V₃ ≤ 2V₄ + 5V₅ + 8V₆` — forcing (B) is not where the count stops; it stops at a map with many four-colour vertices and no
contradiction. So a six-colour NO by counting on the torus must bound something the count does not see (the slack `V₄ − 3V₆` is spent as non-arc edges,
unused absent colours or surplus excess).

**5. N114-COMPACT — TRUE in three parts, each with a precision.** "= C114-COMPACT at every `K`, with the side's addition: a radius uniform in `K` exists if
and only if C-LOCAL holds, and then (with FS112-N3-DENSE3) at radius `R + 3`."
- *C114-COMPACT* ("for each `K`, Q-full_K's NO holds if and only if some radius `R(K)` admits no valid fragment of complexity at most `K` on a disc of that
  radius"). ⟸: a valid map restricts to a valid fragment on every disc. ⟹, contrapositive: fragments on discs of radii `R_n → ∞`, recentred, converge on
  compacts (Blaschke; the diagonal argument), and the limit is valid (two interior points of one colour at distance 1 are interior, with neighbourhoods,
  to same-colour tiles of late fragments; the circle `ω(p_n)` crosses the approximating tile near `q`). **Precision:** the limit keeps "≤ `K` arcs per tile"
  and "radii ≥ `1/K`" but **not "≤ `K` tiles per unit disc"**: a tile may pinch into several faces in the limit. So at one `K` the statement holds with
  `𝓜_{K′}`, `K′ = O(K²)`, on the map side, or exactly when complexity is counted as arcs per unit disc (VW-CPT, `plans/FS107-derivation.md` W-EQ-K, "TRUE at
  W's class; under a per-tile count alone (VW's (Ct)) the compactness step is a GAP that does not bear on `𝓜_K`"). Quantified over all `K` it is TRUE as stated.
- *Uniform ⟺ C-LOCAL.* A radius `R` uniform in `K` is a radius with no valid fragment at all (a fragment on a compact disc has finitely many arcs, so some
  finite `K`) — a one-step local NO, so C-LOCAL. Conversely a NO with finitely many step applications, each reading radius `R₀` about a point the previous
  step located, reads a bounded disc, so a uniform radius exists — **not `R₀`** but `R₀` plus the chain of offsets. TRUE, radii distinct.
- *"at radius `R + 3`"*, read as: if C114-LOCAL-FR holds at radius `R` (no valid fragment on `B̄(v, R)`, `v ∈ F ∪ R`), then no valid fragment on any disc of
  radius `R + 3`. This needs FS112-N3-DENSE3 **as a statement about fragments** on `B̄(c, R + 3)`: DENSE3's witness lies in `B̄(c, 3)` (then `B̄(v, R) ⊂
  B̄(c, R + 3)`), but its **proof reads `B̄(c, 1 + r_b)`**, `r_b` the reading radius of row 134's base about the cubic trichromatic vertex it is run at (a
  vertex of degree ≥ 3 in `B̄(c, 1)`, FS112-DISC1). N3-BASE's hypothesis region is `B̄(u, 2)`; S–V's own accounting: "Note that all reasoning remains valid if
  we consider the interior of a circle of radius 3." So `R + 3` is right whenever `r_b ≤ R + 2`, which any `R > 1.834` (C-BEYOND) gives if `r_b ≤ 3.83`.
  **TRUE given `r_b ≤ R + 2`; `r_b` not re-derived here** (the base's steps read unit circles about points within 1 of `u`, so `r_b ≤ 2` plus the
  validity of the local bends, within 3) — [reading] for that one accounting line.

**6. N114-VOR — MISSTATED (two corrections); C114-VOR's verdict: fails at the band, which a valid map cannot supply.** "`[Voronov2023]` Thm 1.3 applied to a
valid map's closed colour classes gives: every open disc of radius 3 holds a same-colour unit contact (a tile of diameter exactly 1, or two same-colour tiles
at distance exactly 1)."
*Derivation.* The closures `A_i = cl C_i` of the colour classes (by local finiteness, unions of closed tiles) cover the plane; Thm 1.3 ("Suppose that the disc
of radius 3 defined by an arbitrary 2-dimensional norm is covered by 6 closed sets. Then at least one of these sets realizes the unit distance.") gives
`a, b ∈ A_i`, `|a − b| = 1`, in the disc. `a ∈ cl T`, `b ∈ cl T′`, tiles of colour `i`. Three cases (NB-FAR): `T = T′`, `diam T = 1`; `T ≠ T′` far,
`dist = 1`; **`T ≠ T′` close, `diam(T ∪ T′) = 1` realised across the pair** — the parenthetical omits the third (a tile of diameter 1 cut by a segment into
two same-colour tiles of smaller diameter keeps the map valid and turns a first-case contact into a third-case one). And Voronov's `U₃(0)` is the **closed**
disc ("Denote by Ur (x) closed unit disc of radius r centered at x."): the conclusion is for every **closed** disc of radius 3; the open form does not follow
(the limit pair may lie on the boundary circle). *Corrected:* "every closed disc of radius 3 contains points `a, b`, `|a − b| = 1`, in the closures of tiles
`T, T′` of one colour: `T = T′` of diameter 1, or `T ≠ T′` far at distance 1, or `T ≠ T′` close with `diam(T ∪ T′) = 1`." TRUE [hand, one mind; over V-1.3 at
FS106-V's grade].
*C114-VOR.* The step closedness buys is FS106-V's (c): with no unit contact in `A_i ∩ U₃`, compactness gives a band `[1 − δ, 1 + δ]` avoided by all six sets,
and the band is what Thm 1.1's steps spend (FS106-V table: H1 tiling `h < ε/2`, H5 Prop. 2.2, H6 the annulus, H12 the bicycle). **For a valid map the premise
of that step is false by Thm 1.3 itself**: every closed disc of radius 3 holds a unit contact, so no band exists at radius 3 and Voronov's argument proves
nothing more — its conclusion is a density statement (a unit contact within 3 of every point), consistent with the strip, the disk and BOWTIE, which are tight.
**Replacing the step almost everywhere is C-AE-CLOSED**, the tight question itself (row 132: "closed classes are the tight question itself"). So C114-VOR:
**fails at the named step — the band — and cannot be replaced** without answering the question. The density statement at radius 3 is a companion of
DENSE3 (unit contacts, not `F ∪ R` vertices) and is new only in that reading; it moves nothing.

**7. C114-THOM-TOP and the side's statement — MISSTATED.** "Lemma 1 holds for the map graph of every valid map; the topological step "`M − x` is connected"
fails at a tile with a hole or a pinch point, and is repairable in the non-Siamese case by Thomassen's own count of same-colour faces in a set of diameter
`< 2`, but not with Siamese pairs."
- *Lemma 1* is colour-free and TRUE (FS106-V3). Its hypotheses on `M`: connected (the plane) and locally finite (tiles of diameter ≤ 1 in a locally finite
  map) hold for every valid map; **locally Hamiltonian does not** (a tile with a hole; neighbours met twice). Lemma 1 is applied by Thomassen to the reduced
  graph `H`, never to `M`: "holds for the map graph" is right only through the topological steps.
- *"`M − x` connected"* follows from local connectivity at `x` (Thomassen: consecutive entries of the walk around `C_x` meet). **At a tile with a hole —
  TRUE that it fails** (the inner and outer rings are separated by `x`). **At a pinch point — FALSE**: a face whose closure touches itself at a vertex `v` is
  still an open disc with **one** boundary walk; consecutive faces along it meet, so `D₁(x)` is connected, and a tile `a` inside the pinched loop and a tile `b`
  outside it both contain `v` in their closures, so they are `M`-adjacent. (Checked on the two shapes: a C-shaped tile closing at `v`, and a disc minus an
  internally tangent disc.)
- *The repair.* In the plane a hole's contents lie in a bounded region, so they are **finitely many tiles by local finiteness** — colour-free: treat `x` as a
  1-separator, excise the finite inner components, paste them back at the end, exactly as Thomassen pastes `int(M, x, y)`. Likewise Thomassen's two uses of
  the count ("each connected component of int(M, x, y) has at most 6k vertices": the existence of maximal 2-separators and the final diameter bound (iii))
  need only finiteness in the plane: nested interiors of curves of diameter ≤ 2 lie in one bounded region, so chains terminate, and `H` with at most 12
  vertices plus finitely many finite pastings makes `M` finite — a contradiction. **So the topological steps hold for every valid map in the plane, Siamese
  or not**; the count is needed for Thomassen's surfaces, not for the plane. What Siamese pairs break is the **rainbow step** (RD's (S)), and what unit arcs
  break is the rainbow step's (A) and (B): the failure of Thomassen's route on valid maps is entirely at the rainbow step. The count does survive in the
  non-Siamese case as the side says (points in same-colour faces pairwise ≥ 1 apart, discs of radius ½ disjoint), and fails with Siamese pairs at unbounded
  complexity — TRUE but not needed.
- *Corrected statement:* "Thomassen's Lemma 1 and his topological steps, with one repair (holes as 1-separators with finite interiors), hold for the map graph
  of every valid map in the plane; his proof fails on valid maps only at the rainbow step." [hand, one mind]

**8. N114-CUBIC — TRUE.** "No cubic, non-Siamese valid six-map, cellular on a torus with `μ = 0`, exists." *Derivation.* Cubic means every vertex has
degree 3 (degree-2 arc breaks aside): then the tiles at a vertex pairwise share edges, `M = D`, and on the torus `2E′ = 3V′`, `F = E′ − V′ = V′/2`, average
`deg_D = 2E′/F = 6`. Edge-rainbow at six colours gives `deg_D ≤ 5`. Contradiction. No repeat count is needed; with RD it reads: a tile of degree ≥ 6 has a
repeat, which in a cubic non-Siamese map can be neither (A) nor (B), `F ∪ R` being empty. *Controls:* the hexagonal seven-colouring is a cubic non-Siamese
torus map; at seven colours edge-rainbow allows `deg_D = 6`, so the proof fails exactly there — **six is spent at `deg_D ≤ k − 1`**. The strip and the disk
are not cubic (four-colour vertices), outside its class. *Prior art:* its content is Mixon's `[08.14]` with Euler; the cubic case of Thomassen's theorem
without niceness's distance `> 1`.

**9. C114-EDGE-RAINBOW, C114-RAINBOW, C114-DUAL-COUNT.**
- **C114-EDGE-RAINBOW — TRUE.** "in a valid map, two faces of one colour that each share a boundary arc of positive length with a face `x` (either may be `x`)
  are Siamese." If one is `x`, they touch: close. Otherwise both contact sets are infinite, so a far pair is impossible (RD's last clause): close — Siamese
  in the reading of §1.1. Reads `B̄(j_x, 1 + 1/√3)`. Sirgedas's non-Siamese reading "Degree 6 isn't possible with only 6 colors." follows; so does Mixon's
  `[08.14]`.
- **C114-RAINBOW — MISSTATED** (its dichotomy omits a case). "in a valid map, if two faces of one colour both meet the closure of a face `x` (either may be
  `x`), then they are Siamese or they are separated by a unit arc (the unit-radius tactic)". By RD a non-Siamese pair is (A) — the tactic — **or (B)**: both
  touch `x` only at vertices, all contacts at distance exactly `1 = diam x`, no unit arc involved (an out-contact at distance exactly 1 across `x`'s
  diameter between two four-colour or repeated-colour vertices). Nothing local excludes (B): at its vertices the members face away from each other and `x`
  lies in both unit discs, with the tiles between them of other colours. No held object realises (B) (strip, disk, BOWTIE checked by hand); whether it
  occurs in a valid map is open. *Corrected statement:* RD.
- **C114-DUAL-COUNT — TRUE under its hypotheses, as "at least 80%".** "1 quad "emits" 4 curved edges. This is 2n edges (80% of all edges)." For a doubly
  periodic non-Siamese valid map with `μ = 0` in which every tile has five edge-neighbours: `N_D[x]` is all six colours (edge-rainbow), so every tile touching
  `x` at a vertex `v` alone repeats an edge-neighbour's colour — an (A) repeat whose edge is a unit arc centred at `v` with `x` inner; each edge is emitted
  once (NB-A1). Unit-arc edges `≥ Σ_v d(d − 3) = 4V₄ + 10V₅ + 18V₆`; with `2E′ = 5F` and `E′ = F + V′`, `V₄ + 2V₅ + 3V₆ = F/2`, so unit-arc edges
  `≥ 2F + 2V₅ + 6V₆` against `E′ = 5F/2`: **80% exactly when there are no vertices of degree 5 or 6** (Sirgedas's "only triangles and quadrilaterals"), more
  otherwise, and `2V₅ + 6V₆ ≤ F/2`. *With four edge-neighbours:* a tile with `a(x) = 5 − deg_D(x)` absent colours absorbs up to `2a(x)` excess through
  (B) — its vertex-only neighbours of an absent colour, pairwise at unit contact — and escapes emission there; globally `Σ_v (d − 3) = (F + Σ_x a(x))/2`, so
  each missing edge-neighbour adds half a four-colour vertex (Sirgedas's "I think it creates another quad/pentagon", made exact), and the count becomes
  NB-COUNT (`V₄ ≥ 3V₆`). *With Siamese pairs:* edge-rainbow fails (two same-colour edge-neighbours may be close), repeats of type (S) need no arc, and the
  count's supply gains (S) pairs with no bound from the argument — the vertices of `R`, FS112-N3-DENSE3's second half.

### 1.3 Summary of stage 1 (the verdict table I carry into stage 2)

| # | statement | my verdict | the radius it reads | grade, minds |
|---|---|---|---|---|
| 1 | N114-RD | TRUE (precision: (B) members may touch at two vertices) | `B̄(j_x, 1 + 1/√3)` | [hand], 1 |
| 2 | N114-EULER | TRUE with `μ` = excess meetings incl. self; MISSTATED under "distinct neighbours met twice" | global (torus) | [hand; tools exact], 1 |
| 3 | N114-FIVE | TRUE (all clauses); positive control PASSES only with NB-ABSENT, which the statement lacks | global | [hand; tools exact], 1 |
| 3′ | C114-FIVE-COUNT | TRUE for the class (torus, `μ = 0`); the post's general case a GAP closed by NB-ABSENT and `V₃ ≤ V₅`; six's room at `p_6 = 2(d−3)(d−5)` | global | [hand], 1 |
| 4 | N114-ROOM | TRUE; sharpened: `V₄ < 3V₆` is excluded outright, room exactly `V₄ ≥ 3V₆` | global | [hand; tools exact], 1 |
| 5 | N114-COMPACT | TRUE (∀K; at one K with `O(K²)` or arcs per disc); uniform ⟺ C-LOCAL with different radii; `R + 3` given `r_b ≤ R + 2` | `R + 3`, via DENSE3's `1 + r_b` | [hand], 1; one line [reading] |
| 6 | N114-VOR | MISSTATED: closed discs, and a third (close-pair) case | closed disc of radius 3 | [hand], 1 |
| 6′ | C114-VOR | fails at the band; not replaceable (C-AE-CLOSED) | — | [hand], 1 |
| 7 | C114-THOM-TOP / side's statement | MISSTATED: pinch point FALSE; repair colour-free for every valid map in the plane; failure only at the rainbow step | Thomassen's curves, diam `< 2` | [hand], 1 |
| 8 | N114-CUBIC | TRUE (Euler + edge-rainbow; six spent at `deg_D ≤ k − 1`) | global | [hand], 1 |
| 9a | C114-EDGE-RAINBOW | TRUE | `B̄(j_x, 1 + 1/√3)` | [hand], 1 |
| 9b | C114-RAINBOW | MISSTATED: (B) omitted; corrected form is RD | as RD | [hand], 1 |
| 9c | C114-DUAL-COUNT | TRUE as "at least 80%", equality iff no vertex of degree 5, 6 | global | [hand], 1 |
| 10 | N114-FAR | TRUE | the pair | [hand], 1 |
| 0 | anchoring | TRUE with "repeated colour" = any two sectors; FALSE under the narrow reading (only at Siamese vertices) | a point | [hand], 1 |

**What the controls say.** No local statement here is refuted by the strip, the disk or BOWTIE; (A) is realised by the strip and the disk, (S) by BOWTIE,
(B) by nothing held. The counting statements are global (Euler on the torus): the strip, a cylinder with boundary, is not in their class, and its arches
meet the tile inequality with equality. The hexagonal seven-colouring passes every statement and names where six is spent: edge-rainbow `deg_D ≤ k − 1`.

## Stage 1 — SAVED
