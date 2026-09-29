# Definitions for FS116-V1 (statement FS114-N7-3T), copied verbatim

*Vetted by Keryx, 2026-09-29 05:59 UTC, for FS116-V1, from the Clerk's copy (job CL2): one passage cut to its defining clause (the lens), three passages removed because they state lemmas or a verifier's reasoning rather than define a term, and one pointer to the Clerk's report removed. Everything else is the Clerk's verbatim copy. Where the sources leave a term open (whether a four-colour vertex has exactly or at least four colours; how `ε` is quantified in "excluded at radius `1 + ε`"), they do not settle it: state which reading you work, or both.*

*Job CL2, the Clerk, 2026-09-29. Every passage is a blockquote with its source file and lines. Within a passage, source line breaks are joined by one space; nothing else is changed. A fragment is a cut of one sentence at the quoted words. Sections N1-N7 are the verifier's questions. N5 has no passage (see its note). No route, verdict, `argument:`, `uses only:`, `minds:` or `model:` field is copied.*

## N1
**tactic edge, ring, change point (notation)**

> a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone), `n(p)` the non-tactic edges at `p`. New here: at a vertex `p`, the **ring** is `ω(p)`; a **change point** of the ring is a point of `Γ ∩ ω(p)` where the colour of the ring off `Γ` differs on its two sides;

*Source: `plans/FS114-N3-proof.md` lines 6-8.*
**tiles, edges, tangent direction at p**

> `p` is a vertex of degree 4 with tiles `t₁ … t₄` counter-clockwise, colours `c₁ … c₄`, absent colours `c₅, c₆`; `e_i` separates `t_i` (clockwise side) from `t_{i+1}` and leaves `p` in the tangent direction `θ_i`; a tactic `e_i` has centre `q_i`, inner `x_i`, outer `y_i`, partner `z_i` (colour `c(y_i)`, touching `x_i` at `q_i` alone).

*Source: `plans/FS114-N3-proof.md` lines 92-94.*
**the sign of a tactic edge; inner count; the patterns**

> **The patterns.** Mark a tactic `e_i` `+` when its inner tile is `t_{i+1}` and `−` when it is `t_i`; a tile's **inner count** is the number of tactic edges at `p` it is inner to (0, 1 or 2: **anti-lens**, **rotational**, **lens**), and the counts sum to the number of tactic edges. Four tactic edges: `++++` (four rotational), `+−+−` (two opposite lenses, two anti-lenses), and the mixed `+++−`, `++−−` (one lens, two rotational, one anti-lens).

*Source: `plans/FS114-N3-proof.md` lines 116-119.*
**a + edge: inner tile counter-clockwise (fragment)**

> A `+` edge there (inner tile counter-clockwise)

*Source: `plans/FS114-N7-proof.md` lines 126-126.*
**a - edge: inner tile clockwise (fragment)**

> a `−` edge (inner tile clockwise)

*Source: `plans/FS114-N7-proof.md` lines 127-127.*
**order of the edges e1, e2, e3 (fragment of the setting of the exclusion; the source sentence goes on after `e4` at `θ_4`)**

> Three tactic edges among four are consecutive; call them `e1, e2, e3` at `D_a, D_b, D_c` (`a < b < c < a + 6` in the cyclic order), so `t2 = [D_a, D_b]`, `t3 = [D_b, D_c]`, `t4 = [D_c, θ_4]`, `t1 = [θ_4, D_a]`, with `e4` at `θ_4`

*Source: `plans/FS114-N7-proof.md` lines 133-134.*
**reflection reverses the order and the signs (parenthetical only)**

> (which reverses the order and the signs)

*Source: `plans/FS114-N7-proof.md` lines 135-135.*
**D_m and 'reaches' (notation)**

> Write `D_m = y + 30° + 60m` (indices mod 6). A tile **reaches** `y_k` when `y_k` is in its closure.

*Source: `plans/FS114-N7-proof.md` lines 91-92.*

