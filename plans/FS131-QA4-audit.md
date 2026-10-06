# FS131-QA4 — impossible assumptions, third pass: every theorem landed or about to land since FS131-QA3, read against the inhabitant rule's letter (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA4-inhabitants.md`. An audit: read-only toward every `Proofs/` file, every worktree and every branch; every
finding is a recommendation routed through Keryx. Started 2026-10-06 03:55 UTC.*

## Theorems this phase proved

None in the library. An audit proves nothing there; its scratch Lean (`data/fs131/qa4/`) and exact checks (`tools/fs131_qa4_*.py`) are
evidence for verdicts, listed where used, each at its grade.

## Stage 1 — SAVED (FS131-QA4)

### 1.1 The brief's quotations (standing rule 3)

Checked by script (each quotation's text counted with `str.count` in the file its source line names), then the items read in their place:

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a" | `LEAN.md` § The gate, l. 187 | verbatim, once |
| 2 | "real instance and the gate stays green. **The inhabitant satisfies every hypothesis the theorem does not refute, at once, at a parameter the refutation leaves alive** — for a" | `LEAN.md` § The gate, l. 190 | verbatim, once |
| 3 | item 158's first line | `plans/FS131-close-inventory.md` l. 1045 | verbatim, once |
| 4 | item 172's first line | same, l. 1194 | verbatim, once |
| 5 | item 268's first line | same, l. 1949 | verbatim, once |
| 6 | item 273's first line | same, l. 2002 | verbatim, once |
| 7 | item 408's first line | same, l. 3683 | verbatim, once |
| 8 | item 414's first line | same, l. 3726 | verbatim, once |
| 9 | item 416's first line | same, l. 3762 | verbatim, once |
| 10 | item 419's first line | same, l. 3812 | verbatim, once |
| 11 | "**Inhabitant** (`LEAN.md` § The gate): none in Lean yet. FS131-E6's model (`plans/FS131-E6-derivation.md` § 3.1–3.3: a valid plane map" | `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (`main`) | verbatim, once |
| 12 | `theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}` | same | verbatim, once |
| 13 | `theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)` | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (`main`) | verbatim, once |
| 14 | `theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')` | `.claude/worktrees/fs131-w5k/…/BendCollar.lean` (`3b120cd3`) | verbatim, once |

No mismatch. One note, not a mismatch: the brief's header is dated 2026-10-06, which is the UTC date (`date -u` at my start: 2026-10-06 03:55);
the harness's date is 2026-10-05.

Read in full: `plans/STANDING-RULES.md`; `LEAN.md` (§ The gate whole, l. 160–201); `plans/FS131-QA2-audit.md` and `plans/FS131-QA3-audit.md`
(both records whole); inventory items 408–419 (l. 3683–3831).

### 1.2 The rule, as I read it (its letter, `LEAN.md` l. 186–193)

Four requirements, each of which a theorem "whose hypothesis is a structure" can fail separately:

- **(R1) named**: the file ships a named inhabitant, or a one-line note naming the theorem that supplies one.
- **(R2) every clause exercised**: the inhabitant is not degenerate for any clause of any hypothesis.
- **(R3) at once**: one object satisfies every hypothesis the theorem does not refute, at a parameter the refutation leaves alive — a model
  of one hypothesis on an object where another fails is not a model of the theorem.
- **(R4) or declared**: where none is expected (a step inside a proof by contradiction), the docstring says so with the theorem that refutes
  the configuration.

A reading I flag, since the rule is Keryx's to sharpen: "whose hypothesis is a structure (a colouring, an embedding, a certificate, a
homomorphism)" I read as *any hypothesis set that constrains a carried object* — here an `ArcMap k` under `Valid`, `Covers`, `IsPlaneMap`, and
the named predicates on its points and arcs — because that is the class both earlier findings (items 158, 268) fell in, and QA2 § 2.1 read it so.
A theorem all of whose hypotheses are parameters and plain (in)equalities on reals (a frame identity, a lens inequality) is outside the rule and
is tabled as *parametric*.

### 1.3 The bodies, at fixed commits

