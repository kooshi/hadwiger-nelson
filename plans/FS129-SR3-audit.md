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
