# Q8 — the 5-chromatic unit-distance objects (the durable record)

*Written 2026-09-02, consolidating the 2026-09-01 discovery night and its measurement campaign
after a double context compaction. Sources: `build/m51-jobs.txt` entries 03:11Z–09:34Z (09-01)
and 05:36Z (09-02); artifacts `build/m51-copy*`; machine-readable recipes and snapshots in
`data/m51/`. Everything here is TOOLS-LEVEL verified (exact-arithmetic chords + multi-encoding
SAT); the kernel certificate is priced and pending. Registered predictions and the discovery
narrative: `plans/STANDING-QUESTIONS.md` Q8/Q9 and `plans/M51-descent-engine.md` §S-CONT.*

## The construction (Kooshi's, 2026-09-01)

Take U = the unit part of the descended object (the Exoo–Ismailescu seed grown by three
certified halos, seed vertices deleted — 4-colourable on its own). Rotate a copy about one of
its vertices by the **distance-2 spindle angle** 2·arcsin(1/4) = 28.955°, whose rotation is
EXACT: cos = 7/8, sin = √15/8 — de Grey's ρ₁₅ detune, one field up from the seam tower. The
union U ∪ R(U) refuses four colours: **a new 5-chromatic unit-distance graph**, of a genre no
published witness has (glue-lattice fabric + one spindle copy; de Grey/Heule/Parts/Haugland
built their fabric ad hoc — ours was *descended* from a two-distance seed by the certified
batch loop, and the crossing was manufactured on demand, not awaited).

## Object cards

### 1. U ∪ R₂₀₆(U) — the primary object (it-3-era base)

| Property | Value |
|---|---|
| Base | unit part of `…-vdel28` (fingerprint `d6460615c957e19f`), 1,834 live points, 12,735 unit edges, 4-colourable in 0.1 s |
| Transform | rotation about vertex 206 (an endpoint of the seed's forced pair 205–206), cos 7/8, sin √15/8, either sign |
| Union | **3,695 points, 25,486 unit edges**, 34 cross chords, copy-of-206 fuses to 206 exactly |
| Refusal | k = 4 **UNSAT in three encodings** (one-hot + degree breaking 6.8 s; one-hot no breaking; 2-bit) |
| Geometry | all 34 cross chords unit to **250 digits** (worst \|d−1\| = 4.4·10⁻²⁵¹); the rotation is exact field arithmetic |
| Load-bearing | only **4 of 34 chords individually load-bearing**: 225→copy(423), 243→copy(424), 423→copy(225), 424→copy(243) — two pairs of depth-1 glue points {225,423}, {243,424}, each pair at distance exactly **1/√3** (the two-circle inner radius), 225–243 and 423–424 at **√3**, radii 1.3696/1.9470 from 206 |
| Not a pair spindle | U alone carries **137 forced-equal pairs at k = 4** — 131 at d = 8/3 (4d²−1 = 247/9), 6 at 8/√3 (253/3), all halo-touching, radicands outside every owned field, **none at distance 2, none touching 206 or v0** — the lock is a compound (disjunctive) compulsion, G16's genre |

### 2. U ∪ R_v0(U) — the origin copy

Same angle about the origin: 58 cross chords, UNSAT both signs in two encodings (717 s),
chords unit to 250 digits, **no single load-bearing chord** (0 of 58 — multiple disjoint routes).

### 3. The composed four-copy union

Both signs about 206 + both signs about v0: **9,194 points, 63,770 unit edges, 189 cross
chords, 4 fused**. k = 4 UNSAT 15.2 s. At five colours with all cheats: UNSAT 539 s (control).
The **jackpot ask** (separate 205/206 with zero cheats): **SAT at 4,704 s** — no χ ≥ 6, but a
~40× hardness jump over the single copy's 116 s.

### 4. The 883-point core (of object 1)

**883 points** = 434 original (102 seed + 332 halo, provenance depths 1:154/2:103/3:60/4:15)
+ 449 copy; 4,625 unit edges, 20 cross chords; **1-minimal, 0 unknown over 3,412 asks**,
control UNSAT. A *distributed* refutation, de Grey-like, not a small gadget.
Graph: `data/m51/m51-copycore-about206-graph.json`.

**Certificate pricing (priced, not started):** 588 of the original side's 2,265 edges are free
by construction (`Glue.lean`: a glue point is unit from both parents); the core's provenance
closure is 515 original points (378 glue) adjoining **24 distinct radicands** 1−d²/4 — 18 in
the seed-pair catalogue (8 exact, 10 up to a rational square), 6 new roots (21 points), top two
rational (1/4: 131 points; 3/4: 44), none a rational square. A single tower of height ≤ 24 is
too tall for the M02 dense representation (de Grey's was height 4) ⟹ **per-edge compositum
geometry** (each endpoint ≤ ~4 nested radicals) + the M42 LRAT template at k = 4.

### 5. On the committed iteration-4 object (fingerprint `f0871bab2b915b4f`, 1,981 pts / 273 cheats)

The lock **survives the commit** (monotone, and measured): U₅ ∪ R₂₀₆(U₅) — 36 chords, UNSAT
6.3 s; U₅ ∪ R_v0(U₅) — 64 chords, UNSAT 4.2 s. These are the it-5 candidate bases.

## The lock-centre map (where the fabric is 4-tight)

- **Seed vertices:** 176 of 186 live lock (380 asks, 0 unknown). Non-locking, both signs:
  79, 127, 129, 130, 174, 190, 199, 203, **205** (the forced pair's other endpoint, deg 8 —
  while 206 locks), 208. Mostly low-degree/peripheral.
- **Halo points:** **818 of 1,648 lock** (3,296 asks, 0 unknown, 3.6 h); the two signs **never
  disagree**. Locking centres are shallower and better connected: depth-1 locks 308:68; degree
  median 15 vs 10; chords median 28 vs 17.
- The four load-bearing halo points (225, 243, 423, 424) lock with MORE chords (48–52) than
  206's 34.

## Controls (all green)

Angle perturbed ±0.3°/±1°/+5° → only the 18 angle-independent chords, SAT. Moser angle
(√3-spindle) → hundreds–thousands of chords, SAT on every object. The ρ₁₅ angle on the seed's
unit part (214/1,004), iteration 1 (690), iteration 2 (1,008): SAT. **Iteration 3 pre-deletion
(1,862): UNSAT** — the lock arrived with iteration 3's halo, i.e. glue points of glue points =
depth-2 seam material: **G16's depth switch, met from below, under de Grey's own rotation.**

## What it does and does not do to the descent

- No cheat becomes redundant **alone**: floor census on X ∪ R₂₀₆(U) — 0 of 39 redundant
  (36 essential, 3 unknown at 600 s: (118,212), (126,203), (132,134)); endpoint census — 0 of
  184 seed vertices deletable alone, plain and copied alike (171 needed, 13 unknown).
- The **joint** question (Kooshi's: "toss all of these successful rotations together along with
  it-4's outputs — how many cheat vertices can we shrink away or edges eliminate") is the
  group-MUS cull (`tools/copy_cull3.py`), running at the compaction; iteration 5 starts from
  the strongest composed object (Kooshi's directive, 2026-09-02).
- Strategically: the χ(unit-part) 4 → 5 crossing (T7) is **manufactured**, so K1's obstruction
  is gone in the copied object — pair compulsions at five colours in unit material become
  possible for the first time; the 6-hunt's Act One has a stage (G19).
- Adopting a copy as committed object material needs a provenance dialect for rotated points
  (Python `Obj` + the Rust readers, D38) — a work order, not yet planned.
