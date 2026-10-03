# FS-121 — the derivation file (the map step)

*Written by the close job FS121-Z1 (Ephodos, Opus 5.5), 2026-10-03, in the grammar of `.claude/skills/ephodos/SKILL.md` § the entry: every id
qualified `FS121-…`; "Rests on it:" as prose. Every theorem FS-121 proved outside the kernel, one entry each; a verifier's re-derivation is counted
in its entry's minds, never filed twice. Grades translate as `hand` = [hand], `derived from` = [derived], `computed over` = [tools]; verdict `derived`
is TRUE, `gap:` is GAP. Minds and blindness are read from the fence logs (`FS121-Z1-close.md` § Stage 2); every mind is Opus 5.5, one prior.
**Held** means the announcement rule (`FS121-close-inventory.md`, its top): a frozen statement, two minds, the second blind, its verdict committed
first. Frozen names (`C121-…`) and the list's sections are `../data/fs121/claims.md`'s; its § 0 defines D-NF, saturated, honest, (H1), (H2), Σ,
REG-J′, LRA, kind both, (Q), (R2), carries and the ladder. A statement a verifier corrected is filed in its corrected wording, the frozen one's
address given. Arguments are addresses in the job records, resolved from `plans/`. **Nothing here moves a value**, and every statement that quantifies
over saturated colourings with REG-J′ has its held inhabitants at seven or nine (R7, SQ9, HEX9) and none at six.*

*Prior-art queries cited below (zbMATH Open API, `ab:` fields unless marked; hits read by title): the opening's, `FS121-map-step.md` § 2.2; FS121-D2's,
`../data/fs121/d2/zb-run.out`; FS121-D3's, `../data/fs121/d3/`; FS121-C1's, `../data/fs121/c1/zb`; this close's, `../data/fs121/fs121-z1/zb-run.out`
(control and plant fire). Novelty is measured at the grain of the object class those queries name; where a lemma's own search was not run, the entry
says "partly" and names what is in print.*

## Round 1 — the ladder's ends (FS121-O1; FS121-DB1 blind)

derivation: FS121-O1-ENDS
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a
    null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind both
    and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not
    — J_1 is (R2), and z is a point of Σ carrying at least three colours counted by sector — the outer colour and at least two further sectors of
    positive angle — and at least three distinct colours when no colour at z has density 0
  uses only: FS111-M2-INTRAD steps (1)–(2) (the chain toward the centre stops at radius 1 or at Σ); FS111-M-PINCH's two types; C-HULL's first clause;
    FS112-N3-NOBOTH's sector argument with N112-U1's cones; FS121-DB1-L3 for the no-repeat step (FS111-W-NOREP, which the first derivation cited, does
    not reach a centre whose neighbours at distance 1 carry cusps); FS111-M-HALF; no colour count
  not claimed: that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours; that the
    centre has four colours of positive density (FALSE at R7: |P(z)| = 3 with six colours carried)
  argument: FS121-map-step.md § 3.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-O1's § 3.2–3.4 until its verdicts were committed (43bb6385); method: DB1 reads the local fan REG-J′ gives and counts
    colours by properness straddles (DB1-L1, L3–L5), O1 transfers NOBOTH and cites W-NOREP
  model: k = 7: R7 — every interface a split unit arc about a lattice point carrying six colours (three sectors, three cusps)
  prior art: new — “(maximal independent | independent dominating) & (unit distance | distance graph) & (plane | measurable | Euclidean)” (0),
    “(measurable chromatic | chromatic number of the plane) & (map | tiling | regular* | Jordan | boundar*)” (13), none bearing
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain (FS-113)

Frozen as C121-ENDS (`../data/fs121/claims.md` § 2); corrected wording ("counted by sector") from the author's answer and DB1 § 2.6. **Held.** Both
density conditions are idle (FS121-DB1-L4, -L5, one mind). Rests on it: the card's answer (FS121-O1-CARD); C121-R2-FOUR's object; FS-126.

derivation: FS121-O1-OUT
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type interface arc of
    radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved interface of
    tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular window
  uses only: FS111-M-PINCH's tangent contacts; FS111-M2-INTRAD step (1) on the side away from the centre; FS111-M-C11 (iii); no colour count
  not claimed: that a saturated colouring with a curved tangent interface exists at any k (none is held); the same for split arcs (FALSE at R7, exact:
    ../tools/fs121_db1_r7parallel.py)
  argument: FS121-map-step.md § 3.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-O1's § 3.3 until 43bb6385; method: the same held step, DB1 adding the radial images of points of Σ and the attack at R7
  model: k = 9: SQ9, whose flat edges carry the ladder at every unit translate (48 of 48 edge-sides); no held object has a curved tangent interface
  prior art: partly: row 135 found the one-sided pencil consistent in terminal valid maps; that saturation forces it, not found (FS121-map-step.md § 2.2)
  handoff: de Bruijn — with FS111-M2-INTRAD, queued behind the measurable chain

Frozen as C121-OUT (§ 2). **Held.** REG-J′ is idle in the first clause (DB1-L7, one mind). Rests on it: FS121-O1-PER, FS121-D1-PENCILWIN, FS121-D2-SYM's
second route (V5 § 3.2), FS121-V5-SYM-CPT, FS121-Z1-NOCURVED.

derivation: FS121-O1-PER
  statement: in an honest saturated colouring in D-NF satisfying REG-J′ whose interfaces carry only finitely many radii of curvature — in particular a
    doubly periodic one satisfying ¬LRA — every curved interface is a split unit arc of kind both and no (R2) arc occurs; where no colour has density 0
    at an arc's centre, every such arc is (Q)
  uses only: FS121-O1-OUT; FS111-M-REDUCE-I's local finiteness of interface arcs under REG-J′ (or compactness of a fundamental domain, DB1's route);
    FS121-DB1-L4 for the (Q) clause; FS111-M-C11 (iii)
  not claimed: that a tight colouring can be taken periodic; anything with infinitely many radii
  argument: FS121-map-step.md § 3.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-O1's § 3.3 until 43bb6385; method: the periodic step by two arguments (arcs per fundamental domain; translates of pieces
    accumulating into LRA)
  model: k = 7: R7, every curved interface a split unit arc of kind both (VM2-LAD-CTL: 432 of 432)
  prior art: partly: row 135 notes that a stuck ray needs arcs of every radius and doubly periodic maps have none; for saturated colourings not found
  handoff: none — it narrows FS-116's class on the honest route for periodic maps; it crosses with FS121-O1-OUT

Frozen as C121-PER (§ 2), the frozen wording kept. **Held.** The density condition is idle (DB1-L4). Its "satisfying ¬LRA" is unneeded: FS121-D2-PERFIN
(one mind) and FS121-V5-SYM-CPT (one mind, a second route) — a strengthening at one mind each, over M2-INTRAD's per-radius finiteness. Rests on it: the
periodic reading of FS-116's class (FS-116's close).

derivation: FS121-O1-LRA-LINE
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces of radii tending to infinity accumulate at a point x₀ of the
    interface curve on which they lie, with normal ν there, then pieces of radii tending to infinity accumulate at x₀ + kν for every integer k
  uses only: FS111-M2-INTRAD step (1) on both sides and its per-radius finiteness (iii); the parallel-curve formula ρ ↦ ρ ± k away from focal points
  not claimed: that such a line is impossible (¬LRA is open); the conclusion along the normal of another interface curve through x₀ ∈ Σ (reading (b): GAP)
  argument: FS121-map-step.md § 3.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-O1's § 3.3 until 43bb6385; method: each piece's own k-fold parallel moved off Σ, against the parallel of the whole curve
  model: none held of the hypothesis at any k (no held saturated colouring has LRA); the statement is a reduction, and R7, SQ9, HEX9 meet it vacuously
  prior art: new — “parallel curve* & unit distance” (0), “(parallel curve | parallel curves | equidistant*) & (unit distance | colo*)” (21), none bearing
  handoff: none — a reduction of an open statement (C121-NOLRA), which FS121-D2 did not need

Frozen as C121-LRA-LINE (§ 2); corrected wording (reading (a) named) from DB1 § 3.1 row 11. **Held** under (a).

derivation: FS121-O1-CARD
  statement: in an honestly saturated six-map without cusps, every curved interface's ladder of unit parallels ends at a (Q) arc about a vertex of at
    least four colours
  argument: FS121-map-step.md § 3.4
  verdict: gap: the (R2) branch — the ladder's last rung is (Q) or (R2) (FS121-O1-ENDS); an (R2) end lies on FS-116's rings when its centre carries at
    least four colours, and nothing excludes an (R2) centre of exactly three (C121-R2-FOUR)

Poros's card `do-ladders-end-on-q-rings` (`STUB-map-step.md` § The question (Poros, 2026-09-29)); one mind, DB1 § 3.2 consistent (sighted).

derivation: FS121-O1-ABOVE7
  statement: the form "every tight a.e.-proper k-colouring lies below an honest saturated k-colouring" (each class of the first contained a.e. in the
    class of the same colour of the second) is false at k = 7
  uses only: the tight hexagonal seven-colouring is not saturated (FS111-M-DEADLOCK, FS111-W-HEXSAT (2)) and its classes cover the plane, so the only
    partition whose classes contain them a.e. is itself
  not claimed: anything about modifications that may lower a class; anything at five or six
  argument: FS121-map-step.md § 4.1
  verdict: derived
  grade: hand
  minds: 1
  model: the tight hexagonal seven-colouring
  prior art: partly: FS111-M-DEADLOCK (held) is the unsaturated fact; the remark not found
  handoff: none — it fixes C121-SAT6 at six by nature

### DB1's lemmas (one mind each unless said)

