# FS-70 — five colours over ℚ(√3,√5): the subplan

*Written 2026-09-21 by the milestone's planner (Fable 5.1), from the stub `plans/STUB-five-over-sqrt3-sqrt5.md`, the owner's gate
note `data/fs70/owner/gate-2026-09-21-fields.md`, a first-hand reading of `[Haugland2026]` §§2–4 and `[Soifer2024]` ch. 54, and
the measurements in §2 below, which the planner ran itself. Written for an implementer with no memory of any session: every
number here is reproducible from the tools named, every claim carries its grade, and every phase says what a kill redoes.*

*Standing rules that bind every phase (their reasons are in `CLAUDE.md`, whose disk copy is authoritative over any loaded
snapshot): no agent started from this milestone starts another agent; one heavy job at a time; every run over ~15 minutes
checkpoints to a path named in this plan and never runs under a `timeout` wall alone; kill by PID or process group and verify
by effect; exit statuses read from the program, never through a pipe; symmetry broken before every SAT ask and an `UNKNOWN`
from an unbroken encoding never reported as a fact about a graph; nothing is a result until an independent checker says so;
`./scripts/build.sh` only, never `lake build`; commits by explicit path, never push, never amend; `tools/fs58_*.py` and
`tools/fs61_*.py` are frozen (copy, do not edit); `data/fs70/owner/` and every `plans/STUB-*.md` are the owner's.*

---

## 0. The question and the answer's shape

**Is there a finite unit-distance graph with coordinates in ℚ(√3,√5) that cannot be four-coloured?** The local–global conjecture
(`CLAUDE.md` G48) says yes — the field's usable residue planes are 11, 59, 71, so its local bound is 5, and the record holds
`χ(ℚ(√3,√5)²) ∈ {4, 5}` with 4 from FS-48's six-rhombus chain. No Moser spindle can be drawn in the field (√11 is missing), so a
refusal is the first five-chromatic unit-distance graph this project has built without one — and the *only* kind a
sixth-colour construction over a window field could ever use (G57).

The answer's shape is fixed by the chain theorem (G55): a finite graph over the field that forces two points at difference
`δ` to share a colour in every 4-colouring, plus `m` copies chained along unit vectors `u₁ + ⋯ + u_m = 1/δ`, plus one closing
edge, needs five colours **inside the field**. So the milestone is a hunt for **one four-colour forced pair at a chainable
distance**, and §3.5 lists the chainable distances with their copy counts (2 → two copies, `4/3` → three, `4` → four, `8/3` → six).
Everything else — the closure, the certificate, the kernel form — is mechanical once that pair exists.

---

## PA. The prior-art gate (WORKFLOW 3a, all eight items)

*Run 2026-09-21 by the planner. Raw API responses are under `data/fs70/planner/pa/` (`zb-*.json`), so every count below can be
re-derived. The owner's part 1 (`data/fs70/owner/gate-2026-09-21-fields.md`) settled the fields of the two published
Moser-free forcers; this section covers the rest.*

### PA.1 The object in the disciplines' words, and what each search returned

