# FS-112 close — stage 1: the reconciliation (FS112-C, de Bruijn, Opus 5.5, 2026-09-27)

*Every claim and lemma of FS-112 with its verdict, its minds and their blindness; every divergence and how it was settled; round 3 compared in
place of an advisor (Kooshi, inventory item 59: no fresh advisor stage for round 3). Read from each record's "Theorems this phase proved" table first,
then its sections (addresses in each row). "Blind" = a verifier that derived before opening the side's record. The proof side (N, N2, N3) and the
construction side (Y, Y2, Y3) were independent of each other throughout (competitors), so a statement both reached counts two minds, neither blind.
FS112-YB3 (blind on Y3) is still running: its record and working directory are unopened here; stage 1b folds it in on the owner's message.*

## Stage 1a — SAVED

### 1.0 Files read, and the quotation check (standing rule 5)

**Read from disk, in this order:** the brief `data/fs112/briefs/C112-close-math.md` and `STANDING-RULES.md` (rule 0 first); `CLAUDE.md` (296,992 bytes,
equal to my loaded snapshot at `df120f6b`): header rules, § The aim, § Counter-priors, § Paths forward, item 31, G51, G71, G72, G79, G82; `WORKFLOW.md`
step 9; `LEDGER.md` rows 131–134 and FS-110's § B lines; `plans/FS110-derivation.md` (header, §1's form) and FS-110's §R-close; FS110-C's report and
reconciliation (the template); `plans/FS112-close-inventory.md` items 1–63; the plan `plans/FS112-unit-arc-half.md` (§1, §G part 3, §PA, §IQ, §4, §5.1–5.7,
addendum); `data/fs112/claims.md` in full; `plans/FS112-N-proof.md` in full (N, N2, N3); `plans/FS112-NB-verification.md`, `FS112-NB2-`,
`FS112-NB3-verification.md` (theorem tables, verdicts, divergences in full); `plans/FS112-Y-construction.md` (Y's tables, §1.5, §2.5; Y2's table, §5–§7);
`plans/FS112-Y3-construction.md` in full; `plans/FS112-YB-verification.md`, `FS112-YB2-verification.md` (tables, verdicts, divergences);
`plans/FS112-PA-reading.md` (stage 1, stage 8); `plans/POROS-2026-09-27-fs112-unit-arc-half.md` (§1.7, §2.3, §4.2–4.3) and
`plans/POROS-2026-09-27-fs112-competition.md` (§1.6, §2a–2b, §3, §A3-1, §A3-3); every report in `data/fs112/reports/` but YB3's (not yet written);
`data/fs112/briefs/X112-front-page.md` (to aim the drafts). **Not opened:** `plans/FS112-YB3-verification.md`, `data/fs112/fs112-yb3/` (fenced until the
owner's message).

**Quotation check of the brief** (script, whitespace-normalised, against each source):

| quotation in the brief | source | verdict |
|---|---|---|
| Kooshi, item 59, "When round 3 finishes, … spend the night on those two." | `plans/FS112-close-inventory.md` item 59 | exact |
| "does a tight six-map exist once boundary arcs of radius 1 are allowed?" | plan title | exact |
| "Is it true that 7 colors are needed …?" | `data/fs112/claims.md` §1 (S–V Question 2) | exact (a prefix) |
| N2-RAY, "N4-FIN's application fails at a chain's end; … N4-CONE is a GAP under unit arcs" | `plans/FS112-N-proof.md` N2 table | exact |
| N3-BASE, N3-DENSE3, N3-PER | N3 table (l. 594–608) | exact |
| "the GAP N3-ALPH (`plans/FS112-N-proof.md` l. 695–699)" | the verdict opens at l. 695, the GAP at l. 696–699 | exact to the line |
| rule 0's Kooshi quotation | `CLAUDE.md` § Counter-priors | exact |
| the brief's glosses outside quotation marks (CAL-STRIP/-DISK robust; Y2-PIN; the stall; the corrected cone; φ attained) | inventory items 33, 42, 45, 53–54; YB2 D1, D3 | faithful |

No paraphrase inside quotation marks found in the brief.

### 1.1 The proof side (the NO): every statement, its verdict, its minds

| id | statement (short; verbatim in its record) | verdict | minds | address |
|---|---|---|---|---|
| walk | the chain walk: C-CHAIN-3 (N3-CONF), 4 (W-MERGE), 9 (N4-FIN as a statement) and N4-RAY hold as written; 1, 2, 5–8, 10–17 hold off unit-arc centres at points the step reads; 18 fails as a proof; **first break C-CHAIN-1 (NB-4)** | TRUE | two, one blind (N; NB), letter for letter; Y's walk the same (a third, not blind) | N §1.4; NB §1.4, §2.3; Y §1.4, §2.3 |
| N112-U1 | a unit-arc centre's wedges: inner side colour in the facing cone of width `π − ℓ`, outer in the away cone, side cones empty of both | TRUE (NB's precision: the outer tile's shadow *contains* the facing cone) | two, one blind (N; NB); TS-U's content | N §1.3; NB §1.5 |
| N112-SIX | five colours ⟹ `≥ 180°` of centred unit arcs; six ⟹ `ω(v) ⊆ Γ` | TRUE | two, one blind | N §1.3; NB-SIX |
| N112-NB4′ | NB-4 corrected: contradiction if no orbit point lies in the closure of an arc of `ω(v)` and no arc of `ω(y_{k±1})` has `y_k` in its closure; `\|P_cl(y_k)\| ≤ 4` not needed | TRUE | **three**, one blind (N; NB; Y2 as Y2-NB4 after retracting (γ)) | N §2.1 W1; NB-NB4′; Y2 §3.2 |
| A4-SIX-ARCS = C-UA-BUDGET branch 1 | no covering pair on the ring ⟹ centred arcs `≥ 60°` or six | TRUE | three (A4; N; NB, blind) | NB §1.6 |
| N112-L60 | a unit arc with constant sides is `< 60°` | TRUE | two, one blind | N §2.2; NB-L60 |
| N112-LOCK | along a unit arc's interior the only side-colour contacts are at `P` or (inner colour) at `P + 2e_w` | TRUE | two, one blind, different routes | N §2.2; NB-LOCK |
| N112-BEND | off end vertices an arc bends toward `P` unless `s_out ∈ P_cl(P)`, away unless `s_in` at `P` or along radius 2 | TRUE off end vertices | two, one blind | N §2.2; NB-BEND |
| N112-END | in a stuck chain the horn curvatures cannot reach `±1` at an interior step | TRUE, **scope: only chains with N4-STUCK's structure** | two, one blind | N §1.4 row 9; NB-END, §2.2 |
| NB-FLANK | N4-FLANK fails at `κ₊ = 1` / `κ₋ = −1` (an in-type flank tile at `N`); SHAVE's criterion incomplete there | TRUE | two (N blind to NB's stage 1; NB sighted after — NB's stage 1 said "survives") | N row 7; NB §2.2 |
| NB-ISO | isolated inner-colour contacts at `P + 2e_{w₀}` exist locally (N's l. 231 "do not exist" FALSE) and block a first-order away-bend | TRUE (a divergence of truth found by the verifier) | two (NB; N2 concedes) | NB §2.3 #4; N2-1 |
| N2-SIGN, N2-ENV | near/far side-colour tiles; the lens discs leave the union of unit discs only near `P` or `R₂(α)` | TRUE | two, one blind | N2-3; NB2 §1.4 |
| N2-TOWARD | `s_out ∉ P_cl(P)` ⟹ the whole arc, ends included, bends toward `P` | TRUE | two, one blind, **different routes** | N2-3; NB2-TOWARD |
| N2-AWAY | `s_in ∉ P_cl(P)` and no `s_in` tile on `R₂(ᾱ)` ⟹ the whole arc bends away | TRUE | two, one blind | N2-3; NB2-AWAY |
| N2-TAN | isolated R2 contacts cleared by a tangent bend; only R2 along an arc blocks | TRUE (NB-ISO closed) | two, one blind (NB's sketch completed twice) | N2-3; NB2-TAN |
| N2-RED | every valid map has a valid modification creating no unit arc in which every unit arc is (Q) or (R2); terminates, no stubs | TRUE (NB2's "once, wholly" corrected to N2's count) | two, one blind | N2-3; NB2-RED, §2.3 #8 |
| N2-FLANK-Q | a horn bound `±1` sits on a (Q) arc (FLANK's in-type exception; then one arc of `ω(N)` through `v`) or an (R2) arc | TRUE | two, one blind (NB2 sighted on "two-sided") | N2-4; NB2-FLANKQ, §2.3 #10 |
| N2-RAY | N4-FIN's application fails at a chain's end; the one-sided chain `λ_k = −1/(k+1)`, `υ_k = 0` is consistent; **N4-CONE a GAP under unit arcs** | TRUE; the step fails in N4-STUCK (iv) (NB2's correction) | two, one blind | N2-4; NB2-RAY, §2.3 #2 |
| NB2's pencil | the extremal ray is the pencil of circles of radius `k + 1` about `P_{−1}`, straight upper arcs, every shadow tight | TRUE (a recognition) | one (NB2); N3-RAYR's equality case reaches it again | NB2 §1.4 item 2; N3-2 |
| N2-TERM | the terminal map `M*`: arcs (Q)/(R2); vertices cubic, NB4′ exceptions, or stuck; chains not bi-infinite, finite ends within 1 of a (Q)/(R2) arc or NB4′ exception; one-sided infinite chains a GAP | TRUE | two, one blind | N2-4; NB2-TERM |
| N2-DENSE (N2's form) | in `M*` every trichromatic cubic vertex has a unit-arc centre within 4 or a stuck vertex within 3; every disc of radius 5 holds one | TRUE | two, one blind | N2-5; NB2 |
| NB2-DENSE (filed form, item 44) | in **every** valid map each trichromatic cubic vertex has a repeated-colour vertex within 2 or a unit-arc centre within 3; every closed disc of radius 4 holds one | TRUE | one (NB2), over the base; superseded in strength by N3-DENSE3 | NB2 §1.4 |
| NB2-DISC1 | every closed disc of radius 1 of a valid map holds a vertex of degree `≥ 3` | TRUE | two (N2's sketch; NB2's proof) | NB2 §1.4 |
| NB2-END | a chain's end may force a unit arc one step beyond (conditional sketch) | superseded by N3-END (made unconditional) | one | NB2 §1.4 item 5 |
| N3-STEP | along a chain neither `λ` nor `υ` decreases and one strictly increases per step | TRUE | two, one blind (+ Y3-R1 item 1 and A3's reading: four) | N3-2; NB3; Y3 §1.4 |
| N3-LEN | finite alphabet `K` ⟹ a chain has `≤ 2\|K\| − 1` vertices; a one-sided chain has infinitely many curvatures | TRUE; **the argument gives `2\|K\| − 3`** (NB3) | two, one blind; Y3's `3V + 3` a weaker count (a third, not blind) | N3-2; NB3-LEN; Y3 §1.4 |
| N3-RAYR | on an upward-infinite chain `−1/(k+1) ≤ λ_k < 0`: the horn at `P_k` needs an arc of radius `≥ k + 1` | TRUE | two, one blind | N3-2; NB3-RAYR |
| N3-PER | a doubly periodic valid map has a periodic terminal modification | TRUE | two, one blind | N3-2; NB3-PER |
| R1 | TRUE as corrected: the finiteness premise is on the terminal map; periodic maps have no stuck ray and bounded chains; **GAP N3-ALPH** for aperiodic finite-alphabet maps | TRUE / GAP | two, one blind (NB3 via STEP, LEN, RAYR, PER); A3's reading and Y3-R1 as stated carry the uncorrected premise (1.5 below) | N3-2 |
| N3-NOBOTH | a both-centre has `≥ 4` colours or a repeated colour | TRUE | two, one blind | N3-3; NB3-NOBOTH |
| N3-FAIL | the strip at `q ∈ ω(u)` fails only at a leaving centre; there only inner colours inside, outer outside | TRUE | two, one blind, different routes | N3-3; NB3-FAIL |
| N3-ANTI | CE5 survives unit arcs, by counting in-votes | TRUE | two, one blind, different routes | N3-3; NB3-ANTI |
| N3-COR3 | a close complementary pair of cubic trichromatic vertices sits on a unit rhombus whose other two corners are four-colour double leaving centres (T2 forced) | TRUE | two, one blind, different routes | N3-3; NB3-COR3 |
| N3-I | (i) never fails | TRUE | the base's use two, one blind; the unconditional form one (N3) with NB3's sighted check (NB3's stage-1 GAP retracted) | N3-3; NB3 §2.2 #1 |
| N3-II, N3-P′ | (ii) fails only at four-colour or repeated-colour vertices; same-multicolour cubic trichromatic vertices never at distance 1 | TRUE | two, one blind | N3-3; NB3 |
| **N3-BASE** | the base refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)` holds a vertex of `≥ 4` colours or a repeated colour | TRUE (inert arcs pre-bent by N2-TOWARD, both) | two, one blind; **over row 134's base unre-derived** (S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE) and N112-U1, N2-TOWARD (two each) | N3-3; NB3-BASE, §2.3 |
| **N3-DENSE3** | every closed disc of radius 3 of every valid map holds a vertex of `≥ 4` colours or a repeated colour | TRUE | two, one blind (over N3-BASE, NB2-DISC1) | N3-3; NB3-DENSE3 |
| N3-END | a chain's end with horn bound `−1` has a four-colour, repeated-colour vertex one step beyond and a both-kind unit arc centred two steps beyond (or is the doubly bounded one-vertex chain) | TRUE as the table states it; the body's first alternative **MISSTATED** (NB3 #2); item 3 needs the N-E2 step (#3) | two, one blind | N3-4; NB3-END, §2.2 #2–4 |
| N2-ROT, N2-HEX (FS-110) under P17 | survive unit arcs under the base's hypothesis; P17's only exception a both-centre `x₂`; N2-ROT's "no `r`-tile" rests on N3-COR3 | TRUE (the named check) | one (NB3, walked); N3 took them from FS-110 unwalked | NB3 §1.4 step 10, §2.2 #7 |

**Round 3's GAPs, named in the records:** N3-ALPH (does a non-periodic map with finitely many arc classes keep finitely many in its terminal
modification?); **(b′), the non-periodic stuck ray** (whether a one-sided stuck chain can live in a valid terminal map); and the global step
(excluding maps in which a vertex of `≥ 4` colours or a repeated colour lies within 3 of every point — N3's stub line).

### 1.2 The construction side (the YES): every object and claim, its verdict, its minds

| id | statement (short) | verdict | minds | address |
|---|---|---|---|---|
| CAL-STRIP (Y112-STRIP-RULE; YB-STRIP; YB2-STRIP3) | `[AxenovichEtAl2014]`'s strip rebuilt from its words is a valid six-colouring of height exactly `√15/2 + √3`; tight at every contact within reach | ACCEPT, exact | **three rebuilds** (Y; YB blind; YB2 blind), **three checkers**; label maps agree | Y §2.2; YB §3, §5; YB2 §4.1 |
| Y112-STRIP-KINDS / YB-CONTACT | every unit arc (12 per period) centred at a four-colour midline vertex, kind both (self) | exact | two, one blind; D6's 22 vs 24 a window effect (Y2-D6) | Y §2.2; YB O1; Y2 §3.4 |
| Y112-T2-SQRT3 / YB-T2 | T2 realised arc-closed at `√3` (spindle rhombus) and on a thin rhombus at `√15/2` | exact | two, one blind (the thin rhombus YB's alone) | Y §1.3; YB O2, D8 |
| YB-SEAMS | every close complementary pair's common unit points are four-colour midline vertices (both emit arcs) or edge vertices — exhaustive per period | exact | one (YB); Y's list a subset | YB O3 |
| Y112-EDGE / YB-EDGE / YB2-EDGE | no colour above the edge vertex `Q = (1/4, H/2)`; **the colourless set is the open cone `(arcsin ¼, 180° − arcsin ¼)` ≈ 151.05°** (YB2), not `(30°, 165.52°)` (a sub-cone) | the no-colour step two, one blind; the exact cone one (YB2) | Y §1.5; YB O3; YB2 O2, D1 |
| YB-LOCK | in-contact locks outward bends, out-contact inward; a both arc is rigid | TRUE | one (YB) + two exact bends; consistent with N112-BEND (a third, not blind) | YB O4 |
| YB-CHAIN | the strip carries bi-infinite periodic chains of unit arcs | exact | two (Y; YB) | YB O4; Y §2.5 |
| Y2-X4 | (S2)-with-arcs realised on the strip, arc-closed (T2 from the other diagonal) | exact | two (A3's derivation; Y2's check) | Y2 §3.5 |
| **CAL-DISK** (Y2-DISK; YB2-DISK) | `[Polymath2021]` Fig. 10 transcribed by eye before any solve; `r² = (25 + 9√5)/10` reproduced; 26 tiles valid, every tile of diameter exactly 1 | ACCEPT 71/71, exact | **two rebuilds, identical** (26/26 tiles, every piece), **two checkers** (Y's; YB2's tower checker); shared reading assumptions | Y2 §4–5; YB2 §3–6 |
| Y2-DISK-KINDS / YB2-ARCS | 20 unit arcs, all both (self), four at each corner `A_k` of the central Reuleaux pentagon, arc-closed | exact | two, one blind | Y2 §5.3; YB2 O1 |
| Y2-DISK-S1 | the disk realises (S1) arc-closed | exact at vertices, float-located seam points | one checker | Y2 §5.3 (d) |
| Y2-BUDGET2 | C-UA-BUDGET branch 2 FALSE in the disjoint sense too | exact | one (Y2) | Y2 §5.3 (e) |
| **Y2-STOP / YB2-SAME** | both positives stop at the unsaved second common unit point of a close complementary trivalent pair saved at a four-colour centre at its first | TRUE | two, one blind | Y2 §5.3 (f); YB2 O2 |
| YB2-RIM | the disk's colourless rim points are exactly the ten `C_k`, `D_k` (108° cones) | exact | one (YB2) | YB2 O1, D2 |
| YB2-Q | outside points `Q_k` (radius ≈ 2.16253): colourless cone `(54°, 198°)`; `Q_k` itself colourable | exact | one (YB2) | YB2 O2, D6 |
| Y2-PIN | at each stop each own tile realises its diameter toward a pair member; an outward wedge bare | TRUE; **the strip's wedge corrected** (item 54) | two (Y2; YB2 sighted, D1) | Y2 §6.1 |
| Y2-FORCE / YB2-FORCE | the strip's valley and apex sectors forced by the midline quadrants up to one free direction; no such freedom unblocks `Q` | TRUE | two, one blind | Y2 §6.5; YB2 O4 |
| **Y2-MOVE / Y2-WEDGE / YB2-MOVE** | the tactic's move at the disk's corner is valid, new arcs of kind **in** (self; not arc-closed), the bare wedge 108° → 36°; **the dial stalls** | exact | two, one blind | Y2 §6.2–6.3; YB2 O3 |
| Y2-SLACK | the `R_k \| U_k` boundary is not locked | exact | one | Y2 §6.6 |
| Y2-DISK-R / YB2-DISC | no vertex-centred disc beyond `φ` in any extension; **φ attained** by a valid extension | exact + hand | the bound two; attainment one (YB2) | Y2 §5.3 (g); YB2 O5, D3 |
| Y3-STRIPCUT | cutting `C_{−1}`, `C_2` along `ω(Q)` fails (free set `{4}` at 15 named points; the valley's forced sector) | exact + case split | one (YB3 pending) | Y3 §2.1 |
| Y3-DISK-T* | Y2's GAP answered NO: the blocker is `T2_0`'s corner `Y_0`, not `Z^L_0` | exact + hand | one (YB3 pending) | Y3 §2.2 |
| Y3-LEG | the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2 = Z^L_0 − (1, 0)` | exact | one (YB3 pending) | Y3 §2.2 |
| Y3-END-A, -B | a finite stuck chain with the equality pencil (radii 3, 2, 1 about `N`), `N` completed two ways, valid over ℚ (43/43, 47/47); `N` not terminal in either | exact | one (YB3 pending) | Y3 §3.2 |
| Y3-END-NEEDS | keeping `E` stuck and `N` terminal needs a seventh colour: no terminal unit-arc end while `E` has three colours; exceptions (i)–(iii) | GAP-graded claim, one mind | one (YB3 pending) | Y3 §3.3 |
| Y3-R1 | R1 as arithmetic; "finitely many radii ⟹ no one-sided chain; length `≤ 3V + 3`" | TRUE for periodic maps; **as stated on the map rather than its terminal modification, the same imprecision N3 corrected** (N3-PER needed; N3-ALPH otherwise) | one (YB3 pending) | Y3 §1.4 |
| Y3-R3 | every held close complementary pair is saved at one point by half of T2; at both exactly for rhombus completions; the unsaved points are the stops | reading of exact results | one (YB3 pending) | Y3 §4.1 |
| Y3-T2-BUDGET | T2-at-both partners of a trivalent `u` are `w_i + w_j − u`, at most three | TRUE (hand) | one (YB3 pending) | Y3 §4.2 |

### 1.3 The claim list's ids

| id | verdict | minds |
|---|---|---|
| C-UA-WEDGE | MISSTATED; corrected (inner colour facing, outer away, side cones empty) TRUE | three (N; NB, blind; YB, blind) |
| C-UA-BUDGET branch 1 | TRUE | three (A4; N; NB) |
| C-UA-BUDGET branch 2 | FALSE as stated in both senses — union (the strip's `P_1`: Y; YB blind) and disjoint (the disk's `A_0`: Y2, one); its corrected form (NB4′'s orbit statement) TRUE | two + one |
| C-UA-INC | all four kinds consistent locally; held exactly: **both** (strip, disk), **in** (the moved disk, Y2-MOVE); up to N2-RED only (Q) and (R2) survive | exact; the reduction two |
| C-UA-CHAIN | GAP at "each unit arc forces a further unit arc"; killing test (a closed cycle) not fired; bi-infinite periodic chains held (YB-CHAIN) | two |
| ARC-INERT | TRUE, sharper (no exceptional interior points); its end-vertex GAP closed by N2-TOWARD | two, one blind (+ N2-TOWARD's two) |
| C-SEAMS-TWO | MISSTATED; **filed (item 30): NB's unconditional correction** (at a close covering pair the seam point lies in the closure of a unit arc centred at `u` or `v`, or is a vertex of `≥ 4` colours) and **N's as its corollary up to reduction** (one species, a `≥ 4`-colour both-centre, plus R2), now over N2-RED (two minds) and N3-NOBOTH | NB one; N's corollary two over RED |
| C-V4-K | a four-colour vertex with its whole ring is realised exactly (the strip's `P_1`, the disk's `A_k`) | exact, two rebuilds each |
| C-V56 | N112-SIX (the boundary circle forced); de Grey's covering step GAP (= his `[08.16]` merge, NB) | two |
| C-BEYOND | TRUE given CAL-STRIP (1.834) and CAL-DISK (vertex-centred steps: `φ`, Y2-DISK-R / YB2-DISC) | two |
| C-LOCAL | GAP (no explicit `R` for a NO; N3-DENSE3's radius 3 is explicit and not a NO) | two |
| C-ARC-END | realised arc-closed: T2, the four-colour vertex (strip), (S1) (disk) | exact |
| C-HOCK | declined as mis-aimed (no held valid object has an arc of radius `< 1` between two tiles) | Y2; Y3 |
| CAL-7 | ACCEPTed by all three checkers (Y on the hexagonal seven-colouring and, Y2-D3, on row 33's brick; YB; YB2) | exact |
| CAL-FRAGS | reproduced: Y's checker 390 pairs, YB2's 1,663 pairs against the frozen FS-110 checker, 0 disagreements | exact |
| Killing test 8 | every NO route has its step past the strip named: N3-BASE reads `B̄(u, 2)`, which no trichromatic vertex of the strip holds; DENSE3 holds on both positives | two |

### 1.4 Divergences, and how each settled

| round | pair | divergences | of truth | settlement |
|---|---|---|---|---|
| 1 | N / NB | 15 | **#4**: N's l. 231 ("do not exist") FALSE and an unnamed GAP in RED; #1 (FLANK) went the side's way; #2 ("T2 realises NB-4's exception") withdrawn — FS-110's fragments are below NB-4's reading radius | NB §2.3; closed by N2-TAN |
| 1 | Y / YB | 12 | none (no object or verdict differs); D1 label slip `P_2`→`P_3`; D3 CAL-7's object; D4 map hypothesis (confirmed exact on the strip); D8 the thin rhombus | YB §5 |
| 1 | N / Y (card W) | 6 | W1 (ii): Y's "the bound is used" against N and NB — Y2 retracted (γ) (retraction 4) | A3-1.3; Y2 §3.2 |
| 2 | N2 / NB2 | 12 | none; NB2's DENSE sharper (filed, item 44); three of NB2's own corrections (#2, #8, #10) | NB2 §2.3 |
| 2 | Y2 / YB2 | 11 | **D1**: the strip's colourless cone is `(arcsin ¼, 180° − arcsin ¼)`, not `(30°, 165.52°)` — a divergence of truth in a quantity; D2, D3 coverage (completeness of the rim; φ attained) | YB2 §6 |
| 3 | N3 / NB3 | 16 | none of truth. #1 NB3's GAP on N3-I retracted (a gap in its route); #2 N3-END's first alternative MISSTATED as a case description; #3 N-E2 step owed at item 3; #7 the named check done, N3-COR3 a dependency of Prop. 17's row; #14 LEN's bound `2\|K\| − 3`; the rest routes, precisions, wording | NB3 §2.2 |
| 3 | Y3 / its record | — | 1.5 below | — |
| 3 | Y3 / YB3 | pending | stage 1b | — |

**Retractions** (counted as each record states them): N 1, NB 3, N2 2 (conceded), NB2 3, N3 0, NB3 1 — proof side 10; Y 3 (free), YB 0, Y2 1 (free)
and one lost plant registration (`move_wrongside`), YB2 0 (three self-test repairs, its own), Y3 0 — construction side 4; advisors A 1 (free: ARC-INERT's
first argument) and one citation slip (FS107-VW l. 70 cited as a verdict), A2 3, A3 1. Every retraction after a blind commit was the verifier's own; no side retracted a theorem a verifier had confirmed.

### 1.5 Round 3 compared (in place of an advisor)

**N3 against NB3, in full.** No divergence of truth (1.4). Every N3 statement is TRUE at two minds, one blind, with routes differing at FAIL, ANTI,
COR3, the strip and the eleventh point. The one MISSTATED text is N3-END's body (its first alternative carries structure its proof does not derive:
corrected, NB3 §2.2 #2). The named check (FS-110's N2-ROT, N2-HEX under P17) is done by NB3 and adds N3-COR3 as a dependency of the base's Prop. 17 row.
**Selection audit (G21):** both halves of the round flatter the NO. The checks spent against it, recorded: NB3 pushed N3-I until it failed (its GAP, then
N3's perturbation); pushed N3-END's `z = y` case through horn flanks; checked COR3 for both arc orientations and both doubles (tools); named the inert-arc
case as the one place the base, read literally, breaks — closed only by a modification (N2-TOWARD). **The residue both walks share, unre-derived here:**
S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE (row 134's grade), with N112-U1 and N2-TOWARD (two minds each) — a common error would sit there
(NB3 §2.3).

**Y3 against its record.** Every table row matches its section (Y3 §1.4–4.2). Its grades are one mind throughout (tools exact where stated); its one
disagreement with Y2 is recorded, not rewritten (§2.2: the blocker is `Y_0`); its slips are its own (§4.3). Two scope points, for stage 1b and the
derivation file:
1. **Y3-R1 item 3** applies the finite alphabet to "the map"; a stuck chain lives in the terminal modification, so the premise is on `M*` (N3's
   correction). For doubly periodic maps it holds by N3-PER (two minds); for a non-periodic map with finitely many radii it is GAP N3-ALPH. Y3's
   "in particular every map periodic in two independent directions" is TRUE; "finitely many radii" in general is not derived.
2. **Y3-END-NEEDS reaches further than N3-END**, not against it. Frames matched (Y3's top end `E`, centre `N`, flanks `x, x′` and `y` ↔ N3's bottom end
   `P_0`, `P_{−1}`, flanks `y, y′` and `z`): Y3's level 1 = N3-END items 1–2 (two sectors of the far flank at the centre, horns by no-MERGE); Y3's level 2
   = N3-END item 3 sharpened (`x ≠ x′`, so `≥ 5` colours at the centre, where N3/NB3 count four); Y3's level 3 continues past N3-END item 4 (both flanks
   of the centre's horn must shadow it; at `N + n` two further distinct colours are needed; six are used) to **no terminal completion**. N3 says the end
   is "not excluded by the local calculus; anchored" — a weaker statement, not a contrary one. **If Y3-END-NEEDS holds, horn-bound-`±1` chain ends do
   not occur in a terminal map**, and every finite chain ends at an NB4′ exception or row 8's configuration. Two points YB3 should decide (named here,
   not bridged): Y3's setting excludes FLANK's in-type exception at `N`, which N2-FLANK-Q keeps — the count still closes if the lower flank is then `g`
   (five colours used, one free, two distinct places needed), but Y3 does not say so; and Y3's corollary "a periodic terminal map has no stuck chain at
   all unless an end vertex is a four-colour vertex" omits chains whose next point is an NB4′ exception without a horn bound `±1`.

**The sides met at the pinned corner — N3-COR3 is the construction side's stop, seen from the proof side** [a reading, one mind: this close; each half
two minds, one blind]. N3-COR3: in a valid map, both common unit points of a close complementary pair of cubic trichromatic vertices are four-colour
vertices at which both members emit arcs (T2 at both). Y2-STOP / YB2-SAME: both positives stop at the second common unit point of a close
complementary trivalent pair saved by a four-colour centre at its first. So each positive holds a pair N3-COR3 says no valid map can hold with only
one four-colour corner, and stops exactly at the missing corner — the strip's `(V, A)` pairs at `≈ 0.757` (twelve per period, YB-SEAMS) at the edge
vertex, the disk's `(B_k, Z^R_k)` at `C_k`. A3 predicted the meeting ("the next comparison scores the two sides at the same point", A3-3.5). With
Y3-T2-BUDGET (one mind) it gives, **for every valid map**: every close complementary cubic trichromatic partner of a cubic trichromatic `u` is the
fourth corner `w_i + w_j − u` of a unit rhombus on two of `u`'s at most three leaving centres, so `u` has at most three such partners [hand, one mind:
this close, over N3-COR3 (two, one blind) and the count "at most three leaving centres" (N3-3's frame; Y3 §4.2 item 1)]. The strip's printed colouring
violates it (Y3 §4.2 item 3), which is why the strip cannot be a map.

**The registrations of round 3, scored.** N3-P1 (0.9) **met** for every pair whose rhombus lies in the open strip (`(V_m, V′_m)`, `(A_j, A′_j)`: both
corners four-colour midline vertices, YB-SEAMS, Y3-R3); the `(V, A)` pairs' second corner is the edge vertex, where the strip stops — consistent with
N3-COR3, no refutation. N3-P2 (0.6) **met** (NB3; no row repaired). N3-P3 (0.8) **untested**: no held positive has an (R2) arc (all arcs both; the moved
disk's are in). N3-P4 (0.75) **not met**: the strip's `(V, A)` pairs are close complementary cubic trichromatic pairs that are not mirror pairs; their
second corner is off the midline, on the edge (the stop) — the outcome N3 named as reachable, read as a strip's boundary rather than as a refutation.
N3-P5 (0.85) **pending**: Y3's fragments are not terminal at `N` (a MERGE in END-A, a SHAVE in END-B) and Y3 derives that no terminal completion
exists (YB3 pending); END-A's `N` has three colours with one repeated, END-B's five.

### 1.6 The composition of the two gaps (derived; the brief's question)

**Notation.** For a valid map `M`: `F(M)` its vertices of `≥ 4` colours, `R(M)` its vertices carrying a repeated colour; `M*` a terminal valid
modification (N2-TERM); `K` the set of signed curvatures in `[−1, 1]` of `M*`'s arcs, with 0.

**Links held** (each at its grade): (L1) N3-DENSE3 on any valid map, so on `M*`: `F(M*) ∪ R(M*)` meets every closed disc of radius 3 [two, one blind].
(L2) N2-TERM item 2: a vertex of `M*` with `≤ 3` colours and a repeated colour is stuck [two, one blind]. (L3) N2-TERM item 3 with N4-FIN: a stuck vertex lies
on a stuck chain along its normal line that is not bi-infinite [two, one blind]. (L4) **The next point beyond each finite end of a chain has `≥ 4`
colours**: the chain stops where N4-STUCK (iii)–(iv) fail (N2-4: an in-type flank tile at `N`, then `N` is a (Q) centre, `≥ 4` colours by N2-RED; an arc
of `ω(v)` through `N`, then `\|P_cl(N)\| ≥ 4`, NB §2.3 #10, one mind; an NB4′ exception at `N`, `≥ 4` by definition), or at a horn bound `±1`, where N3-END
puts four colours at the centre one step beyond [two, one blind]; and where (iii) holds the antipode carries a repeated colour, so in `M*` it is stuck or in
`F` (L2). [The assembly one mind, this close; its links two minds, one blind, except row 8's count, one.] (L5) N3-PER, N3-LEN: if `M` is doubly periodic,
`M*` is periodic, `K` is finite, every chain has at most `2|K| − 3` vertices, and no one-sided chain exists [two, one blind].

**The composition.**
1. **The global step in N3-DENSE3's form is the NO for every valid map, periodic or not, and needs no ray step.** By (L1) every valid map has its
   `F ∪ R` within 3 of every point, so "no valid map in which a vertex of `≥ 4` colours or a repeated colour lies within 3 of every point" is equivalent to
   "no valid map". It is the NO restated with a proved property every counterexample carries (G79's example invariant), not a smaller step. [hand; (L1)
   two minds, one blind; the equivalence trivial]
2. **The ray enters only when the global step is attacked in its four-colour form** — "no valid map whose vertices of `≥ 4` colours come within `R` of
   every point" — because the repeated-colour vertices of `M*` that are far from `F` are exactly the stuck vertices of long or infinite chains (L2–L4).
3. **For doubly periodic maps the NO reduces to the four-colour form with no ray step and no third step** [hand, one mind: this close, over (L1)–(L5)]:
   each point is within 3 of `F(M*) ∪ R(M*)` (L1); a stuck vertex lies on a finite chain of at most `2|K| − 3` vertices whose two ends each have an
   `F`-vertex one step beyond (L3–L5), so it is within `|K| − 1` of `F(M*)`; hence `F(M*)` meets every closed disc of radius `|K| + 2`. (For a periodic map
   this is also "`F(M*)` is non-empty": a non-empty periodic set is relatively dense.)
4. **For aperiodic maps the four-colour form needs two steps beside it, not one.** (b′): no one-sided stuck chain in a valid terminal map (N2-RAY,
   N3-RAYR: such a ray needs arcs of every radius `≥ k + 1`). **And a third, named here: GAP (b″), a uniform bound on the length of finite stuck
   chains** — a map with infinitely many arc radii can carry finite chains of every length (the recursion allows `λ_k ≥ −1/(k+1)` from one end and
   `υ_k ≤ 1/(L − k + 1)` from the other, compatible for every `L`; Y3-END-A realises the pencil for `L = 3`), and then `F(M*)` is not relatively dense even
   with no ray; N3-LEN bounds lengths only for a finite alphabet, and N3-ALPH is open even there. A compactness argument at bounded `K` (W-EQ-K's
   Hausdorff limit) would turn long chains into a ray only if terminality and the stuck structure pass to the limit, which no record derives.
5. **What each successor decides.** FS-114 (the global step) in N3-DENSE3's form: decisive alone, for all maps. FS-114 in its four-colour form:
   decisive alone for periodic maps (every YES by formula); for aperiodic maps — the limit objects W-EQ-K produces, which a NO of Q-full_K must cover —
   jointly with FS-115's (b′) and (b″). **Y3-END-NEEDS, if YB3 confirms it, removes horn-bound-`±1` ends from terminal maps** and so narrows (b′) and
   (b″) to chains ending at NB4′ exceptions or row 8's configuration.

**In one sentence** [hand; the links two minds, one blind, the assembly one mind (FS112-C)]: *every valid six-map with unit arcs has, in its terminal
modification, a vertex of `≥ 4` colours or a repeated colour within 3 of every point, and its repeated-colour vertices away from four-colour vertices
lie on stuck chains each finite end of which is one step from a four-colour vertex; so the NO is exactly the global step in that form (with no ray step),
it reduces for doubly periodic maps to excluding four-colour vertices within `|K| + 2` of every point, and for aperiodic maps that four-colour form needs
both the stuck ray (b′) and a uniform bound on finite chains (b″) beside it.*

### 1.7 Carried to stage 1b and to the derivation file

- Stage 1b (on the owner's message): Y3 against YB3 — STRIPCUT, DISK-T*, LEG, END-A/-B, END-NEEDS (with 1.5's two scope points), T2-BUDGET, R3, R1.
- Errata the derivation file carries (side records never rewritten): N's l. 231; N's row 9 (two counts); N3-END's first alternative and item 3; N3-LEN's
  bound; N3-BASE's Prop. 17 row (+ N3-COR3); N112-RED's merge (unneeded at cubic centres, N3-NOBOTH) and CE5's step (in-votes, N3-ANTI); Y112-NB4-MIS's
  (γ) withdrawn; the strip's stop cone; the label `P_2` → `P_3`; Y2 §6.4's blocker (`Y_0`); A3-2.3's second reason; the degree-4 sketch's author (Gibbs).