derivation: FS121-DB1-L1
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at the centre of a unit interface arc the inner colour's directions lie in the
    closed facing cone, the outer colour's in the away cone, and neither enters the two side cones
  uses only: properness straddles at the arc's points; FS112-U1's cones, re-derived in the saturated setting
  not claimed: anything about colours other than the arc's two
  argument: FS121-DB1-verification.md § 2.2
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: R7 at a lattice point (tools/fs121_db1_r7cones.py)
  prior art: partly: FS112-U1 (held, for valid maps)
  handoff: none — a local lemma consumed by FS121-DB1-L4, -L5; it crosses with them

derivation: FS121-DB1-L3
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever
    cusps are present at the point or elsewhere
  uses only: the local fan REG-J′ gives; FS111-M-PINCH and FS111-M-C11 at points of the sectors' edges; C-HULL's first clause (DB1); Lemma H, the
    component lemma at contacts inherited along the edges (V2)
  not claimed: that a colour cannot occupy a sector and a cusp, or two cusps, at one point (the first is FS121-V2-SECTOR); anything without REG-J′
  argument: FS121-DB1-verification.md § 2.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: each other's records (DB1 § 2.3 opened by V2 only after f537b8c9); method: a straddle with a tangent/unit-arc case split and
    exact cusp checks (DB1), against the component lemma at contacts inherited as limits along the edges (V2)
  model: k = 9: SQ9 at a vertex (four distinct colours); k = 7: R7 at a lattice point (sectors and cusps of distinct colours)
  prior art: partly: FS111-W-NOREP (held at one mind, saturated maps without cusps) is the map form; this localisation not found
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain

Frozen at § 5. **Held.** It repairs FS111-W-NOREP's argument (its two cases miss an edge that is a unit arc whose centre carries the repeated colour
on the far side; DB1 § 3.3; the erratum is drafted at the close). Rests on it: FS121-O1-ENDS's and -PER's (Q) clauses, FS121-DB1-L4, -L5, FS121-V2-SECTOR.

derivation: FS121-DB1-L4
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the centre of a unit interface arc of kind both lies in Σ and carries at least
    four distinct colours, with no condition on densities
  uses only: FS121-DB1-L1; FS121-DB1-L3
  not claimed: four colours of positive density (FALSE at R7)
  argument: FS121-DB1-verification.md § 2.4
  verdict: derived
  grade: derived from: FS121-DB1-L1, FS121-DB1-L3
  minds: 1
  model: k = 7: R7 (six colours carried at every arc's centre)
  prior art: partly: FS112-N3-NOBOTH (held: four colours or a repeated colour, for valid maps)
  handoff: none — it crosses with FS121-DB1-L3

derivation: FS121-DB1-L5
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the centre of a tangent-type unit arc that carries the arc's outer colour and
    not its inner lies in Σ, with at least two further positive-angle sectors of pairwise distinct colours besides the outer colour's: three distinct
    colours, with no condition on densities
  uses only: FS121-DB1-L1; FS121-DB1-L3; FS111-M-HALF
  not claimed: a fourth colour (C121-R2-FOUR); that such a centre exists in any saturated colouring
  argument: FS121-DB1-verification.md § 2.4
  verdict: derived
  grade: derived from: FS121-DB1-L1, FS121-DB1-L3
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has an (R2) arc, C121-PER); R7, SQ9, HEX9 meet it vacuously
  prior art: partly: FS-112's (R2) kind (held, for valid maps); the count in saturated colourings not found
  handoff: none — a bound on an uninhabited object; it crosses with C121-R2-FOUR

derivation: FS121-DB1-L6
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius toward its
    centre ends, off finitely many normals, at a unit arc whose centre carries that arc's outer colour
  uses only: FS111-M2-INTRAD step (1); FS111-M-PINCH's two types; REG-J′'s local finiteness (each point of Σ but the centre on one normal)
  not claimed: which kind the last arc is (FS121-O1-ENDS)
  argument: FS121-DB1-verification.md § 2.5
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: R7 (chains of length one)
  prior art: partly: FS111-M2-INTRAD (ii) (held), with "a null set of normals" in place of "finitely many"
  handoff: none — a re-derivation inside C121-ENDS's verification; it crosses with FS111-M2-INTRAD

derivation: FS121-DB1-L7
  statement: in an honest saturated colouring in D-NF, the unit parallel away from the centre of a tangent-type interface arc is, at every point off Σ,
    a tangent-type interface of radius one more; REG-J′ is not used
  uses only: FS111-M-PINCH's tangent contacts; FS111-M2-INTRAD step (1) away from the centre; FS111-M-C11 (iii)
  not claimed: the family over the whole window (that uses REG-J′, FS121-O1-OUT); the same for split arcs (FALSE at R7)
  argument: FS121-DB1-verification.md § 2.5
  verdict: derived
  grade: hand
  minds: 1
  model: k = 9: SQ9's flat edges
  prior art: partly: FS111-W-LADDER (held, the flat case)
  handoff: none — it crosses with FS121-O1-OUT

## Round 1 — the (R2) end (FS121-D1); its two lemmas checked blind in round 2 (FS121-V2)

*D1's class word* cusp-free (its header): no colour has density 0 at any point of its support — V2's reading (Σ). Under it a colour can hold a
zero-angle region at a point where it also holds a sector, so D1's citations of FS111-W-NOREP for "one sector per colour" are carried by
FS121-V2-SECTOR (held) — a reading at the close, one mind (`FS121-Z1-close.md` § 2.4); no verdict or count changes.

derivation: FS121-D1-XCORNER
  statement: at a convex corner z of angle θ in (0, π) whose two edges are straight, the inner unit parallels of the two edges meet at the point at
    distance 1/sin(θ/2) from z on the bisector, the image of the points at distance cot(θ/2) from z along each edge
  uses only: plane trigonometry
  not claimed: anything about colourings (a statement about lines)
  argument: FS121-D1-proof.md § 1.3
  verdict: derived
  grade: hand
  minds: 1
  model: θ = π/2: the point (1, 1) from z = 0 with edges along the axes
  prior art: known: elementary geometry of parallel lines
  handoff: none — elementary; it crosses with FS121-D1-EROSION

derivation: FS121-D1-VT
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b with no
    sub-arc of radius 1 curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior
    point of I, no interface arc ends at Y from the far side of L
  uses only: FS111-M-PINCH's tangent partners with M-HULL1; FS111-M2-INTRAD step (1); REG-J′'s local finiteness and FS111-M-C11's end tangents;
    FS121-V2-SECTOR at Y (in place of D1's step "cusp-freeness gives every sector at Y positive angle", false under reading (Σ)); cusp-freeness only at Y
    for the colour a
  not claimed: anything at the image of an endpoint of I; anything when I has a sub-arc of radius 1 curving toward b (L has a corner: FS121-V2-VT-W);
    anything with cusps
  argument: FS121-D1-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-D1's § 2.1 until V2's verdicts were committed (f537b8c9); method: F2–F3 at points of L then FS121-V2-SECTOR at Y (V2),
    against FS111-W-NOREP at Y (D1); both pass the zero-angle case through FS121-V2-SECTOR
  model: k = 9: SQ9 — each edge's partner is the edge one unit along the normal, met by arcs only at its two ends (48 of 48 edge-sides)
  prior art: partly: FS111-W-LADDER's colour rule β_{k+1} = τ_{k−1} (held) is the flat case along one normal line; “(parallel curve | parallel
    curves | equidistant*) & (unit distance | colo*)” (21) returned nothing bearing
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain: the statement with its no-radius-1 clause

Frozen at § 5 as "not a unit arc curving toward b"; **MISSTATED** at a corner of `L` (an interior radius-1 piece curving toward `b`): TRUE under
reading (W), GAP under (B) (V2 §§ 2.6, 3.3 row 6). Filed in the narrower corrected wording, V2's "no sub-arc of radius 1 curving toward `b`" (the
author's scope), **held** by item 58's ruling; the wider statement is FS121-V2-VT-W (one mind). Rests on it: FS121-D1-EROSION, -R2SMOOTH, -RUNG2,
-R2CORNER, -PENCILWIN; FS-116's consumers (FS-116's close).