| discipline / query (zbMATH Open API unless stated) | hits | what they are |
|---|---|---|
| `ab:"Moser spindle" \| ti:"Moser spindle" \| ab:"Moser-spindle"` | 8 | `[ExooIsmailescu2019]`, `[Heule2021]`, `[Voronov2021]`, `[Haugland2026]`, Leo Moser's collected papers, Cranston–Yancey (sparse graphs, off-topic), one 2023 *Mathematics Magazine* item (V. Jungić, doi 10.1080/0025570X.2023.2176684, title withheld by licence — an expository piece by its venue; **not read, listing only**), one off-topic 2026 labelling paper. **Nothing on a specific number field.** |
| unit-distance graph × number field (`ab:"number field" \| "quadratic field" \| "quadratic extension" \| "field extension"`) | 3 | Maehara 1991 (rigid unit-distance graphs), Sawin 2026 (the unit distance problem), one licence-withheld 1973 item. **None about chromatic numbers over a field.** |
| chromatic number of the plane × (`biquadratic \| quartic \| real quadratic \| subfield \| rational plane \| algebraic`) | 32 | only `[Fischer1990]` and `[AxenovichEtAl2014]` are on topic (both held, both in the bibliography); the rest are proceedings volumes and unrelated graph theory. |
| five-chromatic × (unit \| plane \| distance) | 16 | the known five-forcer papers (`[Heule2019]`, `[Parts2020a]`, `[Heule2021]`, `[Voronov2021]`, `[Haugland2026]`), de Grey's 2026 triangle-free five-chromatic graph in ℝ³ (61 vertices; **in dimension three, not the plane** — it does not bear on this field), Exoo–Ismailescu 2023 (hyperbolic plane), and unrelated colouring papers. |
| monochromatic pair / virtual edge × (unit \| colouring) | 7 | `[Heule2021]`, Davies 2024 (*Odd distances in colourings of the plane*), Davies–McCarty–Pilipczuk 2026 (*Prime and polynomial distances in colourings of the plane*) — the odd-distance line, not the unit-distance one; the rest off-topic. |
| additive colouring × (plane \| unit distance \| chromatic) | 92 | only `[Fischer1990]` is ours; "additive coloring" in graph theory means a different notion (Bartnicki et al.). |
| `au:"Polymath" & py:2019-2021` | 2 | **`[Polymath2021]`** — D. H. J. Polymath, *On the chromatic number of circular disks and infinite strips in the plane*, Geombinatorics 30(4) (2021) 190–201 (zbMATH 7362696; the author's summary read through the API). Not held; see PA.3. |

**The question itself** — has anyone computed or asked for `χ(ℚ(√3,√5)²)`, or for any field with local bound 5 outside K's
extensions? **No.** The held Polymath16 threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`, all eighteen)
contain no mention of ℚ(√3,√5) as a field (searched as `sqrt(3), sqrt(5)`, `√3, √5`, `Q(√3,√5)`, `sqrt3, sqrt5`: zero windows);
`[Soifer2024]` ch. 54 names ℚ(√2,√3,√5) and ℚ(√2,√3) and no other field; `[Fischer1990]` treats ℚ(√3,√5)² only through his
Theorem 10 family (multiquadratic fields); `[Moorhouse2010]` §8–10 and `[Madore2015]` §3–4 give the residue bounds and no
lower bound above the Moser spindle's. Benda–Perles Open Problem 11.6 (*"the chromatic number of any algebraic extension of
ℚ²"*, `CLOSED-QUESTIONS.md` §1.7) is the question's general form and lists no biquadratic instance.

### PA.2 The posers' complete listings (item 8)

Pulled through `au:"…"`: Haugland (16 entries; exactly one on the subject), Voronov (8 with chromatic/distance terms; the 2022
paper and its sphere/slice sequels), Neopryatnaya and Dergachev (2 each, both joint with Voronov), Heule (8 with the terms;
the three known plus SAT-methods papers), Parts (12; all known), Fischer (27; the three known). Johnson, Moorhouse and Madore
were listed at FS-61's gate (`plans/FS61-quadratic-census.md` §PA) and nothing new has appeared under their names since.
**Nothing found that an earlier gate had not.**

### PA.3 What the citation walks found — two databases, two posers

`[Voronov2021]` (doi 10.1016/j.disc.2022.113106): OpenAlex lists **6** citing works, Semantic Scholar **6**, overlapping in
four (the sphere and slice papers, the SAT-encoding note, a 2025 generalized-Petersen note). Each database holds two the other
lacks — OpenAlex the **Soifer chapter below** and a 2023 embedding-search paper; Semantic Scholar arXiv:2201.04499 (*Coloring
distance graphs on the plane*, interval-of-distances colourings — abstract read, off-topic). `[Haugland2026]` (arXiv, August
2026): not yet indexed by either. The two-database rule earned its keep: **the one citing work that matters is in only one of
them.**

**`[Soifer2024]` ch. 54, "Can We Reach Chromatic 5 Without Mosers Spindles?" (pp. 693–697; held in `~/source/library/`, read in
full 2026-09-21)** — the question is *Open Problem 54.1 (Soifer 2018)*: *"Find a 5-chromatic unit-distance graph in the plane of
the smallest order that has no Mosers Spindle subgraph."* The chapter also settles the one open field of the owner's gate and
hands over a construction recipe:

1. **Heule's 1,441 is in ℚ(√2,√3,√5)²** and its forcing fabric `T721` (721 vertices, 3,948 edges) in **ℚ(√2,√3)²**: *"a reasonably
   small set of points in ℚ(√2,√3) × ℚ(√2,√3) ... such that a pair of points at distance 2 is monochromatic in all
   4-colorings"*, closed by the spindle argument (which adjoins √15). Its building block is a ten-vertex four-chromatic graph
   Soifer names *the Heule spindle* — `[Voronov2021]`'s seed `L₁₀,₂`. So **all three known Moser-free five-forcers have their
   forcing fabric in a field whose plane is exactly four-chromatic by a residue colouring at 2** (ℚ(√2,√3), wall standing) **or
   in ℚ(ζ₈₄)⁺, and close with `ρ₁₅`; none is a ℚ(√3,√5) object.** Expectation E1 of the stub is met for all three.
2. **The Polymath16 strip forcer** (`[Polymath2021]`, quoted by Soifer): fifty-four unit vectors at the angles `mπ/3 + n·arccos(5/6)`,
   `m ∈ [0,5]`, `n ∈ [0,4]` — that is `ζ₆^m ρ^n` with `ρ` the Moser twist, K-fabric — all points that are sums of at most four of
   them, and *"the vertices at (0,0) and (8/3,0) have the same color in any 4-coloring"*; trimmed to a strip of height
   `(11+7√3)/12`, 61,216 vertices, still forcing. **This is a four-colour forced pair at distance 8/3 over K, in print.** Its
   origin is earlier still: **Jannis Harder, Polymath16 first thread, 28 April 2018** (held: the threads' text, searched
   2026-09-21) — *"The graph V + V + H not only precludes monochromatic triples, but forces the point (8/3, 0) to have the same
   color as the origin. This allows for a simple spindle construction with the angle arccos(119/128) ... The smallest subgraph
   ... 745 vertices"* — and de Grey's reply the same day discusses cutting it below 745. **M56's "8/3 forcer" (the 588-vertex
   core of `data/m53/forced-spindle-core-8over3.json`, credited as ours in `CLAUDE.md` G55, row 47 and `plans/STUB-chain-theorem.md`)
   is a rediscovery of Harder's April-2018 forcer, at 588 vertices against his 745.** The owner should move the credit; the
   object stands (and its spindle field K(√247) is row 47's). The shape — a small direction *group* `ζ₆^m ρ^n`, sums of at most
   four vectors, a forced pair at `8/3` — is the template §3.3 transposes to ℚ(√3,√5).

### PA.4 What this teaches about our own object (WORKFLOW 9's sweep, done at the opening)

* Every known five-forcer, Moser-based or not, is **forcing fabric plus a closer**: the fabric lives in a field whose plane a
  residue colouring at 2 seals at four (K for de Grey/Heule/Parts, ℚ(√2,√3) for Voronov/Heule-1441) or in a wall-broken field
  where the fabric's four-colourings are additive (Haugland's §4), and the closer is `ρ₁₅` or its relatives. Over ℚ(√3,√5) the
  wall is broken by 15 ≡ 7 (mod 8), so there is no residue colouring of the whole plane — but §3.1 shows the plane is graded by
  a 2-adic depth, its depth-zero sub-plane **is** sealed at four by the residue at the split prime, and every wall-breaking
  direction is a power of one vector `w` with `w⁴ = ρ₁₅`. The known recipe has a literal transposition here (§3.3).
* The forced distances the literature reaches are `2` (Haugland, Heule-1441, de Grey's spindles), `8/3` (Harder), `√3`
  (Haugland's virtual edge). §3.4's additive screen says which of these are *possible* on which ℚ(√3,√5)-fabric, and it rules
  Haugland's √3 virtual edge out on every lattice of 2-units — the brief's first ask is dead on the fabric it was aimed at,
  and alive only on wall-breaking fabric.

### PA.5 Bibliography actions (applied 2026-09-21)

`[Soifer2024]` — ch. 54 read in full, recorded; `[Polymath2021]` — new row (not held; Geombinatorics; the strip paper);
`[Polymath16threads]` — Harder's 28 April 2018 comment recorded as the origin of the 8/3 forced pair; `[Heule2021]` — its
graph's fields recorded from Soifer ch. 54 (a claim relayed through a book, not a reading of the paper, which stays on loan
list item 5). `[Voronov2021]`'s public data (`github.com/vsvor/dist-graphs`) noted as a positive-control source beside
Haugland's Appendix A.

---

## 1. Deliverables (the contract)

1. **Either** a certified five-chromatic unit-distance graph over ℚ(√3,√5) — exact coordinates in the nine-integer point format
   of §4.2, the complete unit-distance graph on those points re-derived by a frozen standard-library checker that also replays
   the LRAT refutation and refuses twelve named planted faults, a 1-minimal core, and the kernel form
   `five_le_chromaticNumber_planeOver_threeFive` through the `UDCert` pipeline (§5) — **or** a typed null: every lattice asked,
   every ball's size and degree, every verdict with its solver, budget and encoding, the additive screen's table, and the
   structure of the colourings found (§3.6), so that the null says which instrument stopped and not "the field".
2. The records under `data/fs70/` in the format of §6, one jsonl row per ask, appendable and resumable.
3. The tools `tools/fs70_field.py`, `tools/fs70_fabric.py` (the planner's, to be hardened in phase 0), `tools/fs70_ask.py`
   (phase 1), `tools/fs70_check_witness.py` (phase 2, frozen at first CERTIFIED), `tools/fs70_emit_witness.py` (phase 2).
4. The owner's close (phase 3): the ledger row, the grokking, FS-48's siblings re-aimed, the credit move of PA.3.

---

## 2. What the planner measured before specifying (WORKFLOW 3: cost decides shape)

All on the desktop, 2026-09-21, with `tools/fs70_field.py` (exact arithmetic for ℚ(√3,√5) and its `i`-extension, the
valuations at the primes above 2, 3, 5) and `tools/fs70_fabric.py` (lattices, saturation, the additive screen, Haugland's
`T_n`, Minkowski balls, CNFs). Self-test: `python3 tools/fs70_field.py --selftest`.

### 2.1 The unit vectors by denominator, with their depths

`units_of_denominator(M)` enumerates every unit vector `((a+b√3+c√5+d√15)/M, (e+f√3+g√5+h√15)/M)` exactly. Counts and depths
`(v_𝔓₂, v_𝔓₃, v_𝔓₅)` (§3.1 defines them; `v_𝔓₂` is the *2-adic depth*):

| M | count | depths |
|---|---|---|
| 1, 2 | 4, 8 | all `(0,0,0)` — the twelve 12th roots of unity |
| 3 | 8 | `(0, ±2, 0)` — `u = (−2+i√5)/3` and its `i`-rotations and conjugates |
| 4 | 16 | `(±2, 0, 0)` ×8: `v = (1+i√15)/4` and relatives; `(±1, 0, 0)` ×8: `w = ((√3+√5) + i(√5−√3))/4` and relatives |
| 5 | 16 | `(0, 0, ±1)`, `(0, 0, ±2)` — `(3+4i)/5`, `(2√5+i√5)/5`, … |
| 6 | 24 | `(0, ±1, 0)` ×8, `(0, ±2, 0)` ×16 |
| 7 | 16 | `(0, 0, 0)` — `(1+4i√3)/7`, `(2+3i√5)/7`, …: 2-, 3- and 5-units with poles above 7 |
| 8 | 48 | 2-depths `±1, ±2, ±3, ±4`; `ρ₁₅ = (7+i√15)/8` has depth `∓4` |
| 9, 10, 12 | 8, 32, 64 | 3-depth ±4; 5-depths; mixed 2- and 3-depths |
| **11** | **0** | as it must be: 11 is usable for the field, every unit vector is 11-integral |
| 13, 14 | 32, 48 | all `(0,0,0)`: poles above 13 and 7 |
| 16 | 48 | 2-depths `±3 … ±6` |

The wall-breaking directions are exactly the vectors of nonzero 2-depth, and they are one tower: `w² = ζ₁₂³·v̄` and
`w⁴ = ρ₁₅` (exact; `fs70_field.py --selftest` checks `ρ₁₅ = −v̄²`). So the field's wall-breakers of depth 1, 2, 4 are `w`,
`w²`, `w⁴` up to roots of unity, and the type-M rotation at `n = 4` (G7) is a **fourth power** in ℚ(√3,√5)(i).

### 2.2 Lattices, their saturations and the additive screen

For a generating set `S` (closed under `ζ₁₂` and conjugation), `Λ = ℤ⟨S⟩` (rank 8 whenever `S` leaves `ℤ[ζ₁₂]`), `g = |Λ ∩ U|`
its full unit-vector count (§3.2's method), and the additive screen (§3.4): the number of homomorphisms `φ : Λ → G`, `G ∈ {ℤ/4,
(ℤ/2)²}`, nonzero on every unit vector of `Λ`, and among them how many send `i√3`, `2`, `4/3`, `8/3` to `0`.

| generators | g | additive ℤ/4 (of which `φ(i√3)=0`, `φ(2)=0`, `φ(4/3)=0`, `φ(8/3)=0`) | additive Klein (same) | verdicts |
|---|---|---|---|---|
| `ζ₁₂` | 12 | 36 (12, 12, 0, 0) | 36 (0, 36, 0, 0) | rank 4; `4/3, 8/3 ∉ Λ` |
| `ζ₁₂, u` (2-units) | 36 | **1296 (432, 432, 1296, 1296)** | 1296 (0, 1296, 1296, 1296) | √3 virtual edge **dead**; distance-2 forced pair **dead**; `4/3`, `8/3` **allowed** |
| `ζ₁₂, u, q₇` (2-units, `q₇ = (1+4i√3)/7`) | 60 | 1296 (432, 432, 1296, 1296) | 1296 (0, 1296, 1296, 1296) | as above — the 7-family adds unit vectors and no constraint |
| `ζ₁₂, v` (depth ±2) | 36 | **0** | **0** | no additive four-colouring exists — **but every vector is a 3-unit: dead by the 3-adic gate (§3.1)** |
| `ζ₁₂, w` (depth ±1) | 36 | 288 (96, 96, –, –) | 480 (0, 480, –, –) | √3 dead, distance 2 dead; `4/3, 8/3 ∉ Λ`; **all 3-units: dead by the 3-adic gate** |
| `ζ₁₂, u, v` | **300** | 0 | 0 | none; the lattice is dense (covolume 1.3·10⁻⁴) |
| `ζ₁₂, u, w` | 180 | 0 | 0 | none; dense (2.1·10⁻³) |
| `ζ₁₂, u, ρ₁₅` | — | — | — | saturation by `qfminim` overflows a 4 GB PARI stack: use §3.2's method B |

**Reading the table.** On every lattice of 2-units the ℤ/4-valued additive colourings include ones with `φ(i√3) = 0` — a proper
four-colouring of *any* graph drawn in the lattice in which `0` and `i√3` share a colour — so **Haugland's √3 virtual edge is
impossible on 2-unit fabric over this field, at every radius**, and equally a forced pair at distance 2 (432 colourings
separate it). What every additive colouring of 2-unit fabric respects is `φ(4/3) = φ(8/3) = 0`: **the chainable distances on
2-unit fabric are `4/3` and `8/3`** — exactly Harder's distance over K (PA.3), where the same arithmetic holds (`1/3 ∈ ℤ[U]`).
The lattices holding `1/2 = v + v̄` admit no additive colouring at all (§3.4's theorem), so on them nothing is ruled out by
this screen and nothing is coloured for free.

### 2.3 Pilot asks (kissat 4.0.4, one thread, precedence-broken encodings; every verdict SAT)

| fabric | shape | points / edges / avg degree | ask | verdict, wall time |
|---|---|---|---|---|
| `ζ₁₂, v` | `T₆(0 → i√3)` | 2,115 / 10,489 / 9.9 | triangle-pinned control; `A = B` pinned | SAT 0.00 s; SAT 0.06 s |
| `ζ₁₂, v` | Minkowski ball `R = 2` | 3,793 / 15,990 / 8.4 | control; sep √3; eq √3; sep 2; eq 2 | all SAT, ≤ 1.2 s |
| `ζ₁₂, v` | Minkowski ball `R = 2.5` | 19,957 / 111,990 / 11.2 | control; sep √3; eq 2 | SAT 0.3 s; SAT 10.9 s; SAT 3.7 s |
| `ζ₁₂, u` | `T₄, T₆ (0 → 4/3)` | 136 / 396; 2,188 / 10,128 / 9.3 | control; eq `4/3`; sep `4/3` | all SAT ≤ 0.06 s |
| `ζ₁₂, u` | `T₈ (0 → 4/3)` | not built | — | the rational-arithmetic BFS reached 5.8 GB in 7.5 min and was killed by PID (verified gone): **integer coordinates are mandatory** (§3.7) |

**Every one of these verdicts is predicted by a theorem the plan had not yet stated when they were run** (§3.1's 3-adic
gate, found by the domain-modeling pass): the lattices `ζ₁₂, v` and `ζ₁₂, w` consist entirely of 3-units, so every graph drawn in
them is 3-colourable through the residue plane `UD(𝔽₉²)`, and a 3-colourable graph carries no four-colour compulsion of any kind.
The planner's structure test on the 20k-point colouring looked for a period and for factoring through `Λ/2Λ` and `Λ/4Λ` and found
neither — it asked at the wrong prime (G21: the instrument measured its own enumeration); the 3-adic rule is a function of `Λ/3Λ`,
and §3.6's instruments now test every split prime. The `ζ₁₂, u` asks (`T₄`, `T₆`) are honest but far below the degree the law
names (§2.4).

### 2.4 The ball law with four embeddings, and why balls are out

The finite fabric FS-61 used — every lattice point whose real embeddings all lie in a disc of radius `R` — has four embeddings
here, so the count is `≈ π⁴R⁸/covol(Λ)` and G65's degree law becomes **`degree ≈ g·φ(R)⁴`** with `φ(R) = [2R²·acos(1/2R) −
½√(4R²−1)]/(πR²)`. Measured against predicted at `ζ₁₂, v`: `R = 2`: 3,793 points / degree 8.43 against 3,152 / 7.9; `R = 2.5`:
19,957 / 11.22 against 18,790 / 11.2. **Degree 14 needs `R ≈ 3` whatever `g` is** (`φ(3)⁴ = 0.387`). Covolumes: `ζ₁₂, v` 7.91;
`ζ₁₂, w` 14.06; **`ζ₁₂, u` 0.549** (1.16 M points at `R = 3`); `ζ₁₂, u, q₇` 2.3·10⁻⁴; `ζ₁₂, u, v` 1.3·10⁻⁴. Every lattice that
passes the 3-adic gate of §3.1 contains `u`, hence `1/3`, hence is dense (covolume `≤ 0.55`), so **a Minkowski ball at degree 14
costs a million points on every honest lattice: the ball is not a shape for this milestone.** The shapes are the path shapes —
Harder's *sums of at most `k` vectors* and Haugland's `T_n` lens with a `k`-core — whose size is governed by `|S|` and `k`, not by
the covolume. The ball law stays as the calibration of the degree an ask has reached.

---

## 3. The derivations the phases stand on

### 3.1 The 2-adic depth grading [derived, exact; verified by the tool on every vector of §2.1]

The prime `𝔭` of `F = ℚ(√3,√5)` above 2 (`e = 2`, `f = 2`, residue field `𝔽₄`) **splits** in `E = F(i)`: `−15 ≡ 1 (mod 16)`, so
`√−15 ∈ ℚ₂` and `i = √−15/(√3√5)` lies in the completion. Write `𝔓, 𝔓̄` for the two primes of `E` above it (complex conjugation
swaps them) and `v_𝔓` for the valuation normalised by `v_𝔓(𝔓) = 1` (so `v_𝔓(2) = 2`). For a unit vector `z`, `z z̄ = 1` gives
`v_𝔓(z) = −v_𝔓̄(z) =: depth(z) ∈ ℤ`, a **homomorphism** from the unit-vector group to ℤ. Consequences, each one line:

* **The 2-units** (`depth = 0`) are a subgroup `U₀`; the residue map `ψ : O_{E,𝔓} → 𝔽₄` is additive and sends every 2-unit
  to `𝔽₄^× `, so **every graph whose edge directions are 2-units is 4-coloured by `ψ`** (Theorem A, `colorable_of_residue`),
  and its complex conjugate `ψ̄` at `𝔓̄` is a second such colouring. The 2-unit sub-plane is exactly four-chromatic: the FS-48
  chain (`u` is a 2-unit) gives ≥ 4.
* **A unit vector that is a difference of two 2-integral points is a 2-unit** (integral at both primes and `v_𝔓 = −v_𝔓̄`). So
  a lattice of 2-units contains no wall-breaking unit vector, and Haugland's 84 vectors — differences of vertices of his
  heptagonal graph `H`, whose vertices `P_j, Q_j, R_j` are 2-adic units of ℚ(ζ₈₄) — are **all 2-units**: his forcing fabric is
  2-unit fabric and `ρ₁₅` is his only wall-breaker, like every other known forcer (PA.4).
* **Under `ψ`,** `ψ(2) = 0` (distance-2 pairs are monochromatic — G16's pigeonhole in residue form), `ψ(i√3) = ψ(ζ₆) + ψ(ζ₆²)
  = ω² + ω = 1 ≠ 0` (a √3 pair is bichromatic), and a four-colour forced-equal pair on 2-unit fabric needs `ψ(d) = ψ̄(d) = 0`,
  i.e. `d ∈ 𝔓 ∩ 𝔓̄`: distances `2, 4/3, 8/3, 4` qualify and `√3` does not.
* **The 3-adic gate [derived from row 72's mechanism; the value `χ(UD(𝔽₉²)) = 3` measured 2026-09-21 with a symmetry-broken
  encoding, two colours refused].** The prime of `F` above 3 has residue field `𝔽₉` and splits in `E` too (`i ∈ ℚ₃(√5)`), so a
  unit vector of 3-depth zero is a 3-integral point of `F²` whose reduction lies on the eight-point circle of `𝔽₉²`, and Theorem A
  maps every graph drawn in a lattice of 3-units into `UD(𝔽₉²)`, which is 3-colourable. **A 3-colourable graph has no four-colour
  pair compulsion at any distance** (row 45's spare-colour lemma: recolour one endpoint, or both, with the spare colour). So **every
  lattice asked at four colours must contain a unit vector of nonzero 3-depth** — `u`'s family (depth ±2) or the denominator-6
  family (depth ±1) — and the lattices `ζ₁₂, v` and `ζ₁₂, w`, whatever their additive screen says, are dead by theorem. The
  residue planes at the other split primes do not obstruct: `UD(𝔽₂₅²)` and `UD(𝔽₄₉²)` refuse three and four colours (measured,
  same encoding, `χ ≥ 5`), and the plane at 11 has no four-colouring. **The gate runs before the additive screen, on every
  lattice: no 3-non-unit, no ask.**

### 3.2 The saturation of a lattice, two methods [exact]

`Λ ∩ U` is finite. **Method A** (`fs70_fabric.py Lattice.saturation`): the trace form `B(λ,μ) = Tr_{F/ℚ}(xx' + yy')` is the
standard inner product of the Minkowski embedding `F² → ℝ⁸`, a unit vector has `B(λ,λ) = 4`, PARI's `qfminim(G, 4, , 2)`
enumerates every lattice vector of `B`-norm `≤ 4` exactly, `gp` filters by the four embeddings, Python decides `|λ|² = 1`
exactly. Fails (stack) when the lattice is dense enough that the candidates exceed ~10⁷ (`ζ₁₂, u, ρ₁₅`). **Method B** (FS-61's,
to be written in phase 0): `Λ ⊆ (1/M)ℤ⁸` for the lattice's denominator `M`, so `Λ ∩ U ⊆ ⋃_{d | M} units_of_denominator(d)`;
enumerate `x` over the box of `F`-elements with denominator `d` and all four embeddings in `[−1, 1]`, keep those with `1 − x²`
a square in `F` (filter first by the rational norm being a perfect square), and test membership. Affordable to `M ≈ 60`.

### 3.3 The Harder recipe, transposed [the phase-1 template]

Over K: fifty-four vectors `ζ₆^m ρ^n` (`n ∈ [0,4]`), all sums of at most four, a forced pair at `(0, 8/3)`. Over ℚ(√3,√5) the
2-unit rotation of the smallest denominator is `u = (−2+i√5)/3` (3-depth 2, `1 + u + ū = −1/3`), and the transposition is
**`S_k = {ζ₁₂^m u^n : 0 ≤ m < 12, |n| ≤ k}` with `k = 2` (60 vectors) and the fabric = all sums of at most four of them**, asked
at `(0, 4/3)` and `(0, 8/3)` for a forced-equal pair (`4/3 = −u − ū`, `8/3 = −2u − 2ū`). Why this and not the ζ₁₂-orbit alone: the
Moser ring is generated *multiplicatively* by `ζ₆` and `ρ`, and Harder's fabric is the ring's degree-≤ 4 part; the ℚ(√3,√5)
analogue is the ring `ℤ[ζ₁₂, u, ū]`, whose degree-≤ 4 part is this. Two more knobs, in order: `k = 3`, and sums of at most five.

### 3.4 The additive screen and its theorem [derived; the counts of §2.2 are exhaustive]

An additive four-colouring of `Λ` is `φ ∈ Hom(Λ, G)`, `|G| = 4`, with `φ(z) ≠ 0` on `Λ ∩ U` (G41). It four-colours every finite
graph in `Λ`; so **if some `φ` has `φ(δ) = 0`, no graph in `Λ` has a virtual edge at `δ`; if some `φ` has `φ(δ) ≠ 0`, no graph in
`Λ` has a forced-equal pair at `δ`.** The screen is `Hom(Λ, G) = G^rank` enumerated in full (`4⁸ = 65,536` per group), seconds
per lattice, and it runs **before any SAT ask on any lattice**. Its theorem: **if `Λ` contains `½·{1, ζ₆}` then `Λ` has no additive
four-colouring** — `φ(1) = 2φ(½)` and `φ(ζ₆) = 2φ(ζ₆/2)` lie in `2G`, so in the Klein group both vanish and in ℤ/4 both equal 2,
whence `φ(ζ₆ − 1) = φ(ζ₆²) = 0`; the lattices `ζ₁₂, v` and everything containing them are of this kind, since `v + v̄ = ½`.
On 2-unit fabric, `3 · (1/3) = 1` forces `φ(1/3) = −φ(1)` in ℤ/4, so `φ(4/3) = φ(8/3) = 0` always (allowed) while `φ(2) = 2φ(1)`
and `φ(i√3)` vary (dead as forced pair and as virtual edge respectively, by the explicit colourings the screen exhibits).

**The screen's product is a sublattice, not four booleans** (the domain-modeling pass): every additive colouring factors through
`Λ/4Λ`, and the set of differences every additive colouring makes monochromatic is **`Λ_forced := ⋂_φ ker φ`, a sublattice with
`4Λ ⊆ Λ_forced ⊆ Λ`**, computed once per lattice as an HNF basis. A forced-equal pair at `δ` is additively allowed iff `δ ∈
Λ_forced`; the chainable targets of a lattice are then `Λ_forced ∩ {δ : 1/δ ∈ ℤ[U]}`, read off in one pass rather than tested one
`δ` at a time (the four-entry table of §2.2 is the same object sampled). The residue colourings `ψ, ψ̄` of §3.1 are themselves
Klein-additive colourings of any 2-unit lattice, so `Λ_forced ⊆ ker ψ ∩ ker ψ̄ = 𝔭Λ`-ish automatically: one instrument covers both.
Phase 0.2 emits `Λ_forced` per lattice into `screen.jsonl`.

### 3.5 The chain closers over the field [exact, `fs70_field.py --selftest`]

With `v = (1+i√15)/4`, `v + v̄ = ½`, `v² + v̄² = −7/4`, `ρ₁₅ = −v̄²`:

| forced distance `δ` | `1/δ` as a sum of unit vectors | copies | the object |
|---|---|---|---|
| 2 | `v + v̄` | 2 | the `ρ₁₅` spindle (Haugland, Heule-1441, Parts) |
| **4/3** | `−1 − v² − v̄²` | **3** | copies rotated by `−1`, `ρ̄₁₅`, `ρ₁₅` about the chain points — a three-copy spindle |
| 4 | `1 + 1 + v² + v̄²` | 4 | |
| **8/3** | `−v³ − 2v − 2v̄ − v̄³` | **6** | Harder's distance; over K it needs the spindle into K(√247), here it closes inside the field |

The chain (G55, Theorem 4.1): copy `j` is `z ↦ s_{j−1} + u_j z` with `s_j = δ(u₁ + ⋯ + u_j)`, `s_m = 1`; the union plus the edge
`0 — 1` is not four-colourable. FS-45's kernel form (`not_colorable_chainUnion`) does not exist yet; §5 says how the certificate
avoids needing it.

### 3.6 What colours the fabric — the structure instruments [G21's obligation]

A SAT-found four-colouring is a measurement of the encoding until its structure is known. Three cheap instruments, run on
every colouring the phase records: (i) **quotient screen** — is the colouring a function of `Λ/L` for `L ∈ {2Λ, 3Λ, 4Λ, 5Λ, 6Λ,
7Λ}` — one `L` per split prime at which the lattice is integral, because a residue colouring at `p` is a function of `Λ/pΛ`
(count monochromatic classes); (ii) **period screen** — for each candidate period `t` (all `2s, 3s, 4s`, `s + s'` over `S`), the
fraction of points with `c(p + t) = c(p)`; (iii) **the imposed-quotient ask** — add `c(p) = c(p + t)` clauses for a candidate
period and re-ask: a SAT answer is a periodic colouring rule and a theorem-shaped null (FS-61's quotient screens), an UNSAT
answer says the free colourings are the only ones. A null in phase 1 is reported with (i)–(iii)'s readings or it is not typed.
**Positive control for the instruments** (phase 0.4): on the `ζ₁₂, v` ball of §2.3 the imposed-quotient ask with `L = 3Λ` must
return SAT (the 3-adic residue colouring lives there) while the same ask on an `S₂` fabric of §3.3 must not find a `3Λ`-periodic
colouring at all — the instrument sees the rule the planner's `2Λ`/`4Λ` test missed.

### 3.7 Arithmetic and shape costs [measured, §2.3]

Points must be integer 8-tuples over one denominator `M` (addition is tuple addition; a hash is a tuple); `Fraction`
arithmetic is 20× slower and blew the memory at `T₈`. The word ball of radius 8 in the 36-generator rank-8 lattice has millions
of points: **never build a `T_n` by two full BFS runs**; build Harder's sums-of-≤-4 set directly (≤ 60⁴/24 ≈ 5·10⁵ words, far
fewer points), or the Minkowski ball by `qfminim` (§3.2 A) at the `R` the law names.

---

## 4. Phases

Each phase is one implementer's brief; each records to `data/fs70/records/phase-X.md` (a running log the owner reads by
artifact) and to the jsonl files of §6. **Cheapest first; a refusal anywhere jumps to phase 2.**

