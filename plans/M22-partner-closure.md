# M22 — Partner closure and the shape of the pressure

*Subplanned 2026-08-08 (desktop, 32 cores). Replaces the stub written at M21's close;
the stub's horizon sections (the pivot triangle, the 8-circle metapivot system, the
recursion) are preserved at the bottom — they are M23 material and none of their
claims are spent here. Mission: M21 measured the hunt's first nonzero extension
pressure and left χ(pairSystem) open in both directions; this milestone names the
pressure's mechanism (the kill census), makes the entanglement exact where it can be
made exact (partner closure, aimed by near-relations), and lands the general gluing
classification in Lean — the statement both the partner construction and the M23
metapivot system consume.*

## 0. Measurements first

Predictions were registered in `plans/m22-predictions.md` BEFORE any §0 instrument
existed (same-session, pre-code). All §0 artifacts are UNTRUSTED tools-side triage;
nothing here is a claim until the kernel route re-derives it.

### 0.1 The instruments

| Instrument | What it measures | Artifact |
|---|---|---|
| Near-relation spectrum (`m22near.py`) | Best approximants to `l·θσ + k·60° ≡ 0 (mod 360°)` at the canonical pair (θσ = arctan √11, exact to 60 digits); best `(m,l)` discrepancies of `u^{2m}σ^l` at the four M21 phase-probe closure pairs | stdout (triage) |
| Partner-closure spike (`m22partner.py`) | Depth-1 and depth-2 unit-partner closure of the d=1 pair lattice (mpmath 40-digit, 1e-30 confirms): raw/collision/new counts, edge growth, SAT at k=4 (k=3 control), exact-vs-float cost race, discriminant field-membership | stdout (triage) |
| Kill census (`m22kills.py`) | The 229 committed ambient kills + a fresh 1500-pair frame (seed 22): injection-count rigidity gradient (A1), inner/outer relaxation revival (A2), greedy π_a pin cores (A3), local-conflict anatomy (A4) | `build/m22-kills-695-2044.json` |

### 0.2 Predictions vs outcomes

| # | Prediction (registered) | Outcome | Verdict |
|---|---|---|---|
| A1 | killed instances' median locally-valid injection count ≤ half the sat instances' | median 2 vs 2 — no gradient at all; the ambient mechanism is orthogonal to local slack | **refuted** |
| A2 | inner-circle relaxation revives ≥ 50% of kills | inner revives 45/60 (75%) ✓ — but OUTER revives **60/60 (100%)**, and no kill is inner-only: the 2×2 is {both-necessary: 45, outer-only: 15, inner-only: 0, neither: 0} | **confirmed as stated; mechanism reading amended — outer is universal, inner the majority co-factor** |
| A3 | greedy π_a cores ≤ 8 pins for ≥ 75% of a 60-kill subsample | cores 4–8, median **6**, 60/60 within bound; surviving pins lean inner-a (212 inner vs 149 outer) | **confirmed** |
| A4 | ≥ 80% of local conflicts have a fully-starved class | **0/804** — every local kill is a multi-class Hall/matching failure, none is single-class starvation | **refuted** |
| B1 | ladder discrepancy < 0.1° within \|l\| ≤ 60, at CF denominators, thinning | record l's = 1, 4, 5, 9, 59 — the CF denominators of θσ/60 — with δ(9) = 1.008°, δ(59) = 0.059° | **confirmed** |
| B2 | no closure-pair (m,l) within 1° at \|m\|,\|l\| ≤ 12 | **every probed pair has near-cycles under 0.3°**: (695,2044) 0.292° at (m,l)=(4,3); (30,426) 0.056° at (10,−1); (678,3554) **0.064° at (2,−3)** — a four-crossing, three-seam word; (414,715) 0.066° at (11,−11) | **REFUTED — decision fires: aimed adjunction targets named** |
| B3 | best canonical near-relation names a chord < 0.002 | chord(l=59) = 0.00104; and l=9 names chord 0.0176 at word length nine | **confirmed** |
| C1 | depth-1 closure stays k=4 SAT | SAT — and depth-2 too: 9,412 points, 946,941 edges, k=4 sat in 4 s (k=3 unsat control ✓ both) | **confirmed, extended** |
| C2 | exact ≥ 100× float; exact closure > ~10³ unaffordable | measured **6,021×** (62 ms vs 10 µs); decision fires: float triage + exact-on-demand | **confirmed** |
| C3 | ≥ 90% of partner discriminants leave ℚ(√3,√11) | **37.5% stay inside** (15/40, PSLQ triage) — the field grows far less than predicted | **refuted** |
| C4 | ≤ 3× growth after dedupe; some collisions | **67–70% of raw partners collide with existing lattice points** (gen 1); 3.24× total growth (bound marginally exceeded); gen-2 collision rate falls to 49% | **claim confirmed strongly, ratio marginally refuted** |