derivation: FS121-V2-VT-W
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b, ν its
    normal into b, and x₀ an interior point of I that is not in the closure of a sub-arc of I of radius 1 curving toward b ending at an endpoint of I;
    let Y = x₀ + ν(x₀), P the closure of the radius-1 sub-arc of I curving toward b that contains x₀ in its closure if there is one and {x₀}
    otherwise, and L_Y the image under x ↦ x + ν(x) of a neighbourhood of P in I — a C¹ arc through Y when P = {x₀}, two branches meeting at Y at
    a corner otherwise; then no interface arc other than L_Y's branches ends at Y in the a-side region that L_Y bounds at Y (its far side, or the
    wedge between its branches)
  uses only: Lemma C (a.e.-properness); FS111-M-PINCH and FS111-M-C11 along I and along L_Y off Σ; FS111-M2-INTRAD's chain form, only to name the corner
    case; FS121-V2-SECTOR; cusp-freeness only at Y for the colour a
  not claimed: anything at a point where a has density 0 (the double horn is not excluded); anything at the image of an endpoint of I; anything on L_Y's
    near side
  argument: FS121-V2-verification.md § 2.5
  verdict: derived
  grade: derived from: FS121-V2-SECTOR
  minds: 1
  model: k = 9: SQ9 (every edge's unit parallel a clean segment, its far colour beyond it)
  prior art: partly: FS121-D1-VT is its narrower case
  handoff: none — the wider form of FS121-D1-VT; it crosses with it if the corner case is consumed

derivation: FS121-D1-EROSION
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its
    edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two
    pieces has a point of Σ at distance cot(θ/2) from z
  uses only: FS121-D1-VT on the straight branch through the crossing of the two inner partner lines (where L is C¹); FS121-D1-XCORNER; FS111-M-C11 (iii)
  not claimed: anything for curved edges; anything at θ ≥ π; anything with cusps; content at θ ≤ 2π/3, where the first disjunct holds in every
    a.e.-proper colouring (FS121-V2-EROSION-DIAM)
  argument: FS121-D1-proof.md § 2.2
  verdict: derived
  grade: derived from: FS121-D1-VT, FS121-D1-XCORNER
  minds: 2 — blind to: FS121-D1's §§ 1.3, 2.2 until f537b8c9; method: the same crossing (named in the statement, so given), VT applied through
    different lemmas, V2's for the straight branch alone
  model: k = 9: SQ9 at a grid point (θ = π/2, pieces 1/2 ≤ 1) and HEX9 at a vertex (θ = 2π/3); both inside the diameter bound, so they test nothing
    beyond it (V2 § 3.4 row 11)
  prior art: partly: the erosion of a convex cone by the unit disc is classical (recalled, not read); its reading on a saturated tile not found
  handoff: de Bruijn — with FS121-D1-VT, queued behind the measurable chain

Frozen at § 5. **Held** by the reading of item 58 at the close (`FS121-Z1-close.md` § 2.4; held for the coordinator). Its content lies at
`θ ∈ (2π/3, π)`, where no held colouring has a sector. Rests on it: FS121-D1-R2CORNER.

derivation: FS121-V2-EROSION-DIAM
  statement: in every a.e.-proper colouring, if a colour's sector at z has angle θ in (0, π) and both its edges begin with straight pieces of the
    boundary of one component of that colour, of lengths L₁ and L₂, then min(L₁, L₂) ≤ 1/(2 sin(θ/2)); so for θ ≤ 2π/3, min(L₁, L₂) ≤ cot(θ/2)
  uses only: a component of a class has diameter at most 1 (FS111-M-HULL2); 1/(2 sin(θ/2)) ≤ cot(θ/2) when cos(θ/2) ≥ 1/2
  not claimed: anything for θ in (2π/3, π)
  argument: FS121-V2-verification.md § 2.9
  verdict: derived
  grade: hand
  minds: 1
  model: the tight hexagonal seven-colouring at a hexagon corner (θ = 2π/3, sides 1/2 ≤ 1/√3)
  prior art: known: the diameter bound is FS111-M-HULL2's
  handoff: none — it places FS121-D1-EROSION's content

derivation: FS121-D1-FIRSTORDER
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, at a centre z of an (R2) arc carrying three colours q, r, s, the edge
    between r and s points into the antipodal cone of q's sector, and every partner point and split centre on ω(z) that the three edges at z require
    lies off the relative interior of the (R2) arc, whatever the edges' types
  uses only: FS111-M-HALF (widths ≤ π); FS112-U1 (q's sector in the away cone); the dichotomy at edge-interior points that M-PINCH gives, without a
    four-colour hypothesis; that the arc's relative interior carries p and q alone; one sector per colour (FS121-V2-SECTOR)
  not claimed: that a three-colour (R2) centre exists; any constraint from points of ω(z) off the arc, or from farther than distance 1
  argument: FS121-D1-proof.md § 2.3
  verdict: derived
  grade: hand
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has an (R2) arc, C121-PER)
  prior art: partly: the edge dichotomy is FS-116's opening's (FS116-O1-SATPIN, `../data/fs116/claims.md` § 3); its three-colour reading not found
  handoff: none — a no-go for a route (the plan's first-order aim), not a statement any later proof consumes

derivation: FS121-D1-R2SMOOTH
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if an end A₁ = z + u(α₁) of an (R2) arc about z is not a point of Σ,
    then the edge of q's sector at z on that side has direction α₁ + π/2 — the boundary of the away cone — and is the unit parallel, on the inner side,
    of the arc's tangent-type continuation beyond A₁
  uses only: one type along a connected interface off Σ (FS111-M-C11 (iii) and a limit of centres); FS111-M2-INTRAD (integer radii); FS121-D1-VT (i);
    FS112-U1; one sector per colour (FS121-V2-SECTOR)
  not claimed: that the continuation is straight; anything when A₁ is a point of Σ; that an (R2) arc exists
  argument: FS121-D1-proof.md § 2.4
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held of the hypothesis at any k
  prior art: partly: the plan's gate covers the object class (FS121-map-step.md § 2.2); this lemma's own search not run
  handoff: none — consumed only by FS121-D1-R2CORNER

derivation: FS121-D1-RUNG2
  statement: the window ℓ of an (R2) arc in an honest saturated colouring in D-NF satisfying REG-J′ satisfies 2 sin(ℓ/2) ≤ 1; if the colouring is
    cusp-free, 4 sin(ℓ/2) ≤ 1, so ℓ ≤ 2 arcsin(1/4) < 29°
  uses only: FS111-M-HULL2; FS111-M-PINCH's partners at radius 2; FS121-D1-VT for the cusp-free clause; no colour count
  not claimed: any bound on the windows of (Q) ends; any lower bound on ℓ
  argument: FS121-D1-proof.md § 2.4
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held of the hypothesis at any k; the bound is the diameter of the p-tile the (R2) definition names
  prior art: partly: FS-112's (R2) definition names the inner-colour tile along the radius-2 circle; the bound not found
  handoff: none — consumed by FS121-D1-R2CORNER

derivation: FS121-D1-R2CORNER
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, at an (R2) arc about z with window ℓ whose ends are not points of Σ and
    whose continuations beyond both ends begin straight, q's sector at z is the whole away cone, and within distance tan(ℓ/2) ≤ 1/√15 of the ends A₀,
    A₁, measured along the continuations, one continuation bends or changes its outer colour, or each of q's two edges at z has a point of Σ at
    distance tan(ℓ/2) from z
  uses only: FS121-D1-R2SMOOTH; FS121-D1-VT (i); FS121-D1-EROSION at θ = π − ℓ; FS121-D1-RUNG2; not the number of colours at z
  not claimed: that an (R2) arc exists; anything when an end lies in Σ or a continuation begins curved; any fourth colour at z
  argument: FS121-D1-proof.md § 2.5
  verdict: derived
  grade: derived from: FS121-D1-R2SMOOTH, FS121-D1-EROSION, FS121-D1-RUNG2
  minds: 1
  model: none held of the hypothesis at any k
  prior art: partly: the plan's gate covers the object class; this lemma's own search not run
  handoff: none — a necessary condition on an uninhabited object

derivation: FS121-D1-PENCILWIN
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, a tangent-type interface arc of finite radius n ≥ 2 about z whose
    chain of unit parallels ends at a single unit arc lies in a pencil whose rungs of radius at least 2 share one window, of angular width ℓ with
    4 sin(ℓ/2) ≤ 1
  uses only: FS111-M2-INTRAD step (1) and FS121-O1-OUT (the windows nest both ways); FS121-D1-VT (i); one sector per colour (FS121-V2-SECTOR);
    FS111-M-HULL2; no colour count
  not claimed: any bound when the chain's inner end is broken by points of Σ; that such a pencil exists (C121-CURVED)
  argument: FS121-D1-proof.md § 3.1
  verdict: derived
  grade: derived from: FS121-D1-VT
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has a curved tangent interface)
  prior art: partly: the plan's gate covers the object class; this lemma's own search not run
  handoff: none — a necessary condition on an uninhabited object; it crosses with FS121-O1-OUT if a curved inhabitant lands

derivation: FS121-D1-DOUBLE
  statement: for a point z, a unit vector e and h in (0, 1), within the cone of directions at most 60° from e and beyond ∂B(z, 1), the circles ∂B(z, j)
    and ∂B(z + he, j), j ≥ 1, interleave, and the three-colouring of the sub-bands between them cycling as A₁ = q, B₁ = r, A₂ = p, … has no two points
    of one colour in distinct sub-bands at distance 1 off the circles, and meets FS111-M-PINCH's tangent partners at every point of every circle along
    the normals of the circle's own family
  uses only: points inside ∂B(c, j) and outside ∂B(c, j + 1) are at distance ≥ 1, with equality only on the circles; the colour rules A_{j+1} = B_{j−1},
    B_{j+1} = A_j; elementary estimates for the interleaving
  not claimed: a colouring of the plane; tiles of diameter ≤ 1 (each sub-band holds monochromatic unit pairs once longer than 1); anything inside
    ∂B(z, 1) or outside the cone
  argument: FS121-D1-proof.md § 3.2
  verdict: derived
  grade: hand
  minds: 1
  model: h = 1/2, e = (0, 1), z = 0: on the axis the circles sit at 1, 3/2, 2, 5/2, …, SQ9's one-dimensional pattern bent round z
  prior art: partly: SQ9's pattern along one axis is its flat case; the two-centred form not found
  handoff: none — a partial construction toward C121-CURVED

derivation: FS121-R2-FOUR
  statement: in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, every centre z of an (R2) arc that ends a chain
    of unit parallels, at which no colour has density 0, carries at least four colours
  argument: FS121-D1-proof.md § 3.4
  verdict: gap: excluding a cusp-free three-colour (R2) centre — q in the away cone, r and s filling the facing cone with their common edge in the
    antipodal cone of q's sector (FS121-D1-FIRSTORDER), ℓ ≤ 2 arcsin(1/4) (FS121-D1-RUNG2), a bend or vertex of q's tile within 1/√15 of z in the
    smooth-straight case (FS121-D1-R2CORNER); the band interfaces a second pencil supplies radially (FS121-D1-DOUBLE); open: the transverse
    subdivision and the inner disc about z and z + he with z held at three colours

Frozen as C121-R2-FOUR (§ 2). One mind. Its hypothesis "at which no colour has density 0" is narrower than the cusp-free class that the distinct
count once needed; since FS121-DB1-L3 the distinct count needs no density condition (DB1-L5), so the scope note of item 22 is moot. It holds vacuously
under FS121-Z1-NOCURVED's hypothesis. Rests on it: FS-126.

derivation: FS121-CURVED
  statement: for some k ≥ 7 there is an honest saturated colouring in D-NF satisfying REG-J′, with no colour of density 0 at any point, that has a
    tangent-type interface arc of finite radius
  argument: FS121-D1-proof.md § 3.3
  verdict: gap: the transverse subdivision — cutting the sub-bands of a curved pencil (FS121-D1-DOUBLE's offset pencil as its band interfaces) into tiles
    of diameter at most 1, every cut's ends transported rung to rung along each family's normals (FS121-D1-VT), and closing the inner disc about the two
    centres; neither a colouring by formula nor an obstruction at any k ≥ 7; an inhabitant must be aperiodic (FS121-V5-SYM-CPT)

Frozen as C121-CURVED (§ 2). One mind. Rests on it: FS-126 (its NO, cusps allowed, is FS121-Z1-NOCURVED's hypothesis).

## Round 2 — the sector lemma (FS121-V2; FS121-V3 blind), honest saturation (FS121-D3; V3 blind), ¬LRA (FS121-D2; FS121-V5 blind)

derivation: FS121-V2-SECTOR
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive angle occupies
    no other region there, of positive or of zero angle
  uses only: Lemma C (a.e.-properness); FS111-M-PINCH's contacts on the normal line and FS111-M-C11's bound |κ| ≤ 1 at points of the sector's edges
    near the point; the fan at the point (REG-J′ read with the essential boundary in a small disc about z the finitely many arcs at z)
  not claimed: that a colour cannot occupy two zero-angle regions at one point (they are collinear, FS121-V3-CUSP); anything without REG-J′; that the
    point itself is saturated (not used)
  argument: FS121-V2-verification.md § 2.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: V2 § 2.3 until V3's verdicts were committed (dea603eb; V3 was relayed two definition lines of V2's record, no route); method:
    limits of the edge contacts sorted by two disc tests, Lemmas C and D (V3), against a per-arc case split with Lemma H (V2)
  model: k = 7: R7 at a lattice point (up colours on sectors, down colours on cusps, disjoint); k = 9: SQ9 at a vertex
  prior art: partly: FS111-W-NOREP and FS121-DB1-L3 are its positive-angle case; the zero-angle case not found
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain

Frozen at § 6. **Held.** Its words "sector, region, angle, occupies" are defined in V2's record, not the list's § 0, and it reads REG-J′ as a fan
(V3 §§ 3.5–3.6): a claim-list note is drafted at the close. Rests on it: FS121-D1-VT and -EROSION (held), FS121-V2-VT-W, D1's cusp-free lemmas.

derivation: FS121-V3-CPI
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at a point of Σ every region of positive angle has angle at most π
  uses only: Lemma C and the contacts at z inherited along a region's two edges (V3 § 2.3's lemmas)
  not claimed: anything about zero-angle regions
  argument: FS121-V3-verification.md § 2.3
  verdict: derived
  grade: hand
  minds: 1
  model: k = 9: SQ9 at a vertex (four right angles)
  prior art: partly: FS111-M-HALF (held: each piece's blow-up lies in a half-plane at a saturated point); here with saturation used only at arc points
  handoff: none — a corollary inside FS121-V2-SECTOR's verification

derivation: FS121-V3-CUSP
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, two zero-angle regions of one colour at a point of Σ have collinear tangent
    directions
  uses only: V3 § 2.3's Lemmas C and D at the two cusps' contacts
  not claimed: that two such cusps cannot occur (FS121-V2-SECTOR leaves it open)
  argument: FS121-V3-verification.md § 2.3
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: R7 at a lattice point (its three down cusps are of distinct colours, so it meets the statement vacuously)
  prior art: partly: FS121-V2-SECTOR's not-claimed case, sharpened
  handoff: none — a sharpening of an open case

derivation: FS121-D3-FALLSAT
  statement: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit pairs (a measurable
    idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper k-colouring
  uses only: maximality of each class alone: a small ball added where a class's support misses a point's unit circle keeps null unit pairs
    (FS111-C-FILL's estimate; V3's Lemma B)
  not claimed: the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D); that any idomatic partition exists with fewer than
    seven classes
  argument: FS121-D3-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: D3 § 2.1 until dea603eb; method: the same small-ball argument, reached independently (one mind on the method axis)
  model: k = 7: R7, a regular maximal partition (FS111-VMW-R7-MAX)
  prior art: partly: FS111-M2-SELCOMP (d) (held) with "regular"; fall colourings of finite graphs, Dunbar et al. 2000 (held under FS-67); measurable
    fall colourings, “(fall colo* | idomatic) & (measurable | Borel | unit distance | plane | Euclidean)” (0) — not found
  handoff: de Bruijn — queued behind the measurable chain (FS-113)

Frozen at § 6. **Held.** It carries the fall property: every point outside `int supp A_j` is `j`-bound (V3 § 3.4 row 3). Rests on it: FS121-D4-FALL.

derivation: FS121-D3-GRUNDY
  statement: every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never raising a point's
    colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with null unit pairs inside the
    complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at distance exactly 1 from the support
    of A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than the largest is bound at x
  uses only: maximal extension inside a region (Zorn with FS111-M-SATC (i)'s chain argument, D3; exhaustion by a weighted measure, dependent choice
    only, V3); a ball of A_m added to A_i where A_i's support misses the unit circle (V3), or FS111-M2-ZERO's relative form and a limit (D3)
  not claimed: that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the output lies above f in any order; any
    regularity of the classes; that a saturated input stays saturated
  argument: FS121-D3-proof.md § 2.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: D3 § 2.2 until dea603eb; method: exhaustion (dependent choice) and a ball added at a support point (V3), against Zorn and a
    positive-density limit (D3)
  model: k = 7: R7 (a Grundy colouring in every order, every class a MUA set)
  prior art: partly: the finite form (an optimal colouring made Grundy by greedy recolouring) is classical, recalled, not read; “(Grundy | b-coloring |
    b-chromatic) & (unit distance | plane | measurable)” (15) — the measurable form not found
  handoff: de Bruijn — queued behind the measurable chain; its dependent-choice route matters to a ZF + DC audit (Soifer's Open AC Problem 62.14)

Frozen at § 6, wording kept: "never raising a point's colour index" holds at every point for exact representatives (V3), almost everywhere as D3
writes it (V3 § 3.3 row 3). **Held.** Rests on it: FS121-SAT6's free half, FS121-C1-GMAP's Grundy-bound class, the cover route's Grundy form.

derivation: FS121-D3-SWAP1D
  statement: on the circle R/(5/2)Z with the unit-distance graph y ~ y ± 1 and the definitions of D-NF, saturation and MUA sets read with S⁰ = {±1} in
    place of S¹, there is no a.e.-proper two-colouring and no partition into three MUA sets, and the colouring by formula of FS121-D3-proof.md § 2.3 is
    an honest saturated a.e.-proper three-colouring, Grundy in the order (a, b, c); so an honest saturated colouring with the least number of colours can
    exist where no idomatic partition with that number does
  uses only: the fibration of the circle by five-cycles (x + o_i + 1 = x + o_(i+1)); C₅ has no proper two-colouring and no idomatic three-partition; the
    nine patterns and their exchanges, checked exactly
  not claimed: anything about the plane; that idomatic partitions fail in the plane at six colours
  argument: FS121-D3-proof.md § 2.3
  verdict: derived
  grade: computed over: the nine patterns and 16 discontinuities of one colouring of R/(5/2)Z, exact rationals; the 243 maps of C₅ to three colours
  minds: 1
  model: the colouring itself
  prior art: new — “(fall coloring | idomatic | Grundy) & (measurable | Borel | infinite graph | unit distance)” (2), “(saturated | maximal) & unit
    distance & (partition | coloring | colouring)” (2), none bearing
  handoff: none — a finite exact model separating two notions; formalizable on demand

control: FS121-D3-SWAP1D
  of: FS121-D3-SWAP1D — the colouring is saturated; with the twist ignored four (point, colour) pairs are unbound
  run: python3 ../tools/fs121_d3_swap1d.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d3_swap1d.py --plant seam 2>&1 | tail -1

derivation: FS121-D3-EQ
  statement: C121-SAT6 at k = 6 holds if χ_m⁰(ℝ²) ≥ 7; its failure implies χ_m⁰(ℝ²) ≤ 6, hence χ(ℝ²) ≤ 6 with no MR; and if no honest saturated
    a.e.-proper colouring of the plane with at most six colours exists, C121-SAT6 at k = 6 holds if and only if χ_m⁰(ℝ²) ≥ 7
  uses only: FS111-V0-RESCALE (a tight six-colouring exists iff χ_m⁰(ℝ²) ≤ 6); χ(ℝ²) ≤ χ_m⁰(ℝ²) (row 130); vacuity
  not claimed: that the hypothesis (a NO for every honest saturated colouring with at most six colours) holds; the biconditional without it
  converse: FS121-D3-proof.md § 3.1
  argument: FS121-D3-proof.md § 3.1
  verdict: derived
  grade: hand
  minds: 1
  model: premises open; at seven its analogue is empty of content, R7 being an honest saturated seven-colouring
  prior art: partly: its shape is FS111-C-REG-EQ's, one rung over; “(saturated | maximal) & unit distance & (partition | coloring | colouring)” (2) none bearing
  handoff: none — a statement of the rung's strength; it enters no proof

derivation: FS121-SAT6
  statement: every tight a.e.-proper k-colouring can be modified, keeping it a.e.-proper with k colours, into an honest (one colour per point) saturated
    one, at k = 5 and k = 6
  argument: FS121-D3-proof.md § 3.5
  verdict: gap: the upper colour (TOP₆) — every tight six-colouring is modified for free into a measurable Grundy colouring bound, at every essential
    boundary point, on every colour of its multicolour but the largest (FS121-D3-GRUNDY); binding the largest is open — not by selection
    (FS111-M2-NOSEL), local moves (FS111-M-DEADLOCK, FS111-W-FILL-FREE), a variational selection without a compactness that keeps honesty, or an idomatic
    partition, which is strictly stronger (FS121-D3-SWAP1D); a proof must spend six (FS121-D3-EQ)

Frozen as C121-SAT6 (§ 4), worked at `k = 6`; FS111-C-SAT-T-HONEST's statement. One mind. TOP₆ implies it and is not shown to follow from it.
Rests on it: the honest route's composition (SAT₆ ∧ REG-J′₆ ∧ ¬LRA ∧ the NO); FS-128.

derivation: FS121-D2-INCURVED
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then the
    colouring has tangent-type interface arcs of finite radius at least 2, infinitely many of them
  uses only: FS111-M-C11 (iii) (a split point makes the whole local interface one unit arc); all but finitely many pieces have radius at least 2
  not claimed: the converse; that such a colouring is cusp-free (C121-CURVED's class also asks no colour of density 0)
  argument: FS121-D2-proof.md § 1.3
  verdict: derived
  grade: hand
  minds: 1
  model: none held of the hypothesis at any k; a containment of two uninhabited classes
  prior art: new — “(evolute | focal set | caustic) & (parallel curve | unit distance | colo*)” (14), “(chromatic number of the plane | unit distance
    graph | measurable chromatic) & (curvature | evolute | parallel curve | arc*)” (4), none bearing
  handoff: none — a relation between two claims; it crosses with FS121-Z1-NOCURVED

derivation: FS121-D2-EXT
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, let a be a point of an interface arc, not in Σ, at which the arc passes from a
    circular piece γ of radius n ≥ 3 and centre z to a piece not on γ's circle, and let L be the normal line at a; then for every integer k with
    1 ≤ k ≤ n − 2, and for every integer k ≤ −1, no arc of the circle ∂B(z, n − k) that lies on the far side of L from γ and has an end on L lies in the
    closure of the interface set
  uses only: FS111-M2-INTRAD step (1) on either side, iterated |k| times; FS111-M-C11 and its clause (iii); REG-J′; two distinct circles, or a circle and
    a line, tangent at a point meet only there near it; no cusp-freeness
  not claimed: anything about a continuation past L along another curve; anything when a is a point of Σ; the unit rung, n − k = 1
  argument: FS121-D2-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has a junction inside an interface arc)
  prior art: new — “(evolute | focal set | caustic) & (parallel curve | unit distance | colo*)” (14), “(piecewise circular | circular arcs | biarc*) &
    (accumulat* | infinitely many) & (curvature | radii)” (1), none bearing
  handoff: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD; its geometric core is elementary

control: FS121-D2-EXT-CORE
  of: FS121-D2-EXT — its last step, exact: tangent circles (or a circle and a line) meet only at the point of tangency; the plant adds γ's own circle
  run: python3 ../tools/fs121_d2_geom.py ext
  expect: 0
  fault: python3 ../tools/fs121_d2_geom.py ext --plant

derivation: FS121-D2-THIN
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then for
    every integer r ≥ 2 the colouring has infinitely many radius-r arcs — maximal arcs of circles of radius r contained in the closure of the interface
    set — whose angular windows tend to 0
  uses only: FS111-M2-INTRAD step (2) and (iii); REG-J′; parallel curves share normals; FS121-D2-EXT at each piece's two junctions; no cusp-freeness
  not claimed: that the thin arcs lie in a bounded set; the converse; anything at r = 1; accumulations by segment pieces (the argument takes circular
    pieces; V5 § 3.3 supplies the segment case at one mind, over M2-INTRAD's per-radius finiteness)
  argument: FS121-D2-proof.md § 2.2
  verdict: derived
  grade: derived from: FS121-D2-EXT
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has LRA)
  prior art: new — “(finite local complexity | local complexity) & (curvature | circular arc | colouring | coloring | unit distance)” (5), “(evolute |
    focal set | caustic) & (parallel curve | unit distance | colo*)” (14), none bearing
  handoff: none — a necessary condition on an uninhabited class; it crosses with FS121-D2-SYM

control: FS121-D2-TRANSPORT
  of: FS121-D2-THIN — window transport, exact: a rung subtends at the centre the angle its piece subtends; the plant shifts the rung's centre
  run: python3 ../tools/fs121_d2_geom.py transport
  expect: 0
  fault: python3 ../tools/fs121_d2_geom.py transport --plant

derivation: FS121-D2-SYM
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of its
    radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each mapping the
    partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly periodic colouring — then
    ¬LRA holds
  uses only: FS121-D2-THIN (D2), or FS111-M2-INTRAD's parallel step, FS121-O1-OUT, FS111-M-C11 and FS121-V5-RAY (V5); for the in-particular clause and for
    segment pieces, FS111-M2-INTRAD's per-radius finiteness (one mind, VM2-FIN′); no colour count; no cusp-freeness
  not claimed: ¬LRA without such a bound (C121-NOLRA's open step); that a tight colouring can be taken symmetric; anything from a bound at r = 1
  argument: FS121-D2-proof.md § 2.3
  verdict: derived
  grade: derived from: FS121-D2-THIN
  minds: 2 — blind to: D2 § 2 until V5's verdict was committed (ab25bbdc; V5 was relayed four header definitions of D2's record); method: the window
    carried back out to the piece's radius by FS121-O1-OUT, then a segment in Σ by FS121-V5-RAY (V5), against window transport stopped at junction
    normals by FS121-D2-EXT (D2)
  model: k = 7: R7; k = 9: SQ9 and HEX9 — doubly periodic, no arc of radius ≥ 2, so the bound holds vacuously and ¬LRA holds
  prior art: new — “(finite local complexity | local complexity) & (curvature | circular arc | colouring | coloring | unit distance)” (5), “(chromatic
    number of the plane | unit distance graph | measurable chromatic) & (curvature | evolute | parallel curve | arc*)” (4), none bearing
  handoff: de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113); V5's route needs only FS121-V5-RAY beyond held inputs

Frozen at § 8. **Held** where the accumulating pieces are circular arcs (reading (Lfin)), as item 73 rules; under the reading that counts segments,
the segment case is V5's alone, and the symmetric clause rests on M2-INTRAD's per-radius finiteness at one mind. "An arc" has positive length (V5
§ 4.1 row 7). Rests on it: FS121-D2-PERFIN; the periodic case of C121-NOLRA; FS-115's re-posing.

derivation: FS121-D2-PERFIN
  statement: in a doubly periodic honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, the interfaces carry only finitely
    many radii of curvature
  uses only: FS121-D2-SYM; REG-J′ (finitely many interface arcs meet a compact set); FS111-M2-INTRAD (iii); compactness of an interface arc
  not claimed: anything for colourings that are not periodic; that a tight colouring can be taken periodic
  argument: FS121-D2-proof.md § 2.3
  verdict: derived
  grade: derived from: FS121-D2-SYM
  minds: 1
  model: k = 7: R7 (one radius, 1); k = 9: SQ9 and HEX9 (radius infinite only)
  prior art: partly: C121-PER states the conclusion for doubly periodic colourings satisfying ¬LRA; without ¬LRA not found
  handoff: none — it removes a hypothesis from C121-PER's periodic clause; it crosses with FS121-D2-SYM

derivation: FS121-NOLRA
  statement: in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, ¬LRA holds
  argument: FS121-D2-proof.md § 3.2
  verdict: gap: excluding thin pencils in colourings without a cocompact symmetry — LRA at a point gives, for every r ≥ 2, infinitely many maximal
    radius-r interface arcs with windows tending to 0 (FS121-D2-THIN), and a positive lower bound on those windows for one r ≥ 2 excludes LRA
    (FS121-D2-SYM); no argument bounds the windows of an aperiodic colouring's radius-r arcs from below; it holds under FS121-Z1-NOCURVED's hypothesis

Frozen as C121-NOLRA (§ 3). One mind. The plan's two handles fail as stated (row 134's N4 holds identically along an LRA line; end counts are finite in
every LRA configuration; D2 § 1.2). Rests on it: the honest route's composition; FS-115, FS-126.

## Round 3 — the cover route (FS121-C1; FS121-V4 blind on the five lemmas)

*The cover route opened on the plan's trigger (`FS121-close-inventory.md` item 35: D3's stop rule fired with honest saturation not reduced to a smaller
step) and is parked behind FS-116 (items 51, 63). Its words — locally finite map colouring, `F_j`, bound, outer unit parallel, far level, `𝒫_k`,
Grundy-bound, G-FIN₆, the chain's frame — are `../data/fs121/claims.md` § 7.0; "bound" is read by its "i.e." clause (`T₁(x)` meets `F_j`).*

