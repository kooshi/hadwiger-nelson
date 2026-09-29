# FS121-V2 — a blind second mind on three round-2 claims of FS-121's list (DB1-L3, FS121-D1-VT, FS121-D1-EROSION)

*Job FS121-V2, Ephodos in its verification form (Opus 5.5), launched 2026-09-29 06:30 UTC (start-up HEAD `2303e0a1`). Brief:
`data/fs121/briefs/FS121-V2-verify.md` with `plans/STANDING-RULES.md`. Working files `data/fs121/v2/`; exact checks `tools/fs121_v2_*.py`.
Resuming check: no record and an empty `data/fs121/v2/` existed at start, so this is a fresh start. The three statements are derived from the
frozen list alone (`data/fs121/claims.md` §§ 0, 1, 5) and from the open homes of its definitions; the first derivations are opened only after
my verdicts are committed. `e(φ)` is the unit vector at angle `φ`; a colour **occupies** a sector when the sector is a.e. that colour.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| FS121-V2-QT | the brief's three quotations are verbatim in the frozen list (3 of 3; plant fires) | [tools] | § 1.2 |
| DB1-L3 | TRUE: at a point of Σ no colour occupies two sectors of positive angle, whatever cusps are present | [hand, one mind, blind] | § 2.2 |
| **FS121-V2-SECTOR** | stronger: a colour with a sector of positive angle at a point of Σ occupies no other region there, not even a zero-angle one; only "two cusps" of one colour survives DB1-L3's *not claimed* line | [hand, one mind] | § 2.3 |
| FS121-D1-VT | TRUE wherever `L` is `C¹` at `Y`; at a corner of `L` (an interior radius-1 piece of `I` curving toward `b`) TRUE under reading (W), GAP under reading (B); cusp-freeness used only at `Y` for `a` | [hand, one mind, blind] | §§ 2.5–2.6 |
| FS121-V2-VT-W | FS121-D1-VT corrected: reading (W) named, the terminal radius-1 piece excluded | [derived, one mind] | § 2.10 |
| FS121-D1-EROSION | TRUE, by § 2.5's argument at the crossing of the two inner partner lines (needs no corner case) | [derived, one mind, blind] | § 2.8 |
| FS121-V2-EROSION-DIAM | in every a.e.-proper colouring `min(L₁, L₂) ≤ 1/(2 sin(θ/2))`, so EROSION's first disjunct is automatic for `θ ≤ 2π/3`; its content lies in `(2π/3, π)` | [hand, one mind] | § 2.9 |

## Would-have-searched-here log (standing rule 5)

| move I would have made by search | what I did instead |
|---|---|
| search for a saturated colouring with an interface chain holding an interior radius-1 piece curving toward `b`, to decide FS121-D1-VT under reading (B) | worked the corner by hand (§ 2.6); reported GAP under (B), derived under (W) |
| search for a colouring with a double `a`-horn at `Y` (FS121-D1-VT with cusps) | wrote the local configuration by hand and checked it against Lemmas C and H (§ 2.7); not built, not excluded |
| search for a saturated colouring with a sector of angle in `(2π/3, π)` and long straight edges, to realise EROSION's second disjunct | derived what it would need at the crossing: a four-colour point with T-junctions at `p₁`, `p₂` (§ 2.9) |
| sweep sector angles numerically for the angular lemma | an exact half-degree grid as a control only (`fs121-v2-sectors`); the lemma itself by hand |

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

## Stage 2 — SAVED: the three derivations, the attacks, the verdicts

*Written 2026-09-29 06:40–07:10 UTC, blind: none of the first derivations has been opened. Two readings were fixed by Keryx during this stage (§ 1.4
and § 2.6): "cusp-free" in sense (Σ); "the far side of L" at a corner of `L` left undefined by its author, so both readings are worked.*

### 2.1 Three lemmas the derivations share

Throughout: `f` honest, a.e.-proper, in D-NF, saturated, satisfying REG-J′. `z` is a point with the fan structure of § 1.4: a disc `B(z, r)` whose
only point of Σ is `z` and in which the essential boundary is the finitely many interface arcs at `z`; every region of the fan is an open set a.e. of one
colour, hence contained in that colour's density points. For a region `W` at `z` and a direction `v`, `v ∈ D(W)` when `z + tv ∈ W` for all small `t > 0`;
a region of positive angle has `D(W)` an open arc, a zero-angle region has `D(W) = ∅` and a tangent direction `φ` (it contains points `z + tφ + O(t²)`).

