# FS129-SR1 — pass 3 of the cross-application audit, lane R (the regularity-wall era): merges, strengthening, vacuity, the records that disagree

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-SR1-pass3.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 4, scoped first to the Lean order
(`data/fs129/index/lean-order.md`). Writes only this file, `data/fs129/sr1/`, `tools/fs129_sr1_*.py` and `data/fs129/reports/FS129-SR1.md`.
Started 2026-10-04 00:15 UTC. Planned as successive agents: this one works the named items, then the vacuity sort, then the sweep, and hands
the rest to FS129-SR2.*

## Theorems this phase proved

*Filled at each stage.* Every entry is **derived, one mind, kernel pending**; none moves a value or the answer's bearing.

- **FS129-SR1-TWOCIRC** — two unit circles about a unit pair: `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`, below 1 exactly when
  `s + t < 180°` (`0 < s, t < 180°`); the one lemma under FS114-Y5-PXKILL, FS116-V6-HUG, -V6-ADJ and -Y4-FLANK — hand — § 3.1, control `fs129-sr1-twocirc`.
- **FS129-SR1-SIXQ** — at a point carrying all `k` colours of a valid fragment (Siamese allowed) the ring lies in `Γ`, every ring arc with both side
  colours at the centre; at six colours every ring arc is (Q) — derived from FS116-N1-TWIST-D — § 3.2.
- **FS129-SR1-BENDANY** — FS-112's bends on a whole-tile fragment below `√3` at any `k` and any centre: every ring arc not both of whose side colours are
  carried at the centre is removed, the class kept — derived from FS129-OR1-WHOLE, FS112-N2-BENDS — § 3.3.
- **FS129-SR1-BENDLE3** — in the non-Siamese simple class, any `k`, a point of at most three colours has its ring freed of every arc of `Γ` below `√3`
  — derived from BENDANY, FS116-V5-U1 — § 3.3.
