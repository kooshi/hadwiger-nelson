"""FS116-Z1: the close's changes to the copied entries (see fs116_z1_derivation.py). Every minds line is read from the verifier's
verification block and § 4 count; every corrected statement from the verifier's drafted wording, at the address named in its note."""

HEADER = """# FS-116 — the derivation file (the local exclusion)

*Written by the close job FS116-Z1 (Ephodos, Opus 5.5), 2026-10-03, assembled by `../tools/fs116_z1_derivation.py` from the job records' own
`derivation:` blocks, copied field by field, in the grammar of `.claude/skills/ephodos/SKILL.md` § the entry. Every id is qualified `FS116-…`; a
frozen name without the prefix (RING-GERM, SAT-STRIP, …) is filed as `FS116-<name>`, and a verifier's lemma `V4-…`, `V5-…` as `FS116-V4-…`,
`FS116-V5-…`. Every theorem FS-116 proved outside the kernel is one entry; the quotation readbacks (`FS116-*-QT`) are not mathematics and are
left in their records. A verifier's re-derivation is counted in its entry's minds, never filed twice. Grades translate as `hand` = [hand],
`derived from` = [derived], `computed over` = [tools]; verdict `derived` is TRUE, `gap:` and `stalls at:` are GAP. Minds and blindness are read
from the fence logs and commit order (`FS116-Z1-close.md` § Stage 2); every mind is Opus 5.5, one prior. **Held** means the announcement rule
(`FS116-close-inventory.md`, its top): a frozen statement, two minds, the second blind, its verdict committed first. Frozen names and the list's
sections are `../data/fs116/claims.md`'s, whose § 0 defines valid map, unit arc, (Q), (R2), fragment, Siamese, Γ, tile, ring, change point,
tactic edge, simple and saturated, § 13 the germs, hubs and semi-hubs, and § 14 the hub labels. A statement a verifier corrected is filed in its
corrected wording, the frozen one's address given beside it, and the frozen list is not edited. Arguments are addresses in the job records,
resolved from `plans/`.*

***Vacuity.** FS116-Y4-EMPTY (one mind; FS116-V6, blind, running) says the non-Siamese simple six-coloured class with a ring carrying no arc of Γ is
empty. If it is held, every entry below marked "vac." is true vacuously — its class has no member — at the count its own verifier gave; its argument
stays valid as an argument. **Nothing here moves a value**: χ(ℝ²) ∈ {5, 6, 7}, and every statement about a valid six-coloured fragment on a large
disc is about a possible object.*

*Prior art: FS-116's gate (`FS116-local-exclusion.md` § 2.3, 12 zbMATH queries, `../data/fs116/o1/zb/`) and the queries each record names. Where
an entry says "owed", no search was run for it; the successor's §PA carries the debt (inventory items 63, 99, 113, 128).*
"""