derivation: FS121-C1-BOUND
  statement: in a locally finite map colouring, a point x of F_i ∖ S_i is i-bound if and only if it lies on the outer unit parallel or on the far level
    of a connected component of F_i
  uses only: no two points of faces of one colour at distance exactly 1, faces open; closedness and connectedness of components; the intermediate value
    theorem on a connected set; 1-Lipschitz d_C and D_C; no local finiteness beyond F_i = cl S_i
  not claimed: which of the two levels; that the component is unique; anything at points of S_i
  converse: FS121-C1-proof.md § 2.1
  argument: FS121-C1-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS121-C1's record until V4's verdicts were committed (0dde4982); method: a switch point over the local finiteness of faces
    (V4-SWITCH, V4-LF), against a two-line perturbation (C1)
  model: k = 7: R7 at x = (1, √3 − 1) — for the up colour the far level of the up tile itself, for the down colour the outer unit parallel of the
    same-colour down tile whose cusp is the arc's centre; k = 9: SQ9, every edge point on the outer unit parallel of the square one unit across
  prior art: partly: FS111-M2-HULLC (iv) finds the near and far levels on a regular maximal cover's classes, one direction; “("parallel curve" |
    "parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0), “(spindle convex | ball hull | "constant width") & (coloring |
    colouring | chromatic) & distance” (3), none bearing
  handoff: de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation

