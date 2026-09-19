# FS-62 — six is not a value: χ(ℝ²) ∈ {5, 7} as a theorem target

*Minted 2026-09-17, out of a conversation with Kooshi on where a six-chromatic structure could still hide once no real quadratic
field turns out to need six. Read beside: `CLAUDE.md` G64 (the statement), G56 and G59 (the wall), G48 (the conjecture), G55 (the
chain theorem), `plans/STUB-plane-bridge.md` (FS-39), `plans/STUB-unit-vector-ring-kernel.md` (FS-47),
`plans/STUB-fractional-wall.md` (FS-57).*

---

## 1. The question, and why it is the biggest one on the board

Every time this project pins the chromatic number of a plane over a coefficient structure it gets **2, 3, 4, 5 or 7**. It has never
once got 6, and by FS-53/FS-54/FS-56 the residue method *cannot* produce a 6: the local bound `L(F)` is never six, because no finite
Euclidean plane is exactly six-chromatic anywhere the wall has been closed.

The observation looks like a curiosity about small fields. It is not. **It is equivalent to a two-value Hadwiger–Nelson.**

> **Claim (modulo FS-39).** *No subfield `F ⊆ ℝ` has `χ(F²) = 6`* ⟺ `χ(ℝ²) ≠ 6` ⟺ **`χ(ℝ²) ∈ {5, 7}`**.