| body | commit | what is read there |
|---|---|---|
| `main` | `d4403f09` (its head at my start) | everything `git diff --name-only 7abff9b9 d4403f09 -- Proofs` names: 18 files, 36,405 lines added — `Plane/SVMap`, `Plane/StuckChain`, `Plane/LocalStructure` (27 lines changed), `Plane/ValidMap/{Basic, Sectors, UnitArc, BaseSteps, Contact, Cone, Moves, Surgery, MergeMove, OpenMove}`, `Plane/Woodall/{Basic, Collar, Merge, NoFourFive, Steps}` |
| wave 5 | `fs131-w5` at `3b120cd3` (the branch has since moved to `158bfadd`; not read) | `Plane/{CurveGraph, PlaneTopology}`, `Thomassen`, `Plane/ValidMap/{MapTopology, MapGraph, BrickMap, Chain, Cor3, Dense, FlankUA, HexRing, BaseWalk, BaseDense, RadialPush, CollarMap, Pushforward, BendCollar}` |
| wave 5c | `fs131-w5c` at `87e95385` (the branch has since moved to `a300d495`; not read) | `Plane/ValidMap/{Terminal, HornShadow, Limit, Procedure}`; `exists_vertexStep` and `exists_arcStep` read in `plans/FS131-E6-derivation.md` § 4.5's drafts instead |

Read with `git show <commit>:<path>` only. Scratch Lean runs with `lake env lean` from the idle trees `.claude/worktrees/fs131-wop` (`main`'s
line, at `4b68d47d`) and `.claude/worktrees/fs131-w5k` (`3b120cd3`), reading their oleans, building and writing nothing there.

### 1.4 What I may and may not change

Mine: this record, `data/fs131/qa4/`, `tools/fs131_qa4_*.py`, `data/fs131/reports/FS131-QA4.md`, on `main`, committed by explicit path. Not mine:
any `Proofs/` file, any worktree, any other branch, any statement, any file Keryx alone writes (`LEAN.md`, the inventory) — edits to those are
drafted here with their slot. I prove nothing in `Proofs/`. I start no agent and run no search.

## Stage 2 — SAVED (FS131-QA4): the census instrument, and where the boundary is drawn

### 2.1 The instrument

