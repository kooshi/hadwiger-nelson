# FS-110 — theorems proved outside the kernel (the derivation file)

*Filed by the close planner FS110-C (de Bruijn, Opus 5.5), 2026-09-27, from the records `plans/FS110-N-proof.md` (the proof side: FS110-N, then
§ Continuation — FS110-N2, N3, N4), `plans/FS110-Y-construction.md` (the construction side: FS110-Y, Y2, Y3, Y4; the sides blind to each other until
hand-back), the blind verifiers `plans/FS110-NB-verification.md`, `FS110-YB-`, `FS110-NB3-`, `FS110-YB3-`, `FS110-NB4-`, `FS110-YB4-verification.md`, the
blind checks of the base `plans/FS110-CB-verification.md`, `plans/FS110-CD-verification.md`, `plans/FS110-CC-verification.md`, the second mind at cusp
vertices `plans/FS110-CE-verification.md` (FS110-CE1–CE7, filed by job BK of the consolidation run, 2026-09-27), the prior-art check
`plans/FS110-PA-prior-art.md`, and the advisors `plans/POROS-2026-09-27-fs110-tangency-seam.md` (FS110-A) and `plans/POROS-2026-09-27-fs110-competition.md`
(A2–A6). Reconciliation: `data/fs110/fs110-c/reconciliation.md`. Notation: `data/fs110/claims.md` §0, §7.1, §8. `𝓜_K`: FS-107's locally finite maps with
at most `K` circular or straight arcs per unit disc and radii at least `1/K`; a map is **valid** when it is a full a.e.-proper six-colouring (no two interior
points of one colour at distance exactly 1); **Condition 5** (`[SokolovVoronov2025]`): every boundary meets every unit circle in finitely many points —
in `𝓜_K`, no boundary arc of radius 1 (Y3-C5). `P_cl(u)`, `P_ess(u)`: closure and essential types. Grades carry no nested brackets.*

**The milestone's result in one paragraph.** Under Condition 5, no locally finite map of the plane whose boundaries are segments and circular arcs, none of
radius 1, carries a six-colouring in which no two interior points of one colour are at distance exactly 1 (FS110-CLOSURE): the Condition-5 half of
`[SokolovVoronov2025]` Question 2 is answered **yes, seven colours are needed**, almost everywhere, for such maps. The chain: under Condition 5 no vertex
has four colours and no close covering pair exists (NB-4, NB-5); Woodall's merge, almost everywhere and for curved arcs, removes every two-sector colour
outside Woodall's cone (W-MERGE, N3-DEG); a shave, a ray merge and a propagation lemma remove the cone, since a cone no move removes forces a bi-infinite
chain along its normal line that curvature monotonicity forbids (the N4 chain); the terminal map is cubic, and S–V's Corollary 1, proved almost everywhere
for curved cubic maps with no `d = 2` exception (CB, CD), refutes it. Grade: the chain two minds, one blind; the base two minds, both blind; the base at
cubic vertices with a cusp sector two readings at D2, D5 item 5 and D1, one reading at D4, and at D5 items 1–4, 6 one mind after CE's local repair
(FS110-CE1–CE7). Not in print (FS110-PA).
Beside it: the local calculus of close complementary vertices, the Act-One and winding apparatus the rounds built on the way (off the headline's path,
with one GAP, YB3-SAME), and exact local fragments of every seam (two checkers). Nothing moves a value: the unit-arc half of Question 2 is open.

## §1. The headline and its chain

