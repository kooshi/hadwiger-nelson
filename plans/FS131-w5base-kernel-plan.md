# FS131-KB — the base of row 134 with unit arcs: the plan of `row134BaseUA`'s proof

*de Bruijn, the planner (FS131-KB), 2026-10-04. Brief: `data/fs131/briefs/FS131-KB-base.md` (main tree). Branch `fs131-w5b` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b`), from `fs131-w5` at `764cc558`. The model this record follows is `plans/FS131-kernel-plan.md`
§ 6; wave 5's vocabulary is `plans/FS131-w5-kernel-plan.md` §§ 2, 8, 10.*

## Theorems this phase proved

None: a planning job. The base's leaves are stated with `sorry`; no row is proved.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "197. **Ruling on F-BASE: the unit-arc statement stays, as an intermediate `Prop` proved inside FS-131 — not as the outside hypothesis.** Choice: K5's unit-arc" | `plans/FS131-close-inventory.md` item 197 (**main tree**, l. 1379; this branch's copy is older and ends before item 177) | verbatim (truncated, marked) |
| "Inventory item 197: the unit-arc statement of the base is wave 5's intermediate `Prop` **`Row134BaseUA`**, proved inside FS-131 (`row134BaseUA`," | `data/fs131/k5/STUB-row134-base-lean.md` § What stays outside (identical on `fs131-w5` and here) | verbatim (truncated) |
| "(b) **`NoInertNear` (exclude only inert arcs not ending at `u`?) is the base planner's call**, since `Row134BaseUA` is an intermediate of ours and the" | inventory item **199** (b) (the brief says "the ruling" without its number) | verbatim (truncated) |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch. Two slips of address, harmless: the inventory quoted is the main tree's (the branch's copy predates item 177), and the `NoInertNear`
ruling is item 199 (b). The agent file's pointer "`.claude/agents/debruijn.md` § Building Lean" (from `RUNNING.md` § Building) names a section that
does not exist; `LEAN.md` § Building holds that text.

### 1.2 What I am planning, and what I may change

**Planning:** the proof of `row134BaseUA : Row134BaseUA` (`Plane/ValidMap/Dense`; the `Prop` in `Plane/ValidMap/Chain`) as named lemmas with `sorry`
at every leaf, in new modules under `Plane/ValidMap/`; a plan per leaf; the obligation pass; the implementer's handoff. **I may change:** the layout,
the leaves' names and cut, `Dense.lean` only to move `row134BaseUA` and its four consumers downstream of the base (statements unchanged),
`NoInertNear` (after a message), `Proofs.lean`, `ARCHITECTURE.md`, my block of `scripts/Axioms.lean`. **I may not change** any wave-4/5 statement
(`pair_*`, `fail_*`, `anti`, `noBoth`, `cor3`, `p17_ua`, `bv_*`, `rot_*`, `hex_regular`); where the walk needs one in another form, that is a finding.

### 1.3 The as-given build

`764cc558` under the slot (40 GiB, 8 cpus, `BATCH=4`): § 1.4 when it lands (driver log `data/fs131/kb/build-asgiven.log`).

### 1.4 The as-given build — not obtained separately (a slip, logged)

The as-given build was queued at stage 1 and held by the slot (`ledger 80 + 40 > budget 90 GiB`, four agents building). It had not started when
stage 3's files were written, so the build that runs builds the skeleton too: K5's slip repeated, for the same reason. Its result is § 3.3.

## Stage 2 — SAVED: the confirmation, the two questions, and the GAP (all sent to Keryx mid-job, 2026-10-04)

### 2.1 The confirmation: what of `[SokolovVoronov2025]` the walk uses by statement

Read for it: `plans/FS110-CB-verification.md` (in full), `plans/FS110-CE-verification.md` (in full), `plans/FS110-CD-verification.md` § 1.1, §§ 2.0–2.10,
`plans/BASE-V-verification.md` (in full), FS110-CUSP-BASE in `plans/FS110-derivation.md`, `plans/FS112-N-proof.md` stages N3-3 and N3-4, `plans/FS112-NB3-verification.md`
§§ 1.3–1.4, and the paper's Prop. 19, Lemma 6 and its Appendix (pp. 24, 27–28; Voronov 2023 Lemma 6.1, p. 12). `plans/FS110-CC-verification.md` was not opened
(its content, the strip and Prop. 17 at cusps, is replaced in the walk by `fail_*` and `p17_ua`/`bv_hex`; BASE-V § 2.0 read its C4–C6).

| printed piece | how the walk reads it |
|---|---|
| Props. 1–4, Lemma 1 | inside: the (P) sweep (CB D1; CD (F1)–(F3)) |
| Props. 9–11, Cor. 2 (the strip) | inside: N3-FAIL (`fail_leavingCentre`, `fail_colours`) — used by `cor3`, `pair_ii` |
| Cor. 3 | inside: N3-COR3 (`cor3`) |
| Props. 14–15 ((i), (ii)) | inside: N3-I, N3-II (`pair_i`, `pair_ii`); BV-ND1 (`bv_nd1`) |
| **Lemma 5, Prop. 18** | **inside**: CB took them from print, but FS110-CD § 2.5 and BASE-V § 1a.2–1a.3 derived both, blind, by different routes (two minds) |
| Prop. 17 | inside: `p17_ua` / `bv_hex` |
| Lemma 3 | inside: CB D4, BASE-V BV-L3 (the walk needs it in pseudo-colour form, § 2.2) |
| Prop. 19 (the plane recolouring) | not used: replaced by CD's Lemma R / CE's R1–R4 (the circle-only reduction) |
| Lemma 4's pigeonhole | inside: CD § 2.7, CB D5 item 6, CE E6 |
| **the eleventh point** (p. 28: "It remains to notice that on the boundary of the union of three regions of colors 1, 2, 3 whose vertex is u, there is at least one more trichromatic point (Fig. 6).") | **asserted in print; every source obtains it after hole-filling** (Voronov's Obs. 2.2 and Lemma 6.1; CB D5 item 6; CE E6). In the local base it is a GAP (§ 2.3), not an import |

**Result: no piece is used purely by statement, with one exception that cannot be imported.** The eleventh point is a step of our own walk whose
local truth is in question. An `axiom` for it would carry that question into the kernel, and an axiom importing a step of ours is forbidden anyway.

### 2.2 Question 2 settled: Lemma 3 with contact arcs

**Can in- or out-contact unit arcs occur on the circle of a pigeonhole vertex `p ∈ B̄(u, 1)`?** Yes. Under H and `NoInertNear`, only inert arcs (excluded
by `NoInertNear`) and both-kind arcs (excluded by `noBoth` with H) are ruled out. An in-contact arc of `ω(p)` (inner colour in `P_cl(p)`, outer colour not)
contradicts nothing: its pseudo-colour is the single outer colour along its interior. So wave 5's `bv_l3`, whose `RingProper` demands that
`Γ ∩ ω(p)` be finite, does not apply at such `p`.

**Choice:** a Lemma 3 tolerating such arcs, stated in the base module as `BaseCtx.l3_base`. It reads the pseudo-colourings as wave-3 `CircleColouring`s
(`exists_pseudoCircle`, whose finiteness counts non-singleton pseudo-colour points rather than points of `Γ`). (i) across the two circles is `pair_i`.
The double event is `pair_ii` with H, or `bv_nd`. The route is BASE-V's BV-L3: one linkage loop, the band, the jump at `c₀ ∈ 3ℤ`. The step where BV-L3
reads "generic points interior to tiles" becomes "germs with one pseudo-colour", and the (P) sweep still applies there because the transversal
circle enters the side of the arc that carries the pseudo-colour. That is N3-I's argument and needs no new mathematics.

**Alternative weighed:** widen `RingProper` (K5b's vocabulary) so that `bv_l3` covers arcs. Rejected: `bv_l3` is FS114-BV-HEX's row clause, stated at its
own class (BASE-V assumes generic points interior). Changing it would change a row's statement.

**Statements changed:** none. `l3_base` is new, and `bv_l3` is left unused by the walk. Its circle-abstract core (the linkage band) should be one
lemma shared by both (handoff § 5).

### 2.3 Question 1 settled: `NoInertNear` stays as stated — and GAP-ELEVEN

**`NoInertNear`.** **Choice:** unchanged (every inert unit arc centred in `B̄(u, 1)` excluded, those ending at `u` included). **Why:** the walk reads it
as the finiteness of `ω(p)`'s pseudo-colouring at every pigeonhole centre `p ∈ B̄(u, 1)`. Those centres include V-in endpoints on `ω(u)`, and an inert
arc of `ω(p)` there may end at `u`. Excluding only the arcs not ending at `u` would leave an infinite set of two-colour points on that circle.
**Alternative:** the narrower definition (inventory item 199 (b)'s question). Rejected for that reason. **Statements changed:** none. **Owed by
`n3_base`'s proof:** the pre-bend of an inert arc that ends at `u` must keep `u` cubic trichromatic with its colours (NB3 step 4: "at the ends the sector
structure is unchanged"). This is a strengthened-bend child for wave 5's implementer, and the bends must be iterated until none is left (a bend can
remove a colour from a point on the arc that is itself a unit-arc centre).

**GAP-ELEVEN (sent to Keryx).** The `10 + 1` count needs a three-colour point `q ∈ B̄(u, 1)` carrying exactly two colours of `u` (whose tiles lie in
`B(u, 1)`, as Theorem D2 (ii) needs). Every source finds it on the outer rim of `R*`, the `P_cl(u)`-component of `u`, **once tiles are simply connected**
(hole-filling). In the local base, `u` is fixed and H holds only on `B̄(u, 2)`. A tile `R°` of a colour of `u` that encloses `u` inside `B(u, 1)` makes
`R*`'s outer rim border `R°` alone, and filling `R°`'s hole destroys `u`. I found no local contradiction for that configuration (all distances inside the
hole are below `1`; Lemma H holds). FS110-CD § 2.6 and § 2.8 item 2 named the multiply connected case and left it open. **Not a counterexample to
`Row134BaseUA`. It is a GAP at the walk's eleventh-point step** (FS112-N3-3 asserts it), so also at rows 135 and 137 through FS112-N3-BASE. Repairs, for
Keryx and the deriver: (a) a local argument excluding enclosure under H, or closing the pigeonhole without `q`; (b) add a no-enclosure hypothesis to
`Row134BaseUA` and have `localDense` choose an un-enclosed `u`, at radius 4 if needed (a row change); (c) `BaseHyp` at radius 3. The skeleton isolates
the step as `BaseCtx.exists_eleventh`, so no other leaf changes whichever repair is chosen.

## Stage 3 — SAVED: the skeleton

### 3.1 Layout

| module | contents |
|---|---|
| `Plane/ValidMap/BaseWalk` (new; imports `Dense`, `RingBand`) | `BaseCtx` (the base's context, bundled), `VIn`, `IsEndpoint`, `IsRetArc`; circle-abstract `CircleColouring.Removable`, `ChangeWith`, `IsHex`, `reduce`, `select`; 17 map leaves — **19 `sorry` leaves** |
| `Plane/ValidMap/BaseDense` (new; imports `BaseWalk`) | `row134BaseUA` (the assembly, one `sorry`), `n3_base`, `localDense`, `dense3`, `cv_exists` — **moved from `Dense`, statements and names unchanged** (`cor3` stays in `Dense`, which the walk imports) |

`Proofs.lean`, `ARCHITECTURE.md` (two rows, `Dense`'s row amended; `tools/check_architecture.py` PASS, exit 0) and `scripts/Axioms.lean` (block "FS-131 wave 5 (job FS131-KB)", 19
records) are updated.

### 3.2 Read-backs (each leaf against the walk's line it formalizes)

| leaf | the walk's line | read-back |
|---|---|---|
| `cubic_of_three` | NB3 "under H … every centre the base reads … is cubic" | three colours and H give cubic trichromatic in `B̄(u, 2)` — same |
| `pseudo_nonempty` | N3-3 "`c′ ≠ ∅`: … both-kind at `p`" | same, at every `p ∈ B̄(u, 1)` cubic (the walk applies it at `u` and at the pigeonhole centres) |
| `pseudo_ncard_le_two` | N3-3 "`|c′| ≤ 2`" (N3-COR3) | same |
| `pseudo_finite` | N3-3 "finitely many two-colour points" (after the pre-bend) | **wider reading**: finitely many non-singleton points per period, which is what the circle model needs |
| `exists_pseudoCircle` | NB3 step 2 ("the pseudo-colouring exists"); (i), (ii) | the pseudo-colouring as wave 3's `CircleColouring`, no swap point ((ii) in BV-H1's form, BASE-V step 3) |
| `reduce` | CD Lemma R steps 4–5; CE R3 | circle-abstract, given removable arcs that nest or are disjoint — same |
| `select` | Lemma 6 (BV-L5, BV-C6, BV-P18; CD § 2.5) | hexagon, or three change points per pair with chords `> 1` — same |
| `retArc_partner` | CD Lemma R step 3 | **path-free**: the two tiles' connectedness replaces the path `β`; same conclusion |
| `retArcs_finite`, `retArcs_nested` | CB D5 item 1 ("paths do not cross") | same; nesting is planar core |
| `exists_endpoint` | Prop. 19(b), CD Lemma E, CE R1–R4 | endpoint in the closures of the two tiles at the change point, in `B(u, 1)` or V-in — same, path-free in its statement |
| `exists_eleventh` | S–V p. 28; CD § 2.6; N3-3 | **GAP** (§ 2.3) |
| `endpoint_dist_ge` | CB D5 item 6 ("`|p − p′| ≥ 1`") | same, every `k` |
| `vin_antipodal`, `eleventh_antipodal` | CD Theorem D2 (i), (ii); CE's Antipodal Lemma | same |
| `cor3_base` | NB3 step 5 | same |
| `l3_base` | Lemma 3 (CB D4; BV-L3) | pseudo-colour form (§ 2.2) |
| `hex_base` | NB3 step 10 (Prop. 17) | same, through `p17_ua` |
| `eleventh_type` | Lemma 4's `10 + 1` | finite combinatorics — same |
| `row134BaseUA` | the table's assembly | statement unchanged; its docstring now states the assembly |

### 3.3 The build

See § 3.4 (filled at the commit that records it).
