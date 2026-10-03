# The setting of FS116-Y3-NBTIP, FS116-Y3-TIGHTLENS, FS116-Y3-STARFORCE — definitions copied verbatim (job FS116-CL1)

*Copied by the Clerk, 2026-10-03, from `plans/FS116-Y3-construction.md` (called "the record" below; line numbers are its lines) unless an address
says otherwise. Quotations are verbatim, except that a line break inside a quoted passage is a space. A `[cut: …]` marks where I stopped a passage;
a `CHECK:` line is for the coordinator. Nothing here is argued or paraphrased.*

## T1 — FS116-Y3-SIX and FS116-Y3-TIPS: the `statement:` and `not claimed:` fields only

> **derivation: FS116-Y3-SIX**
> statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles
> not claimed: anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists

Address: the record, lines 245–251.

> **derivation: FS116-Y3-TIPS**
> statement: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°])
> not claimed: anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists

Address: the record, lines 261–267.

## T2 — the labels

**The hubs `y_k`, and `X`, `X̄`** (the record, § 2.1, the sentence after the ∎, lines 186–187):

> Rotating, the hubs are `y_k = e(60k)` (`p` at the origin), and the ring is `X` on `(0°, 60°)`, `(120°, 180°)`, `(240°, 300°)` and `X̄` on the other three arcs (the names `X`, `X̄` chosen so).

Also, the record's stage-3 header (line 323): "`p` at the origin with a Γ-free ring, hubs `y_k = e(60k)`". And the roles of `X`, `X̄` as colours just counter-clockwise / just clockwise of a change point: `data/fs116/claims.md` § 10, RING-GERM, and § 13's quoted Notation (line 183): "colour `X̄` just clockwise (tile `R′`) and `X` just counter-clockwise (tile `R`)" — the record's own header paragraph *Notation* does not define `X`, `X̄`.

**The tiles `T1`–`T4`, their colours, the edges `δ_1`–`δ_4`, and their ranges** (the record, § 2.2, the paragraph after the proof, lines 201–204):

> So, naming the tiles by role — **`T1`** tips `y_0, y_1` (cone `[δ_4, δ_1] ⊂ [−30°, 90°]`), **`T3`** tips `y_2` (`[δ_1, δ_2] ⊂ [30°, 210°]`), **`T2`** tips `y_3, y_4` (`[δ_2, δ_3] ⊂ [150°, 270°]`), **`T4`** tips `y_5` (`[δ_3, δ_4] ⊂ [210°, 30°]`), counter-clockwise, with `δ_1 ∈ [30°, 90°]`, `δ_2 ∈ [150°, 210°]`, `δ_3 ∈ [210°, 270°]`, `δ_4 ∈ [−30°, 30°]` — and their colours `1, 3, 2, 4`.

[cut: the next sentence of the paragraph, "This is the pattern of HEX3's star when …", names a star and what HEX3 needs.]

The stage-3 header (line 323) restates: "tiles `T1` (colour 1, tips `y_0, y_1`), `T3` (3, tips `y_2`), `T2` (2, tips `y_3, y_4`), `T4` (4, tips `y_5`), edges `δ_1, …, δ_4` (§ 2.2)".

The range: § 2.3's table header (line 211): "four colours when every `δ` is interior to its range"; § 3.2 (line 328): "a **boundary value** of `δ_i` is an endpoint of its range".