Frozen at § 7.2. **Held.** Its "locally finite" is idle (V4 Stage 3, BOUND row 2). Model line corrected from V4 Stage 3 row 3 (the count 432 of 432 is
VM2-LAD-CTL's). Rests on it: FS121-C1-GMAP, FS121-C1-SAT.

derivation: FS121-C1-GMAP
  statement: (i) for every k, a Grundy-bound k-colouring that is a.e. equal to a locally finite map colouring makes that map colouring a member of 𝒫_k
    under the order 1 < 2 < … < k; (ii) G-FIN₆ and C121-NOPAR together imply χ_m⁰(ℝ²) ≥ 7, and given C121-NOPAR, G-FIN₆ holds if and only if
    χ_m⁰(ℝ²) ≥ 7
  uses only: FS121-C1-BOUND; supports are invariant under null changes and equal closures for open sets; the definition of χ_m⁰ (row 130); vacuity
  not claimed: G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring
  converse: FS121-C1-proof.md § 2.2
  argument: FS121-C1-proof.md § 2.2
  verdict: derived
  grade: derived from: FS121-C1-BOUND
  minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis), V4 writing out R7's Grundy-boundness
  model: k = 7: R7, every class a MUA set (FS111-VMW-R7-MAX), Grundy-bound in every order
  prior art: partly: the finite form is classical, recalled, not read; “(Grundy | b-coloring | b-chromatic) & (unit distance | plane | measurable)” (15) none bearing
  handoff: de Bruijn — with FS121-D3-GRUNDY, once map colourings and supports are in Lean