`tools/fs131_qa4_census.py` (imports FS131-QA1's parser read-only; reads each module with `git show <commit>:<path>`): for every theorem of
the 39 audited modules — its head reasons (a backlog row named in its docstring; its name used in another audited module; the brief's list of
construction heads), whether its statement concludes `False`, whether its body holds `sorry`, the named predicates in its signature, and the
sentence of its docstring that speaks of an inhabitant or model; for every definition — NEW, CHANGED or SAME against every body the nine
commits of QA2 and QA3 hold under that name, and the number of audited theorems whose signature takes it.

`--self-test`: 15 controls, 4 of them planted faults inside the test (a citing module emptied, a module missing, a definition changed, a
definition new), exit 0. **Two faults planted in the tool itself and watched to fire** (on a copy in the session's scratch): with the arrow
chain's last target not taken, "arrow-form refutation missed", exit 1; with a theorem's own module counted as a citation, "a child read as a
head" and "citation still reported after the citing module was emptied", exit 1.

Outputs (committed): `data/fs131/qa4/theorems.tsv` (2,590 theorems), `heads.tsv` (963), `defs.tsv` (319 definitions).

### 2.2 The census in numbers

| body | modules | theorems | row or construction heads | cited from another module only | refutation-shaped | with `sorry` | docstring speaks of an inhabitant |
|---|---|---|---|---|---|---|---|
| `main` (`d4403f09`) | 18 | 1,563 | 145 | 462 | 32 | 0 | 26 |
| wave 5 (`3b120cd3`) | 17 | 775 | 129 | 154 | 23 | 5 | 48 |
| wave 5c (`87e95385`) | 4 | 252 | 44 | 29 | 7 | 4 | 50 |
| total | 39 | 2,590 | 318 | 645 | 62 | 9 | 124 |

Definitions: 319, of which 108 are Prop-valued (predicates and structures); **28 Prop-valued definitions are new or changed since the commits QA2
and QA3 read** (27 NEW, 1 CHANGED: `IsHoleOf`, item 242's repair); they are tabled in Stage 5.

### 2.3 The boundary (brief, Done means 2: "say where you drew that boundary")

- **A head** is a theorem whose docstring names a backlog row or a derivation's entry (318 by the script: 315 by a row, 3 more from the brief's
  list of construction heads). These are read one by one, by family (Stage 4).
- **A theorem cited from another module and not a row** (645) is an internal child in the brief's sense unless its signature takes a named
  predicate no head of its family takes. The script lists each one's predicates; a child whose predicate set is a subset of its head's
  **inherits its head's line** (its hypotheses are among the head's, so the head's inhabitant is its inhabitant). The ones that take a
  predicate set no head takes are read with the family.
- **Everything else** (1,627 theorems used only in their own module) inherits its module's heads.
- **Parametric theorems** — every hypothesis a parameter or an (in)equality on reals and complex numbers, no carried object (`n4_fin`,
  `curvUp_curvDown`, the lens and lune inequalities, `PlaneTopology`'s lemmas about sets of the plane) — are outside the rule (§ 1.2) and are
  counted, not read.

The census is textual. Its two known blind spots, both in the safe direction for a head count and not for an inhabitant verdict, so every
verdict below is from reading the statement itself: a hypothesis that is not a named predicate (an inline `∀ᶠ`, a cone's interior) is invisible
to the predicate column; and "the docstring speaks of an inhabitant" matches the words, not the claim.

*Slip, my own, corrected in the next commit*: the three per-body rows of § 2.2 were first written from an estimate (139/468, 111/172, 68/5);
the table now holds the script's counts. The totals were right.

## Stage 3 — SAVED (FS131-QA4): the three known cases, and two findings met on the way

Grades: **[scratch-kernel]** — a statement elaborated by `lake env lean` against an idle tree's oleans, its axioms printed (the standard three),
a planted fault watched to fail; not the gate's build (`autoImplicit` is not in force under `lake env lean`). **[hand]** — read and argued
here, clause by clause. **[read]** — read from the signatures.

### 3.1 `bend_toward_collar` (`BendCollar.lean` l. 1400 at `3b120cd3`) — verdict: inhabited at once once `hmax` and `hlen` go; as stated, by nothing in `l60Frag`

Its hypotheses: `hF : F.Valid`, `hA : F.IsRingArc P θ₁ θ₂ c c'`, `hout : c' ∉ F.coloursAt P`, `hlen : θ₂ - θ₁ < 2 * π`, `hmax` (maximality of the
arc among ring arcs with the same sides), `hfree` (near each interior point of the arc `Γ` is `ω(P)`), `hε : 0 < ε`.

`data/fs131/qa4/QA4Collar.lean` (output `QA4Collar.out`, exit 0; run in `fs131-w5k` under `scripts/slot.py --mem 12`), all on the standard three:

| check | statement | result |
|---|---|---|
| QA4-C1 | on `l60Frag`'s sub-arc `r([π/8, 5π/24])`, centre `0`, sides `0`, `1`: `hF`, `hA`, `hout`, `hlen`, `hfree` hold **at once** (`l60Frag_valid`; `collarModel`'s `CollarFit.ring` and `.free_open`; `hout` copied from `collarModel`'s body, l. 635–651) | [scratch-kernel] |
| QA4-C2 | `hmax` **fails** there: the whole arc `r([0, π/3])` (`l60Frag_isRingArc`) holds the sub-arc, has the same sides and a larger carrier | [scratch-kernel] |
| QA4-C3 | `bend_toward_collar`'s whole conclusion without `hlen` and `hmax` (its own proof with the two `have _ :=` lines removed) | [scratch-kernel] — the kernel confirms neither is read |
| QA4-C4 | the weakened theorem applied to the model of C1 | [scratch-kernel] |

Planted fault (`QA4CollarPlant.lean`: the sides swapped in C1) — **fired**, "Application type mismatch", exit 1.

**As stated (with `hmax`), no arc of `l60Frag` is an inhabitant** [hand]: the only maximal arc with sides `0`, `1` is the whole `r([0, π/3])`, and
`hfree` fails on it at the two interior points where the circles of radius `1/4` about its ends cross it (`2 arcsin (1/8) ≈ 14.4°` from each end):
`l60Arcs` holds those two circles whole (`.circ 1 (1/4) 0 (2π)`, `.circ (e (π/3)) (1/4) 0 (2π)`), so inside the lens they are arcs of `Γ` with one
colour on both sides, and `Γ` near the crossing is not `ω(0)` alone. A sub-arc between the crossings is free and not maximal. So with `hmax` kept, a
model needs a new fragment (a copy of `l60Frag` whose two small circles are drawn only outside the lens: its section is about 800 lines).

**Remedy** (ruling 419 (d)(ii)'s, confirmed): drop `hmax` and `hlen` — the statement becomes strictly stronger and its hypothesis set is then
`exists_collarFit`'s, inhabited at once by QA4-C1; and state the model's hypotheses as a named theorem beside `collarModel` (QA4-C1's statement,
proof by splitting `collarModel`'s body), with a docstring line on `bend_toward_collar` naming it. **Who**: the implementer who next edits
`BendCollar` (the statement change under the ruling). **Price**: about 30 lines moved, no new mathematics; QA4-C1 and C3 are the text.
`exists_collarFit` (l. 583) needs only the note; its hypotheses are QA4-C1's.

### 3.2 `exists_open` (`OpenMove.lean` l. 2847 on `main`) — verdict: a note that none exists in Lean; inhabited at once at [hand] by E6's map, re-read here clause by clause

Hypotheses: `hF : F.Valid`, `hv : F.Covers v 1`, `hH : F.IsHorn v α κ₁ κ₂ c`, `h1 : F.HasSectors v c 1`, `hD : (interior (F.allowedCone v c)).Nonempty`,
`hm : F.HasDegree v m`, `hj : F.HasHornCount v j`, `hδ : 0 < δ`. E6's map (`plans/FS131-E6-derivation.md` §§ 3.1–3.3), read against each [hand]:

| hypothesis | at E6's map, `v = 0`, `α = 0`, `κ₁ = 0`, `κ₂ = 2`, `m = 3`, `j = 1` |
|---|---|
| `Valid` | § 3.2's five cases (V1–V5), by colour: background squares of side `3/5` in nine colours (same-colour gap `6/5`); `H` against `T_c` (`z·p > |z|²/2`); `G₀` against `T′`; `H₀` against `T` — each read, each right |
| `Covers 0 1` | a map of the plane |
| `IsHorn 0 0 0 2 c` | `hornSet 0 0 0 2 r = {|z| < r, x > 0, y > 0, y < x² + y²}` — the tile `H` within `B(0, r)` for `r < 1/10`, connected, bounded by the axis and `C₂`, both arcs of the map |
| `HasSectors 0 c 1` | `c`'s other tile `T_c` is `2/5` away |
| `hD` | `cl T_c` meets `ω(0)` at `w = (3/5, 4/5)` only, `T_c ⊆ B(0, 1)`: one contact, in-type and not out-type, so `allowedCone 0 c = {d : d·w ≥ 0}`, a half-plane — **the clause is exercised** (a contact exists; the cone is not `univ`) |
| `HasDegree 0 3` | the sectors `H`, `G₀` (connected: its parts left of the axis and inside `C₂` overlap), `H₀` |
| `HasHornCount 0 1` | `H` is a horn set; a half-disc is not one for small `r` (a point `(x′ → 0⁺, −r/2)` in the frame of any direction is above no arc of fixed curvature `κ₁` once `r < 4/|κ₁|`), nor is `G₀` |

I could not break the set and I confirm the model [hand]. **No Lean object satisfies it**: `cuspFrag` fails `hv` (QA4-B3 below) and `h1`; `bowtie`
fails `hv` (QA4-B1) and `h1`; `sevenBrickMap` has no horn.

**What a Lean model would take.** Two routes, priced:

- (a) *E6's map as written* — an `ArcMap 12` of the plane with four features and a nine-colour grid; validity in five cases; the seven facts above.
  By the library's measured models (`sevenBrickMap` with its corner facts about 530 lines in `SVMap`; `l60Frag` about 840 in `UnitArc`; `bowtie`
  about 2,700 in `BaseSteps`): **1,500–2,500 lines**, one implementer job of full size. It is also the model of F6 (the lone horn shaveable only at
  `σ = 1`), which no theorem's hypotheses ask for.
- (b) *A planted picture* — `exists_open` asks for none of F6: any valid map covering `B̄(v, 1)` with a lone horn of a colour whose cone has interior
  will do. Take a valid plane map, give it spare colours, and recolour a small horn set (and one small disc internally tangent to `ω(v)`, for a
  non-trivial cone) inside one tile with a fresh colour: every fresh class has diameter below `1`, so validity is immediate. The library has the
  recolouring (`ArcMap.recolour`, `recolour_valid`, `recolour_isPlaneMap`, `Plane/Woodall/Merge` l. 679–689) and the base (`sevenBrickMap`); it lacks
  a colour relabelling (`Fin 7 → Fin k′`, about 60 lines) and the local facts at `v` (one sector chart: about 200–400 lines by
  `coloursAt_hasSectors_of_tiles`, `BaseSteps` l. 3116). **400–800 lines**, and **the same construction serves the other three moves** (§ 3.3).

I recommend (b), with (a) left to the day F6 itself needs a kernel model. **Who**: a planner for a short plan (the planted pictures for the four
moves, one construction), then an implementer. Grade of this pricing: an estimate from three measured models, not a measurement.

### 3.3 `exists_merge`, `exists_rayMerge`, `exists_shave` (`Contact.lean` l. 1525, 1509, 1495 on `main`; the `_aux` forms in `Moves`) — verdict: nothing named; each inhabited only hypothesis by hypothesis in Lean; each inhabited at once at [hand]

| theorem | hypotheses | named objects, and which hypothesis each fails | at-once model [hand] |
|---|---|---|---|
| `exists_merge` | `Valid`, `Covers v 1`, `1 ≤ n`, `HasSectors v c (n + 1)`, `hD` (cone has interior) | `bowtie` at `0`: fails `Covers 0 1` (QA4-B1) and `hD` (`bowtie_not_merge_zero`); `cuspFrag` at `0`: fails `Covers 0 1` (QA4-B3); `sevenBrickMap`: no colour with two sectors | QA3's own instance (`plans/FS131-QA3-audit.md` § 3.1): an X of two segments in `B(0, 1/4)`, quadrants I and III one colour, a grid of cells each its own colour to radius `2`; or the planted picture of § 3.2 (b) with two fresh-coloured wedges |
| `exists_rayMerge` | `Valid`, `Covers v 1`, `HasSectors v c (n + 1)`, `κ₂ < κ₃`, two `c`-horns along one ray, `−1 ≤ κ₁`, `κ₄ ≤ 1` | no named map has two horns of one colour along one ray (`bowtie`'s are along `0` and `π`, and it fails `Covers`) | two fresh-coloured horn sets `hornSet v 0 (−1) (−1/2) r`, `hornSet v 0 (1/2) 1 r` planted in one tile |
| `exists_shave` | `Valid`, `Covers v 1`, `HasSectors v c (n + 1)`, a `c`-horn with `−1 ≤ κ₁`, `κ₂ ≤ 1`, flanks `g`, `h`, `κ₁ ≤ σ ≤ κ₂`, `hclear` | `cuspFrag` at `0` satisfies all but `Covers` (its horn `IsHorn 0 0 (−1) 1 1`; everything is clear in `B(0, 1/2)`); `bowtie` at `0` fails `hclear` (`bowtie_not_shave_zero`) and `Covers` | one fresh-coloured horn planted in a tile of colour `c₀`: both flanks are `c₀`, and every horn point is `c₀`-clear because it was a `c₀` point of a valid map |

None of the three docstrings carries an inhabitant note (`exists_merge`'s: IO3's correction, item 408, stands). I could not break any of the three
sets: inside a small disc a picture in fresh colours is constrained by nothing, and `Covers v 1` is met by any valid background. **The one
obstruction in Lean is the pair `Covers v 1` + a horn or a repeated colour: every named map with the second lacks the first.**

`data/fs131/qa4/QA4Bowtie.lean` (output `QA4Bowtie.out`, exit 0; run in `fs131-wop`), on the standard three:

| check | statement | result |
|---|---|---|
| QA4-B1 | `¬ bowtie.Covers 0 1` (every point of the bowtie's eleven tiles has real part at most `1/2`; the point `1` is outside the closure) | [scratch-kernel] |
| QA4-B2 | `¬ bowtie.IsPlaneMap` | [scratch-kernel] |
| QA4-B3 | `¬ cuspFrag.Covers 0 1` (its domain is `B(0, 1/2)`) | [scratch-kernel] |

Planted fault (`QA4BowtiePlant.lean`: the bound `1/4` in place of `1/2`) — **fired**, `linarith failed`, exit 1.

**Remedy**: § 3.2 (b)'s construction with three more pictures, and a docstring line on each move naming its model; **price**: within § 3.2 (b)'s
400–800 lines plus about 100 per further picture.

### 3.4 Finding QA4-1, sent at once: `exists_vertexStep` assumes `v ∈ F.dom` where every move it composes assumes `F.Covers v 1`

`Procedure.lean` on `fs131-w5c` (l. 576 at `87e95385`; E6's draft § 4.5 (2); the restated form at `9489c44b`, l. 762, read by `git show`):
`theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom) (hav : F.MergeAvailable v ∨ F.RayAvailable v ∨ F.ShaveAvailable v) …`,
against `exists_merge_aux`, `exists_rayMerge_aux`, `exists_shave_aux` (`Moves.lean` l. 1668, 1656, 1636) and `exists_open` (`OpenMove.lean` l. 2847),
each `(hv : F.Covers v 1)`. As stated the step is claimed for every valid clean fragment; none of the four moves applies where the domain does not
hold `B̄(v, 1)`. The source (E6-ROUTE; N2-TERM's procedure) is about plane maps. **Missing hypothesis**: `F.Covers v 1` (the one caller,
`exists_terminalSeq`, has `IsPlaneMap`; `covers_of_isPlaneMap`, `Cone.lean` l. 1634). [read] — certain. **Not established**: that the statement
is false on fragments; I tried a counterexample (a domain omitting one point `w` of `ω(v)` where tiles of the merged colour accumulate from
outside beside one in-type tile at `w`, so that Lean's cone is an open half-plane while every recolouring toward `w` meets a unit pair) and did
not finish it — the picture at `v` it needs is a stuck-like pair of horns tangent to the line across `w`, a derivation of its own. `exists_arcStep`
does not share the gap: `bend_toward`, `bend_away_whole`, `bend_toward_collar` carry no domain hypothesis.

*Ruled while I worked* (the coordinator's message; inventory items 422–423): the step now takes `(hv : F.Covers v 1)`; FS131-IR2 holds the leaf;
E6's draft § 4.5 (2) and KL1's plan row are logged as corrections owed.

### 3.5 Finding QA4-2: seventeen docstrings name `bowtie` as "the inhabitant of the hypotheses" of theorems that assume `F.Covers v 1` or `F.IsPlaneMap`

`tools/fs131_qa4_notes.py` (self-test: 6 controls, 1 planted, OK) reads each of the 124 inhabitant notes against the global hypotheses of its
theorem's signature (`data/fs131/qa4/notes.tsv`): **17 CONFLICT**, 8 where the docstring itself limits the claim ("local hypotheses", "a fragment",
"`Covers` is the caller's"), 41 saying none is expected or known, 18 naming no object, 40 with no conflict.

The 17, each "Inhabitant of the hypotheses: `bowtie` at `0`" (or "Model of the hypotheses"), each with `hv : F.Covers v 1` or `hP : F.IsPlaneMap`
among its hypotheses, each refuted as a claim by QA4-B1 or QA4-B2:

- `FlankUA` (`3b120cd3`): `not_outType_N_of_flankAbove_one` (l. 78), `not_outType_S_of_flankBelow_neg_one` (104), `srcG_of_shadow` (132),
  `srcH_of_shadow` (180), `region_near_of_inType` (254), `flank_ne_of_shadows` (311), `horn_poles_contact` (557), `horn_bounds_of_noMerge` (715),
  `hasSectors_one_of_contacts` (737);
- `Terminal` (`87e95385`): `stuck_flanks_ua` (518), `stuck_structure_ua` (771), `chainVertex_antipodal` (788),
  `exists_horn_of_mem_coneAt_of_stuck` (1416), `upper_bounds_of_inType_N` (1975, `IsPlaneMap`), `stuck_turned_frame` (2003, `IsPlaneMap`),
  `stuck_structure_at_axis` (3200), `horn_flanks_of_isChainVertex` (3507).

Sampled (`horn_poles_contact`, `horn_bounds_of_noMerge`, `hasSectors_one_of_contacts`, `not_outType_N_of_flankAbove_one`): the bowtie does satisfy
every *other* hypothesis by the named `bowtie_*` theorems; `Covers` is the one that fails. So these are **inhabited hypothesis by hypothesis only**,
with a note that claims more — the weakness QA2 found five times, now written into docstrings.

**The set is satisfiable** [hand]: complete the bowtie to a valid fragment covering `B̄(0, 1)` (or to a map of the plane) by cells of diameter
below `1` in fresh colours, with the bowtie's own arcs kept (its domain's frontier lies on them). For a colour `c < 6` the region and the tiles are
the bowtie's, so the contacts of `c` at `0`, their types, `allowedCone 0 c`, the sectors, horns and flanks at `0`, and every `IsClear g z` for
`g < 6` are unchanged; so `IsStuck 0`, `HasSectors 0 1 2`, the horns, the flanks and the in- and out-type contacts at `±i` all persist, at
`k = 6 +` the number of cells. Not in Lean, and not a small job (§ 6).
