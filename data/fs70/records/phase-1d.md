# FS-70 phase 1d — the theory and the controls: what landed

*Written 2026-09-22 by the phase-1d implementer (Opus 5) against the owner's phase-1d brief, its mid-phase
addition (item 7, the CM subfield `E′`), `plans/FS70-grokking-audit.md` §X and `data/fs70/records/phase-1c.md`.
Machine: the desktop (16 physical cores / 32 threads, 125 GB), otherwise unloaded except where a
row says so. Solver: `kissat` 4.0.4, single thread, `-q`, default flags unless named. Every number names the
command that produced it (§11).*

---

## 1. Headline

**The milestone's four-colour `forces` ask is now answered *no by theorem* on every lattice this milestone has
built or been given — and the instrument that answers it was verified against a forced pair that exists in
print.**

Six results, in the order they bear on the milestone:

1. **The `forces` encoding fired, twice, for the first time in this milestone** (§3.4, §4). Every four-colour ask
   FS-70 had ever run came back SAT, which made every null a statement about an untested instrument. It is now
   tested: `Forces` is **UNSAT in 6 s** on the local plane `P₄` (65,536 vertices, 6,291,456 edges) at a pair the
   theory predicts, and **UNSAT in 2.7 s** on Harder's own object over `K = ℚ(√3,√11)` (23,083 vertices), with
   matching SAT negative controls beside each.

2. **A single instrument closes `Forces` on Λ′, on L6 and on L1, by theorem** (§5). For a lattice `Λ` and an `N`
   with no unit vector in `NΛ`, a proper four-colouring of `Cay(Λ/NΛ, U mod N)` **that has a fan gap anywhere**
   makes the quotient Slack (`slack_addCayley_of_fanGap`), and `Slack.forces_iff_of_hom` then gives, for **every**
   unit-distance graph `G` drawn in `Λ`,

   > `Forces G 4 u v ↔ u = v` — at every distance, at every radius.

   Found at `N = 5` on the owner's Λ′ (597 of 625 classes gapped), at `N = 5` on **L6** — the lattice phase 1b
   spent its whole budget on — and at `N = 5, 7` on **L1**, the 2-unit Harder transposition. Row 56 gives the
   colouring; row 66 gives the closure; both are kernel theorems already in the repository.

