import json
S=json.load(open('data/fs129/or1/steps.json'))
def step(j): return S[j]['step']
out=[]
A=out.append
A("\n## Stage 3 — SAVED: J2–J10\n")
A("### J2 — FS-124, case 1: SEMI-PAR3\n")
A("**The step** (as `data/fs129/demand-judged.md` J2 quotes it, verbatim): "+step('J2')+"\n")
A("""**Kind of input** (written first): an invariant of the colouring of the ring of `y`, a vertex of exactly three colours — its winding (height),
read on a ring free of arcs of `Γ`. § 2 check: G73 excludes cell-local topological certificates on lattice graphs at four colours; a winding on one
circle about one vertex is not that. Admissible.

**Read for it**: FS116-N3-SEMI, -RING-TRANSFER-QC, -N3-STAR2, -N3-PAIR, -V5-DICHO, -V4-TWIST, -V5-U1, -V6-HUG; FS112-N3-NOBOTH; FS110-N2-RING,
-Y3-GP, -N2-ROT, -N2-TRANS, -FLIP; FS112-ROTHEX; FS114-Y2-BOWTIE (the model the step names); FS129-OR1-BENDFRAG (stage 2).

**Verdict: shortened, not closed** (composition FS129-OR1-BEND3). The GAP asks a proof to read `y`'s own ring. That reading can start from a ring free
of arcs of `Γ`: at a vertex of exactly three colours in the non-Siamese simple class no arc of `Γ` on its ring has both side colours at the vertex, so
stage 2's bends run there too (FS129-OR1-BEND3), on a fragment of radius below `√3` about `y` that keeps `y`'s colours and every tile at `p`
(`|p − y| = 1`, so `p`'s tiles meet `B(y, ρ)`). The ring is then exactly the object of **FS110-N2-RING** and **FS110-Y3-GP** (two minds each): "a
three-colour vertex whose unit circle carries no arc of `Γ`" — **FS-110's winding `W` is the height Poros's hunch sought from lane A (G71), held in
lane R under FS-110's name** (Condition-5 era, so never read against FS-116's rings). Caveat, not claimed: the semi-hub's defining data are `p`'s ring
germs at `r(ψ ± 60°)`, which lie on `ω(y)`; to keep them the bends at `y` must be pinned at those two points — a horn lens tangent to the bent arc at a
pin leaves a transversal circle's germs in the tiles they were in, and pins are N2-TAN's device ("corners elsewhere on `α` at non-contact points") —
but that is not derived here. What remains of SEMI-PAR3: whether the winding constraint on `y`'s three-absent-colour ring (Y3-GP: `W ≡ 3 (mod 6)`
when no two change points are `60°` apart) contradicts a full parallel semi-hub — a derivation for FS-124, not a composition.

derivation: FS129-OR1-BEND3
  statement: let F be a non-Siamese simple valid six-coloured fragment on a closed disc B̄(q, r), r > 1, about a vertex q of exactly three colours, and
    1 < ρ′ < min(r, √3); then there is a non-Siamese simple valid six-coloured fragment on B̄(q, ρ′) in which q is a vertex whose tiles at q have the
    colours they have in F, whose ring carries no arc of Γ, and whose tiles include every tile of F meeting B(q, min(r, √3)) other than the side tiles
    of arcs of Γ on ω(q), which it modifies only inside thin lenses along those arcs
  uses only: FS129-OR1-WHOLE; FS112-N2-BENDS (N2-TOWARD, N2-AWAY) read on a fragment, as in FS129-OR1-BENDFRAG's argument; FS116-V5-U1 (at the centre of
    an arc of Γ the inner colour's sectors lie in the facing cone, the outer colour's in the away cone, neither in the two open side cones); that a
    non-Siamese simple fragment has no repeated colour at a vertex (two tiles of one colour at q are near, by FS116-V4-DICHOTOMY; one tile twice at q
    has a closure that meets itself)
  not claimed: that the bends can be pinned at chosen points of ω(q) keeping the germs there of circles that cross ω(q) (J2 needs it; not derived);
    anything at radius √3 or more; anything in the Siamese or non-simple classes; anything about vertices of four or more colours (FS129-OR1-BENDFRAG)
  argument: § Argument for FS129-OR1-BEND3
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS, FS116-V5-U1
  minds: 1
  model: any cubic trichromatic vertex u of the capped strip (FS114-Y-DIAL) whose closed unit disc lies at distance above 1 from the strip's edge, on
    B̄(u, 1.1): a non-Siamese valid fragment about a vertex of three colours (`plans/FS112-NB3-verification.md` § 1.4's killing test 8 reads the strip's
    trichromatic vertices); its ring's arcs of Γ, if any, are bent
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-BENDFRAG (one module: the bends on a whole-tile fragment below √3)

#### Argument for FS129-OR1-BEND3

*No arc of `Γ` on `ω(q)` has both side colours at `q`.* Let `α ⊂ ω(q)` be one, of angular extent `ℓ > 0`, with side colours `c` (inner), `c′`
(outer), and suppose both are carried at `q`. By FS116-V5-U1 the directions of `c`'s sectors at `q` lie in the closed facing cone and `c′`'s in the
closed away cone, and the two open side cones, each of width `ℓ`, hold neither. Each side cone is covered, but for finitely many edge directions, by
sectors of tiles at `q` of colours outside `{c, c′}`. One sector cannot meet both side cones: a sector is a connected range of directions, and joining
the two side cones it would contain the whole facing cone or the whole away cone, where `c`'s or `c′`'s sector directions lie (a zero-angle cusp
direction of `c` included: a sector containing it in its interior would overlap `c`'s tile near `q`). So `q` has at least two sectors of colours
outside `{c, c′}`, of different colours because `q` has no repeated colour, and `q` carries at least four colours — not three. (This is FS112-N3-NOBOTH
read on a fragment.)
*The bends.* FS129-OR1-BENDFRAG's argument, with "non-(Q)" replaced by "not both side colours at the centre": that argument used "at least four colours
at `p`" only to pass from "not (Q)" to "one side colour absent at the centre", which here holds for every arc of `Γ` on `ω(q)`. So on `F_ρ`,
`ρ = min(r, √3)`, every arc of `Γ` on `ω(q)` bends whole (toward `q` if its outer colour is absent there, else away, no witness by FS129-OR1-WHOLE),
keeping the class, `q`'s colours and every tile away from the lenses; the ring then carries no arc of `Γ`.
""")
A("### J3 — FS-125: NO-SAT, through its cases\n")
A("**The step** (as the demand list quotes it): "+step('J3')+"\n")
A("""**Kind of input**: contact at distance exactly 1 (SATPIN) against a straddle; for case 1's G3 and case 2, the ring type. Admissible.

**Read for it**: FS116-SAT-STRIP, -SAT-QFREE, -S1-QF, -S1-RUNG, -S1-KAPPA, -S1-LENS, -S1-EXIT, -N1-TOUCH, -N1-ECHO, -N1-F15TOUCH, -O1-SATPIN,
-Y1-STRIPCEIL, -Y1-F15; FS111-M-PINCH, -M4-LADDER; the FS-125 stub's G1–G3 (`plans/STUB-saturated-local.md` ll. 35–37); FS129-OR1-QFREE.

**Verdict: shortened** (no new entry; consequences of FS129-OR1-QFREE, stage 2). Case 2 (SAT-QFREE's touch point) and case 1's G3 (QF's tilt — "crosses
not at right angles") are both about fragments whose ring carries no (Q) arc. FS129-OR1-QFREE excludes every such fragment on any disc of radius above 1
in the non-Siamese simple class — saturated or not, at any crossing angles. So **G3 and SAT-QFREE are closed in the non-Siamese simple class**; what is
left of them is their non-simple part (FS116-S1-QF is stated for non-Siamese fragments without "simple") and their Siamese part (with G2). G1 (rings with
(Q) arcs, the strip-like class) and case 3 are untouched; FS116-N1-F15TOUCH (SAT-QFREE false without "(Q)-free") is consistent, the capped strip's ring
carrying four (Q) arcs.
""")
A("### J4 — FS-128: TOP₆, a smaller form\n")
A("**The step**: "+step('J4')+"\n")
A("""**Kind of input**: coverage of a top-colour boundary point's unit circle by the lower colours; § 2's FS111-M2-NOSEL and FS111-M-DEADLOCK exclude
selection and local fills, so the admissible kind is a coverage argument that spends six (FS121-D3-EQ). Admissible.

**Read for it**: FS121-D3-GRUNDY, -D3-EQ, -D3-FALLSAT, -D3-SWAP1D, -C1-BOUND, -C1-GMAP, -O1-ABOVE7, -V4-HEXMID, -V4-EDGE; FS111-M-SATC, -M2-NOSEL,
-M-DEADLOCK, -W-FILL-FREE, -VMW-R7-MAX, -M-R7-FORCE, -W-HEXSAT.

**Verdict: null** — no lane-R result gives a statement strictly smaller than C121-SAT6 at six. Near misses: FS121-D3-SWAP1D (on a circle an honest
saturated three-colouring exists where no idomatic partition does — it separates idomatic from honest saturated, it does not bind a top colour);
FS111-VMW-R7-MAX (R7 saturated in the strongest reading — seven colours); FS121-O1-ABOVE7 (the "lies below" form false at seven). FS129-OR1-TOP5 (J10)
shows the five-colour top-colour clause is the five-colour answer restated given REG-J′₅, so no smaller form of TOP₆ comes by analogy with five.
""")
A("### J5 — FS-124, case 4: the five- and six-colour vertices\n")
A("**The step**: "+step('J5')+"\n")
A("""**Kind of input**: distances between outer tiles at (Q)-arc ends `60°` apart (the identity of V6-HUG on `{p, y}`). Admissible.

**Read for it**: FS116-N2-FIVERING, -N2-SIXRING, -Y2-SIXOFF, -Y2-SIXFRAG, -V6-HUG, -V4-CHORD, -V4-TWIST, -RING-TRANSFER-C; FS112-SIX; FS129-OR1-BENDFRAG.

**Verdict: null.** FS129-OR1-BENDFRAG adds nothing here: FIVERING already forces (Q) arcs over half of a five-colour ring with Siamese pairs allowed,
SIXRING makes the six-colour ring six `60°` (Q) arcs, and any exclusion must read past `3/2` (SIXFRAG), beyond which BENDFRAG (below `√3`) says only
that `p`'s ring carries (Q) arcs and points — already true here. V6-HUG is the hunch's tool; no held result applies it at a five- or six-colour vertex.
""")
A("### J6 — FS-124, case 2: the disk's corner\n")
A("**The step**: "+step('J6')+"\n")
A("""**Kind of input**: points and distances on `p`'s far side, in DCREAD's directions. Admissible.

**Read for it**: FS116-N1-QDISK, -Y2-DCREAD, -RING-GERM, -RING-Q, -RING-Q-PRIME; FS112-CAL-DISK, -DISK-RIM, -DISK-S1, -DISC, -MOVE, -Y3-PIN;
FS114-Y-PENT, -Y-ROUTES.

**Verdict: null**, with a reduction candidate for pass 2. FS114-Y-PENT ("no valid map agrees with the disk near `B_k`, `Z^R_k`, `Z^L_{k+1}`") and
FS112-DISC ("no vertex-centred disc of radius above `φ` lies in any valid extension of the disk") exclude the disk's own combinatorics past `φ`. They
would close J6 only with a rigidity lemma — a fragment holding the disk-corner configuration on `B̄(p, 2)` agrees with the disk near some `B_k` and its
two partners — which no held result supplies, and which DCREAD's directions (outside the disk) may contradict. Not derived.
""")
A("### J7 — FS-123 question 3 with FS-124 case 7: the Siamese and non-simple classes\n")
A("**The step**: "+step('J7')+"\n")
A("""**Kind of input**: points and distances only, never a count (G86). Admissible.

**Read for it**: FS116-Y4-FLANK, -N1-GERM-S, -RING-Q-PRIME-S, -N1-QFREE4, -S1-KAPPA, -Y3-SIX, -V6-HUBS, -V6-HUG, -V6-COUNT; FS129-OR1-QFREE-CLASS.

**Verdict: reduced** (stage 2's FS129-OR1-QFREE-CLASS): EMPTY's Siamese or non-simple form, once derived, gives the (Q)-free form at no cost, so J7's
(Q)-free half is its Γ-free half. The Γ-free half itself: null — no held lane-R result removes non-Siamese from FS116-Y3-SIX's or FS116-V6's tip
uniqueness; FS116-Y4-FLANK (Siamese allowed) is the held piece the stub already names.
""")
A("### J8 — FS-126: a curved tangent-type interface, at any number of colours\n")
A("**The step**: "+step('J8')+"\n")
A("""**Kind of input**: a construction meeting FS121-D1's constraints, or an obstruction, for an aperiodic structure — a one-sided pencil of concentric
integer-radius interface arcs. § 2's FS121-D4-TINY16 forbids counts per region, not this. Admissible.

**Read for it**: FS121-D1-PENCILWIN, -D1-DOUBLE, -D1-VT, -D2-THIN, -D2-INCURVED, -D2-SYM, -D2-PERFIN, -V5-SYM-CPT, -V5-SYM-UP, -O1-OUT, -O1-PER,
-O1-LRA-LINE, -DB1-L7; FS112-N2-RAY, -N3-CHAINS, -Y3-R1, -N3-PER, -Y3-END-AB; FS110-N4-FIN, -N4-SHADOW.

**Verdict: null**, with a pass-2 note — one mechanism held twice. FS-112's extremal one-sided stuck chain (FS112-N2-RAY: "the pencil of circles of radius
`k + 1` about `P_{−1}` with straight upper arcs, every shadow tight"; FS112-N3-CHAINS: on an upward-infinite chain the horn at `P_k` needs a boundary arc
of radius at least `k + 1`) and FS-121's tangent-type ladders (FS121-O1-OUT: radii `n, n + 1, n + 2, …`; -D1-PENCILWIN; -D2-THIN) are one object, a
one-sided pencil of concentric integer-radius arcs — met first as a valid map's stuck ray (FS-115), then as a saturated colouring's curved interface
(FS-126). FS112-N3-PER ("a doubly periodic valid map … has no stuck ray") and FS121-D2-PERFIN with -O1-PER are the same periodicity kill. No held
result decides FS-126; FS112-Y3-END-AB (a finite chain realised exactly over ℚ with the recursion taken with equality) is the nearest construction,
and it is finite.
""")
A("### J9 — FS-127: LAT\n")
A("**The step**: "+step('J9')+"\n")
A("""**Kind of input**: distance-exactly-1 facts at an accumulation point — the sagitta of the unit circle (G90). Admissible.

**Read for it**: FS121-D4-FACE, -D4-GRID, -D4-FALL, -D4-HOLE, -D4-LINE, -V5-FACE-SHARP, -V5-RAY, -V5-GRID-CANTOR, -V5-PAIR; FS111-M3-HC, -M4-CUT,
-M4-HC, -M3-BAND.

**Verdict: null**, with a pass-2 note: FS111-M4-CUT's bound `β(u) ≤ n − (n² − (u − z)²)^{1/2}` (a ladder's `n`-th rung over a gap end) and
FS121-D4-FACE's `2g < ρ²` (sharp as `(1 − g)² + ρ² ≥ 1`, FS121-V5-FACE-SHARP) are one sagitta — at radius `n` along a ladder, at radius 1 at a face. LAT's
open case (pieces that shrink faster than the square root of their gaps) is where both are idle.
""")
A("### J10 — The map step at five: no open stub carries it\n")
A("**The step**: "+step('J10')+"\n")
A("""**Kind of input**: regularity — of maximal covers (a modification lemma keeping maximality) or of honest saturated colourings (a regularity theorem).
Admissible.

**Read for it**: FS111-REG-JP-C5, -VM2-EQ5, -M2-REDUCE-C, -M-REDUCE-I, -C-SIX-M, -C-REG-EQ, -V0-RESCALE, -C-SAT-T-HONEST, -M2-COV, -M2-FIX, -M2-HULLC,
-M3-IRREG, -M3-FIN-U, -M3-MOVE, -M3-COVER, -M4-MOVE, -M3-CASCADE; FS121-SAT6, -REGJ, -D3-GRUNDY, -D3-EQ, -D3-FALLSAT, -C1-GMAP; FS106-AE-MAP6;
FS114-N2-AVG; `plans/STUB-pinch-at-junction.md` ll. 40–47; `plans/STUB-top-colour.md`; `plans/STUB-lateral-extent.md`.

**Verdict: reduced, and the list's carrier line corrected** (composition FS129-OR1-TOP5).
1. *"No open stub carries it" is half true* (a finding about the demand list). Two held routes lead from a regularity statement at five to
   `χ_m⁰(ℝ²) ≥ 6`, both through FS106-AE-MAP6: the cover route (FS111-M2-REDUCE-C — MUA-REG-P and MUA-FIN with D3's clause; REG-JP-C5 is its whole
   statement) and the honest route (FS111-M-REDUCE-I — the honest existence form of C-SAT-T at five, which is FS121-SAT6's `k = 5` clause, with REG-J′₅).
   FS111-C-SAT-T-HONEST's gap line already says honesty "at five … is not needed (FS111-M2-REDUCE-C)". Of the pieces: MUA-FIN is carried by FS-120 (its
   stub l. 44: "at five, the cover statement REG-J′-C₅"); REG-J′₅ by FS-127 (FS121-REGJ is stated "with any number of colours"); **no stub carries
   MUA-REG-P or the top-colour clause at five**.
2. *FS129-OR1-TOP5*: given REG-J′₅, the honest existence form at five holds if and only if `χ_m⁰(ℝ²) ≥ 6` (at AE-MAP6's grade) — the five-colour mirror
   of FS121-D3-EQ. So the honest route at five has one piece that is not the five-colour answer restated: REG-J′₅, which is FS-127's LAT at five. With
   FS111-VM2-EQ5 (the cover route's whole statement is the answer restated), the smaller pieces of the map step at five are colour-generic and already
   carried (FS-127, FS-120), except MUA-REG-P.
3. *A note, not derived*: at five, FS121-C1-GMAP's route needs no C121-NOPAR — FS106-AE-MAP6 excludes every a.e.-proper map-type five-colouring outright,
   so any statement turning a tight five-colouring into an a.e.-equal locally finite map colouring (for instance, FS121-D3-GRUNDY's Grundy colouring
   being one) gives `χ_m⁰(ℝ²) ≥ 6`. The obstacle at five is then regularity where the top colour is unbound (FS111-M-PINCH needs both colours bound) — the
   same obstacle TOP₆ names at six.
4. FS106-AE-MAP6 can be replaced by FS114-N2-AVG's N2-FIVE-PLANE ("no simple non-Siamese valid five-colour map of the plane exists"; one mind; by
   counting; no Townsend's (c)) wherever the map a route produces is simple and non-Siamese (J23).

derivation: FS129-OR1-TOP5
  statement: if REG-J′₅ holds — FS111-M-REDUCE-I's regularity hypothesis at five colours, a saturated colouring whose singular set Σ is locally finite
    with finitely many interface arcs at each point of Σ — then the honest existence form of C-SAT-T at five (every tight a.e.-proper five-colouring can
    be modified, keeping it a.e.-proper with five colours, into an honest saturated one; FS121-SAT6's k = 5 clause) holds if and only if
    χ_m⁰(ℝ²) ≥ 6, the forward direction at FS106-AE-MAP6's grade (modulo Townsend's simplification (c))
  uses only: FS111-M-REDUCE-I ("with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6 follows from those two statements at k = 5"); FS111-V0-RESCALE (a tight a.e.-proper
    k-colouring exists if and only if χ_m⁰(ℝ²) ≤ k); vacuity
  not claimed: REG-J′₅ (FS121-REGJ at five, open — FS-127's LAT); the honest existence form at five; the equivalence without REG-J′₅; the forward
    direction beyond FS106-AE-MAP6's grade; anything at six (FS121-D3-EQ)
  converse: § Argument for FS129-OR1-TOP5
  argument: § Argument for FS129-OR1-TOP5
  verdict: derived
  grade: derived from: FS111-M-REDUCE-I, FS111-V0-RESCALE
  minds: 1
  model: vacuous when χ_m⁰(ℝ²) ≥ 6 (no tight five-colouring exists, by FS111-V0-RESCALE, and every clause holds); no non-vacuous model is known, which is
    the statement's content: at five colours the top-colour clause is the answer restated once REG-J′₅ is granted
  prior art: owed — in-house; the six-colour mirror is FS121-D3-EQ
  handoff: de Bruijn — the statement as a corollary of FS111-M-REDUCE-I's module, over FS106-AE-MAP6 as an imported hypothesis

#### Argument for FS129-OR1-TOP5

*Forward.* Assume REG-J′₅ and the honest existence form at five. FS111-M-REDUCE-I gives REG-I₅ from the two, and with FS106-AE-MAP6, `χ_m⁰(ℝ²) ≥ 6`
(its statement's second clause).
*Converse.* Assume `χ_m⁰(ℝ²) ≥ 6`. By FS111-V0-RESCALE no tight a.e.-proper five-colouring exists, so the honest existence form at five — a statement
about every tight a.e.-proper five-colouring — holds vacuously; REG-J′₅ is not used.
""")
open('data/fs129/or1/stage3.md','w').write('\n'.join(out))
