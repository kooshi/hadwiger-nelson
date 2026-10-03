# FS116-Z1 — the close of FS-116, the local exclusion: part 1 (Ephodos, Opus 5.5, 2026-10-03)

*Brief `data/fs116/briefs/FS116-Z1-close.md` (commit e8779db4), with `plans/STANDING-RULES.md` as part of it. Identity and procedure:
`.claude/agents/ephodos.md` § The close job, split here as the brief rules: this part writes the ticks, the reconciliation, the derivation file, the
§ B drafts and the headline's draft; part 2 (FS116-Z2) writes the sweeps, the scored predictions, the stubs, the bearing lines, the `CLAUDE.md` units
and the FS-114 errata. I touch only this record, `plans/FS116-derivation.md`, `data/fs116/fs116-z1/`, `tools/fs116_z1_*.py` and
`data/fs116/reports/FS116-Z1.md`. FS116-V6 runs beside me, blind to every file I write; I message no one but the coordinator.*

## Theorems this phase proved

**None of this close's own.** The derivation file files the milestone's theorems; the four entries written here by hand (FS116-V1-FRAME,
FS116-V3-GERM-R-EDGE, FS116-V3-ECHO-ONLY, FS116-V5-CROSS-S) are V1's, V3's and V5's results, stated from their records at one mind each, and
FS116-C114-LOCAL-F is a GAP entry recording the case list (§ 2.6). No statement was derived anew.

## Would-have-searched-here log (standing rule 5)

None: a close reads records and assembles; no move of this job would have been a search.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript and no file of FS116-V6's. I wrote nothing outside my touches.

## Stage 1 — SAVED: the readback, the files read, the ticks

### 1.1 Files read, in order (reading status)

| file | read |
|---|---|
| the brief; `plans/STANDING-RULES.md` | in full |
| `plans/FS116-close-inventory.md` | in full (items 1–131, W1–W28, O1–O5) |
| `data/fs116/claims.md` | in full (§§ 0–15) |
| `plans/FS116-local-exclusion.md` | headings, § Theorems, §§ 4.3–4.7, the two entries |
| `plans/FS121-Z1-close.md`, `plans/FS121-derivation.md`, `tools/fs121_z1_ledger_b.py` | the form: headings, § 2.1–2.2, two entries, the composition, the tool |
| the 13 job records (N1, N2, N3, S1, Y1–Y4, V1–V5) | each record's § Theorems, every `derivation:` and `verification:` block (by the gate's parser, `data/fs116/fs116-z1/survey.py`, and in full by `dump.py`), every divergence table, every verifier's § 4 (count, drafts), V1 §§ 2.3–2.5 and 3.1–3.4, V5 §§ 2.0, 3.4, Y4 §§ 3.2–3.3, N1's hand-back, N2 § 3.2–3.3, N3 §§ 3.2–3.4 |
| the reports in `data/fs116/reports/` | not read: every number and verdict was read from the records the inventory items cite |
| `plans/STUB-local-exclusion.md` | its title line (the readback) |

### 1.2 Readback of the brief's quotations (standing rule 3)

| the brief's quotation | source | result |
|---|---|---|
| "Please revive your agents with messages, and continue with the milestone." | `plans/FS116-close-inventory.md` item 74 | verbatim (found once, `grep -c`) |
| "FS-116 — the local exclusion: is there an explicit radius about a four-colour vertex within which no valid six-map fragment with unit arcs exists? (stub)" | `plans/STUB-local-exclusion.md` l. 1 | verbatim; the source line carries the heading mark "# " before it, which is markup |

Restated beside them, as this job uses them: the question's frozen form is C114-LOCAL-F (`data/fs116/claims.md` § 1, verbatim): "**Is there a radius
`R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R` about a vertex of at least
four colours?**" — and Kooshi's instruction is that this close files what the milestone established at the grades the records support.

### 1.3 The brief's other statements, checked (findings, not refusals)

- **F-B1.** The brief lists the statement-defect and correction-owed items as "11, 28, 29, 32, 38, 45, 50, 51, 62, 65, 67, 77, 87, 109, 120". Items 11, 62
  and 87 are about briefs and stub prose, not statements this file carries (ticked "done (noted)"); items 29 and 32 are FS-114's N7-3T (part 2's errata).
  Others the brief did not list and the derivation file carries: item 99's note (ECHO's term, which item 65 names), item 72's (RING-TWIST's frozen
  not-claimed line), item 120's. Nothing missing.
