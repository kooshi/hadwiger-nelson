# FS-62 — six is not a value: does the function F ↦ χ(F²) omit six?

> **Re-aimed at FS-103's close (2026-09-26; `plans/FS103-derivation.md` FS103-S).** S's exact form, given MR, two minds: S_nf ⟹ `χ(ℝ²) ≠ 6`;
> over totally real fields S_nf ⟺ `χ_CP(ℝ²) = 5`, or `χ_CP(ℝ²) = 7` and no field with a non-6-thick stable place has `χ(F²) = 6`. R1's "a finite
> family of CP product statements" is **MISSTATED**: the non-6-thick places have finitely many residue sizes (odd `q` below 101 of the window and
> its neighbours; dyadic `U_Q` of small norm) but infinitely many local planes (`[F_v : ℚ_p]` unbounded). Over every subfield of ℝ, S needs
> Q-const (G63); over every real number field, the complex-place case is one mind (V2).

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 37 → 4 in `plans/FRONTIER-STUBS.md`.** **Re-aimed (the advisor's order, above FS-59):** S's exact form given MR — the adelic local–global principle folded here (R1 §2.2: given MR, `χ(F²) = min(χ_CP(ℝ²), local CP numbers)` iff product locality at every `k`); if FS-103's F1 (a candidate composition, not a result: given MR, row 120, and T-J39-3, at a real field with no non-thick stable place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`) holds, S ⟹ `χ(ℝ²) ≠ 6`, and S ⟺ `χ_CP(ℝ²) = 5`, or `χ_CP(ℝ²) = 7` and no field with a non-6-thick place drops to six (a finite family of CP product statements; the advisor's formulation). §5's gate, the image of `F ↦ χ(F²)`, is an hour and unrun. **derived frame; soft as to truth** — Kooshi on this stub: *"It's just one possibility with some soft evidence"*. Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR).

> **CORRECTED AND DEMOTED 2026-09-19 — a frame, not a theorem target.** As minted, this stub's headline was an equivalence:
> *no subfield of ℝ has χ(F²) = 6* ⟺ *χ(ℝ²) ∈ {5, 7}*, "Hadwiger–Nelson reduced from three values to two", with the wall at six as
> its finite half. **Only one direction holds.** The strong statement implies the weak one trivially (ℝ is a subfield); nothing
> gives the converse, and both lines of the original proof established the same implication. §1–§4 below are rewritten to the
> corrected statements; §2a (why the wall exists) and §5 (prior art owed) stand as written, read as being about the *wall*, which is
> a statement about fields and about the value set of `L` — not about the plane. What this cost: FS-57 and FS-65 were re-ranked as
> "half of" a two-value Hadwiger–Nelson on 2026-09-17/18, and two days of compute at `q = 19` ran under that banner; their results
> are sound and their stated bearing is withdrawn (`plans/FRONTIER-STUBS.md`). FS-53's plan had the careful version on 2026-09-15
> (`plans/STUB-sixth-colour.md` §0.4: *"the first draft said χ(ℝ²) ∈ {5, 7}, which the weak conjecture does not give"*); this stub
> regressed from it two days later.

*Minted 2026-09-17, out of a conversation with Kooshi on where a six-chromatic structure could still hide once no real quadratic
field turns out to need six. Read beside: `CLAUDE.md` G64 (the statement), G56 and G59 (the wall), G48 (the conjecture), G55 (the
chain theorem), `plans/STUB-plane-bridge.md` (FS-39), `plans/STUB-unit-vector-ring-kernel.md` (FS-47),
`plans/STUB-fractional-wall.md` (FS-57).*

---

**Kooshi's target (2026-09-26, consolidation job C3b; `CLAUDE.md` § The mission):** *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be fascinating) and potentially answer the HN problem definitively."* `CLAUDE.md` reads the parenthesis as G64's S — this stub's strong statement, *no subfield `F ⊆ ℝ` has χ(F²) = 6* (a reading C3a held for the owner). Since row 123 (`χ(F²) ≥ min(L(F), 5)`, [hand], through MR) the gap in which six can hide is at `L(F) ≥ 6`, where `χ(F²) ≥ 5`; at ℚ(√167) six contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125). Whether this frame becomes a target again, and its rank (37), are Kooshi's call; the demotion's correction (S ⟹ W only) stands.

## 1. The question, and what it is not

