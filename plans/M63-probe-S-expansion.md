# M63 probe — the small half's expansion menu, run to exhaustion (2026-09-11)

*A scoped experiment inside M63, spawned by the product owner from Poros's phase-D card 2
(`plans/POROS-2026-09-11-m63-phaseD.md`, "has-anyone-ever-expanded-the-S-half"). This file is the
registered record: predictions first, committed before the first solver starts, then the outcomes
scored as written. Instruments: `tools/parts_probe.py` (new, mine) and `tools/parts_run.py`
(committed, phase C's, used read-only and unmodified). Artifacts: `data/m62/m63-probe-*`.
Machine: the 32-core / 125 GB desktop, sharing the box with phase C's four reductions.*

## 1 — What is being asked, in one paragraph

`[Parts2020a]`'s record is 509 vertices: `L(374) ∪ ρ₁₅·S(136)`, the two halves sharing one centre
vertex, so the total is `374 + 136 − 1`. Heule's earlier 510-vertex graph is `L(375) ∪ ρ₁₅·S(136)`
with **the same small half**, so the whole of Parts's one-vertex gain was on the large half. His §6
says so outright: *"Reduction of S-subgraphs is briefly discussed in 5.10. Here we hardly improved
the result of Heule at all; only two edges were removed"* (`parts:811-812`), and his §5.10 gives the
S route as a single rough reduction — 187 vertices, several 169-vertex graphs chosen by numerical
indicators, then **one** reduction at output symmetry 1 (`parts:716-722`). His loop's other half,
**expansion**, was never applied to it. This probe applies it: fill each admissible base orbit into
his accumulative S-graph `v166e774`, reduce again against the frozen `v374e1860`, and see whether
anything lands below 136. One vertex below 136 makes the assembled object 508.

**It is not a record at 508.** The object is a record when every listed edge is verified at distance
exactly 1 in exact arithmetic and a CaDiCaL refutation with a checked LRAT proof exists. The Lean
kernel certificate is explicitly a later phase's job and this probe does not claim it.

## 2 — §PA, prior art for this probe specifically

M63's own prior-art gate is in `plans/M63-parts-reproduction.md`; this section covers only what is
new here — *has anyone expanded the small half?*

- `[Parts2020a]` §6 (`parts:811-812`) and §5.10 (`parts:716-722`): his own statement that the S side
  received one rough reduction and no iteration. His four-state expansion narrative (`parts:798-810`)
  is entirely about the L side, and names the orbits he added there — `(0,0,12,0)`, `(0,0,2,2)`,
  `(4,0,10,2)`, `(10,0,2,4)`, then `(0,0,0,4)` and `(0,0,6,6)` with `(4,0,0,0)` filled.
- `[Heule2019]`'s S half is the input, unchanged, to both published records.
- This repository: M63 §R1 reduced `v166e774 → 136` once, with no expansion; M62 and M64 never
  touched the S side's expansion. Searched `plans/` for any S-side expansion iteration: none.
- **Finding:** no published or recorded expansion iteration of the small half exists, by him, by
  Heule, or here. The falsifier stated in Poros's ledger (*"a published or recorded S-side expansion
  iteration"*) is not met.

## 3 — The admission rule, both readings, written out

This matters beyond this probe, because the same sentence sizes the large half's menu of 49 that
phase D's main sweep rests on. His §5.6, verbatim (`parts:517-521`):

> "Graph `R` is formed from base graph `B` and is updated after several successful iterations of the
> minimization procedure. **A base orbit is included in the graph `R` if, when added to the graph
> `A`, the degree of some of its vertices is at least 4.** (Note that the added base orbit generally
> splits into several orbits of graph `A`.) New orbits are added in order of decreasing vertex
> degree."

Three readings of "the degree", all computed by `tools/parts_probe.py menu`:

| reading | what counts toward a candidate vertex's degree | admits at `A166` |
|---|---|---|
| **into** (strict) | unit edges into `A` only | **6** |
| **plus** (literal) | unit edges into `A` **and** to the orbit's other added vertices — "*when added to* `A`" makes the orbit present | **11** |
| **all** (whole stage) | the above **and** `ρ₁₅` cross edges to the frozen companion `L374` | **12** |

They are ordered `into ≤ plus ≤ all` (asserted in the self-test). **The strict reading reproduces
Poros's census exactly** — same six labels, same degrees, same absent counts — on a base matching his
provenance to the digit (4,513 points, 229 orbits, 38,730 exact unit edges). The literal reading is
the one his own sentence states, and it admits five more; the cross-edge reading adds one more.

**Decision (choice · alternative · why · confidence).** Run the **union**, plus the degree-3
shoulder. *Alternative:* run the strict six, which is what was measured and what the product owner
initially authorised, at half the compute. *Why:* a wrongly-excluded orbit is the one failure mode
that leaves no trace in the output, and the extra eight runs are about two core-hours; a negative
that depends on which way an ambiguous sentence is read can be reopened by one sentence. *Confidence:*
high.

**The shoulder.** The per-orbit maximum absent-vertex degree into `A166`, over all 217 orbits with an
absent vertex: `{0: 139, 1: 55, 2: 14, 3: 3, 4: 3, 6: 2, 8: 1}` — independently reproducing Poros's
P4. Only **three** orbits sit at degree 3, so including them costs three runs and makes the sweep
independent of where his threshold is drawn. One of the three, `(0,4,8,0)`, lies **outside his own
radius-2 search disk** (both radii exactly `√5`), so this is also the first reduction anyone has run
against material his base excluded.

## 4 — The menu, as run (14 candidates)

`A = v166e774` (166 vertices, 774 internal unit edges — his filename's own number, reproduced),
companion `L = v374e1860` (374 vertices, 1,860 edges — likewise). A candidate **fills** an orbit: it
adds only that orbit's absent members, so `|A|` grows by the absent count.

| # | orbit | into | plus | all | absent/size | new `\|A\|` | gap | radii | in his `r=2` disk |
|---|---|---|---|---|---|---|---|---|---|
| 1 | `(0,0,6,6)` | 8 | 8 | 8 | 12/12 | 178 | 42 | 0.7923, 2.5243 | yes |
| 2 | `(12,0,0,0)` | 6 | 8 | 9 | 6/6 | 172 | 36 | 1.0, 1.0 | yes |
| 3 | `(12,2,2,0)` | 6 | 6 | 6 | 18/24 | 184 | 48 | 0.2918, 1.9786 | yes |
| 4 | `(0,0,8,0)` | 4 | 4 | 4 | 3/6 | 169 | 33 | 1.1547, 1.1547 | yes |
| 5 | `(12,0,2,6)` | 4 | 4 | 4 | 24/24 | 190 | 54 | 1.6958, 2.1888 | yes |
| 6 | `(12,2,6,0)` | 4 | 4 | 4 | 24/24 | 190 | 54 | 0.8671, 2.1404 | yes |
| 7 | `(6,4,6,0)` | 3 | 4 | 4 | 24/24 | 190 | 54 | 1.6589, 2.5654 | yes |
| 8 | `(2,0,0,2)` | 2 | 4 | 4 | 12/12 | 178 | 42 | 0.5774, 0.5774 | yes |
| 9 | `(2,0,4,2)` | 2 | 4 | 4 | 24/24 | 190 | 54 | 0.1685, 1.1423 | yes |
| 10 | `(4,0,2,2)` | 2 | 4 | 4 | 24/24 | 190 | 54 | 0.4253, 0.9051 | yes |
| 11 | `(6,2,8,0)` | 2 | 4 | 4 | 24/24 | 190 | 54 | 1.242, 1.8594 | yes |
| 12 | `(10,0,0,2)` | 1 | 3 | 4 | 12/12 | 178 | 42 | 1.0, 1.0 | yes |
| 13 | `(0,2,10,0)` | 3 | 3 | 3 | 12/12 | 178 | 42 | 1.7321, 1.7321 | yes |
| 14 | `(0,4,8,0)` | 3 | 3 | 3 | 12/12 | 178 | 42 | 2.2361, 2.2361 | **no** |

Rows 1–6 are the strict menu (Poros's six); 7–11 are added by the literal reading; 12 by the
cross-edge reading; 13–14 are the shoulder. Gap is `|A| − 136`, the baseline's being 30.

## 5 — Two derivations, before any number is read

**D1 — expansion cannot raise the minimum and cannot lose a minimum.** Whether a selection refuses
four colours depends on the selection together with the frozen companion, and on nothing else. So
every minimum of `A166` is still a refusing selection of any expansion of it, and the new minimum is
`≤ 136`. Each run therefore lands in exactly one of three states: **below 136** (the object the probe
is hunting), **136 with a strictly larger level `{M}`** (his own definition of a *successful
iteration*, the opening of a depth-2 move), or **inert** (136 with the level unchanged). *A run
reporting a minimum above 136, or a level that shrank, is an instrument fault.*

**D2 — the dangerous error is spurious, not missing.** A missing edge makes a graph easier to colour,
so it can only cause an under-claim. A spurious edge makes refusal easier and can manufacture a false
record. So the checking is deliberately asymmetric: an inert verdict is accepted on the instrument's
own controls, while anything below 136 gets exact re-verification of every edge plus an independent
refutation before the word "record" is used. (Both derivations were also put to me by Poros; I
re-derived them before adopting, and D1's three-state form is the one this file scores against.)

## 6 — Controls, and what halts the sweep

Fired before the sweep (`tools/parts_probe.py --self-test`, all green):

- **c1** Parts's own filenames encode edge counts, and our geometry reproduces all three: `v166e774`
  → 774, `v136e564` → 564, `v374e1860` → 1,860 internal unit edges. An independent check of the edge
  law against his published objects, which nobody had run.
- **c2** every vertex of `v166e774` and `v136e564` lies in an orbit meeting his radius-2 disk.
- **c3** the emitter round-trips through **his** parser: every candidate file written is re-parsed by
  `parts_vtx.load_lattice` and compared as a set before it is used.
- **c4** an off-lattice point is refused by the parser rather than rounded onto the lattice.
- **c5** the three degree readings are ordered, and the strict menu is inside the union.
- **c6** no already-complete orbit is offered as a candidate (12 orbits are complete in `A166`).

**c1b — the cross-edge count, checked against the record after an advisor's control failed.** Poros
reported its cross-edge machinery returning **54** edges between `v374e1860` and `v136e564` where
M63 §1(i) attests **18** (12 reference + 6 auxiliary), an exact factor of 3, and flagged that the
twelfth orbit of my menu, `(10,0,0,2)`, is the one that reading promotes. Re-derived here
(`scratchpad/probe-S/crosscheck.py`): **the stage — the object the solver actually sees — has 30
connection edges, 12 of them incident to the shared centre and 18 not touching it.** The record's 18
is reproduced exactly, and my whole-base relation also gives 18 not touching the centre. The inflated
54 is entirely centre-incident: the base relation lists both orientations of a centre edge and
attributes some to an S-side centre, which the arena forbids as a vertex. So there is no geometry
fault in either instrument, and the menu is unaffected — for every non-centre vertex the two counts
agree. **`(10,0,0,2)` survives on a real edge:** each of its members has internal degree 3 with its
own orbit-mates plus exactly one genuine cross edge to the shared centre, and the stage carries 12
such edges. The menu is 12 under the union of readings, not 11.

Fired per candidate, before its reduction (`tools/parts_probe.py control`):

- **c7** the stage's own vertex and edge counts, read from the stage rather than from an arena's
  internal index space (the failure phase D's planner hit: mixing the two halves' index spaces
  silently builds a different graph).
- **c8** the record's own S selection — the group image of `v136e564` that `A166` contains, since
  `v136e564 ⊄ v166e774` as stored — still refuses four colours in the expanded stage.
- **c9** every one of its 135 single-vertex deletions is four-colourable.

**c8 and c9 are invariant across all fourteen candidates by D1**, so a change in either between runs
is an instrument fault and not geometry: **the sweep halts and reports.**

**The baseline.** Phase C is regenerating the unexpanded reduction (`v166e774` against `v374e1860`)
as I write. Its attested values are `|M| = 136`, level 8 up to `Aut(A)` (48 as found), edges 564–567,
`A` equal to his `v166e774` as a set. If the regeneration disagrees with the stored record, that
matters more than this probe and the sweep stops until it is explained.

## 7 — Registered predictions

*Written before the first solver started; scored in §8 as written. Confidences are mine.*

| id | prediction | confidence |
|---|---|---|
| P1 | Every run returns `\|M\| ≤ 136`; none returns more, and no level shrinks (D1) | certain — a violation is a bug |
| P2 | **At least one of the 14 returns `\|M\| ≤ 135`**, i.e. an assembled 508 | **25%** |
| P3 | At least one run leaves `\|M\| = 136` but grows the level `{M}` past the baseline's 8 | 70% |
| P4 | Given any movement at all, it is in rows 1–6 (the strict menu) rather than rows 7–14 | 75% |
| P5 | Given any movement at all, `(0,0,6,6)` is involved — rank 1 by his own degree order, fully absent, and one of the two orbits his **L**-side move added | 45% |
| P6 | `(0,4,8,0)`, the `√5` orbit outside his disk, is inert | 80% |
| P7 | Every run closes (an exhausted level, no cap, no wall) in under 30 minutes CPU on one core; the six gap-54 runs are the slowest | 80% |
| P8 | The frozen-companion regime stays cheap: refusing-ask means under 0.5 s throughout, against the baseline's 0.108 s | 85% |
| P9 | The number of candidates whose level closes with `\|A\|` strictly larger than 166 (the accumulator actually grew) is at least 3 | 55% |

**Why P2 is only 25% despite nobody ever having tried.** The small half is adjacency-poor: 139 of
its 217 candidate orbits do not touch it at all, and only 9 reach degree 3 or more, against 72 for
the large half. There may be very little to expand it *with* — which is itself the likeliest reason
the side was never expanded. A clean negative across 14 candidates would therefore come close to
**closing** the single-orbit question for the small half rather than sampling it, and that is the
result this probe most probably produces.

## 8 — Outcomes

*Filled in as each run lands. Every candidate gets a row, inert ones included, with what made it
inert: `|M|`, level size and its method, whether the level closed or was capped, wall and CPU
seconds, and the two ask populations with their separate means.*

(pending)