### Phase 0 — the fabric (half a day; no solver)

| step | what | acceptance |
|---|---|---|
| 0.1 | Harden `tools/fs70_field.py` / `fs70_fabric.py`: integer coordinates over a lattice denominator; §3.2 method B; a `--selftest` that plants three faults (a non-unit vector accepted, a wrong depth, a lattice basis that drops a generator) and watches each refuse | `python3 tools/fs70_field.py --selftest` and `tools/fs70_fabric.py --selftest` green; the §2.1 table reproduced to `M = 24` and extended to 42 (`data/fs70/atlas.jsonl`) |
| 0.2 | The screen table of §2.2 reproduced and extended to every lattice named in phase 1 (§4.1), plus `ζ₁₂, u, ρ₁₅` by method B; per lattice the 3-adic gate (does `Λ ∩ U` hold a 3-non-unit?) and the HNF basis of `Λ_forced` with its chainable targets (§3.4) | `data/fs70/screen.jsonl`; a lattice whose screen changes from §2.2 is a defect to explain, not a finding; `ζ₁₂, v` and `ζ₁₂, w` must read "gate: fails" |
| 0.3 | **The positive control**: Haugland's `G₁` rebuilt exactly in ℚ(ζ₈₄) from Appendix A (the 84 vectors as `ζ₈₄`-polynomials: `u_{2j} = ζ₈₄^{2j}`, `u_{2j+1} = ε·ζ₈₄^{2j}`, `ε = u₂₉ ζ₈₄^{−28}`, `u₂₉ = (−√3 + i(4cos(π/7) − 1))/(4 sin(2π/7))` with `√3 = ζ⁷+ζ⁻⁷`, `i = ζ²¹`, `cos(π/7) = (ζ⁶+ζ⁻⁶)/2`, `sin(2π/7) = (ζ¹²−ζ⁻¹²)/(2ζ²¹)`); verify `|u₂₉|² = 1` exactly and that his 740 vertices / 3,985 edges come out; ask `A = B` at four colours with our encoding | UNSAT, reproducing his CaDiCaL refusal — the instrument sees a known positive one field over. Budget 2 h; if the counts differ, the derivation of `ε` is wrong before anything else is |
| 0.4 | The residue-plane values behind §3.1 re-derived: `χ(UD(𝔽₉²)) = 3`, `UD(𝔽₂₅²)` and `UD(𝔽₄₉²)` refuse four colours (symmetry-broken; a 2-colour refusal at 9 as the control that the encoding can refuse) | recorded in `data/fs70/records/phase-0.md` with the encodings' shas |
| 0.5 | The structure instruments of §3.6 with their positive control: the imposed-quotient ask at `L = 3Λ` on the planner's `ζ₁₂, v` ball (`build/fs70/ball-v4-25`, regenerable) returns SAT | the instrument finds the 3-adic rule the planner missed |
| 0.6 | The records skeleton (§6) and `data/fs70/README.md` | the owner can read every file's role |