Every time this project pins the chromatic number of a plane over a coefficient structure it gets **2, 3, 4, 5 or 7**. It has never
once got 6, and by FS-53/FS-54/FS-56 the residue method can produce a 6 only through one of six undecided finite graphs: the local
bound `L(F)` is six only if a window plane is exactly six-chromatic, and none has been found to be.

The observation is about the **value set of the function `F ↦ χ(F²)`**. It is tempting to read it as a statement about the plane.
It is not one, and the two must be kept apart.

> **S (strong — value omission).** No subfield `F ⊆ ℝ` has `χ(F²) = 6`.
> **W (weak — the plane).** `χ(ℝ²) ∈ {5, 7}`.

* **S ⟹ W, trivially**: ℝ is a subfield of ℝ. Restricted to *number* fields, S ⟹ W is FS-39's bridge: if `χ(ℝ²) = 6`, de
  Bruijn–Erdős gives a finite 6-chromatic unit-distance graph, its coordinates generate a number field `F`, and
  `6 ≤ χ(F²) ≤ χ(ℝ²) = 6`.
* **W ⟹ S is unproved, and nothing motivates it.** If the plane needs seven, a smaller field may perfectly well need exactly six;
  `χ` is monotone up the tower of fields but its steps are irregular — one quadratic extension takes ℚ to ℚ(√11), 2 to 4.
* **The exact form of W, given the bridge:**

  > **`χ(ℝ²) ≠ 6` ⟺ every real number field `F` with `χ(F²) = 6` has a finite real extension `F′` with `χ(F′²) = 7`.**

  *Proof.* (⟸) If `χ(ℝ²) = 6`, the bridge gives a number field `F` with `χ(F²) = 6`, and every real `F′ ⊇ F` has
  `6 ≤ χ(F′²) ≤ χ(ℝ²) = 6`. (⟹) If `χ(ℝ²) ≠ 6` and some `χ(F²) = 6`, then `χ(ℝ²) = 7`, the bridge gives a number field `E` with
  `χ(E²) = 7`, and the compositum `F′ = FE ⊆ ℝ` is finite over `F` with `χ(F′²) = 7`. ∎

  Six is never where the climb *stops*. This restates Hadwiger–Nelson at the top rung; it is not a reduction of it.

**Note what the claim is NOT.** Six-chromatic unit-distance *graphs* certainly exist if `χ(ℝ²) = 7`, by taking vertex-critical
subgraphs. S says that the **function `F ↦ χ(F²)` omits the value 6** — stranger than "no six-chromatic graph exists", and,
per the above, *stronger* than `χ(ℝ²) ≠ 6`, not a form of it.

---

## 2. How S factors (and why none of this is about W)