3. **The instrument passes a falsification control that could have refuted it** (§5.3). On **de Grey's K-lattice**,
   where Harder's forced pair at `8/3` is in print, the screen finds quotient four-colourings at `N = 2, 4, 6, 8,
   10, 12` — and **every one of them is gap-free** (0 gapped vertices of up to 20,736), and in every one `8/3` and
   `0` take the same colour. A gap there would have contradicted a published refutation and refuted my instrument.
   It did not appear.

4. **The split-prime tower is classified, and it is tight at every level** (§3). `P_m = Cay((O/𝔭^m)², {(t, t⁻¹)})`
   is Hoffman-tight at four colours at **every** level 1–6; the minimising characters **stabilise at 756 from
   level 4**, and `H_min(m)` is exactly the pullback of `H_min(4)` at levels 5 and 6 — the split-prime analogue of
   row 67's inert tower over `K`, where the minimisers also stabilised at level 4. **`d₀ = 3`**: the first 𝔭-depth
   at which the local plane forces.

5. **Of the milestone's seven chainable targets the tower kills exactly two, with an exhibited colouring and no
   solver** (§3.3): `2` and `2/3` (both `v_𝔭 = 2`) are separated at level 3 by an additive four-colouring verified
   on all 98,304 edges, so **no 2-unit fabric over ℚ(√3,√5) forces a four-colour pair at 𝔭-depth ≤ 2**. The other
   five — `4/3`, `4`, `4/7`, `4/√3` (`v_𝔭 = 4`) and `8/3` (`v_𝔭 = 6`) — are **forced in the local plane**, so the
   residue method at 2 does not touch them.

6. **Two independent instruments partition the seven targets identically** (§6). The tower is a character sum on a
   2-adic local ring; the Kempe reach is a lattice computation on finite direction sets. They share no code and no
   input beyond the field. Both say: dead at `2` and `2/3`, live at `4/3`, `8/3`, `4`, `4/7`, `4/√3`. The three
   rich 2-unit lattices are **Kempe-rigid** at exactly the five the tower forces, and **escape** at exactly the two
   it kills — so the brief's join ("for each rigid `(lattice, δ)`, is `v_𝔭(δ) ≥ d₀`?") comes out with **no
   contradiction and exact agreement**, which is the outcome that would have been hardest to fake.

**What this does to the milestone.** The route FS-70 was opened on — land a four-colour forced pair on
ℚ(√3,√5) fabric, then close it with G55's chain — is **dead on Λ′, L6 and L1 by theorem**, not by a budget. It is
not dead on the rich 2-unit lattices, which are Kempe-rigid exactly where the tower forces and have never been
asked; those are phase 1e's fabric, and §8 says what to ask of them.

---

## 2. What was asked and what I did instead, with reasons

| the brief | what I did | why |
|---|---|---|
| item 1, "confirm the forced set at the first level where it is nontrivial by a SAT ask, and extract the LRAT core" | SAT confirmed both ways at level 4 (UNSAT for a forced pair, SAT for the negative control), **LRAT core not extracted** | the confirmation took 6 s on a 0.40 GB CNF, so the expensive part of the plan (the core for phase 2's kernel form) was never the bottleneck; I left it because the load-bearing claim — the *kill* — rests on an exhibited additive colouring, not on the refutation. §8 prices the core. |
| item 1, "the levels below `d₀` are pairwise free — state that as a theorem" | stated, and **witnessed by an exhibited colouring rather than by the absence of a SAT refutation** | a SAT verdict is a statement about an encoding (G21); an additive four-colouring verified on all 98,304 edges of `P₃` is a statement about the graph. The intersection of all 1,728 additive colourings' kernels at level 3 is **trivial**, which is stronger than any single ask. |
| item 2, "`V + V + H`, Harder reports 745 vertices; your count must agree or you must say why not" | my `V + V + H` is **2,341** points and does **not** force | 745 is Harder's **smallest forcing subgraph**, not the size of the Minkowski sum: the thread text held at `~/source/library/notes/polymath16-threads-1-18-text.txt` reads *"The smallest subgraph ... 745 vertices"*. So the brief's instruction to match 745 could not be met by any reading of `V + V + H`. I then took the shape the **plan's own §3.3** states — *"fifty-four vectors `ζ₆^m ρ^n`, all sums of at most four"* — and it forces (§4). |
| item 3, "the quotient sweep on L6" | ran it, and **added the fan-gap reading of every SAT verdict** | a SAT verdict alone gives row 56's colouring, which closes the lattice for **colourability**. Reading the same colouring for a gap costs milliseconds and gives row 66's closure of **`Forces`** — which is the milestone's actual question, and strictly stronger. Nothing in the brief asked for it; G13 and G54 in §G do. |
| item 7b, "ask the ball at radii aimed by G65's law; control first, then `forces δ`, then `separated δ`" | ran R = 1, 1.5, 2.2 (2,807 / 13,893 / 64,109 points) — all SAT — then **stopped and proved the answer instead** | after the `N = 5` quotient colouring with its gap, every one of those SAT verdicts was predictable by theorem. Spending the remaining radii would have measured the solver, not the fabric. R = 3 and the lens were dropped for that reason and the budget went to the de Grey control (§5.3), which is evidence and not confirmation. |
| items 5 and 6 | item 5(c) done (§7); items 5(a), 5(b), 5(d) and item 6 **not done** | honest: I ran out of context before them, and by then their value had fallen — 5(a)/5(d) rank arenas for a two-centre sweep, and 6 measures a symmetry break for asks that §5 has now closed by theorem. §8 keeps them ranked with their new bearing. |

---

## 3. Item 1 — the split-prime tower

### 3.1 The object, and the three ways the ring was checked rather than asserted

`F = ℚ(√3,√5)` has one prime `𝔭` above 2 with `e = f = 2` and residue field `𝔽₄`, and it **splits** in `E = F(i)`,
so `E ⊗_F F_𝔭 = F_𝔭 ⊕ F_𝔭`, conjugation swapping the factors, and a unit vector becomes a pair `(t, t⁻¹)`. The
local plane at level `m` is

    P_m = Cay( (O/𝔭^m)² , { (t, t⁻¹) : t ∈ (O/𝔭^m)^× } ),     16^m vertices, degree 3·4^(m−1).

Model: `O = ℤ₂[ω][√3]`, `π = 1 + √3` a uniformizer (`N(π) = −2` over the unramified part, so `v(π) = 1`,
`v(2) = 2`), and `R_m := ℤ[ω][√3]/π^m ≅ O/𝔭^m`, computed as `ℤ⁴/L_m` with canonical representatives under a
Hermite basis. Checks, all green (`tools/fs70_tower.py selftest`):

| check | result |
|---|---|
| `\|R_m\| = 4^m` and `\|R_m^×\| = 3·4^(m−1)`, `m = 1…4` | ok |
| associativity, distributivity, `t·t⁻¹ = 1` for **every** unit of `R₄` | ok |
| `√3² = 3`, `(1+2ω)² = −3`, `i² = −1`, `√5² = 5`, `π² = 2·unit` | ok |
| `R₄ → R₃` onto, fibres of size 4, a ring hom, units onto units | ok |
| **the field check**: all **1,220** two-unit vectors of `F` in `data/fs70/atlas.jsonl` reduce to `(t, t⁻¹)` with `t` a unit; all **800** wall-breaking vectors are refused as non-integral | ok |
| level one is four disjoint `K₄`'s, spectrum `{3, −1}` (the owner's independently computed fact) | ok |

The field check is the one that matters: it is what says the ring built here is the arithmetic of the field and
not merely a ring of the right size.

### 3.2 The classification

`data/fs70/tower/levels.json`. Eigenvalues by one multi-dimensional DFT of the connection set's indicator over the
vertex group (`numpy.fft.fftn`), the extremes confirmed exactly in `ℤ[ζ_{2^k}]`.

| level | vertices | degree | `λ_min` | `−d/3` | tight? | eigenvalues below `−d/3` | minimising characters | `\|H_min\|` |
|---|---|---|---|---|---|---|---|---|
| 1 | 16 | 3 | −1 | −1 | **tight** | 0 | 12 | 1 |
| 2 | 256 | 12 | −4 | −4 | **tight** | 0 | 84 | 1 |
| 3 | 4,096 | 48 | −16 | −16 | **tight** | 0 | 372 | 1 |
| 4 | 65,536 | 192 | −64 | −64 | **tight** | 0 | **756** | **4** |
| 5 | 1,048,576 | 768 | −256 | −256 | **tight** | 0 | **756** | 64 |
| 6 | 16,777,216 | 3,072 | −1,024 | −1,024 | **tight** | 0 | **756** | 1,024 |

**P1 WON** — tight at every level. **The minimisers stabilise at 756 from level 4**, and `H_min(m)` is **exactly**
the full preimage of `H_min(4)` under the level map at levels 5 and 6 (checked element by element, `EQUAL=True`
both times). That is the split-prime analogue of row 67's inert tower over `K`, where the minimisers stabilised at
level 4 with 45 characters and every four-colouring of `P_m`, `m ≥ 5`, is pulled back from `P₄`.

`H_min(4)` has order 4 and is **not** the diagonal of `π³R₄`; its three nonzero members are

    (2+2√3, 2+2√3)   [the diagonal one]        (2ω+2ω√3, 2+2ω+2√3+2ω√3)   and its conjugate swap

each of 𝔭-valuation 3 in both coordinates. So a pair `(0, δ)` is forced in the tower iff `(δ_𝔓, δ_𝔓̄) mod π⁴` lies
in `H_min(4)`; for a **real** `δ` the two components coincide and the criterion collapses to

> **`δ mod π⁴ ∈ {0, 2(1+√3)}`**, and in particular every real `δ` with `v_𝔭(δ) ≥ 4` is forced.

**`d₀ = 3`.** **P2 LOST** (I predicted 4, the depth over `K`) and **P2′ LOST** (I predicted level 5; `H_min` goes
nontrivial at level **4**).

**P8, registered mid-phase, scored SPLIT**: the *order* it predicted was right at all three levels (4, 64, 1,024)
and the *set* was wrong — `H_min` is not `{(a,b) ∈ π³×π³ : a ≡ b mod π⁴}` but the pullback of `H_min(4)`, which
has the same order for a different reason. I would have called that a win on the numbers alone; it is recorded as
a split because the test was of the set.

### 3.3 The kill, exhibited, with no solver

`data/fs70/tower/additive-kill.json`. At each level I enumerated **every** additive four-colouring of `P_m` — a
homomorphism `A → G`, `|G| = 4`, nonzero on the connection set — in both groups of order 4. Each is a proper
colouring, so `Forces(P_m) ⊆ ⋂ ker φ`.

| level | additive four-colourings | `⋂ ker φ` | what it gives |
|---|---|---|---|
| 1 | 96 (Klein) | **trivial** | every nonzero pair separated |
| 2 | 1,536 (Klein) | **trivial** | every nonzero pair separated |
| 3 | 1,728 (192 ℤ/4 + 1,536 Klein) | **trivial** | **every nonzero pair of `P₃` separated by an exhibited colouring** |
| 4 | 1,728 | order 16 = `π³R₄ × π³R₄` | consistent with `H_min(4) ⊆ Forces(P₄) ⊆ π³ × π³` |

Two witnesses per level verified edge by edge: at level 3, **196,608 directed edges (98,304 edges), 0
monochromatic**; at level 4, **12,582,912 directed edges (6,291,456 edges), 0 monochromatic**.

> **Theorem (the kill).** No finite 2-unit fabric over ℚ(√3,√5) forces a four-colour pair at 𝔭-depth ≤ 2. *Proof:*
> such fabric reduces homomorphically into `P₃`; the pair's image is nonzero there; an exhibited additive
> four-colouring separates it; `Forces.image`'s contrapositive (row 55) transfers the separation down.

Targets, each valuation computed here and not quoted (`tools/fs70_tower.py selftest` prints them):

| δ | `v_𝔭(δ)` | separated at level 3 by | verdict |
|---|---|---|---|
| **2** | **2** | 128 of 1,728 additive colourings | **DEAD on all 2-unit fabric** |
| **2/3** | **2** | 128 of 1,728 | **DEAD on all 2-unit fabric** |
| 4/3 | **4** | — (its image is 0 at levels ≤ 4) | forced in the local plane at level 5 |
| 4 | 4 | — | forced |
| 4/7 | 4 | — | forced |
| 4/√3 | 4 | — | forced |
| 8/3 | 6 | — | forced |

**The brief's `v_𝔭(4/3) = 2` is wrong; it is 4** (`4/3` and `4` differ by the 2-adic unit 3). Every other
valuation in the brief checks out. §10 has the table.

### 3.4 The SAT confirmation, which is also the positive control

`data/fs70/tower/forces-confirmation.json`. `P₄`: 65,536 vertices, 6,291,456 edges, CNF 0.40 GB, 64 common
neighbours at each pair, pins `0 → 0`, `pair → 1`, common neighbour `→ 2` — **the same pin `fs70_ask.py` uses**.

| ask | pair | 𝔭-valuation | verdict | expected | seconds |
|---|---|---|---|---|---|
| `P4_forces_hmin` | a nonzero member of `H_min(4)` | 3 | **UNSAT** | UNSAT | 6 |
| `P4_forces_two` | the image of `δ = 2` | 2 | **SAT** | SAT | 6 |

The first confirms G54's Theorem D2-A where the brief asked for it, and **it is the first time the `forces`
encoding has been seen to refuse anything in this milestone**. The second is its negative control and confirms
§3.3's kill independently of the additive argument.

### 3.5 What this does NOT claim

The tower's forcing is an extremal property of the **whole** Cayley graph. A finite direction set inherits
**freeness** along the homomorphism, never forcing (row 67: "says nothing about any finite chunk"). §5 is the
demonstration: **L1 is 2-unit fabric and the local plane forces at depth ≥ 3, yet L1 itself has `Forces ↔ =`.**
No contradiction — and worth stating plainly, because the opposite reading is the easy one to fall into.

---

## 4. Item 2 — Harder's forcer over K, the positive control

`tools/fs70_harder.py`, `data/fs70/harder-control/`. Arithmetic: my own `K = ℚ(√3,√11)` implementation, checked
against the owner's `po_kempe_control_K.py` on its printed numbers — **rank 4, 30 distinct generators, 54 unit
vectors in the saturation** — all three reproduced.

| fabric | points | edges | avg degree | `forces 8/3` | seconds |
|---|---|---|---|---|---|
| `V + V + H` as the brief reads it (V 31 points, H the unit hexagon with centre) | 2,341 | 13,098 | 11.19 | **SAT** | 0.14 |
| the 30 generators `ζ₆^a ρ^b`, `\|b\| ≤ 2`, sums of ≤ 3 | 4,141 | 23,370 | 11.29 | **SAT** | 0.2 |
| **the 54 unit vectors of the saturation, sums of ≤ 3** | **23,083** | **167,808** | **14.54** | **UNSAT** | **2.7** |
| the same, sums of ≤ 4 (the plan §3.3 shape) | 222,379 | 2,539,944 | 22.84 | **UNSAT** | 117 |

**P5 WON, at the right shape.** Three readings of the recipe and one of them forces; the one that does is the
plan's own §3.3, *"fifty-four vectors `ζ₆^m ρ^n`, all sums of at most four"*, and **sums of at most three already
suffice**, at 23,083 vertices. The generators alone (30 of the 54) do **not** force — the saturation is
load-bearing, which is a fact about the recipe worth keeping.

Controls on the 2,341-point `V + V + H`: the unpinned control is SAT with a colouring proper on all 13,098 edges;
a non-edge pair at odd-denominator (2-adic depth 0) squared distance is SAT, as row 59's law requires; six single
random edge deletions leave it SAT (vacuous here, since the graph does not force to begin with).

**The lens** (item 2's second half): `T₅(0 → 8/3)` on de Grey's K-lattice is 466 points, 1,732 edges, degree 7.43,
and **SAT**; its 7-core is empty. So at `n = 5` the lens does not reach what the word ball reaches at the same
field — the lens is a thinner object at comparable `n`, and phase 1e should price it against the word ball before
leading with it. Larger `n` was not run (§8).

---

## 5. Items 3 and 7 — the quotient screen, and the fan-gap closure it carries

`tools/fs70_quotient.py`, `tools/fs70_lambdaprime.py`, `data/fs70/quotient/`.

### 5.1 The instrument, and the two theorems it joins

For a lattice `Λ` with saturation `U`, and `N` with no unit vector in `NΛ`, reduction `Λ → Λ/NΛ` is a graph
homomorphism from the unit-distance graph on `Λ` onto `Cay(Λ/NΛ, U mod N)`. Then:

1. a proper four-colouring of the quotient four-colours **every** graph on `Λ` at once, at every radius — row 56's
   `unitQuadrance_colorable_of_quotient`, kernel-grade;
2. **and if that colouring has a fan gap anywhere** — a colour absent from some vertex's *closed* neighbourhood —
   then `slack_addCayley_of_fanGap` makes the quotient Slack at four colours (one gap translates to every vertex),
   and `Slack.forces_iff_of_hom` gives `Forces G 4 u v ↔ u = v` for **every** unit-distance graph on `Λ`.

I read the Lean source of `FanGap.lean` rather than the ledger summary before claiming this: `FanGap C v γ` is
`γ ≠ C v ∧ ∀ w, Adj v w → C w ≠ γ` (the *closed* neighbourhood), `slack_addCayley_of_fanGap` needs exactly **one**
gap, and `Slack.forces_iff_of_hom` needs no surjectivity. The virtual-edge half needs a **shared** gap at the
pair's difference and does **not** follow.

### 5.2 The table

| lattice | rank | `g` | wall | `N` | classes | edges | verdict | gapped | shared-gap differences | `Forces` closed? |
|---|---|---|---|---|---|---|---|---|---|---|
| **Λ′** = ⟨unit vectors of ℚ(√3,√−5)⟩ | 4 | 46 | broken | 5 | 625 | 14,375 | **SAT** | **597 of 625** | 1 of 578 | **YES** |
| Λ′ | 4 | 46 | broken | 10 | 10,000 | 230,000 | **SAT** | **9,977** | 1 of 9,953 | **YES** |
| Λ′ | 4 | 46 | broken | 7, 8, 9, 11 | — | — | UNSAT | — | — | — |
| **L6** = `group6:u3:2+zeta6:rho15` | 6 | 54 | broken | 5 | 15,625 | 421,875 | **SAT** | **1,250** | 1,249 of 15,570 | **YES** |
| L6 | 6 | 54 | broken | 7 | 117,649 | 2,117,682 | UNSAT (63.9 s) | — | — | — |
| L6 | 6 | 54 | broken | 8 | 262,144 | 4,718,592 | SAT (5.2 s) | **0** | 0 | no (this `N` alone) |
| **L1** = `group6:u3:2` (Harder transposed) | 4 | 30 | standing (2-unit) | 5 | 625 | 9,375 | **SAT** | **50** | 0 of 594 | **YES** |
| L1 | 4 | 30 | standing | 7 | 2,401 | 21,609 | **SAT** | **193** | 0 of 2,382 | **YES** |
| L1 | 4 | 30 | standing | 2, 4, 6 | — | — | SAT | 0 | 0 | no (those `N`) |
| calibration: ⟨ζ₆⟩, the triangular lattice (χ = 3) | 2 | 6 | — | 3 | 9 | 27 | SAT | 3 | 0 | **YES**, as it must be |

**P3 LOST and P11 LOST**, both in the informative direction: I predicted UNSAT everywhere on L6 and on Λ′.

The `N = 5` colouring of Λ′ is **not additive**, and cannot be: `Hom((ℤ/5)⁴, G) = 0` for `|G| = 4`. It is the
first non-additive periodic four-colouring rule this milestone has found, and it is what the additive screens were
structurally unable to see. That bears on G61(2) — *"every periodic colouring of the 3-integral pools tried is
affine, so quotient screens are blind"* — which is a three-colour statement; at **four** colours over this field a
quotient screen is **not** blind and the colouring is **not** affine.

Independent verification of the Λ′ result (a checker that rebuilds the quotient graph from the 46 unit vectors on
its own): **0 monochromatic edges** on the quotient, and the colouring **pulled back** to real Minkowski balls of
Λ′ — 2,807 / 13,893 / **64,109** points, up to **749,655 edges** — with **0 monochromatic edges** at every radius
and all four colours used.

### 5.3 The falsification control — the row that makes the rest evidence

Harder's forced pair at `(0, 8/3)` on **de Grey's K-lattice** is in print, and §4 reproduces it. So the screen
**must not** find a gapped quotient four-colouring there. `data/fs70/quotient/degrey-K-control.json`:

| `N` | 2 | 4 | 5 | 6 | 7 | 8 | 10 | 11 | 12 | 13 |
|---|---|---|---|---|---|---|---|---|---|---|
| verdict | SAT | SAT | UNSAT | SAT | UNSAT | SAT | SAT | UNSAT | SAT | UNSAT |
| **gapped vertices** | **0** | **0** | — | **0** | — | **0** | **0** | — | **0** | — |
| `8/3` separated from `0` | no | no | — | no | — | no | no | — | no | — |

**Six four-colourings, all gap-free, none separating `8/3` from `0`.** The instrument distinguishes a lattice with
a forced pair from one without, and it did so on the one object where the answer was known independently of
anything I wrote.

### 5.4 Λ′ itself (item 7a and 7b)

`tools/fs70_lambdaprime.py`, `data/fs70/lambdaprime/`. The owner's numbers reproduce exactly: **46 unit vectors**
of `E′ = ℚ(√3,√−5)` at denominator 24, rank 4, HNF `[[−1,50,10,−23],[0,5,−21,4],[0,0,2,20],[0,0,0,2]]`, index 20
in ℤ⁴, `1/2`, `1/3`, `1/4` and the targets `2, 4/3, 8/3, 4, 2/3` in the lattice, `4/7` and `4/√3` not. The named
vectors `u`, `v`, `ρ₁₅` are all unit vectors of it; `ζ₆` is not in `E′`.

**At denominator 48, `g = 66`** (the owner's question): 6 two-units, 60 wall-breaking, 14 three-units, still rank
4, index 20 in ℤ⁴ — so the lattice at 48 is 16× finer and gains 20 unit vectors.

The asks (all **SAT**, all with a colouring proper on every edge; `data/fs70/lambdaprime/asks.jsonl`):

| R | points | edges | avg degree | predicted degree (G65) | asks | seconds |
|---|---|---|---|---|---|---|
| 1.0 | 2,807 | 10,033 | 7.15 | 7.15 | control, `forces 2/3` | 0.12 each |
| 1.5 | 13,893 | 108,601 | 15.63 | 15.7 | control, `forces`/`separated` at `4/3`, `2/3` | 2.6–17.3 |
| 2.2 | 64,109 | 749,655 | 23.39 | 23.6 | control, `forces`/`separated` at `2`, `4/3` | 0.7–2.5 |

**P9 LOST** (the control colours — I had it at medium and it colours, but the reason is §5.2's theorem, not the
solver). **P10 WON**: every ask decided in seconds, as G65's degree law says it must past the hardness peak. The
degree law's prediction `g·φ(R)²` matched the measurement to three significant figures at all three radii, which
is a calibration of the law over a **CM field with two complex places** — a shape it had not been tested on.

R = 3 and the lens on Λ′ were **not run**, deliberately: after §5.2 every `forces` verdict on Λ′ is known by
theorem, so the runs would have measured the solver.

---

## 6. Item 4 — the rich 2-unit lattices, and the join with item 1

`tools/fs70_kempe_rich.py`, `data/fs70/kempe-rich.json`. Reach = the ℤ-span of the pair sums `z + w` over unit
vectors with `φ(z) = b`, `φ(w) = −b`. Computed by the identity

    span{z + w}  =  span( {z₀+w₀} ∪ {z − z₀} ∪ {w − w₀} ),

which replaces up to 372,000 vectors per (colouring, colour) by 611 with the same span — checked against the full
enumeration in the self-test. Each lattice has 48 proper additive ℤ/4-colourings (the owner's
`po_additive_screen_rich.py` reads 48; reproduced).

| lattice | `g` | `2` | `4/3` | `8/3` | `4` | `4/7` | `4/√3` | `2/3` |
|---|---|---|---|---|---|---|---|---|
| `twounits:14` | 212 | escapes (32/48) | **RIGID** | **RIGID** | **RIGID** | **RIGID** | **RIGID** | escapes (32/48) |
| `twounits:30` | 660 | escapes (32/48) | **RIGID** | **RIGID** | **RIGID** | **RIGID** | **RIGID** | escapes (32/48) |
| `twounits:42` | 1,220 | escapes (32/48) | **RIGID** | **RIGID** | **RIGID** | **RIGID** | **RIGID** | escapes (32/48) |
| `v_𝔭(δ)` | | **2** | 4 | 6 | 4 | 4 | 4 | **2** |

**P4 LOST**: I predicted escapes at every target. All three lattices are Kempe-rigid at five of the seven.

**Soundness, stated because it flips here.** These lattices' own denominator is 16,380 (and 5.3·10¹⁰, and
2.5·10¹⁵), so the saturation box is unaffordable and the unit vectors used are the **generator** set — every
2-unit vector to the named denominator, which is what the owner's screen and `data/fs70/screen.jsonl` record as
`g`. A reach computed from generators is a **lower bound** on the true reach, so **RIGID is sound for every graph
in the lattice** (the direction that matters here) while **ESCAPE is sound only for graphs built from those
generators**. Every row in the JSON says which.

**The join the brief asked for.** For each rigid `(lattice, δ)`: is `v_𝔭(δ) ≥ d₀ = 3`? **Yes, all fifteen** (five
targets × three lattices, `v_𝔭 ∈ {4, 6}`). And every escaping `(lattice, δ)` has `v_𝔭(δ) = 2 < d₀`. The two
computations share no code, no solver and no input beyond the field, and they partition the seven targets
identically. A rigid target below `d₀` would have meant a defect in one of them; none appeared.

---

## 7. Item 5(c) — the in-field type-M members, and two the sweep missed

`data/fs70/typeM-in-field.json`. G7's family `cos θ = (2n−1)/(2n)` lies in `F(i)` exactly when `4n − 1` is `k²`,
`3k²`, `5k²` or `15k²`. For `n ≤ 100` there are **nine**:

| n | `4n−1` | class | `ψ` | 2-adic depth | status |
|---|---|---|---|---|---|
| 1 | 3 | 3 | `(1/2, √3/2)` = `ζ₆` | 0 | 2-unit — the trivial rotation |
| **4** | 15 | 15 | `(7/8, √15/8)` = **ρ₁₅** | **−4** | **wall-breaking** |
| 7 | 27 | 3 | `(13/14, 3√3/14)` | 0 | 2-unit — dead by phase 1c's theorem |
| 19 | 75 | 3 | `(37/38, 5√3/38)` | 0 | 2-unit — dead |
| **34** | 135 | 15 | `(67/68, 3√15/68)` | **2** | **wall-breaking — NOT in phase 1c's list** |
| 37 | 147 | 3 | `(73/74, 7√3/74)` | 0 | 2-unit — dead |
| 61 | 243 | 3 | `(121/122, 9√3/122)` | 0 | 2-unit — dead |
| 91 | 363 | 3 | `(181/182, 11√3/182)` | 0 | 2-unit — dead |
| **94** | 375 | 15 | `(187/188, 5√15/188)` | **−2** | **wall-breaking — NOT in phase 1c's list** |

Phase 1c's 3,500 classes contain **exactly one** type-M member, `n = 4`. So its sentence *"only one class in 3,499
is type-M"* is true **of its enumeration** and misses `n = 34` and `n = 94`, both wall-breaking and both live —
their denominators (68 and 188) are outside the atlas's cap of 42 and the `(z+s)/w` generator did not reach them.
Six of the nine are 2-units and dead by phase 1c's own theorem without any of this.

Items 5(a), 5(b), 5(d) and item 6 were **not run**. §8 ranks them.

---

## 8. What phase 1e should do, ranked, with what changed

| # | what | why now |
|---|---|---|
| 1 | **The rich 2-unit lattices, asked.** `twounits:14/30/42` are Kempe-rigid at `4/3`, `8/3`, `4`, `4/7`, `4/√3`, have never been asked, and are the only fabric left that the quotient screen has not closed (rank 8 puts `N^8` out of reach for every admissible `N`, so §5 cannot be run on them). **First: the quotient screen at `N = 2, 3`** (256 and 6,561 classes) — if a gapped colouring exists there, they close too and the milestone's 2-unit route is finished. Only if it does not, ask `forces δ` at the five rigid targets on a ball. | the one live fabric; and the screen is minutes against the ask's hours |
| 2 | **The `N = 8` row of L6 is the counterexample to run down.** L6 has a **gapped** colouring at `N = 5` and a **gap-free** one at `N = 8`. Both are proper. So the gap is a property of the colouring, not the lattice, and the screen's power depends on finding a gapped one — which means an UNSAT or a gap-free SAT at one `N` proves nothing. A finder aimed at gapped colourings (maximise the number of gapped vertices) would make the screen decisive rather than lucky. | the instrument's own soundness boundary, found in its own data |
| 3 | **The de Grey control, inverted into a question.** de Grey's K-lattice has six gap-free quotient four-colourings and a forced pair; Λ′, L6 and L1 have gapped ones and no forced pair. **What distinguishes them?** It is not the 2-adic wall (L1 is 2-unit and gapped, de Grey's is 2-unit and gap-free). A mechanism here would be a grokking, and the data for it is already on disk. | four objects, two classes, and the classifier is not the wall |
| 4 | **The tower's LRAT core** (deferred from item 1). `P₄`'s refutation is 6 s on a 0.40 GB CNF; extracting the core by backward reachability (the `Instances/TwoAdicFive/Edges.lean` recipe) makes the tower's forcing a kernel statement, as row 67's is over `K`. Priced at an afternoon. | phase 2's kernel form |
| 5 | **Items 5(a), 5(b), 5(d)** — cross-edge density, whether cross edges form a matching or close cycles through both halves, the live radius sums, the off-diagonal monochromatic share — and **item 6**, the Galois symmetry break | not done here. Their bearing fell when §5 closed the arena route by theorem: they rank arenas for asks that no longer need running. Keep them for a two-centre shape if one is built |
| 6 | **The lens, priced against the word ball.** `T₅` on de Grey's K-lattice is 466 points and SAT where the word ball at sums of ≤ 3 is 23,083 points and UNSAT. Before phase 1e leads with a lens, measure at which `n` a lens reaches the word ball's forcing | the shape the plan leads with, now measured once and found thin |

---

## 9. Predictions scored

| # | prediction | outcome |
|---|---|---|
| P1 | the split tower is tight at every level 1–5 | **WON** (and at 6) |
| P2 | `d₀ = 4`, as over `K` | **LOST** — `d₀ = 3` |
| P2′ | `H_min` first nontrivial at level 5 | **LOST** — level 4 |
| P3 | the quotient sweep on L6 is UNSAT at every admissible `N ≤ 8` | **LOST** — SAT at `N = 5` (gapped) and `N = 8` (gap-free) |
| P4 | the rich lattices are Kempe-open at every target | **LOST** — rigid at five of seven |
| P5 | Harder's forcer refuses | **WON**, at the plan's §3.3 shape, not at the brief's `V + V + H` |
| P6 | the lens forces `8/3` at some `n ≤ 8`, below 745 points | **not settled** — `n = 5` is SAT at 466 points; larger `n` not run |
| P7 | Galois symmetry breaking gives under 2× | **not run** |
| P8 | `H_min(m) = {(a,b) ∈ π³×π³ : a ≡ b mod π⁴}` | **SPLIT** — the order is right at all three levels, the set is not |
| P9 | the Λ′ control colours at every affordable radius | **WON on the verdict, for the wrong reason** — it colours by theorem (§5.2), not because the solver found something |
| P10 | if Λ′ colours, it colours in seconds | **WON** |
| P11 | the Λ′ quotient sweep returns no SAT | **LOST** — SAT at `N = 5` and `N = 10` |

Eight predictions of twelve settled, **five lost**. Every loss was in the direction that produced a theorem.

---

## 10. Where the brief or I was wrong

| where | what it says | what is the case |
|---|---|---|
| **the brief, item 1** | `v_𝔭(4/3) = 2` | **4.** `4/3` and `4` differ by the 2-adic unit 3, so they have the same valuation, and the brief lists `v_𝔭(4) = 4`. The others (`2`→2, `8/3`→6, `4`→4, `4/7`→4, `4/√3`→4) all check out. It matters: at `v = 2` the tower kills `4/3`, at `v = 4` it forces it |
| **the brief, item 2** | "Harder reports 745 vertices after de-duplication (your count must agree or you must say why not)" | 745 is his **smallest forcing subgraph**; the Minkowski sum `V + V + H` is 2,341 points and does not force. Our own held thread text says *"The smallest subgraph ... 745 vertices"*. The forcing shape is the plan's §3.3 one, and it is 23,083 points at sums of ≤ 3 |
| **the brief, item 1** | "the tower's first forcing depth `d₀` … every chainable target with `v_𝔭(δ) < d₀` is dead" | right, and the useful half of the sentence turned out to be the **other** one: `d₀ = 3` kills only `2` and `2/3`, and the informative result is that the five remaining targets are **forced in the local plane**, which is a positive signal the brief did not anticipate |
| **the brief, item 3 and 7c** | the quotient sweep's product is a colouring (row 56) | it is also, at no extra cost, a **closure of `Forces`** whenever the colouring has a fan gap (row 66). That is the milestone's actual question, and it is strictly stronger. The brief asked only for the weaker half |
| **phase 1c's record, §4a** | *"only one class in 3,499 is type-M"* | true of its enumeration; `n = 34` and `n = 94` are in-field, wall-breaking and absent from it (§7) |
| **my own tower tool**, caught by its own assertion | the coordinate map onto `⊕ℤ/d_i` used the Smith **row** transform of the lattice basis | it needs the **column** one. It was well defined by accident at levels 1–4 (where the lattice is `2^kℤ⁴` or close) and broke the DFT's reality at level 5, where it reported a spectrum with an imaginary part of 32. Repaired, and the assertion that would have caught it on day one — *the coordinate map must vanish on every lattice basis vector* — is now in the constructor. **Levels 3's `H_min` was reported as order 2 under the bug and is 1** |
| **my own `V + V + H` self-test** | asserted 745 points and went RED | the assertion encoded the brief's number rather than a fact I had checked. Replaced by the computed 2,341 with the reason written beside it |
| **my own plant on the Λ′ colouring** | recolour one vertex; it must create a monochromatic edge | it did not — **because that vertex's neighbourhood misses a colour**, which is the fan gap itself. A plant that cannot fire has not tested anything by passing (`CLAUDE.md`, "state the uninformative outcome and confirm it is reachable"). The plant was wrong and the failure was the finding; the check that replaced it is the independent rebuild of §5.2 |
| **my own `drop_generator` plant** in `fs70_lambdaprime` | drop one of the 46 unit vectors from the span; the HNF must change | it does **not**: at rank 4 the 46 generators are redundant, so dropping any one leaves the identical lattice, and the plant could never fire. Repaired to drop down to three (rank falls) and joined by a second plant that admits a non-unit. **The fact it exposed is worth keeping: the HNF does not check that the enumeration of unit vectors is complete** — only the exact norm equation does, and that is where `unit_test_loose` now bites. 4 of 4 plants fire |

---

## 11. What a kill would have redone, what is on disk, and how to regenerate

| step | wall | checkpoint | a kill redoes |
|---|---|---|---|
| the tower levels 1–5 | 11 s | none needed | 11 s |
| the tower level 6 | 3 m 34 s | none | all of it |
| the additive kill at levels 3–4 (every edge verified) | 3 m 22 s | none | all of it |
| the `P₄` forces confirmation | 43 s build + 2 × 11 s | verdicts written at the end | all of it, ~70 s |
| Harder's word balls | 24 m (23 m of it building the sums-of-≤-4 point set) | none | all of it — **my defect**, and the one step here that deserved a checkpoint |
| the Λ′ balls and quotient sweep | 2 m and 30 s | a ledger row per ask, a JSON per `N` | the one ask in flight |
| the L6 and other quotient sweeps | 1–2 m each | a JSON per lattice | the one `N` in flight |
| the de Grey K control | 5 m | none | all of it |
| the Kempe reach sweep | 12 s | none | 12 s |

**Durable artifacts** (all under `data/`, none under `build/`): `data/fs70/tower/` (`levels.json`,
`additive-kill.json`, `forces-confirmation.json`), `data/fs70/quotient/` (per-lattice JSON, the committed
colourings, `lambdaprime-fangap.json`, `degrey-K-control.json`), `data/fs70/lambdaprime/` (`screen.json`,
`asks.jsonl`, the graphs and colourings), `data/fs70/kempe-rich.json`, `data/fs70/harder-control/`,
`data/fs70/typeM-in-field.json`, `data/fs70/records/phase-1d-predictions.md`, this file.

```
python3 tools/fs70_tower.py selftest            # and --plants
python3 tools/fs70_tower.py levels --max 5
python3 tools/fs70_harder.py selftest           # and --plants
python3 tools/fs70_harder.py build
python3 tools/fs70_lambdaprime.py selftest      # and --plants
python3 tools/fs70_lambdaprime.py screen
python3 tools/fs70_lambdaprime.py ball 1.5 --pins control,forces:4/3,separated:4/3
python3 tools/fs70_lambdaprime.py quotient --nmax 30
python3 tools/fs70_quotient.py sweep 'group6:u3:2+zeta6:rho15' --nmax 8 --cap 300000
python3 tools/fs70_quotient.py sweep 'group6:u3:2' --nmax 7
python3 tools/fs70_kempe_rich.py selftest       # and --plants
python3 tools/fs70_kempe_rich.py sweep
```

The three scripts under `build/fs70/1d/` (the `P₄` confirmation, the de Grey control, the additive kill) are
scratch and are reproduced verbatim in the git history of this commit.

---

## 12. A grokking candidate, for the owner (not minted here)

**The quotient screen sees what the additive screen cannot, and the difference is a fan gap.** Over this field at
four colours, three of the milestone's lattices carry a **non-additive** periodic four-colouring — impossible to
reach additively, since `Hom((ℤ/5)^r, G) = 0` for `|G| = 4` — and that colouring has a gap, which by row 66 closes
`Forces` on the whole lattice at every distance and radius. de Grey's K-lattice, which has a forced pair in print,
carries six periodic four-colourings and **not one of them is gapped**. So the question *"can this fabric force a
four-colour pair?"* has a cheap, one-sided, theorem-grade screen — minutes per lattice, no ball, no radius, no
solver time on the object itself — and the milestone ran balls for three phases without it.

*Do: before building any ball over a lattice, run `Cay(Λ/NΛ, U mod N)` at every admissible `N` the rank allows and
read each SAT colouring for a fan gap; one gapped colouring closes `Forces` on the whole lattice by theorem, and no
ball need be built. Killing test: a lattice with a gapped quotient four-colouring that nevertheless carries a
four-colour forced pair — which would refute row 66 or the homomorphism, not the screen.*

What it does **not** say: an UNSAT, or a gap-free SAT, at one `N` proves nothing (L6 gives both at `N = 5` and
`N = 8`), and the shared-gap half — which would close virtual edges — held at only 1 difference of 578 on Λ′.