SECTIONS = [
 ("Round 1 — the opening's two claims (FS116-O1; FS116-V1 blind), and V1's frame", [("O1", "FS116-O1-YESLIM"), ("O1", "FS116-O1-SATPIN"), ("HAND", "FS116-V1-FRAME")]),
 ("Round 1 — the ring (FS116-N1; FS116-V2 blind on three)", [("N1", "FS116-N1-TWIST-D"), ("N1", "RING-TWIST-C"), ("N1", "FS116-N1-TWIST-LIT"), ("N1", "RING-GERM"),
   ("N1", "RING-Q-PRIME"), ("N1", "FS116-N1-QDISK"), ("N1", "RING-TWIST-Q"), ("N1", "RING-Q")]),
 ("Rounds 1–2 — the construction side (FS116-Y1, FS116-Y2)", [("Y1", "FS116-Y1-F15"), ("Y1", "FS116-Y1-STRIPCEIL"), ("Y1", "FS116-Y1-NOTCH"),
   ("Y2", "FS116-Y2-DCREAD"), ("Y2", "FS116-Y2-SIXFRAG"), ("Y2", "FS116-Y2-SIXOFF")]),
 ("Round 2 — the saturated class (FS116-N1's successor; FS116-V3 blind on five)", [("N1", "FS116-N1-GERM-R"), ("HAND", "FS116-V3-GERM-R-EDGE"),
   ("N1", "FS116-N1-GERM-S"), ("N1", "RING-Q-PRIME-S"), ("N1", "FS116-N1-QFREE4"), ("N1", "FS116-N1-TOUCH"), ("N1", "FS116-N1-ECHO"),
   ("HAND", "FS116-V3-ECHO-ONLY"), ("N1", "FS116-N1-AXIS"), ("N1", "FS116-N1-F15TOUCH"), ("N1", "SAT-QFREE")]),
 ("Round 3 — the transfer rule (FS116-N2; no blind check)", [("N2", "FS116-N2-SIXRING"), ("N2", "FS116-N2-FIVERING"), ("N2", "FS116-N2-STAR"),
   ("N2", "FS116-N2-RECIP"), ("N2", "FS116-N2-ANTI"), ("N2", "FS116-N2-HEX6"), ("N2", "FS116-N2-HEX3"), ("N2", "RING-TRANSFER-C")]),
 ("Round 3 — SAT-STRIP from both sides (FS116-S1; FS116-V4 blind on three)", [("S1", "FS116-S1-KAPPA"), ("S1", "FS116-S1-PAIR"), ("S1", "FS116-S1-CLUSTER"),
   ("S1", "FS116-S1-RUNG"), ("S1", "FS116-S1-LENS"), ("S1", "FS116-S1-EXIT"), ("S1", "FS116-S1-QF"), ("V4", "V4-CHORD"), ("V4", "V4-DICHOTOMY"),
   ("V4", "V4-MEET"), ("V4", "V4-TWIST"), ("V4", "V4-PARTNER"), ("V4", "V4-OUTER"), ("S1", "SAT-STRIP"), ("S1", "Y-SAT")]),
 ("Round 3 — the Γ-free hub (FS116-Y3; FS116-V5 blind on five)", [("Y3", "FS116-Y3-SIX"), ("Y3", "FS116-Y3-TIPS"), ("Y3", "FS116-Y3-HUBCOL"),
   ("Y3", "FS116-Y3-TIGHT"), ("Y3", "FS116-Y3-NOQ"), ("Y3", "FS116-Y3-LENS"), ("Y3", "FS116-Y3-TIGHTLENS"), ("Y3", "FS116-Y3-NBTIP"),
   ("Y3", "FS116-Y3-STARFORCE"), ("V5", "V5-NE1"), ("V5", "V5-RING"), ("V5", "V5-GERM"), ("V5", "V5-OUT"), ("V5", "V5-TIPSET"), ("V5", "V5-LENS")]),
 ("Round 4 — the semi-hub rule (FS116-N3; FS116-V5 blind on three)", [("N3", "FS116-N3-CONE"), ("N3", "FS116-N3-PAIR"), ("N3", "FS116-N3-STAR2"),
   ("N3", "FS116-N3-SEMI"), ("N3", "FS116-N3-CROSS"), ("N3", "RING-TRANSFER-QC"), ("V5", "V5-QCOL"), ("V5", "V5-U1"), ("V5", "V5-OUT2"),
   ("V5", "V5-DICHO"), ("HAND", "FS116-V5-CROSS-S"), ("N3", "SEMI-PAR3"), ("N3", "RING-TRANSFER-Q")]),
 ("Round 4 — the Γ-free type is empty (FS116-Y4; FS116-V6 blind, running)", [("Y4", "FS116-Y4-SYM"), ("Y4", "FS116-Y4-SPOKE"), ("Y4", "FS116-Y4-Q1"),
   ("Y4", "FS116-Y4-FLANK"), ("Y4", "FS116-Y4-EMPTY"), ("Y4", "FS116-Y4-OBST")]),
 ("The close's case list (FS116-Z1)", [("HAND", "FS116-C114-LOCAL-F")]),
]

