# FS129-SR3 — pass 3 of the cross-application audit, lane R, last items: (Q)-ring residues, a wider V6-ADJ, item 63's unread lines, and what "simple" QFREE's chain reads

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief: `data/fs129/briefs/FS129-SR3-pass3.md`,
with its § Amendment, 2026-10-03 (commit `520b2a0c`, item (d)). Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 4. Continues
`plans/FS129-SR1-audit.md` and `plans/FS129-SR2-audit.md` and redoes nothing they saved. Writes only this file, `data/fs129/sr3/`,
`tools/fs129_sr3_*.py` and `data/fs129/reports/FS129-SR3.md`. Started 2026-10-04 01:22 UTC.*

## Theorems this phase proved

*Filled at each stage.* Every entry is **derived, one mind, kernel pending**; none moves a value or the answer's bearing.

- **FS129-SR3-E2ONE** — a pinwheel with E2 at exactly one blade and no E1 is excluded at radius `1 + ε` as if outside E2: the three available ALTs
  force the fourth pocket pair to alternate; so FS114-Y6-E2RED's survivor S6 is empty and FS114-Y5-PINALL's E2 exception narrows to E2 at two or more
  blades — derived from FS114-Y5-PINALL, FS114-Y6-E2RED — § 1.2.
- **FS129-SR3-EMPTY-NS** — FS116-Y4-EMPTY with "simple" dropped: no non-Siamese valid six-coloured fragment about a vertex of at least four
  colours has a Γ-free ring (FS116-V6's route reads no simplicity once V6-COUNT's last step is read on sectors) — hand — § 2.2.
- **FS129-SR3-QFREE-NS** — FS129-OR1-QFREE with "simple" dropped (no non-Siamese fragment of that kind has a (Q)-free ring); FS116-S1-QF is its case
  with no "simple at p" step — derived from FS129-SR3-EMPTY-NS, FS129-OR1-QFREE-CLASS — § 2.2.
- **FS129-SR3-OUTERADJ** — FS116-V6-ADJ widened, DOUBLETIP's mirror: two change points 60° apart whose outer germs off the shared arc are free of (Q)
  arcs never share their only outer colour; non-Siamese, no simplicity read — hand — § 3.

## Stage 1 — SAVED: readback, registered expectations, item (a)

### 1.0 Readback and the quotation check

**Read in full before any corpus file:** the brief and its amendment; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from `# Ephodos in
lean-dir — the workflow` to its end (`## A derivation job` and `## What leaves your lane` govern this job); `plans/STANDING-RULES.md`;
`plans/FS129-close-inventory.md` items 76–123; `plans/FS129-SR2-audit.md` §§ header, Stage 1, Stage 4.

**Quotation check** (standing rule 3), by reading each source at its address: the request (`plans/STUB-cross-application-audit.md` l. 9), decisions 1–4
and the note on roots (`plans/FS129-cross-application-audit.md` § 1), Kooshi's reading (`plans/FS129-close-inventory.md` item 32, line-wrapped there),
and the amendment's definition of **Simple** (`data/fs116/claims.md` l. 31, first line) — **all found, verbatim**. One count in the brief is off by one:
item 63's "8 unread GAP lines" are **9 lines in 8 entries** (FS111-M-PINCH carries two, ll. 442 and 447); not a defect of meaning.

### 1.1 Registered expectations

Registered at 2026-10-04 01:22 UTC, before any derivation file, grokking or statement of the items was read, and committed outside this record
(`data/fs129/sr3/expectations.md`, commit `84d57d82`) so that this stage carries a worked item and passes its gate. The table, verbatim from there:

