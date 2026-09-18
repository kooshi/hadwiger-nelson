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

## 3. Deliverables, cheapest first

| # | deliverable | cost | what it needs |
|---|---|---|---|
| D1 | **The equivalence, stated and proved in the kernel** — `chromaticNumber_plane_ne_six_of_no_field_six` and its converse | days | **FS-39** (the bridge) and de Bruijn–Erdős compactness; check Mathlib for the latter |
| D2 | **The aiming corollary, unconditional** — `L(F) ≠ 6` for every `F` whose wall members are closed, hence the candidates for six are exactly the `L ≥ 7` fields | hours, once the wall is closed | **FS-47** (row 57's step at field level) |
| D3 | **The conditional theorem** — *assuming the local–global conjecture and the wall, `χ(ℝ²) ≠ 6`* | days | D1 + D2; publishable as a statement about the conjecture even before the wall closes |
| D4 | **The gap theorem**, or a sharply stated obstruction to it | open | the chain at six; a necessity theorem for compulsions at the top rung |

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

A negative is a finding and goes in §PA either way. **`CLOSED-QUESTIONS.md` gets a row if the literature has posed this.**
