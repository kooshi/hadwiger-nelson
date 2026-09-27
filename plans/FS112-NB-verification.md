# FS112-NB — blind verification of FS-112's proof side (FS112-N)

*Job FS112-NB, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `19a463cd`. Brief: `data/fs112/briefs/NB112-verify-proof.md` with its instance file
`data/fs112/briefs/NB112-instance.md` and `data/fs112/briefs/STANDING-RULES.md`. Derive first, read second: stage 1 is committed before
`plans/FS112-N-proof.md` is opened. Working files: `data/fs112/fs112-nb/`; tool `tools/fs112_nb_checks.py`; scratch `scratchpad/fs112-nb/`. Grades as
`CLAUDE.md` § Notation; "minds" counts derivations, mine included; every verdict below is mine alone unless it says otherwise.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| NB-U1 | at a unit arc `α ⊂ ω(P)` of angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed facing cone of width `π − ℓ`, an outer one in the closed away cone of width `π − ℓ`; the outer tile's first-order shadow near `P` contains the open facing cone of width `π + ℓ`, with equality when its closure meets `ω(P)` only in `ᾱ` (= N112-U1, TRUE with that precision) | [hand, one mind; U1 exact] | §1.5 |
| NB-SIX | `\|P_cl(v)\| = 5` ⟹ unit arcs centred at `v` of total length `≥ 180°`; `\|P_cl(v)\| = 6` ⟹ `ω(v) ⊆ Γ` (= N112-SIX) | [hand, one mind] | §1.5 |
| NB-NB4′ | at a four-colour vertex `v`, a `σ_v`-orbit `y₀…y₅` with `y₀` a change point, no `y_k` in the closure of a `Γ`-arc of `ω(v)`, and no `y_k` in the closure of a `Γ`-arc of `ω(y_{k±1})`, is impossible; the bound `\|P_cl(y_k)\| ≤ 4` is not needed (each `y_k` has exactly one inner and one outer colour, forced by `P_cl(y_{k+1})`) (= N112-NB4′) | [hand, one mind; HP60 exact] | §1.5 |
| NB-L60 | a unit arc with constant sides has angular length `< 60°`; for `w` interior to it, no tile of either side colour has `w ± 60°` in its closure (= N112-L60 in that reading) | [hand, one mind; L60 exact] | §1.5 |
| NB-LOCK | for `w` interior to `α ⊂ ω(P)`: a tile of the outer colour meets `ω(w)` only at `P` (outer, away cone); of the inner colour only at `P` (Siamese, facing cone) or at `P + 2e_w`, from outside `B(P, 2)` (= N112-LOCK) | [hand, one mind; LOCK exact] | §1.5 |
| NB-BEND | a compact sub-arc of `int α` can be bent off radius 1, valid, no unit arc created: toward `P` iff the outer colour is not at `P`; away iff the inner colour is not at `P` and touches no `P + 2e_w`, `w` in the sub-arc | [hand, one mind] | §1.5 |
| NB-INERT | an inert unit arc (neither side colour at `P`) bends toward `P` on every compact sub-arc of its interior, with no exceptional contact point (ARC-INERT, TRUE and sharper) | [hand, one mind] | §1.6 |
| NB-END | in a stuck chain, `υ_{k−1} = 1` or `λ_{k+1} = −1` makes a horn colour the outer colour of a unit arc centred at `P_k` while it fills a half-plane at `P_k`, against NB-U1 (= N112-END) | [hand, one mind] | §1.5 |
| NB-MERGE3 | a unit-arc centre carrying both side colours and exactly three colours has its third colour in both side cones, with `int D_c ≠ ∅` and one gap inside `D_c`: W-MERGE removes a side colour from `P` | [hand, one mind] | §1.5 (RED) |
| NB-SEAM2 | at a close covering pair (union sense) the seam point `w₀` either lies in the closure of a unit arc centred at `u` or `v`, or is a vertex with at least four colours (N-X's count, no disjointness needed) | [hand, one mind] | §1.6 (C-SEAMS-TWO) |
| NB-CHAIN | the chain walk: steps 1, 2, 5–8, 10–18 hold only off named unit-arc exceptions (table §1.4); 3, 4, 9 hold as written; the first break is step 1 (NB-4), **not realised by any held object** (corrected at stage 2: FS-110's fragments are below NB-4's reading radius) | [hand, one mind; the base steps 13–17 read at the level of their Condition-5 uses] | §1.4, §2.4 |
| NB-FLANK | N4-FLANK fails when a horn's bounding arc is a unit arc centred at `N` (`κ₊ = 1`) or `S′` (`κ₋ = −1`): an in-type flank tile at `N` is then Siamese with the flank and shadows a band of the horn; SHAVE's criterion is incomplete there | [hand; two minds: the side blind, mine sighted (stage 2)] | §2.2 |
| NB-ISO | LOCK permits isolated inner-colour contacts at `P + 2e_{w₀}` (a local example: a corner of an inner-colour tile outside `B̄(P, 2)`); they block a first-order away-bend, so N112-RED needs a tangent bend there (sketch) | [hand, one mind] | §2.3 #4 |

## Would have searched here (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate inner/outer colour assignments at the six orbit points of a four-colour vertex to see whether `\|P_cl(y_k)\| ≤ 4` is needed | derived that `P_cl(y_{k+1})` forces a single inner and a single outer colour at each `y_k` (§1.5, NB4′) |
| sample bent arcs numerically to see which bends stay valid | derived the shadow of each side colour near `ω(w)` (LOCK) and bent by compactness (BEND) |
| probe tangent bends at isolated radius-2 contacts with random curvatures | a second-order comparison, stated as a sketch (§1.5, BEND) |

## Fence log

1. Start-up snapshot (in my context, not a command): five commit subjects (`19a463cd … 74f0b705`), including "FS112-N: stage 2", "FS112-N: report",
   "FS-112 inventory: Y's stage 2; YB launched", "FS-112: YB instance file", "FS-112: NB instance file". Subjects only.
2. `ls data/fs112/` and `ls data/fs112/briefs` (to find my paths) printed directory and file names, fenced ones among them (`fs112-a/`, `fs112-a2/`,
   `fs112-n/`, `fs112-y/`, `reports/`; the other jobs' briefs). Names only; nothing inside a fenced path was listed, opened or grepped.
3. Read, not fenced: `plans/POROS-2026-09-27-fs110-competition.md` ll. 600–640 (FS-110's advisor, to check A4-SIX-ARCS's quotation), FS-110's
   records, `tools/fs110_y_fragments.py`'s header and function names (a grep), the held S–V PDF (my extraction in scratch).
4. `git log` beyond the snapshot: not run.

## Stage 1 — SAVED: quotation check, the chain walk, the side's statements, the claim-list ids (blind)

### 1.1 Files read from disk (this order)

`data/fs112/briefs/STANDING-RULES.md`; the brief and the instance file; `CLAUDE.md` § The aim and § Counter-priors (from disk: link 2 there carries
text my loaded snapshot lacks, so the disk copy was used); `LEDGER.md` rows 131–134; `data/fs112/claims.md` in full; `plans/FS112-unit-arc-half.md`
§G part 3, §PA, §IQ (not §5.3); `data/fs112/briefs/N112-proof.md`; `plans/FS112-PA-reading.md` stages 1–7 (the part printed); `plans/FS110-derivation.md`
in full; `data/fs110/claims.md` §§0–3, 7–9; `plans/FS110-N-proof.md` §1.3–1.4, § Continuation — FS110-N3 (stage N3-2), N4 (stages N4-2 to N4-4);
`plans/FS110-NB-verification.md` §§2.1–2.6; `plans/FS110-CB-verification.md` §§1.2, D1–D2 and its Condition-5 lines, `plans/FS110-CD-verification.md`
and `plans/FS110-CE-verification.md` at their Condition-5 lines (grep); `[SokolovVoronov2025]` (held PDF, `pdftotext`): Conditions 5–8, Observation 2,
Thm 1, Cor. 1, Props. 5–6, Lemma 2, Props. 9–11, Cor. 2–3, Prop. 13, Lemma 3, Lemma 4's statement, §7.1, Props. 14–19, Lemma 5, Lemma 6, §8 — **read**.

### 1.2 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| C-CHAIN-1 … C-CHAIN-18's statements | `plans/FS110-derivation.md` ll. 28–174 | **verbatim** (each checked against its bold heading) |
| row 134's grade clause | `LEDGER.md` row 134 | verbatim |
| NB-4's general form "a four-colour vertex needs an arc of `Γ` of `ω(y)` or `ω(σ_v^{±1}y)` through a change point of every orbit of its ring." | `plans/FS110-derivation.md` l. 42 | verbatim |
| "if in one `σ_v`-orbit `y₀, …, y₅` of change points no `Γ`-arc of `ω(y_k)` or `ω(y_{k±1})` passes through `y_k`, then" | `plans/FS110-NB-verification.md` l. 164 | verbatim; the slip is real (§1.5, NB4′) |
| A4-SIX-ARCS, A4-S1-ONE | `plans/POROS-2026-09-27-fs110-competition.md` ll. 612–613, 624 | verbatim |
| A4-TSU's "`P_cl(w) = {1, 3, 4, 5}`" | same file, l. 616 | verbatim; the fragment's own header agrees: "w, w' four-colour vertices (quadrant squares)" (`tools/fs110_y_fragments.py` l. 14) |
| TS-U, FS106-IND-X, W-EQ-K, K-CHR4 | `data/fs110/claims.md` §3 (as the claim list §5 quotes them) | verbatim |
| C-V56's print sketch `[08.17]` | `plans/FS112-PA-reading.md` stage 1 checked it exact against the held thread | not re-checked by me (the held thread text is not in my reading list); taken at PA's check |
| Condition 5, Question 2 | `[SokolovVoronov2025]` p. 4, §9 (my extraction ll. 148–150) | verbatim |
| the instance file's N112-U1 … N112-RED | `plans/FS112-N-proof.md` (fenced until this stage is committed) | **not checkable at stage 1**; checked in stage 2 |

### 1.3 Setting and the facts every verdict uses

A **valid map**: a locally finite map of the plane by open connected tiles bounded by segments and circular arcs (radius 1 allowed), six colours, no two
interior points of one colour at distance exactly 1 (`data/fs112/claims.md` §0). Facts used, each re-derived without Condition 5:
- **N-E0/N-E1** (A-EXACT, A-CIRC): if `u ∈ cl T`, `T` of colour `j`, no tile point of `ω(u)` has colour `j`. The proofs read only open tiles.
- **N-E2** (contact lemma): same-colour tiles `T ∋ u`, `T′ ∋ u′` in closure, `|u − u′| = 1` ⟹ Siamese (`T ⊆ B̄(u′,1)`, `T′ ⊆ B̄(u,1)`) or outer
  (`T ∩ B(u′,1) = ∅`, `T′ ∩ B(u,1) = ∅`). So **a tile whose points near `u` lie on both sides of `ω(u′)` has no same-colour tile at `u′`**.
- **TS-C**: a tile has diameter `≤ 1`.
Exact checks: `tools/fs112_nb_checks.py` (U1, L60, LOCK, HP60, FLAT, CUSP; `--self-test`: each plant fires its own check only, the faithful run passes).

### 1.4 The chain walk (claim list §3), unit arcs allowed

*"Reads" names the unit circles the step's proof reads. "Exception" names where the step's proof uses Condition 5, or its conclusion is realised
against it.* In the exceptions: a **pinch** at a trichromatic `u` is a boundary arc at `u` lying on `ω(p)` for some `p ∈ ω(u)` (a unit arc centred on
`u`'s circle, through `u`); a **(Q)-arc** is a unit arc whose centre carries both side colours; an arc is **inert** at its centre when neither side
colour is there.

| step | verdict | reads | the exception (and what holds there) |
|---|---|---|---|
| C-CHAIN-1 NB-4 | **(b) holds off a named exception; the exception is realised locally** | `ω(v)`; `ω(y)` for `y` in each `σ_v`-orbit on `ω(v)` | four colours at `v` need, in some orbit through every change point, a unit arc of `ω(v)` or of `ω(y_{k±1})` with an orbit point `y_k` in its closure (NB-NB4′); five need `≥ 180°` of unit arcs centred at `v`; six need `ω(v) ⊆ Γ` (NB-SIX). Realised: FS-110's fragment T2 has four-colour vertices `w, w′` with arcs of `ω(w)` through `u, v` (FS110-FRAGS, exact, two checkers). **The first break in chain order.** |
| C-CHAIN-2 NB-5 | **(b); fails as a local statement** (fragments S1, T2 are close covering pairs, exact) | `ω(u)`, `ω(v)`, `ω(w₀)`, `ω(y)` for `y ∈ ω(w₀)` | NB-SEAM2: `w₀` lies in the closure of a unit arc centred at `u` or `v` ((S1), or (S2) with arcs), or is a vertex of `≥ 4` colours — NB-4's exception at `w₀` (T2). N-X's count needs no disjointness (§1.6) |
| C-CHAIN-3 N3-CONF | **(a) holds as written** | `ω(v)` | contacts may now form arcs of `ω(v)`; each is still in- or out-type (N-E1, N-E2), `D_c(v)` is still an intersection of closed half-planes, and N3-CLEAR's clearance is uniform over a compact contact arc. Only the proof's "finite by Condition 5" goes; the statement never used it. A side colour of a unit arc centred at `v` is the arc case: `D_c(v)` ⊆ NB-U1's cone |
| C-CHAIN-4 W-MERGE | **(a) holds as written** ("Condition 5 kept" read as "no unit arc created": the new arcs have radius `ρ < 1`) | `ω(v)`; `ω(v′)` for type-shrinking | clearance by N3-CLEAR and N3-UP, both surviving; a horn bounded by a unit arc of `ω(N)` is still upward-cleared |
| C-CHAIN-5 N3-DEG | **(b)** | `ω(v)`, `ω(N)`, `ω(S′)` | the horn curvatures lie in `[−1, 1]`; `±1` exactly when a bounding arc is a unit arc centred at `N` or `S′` (curvature `1/(C − 0)`, `C = ±1`), with the cone colour its **outer** colour and at `N` (resp. `S′`): an out-contact. Out at `N` and `S′` still forced |
| C-CHAIN-6 N4-SHADOW | **(b)** | `ω(v)`, `ω(N)`, `ω(S′)`, the concentric `Σ(C)` | fails at `C = 0`: the arc at `N` is a unit arc of `ω(v)`; its outer tile's shadow is NB-U1's wedge of width `π + ℓ`, not a circle side. **N4-FLANK survives**: a flank colour cannot own an arc contact on `ω(v)` reaching `N` or `S′` from the horn's side (NB-U1 excludes `+a` from its cone), and arcs on the other side are harmless |
| C-CHAIN-7 N4-SHAVE (and N4-RAY) | **(b)**; N4-RAY **(a)** | as step 6 | validity survives (N4-FLANK does); "keeping Condition 5" fails when the horn's bound is `±1`: then `σ_h = −1` is possible — an `h`-tile at `N` along the radius-2 circle about `S′` has shadow circle `ω(S′)` (`f(−1/2) = −1`, FLAT exact) — and the shave's new arc is a unit arc. N4-RAY: the region between two `c`-horns has bounds strictly inside `(−1, 1)` |
| C-CHAIN-8 N4-STUCK (and N4-PROP) | **(b)** | `ω(v)`, `ω(N)`, `ω(S′)`; NB-4's circles at `v`, `N`, `S′`; along the chain `ω(P_k)` | NB-4 at `v` and `N` (four-colour vertices); a unit arc of `ω(v)` through `N` (its outer colour is then outside `{c, g, h}` by NB-U1, so `N` has four colours — NB-4's exception again); horn bounds `±1` (step 5), which survive at a single stuck vertex and die along a chain (NB-END). N4-PROP stops where some `P_k` is exceptional |
| C-CHAIN-9 N4-FIN | **(a) holds as written** (a statement about real sequences) | none (its inputs read `ω(P_k)`) | its use needs the strict bounds; with unit arcs they close to `[−1, 1]`, and NB-END reopens them in a stuck chain |
| C-CHAIN-10 N4-TERM | **(b)**: the terminal modification exists as written; "every vertex is cubic" holds off the exceptions | local to each operation | four-colour vertices (≥ 4 sectors) survive; a repeated colour at a vertex whose chain ends at an exceptional `P_k` survives |
| C-CHAIN-11 NB4-CS | **(b)**, one mind (NB4's proof not re-derived) | as steps 6–8 | inherits steps 5–8's exceptions: horns bounded by unit arcs, cusp horns at four-colour vertices |
| C-CHAIN-12 P17 | **(b)** — the proof's last line is the exception | `ω(u)` (the ring), `ω(x_{i±1})` at each rotation point | fails exactly when the arc of `Γ` leaving `x₁` tangent to `ω(x₂)` has curvature 1: a unit arc of `ω(x₂)` (or `ω(x₆)`), centred at a hexagon neighbour, with `q` inside and `g` outside — consistent. S–V's print ends the same way ("must form an arc of a circle of radius 1. A contradiction with Condition 5.", p. 24). Also NB-4 at `x₁`; and the ring is undefined when `ω(u)` carries a unit arc |
| C-CHAIN-13 COR1-NOD2 | **(b)** | `ω(u)` at each trichromatic `u`; `ω(p)`, `p ∈ ω(u)`; `ω(y)` for `\|x − y\| = 1` | CB's Condition-5 uses, read line by line (`plans/FS110-CB-verification.md` D1–D2): (i) **(P′)** "each [arc through `x`] meets `ω(y)` finitely (Condition 5)" — fails when `x` lies on a unit arc centred at `y`; unit pairs then nest exactly at (Q)-arcs (`c(x) = {s_in, s_out} ⊆ c(y)`); (ii) **the strip** "no arc from u lies on a unit circle (Condition 5)" — fails at a pinch; (iii) **finitely many `\|c′\| = 2` points** (Conditions 3, 5) — fails at a unit arc of `ω(u)` inert at `u` (both sides in the complementary triple: a continuum of two-colour pseudo-colour points); an arc with in- or out-contact at `u` keeps `\|c′\| = 1` along it; (iv) Prop. 17's last step (step 12); (v) the cubic setting, which rests on steps 1, 10 |
| C-CHAIN-14 CB-LEMMA3 | **(b)** | `ω(u₁)`, `ω(u₂)`, the bicycle's transversal circles | CE's inputs M1–M4 ("(M4) Only finitely many points have `\|c′\| = 2`. This needs Conditions 3 and 5 only", `plans/FS110-CE-verification.md` l. 97): fails at unit arcs of `ω(u_i)` inert at `u_i`, and at pinches at `u_i` (the strip gives (i), (ii), `\|c′\| ≤ 2`) |
| C-CHAIN-15 CE5 | **(b)**, one mind | `ω(u)` | holds when the M-in points at `u ± e` lie on unit arcs of `ω(u)`: by NB-U1 their inner colours face `±e` in cones of width `< π`, so a third colour fills both gaps and `u` is not cubic (my derivation; the lemma's conclusion survives there). **GAP at a pinch at `u ± e`** (a boundary arc of `u` on `ω(u ± e)`): D2's strip and the "vote" at `u ± e` are undefined there |
| C-CHAIN-16 CE6 | **(b)** | as step 13 | "`≠ 1` by (P′)" fails at (Q)-arcs (step 13 (i)); pinches (step 15); R1–R4 otherwise unaffected as far as read |
| C-CHAIN-17 CUSP-BASE | **(b)**; the identity holds as written (CUSP exact) | `ω(u ± n)` along the cusp's normal | `4R(R ∓ 1)m²/(1 + m²)` vanishes identically at `R = ±1`: a cusp bounded by a unit arc centred at `u ± n` has no strip along its normal — the pinch at `u ± n`, the same exception as step 5 |
| C-CHAIN-18 the headline | **(c) fails as a chain**; first break step 1 | — | the chain is cut at NB-4 (four-colour vertices with unit arcs, fragment T2) and at NB-5 (S1, T2); every later exception is a unit arc centred at the vertex, at one of its antipodes `v ± n`, or at a point of its circle |

**The shape of the exceptions [reading, one mind].** Every exception is one of three placements of a unit arc relative to the vertex `v` a step reads:
**centred at `v`** (steps 1, 3's arc contacts, 13 (iii), 14); **centred at `v ± n` or at a hexagon neighbour on `ω(v)`, passing through `v`'s
neighbourhood or its ring** (steps 5–8, 12, 13 (ii), 15, 17 — the pinch); **with `v` on it and the centre carrying both side colours** (13 (i), 16 —
(P′)). Killing test: a step of the chain that fails under unit arcs at a configuration none of the three placements describes.

### 1.5 The side's new statements (instance file item 2), derived

**N112-U1 — TRUE, with one precision [hand, one mind; U1 exact].** Let `T_in, T_out` be the tiles beside `α` (inner, outer). If `s_in ∈ P_cl(P)`
through a tile `X`: every `w ∈ ᾱ` has `w ∈ cl T_in`, `|P − w| = 1`, and `T_in` has points inside `B(P,1)` near `α`, so N-E2's outer branch fails and `X ⊆
B̄(w, 1)` for all `w ∈ ᾱ`: `X`'s directions at `P` satisfy `d·e_w ≥ 0` on `[θ₁, θ₂]`, the closed cone `[θ₂ − 90°, θ₁ + 90°]` of width `π − ℓ` (U1 exact).
If `s_out ∈ P_cl(P)` through `Y`: `T_out` has points outside `B̄(P, 1)`, so the Siamese branch fails, `Y ∩ B(w,1) = ∅` for all `w ∈ ᾱ` (away cone,
width `π − ℓ`) and `T_out ∩ B(P, 1) = ∅`. Shadow: for `z = P + rd`, a point `p` of `T_out` at distance `1 + t` from `P` in direction `e_p` has `|z − p|² =
(1+t)² − 2r(1+t)d·e_p + r²`, below 1 only for `t = O(r)` and `d·e_p > 0`; so the first-order shadow is `⋃_{w ∈ cl T_out ∩ ω(P)} {d·e_w > 0}`, which
**contains** the open facing cone of width `π + ℓ` and **equals** it when `cl T_out ∩ ω(P) = ᾱ`. (Mirror: `T_in`'s shadow contains the open away cone.)
*The precision:* "is" holds when the outer tile touches `ω(P)` only along `ᾱ`; when `s_out ∉ P_cl(P)` the outer tile may meet `ω(P)` elsewhere.

**N112-SIX — TRUE [hand, one mind].** Six colours: tile points of `ω(v)` would need a colour outside `[6]`, so `ω(v) ⊆ Γ`, and since a segment or a
circle of radius `≠ 1` meets `ω(v)` in at most two points, `ω(v)` is a finite union of unit arcs centred at `v` and points. Five: the tile points
`O ⊂ ω(v)` all have the one missing colour and `O ∩ (O + 60°) = ∅` (N-E0); each hexagon `θ + 60°k` holds at most three points of `O`, so `\|O\| ≤ 180°`
and the unit arcs centred at `v` total `≥ 180°`.

**N112-NB4′ — TRUE, and the bound `\|P_cl(y_k)\| ≤ 4` is not needed [hand, one mind; HP60 exact].** *The slip:* in NB l. 164, "no `Γ`-arc of `ω(y_k)`
… passes through `y_k`" cannot be meant — `y_k` is `ω(y_k)`'s centre. The proof there uses arcs of `ω(y_k)` only through "first step at `y_k`" (the bound
`\|P_cl(y_k)\| ≤ 4`, which needs `< 180°` of arcs centred at `y_k`) and uses `{e, f} ⊆ P_cl(y_{k±1})`. *Derivation.* `P_cl(v) = [6] ∖ {e, f}`. If `y₀` is a
change point (an `e`-stretch and an `f`-stretch of `ω(v)` meet at `y₀`) and no `y_k` lies in the closure of a unit arc of `ω(v)`, then points just
before and after each `y_k` are tile points, and the 60° rule `c(θ + 60°) ≠ c(θ)` makes every `y_k` a change point: `{e, f} ⊆ P_cl(y_k)` for all `k`. If
also no unit arc of `ω(y_{k±1})` has `y_k` in its closure, the four half-arcs of `ω(y_{k±1})` at `y_k` lie in tiles at `y_k` (a circle meets `Γ` near
`y_k` only at `y_k` unless it runs along it), whose colours are outside `P_cl(y_{k±1}) ⊇ {e, f}` (N-E1), hence in `P_cl(v)`; the two half-arcs inside
`B(v, 1)` give **inner** colours (Siamese with `v`'s tiles of that colour: sectors facing `y_k`), the two outside give **outer** ones (facing away), and an
inner colour never equals an outer one at one point (a `v`-tile would lie on `ω(y_k)`). Write `i_k^±, o_k^±` for the colours on the half-arcs of
`ω(y_{k±1})`. The pair `{i_k^+, o_k^+}` lies on `ω(y_{k+1})`, so it misses `P_cl(y_{k+1}) ⊇ {i_{k+1}^±, o_{k+1}^±}`: all four of the latter lie in the
complementary 2-set `{X, Y}` of the 4-set `P_cl(v)`; with every inner–outer pair at `y_{k+1}` distinct, `i_{k+1}^+ = i_{k+1}^- = X`, `o_{k+1}^+ =
o_{k+1}^- = Y`. **So each `y_k` has one inner and one outer colour, and the pairs alternate `{A, B}`, `{C, D}`** — without bounding `\|P_cl(y_k)\|`. Each of
the four colours is then confined by three half-planes with lines 60° apart, an arc `≤ 60°` (HP60, the 8 sign choices), `4 · 60° < 360°`. ∎ *The
corrected statement* is the claim's: "`{e, f} ⊆ P_cl(y_k)` … fails only at an arc of `ω(v)` containing an orbit point in its closure", with "passes
through" read as "has `y_k` in its closure" (an arc ending at `y_k` removes one half-arc and so one of `i_k^±, o_k^±`).

**N112-END — TRUE [hand, one mind], given the stuck structure at `P_{k−1}, P_k, P_{k+1}`.** `υ_{k−1} = 1`: the upper arc of the `+a` horn of `a_{k−1}`
at `P_{k−1}` has upward curvature 1, so centre `P_{k−1} + n = P_k`: a unit arc `α ⊂ ω(P_k)` of positive length, the horn below it, outside
`B(P_k, 1)` — so `a_{k−1}` is `α`'s **outer** colour — while in N4-STUCK's structure at `P_k`, `a_{k−1}` fills the side `(z − P_k)·n > 0`: a sector of
width `π`, which NB-U1's away cone (width `π − ℓ`) cannot hold. `λ_{k+1} = −1`: the mirror (centre `P_{k+1} − n = P_k`, horn above, `a_{k+1}` outer, filling
the `−n` side at `P_k`). So in a bi-infinite stuck chain every horn bound is strict and N4-FIN applies. *Scope:* it needs the chain; at a single stuck
vertex a horn bound `±1` is not excluded by this argument (§1.4 step 8).

**N112-L60 — TRUE in the reading below [hand, one mind; L60 exact].** *First clause:* if `α` (constant sides) had `ℓ ≥ 60°`, two points of `int α`
would be `60° − δ` apart, and the points `(1 + t)w` of `T_out` beyond them (`t ≫ δ`) would be more than 1 apart: `diam T_out > 1`, against TS-C. *Second
clause, read as* "for `w ∈ int α`, no tile of colour `s_in` or `s_out` has `w ± 60°` in its closure": the squared distance from `(1 ∓ t)e_φ` (inner /
outer tile points near `w = e_0`) to `e_60` is `1 ∓ t + t²` at `φ = 0` with `φ`-slope `−(1 ∓ t)√3 ≠ 0` (L60 exact), so each side tile has points on both
sides of `ω(e_60)` and N-E2 forbids a same-colour tile at `e_60`; the same at `e_{−60}`. At an end vertex, the tile on the side facing away can be outer.

**N112-LOCK — TRUE [hand, one mind; LOCK exact].** For `q ∈ ω(w)`, `ω(q)` is tangent to `α` at `w` only for `q ∈ {P, P + 2e_w}` (LOCK exact); otherwise it
crosses `α` transversally at `w` and both side tiles have points on both sides of it: no side colour at `q` (N-E2). At `q = P`: `T_out` is outside
`B(P, 1)` (outer, `Y ∩ B(w,1) = ∅`: away cone), `T_in` inside (Siamese, `X ⊆ B̄(w,1)`: facing cone). At `q = P + 2e_w`: `T_out` near `w` meets both
`B(q, 1)` (points `w + t e_w`) and its outside (points `w + sτ + te_w`, `s² > 2t`), so no outer colour; `T_in` is outside `B(q,1)` near `w` (outer), and
its shadow near `q` contains `B(P, 2)` near `q` (points within 1 of `α`), so an inner-colour tile at `q` lies outside `B(P, 2)`.

**N112-BEND — TRUE for compact sub-arcs of `int α`, in the reading below [hand, one mind].** Toward `P` (the lens `L` inside `B(P,1)` becomes `s_out`):
by LOCK the closure of `C_{s_out}°` meets no `ω(w)`, `w ∈ α′` (compact), when `s_out ∉ P_cl(P)` — `T_out` itself included (it cannot reach `P`) — so a
positive margin separates it from `⋃_{w ∈ α′} ω(w)`, and a lens thinner than the margin is clear; the merged tile `T_out ∪ L` has no internal unit pair
(its pairs across are exactly the excluded ones). If `s_out ∈ P_cl(P)`, a point `z = w − t e_w` sees the away-cone sectors at `P` (`\|z − P − rd\|² = 1`
has a root `r ≍ t` for `d·e_w < 0`, `r ≍ √t` on the edge): blocked. Away from `P`: the same with `s_in`, blocked by `s_in ∈ P_cl(P)` (root `r ≍ t` for
`d·e_w > 0`) or by an `s_in` contact at `P + 2e_{w₀}`, `w₀ ∈ α′` (the cap of `ω(w₀ + te_{w₀})` beyond radius 2 enters a tile whose sector at
`q₀` contains the outward normal). The new arc has radius `≠ 1`; its ends are corners on `α`. *Reading:* "lies along the radius-2 circle" must mean
"touches `P + 2e_w` for some `w` of the bent part"; if it means "along an arc of it", an **isolated** contact at `P + 2e_{w₀}` is not covered as stated —
**a second-order sketch [one mind]**: bend with an arc tangent to `α` at `w₀` of curvature `κ < 1`; the lens has height `≈ (1 − κ)δ²/2` at angular offset
`δ`, the cap of `ω(z)` beyond radius 2 has height `t` over angular width `≍ √t`, and a contact tile whose boundary at `q₀` is not the radius-2 circle rises
`≳ aδ²`, `a > 0`: clear for `κ` near 1. Blocked only where the contact tile's boundary **is** the radius-2 circle on that side — (R2).
*What BEND does not reach:* the end vertices. Near an end vertex `E` the lens is a wedge of angle `ψ` at `E`, and a bend toward `P` is blocked by
`s_out` contacts on `ω(E)` at directions `e_q ∈ (180°, 180° + ψ)` from `E` (outer ones, near `P`) or `(0°, ψ)` (Siamese ones, near `P + 2e_E`) — finitely
many isolated ones are avoided by small `ψ`, a contact **arc** of `ω(E)` ending at `P` (from that side) is not.

**N112-RED — GAP at two named steps [hand, one mind].** The case split is complete: an arc not bendable toward `P` has `s_out ∈ P_cl(P)`; not bendable
away, `s_in ∈ P_cl(P)` or an `s_in` contact on the radius-2 circle; with both side colours and **exactly three** colours at `P`, the third colour `c`
fills both side cones (NB-U1 excludes the side colours there), its two sectors lie in nearly opposite directions, `int D_c(P) ≠ ∅` (positive-angle
sectors), and the convex cone `D_c(P)` contains the shorter gap between them — through the facing or the away cone — so W-MERGE (step 4, surviving)
recolours that gap with `c` and removes `s_in` or `s_out` from `P` (NB-MERGE3); after it the arc bends. So "(Q): ≥ 4 colours carrying both side colours"
is right, and (R2) holds with, in addition, `s_out ∈ P_cl(P)` (else the arc bends toward `P`). **The GAPs:**
1. **End vertices.** BEND acts on compact sub-arcs of the interior; a residual unit arc remains at each end vertex, with the same centre and sides,
   neither (Q) nor (R2) when the whole arc was bendable. Repeating BEND on the stubs accumulates new arcs at the end vertex (local finiteness fails in
   the limit). The step needed: a bend up to the end vertex, i.e. control of the side colours' contacts on `ω(E)` near `P` and near `P + 2e_E` (BEND above).
2. **Isolated inner-colour contacts at `P + 2e_{w₀}`** (ARC-INERT's GAP), if (R2) means "along an arc of the radius-2 circle": the tangent bend above is a
   one-mind sketch.
3. (Not a GAP in the statement's words but in its proof, which the statement does not give): termination of the interleaved merges and bends
   (an N4-TERM for bends: each bend is local, removes unit-arc length and creates none, so a measure exists off the stubs; with the stubs it does not).

### 1.6 The claim-list ids (instance file item 3)

| id | verdict | grade | derivation |
|---|---|---|---|
| **C-UA-WEDGE** | **MISSTATED** — corrected: "an **inner** side colour at `P` faces the arc, an **outer** one faces away, each in a closed cone of width `π − ℓ`; so both side cones (open, width `ℓ`) are empty of both side colours" — TRUE | [hand, one mind] | NB-U1. As written ("the `c`-tiles at `P` face the arc") it is false for `c = s_out`: an out-contact's tiles face away (Polymath's tactic and Parts's wavy sides are out-contacts, claim list §0) |
| **C-UA-BUDGET, branch 1** (no covering pair `(v, y)`, `y ∈ ω(v)`) | **TRUE** | [hand; two minds now: A4, NB] | A4-SIX-ARCS's argument, re-derived: arcs `< 60°` leave `x` with the six points `x + 60°k` tile points; consecutive ones differ (N-E0, two-colour ring), so each window changes colour; a change at a single point makes a covering pair; so each window holds a unit arc centred at `v`, none containing a window end |
| **C-UA-BUDGET, branch 2** (a covering pair at `y ∈ ω(v)`) | **MISSTATED** — the derivable form: "in every `σ_v`-orbit of change points some `y_k` lies in the closure of a unit arc of `ω(v)` or of `ω(y_{k±1})`" (NB-NB4′), TRUE | [hand, one mind] | "the arcs sit on `ω(σ_v^{±1}y)` through `y` … not at `v`" is not derived: (1) in the union sense (claim list §0, correction 1) `P_cl(y)` may be `{e, f, i, o}` — `y` a four-colour vertex with an inner and an outer colour — and then no arc at `y` is forced; the orbit's arc may sit at another `y_k`; (2) it may be an arc of `ω(v)` itself at an orbit point, **centred at `v`** (the 60° rule allows a unit arc of `ω(v)` at one orbit point: the other five still alternate). The stated form holds under `P_cl(y) = {e, f}` exactly **and** `σ_v^{±1}y` off the arcs of `ω(v)` (then all four half-arcs at `y` are in `Γ`) |
| **C-UA-BUDGET, do the branches exclude each other?** | as hypotheses, **yes** (complementary); as conclusions, **no** | [hand, one mind] | branch 2's arcs may be centred at `v` (point (2) above), so "arcs at `v`" versus "arcs not at `v`" is not a dichotomy |
| **ARC-INERT** | **TRUE, and sharper**: an inert arc bends **toward** `P` on every compact sub-arc of its interior with no exceptional point; the isolated inner contacts at `P + 2e_w` block only the away-bend, which an inert arc does not need | [hand, one mind] | NB-LOCK: the outer colour meets `ω(w)` only at `P`, and not at all when inert; NB-BEND. The end vertices stay outside (RED's GAP 1). So "the object reduces to unit arcs with a contact at the centre" holds off the end vertices |
| **C-SEAMS-TWO** | **MISSTATED** — corrected (NB-SEAM2): "at a close covering pair the seam point either lies in the closure of a unit arc centred at `u` or `v` — (S1), or (S2) with arcs, whose centre may carry three or more colours — or is a vertex of at least four colours (N-X, union sense), NB-4's exception at `w₀`, of which T2 is an instance" — TRUE | [hand, one mind] | T2's `w₀` has no arc of `ω(u)`, `ω(v)` through it, so N-X's count applies there: four colours (the fragment has them by construction). N-X needs no disjointness: two half-arcs of `ω(u)` at `w₀`, one inside `B(v,1)`, one outside, carry colours of `P_cl(v) ∖ P_cl(u)` that must differ (Siamese and outer at once is impossible), and likewise for `ω(v)`. **What "two species" drops:** (S1) centres with `≥ 4` colours (then the centre, not `w₀`, is NB-4's exception), and (S2) vertices on a unit arc of `ω(u)` — e.g. `P_cl(w₀) = {a₁, a₂, b}` with the arc's side colours `u`'s — which are three-colour and not (S1) |
| **C-UA-CHAIN** | **GAP** at "each unit arc forces a further unit arc" | [hand, one mind] | TRUE-shaped for (Q)-arcs: their centre has `≥ 4` colours, so NB-NB4′ / A4-SIX-ARCS force further unit arcs, centred at `P` or at `P`'s ring points (and `α` alone, `< 60°` by NB-L60, covers at most one point of an orbit). **Not derived** for (R2)-arcs (the radius-2 contact is an arc of radius 2, and nothing forces a unit arc from it); inert and one-contact arcs bend (NB-BEND), so they force nothing but their end-vertex stubs. The monotone quantity: none named |
| **C-V56 (its covering claim)** | **GAP at the Reuleaux-merge step** — as the claim list says | [hand, one mind] | Derivable: at a six-colour vertex `V`, `ω(V) ⊆ Γ` (NB-SIX), and every tile `Z` meeting `B(V, 1)` is one of the six tiles at `V` **or Siamese to the one of its colour** (all cross distances `< 1`: the distance set of `X_j × Z` is connected, avoids 1, and has values `< 1`). So "the six tiles jointly cover the disc" is exactly "no Siamese partner of a tile at `V` lies in `B(V, 1)`" — de Grey's `[08.16]` merge. Five colours: `≥ 180°` of unit arcs centred at `V`. C-V56 as a whole: GAP |
| **C-LOCAL** | **GAP** (no explicit `R`) | [hand, one mind] | At bounded `K`: a NO gives some `R_K` by compactness (valid colourings of growing discs in `𝓜_K` have a Hausdorff-convergent subsequence; interior unit pairs are an open condition, so validity passes to the limit) — TRUE, over W-EQ-K's compactness step (VW, one mind). At unbounded `K`: no compactness, GAP. Lower bounds on any `R`: `(√15/2 + √3)/2 ≈ 1.834` given CAL-STRIP's validity, `√(5/2 + 9/(2√5)) ≈ 2.12426` given CAL-DISK's |
| **C-BEYOND** | **TRUE** given the strip's validity (CAL-STRIP is FS-112's to confirm) | [hand, trivial, one mind] | an argument that derives a contradiction from a valid colouring's restriction to a disc of radius `≤ 1.834` refutes the strip's restriction to that disc. *The step it names* in a route of this shape (RED, then the chain): the propagation — N4-PROP's bi-infinite chain, and any "each arc forces another" (C-UA-CHAIN) iterated without bound; checked against the side's route in stage 2 |
| **A4-SIX-ARCS** | **TRUE** | [hand; two minds now: A4, NB] | branch 1 above |

### 1.7 Where "six" is spent, and the controls

Six is spent in N-E1's use at a four-colour vertex (the ring has two colours) and at a five-colour vertex (one colour), in NB4′'s "the complementary
2-set" of a 4-set, in N-X's "`P_cl(u) ∪ P_cl(v) = [6]`", and nowhere in NB-U1, NB-L60, NB-LOCK, NB-BEND, NB-END (geometry of one colour). *Seven-colour
control:* in the hexagonal seven-colouring a vertex's ring has four colours and no unit arc is a boundary; NB4′, SIX and the chain's exceptions do not
start. *The strip:* NB-U1's self in-contact is the strip's kind (claim list §0); no verdict above refutes a strip.

## Stage 1 — SAVED

## Stage 2 — SAVED: the side's record read (after `2cd9d152`); divergences

*Read after stage 1 was committed: `plans/FS112-N-proof.md` in full (stages 1–2), `tools/fs112_n_arcs.py` (header; re-run with its three plants,
outputs in scratch: ALL CHECKS PASS; `band_below` refuses; `r2_outside` and `end_half` are twins that exit 0 when the derived opposite outcome holds),
`data/fs112/fs112-n/arcs.out`. Also re-read, to settle one divergence: `tools/fs110_y_fragments.py`'s header and `frag_BB` (BB is "all straight").*

### 2.1 Quotation check of the instance file against the side's record

N112-U1, SIX, NB4′ (with "the bound `|P_cl(y_k)| ≤ 4` is not needed", from N112-NB4's row), END, L60, LOCK, BEND, RED: **verbatim** against the theorem
table, `plans/FS112-N-proof.md` ll. 16–25.

### 2.2 The contest's result: one step I called surviving that the side finds failing — the side is right

**N4-FLANK at `κ₊ = 1` (resp. `κ₋ = −1`)** (C-CHAIN-6/7). My stage 1 (§1.4 row 6) said "N4-FLANK survives", having checked only flank contacts that are
arcs of `ω(v)`. The side (`plans/FS112-N-proof.md` l. 114, row 7) finds: when the horn's upper arc is an arc of `ω(N)`, the `g`-flank lies inside
`B(N, 1)`, so an **in-type `g`-tile at `N`** (inside `B(v, 1)`) is Siamese with it — FLANK's step "in-type g at N or at S′ would be Siamese with the flank
sector (N-E2), which has points just above κ₊ ∈ (−1, 1), outside both B̄(N,1) and B̄(S′,1): impossible" uses `κ₊ < 1` exactly there. **Re-derived
(sighted, one more mind):** such a tile touches `ω(v)` at `N` from inside; for a horn point `z = v + sa + yn`, the tile's points `p` near `N` give
`\|z − p\|² − 1 ≈ −2y + (s − X)² − 2h(X)`, `h(X) ≥ X²/2` the tile's depth below `N`, so `z` is shadowed below a circle of curvature `σ′ ≤ 1` (the `g`-flank
above curvature 1 must stay unshadowed) — a band of the horn FLANK's list omits; the side's BAND check exhibits the straddle at named points. The arc
at `N` is then **both** kind (`g` in, `c` out). **Consequences:** SHAVE's criterion `σ_h < σ_g` is incomplete (the shave needs `σ_h ≥ max(σ_g, σ′)`);
N4-STUCK's "doubly shadowed gives an out-type g-tile at S′" no longer follows, so a stuck vertex with a horn bound `±1` can lack N4-STUCK's structure,
and **NB-END (a conditional on that structure) does not reach it**. Steps 6–8, 10, 11 stay (b); their exception lists gain this one. Grade: the failure
two minds (the side blind; mine sighted).

No step the side calls **(a)** (N3-CONF, W-MERGE, N4-RAY, N4-FIN with N112-END, N4-TERM's first half) do I find failing. W-MERGE's added clause
(the side's W2: an arc `A` of `ω(v′)` through `v`, `c ∈ P_cl(v′)`, never bounds a gap sector) — not derived blind; re-derived after reading by a shorter
route: all `c`-sectors at `v` lie on one side of `A` (N-E2 against `v′`'s `c`-tile), and the gap lies between two of them inside `D_c(v)`, so `A`
bounds at most the extreme `c`-horn, never a gap sector. Agrees.

### 2.3 Divergences, each with both addresses

| # | topic | mine (stage 1) | the side | changes a verdict? | resolution |
|---|---|---|---|---|---|
| 1 | N4-FLANK at `κ = ±1` (C-CHAIN-6/7) | "survives" (§1.4 row 6) | fails: in-type flank tile at `N` (l. 114) | **yes — mine was wrong** | §2.2; the side stands |
| 2 | "the exception is realised locally by T2" (C-CHAIN-1, 2, 18) | T2's four-colour `w` realises NB-4's exception; S1, T2 make NB-5 "fail as a local statement" (§1.4 rows 1, 2, 18) | the fragments are below NB-4's reading radius: BB, **all straight** (Condition 5 locally), also carries four-colour `w, w′` (l. 108, W6) | **yes, the evidence** (not the letter (b)) — **mine withdrawn** | BB is all straight (`tools/fs110_y_fragments.py` l. 16): a fragment of radius `1/4` cannot test a step that reads a whole unit circle. The first break is still C-CHAIN-1, **unrealised** |
| 3 | SHAVE's new arc (C-CHAIN-7) | "the shave's new arc is a unit arc" when `σ_h = −1` (§1.4 row 7) | no unit arc is created: `σ_h = −1` puts `Σ` on the existing lower arc (l. 114) | wording; **mine wrong** | `σ_h ∈ [κ₋, κ₊]`, so `σ_h = −1` only as `σ_h = κ₋`: `Σ` is the horn's own lower arc, and the `h`-part is empty |
| 4 | isolated inner-colour contacts at `P + 2e_{w₀}` | permitted by LOCK; they block the **away**-bend near `w₀` (first order), a tangent bend clears them unless the contact tile's boundary **is** the radius-2 circle — sketch (§1.5 BEND); RED GAP 2 | "ARC-INERT's 'finitely many isolated contact points' do not exist in the arc's interior" (l. 231); RED bends away "wherever R2 fails" (l. 246), R2 meaning "over all of `α`" (l. 245) | **yes: the side's sub-claim is false, and N112-RED has a GAP the side does not name** | *Local counterexample to "do not exist"*: an inner-colour tile `Y` outside `B̄(P, 2)` except for a corner at `q₀ = P + 2e_{w₀}` (sides leaving `q₀` at `±60°` from `e_{w₀}`): every interior distance from `T_in ⊂ B(P, 1)` to `Y` exceeds 1, so N-E0 holds, and LOCK's `P + 2e_w` case is exactly this. It is harmless to ARC-INERT (an inert arc bends **toward** `P`, which `Y` does not block — both verdicts agree there) but it blocks a first-order away-bend at an out-contact arc, the step RED uses. Status: **GAP**, closable by the tangent-bend sketch (one mind) |
| 5 | N112-RED's GAPs | end vertices; isolated contacts; termination with stubs (§1.5) | end vertices; the bookkeeping that a bend never creates a contact at another arc's centre (l. 252) | scope | both name the end vertices; add #4; the stub-accumulation argument (repeated interior bends pile arcs at an end vertex) is the reason the end-vertex GAP also blocks termination |
| 6 | C-SEAMS-TWO's correction | two species **before** reduction: `w₀` in the closure of a unit arc centred at `u` or `v`, or `w₀` a vertex of `≥ 4` colours (NB-SEAM2, §1.6) | **one** species **up to** N112-RED: a `≥ 4`-colour vertex carrying both side colours of its arcs, plus R2 (l. 269) | scope (both MISSTATED) | both TRUE in their frames; the side's rests on RED (GAP), and on NB4′'s **(E2)** branch the seam point `w₀` is a four-colour vertex carrying **no** unit arc (the (Q) centres are its ring points), so "one species" describes `w₀`'s ring, not `w₀` |
| 7 | C-UA-CHAIN's (E2) step | (Q) centres force further arcs via NB4′ (§1.6) | "on the (E2) branch it forces a both-kind arc centred at a ring point … whose centre is then (Q)" (l. 270) | precision | "both kind" is derived when `y_k` is **interior** to the arc (its sides are then `e, f`, row 1, l. 108); when the arc only **ends** at `y_k`, its sides at `y_k` are not forced to be `e, f`. Both GAP |
| 8 | N112-U1's shadow clause | "contains" the facing cone; "is" when `cl T_out ∩ ω(P) = ᾱ` (§1.5) | theorem table "is" (l. 16); its own §1.3 says "contains" (l. 86) | wording | the table's "is" needs that precision |
| 9 | N112-L60's second clause | any side-colour tile with `w ± 60°` in its closure, `w ∈ int α`, is excluded (N-E2, §1.5) | two same-colour tiles **beside the arc** 60° apart (N-E1 by transversal crossing, l. 220) | scope; both TRUE | mine covers a tile meeting `w ± 60°` only at a vertex sector, where the side's crossing need not enter the tile |
| 10 | C-CHAIN-8's arc of `ω(v)` through `N` | forces `\|P_cl(N)\| ≥ 4` (both side colours of that arc lie outside `{c, g, h}` by NB-U1, §1.4 row 8) | "the ring colour `r` at `N` may not exist"; `c`'s contact at `N` isolated (l. 115) | mine sharper; compatible | with both: `N` is NB-4's exception, and `c` touches `N` at a point |
| 11 | C-CHAIN-15 | arc-type M-in points at `u ± e` are consistent with the lemma (NB-U1 forces a non-cubic `u`); GAP at a pinch (§1.4) | "(b) (B2) at `u`" (l. 122) | compatible; mine adds the arc case | — |
| 12 | C-UA-BUDGET, "do the branches exclude each other?" | as hypotheses yes, as conclusions no (§1.6) | not answered; its corrected branch 2 includes arcs centred at `v` (l. 266), which implies "no" | compatible | — |
| 13 | C-LOCAL | GAP; TRUE at bounded `K` by compactness (over VW), lower bounds 1.834 / 2.12426 (§1.6) | GAP; candidate global step the (E2) chain (l. 293) | compatible | — |
| 14 | C-BEYOND's step | the propagation (N4-PROP; C-UA-CHAIN iterated) (§1.6) | "the exclusion of a map whose unit arcs are all (Q) or (R2) …", not derived; candidate the (E2) chain (l. 291) | compatible | the side names the step; nothing it derives is refuted by the strip or the disk |
| 15 | the side's tool | — | `r2_outside`, `end_half` are twins that exit 0 when the derived opposite holds; no plant targets L60 (its 50° twin is built in) | tool note | paired controls in `CLAUDE.md`'s sense, but no plant shows the checker turning a wrong verdict red at R2, END or L60 |

**Agreements** (the second mind on each, mine blind): N112-U1 (bar #8), N112-SIX, N112-NB4′ with "the bound is not needed" (the same alternation
argument: `P_cl(y_{k+1})` forces one inner and one outer colour), N112-END, N112-L60 (bar #9), N112-LOCK (different routes: the side by a shadow
half-plane, mine by N-E2's two-sidedness), N112-BEND off the end vertices (bar #4), the three-colour merge inside N112-RED; C-UA-WEDGE's correction
(identical); C-UA-BUDGET branch 1 (now three minds: A4, N, NB) and branch 2's correction; ARC-INERT (TRUE, sharper, off the end vertices); C-UA-CHAIN,
C-V56, C-LOCAL GAP; A4-SIX-ARCS TRUE. Chain walk: every step's letter verdict agrees ((a) at 3, 4, 9 and N4-RAY; (b) at 1, 2, 5–8, 10–17; (c) at 18),
and both put the first break at C-CHAIN-1.

### 2.4 Corrections to my stage 1 (free; counted)

1. §1.4 rows 1, 2, 18 and the Theorems row NB-CHAIN: "realised locally by FS-110's fragment T2" and "fails as a local statement" are withdrawn
   (divergence 2). The first break is C-CHAIN-1, not realised by any held object.
2. §1.4 rows 6–7: "N4-FLANK survives" is wrong at `κ = ±1` (divergence 1); "the shave's new arc is a unit arc" is wrong (divergence 3).
3. NB-END's scope line: add that stuck vertices with a horn bound `±1` may lack N4-STUCK's structure (divergence 1), so NB-END covers only chains that
   have it.

Retractions counted: three, all mine, all after reading (none free in the protocol's sense — stage 1 was committed).

### 2.5 Items for the close (proposed; I edit none of the shared files)

- `LEDGER.md` / the derivation file: N4-FLANK fails at `κ = ±1` (two minds, the side blind); N112-NB4′ with "the bound is not needed" two minds, one
  blind; A4-SIX-ARCS three minds; N112-LOCK two minds by different routes; N112-RED GAP at end vertices **and** at isolated inner contacts (#4).
- The side's l. 231 sentence ("do not exist in the arc's interior") is FALSE as a statement about contacts; correct to "block only the away-bend".
- `plans/FS110-derivation.md` l. 42's general form reads correctly as NB4′ (delete "`ω(y)` or"; read "through" as "in the closure of"; add "or an
  orbit point in the closure of an arc of `ω(v)`").

## Stage 2 — SAVED
