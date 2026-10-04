# FS129-MR1 — pass 2 of the cross-application audit, lane R (the regularity-wall era): mechanisms, the record

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-MR1-pass2.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 3. Lane R owns the grokkings G2, G3,
G81–G86, G88–G91 (`plans/FS129-close-inventory.md` item 51) and the mechanisms named in its held results; this pass follows each to every place
it bears across the whole corpus, both eras. Writes only this file, `data/fs129/mr1/`, `tools/fs129_mr1_*.py` and
`data/fs129/reports/FS129-MR1.md`. Started 2026-10-03 23:48 UTC.*

## Theorems this phase proved

(Filled at the close of the pass.)

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full before this stage: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from
`# Ephodos in lean-dir — the workflow` to its end; `plans/STANDING-RULES.md`; `plans/FS129-cross-application-audit.md`;
`plans/STUB-cross-application-audit.md`; `data/fs129/demand-judged.md` (all of it — § 1's homonyms are required before the first mechanism);
`plans/FS129-OR1-audit.md` (all of it, lane R's pass 1); the reports `data/fs129/reports/FS129-OR1.md` and `-OA1.md`; inventory items 51,
54–65 of `plans/FS129-close-inventory.md`; items 122, 124, 127, 136, 142, 150 of `plans/FS116-close-inventory.md`; and
`plans/FS116-V6-verification.md` ll. 120–200 (§ 2.2, V6-WIN to V6-EMPTY, to check the brief's pointer to the V6-HUG display). Not yet read
(on purpose, until these expectations are saved): any grokking, the index's tables, the derivation files.

**Quotation check** (standing rule 3), by script, character for character:
- the request (`> Right after this close, …`) against `plans/STUB-cross-application-audit.md`: found, verbatim;
- decisions 1–4 (`> 1. yes, we don't want O(N^2) here. …`) against `plans/FS129-cross-application-audit.md`: found, verbatim;
- the note on roots (`> Also a note for the whole plan …`) against the same file: found, verbatim;
- the brief's pointer "displayed at line 159 of `plans/FS116-V6-verification.md` § 2.2": line 159 is the display
  `$$|a(s) − b(t)|^2 − 1 = −8 \sin\tfrac{s}{2}\,\sin\tfrac{t}{2}\,\cos\tfrac{s+t}{2} < 0 \quad (0 < s, t \le 60°)$$`, inside § 2.2
  (which starts at l. 102), with `a(s) = y_0 + e(120° + s)` and `b(t) = y_1 + e(300° − t)` defined at ll. 150–157 (`p = 0`, `y_k = r(60°k)`);
- Kooshi's question, "where else can we use that identity?", against `plans/FS116-close-inventory.md` item 142: found, verbatim, inside
  "That's an interesting one. How did the original proof do it, and where else can we use that identity?".

No mismatch; no finding about the brief. One note for my own reading: item 150 records that Poros's R2 already answered Kooshi's question in
part — card 2 of `plans/POROS-2026-10-03-close-reread.md` names the identity as the classical three-unit-step closure
`|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)`, with "four configurations ranked". My pass reads that card before working the identity, and
does not redo what it closed.

**Registered expectations** (2026-10-03 23:48 UTC, before any grokking, index table or derivation file was read for this pass; scored at the
close of this pass; instruments for G21, never caps):

| quantity | expectation | reasoning |
|---|---|---|
| mechanisms worked (12 grokkings + the bends + two closed forms + pass 1's four leads, counted once each) | about 16, of which I expect to finish 11–16 inside the budget | five mechanisms are named in the brief's order; the rest by reach |
| mechanisms that bear somewhere **unapplied** (a composition, a miss or a near miss with a named failing hypothesis) | 6 (range 3–9) | pass 1 found two in-era misses in one pass over 24 steps; mechanism-first reading meets more sites per mechanism |
| **compositions derived** (block entries) | 4 (range 2–8) | pass 1 derived 8 against a registered 3; I correct upward for that miss, downward because pass 1 took the richest ones |
| **misses of the FS116-Y4 kind** (a milestone worked a step the mechanism would have shortened or emptied) | 2 (range 0–4) | G83's straddle and the bends are both mechanisms that empty classes; each was applied late at least once |
| nulls (mechanisms that bear nowhere new) | 5 (range 2–9) | |
| G83's straddle bears on a held entry's step that it was not applied to | P = 0.55 | the prompting instance was one; straddles are cheap to check |
| the bends (in BEND3's generality) shorten an FS110-era GAP (FS110-A3-HOLE or FS110-N2-SWAP) | P = 0.45 | their reading radius is unknown to me; √3 is generous for a local step, tight for a radius-2 step |
| V6-HUG's identity closes or empties a held open step (not only re-derives a held kill) | P = 0.20 | R2's card 2 already ranked its configurations; what is left is the harder sites |
| a held result found false as read (a refutation to message the coordinator about) | P = 0.04 | |
| this pass **changes the bearing on the answer** (a step of FS-123, FS-124, FS-125, FS-104 or the map step closed or reduced so that a route's shape changes) | P = 0.10 | pass 1 took the top step; pass 2 is interweaving |

## Stage 2 — SAVED: mechanism 1 (G83's straddle) and mechanism 3 (the two closed forms)

**How I read.** Before this stage I read G83 (`.claude/skills/grokkings/SKILL.md`), its index line (`data/fs129/index/grokking-uses.md`: three
mentions, FS116-V6-HUG, -Y4-EMPTY, -Y4-FLANK) and its filed instance (`plans/GROKKING-INSTANCES.md` § G83); `plans/FS116-Y4-construction.md` § 3
(FLANK, EMPTY, the look-back); `plans/FS116-V6-verification.md` § 2.2; every FS-116 and FS-114 statement in `data/fs129/index/statements-R.md`, with
the full records of FS116-RING-GERM, -N1-GERM-S, -N2-STAR, -V4-TWIST, -V4-DICHOTOMY, -Y3-TIPS and -N3-SEMI from `data/fs129/index/theorems.jsonl`;
`plans/FS116-N3-proof.md` §§ 2.3–2.4 and 3.2 (the semi-hub cone calculus and SEMI-PAR3's forced shape); Poros's card 2 and its ranking
(`plans/POROS-2026-10-03-close-reread.md` § 2.3 C5, § 2.5, ll. 480–490); `plans/FS114-YB4-verification.md` items 10 and YB4-2ND (PXKILL's exact form).
I searched the statements by content, not by number: "within 1", "below 1", "B̄(", "hug", "tip", "flank", "straddle", "Reuleaux", "lens".

### Mechanism 1 — G83's straddle

**What it is.** Two tiles of one colour whose closures are pinned along two unit circles come within distance 1 while also holding points more
than 1 apart, so two interior points of that colour are exactly 1 apart (G83; the core is FS116-V4-DICHOTOMY: same-colour tiles are either all
below 1 apart or all above). **Kind of input it delivers:** points and distances, with contact at distance exactly 1 as the pin; never a count
(G86 permits it in every class, Siamese included, since the last step needs no non-Siamese — `plans/FS116-Y4-construction.md` § 3.2).

**Used at** (by id): FS114-YB2-DE and FS114-Y5-PXKILL (the pinwheel family `P_x`), FS114-N7-3T (its straddles at `√3` and `1 + ε`),
FS114-Y-STRIPK6 and -Y-PAIRSHARE's Y-K6 (six tiles pairwise straddling distance 1 make two vertices complementary), FS116-N1-GERM-R and
-V3-GERM-R-EDGE (germ confinement), FS116-S1-CLUSTER (the cluster form), FS116-V6-HUG, -V6-ADJ, FS116-Y4-FLANK, -Y4-EMPTY.

**Where it bears and was not applied.**
1. **A composition — the double tip at two adjacent change points of any ring** (FS129-MR1-DOUBLETIP, below). FS116-V6-HUG states "no tile `T` of
   `p` tips both `y_0` and `y_1` while being the only tip at each" for rings carrying **no arc of `Γ`**; FS116-Y4-EMPTY's double-tip step is the same
   statement inside the same class. Read as arguments, both use only: two change points `60°` apart; RING-GERM (i) at each (the tip cone filled with
   tips), which needs only that the two germs of each one's tip pair lie on no (Q) arc; the flank lemma (colour-free, Siamese allowed); FS116-N2-STAR
   for the flank tiles' colours; and V4-TWIST. Two of the four tip-pair germs are free: at `y` the germ `u⁺` is the ring just counter-clockwise of
   `y′`, off `Γ` because `y′` is a change point, and at `y′` the germ `v′⁻` is the ring just clockwise of `y`. So the class the argument carries is
   **every ring**, with two germs off (Q) arcs — the instance was filed where a wider class was carried (the identity's second failure of the cut). It
   is Y4 § 3.4's "neighbour 2" ("a semi-hub (FS116-N3-SEMI) whose tip is shared with the next change point", there "unread") and Poros's card 2,
   rank 1 (`plans/POROS-2026-10-03-close-reread.md` l. 486). It serves FS-124 (cases 1 and 5: the placing rule's semi-hubs and the recurrence's ring
   types) as a pruning rule.
2. **Near miss — SEMI-PAR3** (J2). Kind O has no tip at `y`; kind T's points `y ± 60°` lie at the ends of its two (Q) arcs (`u⁻` on `A⁻`, `v⁺` on
   `B⁺`), so they are not change points and DOUBLETIP does not apply. I checked the six same-colour pairs SEMI-PAR3's forced shape
   (`plans/FS116-N3-proof.md` § 3.2) holds at radius `1 + ε`: `X` and `X̄` have one tile each at `y` and their other tiles near `u`, `v` sit across
   (Q) arcs; `C` (colour of `t_back`) and `t_back` face away from each other across a unit distance (FS114-N3-LOCAL's N3-FACE), pinned to no second
   circle; `t_a` and `O_B` (colour `a`), `t_{a′}` and `O_A` (colour `a′`) hug the one circle `ω(p)` at angular distance at least `120°`; `t_front`'s
   colour is absent at `y`. **The hypothesis that fails: no pair of same-colour tiles is pinned to two unit circles about a unit pair inside
   `B̄(p, 1 + ε)`**; a straddle there must read `y`'s ring (the lead of § 4 below).
3. **Near miss — DOUBLETIP's ends with an outer germ on a (Q) arc.** If `v⁻` at `y` (or `u′⁺` at `y′`) lies on a (Q) arc, RING-GERM (i) is not
   available there and FS116-N3-CONE only bars the arc's two colours from the tip cone; another colour of `p` may share it. The hypothesis that fails:
   the tip cone filled by the shared tip alone.
4. **Near miss — the Siamese class** (J7, FS-123's question 3, now its main question). The straddle survives Siamese pairs (EMPTY's own parenthesis),
   so DOUBLETIP's last step does; what fails is upstream — "the only tip", "one tile per colour at `y`" (used to identify the flank tile `a` with the
   ring tile `R′`) and FS116-N2-STAR, each stated non-Siamese. The hypothesis that fails: one tile of each colour at a change point. (FS116-S1-CLUSTER and
   FS116-V4-MEET suggest the repair — read "tile" as "the same-colour tiles at a point", which are pairwise near — but a cluster's cone at `y` need not
   be one interval, which the colour step uses; not derived.)
5. **Not read: FS114-K1's residues on (Q) rings** (J17 case 6) — FS114-Y6-E2RED's survivor S6 `(120°, b, 180° − b, 60°)`, the wrap, and the Reuleaux
   `(2, 1, 1, 0)` past `√3`. Each is a configuration where a straddle along two unit circles is the held kill of its neighbours (S1 died to PXKILL); I did
   not reach them in this pass. Listed in the table of misses as unread, for pass 3.

derivation: FS129-MR1-DOUBLETIP
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let
    y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring of p such that neither the arc of ω(p) just clockwise of r(ψ − 60°) nor the arc just
    counter-clockwise of r(ψ + 120°) lies on a (Q) arc; then no tile of p is at once the only tile of p whose closure holds y and the only tile of p
    whose closure holds y′
  uses only: FS116-RING-GERM (i) at y and at y′ (the open cone of 60° about the direction to p lies in cones of tiles of p when neither germ of the
    tip pair lies on a (Q) arc); FS116-Y4-FLANK (colour-free, Siamese allowed); FS116-N2-STAR (C(y) = A(p) ⊔ T_y ⊔ O_y at a change point, p of four
    colours); FS116-V4-TWIST (germs 60° apart carry different colours; a ring point inside a tile has an absent colour); FS116-V4-DICHOTOMY;
    non-Siamese (one tile of each colour at a point; an outer tile misses B(p, 1)); simple (one cone per tile at a vertex)
  not claimed: anything when the arc just clockwise of r(ψ − 60°) or just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; that y or y′ has a
    single tip in general (two tips at either are not excluded); SEMI-PAR3 (its points y ± 60° lie at (Q) arc ends, not change points); the Siamese or
    non-simple class; anything at k ≥ 7 (three absent colours: the flank tiles' colours may differ, control fs129-mr1-doubletip's plant)
  converse: one-way — "the only" names the hypothesis (a sole shared tip), and the statement is a non-existence, not a characterization
  argument: § Argument for FS129-MR1-DOUBLETIP
  verdict: derived
  grade: derived from: FS116-Y4-FLANK, FS116-RING-GERM, FS116-N2-STAR, FS116-V4-TWIST, FS116-V4-DICHOTOMY
  minds: 1
  model: none can exist (a non-existence); the hypotheses without the shared tip are FS116-V6-HUG's class when the ring carries no arc of Γ (empty by
    FS116-Y4-EMPTY), and no held fragment has two change points 60° apart (the capped strip's change points have u⁺ and v⁻ on (Q) arcs; the disk's
    corner has y ± 60° inside (Q) arcs); its colour, flank and cone steps are control fs129-mr1-doubletip
  prior art: owed — an in-house composition; its argument is FS116-V6-HUG's and FS116-Y4-EMPTY's, whose own prior art is unsearched
    (`plans/STUB-qfree-ring.md` § Prior-art debts)
  handoff: de Bruijn — the statement and its not claimed, over FS116-Y4-FLANK, RING-GERM (i) and N2-STAR; it carries FS116-V6-HUG as its Γ-free
    instance, so the kernel module should prove this form once and V6-HUG from it

control: fs129-mr1-doubletip
  of: FS129-MR1-DOUBLETIP — the colour step (two absent colours force one flank colour), the flank geometry (least-curved edges 2cos φ − 1 apart;
    V6-HUG's identity; YB4-2ND's form of PXKILL's pair equal to it; the three-step closure), and the cone step (no interval escapes)
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-colour

control: fs129-mr1-doubletip-flank
  of: FS129-MR1-DOUBLETIP — the flank step reads the edges' curvature: tangent segments stay 1 apart
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-flank

control: fs129-mr1-doubletip-cone
  of: FS129-MR1-DOUBLETIP — the cone step reads the shared tip's cone: without it an interval of directions escapes
  run: python3 ../tools/fs129_mr1_doubletip.py
  expect: colour ok; flank ok; cone ok
  fault: python3 ../tools/fs129_mr1_doubletip.py --fault-cone

#### Argument for FS129-MR1-DOUBLETIP

Suppose `t` is the only tile of `p` at `y` and at `y′`. Put `ψ = 0`. By RING-GERM, `p` has four colours and no more, absent `X`, `X̄`.
1. *The tip cones.* At `y` the tip pair is `{v⁻, u⁺}`: `v⁻` lies on no (Q) arc by hypothesis, and `u⁺`, the ring just counter-clockwise of `y′`, is
   off `Γ` because `y′` is a change point. So RING-GERM (i) puts every direction of `(150°, 210°)` at `y` in the cone of a tile of `p`, which is `t`.
   At `y′ = r(60°)` the tip pair is `{v′⁻, u′⁺}`: `v′⁻` is the ring just clockwise of `y`, off `Γ`; `u′⁺` lies on no (Q) arc by hypothesis; so `t`'s
   cone at `y′` contains `(210°, 270°)`.
2. *The flank.* FS116-Y4-FLANK applies to `t`, `y`, `y′`: `t`'s cone at `y` ends at `210°` and at `y′` begins at `210°`; the tile `a` beyond `t`'s edge
   at `y` and the tile `b` beyond its edge at `y′` have closure points less than 1 apart.
3. *The flank tiles' colours.* `a`'s cone at `y` begins at `210°`, an inward direction (`|y + s e(210° + η)| < 1` for small `s, η > 0`), so `a` meets
   `B(p, 1)`. An outer tile misses `B(p, 1)`: a point `z` of it with `|z − p| < 1` would make it near `p`'s tile of its colour (V4-DICHOTOMY, `p` in
   that tile's closure), hence equal to it (non-Siamese). And `a` is not a tile of `p` (`t` is the only one at `y`, and `a ≠ t`). By N2-STAR every
   colour at `y` is absent at `p`, a tip colour or an outer colour; so `a` has colour `X` or `X̄`. One tile of each colour is at `y`: `R` (colour
   `c(0+)`, holding the ring just counter-clockwise, so its cone holds directions just above `90°`) and `R′` (colour `c(0−)`, holding the ring just
   clockwise, directions just below `270°`). If `a = R`, `R`'s cone — one interval (simple) — holds `210°` and directions just above `90°`, so it
   contains `(150°, 210°)`, inside `t`'s cone, or, the other way round, `270°` in its interior, where `R′` holds the ring points `r(−δ)`: both
   impossible (control `fs129-mr1-doubletip`'s cone step). So `a = R′`, of colour `c(0−)`, holding `r(−δ)`. At `y′` likewise, with the roles turned:
   `b` lies before `t` clockwise, its cone ending at `210°`, inward at `y′`; it is `y′`'s counter-clockwise ring tile, of colour `c(60°+)`, holding
   `r(60° + δ)`.
4. *One colour.* `c(60°+) ≠ c(0+)` (V4-TWIST: the germs just counter-clockwise of `y` and of `y′` are `60°` apart, both inside tiles) and
   `c(0+) ≠ c(0−)` (`y` a change point); all three lie in `{X, X̄}` (V4-TWIST's second clause). So `c(60°+) = c(0−)`: `a` and `b` have one colour.
5. *The straddle.* `|r(−δ) − r(60° + δ)| = 2 sin(30° + δ) > 1`, so `a ⊥ b`; step 2 gives closure points below 1 apart, so `a ~ b` (V4-DICHOTOMY).
   Contradiction. ∎ (The last step needs no non-Siamese; steps 1 and 3 do, through RING-GERM, N2-STAR and one tile per colour.)

*Look-back.* Could it have been foreseen? Yes — V6's own note says the kill is "validity alone"; its class restriction (Γ-free) entered only through
V6-HUBS' and V6-TIP's setting. Does it deform into its neighbours? At three absent colours it fails (control plant); with an outer germ on a (Q) arc it
fails at RING-GERM (i) (near miss 3). V6-ADJ (outer tiles of one colour at adjacent hubs, each hugging the lens arc beyond its hub) is the same
under-reach on the vesica's other Reuleaux triangle; its wider form wants the outer pairs off (Q) at both change points and is not derived here.

### Mechanism 3a — V6-HUG's identity `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`

**What it is.** Points `a(s)`, `b(t)` on the two unit circles about a unit pair `{y_0, y_1}`, each measured from the other centre toward the apex
`p` of the Reuleaux triangle on `p, y_0, y_1`, are less than 1 apart for `0 < s, t ≤ 60°` (display at `plans/FS116-V6-verification.md` l. 159).
Poros named it (card 2): the three-unit-step closure `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)`, the constant width of the unit Reuleaux
triangle. **Kind of input:** points and distances on two unit circles about a unit pair — the straddle's pin, made exact.

**Used at — one law found three times.** Expanded, the right side is `2(1 − cos s)(1 − cos t) − 2 sin s sin t`, which is **FS114-YB4-2ND's exact form
of FS114-Y5-PXKILL's pair** (`plans/FS114-YB4-verification.md` l. 20: "`|A − B|² = 1 + 2(1 − cos s)(1 − cos s′) − 2 sin s sin s′` on the arcs"), whose
leading order is FS114-YB2-DE's `1 − 2tt′` (`plans/FS114-close-inventory.md` item 71). So Kooshi's identity was already used at FS-114, to kill the
pinwheel family `P_x` at `1 + ε`, in expanded form and unnamed; FS-116 found it again in product form (V6-HUG, V6-ADJ), and FS116-Y4-FLANK's least-curved
case `2cos φ − 1` is its diagonal `s = t` (item 142). Control `fs129-mr1-doubletip` checks the two forms equal symbolically. A merge for pass 3: one
lemma, "two unit circles about a unit pair", with PXKILL, V6-HUG, V6-ADJ and FLANK's model as its instances.

**Where it bears and was not applied.**
1. **DOUBLETIP** (above) — through FLANK, whose least-curved edges are the identity's arcs; card 2's rank 1, answered for hubs and kind-T semi-hubs.
   **Card 2's conditional, scored:** "if the shared-tip semi-hub qualifies: the exclusion narrows … SEMI-PAR3" — it does not reach SEMI-PAR3 (near miss
   2 of mechanism 1); Poros's hunch (0.5) is met for the configuration and not for its hoped-for reach.
2. **Near miss — card 2's rank 4, the five- and six-colour vertices** (J5). There the outer tiles over (Q) arcs hug the one circle `ω(p)`; the
   identity needs two circles about a unit pair. The hypothesis that fails: a tile pinned to `ω(z)` for a ring point `z`. Untested whether FS116-N2-SIXRING's
   Reuleaux tiles `t_i ⊂ Reul(p, z_i, z_{i+1})` give one; any use must fail on FS116-Y2-SIXFRAG below `3/2`.
3. **Route R** (J16): the deficit is second order in the hug lengths (FS-122's filed datum, `plans/STUB-forced-pair.md` l. 42); DOUBLETIP inherits it:
   FLANK's margin is `(κ_a + κ_b)s²/2`, so a band of slack `ε` is survived only at edge lengths `s ≳ √ε` (G82: priced at the feature's scale). Nothing new
   to derive.

### Mechanism 3b — FS129-OR1-WHOLE's identity `|x − e|² = (|x|² + |x − 2e|²)/2 − 1`

**What it is.** Apollonius's median identity at the midpoint `p + e` of `p` and `p + 2e`: a point within `ρ` of `p` and within 1 of `p + 2e` is
within `√((ρ² − 1)/2)` of `p + e`, which is below 1 exactly while `ρ < √3`. **Kind of input:** points and distances — it says when a tile pinned at
distance 2 is visible inside a disc of radius `ρ`.

**Its `√3` is the second shell.** The lens corners at `ρ = √3` are the points at distance 1 from `p + e` and from `p + 2e` and `√3` from `p`: the
rhombus completions `y + y′ − p` of two ring points `60°` apart. That is the `√3` of FS114-Y3-RSTOP (`r = q1 + e(330°) = (√3, 0)`), of the `q_k` of
FS116-Y3-TIGHTLENS and -STARFORCE and of FS116-Y2-SIXOFF — one shell of the unit triangular lattice about `p`, not one mechanism: those stops are
read at the shell's points; WHOLE's identity reads a tile through it.

**Used at:** FS129-OR1-WHOLE, hence -BENDFRAG, -BEND3, -QFREE (pass 1). **Where it bears and was not applied: null.** The other places a witness at
distance 2 is read — FS116-N1-ECHO and -V3-ECHO-ONLY (`2w − p`), FS116-Y4-SPOKE (`2y_2`) — need the witness to be present (their conclusions are about
the point at distance 2), where the identity says only when it cannot be seen; their discs are of radius above 2 by statement. Searched: the
statements naming `2w`, `2y`, `2u`, `R₂(`, "radius 2", "√3".