*Kill/redo:* nothing here runs long; everything is regenerable in minutes.

### Phase 1 — the asks (two to three days; the milestone's core)

**1.1 The lattices, in order, and the asks on each.** Every lattice passes the 3-adic gate (a 3-non-unit in `S`) and the additive
screen (`Λ_forced` computed) before its first ask; the targets are read off `Λ_forced` — never ask a target the screen has killed.

| # | lattice (generators) | why | shapes | asks (all at four colours, symmetry-broken) |
|---|---|---|---|---|
| L1 | `S₂ = {ζ₁₂^m u^n : \|n\| ≤ 2}`, Harder's shape (§3.3) | the 2-unit template: passes the 3-adic gate through `u`, `Λ_forced ∋ 4/3, 8/3`; the residue at 2 four-colours it, so a refusal here is a forced pair and not a five-forcer outright | sums of ≤ 4, then ≤ 5; then `S₃` (`\|n\| ≤ 3`) | control (must colour — `ψ` exists; a refusal is a defect); **eq `4/3`**, **eq `8/3`**, and every other `δ ∈ Λ_forced` with `1/δ ∈ ℤ[U]` of small chain length |
| L2 | `S₂ ∪ ζ₁₂·{v, v̄}` — 2-unit fabric plus the depth-2 wall-breaker (`g = 300` in the full lattice) | no additive colouring exists (§3.4's theorem, `1/2 ∈ Λ`) and the 3-adic gate passes through `u`: **nothing is ruled out by any residue** — the control itself can refuse | sums of ≤ 3, then ≤ 4, of the 84 vectors; `T_n` lens between `0` and the target with a 7-core | **control first**; eq `4/3`; eq `8/3`; eq `2`; sep `√3` |
| L3 | `S₂ ∪ ζ₁₂·{w, w̄}` — with the depth-1 breaker (`g = 180`) | as L2, sparser | as L2 | as L2 |
| L4 | `S₂` plus the 7-family `{q₇, s₇}` and the 5-family `{q₅, s₅}` orbits | more 2-units; the residues at 7 and 5 do not obstruct (§3.1) | Harder shape, sums of ≤ 4 | eq `4/3`; eq `8/3` |
| L5 | the denominator-6 family (3-depth ±1) with `ζ₁₂` | the cheapest 3-non-units after `u`; its `Λ_forced` decides its targets | Harder shape | per `Λ_forced` |

**Dead by theorem, never to be asked:** `ζ₁₂, v` and `ζ₁₂, w` alone (3-unit lattices, §3.1); any 2-unit lattice at the targets `√3`
(virtual edge) and `2` (forced pair) (§3.4).

**1.2 The encoding** (`tools/fs70_ask.py`): one-hot, at-least-one and at-most-one per vertex, edge clauses; the pin — control:
the triangle `0, 1, ζ₆` at colours 0, 1, 2 with precedence on the fourth colour; forced-equal ask at `(A, B)`: `A = 0, B = 1`,
precedence over colours 2, 3; virtual-edge ask: `A = B = 0`, precedence over 1, 2, 3. Solvers: `kissat` for the verdict, then
`cadical --lrat` (toolchain) for the proof of any refusal; PySAT's four code bases as the recheck of any refusal before it is
announced. **Aim by the law:** record predicted and measured points and degree for every ball; do not ask below average degree
12 except as a calibration point, and step *up* in degree when a ball is undecided (G65), never down.

**1.3 Budgets and stop rules.** Per ask: `kissat` 30 min wall on one thread, then, if undecided, one cube-and-conquer pass on the
colour of the pair's common neighbours (8 cubes) at 30 min each on 8 threads — and no further compute on that ask without the
owner's word. Per lattice: stop after the largest affordable shape colours *and* §3.6's instruments say the colourings are not
periodic (a periodic rule is a theorem-shaped null and closes the lattice). Total phase budget 48 CPU-hours before the owner
re-ranks.

**1.4 Checkpoint / resume.** Every ask appends one row to `data/fs70/asks.jsonl` **when its verdict is known**; an ask in flight
writes `data/fs70/inflight/<sha>.json` (formula sha, solver, pid, start time) at launch and deletes it at the verdict. Balls
and CNFs are regenerable from their row (lattice, shape, R or n, target); nothing that costs more than 15 minutes is stored only
in memory. *If the implementer dies mid-ask the relaunch re-asks that one formula and nothing else* (`tools/fs70_ask.py
--resume` reads `inflight/` first). A cube pass writes each cube's verdict as it lands.

**1.5 On a refusal** — HALT the sweep, and before anything is announced: rebuild the graph from its row in a fresh process,
re-derive the complete unit-distance graph exactly, re-ask with two more solvers, and check the pin was the intended one
(`eq` and `sep` differ by one literal and a wrong one reads as a jackpot). Then phase 2.

### Phase 2 — the closure and the certificate (two days after a refusal)

| step | what | acceptance |
|---|---|---|
| 2.1 | The chain: from the forced pair `(A, B)` at `δ`, the `m` copies of §3.5 placed by `z ↦ s_{j−1} + u_j (z − A)`, the closing edge; **the whole graph as one point set** — its complete unit-distance graph then contains every copy's edges and the cross edges, all of which only help | the union refuses four colours (`kissat`), and **is five-colourable** (a verified colouring; P2's control: a refusal at five is a six-chromatic graph in a 6-open-like field and is HALT-AND-VERIFY, not a jackpot) |
| 2.2 | 1-minimisation (`tools/fs66_minimise.py`'s lineage: delete vertices while the four-refusal holds, LRAT-guided core first), keeping the point set closed under nothing — the certificate is a point set and its complete unit graph | a 1-minimal witness; size recorded against P4 |
| 2.3 | `tools/fs70_check_witness.py`, copied from `fs58_check_witness.py`'s contract with: nine-integer points `((a+b√3+c√5+d√15)/m, (e+f√3+g√5+h√15)/m)`, exact unit-distance re-derivation by bucketing on integer brackets of each irrational term, the CNF built from its own edge set with the triangle pin, its own LRAT replay, twelve planted faults each refused for its named reason (a moved point, a dropped edge, an added edge, a wrong radicand, a proof with a hint removed, a satisfiable formula, …) beside a faithful twin that passes; frozen (sha256 recorded) at the first CERTIFIED | CERTIFIED on the witness; every plant refused by name |
| 2.4 | The kernel form: `tools/fs70_emit_witness.py` drives `tools/emit_cert.py` (slots 0–3 of the sixteen: `1, √3, √5, √15`) and `tools/emit_mask.py` (four colours, the triangle pin) into `Proofs/HadwigerNelson/Instances/ThreeFive/`, and `Instances/ThreeFive.lean` (§5) consumes them; build through `./scripts/build.sh` with `MEMMAX` set | `five_le_chromaticNumber_planeOver_threeFive` on the standard three axioms; the gate green |

*Cost model for 2.4:* Heule-510's four-colour refutation (13 MB of Lean, 88 segment files) and de Grey's (216 MB) are the
kernel precedents; a 1-minimal witness of 1,000–3,000 points at four colours is in that class — hours of build, not days. If
the LRAT is above ~50 M lines, report the price and stop; the certificate of 2.3 is the milestone's claim and the kernel form
its grade above it.

### Phase 3 — the close (the owner's)

The ledger row; a grokking (**what forces five without a spindle**, or — on a typed null — what the screen and the structure
instruments say about why the field's vocabulary does not); FS-48's siblings `ℚ(√3,√23)`, `ℚ(√3,√47)` re-aimed through the same
screen (both wall-broken, 11 usable; their 2-unit rotations are `(−2 + i√23)/…` — the tool finds them); the credit move of PA.3;
`CLAUDE.md` § Frontier rewritten in place.

---

## 5. The skeleton (WORKFLOW 3; elaborates today)

`Proofs/HadwigerNelson/Instances/ThreeFive.lean` — **not yet imported by `Proofs.lean`** (it carries one `sorry`, and the gates
fail on `sorryAx`; the import line is phase 2.4's first edit). It holds:

* `Q4.threeFive : Subring Q4` — the elements of the tower `Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))` with zero `√11`-part and
  zero `√7`-part, i.e. `ℤ[√3, √5]`; membership decidable; three `example`s (a member, a `√7` intruder, a `√11` intruder).
* `Q4.eval_mem_of_mem_threeFive (h3 : √3 ∈ F) (h5 : √5 ∈ F) : x ∈ Q4.threeFive → Q4.eval x ∈ F`.
* `five_le_chromaticNumber_planeOver_of_sqrt_three_five_mem` — the statement at its proof's level: for every real subfield
  holding √3 and √5, `5 ≤ χ` of the unit-distance graph induced on `planeOver F`; **`sorry`** until phase 2.4 supplies the
  certificate `c : UDCert n`, `c.Valid = true`, `c.CoordsIn Q4.threeFive`, and `¬ (edgeGraph n c.edges).Colorable 4` through
  `Gadget.ofUnsat`, exactly as `Instances/SqrtEleven.lean` does at three colours. The proof then reads
  `(five_le_chromaticNumber_of_not_colorable_four).trans (c.chromaticNumber_le_planeOver (by decide) c_valid c_coords (fun _ hx => Q4.eval_mem_of_mem_threeFive h3 h5 hx))`,
  with `UDCert.chromaticNumber_le_planeOver` already generic in the subring (`SqrtEleven.lean`).
* `five_le_chromaticNumber_planeOver_threeFive : 5 ≤ χ(planeOver (fieldOfRadicands {3, 5}))` — the instance, from
  `sqrt_mem_fieldOfRadicands`.

**Read aloud:** the conclusion is about the unit-distance graph of `ℂ` induced on the points with both coordinates in
`ℚ(√3,√5)`; the finite witness is a subgraph of it; the bound is the witness's four-refusal. Nothing about the upper bound
(`χ ≤ 5` is the residue plane at 11, `chromaticNumber_finitePlane11`, whose number-field step is row 57's gap and FS-47's).

---

## 6. Records

**Identity.** An ask is identified by `sha256(canonical point set, pin)` — the sorted list of points in the nine-integer format
of §4.2 plus the pin — never by the generator names (two spellings of one lattice, or two shapes reaching one point set, are one
ask). A shape is a tagged record: `{"shape": "word", "k": 4}` (Harder), `{"shape": "lens", "n": 6, "B": …}` (Haugland),
`{"shape": "ball", "R": 3}`; a pin is `{"kind": "control"}`, `{"kind": "eq", "delta": …}` or `{"kind": "sep", "delta": …}`.

`data/fs70/atlas.jsonl` (one row per unit vector to denominator 42: coordinates, denominator, depths), `screen.jsonl` (one row
per lattice: generators, `M`, rank, `g`, covolume, whether the 3-adic gate passes, the HNF basis of `Λ_forced`, and the chainable
targets it admits), `asks.jsonl` (one row per ask: its identity sha, lattice, shape, size,
degree predicted/measured, target, pin, encoding sha, solver, budget, verdict, wall and CPU seconds, model sha or proof sha, the
§3.6 readings for a SAT), `inflight/`, `records/phase-{0,1,2}.md` (running logs), `witness-<sha>/` (phase 2: `witness.json`,
`witness.lrat.gz`, `README.md` with the construction). Ball and CNF files stay in `build/fs70/` (regenerable; never the only copy
of anything).

---

## 7. Registered expectations (planner, 2026-09-21; both outcomes reachable for each)

| id | prediction | confidence | the one fact that would change it |
|---|---|---|---|
| P1 | No lattice of 2-units carries a √3 virtual edge or a distance-2 forced pair at four colours (§3.4); every such ask colours | high (a theorem given the screen's exhaustiveness) | a refusal there — which would mean the screen's basis or coordinates are wrong, not that the theorem is |
| P2 | The Harder-shape fabric `S₂`, sums of ≤ 4, **does** force `(0, 8/3)` or `(0, 4/3)` at four colours | medium-low — Harder's fabric over K has the Moser twist (a rigid four-chromatic seed); ours has the chain (not rigid) | the L1 asks colouring at sums of ≤ 5 with non-periodic colourings: then the 2-unit route is a typed null and L2–L4 carry the milestone |
| P3 | **No lattice of 3-units refuses anything at four colours** — a theorem (§3.1), of which the pilot's seven SAT verdicts on `ζ₁₂, v` are instances; the imposed-quotient ask with `L = 3Λ` finds the residue rule there | high (derived) | a refusal on a 3-unit lattice, which would falsify the checker of the lattice's saturation before the theorem |
| P4 | If a five-forcer lands, its 1-minimal size is between 700 and 3,000 points (Haugland 2,131; Heule 1,441; Harder's forcer 745 before the spindle) | medium | a refusal on L2 or L3 at sums of ≤ 3 (dense mixed fabric refuses small) |
| P5 | On L1 the four-colourings found at sums of ≤ 4 are **not** all periodic under a sublattice of index ≤ 4⁸ — the residue colouring `ψ` is among them, but non-additive, non-periodic ones exist | medium | every colouring found factoring through `Λ/4Λ`: then L1's colouring space is the additive family and the forced targets are exactly `Λ_forced`'s — a theorem-shaped reading for the 2-unit route |
| P6 | Wall-breaking directions are **not** needed for a forced pair at `4/3` or `8/3` (P2's route, L1) but are needed for a control refusal (L2/L3, no residue colouring at all) | medium (P2 is the bet) | P2 losing while an L2 control refuses |
| P7 | The kernel form, if reached, costs under 12 hours of `build.sh` wall time | medium-high (Heule-510's precedent) | an LRAT above 50 M lines |
| P8 | Phase 0.3 reproduces Haugland's 740 / 3,985 and his refusal in under 60 s of solver time | high | a count mismatch, which is the `ε` derivation |

---

## 8. Failure and jackpot clauses

*Failure:* L1–L5 all colour at their budgets, the structure instruments report non-periodic colourings, and no forced pair at a
chainable distance appears — a typed null: the conjecture's prediction at ℚ(√3,√5) stays unmet, the record says which
instrument stopped (size at degree 14 on rank-8 lattices, most likely), and the grokking records the screen's theorem and the
depth grading as what was learned. *Jackpot:* a control refusal on L2 or L3 (a five-chromatic graph without any chain); a
forced pair at `4/3` (the three-copy spindle, a new closing shape). *Halt-and-verify:* any refusal at five colours in phase 2.1.

## 9. Addresses

`tools/fs70_field.py`, `tools/fs70_fabric.py` (planner's, 2026-09-21); `data/fs70/planner/pa/` (the gate's raw responses);
`data/fs70/owner/gate-2026-09-21-fields.md`; `plans/STUB-five-over-sqrt3-sqrt5.md`; `Proofs/HadwigerNelson/Instances/ThreeFive.lean`
(the skeleton); `Proofs/HadwigerNelson/Instances/SqrtEleven.lean` and `Instances/CompositumFive.lean` (the certificate pattern);
`tools/fs58_check_witness.py`, `tools/fs58_emit_witness.py`, `tools/emit_cert.py`, `tools/emit_mask.py` (the pipeline);
`~/source/library/pdf/arXiv-2608.04542v3-haugland-2131.pdf` (Appendix A); `~/source/library/notes/polymath16-threads-1-18-text.txt`
(Harder, 28 April 2018); `[Soifer2024]` ch. 54 (`~/source/library/`).