Frozen at § 7.2. **Held.** (ii)'s "if" half is vacuous. It is the map step in Grundy form: given C121-NOPAR, G-FIN₆ is the answer restated.

derivation: FS121-C1-SAT
  statement: for every k, a locally finite map colouring with k colours whose edges are finite chains of segments and circular arcs, and whose classes
    form an honest saturated colouring, is a member of 𝒫_k under every total order of its colours; so C121-NOPAR implies that no honest saturated
    six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs
  uses only: FS121-C1-BOUND; densities 1/2 on each side of a smooth arc; saturation at essential boundary points; closedness of F_j + S¹
  not claimed: the converse (a member of 𝒫_k need not be saturated); anything for edges that are not finite chains
  argument: FS121-C1-proof.md § 2.3
  verdict: derived
  grade: derived from: FS121-C1-BOUND
  minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis)
  model: k = 7: R7; k = 9: SQ9 and HEX9
  prior art: new — “(map | tiling) & (curved | smooth | "circular arcs") & "chromatic number" & plane” (1), “(Grundy | b-coloring | b-chromatic) & (unit
    distance | plane | measurable)” (15), none bearing
  handoff: de Bruijn — queued behind FS121-C1-BOUND and the saturated-colouring definitions (FS-113)

Frozen at § 7.2. **Held.** C1's commentary under it — that C121-NOPAR therefore contains FS-116's saturated-class NO (NO-SAT, `../data/fs116/claims.md`
§ 4, an FS-116 statement graded at FS-116's close) — goes through FS111-M2-REDUCE-A, is one mind (C1), and was outside V4's five. Rests on it: the
cover route's parking.

derivation: FS121-C1-COVMAP
  statement: under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that order, of a disc
    containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in 𝒫_7 under no order
  uses only: DISC7's lattice and colouring (FS111-M2-DISC7); the merge rule of FS111-M2-REDUCE-C step (1); one point per (least, second) pair; exact
    arithmetic in Q(√3)
  not claimed: anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level)
  argument: FS121-C1-proof.md § 2.4
  verdict: derived
  grade: computed over: the 42 (least, second) pairs of DISC7's colours and all 5040 orders, one period, exact in Q(√3)
  minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the colour of rank 4 by parity (V4-MID) against the colour of rank 2 (C1), two tools
    written apart (tools/fs121_v4_covmap.py, tools/fs121_c1_disc7.py)
  model: DISC7 itself
  prior art: new — “(spindle convex | ball hull | "constant width") & (coloring | colouring | chromatic) & distance” (3), “("parallel curve" |
    "parallel body" | "outer parallel") & (coloring | colouring | chromatic)” (0), none bearing
  handoff: none — a property of a control object; exact and periodic, formalizable on demand

control: FS121-C1-COVMAP
  of: FS121-C1-COVMAP — every order leaves an edge point unbound on both sides; read in the cover's classes, none does
  run: python3 ../tools/fs121_c1_disc7.py | tail -1
  expect: orders with an edge point bound by neither side colour: 5040 of 5040
  fault: python3 ../tools/fs121_c1_disc7.py --cover | tail -1

Frozen at § 7.2. **Held.** So the stub's NO-PAR, read on the map a maximal cover yields, is the wrong target; on Grundy partitions it is the right one.

derivation: FS121-C1-FLAT
  statement: there are germs L_k, U_k at P_k, for every k ∈ ℤ, with U_k > L_k on both sides of P_k, every one of curvature 0 at P_k, such that for every
    k: L_k is the unit parallel toward P_k of L_{k+1}, and U_k is the unit parallel toward P_k of U_{k−1} (so the relations FS110-N4-FIN states on circular
    arcs, read on germs with L_k below the parallel of L_{k+1} and U_k above the parallel of U_{k−1}, hold with equality for every k, and λ_k = υ_k = 0)
  uses only: the parallel of a line is a line; the exact series of the parallels of y = x⁴ at every signed distance t, and their composition (t symbolic)
  not claimed: that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries
  argument: FS121-C1-proof.md § 2.5
  verdict: derived
  grade: computed over: {the parallel of the germ y = x⁴ at signed distance t : t ∈ ℝ}, as exact power series through X⁶, t symbolic
  minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the same witness (one mind on the method axis), V4 closing the composition as an
    identity in t with k symbolic, C1 as a series to order 6
  model: L_k the lines through P_k, U_k the parallels of (t, t⁴); Y_k(X) = X⁴ + 8kX⁶ + O(X⁸)
  prior art: partly: FS110-NB4's plant records that the constant sequence (0, 0) survives N4-FIN without strictness; its realisation by smooth horns
    not found — “(map | tiling) & (curved | smooth | "circular arcs") & "chromatic number" & plane” (1)
  handoff: none — a statement about where a route stops; exact, formalizable on demand

control: FS121-C1-FLAT
  of: FS121-C1-FLAT — the parallels of y = x⁴ stay flat horns above the line; from a circle-like germ the chain leaves (−1, 1)
  run: python3 ../tools/fs121_c1_flat.py | tail -1
  expect: FLAT CHAIN: ALL HOLD (for every t: Y - t = X^4 + O(X^6), curvature 0, strictly above the line)
  fault: python3 ../tools/fs121_c1_flat.py --circle | tail -1

Frozen at § 7.2, with its parenthetical, which holds and which C1's entry had dropped (V4 Stage 3, FLAT row 4). **Held.**

derivation: FS121-NOPAR
  statement: 𝒫_6 is empty: no locally finite map colouring with six colours has a total order on its colours in which every point of every edge
    separating colours i < m lies on the outer unit parallel or on the far level of a connected component of F_i
  argument: FS121-C1-proof.md § 2.6
  verdict: gap: two named steps — its members failing Condition 5 include every honest saturated six-map bounded by segments and circular arcs with a
    unit arc (FS121-C1-SAT), whose NO is FS-116's saturated-class NO (NO-SAT, ../data/fs116/claims.md § 4); its members under Condition 5 are
    FS121-NOPAR-C5

Frozen as C121-NOPAR (§ 7.1). One mind. With G-FIN₆ it gives seven (FS121-C1-GMAP). Rests on it: the cover route; FS-128.

derivation: FS121-NOPAR-C5
  statement: no member of 𝒫_6 satisfies Condition 5
  argument: FS121-C1-proof.md § 2.6
  verdict: gap: the transfer of row 134's chain from segment-and-arc edges to edges lying on unit parallels — first at the vertex data (one-sided
    tangents and horn curvatures, which the class does not supply), then at FS110-N4-FIN, whose strictness λ_k < υ_k smooth horns lack (FS121-C1-FLAT)

Frozen as C121-NOPAR-C5 (§ 7.1). One mind. The cover route's own new part.

### V4's lemmas (one mind each)

derivation: FS121-V4-SWITCH
  statement: in a locally finite map colouring, for every x ∈ F_i and every connected component K of F_i, d_K(x) ≥ 1 or D_K(x) ≤ 1; so every component of
    F_i has diameter at most 1
  uses only: no unit pair between points of faces of one colour; a switch point where a unit circle about a generic face point runs inside an edge;
    the local finiteness of faces (FS121-V4-LF)
  not claimed: the same without local finiteness (not examined)
  argument: FS121-V4-verification.md § Derivation of C121-C1-BOUND
  verdict: derived
  grade: derived from: FS121-V4-LF
  minds: 1
  model: k = 9: SQ9 (squares of side 1/2, diameter √2/2)
  prior art: partly: FS111-M-HULL2 (a path-connected piece of a class has diameter ≤ 1) is its form for density sets
  handoff: none — a lemma inside a verification