- **F-B2.** The brief names the mind counts "ruled" in items 31, 49, 76, 118 and 108, 115, 123. Each is filed as ruled; one record shows more than the
  inventory says, recorded in § 2.4 F1 (V1's retraction 2 retracted a true remark).

### 1.4 The ticks

`data/fs116/fs116-z1/ticks.md`: items 1–131, each "done" with where, or "part 2" with what part 2 must do. Part 2's list, gathered: items 13, 19, 20,
25 (scoring N7's registrations), 29, 32, 39, 53, 56, 61, 63, 67, 69, 71, 83, 96–99, 110, 115, 116, 118, 126–130.

## Stage 1 — SAVED

## Stage 2 — SAVED: the reconciliation

*Read from each record's "Theorems this phase proved" first, then its entry blocks (by the gate's parser), then each verifier's blocks, divergence
tables and § 4. **Blindness, from the fence logs and commit order** (the inventory's receipts re-read): V1's verdicts `3daaa05c`, `894db2d9` before it
opened the plan and FS-114's N7 record; V2's `30fd7aaa`, `81bfc5cb` before N1 §§ 2–3 (it had N7-HUB's one-line sketch in the list's § 8, and two
definition sentences of N1's record relayed); V3's `7245b6eb` before N1's record (the same sketch); V4's `48534b7c` before S1 §§ 2.1–2.5 (its brief
said a decided result rests on KAPPA and RUNG, and gave QF's verdict: item 107); V5's `320a3b53` (§§ 12, 14) and `3647075d` (§ 13) before Y3 §§ 2–4
and N3 §§ 2–3. The derivers had no verifier's work before their own commits. **Every mind is Opus 5.5: one prior throughout.** "Held" is the
announcement rule's (inventory top): a frozen statement, two minds, the second blind, its verdict committed first. Ids are the derivation file's
(`plans/FS116-derivation.md`); "vac." marks a statement true vacuously if FS116-Y4-EMPTY is held (item 124), each at its own count.*

### 2.1 Every claim and lemma, with its verdict and minds

**The opening (FS116-O1; FS116-V1 blind).**

| frozen name (list §) | id | verdict | minds | address |
|---|---|---|---|---|
| FS116-O1-YESLIM (§ 3) | FS116-O1-YESLIM | TRUE; thin (the map structure idle beyond a null boundary; the `k = 6` clause holds for every `k` straight from the fragments); **held** | 2 (different route at two steps) | plan § 3.5; V1 § 2.1 |
| FS116-O1-SATPIN (§ 3) | FS116-O1-SATPIN | MISSTATED as frozen ("edge" needs `a ≠ b`; "exactly one" → "at least one"); TRUE corrected; thin (four colours and positive cones idle; holds at cusps); **held** corrected (item 31: both routes use FS111-M-PINCH's case split) | 2 | plan § 4.1a; V1 § 2.3 |
| FS114-N7-3T (§ 8) | — (FS-114's) | GAP at the per-pattern kills at `1 + ε` (blind stall); the `+++`, `b = a + 1` kill a checking reading; statement defects: the headline omits non-Siamese, simple, four colours at `p`, six colours, the bent ring; `+++` unlisted; the N7-HUB parenthesis is a rider | the kills 1 (FS-114) | V1 § 3.2–3.4, § 4.3 |
| N7-HUB (b), (c) (inside § 8) | — (FS-114's) | TRUE | 2 (FS-114's N7; V1 blind, different route: the flip at `σ^{±1}y` against CL) | V1 § 3.1 |
| — | FS116-V1-FRAME | TRUE: exactly six change points; every tactic centre a change point (F5, F6, over F0 and F3) — vac. | 1 (V1) | V1 § 3.1 |

V1-L1 (one side of each contact circle) is folded into SATPIN's second route; V1-YESLIM and V1-SATPIN are the verifications themselves.

**Round 1 — the ring (FS116-N1; FS116-V2 blind on three).**

| frozen name | id | verdict | minds | address |
|---|---|---|---|---|
| RING-TWIST (§ 5) | — | MISSTATED: the parity counts colour changes, not change points; corrected as RING-TWIST-C; its not-claimed line ("the parity fails: R7's lattice points") is vacuous there, not failing (item 38) | 1 | N1 §§ 2.2–2.4 |
| RING-TWIST-C (§ 10) | FS116-RING-TWIST-C | TRUE under reading L ("the ring off Γ on both sides") with "arc of Γ on ω(p)" read as an edge; **held** | 2 (the same route in substance) | N1 § 2.2; V2 § 3.1 |
| FS116-N1-TWIST-LIT (§ 10) | FS116-N1-TWIST-LIT | TRUE under readings L and G; **held**; does not consume RING-TWIST-C (hand on its own, item 51); its "only if" holds inside the non-Siamese class (V2-TL-NS, one mind) | 2 (same route) | N1 § 2.3; V2 § 3.3 |
| — | FS116-N1-TWIST-D | TRUE (RING-TWIST-C's first clause, any `k`, any colours at `p`) | 1 (its four-colour case is RING-TWIST-C's first clause, re-derived by V2) | N1 § 2.1 |
| RING-GERM (§ 10) | FS116-RING-GERM | TRUE under reading L; under reading G FALSE by the strip's apex (a monster, V2-RG-G); **held**, with item 49's caveat (V2 had N7-HUB's sketch); (0a), (0b), (ii) hold Siamese allowed (V2-RG-THIN, one mind) | 2 (different routes: colour exclusion against tile identification) | N1 § 3.1; V2 § 2.2 |
| RING-Q (§ 5) | FS116-RING-Q | GAP at a change point with a germ at `±60°` on a (Q) arc; FALSE below radius ≈ 1.5985 (the disk's corner) | 1 | N1 § 3.4 |
| RING-Q′ (§ 5) | FS116-RING-Q-PRIME | TRUE (closed (Q) arcs) | 1 | N1 § 3.1 |
| — | FS116-N1-QDISK | TRUE [tools, exact to 50 digits; the class read in floats] | 1 | N1 § 3.2 |
| — | FS116-RING-TWIST-Q | TRUE | 1 | N1 § 3.4 |

**Round 2 — the saturated class (FS116-N1's successor; FS116-V3 blind on five).**

| frozen name | id | verdict | minds | address |
|---|---|---|---|---|
| SAT-QFREE (§ 4) | FS116-SAT-QFREE | GAP at the touch point; FALSE with "(Q)-free" deleted (F15TOUCH) | 1 | N1 § 4.2 |
| SAT-STRIP (§ 4) | FS116-SAT-STRIP | GAP, narrowed by S1 to G1 (rings with (Q) arcs), G2 (Siamese fragments), G3 (crosses not at right angles) | 1 each (N1, S1) | N1 § 4.3; S1 § 2.5 |
| FS116-N1-GERM-R (§ 11) | FS116-N1-GERM-R | TRUE; its open intervals sharp (FS116-V3-GERM-R-EDGE); "above 1" can be "1"; **held** | 2 (different routes) | N1 § 4.1; V3 § 2.2 |
| FS116-N1-GERM-S (§ 11) | FS116-N1-GERM-S | TRUE; **held**, the sketch caveat V3 itself states | 2 | N1 § 4.1; V3 § 2.4 |
| FS116-N1-TOUCH (§ 11) | FS116-N1-TOUCH | TRUE; "w in the closure of a tile of one of p's colours" idle (thin); **held** | 2 (same route) | N1 § 4.2; V3 § 3.1 |
| FS116-N1-ECHO (§ 11) | FS116-N1-ECHO | MISSTATED: FALSE under reading (A) (the hexagonal seven-colouring, `w` inside an `X`-hexagon), TRUE under (B); **held in (B)**, filed in V3's wording | 2 on (B) | N1 § 4.2; V3 § 3.3 |
| FS116-N1-AXIS (§ 11) | FS116-N1-AXIS | TRUE; (a), (d) use no saturation (V3-AXIS-STRIP: the unsaturated strip meets them, fails (b)); **held** | 2 (different routes; V3's (b) does not rest on SATPIN) | N1 § 4.3; V3 § 3.5 |
| — | FS116-RING-Q-PRIME-S, FS116-N1-QFREE4, FS116-N1-F15TOUCH [tools] | TRUE | 1 each (QFREE4's Γ-free case re-derived blind inside V5-RING) | N1 §§ 4.1–4.2 |
| — | FS116-V3-GERM-R-EDGE, FS116-V3-ECHO-ONLY | TRUE | 1 each (V3) | V3 §§ 2.3, 3.3 |

**Round 3 — the transfer rule (FS116-N2; no blind check) and SAT-STRIP from both sides (FS116-S1; FS116-V4 blind on three).**

| frozen name | id | verdict | minds | address |
|---|---|---|---|---|
| RING-TRANSFER (§ 5) | — | MISSTATED: its input too small (the rule reads `p`'s star), its output too large (each placed ring's 240° arc outside `B̄(p, 1)` is unread) | 1 | N2 § 3.3 |
| — | FS116-RING-TRANSFER-C | TRUE; its last clause vac. | 1 | N2 § 3.3 |
| — | FS116-N2-SIXRING, -FIVERING, -STAR, -RECIP, -ANTI | TRUE | 1 each | N2 §§ 2.1–2.2 |
| — | FS116-N2-HEX6, -HEX3 | TRUE — vac. | 1 each | N2 § 3.1 |
| FS116-S1-KAPPA (§ 12) | FS116-S1-KAPPA | TRUE in the ruled reading (B), κ's change points (item 103); filed in V4's corrected wording (item 109); under § 10's change points its last clause is GAP | 2, blind, with item 108's caveat (the brief said a decided result rests on it) | S1 § 2.1; V4 § 2.2 |
| FS116-S1-RUNG (§ 12) | FS116-S1-RUNG | TRUE, Siamese allowed; thin (degree 4, four colours and the other three edges idle) | 2, the same caveat; V4's partner step re-derives SATPIN's tangent clause (V4-PARTNER) | S1 § 2.3; V4 § 2.3 |
| FS116-S1-QF (§ 12) | FS116-S1-QF | TRUE; saturation needed only at the points of `p`'s four edges (V4's route) | **two derivations by different routes, the second told the first's verdict by the coordinator's brief** — not held (items 108, 115); a blind second mind owed | S1 § 2.5; V4 § 2.4 |
| — | FS116-S1-PAIR, -CLUSTER, -LENS, -EXIT | TRUE | 1 each | S1 §§ 2.2–2.4 |
| Y-SAT (§ 7) | FS116-Y-SAT | stalls: no construction; the obstruction QF at `R = 2` in its class | 1 (Y1, Y2, S1 each) | Y1 § 2; S1 § 2.5 |
| — | FS116-V4-CHORD, -DICHOTOMY, -MEET, -TWIST, -PARTNER, -OUTER | TRUE | 1 each (V4) | V4 § 2.1 |

**Round 4 — the semi-hub rule (FS116-N3; FS116-V5 blind on SEMI, PAIR, CROSS).**

| frozen name | id | verdict | minds | address |
|---|---|---|---|---|
| FS116-N3-SEMI (§ 13) | FS116-N3-SEMI | TRUE; **held** | 2 (different routes: V5-U1 for the centre's four colours, V5-DICHO for crossed-or-parallel) | N3 § 2.4; V5 § 3.2 |
| FS116-N3-PAIR (§ 13) | FS116-N3-PAIR | TRUE; "simple" idle (thin); **held** | 2 (same route) | N3 § 2.2; V5 § 3.3 |
| FS116-N3-CROSS (§ 13) | FS116-N3-CROSS | TRUE; **held on every clause but the last**; the last ("p is a semi-hub of kind O of the ring of y") one mind and a checking reading (V5's blind verdict GAP there, closed by N3's step through FS114-N7-QOPP at `y`, re-derived by V5 after reading); the first clause vacuous (no tile of `p` has `y` in its closure); the positive-cone and radius-2 hypotheses unused | 2 / 1 + a checking reading | N3 § 3.1; V5 § 3.4 |
| — | FS116-N3-CONE, -STAR2 | TRUE | 1 each (item 95) | N3 §§ 2.1, 2.3 |
| — | FS116-RING-TRANSFER-QC | TRUE | 1 | N3 § 3.3 |
| — | FS116-SEMI-PAR3 | GAP: from the bowtie's four-colour parallel semi-hub to three colours | 1 | N3 § 3.2 |
| RING-TRANSFER-Q (N2's corrected form) | FS116-RING-TRANSFER-Q | GAP at three places: SEMI-PAR3; a closed change point (RING-Q's gap); whether a crossed semi-hub's placed vertex has `p` as a crossed semi-hub | 1 each (N2's GAP narrowed by N3) | N2 § 3.2; N3 § 3.3 |
| — | FS116-V5-QCOL, -U1, -OUT2, -DICHO, -CROSS-S | TRUE (U1 known: FS112-U1; CROSS-S: no tile of `p` has `y` in its closure, and `p`'s tip pair in `y`'s ring lies on (Q) arcs) | 1 each (V5) | V5 §§ 3.1, 3.4 |

**The construction side (FS116-Y1–Y4; FS116-V5 blind on five of Y3's; FS116-V6 blind on EMPTY, running).**

| frozen name | id | verdict | minds | address |
|---|---|---|---|---|
| Y-QRING (§ 7) | — | not landed (P2 met): no fragment by formula about a (Q)-ring four-colour vertex beyond `φ²/√2`; Q1 open, Q2 dead above φ, Q3 dead at √3 | 1 (Y1, Y2) | Y1 § 3.3; Y2 § 1 |
| — | FS116-Y1-F15 [tools], -STRIPCEIL, -NOTCH | TRUE | 1 each | Y1 §§ 2.1–2.2, 3.2 |
| — | FS116-Y2-SIXFRAG [tools], -SIXOFF, -DCREAD | TRUE | 1 each | Y2 §§ 2.2–2.4 |
| FS116-Y3-SIX (§ 14) | FS116-Y3-SIX | TRUE; "simple" idle (V5's route); **held** — vac. | 2 (different routes) | Y3 § 2.1; V5 § 2.2 |
| FS116-Y3-TIPS (§ 14) | FS116-Y3-TIPS | TRUE; **held** — vac. | 2 (same route) | Y3 § 2.2; V5 § 2.3 |
| FS116-Y3-NBTIP (§ 12) | FS116-Y3-NBTIP | TRUE — vac. | 1 and a checking reading (its route was N7-HUB's outline, given) | Y3 § 4.1; V5 § 2.4 |
| FS116-Y3-TIGHTLENS (§ 12) | FS116-Y3-TIGHTLENS | TRUE; thin: each of (Q1)–(Q5) holds by its first disjunct alone (both minds); **held** — vac. | 2 (different routes) | Y3 § 3.2; V5 § 2.6 |
| FS116-Y3-STARFORCE (§ 12) | FS116-Y3-STARFORCE | TRUE under readings R-LENSPT and R-ORDER (written out in the entry); the order clause FALSE under the reverse order; **held** — vac. | 2 | Y3 § 4.2; V5 § 2.6 |
| — | FS116-Y3-HUBCOL, -TIGHT, -NOQ, -LENS | TRUE — vac. | 1 each | Y3 §§ 2.3–3.1 |
| — | FS116-V5-NE1 (known: N-E1), -RING, -GERM, -OUT, -TIPSET | TRUE | 1 each (V5) | V5 §§ 1.4, 2.1 |
| — | FS116-V5-LENS | TRUE — vac. | 1 (V5) | V5 § 2.5 |
| FS116-Y4-EMPTY (§ 15) | FS116-Y4-EMPTY | TRUE | **1; blind second mind running (FS116-V6)** | Y4 § 3.2 |
| — | FS116-Y4-FLANK | TRUE, colour-free, Siamese allowed | 1 (item 123) | Y4 § 3.1 |
| — | FS116-Y4-OBST | TRUE (the brief's target answered at every radius above 1); FS116-Y4-FRAG FALSE by it | 1 | Y4 § 3.3 |
| — | FS116-Y4-SYM, -SPOKE, -Q1 | TRUE — vac. | 1 each | Y4 §§ 2.1–2.3 |

**Claims of the frozen list no job worked:** SATPIN-PER (§ 4), NO-SAT (§ 4), DISC-F (§ 6), LOCAL-DENSE (§ 6) — no D2 job ran; C114-LOCAL-F itself is
filed as GAP at the named ring types (FS116-C114-LOCAL-F, § 2.6's case list). STRUCT (§ 1) is answered in part: §§ 2.1 and 2.6.

**Counts.** Held under the announcement rule: **19 frozen statements** — YESLIM, SATPIN (corrected), RING-TWIST-C, TWIST-LIT, RING-GERM, GERM-R,
GERM-S, TOUCH, ECHO (reading B), AXIS, KAPPA (corrected), RUNG, SEMI, PAIR, CROSS (all but its last clause), SIX, TIPS, TIGHTLENS, STARFORCE — with the
caveats of items 49, 76 and 108 stated where they bind. Not held at two derivations: QF (the second told the verdict). One mind and a checking
reading: NBTIP, CROSS's last clause. One mind: everything else, EMPTY among them while V6 runs. **No top claim landed**: C114-LOCAL-F, NO-SAT, DISC-F,
LOCAL-DENSE, RING-Q, SAT-STRIP, SAT-QFREE, RING-TRANSFER-Q, Y-SAT and Y-QRING are GAP, stalled, not landed or not worked.

### 2.2 The divergences between each job and its verifier, and how each was settled

| verifier | rows | truth | route | wording | settled |
|---|---|---|---|---|---|
| V1 (on O1; on FS-114's N7) | 19 | 0 | 13 | 6 | SATPIN's two words (rows 4–5): the author's readings, filed corrected; YESLIM's class (row 5) wider in V1's wording; N7-3T's headline setting, `+++`, the model (rows 6–8): part 2's FS-114 erratum, the model by § 2.4 F1 |
| V2 (on N1) | 14 | 0 | 10 | 4 | "change point" travels with "the ring off Γ on both sides" (RING-GERM row 4); "edge" in RING-TWIST-C (row 3); TWIST-LIT hand on its own (row 2); RING-GERM's uses-only (row 2) |
| V3 (on N1's successor) | 14 | 0 | 11 | 3 | ECHO's term (reading B named); GERM-R's radius; AXIS's saturation spent at (b) only |
| V4 (on S1) | 16 | 0 | 14 | 2 | KAPPA's "exactly one of the two colours absent" and "κ's change points" (rows 3–4) |
| V5 (on Y3, N3) | 17 | 0 | 15 | 2 | STARFORCE's two phrases (rows 2–3): the readings written in the entry; CROSS's last clause a stall closed by N3's step (route) |

**No divergence of truth in 80 rows; no third mind was needed.** Every second mind is the same model, so agreement on a hard step is weak evidence
there; the routes differ where the tables say, and are the same route at TWIST-C, TWIST-LIT, TOUCH, TIPS, PAIR, NBTIP.

### 2.3 Retractions, counted per mind; tool defects; slips

- **Retractions:** V1, 2 (side remarks on N7-3T, no verdict changed; the second is itself mistaken, § 2.4 F1); V2, V3, V4, V5: 0. The derivers: none
  recorded (Y3's stage-4 removal of a disjunct from its own working is a strengthening, not a retraction).
- **Tool defect:** item 98 (`tools/fs116_n1_ring.py`'s one-ray `locate`); no theorem rests on a sampled output (models only).
- **Slips logged by the coordinator:** items 23, 27, 52, 78, 90, 107 (the last cost QF its held count).

### 2.4 Findings settled here

- **F1 — the bowtie's caps are (Q) arcs, and V1's retraction 2 retracted a true remark.** `data/fs116/n1/ring-survey-bowtie.out` reads FS114-Y2-BOWTIE's
  centre ring with two (Q) arcs, `[150°, 210°]` inner 3 | outer 1 and `[330°, 30°]` inner 1 | outer 3; `data/fs116/n3/semi.out` l. 18 reads its top
  change point's germs `u+:3|1 v-:1|3`, both on those arcs; V4 (item 110) reads `t1`'s outer side as a (Q) arc. So there is one bowtie (item 34), its
  caps are (Q) arcs, FS114-N7-3T's model line is wrong (items 39, 110: part 2's erratum, N1's replacement line), and V1's original § 3.3 remark was right.
  V1 retracted it on reading the very model line now found wrong. Counted: V1, one retraction of a side remark and one withdrawn retraction.
- **F2 — a whiff of two truths (G87), for Keryx to route; no side picked.** The definitions file FS116-V1 was given quotes FS-114's NB6 § 1b.0: "the map is
  bent on a fragment of radius `1 + ε` about `p` (NB6 §1b.0: then every ring `Γ`-arc but the (Q) arcs is removed, and the tactic edges, inner tiles and
  partners are kept, N5-BENDG)" (`data/fs116/v1-n7-definitions.md` l. 195). `plans/FS114-derivation.md` l. 531 reads "N5-BEND and N5-BENDG (FS-112's bends
  leave only (Q) and (R2) ring arcs at a degree-4 vertex, …)", and FS116-Y4 § 3.3 reads "The (Q)-free rings that carry (R2) arcs after the bends
  (FS114-N6-RING60's class, where N7-HUB and N7-3T live) are not reached". If the first holds and the bent fragment stays non-Siamese and simple,
  FS116-Y4-EMPTY applies to every (Q)-free ring after the bends, and FS114-N7-3T's whole class is empty at `1 + ε`; if the second, that class is the
  successor's main case. Which of the two the bends deliver is not settled by any FS-116 record.
- **F3 — the vacuity reaches farther than item 124 lists, and less far in one place.** FS116-V1-FRAME and FS116-V5-LENS are in EMPTY's class (vac.);
  FS116-V5-RING, -GERM, -OUT, -TIPSET are not (their setting drops "simple"), nor is FS116-N2-RECIP (item 124's own exception).

### 2.5 What the milestone's framing now looks like (a finding for Poros and Kooshi)

The stub posed one exclusion about a four-colour vertex (row 137). The rounds turned it into a case list by ring type, and each case went its own way:
the Γ-free type died at `1 + ε` (one mind), the saturated cross died in one class, and every other case stopped at a named configuration on the ring or
the first shell. The structural form (STRUCT) carried the work, as §IQ predicted; the existence form was never worked as a whole. The shape now is
G15's: the pigeonhole is the ring type at `p` and each type needs its kill, and two of the kills are the straddle along two unit circles (G83; FLANK,
SIXOFF). The framing does not look wrong; it looks finer than one statement.

### 2.6 C114-LOCAL-F's case list, as the records leave it (non-Siamese simple fragments unless said)

| case at `p` | status | where |
|---|---|---|
| ring carrying no arc of Γ (the Γ-free type) | **excluded at `1 + ε`**: no such fragment exists (one mind; FS116-V6 running) | FS116-Y4-EMPTY |
| ring (Q)-free, carrying other arcs of Γ ((R2) arcs after FS-112's bends) | open; FLANK's mechanism not carried there (no tip given at a change point ending an (R2) arc); § 2.4 F2 may decide whether it is a case | Y4 § 3.3 |
| ring carrying (Q) arcs, at hubs and semi-hubs | four-colour vertices placed on `ω(p)` (RING-GERM, SEMI, RING-TRANSFER-QC), the rule derived; no exclusion | FS116-RING-TRANSFER-QC |
| … at a full parallel semi-hub of three colours | GAP (SEMI-PAR3) | FS116-SEMI-PAR3 |
| … at a closed change point (the disk's corner) | GAP (RING-Q's); any exclusion on `B̄(p, 2)` must read the far side of `p` | FS116-RING-Q; FS116-Y2-DCREAD |
| the right-angled straight cross, saturated on `B̄(p, 1)` | excluded in the (Q)-free non-Siamese class at `R = 2` (two derivations, the second told the verdict); open with (Q) arcs, Siamese, not at right angles | FS116-S1-QF; FS116-SAT-STRIP |
| a five-colour vertex | no change point, (Q) arcs over half the ring; no exclusion | FS116-N2-FIVERING |
| a six-colour vertex | six 60° (Q) arcs; one family stops below √3; a fragment by formula holds `B̄(p, R)`, `R < 3/2` | FS116-N2-SIXRING; FS116-Y2-SIXOFF; FS116-Y2-SIXFRAG |
| Siamese or non-simple fragments | RING-GERM holds without non-Siamese (GERM-S), so RING-Q′ does (RING-Q-PRIME-S); KAPPA, RUNG, FLANK hold Siamese allowed; no exclusion | FS116-N1-GERM-S |

N7's two carried registrations (item 25): OC dies within √3 (0.5) — OC was not worked; every (Q)-ring survivor has a 60° (Q) arc or one ending 60° from a
tactic centre (0.4) — no survivor was classified. Neither is decided; part 2 scores them so.

## Stage 2 — SAVED

## Stage 3 — SAVED: `plans/FS116-derivation.md`

*Assembled by `tools/fs116_z1_derivation.py` from the records' own `derivation:` blocks (field by field), with every change the close makes written in
`tools/fs116_z1_notes.py`: qualified ids (a frozen name without the prefix filed as `FS116-<name>`, the verifiers' lemmas as `FS116-V4-…`, `FS116-V5-…`),
record-prefixed argument addresses, the minds lines read from the verification blocks and § 4 counts (`MINDS`), the corrected statements as named
substitutions on the frozen text, each applied only if the frozen text is found (`SUBS`: SATPIN, RING-GERM, RING-TWIST-C, ECHO, KAPPA), four field
corrections the verifiers drafted (`FIELD`: TWIST-LIT's grade and uses-only, RING-GERM's uses-only, GERM-R's model, AXIS's and TOUCH's uses-only,
NBTIP's one-way converse), a prose paragraph under every entry (`NOTE`), and "Rests on it:" generated from every other entry's `uses only:` and `grade:`
lines, with the consumers outside the file added by hand (`EXTRA`).*

- **86 entries** (79 derived, 7 GAP or stalled: FS116-RING-Q, -SAT-QFREE, -SAT-STRIP, -Y-SAT, -SEMI-PAR3, -RING-TRANSFER-Q, -C114-LOCAL-F), in ten
  sections by round; **11 controls** copied from the records (the [tools] objects, ECHO's reading-(A) counterexample, RUNG's ceiling, EXIT's identities,
  STARFORCE's truth table, SEMI on the held change points, FLANK and EMPTY's six-colour step), each firing on its fault.
- **Left out, with the reason:** the quotation readbacks `FS116-*-QT` (not mathematics); N1's first SAT-STRIP block and N2's RING-TRANSFER-Q block (each
  superseded by its narrower successor, whose note gives the first address); V1-L1, V1-YESLIM, V1-SATPIN and V3-ECHO-B (they are the verifications);
  V2-RG-THIN, V2-TL-NS, V2-RG-G, V2-RG-STRIP, V2-STRIP-D, V3-ECHO-A and V3-AXIS-STRIP, each folded into the note of the entry it bears on (one-mind
  findings and readings of held objects, stated there with their names).
- **The gate:** `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS116-derivation.md` — **PASS, 0 failures, 28 warnings**
  (`data/fs116/fs116-z1/gate-stage3.out`): 26 "prior art owed" (the records' own, carried), and SATPIN's grade citing FS111-M-PINCH and FS111-M-C11,
  which are held entries of `plans/FS111-derivation.md`, not of this file.
- **A check by hand on the substitutions:** each corrected statement read beside its verifier's drafted wording (V1 § 2.3's last paragraph; V2 § 4.1 row 4,
  § 4.2 row 3; V3 § 4.4; V4, Divergences on KAPPA rows 3–4) — each change is the verifier's words or the minimal insertion its row asks for. RING-GERM's
  "(the ring off Γ on both sides of y)" is my wording of V2's instruction ("change point should be quoted with the ring off Γ on both sides").

## Stage 3 — SAVED

## Stage 4 — SAVED: the § B drafts and their check, the headline draft

### 4.1 The § B drafts

`data/fs116/fs116-z1/ledger-b-draft.md`: 86 lines, one per entry, generated by `tools/fs116_z1_ledger_b.py` (copied from FS-121's and adapted) from the
entries' own statements (truncated at a word boundary, never paraphrased); the grade cell is § 2.1's (held, the special counts, "vacuous if FS116-Y4-EMPTY
is held"); the row column carries placeholders ‹R116-a› (the opening and the ring), ‹R116-b› (the saturated class), ‹R116-c› (the transfer and semi-hub
rules), ‹R116-d› (the six-colour vertex and the Γ-free type, with the case list), for part 2 to number after FS-121's rows.

**The check.** `python3 tools/fs71_ledger_b_check.py --strict` on a scratch copy of the tree (the checker, the gate, every `plans/*-derivation.md`, and
`LEDGER.md` with FS-121's 65 drafted lines and these 86 appended): **RESULT: PASS, exit 0** — 1,289 theorems in 77 files, 1,289 § B rows, no placeholder
(`data/fs116/fs116-z1/ledger-b-check.out`). Its negative control: without FS-116's lines the same run exits 1 with exactly 86 "entry FS116-… has no
LEDGER.md § B row". The generator's own plant: a corrected-statement substitution whose frozen text is altered makes `tools/fs116_z1_derivation.py` exit 1
("FAIL: FS116-N1-ECHO: the frozen text … is not in the statement").

### 4.2 The headline, in four parts (drafted for part 2 and the coordinator; V6's verdict to be folded in)

**1. What FS-116 settled, and at what grade.** *In non-Siamese simple valid six-coloured fragments, C114-LOCAL-F — one radius, for every complexity,
about every vertex of at least four colours — is not landed: it is GAP at named ring types, one type removed.* Case by case (§ 2.6):
- **The Γ-free ring** (no arc of Γ on `ω(p)`): no such fragment exists on any closed disc of radius above 1 about `p` (FS116-Y4-EMPTY) — **one mind;
  a blind second mind, FS116-V6, is running**. Twelve statements of rounds 3–4 about this class are true vacuously if it is held.
- **(Q)-free rings carrying (R2) arcs**: not reached; whether FS-112's bends leave such rings at all is an open whiff of two truths (§ 2.4 F2).
- **Rings with (Q) arcs**: the placing rule is derived — every hub and every semi-hub but one places a vertex of at least four colours on `ω(p)`
  (FS116-RING-GERM and FS116-N3-SEMI held; the assembled rule FS116-RING-TRANSFER-QC one mind) — and no exclusion; GAP at the full parallel semi-hub of three
  colours (SEMI-PAR3) and at closed change points, where RING-Q is false below radius ≈ 1.5985 (the disk's corner, [tools], one mind).
- **The saturated straight right-angled cross** (SAT-STRIP's configuration): excluded at `R = 2` when the ring carries no (Q) arc and the fragment is
  non-Siamese (FS116-S1-QF — two derivations by different routes, the second told the verdict; not held); open with (Q) arcs, Siamese pairs, or other angles.
- **Five- and six-colour vertices**: their rings are derived (FS116-N2-FIVERING, -SIXRING, one mind each); no exclusion; one six-colour family stops below √3.
- **Siamese and non-simple fragments**: RING-GERM holds without non-Siamese (FS116-N1-GERM-S, held); no exclusion.
- **The YES side**: valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held; at every `k`, `χ_m⁰(ℝ²) ≤ k`).

Held under the announcement rule: **19 frozen statements** (§ 2.1's count). **No value moved: χ(ℝ²) ∈ {5, 6, 7}.**

**2. The named steps it stops at.** SEMI-PAR3 (removing the bowtie's tip at `top`); the closed change point (any exclusion on `B̄(p, 2)` must read the far
side of `p`, FS116-Y2-DCREAD); the (Q)-free rings with (R2) arcs; SAT-STRIP's G1–G3 and SAT-QFREE's touch point; RING-TRANSFER-Q's crossed reciprocity; the
five- and six-colour types. NO-SAT, DISC-F and LOCAL-DENSE were not worked. Second minds owed: FS116-S1-QF (blind), FS116-Y3-NBTIP, FS116-N3-CROSS's last
clause, FS116-N2-STAR, -RECIP, -ANTI; FS116-Y4-EMPTY's is running.

**3. What the construction side built or excluded.** Built, exact, one mind each: F(1/5), a valid fragment on `B̄(P₀, 6/5)` saturated on `B̄(P₀, 1/5)` about
the strip's cross (FS116-Y1-F15), and the first exact valid non-Siamese fragment about a six-colour vertex, holding `B̄(p, R)` for `R < 3/2`
(FS116-Y2-SIXFRAG). Excluded: the strip family saturated beyond `≈ 0.491` (FS116-Y1-STRIPCEIL), the straight-sector six-colour flower at √3
(FS116-Y2-SIXOFF), and the whole Γ-free type at `1 + ε` (FS116-Y4-EMPTY, pending V6). Not landed: Y-QRING (no (Q)-ring fragment beyond `φ²/√2`; P2 met),
Y-SAT.

**4. Confidence, and the fact that would change it.** In the held results, high on the logic and moderate on independence: 80 divergence rows, none of
truth, but every second mind is the same model. In FS116-Y4-EMPTY, medium-high: the argument is short (FLANK's two edges inside two unit discs, then two
absent colours alternating), the coordinator's step-by-step reading found no gap, and V6's verdict decides it — a gap at FLANK's second-order step or at "a
has colour c(ψ_k − δ)" would restore the Γ-free type and the twelve vacuous statements' content. That the NO is close: low. Three ring cases have no
exclusion route yet, and the five- and six-colour types none at all; the fact that would raise it is an exclusion of SEMI-PAR3 and the closed change point
within radius 2, or § 2.4 F2 resolved so that EMPTY covers the (Q)-free rings with (R2) arcs.

### 4.3 Findings about Workflow 3.0, from this close (for the coordinator's watch)

- **The split worked.** Reading seventeen jobs to reconciliation depth, by the gate's parser and a block dumper rather than whole records, cost about
  210k of this job's own tokens before stage 2; the derivation file assembled by script from the records' blocks with every change in one notes module
  kept the 86 entries' statements verbatim and the corrections auditable (each a named substitution that fails if its frozen text is absent).
- **What the lane file does not say:** that a verifier's lemmas written as prose (V1, V2, V3) need a writer before they can be entries, while V4's and V5's
  arrived as blocks. A line in the verifier's lane asking for `derivation:` blocks for its own lemmas would save the close a judgment per lemma.
- **A finding the split surfaced:** a retraction can itself be wrong (§ 2.4 F1); the reconciliation is where that is caught, and a verifier's retraction
  deserves the same audit as its verdict.

## Stage 4 — SAVED
