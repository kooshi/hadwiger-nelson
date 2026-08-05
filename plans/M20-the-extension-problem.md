# M20 — The extension problem

*Subplanned 2026-08-04, from the stub written at M19's close. §0 ran first (measure before
specifying); its results reshaped the milestone: the extension profile instrument landed
and read zero pressure, the strip's colouring space turned out exactly classifiable, and a
reviewer instance's construction (relayed by Kooshi) upgraded the local barrier to a
chromatic-number cap. M20's Lean centre of gravity moved accordingly: from "watch the
gradient" to "prove the sharpened barrier and the automaton that computes against it."*

## 1. The question, and how §0 sharpened it

M19's two-circle theorem: the induced unit-distance graph on a 120°-pivot's cover set
`S = N(p) ∪ C` is always 3-colourable. So `minCov(p) = 4` can only be an **extension
obstruction** — ambient structure killing every extendable 3-pattern. M20 §0 built the
instrument that watches this at the finest grain and measured where the pressure stands.

The §0 discoveries (details in §2) sharpen the question twice:

* **The strip automaton** classifies the two-circle colouring space exactly: within one
  pivot's circles, *every* proper colouring of a ≥2-column window extends to the whole
  strip — the only finite obstruction is a lone monochromatic parity-triple.
* **The one-pivot cap**: {p} ∪ (both circles) is **exactly 4-chromatic** — the centre plus
  a hexagon plus a triangle already force a 4th colour (10 points), and 4 always suffice.
  So coverage 4 at five colours (χ({p} ∪ S) ≥ 5 locally) is *impossible within one
  pivot's system*. The 5th colour requires **multi-pivot structure**.

The reframed question M20 hands to M21+: how do *coupled* circle systems (two pivots'
strips joined by ambient unit chords) climb past the one-pivot cap — and can the automaton
calculus be extended to compute their joint colouring spaces?

## 2. §0 — the measurements (all landed 2026-08-04 unless marked pending)

### 2.0 Pre-registration and verdicts

Predictions P1–P5b were registered before any run (scratchpad `m20-predictions.md`;
reconstructed verbatim after the /tmp wipe — see §2.7).

| # | Prediction | Verdict |
|---|---|---|
| P1 | pattern count at 630 in 10²–10⁴ | **CONFIRMED**: 6,144 |
| P2 | ≥ 90% of patterns extend (E0) | **CONFIRMED beyond its bound: 6,144/6,144 — the profile is FULL** |
| P3 | each gadget kills < 10%, likely zero | <SLOT: battery> |
| P4 | strip space exponential; no clean structure theorem | **SPLIT**: growth exponential and *exact* (×12/column); "no structure theorem" refuted in the best direction (§2.4) |
| P5 | clamps small (≤ 6), few multi-component, none majority | <SLOT: census> |
| P5b | gadget-added vertices have \|N(v) ∩ S₀\| ≤ 3 | <SLOT: census> |

### 2.1 The instrument: the extension profile

For pivot p: enumerate every proper ≤3-colour pattern on `G[S]` (canonical up to colour
permutation, first-occurrence numbering; backtracking with a mandatory count cap), then
one SAT call per pattern — `base_clauses(n, E, 5)` plus one unit clause per S-member.
Colour symmetry makes the single pinned representative exact. Every reading is a SAT
verdict: bias-free by construction (the M19 §0(b) lesson built in from birth).
`minCov = 4 ⟺ empty profile`; a gadget's worth = patterns killed; the profile is exactly
the cube split a future kernel certification needs (one UNSAT certificate per pattern).

**Controls, both watched firing:**
* *Negative (harness)*: a deliberately improper pattern (equal colours across an in-S
  edge) refused unsat through the full pipeline.
* *Positive (can it see a kill)*: the known CONFINED pivot — de Grey's 397-point
  configuration, r²=4 class at the origin, k=4 (M14/M17: minCov = 4, kernel-certifiable) —
  sampled 1,000 canonical patterns: **1,000/1,000 killed**. The instrument demonstrably
  reports an empty profile where confinement is certified.

### 2.2 Baseline profile at pivot 630 (E0, the Z3 closure)

`|N(p)| = 12, |C| = 9, |S| = 21`; `G[S]`: 27 edges, components [18, 3]; 6,144
locally-legal patterns. **All 6,144 extend** (1 pool-premarked + 6,143 SAT calls, 147 s
at 28 workers on the desktop). **Extension pressure in the plain closure is exactly
zero** — minCov = 3 was not merely achievable; every single locally-legal 3-pattern is
ambient-realizable. Artifact: `build/m20-profile-630.json`.

