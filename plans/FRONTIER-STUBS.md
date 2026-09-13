# The frontier stubs — the ranked set of next milestones

*Every row is a full stub in `plans/` (the stub rule, WORKFLOW § Plan). **This file holds current state
only**, under the same rule as `CLAUDE.md`: each close rewrites it in place, and the history of rankings,
re-scopes and closures is in git (`git log -p -- plans/FRONTIER-STUBS.md`; the last version carrying that
history is commit `65a60e6`). **Maintenance (WORKFLOW step 9):** the session closing a milestone updates the
open milestones, adds every candidate the milestone surfaced as a stub file, re-ranks the table with each
row's bearing on χ(ℝ²) ≥ 6 stated honestly, moves finished or demoted stubs to the closed list with one line
(and a banner in the stub file), and mirrors the result into `CLAUDE.md` § Paths forward. **FS numbers are
permanent identifiers: after every edit, assert on the written file that each of FS-1 … FS-N appears exactly
once as a row.***

**The ranking rule (G46).** Name each stub's object in the vocabulary of the classical theory it already
belongs to, and let that theory decide the question's shape before any search runs. Prefer a stub whose
question becomes a finite exact computation plus a named theorem over one that searches for an object; a
stub with no such recognition is a reading room, not a milestone; a search's failure is information about
the search's genre. Every stub is read against the field sieve: a route to χ ≥ 6 must end in a 6-open field
(`plans/M58-field-sieve.md`).

**How a milestone is chosen.** Kooshi picks; the default is the top. A milestone takes its number when it
*runs*, not when it is chosen, and its record becomes `plans/Mxx-<name>.md`. Spec-shaped versions of several
stubs, with acceptance gates and stop rules, are in `plans/BACKLOG-FOR-OPUS.md` (FS-17 as B3, FS-16 as B5,
FS-12 as B6, FS-8 as B7, FS-5 as B8, FS-13 as a measure-only run); none of them has been built.

## Open milestones, in order

Kooshi, 2026-09-10: *"the next session will be 100% repro of his algo. The session after that will be
introducing our new angle on it."*

| milestone | what it is | state | next, and bearing on χ ≥ 6 |
|---|---|---|---|
| **M63** — reproduce `[Parts2020a]`'s minimization algorithm end to end (FS-33) | `plans/M63-parts-reproduction.md` | The reduction stage is reproduced on every attested number — his S-subgraph M6A row returns 136 vertices, 8 minima up to his group, edges 564–567, and his accumulator exactly as a set — with complete level sets, about 150× faster than his implementation (§R1). M64 has since stored the correction-set hypergraph and computed every symmetry rung for the two recorded stages. | **Phases C–E**: the correction-set hypergraph work, the held-out runs, the outer loop, the intermediate symmetry rungs. Bearing: none directly — it is M62's calibrated bed. |
| **M62** — the evolutionary type-M search | `plans/M62-evolutionary-type-m.md` — beat 509, the smallest known 5-chromatic unit-distance graph, with a search whose genome, feasibility filter and fitness come from this project's theorems | Paused for M63. Done: Parts's base reconstructed from his §5.6 (FS-31); the arena rebuilt at radius 2.44, containing Heule-510 exactly; the speed campaign (§R23), which measured that a pure descent cannot reach the record. Best 1-minimal objects 624 / 576 / 558 / 582 at symmetry order 24 / 6 / 3 / 1; best object 559 vertices, census-certified. | Resume after M63 with Parts's full loop, reduction plus expansion; **phases D and E are not run**. Bearing: indirect — it is the rehearsal for FS-6, which is the same search one colour up. |

## Ranked stubs

