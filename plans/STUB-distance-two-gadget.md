# FS-49 — One gadget for six: a five-colour virtual edge at distance 2 over a 6-open field, with Exoo–Ismailescu's {1, 2} graph as host (STUB, 2026-09-14; from GPT Astra's `six-colour-research-directions.md` §1)

> Closed as a need, 2026-10-07: `χ(ℝ²) ≥ 6` holds with no MR (`[OAIMath2026]`); a finite six-chromatic unit-distance graph exists and none is explicit. An explicit one is not pursued (Kooshi: 'search for a finite graph is out').

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 33 → 12 in `plans/FRONTIER-STUBS.md`.** Route D, the finite-graph form of rung D, needing no MR; given FS-103's F1 (a candidate composition, not a result: given MR, row 120, and T-J39-3, at a real field with no non-thick stable place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`), such a graph exists iff `χ_CP(ℝ²) ≥ 6` (the advisor). Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR).

**At M3's close:** its measurable analogue is posed in print — Mixon's 2018 criterion (Polymath16 fourth thread): a five-colour forced `{1,2}`-vertex at an irrational angle proves `χ_µ(ℝ²) ≥ 6`; windows over finitely many places of ℚ(√167) cannot supply it from thick places (row 110).

*Read beside: `reference/ChatGPT-local-global-tightness-conjecture/six-colour-research-directions.md` §1 and `VERIFICATION.md`
row 9; `plans/M49-two-distance-descent.md` (the two-distance dial, and the descent that replaced the seed's distance-2 edges one
at a time), `plans/M63-phaseH4-sweep.md` (the arena's 1.3-billion-pair sweep, which already answers this stub's first test),
`plans/STUB-arena-slack-census.md` (FS-43, the instrument that prunes the candidates before any ask), `plans/STUB-fifth-colour-structure.md`
(FS-44); `LEDGER.md` rows 43, 44, 61, 66, G26, G31, G32, G53, G55; `Proofs/HadwigerNelson/OneDefect.lean`, `Homogeneous.lean`
(`Separated.transport`), `DistanceGraph.lean`.*

**Credit.** The host sentence — one five-colour virtual edge at distance 2 suffices for `χ(ℝ²) ≥ 6`, with `[ExooIsmailescu2019]`'s
graph as host — is GPT Astra's (2026-09-14); M49–M50 ran the same route one distance-2 edge at a time (the two-distance descent,
G32), and row 43 states the two-gadget form for the hex-shell host.

## 1. Mission context, in plain language

Exoo and Ismailescu's 426-vertex graph over `K = ℚ(√3,√11)` has 2,009 unit edges and 892 edges of length 2 and cannot be
five-coloured (`[ExooIsmailescu2019]`; re-derived exactly in M49, row 44). If some finite unit-distance graph `G` over a real
field `F ⊇ K` has two vertices `a, b` at distance exactly 2 that **every** proper five-colouring of `G` colours differently — a
five-colour *virtual edge* at distance 2, `Separated G 5 a b` — then placing an isometric copy of `G` on each of the 892 length-2
edges (the multiplier `(y − x)/(b − a)` has norm 1, so the copies stay in `F`) and discarding the length-2 edges gives a
unit-distance graph over `F` that cannot be five-coloured: **`χ(ℝ²) ≥ 6`**. One gadget, one host. Row 43's six-target needed two
gadgets (at `√3` and at 2) because its host is the hex shell; row 61's one-gadget form was over the distance set `{1, 2}`; this
is the one-gadget form for the unit-distance plane, and it is the sharpest statement of the six-target the record holds.

