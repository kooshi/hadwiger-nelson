# FS112-NB3 — round-3 blind verifier of FS-112's proof side (FS112-N3)

*Job FS112-NB3, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `75e38d12`. Brief: `data/fs112/briefs/NB112-verify-proof.md` with its instance file
`data/fs112/briefs/NB3-112-instance.md` (which wins where they differ) and `data/fs112/briefs/STANDING-RULES.md`. Working files `data/fs112/fs112-nb3/`;
exact checks `tools/fs112_nb3_checks.py`. Stage 1 is blind: N3's section of `plans/FS112-N-proof.md` (l. 584 on), its tools and outputs stay unread until
this stage is committed. Notation as `plans/FS112-N-proof.md` §1.3 and `plans/FS110-N-proof.md` §N4-2: `Γ` the boundary set, `P_cl(x)` = `c(x)` the
colours of tiles whose closure holds `x`, `ω(x)` the unit circle about `x`, N-E0/E1/E2, a **valid** map (unit arcs allowed), merged (no arc has one
colour on both sides).*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| NB3-NOBOTH | a centre `P` of a unit arc whose two side colours both lie in `P_cl(P)` has `≥ 4` colours or a colour in two sectors | hand, one mind (over N112-U1) | §1.4 |
| NB3-FAIL | CB's D2 strip at `q ∈ ω(u)` fails only where an arc leaving `u` lies on `ω(q)` and the other votes split; there inside `ω(u)` only the inner colours of those arcs (of `c(u)`) are admissible, outside only the outer ones | hand, one mind; first-order vote model tools exact (FAIL) | §1.4 |
| NB3-ANTI | CE5 holds with unit arcs: at an M-in point both arcs bounding the colour's sector at `u` vote non-inside (`≤ 1`); two such votes at antipodes force `x = u` | hand, one mind | §1.4 |
| NB3-COR3 | a close complementary pair of cubic trichromatic vertices: at both crossings `w` of their unit circles both strips fail (each `w` a leaving centre of both), and `w` carries an inner and an outer colour of each vertex's arcs: `≥ 4` colours | hand, one mind; side-cone forcing tools exact (COR3, 403 + 128 + 336 cases) | §1.4 |
| NB3-P′ | two cubic trichromatic vertices with one multicolour are never at distance 1 | hand, one mind (over NB3-NOBOTH) | §1.4 |
| NB3-II | (ii) fails only when `x` or `y` is a both-centre (so, by NB3-NOBOTH, a `≥ 4`-colour or repeated-colour vertex) | hand, one mind | §1.4 |
| NB3-I | (i) fails only when `x` and `y` are both both-centres and one circle runs along `Γ` at the other point; with `c(u₁) = c(u₂)` and both transversalities, never otherwise (pigeonhole on the 3-set) | hand, one mind | §1.4 |
| NB3-BASE | CB's route (with CE's repair) refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)` holds a vertex of `≥ 4` colours or a repeated colour — inert unit arcs centred in `B̄(u, 1)` bent first by N2-TOWARD | hand, one mind for the assembly; over row 134's base, N2-TOWARD (two minds: N2, NB2) | §1.4 |
| NB3-DENSE3 | every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a repeated colour | hand, one mind (over NB3-BASE and NB2-DISC1) | §1.4 |
| NB3-STEP | with `λ_k ≤ f(λ_{k+1})`, `f̃(υ_{k−1}) ≤ υ_k`, `λ_k < υ_k`: both non-decreasing, one strictly, at every step | hand, trivial; tools exact (STEP) | §1.4 |
| NB3-LEN | with all curvatures in `K`, a chain has `≤ 2\|K\| − 3` vertices (so `≤ 2\|K\| − 1`); a one-sided infinite chain has infinitely many curvatures | hand; tools exact on five sets (LEN) | §1.4 |
| NB3-RAYR | upward-infinite chain from `P_0`: `f̃^k(−1) = −1/(k+1) ≤ λ_k < υ_k ≤ 0` | hand; tools exact `k ≤ 60` (RAYR) | §1.4 |
| NB3-PER | a doubly periodic valid map has a periodic terminal modification (orbit moves; cross pairs of translates were same-colour pairs of the original) | hand, one mind | §1.4 |
| NB3-END | at a chain's bottom end with `λ_0 = −1` and both upper bounds `< 1`, `P_{−1}` carries `c`, `g` twice, `y` and `z` (four colours, `g` repeated) and the lower arc of `g`'s `+a` horn at `P_{−1}` is a both-kind unit arc centred at `P_{−2}`; an upper bound `+1` makes the chain `{P_0}` | hand, one mind | §1.4 |

## Would-have-searched-here log (standing rule 3)

- NB3-BASE: I would have tried to build a counterexample vertex figure (a cubic `u` with unit arcs and no `≥ 4`/repeated vertex within 2) by a local
  search; instead I walked every step of CB D1–D6 and CE R1–R4 and named, per step, which unit circle it reads and what excludes the exception.
- NB3-COR3: I would have enumerated arc placements at the crossing point by a solver; instead derived the side-cone forcing and checked its combinatorics
  exactly on 403 + 128 + 336 named angle configurations (a check of a derived claim, not a search for an object).
- NB3-I's residue (mutual both-centres): I would have searched for a local fragment; named as a GAP instead.
- NB3-END: I would have enumerated sector orders at `P_{−1}`; derived instead from U1, N-E2 and the shave criterion.

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls data/fs112/`, `ls tools/ | grep fs112` and `ls plans/ | grep -i fs112` printed the **names** of fenced files and directories
   (`fs112-a*`, `fs112-y*`, `reports`, `tools/fs112_n3_checks.py`, `tools/fs112_y*`, `plans/FS112-Y*`, `plans/POROS-…`, the close inventory); none opened.
   `ls data/fs112/briefs/` printed the other briefs' names; I opened only `NB112-verify-proof.md`, `NB3-112-instance.md`, `STANDING-RULES.md`
   (and grepped `N112-proof.md` for nothing).