| quantity | expectation |
|---|---|
| (a) a held result (FS129-SR1-TWOCIRC, PXKILL, G83's straddle) kills at least one of FS114-K1's (Q)-ring residues (S6, the wrap, the Reuleaux `(2, 1, 1, 0)` past `√3`) | P = 0.30 |
| (a) of the three residues, how many are killed | 0.5 (range 0–2) |
| (b) a wider V6-ADJ (outer pairs off (Q)) derived, at any scope a consumer can use | P = 0.40 |
| (b) if not derived: stalls at the outer-tile pinning, rather than at the mirror apex | P = 0.65 |
| (c) item 63's 8 lines: answered elsewhere, with no link back | 2 (range 0–4) |
| (c) answered in place | 2 (range 0–4) |
| (c) open, an open question for a named frontier stub | 4 (range 2–7) |
| (c) one of the 8 lines shows a held result false | P = 0.10 |
| merges found in this job | 2 (range 0–5) |
| hypotheses weakened, the weaker form derived as an entry | 1 (range 0–3) |
| results the vacuity lists missed | 0 (range 0–2) |
| records that disagree | 2 (range 0–4) |
| this job finds a held result false | P = 0.08 |
| this job reaches all three named items before handing back | P = 0.75 |

**Added for item (d)** at 2026-10-04 01:37 UTC, on receiving the amendment and before reading any entry of QFREE's chain: P = 0.40 that the chain reads
"simple" at `p` alone (outcome (i)); P = 0.60 that some step reads it elsewhere — at the change points or globally (outcome (ii)). Reasoning: V6's route
spends simplicity at `p` only, but DOUBLETIP-type steps read one cone per tile at ring points, and "tiles are open discs" is used to keep a tile on one
side of a blade.

### 1.2 Item (a) — G83's straddle against FS114-K1's (Q)-ring residues

**Read:** `plans/FS129-MR1-audit.md` § Stage 2 (mechanism 1, DOUBLETIP and its argument, mechanism 3a); `plans/FS129-SR1-audit.md` §§ 2.2, 3 (group 1,
TWOCIRC and its argument), 4.2; `plans/FS114-derivation.md` FS114-Y3-RSTOP, -N6-NOQ, -Y5-PINALL, -Y6-E1CAP, -Y6-E2RED, -Y6-HALF, -N7-3T, -K1, -GSD;
`plans/FS114-Y5-construction.md` header (notation), §§ 2.1–2.2, 3, 4.1, 4.3; `plans/FS114-YB5-verification.md` §§ 1a.3, 1b items 4–7 and its summary;
`plans/FS114-YB4-verification.md` items 6–12; `plans/FS114-Y3-construction.md` § 2.1; `plans/STUB-q-ring.md` ll. 25–60; `plans/FS129-OA1-audit.md` § 3.2.

**TWOCIRC first, as the brief asks.** TWOCIRC needs two tiles **of one colour** pinned to the two unit circles about a unit pair. At each residue:
- **S6** (E2 at the blade `t_{c+1}`: its side `M_c` is an arc of `ω(w_c)`, its edge `c` an arc of `ω(q_c)`, and `|q_c − w_c| = 1`). The unit pair is
  `{q_c, w_c}`; the tiles held across the two arcs are `t_c` (colour `c`) and the pocket tile `μ_c` (colour `m_c ∈ {5, 6}`): two colours. **Null.**
- **The Reuleaux `(2, 1, 1, 0)`** (FS114-Y6-HALF's frame, `t_1 = Reul(p, q1, q2)`). The unit pair is `{q1, q2}`; the tiles pinned outward at it are
  `T1` (colour 4) and `T2` (colour 2), the corner side tiles `X1`, `X2` (`{5, 6}`), and the cap tile `W` (colour 3): no two of one colour. **Null.** The
  stop at `√3` (FS114-Y3-RSTOP) is not a straddle on two circles: it is a cone argument at `q1`'s ring (N-E1, FS112-U1), whose input — `q1`'s five
  colours with the sliver `V` — HALF leaves unforced (YB5 item 7's reading).
- **The wrap** (a pocket tile wrapping round a blade's ring end). At E1CAP's `λ_3` the wrapped tile is `μ_2`, outside the ring between `r_3` and
  `e(φ_2 + 60°)`; the only other tile of its colour the chain places is `μ_4`, in the opposite pocket. No pair is pinned to two circles. **Null.**

**What does kill S6: the four pockets' parity.** E2 at one blade breaks ALT's *proof* at one pair, but not ALT's *conclusion*, which the other three ALTs
force. This is FS114-Y5-ALT applied around the cycle of the four pockets — a held result applied where it was not.

derivation: FS129-SR3-E2ONE
  statement: in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of
    length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no
    such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member
  uses only: FS114-Y5-ALT at the three pairs (μ_c, μ_{c+1}), (μ_{c+1}, μ_{c+2}), (μ_{c+2}, μ_{c+3}) — each needs only all edges below 60° and no E2 at
    t_{c+2}, t_{c+3}, t_c respectively; that each pocket colour m_j is one of the two colours absent at p (FS114-Y5-MU's setting: pocket tiles lie
    inside B(p, 1) and are not tiles of p); FS114-Y6-E2RED's chain clause (E2 at t_{c+1} breaks only ALT(μ_{c−1}, μ_c), which only POCKET at w_c reads,
    which only CASE at q_c reads — two readings, FS114-Y6's and YB5's blind one); FS114-Y5-PINALL's chain outside E1 and E2 (POCKET, CASE, REDUCE,
    PIN120-60, PXKILL), whose use of "no E2" is ALT alone (YB4 item 11, YB5 item 6)
  not claimed: E2 at two or more blades (two broken ALTs leave the parity free: plant --fault-two); E1, with or without E2 (E1 breaks MU at its edge,
    so not every pocket colour is defined, and the residues E1-Z, E1-60, E1-ν, E1{1,2}, E1{1,4} stand); E1CAP's wrap at λ_3; anything in the Siamese
    or non-simple class
  converse: one-way — a non-existence; "exactly one" is a hypothesis, not a characterization
  argument: § 1.3 Argument for FS129-SR3-E2ONE
  verdict: derived
  grade: derived from: FS114-Y5-PINALL, FS114-Y6-E2RED
  minds: 1
  model: none can exist (a non-existence, hypothetical by design); the local configuration of P_90 at radius 1 + ε, built by formula
    (`tools/fs114_y5_px.py`), meets every hypothesis but E2, and no held object has E2 at a blade; the parity and S6's death under CASE are control
    fs129-sr3-e2one
  prior art: owed — an in-house composition (ALT, three times, around the four-cycle of pockets); the pinwheel exclusion's own prior art is FS-114's
    gate ("ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0))
  handoff: de Bruijn — the parity step as a corollary of ALT at three pairs; with it FS114-Y5-PINALL is formalized with the exception "E1, or E2 at two
    or more blades", and S6 leaves FS114-K1's case list

control: fs129-sr3-e2one
  of: FS129-SR3-E2ONE — the parity on all 64 colourings of the four pockets for each broken pair, and S6 killed by CASE at q_c on a grid of b
  run: python3 ../tools/fs129_sr3_e2one.py
  expect: e2one: parity ok; F2 ok
  fault: python3 ../tools/fs129_sr3_e2one.py --fault-two

control: fs129-sr3-e2one-case
  of: FS129-SR3-E2ONE — CASE at q_c reads the neighbour a_{c−1} = 120°, not a_{c+1}
  run: python3 ../tools/fs129_sr3_e2one.py
  expect: e2one: parity ok; F2 ok
  fault: python3 ../tools/fs129_sr3_e2one.py --fault-case

### 1.3 Argument for FS129-SR3-E2ONE

Index the blades and pockets mod 4 as FS114-Y5 does: pocket `Π_{j+1}` lies between `t_{j+1}`'s side `M_j` and `t_{j+2}`'s side `L_{j+1}`; `μ_j` (colour
`m_j`) borders `M_j`. With no E1 every edge at `p` is below `60°`, so FS114-Y5-MU holds at every blade (`w_{j+1} ∈ cl μ_j`) and every `m_j` is defined;
each `m_j` is `5` or `6`, the colours absent at `p`, since `μ_j` meets `B(p, 1)` and is not a tile of `p`.
1. *Three ALTs.* FS114-Y5-ALT gives `m_j ≠ m_{j+1}` unless E2 holds at `t_{j+2}`. E2 holds at `t_{c+1}` alone, so ALT holds at `j = c, c + 1, c + 2`:
   `m_c ≠ m_{c+1} ≠ m_{c+2} ≠ m_{c+3}`.
2. *Parity.* Two colours alternate along the path `c, c + 1, c + 2, c + 3`, so `m_{c+3} = m_{c+1} ≠ m_c`. As `c + 3 ≡ c − 1`, **`m_{c−1} ≠ m_c`** —
   ALT's conclusion at the one pair whose proof E2 broke (control `fs129-sr3-e2one`; with only two pairs it fails, the plant).
3. *The chain resumes.* FS114-Y5-POCKET at `w_c` reads only that conclusion: the pocket tile next to `t_c` is `μ_{c−1}` and the one next to `t_{c+1}` is
   `Λ_c`, of colour `m̄_c`; if they differed, `m_{c−1} = m_c`; so `μ_{c−1} = Λ_c`. FS114-Y5-CASE at `q_c` reads only POCKET at `w_c` (FS114-Y6-E2RED's
   chain clause, and YB5 item 6: "ALT(`μ_{c−1}`, `μ_c`) is read by POCKET at `w_c` only, POCKET at `w_c` by CASE at `q_c` only; MU, RAINBOW, SEP,
   REGION, U1 and the other ALTs read no E2"). So CASE holds at all four centres, and FS114-Y5-PINALL's chain — REDUCE, PIN120-60, PXKILL — runs as
   outside E2: no such pinwheel at `1 + ε`. YB5's worry for this case, a full wrap of `Λ_c` round `r_c` to `q_c`, is now a wrap of `μ_{c−1}`, which
   gives `μ_{c−1} ∋ q_{c−1}, q_c` and so `α_c = 60°` (FS114-YB4 § 2.2 row 6), as outside E2.
4. *S6.* In S6 (YB5's F2) the cones are `α_c = 180° − b`, `α_{c+1} = b`, `α_{c+2} = 60°`, `α_{c+3} = α_{c−1} = 120°`, with `60° < b < 120°`. CASE at `q_c`
   asks `α_c = 60°` (false) or `α_{c−1} + α_c = 300° − b ≤ 180°` (false). Empty (control `fs129-sr3-e2one-case`). ∎

*Look-back.* Could it have been foreseen? Yes: FS114-Y5-PX already states "the pocket colours alternate (ALT): `m_1 = m_3 ≠ m_2 = m_4`", a four-cycle;
E2RED's and PIN120's exceptions were each read off one ALT's proof rather than off the cycle. Does it deform? With E2 at two blades the parity is free
(plant); with E1 the pockets' colours are not all defined. **Consequences for the records** (corrections drafted for FS129-Z2, never edits here):
FS114-Y5-PINALL's exception "E1 or E2" narrows to "E1, or E2 at two or more blades"; FS114-Y5-PIN120's "unless E2 holds at the blade two past the
120° tile" narrows to that E2 together with E1 or with E2 at a second blade (with E1 the parity is not available); FS114-Y6-E2RED's survivor S6 is empty,
so its *not claimed* "that S6 exists or dies" is answered, and its "full wrap of `Λ_c`" GAP closes in the one-blade case; FS114-K1's list loses "E2's
survivor S6" and the wrap's E2RED site.

**Item (a), the verdicts.**
- **S6: killed** — by FS129-SR3-E2ONE (FS114-Y5-ALT's parity), not by TWOCIRC, which is null there.
- **The wrap: one site of three closed.** Y5-PX's `λ` site is moot already (PXKILL holds with or without the wrap: YB4 item 10); E2RED's full wrap closes
  with S6 (step 3); **E1CAP's `λ_3` site stands**, an E1 residue: TWOCIRC is null there.
- **The Reuleaux `(2, 1, 1, 0)` past `√3`: not killed**; TWOCIRC null. One observation, from held statements alone: under HALF's hypotheses (`t_2`'s cone
  above `60°`, `t_4`'s at least `60°`) the ring arc from `q2` to `q1` is a side of `t_1` with `W` outside, and `W` has the colour of `t_3` (FS114-Y4-W, as
  HALF re-derives it); both side colours are carried at `p`, which has four colours, so **that arc is a (Q) arc**. Every Reuleaux `(2, 1, 1, 0)` in HALF's
  class therefore has a (Q) ring, FS114-N7-3T's (Q)-free exclusion never reached it, and FS114-K1's residue "the Reuleaux `(2, 1, 1, 0)` on rings with (Q)
  arcs" is the whole HALF class — a line for FS-124's case 6, not an entry (it restates HALF and the definition of (Q)).

## Stage 2 — SAVED: item (d) — what "simple" FS129-OR1-QFREE's chain reads

**Read:** `plans/FS129-OR1-audit.md` § J1 (FS129-OR1-WHOLE, -BENDFRAG, -QFREE-CLASS, -QFREE, their arguments); `plans/FS129-SR1-audit.md` § 3.3
(FS129-SR1-BENDANY, -BENDLE3); `plans/FS129-SR2-audit.md` FS129-SR2-QFCASE and § 3.2.2; `plans/FS116-derivation.md` FS116-Y4-FLANK, -Y4-EMPTY, -V6-HUBS,
-V6-HUG, -V6-COUNT, -V6-ANTI, -V6-ADJ, -V4-DICHOTOMY, -V5-NE1, -RING-GERM, and the statements and `uses only:` lines of -Y3-SIX, -Y3-TIPS, -N2-STAR;
`plans/FS116-V6-verification.md` §§ 1.2, 2.2, 2.3 in full; `plans/FS116-Y4-construction.md` § 3.2 in full; `data/fs116/claims.md` § 0's **Simple** and the
notation paragraph (l. 183: "**Simple**: § 0's; a tile's cone at a vertex is one closed interval of directions").

### 2.1 Step by step

"Simple" (global, `data/fs116/claims.md` § 0) is used, if at all, in one of two local forms: **at `p`** (one sector per tile of `p`) or **at a ring point**
(one cone per tile at a change point). For each step of the chain:

| step | where it reads "simple" | how read |
|---|---|---|
| FS129-OR1-WHOLE | nowhere in its validity, non-Siamese or no-witness clauses; its clause "simple if `F` is" only *keeps* the property (closures unchanged) | the argument, steps 1–3 |
| FS129-OR1-BENDFRAG / FS129-SR1-BENDANY | nowhere in validity (N2-TOWARD, N2-AWAY read on a fragment: tiles near `α`, `P`, `R₂(ᾱ)`), nor in keeping non-Siamese (V4-DICHOTOMY); the clause "simple if `F` is" only keeps it (the crescent). Every tile of `p` and its cone at `p` are unchanged: WHOLE keeps the tiles at `p` with their closures, and each bend changes a tile only inside a thin lens along a ring arc, near radius 1 (BENDANY's statement says so) | the arguments; BENDANY's locality clause |
| FS129-OR1-QFREE-CLASS | nowhere: it is stated for all four classes, non-Siamese-only among them | statement and argument |
| FS116-V4-DICHOTOMY, FS116-V5-NE1 (WHOLE's inputs) | nowhere | `uses only:` lines |
| FS116-Y4-EMPTY, **Y4's own route** | **at `p`** in FS116-Y3-SIX ("non-Siamese and simple (four tiles)") and FS116-Y3-TIPS ("two tiles adjacent at `p` share a non-degenerate boundary curve from `p`"), by their `uses only:` lines; **at the double-tipped hub `y_k`** in EMPTY's own step "a cone (an interval) holding `ψ_k + 90°` and `ψ_k + 210°` contains the tip's cone … or the outer cone" (`plans/FS116-Y4-construction.md` § 3.2) — the identification of the flank tile `a` with the ring tile `R′`. RING-GERM, FLANK and N2-STAR read none | § 3.2 in full; SIX's and TIPS's arguments not opened |
| FS116-Y4-EMPTY, **FS116-V6's route** | V6's own `uses only:` says "simple … — V6-COUNT's last step only", at `p`. Re-read here step by step: V6-RING, -WIN, -GERM, -TIP, -HUBS, -ANTI read none; **V6-HUG reads none** — its "sector at `y_0`" of the only tip `T` ends at `210°` whatever `T`'s other sectors (all of `T`'s directions lie in `[30°, 210°]` since `T ⊂ B̄(y_1)`; no other tile has a sector, even of zero angle, inside `(150°, 210°)`, or it would be a second tip by V6-TIP's argument), and the tile `R⁻` after it is identified **by colour through V6-GERM**, not by a cone interval; **V6-COUNT** reads none up to its last step | `plans/FS116-V6-verification.md` § 2.2 in full |
| **V6-COUNT's last step** | V6 reads it as "one sector per tile: simple", to form a 4-cycle of shared edges at `p`. **It needs no simplicity**: the four tiles of `p` split into the two tippers of `y_k` and the two of `y_{k+3}` (disjoint, since `B̄(y_k) ∩ B̄(y_{k+3}) = {p}`); every tile of `p` owns at least one sector at `p` (local finiteness: a small disc about `p` minus the edges through `p` is finitely many curvilinear sectors, each inside one tile); so in the cyclic order of sectors some sector of one group is followed by a sector of the other, and the two tiles share the edge between them — against V6-ANTI | control `fs129-sr3-simple` |

So **outcome (i), and more**: on V6's route the whole chain reads "simple" nowhere — not even at `p`. On Y4's own route it reads it at `p` and at a hub. The
weakening the amendment asks for (QFREE with "simple at `p`") holds, and so does the stronger one with "simple" dropped; both are filed as one entry each,
the stronger.

### 2.2 The entries

derivation: FS129-SR3-EMPTY-NS
  statement: no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying
    no arc of Γ
  uses only: FS116-V6's route to FS116-Y4-EMPTY (`plans/FS116-V6-verification.md` § 2.2) — V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP,
    V6-HUBS, V6-HUG (its colour step through V6-GERM), V6-ANTI and V6-COUNT's count — none of which reads simplicity (§ 2.1); V6-COUNT's last step read on
    sectors: every tile of p owns a sector at p, and two cyclically consecutive sectors of the two tipper groups share an edge, against V6-ANTI
  not claimed: anything in the Siamese class (V6-RING's one tile per colour at p, V6-TIP's tip and V6-HUG's uniqueness of the tip and of R⁻, R⁺ read
    non-Siamese); anything at k ≥ 7 (V6-RING and V6-TIP spend six); that FS116-Y4's own route carries the non-simple class (it reads one cone per tile at
    a double-tipped hub)
  converse: one-way — a non-existence
  argument: § 2.1 Step by step
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence); with the ring condition dropped the class is inhabited — FS114-Y2-BOWTIE, non-Siamese, about a degree-4
    vertex of four colours, its ring carrying two (Q) arcs; the count and the sector step are control fs129-sr3-simple
  prior art: partly: FS116-Y4-EMPTY (held, two routes, the simple class); FS116-V6 left the non-simple class undecided ("whether the conclusion survives
    without them I did not decide", `plans/FS116-V6-verification.md` § 2.3 item 4); no outside search — owed
  handoff: de Bruijn — in place of FS116-Y4-EMPTY, on V6's route: V6-HUG's own colour step (V6-GERM, the Γ-free ring's germs all off Γ), not
    FS129-MR1-DOUBLETIP's cone step, and V6-COUNT's last step on sectors as here

control: fs129-sr3-simple
  of: FS129-SR3-EMPTY-NS — V6-COUNT's count (three antipodal two-path patterns, disjoint tipper groups) and its last step on sectors, any number per tile
  run: python3 ../tools/fs129_sr3_simple.py
  expect: simple: count ok; sectors ok
  fault: python3 ../tools/fs129_sr3_simple.py --fault-sector

control: fs129-sr3-simple-hug
  of: FS129-SR3-EMPTY-NS — the count reads V6-HUG: without it single-edge paths survive
  run: python3 ../tools/fs129_sr3_simple.py
  expect: simple: count ok; sectors ok
  fault: python3 ../tools/fs129_sr3_simple.py --fault-hug

derivation: FS129-SR3-QFREE-NS
  statement: no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying
    no (Q) arc
  uses only: FS129-SR3-EMPTY-NS (for every r > 1); FS129-OR1-QFREE-CLASS at the class of non-Siamese fragments, through FS129-OR1-BENDFRAG (or
    FS129-SR1-BENDANY), whose fragment keeps non-Siamese, p's colours and its tiles at p, and whose validity reads no simplicity (§ 2.1)
  not claimed: anything in the Siamese class (FS-123's question 3); anything at k ≥ 7; anything for rings that carry a (Q) arc (FS-124); that a vertex
    with a (Q) ring dies at any radius
  converse: one-way — a non-existence
  argument: FS129-OR1-audit.md § Argument for FS129-OR1-QFREE-CLASS
  verdict: derived
  grade: derived from: FS129-SR3-EMPTY-NS, FS129-OR1-QFREE-CLASS
  minds: 1
  model: FS114-Y2-BOWTIE, non-Siamese, on B̄(p, 3√3/5) about a degree-4 vertex of four colours — its ring carries two (Q) arcs, so the class is inhabited
    and the statement's alternative holds there
  prior art: owed — in-house
  handoff: de Bruijn — in place of FS129-OR1-QFREE (it drops "simple"), over FS129-SR3-EMPTY-NS and FS129-SR1-BENDANY; FS116-S1-QF is then its case
    with no "simple at p" step

### 2.3 What it does to the records (drafted for FS129-Z2; nothing here edits them)

- **FS129-SR2-QFCASE stands**, and needs less than its argument says: S1-QF's class (non-Siamese, not assumed simple) lies inside FS129-SR3-QFREE-NS's,
  so the step "the fragment is simple at `p`" (`plans/FS129-SR2-audit.md` § 3.2.2) is idle; its `uses only:` should read FS129-SR3-QFREE-NS in place of
  FS129-OR1-QFREE. The record job's defect (the amendment) is real as a gloss — FS-116's "simple" is global — and harmless to the conclusion.
- **Item 117's correction ("S1-QF has no non-simple remainder") stands.** SR2's line for FS129-L1, "formalize QFREE in place of S1-QF", becomes
  "formalize FS129-SR3-QFREE-NS in place of FS116-S1-QF and FS129-OR1-QFREE".
- **The non-simple class of FS-123 and FS-124's case 7 shrinks**: for (Q)-free rings it is closed in the non-Siamese class; what stays open there is the
  Siamese class. FS129-OR1-QFREE's *not claimed* "the Siamese or non-simple classes" and FS116-C114-LOCAL-F's Γ-free line ("the non-Siamese simple class")
  narrow accordingly.
- **A caution for the backlog, against SR1's list item 2** (`plans/FS129-SR1-audit.md` § 6.2: "FS129-MR1-DOUBLETIP in place of FS116-V6-HUG (and of
  FS116-Y4-EMPTY's double-tip step on route 2)"): DOUBLETIP identifies its flank tile by a cone interval at `y` and `y′` (its step 3: "`R`'s cone — one
  interval (simple)"), so an EMPTY formalized through DOUBLETIP needs simplicity at the hubs and does not give FS129-SR3-EMPTY-NS. V6-HUG's own step (by
  colour, through V6-GERM) does. Formalize V6-HUG's argument for the Γ-free ring, and DOUBLETIP for the wider ring classes it serves.

## Stage 3 — SAVED: item (b) — a wider V6-ADJ, DOUBLETIP's mirror on the outer side

**Read:** `plans/FS116-derivation.md` FS116-V6-ADJ, -V6-HUG, -RING-GERM, -N1-GERM-R, -N2-STAR; `plans/FS116-V6-verification.md` §§ 2.2 (V6-GERM,
V6-HUG), 2.3 item 2 (the adjacency rule); `plans/FS129-MR1-audit.md` § Mechanism 1 (DOUBLETIP, the model) and § Mechanism 3a; `plans/FS129-SR1-audit.md`
§ 3.1 (TWOCIRC, whose last line names V6-ADJ's arcs "the same statement for the apex `p′ = y₀ + y₁ − p` of the other Reuleaux triangle");
`data/fs116/claims.md` l. 183 (outer tile, outer pair `{u⁻, v⁺}`, tip pair `{v⁻, u⁺}`).

**What V6-ADJ carries.** Its `uses only:` is V6-DICH and the identity with both arcs run outward; its class (a Γ-free ring) is never read, and its
"hug" is a hypothesis. So as stated it is TWOCIRC at the mirror apex plus non-Siamese, at any two points 1 apart — and, its class being empty
(FS116-Y4-EMPTY), SR1 listed it "do not formalize as stated". The wider form must *derive* the hugging. DOUBLETIP's shape transfers: there a sole
shared tip fills both tip cones (RING-GERM (i)) and is pinned by the diameter bound; here a sole outer colour fills both outer cones (RING-GERM (ii)),
its two tiles are distinct and so pinned out of each other's point's disc, and the tiles beyond them are pinned in by the ring's germs. The mirror of
"one tile" is "one colour, two tiles": one tile cannot fill both outer cones (they face apart: check 1a below).

derivation: FS129-SR3-OUTERADJ
  statement: in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and
    y′ = r(ψ + 60°) be change points of the ring such that neither the arc of ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of
    r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once the only colour carried at y by a tile that is not a tile of p and the only colour
    carried at y′ by a tile that is not a tile of p
  uses only: FS116-RING-GERM (ii) at y (outer pair u⁻, v⁺) and at y′ (u′⁻, v′⁺) — u⁻ (the ring just clockwise of y′) and v′⁺ (just counter-clockwise
    of y) are off Γ because y′ and y are change points, the other two by hypothesis — and its first clause (p has four colours, X and X̄ absent);
    V6-GERM's neighbourhood form at y from the germs u⁻ (colour X) and u⁺ (colour X̄), and at y′ from v′⁺ (X) and v′⁻ (X̄), all off Γ (the argument of
    FS116-N1-GERM-R, which reads only N-E1 and the germs' colours); the germs' colours from validity (ring points 60° apart differ, two absent colours);
    non-Siamese (one tile per colour at a point; distinct tiles of one colour have no closure points below 1 apart, FS116-V4-DICHOTOMY); the diameter
    bound; FS129-SR1-TWOCIRC at the mirror apex y + y′ − p; six colours, spent in RING-GERM and in the colour of the tile beyond the outer tile
  not claimed: anything when y or y′ carries two or more outer colours (the tile beyond the outer tile may then be outer and unpinned: tangent segments
    stay exactly 1 apart, plant --fault-tangent); anything when the arc just counter-clockwise of r(ψ − 60°) or just clockwise of r(ψ + 120°) lies on a
    (Q) arc (RING-GERM (ii) is then unavailable); the Siamese class; anything at k ≥ 7 (a third absent colour leaves the tile beyond unpinned, plant
    --fault-seven); that y or y′ has a single tip
  converse: one-way — a non-existence; "the only" names the hypothesis, not a characterization
  argument: § 3.1 Argument for FS129-SR3-OUTERADJ
  verdict: derived
  grade: hand
  minds: 1
  model: none can exist (a non-existence, hypothetical by design); the hypotheses without the shared colour are met at a four-colour hub whose neighbour
    has another outer colour — no held fragment has two change points 60° apart (as for DOUBLETIP); FS116-V6's stage-1 candidate (outer colours 2, 3 at
    y_0 and 2 at y_1, `plans/FS116-V6-verification.md` § 2.3 item 1) shows the rule at work: its builder gave y_0 a second outer colour because of it
  prior art: owed — an in-house composition; its last step is FS116-V6-ADJ's and FS114-Y5-PXKILL's mechanism (G83's straddle), unsearched outside
  handoff: de Bruijn — the statement and its not claimed, over RING-GERM (ii), V6-GERM's neighbourhood form and TWOCIRC; it carries FS116-V6-ADJ's
    argument as its last step, so V6-ADJ is formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair) or
    not at all

control: fs129-sr3-outeradj
  of: FS129-SR3-OUTERADJ — the cone facts at y and y′ (interval arithmetic), the colour step, and the mirror arcs below 1 (identity exact, grid by intervals)
  run: python3 ../tools/fs129_sr3_outeradj.py
  expect: outeradj: cones ok; colour ok; arcs ok
  fault: python3 ../tools/fs129_sr3_outeradj.py --fault-tangent

control: fs129-sr3-outeradj-seven
  of: FS129-SR3-OUTERADJ — the colour step spends six: with a third absent colour the tile beyond the outer tile is not forced to be X
  run: python3 ../tools/fs129_sr3_outeradj.py
  expect: outeradj: cones ok; colour ok; arcs ok
  fault: python3 ../tools/fs129_sr3_outeradj.py --fault-seven

### 3.1 Argument for FS129-SR3-OUTERADJ

Put `ψ = 0`: `p = 0`, `y = e(0°)`, `y′ = e(60°)`, `p′ = y + y′`. By RING-GERM `p` has four colours, `X`, `X̄` absent; `X` is the ring colour just
counter-clockwise of `y` and `X̄` just clockwise. The germs just clockwise and just counter-clockwise of `y′` are off `Γ` (a change point) and `60°` from
those of `y`, so they carry `X` and `X̄` respectively (ring points `60°` apart are 1 apart, and only two colours are absent). Suppose `o` is the only
outer colour at `y` and at `y′`.
1. *Two tiles.* RING-GERM (ii) at `y` (its outer pair: `u⁻` off `Γ`, `v⁺` by hypothesis) puts every direction of `(−30°, 30°)` in the cone of an outer
   tile; all have colour `o`, and one tile of each colour is at `y`: one tile `O`. Likewise one tile `O′` of colour `o` fills `(30°, 90°)` at `y′`. The
   points `y + s e(θ)`, `θ ∈ (−30°, 30°)`, lie outside `B̄(y′)` (`|y + s e(θ) − y′|² = 1 + s² − 2s cos(θ − 120°) > 1`; check 1a), so `O ⊄ B̄(y′)` and
   `O ≠ O′` (a tile holding `y′` lies in `B̄(y′)`). Non-Siamese: `O` misses `B(y′)` and `O′` misses `B(y)`.
2. *The outer tiles end at the lens arcs.* `O`'s directions at `y` lie where `y + s e(θ)` stays out of `B(y′)`, the closed range `[−150°, 30°]`; the
   sector of `O` holding the directions just below `30°` therefore ends at `30°`. Let `N` be the tile whose sector follows it counter-clockwise. Its points
   `y + s e(30° + η)` lie in `B(y′)` and outside `B̄(p)` (check 1b), so `N ≠ O`, `N` is not a tile of `p` (a tile of `p` lies in `B̄(p)`), its colour is
   not `o`, and not another colour of `p` (that would be a second outer colour at `y`); not `X̄` (V6-GERM from `u⁺`: `X̄`-tiles near `y` avoid `B(y′)`).
   So `N` has colour `X`, and near `y` the `X`-tiles lie in `B̄(y′)` (V6-GERM from `u⁻`). The common boundary of `O` and `N` leaving `y` lies in
   `cl O ∩ cl N ⊆ (ℝ² ∖ B(y′)) ∩ B̄(y′) = ω(y′)`: `cl O` holds an arc of `ω(y′)` from `y`, leaving in direction `30°` — toward `p′`. At `y′`, with the roles
   turned: `O′`'s sector ends at `30°` clockwise; the tile `N′` before it has points `y′ + s e(30° − η)` in `B(y)` and outside `B̄(p)` (check 1c); it is not
   `X̄` (V6-GERM from `v′⁻`, the ring just clockwise of `y`: `X̄`-tiles near `y′` avoid `B(y)`), so it is `X`, which near `y′` lies in `B̄(y)` (from `v′⁺`);
   `cl O′` holds an arc of `ω(y)` from `y′` toward `p′`.
3. *The straddle at the mirror apex.* With `a(s) = y + e(120° − s)` (on `ω(y)` from `y′` toward `p′`) and `b(t) = y′ + e(t − 60°)` (on `ω(y′)` from `y`
   toward `p′`), FS129-SR1-TWOCIRC gives `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) < 0` for small `s, t > 0` (check 3). So `cl O′` and `cl O`
   hold points below 1 apart, and FS116-V4-DICHOTOMY makes the distinct tiles `O`, `O′` of colour `o` near — against non-Siamese. ∎

No step reads "simple": every identification is by colour and disc, none by a cone interval (contrast DOUBLETIP's step 3). *Look-back.* Foreseeable from
TWOCIRC's last line; it is the outer-side twin of DOUBLETIP, with RING-GERM's two pairs exchanged. In FS-124's terms (its recurrence: a hub of four colours
carries `X`, `X̄`, one tip colour and one outer colour), **two adjacent four-colour hubs whose outer germs off the shared arc are free carry different
outer colours** — and, by DOUBLETIP (its tip germs free), different tips. A pruning rule for case 5's ring types; a line for FS129-Z2's bearing on
`plans/STUB-q-ring.md`.

## Stage 4 — SAVED: item (c) — item 63's unread GAP lines; the vacuity sort; the records that disagree

### 4.1 Item 63's nine lines (8 entries)

**The list's file is the faulted one.** `data/fs129/sr2/item63-gap-lines.md`, as committed, holds 31 rows with ids shifted by one entry (e.g. l. 442 under
FS111-M-C11): `tools/fs129_sr2_gaps.py --fault` writes the same output file, and the derive gate runs the fault last. The clean list — SR2's § 4.1 table —
is regenerated here by SR2's tool with its output redirected and no fault: `data/fs129/sr3/item63-gap-lines-clean.md` (27 lines in 24 entries). A tool
defect for FS129-Z2; SR2's tool is not mine to edit.

**Read:** each line in its entry, and `plans/FS111-derivation.md` FS111-M-R7, -M-PINCH, -M-C11, -W-NOREP and its correction, -W-HULLREG-MAPS, -M-EXTREME,
-M-COVER-SC, -M-HALF, -M2-INT, -M2-FIX, -M3-IRREG; `data/fs121/claims.md` § 0 (saturated, honest, (H1), (H2), Σ, REG-J′); `plans/FS121-derivation.md`
FS121-DB1-L3, -DB1-L4, -D1-VT, -V2-VT-W; `plans/FS111-VM2-verification.md` § 1.4 (O2), § 2.2; `plans/STUB-pinch-at-junction.md` ll. 28–39;
`plans/STUB-lateral-extent.md` ll. 1–20; `plans/FS112-derivation.md` FS112-SIX, -N3-PAIRS; `plans/FS112-NB-verification.md` l. 205; `plans/FS116-derivation.md`
FS116-N2-SIXRING, -S1-KAPPA; `plans/FS114-derivation.md` FS114-Y3-RSTOP, -Y4-RSTOPALL, -BV-HEX; `plans/FS114-YB2-verification.md` ll. 150–152, 206–207;
`plans/FS129-OR1-audit.md` § J22.

| line | entry | the GAP | class | where |
|---|---|---|---|---|
| FS111 l. 442 | FS111-M-PINCH | "the same without (H1) or (H2) (C-HULL-REG as stated is a GAP there); anything at points of the singular set Σ" | **answered elsewhere, no link back** — as a general form it is **false**: FS111-M-EXTREME (same file) shows M-PINCH's conclusion fails at the extreme points of every component of an honest saturated colouring, each a cusp or a point where (H1) or (H2) fails, and FS111-M-R7 is such a colouring (saturated, "every essential boundary point is a contact point for each of its colours"; its up-vertices are M-EXTREME's model). What does hold at Σ, under REG-J′, is FS121-DB1-L3 (no colour occupies two sectors of positive angle). Without REG-J′ the structure at Σ is FS-127's question (lateral extent) | M-PINCH's *not claimed* should point to M-EXTREME (the counterexample to the unhypothesized form) and to DB1-L3 |
| FS111 l. 447 | FS111-M-PINCH | VMW's "stage-1 GAP at cusp partners" | **answered in place** — the same line records it "withdrawn on reading M's Step 1" | — |
| FS111 l. 853 | FS111-M2-INT | "the same for the interior of the support F of a set with null unit pairs (a GAP under the topological reading of 'regular', VM2 (O2))" | **open**. FS111-M2-FIX (next entry) proves it for regular MUA sets; VM2 (O2) knows no counterexample. **FS111-M3-IRREG does not refute it**: the set maximality must add to `A_f` is nowhere dense, so it adds nothing to `int F`, and its points' unit circles meet the class only at pinch points, boundary points of `F` — no interior point of the support is placed at distance 1 from the support. Its maximal-set form is FS-120's question 3 ("(F1) for irregular MUA sets") | `plans/STUB-pinch-at-junction.md` ll. 38–39 |
| FS112 l. 49 | FS112-SIX | "De Grey's covering step for C-V56 ('those six tiles must jointly cover a disk of radius 1') is a GAP" | **answered elsewhere, no link back, in the non-Siamese class**: a tile meeting `B(V, 1)` of a colour carried at `V` is within 1 of `V`'s tile of that colour, so it is that tile (FS116-V4-DICHOTOMY); FS-112's own NB reduced the step to exactly that (`plans/FS112-NB-verification.md` l. 205: "exactly 'no Siamese partner of a tile at `V` lies in `B(V, 1)`'"), and FS116-N2-SIXRING (non-Siamese) carries the six-colour picture. **Open in the Siamese class** — FS-124's case 7 | FS112-SIX's entry should cite NB l. 205 and FS116-N2-SIXRING |
| FS112 l. 165 | FS112-N3-PAIRS | NB3-I's "GAP there" (at mutual both-centres) | **answered in place** — "retracted at stage 2" in the same line | — |
| FS114 l. 968 | FS114-BV-HEX | "Lemma 4 at cusps (not landed: a GAP in BASE-V's blind derivation at Prop. 19(b) and the selection; CUSP-BASE's D5 items 1–4, 6 stay at CE's one mind)" | **open — an owed second mind, not a frontier question**: FS129-OR1 § J22 found no held second route; every route-M stub names it in its owed-minds line ("row 134's base, Lemma 4 at cusps (BASE-V), before any publication", `plans/STUB-qfree-ring.md` l. 101). Under Workflow 3.1 the kernel module for row 134's base is the promotion path | the Lean backlog |
| FS114 l. 607 | FS114-Y3-RSTOP | "Y3-D2 without reading R-T (a GAP at one case: YB2)" — YB2's case: an `x`-invariant colour-4 tile spanning `top`'s outside when the edges at `p` need not be tactic | **open, unplaced**: FS114-Y4-RSTOPALL also reads R-T ("the bowtie's definition with reading R-T"); FS114-K1's list reads tactic edges. No held result reads a Reuleaux bowtie with a non-tactic edge. Whether FS-112's bends remove it first (a non-tactic unit edge at `p` has its outer colour absent at its centre, so FS112-N2-BENDS bends it) is not read here | a stub line for FS129-Z2: FS-124's case 6, or FS-117 if the count pays it |
| FS116 l. 816 | FS116-S1-KAPPA | its last clause ("in a non-Siamese fragment κ's change points are exactly `y + 60°ℤ`") "Under § 10's ring change points … GAP at whether an orbit point can end an arc of Γ on ω(p)" | **answered elsewhere, by this job**: the clause's class — non-Siamese, six colours, a vertex of four colours, a ring with no (Q) arc, radius above 1 — is **empty** by FS129-SR3-QFREE-NS (§ 2.2; FS129-OR1-QFREE did not reach it, KAPPA assuming no simplicity). The GAP is moot | KAPPA's last clause stands as a step of FS116-S1-QF's second route only |
| FS121 l. 263 | FS121-D1-VT | "TRUE under reading (W), GAP under (B)" at a corner of `L` | **answered in place** — the same paragraph names the wider statement, FS121-V2-VT-W, which carries the corner (two branches meeting at `Y`) | — |

**Tally:** answered elsewhere with no link back **3** (M-PINCH l. 442, FS112-SIX, S1-KAPPA); answered in place **3** (M-PINCH l. 447, N3-PAIRS, D1-VT); open **3**
(M2-INT — FS-120 q. 3; BV-HEX — an owed mind; Y3-RSTOP's R-T case — unplaced). **No held result is shown false**: l. 442's false form is a *not claimed*
form, and M3-IRREG does not touch M2-INT.

### 4.2 The vacuity sort: additions (item 36's four headings)

**No new "empty" result.** One receipt changes: SR1's classes `C_Γ` and `C_Q` (`plans/FS129-SR1-audit.md` § 5's rule) were the non-Siamese **simple**
classes; by FS129-SR3-EMPTY-NS and -QFREE-NS (one mind each) both are empty with "simple" dropped. So the results SR1 filed under "class not known
empty" because they drop simplicity — V5's second routes in V5-RING's setting (FS116-V5-RING, -V5-GERM, -V5-OUT, -V5-TIPSET; non-Siamese, Γ-free ring, no simplicity) and FS116-V4-OUTER (non-Siamese, (Q)-free ring, no simplicity) — and the last clause
of FS116-S1-KAPPA are now over empty classes; each is a step of a held no-go's route (Y3-SIX's or S1-QF's), so each stays **hypothetical by design**, and
nothing passes on. SR1's lead "V5-RING's setting drops simplicity … a lead for J7's non-simple half" is spent: J7's non-simple half, for (Q)-free rings,
is closed by FS129-SR3-QFREE-NS; the Siamese half stays open.

### 4.3 Records that disagree

Each quoted with its address; the argument's verdict beside it; corrections drafted for FS129-Z2, no record edited.

| # | record A | record B | which the argument supports |
|---|---|---|---|
| 1 | `plans/FS129-SR2-audit.md` § 3.2.2: "the fragment is simple at `p` (FS-116's 'simple': one sector per tile at `p`)" | `data/fs116/claims.md` l. 31: "**Simple** … every tile an open disc whose closure meets each other tile's closure in a connected set or not at …" | B defines the word; A's gloss is wrong as a gloss and **idle** as a step: QFCASE stands through FS129-SR3-QFREE-NS (§ 2.3) |
| 2 | `plans/FS116-V6-verification.md` § 2.2 (Uses only): "simple (one sector per tile at `p`, so the four tiles form a 4-cycle of shared edges — V6-COUNT's last step only)" | this record § 2.1 | the step needs no simplicity: any cyclic order of sectors containing both tipper groups has an edge between the groups (control `fs129-sr3-simple`) |
| 3 | `plans/FS129-SR1-audit.md` § 6.2 item 2: "FS129-MR1-DOUBLETIP in place of FS116-V6-HUG (and of FS116-Y4-EMPTY's double-tip step on route 2)" | this record § 2.3 | both are true theorems; the plan in A would formalize EMPTY only in the simple class (DOUBLETIP's step 3 reads a cone interval at the hubs). Keep V6-HUG's colour step for EMPTY-NS |
| 4 | `plans/FS114-derivation.md` FS114-Y5-PINALL: "except possibly under E1 … or E2"; FS114-Y6-E2RED: "**the only E2 survivor family is S6**"; FS114-K1: "E2's survivor S6" | this record § 1.2 (FS129-SR3-E2ONE) | E2 at a single blade (no E1) is no exception and S6 is empty; the records' exceptions narrow to E1, or E2 at two or more blades |
| 5 | `data/fs129/sr2/item63-gap-lines.md` (committed: 31 rows, ids shifted) | `plans/FS129-SR2-audit.md` § 4.1 (27 lines in 24 entries) | B; A is the fault run's output (§ 4.1). The clean list is `data/fs129/sr3/item63-gap-lines-clean.md` |

## Stage 5 — SAVED: additions to the list for FS129-L1; expectations scored; hand-back

### 5.1 Additions to the list for FS129-L1 (the Lean backlog's input; brief § Done means 5)

Read with `plans/FS129-SR1-audit.md` § 6.2 and `plans/FS129-SR2-audit.md` § 4.3, which stand except where item 25 below amends SR1's item 2. Numbering
continues SR2's.

**Formalize X in place of A, B, C:**

23. **FS129-SR3-QFREE-NS** in place of **FS129-OR1-QFREE** and **FS116-S1-QF** — S1-QF is its direct case (non-Siamese, six colours, a four-colour
    vertex, a (Q)-free ring; no "simple at `p`" step needed); S1-QF's own route (S1-LENS, S1-EXIT, S1-CLUSTER; V4-OUTER, S1-KAPPA's last clause) is a
    second route. This replaces SR2's item 19 (FS129-OR1-QFREE in place of S1-QF).
24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI,
    and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.
25. **Amending SR1's item 2**: formalize **FS129-MR1-DOUBLETIP** for the wider ring classes it serves (FS-124), but **not** as EMPTY's double-tip step:
    its step 3 identifies the flank tile by a cone interval at the hubs, so an EMPTY routed through it holds only in the simple class (§ 2.3, § 4.3 row 3).
26. **FS129-SR3-OUTERADJ** in place of **FS116-V6-ADJ**, over FS116-RING-GERM (ii), V6-GERM's neighbourhood form and FS129-SR1-TWOCIRC; V6-ADJ's argument is
    its last step, formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair).
27. **FS114-Y5-PINALL with FS129-SR3-E2ONE**: formalize PINALL with the exception "E1, or E2 at two or more blades"; FS114-Y5-PIN120's exception narrowed
    to E2 at the blade two past the `120°` tile *together with* E1 or a second E2; **FS114-Y6-E2RED**'s survivor clause read as "no survivor at a single
    blade" (S6 empty).

**Do not formalize as stated:**
- **FS114-Y6-E2RED's** "the only E2 survivor family is S6" as a live case (S6 is empty: E2ONE); its chain clause stands.
- **FS116-S1-KAPPA's last clause** except as a step of S1-QF's second route: its class (non-Siamese, (Q)-free ring) is empty by FS129-SR3-QFREE-NS, and its
  GAP under reading L is moot.
- No other result this job reached is empty; SR1's and SR2's lists stand.

### 5.2 Registered expectations, scored

| registered (`data/fs129/sr3/expectations.md`, and § 1.1 for (d)) | outcome |
|---|---|
| (a) a held result kills a residue, P = 0.30 | **yes** — S6, by FS114-Y5-ALT's parity (not by TWOCIRC, which is null at all three) |
| (a) residues killed, 0.5 (0–2) | **1** (S6), and one of the wrap's three sites closed with it |
| (b) a wider V6-ADJ derived, P = 0.40 | **yes** — FS129-SR3-OUTERADJ, and without simplicity |
| (b) if not derived, stalls at the pinning (0.65) | moot — the pinning is by the ring's germs (V6-GERM) |
| (c) answered elsewhere with no link back, 2 (0–4) | **3** |
| (c) answered in place, 2 (0–4) | **3** |
| (c) open, 4 (2–7) | **3** |
| (c) a held result shown false, P = 0.10 | **no** |
| merges, 2 (0–5) | **3** — QFREE-NS ⊇ OR1-QFREE and S1-QF; EMPTY-NS ⊇ Y4-EMPTY; OUTERADJ ⊇ V6-ADJ's use |
| weakenings derived as entries, 1 (0–3) | **3** — EMPTY-NS and QFREE-NS ("simple" dropped); OUTERADJ (V6-ADJ's class and its "hug" hypothesis dropped) |
| vacuity additions, 0 (0–2) | **0** new empties; the receipts of `C_Γ`, `C_Q` widened (§ 4.2) |
| records that disagree, 2 (0–4) | **5** (§ 4.3) — above the range |
| this job finds a held result false, P = 0.08 | **no** |
| all named items reached, P = 0.75 | **yes**, with (d) |
| (d) the chain reads "simple" at `p` alone, P = 0.40 | **yes, and less**: on V6's route it reads it nowhere |

Brier on the six binary predictions ((a) 0.30 → 1; (b) 0.40 → 1; (c) false 0.10 → 0; false 0.08 → 0; reach 0.75 → 1; (d) 0.40 → 1): (0.49 + 0.36 + 0.01 +
0.0064 + 0.0625 + 0.36)/6 = **0.215**. The misses all lie one way: the three "does a held result reach further?" questions were priced below even and all
landed — the counter-priors' measured direction. Every landing came from a held result applied around a structure its record read one piece at a time
(ALT around the cycle of pockets; V6-COUNT's last step around the cycle of sectors; DOUBLETIP's pairs exchanged).
