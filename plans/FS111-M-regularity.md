# FS111-M — the regularity side of FS-111 (route M, phase M1): saturation, contacts and the regularity rungs

*Job FS111-M (de Bruijn, Opus 5.5), opened 2026-09-28 06:43 UTC. Brief: `data/fs111/briefs/M-111-regularity.md`, with
`data/fs111/briefs/STANDING-RULES.md` (rule 0 read first) and the owner's launch notes (V0's record opened to me; C-HULL misstated; V0-WIG7,
V0-WIGGLE, V0-RESCALE; FS-111 keeps its name, route M first). Working files: `data/fs111/fs111-m/`; tools `tools/fs111_m_*.py`. Saved in stages;
each stage's section is headed "Stage n — SAVED" and committed before the next begins. Notation: `data/fs111/claims.md` §0 (D-NF, `S̃_j`, `P(x)`,
`A*_j`, `∂_e S_j`, free, contact, fill) and `data/fs106/claims.md` §0.*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address; every structural theorem names its `k = 7` inhabitant)*

- **M-FILL** (C-FILL re-derived) — a fill with a colour free at a point keeps a.e.-properness and the colour count — [hand; one mind here, sighted of
  V0; two with V0's] §1.4.
- **M-HULL1** (C-HULL's first clause re-derived) and **M-HULL2** (two path-connected pieces of one class have all cross distances `< 1` or all `> 1`)
  — [hand; one mind here] §1.5. C-HULL's "so" clause FALSE (V0's counterexample, re-checked) §1.5.
- **M-SATC** — every a.e.-proper `k`-colouring lies below a maximal admissible cover (Zorn), and every maximal cover's supports satisfy
  `ℝ² = int F_j ∪ (F_j + S¹)`: every point not interior to `F_j` is at distance exactly 1 from `F_j`; a selection from it is an a.e.-proper
  `k`-colouring — [hand, one mind] §2.2. Inhabitant at `k = 7`: R7's up classes (maximal, §2.4).
- **M-SLACKFREE** — if a colouring has slack `ε` in form (a), every point of `A*_j` is `j`-free; so a saturated colouring is tight — [hand, one mind]
  §2.3.
- **M-R7** — the Reuleaux seven-colouring (Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice, coloured by the four
  cosets of `2Λ`; the cusped down triangles coloured by the three cosets of `M = ⟨(0, √3), (3/2, √3/2)⟩`) is a.e.-proper, tight and **saturated**
  (every essential boundary point is a contact point for each of its colours); every boundary is a unit arc centred at a lattice point carrying
  both its side colours — [tools, exact in `ℚ(√3)`, two distance engines agreeing (`tools/fs111_m_reuleaux7.py` and the frozen FS112-Y engine), five
  plants each failing at its own assertion; one mind] §2.4. The object is `[Polymath16threads]`'s (thread 4, de Grey, 5 May 2018).
- **M-R7-FORCE** — on the up/down Reuleaux tiling, saturation of the arcs' down sides forces every down colour class to be a union of cosets of `M`;
  four colours on the ups and three on the downs are each the minimum (a `K₄` among ups at distances 1 and `√3`; three mutually touching downs) —
  [hand, one mind] §2.4.
- **M-DEADLOCK** — in the tight hexagonal seven-colouring of circumradius `1/2` (and in V0-WIG7), no a.e.-proper colouring that agrees with it off
  `B(x, ρ)`, `x` an edge midpoint, `ρ < 1 − √13/4`, has a contact point for either of the edge's two colours inside `B(x, ρ)`: local fills cannot
  saturate it — [hand, one mind] §2.5.
- **M-PINCH** — at a saturated point `x` of an honest a.e.-proper colouring with a neighbourhood `N` in which only two colours `a, b` have positive
  measure and each is a.e. one path-connected set of density points (H1, H2): either `N` is split by one unit circle `T₁(y)` (`a` inside, `b` outside,
  or the reverse; `y` a contact of both colours), or two open unit discs tangent at `x` from opposite sides lie a.e. in `S_a` and in `S_b` — the
  "(in, in)" case is impossible — [hand, one mind] §3.1. No thickness of the partner is needed.
- **M-C11** — if M-PINCH's hypotheses hold at every essential boundary point in `N`, then `∂_e S_a ∩ N′` (`N′ ⋐ N`) is a `C^{1,1}` curve with curvature in
  `[−1, 1]`, semiconcave and semiconvex; a single unit arc if any of its points is of the split type — [hand, one mind; the rolling-ball step is
  classical] §3.2.
- **M-EXTREME** — every component `R` of an open class of a saturated honest colouring has at least two points on its minimal enclosing circle, and
  none of them is a point where M-PINCH's conclusion holds for `R`'s colour: each is a cusp of `R` or a point where (H1) or (H2) fails — [hand, one
  mind] §3.3. Inhabitant R7: the three vertices of every up and the three cusps of every down.
- **M-COVER-SC** — in a maximal cover, at every boundary point of `F_a` each adjacent path-connected piece of `F̃_a` lies in an enclosing unit disc or
  outside an exterior one; where `∂F_a` is locally the graph of a continuous function with `F_a` below it, that function is semiconcave with constant
  1 — [hand, one mind] §3.4.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.
- Stage 2: would have run a local-search colourer for a saturated seven-colouring (every boundary point bound on both sides) on a pixel grid →
  instead derived the contact types a saturated interface admits and read the up/down Reuleaux tiling's colouring off them (the down colours are
  forced onto the cosets of `M`, §2.4), then checked the object exactly (`tools/fs111_m_reuleaux7.py`) and found it in print.
- Stage 2: would have searched fill orders on the hexagonal colouring for one that saturates it → instead proved that no modification near an
  edge can (M-DEADLOCK, §2.5).

## Fence log (standing rule 13)