**What the record already says about where such a gadget can and cannot be.** Over every 5-sealed multiquadratic field
`⊇ K` a five-colour virtual edge is a unit edge (row 66: `Separated ↔ Adj`), so `F` must be **6-open** — `K(√7)`, `K(√13)`,
`K(√79)`, `K(√127)`, de Grey's field, … (G43). On the one purpose-built object in a 6-open field, the `ρ₆₃` arena, phase H4 swept
**every** pair for virtual edges — 1,306,721,748 of them, every pair at squared distance 4 included — and found none, certified
by 4,480 exhibited five-colourings (row 64, G31). So the advisor's proposed first test is already run and negative; the search
must be for a *different* object. The instruments that make that search something other than a blind sweep: (i) a virtual edge
needs a pair with **no shared gap in any five-colouring** (row 66, `not_separated_of_sharedGap`: one colour absent from both
closed neighbourhoods, repainted at both, makes them equal), so FS-43's frozen census, restricted to pairs at distance 2, kills
candidates by lookups on exhibited colourings before any refusal is asked; (ii) G53's counting compulsion gives the design
objective for an interface — force the fifth colour onto one side of a pair; (iii) M49's dial `μ(2)` (the fewest length-2 edges
of a non-five-colourable `{1, 2}` graph) reads `≤ 892` and a gadget is `μ(2) = 1`, so the descent that lowers it edge by edge
(M49 §R4 replaced 12 of 29 on the seed) is the same search run from the other end.

## 2. What we know

| fact | trust | where |
|---|---|---|
| the host lemma: a `Separated` pair at distance 2 plus `[ExooIsmailescu2019]`'s refusal gives `χ(ℝ²) ≥ 6` | derivation (transport by isometry; the composite stays in `F`) | `Separated.transport`, `Separated.planeIn` (row 43); `VERIFICATION.md` row 9 |
| the `{1, 2}` graph: 426 / 2,009 + 892, in `K`, not five-colourable | [L] + [C] (M49 re-derivation); **its refusal certificate is priced at ~50 M hints and deferred** | row 44; `plans/M49-two-distance-descent.md` |
| over a 5-sealed field `⊇ K`, `Separated ↔ Adj` at five colours | **kernel** | row 66 |
| the `ρ₆₃` arena has no virtual edge at any distance | measured, complete | row 64, G31; `plans/M63-phaseH4-sweep.md` |
| a shared gap kills a candidate pair | **kernel** | `not_separated_of_sharedGap`, row 66 |
| `μ(2) ≤ 892`; the seed's descent replaced 12 of 29 distance-2 edges by unit material | measured | M49 §R4, G32 |

## 3. Derivations first

**D1 — the host consumer in the kernel.** `six_le_chromaticNumber_plane_of_separated_two (hEI : ¬ (oneTwoGraph).Colorable 5)
(h : Separated G 5 a b) (hd : dist (q a) (q b) = 2) : 6 ≤ chromaticNumber (unitDistance ℂ)`: the union of the 892 transported
copies with the host's unit edges is drawn in `ℂ`; a five-colouring restricts to each copy, separates each length-2 pair, and
so five-colours the `{1, 2}` graph. Pieces: `Separated.transport`, a `Fin 892`-indexed union (FS-45's `chainUnion` generalised),
`DistanceGraph.lean`. **The blocker is `hEI`:** the `{1, 2}` graph's five-colour refusal as a kernel certificate (row 44's ~50 M
hints). Price the alternatives at opening: cube-and-conquer into kernel-sized cores as FS-38 K3 did (the LRAT core of a
125-vertex refusal replayed in 5.9 s), or a smaller `{1, 2}` six-forcer of our own from M49's descent. Until it lands, the
theorem is stated with `hEI` as a hypothesis and the vacuity gate's `DECLARED` reason names row 44.

**D2 — the candidate filter.** For a graph `G` over a 6-open field and a pair `(a, b)` at distance 2: `G` is a candidate only if
every exhibited five-colouring of `G` gives `N[a]` and `N[b]` no common absent colour. On thick `K(√7)`-fabric (FS-43 phase D's
dial) this is decided from FS-43's models by lookups; the survivors — pairs frozen-together in every colouring seen — are the
only pairs worth a refusal ask, and the ask is one SAT call with `c(a) = c(b)` pinned, verified either way (a model is the
answer; a refusal is re-asked on a second engine and, if it holds, is the jackpot protocol).

