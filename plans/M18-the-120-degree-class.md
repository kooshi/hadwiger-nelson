# M18 — The 120° class (stub)

*Carry-forward notes, written 2026-08-02 as M17 closed. Not yet subplanned. Direction set by
Kooshi: the write-up is deferred indefinitely; **the project is exclusively a hunt for new
mathematics, however small, ratcheting toward major findings** — and M18 is the first milestone
whose objective is a piece of structure nobody has named, not a sweep of known families.*

## 1. Why this milestone exists — the evidence trail

M17's hunt (68 candidates, 557 M class-tests, all separated) produced one non-binary output: the
**resisting histogram**. Classes at squared distance `r² = 1/3` resisted pool rejection
**17,259 of 35,727 solver calls — in every family, at every generation, at the same structural
positions**. Next: irrational classes (12,499), then `r² = 3` (4,062). The signal is stable,
structural, and unexplained by anything then in the toolkit. Twenty minutes of first-principles
analysis at M17's close turned it into verified structure:

### (a) The 120° identity — verified computationally 2026-08-02

The spindle rotation at class `r²` turns by `cos θ = (2r² − 1)/2r²`; at `r² = 1/3` that is
`cos θ = −1/2`: **exactly 120°, the unique class angle of finite order 3.** Verified on de Grey's
graph at pivot 630 (class members [648, 655, 696]):

* Doubling twice at the same pivot **closes a ℤ/3 orbit** — G (1,581) → G∪ρG (3,138) →
  G∪ρG∪ρ²G (4,678) → a fourth copy adds **0 points**.
* In the closure, the 1/3-class **partitions into unit equilateral triangles**: each member and
  its two images are pairwise at distance exactly 1 (each class member has exactly 2 unit
  partners inside the class — measured, matching the prediction).

### (b) The colour-budget mechanism

A proper colouring paints every unit triangle with 3 distinct colours, so in a 120°-closed graph
**the 1/3-class eats 3 of the 5 colours by itself**; a colouring separating the pivot from the
class must hide the pivot's colour in the remaining 2. That is what 17,259 resists look like from
inside: separation as needle-threading through a 2-colour gap.

### (c) The single-class impossibility lemma — and why 1/3 is unique

Unit edges *within* a class are chords of a circle subtending a **fixed** angle, so every
class-induced subgraph has maximum degree ≤ 2 — disjoint paths and cycles, always 3-colourable.
Hence **no class can ever confine a fan by itself** (a separating assignment of the class alone
always exists); confinement, if achievable, is an *interplay* theorem between class and ambient
graph. And `r² = 1/3` is the **unique** class whose induced cycles are triangles — the only class
that brings odd cycles (chromatic number 3) to the table at all.

### (d) The coverage reduction — confinement as a design objective

The pivot is separated from its 1/3-class exactly when some colour appears on neither its
unit-neighbourhood `N(p)` nor the class `C`. Contrapositive, one line, genuinely useful:

> **If every proper 5-colouring puts all five colours on `N(p) ∪ C`, then `p` is fanned by `C`**
> (the shared colour cannot sit on a neighbour, so it sits in the class).

The class already forces 3 colours; the constructive question becomes: **build graphs where the
pivot's unit-neighbourhood is forced to spend the other 2.** This converts confinement from a
binary SAT answer into a *coverage statistic* the instrument can score per candidate — the
gradient M17's binary verdicts could not see.

### (e) What the story does NOT explain — a measurement obligation

`r² = 3`'s third-place resistance rank is **not** explained by odd cycles (its class angle
`2·arcsin(1/(2√3))` is an irrational fraction of the turn; its induced graphs are paths). Whatever
drives it is ambient — de Grey's graph is *built* from √3 rhombi — and §0 of the subplan must
measure it rather than let the pretty 120° story absorb it.

### (f) The ℤ/3 closure sweeps — run, both separated

The closures at pivots 630 and 633 (4,678 points each; recipes
`double(double(dg, p, 1/3), p, 1/3)`, second pivot key rescaled) were unswept by H1–H5. Swept
2026-08-02 (ledger names `Z3-closure-dg{630,633}x1/3`): **both fully separated — 4,678 pivots
and 20,013,206 classes each, zero confined, zero deferred** (578 and 551 calls, ~9 min each).
Exactly what §1(c) predicts: rainbow triangles alone cannot confine — they spend 3 colours but
nothing yet forces the pivot's unit-neighbourhood to spend the other 2. The *coverage gap* of
these two closures — how many colours `N(p) ∪ C` actually carries across the pool's separating
colourings — is the first number M18's §0 must produce: it is the distance-to-confinement the
binary verdict cannot see, measured on the two most triangle-rich candidates in existence.

## 2. Candidate deliverables (to be refined at subplanning)

1. **Formalized structure — the tiny new mathematics.** Three exact statements, each small,
   together turning an empirical histogram into theorem-backed structure:
   * the **class-angle lemma**: unit chords within a distance class subtend a fixed angle; the
     induced degree is ≤ 2; triangles occur iff `r² = 1/3` (exact field arithmetic; the
     `Field/Approx` instrument reads the geometry);
   * the **rainbow-triangle lemma**: in a 120°-closed graph the 1/3-class partitions into unit
     triangles, each rainbow under any proper colouring;
   * the **coverage⟹fan lemma**: surjectivity of a colouring on `N(p) ∪ C` yields the fan over
     `C` — trivial proof, new statement, and the hunt's new objective function.
2. **The coverage instrument**: score `|colours(N(p) ∪ C)|` across the pool per (pivot, class);
   rank candidates by how close they come to 5. Where the maximum sits and what moves it is the
   milestone's empirical question.
3. **Coverage-driven construction**: candidates engineered to force coverage — pivots inside
   many unit triangles (spending `N(p)` colours) whose 1/3-class is closed (spending 3 more).

## 3. Standing constraints (carried)

Rejecting a candidate is ~free; the all-pivots sweep is ~300 s per 3,000-pt candidate; a hit is
triaged then certified through M16's route in its own milestone; deletion never creates
confinement (`FanMono.lean` — kernel-checked); no single class confines alone (§1(c) — to be
kernel-checked in M18). "Searched X, found nothing" is a result. `tools/` stays untrusted.

## 4. Operational rules in force (set 2026-08-02, recorded in CLAUDE.md)

* **All builds through `scripts/build.sh`** — no exceptions, no named-target `lake build` outside
  it. Two OOM incidents were paid for this rule.
* **On any segfault: halt and report immediately** — hardware; Kooshi reboots. Do not diagnose, do not retry, do not continue past it.
* **`lean4checker` replays deferred indefinitely** — the Lean kernel at build time is the
  trust anchor; the independent replay is a *publication* gate, to be run once on other hardware
  before any external claim. The full-fan solver control was retired with the same reasoning
  (M15 established the fact twice; the known-hit control covers the code path).