**Lemma C (the component lemma; FS111-C-HULL's first clause, re-derived).** If `C ⊆ S̃_j` is path-connected and `d̄_j(x) > 0`, then `C ⊆ B(x, 1)` or
`C ∩ B̄(x, 1) = ∅`.
*Proof.* Otherwise `C` has a point with `|c − x| ≤ 1` and one with `|c′ − x| ≥ 1`; a path in `C` between them meets a point `p ∈ C` with `|p − x| = 1`.
Put `e = p − x`, `R_φ` the rotation by `φ`. For `|φ| < ρ` and `u ∈ S_j ∩ B(x, ρ)`, the point `u + R_φ e` lies in `B(p, 2ρ)`, and for fixed `φ` the set of
`u ∈ B(x, ρ)` with `u + R_φ e ∉ S_j` has measure at most `|B(p, 2ρ) ∖ S_j| = o(ρ²)` (`p` is a density point). So the pairs `(u, φ)` with `u` and
`u + R_φ e` both in `S_j` have `Leb ⊗ dφ` measure at least `2ρ(|S_j ∩ B(x, ρ)| − o(ρ²))`, which is positive along a sequence `ρ → 0` (`d̄_j(x) > 0`).
These are pairs at distance exactly 1 in one class, a set of positive `Leb ⊗ σ` measure: `f` is not a.e.-proper. ∎

**Lemma H (both in or both out).** Let `W, W′` be regions of colour `a` at `z` (so `z ∈ cl W ∩ cl W′`) and `y ∈ supp S_a` with `|y − z| = 1`,
`u = y − z`. Then either `D(W), D(W′) ⊆ {v : v·u ≥ 0}` (both *in*) or both `⊆ {v : v·u ≤ 0}` (both *out*); for a zero-angle region read its tangent
direction `φ` in place of `D`. Moreover if `W ∩ B(y, 1) = ∅` then both are out, and if `W ⊆ B(y, 1)` up to a null set with `|W ∩ B(y, 1)| > 0`
then both are in.
*Proof.* `S_a` has positive measure in every ball about `y`, so there are `q_n ∈ S̃_a ∖ T₁(z)` with `q_n → y`. By Lemma C each of `W, W′` is in
(`⊆ B(q_n, 1)`) or out (`∩ B̄(q_n, 1) = ∅`) for `q_n`. If one is in and the other out, `z ∈ cl W ⊆ B̄(q_n, 1)` and `z ∈ cl W′ ⊆ ℝ² ∖ B(q_n, 1)`, so
`|q_n − z| = 1`, excluded. So both have one type along a subsequence. In: `W ⊆ B̄(y, 1)`, and `|z + tv − y|² ≤ 1` gives `v·u ≥ t/2`, so `v·u ≥ 0`;
for a zero-angle region `|z + tφ + O(t²) − y|² ≤ 1` gives `φ·u ≥ −O(t)`. Out: the same with the inequalities reversed. If `W ∩ B(y, 1) = ∅`,
"in" along a subsequence would put the open set `W` inside `T₁(y)`: impossible; so both are out. If `W` meets `B(y, 1)` in positive measure,
"out" would give `W ∩ B(y, 1) = ∅`: so both are in. ∎

**Lemma T (edges and their contacts).** Let `γ` be an interface arc at `z` between colours `a` and `c`. (i) `γ` has a unit tangent `τ` and normal `n`
at `z`, the limits of those along `γ`. (ii) `z ± n ∈ supp S_a` for at least one sign; more precisely, if `γ` is of tangent type the `a`-contact is on
`c`'s side (`z + n_c`, `n_c` the normal into `c`); if `γ` is a unit arc of kind both, the `a`-contact is its centre, `z ± n`.
*Proof.* (i) Points of `γ` near `z` are off Σ, so (M-C11, held through M-PINCH) `γ` is locally `C^{1,1}` with `|κ| ≤ 1`: its unit tangent is
1-Lipschitz in arclength. A sub-arc of length `ℓ ≤ π/2` has chord at least `sin ℓ` along its initial tangent, so inside `B(z, r)`, `r < 1/2`, every
sub-arc has length `< π/2`: the arc has finite length up to `z`, and the tangent converges. (ii) At `x ∈ γ` near `z`, M-PINCH (held) applies — (H1),
(H2) hold off Σ and `x` is saturated for `a` and `c` — and every `a`-contact of `x` is `x ± ν(x)`: in the tangent case `x + ν_c(x)`
(`B(y_a, 1) ∩ N ⊆ S_c`, so `y_a` lies on `c`'s side), in the split case the centre. Take `a`-contacts `y_n` of `x_n → z`; they converge along a
subsequence with one sign; `supp S_a` is closed. ∎

### 2.2 DB1-L3 — derivation

Let `z ∈ Σ` and suppose colour `a` occupies two distinct sectors `W₁, W₂` of positive angle. Rotate so that `W₁`'s edges `γ′, γ` have tangent
directions `0` and `θ₁ ∈ (0, 2π)`, `D(W₁) = (0, θ₁)`.

By Lemma T each edge gives a contact of `a` at distance 1 from `z` along its normal: `y = z ± e(θ₁ + π/2)` for `γ`, `y′ = z ± e(π/2)` for `γ′`. Lemma H
with `y`: `D(W₁)` and `D(W₂)` lie on one closed side of the line `ℝe(θ₁)`. Lemma H with `y′`: on one closed side of `ℝe(0)`.
- If `θ₁ > π`, the open arc `(0, θ₁)` lies on neither closed side of `ℝe(0)`: contradiction already.
- If `θ₁ ≤ π`, the side of `ℝe(θ₁)` holding `(0, θ₁)` is the closed arc `[θ₁ − π, θ₁]`, and the side of `ℝe(0)` holding it is `[0, π]`. So
  `D(W₂) ⊆ [θ₁ − π, θ₁] ∩ [0, π] = [0, θ₁]`. But `D(W₂)` is an open arc of positive length disjoint from the open arc `(0, θ₁) = D(W₁)`, and
  `[0, θ₁] ∖ (0, θ₁)` is two directions. Contradiction. ∎

**Uses only:** Lemma C (a.e.-properness alone); M-PINCH's contacts on the normal line and M-C11's curvature bound, at points of the two edges of
`W₁` near `z` (saturation there, (H1), (H2) there, i.e. those points off Σ); the fan at `z` (REG-J′). **Not used:** that `z` is saturated; anything
about cusps anywhere (the neighbour across an edge may be a zero-angle region); honesty beyond M-PINCH's hypothesis; the number of colours.
The angular lemma is checked on a half-degree grid by `fs121-v2-sectors` (§ 2.10).

### 2.3 A stronger form — a colour with a sector occupies nothing else at the point

DB1-L3's *not claimed* line leaves open "that a colour cannot occupy a sector and a cusp … at one point". The same two lemmas exclude it.

**FS121-V2-SECTOR.** At a point `z` of Σ, a colour `a` that occupies a sector `W₁` of positive angle occupies no other region at `z`, of positive or of
zero angle.
*Proof.* Positive angle: § 2.2. Zero angle: let `W₂` be a zero-angle region of `a` with tangent direction `φ`. (i) The argument of § 2.2, with Lemma
H's zero-angle form, gives `φ ∈ [0, θ₁]` (`θ₁ ≤ π`, else contradiction as there), and `φ ∉ (0, θ₁)` since `W₁` fills its angular range near `z`: so
`φ` is an edge direction of `W₁`, say `φ = 0`, and `W₂` sits in the stack of zero-angle regions tangent to `e(0)` on the side of `γ′` away from `W₁`,
with at least one region of another colour between `γ′` and `W₂` (an arc does not separate `a` from `a`). Orient `e(π/2)` toward `W₁`. (ii) Let `γ₃` be
`W₂`'s bounding arc on `W₁`'s side, between `a` (in `W₂`) and a colour `c` (its neighbour toward `γ′`); its normal at `z` is `±e(π/2)`, and `W₂` lies on
the `−e(π/2)` side of `γ₃`. By Lemma T three cases:
- `γ₃` of tangent type: the `a`-contact is on `c`'s side, `y = z + e(π/2)`. `γ₃` is tangent to `T₁(y)`'s lower arc at `z` and bends toward `y` with
  curvature at most 1, so (comparison of `dφ/dx ≤ 1/cos φ` with the circle's equality) it lies on or below that arc, outside `B(y, 1)`; `W₂`, below
  `γ₃`, misses `B(y, 1)`. Lemma H: `W₁` is out, `D(W₁) ⊆ {v : v·e(π/2) ≤ 0}` — but `D(W₁) = (0, θ₁)` lies strictly above. Contradiction.
- `γ₃` a unit arc of kind both with `a` outside: its centre is on `c`'s side, `y = z + e(π/2)`, and `W₂` is outside `T₁(y)`: as before.
- `γ₃` a unit arc of kind both with `a` inside: its centre is `y = z − e(π/2)` and `W₂ ⊆ B(y, 1)` near `γ₃`. Lemma H: `W₁` is in,
  `D(W₁) ⊆ {v : v·e(π/2) ≤ 0}`: the same contradiction. ∎

So **at every point of Σ a colour occupies either one sector of positive angle and nothing else, or only zero-angle regions**. Only "two cusps" (two
zero-angle regions of one colour, no sector) survives of the *not claimed* line. The comparison step is checked on rational points of circles of radius
`R ≥ 1` by `fs121-v2-comparison`.

### 2.4 Attack on DB1-L3

- **The smallest configurations.** Two sectors of one colour need at least four regions (`a, b, a, c`, with `c = b` allowed). The X-vertex
  (`a, b, a, b` in four right angles) dies at once: `D(W₂) = (π, 3π/2)` is on neither admissible side. Two sectors on one side of a line —
  `a` on `(0°, 30°)` and `(60°, 90°)`, `b` between — die too: the edge at `30°` puts `W₂` on `[−150°, 30°]`.
- **Each hypothesis removed.** *Saturation:* without it the attack succeeds — a periodic colouring by "bow-tie" blocks (two squares of side `s < 1/(2√2)`
  touching at a corner, one colour, blocks coloured properly with finitely many colours) is a.e.-proper and has a colour on two opposite sectors at every
  bow-tie centre; it is not saturated (a square's edge far from the centre has no contact of its colour at distance 1). So saturation is used, and
  it is used exactly at the points of the two edges near `z`. *REG-J′:* without it "sector" is undefined (the *not claimed* line). *Cusps:* not used
  (§ 2.2).
- **The converse** (every colouring whose colours occupy one sector each at every point of Σ is saturated): false and not claimed — the hexagonal
  seven-colouring has three distinct colours at every vertex and is not saturated (M-DEADLOCK).
- **Where the attack succeeds on the neighbouring statement:** "two zero-angle regions of one colour" — neither lemma touches it (with no sector, Lemma
  H gives no side, since a zero-angle region's direction lies on the contact line), so the one surviving item of the *not claimed* line is the
  statement's true edge as far as this route sees.
- **Models.** R7 at a lattice point: three up colours on `120°` sectors and three distinct down colours on cusps, the two sets disjoint — as
  FS121-V2-SECTOR requires. SQ9 at a vertex: four distinct colours (`fs121-v2-sq9`, 81 of 81 vertices of a period).

### 2.5 FS121-D1-VT — derivation

*Setting.* `I` a tangent-type interface arc between `a` and `b` (tangent type at one point is tangent type along the arc: a split point makes its whole
M-C11 neighbourhood one unit arc, M-C11 (iii), so a chain cannot join a split piece), `ν` its unit normal into `b`, `x₀` an interior point of `I`,
`Y = x₀ + ν(x₀)`. `I` is a chain of segments and arcs of integer radius (M2-INTRAD, held), finitely many unit pieces near `x₀`. **Case C¹:** `x₀` is
not in the closure of a sub-arc of `I` of radius 1 curving toward `b`. Then near `x₀` the curvature toward `b` is at most `1/2`, the map
`x ↦ x + ν(x)` has derivative `(1 − κ)T ≠ 0`, and `L` near `Y` is a `C¹` arc through `Y` with normal `ν(x₀)` there. (The other case, a corner of `L`, is
§ 2.6.)

**F2 (the near side is `a`-free).** There is `δ > 0` with `B(Y, δ) ∩ B(x₀, 1)` containing no point of positive `a`-density. So every region of `a` at
`Y` has its directions in the closed far half-plane `{v : v·ν(x₀) ≥ 0}`.
*Proof.* Let `P = B(x₀ − ν(x₀), 1) ∩ N` (M-C11's `a`-side disc at `x₀`, a.e. in `S_a`, open, convex, so `P ⊆ S̃_a`, `x₀ ∈ cl P`). If `d̄_a(q) > 0` and
`|q − x₀| < 1`, points of `P` near `x₀` lie in `B(q, 1)`, so by Lemma C `P ⊆ B(q, 1)`. But `P ∋ p* = x₀ + tτ − t²ν` for small `t > 0` (`τ` the tangent),
and `|p* − Y|² = t² + (1 + t²)² > 1`; so `p* ∉ B(q, 1)` once `|q − Y| < |p* − Y| − 1 =: δ`. ∎

**F3 (the far side along `L` is `a`).** For `Y′ ∈ L` near `Y`, `Y′ ≠ Y`: `L` coincides near `Y′` with the interface there, `a` on the far side and one
other colour on the near side.
*Proof.* `Y′ = x′ + ν(x′)` is an `a`-contact of `x′` (Lemma T (ii)), so `Y′ ∈ supp S_a`; `Y′ ∉ Σ` (local finiteness), so `S_a` does not have density 0 at
`Y′` (Σ contains every such point); F2 at `x′` makes the near side `a`-null, so `Y′` is no density point of `a`: `Y′ ∈ ∂_e S_a`. At `Y′ ∉ Σ`, (H1), (H2)
hold and the essential boundary near `Y′` is one `C^{1,1}` curve with `a` on one side; the arc `L` near `Y′` lies in it, so it is it, and `a` is on the far
side by F2. ∎

**The conclusion.** Suppose an interface arc `J` ends at `Y` from the far side of `L`. Then `Y ∈ Σ`, and the far side of `L` near `Y` holds at least two
regions of the fan; by F3 the one adjacent to `L`'s branch on each side of `Y` is an `a`-region, and they are distinct (`J` lies between them). `Y` is a
limit of points of `L ⊆ supp S_a`, so `Y ∈ supp S_a`; by the list's cusp-freeness (reading (Σ), fixed by Keryx) `S_a` does not have density 0 at `Y`,
so `a` occupies a region of positive angle at `Y`. FS121-V2-SECTOR: then `a` occupies no other region at `Y` — but it occupies two. Contradiction. ∎

*Under reading (G)* the same holds with DB1-L3 alone: every region then has positive angle, and the two `a`-regions contradict § 2.2.

**Uses only:** Lemma C; M-PINCH and M-C11 along `I` and along `L` (off Σ); M2-INTRAD's piecewise-circular form, only to split off the corner case; the
fan at `Y` (REG-J′); FS121-V2-SECTOR; and cusp-freeness **only at the one point `Y`, for the one colour `a`**. So VT holds, by this route, in every
honest saturated colouring satisfying REG-J′ at every such `Y` where `a` does not have density 0.

### 2.6 The corner of `L` — reading (W) and reading (B)

*The case.* `x₀` lies on a sub-arc `P₀` of `I` of radius 1 curving toward `b`, with both ends of `P₀` interior to `I` (if an end of `P₀` is an endpoint of
`I`, then `Y` is also the image of that endpoint — the *not claimed* line's case — and the claim's two scopes overlap there). Every point of `P₀` is
tangent type with its `a`-contact at `P₀`'s centre, which is `Y` (so `P₀` is an (R2)-type piece: its centre carries the outer colour `a`); `L` near `Y` is
two branches, the images of the pieces before and after `P₀`, meeting at `Y` at a corner. F2 at every `x ∈ P₀` makes `B(Y, δ) ∩ B(x, 1)` `a`-free, so
`a`'s regions at `Y` lie in the polar cone of the directions from `Y` to `P₀`: a wedge `Ω` of angle `π − ψ` (`ψ` the angle `P₀` subtends; cusp-freeness at
`Y` forces `ψ < π`), whose two boundary rays are exactly the branches' tangents. F3 holds along both branches.

- **Reading (W)** — the far side of `L` at `Y` is `Ω`, the side of the curve `L` away from `I`: **derived**, by § 2.5's last paragraph verbatim (two
  distinct `a`-regions adjacent to the branches inside `Ω`, against FS121-V2-SECTOR).
- **Reading (B)** — the far side of one branch's tangent line: that half-plane also holds a slice of angle `ψ` of the other branch's near side, and the
  conclusion then also forbids any arc of `L`'s near side from ending at `Y` inside that slice (for instance the arc separating two different near
  colours of the two branches, if one exists and runs there). My route says nothing about `L`'s near side, and no held colouring has such a chain:
  **not derived (GAP)** — and not refuted.

Keryx relayed (2026-09-29) that the proposing record does not define the term and its author is past its line. **Recommendation:** name reading (W) in
the statement (it is the plain sense of the side of a curve, and it is what the proof carries); excluding such chains instead would drop a true case.
The corrected statement is FS121-V2-VT-W (§ 2.10).

### 2.7 Attack on FS121-D1-VT

- **The zero-angle escape** (my registered likeliest break): an arc `J₁` leaving `Y` tangent to `L`'s branch, the thin region between them `a`, with `a`
  of positive density at `Y` from another sector. Killed by FS121-V2-SECTOR's zero-angle clause, whose three cases here are: `J₁` tangent type or a
  unit arc of kind both with `a` outside (contact `Y + ν(x₀)`, the thin region outside `B(Y + ν(x₀), 1)`, the positive sector pushed below the
  tangent line — against F2), or `a` inside (centre `Y − ν(x₀) = x₀`, the thin region inside `B(x₀, 1)` — against F2 directly).
- **A self-touching `L`** (two points of `I` with one image, their branches tangent at `Y`): the branch through `Y` from `x₀` still has `a` on its far side
  and the other branch then bounds a zero-angle `a`-region against it — killed as above; a transversal self-crossing of `L` is impossible outright (the
  quadrant on one branch's far side and the other's near side would be `a` and `a`-free).
- **The cusp hypothesis removed** (not claimed): if `a` has density 0 at `Y` — thin `a`-horns along both branches of `L`, the far half-plane otherwise
  held by another colour `d`, e.g. inside the unit circle about `Y + ν(x₀)` with that circle's arcs of kind both bounding the horns — then an arc ends at
  `Y` from the far side and neither lemma objects: Lemma H with a horn gives no side. I built no colouring with this configuration and found no
  contradiction in it: **the global cusp-free hypothesis is not shown idle**; the route needs it at `Y` for `a` only.
- **Endpoints of `I`** (not claimed): at the image of an endpoint the far-side colour can change, and a T-junction on `L` from the far side is then
  exactly what the second branch of FS121-D1-EROSION's conclusion needs (§ 2.9).
- **Models.** No held colouring in the class has a tangent-type interface whose unit parallel carries a junction: SQ9 and HEX9 have tangent-type edges
  whose ladders are clean segments (VM2-LAD-CTL, as filed), R7 has no tangent-type interface. The class is inhabited at `k = 9` and the statement holds
  there by inspection; it is never tested at a junction.

### 2.8 FS121-D1-EROSION — derivation

*Setting.* A colour `A`'s sector at `z` of angle `θ ∈ (0, π)`; bisector `e(0)`; edges `E_i` from `z` in directions `d₁ = e(θ/2)`, `d₂ = e(−θ/2)`, straight
for lengths `L₁, L₂`; outward normals `n₁ = e(θ/2 + π/2)`, `n₂ = e(−θ/2 − π/2)`. Every point of `E_i` off Σ is an interface point between `A` and an outer
colour, of tangent type (a straight interface contains no unit arc), so its outer colour's contact is `x − n_i`, on `A`'s side (Lemma T (ii)).

*The crossing.* The unit parallels on `A`'s side are the lines `M_i = {t d_i − n_i}`. They meet at `Q = e(0)/sin(θ/2)`, at parameter `t = cot(θ/2)` on
both, transversally (at angle `θ`) — `fs121-v2-crossing` (symbolic in `θ`; its plant, the outer parallels, meets at `t = −cot(θ/2)`, behind `z`). Put
`c = cot(θ/2)` and `p_i = z + c d_i`, so `Q = p₁ − n₁ = p₂ − n₂`.

*The argument.* Suppose `L₁, L₂ > c`. Then `E_i` is straight on both sides of `p_i`, so for `x ∈ E_i` near `p_i`, `x ≠ p_i`, the point `x − n_i` lies on
`M_i` near `Q`, off Σ, and (F3, with the roles `a := ` the outer colour, `b := A`) `M_i` is an interface there, the outer colour of `E_i` near `p_i` on its far
side. Near `Q` the essential boundary contains two transversal segments, so `Q ∈ Σ`. Suppose `p₁ ∉ Σ`, i.e. `p₁` is an interior point of the interface arc
`I₁ ⊇ E₁ ∩ B(p₁, ε)` with outer colour `B₁`, and the branch of `L = I₁ − n₁` through `Q` is the straight `M₁` (Case C¹ of § 2.5). The half of `M₂` on
the far side of `M₁` is an interface arc ending at `Q` from the far side of that branch. § 2.5's conclusion (it uses only the branch through `Q`, whatever
else maps to `Q`) forbids it: contradiction. So `p₁ ∈ Σ`, and symmetrically `p₂ ∈ Σ` — the half of `M₁` on the far side of `M₂` exists whether or
not `p₁ ∈ Σ`, since `E₁` is straight on both sides of `p₁`. So **`min(L₁, L₂) ≤ cot(θ/2)`, or `p₁, p₂ ∈ Σ`**, which is the statement. ∎

**Uses only:** § 2.5's argument at `Q` for the branch through `Q` (so Lemma C, M-PINCH, M-C11, FS121-V2-SECTOR), and cusp-freeness only at `Q`, for the
two outer colours. It needs nothing at corners of `L` (§ 2.6), so its verdict does not depend on the reading left open there.

### 2.9 Attack on FS121-D1-EROSION

- **Where its content lies.** A component of a class has diameter at most 1 (Lemma C with `x` in the component), and the points at distance `m =
  min(L₁, L₂)` on the two edges are `2m sin(θ/2)` apart, so `m ≤ 1/(2 sin(θ/2))` in **every a.e.-proper colouring**. That is at most `cot(θ/2)` exactly
  when `θ ≤ 2π/3` (`fs121-v2-diameter`, 1..120 of 179 integer degrees). So for `θ ≤ 2π/3` the first disjunct holds with no saturation, no REG-J′ and
  no cusp-freeness — a thin truth: the unsaturated hexagonal seven-colouring meets it at every corner (`θ = 2π/3`, sides `1/2 ≤ cot(π/3) ≈ 0.577`). The
  statement has content only for `θ ∈ (2π/3, π)`: there it bounds the shorter edge by `cot(θ/2)`, below the diameter bound, and it forces the edge of a
  sector of angle near `π` to be short (`cot(θ/2) → 0` while Σ is locally finite).
- **The second disjunct, realised?** If `p₁, p₂ ∈ Σ` with both edges straight past them, the crossing at `Q` has four quadrants: the far–far quadrant
  (angle `θ`) is adjacent to the far sides of `M₁⁺` and `M₂⁺`, so the outer colours of `E₁` and `E₂` beyond `p₁`, `p₂` coincide; the two mixed quadrants
  (angle `π − θ`) carry `B₁` and `B₂`, which differ (DB1-L3, opposite sectors); the near–near quadrant carries a fourth colour. So the second branch needs
  a four-colour crossing at `Q` with T-junctions at `p₁` and `p₂`. Nothing held realises it; nothing I have excludes it.
- **The far-side bookkeeping** (my registered likeliest break): `+d₂` lies on the far side of `M₁` (`d₂·(−n₁) = sin θ > 0`), so one half of each line lies
  on each side of the other, and the half needed exists as soon as both edges pass their points `p_i`. It did not break.
- **An outer colour that changes before `c`:** harmless — only the interface arc through `p_i` enters, and a change exactly at `p_i` is the second
  disjunct.
- **The boundary `min = c`:** covered by the first disjunct; my route suggests the inequality could be strict when the straight piece ends at `p_i` in a
  `C¹` bend (the parallel then continues through `Q`), except when the bend is a radius-1 arc curving toward `A`, where `L` collapses at `Q` (§ 2.6).
  Not pursued.
- **Models.** SQ9 (`θ = π/2`, sides `1/2 ≤ 1`) and HEX9 (`θ = 2π/3`, sides `1/(2√3) ≤ 1/√3`) meet the first disjunct; both lie where the statement is
  implied by the diameter bound. No held colouring in the class has a sector of angle in `(2π/3, π)`.

### 2.10 Entries, controls and the three verdicts

derivation: FS121-V2-SECTOR
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive angle
    occupies no other region there, of positive or of zero angle
  uses only: Lemma C (a.e.-properness); M-PINCH's contacts on the normal line and M-C11's bound |κ| ≤ 1 at points of the sector's edges near the point;
    the fan at the point
  not claimed: that a colour cannot occupy two zero-angle regions at one point; anything without REG-J′; that the point itself is saturated (not used)
  argument: § 2.3 A stronger form — a colour with a sector occupies nothing else at the point
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point (up colours on sectors, down colours on cusps, disjoint); SQ9 at a vertex (four distinct colours)
  prior art: owed — the object is this project's (saturated colourings); no search run in this job
  handoff: the coordinator — a strengthening of DB1-L3 that its not claimed line leaves open

control: fs121-v2-sectors
  of: FS121-V2-SECTOR — DB1-L3's case, the angular lemma on a half-degree grid: no second arc survives both edge constraints; cusp directions are the two edges
  run: python3 ../tools/fs121_v2_check.py sectors
  expect: sectors: reflex W1 killed outright 358; theta1 leaving an arc for a second region 0; theta1 <= 180 whose allowed cusp directions are exactly the two edges 359 of 359
  fault: python3 ../tools/fs121_v2_check.py sectors --plant

control: fs121-v2-comparison
  of: FS121-V2-SECTOR — the zero-angle case's comparison: a circle of radius R ≥ 1 tangent at 0 stays outside the open unit disc about (0, 1)
  run: python3 ../tools/fs121_v2_check.py comparison
  expect: comparison: points inside the open unit disc about (0, 1): 0 of 174
  fault: python3 ../tools/fs121_v2_check.py comparison --plant

control: fs121-v2-sq9
  of: FS121-V2-SECTOR — the model SQ9: four distinct colours at every vertex of a period
  run: python3 ../tools/fs121_v2_check.py sq9
  expect: sq9: vertices of one period with a repeated colour: 0 of 81
  fault: python3 ../tools/fs121_v2_check.py sq9 --plant

derivation: FS121-V2-VT-W
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b, ν its
    normal into b, and x₀ an interior point of I that is not in the closure of a sub-arc of I of radius 1 curving toward b ending at an endpoint of I;
    let Y = x₀ + ν(x₀), P the closure of the radius-1 sub-arc of I curving toward b that contains x₀ in its closure if there is one and {x₀}
    otherwise, and L_Y the image under x ↦ x + ν(x) of a neighbourhood of P in I — a C¹ arc through Y when P = {x₀}, two branches meeting at Y at
    a corner otherwise; then no interface arc other than L_Y's branches ends at Y in the a-side region that L_Y bounds at Y (its far side, or the
    wedge between its branches)
  uses only: Lemma C; M-PINCH and M-C11 along I and along L_Y off Σ; M2-INTRAD's chain form, only to name the corner case; FS121-V2-SECTOR; cusp-freeness
    only at Y for the colour a
  not claimed: anything at a point where a has density 0 (the double horn of § 2.7 is not excluded); anything at the image of an endpoint of I; anything on
    L_Y's near side
  argument: § 2.5 FS121-D1-VT — derivation
  verdict: derived
  grade: derived from: FS121-V2-SECTOR
  minds: 1
  model: SQ9 (k = 9): every edge's unit parallel is a clean segment with its far colour on its far side; no junction on it
  prior art: owed — the object is this project's; no search run in this job
  handoff: the coordinator — the corrected statement of FS121-D1-VT, reading (W) named

derivation: FS121-V2-EROSION-DIAM
  statement: in every a.e.-proper colouring, if a colour's sector at z has angle θ in (0, π) and both its edges begin with straight pieces of the
    boundary of one component of that colour, of lengths L₁ and L₂, then min(L₁, L₂) ≤ 1/(2 sin(θ/2)); so for θ ≤ 2π/3, min(L₁, L₂) ≤ cot(θ/2)
  uses only: Lemma C (a component of a class has diameter at most 1); 1/(2 sin(θ/2)) ≤ cot(θ/2) iff cos(θ/2) ≥ 1/2
  not claimed: anything for θ in (2π/3, π), where the diameter bound exceeds cot(θ/2)
  argument: § 2.9 Attack on FS121-D1-EROSION
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring at a hexagon corner (θ = 2π/3, sides 1/2 ≤ 1/√3), unsaturated
  prior art: known: the diameter bound for a component is FS111-M-HULL2's (and C-HULL's), as filed
  handoff: none — it places FS121-D1-EROSION's content at θ in (2π/3, π)