Strip-cell layout of S (numeric label BFS, tolerance 1e-9, non-tree edges consistent):
one tube window spanning 5 columns — outer half-hex {1,3,5} at j=−3, inner triangle
{1,3,5} at j=−2, **full outer hexagon at j=−1**, inner triangle {0,2,4} at j=0, outer
half-hex {0,2,4} at j=+1 — plus a lone inner triangle (component 2, orbit relation to
component 1 numerically undecidable: the seam orbit is dense). Note: the full hexagon at
j=−1 with the adjacent triangle at j=0 is exactly the 10-point forcing configuration of
§2.5 — **the forcing pattern is present at the doubling pivot.**

### 2.3 The E-battery, re-scored by pattern-killing

Same gadgets as M19 §0(d) (E1: 2nd ℤ/3 closure at q_n=726; E1′: at q_c=648; E2:
spindle-double at 630, r²=1), now scored by profile shrinkage on E0's 6,144 patterns
(relocated by exact rational coordinates; `G[S]` verified unchanged under each gadget —
supergraphs only kill, never legalize).

<SLOT: battery table + verdict>

### 2.4 The strip automaton — the two-circle colouring space, exactly

The strip Σ (one ⟨zeta6, seam⟩-orbit): cells {out, in} × ℤ/6 × ℤ; edges out(i,j)–out(i±1,j),
in(i,j)–in(i±2,j), out(i,j)–in(i,j±1). Computed exactly (transfer matrix, pure python,
integer arithmetic; scratchpad `striptransfer.py`):

* **Tube decomposition**: χ(cell) = (j + [cell is inner]) mod 2 is invariant under all
  three edge rules, so **Σ is disconnected: two isomorphic "tubes"**, each an alternating
  chain of hexagon columns and triangle-pair columns with pointwise-disequality coupling.
  (A refinement of the reviewer instance's structure-theorem reading: their single
  4-regular graph splits.)
* **States**: 66 proper hexagon colourings × 36 rainbow pairs = 2,376; transfer edges
  9,216 of 5.6M (0.16%).
* **Recurrent core** = exactly (24 hexes with *neither parity-triple monochromatic*) ×
  (all 36 rainbow pairs) = 864 states, **a single SCC** (verified as a set equality
  against the trimmed fixpoint, plus iterative Tarjan).
* **Purification**: any proper hexagon colouring avoiding *any* rainbow pair is
  automatically non-mono; a mono-parity hexagon avoids *no* rainbow pair (0 of 42).
* **4-avoidance**: every non-mono hexagon admits exactly 4 avoiding rainbow pairs.
* **Exact ×12 growth**: window counts 2,376, 9,216, then ×12 per column forever (checked
  to L=25). Mechanism verified as a uniform identity: each non-mono hexagon's 4 avoiding
  rainbow pairs have hexagon-continuation counts splitting exactly {2,2,4,4} — constant
  two-step row sum 12. Entropy log₂12 ≈ 3.585 bits/column.
* **96 j-independent states** (self-loops) = 24 non-mono hexes × their 4 rainbow pairs;
  the M19 table pair is one, confirmed a fixed point.
* **Window extension theorem** (the three lemmas machine-checked over the full finite
  space): every proper colouring of a ≥2-column window extends to the whole bi-infinite
  strip; the *only* finite obstruction is a single mono-parity hexagon column standing
  alone. Scattered (non-full-column) patterns can obstruct — see §2.5 — so the honest
  statement is per-window, not per-induced-subgraph.

### 2.5 The compulsion theorem and the one-pivot cap (with the reviewer instance)

Found here in §0 and independently — in composed form — by a reviewer instance whose
note Kooshi relayed; both ride the same mechanism, and the review's construction is
hereby folded in with its boundary corrected (§2.6).

* **The 120°-compulsion theorem** (new; the first *independent-set* colour compulsion in
  this project): in every proper 3-colouring of the two circles, no outer 120°-triple
  {z, rot3 z, rot3² z} is monochromatic — although its three points are pairwise
  non-adjacent (chord √3). Witness: the seam-image triple y_t = p + σ·ω^t·(z−p) with
  **σ = seam/√3 = ⟨1/6, √11/6⟩** lies on the inner circle, is the rot3-orbit of y₀ —
  hence a *unit triangle* (M18 `rot3_unit_triangle`), hence rainbow — and each y_t is
  unit-adjacent to its outer partner (‖1−σ‖ = 1, exact). Mono triple colour a ⇒ all
  three y_t ≠ a ⇒ the rainbow triangle misses a. Contradiction, five lines.
  Geometry verified numerically to 1e-12 before statement.