2. `grep -n "Continuation — FS112-N3" plans/FS112-N-proof.md` printed the fenced section's **heading line** (l. 584). I read l. 1–583 only.
3. `grep -n "N2-ROT\|N2-HEX" plans/FS112-N-proof.md | cut -c1-80` printed **one line of the fenced section**, l. 848, truncated: "N2-ROT, N2-HEX) were not
   walked separately in this job or in N's walk: **" — the instance file already says so; no derivation content.
4. `git log --oneline -3` at launch printed the three start-up snapshot commits; `git log -1 --format=%H -- CLAUDE.md` printed a bare hash. No other
   `git log`.
5. Read, open to me by the instance file: `plans/FS112-N-proof.md` l. 1–583 (rounds 1–2), `plans/FS112-NB2-verification.md` l. 88–150 (its N2-RAY and
   N2-DENSE verdicts, including NB2-END's sketch), and FS-110's `plans/FS110-CB-verification.md`, `plans/FS110-CE-verification.md`,
   `plans/FS110-N-proof.md` l. 330–425 (N2-RING/SWAP/ROT/HEX), l. 640–670 (N3-P17, N3-RED), l. 777–945 (N4-2).

## Stage 1 — SAVED: quotation check and the blind verdicts

### 1.1 Files read from disk (this order)

`STANDING-RULES.md`; `NB112-verify-proof.md`; `NB3-112-instance.md`; `CLAUDE.md` § The aim, § Counter-priors, G82 from disk (G21, G51, G79 as loaded,
unchanged on a spot check); `LEDGER.md` rows 131–134; `data/fs112/claims.md` in full; `plans/FS112-unit-arc-half.md` §G part 3, §PA, §IQ (not §5.3);
`plans/FS112-N-proof.md` l. 1–583; `plans/FS110-CB-verification.md` in full; `plans/FS110-CE-verification.md` in full; `plans/FS110-N-proof.md` as
above; `plans/FS112-NB2-verification.md` as above. Not read: `plans/FS112-PA-reading.md` (reading debt, logged; nothing below rests on the prints).

### 1.2 Quotation check (standing rule 5)

| quotation / address in my brief | source | verdict |
|---|---|---|
| standing rules' Kooshi quotations ("From here on out, you may doubt …", "to eliminate the crutch …", "A proven theorem about why its impossible is also valid. All novel knowledge is a success.", "search for a finite graph is out. It would be huge, not feasible.", "It's ok if jobs overrun a bit. …") | `CLAUDE.md`; `plans/CONSOLIDATION-2026-09-27.md` | **exact**, all five (`grep -c` = 1 each) |
| "The base" is "row 134's (S–V Cor. 1 almost everywhere, as FS110-CB, CD and CE derive it)" | `LEDGER.md` row 134's grade clause | consistent |
| "the ring lemmas N2-ROT and N2-HEX (from round 2; in `plans/FS112-N-proof.md` § Continuation — FS112-N2, open to you)" | `plans/FS112-N-proof.md` l. 303–583 hold no N2-ROT or N2-HEX; they are **FS-110's** round-2 lemmas: `plans/FS110-N-proof.md` l. 374 (N2-ROT), l. 393 (N2-HEX), `plans/FS110-derivation.md` l. 220; FS112-N names them at l. 119 and l. 197 | **MISADDRESSED** (the owner's pointer); I walked FS-110's |
| the fourteen N3 statements, "verbatim from N3's … table" | fenced | **deferred to stage 2** |
| the side's report, `data/fs112/reports/FS112-N3.md` l. 13 | fenced (brief: `data/fs112/reports/`) | **deferred to stage 2** |

### 1.3 Readings of the round-3 terms (instance: "derive it under the most natural reading and name the reading")

