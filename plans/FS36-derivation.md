# FS-36 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Filed 2026-09-23 by the FS-71 batch-5a implementer (the theorem audit, `plans/FS71-theorem-audit.md`). FS-36 folded
in a 2026-09-11 handoff from Kooshi's conversation with ChatGPT (OpenAI) about colouring the plane over
multiquadratic fields; the mathematics is filed here (with the ChatGPT credit line each entry carries) rather than
under a separate id, per this milestone's own decision D8 and per `plans/FS71-theorem-audit.md`'s M.2 ("the home of
a theorem is where it was proved" — the handoff's claims were re-derived, checked, and in the two-colour case
completed, inside this milestone's own plan and its Lean modules the same week; nothing in
`reference/ChatGPT-multiquadratic/` states a theorem this file's two entries do not already carry with full credit).
Enumeration: `plans/FS36-multiquadratic-decomposition.md` read in full (1,212 lines: §0–§11 as approved, §M1–§M2 the
modeling passes, §R the implementer's results); `reference/ChatGPT-multiquadratic/handoff.md` (298 lines) and
`VERIFICATION.md` (109 lines) read in full; `independent_check.py` and `handoff_check.py` read for their check list
and counts, not executed (no solver, no Lean beyond `rg`, per the brief); `LEDGER.md` row 63 and `plans/
FIELD-WALL-THEOREM.md` §10.2 (Proposition 6.4, corrected) cross-checked against `plans/M53-derivation.md`'s own
cross-batch note, which points this correction's home here rather than at M53.*

## The theorems

**T1 — The multiquadratic two-colour iff. [hand; sufficiency ChatGPT (OpenAI), with Kooshi, 2026-09-11; the
converse the FS-36 planning session, 2026-09-11]** For a real multiquadratic number field `F` with 2-adic
square-class image `V ⊆ ℚ₂^×/ℚ₂^{×2}`: `χ(F²) = 2` if and only if `[−1] ∉ V` and `[3] ∉ V` — equivalently, iff no
odd element of `F`'s square-class group is `≡ 3 (mod 4)`. **Sufficiency:** when `[−1] ∉ V`, the extension `E(i)/E`
(`E` the 2-adic completion) is ramified exactly when `[3] ∉ V` (the unique unramified quadratic extension of `ℚ₂` is
`ℚ₂(√5)`, so `[5] ∈ V` is the case `[3]` need not decide alone — handled explicitly), and a ramified extension puts
conjugation in the inertia group, so every unit vector's residue is `1` and a linear functional two-colours the
plane. **Necessity:** `[3]` or `[−1] ∈ V` means an odd `e ≡ 3 (mod 4)` lies in `F`'s square-class group, so
`ℚ(√e) ⊆ F`, and `[Fischer1990]` Theorem 8 already refuses two colours there. *Proof:* `plans/FIELD-WALL-THEOREM.md`
§10.2 (Proposition 6.4, corrected — the same statement `LEDGER.md` row 63 credits); the sufficiency mechanism
checked exhaustively over all 16 local subgroups of `(ZMod 2)³` in `reference/ChatGPT-multiquadratic/
independent_check.py`; the necessity direction and the local-form-vs-global-form and local-form-vs-Fischer-Theorem-8
checks recorded in `reference/ChatGPT-multiquadratic/VERIFICATION.md` §2 item 4′ (13,287 square-class groups; every
squarefree `N < 1000`). *Proof verdict:* closes. *Rests on it:* `LEDGER.md` row 63; `CLAUDE.md` G38 (this entry
corrects Proposition 6.4's original, too-narrow "residue field `𝔽₂`" clause, which put `ℚ(√5)`, `ℚ(√13)` and every
field whose 2-adic image holds `[5]` under "four" rather than "two"); the mechanism's kernel form
(`colorable_two_unitDistance_induce_of_valuationSubring`, `TwoColourResidue.lean`). *Prior art:* the two-colour
mechanism for a single field is classical and spread across four sources, all read in full — `[Fischer1990]`
Theorem 8 (`ℚ(√N)²` 2-colourable iff `N ≢ 3 (mod 4)`, both directions, explicit odd cycle one way and parity
evaluations on `Σ₀` the other); `[Moorhouse2010]` Theorem 7.1 (odd-degree number fields have `χ(K²) = 2` by a trace
functional at a prime with `e, f` both odd — a special case, since such a prime ramifies in `K(i)`); `[Madore2015]`
Prop. 3.9 and Remark 2.5 (`χ(ℚ(√2)²) = χ(ℚ₂(√2)²) = 2` by hand over `ℚ₂(√2)`, his own "slight difficulty" with
coordinate-wise valuation, which is `[Fischer1990]` Theorem 8 at `N = 2` with a proof that does not cite Fischer);
`[Johnson1987]` (the "if" half of Fischer's Theorem 8, with many distances forbidden) — but **the multiquadratic iff
itself, stated for the whole square-class group of an arbitrary real multiquadratic field, is in none of the four**.
**Check owed, partly discharged since row 63 was written:** `[AxenovichEtAl2014]` — row 63 flags this iff as
"unchecked against `[AxenovichEtAl2014]` and `[Johnson2006]`"; **FS-58's own prior-art gate (2026-09-17) read its
§1–§2 in full and found the multiquadratic iff is not there** ("Theorems 2.2–2.3 give upper bounds 2, 3, 4 and 6 for
real quadratic and multi-radical planes by explicit residue colourings … no lower bound, and no multiquadratic
two-colour criterion, so FS-36's criterion is not in §2", `BIBLIOGRAPHY.md`); §3–§4 remain unread, so the check is
*negative but incomplete*, not closed. `[Johnson2006]` remains unobtained (`BIBLIOGRAPHY.md`: "not read — named
only; blocking for FS-20") — genuinely check owed. zbMATH (this batch, verbatim): `ab:"chromatic number" &
ab:"multiquadratic"` (0), `ti:"chromatic number" & ab:"square class"` (0). *Kernel:* kernel
(`colorable_two_unitDistance_induce_of_valuationSubring`, `TwoColourResidue.lean`) for the mechanism; the
field-level step — that a real multiquadratic `F` meeting the criterion actually supplies the conjugation-stable
valuation subring the mechanism needs — is **not** in the kernel and is stub FS-37 (`plans/
STUB-field-level-criteria.md`), the same gap Theorem A's own general form carries.

**T2 — The square-class decomposition. [hand; ChatGPT (OpenAI), with Kooshi, 2026-09-11; formalized in the kernel the same week]** Every real multiquadratic field lies, once `√2` is adjoined, in a compositum of two test-passing fields. Let `W` be the 2-adic square-class group of `D ∪ {2}` for a set `D` of natural numbers. `W` is the sum of
two pieces — the classes localizing into `{1,3,2,6}` and those localizing into `{1,3,10,14}` — and **neither
piece's 2-adic image contains `[−1]`**. Consequently `ℚ(√d : d ∈ D)` lies in the compositum of the two pieces'
fields; if `D ⊇ {3, 11}`, each piece's plane needs at least four colours (a Moser spindle sits in both, since `[3]`
localizes into both pieces). Instance: `K(√14)` and `K(√70)` both pass the test, and the plane over their compositum
needs **at least five** colours (`√5 = √70/√14` puts a Heule-510-shaped certificate there, reduced through the
11-plane). *Proof:* the field-level decomposition and the `≥ 4` bound are kernel —
`fieldOfRadicands_le_sup`, `four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap`,
`minusOne_not_mem_map_inf_comap` (`SquareClass.lean`); the `K(√14)·K(√70)` instance is kernel —
`map_twoAdic_fourteen_le`, `map_twoAdic_seventy_le`, `five_le_chromaticNumber_planeOver_fourteen_sup_seventy`
(`Instances/CompositumFive.lean`, Phase C, `plans/FS36-multiquadratic-decomposition.md` §R4). The original hand
proof is `reference/ChatGPT-multiquadratic/handoff.md` §5; re-derived and simplified here (the handoff's two-case
split is unnecessary — if `U_A ⊆ ρ(W)` and `U_A + U_B` is the whole local group, every `w ∈ W` splits by lifting
one piece), and sampled on 16,288 + 15,288 fields (`independent_check.py`, `VERIFICATION.md` item 11), with a red
confirming the `√2` hypothesis is load-bearing (the split fails over `K(√7)` without it). *Proof verdict:* closes.
*Rests on it:* `LEDGER.md` row 63; `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4's remark that "their colourings do not
glue" (this makes it exact); FS-37 (the field-level `χ ≤ 4` step the reading below leans on). *Prior art:* ours —
searched under Kummer theory / square classes and under the chromatic-number-of-planes-over-fields vocabulary
(`plans/FS36-multiquadratic-decomposition.md` §PA(b)); nothing found, and the credit line names it a corollary of
this project's own 2-adic four-colour criterion (itself `[Fischer1990]`'s and `[Madore2015]`'s mechanism) rather
than "the project's" own, per decision D8. zbMATH: `ab:"chromatic number" & ab:"compositum"` (0), `ab:"unit
distance" & ab:"biquadratic"` (0). *Kernel:* kernel (`fieldOfRadicands_le_sup`,
`four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap`, `minusOne_not_mem_map_inf_comap`, `SquareClass.lean`;
the compositum instance in `Instances/CompositumFive.lean`).

## Readings and measurements that were called theorems, or that could be mistaken for them

- **The conditional reading row 63 states: "granted the factors' hand `χ ≤ 4`, no combining rule for test-passing
  fields gives four."** T2's kernel content is unconditional (the compositum needs `≥ 5`, kernel); what is
  conditional is the *interpretation* "so no combining rule of the form `χ(A²), χ(B²) ≤ 4 ⟹ χ((AB)²) ≤ 4` can hold
  for test-passing `A, B`" — this needs each piece's own `χ ≤ 4`, which is **not** proved at the field level (that
  is exactly FS-37's gap, T1's own boundary). `[reading, named hypothesis: FS-37]`, not filed as a theorem — it is
  the informal gloss on an unconditional kernel fact plus an unproved hypothesis, per
  `plans/FS71-theorem-audit.md`'s own instruction for this row ("file the kernel instance as kernel and the
  conditional reading as a reading with its named hypothesis").
- **`χ(F²) = 2` iff `L(F) = 2` for every real number field** (GPT Astra, `CLAUDE.md` G55, credited in row 63) — not
  filed here; it is the 2026-09-14 Astra fold-in's, assigned to batch 5c per the brief.
- **The "screening rule" for several radicands at once** (`VERIFICATION.md` item 6: odd roots `≡ 1, 3 (mod 8)`;
  even roots all in `{2,6}` or all in `{10,14} (mod 16)`) — "proved by exhaustion" over 256 local-class patterns
  plus every squarefree `d ≤ 1000`. This is T2's splitting fact read as a practical test rather than a separate
  result; not filed as a distinct theorem, and its `[tools]` exhaustive check is T2's own verification evidence.
- **The latent bug found in `tools/fplane.py usable`** (`VERIFICATION.md` §3: it tests each radicand separately and
  wrongly accepts `--rads 22,33` at `p = 11`, since `22·33 = 11²·6` and each radicand alone is divisible by 11) —
  a tooling defect, not a theorem; already flagged in `plans/STUB-consolidation-remainder.md` §5 and unaffected in
  every recorded result (no field in the record has two radicands divisible by one usable prime).

## Conjectures surfaced, not claimed

None. `plans/FS36-multiquadratic-decomposition.md` §10 states explicitly what is **not** proved — `χ ≤ 4` for
either piece of the decomposition, at the field level — and that gap is stubbed as FS-37 rather than claimed;
nothing in this milestone's record asserts it.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | kernel (mechanism, `TwoColourResidue.lean`); field-level step stub FS-37 |
| T2 | kernel (`SquareClass.lean`, `Instances/CompositumFive.lean`) |
