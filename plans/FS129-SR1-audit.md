# FS129-SR1 — pass 3 of the cross-application audit, lane R (the regularity-wall era): merges, strengthening, vacuity, the records that disagree

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-SR1-pass3.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 4, scoped first to the Lean order
(`data/fs129/index/lean-order.md`). Writes only this file, `data/fs129/sr1/`, `tools/fs129_sr1_*.py` and `data/fs129/reports/FS129-SR1.md`.
Started 2026-10-04 00:15 UTC. Planned as successive agents: this one works the named items, then the vacuity sort, then the sweep, and hands
the rest to FS129-SR2.*

## Theorems this phase proved

*Filled at each stage; see the last line of this section for the current state.*

- (none yet)

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