HAND = {
 "FS116-V1-FRAME": [
  ("statement", "at a degree-4 vertex p of four colours, every tile at p with a cone of positive angle, of a non-Siamese simple valid fragment on an open set containing B̄(p, 1) whose ring ω(p) carries no arc of Γ, the ring has exactly six change points, 60° apart, and the centre of every tactic edge at p is a change point of the ring"),
  ("uses only", "V1's F0 (two tiles of one colour are all closer than 1 or all farther; a tile has diameter at most 1), F1–F3 (off Γ the ring lies in tiles of the two absent colours, swapped by the rotation σ; the four regions at a change point cut by ω(σy) and ω(σ⁻¹y)) and F4 (the inward region lies in tiles of p reaching y); non-Siamese at F4–F6, simple at F6, six colours at F3"),
  ("not claimed", "anything with Siamese pairs or non-simple tiles; anything at k ≥ 7; that any such vertex exists (FS116-Y4-EMPTY excludes the class at six colours, one mind)"),
  ("argument", "FS116-V1-verification.md § 3.1 The frame (my route) — setting N"),
  ("verdict", "derived"), ("grade", "hand"), ("minds", "1"),
  ("model", "none at six colours; V1 read the frame's colour-level conditions by hand on OC, the (1, 2, 1, 2) pinwheel, +++ and the γ = 0° lens (V1 § 3.2), which are patterns, not fragments"),
  ("prior art", "partly: FS114-N6-RING60 (six change points after the bends) and FS114-N7-TAC (tactic centres at change points), one mind each; F5 is a second route to the count over non-Siamese (V1 § 4.3 row 4)"),
  ("handoff", "none — in its class FS116-Y4-EMPTY, if held, leaves it vacuous; it carries N7-HUB's second mind to FS-114's filing (part 2)")],
 "FS116-V3-GERM-R-EDGE": [
  ("statement", "FS116-N1-GERM-R's open intervals cannot be closed: at each end of the interval of v⁻ and of v⁺ (and, by the reflection, of u⁻ and u⁺), two tiles of one colour, given by formula about p = 0, y = (1, 0), have no two points at distance exactly 1 while one holds the germ in its closure and the other approaches y exactly along the end direction"),
  ("uses only", "the four tile pairs of V3 § 2.3 item 3 (a box about r(−60°) outside or inside ω(p), and a horn or a crescent at y along ψ + 150° or ψ + 330°), each with a hand bound on |z − a|² − 1 of one sign over the pair"),
  ("not claimed", "anything about colourings beyond the pair of tiles (it shows the not-claimed line of GERM-R is needed, not that any fragment realises it); anything at u± beyond the reflection"),
  ("argument", "FS116-V3-verification.md § 2.3 Attack on GERM-R"),
  ("verdict", "derived"), ("grade", "hand"), ("minds", "1"),
  ("model", "the four pairs themselves; `../tools/fs116_v3_boundary.py` samples the bounds (a check of the bound, not a proof)"),
  ("prior art", "partly: FS116-N1-GERM-R's not-claimed line names the boundary directions; that they are sharp is V3's"),
  ("handoff", "none — a sharpness statement about GERM-R's intervals; it travels as GERM-R's model line")],
 "FS116-V3-ECHO-ONLY": [
  ("statement", "in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; then every point of ω(w) in the closure of a tile of colour X is 2w − p"),
  ("uses only", "N-E1; a straddle against the ring tile on the side fixed by the sign of η·sin(θ − ψ); that X is absent at p"),
  ("not claimed", "that 2w − p carries X (that needs saturation at w, FS116-N1-ECHO in reading (B)); anything about other colours on ω(w)"),
  ("argument", "FS116-V3-verification.md § 3.3 ECHO — derived under reading (B), refuted under reading (A); MISSTATED"),
  ("verdict", "derived"), ("grade", "hand"), ("minds", "1"),
  ("model", "the hexagonal seven-colouring of circumradius 0.45 with w inside an X-hexagon (V3's reading-(A) object): ω(w) meets no X-tile at all, and the statement holds with nothing at 2w − p"),
  ("prior art", "partly: FS116-N1-ECHO's argument reaches the same support bound by a derivative (V3 § 4.2, ECHO row 2)"),
  ("handoff", "none — a relay-lemma under FS116-N1-ECHO; it crosses to Lean with it")],
 "FS116-V5-CROSS-S": [
  ("statement", "in FS116-N3-CROSS's setting (y = r(ψ) a crossed full semi-hub of kind O of p's ring in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours), no tile of p has y in its closure; and if y has four colours and no edge of p runs along ω(y) at p, then both germs of p's tip pair in y's ring lie on (Q) arcs of y's ring and at most one germ of its outer pair does, so p is a full semi-hub of kind O of y's ring or a closed change point of it"),
  ("uses only", "FS116-V5-U1's cones at p; FS116-V5-QCOL; FS116-V5-OUT2 at y, at v and at u; N-E1; non-Siamese; that an arc of ω(y) whose side colours are both carried at a four-colour y is a (Q) arc"),
  ("not claimed", "that p is a semi-hub of y's ring rather than a closed change point (that is FS116-N3-CROSS's last clause, closed by FS114-N7-QOPP at y); that y has four colours; anything at k ≥ 7"),
  ("argument", "FS116-V5-verification.md § 3.4 CROSS — derivation, and where it stops"),
  ("verdict", "derived"), ("grade", "derived from: FS116-V5-U1, FS116-V5-QCOL, FS116-V5-OUT2"), ("minds", "1"),
  ("model", "the strip's P₀ at its change point P₂ (FS116-N3-CROSS's model: P₀ is a crossed full semi-hub of kind O of P₂'s ring)"),
  ("prior art", "partly: FS116-N3-CROSS (one mind on its last clause) and FS116-N2-RECIP (its hub form)"),
  ("handoff", "none — strengthens CROSS's first clause (it holds vacuously) and its reciprocity to a full semi-hub; it travels with CROSS")],
 "FS116-C114-LOCAL-F": [
  ("statement", "there is a radius R — one R for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius R about a vertex of at least four colours"),
  ("argument", "FS116-Z1-close.md § 2.6 C114-LOCAL-F's case list, as the records leave it (non-Siamese simple fragments unless said)"),
  ("verdict", "gap: the ring types left without an exclusion — a (Q)-free ring carrying (R2) arcs after the bends, a full parallel semi-hub of three colours (FS116-SEMI-PAR3), a closed change point (FS116-RING-Q's gap; any exclusion on B̄(p, 2) reads the far side of p, FS116-Y2-DCREAD), five- and six-colour vertices beyond FS116-Y2-SIXOFF's family, and the Siamese and non-simple classes; the Γ-free type is excluded at radius 1 + ε (FS116-Y4-EMPTY, one mind) and the saturated right-angled straight cross in the (Q)-free non-Siamese class at R = 2 (FS116-S1-QF)")],
}