derivation: FS121-V4-LF
  statement: in a locally finite map colouring every bounded set meets finitely many faces
  uses only: plane-graph facts PG1 and SEP (cited unread in V4's record)
  not claimed: anything for graphs with infinitely many edges in a bounded set
  argument: FS121-V4-verification.md § Derivation of C121-C1-BOUND
  verdict: derived
  grade: hand
  minds: 1
  model: k = 9: SQ9
  prior art: partly: standard plane-graph topology, cited unread
  handoff: none — a standard fact, formalized with the plane-graph library if needed

derivation: FS121-V4-EDGE
  statement: in DISC7's merged map under a total order of its seven colours, an arc point of the disc of colour c is unbound by both side colours exactly
    when c lies between the colours of an opposite pair of c's neighbours; the colour of rank 4 always does, so every order leaves at least five unbound
    edge types
  uses only: DISC7's geometry (opposite neighbours at c ± 1, c ± 2, c ± 3); the parity of the ranks; exact arithmetic in Q(√3)
  not claimed: anything about other covers
  converse: FS121-V4-verification.md § Derivation of C121-C1-COVMAP
  argument: FS121-V4-verification.md § Derivation of C121-C1-COVMAP
  verdict: derived
  grade: computed over: one period of DISC7 with max(|m|, |n|) ≤ 8 and all 5040 orders, exact in Q(√3)
  minds: 1
  model: DISC7 itself
  prior art: partly: FS121-C1-COVMAP is its existence half
  handoff: none — a property of a control object

derivation: FS121-V4-HEXMID
  statement: at every edge midpoint of the tight hexagonal seven-colouring neither side colour is bound: the farthest point of its own hexagon is √13/4
    away and the nearest same-colour hexagon of either side is farther than 1
  uses only: the hexagonal seven-colouring's geometry (circumradius 1/2)
  not claimed: anything about other tight seven-colourings
  argument: FS121-V4-verification.md § Attack on C121-C1-GMAP
  verdict: derived
  grade: hand
  minds: 1
  model: the tight hexagonal seven-colouring
  prior art: partly: FS111-M-DEADLOCK (held) is the same geometry; the list's "in no 𝒫_7", re-derived
  handoff: none — a property of a control object

## Round 4 — the singular set (FS121-D4); FS121-V5 blind on FACE and GRID

derivation: FS121-D4-FACE
  statement: in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box
    {x − s e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c,
    with ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has density 1
    at x
  uses only: a.e.-properness, through Fubini on Leb ⊗ σ; the unit circle's sagitta; saturation only in the last clause, at the one point x
  not claimed: the same with a curved near side (a tangent unit disc admits the in-contact x − e); the margin below ρ² ≥ 2g − g² (FALSE there,
    FS121-V5-FACE-SHARP); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)
  argument: FS121-D4-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: D4 §§ 2.1–2.2 until V5's verdicts were committed (4ed402c6); method: a Fubini pair lemma and a crossing criterion with the exact
    corner (V5), against the sagitta bound and a shrinking ε′ (D4)
  model: V5 § 2.2's non-saturated colouring: g = 1/20, ρ = 2/5, ε = 1/10, ε′ = 1/20, S_c = the half-box and the box, the strip between them in a
    second colour, the rest by squares of side 1/4 in 36 colours; c has density 1/2 at x, and the first clause holds there
  prior art: new — “(unit distance | distance one | forbidden distance) & (singular set | locally finite | free boundary | accumulat*)” (2),
    “(saturated | maximal) & (unit distance | distance graph) & (colouring | coloring | partition) & (boundary | regular*)” (2), none bearing
  handoff: de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurable chain

Frozen at § 8. **Held.** Model line from V5 § 2.2 (D4's named none inside the hypotheses, item 78). Its margin is not sharp (FS121-V5-FACE-SHARP).
Rests on it: FS121-D4-GRID; LAT's use in FS121-REGJ.

derivation: FS121-D4-GRID
  statement: in every honest saturated a.e.-proper grid colouring with finitely many colours — closed countable sets B_x, B_y ⊂ ℝ, a.e. one colour on
    each open cell I × J of ℝ ∖ B_x by ℝ ∖ B_y, cells sharing an edge of positive length coloured differently — B_x and B_y are locally finite, so the
    singular set Σ is locally finite and each point of Σ meets at most four interface arcs
  uses only: FS121-D4-FACE; the pigeonhole on finitely many colours; a countable closed subset of ℝ is scattered (D4), or Cantor–Bendixson (V5); the
    adjacency rule
  not claimed: B_x or B_y uncountable (the breakpoint clause is false there — SQ9 with a null Cantor set of redundant breakpoints in one column,
    FS121-V5-GRID-CANTOR — and the Σ clause is open); grid colourings in which adjacent cells may share a colour; any bound on breakpoints per length
  argument: FS121-D4-proof.md § 2.2
  verdict: derived
  grade: derived from: FS121-D4-FACE
  minds: 2 — blind to: D4's argument until 4ed402c6, but given its key lemma, FS121-D4-FACE, by name in the frozen list; method: consecutive thin
    columns by Cantor–Bendixson and a pigeonhole over k + 1 of them (V5), against isolated breakpoints near the accumulation (D4)
  model: k = 9: SQ9 (B_x = B_y = ½ℤ); k = 16: FS121-D4-TINY16 (cells of side ε)
  prior art: new — “(unit distance | distance one | forbidden distance) & (singular set | locally finite | free boundary | accumulat*)” (2),
    “(avoiding distance | without unit distance* | avoiding sets | distance avoiding) & (boundary | regular* | curvature | locally finite)” (2), none bearing
  handoff: none — a class result that sorts the determiners; it crosses with FS121-D4-FACE if the class is wanted in Lean

Frozen at § 8; its not-claimed parenthesis corrected from V5 § 4.3 row 3 (it said "GAP there"). **Held, with item 73's caveat** (the second mind was
given FACE by name). `Σ` equals `B_x × B_y`, four arcs at each point (V5). Rests on it: LAT's grid case.

derivation: FS121-D4-HOLE
  statement: in an honest saturated colouring in D-NF, if a region D (a component of the interior of the density set of one colour) has a bounded
    complementary component K of its closure, then every point of ∂K lies in Σ; so Σ contains a non-degenerate continuum, and a colouring whose Σ is
    locally finite has no region with a hole
  uses only: FS111-M-PINCH at a point off Σ (both types); C-HULL's first clause at the contact; FS111-M-HULL2 (diam D ≤ 1); a bounded complementary
    component lies in the convex hull; the definition of Σ
  not claimed: that a region with a hole exists or not; anything about unbounded complementary components; REG-J′ (unused)
  argument: FS121-D4-proof.md § 2.3
  verdict: derived
  grade: hand
  minds: 1
  model: none held of the hypothesis (R7, SQ9, HEX9, TINY16 have no region with a hole); a no-go for islands whose shore holds a point off Σ
  prior art: new — “(unit distance | distance one | forbidden distance) & (singular set | locally finite | free boundary | accumulat*)” (2),
    “(saturated | maximal) & (unit distance | distance graph) & (colouring | coloring | partition) & (boundary | regular*)” (2), none bearing
  handoff: none — a structural no-go between open statements; it crosses with FS111-M-PINCH

derivation: FS121-D4-LINE
  statement: on the real line with the unit graph x ~ x ± 1, every colouring f(x) = (⌊x⌋ + v(x − ⌊x⌋)) mod 2 with v measurable is proper at every unit
    pair, honest and saturated; with v(t) = ⌊1/dist(t, Z₀)⌋ mod 2, Z₀ = {0} ∪ {1/n}, its singular set contains Z₀ + ℤ and is not locally finite — the
    line analogue of C121-REGJ is false with two colours
  uses only: f(x + 1) = 1 − f(x); the definitions of ∂_e S_j, saturation and Σ read on intervals
  not claimed: anything in the plane; anything on a circle of length 5/2
  argument: FS121-D4-proof.md § 2.4
  verdict: derived
  grade: hand
  minds: 1
  model: v as stated; checked exactly by ../tools/fs121_d4_tiny16.py at 11,760 rational points
  prior art: new — “(avoiding distance | without unit distance* | avoiding sets | distance avoiding) & (boundary | regular* | curvature | locally
    finite)” (2), “(saturated | maximal) & (unit distance | distance graph) & (colouring | coloring | partition) & (boundary | regular*)” (2), none bearing
  handoff: none — a calibration that sorts the dimension as a determiner

derivation: FS121-D4-TINY16
  statement: for every ε in (0, 1/2) the product of two copies of the partition of the line at m, m + ε, m + 1/2 (m ∈ ℤ), gaps coloured by their index
    mod 4, is an honest saturated a.e.-proper sixteen-colouring of the plane whose cells include squares of side ε; so a saturated colouring with a fixed
    number of colours can have regions of every small diameter, and no count of singular points per region bounds Σ per unit area
  uses only: translation by 1 shifts the gap index by 3, so same-coloured gaps are 4 apart in index and at least 1 apart in position; contacts at unit
    translates along the normals
  not claimed: that sixteen is least for small regions; any accumulation (FS121-D4-GRID excludes it in its class)
  argument: FS121-D4-proof.md § 2.5
  verdict: derived
  grade: computed over: ε = 1/10 on the window [−3, 7]² of the 4ℤ²-periodic colouring, exact rationals; the hand argument for every ε
  minds: 1
  model: TINY16 at ε = 1/10
  prior art: new — “(saturated | maximal) & (unit distance | distance graph) & (colouring | coloring | partition) & (boundary | regular*)” (2),
    “(unit distance | distance one | forbidden distance) & (singular set | locally finite | free boundary | accumulat*)” (2), none bearing
  handoff: none — a control object, exact and periodic

control: FS121-D4-TINY16
  of: FS121-D4-TINY16 — every same-colour pair proper and every contact present; with the gaps coloured mod 3 properness fails
  run: python3 ../tools/fs121_d4_tiny16.py 2>&1 | tail -1
  expect: ALL HOLD
  fault: python3 ../tools/fs121_d4_tiny16.py --plant mod3 2>&1 | tail -1

derivation: FS121-D4-FALL
  statement: if C121-REGJ holds, then every measurable idomatic partition of the plane into finitely many maximal unit-avoiding sets has a locally
    finite singular set with finitely many interface arcs at each of its points; so a measurable fall colouring at any k whose singular set is not
    locally finite — for instance a regular maximal partition containing a Cantor pinch of FS111-M3-HC's type — refutes C121-REGJ
  uses only: FS121-D3-FALLSAT
  not claimed: that such a fall colouring exists; the converse (a saturated colouring need not be idomatic, FS121-D3-SWAP1D)
  argument: FS121-D4-proof.md § 3.2
  verdict: derived
  grade: derived from: FS121-D3-FALLSAT
  minds: 1
  model: k = 7: R7, a regular maximal partition with Σ the lattice
  prior art: known: a corollary of FS121-D3-FALLSAT
  handoff: none — a routing remark: it puts FS-120's pinch on C121-REGJ's path

derivation: FS121-REGJ
  statement: in every honest saturated colouring in D-NF, with any number of colours, the singular set Σ is locally finite and each point of Σ meets
    finitely many interface arcs
  argument: FS121-D4-proof.md § 3.3
  verdict: gap: LAT — at every accumulation point of Σ or of interface arcs some colour has two pieces in FS121-D4-FACE's position (a half-box at a point
    where it lacks density 1, a same-colour box of lateral half-width ρ straight ahead across a gap g with 2g < ρ²); LAT with FS121-D4-FACE gives the
    claim; LAT holds on grid colourings with countable breakpoints (FS121-D4-GRID), its line analogue fails (FS121-D4-LINE); open where same-colour
    pieces shrink in every direction faster than the square root of their gaps