* **The 10-point forcing configuration**: {p} ∪ (one full outer hexagon) ∪ (its adjacent
  inner triangle) is 4-chromatic. p eats one colour; the hexagon, 2-coloured, alternates;
  its even triple goes monochromatic; the compulsion kills it. (The reviewer's 16-vertex
  two-hexagon version verified by hand first — both hexagons disjoint by seam-infinite-
  order, no unlisted unit pairs — then compressed: one hexagon suffices once the
  compulsion is a lemma.)
* **The one-pivot cap** (the barrier, sharpest form): χ({p} ∪ both circles) = **exactly
  4** — ≥ 4 by the 10-point configuration, ≤ 4 by the two-circle theorem plus a fresh
  colour at p. Corollary: coverage 4 at k=5 cannot arise within one pivot's system;
  extension pressure requires multi-pivot coupling. This *theorem* explains every flat
  histogram M17–M19 measured.

### 2.6 Corrections and honest boundaries

* **The M19 barrier docstring is understated and gets corrected in this milestone**: it
  says a 4th colour must be forced "from outside the two circles"; in truth {p} ∪ circles
  force it alone (p was never "outside"). The correct boundary: at k = 5, a *5th* colour
  on {p} ∪ S needs structure beyond one pivot's system.
* The reviewer's "minCov measured the wrong quantity" clause is **not** adopted: minCov
  was measured at k = 5, where a 4-chromatic local configuration is invisible by design;
  local χ = 4 and coverage-at-5 = 3 are consistent, and both are true at pivot 630.
* Priority: a web search found no named two-circle result; nearest literature is the
  single-circle / circulant colouring theory the reviewer cited. "Novel vs
  folklore-never-written" stays undecided; the deep literature pass is a
  publication-gate task (standing deferral policy), recorded here so it is not lost.

### 2.7 Incidents (both mechanisms named, both fixed)

* **The desktop OOM** was the profile instrument's own pattern enumeration: the known-hit
  control's G[S] is 36 edges on 36 vertices, so the *uncapped* backtracking enumeration
  is 3^|S|-scale and materialized ~79 GB before dying (reproduced deliberately after the
  reboot, watched at 78.8 GB, killed). Fix: the count cap is mandatory in the promoted
  instrument — no call path may bypass it; the confined-pivot control samples (1,000
  patterns) instead of enumerating. The three-job stacking was real indiscipline but not
  the killer.
* **Python 3.14 forkserver**: pool workers re-import modules, so a mutated module global
  (k = 4 for the control) never reaches them — pins landed at the wrong variable stride
  and the model-verification assert killed the pool (loudly, as designed). Fix: k travels
  through the pool initializer explicitly. Corollary recorded: worker scripts must be
  real files (forkserver cannot re-import a stdin heredoc).

## 3. Lean deliverables

Centre of gravity: the sharpened barrier and the automaton, as kernel-checked theorems.

### 3.1 `Proofs/HadwigerNelson/Compulsion.lean` — the compulsion and the cap

* `sigma : ℂ := ⟨1/6, √11/6⟩` with `normSq_sigma = 1/3`, `normSq_one_sub_sigma = 1`;
  spec example `sigma * √3 = seam` (ties to M19; needs `√3·√11 = √33`).
* `no_mono_outer_triple` — the compulsion: for any 3-colouring of the induced two-circle
  graph and outer z, ¬(C z = C (rot3 p z) ∧ C z = C (rot3 p (rot3 p z))). Proof: seam
  image + `rot3_unit_triangle` + Fin-3 pigeonhole (`decide`).
* `concentric_not_colorable_three` : ¬ Colorable 3 of the induced graph on
  `insert p (sphere p 1 ∪ sphere p (√3/3))` — p pigeonholes the outer circle to 2
  colours, the hexagon chain forces the even triple mono (Fin-3 `decide` steps), the
  compulsion closes. Uses the 60°-chord fact (`‖zeta6 − 1‖ = 1`, already a M19 example).
* `concentric_colorable_four` : Colorable 4 of the same graph — M19's colouring plus a
  fresh colour at p (Fin 3 ↪ Fin 4 plumbing).
* Together stated as the cap (χ = 4 exactly); `chromaticNumber` equality if cheap.
* The finite 10-point witness with explicit field coordinates: **deferred** — same
  content, adds field plumbing only; noted for the eventual write-up.

### 3.2 `Proofs/HadwigerNelson/Strip.lean` — the automaton, finite part decidable