control: fs121-v2-crossing
  of: FS121-D1-EROSION — the inner unit parallels of the two edges meet at parameter cot(θ/2) on both, symbolic in θ
  run: python3 ../tools/fs121_v2_check.py crossing
  expect: crossing: t = cot(theta/2): True; s = cot(theta/2): True; Q = (1/sin(theta/2), 0)
  fault: python3 ../tools/fs121_v2_check.py crossing --plant

control: fs121-v2-diameter
  of: FS121-V2-EROSION-DIAM — the diameter bound gives the first disjunct exactly for θ ≤ 120° on integer degrees
  run: python3 ../tools/fs121_v2_check.py diameter
  expect: diameter: the diameter bound gives the first disjunct at 120 of 179 integer angles, exactly 1..120
  fault: python3 ../tools/fs121_v2_check.py diameter --plant

verification: DB1-L3
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere *Not claimed:* that a colour cannot occupy a sector and a cusp, or two cusps, at one point; anything without REG-J′
  given: the statement verbatim and the list's §§ 0–1 (at 01:31); my brief's note that the statement "localises" FS111-W-NOREP; the open FS-111 records
    of § 1.1, including W-NOREP's statement and the fact that its case (ii) rests on W-KB-DIR (not its body, not W-wild.md); no verdict or sketch of any
    other mind on it
  committed: 2026-09-29, stage 2
  predicted: derived — 0.85 — likeliest break: an interface arc at z without a tangent there, or an edge whose normal carries no contact of the colour to z
  verdict: derived
  method: contacts inherited at z as limits along the sector's two edges, then the component lemma (Lemma H) puts every second region of the colour on
    the sector's side of both edge lines; the first derivation's route not known to me
  attack: § 2.4 Attack on DB1-L3
  divergences: none — the first derivation is not yet read; stage 3 writes the table
  counterexamples: none — the X-vertex, two sectors on one side of a line, and every angle of the first sector on a half-degree grid; without saturation
    the bow-tie colouring puts one colour on two sectors, as it must
  minds: 1 — blind, the same model: blind to the first derivation's record (not opened before this commit); method: my own, route unknown to me
  grade: hand