Frozen as C121-REGJ (§ 4). One mind. Per-region counts are idle (FS121-D4-TINY16); a fall colouring with a Cantor pinch would refute it
(FS121-D4-FALL). Rests on it: the honest route's composition; FS-127.

### V5's lemmas (one mind each)

derivation: FS121-V5-PAIR
  statement: in an a.e.-proper measurable colouring, if for every w in an open set V the unit circle T₁(w) meets one class S_c in an arc of positive
    length that lies a.e. in S_c, then S_c ∩ V is null; and under FS121-D4-FACE's hypotheses the gap satisfies g < 1/8
  uses only: Fubini on Leb ⊗ σ (the pair lemma); the diameter bound for a class component
  not claimed: anything without a.e.-properness
  argument: FS121-V5-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1
  model: the hypotheses of FS121-D4-FACE at g = 1/20, ρ = 2/5 (V5 § 2.2's model)
  prior art: partly: the Fubini fact is FS-106's (held, as D4 uses it)
  handoff: none — lemmas inside a verification; they cross with FS121-D4-FACE

derivation: FS121-V5-FACE-SHARP
  statement: in FS121-D4-FACE's setting, the first clause holds whenever ρ² ≥ 2g − g², that is (1 − g)² + ρ² ≥ 1, and fails for some colouring whenever
    ρ² < 2g − g²
  uses only: FS121-V5-PAIR; the exact corner of the far box against the unit circle about x + e; for the failure, an explicit a.e.-proper colouring (g =
    1/10, ρ = 2/5, a small box Q just beyond x + e) checked exactly
  not claimed: anything about curved near sides
  argument: FS121-V5-verification.md § 2.2
  verdict: derived
  grade: hand
  minds: 1
  model: g = 1/10, ρ = 11/25 (outside 2g < ρ², inside the sharp condition); the counterexample g = 1/10, ρ = 2/5 below it
  prior art: partly: FS121-D4-FACE is its sufficient half
  handoff: none — it sharpens a held lemma's margin

control: FS121-V5-FACE-CEX
  of: FS121-V5-FACE-SHARP — below the sharp margin the first clause fails, exactly
  run: cd .. && python3 tools/fs121_v5_face.py cex
  expect: True
  fault: cd .. && python3 tools/fs121_v5_face.py cex --fault

derivation: FS121-V5-GRID-CANTOR
  statement: the breakpoint clause of FS121-D4-GRID fails without countability: SQ9 with a null Cantor set of redundant breakpoints added inside one
    column, every sub-cell keeping its column's colour, meets every other hypothesis, and its B_x is not locally finite
  uses only: no two gaps of a Cantor set share an endpoint; the colouring is SQ9 almost everywhere
  not claimed: anything against the Σ clause (Σ is SQ9's there)
  argument: FS121-V5-verification.md § 2.4
  verdict: derived
  grade: hand
  minds: 1
  model: the colouring itself
  prior art: partly: FS121-D4-GRID's not-claimed case, now decided for the breakpoint clause
  handoff: none — a counterexample to a removed hypothesis

derivation: FS121-V5-LOC
  statement: in an honest saturated colouring in D-NF satisfying REG-J′ with interface set 𝓘: (i) cl 𝓘 ∖ Σ ⊆ 𝓘, and no point of 𝓘 is a density point of
    any class; (ii) each y ∈ cl 𝓘 ∖ Σ has a ball missing Σ in which cl 𝓘 is the graph of a C^{1,1} function over the tangent line at y; (iii) a circular
    or straight arc of positive length in cl 𝓘 is, at its points off Σ and its ends, interior to a piece on its own circle or line, of tangent type when
    its radius is not 1
  uses only: the definitions of ∂_e and Σ (cusps); FS111-M-PINCH and FS111-M-C11 at points off Σ
  not claimed: anything at points of Σ
  argument: FS121-V5-verification.md § 3.1
  verdict: derived
  grade: hand
  minds: 1
  model: k = 7: R7 (its interface set is the unit arcs, Σ the lattice)
  prior art: partly: FS111-M-C11 (held) is the local regularity it packages
  handoff: none — local lemmas consumed by FS121-V5-RAY

derivation: FS121-V5-RAY
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, let C_n ⊆ cl 𝓘 be arcs of circles of radii R_n → ∞, or segments, no two sharing
    a sub-arc of positive length, with points p_n ∈ C_n, p_n → x₀, from which C_n continues for arclength at least λ > 0 with unit tangent u_n → u; then Σ
    contains the open segment (x₀, x₀ + λu), so Σ is not locally finite
  uses only: FS121-V5-LOC; FS111-M-C11; uniform convergence of the arcs to the ray
  not claimed: anything for arcs of bounded radius
  argument: FS121-V5-verification.md § 3.1
  verdict: derived
  grade: derived from: FS121-V5-LOC
  minds: 1
  model: none held of the hypothesis at any k (no held colouring has arcs of radius ≥ 2); the statement is a contradiction lemma
  prior art: partly: FS121-D2-EXT does the equivalent work at a junction
  handoff: de Bruijn — a self-contained lemma over FS111-M-C11 that both routes to FS121-D2-SYM can rest on (item 79)

derivation: FS121-V5-SYM-UP
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if the radius-r arcs, for some r ≥ 2, have windows at least θ₀ > 0, then every
    circular piece of finite radius R ≥ r lies in a radius-R arc of window at least θ₀
  uses only: FS111-M2-INTRAD's parallel step inward to radius r; FS121-O1-OUT outward over the window; FS121-V5-LOC (iii)
  not claimed: anything below r
  argument: FS121-V5-verification.md § 3.5
  verdict: derived
  grade: derived from: FS121-V5-LOC
  minds: 1
  model: k = 7: R7, k = 9: SQ9 and HEX9 (vacuous: no arc of radius ≥ 2)
  prior art: partly: FS121-D2-THIN's window transport, run outward
  handoff: none — a strengthening inside a verification

derivation: FS121-V5-SYM-CPT
  statement: in an honest saturated colouring in D-NF satisfying REG-J′ invariant under a group of isometries of the plane, each mapping the partition to
    itself up to a permutation of the colours, with a compact set whose images cover the plane, no interface piece is a tangent-type arc of finite radius:
    every curved interface is a unit arc of split type, of kind both
  uses only: FS121-O1-OUT; FS121-V5-SYM-UP; the window bound a cocompact symmetry gives (V5 § 3.4, over FS111-M2-INTRAD's per-radius finiteness, one
    mind); FS121-V5-RAY
  not claimed: that a tight colouring can be taken symmetric; anything without a cocompact symmetry
  argument: FS121-V5-verification.md § 3.5
  verdict: derived
  grade: derived from: FS121-V5-SYM-UP, FS121-V5-RAY
  minds: 1
  model: k = 7: R7; k = 9: SQ9 and HEX9
  prior art: partly: C121-PER (held) for doubly periodic colourings satisfying ¬LRA; FS121-D2-PERFIN with C121-PER reaches the doubly periodic case by a
    second, independent route
  handoff: none — it removes ¬LRA from C121-PER for every cocompact symmetry; it crosses with FS121-D2-SYM

## The close's composition (FS121-Z1)

*Argument.* Suppose no honest saturated colouring in D-NF satisfying REG-J′ has a tangent-type interface arc of finite radius at least 2, cusps
allowed. (i) An (R2) arc is a unit arc whose centre does not carry its inner colour; no point of it is split (split puts both colours at the centre), so
it is tangent type throughout, and by FS121-O1-OUT its outward unit parallel is, off Σ, a tangent-type interface arc of radius 2 — excluded. So no
(R2) arc occurs, and C121-R2-FOUR holds vacuously. (ii) LRA would give tangent-type arcs of finite radius at least 2 (FS121-D2-INCURVED) — excluded;
so ¬LRA. (iii) A curved interface off Σ of radius at least 2 is of tangent type (FS111-M-C11 (iii)), so it is excluded; a curved interface of radius 1
is a split unit arc of kind both, or a tangent unit arc, whose outward parallel is excluded as in (i). ∎

derivation: FS121-Z1-NOCURVED
  statement: if no honest saturated colouring in D-NF satisfying REG-J′ has a tangent-type interface arc of finite radius at least 2, then in every such
    colouring no (R2) arc occurs (so C121-R2-FOUR holds vacuously), ¬LRA holds, and every curved interface is a split unit arc of kind both
  uses only: FS121-O1-OUT (an (R2) arc's outward parallel is a tangent-type arc of radius 2); FS121-D2-INCURVED; FS111-M-C11 (iii)
  not claimed: the hypothesis (C121-CURVED's negation with cusps allowed, open); anything about REG-J′ itself or about honest saturation at six
  argument: § The close's composition (FS121-Z1)
  verdict: derived
  grade: derived from: FS121-O1-OUT, FS121-D2-INCURVED
  minds: 1
  model: k = 7: R7; k = 9: SQ9 and HEX9 (each meets the hypothesis and the conclusion)
  prior art: partly: D2 § 3.3 records that an obstruction to curved tangent interfaces decides C121-NOLRA; the (R2) half and the composition not found
  handoff: none — the frame of stub FS-126, not a statement a proof consumes yet

Rests on it: FS-126's frame; the observation (`FS121-Z1-close.md` § 2.5) that three of the milestone's six open claims are one question.
