# FS-112 — theorems proved outside the kernel (the derivation file)

*Filed by the close planner FS112-C (de Bruijn, Opus 5.5), 2026-09-27, from the records `plans/FS112-N-proof.md` (the proof side: FS112-N, then
§ Continuation — FS112-N2, FS112-N3), `plans/FS112-Y-construction.md` (the construction side: FS112-Y, then § Continuation — FS112-Y2) and
`plans/FS112-Y3-construction.md` (FS112-Y3; the sides blind to each other throughout), the blind verifiers `plans/FS112-NB-verification.md`,
`FS112-NB2-`, `FS112-NB3-`, `FS112-YB-`, `FS112-YB2-verification.md` (and `FS112-YB3-verification.md`, folded in at stage 1b when it reports), the reading
job `plans/FS112-PA-reading.md` with `data/fs112/fs112-pa/extracts.md`, and the advisors `plans/POROS-2026-09-27-fs112-unit-arc-half.md` (FS112-A) and
`plans/POROS-2026-09-27-fs112-competition.md` (A2, A3). Reconciliation: `data/fs112/fs112-c/reconciliation.md`. Notation: `data/fs112/claims.md` §0
(`Γ`, `P_cl`, `ω(x)`, the contact kinds in-, out-, both, inert), `plans/FS112-N-proof.md` §1.3 (N-E0, N-E1, N-E2) and FS-110's N4 frame (`n`, `a ⊥ n`,
chains `P_k = v + kn` with horn curvatures `λ_k < υ_k`, `f(λ) = λ/(1 + λ)`, `f̃(υ) = υ/(1 − υ)`). A map is **valid** when it is a locally finite map of
the plane bounded by segments and circular arcs, **arcs of radius 1 allowed** (Condition 5 dropped), carrying a six-colouring in which no two interior
points of one colour are at distance exactly 1. A **unit arc** is a boundary arc of radius 1; **(Q)** an arc whose centre carries both side colours and
at least four colours; **(R2)** an arc whose centre carries the outer side colour and not the inner, with an inner-colour tile along the radius-2 circle
over the whole arc. `M*` is a terminal valid modification (N2-TERM). `F(M)`: the vertices of at least four colours; `R(M)`: the vertices carrying a
repeated colour. Grades carry no nested brackets.*

**The milestone's result in one paragraph.** FS-112 asked whether a tight six-map exists once boundary arcs of radius 1 are allowed. **Not decided.**
**The NO is reduced to one statement about every valid map**, at [hand], its links at two minds, one blind: every valid map has a vertex of at least
four colours or a repeated colour within 3 of every point (FS112-N3-DENSE3), because row 134's base still refutes a map near any cubic trichromatic
vertex whose disc of radius 2 holds neither (FS112-N3-BASE) — on the way, Condition 5's chain was walked under unit arcs (first break NB-4), every unit
arc was reduced to a four-colour both-centre (Q) or the radius-2 configuration (R2) (FS112-N2-RED), and the cone removal was found to fail only along
one-sided stuck chains (FS112-N2-RAY). The close derives how the two remaining steps compose (FS112-C-COMPOSE): excluding such maps is the NO itself,
for every map, with no ray step; for doubly periodic maps it reduces to excluding four-colour vertices within `|K| + 2` of every point; for aperiodic
maps that four-colour form needs the stuck ray excluded **and** finite stuck chains bounded (a third GAP, named here). **The YES stalls at a named
obstruction**: both printed positives — `[AxenovichEtAl2014]`'s strip and `[Polymath2021]`'s disk, rebuilt exactly and blind, every arc of kind both at
a four-colour vertex — stop at the same point, the unsaved second common unit point of a close complementary pair (the pinned corner), which is where
FS112-N3-COR3 says a valid map needs a second four-colour vertex; the tactic's own move shrinks the bare wedge there and does not close it. Nothing
moves a value; nothing answers a posed question.

## §1. The proof side, rounds 1–2: the walk, the unit-arc calculus and the reduction