- **FS129-SR1-RINGBAND** — the band of `D` on a three-coloured ring: `h = (6 − 2n₂)/3`, `W = Σ m_j + 3 − h/2`; carries FS110-N2-RING (refined: `W = 6M + 3`
  unless the change set is `60°`-invariant), FS110-Y3-GP and FS129-OA1-RINGWIND — hand — § 3.4, control `fs129-sr1-ringband`.

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full before this stage: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from
`# Ephodos in lean-dir — the workflow` to its end (lines 278–432 read; `## The record job` not mine); `plans/STANDING-RULES.md`;
`plans/FS129-cross-application-audit.md`; `plans/FS129-close-inventory.md` (all 85 items); `data/fs129/index/lean-order.md` (all 197 rows);
`data/fs129/index/vacuity.md` (the header, the two lists and the 55 `none-known` entries' model lines). Not yet read, on purpose, until these
expectations are saved: any derivation file, any grokking, passes 1 and 2's records beyond MR1's first 60 lines (read for the record's form).

**Quotation check** (standing rule 3), by script:
- the request (`> Right after this close, …`) against `plans/STUB-cross-application-audit.md`: found, verbatim (`grep -cF` → 1);
- decisions 1–4 (`> 1. yes, we don't want O(N^2) here. …`) against `plans/FS129-cross-application-audit.md`: found, verbatim;
- the note on roots (`> Also a note for the whole plan …`) against the same file: found, verbatim;
- Kooshi's reading (`> **Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. …`) against `plans/FS129-close-inventory.md` § Items:
  found, verbatim, as item 32, across its line breaks (a single-line `grep -F` misses it; joined on whitespace it matches).

No mismatch; no finding about the brief.

**Scope, counted before reading.** The Lean order holds 197 results; 195 are lane R's (FS-106, FS-111, FS-112, FS-114, FS-116, FS-121), and 2
lane A's (TC1-SQRT3-DYADIC, TC1-STANDING-FIVE, both conditional seeds, item 13) — those two are lane A's pass 3's, and I leave them. The
vacuity file flags 55 `none-known` entries, every one of them lane R's (FS-114, FS-116, FS-121), plus a second list of 2 borderline and 16
loose-pattern entries.

**Registered expectations** (2026-10-04 00:15 UTC, before any derivation file or grokking was read for this pass; scored at this pass's hand-back
and at FS129-Z1; instruments for G21, never caps):

| quantity | expectation | reasoning |
|---|---|---|
| of the seven named merge groups (brief § Done means 2(c)), confirmed as **one statement or one a case of the other** | 5 of 7 (range 3–7) | each was flagged by a reader who had both statements open; the stuck ray / tangent pencil and RINGWIND / FS110-Y3-GP groups read as shared mechanisms more than shared statements |
| further merges found in the sweep of the Lean order (beyond the named groups) | 8 (range 3–15) | FS-116's V-stages re-derive its Y-stages (V5-U1, V5-NE1 already flagged); FS-114 holds superseded entries kept "as the proof side's route" |
| hypotheses weakened, the weaker form derived as an entry | 3 (range 1–8) | item 61 (bends need one absent side colour) is one ready; most hand results here are already stated at the class their argument used |
| of the 55 `none-known` entries: **hypothetical by design** / **no-go** / **empty** / **inhabited** | 38 / 7 / 6 / 4 | FS-116's Y3–Y4 and V5–V6 lists and FS-121's D1–D2 lists are steps toward a contradiction; Y4-EMPTY, Y4-OBST, D4-HOLE, TIGHTLENS read as no-gos; FS114-N7-HUB already says it is "true vacuously" on one class |
| an "empty" entry with a dependent that **inherits** the vacuity in a way that matters (a non-contradiction use of an empty class) | P = 0.30 | the double tip was worked two rounds on an empty class; the danger is a construction-side use |
| the disagreement on FS-112's bends (item 2(b)) **settled by pass 1's WHOLE** | P = 0.55 | WHOLE is a whole-tile restriction statement; the disagreement may be about round versus whole-tile restriction, which WHOLE addresses, or about which arcs survive, which it may not |
| the attack on FS129-OR1-QFREE's chain (item 55) **succeeds** (a step fails as stated) | P = 0.15 | horn lenses at cusp ends are the kind of place a simplicity hypothesis breaks |
| the attack on FS129-MR1-DOUBLETIP (item 76) **succeeds** | P = 0.15 | "free only because its neighbour is a change point" is a circular-looking step, but RING-GERM's germs are local |
| either attack yields a **repair** narrower than the stated composition, rather than a refutation | P = 0.25 | |
| pass 3 finds **a held result false** (any, including the two compositions) | P = 0.22 | |
| of the lane-R "Rests on it: nothing" edges (item 77), the share that are **real** dependencies | 30 % | the examples given are mostly corrected-form pointers and successor lists |
| this agent reaches the end of the vacuity sort before handing back | P = 0.6 | the named items are heavy reading; the sweep goes to SR2 |

## Stage 2 — SAVED: the two attacks (item 2(a)) and the bends' disagreement (item 2(b))

*Both attacks are checking readings, not second minds: I read each composition's argument before attacking it (brief § Done means 2(a)).*

### 2.1 FS129-OR1-QFREE's chain, attacked at its two named steps (`plans/FS129-close-inventory.md` item 55)

The chain: FS129-OR1-WHOLE (the whole-tile restriction `F_ρ`, `ρ ≤ √3`, keeps the class and shows no witness) → FS129-OR1-BENDFRAG (bend every
non-(Q) ring arc of `F_ρ`) → FS129-OR1-QFREE-CLASS (a Γ-free exclusion becomes a (Q)-free one) → FS129-OR1-QFREE (with FS116-Y4-EMPTY). Read:
`plans/FS129-OR1-audit.md` ll. 55–255 (J1 in full); `plans/FS112-derivation.md` § 1 (FS112-U1 to FS112-DISC1, the bends and their lemmas);
`plans/FS112-NB2-verification.md` § 1.4 (N2-TOWARD, N2-AWAY, N2-TAN, N2-SIGN, N2-ENV) and § 2.3 row 5 (N2's route against NB2's);
`data/fs116/claims.md` § 0 (valid fragment, tiles, simple, Siamese).

**Step 1 — "FS112-N2-BENDS being read on a fragment (it depends only on the tiles present)". Holds.** The attack looked for any step of the bend
lemmas that consumes a property a valid *map* has and a fragment's restriction `F_ρ` lacks: covering of the plane, local finiteness up to radius 2,
or a regular shape of a contact tile. What each step consumes, read off NB2 § 1.4 and N2's route (NB2 § 2.3 row 5):
- *N2-SIGN* (a side-colour tile point is within `< 1` of all of `int α` or `> 1` from all of it) consumes one offending tile point `x`, the two side
  tiles `T_in`, `T_out`, and validity on the pair (`x`, a side tile). All three are tiles of `F_ρ`, hence of `F`, with the same sets.
- *N2-ENV* is plane geometry about `α` alone.
- *N2-TOWARD*, by N2's route: a near tile (within `< 1` of all of `int α`, so within `≤ 1` of all of `ᾱ`) is within `< 1` of every point of a toward
  lens, because the lens lies in the circular segment cut by `α`'s chord and the distance from a fixed point is a strictly convex function on that
  segment (equality at a lens point would force it to be an end of `α`); a far tile meets a lens point's unit circle only within `O(ψ)` of `P` (ENV),
  where `s_out ∉ P_cl(P)` and the finitely many tiles of `F_ρ` meeting a neighbourhood of `P` give a positive distance. Nothing reads a tile's shape.
- *N2-AWAY*: near `s_in` tiles at the ends — a closure point `c` with `|c − A| = 1` and `|c − w| < 1` on `int α` has `(c − A)·τ_A > 0` unless `c ∈
  {P, Q_A}` (`P` excluded by `s_in ∉ P_cl(P)`, `Q_A` is far), so a wedge lens of small angle stays within `< 1` of `c`; far `s_in` tiles meet a lens
  point's circle only within `O(√ψ)` of `R₂(ᾱ)` (ENV), and WHOLE's last clause (no `s_in` tile of `F_ρ` touches `R₂(ᾱ)`, ends included) with the
  finiteness of `𝒯_ρ` gives a positive distance.
- *Finiteness.* `𝒯_ρ` is finite: local finiteness on the compact `B̄(p, ρ) ⊂ V` leaves finitely many arcs of `Γ` in `B(p, ρ)`, so `B(p, ρ) ∖ Γ` has
  finitely many components, and each tile of `𝒯_ρ` contains one. Each tile's closure is compact (diameter at most 1, FS116-V5-NE1).
So every exclusion is "an offending tile of `F_ρ` would be in the shadow of a side tile of `F_ρ`", a statement about two tiles of `F` that `F`'s
validity already forbids; removing tiles removes constraints and adds none. The reading is monotone, as OR1 said.

*One point for the Lean module, not a defect of the composition.* NB2's own route at an end vertex (the contact half-planes at `Q_A = P + 2e_A`, and
the out-type tile's shadow circle `Σ` tangent at `A`) reads the **shape** of an `s_out` tile at `Q_A` — its sector, its tangent directions. On a
fragment about `p` of radius `r < 2`, `Q_A` (at distance 2 from `p`) may lie on the boundary of the fragment's open set `V`, where the definition
("a map of an open set containing `D`, bounded by segments and circular arcs", `data/fs116/claims.md` § 0) promises no shape and no local finiteness.
N2's route (convexity for near tiles, ENV for far ones) reads only closure points and does not meet this. **So the Lean module of the bends on a
fragment should follow N2's route, not NB2's.** I checked the claim behind it directly for the toward lens near an end `A`: for a lens point `z` with
angular coordinate in `(0, ℓ)` and a point `y` with `|y − z| = 1` and `|y − P| > √2`, the arc of `ω(y)` inside `B(P, 1)` contains no point where a ray
from `P` is tangent to `ω(y)` (those points are at distance `(|y − P|² − 1)^{1/2} > 1` from `P`), so the angular coordinate is monotone along it; its two
ends on `ω(P)` bracket `z`'s angle, and for `y` near `Q_A` the arc is short, so one end lies in `int α`, where `ω(y)` crosses transversally into
`T_out`: `y` is in `T_out`'s shadow, whatever the shape of `y`'s tile. This is the content of NB2's `Σ` argument without the shape.

**Step 2 — "simplicity surviving horn lenses at cusp ends". Holds.** Simple (`data/fs116/claims.md` § 0): "every tile an open disc whose closure meets
each other tile's closure in a connected set or not at all, and does not meet itself". At a cusp end `A` where `T_in`'s sector has angle zero (TOWARD),
`T_in` near `A` is a horn between `α` and its other edge `e` at `A`, tangent there with signed curvature `κ_e > 1` (inward); the horn sub-lens is
bounded by `α` and a new edge `β` tangent at `A` with curvature in `(1, κ_e)`. Then:
- `β ∖ {A, B} ⊂ T_in` and `β ∩ e = {A}` near `A` (different curvatures separate at once); so `J′ = (∂T_in ∖ int α) ∪ β` is a Jordan curve (a cusp at
  `A` between `β` and `e` is allowed), and `T_in′` is its interior; likewise `(∂T_out ∖ int α) ∪ β` bounds `T_out′ = T_out ∪ int α ∪ lens` (the
  theta-curve `∂T_out ∪ β`: its three regions are `T_out`, the lens and the rest).
- For a third tile `S`: `cl S ∩ cl(lens) ⊆ {A, B}` (`cl S` misses the open set `T_in`, the interior points of `α`, which lie on `∂T_in ∩ ∂T_out`
  only, and `int β ⊂ T_in`), and `A, B ∈ cl T_out` already, so `cl S ∩ cl T_out′ = cl S ∩ cl T_out`; and `cl S ∩ cl T_in′ = cl S ∩ cl T_in` (the
  removed points `int α ∪ lens` are not in `cl S`). Both unchanged.
- `cl T_in′ ∩ cl T_out′ = (C ∖ int α) ∪ β` with `C = cl T_in ∩ cl T_out` connected. OR1 says each component of `C ∖ int α` contains an end of `α`.
  That holds **without** assuming finitely many components (which a tile reaching the edge of `V` need not have): `int α` is relatively open in `C`,
  so `C ∖ int α` is compact; if a component `K` missed `A` and `B`, quasi-components (equal to components in a compact Hausdorff space) give a set
  `U ⊇ K`, clopen in `C ∖ int α`, missing `A` and `B`; `U` is compact and disjoint from `ᾱ`, so at positive distance from `int α`, hence open in `C`
  too — a proper clopen subset of the connected `C`. So the union with `β` (which holds `A` and `B`) is connected.
- AWAY at a cusp end of `T_out`: the mirror, with the new edge's curvature in `(max(κ_{e′}, −1), 1)` — the interval must also avoid `−1`, or the bend
  would create a unit arc of the other orientation; NB2's AWAY clause writes the interval as `(−1, σ)`, which does. TOWARD's interval `(1, κ_e)`
  never contains `±1`. A wording point for the Lean statement, not a gap: OR1's sentence names only TOWARD's horn.

**Verdict (a1): the attack on FS129-OR1-QFREE's chain does not succeed.** Both named steps hold as read; no step of WHOLE, BENDFRAG or QFREE-CLASS
fails. Two notes go to de Bruijn with the chain: follow N2's route for the bends at end vertices (NB2's reads a contact tile's shape, which a
fragment of radius below 2 does not promise); and prove the connectedness step by quasi-components, not by counting components.

### 2.2 FS129-MR1-DOUBLETIP, attacked at its named step (item 76)

The named step: "RING-GERM (i) and N2-STAR applied at a change point whose other tip germ is free only because the neighbouring point is a change
point". Read: `plans/FS129-MR1-audit.md` ll. 75–200 (the entry and its argument); FS116-RING-GERM's entry and its argument
(`plans/FS116-N1-proof.md` § 3.1, read in full); FS116-Y4-FLANK's entry.

At `y = r(0)` the tip pair is `{v⁻, u⁺}`, and `u⁺` is the ring just counter-clockwise of `r(60°) = y′`, off `Γ` because `y′` is a change point. What
RING-GERM's argument does with `u⁺` (§ 3.1): **Step 1** — `u⁺`'s points are at distance 1 from interior points of `R` (their `−60°` images lie just
counter-clockwise of `y`), so they carry no `X`; a germ off `Γ` carries one absent colour (TWIST-D); so `u⁺` lies in a tile `S` of colour `X̄`.
Nothing here asks that `y + 60°` be interior to a tile: the germ is the open arc beside it. **Step 2(d)** — `S` holds `u = y′` in its closure; `S ≠ R′`
because `R′` holds ring points just clockwise of `y` and `S` ring points just counter-clockwise of `y + 60°`, more than `60°` apart, hence more than 1
apart, and a tile has diameter at most 1; N3-FACE at `(y, u)` (two distinct non-Siamese tiles of one colour at a unit pair face away) puts `R′`'s cone
at `y` in `[210°, 390°]`. Both uses hold when `y′` is a change point: the germ's tile is a tile like any other, and `y′`'s being a change point only
makes the germ certainly off `Γ`. At `y′` the same with `v′⁻`, the ring just clockwise of `y`, inside `R′` (colour `X̄`); Step 1 at `y′` gives it the
colour `X′` (counter-clockwise colour at `y′`), so `X′ = X̄` — the colour bookkeeping DOUBLETIP's step 4 uses, consistent.

The other steps, re-read: step 2's "t's cone at y ends at 210°" is FLANK's own conclusion (from `t ⊂ B̄(y′, 1)`, the cone at `y` lies in
`[30°, 210°]`), not an extra assumption; step 3's colour of `a` follows from non-Siamese and FS116-V4-DICHOTOMY alone (`a` meets `B(p, 1)`, is not a
tile of `p`, so its colour is absent at `p`) — **N2-STAR is not needed there**, a narrower uses-only line; the cone argument identifying `a = R′` and
`b = R_{y′}` uses one interval per tile at a vertex and the ring directions `90°⁺`, `270°⁻` at `y` (and `150°⁺`, `330°⁻` at `y′`), each checked;
step 5's straddle `|r(−δ) − r(60° + δ)| = 2 sin(30° + δ) > 1` against FLANK's closure points below 1 is V4-DICHOTOMY (or `a = b` against the diameter).