- Stage 1: `plans/FS111-cone-scale.md` — its heading list (`grep "^#"`, which prints the heading line of stage 6.3 and nothing of its body), its header
  and "Theorems this phase proved" (lines 1–35), stages 2, 3b, 4 and 5 as the brief directs; stage 6 not read. `plans/FS111-V0-verification.md` read
  (header, fence log, stage 2) — opened to me by the owner's launch note. A directory listing of `tools/` printed the file name `tools/fs111_w_check.py`
  (competitor W's tool, fenced); it was not opened. A `git log` line showed W's commit subject "FS111-W: stage 1"; nothing of W's was opened.

## Stage 1 — SAVED: quotation check; each claim's object, complexity class and boundary class; C-FILL and C-HULL checked

### 1.1 Files read, in order

`data/fs111/briefs/M-111-regularity.md`; `data/fs111/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim, § Counter-priors, G82, G79, G24, G60, G22,
G83, G71, G40, G21 (in context, and read on disk for the quotation check); `LEDGER.md` rows 129–136; `plans/FS111-cone-scale.md` (as logged above);
`data/fs111/claims.md` in full; `plans/FS111-V0-verification.md` (header, stage 2); `data/fs106/claims.md` §0, §1, §5; `plans/FS107-derivation.md` §1,
§2; `plans/FS106-derivation.md` §2 (AE-SLACK, AE-CLOSED, AE-POLY, AE-CONV, AE-NICE, AE-MAP6, AE-FA, AE-Q2); `plans/M36-derivation.md` T1 (the brick
seven-colouring, G20's control). Papers (`pdftotext -layout`, in `~/source/library/pdf/`): Cohen–Mani §2.3 and §5 in full; `[Bukh2008]` §3 (notation),
§4 to the Supersaturation lemma, Definitions 9–10, Theorem 11, Lemma 12 with its proof; `[Voronov2023]` §2 in full (Props. 2.1–2.2, Obs. 2.1–2.3,
Lemma 2.2); `[SokolovVoronov2025]` §1, §2 (Conditions 1–3), §8, §9; Rataj–Zajíček 2025 abstract and §1 to Definition 1.2 (Theorems F, L; the planar
remark; B-sets). Rataj–Zajíček 2017 §6 not yet read (stage 3).

### 1.2 Quotation check (standing rule 5), every quotation in the brief and the launch note, and the claim-list quotations this job uses

Checked by `grep -F` on line-joined text (the sources are hard-wrapped; a single-line grep reads 0 for a present string).

| quotation | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | verbatim (a prefix of the quotation there) |
| "Let's see some ambition. I know we can do it." | `CLAUDE.md` § Counter-priors | verbatim (a prefix) |
| the front page's "FS-114's NO plus the cone scale gives seven" | brief § The question | **not verbatim**: no file holds it; `CLAUDE.md` rank-2 row reads "with FS-114's NO it is the route to `χ_m⁰(ℝ²) = 7`". A paraphrase in quotation marks; the sense is kept |
| "maps need six" (FS106-AE-MAP6) | `CLAUDE.md` link 4, "Maps need six" | verbatim up to case |
| C-SAT-T in the brief: "saturate a tight colouring by fills until no essential boundary point is free for any of its colours; then every boundary point is a contact point for each colour it carries" | `data/fs111/claims.md` §3: "every tight a.e.-proper `k`-colouring can be modified, keeping it a.e.-proper with `k` colours, into one in D-NF in which no `x ∈ ∂_e S_j` is `j`-free, for every `j`; so every essential boundary point is a `j`-contact point for every `j ∈ P(x)`." | **the brief narrows it**: "by fills" against the list's "can be modified". The two differ in what they claim (stage 2 decides both); this record works the list's wording and says where "by fills" fails |
| C-HULL-REG, REG-J, REG-B in the brief | `data/fs111/claims.md` §3 | paraphrases faithful in sense; the list's wording is used |
| the launch note: C-HULL "first clause is TRUE; its 'so' clause (sup < 1 or dist > 1) is FALSE"; the hexagonal counterexample; V0-WIG7, V0-WIGGLE, V0-RESCALE; the verdicts on C1-GAP, C1-FALS, C1-UNIF, C1-PW, C1-ROUTES, C-SEVEN-M, C-SIX-M, C-REG-EQ, C-FILL | `plans/FS111-V0-verification.md` §2.1, §2.8, §2.9 | faithful; "TRUE at two minds" counts the planner's derivation and V0's |
| claim list: D-NF, D-SLACK, D-AEMAP, I-D1 | `data/fs106/claims.md` §0–§1 | verbatim (truncations marked "…") |
| claim list: FS107-R-SAT, W-EQ-K | `plans/FS107-derivation.md` §1, §2 | verbatim |
| claim list: FS106-AE-MAP6 | `plans/FS106-derivation.md` §2 | verbatim (a prefix) |
| claim list: S–V Condition 5 | `[SokolovVoronov2025]` §2 | verbatim |
| claim list: `[Bukh2008]` Lemma 12; `[Voronov2023]` Prop. 2.1; Cohen–Mani Question 5.1 and block structure; Rataj–Zajíček's planar remark | the PDFs' text layers | verbatim |

### 1.3 Each claim's object, complexity class and boundary class (X4; the generator-image rule)

*Object as in the claim list (SEQ, LIM, MAP, ARG). "Complexity": arcs or tiles per unit disc. "Boundary class": what the statement assumes of the
class boundaries (hypothesis) and what it delivers (conclusion).*

| claim | object | complexity (hyp → concl) | boundary class (hyp → concl) | remark |
|---|---|---|---|---|
| REG-A_k | LIM → MAP | unbounded → locally finite (Cond. 3) | measurable → segments and circular arcs, unit arcs allowed | top rung; with Q-NO equivalent to seven (C-REG-EQ) |
| REG-I_k | LIM → MAP | unbounded → locally finite | measurable → Jordan arcs (Cond. 2) | at `k = 5`, C-SIX-M's missing half |
| REG-J_k | LIM → LIM (D-NF) | unbounded → junctions locally finite | measurable → sectorial blow-ups at `\|P\| ≥ 3` | **silent at bichromatic vertices of degree ≥ 4** (`\|P(x)\| = 2`; row 132's hole-filling fails exactly there; W-TAN's "two-element types"): the rung's junction set must include them (stage 4) |
| REG-B_k | LIM → LIM | unbounded → blocks | measurable → blocks of diameter `≤ 1`, gaps `≥ 1` | one class at a time in its conclusion; the existence is global |
| C-HULL | LIM (any a.e.-proper colouring in D-NF; tightness unused) | any | measurable | a single-point statement |
| C-FILL | LIM (any a.e.-proper) | any | measurable | a local move |
| C-SAT-T | LIM → LIM | unbounded | measurable → every essential boundary point bound | "modified" (list) versus "by fills" (brief) |
| C-HULL-REG | LIM (saturated) | local | → Lipschitz graph, semiconcave or semiconvex | at `\|P(x)\| = 2` only |
| PER | SEQ → SEQ | unbounded → finite perimeter density | grid squares → finite perimeter | link 6's reading |
| NO-C2 | MAP | locally finite | `C²` arcs | Q-NO's extension (X16) |
| CM-Q5.1 | one class | — | — | calibration only |
| C-SEVEN-M, C-SIX-M, C-REG-EQ | ARG | — | — | TRUE at two minds (FS111-P, FS111-V0) |

### 1.4 C-FILL — **TRUE** [hand; one mind here, sighted of V0 §2.8; two minds with V0's]

*Statement* (`data/fs111/claims.md` §3, verbatim): "if `x` is `j`-free with `|S̃_j ∩ A_η(x)| = 0`, the fill move on `B(x, η/2)` with colour `j` keeps the
colouring a.e.-proper."

*Proof.* `j`-free is defined for `x ∈ A*_j`, so `η < 1`: for `η ≥ 1`, `A_η(x)` contains a neighbourhood of `x`, where `S̃_j` has positive measure.
Put `B = B(x, η/2)`, `N = S_j ∩ A_η(x)`; `|N| = 0` (`S_j ∖ S̃_j` is null). The new classes are `S′_j = S_j ∪ B`, `S′_i = S_i ∖ B` (`i ≠ j`): `k` colours,
the others only shrink. Unit pairs of `S′_j`: inside `B` none (`diam B = η < 1`); between `b ∈ B` and `q ∈ S_j ∖ B` with `|b − q| = 1`,
`||q − x| − 1| ≤ |b − x| < η/2`, so `q ∈ N`, and `(Leb ⊗ σ){(p, w) : p ∈ B, p + w ∈ N} = ∫ |B ∩ (N − w)| dσ(w) ≤ |N| = 0`, the reversed pairs likewise;
pairs inside `S_j ∖ B` were null before. ∎

*Inhabitant at `k = 7`* (V0's, checked by hand here): the tight hexagonal seven-colouring by regular hexagons of circumradius `1/2`, at an edge midpoint
`x` of a hexagon `H` of colour `j`: the farthest points of `H` are the two far vertices at `√13/4 ≈ 0.9014`, and the other colour-`j` hexagons are
more than `1.29` away, so `x` is `j`-free with any `η < 1 − √13/4`. *Controls:* on the strip and the disk (row 136) a fill is a local move and changes
nothing checked there; at the vertices of the hexagonal colouring (opposite vertices at distance exactly 1) no `η` works, as tightness requires.

### 1.5 C-HULL — **MISSTATED**: first clause **TRUE**, "so" clause **FALSE** [hand; one mind here, sighted of V0 §2.8; two minds with V0's]

*Statement* (`data/fs111/claims.md` §3, verbatim): "let `S̃_j` be a class of a tight a.e.-proper `k`-colouring in D-NF and `C ⊆ S̃_j` path-connected;
then every `x ∈ A*_j` has `C ⊆ B(x, 1)` or `C ∩ B̄(x, 1) = ∅`, so `A*_j ⊆ {x : sup_{c ∈ C} |x − c| < 1} ∪ {x : dist(x, C) > 1}`."

**M-HULL1 (the first clause).** For `x ∈ A*_j` (`d̄_j(x) > 0`) and `c ∈ C ⊆ S̃_j`, I-D1 gives `|x − c| ≠ 1`; `c ↦ |x − c|` is continuous on the
path-connected `C`, so its image is an interval missing 1. ∎ [hand, one mind here; I-D1 is held at one mind and re-derived by V0 (V0-ID1)]

**The "so" clause is FALSE.** V0's counterexample, re-checked: in the hexagonal seven-colouring of circumradius `1/2`, `x = v₀` a vertex of a hexagon
`H` of colour `j` (`d̄_j(v₀) = 1/3`) and `C = int H`: `sup_{c ∈ C} |v₀ − c| = 1`, approached at the opposite vertex `v₃ ∉ C`, not attained; and
`dist(v₀, C) = 0`. So `v₀` lies in neither set. The first clause holds there (`C ⊆ B(v₀, 1)`), which is what shows the "so" is a different, stronger
statement: the first clause is pointwise strict, the "so" asks for a uniform margin.

**Corrected** (V0's form, confirmed): `A*_j ⊆ {x : |x − c| < 1 ∀c ∈ C} ∪ {x : |x − c| > 1 ∀c ∈ C}`; with non-strict inequalities,
`A*_j ⊆ {sup ≤ 1} ∪ {dist ≥ 1}`; the strict sup/dist form holds when `C` is compact.

**M-HULL2 — the two-piece form, which the later rungs use.** If `C, D ⊆ S̃_j` are path-connected, then either `|c − d| < 1` for all `c ∈ C`,
`d ∈ D`, or `|c − d| > 1` for all. *Proof:* `C × D` is path-connected, `(c, d) ↦ |c − d|` is continuous and never 1 (I-D1: both points have density
1). ∎ [hand, one mind] With `D = C`: a path-connected subset of `S̃_j` has diameter `≤ 1`. With `y ∈ cl D` and `|x − y| = 1` for some
`x ∈ cl C`: all of `C` lies in `B̄(y, 1)` or all of `C` lies outside `B(y, 1)` — the form stage 3 uses.

*Inhabitant at `k = 7`:* the same hexagonal colouring; M-HULL2's "all `< 1`" is realised by one hexagon against itself, "all `> 1`" by two hexagons of
one colour (gap `> 1.29`). *Controls:* on the strip and the disk (row 136) every tile is a path-connected piece and the checkers' verdicts are exactly
M-HULL2 read pairwise (a tile pair is accepted iff 1 is not interior to its cross-distance range); nothing new is checked there.

### 1.6 What stage 1 changes

- C-SAT-T is worked in the list's wording ("modified"), with "by fills" decided separately (stage 2).
- REG-J's junction set must contain bichromatic vertices of degree `≥ 4` (stage 4).
- M-HULL2, not C-HULL's "so", is the form carried forward.

## Stage 2 — SAVED: C-SAT-T — the cover form TRUE, the honest form GAP at `k = 5, 6`, inhabited at `k = 7` (the Reuleaux seven-colouring)

### 2.1 What is asked, in two readings

The list (verbatim, §1.2): "every tight a.e.-proper `k`-colouring can be modified, keeping it a.e.-proper with `k` colours, into one in D-NF in which
no `x ∈ ∂_e S_j` is `j`-free, for every `j`; so every essential boundary point is a `j`-contact point for every `j ∈ P(x)`." With "modified" unrestricted
this is the **existence form**: *if a tight a.e.-proper `k`-colouring exists, a saturated one exists* — which is all route M uses (REG in its existence
form, stage 2 §2.5 of the plan). The brief's "by fills" is a **process form**. Two facts first:

- *The "so" clause is an equivalence, not a consequence:* for any colouring, `x` is not `j`-free ⟺ `T₁(x) ∩ supp S_j ≠ ∅` ⟺ `x` is a `j`-contact point
  (`supp S_j = cl S̃_j` is closed and `T₁(x)` compact: if they are disjoint they are at positive distance `2η`, and `A_η(x) ∩ S_j` is null; if `y` is in
  both, `A_η(x) ⊇ B(y, η)` meets `S_j` in positive measure for every `η`). So "saturated" means: **every essential boundary point is at distance exactly
  1 from the support of each colour of its essential multicolour.**
- *Fills are not monotone.* A fill with `j` enlarges `S_j` and shrinks the others; shrinking a class frees points for it. No functional of the class
  measures increases under every fill (`Σ|S_j|` is constant on a torus, and a fill moves measure between classes in either direction). R-SAT's
  Zorn argument (`plans/FS107-derivation.md` §1) uses that adding points to a partial colouring is monotone; for full colourings the honest analogue
  has no such order. What does have one is the cover (2.2).

### 2.2 M-SATC — the cover form of saturation, **TRUE** [hand, one mind]

*Definitions (this record's).* An **admissible cover** is a `k`-tuple `A = (A_1, …, A_k)` of measurable sets with `⋃ A_j = ℝ²` up to a null set and
each `A_j` with `(Leb ⊗ σ)`-null unit pairs (the classes may overlap). `A ≤ B` iff `A_j ⊆ B_j` a.e. for every `j`. `F_j = supp A_j` (closed).

**Statement.** (i) Every a.e.-proper `k`-colouring's classes form an admissible cover lying below a maximal one. (ii) If `A` is maximal, then for every
`j`: `ℝ² = int F_j ∪ (F_j + S¹)`, where `F_j + S¹ = {x : T₁(x) ∩ F_j ≠ ∅}`; so every point of `∂F_j`, and every point outside `F_j`, is at distance
exactly 1 from `F_j`. (iii) Any measurable selection `g(x) ∈ {j : x ∈ A_j}` is an a.e.-proper `k`-colouring with `S_j^g ⊆ A_j`, and its class
boundaries lie in `⋃_j ∂F_j` up to a null set when these boundaries are null.

*Proof.* (i) Zorn. Let `(A^α)` be a chain. Put `μ(A) = Σ_j Σ_n 2^{−n} |A_j ∩ B(0, n)|/|B(0, n)|`, monotone along the chain, and pick `α_1 ≤ α_2 ≤ ⋯`
with `μ(A^{α_m}) → sup_α μ(A^α)`; set `E_j = ⋃_m A_j^{α_m}`. For any `α` either `α ≤ α_m` for some `m`, or `A^α ≥ A^{α_m}` for all `m` and
`μ(A^α) ≤ μ(E)`, whence `A^α = E` a.e.; so `E` bounds the chain. `E` is admissible: a unit pair `(x, x + w)` in `E_j × E_j` lies in
`A_j^{α_m} × A_j^{α_m}` for some `m` (monotone union), so the pairs of `E_j` are a countable union of null sets; the cover property is inherited.
(ii) Let `x ∉ F_j + S¹`. `F_j ≠ ∅` (else `A_j` is null and adding `B(x, 1/3)` to it is admissible, contradicting maximality). `T₁(x)` is compact and
`F_j` closed, so `dist(T₁(x), F_j) = 2η > 0`, `η ≤ 1/2` wlog, and `A_j ∩ A_η(x)` is null. C-FILL's computation (§1.4, which uses only this) shows
`A_j ∪ B(x, η/2)` has null unit pairs; by maximality `|B(x, η/2) ∖ A_j| = 0`, so `B(x, η/2) ⊆ F_j` and `x ∈ int F_j`. (iii) `S_j^g ⊆ A_j` inherits null
pairs; the cover property gives a full colouring. ∎

*What it says.* In a maximal cover **each class is saturated on its own**: `F_j` is a maximal unit-avoiding set in the density sense (every point
it does not contain in its interior is excluded by it). The honest colouring's "gap" (2.5) is absorbed by overlaps: where two colours are both free,
both covers contain the region. A **selection** is honest but may lose saturation: its class `S_j^g ⊆ A_j` is smaller, so its contact set
`supp S_j^g + S¹` is smaller than `F_j + S¹`.

*Inhabitant at `k = 7`:* R7 (2.4). Its up classes are already maximal: a point `z` outside an up `T` of colour `a` with `dist(z, T) < 1` has
`maxdist(z, T) ≥ dist(z, T) + 1` (the support line of `T` at the nearest point `p` and the opposite support line are 1 apart, `T` having constant
width 1), so some point of `T` is at distance exactly 1; and every point of the plane is within `2/√3 − (1 − 1/√3) < 1` of some up of colour `a`
(`2Λ` has covering radius `2/√3` from the ups' centroids, and each up contains the disc of radius `1 − 1/√3` about its centroid). Whether R7's down
classes are maximal is not decided here (not needed).

### 2.3 M-SLACKFREE — a colouring with slack has no contact points; so saturated colourings are tight [hand, one mind]

*Statement.* If `f` has slack `ε > 0` in form (a) (D-SLACK), then every `x ∈ A*_j` is `j`-free, for every `j`. Hence a colouring with at least one
essential boundary point that is saturated is tight.
*Proof.* Let `x ∈ A*_j` and `η, r > 0` with `η + r < ε`. `|S_j ∩ B(x, r)| > 0` (`d̄_j(x) > 0`). If `|S_j ∩ A_η(x)| > 0`, every pair in
`(S_j ∩ B(x, r)) × (S_j ∩ A_η(x))` has distance in `[1 − η − r, 1 + η + r] ⊆ [1 − ε, 1 + ε]`, a set of positive `Leb ⊗ Leb` measure: contradiction. ∎
*Reading.* Saturation is tightness made pointwise: slack frees every boundary point, saturation binds every one.

### 2.4 M-R7 and M-R7-FORCE — the Reuleaux seven-colouring, the `k = 7` inhabitant [tools exact + hand, one mind; the object prior art]

**The object** (by formula; `Λ = ℤ(1, 0) + ℤ(1/2, √3/2)`, `λ(m, n) = m(1, 0) + n(1/2, √3/2)`). Up tile `U(m, n)`: the Reuleaux triangle of width 1 on
`λ + {(0, 0), (1, 0), (1/2, √3/2)}`, each side the unit arc centred at the opposite vertex. Down tile `D(m, n)`: the down triangle
`λ + {(1, 0), (1/2, √3/2), (3/2, √3/2)}` less the bulges of `U(m, n)`, `U(m + 1, n)`, `U(m, n + 1)` — a curvilinear triangle with three cusps. Colours:
`U(m, n) ↦ 2(m mod 2) + (n mod 2)` (the four cosets of `2Λ`); `D(m, n) ↦ 4 + ((m − n) mod 3)` (the three cosets of `M`). Areas `(π − √3)/2` and
`√3 − π/2`, summing to `√3/2`.

**Checked exactly** (`tools/fs111_m_reuleaux7.py`, arithmetic in `ℚ(√3)`; output `data/fs111/fs111-m/reuleaux7_check.out`, plants
`data/fs111/fs111-m/reuleaux7_plants.out`):
- (P) a.e.-properness: every same-colour tile pair (a tile with itself included) whose centroids are within 3, first tile over the 12 representatives of
  the period lattice `{m, n even, m ≡ n (mod 3)}` of each kind: **240 pairs, 0 rejected, 168 realising distance exactly 1**; the frozen FS112-Y engine
  (`tools/fs112_y_check.py`, imported, not edited) gives the same verdict on all 240 (0 disagreements). Pairs farther apart are `> 3 − 2/√3 > 1`.
- (S) saturation: every arc (36 up to the period) is centred at a lattice point where both its side colours occur (its up as a vertex, a down of its
  other colour as a cusp); every lattice point is bound for each of its three up colours by that up's opposite arc. Essential boundary points are
  exactly arc points (`P = {up colour, down colour}`) and lattice points (`P` = the three up colours; the three cusps have density 0).
- (T) tight: the within-contacts of every up (vertex to opposite arc). (C) seven colours, four on ups, three on downs.
- Plants: `down_mod2` fails (P) and (C); `down_2lambda` (a **proper, tight, unsaturated** eight-colouring) fails (S) alone besides (C); `up_m_only`
  fails (P); `endpoints` (the engine without interior critical pairs) fails the engine's own positive control (the pair `U(0, 0)`, `U(1, 1)`, improper
  only at interior points, is accepted); `centre_shift` fails (S). Each fires for its own reason.

**M-R7-FORCE** [hand, one mind]. *Why these colours.* At an arc point `x` between `U` (colour `a`) and `D` (colour `b`), the arc is centred at `U`'s
opposite vertex `v`; `a` is bound at `x` by `v`. `b` is bound only if `v ∈ supp(b)`, and properness at `v` forces the `b`-material at `v` into the
directions at angle `≥ 90°` from every direction of the arc (else a `b`-point near `v` and a `b`-point just outside the arc are exactly 1 apart):
of the three cusps at `v` only the backward one qualifies, which for `U(0, 0)`'s arc opposite `(0, 0)` is `D(m, n) − (3/2, √3/2)`. By `D`'s threefold
symmetry, `c(D) = c(D + μ)` for `μ ∈ {(3/2, √3/2), (0, √3), (3/2, −√3/2)}`, which generate `M` (index 3 in `Λ`). So saturation forces the downs
onto `M`-cosets, and three colours are also the minimum for downs (three downs share each lattice point pairwise). The ups need four: `0`, `(1, 0)`,
`(1/2, √3/2)`, `(3/2, √3/2)` are pairwise at distance 1 or `√3`, and ups at those offsets touch or have 1 interior to their distance range (the
engine's positive control `U(0,0)/U(1,1)`). So on this tiling, seven colours and this colouring (up to the ups' choice and relabelling) are what
saturation and properness leave.

**What R7 is, in the programme's vocabulary.** A locally finite segment-and-arc map, all of whose boundaries are **unit arcs of kind both**, each
centred at a lattice point whose closure multicolour has six colours (three ups, three cusps) and whose essential multicolour has three. Its
interfaces are all of the "(in, out)" type of stage 3: a unit arc splitting its neighbourhood, the up inside, the down outside, one centre binding
both colours.

**Prior art.** The tiling and its 4 + 3 colouring are `[Polymath16threads]` thread 4, Aubrey de Grey (ag24ag24), 5 May 2018, 4:37 pm, verbatim:
*"the triangular grid needs eight colours, but if all the triangles in one of the orientations are “fattened” into Reuleaux triangles then they still
need only four colours but the other (concave) triangles now only need three."* Thread 12 (Bernhard Hockertz, 24 March 2019) calls it *"the 7-color
Reuleaux triangle tesselation"*, and (14 April 2019) *"the Reuleaux tiling whose 100% exclusion rate still fascinates me"* — the saturation property,
named informally. zbMATH (`ab:"Reuleaux" & (ab:"chromatic number" | ab:"coloring" | ab:"colouring") & ab:"plane"`: 0; `ti:"Reuleaux" &
(ab:"unit distance" | ab:"chromatic")`: 1 hit, on Borsuk's problem; `ab:"Reuleaux triangles" & ab:"tiling"`: 1 proceedings volume) finds no printed
paper. **Ours:** the exact check, the saturation reading (M-R7-FORCE: saturation forces the down colouring), its role as the vacuity rule's
inhabitant. A `BIBLIOGRAPHY.md` note is proposed at §P (stage 5).

### 2.5 M-DEADLOCK — the hexagonal colouring cannot be saturated locally [hand, one mind]

*Statement.* Let `f` be the tight hexagonal seven-colouring of circumradius `1/2`, `x` the midpoint of an edge between hexagons `H` (colour `a`) and
`H′` (colour `b`), `0 < ρ < 1 − √13/4 ≈ 0.0986`. If `g` is a.e.-proper and `g = f` off `B(x, ρ)`, then no point of `B(x, ρ)` is an `a`-contact or a
`b`-contact point of `g`. The same holds for V0-WIG7 with its wiggles vanishing near the edge's ends and `ρ` below the same bound minus the wiggle
amplitude.
*Proof.* A point `y ∈ supp S_a^g` at distance 1 from `z ∈ B(x, ρ)`: if `y ∈ B̄(x, ρ)`, `|z − y| < 2ρ < 1`; otherwise a neighbourhood of `y` avoids
`B(x, ρ)` or `y ∈ ∂B(x, ρ)` (then `|z − y| < 2ρ`), so `y ∈ supp S_a^f`, i.e. `y ∈ cl H` or `y` in another hexagon of colour `a`. The latter are more
than `1.29` from `x`, hence more than `1.29 − ρ > 1` from `z`; the former have `|z − y| ≤ |x − y| + ρ ≤ √13/4 + ρ < 1` (the farthest points of `H`
from `x` are its two far vertices, at `√13/4`). The same for `b` with `H′`. ∎
*What it says.* Every interface of this colouring sits in a "gap": `a` becomes bound only if the interface is pushed at least `0.1022` into `H′`
(where `H`'s far vertices reach distance 1), `b` only if pushed `0.1022` into `H`; no position binds both. Saturating it needs a global
rearrangement (R7 is combinatorially different: triangles, not hexagons). This is why the honest form cannot be proved by fills applied interface by
interface, and why R-SAT's order has no honest analogue. **V0-WIG7 is not saturated** (its wiggled edges are free for both colours away from the
vertex zones), so it bears on C-HULL-REG only through C-HULL-REG's hypothesis — which is exactly what must remove it (stage 3's pinching lemma).

### 2.6 Verdict on C-SAT-T

| form | verdict | grade, minds |
|---|---|---|
| cover form (M-SATC, proposed as the rung REG uses) | **TRUE** for every `k` | [hand], one mind; inhabitant R7 |
| honest existence form ("if a tight a.e.-proper `k`-colouring exists, a saturated one exists"; the list's "modified") | **TRUE at `k ≥ 7`** (R7, with `k − 7` colours unused); **vacuous at `k ≤ 4`** (`χ_m⁰(ℝ²) ≥ χ(ℝ²) ≥ 5`, I-EASY); **GAP at `k = 5, 6`**, at the step *from a maximal cover to an honest colouring whose interfaces lie where both colours are bound* (a selection loses contacts; M-DEADLOCK shows the repair is not local) | [hand + tools], one mind |
| process form ("by fills", the brief) | not decided; M-DEADLOCK: no fill order confined near an interface saturates the hexagonal colouring | [hand], one mind |

**MISSTATED as the rung REG needs:** route M needs saturation only to regularise, and the cover form delivers each class's saturation with no gap
problem; a selection from a regular cover is regular (its boundaries lie in `⋃ ∂F_j`). The honest form is what C-HULL-REG's statement presupposes
(it speaks of `∂_e S_a` at points with `P(x) = {a, b}`), so stage 3 works both: the honest colouring where it is saturated, and each cover class.
**Registration E3** (TRUE / GAP / FALSE at 0.35 / 0.5 / 0.15): GAP for the honest form at `k = 5, 6`, TRUE for the cover form.

## Stage 3 — SAVED: C-HULL-REG — MISSTATED; TRUE and much stronger under two named hypotheses (the pinching lemma), GAP as stated

*Setting.* An honest colouring `g` (a measurable `k`-colouring, a.e.-proper, in D-NF). A point `x ∈ ∂_e S_j` is **saturated for `j`** if it is a
`j`-contact point (§2.1: equivalently not `j`-free). **(H1)** at `x`: a ball `N = B(x, ρ)` in which `S_c` is null for `c ∉ {a, b}`. **(H2)** at `x`:
in `N`, `S_a` and `S_b` are each a.e. equal to a path-connected set of density points, `P_a ⊆ S̃_a`, `P_b ⊆ S̃_b`, with `x ∈ cl P_a ∩ cl P_b`.

### 3.1 M-PINCH — the pinching lemma [hand, one mind]

*Statement.* If (H1), (H2) hold at `x` and `x` is saturated for `a` and for `b`, with contacts `y_a ∈ supp S_a`, `y_b ∈ supp S_b` (`|x − y_a| =
|x − y_b| = 1`), then exactly one of:
- **(split)** `y_a = y_b =: y`, and either `S_a ∩ N = B(y, 1) ∩ N` and `S_b ∩ N = N ∖ B̄(y, 1)` up to null sets, or the same with `a` and `b` exchanged;
- **(tangent)** `y_b − x = −(y_a − x)`, and `B(y_a, 1) ∩ N ⊆ S_b`, `B(y_b, 1) ∩ N ⊆ S_a` up to null sets: two open unit discs tangent at `x` from
  opposite sides, each inside the colour whose contact is the *other* disc's centre.

*Proof.* **Step 1 (one side of each contact circle).** Take `q_n ∈ S̃_a`, `q_n → y_a` (`supp S_a = cl S̃_a`). M-HULL1 with the path-connected
`P_a ⊆ S̃_a` and the point `q_n ∈ S̃_a ⊆ A*_a` gives, for each `n`, `P_a ⊆ B(q_n, 1)` or `P_a ∩ B̄(q_n, 1) = ∅`. Pass to a subsequence of one type:
"in", `P_a ⊆ B̄(y_a, 1)`; "out", `P_a ∩ B(y_a, 1) = ∅` (a point `w` with `|w − y_a| < 1` is in `B(q_n, 1)` for large `n`). Likewise `P_b` with `y_b`.
No path-connected piece at the partner is used: the partner may be a cusp, a thin horn or dust. **Step 2 (cases).** `S_a ∪ S_b ⊇ N` a.e. by (H1).
*(in, in):* `N ⊆ B̄(y_a, 1) ∪ B̄(y_b, 1)` a.e., with `x` on both circles. If `y_a − x ≠ −(y_b − x)`, the open cone of directions `u` with
`u·(y_a − x) < 0` and `u·(y_b − x) < 0` is non-empty and `x + tu` (small `t > 0`) lies outside both discs, a set of positive measure; if the discs are
tangent at `x` from opposite sides (or equal), the region between the circles has positive measure in every ball about `x`. Impossible.
*(in, out):* `B(y_b, 1) ∩ N ⊆ S_a ⊆ B̄(y_a, 1)` a.e., so the open set `B(y_b, 1) ∩ N` lies in the closed disc `B̄(y_a, 1)`; two unit circles through
`x` with `y_a ≠ y_b` leave an open cone of directions inside the first disc and outside the second, so `y_a = y_b = y`; then `S_a ∩ N ⊆ B̄(y, 1)` and
`S_b ∩ N ∩ B(y, 1) = ∅`, which with (H1) is (split). *(out, in):* the same, exchanged. *(out, out):* `B(y_a, 1) ∩ N ⊆ S_b` and `B(y_b, 1) ∩ N ⊆ S_a`
a.e.; the two open discs meet `N` in disjoint sets (an open set of measure 0 is empty), and both circles pass through `x`: they are tangent at `x`
from opposite sides, `y_b − x = −(y_a − x)`. ∎

*What the two cases are.* (split) is a **unit arc of kind both** (row 135's term): its centre `y` carries both side colours. (tangent) is the
**parallel-partner** case (V0 §2.4 item 7(iv)): `y_a = x + ν_b` is a point of `supp S_a` across the `b`-side at distance exactly 1, and M-HULL1 with
`P_a` shows the `a`-material near `y_a` lies at distance `> 1` from `P_a`, i.e. beyond the unit-parallel curve of `∂_e S_a ∩ N`; likewise for `b`.

### 3.2 M-C11 — saturated two-colour interfaces are `C^{1,1}` with `|κ| ≤ 1` [hand, one mind; the rolling-ball step classical]

*Statement.* If every point of `∂_e S_a ∩ N` satisfies M-PINCH's hypotheses (with the same `N`, `P_a`, `P_b`), then for `N′ = B(x, ρ/4)`:
(i) at every `x′ ∈ ∂_e S_a ∩ N′` there are open unit discs `D^a(x′) ⊆ S_a`, `D^b(x′) ⊆ S_b` (within `N`, up to null sets) tangent at `x′` from opposite
sides; (ii) `∂_e S_a ∩ N′` is a `C^{1,1}` curve with curvature in `[−1, 1]` a.e. — a Lipschitz graph over its tangent at `x`, both semiconcave and
semiconvex (Rataj–Zajíček 2017, eq. (2): `C^{1,1}` ⟺ both); (iii) if one point of it is of type (split), all of `∂_e S_a ∩ N` is one arc of `T₁(y)`.
*Proof.* (i) is M-PINCH at `x′` (the (split) case gives both discs: `B(y, 1) ∩ N` on one side, `B(2x′ − y, 1) ∩ N ⊆ N ∖ B̄(y, 1)` on the other).
(iii) (split) at one point already fixes `S_a ∩ N` and `S_b ∩ N` as the two sides of `T₁(y)`. (ii) Every `x″ ∈ ∂_e S_a ∩ N′` lies outside both open
discs at `x′` (it has positive density for each colour, while `D^a(x′)` is a.e. in `S_a` and `D^b(x′)` a.e. in `S_b`), so
`|⟨x″ − x′, n(x′)⟩| ≤ |x″ − x′|²/2` with `n(x′)` the common normal. A closed set whose boundary points all admit two tangent open unit discs, one on
each side, is a domain with the two-sided rolling-ball property of radius 1, whose boundary is `C^{1,1}` with normal 1-Lipschitz — Blaschke's rolling
theorem in its two-sided form (the planar argument: the two inequalities at `x′` and `x″` bound the angle between `n(x′)` and `n(x″)` by
`O(|x′ − x″|)`, and the double-horn constraint makes each normal line near `x` meet the boundary once). [external for the classical step: Walther 1999
and the "two-sided supporting spheres" literature, not read here — a debt, §P] ∎

*What it does to arbitrary interfaces.* V0-WIG7's wiggled edges are **not saturated** (away from the vertex zones they are free for both colours:
§1.4, §2.5), so they do not bear on C-HULL-REG's statement — but they show its hypothesis is load-bearing: **saturation is exactly what removes
them.** Under (H1), (H2), a saturated interface is a unit arc splitting its neighbourhood, or a `C^{1,1}` curve with `|κ| ≤ 1` carrying unit discs of
both colours on both sides and parallel partners at distance 1 on both sides. A wiggle of curvature `> 1` is excluded outright; a gentle wiggle
survives only with a unit-parallel partner curve of the far colour on each side, which is itself an interface with its own partners — a **chain of
unit-parallel curves**, whose curvature is transported by row 134's shadow map `λ ↦ λ/(1 + λ)` (X16). Whether chains force straight segments or
end at unit arcs is the next rung (proposed stub, §P): it is REG-A off the junction set.

### 3.3 M-EXTREME — every region has at least two singular points on its minimal enclosing circle [hand, one mind]

*Statement.* Let `g` be saturated and honest with classes a.e. open, and `R` a component of the open class of colour `c`. `diam R ≤ 1` (M-HULL2), so its
minimal enclosing circle `∂B(o, r)` has `r ≤ 1/√3 < 1` (Jung) and meets `cl R` in at least two points. At each such `p`, M-PINCH's conclusion fails for
`R`'s side: either `d̄_c(p) = 0` (`R` is a cusp at `p`) or (H1) or (H2) fails at `p`.
*Proof.* Suppose `d̄_c(p) > 0` and (H1), (H2) hold at `p`, with `c` and some `d`. `p` is saturated. `P_c ∪ R` is a path-connected subset of the open
class (they share the positive-measure set `R ∩ N`), so `P_c ⊆ R`. M-PINCH gives an open unit disc tangent at `p` with `D ∩ N ⊆ S_c`, a.e. inside
`P_c ⊆ R ⊆ B(o, r)`. The interface is `C^1` at `p` (two tangent discs) and `R ⊆ B(o, r)`, so the tangent at `p` is the circle's and `D` lies on `o`'s
side: `D` is internally tangent to `B(o, r)` at `p` with radius `1 > r`, so it contains points near `p` outside `B̄(o, r)` — a positive-measure set in
`S_c ∩ N ⊆ R`, outside `R`'s enclosing disc. ∎
*Reading.* Voronov's Lemma 2.2 (a trichromatic point in every unit disc) has a saturated sharpening: every region carries at least two singular points,
at its extreme positions, and every closed unit disc about any point contains a region's singular points. The singular set Σ (cusps, points of three
or more colours, points where a colour's local part is disconnected — bichromatic vertices of degree `≥ 4`) is where REG-J must work (stage 4).
*Inhabitant at `k = 7`:* R7 — each up's minimal circle is its circumcircle, meeting it at its three vertices (lattice points, `|P| = 3`); each down's
meets it at its three cusps (`d̄ = 0`).

### 3.4 M-COVER-SC — the class-by-class form, for maximal covers [hand, one mind]

In a maximal cover (M-SATC) every `x ∈ ∂F_a` has a contact `y ∈ F_a`, and M-PINCH's Step 1 (which uses only M-HULL1) gives, for each path-connected
piece `P` of `F̃_a` near `x` with `x ∈ cl P`: `P ⊆ B̄(y, 1)` or `P ∩ B(y, 1) = ∅`. So each boundary point admits, per adjacent piece, an **enclosing**
or an **exterior** unit disc — one-sided only (the other side of `F_a` is covered by several classes, so Step 2 does not run). If `∂F_a` is locally
the graph of a continuous `u` with `F_a` below, both cases touch `u` from above at `x` by a function of second derivative `≤ 1` (the enclosing disc's
upper arc, `−1`; the exterior disc's lower arc, `+1`), so `u − s²/2` is concave: **`u` is semiconcave with constant 1** — the planar
positive-reach structure of Rataj–Zajíček (2017, Theorem 6.4, type `T¹`; the hypograph of a semiconcave function has positive reach). The graph
property itself is not proved here: GAP.

### 3.5 Controls

- **R7** (`k = 7`): every interface is of type (split): the up inside `B(v, 1)`, the down outside, `v` the arc's centre, carrying both colours (checked
  exactly in stage 2, (S)); the lattice points are singular (three ups meet); M-C11's conclusion (unit arcs) holds on every arc.
- **The strip** (row 136; `tools/fs112_y_check.py` `strip()`, read, not run for this): its vertical segments `x = x_{j+1}` (`x_j = j/2`) between `A_j`
  and `A_{j+1}` are of type (tangent): `A_j`'s colour recurs at `A_{j+3}`, whose left edge is `x = x_{j+1} + 1`, and `A_{j+1}`'s at `A_{j−2}`, whose
  right edge is `x = x_{j+1} − 1`, both over the same heights — straight parallel partners at distance 1 on both sides; its unit arcs are of type
  (split), kind both (row 136). Consistent with M-PINCH (read by hand from the checker's formula; one mind).
- **The disk** (row 136): every unit arc of kind both centred at a four-colour vertex — the (split) type; its non-arc interfaces not examined here.
- **The hexagonal colouring and V0-WIG7** (`k = 7`): not saturated (M-DEADLOCK); M-PINCH says nothing there, and they show the saturation hypothesis
  cannot be dropped from any regularity statement.

### 3.6 Verdict on C-HULL-REG

**MISSTATED.** *As stated* ("every `x` with `P(x) = {a, b}` has a neighbourhood in which `∂_e S_a` is the graph of a Lipschitz function, locally
semiconcave or semiconvex"): **GAP at (H1) and (H2)** — `P(x) = {a, b}` does not exclude (H1)'s failure (a third colour of density 0 at `x`, e.g. a
cusp touching an interface point, which makes `∂_e S_b` near `x` a union of the interface and the cusp's sides, not one graph) nor (H2)'s (several
`a`-components meeting at `x`: a bichromatic vertex of degree `≥ 4`, an X-shaped `∂_e S_a`, not a graph). No saturated colouring realising either was
built (that is W's side); none is excluded. *Corrected* (M-PINCH, M-C11): under (H1) and (H2) at every essential boundary point of `N`, `∂_e S_a` near
`x` is a `C^{1,1}` curve with `|κ| ≤ 1` — semiconcave **and** semiconvex — which is either one unit arc of kind both splitting the neighbourhood, or a
curve with unit discs of both colours tangent on both sides and unit-parallel partners. [hand, one mind]. *Class by class* (M-COVER-SC): semiconcave
with constant 1 wherever `∂F_a` is a graph; the graph property GAP. **Registration E4** (C-HULL-REG TRUE given C-SAT-T, 0.5): as stated GAP; its
corrected form TRUE with a stronger conclusion than registered.