**FS112-WALK — Under unit arcs, Condition 5's chain (row 134) breaks first at C-CHAIN-1, NB-4; N3-CONF, W-MERGE, N4-RAY and N4-FIN as a statement hold as written; every other step holds off unit-arc centres at points it reads (its vertex, points of its ring, the antipodes N and S′); the headline fails as a proof. [hand; two minds, one blind, letter for letter: N; NB. Y's walk a third, not blind]**
*Proof:* N §1.4 (every step, the circles it reads, the exception by contact kind); NB §1.4, §2.3 (blind; one reversal, FLANK, the side's way); Y §1.4,
§2.3. *Proof verdict:* TRUE. N's row 9 ("its application also survives") is overstated twice — N4-FLANK fails at `κ = ±1` (FS112-FLANK) and N4-FIN's
application fails at a chain's end (FS112-N2-RAY). "The exception is realised locally by T2" (NB's and A2's stage 1) withdrawn: FS-110's fragments are
below NB-4's reading radius (all-straight BB also has four-colour vertices); the break is realised exactly by the strip's midline vertex
(FS112-CAL-STRIP). *Rests on it:* the whole proof side. *Prior art:* not found in print; the chain is row 134's. *Kernel:* declined — a verdict table.

**FS112-U1 — At a unit arc `α ⊂ ω(P)` of angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed cone of width `π − ℓ` facing `α`, an outer one in the closed cone facing away; both side cones hold neither; the outer tile's first-order shadow near `P` contains the open facing cone of width `π + ℓ`. [hand; two minds, one blind: N; NB]**
*Proof:* N §1.3; NB-U1 (`π + ℓ` "contains", equality when `cl T_out ∩ ω(P) = ᾱ`). *Proof verdict:* TRUE with NB's precision. Answers **C-UA-WEDGE:
MISSTATED** as written ("the `c`-tiles at `P` face the arc" fails for the outer colour); corrected as above, TRUE — three minds (N; NB; YB, blind, all 12
strip arcs). *Rests on it:* every later lemma of the side. *Prior art:* TS-U's content (`plans/FS106-TS-derivation.md`, row 132), re-derived as a shadow
statement. *Kernel:* stub — with the NO's map argument (FS-114).

**FS112-SIX — A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, every arc of kind both. [hand; two minds, one blind: N; NB]**
*Proof:* N §1.3; NB-SIX. *Proof verdict:* TRUE. De Grey's covering step for C-V56 ("those six tiles must jointly cover a disk of radius 1") is a GAP —
exactly his unproved merge `[08.16]` (NB §1.6). *Rests on it:* FS112-N2-DENSE, FS112-N3-DENSE3. *Prior art:* the six-colour picture is argued in
`[Polymath16threads]` (`[08.17]` de Grey, `[08.18]` Gibbs), conditional on an unproved transformation. *Kernel:* stub — with FS-114.

**FS112-NB4P — NB-4 corrected: at a vertex of exactly four colours, let `(v, y₀)` be a covering pair at a change point of its ring; if no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its closure, contradiction; the bound on the colours at `y_k` is not needed. [hand; three minds, one blind: N; NB; Y2]**
*Proof:* N §2.1 W1 (N112-NB4′); NB-NB4′ (blind, the same alternation); Y2 §3.2 (Y2-NB4, after retracting Y112-NB4-MIS's (γ)). *Proof verdict:* TRUE.
**Correction owed to `plans/FS110-derivation.md` l. 42** (FS110-NB-4's "general form"): read it as NB4P — delete "`ω(y)` or", read "through" as "in the
closure of", add "or an orbit point in the closure of an arc of `ω(v)`"; the printed `ω(y_k)` clause (FS110-NB l. 164) is impossible as written.
Answers **C-UA-BUDGET branch 2: MISSTATED**; its derivable form is this statement (N; NB), and the stated form is FALSE in both senses
(FS112-BUDGET2). *Rests on it:* FS112-N2-TERM, FS112-N2-DENSE. *Prior art:* its four-colour half under Condition 5 is `[SokolovVoronov2025]` Lemma 2.
*Kernel:* stub — with FS-114.

**FS112-A4SIX — A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows (C-UA-BUDGET, branch 1). [hand; three minds, one blind: A4; N; NB]**
*Proof:* `plans/POROS-2026-09-27-fs110-competition.md` § A4-1; N §1.4 row 1; NB §1.6. *Proof verdict:* TRUE. On the strip its hypothesis is vacuous in the
union sense and met in the disjoint sense, and its conclusion holds unconditionally (four arcs, 62.09°, exact; A3-1.4). *Rests on it:* the (E1) branch
of FS112-NB4P. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-L60 — A unit arc with constant sides has angular length below 60°; along it neither side colour recurs 60° apart. [hand; two minds, one blind: N; NB; tools exact]**
*Proof:* N §2.2 (the outer tile's diameter); NB-L60 (N-E2 at `w ± 60°`, a wider scope); `tools/fs112_n_arcs.py` L60, `tools/fs112_n2_checks.py` L60 with its
red plant `l60_fifty`. *Proof verdict:* TRUE. *Rests on it:* FS112-N2-RED, FS112-N3-COR3. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-LOCK — For `w` interior to a unit arc `α ⊂ ω(P)`, a tile of either side colour touches `ω(w)` only at `P`, or — the inner colour only — at `P + 2e_w`, from outside `B(P, 2)`. [hand; two minds, one blind, different routes: N; NB; the outer colour's exclusion at radius 2 tools exact]**
*Proof:* N §2.2 (a shadow half-plane); NB-LOCK (N-E2's two-sidedness); R2OUT, R2IN in `tools/fs112_n2_checks.py`. *Proof verdict:* TRUE. N's sentence
"its 'finitely many isolated contact points' do not exist in the arc's interior" (N l. 231) is FALSE (FS112-ISO). *Rests on it:* FS112-BEND,
FS112-N2-BENDS. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-BEND — Off its end vertices a unit arc can be bent off radius 1, keeping validity and creating no unit arc: toward `P` unless its outer colour is at `P`; away from `P` unless its inner colour is at `P` or lies along the radius-2 circle. [hand; two minds, one blind: N; NB]**
*Proof:* N §2.2; NB-BEND, NB-INERT. *Proof verdict:* TRUE off end vertices (their GAP closed by FS112-N2-BENDS). Answers **ARC-INERT: TRUE and sharper**
— an inert arc bends toward its centre with no exceptional interior point (two minds; three with N2-TOWARD at the ends). YB-LOCK (FS112-YB-LOCK) is the
converse on a both arc. *Rests on it:* FS112-N2-RED. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-ISO — Isolated inner-colour contacts at `P + 2e_{w₀}` exist locally (an inner-colour tile outside `B̄(P, 2)` but for a corner), and block a first-order away-bend. [hand; two minds: NB; N2 conceding]**
*Proof:* NB §2.3 #4 (the local corner example); N2 stage N2-1. *Proof verdict:* TRUE; it refuted N's l. 231 and exposed a GAP in N112-RED that N had not
named — FS-112's divergence of truth found by a verifier. Closed by N2-TAN. *Rests on it:* FS112-N2-BENDS. *Prior art:* not found in print. *Kernel:*
declined — a local example.

**FS112-N2-BENDS — A whole unit arc, end vertices included, bends toward its centre whenever its outer colour is absent there, and away whenever its inner colour is absent there and no inner-colour tile touches the radius-2 arc `R₂(ᾱ)`; isolated R2 contacts are cleared by a tangent bend, and only R2 along an arc blocks. Its lemmas: every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it (N2-SIGN); a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` or near `R₂(ᾱ)` (N2-ENV). [hand; two minds, one blind: N2; NB2; N2-TOWARD by different routes; identities tools exact]**
*Proof:* N2 stage N2-3 (N2-SIGN, N2-ENV, N2-TOWARD, N2-AWAY, N2-TAN); NB2 §1.4 (NB2-SIGN, ENV, TOWARD by contact half-planes, AWAY, TAN); ENVT, ENVA, TAN in
`tools/fs112_n2_checks.py`. *Proof verdict:* TRUE; NB2-SIGN adds that the dichotomy is for open-tile points (an R2 contact is at distance exactly 1).
*Rests on it:* FS112-N2-RED; the inert-arc pre-bend of FS112-N3-BASE. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N2-RED — Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which every unit arc is (Q) or (R2); the procedure terminates with no stubs. [hand; two minds, one blind: N2; NB2; over NB-MERGE3, two minds]**
*Proof:* N2 stage N2-3 (termination by N2's count: a bend removes an arc or leaves (R2) pieces, re-enabled only by a W-MERGE or a colour lost at its
centre); NB2-RED (its "once, wholly" corrected to N2's count, NB2 §2.3 #8). *Proof verdict:* TRUE. N112-RED's merge step is needed only at centres with a
repeated colour: at a cubic centre no both-kind arc exists (FS112-N3-NOBOTH). Answers **C-SEAMS-TWO**'s second correction (FS112-SEAMS-TWO) and
**C-UA-INC** up to reduction (only (Q) and (R2) survive). *Rests on it:* FS112-N2-TERM. *Prior art:* not found in print; `[Polymath16threads]`
`[06.91]` (Hockertz, stated) fills arcs of radius below 1 up to radius 1, the opposite direction. *Kernel:* stub — with FS-114.

**FS112-FLANK — N4-FLANK fails when a horn's bounding arc is a unit arc centred at `N` (`κ₊ = 1`) or `S′` (`κ₋ = −1`): an in-type flank tile at the centre is then Siamese with the flank and shadows a band of the horn, and SHAVE's criterion is incomplete there. [hand; two minds: N, blind to NB; NB sighted, after its stage 1 had "survives"]**
*Proof:* N §1.4 row 7; NB §2.2 (re-derived, the BAND straddle). *Proof verdict:* TRUE — the round-1 reversal went the side's way. *Rests on it:*
FS112-N2-FLANK-Q, FS112-N2-RAY. *Prior art:* FS110-N4-SHADOW's flank list is the object. *Kernel:* stub — with FS-114.

**FS112-END — In a stuck chain whose vertices all carry N4-STUCK's structure, the horn curvatures cannot reach `λ_{k+1} = −1` or `υ_{k−1} = 1`. [hand; two minds, one blind: N; NB]**
*Proof:* N §1.4 row 9 (N112-END); NB-END. *Proof verdict:* TRUE with its scope: it reaches only chains with N4-STUCK's structure at the centre `P_k`, which
a chain's end lacks (FS112-N2-RAY). *Rests on it:* FS112-N3-CHAINS. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N2-FLANK-Q — Every horn bound of exactly `±1` sits on a (Q) arc — FLANK's in-type exception, and then both horns' upper arcs form one arc of `ω(N)` through `v` — or on an (R2) arc, whose inner-colour tile along the radius-2 circle is FLANK's out-type tile at the far antipode. [hand; two minds, one blind: N2; NB2, sighted on the one-arc clause]**
*Proof:* N2 stage N2-4; NB2-FLANKQ, §2.3 #10. *Proof verdict:* TRUE. *Rests on it:* FS112-N2-TERM, FS112-N3-END. *Prior art:* not found in print. *Kernel:*
stub — with FS-114.

**FS112-N2-RAY — N4-FIN's application fails at a chain's end; a one-sided stuck chain with `λ_k = −1/(k+1)`, `υ_k = 0` is consistent with N4-FIN; so N4-CONE is a GAP under unit arcs — the extremal chain is the pencil of circles of radius `k + 1` about `P_{−1}` with straight upper arcs, every shadow tight. [hand; two minds, one blind: N2; NB2; the pencil one mind, NB2; RAY exact]**
*Proof:* N2 stage N2-4; NB2 §1.4 N2-RAY items 1–4 (the step fails in N4-STUCK (iv), NB2 §2.3 #2), item 2 (the pencil). *Proof verdict:* TRUE. FIN as a
statement about bi-infinite sequences in `(−1, 1)` is untouched; N4-PROP's step past a chain's end with a horn bound `±1` has no proof. *Rests on it:*
FS112-N2-TERM; the stuck ray, FS-115's object. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N2-TERM — Every valid map has a valid modification `M*`, creating no unit arc, in which every unit arc is (Q) or (R2); every vertex is cubic, an NB4P exception with at least four colours, or stuck; every stuck vertex lies on a stuck chain along its normal line that is not bi-infinite, each finite end within distance 1 of a (Q) or (R2) arc or an NB4P exception, every horn bound `±1` on it a (Q) or (R2) arc; one-sided infinite chains are a GAP. [hand; two minds, one blind: N2; NB2]**
*Proof:* N2 stage N2-4 (over N2-RED, N4-TERM's enumeration, NB4P); NB2-TERM. *Proof verdict:* TRUE. *Rests on it:* FS112-C-ENDS, FS112-C-COMPOSE.
*Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N2-DENSE — In every valid map each trichromatic cubic vertex has a repeated-colour vertex within 2 or a unit-arc centre within 3, so every closed disc of radius 4 holds one; in `M*` a unit-arc centre within 4 or a stuck vertex within 3, every disc of radius 5. [hand; NB2's form one mind: NB2; N2's form two minds, one blind: N2; NB2; over row 134's base, NB4P and FS112-SIX]**
*Proof:* NB2 §1.4 (the base reads local structure only in `B̄(u, 2)`; no terminal modification needed); N2 stage N2-5. *Proof verdict:* TRUE; filed in
NB2's form (owner's ruling, inventory item 44). Superseded in strength by FS112-N3-DENSE3. *Rests on it:* round 3's aim. *Prior art:* not found in print.
*Kernel:* declined — superseded by FS112-N3-DENSE3.

**FS112-DISC1 — Every closed disc of radius 1 of a valid map contains a vertex of degree at least 3. [hand; two minds: N2's sketch; NB2's proof]**
*Proof:* NB2 §1.4 N2-DENSE item 3 (nested surrounding tiles lie in the disc; local finiteness ends the nesting at a branch point); N2 stage N2-5 Corollary.
*Proof verdict:* TRUE. *Rests on it:* FS112-N2-DENSE, FS112-N3-DENSE3. *Prior art:* CB's D6 is the trichromatic form for cubic maps. *Kernel:* stub —
with FS-114.

## §2. The proof side, round 3: the base with unit arcs, and the chains

**FS112-N3-CHAINS — Along a stuck chain neither `λ` nor `υ` decreases and one of them strictly increases at every step; with all curvatures in a finite set `K` a chain has at most `2|K| − 3` vertices, and a one-sided infinite chain carries infinitely many curvatures; on an upward-infinite chain `−1/(k+1) ≤ λ_k < 0`, so the horn at `P_k` needs a boundary arc of radius at least `k + 1`, equality being the pencil of FS112-N2-RAY. [hand; two minds, one blind: N3; NB3; tools exact on both sides]**
*Proof:* N3 stage N3-2 (N3-STEP, N3-LEN, N3-RAYR; STEP, MONO, RAY in `tools/fs112_n3_checks.py`); NB3 §1.4 (NB3-STEP, LEN, RAYR). *Proof verdict:* TRUE; N3-LEN's
stated bound `2|K| − 1` is true and not sharp — the rank count gives `2|K| − 3` (NB3 §2.2 #14). Card R's reading R1 (A3-3.3) and Y3-R1 (FS112-Y3-R1) are
the same arithmetic, the latter with a weaker count `3V + 3`. *Rests on it:* FS112-N3-PER, FS112-C-COMPOSE. *Prior art:* not found in print. *Kernel:*
stub — a leaf (the curvature algebra), with FS-114.

**FS112-N3-PER — A doubly periodic valid map has a periodic terminal modification, so finitely many arc classes: it has no stuck ray and its chains are bounded; for a non-periodic map with finitely many arc classes whether its terminal modification keeps finitely many is a GAP, N3-ALPH. [hand; two minds, one blind: N3; NB3]**
*Proof:* N3 stage N3-2 (operations applied to whole orbits; translate pairs kept off distance 1 by `ρ < d₀/4` or by a lens inside one tile; R1's verdict);
NB3-PER. *Proof verdict:* TRUE; GAP N3-ALPH named (SHAVE's circle takes a shadow's exact curvature and a bend's tangent start one chosen in an interval,
so iterated operations may create new classes). *Rests on it:* FS112-C-COMPOSE item 3. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N3-NOBOTH — The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour. [hand; two minds, one blind: N3; NB3; over FS112-U1]**
*Proof:* N3 stage N3-3; NB3-NOBOTH. *Proof verdict:* TRUE. So no both-kind arc is centred at a cubic trichromatic vertex, and a three-colour (S1) centre is
a bowtie. *Rests on it:* FS112-N3-COR3, FS112-N3-PAIRS, FS112-N3-END. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N3-FAIL — At a cubic trichromatic `u`, CB's D2 strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of `u` (the centre of a unit arc ending at `u`); there the colours of `c(u)` allowed inside `ω(u)` near `q` are exactly the inner colours of those arcs, outside exactly their outer colours. [hand; two minds, one blind, different routes: N3; NB3; tools exact, VOTES; FAIL]**
*Proof:* N3 stage N3-3 and N3-4 precision 1 (the arc's own side tiles' shadows, no transversality needed); NB3-FAIL (a first-order vote model).
*Proof verdict:* TRUE; N3's vote table has combinatorial rows the geometry never realises, harmlessly (NB3 §2.2 #12). *Rests on it:* FS112-N3-COR3,
FS112-N3-BASE. *Prior art:* S–V Prop. 10's strip (row 134's base). *Kernel:* stub — with FS-114.

**FS112-N3-ANTI — CE5, the Antipodal Lemma, survives unit arcs: at a cubic trichromatic vertex no two points of its unit circle at distance 2 are both M-in. [hand; two minds, one blind, different routes: N3; NB3; tools exact, ANTI]**
*Proof:* N3 stage N3-3 (every arc casts an in-vote at one antipode: three in-votes against a budget of two); NB3-ANTI (a shared bounding arc voting `≤ 1`
at both antipodes lies at `u`). *Proof verdict:* TRUE; CE5's step "at an M-in point the strip's majority side is outside" is not needed — replaced by the
in-vote count. *Rests on it:* FS112-N3-BASE. *Prior art:* FS110-CE5. *Kernel:* stub — with FS-114.

**FS112-N3-COR3 — In a valid map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint multicolours, `d < 2`) sits on a unit rhombus `u, q₊, u′, q₋` whose other corners are vertices of at least four colours, each a leaving centre of both `u` and `u′`, a unit arc of each leaving centre's circle being both-kind there: T2 is forced at both common unit points. [hand; two minds, one blind, different routes: N3; NB3; tools exact, COR3 on 403 + 128 + 336 cases]**
*Proof:* N3 stage N3-3 (N-E1 at `u` puts `Ω`'s half on `u′`'s clean side in `Γ`, both-kind at `u`, against NOBOTH; then N-E1 at `u′`); NB3-COR3 (U1's side
cones against a clean side). *Proof verdict:* TRUE; readings "double" = of both vertices, "four-colour" = at least four. **It is the construction
side's stop seen from the proof side** (FS112-STOP; FS112-C-PARTNERS). *Rests on it:* FS112-N3-BASE (Cor. 3's pairs), N2-ROT's "no `r`-tile at `x`"
(FS112-ROTHEX), FS112-C-PARTNERS. *Prior art:* the slack form — two trichromatic points sharing no colour are at least 2 apart — is stated for tilings
avoiding `[1, d]` in `[Polymath16threads]` `[17.282]` (de Grey, 2022; FS-107's complementary junction pair); the tight form, with its four-colour
corners, not found in print. *Kernel:* stub — with FS-114.

**FS112-N3-PAIRS — The base's pair steps survive unit arcs: (i) never fails; (ii) fails only when a point read has at least four colours or its partner is a both-centre; two cubic trichromatic vertices with one multicolour are never at distance 1. [hand; two minds, one blind: N3; NB3; (i)'s unconditional form one mind, N3, with NB3's sighted check]**
*Proof:* N3 stage N3-3 (N3-I by perturbation at non-leaving centres; N3-II; N3-P′); NB3-I (blind: TRUE off mutual both-centres, its GAP there retracted
at stage 2), NB3-II, NB3-P′. *Proof verdict:* TRUE; N3-II's form at `x` is sharper (four colours, not "four or a repeat"). *Rests on it:* FS112-N3-BASE.
*Prior art:* CB's D1–D2 (row 134's base). *Kernel:* stub — with FS-114.

**FS112-N3-BASE — In a valid map, if the closed disc of radius 2 about a cubic trichromatic vertex `u` holds no vertex of at least four colours and none with a repeated colour, row 134's base refutes the map near `u` (inert unit arcs centred within 1 of `u` first bent toward their centres). [hand; two minds, one blind: N3; NB3; over row 134's base at its grade — CB's route with CE's repairs, CUSP-BASE, S–V Lemma 5, Prop. 18 and Lemma 6's `< 9` branch, unre-derived here — and FS112-U1, FS112-N2-BENDS, two minds each]**
*Proof:* N3 stage N3-3 (the table: every step of the base, the unit circle it reads, where its exception lives) and N3-4 precision 2; NB3 §1.4 (steps
1–12, blind; the named check of Prop. 17's ring lemmas, FS112-ROTHEX). *Proof verdict:* TRUE; no row needed a repair; Prop. 17's row gains N3-COR3 as a
dependency (NB3 §2.2 #7). **The residue both walks share is row 134's base, unre-derived; a common error of the two walks would sit there** (NB3 §2.3).
(R2) centres and three-colour unit-arc centres never save the base. *Rests on it:* FS112-N3-DENSE3. *Prior art:* S–V Cor. 1 (row 134's base, curved and
almost everywhere); not found in print with unit arcs. *Kernel:* stub — with FS-114, over the base's own formalization.

**FS112-N3-DENSE3 — Every closed disc of radius 3 of every valid map holds a vertex of at least four colours or a vertex with a repeated colour. [hand; two minds, one blind: N3; NB3; over FS112-N3-BASE and FS112-DISC1]**
*Proof:* a closed unit disc holds a vertex of degree at least 3 (FS112-DISC1); if it is cubic trichromatic, FS112-N3-BASE puts one of the two kinds
within 2 of it (N3 stage N3-3; NB3-DENSE3). Moves never add a colour or a sector to an existing point, so no terminal modification is needed.
*Proof verdict:* TRUE. On both positives it holds (four-colour midline vertices within 1.834 of every point of the strip; the disk's corners). *Rests on it:*
FS112-C-COMPOSE; **FS-114's global step is its converse question**. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-N3-END — A stuck chain's end with horn bound `−1` has a vertex one step beyond it carrying at least four colours and a repeated colour, and a both-kind unit arc centred two steps beyond it; or, if an in-type flank tile sits at the other neighbour, both horns' upper arcs lie on that neighbour's unit circle and the chain is the single vertex. [hand; two minds, one blind: N3; NB3]**
*Proof:* N3 stage N3-4 items 1–4 (N2-FLANK-Q, N3-DEG, U1's side cone, SHAVE's flanks); NB3-END (its item 4: `z ≠ y` by N-E2 twice). *Proof verdict:* TRUE as
the table states it; N3's body's first alternative ("both horns lie between `ω(P_{−1})` and `ω(P_1)`, … in-type `h` at `P_{−1}`") is MISSTATED as a case
description and corrected as above (NB3 §2.2 #2); its item 3's "(else SHAVE)" needs the N-E2 step (#3). It makes NB2-END unconditional. Y3-END-NEEDS
continues past its item 4 (FS112-Y3-END-NEEDS). *Rests on it:* FS112-C-ENDS. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-ROTHEX — FS-110's ring lemmas N2-ROT and N2-HEX survive unit arcs under the base's hypothesis; P17's only unit-arc exception is a both-centre `x₂`; N2-ROT's "no `r`-tile at `x`" rests on FS112-N3-COR3. [hand; one mind: NB3, the named check]**
*Proof:* NB3 §1.4 N3-BASE step 10, §2.2 #7 (`plans/FS110-N-proof.md` l. 374, 393). *Proof verdict:* TRUE; N3 took the lemmas on FS110-P17's route unwalked.
*Rests on it:* FS112-N3-BASE's Prop. 17 row. *Prior art:* S–V Prop. 17. *Kernel:* stub — with FS-114.

## §3. The close's compositions (FS112-C)

**FS112-C-ENDS — In a terminal valid map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours. [hand; one mind: FS112-C, an assembly; its links two minds, one blind, but the arc-through-N count one mind: NB]**
*Proof:* a chain stops where N4-STUCK (iii)–(iv) fail at the next point `N` (N2 stage N2-4): an in-type flank tile at `N` makes `N` a (Q) centre, at least
four colours (FS112-N2-FLANK-Q, FS112-N2-RED); an arc of `ω(v)` through `N` forces `|P_cl(N)| ≥ 4` (NB §2.3 #10, one mind); an NB4P exception at `N` has
four; at a horn bound `±1`, FS112-N3-END puts four colours at the centre one step beyond. Where (iii) holds the antipode carries a double sector, so in
`M*` it is stuck or has four colours (FS112-N2-TERM item 2), and the chain continues. `data/fs112/fs112-c/reconciliation.md` §1.6 (L4). *Proof verdict:* TRUE
at one mind; the exhaustiveness of N2's exception list for (iii)–(iv) is N2's (NB2 checked N2-TERM, not the list separately). *Rests on it:*
FS112-C-COMPOSE. *Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-C-COMPOSE — The two gaps compose as follows: (1) since every valid map has `F ∪ R` within 3 of every point, excluding such maps is the NO for every valid map, periodic or not, with no ray step; (2) for a doubly periodic map, the terminal modification's four-colour vertices meet every closed disc of radius `|K| + 2`, `K` its finite curvature set, so the NO reduces to the four-colour form with no ray step and no third step; (3) for aperiodic maps the four-colour form needs both the stuck ray excluded (b′) and a uniform bound on the length of finite stuck chains, a third GAP, (b″). [hand; one mind: FS112-C; its links two minds, one blind]**
*Proof:* `data/fs112/fs112-c/reconciliation.md` §1.6, over FS112-N3-DENSE3 (L1), FS112-N2-TERM (L2, L3), FS112-C-ENDS (L4), FS112-N3-PER and FS112-N3-CHAINS (L5):
in (2) a stuck vertex lies on a finite chain of at most `2|K| − 3` vertices whose ends each have a four-colour vertex one step beyond, so it is within
`|K| − 1` of one. For (3): the recursion admits finite chains of every length `L` (from one end `λ_k ≥ −1/(k+1)`, from the other `υ_k ≤ 1/(L − k + 1)`,
always compatible; Y3-END-A realises the pencil for `L = 3`), each needing about `L` distinct curvatures, so a map with infinitely many arc radii can
carry them and its four-colour vertices need not be relatively dense even with no ray; N3-LEN bounds lengths only for a finite alphabet, and N3-ALPH is
open there. A Hausdorff limit at bounded `K` (W-EQ-K's) would convert long chains into a ray only if terminality and the stuck structure pass to limits,
which no record derives. *Proof verdict:* TRUE at one mind; (b″) named, not bridged. *Rests on it:* the stubs FS-114 and FS-115 (their bearing lines).
*Prior art:* not found in print. *Kernel:* stub — with FS-114.

**FS112-C-PARTNERS — In a valid map, every close complementary cubic trichromatic partner of a cubic trichromatic vertex `u` is the fourth corner `w_i + w_j − u` of a unit rhombus on two of `u`'s leaving centres, so `u` has at most three such partners. [hand; one mind: FS112-C; over FS112-N3-COR3, two minds, one blind, and the count of leaving centres, N3 stage N3-3's frame and Y3 §4.2 item 1]**
*Proof:* by FS112-N3-COR3 both common unit points of such a pair are leaving centres of `u`; a boundary curve leaving `u` lies on at most one unit circle,
so `u` has at most three leaving centres, and two common unit points of `ω(u)`, `ω(u′)` determine `u′ = q₊ + q₋ − u`. `data/fs112/fs112-c/reconciliation.md`
§1.5. *Proof verdict:* TRUE at one mind. It makes Y3's design condition (FS112-Y3-T2-BUDGET) a theorem about every valid map; the strip's printed
colouring violates it at its `(V, A)` pairs, which is why the strip cannot be a map. *Rests on it:* FS-114's reading list. *Prior art:* not found in
print. *Kernel:* stub — with FS-114.

**FS112-SEAMS-TWO — C-SEAMS-TWO corrected: at a close covering pair of a valid map (union sense) the seam point either lies in the closure of a unit arc centred at `u` or `v` — (S1), or (S2) with arcs, the centre of three or more colours — or is a vertex of at least four colours, NB-4's exception at `w₀`, of which T2 is an instance; up to FS112-N2-RED the unit arcs are one species, a (Q) centre, plus (R2). [hand; the unconditional form one mind: NB; its corollary up to reduction two minds, one blind, over FS112-N2-RED]**
*Proof:* NB-SEAM2, NB §1.6; N §2.3 (the corollary, then over N112-RED's GAP, now closed by FS112-N2-RED). *Proof verdict:* TRUE; filed as the owner ruled
(inventory item 30): NB's statement as the correction, N's as its corollary. On NB4P's (E2) branch the seam point is a four-colour vertex carrying no unit
arc; "one species" then describes its ring's centres (NB §2.3 #6). *Rests on it:* nothing further. *Prior art:* not found in print. *Kernel:* declined —
a classification superseded by FS112-N3-DENSE3.

## §4. The construction side: the printed positives, rebuilt exactly, and where they stop

**FS112-CAL-STRIP — `[AxenovichEtAl2014]` Thm 4.2's strip, rebuilt by formula from its printed words with Fig. 4 read for the colour pattern only, is a valid six-colouring of the strip of height exactly `√15/2 + √3`; every same-colour pair within reach touches at exactly 1; every unit arc (twelve per period) is centred at a four-colour midline vertex and is of kind both, with the self case. [tools, exact; three rebuilds, two blind: Y; YB; YB2; three checkers]**
*Proof:* Y §1.3, §2.2 (`tools/fs112_y_check.py`, `fs112_y_calibrate.py`); YB §3–5 (`tools/fs112_yb_check.py`, `fs112_yb_strip.py`, `fs112_yb_objects.py`);
YB2 §4.1 (`tools/fs112_yb2_check.py`, `fs112_yb2_objects.py`). *Proof verdict:* ACCEPT on all three; the rebuilds agree under one label map (YB §5); the
arc count is 24 in six columns (Y's 22 a window effect, Y2-D6). It realises NB-4's break exactly (the midline vertex `P_1`, `{1,2,4,5}`, its whole ring
inside the strip), and NB-5's and N4-TERM's cubic clause's. *Rests on it:* C-BEYOND (1.834); N112-P1 met exactly; every later reading of the strip.
*Prior art:* the object is `[AxenovichEtAl2014]`'s; its rule in words is `[Polymath16threads]` `[07.10]` (de Grey, 2018) and its width `[09.100]`
(Parts); the exact rebuild and its checkers are ours. *Kernel:* declined — a local positive, a calibration; a YES would be formalized as its own map.

**FS112-STRIP-SEAMS — On the strip every close complementary pair's common unit points are four-colour midline vertices where both members emit arcs of its unit circle, or edge vertices (exhaustive per period); T2 is realised arc-closed at `√3` on the spindle rhombus and at `√15/2` on a thin unit rhombus; the Q-rule's (S2) with arcs is realised at the valleys and apexes — T2 read from the rhombus's other diagonal. [tools, exact; T2 at `√3` two minds, one blind: Y; YB; the exhaustive list and the thin rhombus one: YB; (S2) with arcs two: A3's derivation; Y2's check]**
*Proof:* Y §1.3 (Y112-T2-SQRT3); YB O2, O3 (YB-SEAMS, YB-T2); Y2 §3.5 (Y2-X4); A3-1.6 item 2. *Proof verdict:* TRUE. It corrects the claim list's T2
parenthesis "(the spindle's rhombus)", too narrow (YB D8). *Rests on it:* FS112-STOP, FS112-Y3-R3. *Prior art:* not found in print. *Kernel:* declined.

**FS112-EDGE — The strip's colouring cannot be continued into any open set above an edge vertex `Q = (1/4, H/2)`, the upper common unit point of the complementary pair valley `V₀` `{1,3,5}`, apex `A₁` `{2,4,6}` at distance `√(9 − 3√5)/2`: the colourless set there is the open cone from `arcsin ¼` to `180° − arcsin ¼`, width ≈ 151.05°. [hand and tools; the no-colour step two minds, one blind: Y; YB; the exact cone one mind: YB2]**
*Proof:* Y §1.5 (Y112-EDGE); YB O3 (YB-EDGE, blind); YB2 O2, D1 (`tools/fs112_yb2_edgecheck.py`, `data/fs112/fs112-yb2/edgecheck.out`: no colour at `20°`,
orange free at `10°`, red at `170°`). *Proof verdict:* TRUE; **YB-EDGE's and Y2-PIN's cone `(30°, 165.52°)` is a proper sub-cone**, not the colourless
set — each top tile touches `ω(Q)` twice, and the mirror `x ↦ 1/2 − x` fixing `Q` forces a symmetric cone (inventory item 54); the widths compared are
151.05° (strip) against 108° (disk). `Q` is at distance 1 from two complementary pairs, `(V₀, A₁)` and `(V₁, A_{−1})` (YB2 D4). *Rests on it:*
FS112-STOP. *Prior art:* `[Polymath16threads]` `[16.347]` (Sirgedas, 2021) says in dual-graph words why the strip cannot be extended ("all 6 colors are
within two 'steps' of the new vertex"); the exact point and cone are ours. *Kernel:* declined.

**FS112-YB-LOCK — In-contact locks the outward bends of a unit arc and out-contact the inward ones, so a both-kind arc cannot be bent either way. [hand; one mind: YB; two exact bends]**
*Proof:* YB O4 (`tools/fs112_yb_o45.py`, `o45.txt`). *Proof verdict:* TRUE; the converse face of FS112-BEND and FS112-N2-BENDS (a third mind for their
blocking conditions, not blind to the statement's shape). ARC-INERT is vacuous on the strip. *Rests on it:* FS112-MOVE's reading (the disk's top arcs
are locked). *Prior art:* not found in print. *Kernel:* declined.

**FS112-STRIP-CHAIN — The strip carries bi-infinite periodic chains of unit arcs (arcs meeting at valleys and apexes), valid inside the strip, so no strictly monotone quantity local to a chain of unit arcs excludes them. [tools, exact; two minds: Y; YB]**
*Proof:* Y §2.5 item 4; YB O4 (YB-CHAIN). *Proof verdict:* TRUE. C-UA-CHAIN's killing test (a closed cycle) did not fire; this is its sibling outcome
(E10). *Rests on it:* the proof side's choice of route B over the chain route (N2 §5.1). *Prior art:* not found in print. *Kernel:* declined.

**FS112-CAL-DISK — `[Polymath2021]` Fig. 10's disk, its combinatorics transcribed by eye before any solve and the one unknown solved exactly, reproduces `r² = (25 + 9√5)/10` and is a valid six-colouring of the closed disc of that radius: 26 tiles, every tile of diameter exactly 1, 71 of 71 same-colour pairs ACCEPT; its 20 unit arcs are all of kind both (self), four centred at each corner `A_k` of the central Reuleaux pentagon, a four-colour vertex, and arc-closed. [tools, exact; two rebuilds, one blind, identical: Y2; YB2; two checkers]**
*Proof:* Y2 §4–5 (`tools/fs112_y2_disk.py`; Y2-DISK, Y2-DISK-KINDS); YB2 §3–6 (`tools/fs112_yb2_objects.py`, `fs112_yb2_compare.py`: 26 of 26 tiles the
same colour and every piece the same point set). *Proof verdict:* ACCEPT on both checkers; the shared reading assumptions stated (Y2 §4.5 items 1–6; YB2
readings P, W, M). N112-P3 met. *Rests on it:* FS112-STOP, FS112-MOVE, FS112-DISC. *Prior art:* the object is `[Polymath2021]`'s (Gibbs's disk,
`[Polymath16threads]` `[07.49]`; five-fold, `[07.50]`; skeleton and radius, Parts `[11.34]`); the exact rebuild and checkers are ours. *Kernel:* declined
— a local positive.

**FS112-DISK-S1 — The disk realises (S1) exactly and arc-closed: its covering pairs `(A_k, X_{k+3})`, `(A_k, Y_{k+1})` and the complementary pairs `(A_k, y)`, `y` a transversal change point of `A_k`'s ring, are saved at non-vertex points of unit arcs centred at `A_k`. [tools, exact at the vertices and arcs, the seam points located in floating point; one mind: Y2, one checker]**
*Proof:* Y2 §5.3 (d). *Proof verdict:* TRUE at one checker. It falsifies N's pre-round secondary ("C-ARC-END for (S1) at both ends of the arc fails") and
meets E11. *Rests on it:* FS112-Y3-R3's line (iv). *Prior art:* not found in print. *Kernel:* declined.

**FS112-BUDGET2 — C-UA-BUDGET's second branch ("the arcs sit on `ω(σ_v^{±1}y)` through `y`, centred at ring points, not at `v`") is FALSE in both senses: in the union sense at the strip's `P_1`, whose arcs all lie on its own circle; in the disjoint sense at the disk's `A_0`, where a complementary ring point at about 209° lies on no arc of `Γ`. [tools, exact; the union sense two minds, one blind: Y; YB; the disjoint sense one: Y2]**
*Proof:* Y §2.5 item 4; YB O4; Y2 §5.3 (e) (the crossing by the intermediate value theorem on an exact segment). *Proof verdict:* FALSE as stated;
consistent with FS112-NB4P, whose escape (α) holds at `A_0`. *Rests on it:* the correction of branch 2 to FS112-NB4P. *Prior art:* not found in print.
*Kernel:* declined.

**FS112-STOP — The pinned corner: the strip and the disk stop at the same kind of point, the second common unit point of a close complementary trivalent pair saved at its first by a four-colour vertex where both members emit arcs of its circle; at the stop every colour but the two own ones straddles distance 1, and each own tile realises its diameter toward a member of the pair, so an outward cone carries no colour. [hand and tools; two minds, one blind: Y2; YB2]**
*Proof:* Y2 §5.3 (f), §6.1 (Y2-STOP, Y2-PIN; `tools/fs112_y2_dial.py pin`); YB2 O2 (YB2-SAME). *Proof verdict:* TRUE; the strip's cone as corrected in
FS112-EDGE; A3's hunch `a3-disk-stops-at-a-seam` confirmed on a fresh object. **It is where FS112-N3-COR3 bites**: a valid map needs a four-colour vertex
at both common unit points of such a pair, and each positive supplies one. *Rests on it:* FS-114's handle. *Prior art:* `[Polymath16threads]` `[16.347]`
(Sirgedas) for the strip, in dual-graph words; the common law not found in print. *Kernel:* declined.

**FS112-DISK-RIM — The disk's colourless rim points are exactly the ten `C_k`, `D_k`, each with an open colourless cone of width 108°; the outside points `Q_k`, at radius ≈ 2.16253 with `|Q_k|²` a root of `25x⁴ − 50x³ − 265x² − 250x + 121`, have the colourless cone from 54° to 198° while `Q_k` itself can still be coloured. [hand and tools, exact; one mind: YB2]**
*Proof:* YB2 O1, O2, D2, D6 (`tools/fs112_yb2_analysis.py`, `cone-disk.out`, `o1-o2.out`). *Proof verdict:* TRUE; Y2 tested named directions, YB2 the
completeness. *Rests on it:* FS112-STOP's disk half. *Prior art:* not found in print. *Kernel:* declined.

**FS112-FORCE — At the strip's valley `V₀` and apex `A₁` the neighbouring four-colour midline vertices force the sectors up to one free direction each, and no change confined to those free directions, or to neighbourhoods of `V₀`, `A₁` of radius below about 0.13, makes a colour available at the edge vertex. [hand; two minds, one blind: Y2; YB2; the directions exact]**
*Proof:* Y2 §6.5 (Y2-FORCE); YB2 O4 (YB2-FORCE, with the radius). *Proof verdict:* TRUE. *Rests on it:* FS112-Y3-PIN. *Prior art:* not found in print.
*Kernel:* declined.

**FS112-MOVE — The dial stalls: replacing the straight sides of the disk's rim tiles `R_k` by the unit arcs of `ω(C_k)` and `ω(D_k)` — the only arcs through those ends that clear the rim neighbours — keeps the disk valid, its ten new arcs of kind in (self; not arc-closed), frees a third colour at each rim corner and shrinks the colourless cone from 108° to 36°, and does not close it; the `R_k | U_k` boundary is not locked. [tools, exact; two minds, one blind: Y2; YB2; the slack boundary one: Y2]**
*Proof:* Y2 §6.2–6.3, §6.6 (Y2-MOVE, Y2-WEDGE, Y2-SLACK); YB2 O3 (YB2-MOVE). *Proof verdict:* TRUE; E6 not met, a stall with the obstruction named; the
first in-only unit arcs held in an exact valid object (C-UA-INC). The plant `move_wrongside`, registered with a wrong reason, ACCEPTs and revealed the
slack boundary. *Rests on it:* FS112-Y3-PIN's disk half. *Prior art:* the move is `[Polymath2021]` p. 194's tactic applied once more. *Kernel:* declined.

**FS112-DISC — No vertex-centred disc of radius above `φ` lies in any valid extension of the disk, and a valid extension holds `B̄(A_0, φ)`: φ is attained; inside the disk the largest vertex-centred disc has radius `r − |OA|` ≈ 1.5985. [tools, exact + hand; the bound two minds: Y2; YB2; the attainment one: YB2]**
*Proof:* Y2 §5.3 (g) (Y2-DISK-R); YB2 O5, D3 (YB2-DISC: `R_0` grown to the circle `(A_0, φ)`, 71/71 ACCEPT). *Proof verdict:* TRUE. So CAL-DISK does not
enlarge C-BEYOND for a step reading a disc about a vertex (the strip holds 1.834); A3-2.3's second reason for rebuilding the disk fails there (A3's
retraction). *Rests on it:* C-BEYOND. *Prior art:* not found in print. *Kernel:* declined.

**FS112-CHK — Three exact curved-tile checkers: Y's over towers of quadratic fields (390 pairs of FS-110's fragments against the frozen checker, 0 disagreements; the float-guarded map hypothesis confirmed exact on the strip), YB's over multiquadratic fields with an exact meeting test and no map hypothesis, YB2's over towers of square roots (1,663 pairs against the frozen checker, 0 disagreements); each ACCEPTs CAL-7 and rejects its plants at the predicted pairs. [tools, exact; three independent builds, two blind]**
*Proof:* Y §2.1 (Y112-CHK), Y2 §3.3 (Y2-D3, Y2-D4S); YB §2 (`tools/fs112_yb_calib.py`); YB2 §2 (YB2-CHK, `tools/fs112_yb2_calib.py`). *Proof verdict:* TRUE.
Y calibrated CAL-7 on the hexagonal seven-colouring, the claim list named row 33's brick (YB D3); Y's checker ACCEPTs the brick with 0 disagreements
against YB's (Y2-D3). YB's field cannot hold `sin 72°`, hence YB2's tower checker. *Rests on it:* every exact verdict of §4. *Prior art:* the frozen FS-110
checkers. *Kernel:* declined — instruments.

**FS112-Y3-PIN — Both pinned-corner GAPs close as derived obstructions: the strip's stop cannot be passed by cutting `C_{−1}` and `C_2` along `ω(Q)` (at 15 named points of both tiles on and beside the cut the only free colour is 4, and the outer part holds the valley's forced 4-sector); on the disk no change near `Z^L_0` lets the triangle `T*` be blue — the blocker is `T2_0`'s corner `Y_0`, whose distance to `q2 = Z^L_0 − (1, 0)` is below 1, and the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2`. [tools, exact at named points + hand; one mind: Y3]**
*Proof:* Y3 §2.1–2.3 (Y3-STRIPCUT, Y3-DISK-T*, Y3-LEG; `tools/fs112_y3_pin.py`). *Proof verdict:* TRUE at one mind; Y2 §6.4's blocker corrected from
`Z^L_0`'s sector to `Y_0` (recorded, not rewritten). **Grade pending FS112-YB3** (stage 1b). Y2-PIN strengthened: each named local move forces a change
one ring further out. *Rests on it:* FS-114's handle. *Prior art:* not found in print. *Kernel:* declined.

**FS112-Y3-END-AB — A finite stuck chain `P_0, P_1, E` with C-CHAIN-9's recursion taken with equality from the end — upper arcs the circles of radii 3, 2, 1 about `N = P_3`, lower boundaries straight — is realised exactly over ℚ with `N` completed two ways: least (`N` three colours, one repeated; a MERGE available at `N`) and five-coloured (no MERGE; a SHAVE available). [tools, exact; one mind: Y3; plants fire]**
*Proof:* Y3 §3.1–3.2 (`tools/fs112_y3_chainend.py`; 43 of 43 and 47 of 47 pairs). *Proof verdict:* TRUE at one checker; neither completion is terminal at
`N`. **Grade pending FS112-YB3.** *Rests on it:* FS112-Y3-END-NEEDS (its levels 1–2). *Prior art:* not found in print. *Kernel:* declined.

**FS112-Y3-END-NEEDS — To keep the chain's end `E` stuck and its unit-arc centre `N` terminal: `N` needs at least three colours (then a MERGE at `N`), at least five to block it (then a SHAVE at `N`), and blocking both needs a seventh colour — so no stuck chain of a terminal map ends at a unit arc while `E` has three colours; exceptions named: a four-colour `E`, contact arcs accumulating at `N`, the operations' own validity. [hand; one mind: Y3; levels 1–2 realised exactly]**
*Proof:* Y3 §3.3. *Proof verdict:* one mind; **grade pending FS112-YB3.** Its levels 1–2 agree with FS112-N3-END's items 1–3 (frames matched,
`reconciliation.md` §1.5), sharpened to five colours at `N`; its level 3 goes past N3-END's item 4 to a contradiction. Two scope points for the verifier:
its setting excludes FLANK's in-type exception at `N`, where the count still closes if the lower flank is then the inner colour, which Y3 does not say;
and its corollary "a periodic terminal map has no stuck chain at all unless an end vertex is a four-colour vertex" omits chains whose next point is an NB4P
exception without a horn bound `±1`. *Rests on it:* if confirmed, it removes horn-bound-`±1` ends from terminal maps and narrows FS-115. *Prior art:* not
found in print. *Kernel:* stub — with FS-115, if confirmed.

**FS112-Y3-R1 — Along any sequence obeying C-CHAIN-9's inequalities `λ` and `υ` are non-decreasing, two consecutive terms equal only at 0; a chain infinite upward has every `λ_k < 0`, downward every `υ_k > 0`, so a one-sided chain has infinitely many horn radii; a doubly periodic map has no one-sided chain, and its chains have at most `3V + 3` vertices. [hand; one mind: Y3; arithmetic]**
*Proof:* Y3 §1.4. *Proof verdict:* TRUE for doubly periodic maps (through FS112-N3-PER, since chains live in the terminal modification); Y3's "a map with
finitely many arc radii" in general carries the premise N3 corrected — the finiteness must hold in `M*`, GAP N3-ALPH. The same arithmetic as
FS112-N3-CHAINS, independently (a second mind for STEP, not blind to card R's reading). **Grade pending FS112-YB3.** *Rests on it:* nothing beyond
FS112-N3-CHAINS. *Prior art:* not found in print. *Kernel:* declined — subsumed by FS112-N3-CHAINS.

**FS112-Y3-R3 — At both held positives every close complementary pair of vertices is saved at one common unit point by half of T2, at both exactly when it is a rhombus completion (T2 twice), and its unsaved second point is where the positive stops; the disk's `(A_0, y)` pairs are saved at both by (S1). [a reading of exact results held; one mind: Y3]**
*Proof:* Y3 §4.1 (over YB-SEAMS, Y2 §5.3 (d), YB2-PAIRS). *Proof verdict:* TRUE as a reading; **grade pending FS112-YB3.** It meets N3-P1 for pairs whose
rhombus lies in the open strip and refutes N3-P4 as registered (the `(V, A)` pairs are not mirror pairs). *Rests on it:* FS112-C-PARTNERS's reading.
*Prior art:* not found in print. *Kernel:* declined.

**FS112-Y3-T2-BUDGET — If a close complementary pair `(u, v)` with `u` trivalent is saved by T2 at both common unit points, then `v = w_i + w_j − u` for two of the at most three centres `w_i` of unit arcs `u` emits; so a trivalent vertex has at most three such partners, at determined places, and the strip's printed colouring cannot meet the pattern. [hand; one mind: Y3]**
*Proof:* Y3 §4.2. *Proof verdict:* TRUE at one mind; **grade pending FS112-YB3.** With FS112-N3-COR3 it becomes a statement about every valid map
(FS112-C-PARTNERS). *Rests on it:* FS112-C-PARTNERS. *Prior art:* not found in print. *Kernel:* declined — a design condition, promoted by C-PARTNERS.

## §5. Re-attribution (prior art, not ours)

- The question is `[Polymath2021]` p. 199's ("eliminate criterion (ii)") and `[SokolovVoronov2025]` Question 2's unit-arc half; `[Parts2021]` pp. 181–182
  uses the tactic. Nothing here answers either (the answer is not decided).
- The strip is `[AxenovichEtAl2014]` Thm 4.2's (its rule also `[Polymath16threads]` `[07.10]`, de Grey; its width `[09.100]`, Parts); the disk is
  `[Polymath2021]` Fig. 10's (Gibbs's disk `[07.49]`, de Grey's five-fold form `[07.50]`, Parts's skeleton and radius `[11.34]`); why the strip cannot be
  extended is said in dual-graph words by Sirgedas (`[16.347]`); the dual-graph rule "each quad emits four arrows" (`[16.346]`) is the (Q) type in words.
- HOCK (Hockertz, `[06.31]`, `[06.91]`) is stated, never argued; the degree-4 sketch (`[06.62]`) is **Philip Gibbs's**, not de Grey's (the plan's §PA
  row 3 misattributes it); the six-colour-vertex sketch is de Grey's (`[08.17]`) and Gibbs's (`[08.18]`), argued, conditional on de Grey's unproved merge
  (`[08.16]`); Gibbs's "constraint" (`[08.39]`) is a definition.
- The slack form of FS112-N3-COR3 — trichromatic points sharing no colour are at least 2 apart in a tiling avoiding `[1, d]` — is de Grey's (`[17.282]`,
  2022), FS-107's complementary junction pair; TS-U is row 132's; CE5 and the base are row 134's.

## §6. Errata to side records (the records are never rewritten; each correction lives in the entry named)

| record, address | what it says | the correction | entry |
|---|---|---|---|
| `plans/FS112-N-proof.md` l. 231 | isolated contact points "do not exist in the arc's interior" | FALSE: they exist and block only the away-bend | FS112-ISO |
| N §1.4 row 9 | "N4-FIN … its application also survives" | overstated twice: FLANK at `κ = ±1`; a chain's end | FS112-WALK, FS112-N2-RAY |
| N3-END's body, l. 858–859 | the first alternative's case description | "if an in-type `g`-tile sits at `P_1`, both horns' upper arcs lie on `ω(P_1)` and the chain is `{P_0}`; otherwise items 1–4, with `P_1` not stuck whenever an upper bound is `+1`" | FS112-N3-END |
| N3-END item 3, l. 866 | "(else SHAVE)" | cite the N-E2 step (NB3 §1.4 item 4) | FS112-N3-END |
| N3-LEN | "at most `2\|K\| − 1`" | `2\|K\| − 3` (so `2\|K\| − 1`) | FS112-N3-CHAINS |
| N3-BASE's table, Prop. 17 row | names only `x₂` | gains N3-COR3 (inside N2-ROT) | FS112-N3-BASE, FS112-ROTHEX |
| N112-RED's proof | the merge as a general step | needed only at centres with a repeated colour | FS112-N2-RED |
| FS110-CE5's step (`plans/FS110-derivation.md` FS110-CE5) | "at an M-in point the strip's majority side is outside" | not needed; the in-vote count carries it, unit arcs included | FS112-N3-ANTI |
| `plans/FS110-derivation.md` l. 42 | NB-4's general form with "`ω(y)` or … through" | NB4P's form | FS112-NB4P |
| `plans/FS112-Y-construction.md`, Y112-NB4-MIS | exception (γ) | withdrawn by Y2 (retraction 4) | FS112-NB4P |
| Y §1.3, Y112-T2-SQRT3; YB instance | `(3/2, 0)` "`P_2`" | `P_3` by `P_j = (j/2, 0)` | FS112-STRIP-SEAMS |
| Y2 §6.1 Y2-PIN; YB O3 YB-EDGE | the strip's bare wedge `(30°, 165.52°)` | the colourless set is `(arcsin ¼, 180° − arcsin ¼)`, ≈ 151.05° | FS112-EDGE |
| Y2 §6.4 | the blue `T*`'s blocker at `Z^L_0`'s sector | `T2_0`'s corner `Y_0` | FS112-Y3-PIN |
| YB2 stage 5 O1 | "the arches' `arccos(…)` ≈ 20.17°" | `72° − arctan(√φ)` ≈ 20.17° (YB2's own erratum) | FS112-CAL-DISK |
| A3-2.3, second reason | the disk calibrates radius-2 steps | fails at vertex-centred steps (A3's retraction) | FS112-DISC |
| `plans/FS112-unit-arc-half.md` §PA row 3, l. 413, 422, 517 | the degree-4 sketch "de Grey's" | Philip Gibbs's (`[06.62]`) | §5 |
| `data/fs112/claims.md` §2, T2 | "(the spindle's rhombus)" | also a thin unit rhombus at `√15/2` | FS112-STRIP-SEAMS |