> **RE-RANKED 2026-09-12 at M63 phase H3's close. This block states the current order and supersedes the
> numeric column below it, which is left in place so no row's text is lost.** Two things set the ranking:
> **a five-chromatic unit-distance graph now exists in a 6-open field** (ledger row 64) — 51,133 vertices at
> `ρ₆₃` in `ℚ(√3,√7,√11)`, refusal *produced* rather than inherited; every previous witness this project can
> screen is 5-sealed, so the only known mechanism for the sixth colour had no platform, and now has one. And
> **phase H3 closed its own successor** (ledger row 65), which removes the top row rather than adding one.
>
> **Current order:**
> 1. **FS-6 the six-level design target** — **promoted to the top**, since the direction that outranked it is
>    closed.
>
> **CLOSED AS A DIRECTION, 2026-09-12 — dropping `[Parts2020a]`'s coordinate shape** (was rank 1;
> `plans/M63-phaseH3-drop-the-shape.md`, bannered; record `plans/M63-phaseH3-plan.md`). **The object is
> four-colourable at every radius, by derivation**, and the reason generalises into a base-free screen:
> the additive-pair route is **ARENA-AT-RISK** when `4 ∤ n` and **ARENA-IMMUNE** when `4 | n`. Run over
> Parts's **shaped** lattice, every member he can realise with a nonempty circle is either **odd** — at risk,
> and dead anyway to the 2-adic wall — or **`4 | n` and immune**. **So dropping the shape reaches only
> members this route kills.** `n = 16` is the cheapest 6-open immune member, nothing lies below it (4, 8, 12
> are 5-sealed), and it is realisable **shaped** at 25,567 points, which *is* phase H2's object. **Every
> member worth having was already reachable on Parts's lattice; the shape-free construction has no target.**
> The premise it was chartered to test is nevertheless **confirmed** — at `n = 4`, the record's own rotation,
> dropping the shape takes monochromatic off-diagonal cross edges **0 → 144**. **Residual, priced not
> pursued:** `n = 10` (`K(√13)`, 6-open, `4 ∤ 10`) is at risk and **uncomputed** at ~6.6 M points, past the
> present Python tooling, where truncation biases toward a false "four-colourable". **Un-computed is not a
> verdict**, and it changes no ranking. Six family-level results survive in ledger row 65.
>
> 2. **FS-6's own detail, unchanged in content** — **promoted from 4.** Unchanged in content; what changed is that
>    G48's mechanism now has an object to stand on, and the arithmetic bar that blocks it (a five-colour
>    forced pair needs `11 ∣ d²`) **does not apply in `K(√7)`**, where 11 has residue degree 2.
> 3. **FS-20 the paper** — **demoted from 1 on urgency, not value.** Still the publication trigger, still
>    blocked on the same two items; but phase H2 added material a write-up would want to include, so writing
>    now would be writing early.
> 4. **FS-22 √7 phase pinning** — **largely ANSWERED and demoted from 10.** Its question was whether a
>    construction could be made to land in `ℚ(√3,√7,√11)`. One does, reached by a different route (the
>    rotation family at `n = 16`, not the Moser twist substitution), and the field's 6-openness is now
>    confirmed by direct computation rather than cited. What remains of it is only whether *his* route also
>    lands there, which is a curiosity now that the field is occupied.
> 5. **FS-30 consume the rotation list** — **demoted from 2; its central question is CLOSED.** The rotations
>    are classified by one integer and screened by four gates we already hold. Two live remainders, both
>    recorded: `moser_ball_exact` enumerates an infinite set with its `span` default silently *being* the
>    answer, so the stored census is a property of span 4 and **its regeneration is unrun**; and the
>    withdrawn claim "nothing on either base is 6-open" is replaced by an explicit list of seven 6-open
>    members at `n ≤ 32`.
> 6. Everything else keeps its previous order.
>
> **The honest caution on all of the above:** phase H2 decided **one object**. The criterion it produced —
> that refutation by the diagonal family needs six ten-element sets to form an intersecting family — applies
> to every base, and **nothing shows a base satisfying it exists.**

