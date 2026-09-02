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

**CORRECTED 2026-09-02 (M52, T14):** the "24 distinct radicands / tower height ≤ 24 / per-edge
compositum" below is superseded — every point of the object is in ℚ(√3, √11) exactly (all unit
edges verified as exact identities) and the copy adjoins only √5, so the whole union is in
ℚ(√3, √5, √11) ⊂ M02's kernel tower: the certificate's geometry is M06-class. Kept as written for
the record. **Certificate pricing (as priced 2026-09-01, superseded):** 588 of the original side's 2,265 edges are free
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

## The atlas cards (M52 phase 1, generated by `tools/copy_anatomy.py --md`; numbers only, readings in the M52 report)

### atlas · `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1` (fp f0871bab2b915b4f)

- **size**: 1981 points (1953 live), 13796 unit edges exact (float census 13796 verified / 0 rejected / 0 recovered), 273 cheats standing
- **directions**: 13796 of 13796 on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, 0 off; (m,j) classes: (-2,0):1754, (-1,0):3122, (0,0):2782, (1,0):3141, (2,0):2331, (3,0):666
- **rings about 206**: 778 distinct r²; top r=1.7321×18 = √[3]; r=1.0000×18 = √[(-1)/-1]; r=1.2910×16; r=1.5676×14; r=0.7366×14 = √[(-9 + 1√33)/-6]
- **rings about 0**: 234 distinct r²; top r=1.7321×38 = √[3]; r=1.2910×35; r=1.5275×35; r=0.8671×32 = √[(-8 + 1√33)/-3]; r=2.1404×32
- **rings about 205**: 1209 distinct r²; top r=2.2361×9 = √[(-5)/-1]; r=1.0000×8 = √[(-1)/-1]; r=2.6458×8 = √[7]; r=2.1888×6; r=3.5119×6
- **symmetries** (rotations about the centres, reflections at ladder angles): 0
- computed at 50 digits in 15.9 s; `exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof`

### atlas · `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1+rot2-0p` (fp 6673c893b7379146)

- **size**: 3933 points (3905 live), 27627 unit edges exact (float census 27627 verified / 0 rejected / 0 recovered), 273 cheats standing
- **directions**: 27592 of 27627 on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, 35 off; (m,j) classes: (-2,0):1754, (-2,1):1754, (-1,0):3122, (-1,1):3122, (0,0):2782, (0,1):2782, (1,0):3141, (1,1):3141, (2,0):2331, (2,1):2331, (3,0):666, (3,1):666
- **rings about 0**: 234 distinct r²; top r=1.7321×76 = √[3]; r=1.2910×70; r=1.5275×70; r=0.8671×64 = √[(-8 + 1√33)/-3]; r=2.1404×64
- **rings about 206**: 2730 distinct r²; top r=1.7321×18 = √[3]; r=1.0000×18 = √[(-1)/-1]; r=1.2910×16; r=1.5676×14; r=0.7366×14 = √[(-9 + 1√33)/-6]
- **rings about 205**: 3161 distinct r²; top r=2.2361×9 = √[(-5)/-1]; r=1.0000×8 = √[(-1)/-1]; r=2.6458×8 = √[7]; r=2.1888×6; r=3.5119×6
- **cross chords**: 64 — 15 self (radius-2 shell), 29 centre–neighbour, 64 collinear with the centre, 64 with both endpoints in ℚ(√3,√11)
- **symmetries** (rotations about the centres, reflections at ladder angles): 0
- computed at 50 digits in 31.7 s; `exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof`

### atlas · `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1+rot2-206p` (fp a6905d4eb85d71dc)

- **size**: 3933 points (3905 live), 27610 unit edges exact (float census 27610 verified / 0 rejected / 0 recovered), 273 cheats standing
- **directions**: 27592 of 27610 on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, 18 off; (m,j) classes: (-2,0):1754, (-2,1):1754, (-1,0):3122, (-1,1):3122, (0,0):2782, (0,1):2782, (1,0):3141, (1,1):3141, (2,0):2331, (2,1):2331, (3,0):666, (3,1):666
- **rings about 206**: 778 distinct r²; top r=1.7321×36 = √[3]; r=1.0000×36 = √[(-1)/-1]; r=1.2910×32; r=1.5676×28; r=0.7366×28 = √[(-9 + 1√33)/-6]
- **rings about 0**: 2185 distinct r²; top r=1.7321×38 = √[3]; r=1.2910×35; r=1.5275×35; r=0.8671×32 = √[(-8 + 1√33)/-3]; r=2.1404×32
- **rings about 205**: 3161 distinct r²; top r=2.2361×9 = √[(-5)/-1]; r=1.0000×8 = √[(-1)/-1]; r=2.6458×8 = √[7]; r=2.1888×6; r=3.5119×6
- **cross chords**: 36 — 10 self (radius-2 shell), 18 centre–neighbour, 36 collinear with the centre, 36 with both endpoints in ℚ(√3,√11)
- **symmetries** (rotations about the centres, reflections at ladder angles): 0
- computed at 50 digits in 32.0 s; `exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof`

