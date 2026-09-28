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

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.

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