| rank | stub | the question | bearing on χ ≥ 6 | cost | status |
|---|---|---|---|---|---|
| 1 | **FS-20 the paper** — `plans/STUB-theorem-B-writeup.md` | One reduction, derived independently in seven lineages that barely cite one another, each stopping where `[Madore2015]` Prop. 3.9 declines to formulate the general case — **Theorem A is that formulation** — with χ(ℚ(√3,√11)²) = 4 closing Madore's 4 ≤ χ ≤ 5 and settling a question posed or named as open at least six times (`CLOSED-QUESTIONS.md` §1.1 — Moorhouse §1, Cranston–Rabern, Exoo–Ismailescu's conclusion, Polymath16; for Benda–Perles Open Problem 11.6 it settles one field of the family asked about). The novelty check is complete: nothing anywhere contradicts the value. **Naming is a first-class deliverable** (the release from the write-up deferral covers this result only). Blockers: FS-27 §2 (read `[Polymath16wikiR2]`, which attempts Theorem B's argument; give Theorem A's headline form a worked example), `[Johnson2006]` (the Geombinatorics digital archive) and `[Fischer1990b]` (interlibrary loan, Congressus Numerantium 72) — the request list is the library's notes | none; ranked on the publication trigger | 4–6 days writing; no compute, no new Lean | minted 2026-09-08 on Kooshi's trigger |
| 2 | **FS-30 consume the rotation list** — `plans/STUB-consume-rotation-list.md` | **The 412 never counted rotations** (corrected by M63 phase G, 2026-09-11): a rotation of this kind joins only points collinear with its centre, so they enumerate exactly over the base's lines — one stored entry can hold several, **91 of 150 hold none**, the list was computed on the wrong base, and only 150 of the 412 reached disk — the wrong base being the Moser ball rather than the §5.6 lattice
the record lives on. **The file's own numbers are correct for what it computed**: an exact regeneration
reproduces 412 on that ball edge for edge, so what was wrong is the base and the unit, never the arithmetic.
Its honest admissible count there, with radius families counted correctly over all 1,336 classes, is **37**
(a truncated top-150 sample suggests ~90 and is biased upward, being the family-richest slice). The exact enumeration on Parts's own base gives **26 candidates and six angles past the 2-adic filter — which are TWO rotations** once counted up to the base's own symmetry, since reflection, half-turn and the arithmetic flip swapping the two square roots make a rotation's four sign-and-conjugate variants one arrangement relabelled (its signature: the same 126 cross edges decomposing as 60+36+30, 2×18+30+60 and 2×33+0+60). One is Parts's own; **one is a new class in a field no published construction uses**. **"Nothing on either base is 6-open" was WITHDRAWN 2026-09-12** — it rested on `moser_ball_exact`, which cuts on one conjugate only, so *"the Moser lattice inside radius r"* is an **infinite** set and the `span = 4` default silently *was* the answer: at radius 5 it reports 14 points on `|p|² = 16` where the converged value is **18**, and 4 on `|p|² = 20` where it is **36**, while the totals never converge (3,893 → 9,733 → 17,851 → 28,267 at spans 4/6/8/10). The stored census `data/m62/rotations-exact-moser-r2.05.json` is a property of span 4, not of the base, and its own self-test compared it against `build_base(r, span=4)` — the same truncation twice, so it could never bite. **6-open rotations DO exist on Parts's own lattice** (`plans/M63-phaseH2-the-family.md`): the usable angles are classified by one integer, `cos θ = (2n−1)/(2n)` with diagonal circle `|p|² = n`, the record is `n = 4`, and the 6-open members with a nonempty circle over his lattice at `n ≤ 120` are **16 (30 circle points), 20 (60), 44 (30), 60 (84), 64 (30), 76 (60), 108 (66), 112 (60)** — `n = 16` being `ρ₆₃` = `ω₁₆` of `[Polymath16wikiMain]`'s own 2018 list and a generator of de Grey's ring `ℤ[ω₁,ω₃,ω₄,ω₁₆]` (hence of G8's set), in `ℚ(√3,√7,√11)`, the field FS-22 points at independently. **The angle family and its spindle reading are that page's, not ours** (G7); what is ours is the radicand form, the field screen, 6-openness, and **dropping its restriction to Loeschian `t` — `n = 2` is not Loeschian**, an independent second reason it appears in nobody's census. Tool unfixed and census unregenerated; both are open items. **Count rotations up to symmetry, never angles** — four negatives that are one negative is a false count in the census's own headline. `[Parts2020a]` §4: *"working constructions of type M with other rotations are not known yet"* — because none exist, or because nobody enumerated them? Either answer is a result. Rank candidates by radius families, wall-breaking radicand and 6-openness, never by cross-edge count (maximal coupling keeps the rotation inside ℚ(√3,√11), where Theorem B kills it). **The "cheaper lead" was false and is withdrawn:** the seven are radius *pairs sharing a field*, of which three can carry an edge and two are the rotation's own — and Parts uses **both**. There are **zero** unused families | medium — the 6-openness ranking is FS-6's tie | days | minted 2026-09-10 |
| 3 | **FS-35 the expansion step's look-ahead** — `plans/STUB-expansion-measure.md` | Parts's loop does not need a termination measure — expansion only enlarges, so the minimum cannot increase — its problem is stagnation. The aim is to **price a candidate expansion before paying to reduce it**, which M64 makes free: every rung's minimum comes from the stored hypergraph by hitting-set duality, with no colouring ask. **Precondition, half an hour:** compute the candidate quantities (the exchange-class vector, the per-rung closure bound) at each state of Parts's one recorded four-state path; if they read flat, retire the stub | indirect; the direct input to M62's expansion step | days | minted at the M64 close; re-aimed the same day (`plans/POROS-2026-09-10-b-closure-equality.md`) |
| 4 | **FS-6 the six-level design target** — `plans/STUB-family-keeping-thickening.md` (§H is the handoff) | **M62's sequel: the same search one colour up.** A pair forced equal at five colours over a 5-sealed field (ℚ(√3,√5,√11), ℚ(√3,√11,√247), ℚ(√3,√11,√23)) at a distance with 11 ∣ d²; its spindle (√43, √131, 5√7, √10, …) is then a 6-forcer in a field that is 6-open by construction (G48). The stub's material route is a family-keeping thickening of de Grey's half-spindle closure, with M59's hub scan as the enumerator — **note, corrected 2026-09-12: de Grey's field ℚ(√3,√5,√7,√11) is itself 6-OPEN** (G43, measured), so on that route the `11 ∣ d²` constraint above does **not** apply and the sealed-then-spindle bookkeeping is the wrong frame; what a forced pair there needs is only that its own spindle radicand keeps the field 6-open. The three listed 5-sealed fields are correct, but none of them is de Grey's. Polymath16 posed the target in 2018 at d = 5/3, where the residue law forbids it, kernel-checked for every √7-free certificate with 11 ∤ D (`not_forces_five_thirds_11`; `CLOSED-QUESTIONS.md` §1.4) | medium — the only known mechanism to χ ≥ 6 | days | chosen by Kooshi at the M61 close; runs after M62 |
| 5 | **FS-27 the consolidation remainder** — `plans/STUB-consolidation-remainder.md` | §2 the paper's two blockers (see FS-20). §3 the fourteen private copies of √3·√3 = 3, moved into a new leaf module `Field/Radicals.lean` last and alone in the main tree; G5; G6 (derive its witnesses in sympy first); E2 (before the radicals item), E6, E7. §4 the three-way collapse of `Forces.comap`, `Separated.comap` and `transport_pair_of_isometry`, alone in the main tree. §5 the `Instances/OneTwo` docstring reference (ride along with the next edit to those files) and two `[Parts2020a]` Table 1 rows to read by eye | none; §2 blocks the paper | §2 an afternoon and an hour; the rest 2–3 days | §1 closed 2026-09-09 |
| 6 | **FS-23 the knowledge web** — `plans/STUB-prior-art-web.md` | What its §R4 leaves: draw the seven lineages' citation graph, including the edges that do not exist (FS-20's central evidence), and re-verify the older bibliography rows resting on `[Fischer1990]` and `[Moorhouse2010]` against the PDFs. Held and not yet read: `[MMST1996]`, `[Woodall1973]`, `[Coulson2004]`, `[Exoo2005]` | none; stops G49 recurring and feeds FS-20 | about a day | phases A and C closed 2026-09-09 |
| 7 | **FS-19 the 𝔭-adic classification of forbidden distances** — `plans/STUB-padic-distance-classification.md` | `[Chow1993]` classifies the distance sets a 2-colouring of ℚ³ can forbid by v₂(d²); the number-field analogue by v_𝔭(d²) appears unasked, and Theorem A is the generality that makes it askable. Sharp form C3: does a colouring at N(𝔭) > 2 forbid only one valuation class? If yes, "the residue method is blind above four" becomes a structural theorem | low-medium; a derivation with the machinery already in the kernel | 2–4 days | minted 2026-09-08 |
| 8 | **FS-37 the 2-adic colouring criteria at the field level** — `plans/STUB-field-level-criteria.md` | The kernel holds both 2-adic criteria's mechanisms — four colours by Theorem A, two by FS-36's `TwoColourResidue` — for an explicitly given valuation subring, and not that a real multiquadratic field meeting a criterion supplies one. Can it prove `[−1] ∉ V₂(F)` ⟹ χ(F²) ≤ 4 and `[−1], [3] ∉ V₂(F)` ⟹ χ(F²) = 2, or at least χ = 4 for the factors FS-36 names (ℚ(√3,√11,√14), ℚ(√3,√11,√70), ℚ(√2,√3,√11,√35), ℚ(√3,√10,√11,√35))? Check first whether Mathlib has grown a residue-degree computation for Kummer extensions | none; feeds FS-20's field section and closes Theorem A's own gap (`plans/A1-theorem-A-kernel.md` §R2) | a week or more by an explicit order; less if Mathlib computes the residue degree | minted 2026-09-11 by FS-36's planning |
| 9 | **FS-16 the residue-allowed distances** — `plans/STUB-residue-allowed-distances.md` | Over a 5-sealed field a five-colour virtual edge can live only at d² ≡ 1 (mod 11) (2√3, 8/3, √23, …) and a forced pair only at 11 ∣ d². Why do M55's theorem-admitted candidates concentrate at residue norm 1 (51 of 86 undecided), and are any of the 51 virtual edges? | low-medium — a filter and a census; negative knowledge made cheap | hours plus a day of CPU | minted 2026-09-07 |
| 10 | **FS-22 √7 phase pinning** — `plans/STUB-sqrt7-phase-pinning.md` | `[Parts2020hv]` uses √5 at exactly one step, to pin phases; the Moser twist does that job inside ℚ(√3,√11), which would land the object in ℚ(√3,√7,√11), a 6-open field | medium — material in a 6-open field by an arithmetic route | days | minted 2026-09-09 |
| 11 | **FS-13 the finite planes' 6-critical cores** — `plans/STUB-finite-plane-cores.md` | The planes refuse five colours from p = 59 up, but CDCL does not see it at 17,161 vertices in an hour; cube-and-conquer over a neighbourhood's colourings, or a sphere shrink at 59 and 83, would give autopsy objects for clique-free forcing with exact algebraic tools. `[Krebs2022]` is read: its χ > ω result is weaker than what we hold, so the gap question is ours | low-medium — a mechanism bed, not an object | days | minted at the M59 close |
| 12 | **FS-17 the first digit at 23** — `plans/STUB-first-digit-23.md` | Is UD(𝔽₂₃,2) exactly 5-chromatic? χ ∈ {5,…,8}: ϑ = Hoffman = 4.02, the periodic family needs 8, and no 5-colouring has rotational symmetry of order ≥ 3. Priced routes: cube-and-conquer on the half-turn family, and on the independence-number instance | medium as a frame, low as work | a day, priced | minted at the M61 close |
| 13 | **FS-12 the hub scan as a design instrument** — `plans/STUB-hub-scan-design.md` | The finite plane enumerates an object's exact depth-one hubs over every field at once; next, a hub whose support is forced rainbow at five colours is a kill (A1), decidable on the object | medium-low — an instrument; no kill until a support is rainbow | days | minted at the M59 close |
| 14 | **FS-2 Kempe classes** — `plans/STUB-kempe-classes.md` | What carries forcing when the additive family does not: ℚ(√3,√11)-fabric's 16-pair residue and the seed's 252-cheat subset (the seed's own half is answered, M57 §R2). Any design consequence must be carried to a 6-open field | medium, mechanism only | 1–2 days | minted at the M56 close |
| 15 | **FS-8 the Haugland 7-adic check** — `plans/STUB-haugland-7adic.md` | Does the heptagonal 5-forcer's field have a degree-one prime above 7 (then the plane at 7 makes it 4-colourable and the external claim is wrong), or does its detuning adjoin a 7-inert radical? The paper is read; its graph is not imported | low-medium — a falsifier of an external claim | half a day plus the import | minted 2026-09-06 |
| 16 | **FS-29 the overclaim check** — `plans/STUB-vacuity-coverage.md` §Phase C | 67 theorems take a `Forces`/`Separated`/`Fan` hypothesis, which is vacuously true when k colours are refused, so a consumer's conclusion can be true, non-vacuous and still overclaimed. The planned check was hypothesis mutation: delete a binder, re-elaborate, require the proof to break. **FS-36's audit measured that check's limit** (`plans/FS36-multiquadratic-decomposition.md` §R3): a proof that names a binder always breaks when the binder is deleted, so a break shows use, not need, and a vacuous `Forces` binder breaks the same way. The check needs a counterexample per binder, or the proof re-run from the emptiness the binder hides | none | a day or more; research-shaped | ranked at the FS-36 close |
| 17 | **FS-9 topological lower bounds** — `plans/STUB-topological-bounds.md` | Does any unit-distance graph have a Borsuk–Ulam-type lower bound above 3? The 791-forcer's central symmetry is a free ℤ₂-action | low-medium; a reading room | 1–3 days | minted 2026-09-06 |
| 18 | **FS-10 Nullstellensatz certificates** — `plans/STUB-nullstellensatz.md` | Colourability as a polynomial system, refuted by a bounded-degree identity the kernel checks with `linear_combination` — a second certificate genre beside LRAT, first on the spindle and the 9-, 23- and 122-vertex cores | low-medium; a reading room | 2–3 days | minted 2026-09-06 |
| 19 | **FS-5 bookkeeping** (no stub file) | The ν = number-of-spindles law (T25) and the plane instance of `extends_of_hubs` | low | an afternoon | listed at the M57 close |

## Closed, absorbed and demoted

One line each. The stub files carry banners; the milestone plans hold the records.

| stub | became | record |
|---|---|---|
| FS-1 additive rigidity | M57: the reduction theorem and the closure gauge; nothing held is rigid | `plans/M57-additive-rigidity.md` |
| FS-3 thickened material | **demoted**: ℚ(√3,√11,√247) is 5-sealed, so nothing built there is 6-chromatic | `plans/STUB-thickened-material.md` |
| FS-4 Theorem B in the kernel | closed 2026-09-08 (ledger row 57), with Theorem A on top | `plans/STUB-field-wall-kernel.md`, `plans/B1-field-wall-kernel.md` |
| FS-7 the field sieve | M58 | `plans/M58-field-sieve.md` |
| FS-11 the finite-plane lift | M59: a finite-plane subgraph lifts only if it is a shadow | `plans/M59-finite-plane-lift.md` |
| FS-14 the five-colour residue obstruction | M60 | `plans/M60-five-colour-residue-obstruction.md` |
| FS-15 local–global tightness | M61: the tightness mechanism (G48); its first digit re-minted as FS-17 | `plans/M61-local-global-tightness.md` |
| FS-18 read the library | closed 2026-09-08 | `plans/STUB-library-read.md` §R |
| FS-21 the 2-adic law of four-colour compulsions | closed 2026-09-09 (ledger row 59). Its sketched follow-up, no virtual edge at √3 over ℚ(√3,√11), needs a √3 carrier inside that field first: `core9`'s points are not in it (FS-27 §1) | `plans/STUB-four-colour-valuation-law.md` |
| FS-24 generalize the kernel | closed 2026-09-09; remainder in FS-27 | `plans/STUB-generalize-the-kernel.md` |
| FS-25 explain the unexplained | closed 2026-09-09 (E1, E3, E4, E5); remainder in FS-27 | `plans/STUB-explain-the-unexplained.md` |
| FS-26 the vacuity audit | closed 2026-09-09: no second vacuous theorem exists; remainder in FS-27 | `plans/STUB-vacuity-and-record-integrity.md` |
| FS-28 the vacuity gate's coverage | closed 2026-09-09: a clean negative, and four defects in the gate fixed; its Phase C is FS-29 | `plans/FS28-vacuity-coverage.md` |
| FS-31 Parts's base | closed 2026-09-10: his base is the closed form in his §5.6 | `plans/M62-evolutionary-type-m.md` §R19 |
| FS-32 the reduction stage as smallest group-MUS | **absorbed** 2026-09-10: opened and measured — the exact method does not scale here and pure reduction cannot reach the record (§R3) — which pointed to reproducing Parts's full loop; M63 then reproduced the reduction stage exactly | `plans/FS32-smus-reduction.md` |
| FS-33 reproduce Parts's algorithm | opened as M63 (above) | `plans/M63-parts-reproduction.md` |
| FS-34 overcompression as a face phenomenon | M64: overcompression is an orbit-closure gap (ledger row 62) | `plans/M64-orbit-filling-polytope.md` |
| FS-36 the multiquadratic handoff | closed 2026-09-11 (ledger row 63): Theorem A's two-colour case, the 2-adic splitting and the field-level decomposition in the kernel, with two test-passing fields whose compositum's plane needs five colours; the field-level criteria carried to FS-37 | `plans/FS36-multiquadratic-decomposition.md` |

**Directions closed by theorem or measurement:** many spindles over one fabric (absorption, `plans/M55-absorption.md`
§R); extracting a gadget from an existing witness, including the five-colour class-avoidance hunts (G31); FS-3's
additive pre-filter (vacuous on ℚ(√3,√11,√247), `plans/M57-additive-rigidity.md` §R5).