**Verdict (a2): the attack on FS129-MR1-DOUBLETIP does not succeed.** The named step holds; DOUBLETIP's argument is sound as read. One narrowing of its
`uses only:` line, for the record job: FS116-N2-STAR can be dropped (step 3 needs only non-Siamese and V4-DICHOTOMY); RING-GERM (i), FLANK, V4-TWIST
and V4-DICHOTOMY stay.

### 2.3 The records that disagree on what FS-112's bends leave on a ring (item 2(b); `plans/FS116-close-inventory.md` items 136, 145)

The two sides, verbatim in `plans/FS116-Z2-close.md` § 1.5. Side 1 (`plans/FS114-NB6-verification.md` § 1b.0): "run on a fragment on a neighbourhood
of `B̄(p, 1 + ε)`, N2-AWAY sees no radius-2 witness, so every ring arc but the (Q) arcs is removed"; side 2 (`plans/FS112-derivation.md` l. 90,
FS112-N2-RED): "Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which every unit arc is (Q) or (R2)";
FS116-Y4-EMPTY's *not claimed*: "anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the
bends, with (R2) arcs)".

**Pass 1's WHOLE settles it, and here is how far.** (i) The two sides are about different objects and do not contradict: side 2 is about a map,
where an (R2) arc's radius-2 witness exists and blocks N2-AWAY; side 1 is about a fragment that does not reach it. "Only (Q) and (R2) arcs remain"
(side 2, FS114-N5-GRING's uses-only) is also true of a bent fragment — side 1's "only (Q) arcs" is the stronger statement there, not a contrary one.
(ii) What Z2 § 1.5 named as deciding it — whether the bent fragment is again in FS116-Y4-EMPTY's class — is FS129-OR1-WHOLE plus BENDFRAG, and the
answer is yes **for the whole-tile restriction of radius at most √3**, and not shown (and in general false for the class) for side 1's literal
recipe, a round neighbourhood: OR1's control `fs129-or1-cut` cuts one tile into two pieces of one colour less than 1 apart, a Siamese pair. Side 1's
sentences are true about the arcs (a round restriction also removes every non-(Q) ring arc); what they did not carry is class membership.
(iii) The attacks of § 2.1 found no gap in WHOLE or BENDFRAG, so the settlement stands at its grade: derived, one mind (OR1), checked here as a reading.

Corrections owed (drafted for the record job, item by item; I edit neither record): `plans/FS114-NB5-verification.md` § 1b.3, `plans/FS114-NB6-verification.md`
§ 1b.0 and `plans/FS114-N7-proof.md` ll. 88–89 — read "restrict first" / "run on a fragment on a neighbourhood of `B̄(p, 1 + ε)`" as the whole-tile
restriction of FS129-OR1-WHOLE (OR1 already owes this, inventory item 59); FS116-Y4-EMPTY's *not claimed* line and `plans/FS116-Y4-construction.md`
§ 3.3 — add after "with (R2) arcs)": "reached in the non-Siamese simple class by FS129-OR1-QFREE (derived, one mind)"; FS112-N2-RED and FS114-N5-GRING's
line stand as written (both true; the second is weaker than what holds on a fragment).

*Gate at this stage's commit: `derive_gate.py all` FAILs with exactly one failure, "no derivation entry" — this stage holds checking readings, not
entries; stage 3's merge entries cure it. Committed so that the readings survive a halt (standing rule 2).*

## Stage 3 — SAVED: the merges lane R's passes found (item 2(c); inventory items 61, 62, 79, 70)

Seven groups, plus item 61's generalization of the bends. For each: is it one statement, one a case of another, or two statements sharing a step;
and what de Bruijn formalizes. Four entries below (TWOCIRC, SIXQ, BENDANY with BENDLE3, RINGBAND); the rest are lines.

| group | verdict | what crosses to Lean |
|---|---|---|
| 1. FS116-V6-HUG / FS114-Y5-PXKILL (FS114-YB4-2ND) / FS116-V6-ADJ / FS116-Y4-FLANK's model | **four statements sharing one lemma**, the two-circle identity (FS129-SR1-TWOCIRC); and V6-HUG is a **case** of FS129-MR1-DOUBLETIP (a ring with no arc of Γ has every germ off (Q) arcs; "tips both … the only tip at each" is DOUBLETIP's "the only tile of `p` whose closure holds `y`, and … `y′`") | TWOCIRC once; DOUBLETIP in place of V6-HUG (MR1's handoff already says so); PXKILL, V6-ADJ and FLANK each over TWOCIRC |
| 2. FS112-SIX with FS116-N2-FIVERING and -SIXRING | **SIX is subsumed**: its five-colour clause ("unit arcs centred at it of total length at least 180°") is FIVERING's last clause in a weaker form (FIVERING: (Q) arcs, on fragments, Siamese allowed); its six-colour clause is TWIST-D's two-line corollary at any `k`, Siamese allowed (FS129-SR1-SIXQ); SIXRING is that clause's non-Siamese strengthening | FIVERING and SIXQ in place of FS112-SIX; SIXRING as filed |
| 3. FS112-U1 = FS116-V5-U1 | **one statement in its first three clauses** (inner colour's sectors in the closed facing cone of width `π − ℓ`, outer colour's in the closed away cone, neither in the open side cones); V5-U1 states them on fragments at any `k`, U1 for six-coloured maps. Each adds one clause: U1 the outer tile's first-order shadow (`π + ℓ`), V5-U1 "a centre carrying both side colours carries at least four, non-Siamese simple" | V5-U1's first three clauses once, in place of U1's; U1's shadow clause and V5-U1's four-colour clause as two corollaries |
| 4. FS111-V0-ID1 / FS116-V5-NE1; FS111-C-HULL / FS116-V4-DICHOTOMY | **not one statement**: parallel forms in two settings. V0-ID1 and C-HULL read density (a density point of colour `j` against a point of positive upper density, a.e.-proper colourings); V5-NE1 and DICHOTOMY read closures (an interior point against a closure point, fragments). On a fragment, V0-ID1 gives V5-NE1 only at closure points where the tile has positive upper density, and a tile's cusp point has density 0 — so neither subsumes the other. They share only the step "a continuous function on a connected set that avoids the value 1 stays on one side" | both pairs separately; the connectedness step can be one Lean lemma |
| 5. the stuck ray (FS112-N2-RAY, -N3-CHAINS) and the tangent pencil (FS121-O1-OUT, -D2-SYM) | **not one statement**: one picture (a one-sided, unit-spaced, concentric pencil) in two settings — a valid map's stuck vertex chain, and an honest saturated colouring's tangent interfaces. The periodic kills (FS112-N3-PER; FS121-D2-PERFIN, -O1-PER) share only "finitely many radii". MR1's candidate weakening — FS121-D2-SYM's hypothesis (radius-`r` windows bounded below) moved to FS112-N3-PER toward N3-ALPH — **stalls at** an analogue of FS121-O1-OUT for valid maps: D2-SYM's kill uses that a tangent arc of radius `n` continues to `n + 1, n + 2, …` over one angular window, so windows stay fixed while radii grow; FS-112's pencil arcs bound horns near `P_k` and nothing makes a valid map continue them along a window, so their angular windows about `P_{−1}` need not be bounded below | nothing merged; the stall goes to FS129-Z1 as the smallest open form, for FS-126 or FS-115's re-posing |
| 6. FS111-M4-CUT and FS121-D4-FACE | **not one statement**: one elementary fact (the sagitta of a circle of radius `R` over half-chord `a` is `R − (R² − a²)^{1/2}`) read on a rung at radius `n` and on a facing box at radius 1. What matters for the Lean order is different: **D4-FACE has a stronger held form**, FS121-V5-FACE-SHARP (hypothesis `ρ² ≥ 2g − g²` in place of `2g < ρ²`, sharp) — see the sweep | D4-FACE in V5-FACE-SHARP's form (sweep, § 6) |
| 7. FS129-OA1-RINGWIND with FS110-Y3-GP and -N2-RING | **one lemma, three statements**: the band of `D(θ) = c̃(θ + 60°) − c̃(θ)` (N2-RING's proof) and the count `n₂` (Y3-GP's proof) carry all three. RINGWIND's hexagon winding is `h = (6 − 2n₂)/3`, so RINGWIND is Y3-GP's invariant read position by position — **its prior art is partly in-house** (FS110, two minds each), not only G71. The merged lemma adds the identity `W = Σ m_j + 3 − h/2` and refines N2-RING: with no swap point, `W = 6M + 3` unless the change set is invariant under the `60°` rotation (FS129-SR1-RINGBAND) | none required (all three are declined or uncrossed); if any is formalized, RINGBAND once |
| item 61. FS129-OR1-BENDFRAG, -BEND3 | **one statement at a wider class**: the bends need only that one side colour of a ring arc is absent at the centre, at any `k` and any number of colours at the centre (FS129-SR1-BENDANY); BENDFRAG is its case at `k = 6` and four or more colours, and BEND3's conclusion is BENDANY plus V5-U1's four-colour clause (FS129-SR1-BENDLE3, at most three colours, any `k` — also MR1's "generalization, not derived", inventory item 82) | BENDANY and BENDLE3 in place of BENDFRAG and BEND3 |

derivation: FS129-SR1-TWOCIRC
  statement: let y₀ and y₁ be points of the plane with |y₀ − y₁| = 1, and p a point with |p − y₀| = |p − y₁| = 1; for real s, t let a(s) be the point
    of ω(y₀) reached from y₁ by turning through the angle s about y₀ toward p, and b(t) the point of ω(y₁) reached from y₀ by turning through the
    angle t about y₁ toward p; then |a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t, and for
    0 < s, t < 180° the distance |a(s) − b(t)| is below 1 when s + t < 180°, equal to 1 when s + t = 180°, and above 1 when s + t > 180°
  uses only: a congruence taking (y₀, y₁, p) to (e(0°), e(60°), 0), which keeps "toward p"; there a(s) = y₀ + e(120° + s) and b(t) = y₁ + e(300° − t);
    the half-angle formulas
  not claimed: anything about tiles — each use (FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ, FS116-Y4-FLANK) adds its own pinning of two tiles to the
    two circles; anything for s or t outside (0°, 180°)
  argument: § 3.1 FS129-SR1-TWOCIRC, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: s = t = 30°: |a − b| = 2 cos 30° − 1 = √3 − 1, the gap of FS116-V6-HUG's model line ("its two X̄ ring tiles √3 − 1 apart at s = t = 30°")
  prior art: partly: in-house three times, unnamed (FS114-YB4-2ND's expanded form, FS116-V6-HUG's product form, FS116-Y4-FLANK's diagonal); Poros's
    R2 card 2 names it the three-unit-step closure |u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw) (as quoted in plans/FS129-MR1-audit.md; the card
    not re-read here); the constant width of the unit Reuleaux triangle
  handoff: de Bruijn — one lemma, proved once and consumed by FS114-Y5-PXKILL, FS116-V6-ADJ, FS116-Y4-FLANK and (through FS129-MR1-DOUBLETIP)
    FS116-V6-HUG; the statement and its not claimed

control: fs129-sr1-twocirc
  of: FS129-SR1-TWOCIRC — both forms of the identity, the diagonal 2cos φ − 1, the sign on a grid of angles (step 15°), and V6-ADJ's mirror, exactly
  run: python3 ../tools/fs129_sr1_twocirc.py
  expect: twocirc ok
  fault: python3 ../tools/fs129_sr1_twocirc.py --fault-sign

control: fs129-sr1-twocirc-diag
  of: FS129-SR1-TWOCIRC — the diagonal reads 2cos φ − 1, not 2cos φ + 1
  run: python3 ../tools/fs129_sr1_twocirc.py
  expect: twocirc ok
  fault: python3 ../tools/fs129_sr1_twocirc.py --fault-diag

### 3.1 FS129-SR1-TWOCIRC, the argument

In the frame `p = 0`, `y₀ = e(0°)`, `y₁ = e(60°)`: `a(0) = y₀ + e(120°) = e(60°) = y₁` and `a(60°) = y₀ + e(180°) = 0 = p`, so `a(s) = y₀ + e(120° + s)`
is the point of `ω(y₀)` turned through `s` from `y₁` toward `p`; likewise `b(0) = y₁ + e(300°) = y₀`, `b(60°) = p`. Then `a(s) − b(t) = (y₀ − y₁) +
e(120° + s) − e(300° − t)`, and expanding `|·|²` (three unit vectors, `y₀ − y₁ = e(−60°)`) gives `3 + 2 cos(180° + s) − 2 cos(360° − t) −
2 cos(180° + s + t)`, i.e. `|a − b|² − 1 = 2 − 2 cos s − 2 cos t + 2 cos(s + t) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t`. With `1 − cos x =
2 sin²(x/2)` and `sin x = 2 sin(x/2) cos(x/2)` this is `8 sin(s/2) sin(t/2)[sin(s/2) sin(t/2) − cos(s/2) cos(t/2)] = −8 sin(s/2) sin(t/2) cos((s + t)/2)`.
For `0 < s, t < 180°` both sines are positive, and `cos((s + t)/2)` is positive, zero or negative as `s + t` is below, at or above `180°` (with
`s + t < 360°`). A reflection of the frame exchanges nothing: `a` and `b` are defined by turning toward `p`. The diagonal: `|a(φ) − b(φ)|² =
1 − 8 sin²(φ/2) cos φ = 1 − 4(1 − cos φ) cos φ = (2 cos φ − 1)²`. V6-ADJ's arcs (`a = y₁ + e(−60° + s)`, `b = y₀ + e(120° − t)`) are the same
statement for the apex `p′ = y₀ + y₁ − p` of the other Reuleaux triangle. Control `fs129-sr1-twocirc` checks every equality symbolically.

derivation: FS129-SR1-SIXQ
  statement: let F be a valid k-coloured fragment, for any k ≥ 1, Siamese pairs allowed, on a closed disc of radius above 1 about a point p at which
    all k colours are carried; then ω(p) lies in Γ, and both side colours of every arc of Γ on ω(p) are carried at p; so at k = 6, when p carries six
    colours, every arc of Γ on ω(p) is a (Q) arc
  uses only: FS116-N1-TWIST-D (the ring points in the closure of a tile of one of p's colours form a closed set lying in the union of the arcs of Γ on
    ω(p) and finitely many points); that every point of the fragment's open set lies in the closure of a tile (Γ, a locally finite union of arcs, has
    empty interior); the definition of (Q) (both side colours and at least four colours at the centre)
  not claimed: FS116-N2-SIXRING's structure (six 60° arcs, each the ring points of one tile; it needs non-Siamese); anything when a colour is absent at
    p (five colours: FS116-N2-FIVERING); that a fragment with a six-colour vertex exists beyond radius 3/2
  argument: § 3.2 FS129-SR1-SIXQ, the argument
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: FS116-Y2-SIXFRAG, the straight flower: its centre carries six colours and its ring is six (Q) arcs (FS116-N2-SIXRING's model line)
  prior art: partly: FS112-SIX's six-colour clause (valid six-coloured maps, two minds), of which this is the fragment form at any k
  handoff: de Bruijn — with TWIST-D, in place of FS112-SIX's six-colour clause; FS112-SIX's five-colour clause is FS116-N2-FIVERING's last clause
    in a weaker form, so FIVERING is formalized in its place

### 3.2 FS129-SR1-SIXQ, the argument

Every ring point lies in the closure of some tile (the ring lies in the fragment's open set, where `Γ` has empty interior), and that tile's colour is
carried at `p`, so TWIST-D's set `D` is the whole ring. Hence `ω(p) ⊆ A ∪ E`, with `A` the union of the arcs of `Γ` on `ω(p)` (finitely many closed
arcs, so `A` is closed) and `E` finite; `ω(p) ∖ E ⊆ A` is dense in `ω(p)`, so `ω(p) ⊆ A ⊆ Γ`. The side colours of an arc of `Γ` on `ω(p)` are colours
of tiles, all carried at `p`. At `k = 6` with six colours at `p`, each ring arc has both side colours at a centre of at least four colours: (Q).

derivation: FS129-SR1-BENDANY
  statement: let F be a valid k-coloured fragment, for any k ≥ 1, on a closed disc B̄(p, r), r > 1, about a point p, and let 1 < ρ′ < min(r, √3);
    then there is a valid k-coloured fragment F″ on B̄(p, ρ′), with the same colours carried at p as in F, whose arcs of Γ on ω(p) are exactly the
    arcs of Γ on ω(p) in F both of whose side colours are carried at p, so that Γ ∩ ω(p) in F″ is those arcs and finitely many points; its tiles are
    the tiles of F meeting B(p, min(r, √3)), each unchanged except the two side tiles of each other ring arc, which differ from F's only inside lenses,
    as thin as wished, along that arc; and F″ is non-Siamese if F is, and simple if F is
  uses only: FS129-OR1-WHOLE at ρ = min(r, √3) (stated for any k); FS112-N2-BENDS (N2-TOWARD, N2-AWAY) read on a fragment by N2's route (§ 2.1 of
    this record), in which no colour count is spent (`plans/FS112-NB2-verification.md` § 1.5: six "nowhere in N2-RAY, TOWARD, AWAY, TAN, RED, SIGN, ENV");
    FS116-V4-DICHOTOMY (any k), for non-Siamese after each bend
  not claimed: anything at radius √3 or more (an (R2) arc's witness can be seen there); that F″ keeps saturation; anything about the rings of other
    points; that an arc with both side colours at p can be removed
  converse: § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  argument: § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  verdict: derived
  grade: derived from: FS129-OR1-WHOLE, FS112-N2-BENDS
  minds: 1
  model: k = 6, the capped strip about a midline vertex P_j on B̄(P_j, 1.8), ρ′ = 1.7 — its four ring arcs are (Q), so F″ is F_√3 with nothing bent
    (FS129-OR1-BENDFRAG's model); no held fragment has a ring arc with a side colour absent at a centre of four or more colours, so the bend clause's
    held models are FS112-N2-RED's maps only
  prior art: owed — in-house; FS-112's bends are "not found in print" (FS112-N2-RED's entry)
  handoff: de Bruijn — in place of FS129-OR1-BENDFRAG and the bend half of FS129-OR1-BEND3: one module, the bends on a whole-tile fragment below √3,
    over FS112-N2-BENDS as an imported hypothesis until FS-112's module lands, following N2's route at the end vertices

derivation: FS129-SR1-BENDLE3
  statement: let F be a non-Siamese simple valid k-coloured fragment, for any k ≥ 1, on a closed disc B̄(p, r), r > 1, about a point p carrying at most
    three colours, and let 1 < ρ′ < min(r, √3); then there is a non-Siamese simple valid k-coloured fragment on B̄(p, ρ′), with the same colours carried
    at p, whose ring carries no arc of Γ
  uses only: FS129-SR1-BENDANY; FS116-V5-U1's last clause (in a non-Siamese simple fragment a centre carrying both side colours of an arc of Γ on its
    unit circle carries at least four colours; its argument reads validity, one tile per colour at a point and one cone per tile at a vertex, at any k)
  not claimed: anything at a point of four or more colours (there BENDANY keeps the arcs with both side colours at p: the (Q) arcs at k = 6); the
    Siamese or non-simple classes
  argument: § 3.3 FS129-SR1-BENDANY and BENDLE3, the argument
  verdict: derived
  grade: derived from: FS129-SR1-BENDANY, FS116-V5-U1
  minds: 1
  model: k = 6, a cubic trichromatic vertex u of the capped strip whose closed unit disc lies at distance above 1 from the strip's edge, on B̄(u, 1.1)
    (FS129-OR1-BEND3's model)
  prior art: owed — in-house
  handoff: de Bruijn — in place of FS129-OR1-BEND3, with BENDANY

### 3.3 FS129-SR1-BENDANY and BENDLE3, the argument

*BENDANY.* FS129-OR1-BENDFRAG's argument (`plans/FS129-OR1-audit.md`, § Argument for FS129-OR1-BENDFRAG), read with "a ring arc not both of whose side
colours are carried at `p`" in place of "a non-(Q) ring arc": that argument used "at least four colours at `p`" only to pass from "not (Q)" to "one side
colour absent at the centre" (OR1 says so in BEND3's argument), and here that is the hypothesis. Every other step — WHOLE's restriction and its witness
clause, TOWARD and AWAY on `F_ρ` (monotone, § 2.1), each bend keeping non-Siamese (V4-DICHOTOMY) and simple (the crescent, § 2.1's step 2), the
finitely many ring arcs bent one at a time with lenses near radius 1 and witnesses excluded near radius 2 — reads no colour count: WHOLE and
V4-DICHOTOMY are stated for `k` colours, and NB2 § 1.5 records that the bend lemmas spend six nowhere. *The converse direction of "exactly":* the arcs with both side
colours at `p` are not touched — each lens lies inside the two side tiles of its own arc, away from every other ring arc — so each stays an arc of
`Γ` on `ω(p)` with the same sides. The locality clause is the construction (each lens lies in a thin neighbourhood of its arc, inside its two side tiles).
*BENDLE3.* By V5-U1's last clause, an arc of `Γ` on `ω(p)` with both side colours at `p` makes `p` carry at least four colours in a non-Siamese simple
fragment; `p` carries at most three, so no ring arc has both side colours at `p`, and BENDANY removes them all, keeping non-Siamese and simple.

derivation: FS129-SR1-RINGBAND
  statement: let c colour the circle by ℤ/3, defined and locally constant off a finite set Σ of change points, with c(θ) ≠ c(θ + 60°) wherever both
    are defined; lift c to c̃, changing by +1 or −1 at each change point, and put W = (c̃(θ + 360°) − c̃(θ))/3; for θ with no point θ + 60°j in Σ put
    D_j(θ) = c̃(θ + 60°(j + 1)) − c̃(θ + 60°j), m_j(θ) = ⌊D_j(θ)/3⌋, n₂(θ) = #{j : D_j(θ) ≡ 2 (mod 3)} and h(θ) = (1/3) Σ_{j=0..5} d(c(θ + 60°j),
    c(θ + 60°(j + 1))), with d(x, y) = ±1 as y = x ± 1 (FS129-OA1-RINGWIND's W); then (i) h(θ) = (6 − 2n₂(θ))/3, a value in {−2, 0, 2}; (ii) W = m_0(θ)
    + m_1(θ) + … + m_5(θ) + 3 − h(θ)/2; (iii) h changes across θ₀ only if Σ holds two points θ₀ + 60°j and θ₀ + 60°(j + 1); (iv) if no point of Σ is a
    swap point (a change point x with c(x + 60°−) = c(x+) and c(x + 60°+) = c(x−), or the same with −60°), all m_j(θ) equal one integer M, W is
    6M + 2, 6M + 3 or 6M + 4, and W = 6M + 3 unless Σ is invariant under the rotation by 60°; (v) if no two points of Σ are 60° apart, h is 0
    everywhere and W = 6M + 3
  uses only: c(θ) ≠ c(θ + 60°), so no D_j is ≡ 0 (mod 3); that Σ is finite; at an event, the change of D_j is Δ_{j+1} − Δ_j (Δ_j the step crossed at
    the hexagon's j-th point, 0 if none), so the changes sum to zero; FS110-N2-RING's band step (D_0 leaves {3M + 1, 3M + 2} only by a jump of ±2,
    which needs a swap)
  not claimed: anything about tiles or maps (the circle colouring is the input; FS110-N2-RING's setting — a three-colour vertex whose ring carries no
    arc of Γ, coloured by its three absent colours — supplies one); that h is constant across two change points 60° apart (the swap moves it, row 132
    and G71)
  argument: § 3.4 FS129-SR1-RINGBAND, the argument
  verdict: derived
  grade: hand
  minds: 1
  model: the ring of six 60° arcs coloured 0, 1, 2, 0, 1, 2 — no swap point, Σ invariant, h = 2, W = 2 = 6·0 + 2; nine 40° arcs coloured 0, 1, 2, …
    (`plans/FS110-Y-construction.md` § 8.2's control) — no two change points 60° apart, h = 0, W = 3
  prior art: partly: FS110-N2-RING (the band) and FS110-Y3-GP (the count n₂ = 3, so W = 6M + 3), in-house, two minds each; FS129-OA1-RINGWIND
    (one mind) is (i) with (iii); G71's height functions; the identity (ii) and the refinement in (iv) not found in-house (not searched outside)
  handoff: none — FS110-N2-RING and -Y3-GP are declined for the kernel and RINGWIND crosses nowhere; if any of the three is formalized, this lemma is
    formalized once in their place

control: fs129-sr1-ringband
  of: FS129-SR1-RINGBAND — (i), (ii), (iii), (iv) and (v) on every proper discretised ring of 12 and of 18 cells and on 4000 seeded random ones of
    24 to 60 cells (44 with no 60° pair, 10896 with no swap point, 30 of those rotation-invariant)
  run: python3 ../tools/fs129_sr1_ringband.py
  expect: ringband ok (101284 rings; no 60-degree pair 44, no swap point 10896, of which rotation-invariant 30)
  fault: python3 ../tools/fs129_sr1_ringband.py --fault

### 3.4 FS129-SR1-RINGBAND, the argument

(i) `D_j ≡ c(θ + 60°(j + 1)) − c(θ + 60°j)`, so `d = +1` exactly when `D_j ≡ 1` and `−1` when `D_j ≡ 2`: `Σ d = (6 − n₂) − n₂`. As `Σ_j D_j =
c̃(θ + 360°) − c̃(θ) ≡ 0`, `Σ d ≡ 0 (mod 3)`, so `n₂ ∈ {0, 3, 6}`. (ii) `3W = Σ_j D_j = Σ_j (3m_j + r_j)`, `r_j ∈ {1, 2}`, `Σ r_j = 6 + n₂`; so
`W = Σ m_j + 2 + n₂/3 = Σ m_j + 3 − h/2` by (i). (iii) At an event (some hexagon points cross change points), `D_j` moves by `Δ_{j+1} − Δ_j`. If no
two adjacent hexagon points cross, every move is `0` or `±1`, and a `±1` move cannot reach a multiple of 3, so it stays in its band and flips its
residue; the moves come in pairs (`D_{j−1}` by `+Δ_j`, `D_j` by `−Δ_j`) of opposite signs, one `1 → 2` and one `2 → 1`, so `n₂`, hence `h`, is
unchanged. (iv) With no swap, `D_0` never leaves its band (N2-RING), so every `D_j(θ) = D_0(θ + 60°j)` lies in one band `{3M + 1, 3M + 2}`: `m_j = M`,
and `W = 6M + 3 − h/2 ∈ {6M + 2, 6M + 3, 6M + 4}`. Every move is then `0` or `±1` and the moves sum to zero, so `n₂` is invariant as in (iii). If
`n₂ = 0`, every `D_j = 3M + 1` and no move can be `−1`, so with sum zero every move is 0: `Δ_{j+1} = Δ_j` for all `j` at every event, i.e. every change
point's five rotates by multiples of `60°` are change points with the same step — `Σ` is rotation-invariant; `n₂ = 6` the same. So if `Σ` is not
invariant, `n₂ = 3`, `h = 0`, `W = 6M + 3`. (v) A swap point is a pair of change points `60°` apart, so (iv) applies; an invariant non-empty `Σ` would
put every change point in such a pair (and `Σ` is non-empty: a colouring with `c(θ) ≠ c(θ + 60°)` is not constant). So `h = 0` and `W = 6M + 3`.
*The three statements it carries:* FS110-N2-RING ("if it has no swap point then `|W(u)| ≥ 2`") is (iv)'s first part; FS110-Y3-GP ("winds `W ≡ 3 (mod 6)`")
is (v); FS129-OA1-RINGWIND ("`W` takes values in `{−2, 0, 2}`, has period `60°`, and changes across `θ₀` only if `Σ` contains two points `θ₀ + 60°j` and
`θ₀ + 60°(j+1)`") is (i) with (iii), its period being the definition's.

## Stage 4 — SAVED: the "Rests on it: nothing" edges (item 2(d), inventory item 77); the unread items (2(e), items 63, 81)

### 4.1 The edges, sorted

Found by script: every index record whose "Rests on it" text begins "nothing" or "none" and still carries ids — **25 lane-R records, 26 edges** (and 9
lane-A records, lane A's pass 3's; item 77's count of 24 used another matcher). Each edge `from → to` reads "`to` uses `from`". I read each sentence
and the `uses only:` line of each `to`. Classes: **real** (`to` rests on `from`); **route** (`from` is a step of a second mind's route to `to`, counted in
`to`'s minds, not needed by its first proof); **false** (`to` does not use `from`); **reversed** (false as written; the dependency runs `to → from`).

| from | to | class | reading |
|---|---|---|---|
| FS111-C-HULL-SO | FS111-C-HULL | false | a refuted entry naming its corrected form |
| FS111-M2-DISCK7-AS-PLACED | FS111-M2-DISCK7 | false | the same |
| FS112-Y3-R1 | FS112-N3-CHAINS | false | "nothing beyond": Y3-R1 is the same arithmetic, subsumed (its kernel line says so) |
| FS114-K1 | FS114-N7-HUB | false | K1 is the successor's opening list; it names a blind check of N7-HUB |
| FS114-ROUTE-T | FS114-N2-LEMMAS | reversed | ROUTE-T cites N2-LEMMAS' REFINE as its reason |
| FS116-O1-YESLIM | FS116-C114-LOCAL-F | real | the YES side of the open statement |
| FS116-RING-Q | FS116-C114-LOCAL-F | real | an open step of the open statement |
| FS116-RING-TRANSFER-QC | FS116-C114-LOCAL-F | real | its (Q)-ring case |
| FS116-S1-QF | FS116-C114-LOCAL-F | real | its saturated-cross case |
| FS116-S1-QF | FS116-SAT-STRIP | real | "SAT-STRIP's narrowing" |
| FS116-SEMI-PAR3 | FS116-C114-LOCAL-F | real | an open step of the open statement |
| FS116-V4-MEET, -OUTER, -PARTNER, -TWIST | FS116-S1-KAPPA | route (4 edges) | "FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF"; KAPPA's own `uses only:` reads N-E1, local finiteness, (Q), transversality |
| FS116-V5-DICHO | FS116-N3-SEMI | route | SEMI's minds: "FS116-V5-U1 … and FS116-V5-DICHO for crossed-or-parallel" (V5's method) |
| FS116-V5-LENS | FS116-Y3-SIX | route | "FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, …"; Y3-SIX's `uses only:` reads QFREE4, RING-TWIST-C, RING-GERM |
| FS121-C1-GMAP | FS121-D3-GRUNDY | false | "with FS121-D3-GRUNDY, once map colourings … are in Lean" — a crossing note; GRUNDY's `uses only:` has no GMAP |
| FS121-D1-PENCILWIN | FS121-O1-OUT | false | "it crosses with FS121-O1-OUT if a curved inhabitant lands"; O1-OUT's `uses only:` has no PENCILWIN |
| FS121-D2-PERFIN | FS121-D2-SYM | reversed | PERFIN is derived from SYM |
| FS121-D4-HOLE | FS111-M-PINCH | false | "it crosses with FS111-M-PINCH"; M-PINCH (FS-111) reads C-HULL, (H1), (H2), saturation |
| FS121-DB1-L6 | FS111-M2-INTRAD | false | "a re-derivation inside C121-ENDS's verification"; INTRAD reads M-C11 |
| FS121-DB1-L7 | FS121-O1-OUT | false | "it crosses with"; O1-OUT's `uses only:` has no L7 (L7's `uses only:` is O1-OUT's own) |
| FS121-V2-EROSION-DIAM | FS121-D1-EROSION | false | "it places … EROSION's content"; EROSION reads VT, XCORNER, M-C11 |
| FS121-V2-VT-W | FS121-D1-VT | false | VT-W is VT's wider form (a merge, sweep § 6), not an input |
| FS121-V3-CPI | FS121-V2-SECTOR | false | "a corollary inside FS121-V2-SECTOR's verification"; SECTOR reads Lemma C, M-PINCH, M-C11 |

**Tally:** real 6, route 6, false 12, reversed 2 — real dependencies are 6 of 26 (23 %), or 12 of 26 (46 %) with second routes (registered: 30 %).

**What the false edges do to the index** (`tools/fs129_sr1_edges.py`, which checks every row above is in `data/fs129/index/edges.csv`, removes the false
and reversed ones, and recomputes; control `fs129-sr1-edges`): **seven lane-R cycles break** — M-PINCH ↔ D4-HOLE, INTRAD ↔ DB1-L6, GMAP ↔ GRUNDY,
PENCILWIN ↔ O1-OUT, PERFIN ↔ D2-SYM, N2-AVG / N2-LEMMAS / ROUTE-T, and K1 / N7-3T / N7-HUB shrinks to N7-3T ↔ N7-HUB — so lane-R cycles go from 17 to
11; and **FS121-D4-HOLE's transitive dependents go from 61 to 0**: `data/fs129/index/vacuity.md` ranks D4-HOLE first ("transitive 60") entirely through
the false edge into FS111-M-PINCH, and `data/fs129/index/lean-order.md` row 28 lists M-PINCH as needing D4-HOLE. Route edges are kept (they are real for
the second route); removing them too would break V5-LENS / Y3-SIX / Y3-TIPS for a Lean order that follows the first routes.

For FS129-Z1, which corrects the index when it adds its column: drop the 12 false edges, reverse nothing (the true direction of each reversed edge is
already in `edges.csv`), mark the 6 route edges `route`, and recompute `roots.md`, `hubs.md`, `cycles.md`, `vacuity.md` and the Lean order.

control: fs129-sr1-edges
  of: § 4.1 — the 26 sorted edges are in edges.csv; dropping the false and reversed ones breaks seven lane-R cycles and leaves D4-HOLE no dependent
  run: cd .. && python3 tools/fs129_sr1_edges.py
  expect: edges sorted: 26 (real 6, route 6, false 12, reversed 2); lane-R cycles 17 -> 11; D4-HOLE dependents 61 -> 0
  fault: cd .. && python3 tools/fs129_sr1_edges.py --fault

### 4.2 The unread items (items 63, 81): what this pass read, and what it leaves

- **Item 63** (the mechanical half, `data/fs129/index/open-steps.md` § 3, lane R beyond FS-110): **not read by this agent**; left for FS129-SR2, scoped
  to the GAP lines of the Lean order's lane-R ids (FS-111, FS-112, FS-114, FS-116, FS-121), as the plan says.
- **Item 81**, three leads from MR1: (1) G83's straddle against FS114-K1's (Q)-ring residues (FS114-Y6-E2RED's survivor S6, the wrap, the Reuleaux
  `(2, 1, 1, 0)` past `√3`) — **not read**; FS129-SR1-TWOCIRC is the tool to try first (S1 died to PXKILL, which is TWOCIRC). (2) V6-ADJ at adjacent change
  points whose outer pairs are off (Q) — **not derived**: the analogue of DOUBLETIP would need RING-GERM (ii) at both points (outer germs `u⁻`, `v⁺` off
  (Q)) and V6-ADJ's own pinning of the outer tiles to the lens arcs; TWOCIRC covers its last step (the mirror apex). (3) FS106-BIKE's coupling of two
  circles' windings across the cross curve — FS129-SR1-RINGBAND sharpens the single-circle input (no swap point and a change set not invariant under
  `60°` give `|W| ≥ 3`, not only `≥ 2`), and **the coupling stays missing**. All three to FS129-SR2.

## Stage 5 — SAVED: the vacuity sort (brief § Done means 3; inventory items 33–37)

**Rule used to split "empty" from "hypothetical by design"**, since several classes are now *known* empty: a statement over a class that a held no-go
empties is **hypothetical by design** when it is a step of that no-go's held proof (or of a held second route to such a step), and **empty** when no held
contradiction proof uses it — then formalizing it as stated formalizes a vacuous statement with no consumer. Classes known empty, with their receipts:
`C_Γ` — non-Siamese simple valid six-coloured fragments, radius above 1, about a vertex of at least four colours whose ring carries no arc of `Γ`
(FS116-Y4-EMPTY, held; its two routes: FLANK, Y3-SIX, Y3-TIPS, RING-GERM — or V6-HUBS, V6-HUG, V6-ANTI, V6-COUNT); HEX3's class `⊂ C_Γ`; `C_Q` — the same
with "no (Q) arc" (FS129-OR1-QFREE, **derived, one mind**). Classes **not** known empty: the same with non-Siamese or simple dropped (FS-123 question 3,
J7); rings with (Q) arcs (FS-124); five-colour vertices; saturated touch points (FS-125); curved tangent interfaces, (R2) arcs and LRA in honest saturated
colourings (FS-126, FS-127); valid maps of the plane (the NO). Dependents are read from `data/fs129/index/edges.csv` with § 4.1's false edges removed
(`data/fs129/sr1/vacuity_input.txt`, the working list).

### 5.1 The 55 `none-known` results

**No-go (4)** — the statement is that a class is empty; nothing passes on.
| id | reading |
|---|---|
| FS121-D4-HOLE | "a colouring whose Σ is locally finite has no region with a hole"; after § 4.1 it has **no dependent** (its 60 were the false edge) |
| FS116-Y4-EMPTY | `C_Γ` is empty |
| FS116-Y4-OBST | "no fragment of the HEX3 class exists" — a corollary of Y4-EMPTY (HEX3's class lies in `C_Γ`) |
| FS116-N1-QFREE4 (borderline) | equivalent to "no vertex of five or six colours (Siamese allowed) has a ring free of (Q) arcs", whose class is inhabited by FS116-Y2-SIXFRAG's centre (six colours, six (Q) arcs) — not vacuous |

**Inhabited (1)**
| id | object |
|---|---|
| FS121-O1-OUT (borderline) | `k = 9`, FS111-W-SQ9: its flat edges are tangent-type interface pieces of infinite radius, and their unit parallels carry the ladder (48 of 48 edge-sides, its model line); the curved case (finite `n`) is uninhabited and hypothetical by design (FS-126) |

**Empty (15)** — the class has no member; the statement holds vacuously; **do not formalize as stated**.
| id | why empty | dependents (corrected edges), and whether each inherits |
|---|---|---|
| FS116-Y3-NOQ | `C_Γ` (Y3-TIPS's setting); used by neither route of Y4-EMPTY | Y3-LENS, -STARFORCE, -TIGHTLENS, Y4-Q1, Y4-SPOKE — all inherit (same class) |
| FS116-Y3-TIGHT | `C_Γ` | Y3-LENS, Y4-Q1 — inherit |
| FS116-Y3-HUBCOL | `C_Γ` | Y3-STARFORCE, -TIGHTLENS — inherit |
| FS116-Y3-LENS | `C_Γ` | Y3-STARFORCE, -TIGHTLENS — inherit |
| FS116-Y3-NBTIP | `C_Γ` | Y3-STARFORCE, Y4-SPOKE — inherit |
| FS116-Y3-TIGHTLENS | `C_Γ` at radius `≥ √3` | Y3-STARFORCE — inherits |
| FS116-Y3-STARFORCE | `C_Γ` at radius `≥ √3` | Y4-Q1, Y4-SPOKE — inherit |
| FS116-Y4-SYM | HEX3's class | Y4-SPOKE — inherits |
| FS116-Y4-SPOKE | HEX3's class | Y4-Q1 — inherits |
| FS116-Y4-Q1 | HEX3's class | none |
| FS116-V6-ADJ | `C_Γ`; not used by Y4-EMPTY | none (its wider form, § 4.2 item 81 (2), is not derived) |
| FS116-V1-FRAME | `C_Γ` | none |
| FS116-N2-HEX6 | `C_Γ` at radius above 2 | N2-HEX3 — inherits; RING-TRANSFER-C — **inherits on its four-colour clause only** (the Γ-free hubs); its five- and six-colour clauses and STAR's partial form are inhabited (strip `P₀`, SIXFRAG) and do not |
| FS116-N2-HEX3 | `C_Γ` | none |
| FS114-N7-HUB | `C_Q` (rings (Q)-free after the bends, non-Siamese simple) — empty **given FS129-OR1-QFREE (one mind)**; its Γ-free part by Y4-EMPTY (held), as its model line says | FS114-N7-3T — inherits (OR1: N7-3T's class is empty at `1 + ε` in the non-Siamese simple class); FS116-N2-HEX6 — already empty |

**Hypothetical by design (35)** — properties of an object whose emptiness is the goal (or a step of a held second route); nothing passes on.
- *Steps of Y4-EMPTY's held routes:* FS116-Y3-SIX, -Y3-TIPS, -V6-HUBS, -V6-HUG (a case of FS129-MR1-DOUBLETIP), -V6-ANTI, -V6-COUNT.
- *V5's second routes* (V5-RING's setting drops simplicity, so its class is **not** known empty — a lead for J7's non-simple half): FS116-V5-RING, -V5-GERM,
  -V5-OUT, -V5-TIPSET, -V5-LENS; and toward FS-124's (Q)-ring cases: -V5-QCOL, -V5-OUT2, -V5-DICHO.
- *Toward S1-QF's saturated cross:* FS116-V4-OUTER (non-Siamese, simplicity not assumed).
- *FS-124 / FS-125 tools on classes not known empty:* FS116-N2-RECIP, -N2-ANTI (hubs), -N2-FIVERING (five colours), -N1-ECHO (a saturated touch point),
  -RING-Q-PRIME, -RING-Q-PRIME-S (change points on rings with (Q) arcs).
- *The NO's object (a valid map of the plane):* FS114-Y-PAIRSHARE, -NB-DUAL, -Y-REDBLOCK1.
- *FS-126 / FS-127 (curved tangent interfaces, (R2) arcs, LRA, junctions inside arcs):* FS121-D1-PENCILWIN, -V5-RAY (a contradiction lemma), -D2-EXT,
  -D1-R2CORNER, -D1-R2SMOOTH, -D1-RUNG2, -D2-THIN, -D1-FIRSTORDER, -D2-INCURVED, -DB1-L5, -O1-LRA-LINE.

### 5.2 The second list (the 16 loose-pattern `named` entries; the 2 borderline ones are sorted above)

| heading | ids |
|---|---|
| inhabited (5) | FS111-M4-LADDER (SQ9, unpinched); FS114-N114-COMPACT (the brick seven-colouring at `K = 2`, its model line); FS116-N3-SEMI (the strip's `P₀` at `P₂`, FS114-Y2-BOWTIE's centre); FS116-RING-TRANSFER-C (strip `P₀`, SIXFRAG — clause by clause; its four-colour clause inherits HEX6's emptiness, above); FS116-RING-TWIST-C (strip `P₀`, first clause; the parity clause feeds Y3-SIX, a step of Y4-EMPTY) |
| no-go (1) | FS114-N6-NOQ ("No pinwheel has a ring free of (Q) arcs") — now also a case of FS129-OR1-QFREE in the non-Siamese simple class |
| hypothetical by design (10) | FS111-C-REG-EQ, -C-SEVEN-M, -C-SIX-M, -C1-ROUTES, -VM2-EQ5, FS121-D3-EQ (conditionals whose premises are the open steps: reductions, not object classes); FS111-M4-MOVE (two hypothetical partitions); FS114-CV-EXISTS (the NO's object: its model line says the class is empty exactly when the NO holds); FS116-S1-KAPPA, -S1-PAIR (toward S1-QF; Siamese allowed, class not known empty) |

**Tally.** Main list: hypothetical 35, empty 15, no-go 4, inhabited 1 (registered 38 / 6 / 7 / 4 — "empty" under-priced: the construction side's Y3/Y4
lists were built before Y4-EMPTY, and Y4-EMPTY's routes use few of them). The one "empty" whose dependent uses a non-vacuous part is N2-HEX6 →
RING-TRANSFER-C; no non-contradiction use of an empty class reaches a result outside its own class (registered P = 0.30 that one would matter: not met,
except RING-TRANSFER-C's clause, which is in the same class).