* Column representation: **measured, decided** (desktop, `lake env lean`, min of the
  runs that mattered): a pair-quantified decide over packed `Fin 729` costs **5m30s**
  (unaffordable as a pattern; the Pi-type encoding was not even run); the same content
  as a **single quantifier against a literal table** — the M04 `PtTable` pattern —
  costs **2.5 s** including the table-completeness bridge
  (`(List.range 729).filter rainbowB = rainTable` by `decide +kernel`, one linear
  pass). Rule adopted: *no decide in this module ever runs a pair quantifier*; the
  second side is always a literal table (66 hexes / 36 rainbows), each table verified
  complete by its filter bridge. Packed Nat digits (`n / 3^i % 3`), Bool predicates,
  Prop bridges via `List.all_eq_true` exactly as in M19's `DeGreyBalanced`.
* Definitions: `ProperHex`, `Rainbow`, `Avoids`, `NonMono` (+ Bool mirrors if packed).
* Finite theorems (decide, cost-measured): `purification` (avoiding any rainbow ⇒
  non-mono), `mono_blocks` (mono hexagon avoids no rainbow pair), `avoid_card` (= 4),
  `rainbow_extends` (∃ proper hexagon avoiding any rainbow pair), `twostep_card`
  (= 12; may be restated or parked if the count blows the kernel budget — the
  qualitative package does not depend on it).
* `TubeProper (f : ℤ → Col6)` and the **window-extension theorem**: any proper window
  (length ≥ 2, both parities of anchoring) extends to a full tube colouring — the
  module's one structural induction (two-sided ℕ-recursion with chosen continuations).
* Everything computable where possible (`#eval` gates; the reviewer's computability
  note adopted for the abstract layer).
* The geometric bridge (orbit ↔ strip isomorphism) is **not** in scope: the compulsion
  theorem carries the geometric content M20 needs; the full isomorphism waits for a
  milestone that needs it.

### 3.3 `Proofs/HadwigerNelson/TwoCircle.lean` — the docstring correction

Module doc + barrier docstring rewritten per §2.6 (a doc edit re-elaborates dependents;
TwoCircle's dependents are checked before editing — expected none). Add the reviewer's
companion negative control: perturbing `outerTable` to the alternating `[0,1,0,1,0,1]`
must fail `outerTable_ne_innerTable` — pinning that three outer colours are *forced*,
not chosen.

## 4. Instrument promotion

`tools/extend.py` from scratchpad `extendprofile.py`: profile + battery modes, mandatory
enumeration cap (refusal by name — the OOM lesson as API), k through the pool
initializer, gadget-graph dumps for downstream analysis, pool premarking with graph-
identity verification, both controls in `--self-test` (synthetic kill: two pinned
vertices + an ambient K2 at k=3; synthetic full profile; improper-pattern refusal; the
sampled confined-pivot control stays a separate documented invocation — it needs the
397-point build). Wire into `scripts/regen-check.sh`. Clamp census (`--clamps`) folded
in reading the gadget dumps. `striptransfer.py` and `labelmap.py` stay scratchpad-side;
their results are §2.4/§2.2 and the Lean module supersedes the former.

## 5. Scope and standing decisions

* Writeups/upstreaming deferred (standing, Kooshi 2026-08-04); priority literature pass
  deferred to the publication gate (§2.6).
* General-radius two-circle theorem: still deferred until needed.
* Kernel route unchanged: a minCov = 4 reading becomes a claim only via `Fan.of_unsat`;
  the profile is the cube split for it.
* Rotation policy unchanged: if profiles stay flat across families, the designated shift
  is the certified-6-colouring angle. §0's zero-pressure baseline is one data point of
  "flat", not yet the trigger — M20's cap theorem *explains* the flatness and names
  where pressure must come from (multi-pivot), which is a live thread, not a dead one.
* M21 candidate (to be stubbed at close): **coupled circle systems** — two pivots'
  strips joined by ambient chords; extend the automaton calculus to the coupled space;
  hunt the 5-chromatic local configuration the cap theorem proves must span ≥ 2 pivots.

## 6. Gate additions for this milestone

* Compulsion/Strip/TwoCircle changes: `#print axioms` entries in `scripts/Axioms.lean`
  (target: the standard three, zero purchases).
* `extend.py --self-test` in regen-check, FAIL-wired.
* Negative controls: the `outerTable` alternating mutation (§3.3); the strip lemmas'
  mutation probes (a mono hexagon claimed extendable must be refused by `decide`).
* Spec examples: `#eval` on the packed/functional column encodings agreeing; the σ–seam
  tie; the 60°-chord and cap-construction distance facts as `example`s.