**(a) `χ(F²) ≤ L(F)` is a theorem** (ledger row 52; the field-level step is row 57's hand gap, which FS-47 closes). So **every field
with a usable small prime is already excluded as a home for six** — no search needed, no conjecture needed. If `L(F) ≤ 5` then
`χ(F²) ≤ 5`.

**(b) The wall at six says `L(F)` is never 6** (G56, G59). Finite: six graphs remain — `q ∈ {23, 27, 31, 43, 47}` and `U₆₄` — with
floors 6, 6, 5, 6, 6, 6 and no six-colouring found at any of them. **This is a finite computation**, and FS-57 prices the two
members within reach (47 and `U₆₄`).

**(c) What is left of S is a gap theorem, in the field itself:**

> **`χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7`.**

Combining (a) with (b): **a field with `χ(F²) = 6` has `L(F) ≥ 6`, and `L(F) = 6` needs one of six named finite graphs to be
six-chromatic.** If the wall holds, the only fields that could be six-chromatic are those with `L(F) ≥ 7` — exactly the fields the
conjecture's bold form predicts to be 7. Under the bold form S *is* the wall; under the main clause alone, a six-chromatic window
plane *is* a six-chromatic field (`ℚ(√2351)` if it is 47's), and S fails while W is untouched.

**The engine for (c) is G55's chain theorem one rung up.** A pair forced equal at `k` colours at difference `δ` makes every
`k`-colouring `δR`-periodic, and `1/δ ∈ R = ℤ[U]` gives `χ(F²) > k` with an explicit witness *in `F`*. So the strong gap theorem
would follow from: *every 6-chromatic field graph carries a 6-colour forced pair at a `δ` with `1/δ ∈ ℤ[U]`*.

**W needs only the weak gap — and there the arithmetic hypothesis vanishes.** For `χ(ℝ²) ≠ 6` it suffices that some finite
*extension* reaches 7, and the spindle (ledger row 44: a forced-equal pair at any `d ≥ 1/2` refutes `k`-colourability, in
`F(√(4d² − 1))`) asks nothing of `δ`. `1/δ ∈ ℤ[U]` is the price of staying in the field, which only S pays. Either way the missing
ingredient is the same — a six-colour forced pair in a six-chromatic field's fabric — and that is this repository's own open
structural question (`CLAUDE.md` § The open structural question — "is a pigeonhole necessary?") asked at six instead of five; the
only necessity theorem we hold (A1) is vacuous at the top rung.

**And the wall is no part of W.** `χ(ℝ²)` is a supremum, and fields with `L ≥ 7` exist (`K(√7)`, de Grey's); whether some *other*
field has `L = 6` cannot move it. FS-57's stub said so the day before this one was minted: the wall *"neither proves nor refutes
χ(ℝ²) ≥ 6"*.

**The split, stated once** (2026-09-20, out of a conversation with Kooshi, who asked why finishing the enumeration of the six
finite planes would not narrow Hadwiger–Nelson). Sort the fields by local bound; S is three statements:

| fields with | six is excluded by | status |
|---|---|---|
| `L(F) ≤ 5` | `χ ≤ L` — (a) | theorem (row 57's hand step aside) |
| `L(F) = 6` | the wall: no such field exists — (b) | **finite**: six graphs, none decided, four beyond any priced instrument |
| `L(F) ≥ 7` | nothing we hold; needs (c) on these fields | **open, and infinite**: ℚ(√167) (if the wall holds; proven `5 ≤ χ ≤ 7`, five at [hand] through MR, `LEDGER.md` row 123), `K(√7)` and de Grey's field (`5 ≤ χ ≤ 7`), and every real field containing one of them |

The theorem is one-sided — `χ ≤ L` — so **closing the wall proves "no field has local bound six", never "no field has chromatic
number six"**; the step between them is `χ = L`, which is the conjecture. And **W follows from the third row alone** [derived; rests
on the bridge and on row 68's `L(K(√7)) ≥ 7`]: if `χ(ℝ²) = 6`, the bridge gives a number field `F` with `χ(F²) = 6`; then
`F′ = F·K(√7)` is real, `L(F′) ≥ L(K(√7)) ≥ 7` because `L` is monotone up a tower (a conjugation-fixed prime of `F′(i)` restricts to
one of `F(i)`, and the residue-field inclusion is a homomorphism of the target graphs — a larger field only *loses* usable primes),
and `6 ≤ χ(F′²) ≤ χ(ℝ²) = 6`, a six-chromatic field in the third row. So **the fields with `L ≥ 7` are cofinal, `χ(ℝ²)` is decided
on a cofinal family, and the fields the wall speaks about are exactly the ones that can never decide the plane.** Checked from both
ends: without the conjecture the wall is silent on the third row; with its bold form `χ(K(√7)²) = 7` already gives `χ(ℝ²) = 7` and
the wall is not used; under the main clause alone (`χ = L` where `L ≤ 6`) the third row is unconstrained. There is no intermediate
hypothesis under which the enumeration is the step that narrows Hadwiger–Nelson. What it does buy is listed in §4 and in G64: a
theorem about the residue method (`L` omits six), the conjecture's prediction at ℚ(√167) sharpened from `≥ 6` to `7`, and the aiming
statement.

---

## 2a. Why the wall exists at all, and what that makes of (b)

*Added 2026-09-18, out of a conversation with Kooshi that started on the complex plane and the quaternions. The conclusion is
G59's; this section is about (b), the wall — one theorem plus two small cases rather than six certificates. Read 2026-09-19's
banner first: (b) bears on S and on the value set of `L`, not on `χ(ℝ²)`.*

**Normalize the independence number.** Write `c = α(UD(𝔽_q,2)) / q^{3/2}`. Since these graphs are vertex-transitive,
`χ_f = q²/α` and `χ ≥ ⌈χ_f⌉`, so the colour count is `≈ √q / c`. Six therefore needs `c ≈ √q/6` — **a threshold that grows
with `q`, measured against a constant that looks flat:**

| `q` | best set known | `c` observed | `c` six requires | shortfall |
|---:|---:|---:|---:|---:|
| 7 | 14 | 0.756 | — | — |
| 11 | 28 | 0.767 | — | — |
| 19 | 76 | **0.918** | — | — |
| 23 | 87 | 0.789 | 0.807 | **+2 vertices** |
| 27 | 117 | 0.834 | 0.870 | +5 |
| 31 | 146 | 0.846 | 0.933 | +15 |
| 43 | 258 | **0.915** | 1.096 | +51 |
| 47 | 265 | 0.822 | 1.145 | +104 |

Exact only at 7 and 11; the rest are best-found sets, hence **lower** bounds on the truth. The threshold crosses the observed
maximum 0.92 at `q ≈ 30.5`.

**Five consequences for this stub** (1–3 derived 2026-09-18, 4–5 measured the same day).

1. **Six is not special; the family is discrete and the function climbs.** The colour count grows like `√q`, so each value is
   reachable only in a narrow band of `q`, and six's band falls in the gap between the last comfortably five-chromatic member
   (19) and the first comfortably seven-chromatic one. That is a far weaker and more contingent reason than the norm reading of
   G64 suggests — which matters here, because §4's trap ("six is skipped" is not evidence for seven) gets sharper: **if the
   skipping is an artifact of where the prime powers fall, it carries no information about `χ(ℝ²)` at all.**
2. **(b) is one theorem plus two cases.** A uniform `α ≤ 0.93·q^{3/2}` closes **31, 43 and 47**, leaving 23, 27 and `U₆₄` — the
   last on a different scaling (characteristic 2, measured `c = 1.0`, maximum sets are subspaces). No uniform bound can close 23:
   it needs `c < 0.799` while 19 itself reaches 0.918. So the shape of the finite half changes from "six hard relaxations at
   growing cost" (FS-57's pricing) to "one bound, plus the two members where the search has plateaued 2 and 5 vertices short".
3. **The uniform bound is nearly refuted already, and the falsifiers are cheap.** `0.93·19^{3/2} = 77.0` against a measured
   `α(19) ≥ 76` — a 1.3 % margin. So **an independent set of 78 at `q = 19`, or of 263 at `q = 43`, kills the uniform route to 31**,
   on search instruments that already exist. Run those before pricing any theorem.

4. **But price D5 honestly, because the reframing flatters itself.** A uniform `0.93·q^{3/2}` is not a cheaper route to the
   same place — it is a **stronger statement than any single certificate this project has produced**, asked of every `q` at once.
   Against the exact spectral (ratio) bound it must reach:

   | `q` | ratio bound | `0.93·q^{3/2}` | reach D5 needs | best reach achieved there |
   |---:|---:|---:|---:|---:|
   | 31 | 240.25 | 160.5 | **0.668** | 0.836 (`cert-q31-N200`) |
   | 43 | 395.23 | 262.2 | **0.663** | 0.924 (`cert-q43-N365`) |
   | 47 | 466.39 | 299.6 | **0.642** | 0.797 — *the best measured anywhere* (`cert-q47-N371`) |

   So D5 asks for roughly 19 % beyond the instrument's best single-member result, uniformly. That does not kill it — a theorem
   and a relaxation are different objects, and the literature pass in §5 item 5 may simply hold one — but it means **D5 is a long
   shot to be ranked on its prior-art answer, not an obvious simplification of (b)**. *Recorded because the reframing in this
   section is the author's own and this was the first number checked after writing it (G21: audit what you like at the same rate).*

5. **Do not reach for an exact independent-set solver here; both of them fail, and the reason is structural** [measured
   2026-09-18, `data/fs62/q19/`]. On `q = 19` — 361 vertices, 20-regular, 3,610 edges, 5.6 % density, which *looks* easy —
   KaMIS's branch-and-reduce returned **70** at its time limit without proving optimality, and `struction`, even with its
   degree cap raised to 20 so the reduction could fire at all, returned **66**; the local search finds **76** in seconds.
   **Every reduction rule these solvers own works by finding a vertex that differs from its neighbours, and a vertex-transitive
   graph has no such vertex** — measured directly: branch-and-reduce spent 3 ms on reductions, `struction` 26 ms, both finding
   nothing, then fell through to blind branching. Worse, at `q = 19` the graph is **triangle-free** (3 is a non-residue mod 19,
   G57), so the clique-cover bound that prunes the search tree is at best a matching: `n/2 = 180` against a truth `≤ 80`, off by
   2.3×, and nothing prunes. The symmetry that makes the algebraic instruments work is exactly what defeats the combinatorial
   ones, and the property that decides it — whether 3 is a square mod `q` — is arithmetic. *A symmetry-aware exact method
   (orbital branching, Schreier–Sims cuts in a MIP) is the untried class; the off-the-shelf MIS solvers are closed.*
   **And SAT is now closed too, with the symmetry broken three different ways** [measured 2026-09-19, FS-65 D1]:
   pinning the origin, the centroid equations `Σa·x ≡ Σb·x ≡ 0 (mod q)`, and lex-least over all 360 translations —
   the last two exact, quotienting the full `q²` where the pin is worth only `q²/k = 4.63`. **None of them decides
   `k = 78`, the fastest is the weakest one, and at `q = 19` both exact breaks are slower than leaving the
   symmetry entirely unbroken**: at `q = 19, k = 115` the pin refutes in 97 s against the centroid's 467 s, lex's
   1,110 s and no-break's 408 s, because the pin's unit clauses propagate and modular sums do not.
   The sharp statement of the gap: at `q = 19` the solver refutes `k = 130` in 16 s, `k = 115` in 115 s, and
   **nothing at or below `k = 105` in 900 s** — its frontier sits about thirty above the answer, with a vertical wall between 110 and 105.

**The first experiment, RUN 2026-09-18 — and it neither confirmed nor refuted the reading** (`data/fs62/q19/README.md`): the level-3 relaxation that pinned `α(Γ₇) = 14` and `α(Γ₁₁) = 28` exactly had never been run at 19, and it converges there to **80.59**, so `α(19) ≤ 80` — an improvement on the ratio bound's 99, ~6 % loose against the best known set, and **not the ≤ 77 that would confirm the uniform route**. Alongside it, the local search was asked for 78 for a full hour on 24 threads: **521,874 restarts, never past 76** — a null at a budget, never a refusal (G21). So `c(19) ∈ [0.918, 0.966]` with the deciding 0.933 inside, and the reading survives its cheapest falsifier without being confirmed. **Two by-products worth more than the target:** the relaxation is ~6 % loose at 19, against exact at 7 and 11 and ~20 % at 23, which pins where the instrument stops being exact; and its GPU backend is **3.6× SLOWER** than the CPU one on this instance class (2.75 against 0.77 s/iteration), the reverse of the FS-50 certificate at `q = 83` — a number that does not travel across instance shapes.

**Prior-art question this opens, owed under §5:** independence numbers of Cayley graphs on `𝔽_{q²}` whose connection set is the
norm-one subgroup `μ_{q+1}` — equivalently, the largest set whose difference set misses a prescribed multiplicative coset. That
is a well-posed question in the character-sum and finite-geometry literature and is *not* the same search as "finite Euclidean
graph chromatic number", which is what has been searched so far.

---

## 3. Deliverables, cheapest first

| # | deliverable | cost | what it needs |
|---|---|---|---|
| D1 | **The exact equivalence in the kernel** — `χ(ℝ²) ≠ 6` ⟺ every six-chromatic number field has a seven-chromatic finite extension; and S ⟹ W for number fields | hours, **on top of FS-39**, where it belongs as a corollary | the bridge and de Bruijn–Erdős compactness; check Mathlib for the latter |
| D2 | **The aiming corollary** — a six-chromatic field has `L(F) ≥ 6`; with the wall, `L(F) ≥ 7` | hours, once the wall is closed | **FS-47** (row 57's step at field level) |
| ~~D3~~ | ~~The conditional theorem — *assuming the local–global conjecture and the wall, `χ(ℝ²) ≠ 6`*~~ **Withdrawn 2026-09-19: not a theorem target.** Under the conjecture's bold form `χ(K(√7)²) = 7`, so `χ(ℝ²) = 7` with no wall; under the main clause alone, fields with `L ≥ 7` are unconstrained and the conclusion does not follow even with the wall. What the conjecture plus the wall *does* give is S for fields with `L ≤ 6` — G59's `χ(F²) ∈ {2, 3, 4, 5, 7}` under the bold form — which is a statement about the fields and is already recorded | — | — |
| D4 | **The gap theorem**, strong or weak, or a sharply stated obstruction to it | open | a necessity theorem for compulsions at the top rung |
| D5 | **The uniform independence bound** — `α(UD(𝔽_q,2)) ≤ 0.93·q^{3/2}` for odd `q ≥ 23`, or its counterexample. Closes **31, 43 and 47 in one theorem**, cutting the wall from six members to two. **A wall result, not a plane result** | unknown, and **harder than "one theorem instead of three relaxations" suggests** — §2a(4) prices it; both routes to its killing test at 19 are characterised and closed (FS-65) | §2a above; a literature pass on independence numbers of subgroup-Cayley graphs over `𝔽_{q²}` |

**There is no cheap theorem here.** D1 is a corollary of another stub, D3 is withdrawn, D4 is the open problem, D5 is a long shot
about the wall. What the frame is good for: keeping S and W apart, and §5's gate — *has anyone asked for the image of `F ↦ χ(F²)`?*

---

## 4. Expectations, and the clauses that matter

* **The wall closes at 47 and `U₆₄` and nowhere else by any priced instrument** (medium-high; FS-57's own estimate). Then S
  stays conditional on four undecided planes as well as on the conjecture, which is worth stating as such.
* **The gap theorem resists** (high). Nobody has a 6-colour forced pair over any field, and G31 says every compulsion sweep this
  project has run returned zero at the top rung.
* **Informative failure — the one that would make this stub a finding rather than a frame:** a six-colouring of any window member.
  That gives a field with `L(F) = 6`, and under the conjecture a field with `χ(F²) = 6`, which kills S outright (and says nothing
  about W), and hands the project the first exactly six-chromatic finite Euclidean plane. FS-53 and FS-57 are already pointed there.
* **The trap to name in advance:** "six is skipped" is **not** evidence that the answer is seven. It is equally consistent with every
  field being `≤ 5` and `χ(ℝ²) = 5`. Any write-up that lets the skipping imply seven without invoking the conjecture's bold form at
  `K(√7)` (G48) is overclaiming — **and a second trap, sprung once already (the banner): S is not W.** A sentence that moves from
  "no field is six-chromatic" to "the plane is five or seven" is fine; one that moves back is not.

---

## 5. Prior art owed (WORKFLOW 3.2), and it is the first thing to run

**Nothing here has been searched.** Before any derivation:

1. **Has anyone stated `χ(ℝ²) ≠ 6`, or conjectured `χ(ℝ²) ∈ {5, 7}`?** The folklore "probably 5 or 7" is common in conversation; a
   *stated* conjecture, with or without a reduction, is what matters. Search Polymath16's blog and wiki, `[Soifer2024]`, and the
   survey literature, in those words.
2. **Value-omission theorems for chromatic numbers of graph families**, in the vocabulary of that literature ("chromatic gap",
   "no graph in this class has chromatic number k", Grötzsch-type gap theorems, chromatic spectra of families).
3. **The chromatic number of `F²` as a function of `F`** — has anyone asked what its image is? `[Benda–Perles]` Open Problem 11.6
   and Johnson's status reports are the places to look.
4. Under two disciplines (G49): graph colouring, and the arithmetic-of-fields side where the object is `χ(F²)`.
5. **For D5 / §2a, a different search from any run so far:** independence numbers of Cayley graphs on `𝔽_{q²}` with connection
   set the norm-one subgroup `μ_{q+1}` — in that literature's words (*difference sets avoiding a multiplicative coset*,
   *Paley-type* and *Peisert-type graphs*, *character-sum bounds on independent sets*), not in ours (*finite Euclidean plane*).
   Everything searched to date has been about the chromatic number of these graphs; the independence number is a separate and
   much more classical question, and a uniform `α ≤ c·q^{3/2}` with `c < 0.93` may simply exist.
   **First pass run 2026-09-18, and it returns a negative that lowers D5's rank** (`[Hopkins2018]`): the representation-theoretic
   machinery for independence bounds on Cayley graphs (Kane–Lovett–Rao) **reduces, on ABELIAN groups, to the Hoffman bound and
   Delsarte's linear programme** — and every target here is a Cayley graph on the abelian `𝔽_{q²}`, where that is the ratio bound
   we already compute (99.50 at `q = 19` against the 77 D5 needs). KLR's advance is for non-abelian groups, which these are not.
   **So the discipline D5 would naturally borrow from supplies nothing beyond what we hold.** Still unsearched, and now the only
   live line: the Paley/Peisert and character-sum literature proper, where bounds beating the ratio bound for *specific* subgroup
   connection sets do exist.

A negative is a finding and goes in §PA either way. **`CLOSED-QUESTIONS.md` gets a row if the literature has posed this.**

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 123 (`plans/FS100-derivation.md` §4, FS100-COR); row 125 (`plans/FS100-derivation.md` FS100-B12, FS100-B3).
