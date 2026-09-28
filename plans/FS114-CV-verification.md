# FS114-CV — blind second mind on FS-112's composition (FS-114, the unit-arc question)

*Job FS114-CV, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `37c459ed`. Brief: `data/fs114/briefs/CV114-composition.md` with
`data/fs114/briefs/STANDING-RULES.md`. Claim list: `data/fs114/claims.md` (quoted, never paraphrased). Working files: `data/fs114/fs114-cv/`; tool
`tools/fs114_cv_quotes.py`; scratch `scratchpad/fs114-cv/`. Derive first, read second: stage 1 is committed before the assembly (`data/fs112/fs112-c/`,
`data/fs112/fs112-c2/`, `plans/FS112-derivation.md` §3, `plans/FS112-unit-arc-half.md` §R-close, `plans/POROS-2026-09-27-night-aim.md`,
`plans/STUB-global-step.md`, `plans/STUB-stuck-ray.md`) is opened. Grades as `CLAUDE.md` § Notation; "minds" counts derivations, mine included.
Notation: `plans/FS112-N-proof.md` §1.3 (`Γ`, `P_cl`, `ω(x)`, N-E0/E1/E2, TS-C) and FS-110's N4 frame (`plans/FS110-N-proof.md` §N4-2).*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| CV-L0 | in a terminal valid map `M*` a stuck vertex centres no unit arc, so `Γ ∩ ω(E)` is finite | hand, one mind (over N112-U1, two) | §1.4 |
| CV-FLANK | at a stuck `E` the flank shadows on a horn come only from an in-type flank tile at the near antipode (which forces both horns' bounds on that side to `±1`) or from out-type flank tiles at the far antipode tangent to `±a`; contact arcs add nothing | hand, one mind | §1.4 |
| CV-U | if one horn of a stuck `E` has upper bound `1`, `E + n` is not stuck (mirror at `−1`) | hand, one mind (N112-END's content) | §1.4 |
| CV-P | with no in-type upper-flank tile at `E + n` (`¬G_N`), the upper flank `g` has two sectors at `E − n`; so `E − n` is stuck or has at least four colours (mirror) | hand, one mind | §1.4 |
| CV-L4 | an in-type upper-flank tile at `E + n` (`G_N`) makes `E + n` a both-centre with at least four colours | hand, one mind (over N112-U1, W-MERGE) | §1.4 |
| **CV-HD** | **in `M*`, for a stuck `E`: both upper bounds `1` and no in-type lower-flank tile at `E − n` is impossible; hence `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1`** (all four horn arcs unit arcs, in-type flank tiles at both antipodes) | hand, one mind; six spent at two named steps | §1.4 |
| **CV-CLASS** | a stuck vertex of `M*` is a bowtie (CV-HD's four equivalent conditions; both neighbours both-centres with `≥ 4` colours; a one-vertex chain) or has `g` twice at `E − n` and `h` twice at `E + n` (each neighbour stuck or with `≥ 4` colours and a repeated colour) | hand, one mind | §1.4 |
| **CV-ENDS** | FS112-C-ENDS holds **with no residue**: the point one step beyond every finite end of a stuck chain has at least four colours | hand, one mind (blind) | §1.5 |
| **CV-EXISTS** | every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step | hand, one mind (blind), over DENSE3 (two), N2-TERM (two), N4-FIN (two), N3-DEG/W-MERGE/N4-RAY under unit arcs (two) | §1.5 |
| CV-PART | FS112-C-PARTNERS: TRUE, a corollary of N3-COR3 | hand, trivial, one mind (mine) | §1.5 |
| CV-COMP | FS112-C-COMPOSE (1) TRUE (a tautology of DENSE3); (2) TRUE with the radius `\|K\| + 2` needing NB3-LEN's `2\|K\| − 3`; (3) TRUE of GS-4's density form, not needed for the NO once CV-EXISTS holds | hand, one mind | §1.5 |

## Would-have-searched-here log (standing rule 3)

- The residue (a one-vertex chain with an in-type upper flank tile and no in-type lower one): I would have enumerated sector orders at `E ± n` and
  `E + 2n`; instead I derived the colour count at `E + n` and `E + 2n` (CV-HD, steps 1–13), where the three spare colours run out.
- Whether a fragment by formula realises `υ± = 1` with no in-type lower flank tile (a test of CV-HD): building one is a search for a counterexample to a
  derivation; not done. The held BOWTIE was run as it is (control, §1.6).
- Chain lengths over a named curvature set: not enumerated; NB3-LEN's rank count used.

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls data/fs114/` printed the **names** `fs114-n`, `fs114-nb`, `fs114-p`, `fs114-y`, `reports` (fenced directories); nothing in them was
   listed or opened.
2. `ls tools/ | grep -c fs114` printed a count (19); no name of another job's tool was printed.
3. **A touch of the assembly's summary, not its §3.** To check the claim list's §0 quotation I printed the **header** of `plans/FS112-derivation.md`
   (the text before its first `## ` line; §3 is fenced, the header is not). The header ends with a paragraph "The milestone's result in one paragraph"
   which retells the composition in summary: C-COMPOSE's three clauses (as the claim list quotes them), that BOWTIE refuted Y3-END-NEEDS, and "corrected,
   a horn bound of exactly `±1` on both horns of a terminal map's stuck vertex occurs only at a one-vertex chain (FS112-C-HORNEND), and the composition is
   unchanged but for one residue of FS112-C-ENDS". No proof content; the statements it names are the brief's. Told to the owner in the report.
4. `data/fs112/claims.md` §11 (the close's corrections and verdicts, written by FS112-C) is not on the fence list; I did not open it before stage 1, as it
   carries the close's verdicts on the claims I verify.
5. `LEDGER.md` row 135 (open by the brief) retells two of the composition's conclusions in one sentence each ("a horn bound `±1` on both horns … occurs
   only at a single vertex bounded by unit arcs on both sides", "every finite end has a four-colour vertex one step beyond (… bar one named residue …)").
6. Read and not fenced: `plans/BASE-V-verification.md` is lifted by the owner's note 2; I did not open it (not needed).
7. `git log`: not run.

## Stage 1 — SAVED: quotation check; the verdicts, blind

### 1.1 Files read from disk (this order)

`data/fs114/briefs/CV114-composition.md`; `data/fs114/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim and § Counter-priors (disk; identical to the loaded
copy on those lines); `data/fs114/claims.md` §§0–3; `data/fs112/claims.md` §0; `data/fs110/claims.md` §0; `plans/FS112-N-proof.md` in full;
`plans/FS110-N-proof.md` stage N3-2 and § Continuation — FS110-N4 in full; `plans/FS112-NB2-verification.md` (header, theorem table, N2-RAY, N2-DENSE,
N2-TERM, N2-FLANK-Q, stage 2); `plans/FS112-NB3-verification.md` (header, theorem table, §1.3, the chain lemmas and N3-END, stage 2);
`plans/FS112-NB-verification.md` §1.3, §1.4, §2.3; `plans/FS112-Y3-construction.md` stage 3; `plans/FS112-YB3-verification.md` §3.1 and the D1 row of stage 4;
`LEDGER.md` rows 134–136; `tools/fs112_yb3_frags.py` (BOWTIE's construction, read and run as it is); the header of `plans/FS112-derivation.md` (fence log 3).

### 1.2 Quotation check (standing rule 5)

| quotation | source | verdict |
|---|---|---|
| brief: FS112-C-HORNEND, "In a terminal valid map, a stuck vertex `E` both of whose horns …" | `plans/FS112-derivation.md` §3 (fenced) | **not checkable at stage 1**; checked at stage 2 |
| brief: FS112-C-DOUBLE, "In a terminal valid map, a stuck vertex `E` all four of whose horn arcs …" | same | same |
| brief: the stub's "second minds on FS112-C-ENDS (with its stage-1b repair), C-COMPOSE and C-PARTNERS" | `plans/STUB-global-step.md` (fenced) | same |
| claim list §0: valid map, unit arc, (Q), (R2), `M*`, `F(M)`, `R(M)` | `plans/FS112-derivation.md` header | **exact** (`tools/fs114_cv_quotes.py`, `data/fs114/fs114-cv/quotes-stage1.out`; the plant fires for its own row only) |
| claim list §0: `𝓜_K` | `data/fs112/claims.md` §0 | **exact** (same tool) |
| claim list §2: the ten held statements (DENSE3, BASE, COR3, C-PARTNERS, NOBOTH, N2-RED, NB4P, A4SIX, SIX, N2-TERM, C-ENDS, C-COMPOSE, N3-PER) | `plans/FS112-derivation.md` (sections not known before stage 2) | deferred to stage 2; each read against its record's own statement here: DENSE3, BASE, COR3, NOBOTH, N2-TERM, N3-PER **match their records' tables in content** (the derivation file's wording is longer) |
| claim list §3: GS-1's two quotations | `plans/POROS-2026-09-27-night-aim.md` (fenced) | deferred to stage 2 |

### 1.3 Setting, and the words I use

`M*` is a terminal valid modification (N2-TERM, two minds): valid, locally finite, arcs circular or straight, and no MERGE (W-MERGE), MERGE-RAY (N4-RAY),
SHAVE (N4-SHAVE) or bend (N2-RED's) applies anywhere. A **stuck** vertex is a vertex of `M*` with a repeated colour and exactly three colours. At a stuck
`E` (N4-STUCK (i)–(ii), which survive unit arcs — N2-4, NB2 divergence 2, re-derived below): a colour `c` has exactly two sectors, horns `H±` along
`±a`; the colour `g` fills the open half-plane `(z − E)·n > 0` in one sector, `h` the other one; `P_cl(E) = {c, g, h}`. `N = E + n`, `S = E − n`,
`M = E + 2n`. `υ±`, `λ±`: the upward curvatures at `E` of the upper and lower arcs of `H±`; `υ± = 1` means the upper arc of `H±` is an arc of `ω(N)`,
`λ± = −1` that the lower arc is an arc of `ω(S)`. **`G_N`**: a `g`-tile with `N` in its closure lying in `B̄(E, 1)` (in-type at `N`). **`H_S`**: an
`h`-tile at `S` lying in `B̄(E, 1)`. `R` = the three colours outside `{c, g, h}`. A **flank shadow** on a horn is a set of points of the horn's tip, at
every scale, lying in the shadow of tiles of a flank colour; "no SHAVE" is "doubly shadowed" (N4-SHAVE; a flank colour's shadow read as absent, or as
all of the tip, where it is).

**Inputs used, with their grades** (each re-checked in the step that uses it): N-E0/E1/E2 and N3-CONF ("both types at one point are impossible";
two minds); N3-CLEAR; N3-DEG under unit arcs (out-type contacts at both antipodes, bounds in `[−1, 1]`; N row 5, NB row 5: two minds); W-MERGE under
unit arcs (two minds; N's W2); N4-RAY (two); N4-SHADOW for `C ≠ 0` (two); N4-FIN (two); N112-U1 (two); N2-TERM (two, one blind); N3-DENSE3 (two, one
blind); N3-COR3 (two, one blind); N3-LEN and NB3-LEN (two); N3-PER (two); "moves never add a colour or a sector to an existing point" (N3-DENSE3's
proof, with W-MERGE's statement, N4-SHAVE's and N2-TOWARD's: two minds each for the moves).

### 1.4 The lemmas at a stuck vertex, and the classification

**N4-STUCK (i)–(ii) with unit arcs, re-derived.** A repeated colour `c` at a vertex `E` of `M*`: no MERGE gives `int D_c(E) = ∅`, so (N3-DEG) out-type
`c`-contacts at `E ± n` and `c`'s sectors are horns along `±a`; no MERGE-RAY, one per ray. Each horn needs both flank colours' shadows (no SHAVE); with
one colour `k` on both flanks no `k`-tile can shadow the tip (an in-type `k` at `N` is not Siamese with the lower flank, which lies outside `B̄(N, 1)`, nor
at `S` with the upper; an out-type `k` at `N` would put `D_k(E)` in `{d·n ≤ 0}` against the upper flank, at `S` against the lower), so the flanks differ:
**a repeated-colour vertex of `M*` has at least three colours.** For `H+`'s upper flank `g+` the shadow sources are contacts whose half-plane has `+a` on its
boundary (N3-CLEAR clears every other contact, and a contact arc of `ω(E)` compact and away from `N, S` uniformly): in-type at `N` or out-type at `S`
(in-type at `S` is not Siamese with a flank above the horn; out-type at `N` contradicts the flank's directions). A contact **arc** of `ω(E)` adds
nothing: a horn point `z = E + (x, κx²/2)`, `κ ∈ (λ, υ)`, has `|z − (E + e_θ)|² − 1 = −2x cos θ − κx² sin θ + x² + O(x⁴)`; the flank colour's in-type arcs
have `cos θ ≥ 0` (its sector holds `+a`), so a horn point is farther than 1 from an arc point only at `θ = ±90°` — the arc then reaches `N` or `S` and is
an in-type contact there; its out-type arcs have `cos θ ≤ 0`, and no horn point is within `< 1` of an arc point. Either source gives `D_{g+}(E) ⊆ {d·n ≥ 0}`, and N4-STUCK's proof of (ii) then runs as
written with `|P_cl(E)| = 3`: `g+ = g−`, `h+ = h−`, `g` one sector filling the upper open half-plane, `h` the lower.

**CV-L0 (a stuck vertex centres no unit arc).** A unit arc of `ω(E)` of length `ℓ > 0` is (Q) or (R2) in `M*` (N2-TERM), so its outer colour is in `{c, g, h}`
and (N112-U1) has all its sectors at `E` in a closed cone of angle `π − ℓ < π`. `g` and `h` each have a sector of angle `π`; `c` has horns along `+a` and `−a`,
which no cone of angle `< π` holds. So `ω(E) ∩ Γ` is finite. ∎

**CV-FLANK.** At a stuck `E`: the `g`-shadow on `H±` comes from `G_N` (then `g`'s sector, which fills the upper half-plane, lies in `B̄(N, 1)` near `E` by
N-E2, so **both** upper arcs have curvature `≥ 1`, hence `= 1`: `υ+ = υ− = 1`; and the in-type tile shadows every horn point, since horn points are
outside `B̄(N, 1)`), or from out-type `g`-tiles at `S` tangent to `+a` (for `H+`; to `−a` for `H−`), whose shadow is below a concentric circle (N4-SHADOW,
`C ≠ 0` by CV-L0); a non-tangent out-type tile shadows only inside `B(S, 1)`, which the horns miss. Mirror for `h`: `H_S` (forcing `λ+ = λ− = −1`) or
out-type `h`-tiles at `N` tangent to `±a`. ∎

**CV-U.** If `υ+ = 1`, `H+` lies outside `B(N, 1)` along an arc of `ω(N)` of directions `[270°, 270° + φ₊]` from `N`, `φ₊ > 0`; `c`'s shadow near `N` then
contains every direction `d` with `d·u > 0` for some `u` in that range, so `c`'s sectors at `N` lie in `[φ₊, 180°]`. A stuck `N` would carry `c` (N3-DEG at
`E`) either as its cone colour, with horns along two opposite directions, or as a flank filling an open half-plane; neither fits in `[φ₊, 180°]`. ∎ (Mirror at
`λ = −1`.)

**CV-P.** Suppose `¬G_N`. By CV-FLANK and no SHAVE of `H+` and of `H−`, there are out-type `g`-tiles `Q+`, `Q−` at `S` tangent to `+a` and to `−a`, each with a
shadow on its horn. (1) `c ∈ P_cl(S)` (N3-DEG at `E`), all `c`-sectors at `S` in `{d·n ≤ 0}` (the horns are an out-type `c`-contact of `S` at `E`). (2) No
`c`-sector at `S` lies in the `+a` stack above `Q+`: its upper arc, of curvature `κ_c` above `Q+`'s `κ_Q`, would shadow `E` below `f̃(κ_c) > f̃(κ_Q) > λ+`, i.e.
on `H+` (N4-SHADOW, N-E0); likewise at `−a`. (3) The open upper half-plane at `S` lies in `B(E, 1)`: its tiles are in-type at `S` or cross `ω(E)`; no `g`
there (in-type `g` at `S` is not Siamese with `g`'s sector at `E`; crossing is N-E1). So between `Q+` and `Q−` there is `c` one way round and a non-`g` colour
the other: **`g` has two sectors at `S`**. `S` therefore has a repeated colour: it is stuck, or it has at least four colours. ∎ (Mirror: `¬H_S` gives `h`
twice at `N`, the tiles `Y±` tangent to `±a`, separated by `c`'s sectors above and by the non-`h` lower half at `N`.) This is N4-STUCK (iv) with N4-PROP;
their only unit-arc exception is FLANK's in-type tile — the arc of `ω(E)` through `N` (row 8's) cannot occur at a stuck vertex (CV-L0).

**CV-L4.** `G_N` makes both upper arcs arcs of `ω(N)` with inner colour `g ∈ P_cl(N)` and outer colour `c ∈ P_cl(N)`: `N` is a both-centre. At a both-centre
each side cone holds a colour other than the two side colours (N112-U1); one colour in both side cones has two sectors, so (terminal) its sectors are horns
along a line, and with three colours `N` would be stuck, with flanks filling half-planes — against the side colours' cones of angle `< π`. So `|P_cl(N)| ≥ 4`
(N3-NOBOTH's "or a repeated colour" branch closes in `M*`). ∎

**CV-HD — both upper bounds `1` force an in-type lower flank tile at `E − n` [hand, one mind].** *In `M*`, no stuck `E` has `υ+ = υ− = 1` and `¬H_S`.*
Suppose it does. `φ± > 0` are the angular extents, seen from `N`, of the two upper arcs (arcs of `ω(N)` through `E`).
1. `c ∈ P_cl(N)`, its sectors at `N` in the pinch `Π_N = [φ₊, 180° − φ₋]` (the horns lie outside `B(N, 1)` along those arcs; CV-U's shadow on both sides).
2. `¬H_S` and no SHAVE of `H±`: out-type `h`-tiles `Y±` at `N` tangent to `±a` (CV-FLANK), and `h` has two sectors at `N` (CV-P's mirror).
3. `N` is terminal: `int D_h(N) = ∅` (else W-MERGE), so (N3-DEG at `N`) `h`'s sectors at `N` are exactly two horns `Y±` along `±a` (no MERGE-RAY), with
   out-type `h`-contacts at `E` and at `M = N + n`. `Y±`'s lower arcs have curvature `> −1` (curvature `−1` is an arc of `ω(E)`: CV-L0), so the tile just
   below each is outside `B̄(E, 1)` near `N`.
4. The flanks of `Y+`: upper `x+`, lower `y+`. Neither is `c` (the pinch excludes directions near `0°`), `g` (an out-type `g`-tile at `N` would put `D_g(E)`
   in `{d·n ≤ 0}`) or `h` (its sectors are `Y±`): **`x±, y± ∈ R`**, so none lies in `P_cl(E)`.
5. `x+ ≠ y+`: with one colour `k` on both flanks no `k`-tile shadows `Y+`'s tip — none at `E` (`k ∉ P_cl(E)`); at `M` in-type is not Siamese with the lower
   flank (outside `B̄(M, 1)`), out-type contradicts the upper flank's directions; a contact arc of `ω(N)` acts only through `M` or `E` (the computation of
   N4-STUCK's re-derivation, at `N`); other contacts are cleared — so a SHAVE by `k` applies. Likewise `x− ≠ y−`.
6. No SHAVE of `Y+`: the `x+`-shadow must come from an in-type `x+`-tile at `M` (out-type at `E` impossible, `x+ ∉ P_cl(E)`; out-type at `M` contradicts
   the upper flank's directions), Siamese with `x+`'s sector just above `Y+`, which forces **`Y+`'s upper arc onto `ω(M)`**; the `y+`-shadow must come from an
   out-type `y+`-tile at `M` tangent to `+a` (in-type at `E` impossible; in-type at `M` is not Siamese with the lower flank). Mirror for `Y−`.
7. `x±, y± ∈ P_cl(N)`; `x±` are in-type at `M`, `y±` out-type at `M`; a colour of `P_cl(N)` cannot be both at `M` (N3-CONF), so
   **`{x+, x−} ∩ {y+, y−} = ∅`**. With `|R| = 3` (*six is spent here*): `x+ = x−` or `y+ = y−`.
8. *`x+ = x− = x`*: `x` has two sectors at `N` (`c` between them above, `Y±` below). Their closures hold the directions `0°` and `180°`, so every `x`-contact's
   half-plane has boundary `±a`: contacts at `E` or `M` only, and none at `E`. So `D_x(N)` is the upper half-plane (in-type at `M`) and has interior:
   **W-MERGE applies at `N`** — against terminality.
9. So `y+ = y− = y`. If `y`'s sectors below `Y+` and below `Y−` were different, the same count (contacts at `M` only, out-type there) makes `D_y(N)` the lower
   half-plane and W-MERGE applies. So **`y` is one sector filling the open lower half-plane at `N`**, whence `¬G_N` (an in-type `g`-tile at `N` would lie there),
   and `g ∉ P_cl(N)` (out-type `g` at `N` is impossible, step 4). `P_cl(N) = {c, h, x+, x−, y}`, `x+ ≠ x−`: every colour but `g`.
10. At `M`: `y` has out-type tiles `V±` tangent to `±a` (step 6) and `h` lies in the pinch `Π_M` (`Y±` lie outside `B(M, 1)` along their upper arcs, step 6);
    `V+`, `V−` are separated by `h` above and, below, by the lower half at `M`, which holds no `y` (a `y`-tile there is in-type at `M` or crosses `ω(N)`; both
    are excluded for `y ∈ P_cl(N)`, N3-CONF and N-E1). Terminal: `D_y(M)` is the line, `V±` are horns along `±a`, one per ray.
11. The upper flank `z+` of `V+` at `M` lies outside `B̄(N, 1)`. If `z+ ∈ P_cl(N)` it is out-type at `M`: not `c` (it would put `D_c(N)` in the lower
    half-plane, against `Π_N`), not `h` (`Π_M` excludes directions near `0°`), not `x±` (in-type at `M`), not `y` (an adjacent `y` region is `V+` itself; a second
    `y`-horn on the ray merges). So `z+ ∉ P_cl(N)`: **`z+ = g`**, and likewise `z− = g` (*six is spent here: `g` is the only colour left*).
12. `z+`, `z−` are two `g`-sectors at `M` (`h` between them above; `V±` below). Their closures hold `0°` and `180°`, so `g`'s contacts on `ω(M)` are at `N` or at
    `M + n`; there is none at `N` (`g ∉ P_cl(N)`, step 9). So `D_g(M)` is a half-plane or everything: **W-MERGE applies at `M`** — against terminality. ∎

*Mirror:* no stuck `E` has `λ+ = λ− = −1` and `¬G_N`. With CV-FLANK (`G_N ⇒ υ± = 1`, `H_S ⇒ λ± = −1`):
**`G_N ⇔ υ+ = υ− = 1 ⇔ H_S ⇔ λ+ = λ− = −1`** — the four horn arcs are unit arcs exactly when the flanks have in-type tiles at both antipodes (BOWTIE's
configuration).

*Where six is spent:* step 7 (three colours outside `P_cl(E)`) and step 11 (`g` the last colour). With seven colours `x+, x−, y+, y−` can be four distinct
colours and step 7 yields nothing: the argument stops, as it must (no stuck vertex in the hexagonal seven-colouring either). Nothing else in the chain counts
colours.

**CV-CLASS.** *A stuck vertex `E` of `M*` is either* **(I) a bowtie** — `G_N` and `H_S`, all four horn arcs unit arcs, `N` and `S` both-centres with at least
four colours (CV-L4 and its mirror), `E` a one-vertex chain — *or* **(II)** `¬G_N` and `¬H_S`, and then `g` has two sectors at `S` and `h` two at `N` (CV-P
both ways): each neighbour is stuck or has at least four colours **and** a repeated colour. ∎ (CV-HD rules out the mixed cases.)

### 1.5 The verdicts

| statement | verdict | grade, minds (mine blind) |
|---|---|---|
| **FS112-C-ENDS** "the point of the normal line one step beyond each finite end of a stuck chain has at least four colours, except possibly beside a one-vertex chain bounded by unit arcs on both sides but not on all four horn arcs, at a bound on an (R2) arc — a residue not walked" | **TRUE as stated; and TRUE with the exception deleted — the residue is empty.** Let `E` end a chain with `S` not stuck. If `¬G_N`, CV-P gives `g` twice at `S`, which is not stuck, so `\|P_cl(S)\| ≥ 4`. If `G_N`, CV-HD gives `H_S`, and `S` is a both-centre with `≥ 4` colours (CV-L4's mirror). Mirror at an upper end. The configuration the exception names — unit arcs above and below but not all four, a bound on an (R2) arc — is case (II): the neighbour beyond carries a repeated colour (CV-P) and is not stuck (CV-U), so it has four colours or more | hand; the stated form two minds (FS112-C; mine); the residue-free form one mind (mine) |
| **FS112-C-HORNEND** "In a terminal valid map, a stuck vertex `E` both of whose horns are bounded by unit arcs of `ω(E + n)` has a horn bounded by a unit arc of `ω(E − n)` too, and is a one-vertex chain; likewise with `n` reversed." | **TRUE, and sharper:** both horns are bounded by unit arcs of `ω(E − n)`, and an in-type lower-flank tile sits at `E − n` (CV-HD); one-vertex by CV-U both ways | hand; the stated form two minds (FS112-C2; mine); the sharper form one mind |
| **FS112-C-DOUBLE** "… a stuck vertex `E` all four of whose horn arcs are unit arcs … carries an in-type tile of its upper flank colour at `E + n` and of its lower flank colour at `E − n`, and both are (Q) centres with at least four colours." | **TRUE** (CV-HD's mirror gives `G_N` from `λ± = −1` and `H_S` from `υ± = 1`; CV-L4 both ways: both-centres with `≥ 4` colours, so (Q) in `M*`) | hand; two minds (FS112-C2, a sketch; mine) |
| **FS112-C-PARTNERS** "every close complementary cubic trichromatic partner of a cubic trichromatic vertex `u` is the fourth corner `w_i + w_j − u` of a unit rhombus on two of `u`'s leaving centres, so `u` has at most three such partners" | **TRUE.** By N3-COR3 both common unit points `q±` of `u`, `u′` (distinct, `0 < d < 2`) are leaving centres of `u`; the rhombus `u, q₊, u′, q₋` has unit sides, so `u′ = q₊ + q₋ − u`. A cubic `u` has three boundary arcs leaving it, each on at most one unit circle, whose centre lies on `ω(u)`: at most three leaving centres, three pairs | hand, trivial over N3-COR3 (two minds, one blind); two minds (FS112-C; mine) |
| **FS112-C-COMPOSE (1)** | **TRUE** — DENSE3 makes "valid maps with `F ∪ R` within 3 of every point" all valid maps; nothing about rays enters | hand, trivial; two minds |
| **FS112-C-COMPOSE (2)** | **TRUE.** `M*` periodic (N3-PER), `K` finite; `x` has `w ∈ F ∪ R` within 3 (DENSE3 on `M*`); a stuck `w` lies on a chain of at most `2\|K\| − 3` vertices (**NB3-LEN**; N3-LEN's `2\|K\| − 1` would give `\|K\| + 3`), within `\|K\| − 2` of its nearer end, and the point beyond that end has four colours (CV-ENDS; for a one-vertex chain, CV-CLASS). `3 + (\|K\| − 2) + 1 = \|K\| + 2` (`\|K\| ≥ 2` wherever a horn exists) | hand; two minds; the radius rests on NB3-LEN's count |
| **FS112-C-COMPOSE (3)** | **TRUE of GS-4's density form**: a stuck ray, or chains of unbounded length, leave points of `M*` far from `F` (CV-CLASS bounds nothing along a chain). **Not needed for the NO**: by CV-EXISTS the NO follows from C114-LOCAL-F alone, with no ray step and no chain bound | hand; one mind for the scope note |
| **C114-EXISTS-F** "every valid map has a valid modification with a vertex of at least four colours — with FS112-C-ENDS's residue closed, or named as the one case it misses" | **TRUE, stronger: every valid map itself has a vertex of at least four colours; no residue, no ray step.** Take `M*`. DENSE3 gives a vertex of `F(M*) ∪ R(M*)`. If `F(M*) = ∅`, a repeated-colour vertex has three colours (the re-derivation above), so it is stuck; `G_N` or `H_S` would put a vertex of `≥ 4` colours at `E ± n` (CV-L4), so `¬G_N`, `¬H_S`, and CV-P makes both neighbours carry a repeated colour with three colours: stuck. The chain is bi-infinite; CV-U puts every bound strictly inside `(−1, 1)`, the recursions of N4-FIN hold between consecutive stuck vertices (N3-2's frame, two minds), and N4-FIN forbids the chain. So `F(M*) ≠ ∅`. Moves never add a colour to an existing point and create only corners and cubic vertices, so a vertex of `≥ 4` colours of `M*` has `≥ 4` colours in the original map. The residue was never on this path: at a one-vertex chain one neighbour always has four colours (CV-CLASS) | hand; one mind (mine), over DENSE3 (two, one blind), N2-TERM (two, one blind), N4-FIN, N4-SHADOW, N3-DEG, W-MERGE, N4-RAY, N112-U1 (two each) |
| **GS-1** "the terminal modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named residue"; "A local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density" | **TRUE, and "outside … residue" can be deleted** (CV-EXISTS; the vertex is the original map's). The second sentence is TRUE: a valid map restricted to a disc of radius `R` about its four-colour vertex is a valid fragment, so C114-LOCAL-F with CV-EXISTS is the NO | hand; one mind for the residue-free form |
| C114-LOCAL-FR | with CV-EXISTS it is not needed: C114-LOCAL-F (the weaker local statement) already gives the NO | (a scope note) |

**What it does to the question (FS-114).** The NO is now: *exclude a valid fragment on a closed disc of radius `R` about one vertex of at least four
colours* (C114-LOCAL-F), for some explicit `R` (`R > 1.834` by the strip; the disk's `φ` for vertex-centred discs about its corners). No density, no ray, no
chain bound, no periodicity. The stuck ray (FS-115) and N3-ALPH bear only on GS-4's density form, which the NO no longer needs.

### 1.6 Controls

- **BOWTIE** (`tools/fs112_yb3_frags.py bowtie`, run as it is; `data/fs114/fs114-cv/bowtie-control.out`, exit 0, ACCEPT 21/21): `E` stuck with `P_cl = {1, 2, 3}`,
  in-type `g` at `N` and `h` at `S`, all four horn arcs unit arcs; `P_cl(N) = {1, 2, 4, 5}`, `P_cl(S) = {2, 3, 4, 5}`. It is CV-CLASS's case (I) exactly: both
  neighbours four-coloured, one vertex. It does not test CV-HD (it has both in-type tiles); nothing held has `υ± = 1` with `¬H_S` in a terminal map.
- **Y3-END-A, Y3-END-B** (their records, not rebuilt): `υ_E = 1`, `λ_E = 0`. CV-HD predicts no terminal completion; Y3 found `N` not terminal in both (a
  MERGE, then a SHAVE), and YB3's seventh colour at `N + n` is CV-HD's steps 10–11 on the `¬G_N`, `y+ = y−` branch. Consistent.
- **Seven colours:** CV-HD's steps 7 and 11 are where six is spent; with seven the count fails and the lemma says nothing. CV-P, CV-U, CV-L0, CV-L4 count no
  colours (CV-L4 uses "three colours ⇒ stuck", which holds for any palette). The hexagonal seven-colouring has no stuck vertex and no unit arc: vacuous.
- **The strip:** no stuck vertex (card X; N2-5): CV-CLASS is vacuous there, and its midline four-colour vertices are CV-EXISTS's vertices.

### 1.7 Selection audit (G21)

This result closes a door the NO side wants closed, at one mind. What I pushed against it: (a) every "a colour has two sectors, so W-MERGE" step (CV-HD
steps 8, 9, 12) was checked for the one escape, `int D = ∅`, by listing the contacts whose half-planes can hold both directions `0°` and `180°` (only the two
antipodes) and checking each against `P_cl` of the vertex across; (b) the both-types step (step 7) was checked to apply only to colours of `P_cl(N)` —
`x±`, `y±` are flank colours of `N`'s horns, so it does; (c) the `G_N` sub-case is not assumed away: it dies at step 9; (d) the shadow lists at `N` and `M`,
which may centre unit arcs, were re-derived with contact arcs (N4-STUCK's re-derivation, carried to `N`); (e) CV-EXISTS was derived without CV-HD, from
CV-P and CV-L4 alone, so its truth does not rest on the new lemma. **What an error common to my walk and the N side's would rest on:** W-MERGE and N3-DEG
under unit arcs, N4-FIN's recursions, N112-U1 and DENSE3 — all held at two minds, none re-derived here beyond the steps named.

### 1.8 Registered before stage 2 (G21 instruments; each with both outcomes reachable)

| id | prediction | p |
|---|---|---|
| CV-P1 | the assembly's residue exists because its C-ENDS argument did not close the case with an in-type upper-flank tile and no in-type lower one (CV-HD), or did not see that the neighbour beyond an (R2) bound carries a repeated colour (CV-P's mirror) | 0.6 |
| CV-P2 | the assembly's C-HORNEND rests on Y3/YB3's level analysis and concludes one lower unit arc, not both with an in-type tile (no statement equivalent to CV-HD's equivalence) | 0.7 |
| CV-P3 | the night advisor's C114-EXISTS-F passes through C-ENDS and keeps the residue as its exception (no remark that a one-vertex chain always has a four-colour neighbour) | 0.7 |

## Stage 1 — SAVED
