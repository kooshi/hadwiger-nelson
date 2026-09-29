# FS121-V2 — a blind second mind on three round-2 claims of FS-121's list (DB1-L3, FS121-D1-VT, FS121-D1-EROSION)

*Job FS121-V2, Ephodos in its verification form (Opus 5.5), launched 2026-09-29 06:30 UTC (start-up HEAD `2303e0a1`). Brief:
`data/fs121/briefs/FS121-V2-verify.md` with `plans/STANDING-RULES.md`. Working files `data/fs121/v2/`; exact checks `tools/fs121_v2_*.py`.
Resuming check: no record and an empty `data/fs121/v2/` existed at start, so this is a fresh start. The three statements are derived from the
frozen list alone (`data/fs121/claims.md` §§ 0, 1, 5) and from the open homes of its definitions; the first derivations are opened only after
my verdicts are committed. `e(φ)` is the unit vector at angle `φ`; a colour **occupies** a sector when the sector is a.e. that colour.*

## Theorems this phase proved

*(Filled at the verdicts' stage.)*

## Would-have-searched-here log (standing rule 5)

| move I would have made by search | what I did instead |
|---|---|
| — | — |

## Fence log (standing rule 8)

1. **The harness's start-up context** (not a command of mine) carried the auto-memory index (under `~/.claude/projects/`, fenced): milestone status
   lines about FS-111, FS-114 and earlier, nothing about FS-121's or FS-116's routes. It also carried the start-up git status, which printed the
   **names** `plans/FS116-Y1-construction.md` (modified), `data/fs116/y1/notch.out`, `data/fs116/y1/notch-plant-high.out`, `tools/fs116_y1_notch.py`
   (all FS-116's, fenced), and five commit subjects (`FS-116, FS-121: round 2 additions and briefs`, `FS116-N1: report`, `FS116-Y1: stage 2`,
   `FS116-N1: stage 3`, `FS121-DB1: report`). Names and subjects only; nothing opened.
2. `ls data/fs121/` (01:31) printed the **directory names** `briefs d1 d2 d3 db1 o1 reports v2`. Names only.
3. `ls plans/FS111-* …` (sizing the open reading) printed the **name** `plans/FS111-W-wild.md` (fenced). Not opened.
4. `grep -n 'NOREP\|…' plans/FS111-derivation.md` (open) printed, from the open entries W-HULLREG-MAPS and W-KB-DIR, the lines "FS111-W-NOREP (no
   repeated colour at a vertex, so no bichromatic vertex)" and "Rests on it: FS111-W-NOREP case (ii); …", and W-NOREP's own `model:` line. Open text,
   logged because it hints at W-NOREP's route (a case (ii) that uses W-KB-DIR). I chose **not** to read W-NOREP's entry body (lines 485–498 of the
   open file) before my verdicts, to keep my route on DB1-L3 my own.

## Stage 1 — SAVED: the readback, what I was given, and the registered expectations

### 1.1 Files read before any derivation, in order

