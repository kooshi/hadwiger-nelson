
## Stage 13 — SAVED (FS131-K10c): the import, with its four items, and the floor on it

**Module**: `Proofs/HadwigerNelson/Arith/WeilKloosterman.lean` (imports `Arith/TargetFloors`; nothing imports it). One `axiom`,
no `sorry`, no `native_decide`.

```
axiom kloosterman_bound.{u} (F : Type u) [Field F] [Fintype F] [DecidableEq F] (hp : ringChar F ≠ 2)
    (ψ : AddChar F ℂ) (hψ : ∃ x, ψ x ≠ 1) (c d a : F) (h4 : 4 * c * d = a) (ha : a ≠ 0) :
    ‖∑ x ∈ univ.filter (fun x : F => x ≠ 0), ψ (c * x + d * x⁻¹)‖ ≤ 2 * Real.sqrt (Fintype.card F)
```

**Its form, and why** (the brief: mine to decide). (i) **The page's own sentence, not `KloostermanBound F`**: the three
translations between them (`∃ x, ψ x ≠ 1` / `ψ ≠ 1`; `4cd = a ≠ 0` / `c, d ≠ 0`; `x ≠ 0` / units) are then theorems the kernel
checks (`kloostermanBound_of_ringChar_ne_two`, and back, `kloosterman_page_of_kloostermanBound`), not part of what is trusted;
a reader checks the axiom against p. 207 symbol by symbol. (ii) **Characteristic not 2, the page's class**, not the fields the
floor reads (§ 12.4 item 1).

**The four items** (`LEAN.md` § Assumptions):
1. *Docstring*: names `[Weil1948]`, says the note has no sections, and gives p. 207 (the second displayed inequality) with
   the hypotheses' pages (204, 206).
2. *Read-back*: Stage 12.
3. *Model, in the same file*: `kloosterman_bound_model` — `ZMod 3`, `ZMod.stdAddChar`, `c = d = a = 1`: `ringChar ≠ 2`, a value
   of the character other than 1, `4·1·1 = 1`, `1 ≠ 0`, **and the conclusion there, proved with no axiom** (from
   `kloostermanBound_of_card_le_five`, the second pass's model, through `kloosterman_page_of_kloostermanBound`). So the axiom's
   hypotheses are met at a field where its conclusion is independently a theorem.
4. *`ARCHITECTURE.md` § Trust*: the row `StandingFive.kloosterman_bound` under "Imported outside theorems", and the module's
   row in § 3.

**Declared to the gate** (`scripts/Axioms.lean`, IMPORTED): `#eval AxiomAudit.declareImport
``HadwigerNelson.StandingFive.kloosterman_bound`, and under it the **eight records that rest on it**:
`kloostermanBound_of_ringChar_ne_two`, `targetFloor_seven_weil`, `targetFloor_six_weil`, `circle_sum_le_weil`,
`standingFloor_seven_weil`, `standingFloor_five_weil`, `seven_le_localBound_weil`, `five_le_chromaticNumber_weil`. Six records
of the module carry no axiom beyond the standard three and sit in a CLEAN block "FS131-K10c": `sum_units_eq_sum_ne_zero`,
`four_mul_mul_ne_zero_iff`, `kloosterman_page_of_kloostermanBound`, `kloosterman_bound_model`,
`ringChar_ne_two_of_card_mod_four`, `targetFloor_six_of_kloosterman`.

**The consumers, read aloud.**
- `standingFloor_seven_weil : StandingFloor 7` — every field of `128²` elements, and every field of `Q²` elements with
  `Q ≡ 3 (mod 4)`, `Q ≥ 347`, with a non-trivial involution `σ`, has `χ(Cay(k, {x : x·σ(x) = 1})) ≥ 7`. No hypothesis.
- `seven_le_localBound_weil : 7 ≤ localBound standingField` — TC1-STANDING-FIVE's "so `L(F) ≥ 7`", no hypothesis.
- `five_le_chromaticNumber_weil (hRow123)` — "and given MR, `χ(F²) ≥ 5`", over row 123's chain alone.
- `targetFloor_seven_weil` (`Q ≡ 3 (mod 4)`, `Q ≥ 98`), `targetFloor_six_weil` (`Q ≥ 62`; the bibliography's "`> 5` for
  `p ≥ 62`"; the threshold sharp for the argument, Spec: `62 < 8√61`), stated for every `Q`, empty of content where `Q` is no
  prime power.
- `circle_sum_le_weil` — `[MMST1996]` Theorem 3 at `n = 2` in the form that is true (§ 15.1).