B = "the same model (Opus 5.5), one prior"
MINDS = {
 "FS116-O1-YESLIM": f"2 — blind to: the first derivation until V1's verdicts were committed (3daaa05c); method: the Rajchman step by a compact operator and the rounding by a least index (V1 § 4.1 rows 1–2), against dominated convergence and the support rounding; {B}",
 "FS116-O1-SATPIN": f"2 — blind to: the first derivation until 3daaa05c, not to FS111-M-PINCH's case split, which both routes use (item 31's ruling); method: V1's L1–L4, a connected-product interval per contact, the last clause through the edges, against saturation at p (V1 § 4.2); {B}",
 "FS116-RING-TWIST-C": f"2 — blind to: N1's argument until V2's verdicts (81bfc5cb); method: the same route in substance (V2 § 4.2); {B}",
 "FS116-N1-TWIST-LIT": f"2 — blind to: N1's argument until 81bfc5cb; method: the same slit (V2 § 4.3); {B}",
 "FS116-RING-GERM": f"2 — blind to: N1's argument until 81bfc5cb, given N7-HUB's one-line sketch in the list's § 8 (item 49's caveat); method: colour exclusion at the tiles in the cones (V2) against tile identification (N1), V2 § 4.1 row 1; {B}",
 "FS116-N1-GERM-R": f"2 — blind to: N1's record until V3's verdicts (7245b6eb); method: a straddle on T′ × T in two regimes against the monotone ring point (V3 § 4.2); {B}",
 "FS116-N1-GERM-S": f"2 — blind to: N1's record until 7245b6eb, given N7-HUB's sketch in § 8 (V3's own caveat: a reader who counts it as given may count one); method: N-E2 against the interval argument, one fact under two names; {B}",
 "FS116-N1-TOUCH": f"2 — blind to: N1's record until 7245b6eb; method: the same three steps (a second mind on the information axis only, V3 § 4.2); {B}",
 "FS116-N1-ECHO": f"2 — on the corrected statement (reading B); blind to: N1's record until 7245b6eb; method: FS116-V3-ECHO-ONLY by a straddle against N1's derivative argument; {B}",
 "FS116-N1-AXIS": f"2 — blind to: N1's record until 7245b6eb; method: N-E2 for (a) and saturation's definition for (b), so V3's (b) does not rest on SATPIN (V3 § 4.2); {B}",
 "FS116-S1-KAPPA": f"2 — blind to: S1's record until V4's verdicts (48534b7c), told by its brief that a decided result rests on it (items 107, 108); method: three ring points and FS116-V4-DICHOTOMY against N-E1 at w (V4, Divergences on KAPPA row 1); {B}",
 "FS116-S1-RUNG": f"2 — blind to: S1's record until 48534b7c, with item 108's caveat; method: FS116-V4-PARTNER (saturation at the edge point) against SATPIN's tangent clause, FS116-V4-MEET against CLUSTER; {B}",
 "FS116-S1-QF": "1 — and a second derivation by a different route (FS116-V4 § 2.4: the rung tiles cross in the crescent B(q, 1) ∖ B̄(p, 1), by Jordan), whose brief told it the first's verdict (item 107), so it is not counted as a blind second mind (items 108, 115); a blind second mind is owed",
 "FS116-Y3-SIX": f"2 — blind to: Y3's record until V5's verdicts (320a3b53); method: FS116-V5-RING (non-Siamese against a tile's 60° reach; no simplicity) against Y3's tip count; {B}",
 "FS116-Y3-TIPS": f"2 — blind to: Y3's record until 320a3b53; method: the same argument (V5 § 4.1); {B}",
 "FS116-Y3-NBTIP": "1 — and a checking reading by FS116-V5 (blind to Y3's record until 320a3b53, but its route and conclusion were N7-HUB's outline in the list's § 8)",
 "FS116-Y3-TIGHTLENS": f"2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS (the lens corner at the far vertex) against Y3's NOQ and TIGHT straddles; {B}",
 "FS116-Y3-STARFORCE": f"2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS with its images under the reflection at 30° and the half-turn, against Y3 § 3.2 rerun with NBTIP; {B}",
 "FS116-N3-SEMI": f"2 — blind to: N3's record until V5's verdicts (3647075d); method: FS116-V5-U1 for the centre's four colours and FS116-V5-DICHO for crossed-or-parallel, against FS112-N3-NOBOTH and FS114-N7-QOPP (V5 § 4.1); {B}",
 "FS116-N3-PAIR": f"2 — blind to: N3's record until 3647075d; method: the same route; {B}",
 "FS116-N3-CROSS": f"2 — on every clause but the last; blind to: N3's record until 3647075d; method: FS116-V5-U1's cones at p (V5 § 3.4); {B}; the last clause 1 and a checking reading (V5's blind verdict was GAP there, its stall closed after reading by N3's step through FS114-N7-QOPP at y, re-derived by V5-U1)",
 "FS116-Y4-EMPTY": "1 — a blind second mind running (FS116-V6, the list's § 15)",
}

SUBS = {
 "FS116-O1-SATPIN": [("each edge e at p, with side colours", "each edge e at p (a boundary arc between tiles of two different colours), with side colours"),
                     ("of exactly one of two types", "of at least one of two types")],
 "FS116-RING-GERM": [("let y be a change point of the ring,", "let y be a change point of the ring (the ring off Γ on both sides of y),")],
 "FS116-RING-TWIST-C": [("every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides", "every edge on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides"),
                        ("lies on an arc of Γ on ω(p) with one colour on both sides", "lies on an edge on ω(p) with one colour on both sides")],
 "FS116-N1-ECHO": [("if the fragment is saturated at w and X is in w's essential multicolour", "if w is an essential boundary point at which the fragment is saturated (each colour of P(w) has a point of its support at distance exactly 1 from w) and X is in w's essential multicolour")],
 "FS116-S1-KAPPA": [("tiles of exactly one colour absent at p", "tiles of exactly one of the two colours absent at p"),
                    ("in a non-Siamese fragment the change points are exactly", "in a non-Siamese fragment κ's change points are exactly")],
}

