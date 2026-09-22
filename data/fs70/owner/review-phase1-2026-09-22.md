# FS-70 — the owner's review of phase 1 (the asks), 2026-09-22

*Scored by artifact against `data/fs70/records/phase-1.md` (commits `2ac1696b` … `4c788f06`). Implementer: Opus 5, ≈550k tokens
(over the ~400k asked; everything persisted). Every check below is my own code or hand, none shared with `tools/fs70_*`.*

## 1. Verdict: ACCEPTED as a phase; the milestone is NOT closed — one lattice the plan never built is live, and it is asked next

| what | how I checked | result |
|---|---|---|
| **The Kempe escape** (record §4.1): a Kempe swap of a proper additive colouring is proper and non-additive; the `(0,b)`-component of the origin is the sublattice spanned by pair sums `z + w` with `φ(z) = b`, `φ(w) = −b`; if it misses `δ`, no finite graph in the lattice forces `(0, δ)` at any radius | derived by hand before reading the record (the alternation argument, closure under negation, the swap's properness on any finite subgraph); then `po_kempe_screen.py` (mine) on Harder's lattice `⟨ζ₁₂, u, u²⟩` | sound; **288 of 1,296 additive colourings give an escape at colour 2 (reach rank 6) for both 4/3 and 8/3; none at colours 1, 3** — the record's kill reproduced. **P2 is lost by derivation.** |
| **The screen's falsification control**, which the phase could not run (no ℚ(√3,√11) arithmetic): over K on de Grey's direction lattice `⟨ζ₆^m ρ^n : \|n\| ≤ 2⟩`, Harder's pair `(0, 8/3)` is forced in print, so the screen **must** read live | `po_kempe_control_K.py` (mine, radicand 11): rank 4, **54 unit vectors** (the Polymath strip paper's fifty-four), 12 ℤ/4 and 12 Klein proper additive colourings | **none separates the pair and no Kempe swap frees it at any colour — LIVE, as it must be.** The screen survives the one test that could refute it |
| The 13 SAT verdicts | `po_verify_ask.py` (mine: every unit vector over the file's denominator enumerated by a vectorised exact box, the complete unit-distance graph by translate lookup, the colouring on MY edges): L2 `forces 4/3` (95,317 points) and L4a `forces 4/7` (94,849) | my edge sets equal the files' (550,014 and 559,536, exactly); both colourings proper, pins honoured, pairs separated |
| The encoding correction (record §2) | read against my brief | **my brief inverted `eq`**: contraction asks whether the pair *can* be equal (a virtual-edge ask); the forced-equal ask pins the pair *different*. I copied Haugland's control (a virtual edge, rightly contracted) onto the wrong question. The implementer followed the mathematics and said so. **Owner error, recorded.** |
| The `e_denominator` defect in `fs70_field.py` (max for lcm; `int()` truncating a `Fraction`) | its blast-radius claim: zero mis-converted unit vectors, atlas byte-identical | plausible by the argument given (`x² + y² = 1` forces the dividing relation); phase 2 was the consumer; fixed |
| The two runs left live (L3 k=4 control, L5 k=4 `forces 4/3`; single kissat each, budgets 1,500 s and 3,000 s, self-describing in-flight markers) | `ps`, the markers | within their budgets; left to expire (`UNKNOWN` at budget is what they will write; killing them buys nothing) |

## 2. What phase 1 established

1. **The 2-unit route is dead by theorem.** On every lattice that admits a proper additive ℤ/4-colouring with a Kempe escape —
   Harder's shape `S₂`, the 7-family, `zeta12+u3`, L4b, `zeta12+d6` — no finite graph forces any chainable pair, at any radius.
   Two screens, both exact, both reproduced here, one of them tested against a forced pair in print.
2. **The live lattices are free at every size built.** L2, L3 (wall-breakers; no additive colouring), L4a, L5 (additive but
   Kempe-rigid): thirteen asks at 95k points / degree 11.5, all coloured in seconds; at 1.86 M points / degree 15.5 the two
   controls with additive lattice colourings are SAT by exhibition. L2's control colouring is a function of no residue at any
   prime ≤ 7 and has no period. The word balls top out at degree ~15.5 (a 14-core of L5's is empty); Minkowski balls are
   unaffordable on rank-8 lattices with four embeddings.
3. **The mechanism, in one comparison, from my own runs tonight.** Over K, de Grey's direction lattice is rank 4 with **54 unit
   vectors on 30 generators** (the twist `ρ` has the square root `η = (√33 + i√3)/6` in the field), **24 additive colourings, all
   Kempe-rigid** at 8/3. Over ℚ(√3,√5) the faithful transposition `⟨ζ₆^m u^n : \|n\| ≤ 2⟩` (rank 4, in the CM field
   ℚ(√−3,√−5)) has **30 unit vectors on 30 generators** (`u` has no square root: `(1 + Re u)/2 = 1/6` is not a square in the
   field), **72 additive colourings, with Kempe escapes at 4/3, 8/3 and 4** in both families — `po_cm_lattice.py 2`. The
   rank-8 lattices the plan used (every one carries the quarter turn ζ₁₂) have 1,296 and escape too. **What made Harder's forcer
   possible over K is a lattice rigid enough to have almost no colouring freedom, and the same construction over ℚ(√3,√5) has
   three times the freedom and a hole.** G61(4)'s reading — what decides a field is how many unit vectors its lattices hold —
   has a sharper form here: the count of additive colourings and the Kempe reach rank, both exact.

## 3. What phase 1 did not ask, and why the milestone is not closed

Every lattice in the plan contains ζ₁₂. M63 phase H3 recorded that *dropping Parts's coordinate shape IS adjoining the quarter
turn* and that the shape-free base died by an additive route (row 65). The known forcers all live on **CM-shaped, rank-4**
lattices plus one wall-breaker. The transposition here is `⟨ζ₆^m u^n : \|n\| ≤ 2⟩ ∪ ζ₆^m{ρ₁₅, ρ̄₁₅}`: `ρ₁₅ = (7 + √−15)/8` lies
in ℚ(√−15) ⊂ ℚ(√−3,√−5), and `ρ₁₅ζ₆` lies in ℚ(√−3,√5), so the lattice has **rank 6, M = 144, 54 unit vectors on 42
generators, no additive colouring of either kind, and every chainable target LIVE** (`po_cm_lattice.py 2 rho15`). Neither
screen can speak on it; only a solver can. It is the one fabric with the structure of every known forcer, and it costs a
morning: word balls at sums of ≤ 3 and ≤ 4 on 42 vectors are 10⁴–10⁵ points.

## 4. Rulings for phase 1b (one fresh Opus implementer)

1. **L6 = `⟨ζ₆, u^{±1,±2}, ρ₁₅, ρ̄₁₅⟩`** (the tool needs a `zeta6` family and a `rho15` family; ζ₆-orbits, not ζ₁₂): screen row
   appended to `screen.jsonl` (gate, `g = 54`, no additive colouring — mine says so; theirs must agree), then the asks in this
   order on word balls at sums of ≤ 3, then ≤ 4: **control**, `forces 2`, `forces 4/3`, `forces 2/3`, `forces 8/3`, `forces 4`,
   `separated i√3`. Then the same with `|n| ≤ 3`. A refusal on the control is the milestone (a five-chromatic graph with no chain).
2. **The cube pass the plan owed:** L2 and L3 at k=4, control — after the live kissats expire.
3. L5 and L4a at k=4, `forces 4/3` — only if the cube pass on L2/L3 has closed and budget remains.
4. Budgets as before (10 min single solver, then cubes; 40 CPU-h per ask; 240 CPU-h for the phase). On a refusal: HALT, verify
   three ways, hand back with the graph in the nine-integer format and the ledger.
5. **Colourings are evidence: every SAT row's colouring is committed** (compressed, beside its row under `data/fs70/records/asks/`),
   not left in `build/`. Phase 1's thirteen are copied in by phase 1b.
6. If everything colours: the milestone closes as a typed null with the Kempe screen as its instrument finding and §2.3 above as
   its mechanism finding; phase 3 is mine.

## 5. Owner errors this milestone (running list)

1. The brief's `eq` encoding (contraction) — inverted; caught by the phase-1 implementer.
2. The review note's first draft called 2/3 a live 2-unit target — corrected by re-deriving; and gave the wrong reason for its
   absence from the table — corrected by the phase-0 implementer.
3. `setsid` forks: I recorded the parent's pid for the replay — caught by checking the ledger was still growing.

## 6. Files

`po_kempe_screen.py`, `po_kempe_control_K.py`, `po_verify_ask.py`, `po_cm_lattice.py` (this directory; each runs in seconds
to a minute), this note.