*Note: No line states outright that a sign string such as `+-+` reads `e1 e2 e3` in counter-clockwise order; the passages above are all the source gives (`CHECK:` in the report).*

## N2
**lens, its centres, gamma (N3-SEC (iii); fragment, the definition only)**

> A tile inner to both its edges at `p` (a **lens**; centres `q, q′`, the angle `γ = ∠qpq′`)

*Source: `plans/FS114-N3-proof.md` lines 113-114.*
**Reuleaux lens (fragment)**

> a lens is Reuleaux (`γ = 60°`, cone `120°`, reaching its two centres)

*Source: `plans/FS114-N7-proof.md` lines 136-136.*
**Reuleaux cap region**

> With `P = 0`, `A = e(0°)`, `B = e(60°)`, `C = A + B`: the Reuleaux triangle `Reul(P, A, B)` inside the arc `α ⊂ ω(P)` from `A` to `B`, and the **Reuleaux cap** `Reul(A, B, C) ∖ B̄(P, 1)` outside it,

*Source: `plans/FS114-N4-proof.md` lines 185-186.*
**the cap of the bowtie (N4's frame)**

> the cap (an arc of `ω(p)`) leaves `q1` at `300°`

*Source: `plans/FS114-N4-proof.md` lines 91-91.*
**the bowtie's caps as (Q) arcs**

> Its caps are (Q) arcs (inner `t1`, outer the colour-3 cap tile)

*Source: `plans/FS114-N6-proof.md` lines 253-253.*
**a bowtie whose lenses do not border the caps**

> A bowtie whose lenses do **not** border the caps (the caps' ring arcs in absent-colour tiles)

*Source: `plans/FS114-N6-proof.md` lines 254-255.*
**the Reuleaux bowtie (construction side's object)**

> **the Reuleaux bowtie** — a vertex `p` where two Reuleaux triangles of width 1, `t1 = (p, q1, q2)` and `t3 = (p, q4, q3)` (`q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`), meet corner to corner, with `t2` above and `t4` below; all four edges at `p` are unit arcs about `q1…q4`.

*Source: `plans/FS114-Y2-construction.md` lines 74-76.*
**a Reuleaux bowtie includes its four tactic edges**

> A **Reuleaux bowtie** includes its four tactic edges (reading R-T, the owner's ruling, `plans/FS114-close-inventory.md` item 72).

*Source: `plans/FS114-derivation.md` lines 9-10.*
**OC: the defining clause in the D-frame (fragment of N7-3T's proof-record statement)**

> in the frame above, `t2 ⊂ Reul(p, y_{a+1}, y_{a+2})` with cone `[D_a, D_{a+2}]`, `t3 = [D_{a+2}, D_{a+3}]`, `t4 ⊂ Reul(p, y_{a+4}, y_{a+5})`, `t1` a tip at `y_a`, `θ_4 ∈ [D_{a+4}, D_{a+5}]` — the **open-cap family OC**.

*Source: `plans/FS114-N7-proof.md` lines 140-142.*
**OC with a fourth tactic edge (fragment)**

> With `e4` tactic OC is the Reuleaux bowtie whose lenses do not border the caps (N6's K1-OPENCAP), `θ_4 = D_{a+5}`

*Source: `plans/FS114-N7-proof.md` lines 144-145.*
**OC in the bowtie frame (parenthetical of the section 'What survives')**

> frame of N4's bowtie: `t1 = [300°, 60°] ⊂ Reul(p, q2, q1)`, `t2 = [60°, 120°]` the tip at `top`, `t3 = [120°, θ_4] ⊂ Reul(p, q3, q4)`, `t4 = [θ_4, 300°]` the tip at `bot`, `θ_4 ∈ [180°, 240°]`; tactic edges at `300°` (along `ω(q1)`, partner of colour 4 at `q1`), `60°` (along `ω(q2)`, partner 2 at `q2`) and `120°` (along `ω(q4)`, partner 2 at `q4`); the ring's change points `q1, top, q3, q4, bot, q2`, ring tiles alternating `X, X̄` on the six 60° arcs)

*Source: `plans/FS114-N7-proof.md` lines 195-197.*
**OC's frame in section 3.3**

> *Frame of §2.3 (N4's bowtie frame), `θ_4 ∈ (180°, 240°]`.*

*Source: `plans/FS114-N7-proof.md` lines 265-265.*

*Note: No separate definition found for: "non-Reuleaux lens" (a lens with `gamma` not 60 degrees, by the two lens passages above, is my reading only); "60 degree anti-lens" (anti-lens is inner count 0; "60 degrees" not defined, the D-frame OC passage shows `t3 = [D_{a+2}, D_{a+3}]`); "open-cap" (why open) ; "members" of OC; the word "lune". Defined in use only.*

## N3
**the (2, 1, 1, 0) patterns and the pinwheel named by pattern (N4's table cell)**

> `++++` (the pinwheel), `+++−` and `++−−` (the `(2, 1, 1, 0)` patterns)

*Source: `plans/FS114-N4-proof.md` lines 290-290.*
**the (2, 1, 1, 0) patterns, read against N3-SEC's pattern list (N5's readback line)**

> "the `(2, 1, 1, 0)` patterns": faithful to N3-SEC's pattern list (`++++` four rotational; `+++−`, `++−−` one lens, two rotational, one anti-lens).

*Source: `plans/FS114-N5-proof.md` lines 83-83.*

*Note: No line states what the 4-tuple orders or counts. N3-SEC's inner counts (0, 1 or 2: anti-lens, rotational, lens) and its pattern list are the nearest source: see the N1 passage `The patterns`.*

## N4
**the pinwheel: the pattern ++++ (N5, section 4.2)**

> *Pattern `++++` (N3-SEC): `t_j` has cone `[θ_{j−1}, θ_j]` of width `α_j`, is inner to `e_{j−1}` (centre `q_{j−1} = p + e(θ_{j−1} + 90°)`) and outer to `e_j` (centre `q_j`); the partner of `e_j` is `z_j`, of colour `c_j`, at `q_j`.

*Source: `plans/FS114-N5-proof.md` lines 259-260.*
**the pinwheel (construction side's parenthetical)**

> the pinwheel (each tile inner for one edge, angles ≤ 180°)

*Source: `plans/FS114-Y2-construction.md` lines 158-158.*
**gamma: see N2 (N3-SEC (iii)); the lens with gamma = 0 (fragment of the N7 record)**

> or `γ = 0°` (cone `180°`, one centre)

*Source: `plans/FS114-N7-proof.md` lines 136-136.*

## N5

*Note: No separate definition found; "die in every member" is defined in use only. Used at `plans/FS114-N7-proof.md` line 144 ("in every member") and in the entry's `statement:` below; not copied, since the sentence says what dies.*

## N6
**what 'no valid fragment' refers to: valid fragment on a disc, and 'reads radius R'**

> **Local** *(this list)*: a statement or a step **reads radius `R`** when its hypotheses and its conclusion concern only the map inside a closed disc of radius `R`. A **valid fragment on a disc** `D` is a map of an open set containing `D`, bounded by segments and circular arcs, six-coloured with no two interior points of one colour at distance exactly 1.

*Source: `data/fs114/claims.md` lines 36-38.*
**the goal statement about a disc about a four-colour vertex (claim list)**

> there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours.

*Source: `data/fs114/claims.md` lines 110-111.*
**the disc the lemmas read**

> Every lemma reads the disc of radius `1 + ε` about `p` unless it says otherwise, and uses no complexity bound.

*Source: `plans/FS114-N3-proof.md` lines 95-95.*
**non-Siamese (definition)**

> **non-Siamese** valid maps (no two distinct tiles of one colour close)

*Source: `plans/FS114-N6-proof.md` lines 11-12.*
**simple class (definition)**

> **simple class** (a tile's cone at a vertex is one closed interval; a tile never touches itself)

*Source: `plans/FS114-N6-proof.md` lines 12-13.*
**close / far**

> two tiles of one colour are **close** when every distance between their points is `< 1` (de Grey's *Siamese*) and **far** when every such distance is `> 1`.

*Source: `plans/FS114-N-proof.md` lines 8-9.*

## N7
**unit arc and (Q)**

> A **unit arc** is a boundary arc of radius 1; **(Q)** an arc whose centre carries both side colours and at least four colours;

*Source: `data/fs114/claims.md` lines 16-17.*
**P_cl and omega (notation)**

> `P_cl(x)` the colours of tiles whose closure contains `x`, `ω(x)` the unit circle about `x`

*Source: `plans/FS112-N-proof.md` lines 6-6.*
**the bends, in the (Q)-free setting**

> the map is bent on a fragment of radius `1 + ε` about `p` (NB6 §1b.0: then every ring `Γ`-arc but the (Q) arcs is removed, and the tactic edges, inner tiles and partners are kept, N5-BENDG).

*Source: `plans/FS114-N7-proof.md` lines 88-89.*
**the bends: the modification (FS-112's statement)**

> Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which every unit arc is (Q) or (R2)

*Source: `plans/FS112-derivation.md` lines 90-90.*
**a four-colour vertex in the setting of the exclusion**

> `p = 0` a vertex of a non-Siamese valid map in the simple class carrying exactly four colours (so degree 4)

*Source: `plans/FS114-N7-proof.md` lines 87-87.*
**a four-colour vertex in the verifier record NB6**

> A **four-colour vertex** here carries exactly four colours (two absent colours `A`, `Ā`, so that `κ̄` means something); non-Siamese, it has degree 4.

*Source: `plans/FS114-NB6-verification.md` lines 99-100.*
**F(M): vertices of at least four colours**

> `F(M)`: the vertices of at least four colours;

*Source: `plans/FS112-derivation.md` lines 14-14.*
**tip**

> the open cone `(ψ_k + 150°, ψ_k + 210°)` at `y_k` (the directions toward `p`) lies in cones of tiles of `p` reaching `y_k`; call such a tile a **tip** at `y_k`.

*Source: `plans/FS114-N7-proof.md` lines 99-100.*
*Note: No separate definition found for "(Q)-free ring" and "(Q)-free after the bends" as phrases; the passages above (unit arc and (Q); the bends) are what the sources give. "tiles of p", "p-tiles" and "face away": no definition outside the records that hold the first derivation; read them in the statement's own words, or ask.*

## The entry `derivation: FS114-N7-3T`: `statement:` and `not claimed:` (nothing else)
*Line breaks kept; the two-space indentation of the entry removed from each line; all other characters as in the file.*
**statement:**

> statement: **Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`**, except the open-cap family **OC**
>   (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses do not border the caps): the
>   `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a four-colour vertex,
>   non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions
>   toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other
>   tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)

*Source: `plans/FS114-derivation.md` lines 712-717.*
**not claimed:**

> not claimed: rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC
>   (its forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the
>   construction side's E2 is not settled, `plans/FS114-C-close.md` stage 2 §2.5)

*Source: `plans/FS114-derivation.md` lines 719-721.*

## The author's readings of FS116-O1-SATPIN (relayed to FS116-V1 by message, 2026-09-29)

*Verbatim from FS116-O1's message to the coordinator; recorded here so the brief's amendment can quote it from a file you may read.*

> (S1) The reading a ≠ b is meant. An "edge" in the statement is a boundary arc between tiles of two different colours. A boundary arc between two tiles of one colour is not an edge in the statement's sense.
>
> (S2) The reading "one of" is meant: every edge is at least one of the two types. "Exactly one" is not meant to assert that no edge satisfies both descriptions as written.