FIELD = {
 ("FS116-N1-TWIST-LIT", "grade"): "hand",
 ("FS116-Y3-NBTIP", "converse"): "one-way — \"the only outer colour of y_2 is 4\" names the outer colours of two hubs; it characterizes nothing",
 ("FS116-N1-TWIST-LIT", "uses only"): "the slit: an arc of ω(p) from a change point into the tile on one side, added to Γ, leaves the fragment valid, the vertex p and the set D unchanged, and removes that change point and no other; nothing else (RING-TWIST-C, which the first entry listed, is not consumed: V2 § 4.3 row 2)",
 ("FS116-RING-GERM", "uses only"): "FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; CL and N3-FACE (non-Siamese) for (i) and (iii) only — (ii) holds without them (V2-RG-THIN, V2 § 4.1 row 2); that a tile has diameter at most 1; six colours, spent at Step 1 and in the cone step (V2 § 4.1 row 3)",
 ("FS116-N1-GERM-R", "model"): "F(1/5) at q_N (FS116-Y1-F15): the germs at 30° and 150° carry G, and no G-tile holds q_N; the ends are sharp: four one-colour tile pairs by formula realise the boundary directions ψ + 150°, ψ + 330° at v⁻ and ψ + 150°, ψ − 30° at v⁺ (FS116-V3-GERM-R-EDGE)",
 ("FS116-N1-AXIS", "uses only"): "N-E1 on the dip of ω(z) below p through the four tiles (a); FS116-O1-SATPIN in its corrected wording (two minds) at the four edges near p (b); GERM-S's interval argument on a (Q) arc's side tiles and FS116-N1-GERM-R (c); FS116-N1-GERM-R and six colours (d); (a) and (d) use no saturation (FS116-V3 § 3.6: the strip satisfies both)",
 ("FS116-N1-TOUCH", "uses only"): "FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs, whose four open intervals cover every direction; six colours, spent once; w ∈ D is used only to place w on Γ — the conclusions hold at every point of ω(p) off the arcs of Γ on ω(p), not a change point, with its four germs off (Q) arcs (V3 § 4.4)",
}