**FS110-CLOSURE — Under Condition 5 no locally finite map of the plane bounded by segments and circular arcs carries a full a.e.-proper six-colouring; the Condition-5 half of S–V Question 2 is answered yes, almost everywhere. [hand; the chain two minds, one blind; the base two minds, both blind; the cusp scope two readings at D2, D5 item 5 and D1, one reading at D4, and D5 items 1–4, 6 one mind after CE's repair]**
*Proof:* NB-4, NB-5; W-MERGE; N4-TERM and N4-CONE (every valid map has a terminal valid modification, cubic at every vertex); FS110-COR1-NOD2 on the
modification, with FS110-CUSP-BASE for cubic vertices whose third colour is a doubly shadowed single horn (the residue, FS110-NB4-CS; it exists locally,
FS110-A6-C2). Headline as A6-2.1 states it (`plans/POROS-2026-09-27-fs110-competition.md` l. 1485). *Proof verdict:* holds given the base at cusp sectors
(NB4 §2.9); the base at cusps read twice at D2, D5 item 5, D1 (A6-1.5; CC); D4's bicycle read at cusp vertices once (FS110-CE1), D5 items 1–4, 6 true there after CE's local repair (FS110-CE6). **Polarity:**
N4-4 wrote "answered NO" — a sign slip (A6 §7; NB4 D1). **Scope:** no step uses the complexity bound `K` (A6-C1; NB4-TM and NB4-SC use local finiteness
only), so the map statement is for every locally finite map; `K` is load-bearing only in FS-107's W-EQ-K, where vanishing holes become a map. *Rests on it:*
with W-EQ-K (row 133), under Condition 5 vanishing holes at bounded complexity cannot save a colour; FS-110's question left at the unit-arc half. *Prior art:*
not in print (FS110-PA: Condition 5 without Condition 6 not settled, stated or asked); S–V prove seven under Condition 6 (Thm 1, itself a GAP at Prop. 19's
fills, row 132); S–V Lemma 2 is NB-4's four-colour half; W-MERGE and SHAVE are curved-arc forms of S–V Props. 7–8 and of `[Woodall1973]` step 3. *Kernel:*
stub — the map argument in Lean (§ The aim's "Lean throughout"), with FS-110's successor.

**FS110-NB-4 — In a tight six-map in `𝓜_K` under Condition 5 no vertex has four colours (nor five). [hand; two minds, one blind: NB; A4]**
*Proof:* NB §2.3 (each of the four colours squeezed into 60° of the ring; 240° < 360°); A4 stage 2 checked it step by step. *Proof verdict:* TRUE. The
general form (read as FS112-NB4P at FS-112's close): a four-colour vertex needs an arc of `Γ` of `ω(σ_v^{±1}y)` with a change point of every orbit of its ring in its closure, or an orbit point in the closure of an arc of `ω(v)`. *Rests on it:* NB-5;
the N4 chain at every stage (K-TIGHT). *Prior art:* its four-colour half is `[SokolovVoronov2025]` Lemma 2 (FS110-PA), TRUE region-only (FS106-V).
*Kernel:* with FS110-CLOSURE.

**FS110-NB-5 — Under Condition 5 a tight six-map in `𝓜_K` has no close covering pair. [hand; two minds, one blind: NB; A4]**
*Proof:* NB §2.4, over N-SEAM, N-X (a)–(b) and NB-4, each re-derived there: the common unit point would be a vertex of exactly four colours. A4: no
disjointness is needed (the branch colours lie outside `u`'s type and outside `v`'s). *Proof verdict:* TRUE. *Rests on it:* the tangency seam is closed
under Condition 5 (A4-2); Y3-PROP. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-W-MERGE — Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is nonempty, two non-adjacent `c`-sectors at `v` are joined by recolouring the gap inside `D_c(v)` near `v`; validity and Condition 5 kept, types only shrink. [hand; two minds, one blind: N3; NB3]**
*Proof:* N § Continuation — FS110-N3 §2.2; NB3 §2.2 (NB3-MERGE). *Proof verdict:* TRUE with two one-line repairs (NB3): choose `ρ` off finitely many
values (the step "`cl R ∩ ω(v′) ⊆ {v}`" fails at `|v′ − v| = 1 ± ρ`); fill the hole a merge of two sectors of one tile encloses (Woodall's step 1). Inputs
N3-CONF, N3-CLEAR, N3-UP (FS110-N3-CONF). *Rests on it:* N3-RED; the N4 chain. *Prior art:* `[Woodall1973]` step 3 (everywhere-proper, read by NB3 and
Y4); S–V Props. 7–8 for polygons. *Kernel:* with FS110-CLOSURE.

**FS110-N3-CONF — Contacts of a colour on `ω(v)` are in-type or out-type; directions of `c`-sectors lie in `D_c(v)`; compact sets inside `int D_c(v)` are clear near `v`; tangent in- and out-contacts are upward closed. [hand; two minds, one blind: N3; NB3]**
*Proof:* N3 §2.1 (N3-CONF, N3-CLEAR, N3-UP; exact checks C1–C2 in `tools/fs110_n_merge.py`); NB3 §2.1. *Proof verdict:* TRUE; NB3 reads N3-UP's lens as
`{w ∈ B̄(x, 1)}`. *Rests on it:* W-MERGE; N3-DEG. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-N3-DEG — `int D_c(v)` is empty only in Woodall's cone: out-type `c`-contacts at both `v ± n`, every `c`-sector a cusp horn along `±a` with bounding curvatures in `(−1, 1)`. [hand; three minds, two blind: N3; NB3; NB4]**
*Proof:* N3 §2.3; NB3 §2.3; NB4 §2.5. *Proof verdict:* TRUE. *Rests on it:* N3-RED; N4-STUCK. *Prior art:* the cone is `[Woodall1973]`'s, excluded there
by his step 5 only at five colours. *Kernel:* with FS110-CLOSURE.

**FS110-N3-RED — A tight six-map in `𝓜_K` under Condition 5 has, in every disc of radius 3, a hard Woodall-cone vertex or S–V's `d = 2` configuration, given S–V Cor. 1 for cubic maps. [hand; two minds, one blind: N3; NB3]**
*Proof:* N3 §2.5; NB3 §2.5 (uses no tightness, windings or even counts). *Proof verdict:* TRUE; repairs: merge within `ρ` or restate at radius 4
(NB3); "hard" means doubly shadowed (N4), not tip-hard (Y4) (A6; YB4 S5). Superseded as a residue by the N4 chain and CB/CD (G-d2 does not arise).
*Rests on it:* round 4's frame (claims §8). *Prior art:* not found in print. *Kernel:* declined — superseded by FS110-N4-TERM.

**FS110-N4-SHADOW — The shadow near `v` of a tile at `N = v + n` beyond an arc tangent to `a` at `N` is one side of the circle through `v` concentric with that arc; curvature `f(λ) = λ/(1 + λ)` going down, `f̃(υ) = υ/(1 − υ)` going up; a horn is shadowed by its flanks only through out-type tiles at `S′` and `N` tangent to `a` (N4-FLANK). [hand; four minds, two blind: N4; Y4 as Y4-MU; NB4; YB4]**
*Proof:* N § Continuation — FS110-N4 §2.1–2.2, `tools/fs110_n_shadow.py`; NB4 §2.1–2.2 (NB4-SH, NB4-FL), `tools/fs110_nb4_check.py` C1; Y4 §11.2;
YB4 §2.3. *Proof verdict:* TRUE; the map `λ/(1 + λ)` derived four times, twice blind, and discriminated exactly (`κ₂ = 3/10` ACCEPT, `9/25` REJECT at
`µ = 1/3`). *Rests on it:* N4-SHAVE; N4-FIN. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-N4-SHAVE — A horn tip can be recoloured by its two flank colours, valid and keeping Condition 5, unless doubly shadowed (`σ_h < σ_g`); two horns of one colour on one ray merge (N4-RAY). [hand; two minds, one blind: N4; NB4]**
*Proof:* N4 §2.2–2.3; NB4 §2.3–2.4 (NB4-SV, NB4-RY; RAY by an exact route replacing N4's second-order bound, D5). *Proof verdict:* TRUE. Controls: WC1H is
tip-hard yet shaveable (`σ_g = σ_h = 0`; A6's exact split ACCEPTs on Y's checker, `data/fs110/fs110-a6/a6_shave_wc1h.py`; NB4-WC1H). *Rests on it:*
N4-STUCK; N4-TERM. *Prior art:* the curved form of S–V Prop. 7. *Kernel:* with FS110-CLOSURE.

**FS110-N4-STUCK — At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns `±a`, the vertex has degree 4, and the antipodes carry `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}` with double sectors; in a terminal map a stuck vertex forces stuck vertices at unit spacing along the normal line, bi-infinite (N4-PROP). [hand; two minds, one blind: N4; NB4]**
*Proof:* N4 §2.4–2.5; NB4 §2.5 (NB4-ST, by a second route: no-MERGE for every colour plus NB-4, D6). *Proof verdict:* TRUE. Control: WCH is N4-STUCK (iv),
the chain cut off where the fragment ends (A6; NB4-WCH). *Rests on it:* N4-FIN. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-N4-FIN — No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`. [hand; two minds, one blind: N4; NB4]**
*Proof:* N4 §2.6 (exact check C3); NB4 §2.6–2.7 (NB4-CH, NB4-FN; C2 with a plant: strictness `λ_k < υ_k` is necessary, the constant `(0, 0)` survives
otherwise). *Proof verdict:* TRUE; the inequalities come from validity of the flanks alone. *Rests on it:* N4-CONE. *Prior art:* not found in print.
*Kernel:* with FS110-CLOSURE — an exact inequality chain, a leaf.

**FS110-N4-TERM — Every valid map has a terminal valid modification (each point changed finitely often), and in it no colour has two sectors at any vertex: every vertex is cubic, sectors possibly cusp horns (N4-CONE, N4-RED). [hand; two minds, one blind: N4; NB4]**
*Proof:* N4 §2.7–2.8; NB4 §2.8–2.9 (NB4-TM). *Proof verdict:* TRUE, with NB4's precisions: count `Φ` plus the number of horns (horns never increase), so
shaves of single horns join the moves (D3); straight cuts keep the radius bound, `M* ∈ 𝓜_{O(K)}` (D4, NB4-SC). *Rests on it:* FS110-CLOSURE. *Prior art:*
not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-NB4-CS — The terminal map's only surviving cusp horns are single horns that are doubly shadowed with `D_c(v)` the line `±a`: single-horn Woodall cones. [hand; one mind: NB4, with N4's wedge-opening a sketch]**
*Proof:* NB4 §2.9, §4.1 D3. *Proof verdict:* one mind; the object exists locally (FS110-A6-C2). *Rests on it:* the base's cusp scope is exactly this
residue. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-COR1-NOD2 — S–V Corollary 1 holds almost everywhere for curved cubic maps under Condition 5 with no `d = 2` exception, for same- and disjoint-multicolour pairs. [hand; two minds, both blind, different routes: CB; CD]**
*Proof:* CB §D5–D6 (a circle-only reduction replacing S–V Prop. 19's plane recolouring; every pigeonhole endpoint in the open disc or a V-in vertex on
`ω(u)`); CD §2.2–2.7 (Lemmas H, H′, L, E, R; Theorem D2: antipodal same-multicolour endpoints give `R_i ⊆ B̄(p, 1) ∩ B̄(p′, 1) = {u}`, the disjoint pair
leaves the cusps at `u` uncovered), `tools/fs110_cd_checks.py`. *Proof verdict:* TRUE; CB's "open disc" a GAP at (E3), (β) (FS110-CE4), harmless via D2 (CD) and closed by CE's repair (FS110-CE5, CE6); CB's item 2
fails at (β) and spike returns (FS110-CE3), item 1 needs (ii) (FS110-CE7); Lemma 5
and Prop. 18 re-derived by CD, from print in CB; CD takes Props. 9–11 and 17 from print. *Rests on it:* FS110-CLOSURE; row 132's `d = 2` exception struck
(FS106-SV2, FS106-AE-POLY, FS106-AE-CONV). *Prior art:* `[SokolovVoronov2025]` Cor. 1 everywhere-proper; the a.e. form and the `d = 2` closure not in print.
*Kernel:* with FS110-CLOSURE.

**FS110-CB-LEMMA3 — S–V Lemma 3 holds almost everywhere for all `1 < d < 2`, by Voronov's bicycle run on the two pseudo-coloured circles; the printed Fig. 5 argument fails from `√3` on. [hand and tools; two minds, one blind: CB; FS106-V's sketch]**
*Proof:* CB §D3–D4 (for `d > √3` one partner overshoots `z₁`, turning at `cos θ* = (3 + d²)/(4d)`; the printed three-cycle fails since `|q₃ − u₁|² = 2 +
2cos(2θ₀ − 60°)`, equal to 4 only at `d = √3`), `tools/fs110_cb_geometry.py`. *Proof verdict:* TRUE (CB, a full derivation, blind); FS106-SV2's repair
was a sketch. *Rests on it:* FS110-COR1-NOD2; FS106-SV2's weakest link. *Prior art:* `[SokolovVoronov2025]` Lemma 3, whose printed proof fails at
`√3 ≤ d < 2`; the bicycle is `[Voronov2023]` Thm 1.2, §5. *Kernel:* with FS110-CLOSURE.

**FS110-CUSP-BASE — CB's route holds at cubic vertices with a cusp or double cusp at D2's strip (a)–(c), D5 item 5 and D1's (P′); along a cusp's normal `|u ± n − x(m)|² − 1 = 4R(R ∓ 1)m²/(1 + m²)`. [hand and tools; two readings at these steps: A6 sighted, CC; D4 one reading, CE; D5 items 1–4, 6 one mind after CE's repair]**
*Proof:* CC §C1–C6 (`tools/fs110_cc_cusp.py`, two plants firing for their named reasons); A6-1.5. *Proof verdict:* no step fails, no repair; CB's D5 item 5
omits an inner-`q` case, impossible by the same branch constraints (a completion). Read at cusps by CE: D4's bicycle (FS110-CE1, CE2), and D5 items 1–4, 6, true after CE's repair (FS110-CE3–CE7);
S–V's printed Prop. 17 at a horn rests on Prop. 16 there (CD's from-print route). *Rests on it:* FS110-CLOSURE at the residue. *Prior art:* not found in
print. *Kernel:* with FS110-CLOSURE.

**FS110-CE1 — CB's D4, Lemma 3's exact bicycle with the overshoot for `d > √3`, holds at cusp and double-cusp vertices: the map enters only through (i), (ii), `|c′| ≤ 2`, closedness and finiteness, and spikes are harmless. [hand and tools; one mind on cusps: CE; D4's endpoint cases two minds: CB; CE]**
*Proof:* CE §E1 (the map's inputs M1–M4 read line by line from CB's D4; (ii) re-proved at a spike, word for word CB's proof; the endpoint cases
exhausted with the unknown second colour of a spike adversarial), `tools/fs110_ce_scope.py` BIKE (0 surviving assignments for `d ≤ √3` and for
`d > √3`; the plants `noII`, 48 survivors, and `noClosure`, 16 and 48, fire). *Proof verdict:* TRUE, one mind on cusps; the cusp enters only through
D2, read by CC, and through spikes. *Rests on it:* FS110-CUSP-BASE at D4; FS110-CLOSURE at the cusp residue (FS110-NB4-CS). *Prior art:* not found in
print; the bicycle is `[Voronov2023]` Thm 1.2, §5, as in FS110-CB-LEMMA3. *Kernel:* with FS110-CLOSURE.

**FS110-CE2 — CB's "WLOG n = −1" completed: with each 60° step of the E band written `3k + e`, `e ∈ {1, 2}`, every band offset `k ≠ 0, −1` dies on the D band, and `k = −1` is `k = 0` negated. [hand and tools; one mind: CE]**
*Proof:* CE §E1, "A completion CB owes" (`D_y − D_z = 6k + e1 + e2 − J + J_z` lies in `{−1,0,1}` only for `k ∈ {0, −1}`); BIKE runs `k ∈ [−3, 3]`,
0 survivors. *Proof verdict:* TRUE; a completion of CB's step as written, not a repair. *Rests on it:* FS110-CB-LEMMA3; FS110-CE1. *Prior art:* not
found in print. *Kernel:* with FS110-CLOSURE.

**FS110-CE3 — CB's D5 item 2 parenthetical, that the recolouring colour a is also the circle's colour just outside the arc at both ends, is FALSE at CD's configuration (β) and at spike returns, and TRUE at every return where the circle changes colour. [hand and tools; two minds at (β): CD; CE. One mind at spike returns: CE]**
*Proof:* CE §E3: at (β) a rational instance (BETA, exact: `v′ = (1,0)`; P the circle of centre `(4/3, 4/9)` and radius `5/9`, tangent to the a|c
edge at `v′` and through `b = (4/5, 3/5)`; 902 rational points of its arc in the open disc), so item 2 recolours `[b, v′]` by a while `ω(u)` just
beyond `v′` is c; at a spike return (SPIKE: a circle of radius 1/2 tangent to `ω(u)` from inside at `s = (1,0)`, or a path through a spike corner),
and in cusp form a horn tangent to `ω(u)` from inside; the positive half at a transversal crossing, a corner the circle crosses, or a V-out vertex.
`tools/fs110_ce_scope.py` BETA, SPIKE. *Proof verdict:* FALSE as stated; two minds at (β) (FS110-CD §4.1; CE's rational instance), one at spike
returns. *Rests on it:* the local repair R1–R4 (FS110-CE6); row 134's Corrections clause. *Prior art:* not found in print; CB's D5 is his replacement
for S–V Prop. 19's plane recolouring. *Kernel:* declined — a counterexample to CB's text; its positive half is carried inside FS110-CE6.

**FS110-CE4 — CB's D5 item 4, that every surviving colour change's inward path ends at a trichromatic vertex of the open disc, has a GAP at (E3) and at (β), with cusp instances; its "third colour in {4,5,6}" holds, endpoints on the circle included. [hand and tools; two minds: CD; CE]**
*Proof:* CE §E5: at (E3) a selected change that is a V-in vertex has its a|c edge outside the disc, so no inward path, and its trichromatic point
lies on `ω(u)`; cusp instances E3H (exact: an i-horn tangent to `ω(u)` from inside, edge curvatures 2 and 3), an a-horn whose a|c edge leaves
tangentially outward, and a double cusp tangent to `ω(u)`; at (β) `v′` survives under item 2 as written; the third colour by `|c′| ≤ 2`.
`tools/fs110_ce_scope.py` E3H. *Proof verdict:* GAP as written; repaired by R2 and R4 (endpoints in the open disc, or V-in vertices on the circle).
*Rests on it:* FS110-CE6; row 134's Corrections clause. *Prior art:* not found in print. *Kernel:* declined — a GAP in CB's text, superseded by
FS110-CE6.

**FS110-CE5 — The Antipodal Lemma: at a trichromatic cubic vertex u, cusps and double cusps allowed, no two M-in points of `ω(u)` are at distance 2; it is one-sided, and two antipodal points may both have the strip inside. [hand and tools; one mind: CE]**
*Proof:* CE §E6 (a point x of `ω(u)` is M-in if a tile of a colour of `M = c(u)` has x in its closure and interior points strictly inside the circle
arbitrarily close to x): at an M-in point `u + e` the strip's majority side is outside, by D2's strip and CC's C2 along a horn's normal, so two of
u's arcs vote outside there; an arc point `x ≠ u` cannot lie within 1 of both `u + e` and `u − e`, since `2 = |2e| ≤ |u+e−x| + |x−u+e| < 2`; so
the outside votes at ±e number at most three, not four. No tangent is used. `tools/fs110_ce_scope.py` AL: an ordinary vertex, three cusps and a
double cusp over 46 directions including the horn normal; the `nearAntipodal` plant fires. *Proof verdict:* TRUE, one mind; one-sided (at the a6
cusp all three arcs vote inside at both ±n), which is why R2 ends paths only at V-in vertices. Its step 'at an M-in point the strip's majority side is outside' is not needed — the in-vote count carries it, unit arcs included (FS112-N3-ANTI; FS-112's close). *Rests on it:* FS110-CE6; the `d = 2` closure's
second route, beside CD's Theorem D2 (row 134's grade; FS110-COR1-NOD2). *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-CE6 — CB's D5 repaired by R1–R4 and the Antipodal Lemma: every pair the chain hands to S–V Lemma 3 or Cor. 3 is at distance below 2, at cusp centres and cusp endpoints included, so S–V Cor. 1 almost everywhere needs no `d = 2` exception. [hand; one mind by this route: CE]**
*Proof:* CE §E3's repair (R1 an inward a|c path continues through every spike it meets; R2 it ends at its first trichromatic vertex, which may be
a V-in vertex on the circle; R3 only returns at colour changes of the circle are circle-to-circle, and only their arcs are recoloured; R4 a
selected change that is itself a V-in vertex is its own endpoint); §E4, item 3 for the repaired reduction; §E6, item 6 (the pigeonhole points are
u, open-disc endpoints, V-in vertices on the circle and the eleventh point w, each M-in when it lies on the circle, so FS110-CE5 excludes a pair
at distance 2; `|p − p′| ≥ 1` by the a-side curves, a self-endpoint and a horn endpoint included; `≠ 1` by (P′); the eleventh point topological).
*Proof verdict:* TRUE after repair, one mind by this route; R3 coincides with CD's pairing rule (FS110-CD l. 414), which CE saw before deriving
(CE §1.2), so R3 is not blind to CD. Not checked by CE: CB's `< 9` changes branch, hole-filling beyond "a horn changes nothing", Lemma 5 and
Prop. 18. *Rests on it:* FS110-CUSP-BASE at D5 items 1–4, 6; FS110-COR1-NOD2 at cusps; FS110-CLOSURE; row 134's grade. *Prior art:* not found in
print. *Kernel:* with FS110-CLOSURE.

**FS110-CE7 — CB's D5 item 1 holds at cusps, but its "= 1 is (P′)" is misstated when the two ends are vertices `{a,c,i}` and `{a,c,j}` with `i ≠ j`; there (ii) excludes distance 1. [hand; one mind: CE]**
*Proof:* CE §E2: corners of a path, cusp corners included, keep one a-tile beside the path, and a tile has diameter ≤ 1; the two ends'
multicolours do not nest, and both ends have `c′ = {a,c}` on one circle, which is (ii)'s case. *Proof verdict:* TRUE; MISSTATED, closed by (ii).
*Rests on it:* FS110-CE6 at item 1; row 134's Corrections clause. *Prior art:* not found in print. *Kernel:* declined — a one-line correction,
carried inside FS110-CE6.

**FS110-P17 — Under Condition 5 no vertex with exactly three sectors has a purely rotating ring (six 60° arcs). [hand; many minds, three blind: N3 by two routes; NB3; Y3 and YB3 as Y3-SIX; CB's Prop. 17 a.e.; S–V Prop. 17 as FS106-V repaired]**
*Proof:* N3 §2.4; NB3 §2.4 (the bracketing pair, exact checks C3–C4); Y3 §8.5; YB3 §2.7 (a counting lemma, then a forced unit arc); CB §D5 item 5 (cones
at `u`, total ≤ 180°). *Proof verdict:* TRUE; N2-HEX's remark that the pure rotating ring is locally consistent is false under Condition 5 (N3). *Rests on it:*
 the six-arc ring kill in every route. *Prior art:* `[SokolovVoronov2025]` Prop. 17. *Kernel:* declined — prior art; formalized inside the base.

## §2. The local calculus and the seam point

**FS110-CALC — The local calculus: A-EXACT (no point of the plane sees all six colours near distance 1, so the closure types of any family of vertices covering six cannot all block), A-CIRC (in closure form, cusp colours included), A-SIX (C-T-TAN uses the types only through their union) and D-TYPE (`P_cl` and `P_ess` differ exactly at colours whose sectors are all cusps). [hand; A-EXACT and A-SIX three minds: A; N; Y. A-CIRC five, two blind: A; N; Y; NB; NB3. D-TYPE two: N; Y]**
*Proof:* N §1.4 (N-E0, N-E1, N-SIX, N-TYPE); Y §1.3 (Y-AEX, Y-CIRC, Y-SIX, Y-TYPE); NB3 §2.1 (NB3-AC). *Proof verdict:* TRUE; A-EXACT read "meets the
interior of a tile" (Y). *Rests on it:* every seam lemma. *Prior art:* A-SIX read from C-T-TAN's proof (FS106-TS). *Kernel:* with FS110-CLOSURE.

**FS110-ESC4 — A four-colour vertex with four distinct colours, each sector below 180°, escapes on an open set of directions with no colour repeated; a strong escape is "a class of `P(u)` wholly on each side". [hand; two minds: A2; Y]**
*Proof:* A2 stage 1; Y §3. *Proof verdict:* TRUE; corrects `claims.md` §1b. *Rests on it:* card 1; vacuous under Condition 5 (NB-4). *Prior art:* not found
in print. *Kernel:* declined — vacuous under the headline's hypothesis.

**FS110-N-SEAM — For a covering pair at distance below 2 each common unit point lies on the boundary set, every tile there lies on one side of the unit circles, and a non-vertex point lies on a unit arc whose centre's other colours fill both side cones; two same-colour tiles touching points at distance 1 are Siamese or outer (N-E2). [hand; two minds, one blind: N; NB]**
*Proof:* N §1.4; NB §2. *Proof verdict:* TRUE (N-SEAM (d) restricted to `|P_cl(x)| = 3` after card 1). *Rests on it:* NB-5; N-X. *Prior art:* the
side-cone step is TS-U (FS-106). *Kernel:* with FS110-CLOSURE.

**FS110-CUSP-K — A cusp horn is seen like a ray: close complementary pairs at cusp vertices are tangent pairs or bowties, closing W-TAN's cusp GAP. [hand; three minds, one blind, two routes: N via N-HORN; Y at pair level; NB]**
*Proof:* N §2.1–2.2; Y §1.4; NB §2. *Proof verdict:* TRUE for the limit object. *Rests on it:* row 133's W-TAN at cusps. *Prior art:* not found in print.
*Kernel:* declined — superseded by NB-5 under Condition 5; kept for the unit-arc half.

**FS110-N-X — At a seam point with no unit arc and disjoint types, the point is a four-colour vertex whose colours alternate around the four unit tangents, with bowties at both ends; every tile-interior point of its unit circle near `u` has the one colour `P(u)` less `P_cl(w)` (Y2-W4, W4e). [hand; three minds, one blind: N; Y2; NB]**
*Proof:* N §2.3; Y2 §4.3; NB §2.4; YB §3.1 (YB-W4). *Proof verdict:* TRUE; Y2-W4 (d) MISSTATED, reads "at most `|P(u)| − 2` colours", vacuous under
Condition 5. *Rests on it:* NB-5. *Prior art:* not found in print. *Kernel:* with FS110-CLOSURE.

**FS110-YB-V5X — No bichromatic vertex of degree at least 4 ends a covering pair at a transversal common unit point. [hand; one mind: YB, blind]**
*Proof:* YB §3.1. *Proof verdict:* one mind. *Rests on it:* C-V5-K in the unit-arc half. *Prior art:* not found in print. *Kernel:* declined — one mind,
off the headline's path.

**FS110-A3-HOLE — A2-V56 and the four-colour Act One step hold when the vertex's unit circle carries no arc of `Γ` and are a GAP when it does. [hand; three minds, two prompted: A3; N2 as N2-V4; Y2]**
*Proof:* A3 stage 1–4; N2 §4.2; NB D1 (N2-V4 step 2 TRUE in the union sense, GAP in the disjoint sense). *Proof verdict:* TRUE; the TS-U reading both
A3 and N2 used is wrong (A4), the verdict survives on another argument. *Rests on it:* the unit-arc branch. *Prior art:* TS §5 for the `|P| ≥ 5` case.
*Kernel:* declined — off the headline's path.

*Erratum (2026-10-03, FS129-Z1, from `plans/FS129-MR1-audit.md` § The leads of pass 1, lead (a), and § Lead (a), completed; `plans/FS129-close-inventory.md` item 78):* this entry's GAP — both steps when the vertex's unit circle carries an arc of `Γ` — was answered later without a link back. Its first step is held, stronger, as FS116-N1-QFREE4 ("if the ring carries no (Q) arc then `p` has four colours and no more", Siamese pairs allowed), so the GAP branch is exactly the rings carrying a (Q) arc, and there the step is false on fragments: FS116-Y2-SIXFRAG holds a six-colour vertex on every disc of radius below 3/2. Its second step is FS112-A4SIX's branch (a four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows), or else a change point of exactly two colours (FS116-N2-STAR gives `C(y) = A(p) ⊔ T_y ⊔ O_y`; FS116-N1-QDISK's corner change point is one). A miss of citation, not of work.

## §3. Act One and the winding apparatus (off the headline's path)

**FS110-N2-RING — At a three-colour vertex whose unit circle carries no arc of `Γ` the ring has a winding `W`; `|W| ≤ 1` forces a swap point. [hand; two minds, one blind: N2; NB]**
*Proof:* N2 §4.3, `tools/fs110_n_ring.py`; NB §2.2 (the stronger form). *Proof verdict:* TRUE. *Rests on it:* N2-ACT1-W0. *Prior art:* the band
argument is A4-BAND's, and Y-BIKE-3C's ring family (A3). *Kernel:* declined — off the headline's path.

**FS110-N2-SWAP — A swap point gives a covering pair at distance 1 unless named unit arcs intervene; so under Condition 5 Act One holds in every tight six-map with a four-colour vertex or a three-colour vertex whose ring has a swap (N2-ACT1-W0). [hand; two minds, one blind: N2; NB]**
*Proof:* N2 §4.3–4.4; NB §2. *Proof verdict:* TRUE under Condition 5, GAP without. *Rests on it:* W-3's framing. *Prior art:* not found in print. *Kernel:*
declined — off the headline's path.

**FS110-N2-ROT — At a ring change point the patterns (A+, A−) and (B+, B−) force a colour into the outward or inward 60° cone; a purely rotating ring forces a regular vertex (N2-HEX). [hand; two minds, one blind: N2; NB]**
*Proof:* N2 §4.3–4.4; NB §2.9. *Proof verdict:* TRUE at degree 3; N2-ROT's table line drops "(A+, B+), (A−, B−) is a swap" (MISSTATED); N2-HEX needs TS-C
against bichromatic rotation points (NB), unproved at degree ≥ 4 (N3). *Rests on it:* FS110-P17. *Prior art:* S–V Prop. 17. *Kernel:* declined.

**FS110-N2-S1 — At an (S1) seam point on a unit arc of `ω(u)`, with `|u − v|` not 1 or `√3`, both hexagon neighbours of the seam point carry `u`'s bowtie colour on both sides along `ω(v)`. [hand; two minds, one blind: N2; NB]**
*Proof:* N2 §5.1; NB §2.9 (the exceptional distances are exactly `{1, √3}`). *Proof verdict:* TRUE. *Rests on it:* the unit-arc branch ((S1)). *Prior art:*
not found in print. *Kernel:* declined — the unit-arc half.

**FS110-N2-TRANS — Along an edge whose ends have different third colours, off the collinear `d = 2` configuration, the winding transports: `W(u)` on `(d, e, f)` equals `W(u′)` on `(c, e, f)`; bowties and cusps included. [hand; four minds, two blind: N2; NB; Y3 as Y3-PROP; YB3]**
*Proof:* N2 §6.1 (the nerve step a sketch); NB; Y3 §8.3; YB3 §2.3 (YB3-TRANS; the nerve step written out as a window lemma, YB3-EVENT). *Proof verdict:*
TRUE for `c ≠ d`; **across a same-type edge a GAP** (YB3-SAME, one mind: every merge meets an event type no hypothesis excludes; a `c`-tile ringed by
`d, e, f` swept by `ω(p)` changes `W` by `±1`). *Rests on it:* W-3's "consistently along edges"; "`|W|` constant" (Y3-PROP) carries the GAP. *Prior art:*
 not found in print. *Kernel:* declined — off the headline's path.

**FS110-FLIP — Around a tile the transported ring orientation returns with sign `(−1)^k`, `k` the same-type steps (N2-FLIP, Y3-FLIP); a bowtie counts as one merged neighbour, a same-type step iff its flanks agree (Y3-BOW). [hand and tools; the parity four minds, two blind: N2; NB; Y3; YB3. Y3-BOW two, one blind]**
*Proof:* N2 §6.2, `tools/fs110_n_face.py`; NB §2.8, `tools/fs110_nb_ring.py`; Y3 §8.3–8.4; YB3 §2.5–2.6, `tools/fs110_yb3_perm.py` (1,920 colour
assignments). *Proof verdict:* the label algebra TRUE; its use, `k` odd ⟹ `W = 0`, needs transport at same-type steps — YB3-SAME's GAP. *Rests on it:*
W-3's "every tile has an even count". *Prior art:* not found in print. *Kernel:* declined.

**FS110-Y3-GP — A ring with no two change points exactly 60° apart winds `W ≡ 3 (mod 6)`; so `|W| ≤ 2` needs two change points at distance exactly 1. [hand and tools; two minds, one blind: Y3; YB3; the weaker hypothesis one mind: YB3]**
*Proof:* Y3 §8.2, `tools/fs110_y_ring.py` (six named rings); YB3 §2.2, §4.3, `tools/fs110_yb3_ring.py`. *Proof verdict:* TRUE; YB3-GP′ strengthens Y3's
hypothesis. *Rests on it:* the winding frame. *Prior art:* not found in print. *Kernel:* declined.

**FS110-Y3-SIX — No vertex of degree 3 with three essential sectors has a six-arc ring in a tight six-map in `𝓜_K` under Condition 5. [hand; two minds, one blind, different routes: Y3; YB3]**
*Proof:* Y3 §8.5; YB3 §2.7, `tools/fs110_yb3_six.py`. *Proof verdict:* TRUE; drop "the colours run `r₀r₁r₂r₀r₁r₂`" (six-arc three-colour rings with `W = 0`
exist). Open at bowties. *Rests on it:* FS110-P17. *Prior art:* S–V Prop. 17's content. *Kernel:* declined.

**FS110-Y3-C5 — In `𝓜_K` the print's Condition 5 coincides with "no boundary arc of radius 1". [hand, trivial; three minds, one blind: Y3; YB3; A5]**
*Proof:* Y3 stage 7; YB3 §2.1; A5 stage 1. *Proof verdict:* TRUE. *Rests on it:* every statement of FS110-CLOSURE. *Prior art:* the condition is
`[SokolovVoronov2025]`'s. *Kernel:* with FS110-CLOSURE.

## §4. The construction side: exact local fragments

**FS110-FRAGS — Four tight fragments given by formula over ℚ(√3) are a.e.-proper: S1 (a bowtie centred on two boundary unit arcs), T2 (the `d = 1` rhombus), BB (a double bowtie escaping at both unit points), MX (one pair mixing both seams). [tools, exact, two checkers: Y2; YB]**
*Proof:* Y2 §4.5, stage 5, `tools/fs110_y_fragments.py` (18, 24, 30, 27 same-colour pairs); YB §2.3, `tools/fs110_yb_fragments.py`, planted faults
firing for their own reasons. *Proof verdict:* ACCEPT and tight on both. *Rests on it:* C-T2 (i) and C-BOW-K (i) at fragment level; the unit-arc branch.
*Prior art:* not found in print. *Kernel:* declined — local fragments, not a map.

**FS110-Y2-S1I — Every realisation of (S1) with the seam point an edge point has the arc's sides in `u`'s facing and away colours, `u` a strong escape, and the arc's ends vertices meeting a colour of `P(v)`. [hand; one mind, with YB's GAP at item 4]**
*Proof:* Y2 §4.5; YB §3.1 (YB-S1i-cusp). *Proof verdict:* TRUE bar item 4, a GAP when both side colours are cusps at `u`; "partner free" reads "vertex
figure unconstrained", short of N2-S1 (A4). *Rests on it:* the unit-arc branch. *Prior art:* not found in print. *Kernel:* declined.

**FS110-Y-BIKE-3C — No six-arc three-cycle colouring of each circle colours the bicycle at any `d` in `(1, 2)` whose cross curve meets no grid vertex. [hand; two minds, one blind: Y; YB; GAP at grid-corner passages]**
*Proof:* Y §2.4; YB §3.1 (YB-BIKE-gen). *Proof verdict:* TRUE off grid corners; GAP at corner passages — A4-BAND's cross-swap (A5-CORNER). *Rests on it:*
C-T-BIKE in the unit-arc half. *Prior art:* the bicycle is `[Voronov2023]` Thm 1.2. *Kernel:* declined.

**FS110-Y-T2W — A pair saved at its seam point by T2 makes the point a vertex of degree at least 4 whose branches of the two unit circles alternate. [hand; two minds, one blind, at (3, 3): Y; YB; GAP at (2, 4)]**
*Proof:* Y §2.3; YB §3.1. *Proof verdict:* TRUE at (3, 3); GAP at (2, 4); the table line drops §2.3's sizes (A5). *Rests on it:* the T2 rhombus. *Prior art:*
 not found in print. *Kernel:* declined.

**FS110-Y4-CONES — Woodall's cone is realised locally under Condition 5 with its whole ring (WC, WC1, WCEQ), and tip-hard cones exist (WCH, WC1H): every single-colour tip recolouring is refused for the derived reason; a cone loses each horn to a one-tile recolouring unless its opposite colour reaches a zero-width window at the antipodal contact (Y4-TIP). [tools, exact, two checkers: Y4; YB4. Y4-TIP hand, two minds, one blind: Y4; YB4]**
*Proof:* Y4 §11.3–11.4, `tools/fs110_y_cone.py`; YB4 §2.2–2.3, `tools/fs110_yb4_check.py`. *Proof verdict:* TRUE for the members; "every curvature" →
"every horn-bounding curvature"; a double-horn cone needs one recolouring per horn; `λ = ∞` per side; the contact tiles' completions to be added to the
formulas (YB4 S1–S4). Tip-hard is weaker than doubly shadowed: WC1H shaves (FS110-A6-SHAVE). *Rests on it:* N4-P2's test; the residue's existence
(FS110-A6-C2). *Prior art:* not found in print. *Kernel:* declined — local fragments.

**FS110-Y4-D2 — At a tip-hard cone the antipodal contacts never share a closure type, so G-CONE is never the same-multicolour `d = 2` configuration. [hand; two minds, one blind: Y4; YB4]**
*Proof:* Y4 §11.5; YB4 §2.3 (YB4-D2). *Proof verdict:* TRUE for closure types and the pair `(N, S′)`; can fail for essential types; moot, G-d2 not
arising (FS110-COR1-NOD2). *Rests on it:* nothing now. *Prior art:* not found in print. *Kernel:* declined.

**FS110-YB4-WINDOW — At WC's curvatures a `y`-cusp at `N` inside the window `R_y` (from `−T²/6` inclusive to `T²/2` exclusive) blocks the tip recolouring into `y`, and one above it does not. [hand and tools; one mind: YB4, blind]**
*Proof:* YB4 §2.2–2.3. *Proof verdict:* both ends confirmed on four exact members. *Rests on it:* Y4-TIP's windows. *Prior art:* not found in print.
*Kernel:* declined.

**FS110-A6-SHAVE — WC1H, tip-hard, is shaveable: the two-colour split along the tangent line ACCEPTs, and tilting it by ±1/200 REJECTs at exactly the predicted pairs; WCH is N4's stuck chain truncated. [tools, exact; two minds, one blind: A6; NB4]**
*Proof:* A6 stage 1, `data/fs110/fs110-a6/a6_shave_wc1h.py` on Y's checker; NB4 §2.10 (NB4-WC1H, NB4-WCH, C3–C4). *Proof verdict:* TRUE. *Rests on it:*
N4-P2 met; round 4's convergence. *Prior art:* not found in print. *Kernel:* declined.

**FS110-A6-C2 — A doubly shadowed single horn at a cubic vertex exists locally: WC1H with the lower boundary of `N`'s colour-3 sector bent to curvature `−1/4` is a.e.-proper and every N4 operation is blocked. [tools, exact; one mind: A6, one checker]**
*Proof:* A6 stage 3, `data/fs110/fs110-a6/a6_c2_single_horn.py` (16 tiles, 30 pairs; the unbent split ACCEPTs; curvature `−1/2` REJECTs for the window's
reason). *Proof verdict:* ACCEPT on Y's checker. *Rests on it:* the base's cusp scope is live (FS110-CUSP-BASE). *Prior art:* not found in print. *Kernel:*
declined.

## §5. Re-attribution (prior art, not ours)
- The four-colour half of NB-4 is `[SokolovVoronov2025]` Lemma 2; W-MERGE and N4-SHAVE are curved-arc, almost-everywhere forms of S–V Props. 7–8 and of
  `[Woodall1973]` step 3; the cone is Woodall's; Prop. 17's content is S–V's.
- `[Soifer2024]` ch. 25 reprints Townsend's proof with simplification (c) and its gap (FS110-PA stage 4; FS106-V3's GAP is in the published text).
- Condition 5 without Condition 6: not settled, stated or asked in print (FS110-PA).