My brief; `plans/STANDING-RULES.md`; `.claude/agents/ephodos-verifier.md` (head); `data/fs121/claims.md` in full; `data/fs111/claims.md` in full;
`plans/FS111-M-regularity.md` §§ 2–4 (saturation, M-SATC, M-R7, M-DEADLOCK, M-PINCH, M-C11, M-EXTREME, M-HALF, M-POLAR, REG-J); `plans/FS111-M2-regularity.md`
§ 4 (M2-INTRAD, M2-REDUCE-A, DISCK7); `plans/FS111-derivation.md` entries M-PINCH to M-C11, W-NOBEND, W-HULLREG-MAPS to M-REDUCE-I, W-NEG to W-HEXSAT,
M2-INTRAD, M2-REDUCE-A, M4-LADDER to M4-MOVE and the named gaps (not W-NOREP's body); the example verification record of the gate.

### 1.2 Quotation check (standing rule 3)

`tools/fs121_v2_quotes.py` compares the brief's three quotations with `data/fs121/claims.md` § 5 character for character: **3 of 3 verbatim**
(`data/fs121/v2/quotes.out`); its plant (one prime dropped from the first quotation) makes it report a mismatch and exit 1
(`data/fs121/v2/quotes-plant.out`). The two held inputs I lean on, FS111-M-PINCH and FS111-M2-INTRAD, are verbatim in the list's § 1 against their
`statement:` lines in `plans/FS111-derivation.md` (whitespace-normalised comparison, 2 of 2). The brief's sentence "no held saturated colouring has a
curved tangent interface at any number of colours" is its own words, not a quotation; it matches the list's C121-OUT line ("**none held for the curved
case at any `k`**"). No mismatch to report.

derivation: FS121-V2-QT
  statement: the brief's quotations of DB1-L3, FS121-D1-VT and FS121-D1-EROSION are character for character the frozen list's § 5 lines
  uses only: the two files as committed at 165466d8
  not claimed: that the list's § 5 lines are verbatim in their proposing records (fenced from me until my verdicts are committed)
  argument: § 1.2 Quotation check (standing rule 3)
  verdict: derived
  grade: computed over: {DB1-L3, FS121-D1-VT, FS121-D1-EROSION}, each quoted line compared with its § 5 line
  minds: 1
  model: the brief and data/fs121/claims.md at 165466d8
  prior art: known: not a mathematical claim — a readback
  handoff: none — a readback for the coordinator

control: fs121-v2-quotes
  of: FS121-V2-QT — the three quotations, compared exactly; the fault drops one prime from the first
  run: python3 ../tools/fs121_v2_quotes.py | tail -1
  expect: 3 of 3 verbatim
  fault: python3 ../tools/fs121_v2_quotes.py --plant | tail -1

### 1.3 The statements, restated (verbatim, `data/fs121/claims.md` § 5)

- **DB1-L3**: "in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever
  cusps are present at the point or elsewhere *Not claimed:* that a colour cannot occupy a sector and a cusp, or two cusps, at one point; anything without
  REG-J′"
- **FS121-D1-VT**: "in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b
  that is not a unit arc curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point
  of I, no interface arc ends at Y from the far side of L *Not claimed:* anything at the image of an endpoint of I (the far-side colour may change there);
  anything when I is a unit arc curving toward b (L is a point, the (Q) or (R2) end); anything with cusps (NOREP's hypothesis)"
- **FS121-D1-EROSION**: "in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π)
  and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the
  two pieces has a point of Σ at distance cot(θ/2) from z *Not claimed:* anything for curved edges (their partner curves cross elsewhere, and
  FS121-D1-VT still forbids the crossing at images of interior points); anything at θ ≥ π; anything with cusps"

### 1.4 Terms, and the one I asked about

*Sectors.* Under REG-J′ a point `z ∈ Σ` meets finitely many interface arcs, and a small disc about `z` meets no other essential boundary; the arcs cut it
into finitely many curvilinear sectors, each a.e. one colour, each with an angle at `z` read from its two bounding arcs' tangents (0 for a cusp-shaped
sector). *Interface arc* (my reading, sent to "main"): a maximal `C¹` chain of segments and circular arcs of essential boundary between points of Σ
(M2-INTRAD's sense). *"Ends at Y"*: an arc through `Y` counts as two arcs ending at `Y`, one from each side of `L` (sent to "main").

**Asked of the author, 2026-09-29 06:38 UTC, by message to "main":** which reading of "cusp-free" VT and EROSION mean — **(G)** no sector of angle 0 at
any point, or **(Σ)** no point of `supp S_j` at which `S_j` has density 0 (Σ's cusps). They differ exactly at a zero-angle region of a colour `a` at a
point where `a` also occupies a sector of positive angle. Until the answer comes I work both readings.

**Answered by Keryx, 2026-09-29 (received after § 1.6 was written, before stage 1's commit): reading (Σ).** Keryx quoted the author's header
definition only, verbatim: "*cusp-free* — no colour has density 0 at any point of its support (C121-CURVED's "no colour of density 0 at any point")"
(`plans/FS121-D1-proof.md`, header, ll. 6–7), and noted that the list's own C121-CURVED uses the same phrase. My verdicts are given under (Σ); where
the verdict under (G) differs I record it too. My two further readings are not defined by the author: I work them as stated and say where a verdict
depends on them.

### 1.5 What I was given (the `given:` line, dated)

The three statements verbatim with their *not claimed* lines; the list's definitions (§ 0) and held inputs (§ 1) with their grades and mind counts;
the list's round-2 source notes, which say VT and EROSION were "proposed at round 1" in a record I may not read, and EROSION's own *not claimed* line,
which names FS121-D1-VT as what "forbids the crossing at images of interior points" — **so the statement itself tells me VT is EROSION's intended
lever, and that EROSION is about partner curves crossing** (given, not brought); VT's *not claimed* line names "NOREP's hypothesis" for cusps, and
DB1-L3 is described in my brief as the step that "localises" W-NOREP — **so I was told the three are linked and that DB1-L3 extends W-NOREP past
cusps**. From the open FS-111 records: the definitions of saturation, M-PINCH's two cases and their contacts, M-C11, M-HALF, M-POLAR, M2-INTRAD's
unit-parallel mechanism, the controls R7, SQ9, HEX9, and the fact (open, from W-KB-DIR's entry) that W-NOREP has a case (ii) resting on W-KB-DIR.
No verdict of any other mind on these three statements was given to me. I knew nothing of this result or its literature before the brief.

### 1.6 The registered expectations (before any written derivation)

**An honest note on timing.** While reading the definitions (§ 1.1) I sketched in my head an argument for DB1-L3 — the contacts at `z` inherited as
limits from the two edges of one sector, and the component lemma (C-HULL's first clause) forcing both sectors of the colour to one closed side of
each edge's tangent line. So DB1-L3's prediction below was written **after** a mental sketch and is informed; VT's and EROSION's were written after
parsing them and seeing how they hang together, before any derivation of their own.

| statement | predicted verdict | probability | likeliest break |
|---|---|---|---|
| DB1-L3 | derived (TRUE) | 0.85 | an interface arc at `z` without a tangent there (pieces of radii → ∞ accumulating at `z`), or a sector whose edge arcs' normals do not carry a contact of the sector's colour to `z` |
| FS121-D1-VT | derived (TRUE) under reading (G) of "cusp-free"; GAP under reading (Σ) | 0.55 for TRUE as stated (either reading accepted) | a zero-angle region of `a` between `L` and an arc tangent to `L` at `Y`, which reading (Σ) does not exclude; or an `I` that is a chain containing a unit-arc piece curving toward `b` (its image collapses to a point of Σ although the statement excludes only a whole unit arc) |
| FS121-D1-EROSION | derived (TRUE), over VT | 0.5 | the far-side bookkeeping at the crossing of the two inner partner lines (which half of one line lies on the other's far side), or a straight piece whose outer colour changes before distance `cot(θ/2)`, so that the piece is not one interface arc |

*Stage 1 ends here; derivations follow in stage 2.*