### 0.3 What the measurements name

1. **The pair is nearly partner-closed.** Two thirds of all unit-partners of lattice
   points already ARE lattice points (gen 1), and over a third of the genuinely new
   partners stay inside ℚ(√3,√11) (C3 refuted). The M21 caveat — "move-closed but not
   cross-partner-closed" — overstated the gap: the move lattice captures most of the
   partner web, and the enrichment is a densification, not an escape into wild fields.
2. **Densification is explosive; the fork does not move.** One closure generation
   multiplies edges ~40× (1,729 → 71,777 on 1,945 points); two generations reach
   946,941 edges on 9,412 points — and k = 4 stays SAT, found in seconds. The χ fork
   will not fall to closure depth at the pair. Whatever forces a 5th colour needs
   either a different configuration (M23's triangle/metapivot) or a targeted, not
   brute, enrichment.
3. **The near-relation spectrum is real and CF-structured.** Nine seam steps land
   within 1.008° of a hex step (missing chord 0.0176 — word length nine!); fifty-nine
   within 0.059° (chord 0.001). These name the almost-cycles — the aimed adjunction
   targets — and the l = 9 relation is small enough to be a certified Lean fact
   (candidate, §2.3).
4. **The closure's coupled pairs are dense with near-cycles** (B2 refuted). Every
   probed pair carries an almost-closed loop under 0.3° at word length ≤ 12 — the
   √33-family pair (678,3554) at a mere (m,l) = (2,−3), i.e. four cross-hops and
   three seam steps missing closure by 0.064°. M21's "no exact relation" was true and
   razor-thin: the coupled geometry sits arbitrarily close to the finite-state
   quotient it provably never reaches. Post-hoc hypothesis for implementation (NOT
   registered — flagged honestly): the ambient kills at (695,2044) are the colour
   shadow of its (4,3)-near-cycle; testable by checking kill cores against the
   near-cycle's vertex support.
5. **The kill mechanism has a shape** (fresh frame 804/228/468 reproduces M21's
   785/229/486 — the phenomenon is frame-independent). Ambient kills are
   **gadget-sized** (cores of 4–8 π_a pins, median 6); the partner side's OUTER
   constraints are necessary in every kill and the inner in 75%; the pinned side's
   cores lean INNER (59%); local kills are pure matching failures (no starvation);
   and local slack does not predict ambient death. Post-hoc mechanism sketch (NOT
   registered): pinned-side inner compulsion triangles transmit through cross chords
   into partner-side outer hexagon alternation — "seam triangle → cross chord →
   hexagon" chains. The clamp specification for gadget design: bind the partner's
   outer hexagon jointly with the anchor's inner triangle; ~6 pins suffice.

### 0.4 Incidents

* The kill census's first run crashed on a missing `edges_sha` key: the committed M21
  joint artifact predates the promoted tool's digest field, and the identity check
  read as a KeyError instead of a named refusal. Fixed with a named fallback
  (identity by (name, n, n_edges) for pre-sha artifacts, printed); cost one 155 s
  closure reload. The promoted `--kills` subcommand carries the fallback and a
  regression fixture for it.
* No OOM, no segfault; caps and controls held on every other run (partner-off-circle
  asserts, planted glue-point control, k=3 controls, free-relaxation SAT control —
  60/60, corpus re-solve control — 0 drift).

## 1. The object, reframed by measurement

The stub ranked "partner closure to force the fork" first. §0-C reframes it: the
closure *cannot* force the fork by depth (k=4 SAT through ~10⁶ edges), because the
pair's partner web is already two-thirds move-generated. The milestone's threads
therefore become:

* **The mechanism thread** (was: kill census) — §0-A names which circle family and
  which core sizes carry the 52%/32% pressure; the output is the clamp specification
  for gadget design (the deliverable M20's battery lacked).
* **The exactness thread** (was: partner closure) — the value of partner adjunction is
  not depth but *aim*: near-relations name almost-cycles; adjoining exactly the
  discrepancy-closing partners builds the tightest finite configurations the pair
  admits. The Lean face is the general gluing classification (`Glue.lean`), which
  states the adjunction move itself.
* **The certified near-cycle** (new, from B1) — `σ⁹` vs `ζ₆`-lattice at chord 0.0176
  is an exact field inequality; candidate for the first certified near-relation
  (§2.3, domain pass rules).

## 2. The Lean targets

*(Skeleton in `Proofs/HadwigerNelson/Glue.lean`; 13 tracked obligations, elaborates
clean at subplan commit; shapes below are pre-modeling drafts.)*

### 2.1 The general gluing classification

* `reflAxis` — the mirror across an arbitrary axis (`(q−p)²/|q−p|²`-conjugation), with
  the M21 package generalized: pivot fixing (`p ≠ q` replaces `dist = 1` — the unit
  premise was normalization, not mechanism), involution, isometry, sphere memberships,
  and the bridge `reflAxis_eq_reflAcross` at unit axis.
* `gluePoint p q r₁ r₂` — the (+)-branch intersection, explicit; its imaginary part is
  the adjoined root `√(r₁²d² − A²)/d²`, i.e. the formula IS the field-growth meter.
* `sphere_inter_sphere` — under the annulus condition, the intersection is exactly
  {gluePoint, its mirror}; tangency degenerates the pair to a singleton and the
  statement stands. Two empty-case lemmas outside the annulus.
* Spec: the unit instance reproduces `hexStep`; the metapivot instance (axis 1/√3 —
  the first non-unit model, straight off the M23 horizon); the far empty case.

### 2.2 Fork-independence

Nothing in 2.1 depends on the χ fork; the classification serves the ≥ 5 branch (it
states the adjunction that builds candidate witnesses), the ≤ 4 branch (it names every
intersection a colouring must respect), and M23 (the metapivot instance is a spec
example already).

### 2.3 Candidate: the nine-step near-cycle (domain pass rules)

`normSq (ζ₆ · σ⁹ − 1) < 1/2500` — exact field arithmetic in ℚ(√3,√33), no
transcendence: nine seam steps miss a hex step by chord < 1/50. The first *certified*
near-relation, and the aiming lemma for the exactness thread. Cost unknown (√-bound
arithmetic through `nlinarith`); the domain pass decides whether the statement earns
its place or stays a tools-side table entry.

## 3. Module and shape decisions

### 3.1 Domain-modeling pass (2026-08-08)

* **The mirror is ratio conjugation.** `reflAxis p q z = p + (q−p)·conj((z−p)/(q−p))`
  — M21's obligation-pass identity (`reflAcross_ratio`: the mirror conjugates the
  axis ratio) elevated to the definition. The skeleton's first draft normalized by
  `(q−p)²/normSq(q−p)`; the ratio form is the intrinsic statement and the division
  appears once. Alternative weighed: keep the M21 shape with an explicit normalizer —
  rejected; the normalizer WAS the incidental structure the unit premise had hidden.
  Confidence high.
* **`gluePoint` is division-once, components division-free.** In the frame
  `v = (x−p)·conj(q−p)` the two pinned norms fix `v.re = A = (d² + r₁² − r₂²)/2` and
  `v.im² = r₁²d² − A²` with NO denominators (the first draft divided both components
  by `d²` — x-frame thinking); the one division is the frame inverse `/conj(q−p)`,
  legitimate because `(q−p)·conj(q−p) = d²`. The √ argument is named: the **gluing
  discriminant**, the exact object the partner construction adjoins. Confidence high.
* **Hypotheses minimized to the three that bind.** Radius nonnegativity is derivable
  from the annulus pair (`|r₁−r₂| ≤ d ≤ r₁+r₂` forces both ≥ 0); dropped from the
  classification. `p ≠ q` stays (excludes concentric-equal, where the intersection is
  a full circle). The degenerate seams VALIDATE rather than break: tangency collapses
  the pair to a singleton, zero radius collapses both points onto the centre — no
  special cases anywhere. Confidence high.
* **The near-cycle candidate is KEPT, in `Glue.lean`, as two lemmas.** The chord
  bound reduces through `|ζ₆σ⁹| = 1` to `re(ζ₆σ⁹) > 1 − 1/5000` — rational bounds on
  √3, √11 (exact: `re = 68√3·(1/2)/243 + …`, numerically 0.99984); the nonvanishing
  reduces through sixth powers to `σ⁵⁴ ≠ 1` = M19's `seam_pow_ne_one 54`. Housed in
  Glue (leaf module) not TwoCircle (settled; adding declarations there rebuilds five
  downstream modules). Alternative weighed: tools-side table only — rejected; the
  l = 9 relation is the exactness thread's aiming lemma and costs two short proofs.
  Confidence medium-high — if the √-bound arithmetic through nlinarith exceeds ~40
  lines the obligation pass may re-route through `Real.sqrt` interval lemmas.
* **Hand-computation hazard, recorded for the obligation pass**: deriving σ⁹'s
  components by hand produced one sign error caught only by the per-power invariant
  `normSq(σ^k) = 1`. The obligation design must carry that invariant as a checked
  stepping stone (`normSq σ³ = 1`, `normSq σ⁶ = 1`, …), not trust component algebra.
* **Mathlib grep**: no two-circle classification with explicit intersection points
  exists (Euclidean sphere library has tangency, line-sphere `SecondInter`, power of
  a point); the statement is ours. `exact?` re-checks per obligation at
  implementation.
* Skeleton after the pass: 15 obligations (reflection package 7, classification 3,
  spec examples 3, near-cycle 2); elaborates clean.

## 4. Instrument promotion

At implementation, the scratch instruments consolidate into `tools/couple.py` as new
subcommands (the M21 promotion precedent): `--near` (the spectrum, canonical +
closure), `--partner` (closure generations with collision census, float-triage +
exact-on-demand per C2's registered decision), `--kills` (the census: fresh frame,
relaxations, cores). Self-tests to carry: the planted glue-point control, the CF
record-l control (a planted rational angle must close exactly), the partner
off-circle assert, the kill-corpus digest check, the free-relaxation SAT control.

## 5. Scope and standing

* In scope: `Glue.lean` burned down; instrument promotion; the kill-mechanism census
  as the named gadget-design input; the near-cycle lemma IF the domain pass keeps it.
* Out of scope: the triangle/metapivot system (M23 — horizon preserved below);
  kernel certification of kills (deferred until a claim needs one); closure
  generations ≥ 3 (measured pointless at the pair: the fork does not move).
* Standing: writeups/upstreaming deferred (2026-08-04); `lean4checker` a publication
  gate; builds via `scripts/build.sh` only; segfault ⇒ halt and report; one heavy job
  at a time; killed patterns become claims only through the kernel route.
* Gate additions at close: `#print axioms` rows for every public `Glue` declaration;
  the new subcommands' self-tests wired into `scripts/regen-check.sh`; the
  negative-control sweep on every new check.

---

# Preserved M23+ horizon (from the M21-close stub, verbatim claims)

## The pivot triangle (Kooshi, 2026-08-08)

Three pivots pairwise at distance 1 — a unit triangle of systems. It adds exactly what
the pair lacks: (a) *cyclic* constraint flow A→B→C→A; (b) placed at 0, 1, ζ₆ the three
coupling directions are 1, ζ₆, ζ₃ — hex-commensurate, so exact closed loops exist that
the pair's incommensurability forbade; (c) the circumcentre sits at distance 1/√3 from
all three pivots — ON all three inner circles, the first triple glue point, and by
M18's identity the pivots are a rainbow unit triangle in its 1/3-class — a self-seeding
fourth system; (d) the configuration's symmetry is dihedral (rot3 about the centroid +
reflections). `Coupled.lean` transfers wholesale; `Glue.lean` (this milestone) supplies
the axis-1/√3 intersections the metapivot needs.

The full object is an **8-circle, 4-centre system** — the triangle's six circles plus
the centroid-metapivot's two, both already threading named points: its inner circle
passes through the three pivots (M18 identity), its outer circle through the six
120°-partners `rot3^±1 · c` about each pivot (the 120° chord of a 1/√3-circle is
exactly 1). The pivot/metapivot relation is a duality — the metapivot of
{c, rot3 p c, rot3² p c} is p itself — so the cascade is closed along same-circle
triangles and generates new pivots only through cross-system unit triangles. The
centroid is the hunt's first simultaneous centre-and-point.

Recursive: three 8-circle systems on a unit metapivot triangle + the new centroid = 26
circles generically (8·3 + 2), but the six metapivot circles + the new two form
ANOTHER 8-circle system — a three-layer role-overlapping incidence structure
(9 + 3 + 1 centres), duality running through every rung. Each pivot triangle carries a
free rotational phase about its metapivot: the recursion is a 3-moduli family, and
tuning a phase until a cross-copy pair lands exactly unit apart is the spindle move
(`construct.spindle`, field criterion in `field.py`) — a structured witness factory,
same two radii at every level (unit-distance rigidity densifies, never shrinks).
