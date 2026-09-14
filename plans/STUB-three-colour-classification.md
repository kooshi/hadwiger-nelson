# FS-46 — Three colours over fields containing √3: GPT Astra's classification, and the conjecture's four-level (STUB, 2026-09-14; minted from GPT Astra's response to the conjecture write-up)

*Read beside: `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §3 (the proof) and
`VERIFICATION.md` row 4 (our read); `plans/STUB-chain-theorem.md` (FS-45, whose Theorem 4.1 — forced pairs give periods forming
an ideal — is the first step here); `CLAUDE.md` G54 (tight at 3: the plane `UD(𝔽₃) = K₃ □ K₃` forces), row 58 (the rhombus is the
minimal forcer at three colours), row 53 (the finite-plane bound), G48 (the conjecture); `plans/STUB-tight-quotients.md` (FS-42,
where Hedetniemi's conjecture enters in the other direction).*

**Credit.** Theorem 3.1 and its proof are **GPT Astra's** (OpenAI, 2026-09-14, in conversation with Kooshi), read here and found
sound modulo two cited theorems (`VERIFICATION.md` row 4). Ours: the rhombus as the level-one forcer at 3 (row 58), the
finite-plane bound and the exact spectra it uses.

## 1. Mission context, in plain language

The local–global tightness conjecture (G48; `docs/local-global-tightness.md`) says a real number field's plane needs exactly
`min(7, L(F))` colours, where `L(F)` is the best bound any conjugation-stable prime's residue graph gives. FS-45 records the
proof of its two-colour level for every real number field. This stub records the **three-colour level for every field
containing `√3`**, which is the whole family the ladder runs in:

> **Theorem 3.1 (GPT Astra).** Let `F ⊂ ℝ` be a number field with `√3 ∈ F`. Then `χ(F²) = 3` ⟺ some prime of `F` has residue
> field exactly `𝔽₃` ⟺ `L(F) = 3`. Hence the conjecture holds for every such `F` with `L(F) ≤ 4`.

The proof runs the ladder's own mechanism in reverse. With `ω = (1 + i√3)/2` and `δ = 1 + ω` (`N(δ) = 3`), every unit rhombus
`z, z + u, z + ωu, z + δu` forces its two apexes equal in every three-colouring — the rhombus of row 58 — so by FS-45's
Theorem 4.1 every three-colouring of `F²` is periodic under `δR`, hence under `3R` (`δδ̄ = 3`), and descends to a proper
three-colouring of the finite Cayley graph `Cay(A, H)`, `A = R/3R`, `H` the image of the unit vectors (`A` is finite:
`dim_{𝔽₃} A ≤ [F(i) : ℚ]`, by clearing a rational relation among any `n + 1` elements). The reduced quotient of `A` is the product
of the residue fields `κ_j = 𝔽_{q_j²}` of the stable primes above 3 (`q_j = 3^{f_j}`, `f_j` odd), each **full**, because the
norm-one elements of `κ_j` are all of the form `b/b̄` (Hilbert 90) and lift to unit vectors `a/ā ∈ R`, and they generate `κ_j`
over `𝔽₃` (their cyclic group has order `q_j + 1`, too large for a proper subfield). A Frobenius power gives a canonical
conjugation-stable copy `T ≅ ∏ κ_j` inside `A`, whose norm-one elements lie in `H`; so **`Cay(A, H)` contains the categorical
product `∏_j UD(𝔽_{q_j})`** of the finite Euclidean planes. Now the one external theorem: **El-Zahar–Sauer (1985)** — a
categorical product of graphs each needing four colours needs four — so a three-colourable product has a three-colourable
factor; and the finite-plane spectral floor `1 + (q + 1)/(2√q) > 3` for `q ≥ 27` leaves `q_j = 3`. Conversely a prime with
residue field `𝔽₃` gives the bound 3 and the unit triangle the floor. ∎

**Why it is worth a milestone and not a footnote.** (i) It is the first level of the conjecture proved by a mechanism other
than "exhibit the forcer": the product theorem does the work the spindle did, and it does it for *every* field at once. (ii) It
uses a Hedetniemi-type theorem in the **positive** direction, where FS-42 uses Shitov's refutation to remove Moorhouse's bar —
and the two are the same fact seen from both sides: El-Zahar–Sauer is Hedetniemi at four colours, which is true, while at five
the product of two 5-chromatic graphs can be 4-chromatic (`[Tardif2022]`, from memory, to be checked at PA), so **the same
argument cannot run at the next level** — the four-colour classification of the conjecture is not a product theorem away, and
the reason is the exact place where Hedetniemi first fails. (iii) It hands the record new field values by congruence alone:
`ℚ(√3, √11)` and `ℚ(√2, √3)` have no prime of residue field `𝔽₃` (3 is inert in `ℚ(√11)` and in `ℚ(√2)`), so both need four,
matching Theorem B and FS-45's 18-vertex graph; `ℚ(√3, √5)` needs four too, and there `L = 5` (the wall is broken by the class
`15 ≡ 7 (mod 8)`; 11 is usable since 3 and 5 are squares modulo 11; `fplane.py usable --rads 3,5` lists 11, 59, 71, …) with
`√11 ∉ F`, so FS-45's Corollary 6.2 does not apply: **`ℚ(√3, √5)` is the smallest field containing `√3` where the conjecture's
five-level is open with `L = 5`**, a named test case. Below it sit the quadratic fields, where the theorem is silent (no `√3`) and
the exposure is starker: `ℚ(√11)` and `ℚ(√23)` have `L = 4` (the 2-adic `K₄`; the plane at 7, `χ = 4`) and `χ ∈ {3, 4}` (odd cycles
exist since `11, 23 ≡ 3 (mod 4)`, row 63), and `ℚ(√47)` has usable primes 11, 19, 23, 31, 43, 47, … so `L ∈ {4, 5}` — **five iff the
plane at 19 refuses four colours**, which `data/fplane/chi-p19-k4.json` records as undecided — and `χ ∈ {3, 4, 5}`. The conjecture
predicts four for a quadratic field with no Moser spindle and, if 19 refuses four, five for `ℚ(√47)`; no forcer is known in any
of them, and a four-colouring of `ℚ(√11)²` local at no prime would refute the conjecture outright.

## 2. What we know

| fact | trust | where |
|---|---|---|
| Theorem 3.1, the argument above | hand, GPT Astra; read here, sound modulo `[ElZaharSauer1985]` and the Weil–Hoffman floor for prime powers `q = 3^f` | `local-global-further-results.md` §3; `VERIFICATION.md` row 4 |
| the rhombus forces at three colours, and only it (the minimal gadget) | kernel | row 58, `Mascot.lean` |
| `UD(𝔽₃) ≅ K₃ □ K₃` is tight at three colours; its three-colourings are Latin squares, every vertex frozen | kernel + derived | G54; `Instances/PlaneFreedom.lean` |
| the finite-plane floor `1 + (q + 1)/(2√q)` from Weil | derived; prime `q` measured exactly below 600; prime powers by the same Kloosterman bound | G44; `data/fplane/spectral-below-600.json` |
| El-Zahar–Sauer 1985: a product of 4-chromatic graphs is 4-chromatic | **[L]**, not held, not read | `[ElZaharSauer1985]` |
| `χ(ℚ(√3)²) = 3`, `χ(ℚ(√3,√11)²) = 4`, `χ(ℚ(√2,√3)²) = 4` as instances | hand; kernel; [C] + hand | Table 2 of the write-up; row 57; FS-45 |

## 3. Derivations first

**D1 — verify, in our notation.** Write the proof out in `plans/` with every step named against what we hold: the rhombus
period (row 58 + FS-45 D1), the finiteness of `R/3R`, the Hilbert-90 lifting, the Frobenius-power copy `T` (the Teichmüller step:
`T = Frob^N(A)` meets the nilradical trivially because `Frob^N` is the identity on `A/J`), the product embedding, the product
theorem, the floor. The two external inputs stay `[L]`.

**D2 — the kernel pieces.** `forces_rhombus` (three colours, the apexes; row 58 has the drawing), `periodic_of_forces_isometries`
(FS-45's chain lemma in its period form), the descent of a `3R`-periodic colouring to `addCayley (R ⧸ 3R) H` (`LocalGlobal.lean`'s
`addCayleyMap` pattern), and the instance `chromaticNumber (UD 𝔽₃) = 3` with every vertex frozen. The product step and the floor
are not kernel targets here.

**D3 — the four-colour level, stated so it can fail.** For `√3 ∈ F` with no `𝔽₃`-prime, `χ(F²) ≥ 4`; the conjecture says `= 4`
iff a stable dyadic prime has residue graph `K₄`, else `≥ 5`. The "`≥ 5`" half is FS-45's Theorem 6.1 for `F ⊇ K` (conditional
on the 8/3 forcer) and **open for fields like `ℚ(√3, √5)`** — the product route is closed by (ii) above, so the five-level needs a
four-forcer over `ℚ(√3)`-material that does not use `√11`, or a different mechanism; and the four-level is open for the quadratic
fields `ℚ(√11)`, `ℚ(√23)`, where a three-forcer with `1/δ` a sum of unit vectors (FS-45's chain) is the only route the record
names. Name those as the questions this stub leaves.

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| PA | `[ElZaharSauer1985]` fetched and read (the statement and its scope); `[Tardif2022]` checked against the paper; search "chromatic number of the plane over a number field three colours", "categorical product unit-distance", `[Fischer1990]` §3, `[Moorhouse2010]` §7, `[Madore2015]` §3 for the three-colour case; `[Soifer2024]` ch. 11 | half a day | a prior statement moves the credit line; the bibliography updated the same day |
| A | D1: the proof in our notation, each step checked; the instances table extended to every field in `data/fplane/map.md` | a day | a written proof with two `[L]` leaves, or the step that does not close, named |
| B | D2: the kernel pieces | 1–2 days | `forces_rhombus`, the period lemma, the descent; the `𝔽₃` instance |
| C | the record: G48's proved range, row 58's consumer, the `ℚ(√3,√5)` test case into `FRONTIER-STUBS.md` | half an hour | gates green |

## 5. Registered predictions

| id | prediction | falsifier |
|---|---|---|
| P1 | El-Zahar–Sauer's theorem, read, covers finite products of finitely many factors by the two-factor case and induction, with no connectivity or looplessness hypothesis beyond simple graphs | a hypothesis the product `∏ UD(𝔽_{q_j})` does not meet |
| P2 | PA finds no prior statement of Theorem 3.1 (the three-colour classification of number-field planes) | a statement in Fischer, Moorhouse, Madore or Benda–Perles — then the credit line names it |
| P3 (hunch) | the four-colour level cannot be proved by any product theorem: Hedetniemi fails at five (`[Tardif2022]`) exactly where the argument would need it | a product theorem for the specific factors (Cayley graphs of `𝔽_q²`) at five colours |

## 6. Failure and jackpot clauses

Failure: a step of D1 does not close under our read — then the theorem is demoted to a reading with the gap named, and the
instances stand on their own proofs (Theorem B, the 18-vertex graph). Jackpot: none — the stub is a derivation.

## 7. Bearing on 6, honestly

**None on six; medium as mechanism.** It is the second level of the conjecture proved by a general argument, it names the
smallest open five-level test case (`ℚ(√3, √5)`), and it locates the boundary of the product method at exactly the colour count
where Hedetniemi's conjecture first fails — which is a structural fact about why the ladder's higher rungs need forcers.

## 8. Addresses

`reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §3; `Proofs/HadwigerNelson/Mascot.lean`
(row 58), `Instances/PlaneFreedom.lean`, `LocalGlobal.lean` (`addCayleyMap`), `Copy.lean`, `Homogeneous.lean`; `data/fplane/map.md`,
`spectral-below-600.json`; `plans/STUB-chain-theorem.md` (FS-45).