- **both-centre** — a point `P` that is the centre of a unit arc `α ⊂ ω(P) ∩ Γ` with `s_in(α), s_out(α) ∈ P_cl(P)` (claims §0's "both" contact kind).
- **leaving centre** of a vertex `u` — a point `q ∈ ω(u)` such that an arc of `Γ` leaving `u` lies on `ω(q)` (so `q` is its centre); **double** — for
  a pair `(u, v)`: a leaving centre of both `u` and `v`.
- **`C`** — the constraint the strip argument puts on the colours of tiles near `q` on each side of `ω(u)`; "fails" — D2's majority vote gives no clean side.
- **in-votes** — CE's votes read the other way: arc `ij` casts an in-vote at `e` when `|u + e − x_ij(δ)| > 1` (the strip would be inside).
- **(i), (ii)** — CB's D2 statements for `x ∈ ω(u₁)`, `y ∈ ω(u₂)`, `|x − y| = 1`, under transversality: (i) `c′(x) = c′(y) = {a}` impossible; (ii)
  `c′(x) = c′(y) = {a, b}` impossible. **(P′)** — CB D1: `|x − y| = 1 ⟹ c(x) ⊄ c(y)`; N3-P′ is its vertex form.
- **"four-colour"** — at least four colours; **"stuck chain"** — N4-STUCK's structure at every `P_k` (with unit arcs, bounds in `[−1, 1]`) in a map
  where no MERGE, MERGE-RAY or SHAVE applies at its vertices and their neighbours; **"doubly bounded one-vertex chain"** — a chain `{P_0}` with a horn bound
  `−1` and a horn bound `+1`.

### 1.4 The blind verdicts, in the instance file's priority order

#### N3-NOBOTH — "a both-centre is a vertex with `≥ 4` colours or a repeated colour"

**TRUE** [hand, one mind]. Let `α ⊂ ω(P)` have length `ℓ ∈ (0°, 60°)`, `s_in, s_out ∈ P_cl(P)`. By N112-U1 (re-derived: a point `z = P + r d` with
`d·e_w > 0` for some `w ∈ α` is within `< 1` of `T_out`'s points `(1 + ε)e_w` and `> 1`-straddled by continuity; mirror for `T_in`), `s_in`'s sectors lie in
the closed facing cone `F`, `s_out`'s in the closed away cone `A`, and the two open side cones `S₁, S₂` (angle `ℓ` each, cyclic order `F, S₁, A, S₂`) hold
neither. Each `S_i` has positive angle and finitely many arcs leave `P`, so each contains sector interiors, of colours `∉ {s_in, s_out}`. One colour
`γ` in both would need one sector spanning `F` or `A` — impossible, since `s_in`'s sector (or horn) lies in `F` and `s_out`'s in `A`, and a horn inside a
`γ`-sector already splits it — so `γ` has two sectors (repeated), or `S₁`, `S₂` carry different colours `γ₁ ≠ γ₂` and `P_cl(P) ⊇ {s_in, s_out, γ₁, γ₂}`.
`P` has `≥ 3` colours, so it is a vertex. *Where six is spent:* nowhere (one arc, one circle family). *Seven-colour control:* no unit arc, vacuous.

#### N3-FAIL — "the strip at `q ∈ ω(u)` fails only at a leaving centre; there `C` allows only the unit arcs' inner colours inside, outer outside"

**TRUE** [hand, one mind; first-order model tools exact]. `u` cubic, `c(u) = M = {4,5,6}`, `q = u + e`. D2's step: for fixed small `δ` the signs of
`|q − x_ij(δ)| − 1` (`x_ij(δ)` the arcs' points at radius `δ`) fix, for all `z` near `q`, which sectors of `u` `ω(z)` enters; if two of the three are
`< 0` every sector has a point inside `B(z, 1)` and `u` outside it for `z` strictly outside `ω(u)`, so those `z` are colour `∉ M` (the mirror for `> 0`).
A sign is `0` for all small `δ` only when the arc lies on `ω(q)` (an arc not on `ω(q)` meets it finitely, Condition 3), i.e. `q` is a leaving centre;
with one zero the strip still holds when the other two agree. **Failing configuration** (one arc `45` on `ω(q)`, inner `5`, outer `4`, the other two
votes split): from inside `ω(u)` a point sees `4` and `6`, from outside `5` and `6` — admissible `{1,2,3} ∪ {5}` inside, `{1,2,3} ∪ {4}` outside.
**Two arcs on `ω(q)`** (leaving `u` both ways along `ω(q)`): shared outer `4` with inners `5, 6` — inside `{5, 6}`, outside `{4}`; or shared inner `5` with
outers `4, 6` — inside `{5}`, outside `{4, 6}`. In every failing case: inner colours inside, outer outside. The claim bounds the admissible set from above,
which is what the vote proves (a sector not seen at the vote's scale is not thereby admissible). Tool FAIL: 16 of 28 single configurations fail, exactly the
split ones, with `{5}`/`{4}`; both double cases as stated; the plant (the arc given a vote) fires. *Six:* "`{1,2,3}` is the complement of `c(u)`".

#### N3-ANTI — "CE5 (the Antipodal Lemma) survives unit arcs, by counting in-votes"

**TRUE** [hand, one mind]. Let `x = u + e` be M-in with colour `i ∈ M`: points `z` of an `i`-tile strictly inside `ω(u)` arbitrarily near `x`. By (P)
`ω(z)` misses `u`'s `i`-sector; `u ∈ B(z, 1)`, so every point of that sector near `u` is within `≤ 1` of `z`, and in the limit the two arcs `A, B`
bounding the `i`-sector satisfy `|u + e − x(δ)| ≤ 1` for all small `δ` (a strict `> 1` — an in-vote — would put a sector point outside `B̄(z, 1)` for `z`
near `x`, and the sector, connected, would cross `ω(z)`). So an M-in point has at most one in-vote. At an antipodal M-in `u − e` (colour `i′`, arcs
`A′, B′`), `{A, B} ∩ {A′, B′} ≠ ∅` (two 2-subsets of three arcs), and a shared arc's point `x(δ)` has `|u + e − x| ≤ 1`, `|u − e − x| ≤ 1`, so
`2 ≤ |u+e−x| + |x−u+e| ≤ 2`: equality, `x` the midpoint `u`, against `|x − u| = δ > 0`. Zero votes (a leaving arc) are harmless: the proof needs only
`≤ 1`. No tangent is used, so cusps change nothing (CE's remark stands).

#### N3-COR3 — "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus whose other corners are four-colour double leaving centres"

**TRUE** [hand, one mind; tools exact]. `u, v` cubic, `c(u) = M`, `c(v) = [6] ∖ M`, `0 < |u − v| < 2`; `ω(u)`, `ω(v)` cross transversally at `w₀, w₀′`
(`u w₀ v w₀′` a unit rhombus). Cor. 3's proof: if both strips hold at a crossing `w`, the open quadrant of their clean sides near `w` holds tile points
with colour `∉ M` and `∈ M`. So at `w₀` and at `w₀′` a strip fails, hence (NB3-FAIL) `w` is a leaving centre. **One failure is not enough:** if `v`'s strip
holds on side `σ_v`, the tangent `t_u` of `ω(u)` at `w` is interior to `σ_v`; each arc of `u` centred at `w` has a side cone adjacent to `+t_u` and one to
`−t_u` (it ends at `u`, direction `⊥ t_u`), on opposite sides of `ω(u)`; directions there must carry a colour in `M ∩ (inner or outer colours of u's arcs)`
= one of that arc's own side colours (or, for two arcs, the other arc's, which its own side cone then excludes) — against N112-U1. So **both** strips fail
at `w₀` and at `w₀′`: each is a leaving centre of `u` and of `v`. Then each quadrant at `w` admits only side colours of `u`'s and `v`'s arcs; `u`'s side
cones at `±t_u` (on opposite sides of `ω(v)`) force a `v`-inner and a `v`-outer colour, and `v`'s side cones a `u`-inner and a `u`-outer colour; inner and
outer sets are disjoint for one vertex (one arc; or two arcs with a shared outer or a shared inner colour), and `u`'s colours are disjoint from `v`'s:
`|P_cl(w)| ≥ 4`. Tool COR3 (angles exact, `θ = ∠uwv ∈ {3°, …, 177°}`, arc lengths `5°–50°`, single/double arcs of each orientation): in all 336
strip-holds cases a probe has no admissible colour; in all 403 both-fail cases the four classes are forced; 128 further both-fail cases are impossible
outright; 141 overlapping placements skipped. Plant (U1 dropped) fires. *Six:* `c(u) ∪ c(v) = [6]`.

#### N3-I / N3-II / N3-P′ — "(i) never fails; (ii) fails only at a four-colour or repeated-colour vertex; same-multicolour cubic trichromatic vertices are never at distance 1"

- **(P′) as stated: TRUE** [hand, one mind]. Let `x, y` be cubic trichromatic, `c(x) = c(y)`, `|x − y| = 1`. If `ω(y)` enters a tile at `x`, its colour
  is in `c(x) ∖ c(y)` by (P). Otherwise `ω(y)` runs along `Γ` on both sides of `x`: `x` is not interior to an arc (it has three colours), so it is the
  junction of two arcs `β₁, β₂ ⊂ ω(y)` meeting at `180°`, with the third arc on one side: `c(x) = {A, B, C}`, `β₁`'s sides `{A, B}`. Then `A, B ∈ c(y)`:
  `y` is a both-centre with exactly three colours and one sector each, against NB3-NOBOTH.
- **(ii): TRUE** [hand, one mind]. The proof enters the strip beside `x` (side `σ_x`) with the transversal `ω(y)`. It fails only if (1) the strip fails at
  `x` — `x` a failing leaving centre of `u₁`; then `ω(y)` meets, on each side of `ω(u₁)`, a tile whose colour is not in `c′(x) = c′(y)`, hence an inner
  colour inside and an outer colour outside (NB3-FAIL), both in `c(x)`: `x` is a both-centre (one arc; for two arcs, of the arc whose inner and outer
  colours they are); if `ω(y)` runs along an arc `β ⊂ ω(y)` on one side instead, `β`'s sides lie in `c(x) ∩ ({a, b} ∪ X^in)` and again `x` carries an inner
  and an outer colour — or (2) `ω(y)` runs along an arc `β ⊂ ω(y)` inside the clean side: `β`'s sides are `a` and `b`, both in `c′(y) ⊆ c(y)`: `y` is a
  both-centre. By NB3-NOBOTH the failing point has `≥ 4` colours or a repeat.
- **(i): TRUE except at one named configuration; GAP there** [hand, one mind]. Case (2) cannot occur (`β`'s sides would both be `a`: merged). In case (1)
  with `ω(y)` entering tiles on both sides, the two entered colours `I ⊆ c(x) ∩ c(u₁)` avoid `c(y)`; from `y`'s side symmetrically `J ⊆ c(y) ∩ c(u₂)`,
  `|J| = 2`, avoiding `c(x)`; with `c(u₁) = c(u₂)` (Lemma 3, or one circle) `I ∩ J = ∅` in a 3-set: contradiction. When `ω(y)` runs along an arc at `x` and
  `ω(x)` along an arc at `y`, the count leaves `c(x) ∩ M = {e_x, s}`, `c(y) ∩ M = {e_y, s}` with no contradiction found: `x` and `y` are then **mutual
  both-centres** (each the centre of a unit arc through the other point, and each a leaving centre). The base never meets it: there `x, y ∈ B̄(u, 2)` and
  a both-centre is excluded. Also the claim is silent when only one transversality holds; the base uses (i) only where both hold (CB D4: at `t > 0`).

#### N3-BASE — "the base refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)` holds a vertex of `≥ 4` colours or a repeated colour"

**TRUE** [hand, one mind for the assembly; over row 134's base (CB D1–D6 with CE's R1–R4 and AL) and N2-TOWARD (two minds)]. Assume **H**: no vertex of
`B̄(u, 2)` has `≥ 4` colours or a repeated colour. Every centre the base reads (`u`; the pigeonhole vertices `u₁, u₂`, the V-in vertices and the eleventh
point, all in `B̄(u, 1)`) is cubic; every point whose colours it reads lies in `B̄(u, 2)`. Under H there is **no both-centre** in `B̄(u, 2)` (NB3-NOBOTH).
The steps, each with the unit circle it reads and what closes its exception:
1. **(P)**: no Condition 5.
2. **D2's strip at `q ∈ ω(u_i)`**: fails only at a leaving centre (NB3-FAIL); there `c(q) ∩ M` lies in the inner colours or in the outer ones (else `q` is a
   both-centre), so one side is clean and D2's neighbourhood `N_q` takes it; where sides switch, a nearby point has both sides clean. So `γ(u)` and the
   pseudo-colouring exist.
3. **`c′ ≠ ∅`**: at a point where `ω(u)` runs along `Γ`, an arc with both sides in `M` would make `u` a both-centre.
4. **Finitely many `|c′| = 2`**: fails exactly along **inert** arcs of `ω(u_i)` (both sides outside `c(u_i)`). **Closed by pre-processing:** bend every
   inert unit arc centred in `B̄(u, 1)` toward its centre (N2-TOWARD: `s_out ∉ P_cl(P)`; valid, ends included, no new unit arc; at the ends the sector
   structure is unchanged and interior arc points only lose a colour), so H and `u`'s type survive; finitely many arcs, each bend removes one.
5. **Cor. 3** (and `|c′| ≤ 2`): NB3-COR3 — the rhombus corners are within 1 of a pigeonhole point, so in `B̄(u, 2)`, and four-colour: excluded by H.
6. **(i)/(ii)**: NB3-I, NB3-II — failures need a both-centre in `B̄(u, 2)`.
7. **(P′)** at vertex pairs (D1's consequence; D5 item 6's "`≠ 1`"): NB3-P′. At item 1 with different third colours, (ii) (CE7).
8. **D4 (Lemma 3's bicycle)**: uses only 2–6 (CE's E1 list: (i), (ii), `|c′| ≤ 2`, closedness, finiteness).
9. **D5 items 1–4 with R1–R4**: item 3's "`ω(w)` meets the `a`-tile" survives a run of `ω(w)` along `P`: `ω(w)` must leave `cl Q` through `P`'s interior
   (it meets `ω(u)` only at `x` and `x ± 120°`, outside the `< 60°` arc), and `P`'s interior points are corners, so it then enters the `a`-tile.
10. **D5 item 5 (Prop. 17)** by FS-110's N3-P17 route: **the named check — N2-ROT and N2-HEX walked, both survive.** N2-ROT uses N-E2 only (the ring's
    tiles at `σ^{±1}x` beside `ω(u)`, whether `ω(u)` runs through a tile or along an in/out arc of `Γ` there) and the tangent half-planes of `ω(σ^{±1}x)`;
    its "no `r`-tile at `x`" is a covering pair at distance 1, i.e. a close complementary pair (NB3-COR3, corners in `B̄(u, 1)`) or a `≥ 4`-colour `x`:
    excluded by H. N2-HEX is sector geometry at `u`. In P17 itself `P_cl(x₁) = {p, q, g}` is H, and the one Condition-5 step ("the arc … leaves `x₁`
    tangent to `ω(x₂)` with curvature `≠ 1`") fails only on a unit arc of `ω(x₂)` with sides `q` (`∈ P_cl(x₂)`: the ring colour before `x₂`) and `g`
    (`x₂`'s cone colour): `x₂` a both-centre, excluded.
11. **D5 item 6**: `|p − p′| ≥ 1` (N-E0 on `a`-side curves), `≠ 1` (NB3-P′), `< 2` (NB3-ANTI), Lemma 3, Cor. 3 for the eleventh point; hole-filling is
    valid with unit arcs (move the outside centre off the finitely many unit-arc centres).
12. Lemma 5, Prop. 18, the `< 9` branch: circle-abstract, from (i), (ii) and finiteness (as CB and CE take them).
*Where six is spent:* the base's multicolour count, NB3-COR3's complement, NB3-I's pigeonhole on a 3-set, NB3-FAIL's complement. *Seven-colour control:* the
hexagonal seven-colouring satisfies H everywhere and is valid; the base does not start (a trichromatic ring sees four colours), as required. *Killing test 8
(CAL-STRIP):* every trichromatic vertex of the strip lies within `1.834` of a midline four-colour (Q) centre (card X1 as N2 reports it), so the conclusion
holds on the strip and nothing is refuted; the step reads outside the strip only where the conclusion is already met. *C-LOCAL:* radius 2 about `u`.

#### N3-DENSE3 — "every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a repeated colour"

**TRUE** [hand, one mind; over NB3-BASE]. Every closed disc `B̄(x, 1)` holds a vertex of degree `≥ 3` (NB2-DISC1: nested surrounding tiles lie in
`B̄(x, 1)`; local finiteness ends the nesting at a branch point). Such a vertex has a repeated colour, `≥ 4` colours, or is cubic trichromatic `w`; then
NB3-BASE puts one of the first two in `B̄(w, 2) ⊆ B̄(x, 3)`. No terminal modification is needed.

#### N3-STEP — "along a stuck chain neither `λ` nor `υ` decreases and one of them strictly increases at every step"

**TRUE** [hand, trivial; tools exact]. On `(−1, 1)`, `f(x) = x/(1+x) ≤ x` and `f̃(x) = x/(1−x) ≥ x`, equality only at `0`. So
`λ_k ≤ f(λ_{k+1}) ≤ λ_{k+1}` and `υ_{k+1} ≥ f̃(υ_k) ≥ υ_k`; both equalities need `λ = υ = 0`, against `λ_k < υ_k`. Inside a chain `λ_{k+1} = −1` and
`υ_k = 1` do not occur (N112-END), so `f` and `f̃` are defined at every step; at the ends `[−1, 1]` changes nothing.

#### N3-LEN — "with every horn curvature in a finite set `K`, a chain has at most `2|K| − 1` vertices; a one-sided infinite chain carries infinitely many curvatures"

**TRUE, and the argument gives `2|K| − 3`** [hand; tools exact]. By NB3-STEP the index sum `idx(λ_k) + idx(υ_k)` rises by at least one per step, from
`≥ 3` to `≤ 2|K| − 1` (`λ < υ` strictly): at most `2|K| − 3` vertices. Tool LEN confirms on five sets (with the chain relations the longest chains are
shorter still); the plant (non-strict, relations dropped) reaches `2|K| − 1` exactly. The second clause follows. Wording, not truth: the stated bound is
not sharp.

#### N3-RAYR — "on an upward-infinite chain `−1/(k+1) ≤ λ_k < 0`: the horn at `P_k` needs a boundary arc of radius `≥ k+1` (mirror downward)"

**TRUE** [hand; tools exact], reading `k` from the chain's lower end `P_0` (`λ_0 ≥ −1`). Upward, `υ > 0` dies in `⌈1/υ⌉` steps (N4-FIN's count), so all
`υ_k ≤ 0` and `λ_k < 0`. From `λ_{k−1} ≤ f(λ_k)` and `f̃ = f⁻¹` increasing, `λ_k ≥ f̃(λ_{k−1}) ≥ f̃^k(−1) = −1/(k+1)` (RAYR exact to `k = 60`). The
lower arc has radius `1/|λ_k| ≥ k + 1`. The bound is attained by N2-RAY's ray, whose lower arcs are the concentric circles about `P_{−1}` (NB2).

#### N3-PER — "a doubly periodic valid map has a periodic terminal modification (so finitely many arc classes)"

**TRUE** [hand, one mind; over N2-TERM's moves]. No period has length 1 (else every point meets its own colour at distance 1). Apply each move to its
whole orbit at once. A move is supported either in a ball of radius `ρ` (MERGE, MERGE-RAY, SHAVE), and `ρ` below `min_τ ||τ| − 1|/3` over the finitely
many periods of length in `[1/2, 2]` keeps translate pairs off distance 1; or in a bend's lens `L ⊂ T_in`, and a pair in `L × (L + τ)` was an
`s_in`–`s_in` pair of the original map, never at distance 1. Each orbit move lowers the per-period potential (N4-TERM's `Φ`, N2-RED's arc count), so
finitely many orbit moves end in a terminal periodic map. The use: finitely many curvatures, so every chain is finite (NB3-LEN) — no stuck ray.

#### N3-END — "a stuck chain's end with horn bound `−1` has a four-colour, repeated-colour vertex one step beyond and a both-kind unit arc centred two steps beyond (or is the doubly bounded one-vertex chain)"

**TRUE** [hand, one mind; NB2-END's sketch completed]. Frame N4-2: `v = P_0` the chain's lower end, `c` its cone colour with horns `H_±`, `g` filling the
`+n` side, `h` the `−n` side, `λ_0 = −1` for `H_+`: its lower arc `α ⊂ ω(S′)`, `S′ = P_{−1}`, `s_in = h`, `s_out = c`.
1. If an upper bound of `H_±` is `+1`, that arc lies on `ω(P_1)` with the horn colour `c` outside, and a stuck `P_1` would need `c` to fill its `+n` side
   against N112-U1 (N112-END's argument): the chain is `{P_0}`, doubly bounded. Otherwise both upper bounds are `< 1`.
2. No SHAVE at `v`: each horn needs a `g`-shadow. With upper bound `< 1` no in-type `g`-tile at `N` exists (the flank is not in `B̄(N, 1)`), other
   contacts are cleared (N3-CLEAR), and a `g`-tile at `S′` not tangent to `±a` shadows only `B(S′, 1)`, which `H_+` avoids. So `g` has tiles at `S′`
   tangent to `+a` and to `−a`, out-type relative to `v`. `c ∈ P_cl(S′)` (N3-DEG at `v`), its sectors in `α`'s away cone (U1), below: the two `g`-tiles are
   **two sectors** of `g` at `S′`.
3. Terminal at `S′`: no MERGE, so `int D_g(S′) = ∅` and (N3-DEG) `g`'s sectors are horns along `±a` with out-type contacts at `v` and `P_{−2}`.
4. The sector just below `g`'s `+a` horn lies in `α`'s side cone `(−ℓ, 0)`: colour `y ∉ {c, h}` (U1), `≠ g`. The sector just above it: `z ≠ g`, `≠ c`
   (away cone). **`z ≠ y`:** else both flanks are `y`; `y ∉ P_cl(v)`; a `y`-tile at `P_{−2}` would be Siamese to the lower flank (points at distance `< 1`
   from `P_{−2}` — or, for a horn flank, `≤ 1` only if its upper arc has curvature `−1`) and outer to the upper flank (points at distance `> 1`) — N-E2
   twice, so none exists unless a flank is a horn above curvature `−1`, where it is outer to both and its shadow, downward closed, would cover the lower
   flank. So the horn is `y`-clear and SHAVE applies: against terminal. **`P_{−1}` carries `c, g, y, z`, `g` twice.**
5. No SHAVE of that horn with `z ≠ y` needs a `y`-shadow on it; `y ∉ P_cl(v)`, an out-type `y` at `P_{−2}` shadows a downward-closed set meeting the lower
   flank, so the shadow is an in-type `y`-tile at `P_{−2}`, Siamese to the lower flank — possible only when the horn's lower arc is an arc of `ω(P_{−2})`
   (else the flank has points at distance `> 1` and `< 1` from `P_{−2}`). That arc has `s_in = y`, `s_out = g`, both in `P_cl(P_{−2})` (`g` out-type by 3):
   **a both-kind unit arc centred at `P_{−2}`** (so `P_{−2}` has `≥ 4` colours or a repeat, NB3-NOBOTH).

### 1.5 Summary of stage 1

| claim | NB3 verdict (blind) | grade, minds |
|---|---|---|
| N3-BASE | TRUE (inert arcs pre-bent by N2-TOWARD — a named step the statement needs for a general valid map) | hand, one mind (NB3) |
| N3-DENSE3 | TRUE | hand, one mind |
| N3-NOBOTH | TRUE | hand, one mind |
| N3-FAIL | TRUE | hand + tools, one mind |
| N3-ANTI | TRUE (zero votes harmless; `≤ 1` suffices) | hand, one mind |
| N3-COR3 | TRUE (readings: "double" = of both vertices; "four-colour" = `≥ 4`) | hand + tools, one mind |
| N3-I | TRUE off mutual both-centres; **GAP** at that configuration as an unconditional statement; not needed by the base | hand, one mind |
| N3-II | TRUE | hand, one mind |
| N3-P′ | TRUE | hand, one mind |
| N3-STEP | TRUE | hand + tools |
| N3-LEN | TRUE (the argument gives `2\|K\| − 3`) | hand + tools |
| N3-RAYR | TRUE | hand + tools |
| N3-PER | TRUE | hand, one mind |
| N3-END | TRUE (reading of "doubly bounded one-vertex chain" as above) | hand, one mind |

**The named check (N2-ROT, N2-HEX under P17): both survive; P17's only unit-arc exception makes `x₂` a both-centre** (§1.4 N3-BASE step 10).
**Selection audit (G21).** The result flatters the NO side; the checks spent against it: NB3-I's count was pushed until it failed (the mutual-both-centre
residue); NB3-END's `z = y` case was pushed through horn flanks; NB3-COR3's single-failure case was checked for both arc orientations and both doubles
(tools); the inert-arc case of step 4 is the one place the base, read literally, breaks on a general valid map, and it is closed only by a modification.

## Stage 1 — SAVED

## Stage 2 — SAVED: N3's section read; divergences

*Read after stage 1's commit (`83f40a5d`): `plans/FS112-N-proof.md` l. 584–908 (§ Continuation — FS112-N3) in full; `tools/fs112_n3_checks.py` (header, VOTES, ANTI)
and `data/fs112/fs112-n/n3-checks-selftest.out`. Not opened: N3's report (`data/fs112/reports/` stays fenced for me except NB's and NB2's).*

### 2.1 Quotation check, completed

- The fourteen statements the instance quotes from N3's table (l. 594–608): **all exact** (a script over the table cells; N3-LEN by `grep -F`, whose `2\|K\|`
  carries the table's escape in both files).
- The instance's quotation of N3's report, l. 13: **not checkable** (the report is fenced for me). Its content — N2-ROT/N2-HEX "not walked", "a named check for the
  verifier" — matches N3's record, l. 847–848.
- N3's own pointer is right: l. 847 names them "FS110 N2-ROT, N2-HEX"; the instance's address (`plans/FS112-N-proof.md` § FS112-N2) is the owner's slip (§1.2).

### 2.2 Divergences (both addresses; kind; whether a verdict changes)

| # | claim | NB3 (stage 1) | N3 | kind | verdict change? |
|---|---|---|---|---|---|
| 1 | N3-I, "(i) never fails" | TRUE off **mutual both-centres**; GAP there as an unconditional statement (§1.4 N3-I) | TRUE unconditionally by **perturbation**: `c′` is locally constant at a singleton (`{p : a ∈ c′(p)}` closed, `c′ ≠ ∅`), leaving centres are at most three, so a failing pair `(x, y)` has failing pairs `(x′, y′)` nearby with `x′` not a leaving centre, where CB's proof stands (l. 784–787) | **truth, of my route**: my GAP was a gap in my derivation, not in the claim | **yes — mine to TRUE**. Checked sighted: `c′(x′) ⊆ c′(x)` near `x` by closedness, `= {a}` by `c′ ≠ ∅` (no both-kind arc of `ω(u₁)`, `u₁` cubic), `y′` follows `y` along `ω(x′) ∩ ω(u₂)`, transversality is generic, and at `x′` an `a | a` arc is merged away. Minds for the unconditional form: one (N3), with my sighted check; for the base's use (both-centres excluded) two, one blind |
| 2 | N3-END, first alternative | an upper bound `+1` (either horn) makes the chain `{P_0}`; nothing more is forced (§1.4 N3-END item 1) | "Either `υ_0 = 1` too — **both of `P_0`'s horns lie between `ω(P_{−1})` and `ω(P_1)`**, `P_0` is a one-vertex chain, and the **in-type `g` at `P_1` and `h` at `P_{−1}`** make both neighbours unit-arc centres — or: 1–4" (l. 858–859) | **scope**: the body's first alternative carries structure its proof does not derive. N2-FLANK-Q gives both upper arcs on `ω(P_1)` only when an in-type `g` sits at `P_1`; `υ_0 = 1` does not force that `g` (the `g`-shadows may still come from `P_{−1}`, and then items 1–4 hold as well), and nothing forces both lower arcs onto `ω(P_{−1})` or an in-type `h` at `P_{−1}` | **no** for the table's statement (its disjunction "or is the doubly bounded one-vertex chain" is met either way). **MISSTATED** as a case description. Corrected: *if an in-type `g`-tile sits at `P_1`, both horns' upper arcs lie on `ω(P_1)` and the chain is `{P_0}`; otherwise items 1–4, with `P_1` not stuck whenever an upper bound is `+1`* |
| 3 | N3-END item 3, `y ≠` the upper flank | proved: with both flanks `y`, a `y`-tile at `P_{−2}` would be Siamese to the lower flank and outer to the upper (N-E2 twice), so none exists, the tip is `y`-clear and SHAVE applies (§1.4 N3-END item 4) | "(else SHAVE)" (l. 866) | **precision**: under unit arcs the equal-flank SHAVE could a priori be blocked by FLANK's in-type exception at `P_{−2}` (round 1's row 7 found SHAVE's criterion incomplete there); the N-E2 argument is the step that excludes it | no |
| 4 | N3-END item 4, the arc at `P_{−2}` | lower bound exactly `−1` needed: otherwise the flank has points both within `< 1` and `> 1` of `P_{−2}` and no `y`-tile sits there | "at lower bound `−1`, an in-type `y`-tile at `P_{−2}`" (l. 869) | precision (the reason the bound is `−1`) | no |
| 5 | N3-BASE, the strip at leaving centres | under H a failing leaving centre is not a both-centre, so one side is clean and `γ(u)` exists (§1.4 step 2) | the strip is "used only through the rows below" (l. 802): (i) by perturbation, (ii), Cor. 3 by N3-COR3, the eleventh point by N-E1 | **route** | no |
| 6 | N3-BASE, the eleventh point | `R` inside `γ(u)` | `R ⊂ B(u, 1)` by N-E1: a point of `Ω` in `R` makes `Ω ⊂ Γ` with `C` on both sides, both-kind at `u` (l. 796–798) | **route** (N3's needs no strip) | no |
| 7 | N3-BASE, Prop. 17 | **walked** FS-110's N2-ROT and N2-HEX: both survive; N2-ROT's "no `r`-tile at `x`" is a covering pair at distance 1, so it needs N3-COR3 (corners in `B̄(u, 1)`) or a `≥ 4`-colour `x`: H (§1.4 step 10) | taken on FS110-P17's route, the ring lemmas "not walked … a named check for the verifier" (l. 846–848); the table's Prop. 17 row names only `x₂` | **scope: the named check done**; one dependency N3's row omits (COR3 inside N2-ROT) | no |
| 8 | N3-BASE, D5 item 3 | explicit: `ω(w)` can run along `P` but must leave `cl Q` through `P`'s interior (it meets `Ω` only at `x`, `x ± 120°`), into the `a`-tile | "centres moved off the finitely many unit-arc centres" (l. 809) — i.e. by genericity/perturbation | **route** | no |
| 9 | N3-BASE, inert arcs | pre-bend by N2-TOWARD | the same (l. 794–795) | **agreement, route included** (blind) | no |
| 10 | N3-COR3 | U1's side cones at `±t_u` against a clean side of `v`; forcing checked on 403 + 128 + 336 cases (tool COR3) | N-E1 at `u`: `Ω`'s half on `v`'s clean side lies in `Γ`, both-kind at `u`; then N-E1 at `u′` along `ω(u′)` through `q` gives an inner and an outer colour (l. 773–781) | **route** (N3's is shorter) | no |
| 11 | N3-ANTI | triangle inequality: a shared bounding arc voting `≤ 1` at both antipodes is at `u` | second-order expansion: every arc votes in at one antipode, three in-votes against a budget of two (l. 761–767) | **route**; mine needs no circularity of arcs | no |
| 12 | N3-FAIL | geometric first-order vote model (tool FAIL) | the unit arc's own side tiles' shadows plus a combinatorial vote table (VOTES, 12 rows), "exactly" the inner/outer colours (l. 752–760, 841–845) | **route**; N3's table includes combinatorial rows the geometry never realises (the split with `s_out` shared with the out-voter), harmlessly | no |
| 13 | N3-II | failing point `x` a both-centre, or `y` | "`c(x) ⊇ {a, b, s_in, s_out}` or `y` is a both-centre" (l. 789–794) — sharper at `x` (four colours, not "four or a repeat") | precision (N3's) | no |
| 14 | N3-LEN | the rank count gives `≤ 2\|K\| − 3` (`λ < υ` strict) | `≤ 2\|K\| − 1` (l. 709–713) | **wording**: the stated bound is true and not sharp | no |
| 15 | N3-BASE table | — | "a four-colour vertex on `ω(p)` or at `p ± 60°`" (l. 803) | **wording**: the corners are the common unit points of `ω(p)` and `ω(x)`, `x ± 60°` on `ω(p)` | no |
| 16 | N3-NOBOTH, P′, DENSE3, STEP, RAYR, PER | as §1.4 | as N3 | **agreement**, blind; PER even to the lens-inside-one-tile step | no |

### 2.3 Where both minds rest on the same thing (the selection audit's residue)

Both derivations take from row 134's grade, unre-derived here: S–V's Lemma 5, Prop. 18 and Lemma 6's `< 9` branch (circle-abstract, from (i), (ii) and finiteness —
CB and CE took them from print), CUSP-BASE, and N112-U1 and N2-TOWARD (two minds each). An error common to both walks would sit there, not in the unit-arc steps.
Seven-colour control and killing test 8: as §1.4; N3 reads the strip the same way (its registered N3-P1 and N3-P4 are the strip's test of N3-COR3, unscored here).

### 2.4 Verdicts after stage 2

| claim | verdict | grade, minds |
|---|---|---|
| N3-BASE | **TRUE** | hand; two minds, one blind (N3; NB3) — over row 134's base and N2-TOWARD (two); the named check (FS-110's N2-ROT, N2-HEX) walked by NB3 |
| N3-DENSE3 | **TRUE** | hand; two minds, one blind |
| N3-NOBOTH, N3-FAIL, N3-ANTI, N3-COR3 | **TRUE** | hand; two minds, one blind, different routes for FAIL, ANTI, COR3; tools exact on both sides |
| N3-I | **TRUE** (my stage-1 GAP retracted: N3's perturbation closes it) | hand; the base's use two minds, one blind; the unconditional form one mind (N3), checked sighted by NB3 |
| N3-II, N3-P′ | **TRUE** | hand; two minds, one blind |
| N3-STEP, N3-LEN, N3-RAYR, N3-PER | **TRUE** (LEN's bound not sharp: `2\|K\| − 3`) | hand; two minds, one blind; tools exact on both sides |
| N3-END | **TRUE** as the table states it; the body's first alternative **MISSTATED** (divergence 2), item 3 needs the N-E2 step (divergence 3) | hand; two minds, one blind |

**Registered prediction scored:** N3-P2 ("a blind second mind finds N3-BASE TRUE, possibly with a repair in a row of its table", 0.6) — **met**; no row needed a
repair; one row (Prop. 17) gains a dependency (N3-COR3 inside N2-ROT) and the named check is done.
**Retractions counted:** one (mine, divergence 1).

### 2.5 Proposed edits (for the close; I edit none of these files)

- `plans/FS112-N-proof.md` N3-END (l. 858): the first alternative as corrected in divergence 2; item 3 (l. 866): cite the N-E2 step.
- N3-LEN: "at most `2|K| − 3` vertices (so `2|K| − 1`)".
- `data/fs112/briefs/NB3-112-instance.md`'s pointer for N2-ROT/N2-HEX: `plans/FS110-N-proof.md` l. 374, l. 393 (FS-110's round 2), not FS112-N2.
- `LEDGER.md` § B (when N3's rows are filed): N3-BASE, DENSE3 and the lemmas under it at two minds, one blind; N3-I's unconditional form one mind with a sighted check.

## Stage 2 — SAVED