V = "vac. —"
NOTE = {
 "FS116-O1-YESLIM": "Frozen at § 3. TRUE, **held** (item 31). A thin truth: the map structure is idle beyond a null boundary, and the `k = 6` clause holds for every `k` straight from the fragments with no limit (V1 § 2.1–2.2).",
 "FS116-O1-SATPIN": "Frozen at § 3 with \"each edge e at p, with side colours\" and \"of exactly one of two types\": **MISSTATED** in those two words (an edge with `a = b` is of neither type, a monster; exclusivity is not carried), TRUE in the author's readings S1, S2 (V1 § 1.6, § 2.3), and filed here in V1's corrected wording; **held** (item 31). A thin truth: four colours and positive cones are idle, and it holds at every vertex of at least two colours in the saturated disc, cusps included (R7).",
 "FS116-V1-FRAME": f"{V} its class lies inside FS116-Y4-EMPTY's. V1's second route to the six change points and the tactic centres (F5, F6), derived blind beside N7-HUB (b), (c), which now stand at two minds in FS-114's filing (part 2).",
 "FS116-N1-TWIST-D": "Not frozen; its four-colour case is FS116-RING-TWIST-C's first clause, re-derived blind by V2.",
 "FS116-RING-TWIST-C": "Frozen at § 10. TRUE under reading L of \"change point\" (the ring off Γ on both sides) with \"arc of Γ on ω(p)\" read as an edge, and filed in V2's wording, \"edge\" in the two clauses that need it (V2 § 4.2 row 3); **held** (item 49). It replaces RING-TWIST (§ 5), MISSTATED: the parity counts colour changes, not change points (FS116-N1-TWIST-LIT shows the gap); RING-TWIST's frozen not-claimed line (\"the parity fails: R7's lattice points\") is vacuous there, not failing (item 38). The qualifying window has no held model (V2-STRIP-D: every D-free arc of the strip is at most 60°).",
 "FS116-N1-TWIST-LIT": "Frozen at § 10. TRUE under readings L and G; **held** (item 49). Filed with grade `hand` and the uses-only V2 found (item 51). V2-TL-NS (one mind): the \"only if\" holds inside the non-Siamese class, the slit keeping non-Siamese — simplicity, not non-Siamese, is what the parity needs.",
 "FS116-RING-GERM": "Frozen at § 10. TRUE under reading L, filed with \"the ring off Γ on both sides of y\" written in (item 50); under reading G FALSE by the strip's apex `(1/4, √15/4)` of `P₀`'s ring (V2-RG-G, a monster the author's reading settles); **held** with item 49's caveat. Its uses-only corrected (item 51): (0a), (0b) and (ii) hold Siamese pairs allowed (V2-RG-THIN, one mind; FS116-N1-GERM-S is the Siamese form of the whole).",
 "FS116-RING-Q-PRIME": "Frozen at § 5 as RING-Q′; TRUE as posed (closed (Q) arcs). The rung FS-121 takes (inventory item 41).",
 "FS116-N1-QDISK": "A statement about one held object, exact at the change point and its ±60° points, the class read in floats.",
 "FS116-RING-TWIST-Q": "Ties the parity's window to the (Q) arcs.",
 "FS116-RING-Q": "Frozen at § 5 (card `what-do-q-rings-force`). GAP; its qualifier \"that lies on no (Q) arc\" is empty under § 0's change point (item 38, harmless). P3 (RING-Q holds, 0.45) is not decided as posed.",
 "FS116-Y1-F15": "Exact, by formula; the certifier's controls accept SQ9 and R7 first (Y1's control `fs116-y1-satcert`).",
 "FS116-Y1-STRIPCEIL": "The strip family cannot decide SAT-STRIP at `r = 1`; FS116-S1-RUNG contains it as the case `w = r(120°)`.",
 "FS116-Y1-NOTCH": "A relay-result for the construction side; Y-QRING not landed (P2 met).",
 "FS116-Y2-DCREAD": "Scopes FS116-RING-Q's missing step.",
 "FS116-Y2-SIXFRAG": "The first exact valid non-Siamese fragment about a six-colour vertex held here; a ring type the plan omitted (item 61).",
 "FS116-Y2-SIXOFF": "One family of the six-colour type; the type's exclusion is open.",
 "FS116-N1-GERM-R": "Frozen at § 11. TRUE; its open intervals are sharp (FS116-V3-GERM-R-EDGE), and \"above 1\" may be \"1\" (V3 § 4.2); **held** (item 76).",
 "FS116-V3-GERM-R-EDGE": "V3's finding, one mind: GERM-R's not-claimed line is the statement's edge, not caution.",
 "FS116-N1-GERM-S": "Frozen at § 11. TRUE; **held** (item 76), with V3's own caveat on N7-HUB's sketch.",
 "FS116-RING-Q-PRIME-S": "RING-Q′ in the Siamese and non-simple class.",
 "FS116-N1-QFREE4": "Its Γ-free, non-Siamese case was re-derived blind inside FS116-V5-RING (step 3); as stated (Siamese allowed, (Q)-free) one mind.",
 "FS116-N1-TOUCH": "Frozen at § 11. TRUE; the hypothesis \"w in the closure of a tile of one of p's colours\" is idle (a thin truth; V3's note in the uses-only line); **held** (item 76).",
 "FS116-N1-ECHO": "Frozen at § 11 with \"if the fragment is saturated at w and X is in w's essential multicolour\": **MISSTATED** — under reading (A) (saturation at `w` vacuous off the essential boundary) FALSE by the hexagonal seven-colouring with `w` inside an `X`-hexagon (V3-ECHO-A, control `v3-echo-a` below), TRUE under (B); filed in V3's corrected wording (V3 § 4.4, items 65, 77); **held in (B)** (item 76).",
 "FS116-V3-ECHO-ONLY": "V3's relay-lemma, one mind; sharper with ECHO: `ω(w) ∩ supp S_X ⊆ {2w − p}` always, and saturation at `w` for `X` makes it `{2w − p}`.",
 "FS116-N1-AXIS": "Frozen at § 11. TRUE; (a) and (d) need no saturation (V3-AXIS-STRIP, tools at named points: the unsaturated strip meets (a), (c), (d) and fails (b); SQ9 at `k = 9` fails (d)); **held** (item 76).",
 "FS116-N1-F15TOUCH": "With FS116-N1-TOUCH, the touch point SAT-QFREE stalls at, realised where the ring carries (Q) arcs.",
 "FS116-SAT-QFREE": "Frozen at § 4. GAP (one mind).",
 "FS116-N2-SIXRING": "No blind check ran (item 69).",
 "FS116-N2-FIVERING": "No blind check ran.",
 "FS116-N2-STAR": "No blind check ran; owed (item 69).",
 "FS116-N2-RECIP": "No blind check ran; owed. Not vacuous by FS116-Y4-EMPTY: its `p` need not have a Γ-free ring (item 124).",
 "FS116-N2-ANTI": "No blind check ran; owed.",
 "FS116-N2-HEX6": f"{V} its class is FS116-Y4-EMPTY's (item 124). No blind check ran.",
 "FS116-N2-HEX3": f"{V} as HEX6.",
 "FS116-RING-TRANSFER-C": "RING-TRANSFER (§ 5) is **MISSTATED** (its input too small: the rule reads `p`'s star; its output too large: each placed ring's 240° arc outside `B̄(p, 1)` is unread; N2 § 3.3); this is its corrected form, one mind, its last clause (\"a ring free of arcs of Γ has …\") vac. by FS116-Y4-EMPTY (item 124).",
 "FS116-S1-KAPPA": "Frozen at § 12 with \"tiles of exactly one colour absent at p\" and \"the change points are exactly\": TRUE in the ruled reading (B) with κ's change points (item 103); filed in V4's corrected wording (V4, Divergences on KAPPA rows 3–4; item 109). Under § 10's ring change points the last clause is GAP at whether an orbit point can end an arc of Γ on ω(p). Two minds, blind, with item 108's caveat.",
 "FS116-S1-PAIR": "One mind (not frozen).",
 "FS116-S1-CLUSTER": "One mind; V4 reached the same mechanism as FS116-V4-MEET.",
 "FS116-S1-RUNG": "Frozen at § 12. TRUE, Siamese pairs allowed; a thin truth (its main clause needs neither degree 4, nor four colours, nor the other three edges; V4 § Attack on RUNG); two minds, blind, with item 108's caveat.",
 "FS116-S1-LENS": "One mind.",
 "FS116-S1-EXIT": "One mind; its identities exact (control `exit-identities`).",
 "FS116-S1-QF": "Frozen at § 12. TRUE; **not held** (items 108, 115): V4's derivation is a second route, but its brief gave QF's verdict. V4's route shows saturation is needed only at the points of `p`'s four edges.",
 "FS116-V4-CHORD": "V4's lemma, one mind; prior art owed (item 113).",
 "FS116-V4-DICHOTOMY": "V4's lemma, one mind; it is FS116-V1-FRAME's F0 and FS116-V5-NE1 in another form.",
 "FS116-V4-MEET": "V4's lemma, one mind.",
 "FS116-V4-TWIST": "V4's lemma, one mind.",
 "FS116-V4-PARTNER": "V4's lemma, one mind: SATPIN's tangent clause for segment edges, with none of SATPIN's hypotheses on `p`.",
 "FS116-V4-OUTER": "V4's lemma, one mind.",
 "FS116-SAT-STRIP": "Frozen at § 4. GAP — first at the right-angled cross's axis structure (FS116-N1-proof.md § 4.3, one mind), then narrowed by S1 to G1–G3 (this block, S1 § 2.5). P1 (SAT-STRIP TRUE, 0.55) is not scored.",
 "FS116-Y-SAT": "Frozen at § 7; its parenthetical (\"the capped strip made saturated at its midline, which decides SAT-STRIP from the other side\") cannot hold (FS116-Y1-STRIPCEIL) and is read as \"a geometry differing from the strip inside the unit disc, saturated on `B̄(p, 1)`\" (item 45). No construction (Y1, Y2, S1).",
 "FS116-Y3-SIX": f"{V} Frozen at § 14. TRUE; \"simple\" idle on V5's route (a thin truth); **held** (item 118).",
 "FS116-Y3-TIPS": f"{V} Frozen at § 14. TRUE; **held** (item 118).",
 "FS116-Y3-HUBCOL": f"{V} One mind.",
 "FS116-Y3-TIGHT": f"{V} One mind. Y4's look-back: it stated both flank edges and used each only against a far lens vertex (item 127).",
 "FS116-Y3-NOQ": f"{V} One mind.",
 "FS116-Y3-LENS": f"{V} One mind.",
 "FS116-Y3-TIGHTLENS": f"{V} Frozen at § 12. TRUE; a thin truth: each of (Q1)–(Q5) holds by its first disjunct alone, so the statement is weaker than its hypotheses give (both minds; item 120); **held** (item 118).",
 "FS116-Y3-NBTIP": f"{V} Frozen at § 12. TRUE; one mind and a checking reading (item 118); its blind second mind is owed.",
 "FS116-Y3-STARFORCE": f"{V} Frozen at § 12. TRUE under the two readings both minds used (item 120), written here: **\"near q_k the lens points carry colour c\"** — every point of the lens `L_k` close enough to its far vertex `q_k` lies in a tile of colour `c` or on Γ (V5's R-LENSPT); **\"counter-clockwise 2, 3 at y_0\"** — turning counter-clockwise about `y_0` through its outer tiles, from the ring tile on the clockwise side of `y_0` toward the one on the counter-clockwise side, the tile of colour 2 comes first and of colour 3 second (V5's R-ORDER); under the reverse order the order clause is FALSE at all four hubs. **Held** (item 118).",
 "FS116-V5-NE1": "V5's lemma, one mind; known (N-E1).",
 "FS116-V5-RING": "V5's lemma, one mind. Not vacuous by EMPTY (its setting drops \"simple\").",
 "FS116-V5-GERM": "V5's lemma, one mind; not vacuous by EMPTY.",
 "FS116-V5-OUT": "V5's lemma, one mind.",
 "FS116-V5-TIPSET": "V5's lemma, one mind; not vacuous by EMPTY.",
 "FS116-V5-LENS": f"{V} V5's lemma, one mind: at radius √3 each lens beside a single tip forces its double-tip hub's tip tight at `p`, giving HEX3's star directly.",
 "FS116-N3-CONE": "One mind (item 95: its statement was written during the derivation, and is not frozen).",
 "FS116-N3-PAIR": "Frozen at § 13. TRUE; \"simple\" idle (a thin truth); **held** (item 118).",
 "FS116-N3-STAR2": "One mind (item 95).",
 "FS116-N3-SEMI": "Frozen at § 13. TRUE; **held** (item 118). Its crossed-or-parallel dichotomy, given in § 13's notation through FS114-N7-QOPP (one mind, degree 4), was checked by V5 for every degree (FS116-V5-DICHO).",
 "FS116-N3-CROSS": "Frozen at § 13. TRUE; **held on every clause but the last** (item 118); the last clause one mind and a checking reading, its blind second mind owed. A thin truth: the first clause holds vacuously (no tile of `p` has `y` in its closure, FS116-V5-CROSS-S), and the hypotheses \"every tile at y a cone of positive angle\" and \"radius above 2\" are unused in every clause V5 derived (item 120).",
 "FS116-RING-TRANSFER-QC": "One mind; the semi-hub rule in round 3's corrected form (input: `p`'s ring with its (Q) arcs' colours and `p`'s star).",
 "FS116-V5-QCOL": "V5's lemma, one mind.",
 "FS116-V5-U1": "V5's lemma, one mind; known (FS112-U1).",
 "FS116-V5-OUT2": "V5's lemma, one mind.",
 "FS116-V5-DICHO": "V5's lemma, one mind: the check § 13's note asked for, without FS114-N7-QOPP.",
 "FS116-V5-CROSS-S": "V5's strengthening of CROSS (item 119), one mind.",
 "FS116-SEMI-PAR3": "GAP (one mind); the construction side's matching target is the bowtie with its tip at `top` removed (item 96).",
 "FS116-RING-TRANSFER-Q": "GAP, N2's \"a placing rule at semi-hubs\" (FS116-N2-proof.md § 3.2) narrowed by N3 to three places.",
 "FS116-Y4-SYM": f"{V} One mind; a bookkeeping lemma.",
 "FS116-Y4-SPOKE": f"{V} One mind.",
 "FS116-Y4-Q1": f"{V} One mind.",
 "FS116-Y4-FLANK": "One mind (item 123: stated after its author had found the route); colour-free, Siamese pairs allowed. G83's straddle along two unit circles.",
 "FS116-Y4-EMPTY": "Frozen at § 15 with the parenthetical of its not-claimed line withheld for blindness; the line is filed whole here. **One mind; FS116-V6 runs blind on it** — part 2 folds V6's verdict in here and in every \"vac.\" note. It removes the Γ-free ring type from C114-LOCAL-F's case list at radius `1 + ε` in the non-Siamese simple class; round 3 and FS116-N2 had worked that class as possible (a G21 instance, item 124).",
 "FS116-Y4-OBST": "The brief's target answered at every radius above 1; FS116-Y4-FRAG (a fragment of the HEX3 class above radius 2) is FALSE by it.",
 "FS116-C114-LOCAL-F": "Frozen at § 1 and § 6. The milestone's question, filed as GAP at its named cases; the stub's existence form was never worked as a whole, its structural form carried the rounds (`FS116-Z1-close.md` § 2.5).",
}