CHECK: the range of each `δ_i` is stated only in the § 2.2 sentence above, as a conclusion ("with `δ_1 ∈ [30°, 90°]`, …"), the same sentence as the naming; it may be the definition of "its range" (your call).
CHECK: no sentence says in words that `δ_i` is "the direction of an edge of `p`". The record gives the cones as `[δ_4, δ_1]`, … and speaks of "edges `δ_1, …, δ_4`" (line 323) and "the edges of `p` satisfy" (TIGHTLENS's statement). Defined in use at § 2.2, lines 201–204.
CHECK: the § 2.1 sentence on `y_k` and `X`, `X̄` follows the proof of SIX (its conclusion "so there are 6(2j+1) change points … forces j = 0 ∎") and the labelling "the hubs are y_k = e(60k)" is the conclusion of SIX; as a labelling it is also what TIPS's statement says ("with the hubs y_k = e(60k)"). I copied the one sentence; the cut, if any, is yours.

## T3 — hub, tip, outer tile, outer colour, single tip, double tip, Γ-free

The record's header paragraph *Notation* (line 11 on; the part defining these terms is lines 15–18):

> A **hub** of `p` (N2's) is a change point of `p`'s ring whose four germs at `±60°` lie on no (Q) arc; a **tip** at a ring point `y` is a tile of `p` whose closure holds `y`; an **outer tile** at `y` is a tile of a colour of `p` that is not a tile of `p`. *New:* a ring is **Γ-free** when no arc of `Γ` lies on it (`Γ ∩ ω(p)` finite).

(Copied from "A **hub**" to "(`Γ ∩ ω(p)` finite).": the record, lines 15–18, the two sentences that follow "A tile has diameter at most 1." in the paragraph; nothing dropped between them.)

The same words, in the sources the record cites: `plans/FS116-N2-proof.md` lines 14–16: "A **tip** at a ring point `y` is a tile of `p` whose closure holds `y`; an **outer tile** at `y` is a tile of a colour of `p` that is not a tile of `p`. *New:* a **hub** of `p` is a change point `y` of `p`'s ring whose four germs `u⁻, u⁺, v⁻, v⁺` at `y ± 60°` lie on no (Q) arc — by RING-GERM (iii) a vertex of at least four colours"; and `data/fs116/claims.md` § 13 (line 183): "A **tip** at `y` is a tile of `p` whose closure holds `y`; an **outer tile** a tile of a colour of `p` that is not a tile of `p`; `T_y`, `O_y` their colours (FS116-N2-STAR)." and "`y` is a **hub** when its four germs lie on no (Q) arc (FS116-N2's word)".

CHECK: the record's "outer tile **at `y`**" and § 13's "an outer tile" (no "at `y`") differ by those two words; and the record names the hub's four germs "at `±60°`", § 13 says "its four germs"; I judge neither changes the meaning, but you asked for a flag on any difference. The germs themselves are RING-GERM's (claims § 10, line 158).
CHECK: **outer colour** has no separate definition in the record. Defined in use at the record § 2.3 (line 208): "`O_y` (non-empty: RING-GERM (ii)) holds colours whose tile at `p` misses `B(y, 1)` (cone at `p` in `[ψ + 90°, ψ + 270°]`)" — that sentence is a claim about outer colours, not copied beyond this address; and at `claims.md` § 13 (line 183): "`T_y`, `O_y` their colours (FS116-N2-STAR)" — "their" is the colours of the tips and of the outer tiles. FS116-N2-STAR lives in `plans/FS116-N2-proof.md`.
CHECK: **single tip** and **double tip** have no definition in the record. Defined in use at § 2.2 (lines 201–204, copied above): `T1` and `T2` each tip two hubs, `T3` and `T4` one. The words "double tip" / "single tip" appear in the record's theorem list (lines 24, 30, 36), in the stage-1 sentence at lines 159–162 (which says what exists, a claim, not copied), and at line 327 (copied under T4).
CHECK: **hub** is also used in the record with "(N2's)"; the definition is the same as N2's (compared above), not different.
CHECK: **Γ-free**: the statements of TIGHTLENS and STARFORCE say "whose ring carries no arc of Γ" (same words as SIX's statement); the record's header defines "Γ-free" by "no arc of `Γ` lies on it (`Γ ∩ ω(p)` finite)". The parenthetical `Γ ∩ ω(p)` finite is part of the copied clause.

## T4 — `q_k`, lens, far vertex, `R_{k,k+1}`, tight lens, lens beside a single tip, lens points

The record, the italic paragraph opening § 3 (lines 325–327):

> `q_k = y_k + y_{k+1} = √3·e(60k + 30°)`; the **lens** `L_k` is `B̄(y_k, 1) ∩ B̄(y_{k+1}, 1)` outside `B(p, 1)`, with far vertex `q_k`; `R_{k,k+1}` is the ring tile over the arc from `y_k` to `y_{k+1}`. The lenses `L_1, L_2, L_4, L_5` — beside the single tips — are the **tight lenses**

[cut at the sentence's colon, as your brief directs: the rest, "their ring tiles meet a double tip's tight edge (FS116-Y3-TIGHT).", is a claim, not part of what "tight lens" means.]

CHECK: **lens beside a single tip** has no separate definition; the only definition-like text is "The lenses `L_1, L_2, L_4, L_5` — beside the single tips —" (above), whose "beside the single tips" gloss presumably means `L_1` between `y_1, y_2`, `L_2` between `y_2, y_3`, `L_4` between `y_4, y_5`, `L_5` between `y_5, y_0`, each having `y_2` or `y_5` as one hub: that last clause is mine and unsourced; I did not copy it as a definition. Defined in use at the record line 327.
CHECK: **lens points** ("the lens points carry colour 2", STARFORCE) has no definition. Nearest text, a statement, not copied as a definition: FS116-Y3-LENS's `statement:` (record lines 409–416), "for k in {1, 2, 4, 5} and every point x close enough to q_k inside B(y_k, 1) ∩ B(y_(k+1), 1), …". Defined in use at the record lines 519–526 (STARFORCE's statement) only.
CHECK: "far vertex" is defined only as the clause "with far vertex `q_k`" above; the lattice definition of `q_k` is the first formula.

## T5 — star, generic star, boundary value, flanking direction, tight at p

The record, the same italic paragraph (lines 328–329), copied whole:

> The **star** is generic when every `δ_i` is interior to its range; a **boundary value** of `δ_i` is an endpoint of its range, and each is an edge of `p` along a flanking direction `60k ± 90°` of some hub, with that hub's tip on its side — the tip **tight at `p`** for that hub.

CHECK (your brief's second example): the clause "and each is an edge of `p` along a flanking direction `60k ± 90°` of some hub, with that hub's tip on its side" asserts that every boundary value is such an edge (a claim) and also introduces "flanking direction" and "tight at `p`". I copied the whole sentence for you to cut.

**Flanking direction**, the definition is not in the record but in `plans/FS116-N2-proof.md` (lines 16–17), the source the record's header names ("N2's"):

> for a hub `y = r(ψ)` the **flanking directions** are `ψ ± 90°` at `p`

CHECK: the record uses "flanking direction `60k ± 90°`" and "flanking directions `60k ± 90°`" without defining them; N2's definition, with `ψ = 60k` for `y_k`, gives these. This is an address outside the construction record, your call whether to freeze it.
CHECK: **star** has no separate definition in the record. Used as the tuple of the edges of `p`: "the **star** is generic when every `δ_i` …" (above); § 4.2 (line 474): "the star is exactly FS116-N2-HEX3's: `p`'s edges leave along the flanking directions `90°, 150°, 270°, 330°`" (a claim, not copied); STARFORCE's statement itself: "the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star)". In `plans/FS116-N2-proof.md` line 121 a bullet reads "**`p`'s star** (the directions of its edges against the flanking directions and the D-directions)", a recognition-list item and not a definition; I did not copy it into the definitions. Defined in use at the record lines 328–329.
CHECK: **generic star**: TIGHTLENS speaks of "its range" / "a generic star"; the only definition is "The **star** is generic when every `δ_i` is interior to its range" (copied above); "interior to its range" has no further definition (the range is T2's).
CHECK: **tight at p**: defined only inside the copied sentence (the clause "the tip **tight at `p`** for that hub"); TIGHTLENS's "the tip of one of its two hubs is tight at p for that hub" reads it. "with that hub's tip on its side" has no separate explanation in the record.

## T6 — anything else in the three statements that the record defines and § 0, § 10, § 13 of the claim list do not

Terms in the three statements and where I found them (nothing here is newly copied unless a quotation is shown):
- "non-Siamese", "simple", "valid", "(Q) arc", "Γ", "tiles", "ring", "change point", "vertex of at least four colours": `claims.md` § 0, § 13 (in § 13: "Non-Siamese: …", "Simple: § 0's; a tile's cone at a vertex is one closed interval of directions (possibly a single direction, a cusp)"). Not redefined in the record; its header says "(FS116-N1's and FS116-N2's headers, and the frozen list's § 0; nothing new is meant by it but the words marked *new*)": the only *new* word is Γ-free (T3).
- "labelled as FS116-Y3-TIPS" / "in FS116-Y3-TIPS's setting": T1 above (TIPS's `statement:` and, in it, "in FS116-Y3-SIX's setting").
- "(Q1)", "(Q2)", "(Q4)", "(Q5)": defined in TIGHTLENS's statement itself (the four conditions named in its text).
- "FS116-N2-HEX3's star": STARFORCE's statement gives the four values; the label points to `plans/FS116-N2-proof.md` § 3.1 (FS116-N2-HEX3, line 32); not copied.
- "outer colour of `y_k`", "two outer tiles, counter-clockwise 2, 3 at y_0": see T3's CHECK (outer colour); the order "counter-clockwise" at a hub has no definition in the record, defined in use at § 3.1 (line 338) "At a hub the tiles run, counter-clockwise, outer tiles – `R_{k,k+1}` – tip – `R_{k−1,k}`" — which is partly a claim and is not copied.
- "the open unit disc about each of the two neighbouring hubs", "neighbouring hubs": `y_k` and `y_{k±1}` of T2; "neighbouring" has no separate definition.
- "closed disc of radius at least √3 about a vertex p": no definition needed beyond `claims.md` § 0 "valid fragment on a disc".
- "a third absent colour survives near q_k", "k ≥ 7": these sit in *not claimed* fields.