verification: FS121-D1-VT
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b that is not a unit arc curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I, no interface arc ends at Y from the far side of L *Not claimed:* anything at the image of an endpoint of I (the far-side colour may change there); anything when I is a unit arc curving toward b (L is a point, the (Q) or (R2) end); anything with cusps (NOREP's hypothesis)
  given: the statement verbatim and the list's §§ 0–1; the list's note that EROSION rests on it; the author's definition of cusp-free, relayed verbatim
    by Keryx during stage 1 (reading (Σ)); Keryx's word during stage 2 that "the far side of L" at a corner is undefined by its author; no verdict or
    sketch of any other mind
  committed: 2026-09-29, stage 2
  predicted: derived — 0.55 — likeliest break: a zero-angle region of a between L and an arc tangent to L at Y, or a chain I with a radius-1 piece curving
    toward b
  verdict: gap: at "the far side of L" where L has a corner (I a chain with an interior radius-1 piece curving toward b) — derived there under reading (W),
    not derived under reading (B); derived wherever L is C¹ at Y; the corrected statement is FS121-V2-VT-W, derived
  method: F2 (the near side of L is a-free) and F3 (L's far side is a) at points of L, then FS121-V2-SECTOR at Y; the first derivation's route unknown
  attack: § 2.7 Attack on FS121-D1-VT
  divergences: none — the first derivation is not yet read; stage 3 writes the table
  counterexamples: none — the zero-angle escape (killed), a self-touching L (killed), the double horn with cusps (outside the hypotheses; not excluded, not
    built); under reading (B) no object found either way
  minds: 1 — blind, the same model: blind to the first derivation's record; method: my own, route unknown to me
  grade: hand

verification: FS121-D1-EROSION
  statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces has a point of Σ at distance cot(θ/2) from z *Not claimed:* anything for curved edges (their partner curves cross elsewhere, and FS121-D1-VT still forbids the crossing at images of interior points); anything at θ ≥ π; anything with cusps
  given: the statement verbatim, whose not claimed line names FS121-D1-VT as the lever and the crossing of partner curves as the mechanism; the list's §§
    0–1; the author's definition of cusp-free relayed by Keryx; no verdict or sketch of any other mind
  committed: 2026-09-29, stage 2
  predicted: derived — 0.5 — likeliest break: the far-side bookkeeping at the crossing of the two inner partner lines, or a straight piece whose outer
    colour changes before cot(θ/2)
  verdict: derived
  method: the inner unit parallels cross at the images of the points at distance cot(θ/2); § 2.5's argument at the crossing, for the straight branch only
  attack: § 2.9 Attack on FS121-D1-EROSION
  divergences: none — the first derivation is not yet read; stage 3 writes the table
  counterexamples: thin truth: the unsaturated hexagonal seven-colouring at a hexagon corner — for θ ≤ 2π/3 the first disjunct holds in every
    a.e.-proper colouring by the diameter bound (FS121-V2-EROSION-DIAM), so the hypotheses are idle there
  minds: 1 — blind, the same model: blind to the first derivation's record; method: the mechanism was named by the statement itself (given), the argument
    at the crossing mine
  grade: derived from: FS121-V2-VT-W