EXTRA = {
 "FS116-O1-YESLIM": "the YES side of C114-LOCAL-F (fragments on every disc give χ(ℝ²) ≤ 6 with no MR)",
 "FS116-RING-Q-PRIME": "FS-121's ring rung (FS-121 inventory item 8)",
 "FS116-Y4-EMPTY": "the vacuity of every entry marked vac.; FS116-C114-LOCAL-F's Γ-free case",
 "FS116-S1-QF": "FS116-C114-LOCAL-F's saturated-cross case; FS116-SAT-STRIP's narrowing",
 "FS116-SEMI-PAR3": "FS116-C114-LOCAL-F; the successor stub",
 "FS116-RING-Q": "FS116-C114-LOCAL-F; the successor stub",
 "FS116-RING-TRANSFER-QC": "FS116-C114-LOCAL-F's (Q)-ring case",
 "FS116-N2-SIXRING": "FS116-C114-LOCAL-F's six-colour case",
 "FS116-N2-FIVERING": "FS116-C114-LOCAL-F's five-colour case",
 "FS116-C114-LOCAL-F": "the successor stubs (FS-123–FS-125)",
}

CONTROLS = {
 "FS116-N1-QDISK": [("N1", "disk-two-colour", "FS116-N1-QDISK")],
 "FS116-N1-ECHO": [("V3", "v3-echo-a", "FS116-N1-ECHO")],
 "FS116-N1-AXIS": [("N1", "axis-touch-f15", "FS116-N1-AXIS")],
 "FS116-Y1-F15": [("Y1", "fs116-y1-f15", "FS116-Y1-F15")],
 "FS116-Y2-SIXFRAG": [("Y2", "fs116-y2-sixfrag", "FS116-Y2-SIXFRAG")],
 "FS116-S1-RUNG": [("S1", "rung-ceil", "FS116-S1-RUNG")],
 "FS116-S1-EXIT": [("S1", "exit-identities", "FS116-S1-EXIT")],
 "FS116-Y3-STARFORCE": [("Y3", "fs116-y3-star", "FS116-Y3-STARFORCE")],
 "FS116-N3-SEMI": [("N3", "fs116-n3-semi", "FS116-N3-SEMI")],
 "FS116-Y4-FLANK": [("Y4", "fs116-y4-flank", "FS116-Y4-FLANK")],
 "FS116-Y4-EMPTY": [("Y4", "fs116-y4-flank-seven", "FS116-Y4-EMPTY")],
}

for _n in ("CHORD", "DICHOTOMY", "MEET", "TWIST", "PARTNER", "OUTER"):
    EXTRA.setdefault(f"FS116-V4-{_n}", "FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds)")
for _n in ("NE1", "RING", "GERM", "OUT", "TIPSET", "LENS"):
    EXTRA.setdefault(f"FS116-V5-{_n}", "FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE")
for _n in ("QCOL", "U1", "OUT2", "DICHO"):
    EXTRA.setdefault(f"FS116-V5-{_n}", "FS116-V5's second derivations of FS116-N3-SEMI, -PAIR and -CROSS")