*Proof.* (⟸) `χ(ℝ²)` is the supremum of `χ(F²)` over subfields (FS-39). If no field attains 6, the supremum is not 6.
(⟹) If `χ(ℝ²) = 6`, de Bruijn–Erdős gives a finite 6-chromatic unit-distance graph; its coordinates generate a number field `F`
(FS-39's algebraic-drawing step); then `6 ≤ χ(F²) ≤ χ(ℝ²) = 6`. ∎

De Grey removed 4 in 2018. **Removing 6 would be the first narrowing of the interval since**, and it is a statement about fields —
which is the one object this repository has a full instrument suite for.

**Note what the claim is NOT.** Six-chromatic unit-distance *graphs* certainly exist if `χ(ℝ²) = 7`, by taking vertex-critical
subgraphs. The claim is that the **function `F ↦ χ(F²)` omits the value 6**, which is a much stranger and much weaker-looking
statement than "no six-chromatic graph exists".

---

## 2. How it factors

**(a) `χ(F²) ≤ L(F)` is a theorem** (ledger row 52; the field-level step is row 57's hand gap, which FS-47 closes). So **every field
with a usable small prime is already excluded as a home for six** — no search needed, no conjecture needed. If `L(F) ≤ 5` then
`χ(F²) ≤ 5`.

**(b) The wall at six says `L(F)` is never 6** (G56, G59). Finite: six graphs remain — `q ∈ {23, 27, 31, 43, 47}` and `U₆₄` — with
floors 6, 6, 5, 6, 6, 6 and no six-colouring found at any of them. **This is a finite computation**, and FS-57 prices the two
members within reach (47 and `U₆₄`).

**(c) What is left is a gap theorem:**

> **`χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7`.**

Combining (a) and (b): unconditionally, **the only fields that could have `χ(F²) = 6` are exactly the fields the conjecture
predicts to be 7** — those with `L(F) ≥ 7`, where the arithmetic gives no bound below seven. Six hides nowhere else.

**The engine for (c) is G55's chain theorem one rung up.** A pair forced equal at `k` colours at difference `δ` makes every
`k`-colouring `δR`-periodic, and `1/δ ∈ R = ℤ[U]` gives `χ(F²) > k` with an explicit witness. So the gap theorem would follow from:
*every 6-chromatic field graph carries a 6-colour forced pair at a `δ` with `1/δ ∈ ℤ[U]`*. That is this repository's own open
structural question (`CLAUDE.md` § The open structural question — "is a pigeonhole necessary?") asked at six instead of five, and
the only necessity theorem we hold (A1) is vacuous at the top rung.

---

## 2a. Why the wall exists at all, and what that makes of (b)

*Added 2026-09-18, out of a conversation with Kooshi that started on the complex plane and the quaternions. The conclusion is
G59's; this section is the part that bears on FS-62, namely that (b) is one theorem plus two small cases rather than six
certificates.*

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
   `k = 78`, and the fastest is the weakest one**: at `q = 11, k = 29` (UNSAT, `α = 28` known) the pin refutes in
   22 s where the centroid takes 240 s, because the pin's thirteen unit clauses propagate and modular sums do not.
   The sharp statement of the gap: at `q = 19` the solver refutes `k = 130` in 16 s, `k = 115` in 115 s, and
   **nothing at or below `k = 95` in 600 s** — its frontier sits about forty above the answer.

**The first experiment, RUN 2026-09-18 — and it neither confirmed nor refuted the reading** (`data/fs62/q19/README.md`): the level-3 relaxation that pinned `α(Γ₇) = 14` and `α(Γ₁₁) = 28` exactly had never been run at 19, and it converges there to **80.59**, so `α(19) ≤ 80` — an improvement on the ratio bound's 99, ~6 % loose against the best known set, and **not the ≤ 77 that would confirm the uniform route**. Alongside it, the local search was asked for 78 for a full hour on 24 threads: **521,874 restarts, never past 76** — a null at a budget, never a refusal (G21). So `c(19) ∈ [0.918, 0.966]` with the deciding 0.933 inside, and the reading survives its cheapest falsifier without being confirmed. **Two by-products worth more than the target:** the relaxation is ~6 % loose at 19, against exact at 7 and 11 and ~20 % at 23, which pins where the instrument stops being exact; and its GPU backend is **3.6× SLOWER** than the CPU one on this instance class (2.75 against 0.77 s/iteration), the reverse of the FS-50 certificate at `q = 83` — a number that does not travel across instance shapes.

**Prior-art question this opens, owed under §5:** independence numbers of Cayley graphs on `𝔽_{q²}` whose connection set is the
norm-one subgroup `μ_{q+1}` — equivalently, the largest set whose difference set misses a prescribed multiplicative coset. That
is a well-posed question in the character-sum and finite-geometry literature and is *not* the same search as "finite Euclidean
graph chromatic number", which is what has been searched so far.

---

## 3. Deliverables, cheapest first

| # | deliverable | cost | what it needs |
|---|---|---|---|
| D1 | **The equivalence, stated and proved in the kernel** — `chromaticNumber_plane_ne_six_of_no_field_six` and its converse | days | **FS-39** (the bridge) and de Bruijn–Erdős compactness; check Mathlib for the latter |
| D2 | **The aiming corollary, unconditional** — `L(F) ≠ 6` for every `F` whose wall members are closed, hence the candidates for six are exactly the `L ≥ 7` fields | hours, once the wall is closed | **FS-47** (row 57's step at field level) |
| D3 | **The conditional theorem** — *assuming the local–global conjecture and the wall, `χ(ℝ²) ≠ 6`* | days | D1 + D2; publishable as a statement about the conjecture even before the wall closes |
| D4 | **The gap theorem**, or a sharply stated obstruction to it | open | the chain at six; a necessity theorem for compulsions at the top rung |
| D5 | **The uniform independence bound** — `α(UD(𝔽_q,2)) ≤ 0.93·q^{3/2}` for odd `q ≥ 23`, or its counterexample. Closes **31, 43 and 47 in one theorem**, cutting (b) from six members to two | unknown, and **harder than "one theorem instead of three relaxations" suggests** — §2a(4) prices it | §2a above; a literature pass on independence numbers of subgroup-Cayley graphs over `𝔽_{q²}` |

**D3 is the honest first target.** A conditional dichotomy resting on a conjecture verified at six fields and proved for `L ≤ 5`
(G55) is a real result and states clearly what it depends on. D4 is the real prize and may be out of reach.

---

## 4. Expectations, and the clauses that matter

* **The wall closes at 47 and `U₆₄` and nowhere else by any priced instrument** (medium-high; FS-57's own estimate). Then the
  dichotomy stays conditional on four undecided planes, which is worth stating as such.
* **The gap theorem resists** (high). Nobody has a 6-colour forced pair over any field, and G31 says every compulsion sweep this
  project has run returned zero at the top rung.
* **Informative failure — the one that would make this stub a finding rather than a frame:** a six-colouring of any window member.
  That gives a field with `L(F) = 6`, and under the conjecture a field with `χ(F²) = 6`, which kills the dichotomy outright and
  hands the project the first exactly six-chromatic finite Euclidean plane. FS-53 and FS-57 are already pointed there.
* **The trap to name in advance:** "six is skipped" is **not** evidence that the answer is seven. It is equally consistent with every
  field being `≤ 5` and `χ(ℝ²) = 5`. Any write-up that lets the dichotomy imply seven without invoking the conjecture's bold form at
  `K(√7)` (G48) is overclaiming.

---

## 5. Prior art owed (WORKFLOW 3a), and it is the first thing to run

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
