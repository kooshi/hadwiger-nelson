# FS114-CVB — a blind second mind on FS114-CV's lemmas, and a blind third mind on C114-THOM-TOP's two clauses (FS-114, the unit-arc question)

*Job FS114-CVB, de Bruijn (Opus 5.5), 2026-09-28. Brief `data/fs114/briefs/CVB114-verify.md` with `data/fs114/briefs/STANDING-RULES.md` (rule 0
first; `CLAUDE.md` § The aim and § Counter-priors read from disk). Working files `data/fs114/fs114-cvb/`; tools `tools/fs114_cvb_*.py`. Resuming check: no
record existed at start (06:07 UTC). Stage 1 is written before any fenced file (FS114-CV's record, directory and tools; FS114-N's and FS114-NB's) is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| FS114-CVB-EXISTS | Every valid map has a vertex of at least four colours, in the map itself; the proof passes through `M*`, where with no such vertex every stuck chain would be bi-infinite; it uses neither CV-HD nor FS112-C-ENDS, no ray step and no residue | [hand; one mind: CVB, blind to CV] | stage 1 §1.4 |
| FS114-CVB-L0 | In `M*` a stuck vertex centres no unit arc, so `Γ ∩ ω(E)` is finite | [hand; one mind: CVB] | §1.5 |
| FS114-CVB-HD | In `M*`, for a stuck `E`: `υ± = 1` with no in-type lower-flank tile at `E − n` is impossible; hence `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1` | [hand; one mind: CVB, blind to CV, sighted on Y3-END-NEEDS's levels; the `G_N` branch's MERGE made explicit] | §1.6 |
| FS114-CVB-CLASS | A stuck vertex of `M*` is a bowtie (the four conditions; both neighbours both-kind (Q) centres; a one-vertex chain) or has `g` twice at `E − n` and `h` twice at `E + n` | [hand; one mind: CVB]; BOWTIE control consistent | §1.7 |
| FS114-CVB-ENDS | FS112-C-ENDS with no residue: one step beyond every finite end of a stuck chain of `M*` lies a vertex of at least four colours | [hand; one mind: CVB] | §1.8 |
| FS114-CVB-PINCH | In the map graph of a locally finite plane map, `M − x` is connected at a pinched tile and disconnected at a holed one; holes are locally consistent with validity | [hand; one mind: CVB] | §1.9 |
| FS114-CVB-THOM | `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed: fill holes, read facial cycles as boundary walks, and replace the count in `int(R)` by local finiteness (finite against infinite); the reduced map graph `H` then has a vertex of degree `≥ 6` | [hand; one mind: CVB; the 2-separator criterion at pinches a sketch] | §1.9 |

## Would-have-searched-here log (standing rule 3)

- CV-HD's two branches: an enumeration of sector orders at `N = E + n` (which colours can sit where) — replaced by the derived colour count (§1.6).
- B1's hole case: a search for a valid map with a holed tile — replaced by the observation that the step fails in every locally finite map containing
  one, with a hand fragment showing validity does not exclude holes locally (§1.9).
- No other search considered. The only programs run: the quotation check (`tools/fs114_cvb_quotes.py`) and the held BOWTIE fragment, unedited.

## Fence log (standing rule 13; brief § Fences)

1. **Shared scratchpad, names only.** My first command listed the top level of the shared harness scratchpad (to find a place for `fs114-cvb/`): the
   output showed other jobs' entry names (among them `fs114-cv`, `fs114-n`, `fs114-nb`). No file there was opened. I work only in `scratchpad/fs114-cvb/`.
2. **Fenced tool names, names only.** `ls tools/fs114_*` (to choose my tool's name) printed the names `tools/fs114_cv_quotes.py` (FS114-CV's, fenced) and
   `tools/fs114_n_*`, `fs114_nb_*`, `fs114_n2_*`, `fs114_n3_*`, `fs114_p_*`. None was opened. Told to the owner in the report.
3. **git log.** At start `git log --oneline -8` printed three subjects older than the start-up snapshot's five (`04ab71e9 FS114-N2: report`,
   `27b969b6 FS114-N2: stage 3`, `9e135bee FS-114 inventory: construction verifier's result`); subjects only, nothing newer than the snapshot, no `-p`.
4. Nothing else fenced was touched: no transcript, no `chats-bak/`, no `data/fs112/fs112-c*/`, no other FS-114 record, brief or report, no FS-111 file.

## Stage 1 — SAVED: quotation check; blind verdicts on A1–A5 and B1–B2

### 1.1 Read, in this order

The brief; the standing rules; `CLAUDE.md` § The aim, § Counter-priors (disk); `data/fs114/claims.md` (all); `data/fs112/claims.md` §0;
`plans/FS112-derivation.md` §§1–4 (all entries); `data/fs114/briefs/CV114-composition.md`; `plans/FS110-derivation.md` §1 to FS110-CE4;
`plans/FS110-N-proof.md` stage N4-2 (§§2.1–2.8, the N4 frame); `plans/FS112-N-proof.md` §1.3, §1.4 (the walk), stages N2-4, N3-2, N3-4;
`plans/FS112-Y3-construction.md` §3 (Y3-END-NEEDS as stated); `plans/FS112-YB3-verification.md` §3.1 (its blind derivation and BOWTIE);
`tools/fs112_yb3_frags.py` (the BOWTIE definition, read to run it); `LEDGER.md` rows 134–136 (statements);
`~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt` (all, OCR); `plans/FS106-V-verification.md` V3 stage 2.
**Page images of `[Thomassen1999]` are not held** (only the OCR text; `BIBLIOGRAPHY.md` row `[Thomassen1999]` records the same need). The garbled lines
bear on nothing below: my repair (§1.9) removes every constant ("12k + 3" against "12k + 30"), and the index inequality "1 < i < j - 1 < k - 1" is read
`1 ≤ i < j − 1 ≤ k − 1`. Prior-art debt: fetch the page images.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_cvb_quotes.py --file data/fs114/fs114-cvb/quotes-stage1.tsv` → `quotes-stage1.out`: **28 of 28 FOUND**, exit 0. Plant (`--plant`,
`quotes-stage1-plant.out`): exit 1, exactly the planted row MISSING. **The plant's first version could not fire**: it mutated "distinct" to "different",
and `[Thomassen1999]` prints "x and its neighbors must have different colors" in its last paragraph, so the mutated quotation was still found; the plant
now writes a token absent from every source and refuses to run if the token occurs in one. Rows: the brief's quotation of the rainbow step; Lemma 1; the
five steps of Thomassen's proof I quote in §1.9; C114-THOM-TOP's clause; the Kooshi quotations of standing rules 0, 3, 4, 10; and the fourteen input
statements I quote below from `plans/FS112-derivation.md` and `plans/FS110-derivation.md`.
- **Punctuation:** standing rule 4 ends Kooshi's quotation "… All novel knowledge is a success." with a period; `CLAUDE.md` has none. Content identical.
- **Paraphrase (brief, part B):** the brief's gloss of C114-THOM-TOP drops the claim list's "with FS106-V3's repairs" and writes the map graph's adjacency as
  "faces adjacent when their closures meet", where Thomassen's words are "the corresponding facial cycles in G intersect"; for a tile with a hole or a pinch
  there is no facial cycle, so "closures meet" is the reading used below (it agrees with Thomassen's on disc faces).
- **Not checkable in stage 1:** the brief's statements of A1–A5 are quoted from `plans/FS114-CV-verification.md`, fenced until this stage is committed;
  they are checked in stage 2 against that file.

### 1.3 Frame (FS-110's N4 frame and FS-112's unit-arc notation, as the inputs state them)

`M*` a terminal valid modification (FS112-N2-TERM): no MERGE (W-MERGE), MERGE-RAY or SHAVE applies at any vertex, every unit arc is (Q) or (R2). A
**stuck** vertex `E` has a repeated colour and no operation; N4-STUCK's structure (i)–(ii): `P_cl(E) = {c, g, h}`, `g` one sector filling the open
half-plane of directions `d·n > 0`, `h` one sector filling `d·n < 0`, `c` two cusp horns `H₊`, `H₋` along `±a`, each between arcs tangent to `a` at `E` of
upward curvatures `λ± < υ± ` in `[−1, 1]` (N3-DEG with unit arcs, the walk's row 5). `N = E + n`, `S′ = E − n`. `υ± = 1` means both upper arcs lie on
`ω(N)`; `λ± = −1` both lower arcs on `ω(S′)`. `G_N`: an in-type `g`-tile at `N` (inside `B̄(E, 1)` near `N`); `H_S`: an in-type `h`-tile at `S′`. N-E0: a
tile never meets the shadow `Sh(T) = {z : ω(z) ∩ T ≠ ∅}` of a tile of its own colour; N-E1: a tile crossing `ω(v)` has a colour outside `P_cl(v)`.
Grades of the inputs as filed: FS112-N3-DENSE3, N2-TERM, U1, FLANK, N2-FLANK-Q, END, the walk (N3-CONF, W-MERGE, N4-RAY, N4-FIN hold as written; N3-DEG
row 5) — two minds, one blind; FS110 N4-STUCK, N4-PROP, N4-SHADOW, N4-FIN — two minds, one blind; FS112-Y3-END-NEEDS as corrected — levels two minds,
its shadow-source list, exception and `y ≠ g` one mind (YB3).

### 1.4 A5 — CV-EXISTS, first (the priority): **TRUE**, and it needs neither CV-HD nor C-ENDS [hand; one mind, blind to CV]

*Statement (brief):* "every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step".

**Derivation.** Let `M` be a valid map and `M*` its terminal modification (N2-TERM), itself a valid map. Suppose `M*` has no vertex of four or more
colours. Then:
1. **Every unit arc of `M*` is (R2)**: a (Q) arc needs a centre with at least four colours (N2-TERM item 1, the definition of (Q)).
2. **Stuck vertices exist.** DENSE3 applied to `M*`: every closed disc of radius 3 holds a vertex of at least four colours or with a repeated colour; the
   first kind is absent, so a repeated-colour vertex exists, and by N2-TERM item 2 (cubic, NB4P exception with `≥ 4` colours, or stuck) it is stuck.
3. **A stuck vertex `E` centres no unit arc** (FS114-CVB-L0, §1.5, here in its easy form: an (R2) arc centred at `E` would have its outer colour at `E` and
   that colour's sectors in a closed cone of width `π − ℓ < π` (U1); `g` and `h` fill open half-planes and `c` points both ways along `±a`). So
   `Γ ∩ ω(E)` is finite, the degenerate shadow `C = 0` (walk row 6) and the arc of `ω(E)` through `N` (walk row 8) do not occur at `E`.
4. **FLANK holds at `E` exactly as under Condition 5.** FS112-FLANK: FLANK fails only through an in-type flank tile at the centre of a horn-bounding unit
   arc — `G_N` (then the arc of `ω(N)` is both-kind at `N`: `g` in-type and `c` out-type there, N3-DEG) or `H_S` (the mirror). A both-kind arc is not (R2);
   by item 1 it does not exist. The rest of FLANK's list is Condition-5-free once `Γ ∩ ω(E)` is finite (N3-CONF, N3-CLEAR, N3-UP hold with unit arcs,
   walk row 3): in-type `g` at `S′` and in-type `h` at `N` straddle the flank (the flank has points arbitrarily near `E`, within `< 1` of the in-type tile's
   interior points and `> 1` from `N`, resp. `S′`); out-type `g` at `N` shadows the flank. So the `h`-shadow on `H₊` comes only from out-type `h`-tiles at `N`
   tangent to `+a`, and (terminal: no SHAVE, whose criterion is complete here) it exists; likewise `Q₋` at `N` for `H₋`, and `g`-tiles at `S′` for both.
5. **N4-STUCK (iii)–(iv) hold at `E`.** `c ∈ P_cl(N)` out-type (N3-DEG); `c`'s sectors at `N` lie in `d·n ≥ 0` (the horns are an out-type `c`-contact of
   `ω(N)` at `E`) and not in the `±a` stacks below `Q±` (such a sector would shadow part of `H±`, against N-E0); the arcs of `ω(E)` leaving `N` lie in tiles
   at `N` (item 3), which cross `ω(E)`, so a ring colour `r ∉ {c, g, h}` sits below; with `|P_cl(N)| ≤ 3` (the hypothesis), `P_cl(N) = {c, h, r}`. Going
   from `Q₊` to `Q₋` over the top meets `c`, under the bottom `r`: **`h` has two sectors at `N`.**
6. **The chain runs on.** `N` has a repeated colour and at most three colours, so it is stuck (N2-TERM item 2). No MERGE at `N` makes `D_h(N)` degenerate,
   and `E` is an out-type `h`-contact of `ω(N)`, so the degenerate `D_h(N)` is the line `±a` (N4-PROP's step): `N` is stuck on the same axis. The mirror
   holds at `S′`. By induction every `P_k = E + kn`, `k ∈ ℤ`, is stuck: **the chain is bi-infinite.**
7. **N4-FIN forbids it.** Along a chain of stuck vertices every horn bound lies in `(−1, 1)` (a bound `±1` would be a unit arc centred at a stuck neighbour,
   against item 3; this is FS112-END), and N4-SHADOW with N4-STUCK (ii) give `λ_k ≤ f(λ_{k+1})`, `f̃(υ_{k−1}) ≤ υ_k` (FS110 §2.6). N4-FIN: no bi-infinite
   such sequence. Contradiction.

So `M*` has a vertex of at least four colours. **Back to `M`:** the moves add no colour at an existing point (DENSE3's proof note: "Moves never add a colour
or a sector to an existing point, so no terminal modification is needed.") and create only corners and cubic vertices (FS110 N4-TERM; a bend's lens lies in
one tile, `plans/FS112-N-proof.md` N3-PER item 2 (ii)); so that vertex was a vertex of `M` with at least four colours. ∎

**Answers to the brief's question.** CV-EXISTS needs **neither CV-HD nor C-ENDS**, and no ray step: chains end only at four-colour vertices, and in a map
with none there is nothing for a chain to end at — N4-FIN, which forbids only bi-infinite chains, then suffices. The residue of C-ENDS and the stuck ray
concern *where* four-colour vertices sit (density), not *whether* one exists. **Inputs actually used:** DENSE3, N2-TERM, U1, FS112-FLANK (its exceptions are
exactly `G_N`, `H_S`), N3-DEG and N3-CONF with unit arcs, W-MERGE, N4-STUCK (i)–(ii) and N4-PROP's step (re-run above where unit arcs could bite), N4-SHADOW,
N4-FIN, END, the move properties. N4-RAY enters only through N4-STUCK (i) (one horn per ray). If FS114-CV's list omits U1 and FLANK, it understates the inputs
(to check at stage 2).
**Where six is spent:** only in DENSE3 (row 134's base, through N3-BASE). The rest uses "at most three colours at every vertex", which is the hypothesis being
refuted, not six. **Seven-colour control:** the hexagonal seven-colouring is terminal, cubic, with no four-colour vertex; the argument fails there at item 2
exactly (DENSE3 is false for it), as it must. **Strip:** CAL-STRIP has four-colour midline vertices; the statement holds there and is not a NO, so killing
test 8 does not bind it. **Bearing:** with C114-LOCAL-F (no valid fragment on the closed disc of radius `R` about a vertex of at least four colours),
this is Q-full's NO — GS-1 of the claim list holds with no residue, at [hand], one mind here, over links at two minds.

### 1.5 A1 — CV-L0: **TRUE** [hand; one mind]

*Statement (brief):* "in a terminal valid map `M*` a stuck vertex centres no unit arc, so `Γ ∩ ω(E)` is finite".

A unit arc `α ⊂ ω(E)` of `M*` is (Q) or (R2) (N2-TERM item 1). (Q) needs four colours at its centre; `|P_cl(E)| = 3`. (R2) needs the outer side colour
`s_out ∈ P_cl(E)`, and U1 puts `s_out`'s sectors at `E` in the closed cone of width `π − ℓ` facing away from `α` (`0 < ℓ < 60°`, FS112-L60). `g` fills an open
half-plane (angle `π`), impossible; so does `h`; `c`'s two horns point along `+a` and `−a`, and a closed cone of width `< π` holds no antipodal pair. So no
unit arc is centred at `E`. Every other boundary arc or segment meets `ω(E)` in at most two points, and local finiteness leaves finitely many arcs meeting
the compact `ω(E)`: `Γ ∩ ω(E)` is finite. ∎ **Consequences:** the walk's row 8 exception (an arc of `ω(v)` through `N`, NB §2.3 #10's one-mind count) and
row 6's `C = 0` never occur at a stuck vertex of `M*`; C-ENDS's clause resting on the one-mind count is vacuous.

### 1.6 A2 — CV-HD: **TRUE** [hand; one mind, blind to CV; the `¬G_N` branch sighted on Y3-END-NEEDS as corrected]

*Statement (brief):* "in `M*`, for a stuck `E`: both upper bounds `1` and no in-type lower-flank tile at `E − n` is impossible; hence
`G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1`".

**The two easy arrows (Siamese).** `G_N ⇒ υ± = 1`: an in-type `g`-tile `T` at `N` has interior points inside `B(E, 1)`, within `< 1` of every flank point
near enough to `E`, and points arbitrarily near `N`; a flank point `p` with `|p − N| > 1` would see `T` on both sides of `ω(p)`. So the flank lies in `B̄(N, 1)`
near `E`, and for `p = E + xa + (υx²/2)n` on an upper arc `|N − p|² = 1 + (1 − υ)x² + O(x³) ≤ 1` forces `υ = 1`, on both sides since the flank reaches both
horns (N2-FLANK-Q's clause). The mirror gives `H_S ⇒ λ± = −1`.

**The main clause: `υ± = 1 ∧ ¬H_S` is impossible.** With `¬H_S`, FLANK's `h`-list on `H±` is out-type `h`-tiles `Q±` at `N` tangent to `±a` (item 4 of §1.4:
in-type `h` at `N` and out-type `h` at `S′` never shadow the horn; in-type `h` at `S′` is `H_S`; `Γ ∩ ω(E)` finite, §1.5), and no SHAVE at `E` needs them
(an absent `h`-shadow lets the whole tip be recoloured `h`, a SHAVE with `Σ` the upper arc, which creates no unit arc). `c ∈ P_cl(N)`, and by U1 at `N`
(the arcs of `ω(N)` bounding the horns have `s_out = c`) `c`'s sectors at `N` lie in the pinch around `+n`. Two branches.
- **Branch `G_N` (new here; YB3-N5's content, with its MERGE made explicit).** At `N`: `g` in-type, in U1's inner cone facing `−n`; ring tiles `r₊`, `r₋`
  containing the arcs of `ω(E)` leaving `N` to the right and left (they exist, §1.5), colours outside `{c, g, h}` (N-E1). The `g`-sector separates them
  through the bottom. **`r₊ ≠ r₋`**: else `r` has two sectors at `N` whose directions include `0⁻` and `π⁺`; `D_r(N)` is an intersection of closed
  half-planes of directions (N3-CONF), so it contains the lower arc between them (length `< π`), `int D_r(N) ≠ ∅`, and W-MERGE joins them — not terminal.
  `Q₊`'s upper neighbour `x₁` at `N` (directions from `0⁺`): `x₁ ≠ h`; `≠ c` (outside the pinch); `≠ g` (it lies above `ω(E)`, an out-type contact of `ω(E)`
  at `N`, forcing `D_g(E) ⊆ {d·n ≤ 0}` while `g` fills `d·n > 0`); `≠ r₊` (two `r₊`-sectors on both sides of `+a`: `D_{r₊}(N)` has interior unless it is the
  line `±a`, which needs a contact at `E`, but `r₊ ∉ P_cl(E)`; W-MERGE); `≠ r₋` (two sectors around the top: same). So `{c, g, h, r₊, r₋, x₁}` are six distinct
  colours, and `Q₋`'s upper neighbour `x₂` is outside all six by the same reasons (`x₂ ≠ x₁`: two sectors separated by the pinch, degenerate only with an
  `x`-contact at `E`). **A seventh colour.** (BOWTIE is the case `G_N ∧ H_S`: there `h` is absent at `N` and `P_cl(N) = {1, 2, 4, 5}` with `r₊ = 4 ≠ r₋ = 5`.)
- **Branch `¬G_N`** — FS112-Y3-END-NEEDS as corrected, whose Steps 3–4 use only "`h` at `N` tangent to `±a`" (YB3's Step 2, true here since `¬H_S` — YB3
  states it as "iff `λ_E > −1`"; with `λ_E = −1` and no in-type `h` at `S′` the `h`-shadow still has only `Q±` for sources): no MERGE of `h` at `N` makes `h`'s
  sectors horns (out-type `h` at `N + n`), with upper flanks `x₁ ≠ x₂` and a lower flank `y`, five colours `{c, h, x₁, x₂, y}` at `N`; no SHAVE at `N` needs an
  `x₁`-shadow on `N`'s `+a` horn, available only from an in-type `x₁` at `N + n` (so `N`'s horns' upper arcs lie on `ω(N + n)`), and a `y`-shadow from
  out-type `y` at `N + n` tangent to `±a`; then `y`'s two sectors at `N + n` are horns whose upper flanks `z₁ ≠ z₂` avoid `{c, h, x₁, x₂, y}` — a seventh
  colour. **Two steps I re-derived (one mind each, sighted):** (a) `y ≠ g` (YB3's Step 3 (a)): the tile just below `Q₊` at `N` lies above `ω(E)` (out-type:
  no `g`), crosses `ω(E)` (N-E1: no `g`), or lies below it only if `Q₊`'s lower arc is `ω(E)`, excluded by §1.5; the seventh colour follows without it anyway
  (`z₁, z₂` are two distinct colours outside a five-set). (b) **FLANK at `N` with contact arcs of `ω(N)`** (Y3's named exception (ii); `N` centres unit arcs):
  an out-type `x₁`- or `y`-arc of `ω(N)` accumulating at `N + n` shadows that colour's own flank sector at `N` (for `u ∈ I` near `n`, directions within
  `|u·a|` of `±a` on the flank's side have `d·u > 0`), and an in-type `x₁`-arc accumulating at `N + n` is an in-type contact at `N + n`, the Siamese case
  already counted. So Step 4's list of shadow sources is complete.

**Hence.** `υ± = 1 ⇒ H_S` (both branches); `H_S ⇒ λ± = −1` (Siamese); `λ± = −1 ⇒ G_N` (the main clause with `n` reversed, `g ↔ h`); `G_N ⇒ υ± = 1`. The four
conditions are equivalent, and when they hold all four horn arcs are unit arcs with in-type flank tiles at both antipodes. ∎ FS112-C-HORNEND and
FS112-C-DOUBLE follow (each at one mind in the file): both upper arcs unit forces `H_S`, hence all four unit and `G_N`, and `N`, `S′` carry both side
colours of their arcs, both-kind, (Q). **Not reached by CV-HD** (consistent with it): a unit arc bounding one horn only (`υ₊ = 1`, `υ₋ < 1`) — then all four
conditions fail, the arc is (R2), and `N` is not stuck (it centres a unit arc, §1.5).

### 1.7 A3 — CV-CLASS: **TRUE** [hand; one mind]; the BOWTIE control consistent

*Statement (brief):* "a stuck vertex of `M*` is a bowtie (CV-HD's four equivalent conditions; both neighbours both-centres with `≥ 4` colours; a one-vertex
chain) or has `g` twice at `E − n` and `h` twice at `E + n` (each neighbour stuck or with `≥ 4` colours and a repeated colour)".

By CV-HD either all four conditions hold or none. **All four:** the arcs of `ω(N)` bounding the horns have `s_in = g` and `s_out = c`, both in `P_cl(N)`:
both-kind, hence (Q) in `M*` (N2-TERM item 1), at least four colours; likewise `S′`; neither is stuck (§1.5: they centre unit arcs), so the chain is `{E}`.
**None:** FLANK holds at `E` on both sides as in §1.4 item 4, so `Q±` exist at `N` and the mirror tiles at `S′`, and §1.4 item 5's separation (`c` over the
top, ring tiles below) gives `h` two sectors at `N` and `g` two at `S′` — with no use of `|P_cl(N)| ≤ 3`. A vertex with a repeated colour is stuck or has at
least four colours (N2-TERM item 2). ∎ **Control** (`tools/fs112_yb3_frags.py bowtie`, unedited, exit 0; `data/fs114/fs114-cvb/bowtie-control.out`): ACCEPT,
21 of 21 same-colour pairs; `P_cl(E) = {1, 2, 3}`; `G` (colour 1 = `g`) in-type at `N`, `H` (3 = `h`) in-type at `S`; `P_cl(N) = {1, 2, 4, 5}`,
`P_cl(S) = {2, 3, 4, 5}` (four colours, both side colours of the unit arcs at each: both-kind); no 3-tile at `N`; `E` doubly shadowed at all five named
points. Every clause of the bowtie case holds on it, and its `N` shows the two ring colours `4 ≠ 5` of §1.6's branch `G_N`. (A sighted observation: I read
the fragment's docstring before deriving that branch.)

### 1.8 A4 — CV-ENDS: **TRUE**, the residue closed [hand; one mind]

*Statement (brief):* "FS112-C-ENDS holds with no residue: the point one step beyond every finite end of a stuck chain has at least four colours".

Let `P_L` be a finite end, `P_{L+1}` not stuck. By CV-CLASS at `P_L`: a bowtie puts a (Q) centre with four or more colours at `P_{L+1}`; otherwise
`P_{L+1}` carries a repeated colour and, not being stuck, has at least four colours (N2-TERM item 2). The mirror at a lower end. ∎ **The residue** —
"a one-vertex chain bounded by unit arcs on both sides but not on all four horn arcs, at a bound on an (R2) arc" — is excluded by CV-HD: unit arcs on
both upper horns (or both lower) with no in-type tile at the far antipode is the main clause's impossible case; with an in-type tile at one antipode all four
are unit arcs (the bowtie); and a unit arc bounding one horn only on a side (`υ₊ = 1`, `υ₋ < 1`, whatever the lower bounds) leaves all four conditions false,
so CV-CLASS's second case: `h` twice at `N`, and `N`, centring that arc, is not stuck (§1.5) — four colours. The same on the lower side. What CV-ENDS does **not** give: a bound on chain length (FS-115's
(b″)) or the absence of rays ((b′)); so density of four-colour vertices stays open for aperiodic maps, as FS112-C-COMPOSE (3) says.

### 1.9 B1–B2 — C114-THOM-TOP's two clauses (the third mind) [hand; one mind]

*Frame.* A valid map is locally finite, its tiles open, connected, of diameter at most 1 (a connected open set of diameter above 1 holds a pair at distance
exactly 1); WLOG every edge separates two tiles of different colours (an arc with one colour on both sides is deleted), so no dangling edges or slits.
`M`: tiles, adjacent when their closures meet. `M` is locally finite and connected, and infinite.

**B1, the pinch clause.**
- **Pinch (the boundary walk visits a vertex `p` twice), no hole: `M − x` is connected — TRUE.** At `p`, `x` has two sectors, separated on both sides by
  non-empty gaps (else the sectors are one). A bounded component `B` of `ℝ² ∖ cl x` (a bay) has `p` in its boundary; its tiles form a connected subgraph
  (their closures cover the connected `cl B`, finitely many near any point), one of them has `p` in its closure, and so does a tile of the other gap: they
  are adjacent in `M − x`. Thomassen's local connectivity also holds: read `C_x` as the closed boundary walk; consecutive neighbours along it share a vertex
  of the walk, and dropping vertex-only repeats keeps them adjacent (FS106-V3's check). So "It follows that M - x … is connected." survives.
- **Hole (a boundary component of `x` disjoint from its outer one): `M − x` is disconnected — FALSE.** The tiles inside the hole have closures in the
  hole's closure, those outside in the closure of the unbounded component of `ℝ² ∖ cl x`; the two closed sets are disjoint, so no edge of `M − x` joins them,
  and both are non-empty (an inner boundary component encloses a tile, since it separates two colours). `D₁(x)` is itself disconnected (inner and outer
  neighbours), so `M` is not locally connected at `x` either. **Counterexample configuration (local, valid):** `x = {1/4 < |z| < 1/2}` colour 1, `{|z| < 1/4}`
  colour 2, and four quarter-annuli `{1/2 < |z| < 0.55}` coloured 3, 4, 5, 6 (each of diameter `≈ 0.78`; no same-colour pair across tiles; every tile's
  interior of diameter at most 1): a valid fragment on an open set containing `B̄(0, 1/2)`, in whose map graph the disc tile is joined to `x` only. Validity
  does not exclude holed tiles; whether a valid map of the plane exists is Q-full's question, so "every valid map" cannot be refuted by an object, but the
  step fails in every locally finite map with a holed tile, so the proof does not reach valid maps without a repair.

**B2, the repair: TRUE for every valid map, Siamese pairs allowed** — every step other than the rainbow step is colour-free once the count is replaced.
1. **Fill holes.** Replace each tile `x` by `x̂ = x ∪` its holes (outermost holes first). The filled map is locally finite, its tiles bounded (the holes lie
   inside `x`'s outer boundary, so `diam x̂ = diam x ≤ 1`), simply connected, each bounded by a closed boundary walk; its map graph is `M` minus the hole
   contents. Colours are not used below, so the filling need not be valid.
2. **Boundary walks for facial cycles** (pinches). At each pass of the walk through a vertex list every tile at that vertex, then drop vertex-only
   repeats (Thomassen's rule): the tiles at one vertex are pairwise adjacent, so consecutive entries stay adjacent and local connectivity holds as in B1.
   **"M − x − y is connected unless y appears twice"** holds for the filled map [one mind, a sketch]: a bounded component `A` of `M − x − y` is enclosed by
   edges of `x̂` and `ŷ`; at a point where the enclosure passes from `x` to `y`, the tiles of `A` there and the tiles on the other side would be adjacent unless
   `x` and `y` share the edge between their sectors on that other side; the enclosure passes at least twice, at distinct shared edges (one edge used at both
   ends makes `x̂` or `ŷ` the unbounded one of the three regions cut out by three paths between the edge's ends), and the tiles of `A` met along the
   enclosure's `x`-side — by an edge, or at a vertex, as at a pinch of `y` whose bay is `A` — separate `y`'s two appearances in `x`'s sequence. "Precisely one"
   component outside `int(M, x, y)`: the complement of the compact connected `cl x̂ ∪ cl ŷ` has one unbounded component and every other component of
   `M − x − y` is finite; in the plane take `int(M, x, y)` to be their union, and no curve `R` is needed (Thomassen's `R` avoids `G` but at `e`, `f`; at a
   pinch the enclosure turns at a vertex, so his definition would have to admit `R` through a vertex).
3. **What replaces "By (ii), there are at most k points Pz" in the plane: local finiteness.** A curve `R` in `x̂ ∪ ŷ` has diameter at most 2 and `int(R)`
   meets finitely many tiles; nothing about colours is needed. Thomassen's uses of the count become: `int(M, x, y)` is finite; a strictly nested chain of
   2-separator interiors lies in a fixed ball (each contains `x` or `y`, within 4 of it) and stops; and each contradiction "M has diameter at most 12k + 1",
   "at most 12k + 29" becomes "M is finite" (the component of `M − u − v` containing `x` is `x` plus two finite interiors, yet it is `ext(M, u, v)`, which is
   infinite; `H` with maximum degree at most 5 has at most 12 vertices by Lemma 1, and pasting finite interiors on at most 30 crucial edges leaves `M`
   finite). "One of the edges xu or xv is crucial" holds after filling (the only deleted neighbours are 2-separator interiors).
4. **Conclusion:** `H` (the filled map graph with every maximal 2-separator's interior deleted) is connected, locally finite, locally Hamiltonian and
   infinite, so by Lemma 1 (pure graph theory; FS106-V3's one supplied inference checked) **it has a vertex of degree at least 6.** **Siamese pairs never
   enter:** niceness was used only at the rainbow step and at the count (FS106-V3), and the count's replacement reads no colour. So the answer to
   "every valid map, or only non-Siamese maps" is **every valid map**, indeed every locally finite plane map with bounded connected tiles; what fails for
   valid maps is the rainbow step alone (a tile of `H`-degree 6 with Siamese or tight same-coloured neighbours), which is C114-RAINBOW's question.
   **An explicit version** (for C114-CURV): at complexity `K` ("at most `K` tiles per unit disc"), `int(R)` lies in a disc of radius `2/√3` (Jung) and meets at
   most a constant times `K` tiles, which restores an explicit `k` in Thomassen's constants.

### 1.10 Registered before stage 2 (G21; both outcomes reachable)

| id | prediction | p |
|---|---|---|
| CVB-P1 | FS114-CV's proof of CV-EXISTS routes through CV-HD or CV-ENDS (so §1.4's route is a simplification, not a duplicate) | 0.6 |
| CVB-P2 | FS114-CV's CV-HD treats the branch `G_N ∧ ¬H_S` explicitly (not only by citing YB3-N5 or C-DOUBLE) | 0.5 |
| CVB-P3 | FS114-CV lists the inputs of CV-EXISTS without U1 or without FS112-FLANK | 0.5 |
| CVB-P4 | at least one of FS114-N (§1.4 (3)) and FS114-NB (§2.2 D3–D4) reads the pinch as breaking `M − x`'s connectivity, against §1.9's TRUE | 0.4 |
| CVB-P5 | at least one of them makes the repair depend on non-Siamese maps, against §1.9's "every valid map" | 0.5 |

## Stage 1 — SAVED