**D3 — the design reading, from G53.** Across a `√7` seam, a pair `(v, Rv)` at distance 2 sits on the circle `|p|² = 1` about
the centre in the type-M family (`|v − Rv|² = 2n(1 − cos θ) = 1` needs `n = 1`, which is not a member); off the diagonal, a
distance-2 pair `(v, Rw)` needs `|v − Rw|² = 4` — the cross-edge law of G52 at distance 2 rather than 1. Enumerate, for each
6-open member `n`, the distance-2 cross pairs the arena realises, and read G53's counting compulsion at those pairs: the fifth
colour forced to one side of the seam is a virtual edge across it.

**D4 — the dial, restated.** `μ(2)` over 6-open fields: each M49-style replacement of a length-2 edge by unit material lowers
it; the count of edges no unit material replaces at affordable size (M49's P5/P6, "stall value") is the measurement; the
gadget is the case where one replacement kills them all.

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| PA | the prior-art gate under "two-distance graphs", "{1, 2}-graphs chromatic number", "forbidden distance gadget", and the Polymath16 threads on Exoo–Ismailescu's graph (any attempt to replace its length-2 edges) | half a day | anything found is read before D2 runs |
| A | D1 stated in the skeleton with `hEI` declared; the certificate priced (cube-and-conquer core extraction on the 426-vertex refusal) | a day | the price on record; the theorem in the kernel modulo `hEI` |
| B | D2 on thick `K(√7)`-fabric, riding FS-43's dial: the distance-2 candidate list per thickness, the survivors after the shared-gap filter, the pinned asks on survivors only | a day per thickness; checkpoints under `data/fs49/ckpt/` with the resume command in the README | the first thickness with a survivor is the first place a distance-2 virtual edge could live; zero survivors at affordable thickness is the two-sided reading |
| C | D3 across the type-M members that are 6-open (`n = 16, 20, 44, …`): the distance-2 cross pairs and G53's count at them | a day | a member whose seam realises many distance-2 pairs is the next arena |
| D | D4: M49's descent re-run from the `{1, 2}` seed **in a 6-open field** (the seed is in `K`; adjoin `√7` material at the replacements) | days; priced first | `μ(2)`'s stall value one field up |

## 5. Registered predictions (both outcomes reachable)

| id | prediction | if it fails |
|---|---|---|
| P1 | on the arena and its depth-two thickening every distance-2 pair has a shared gap in some exhibited five-colouring (zero survivors) | a survivor is asked, two engines; a refusal is the jackpot protocol |
| P2 | the `{1, 2}` refusal's LRAT core, extracted as FS-38 K3 did, is under 10⁶ lines | the consumer stays declared; a smaller six-forcer from M49's descent is tried |
| P3 (hunch) | `μ(2)` one field up stalls above 1 at every affordable size, as it did in `K` | a run of replacements that does not stall is the first evidence for the six-target's constructibility |

## 6. Failure and jackpot clauses

Failure: zero survivors at every affordable thickness and a stalled `μ(2)` — then the reading is FS-44's (five-colourings of
6-open fabric are floppy everywhere), and the honest statement is that no object we can build carries the gadget. **Jackpot:**
a survivor whose pinned ask refuses on two engines — HALT AND VERIFY: the drawing re-checked exactly, the pair's distance an
identity in the field, the refusal replayed as an LRAT core in the kernel (FS-38 K3's recipe), the host lemma D1 applied; that
object is a six-chromatic unit-distance graph and the programme's target, a candidate until the kernel says so.

## 7. Bearing on 6, honestly

**The highest of any stub if it lands, and the genre that returned zero on the arena.** It is ranked below the derivation
milestones by G46's rule — a search whose failure is information about the search — and above the reading rooms because its
target is now a single, sharply stated object with a kernel consumer, and because FS-43's census turns the sweep into a filter
plus a handful of asks.

## 8. Addresses

`tools/arena_sweep.py`, `tools/twodist.py`, `tools/batchkill.py` (M49–M50), the H2 interface encoder; `data/m62/m63-phaseH2-rho63-certificate.json`,
`data/m63/m63-phaseH4-rho63-k5.json`; `Proofs/HadwigerNelson/OneDefect.lean`, `DistanceGraph.lean`, `Homogeneous.lean`, `FanGap.lean`;
`reference/ChatGPT-local-global-tightness-conjecture/six-colour-research-directions.md`; records to `data/fs49/`.