### atlas · `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1+rot2-206p+rot2-206m` (fp 3148c281f24386ab)

- **size**: 5885 points (5857 live), 41424 unit edges exact (float census 41424 verified / 0 rejected / 0 recovered), 273 cheats standing
- **directions**: 41388 of 41424 on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, 36 off; (m,j) classes: (-2,-1):1754, (-2,0):1754, (-2,1):1754, (-1,-1):3122, (-1,0):3122, (-1,1):3122, (0,-1):2782, (0,0):2782, (0,1):2782, (1,-1):3141, (1,0):3141, (1,1):3141, (2,-1):2331, (2,0):2331, (2,1):2331, (3,-1):666, (3,0):666, (3,1):666
- **rings about 206**: 778 distinct r²; top r=1.7321×54 = √[3]; r=1.0000×54 = √[(-1)/-1]; r=1.2910×48; r=1.5676×42; r=0.7366×42 = √[(-9 + 1√33)/-6]
- **rings about 0**: 4117 distinct r²; top r=1.7321×38 = √[3]; r=1.2910×35; r=1.5275×35; r=0.8671×32 = √[(-8 + 1√33)/-3]; r=2.1404×32
- **rings about 205**: 4952 distinct r²; top r=2.2361×9 = √[(-5)/-1]; r=1.0000×8 = √[(-1)/-1]; r=2.6458×8 = √[7]; r=2.1888×6; r=3.5119×6
- **cross chords**: 72 — 20 self (radius-2 shell), 36 centre–neighbour, 72 collinear with the centre, 72 with both endpoints in ℚ(√3,√11)
- **symmetries** (rotations about the centres, reflections at ladder angles): 0
- computed at 50 digits in 52.1 s; `exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof`

### atlas · `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1+rot2-206p+rot2-206m+rot2-0p+rot2-0m` (fp 628bf2b51c9c3f76)

- **size**: 9789 points (9761 live), 69086 unit edges exact (float census 69086 verified / 0 rejected / 0 recovered), 273 cheats standing
- **directions**: 68980 of 69086 on the half-twist ladder θ ≡ 30a + m·16.7787° + j·28.955°, 106 off; (m,j) classes: (-2,-1):3508, (-2,0):1754, (-2,1):3508, (-1,-1):6244, (-1,0):3122, (-1,1):6244, (0,-1):5564, (0,0):2782, (0,1):5564, (1,-1):6282, (1,0):3141, (1,1):6282, (2,-1):4662, (2,0):2331, (2,1):4662, (3,-1):1332, (3,0):666, (3,1):1332
- **rings about 0**: 4117 distinct r²; top r=1.7321×114 = √[3]; r=1.2910×105; r=1.5275×105; r=0.8671×96 = √[(-8 + 1√33)/-3]; r=2.1404×96
- **rings about 206**: 4662 distinct r²; top r=1.7321×54 = √[3]; r=1.0000×54 = √[(-1)/-1]; r=1.2910×48; r=1.5676×42; r=0.7366×42 = √[(-9 + 1√33)/-6]
- **rings about 205**: 8854 distinct r²; top r=2.2361×9 = √[(-5)/-1]; r=1.0000×8 = √[(-1)/-1]; r=2.6458×8 = √[7]; r=2.1888×6; r=3.5119×6
- **cross chords**: 200 — 50 self (radius-2 shell), 94 centre–neighbour, 200 collinear with the centre, 200 with both endpoints in ℚ(√3,√11)
- **symmetries** (rotations about the centres, reflections at ladder angles): 0
- computed at 50 digits in 85.2 s; `exact points from provenance at dps digits; ladder membership at 1e-(dps-15) deg; PSLQ identifications are numeric (maxcoeff 1e6/1e8), a census not a proof`

