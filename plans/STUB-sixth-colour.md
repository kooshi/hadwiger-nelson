# FS-53 — The sixth colour: a finite plane with χ = 6 exactly, and the field it seals (STUB, minted 2026-09-15 at Kooshi's instruction: "stub the next milestone as searching for and verifying the field and prime with chromatic number 6, now that we have strong tools")

*Read beside: `plans/STUB-independence-threshold.md` and `data/fs50/README.md` (the instrument: the triple-level SDP in real
blocks on the GPU, the exact rational certificate, the stranger-checkable checker `tools/fplane_cert_check.py`),
`plans/STUB-first-digit-23.md` (FS-17: the prime this stub's phase B starts at), `plans/STUB-first-digit-83.md` (FS-40, closed
by FS-50's certificate), `plans/STUB-arena-slack-census.md`, `plans/STUB-three-colour-classification.md` and
`plans/STUB-biquadratic-table.md` (FS-46/48: fields without √11), `plans/STUB-bridge-to-plane.md` (FS-39: χ(ℝ²) = sup_F χ(F²)),
`plans/STUB-unit-vector-ring-kernel.md` (FS-47: the field-level residue step), `plans/STUB-ratio-bound-kernel.md` and
`plans/STUB-triple-certificate-kernel.md` (FS-51/52: the kernel forms of the certificates); `CLAUDE.md` rows 52–53, 56, 66–67,
G43, G44, G48, G54, G55. Vocabulary: a prime p ≡ 3 (mod 4) is **usable** for a real field F when every radicand of F is a
square modulo p (residue field 𝔽_p at a prime above p, so F² maps onto UD(𝔽_p, 2) and χ(F²) ≤ χ(UD(𝔽_p, 2))); L(F) is the
least χ of a usable prime's plane, with the 2-adic wall (four colours when it stands) and the primes above 3 (three) as the
small cases; the **conjecture** (G48, FS-15) is χ(F²) = L(F) wherever L ≤ 6, proved for L ≤ 5 over multiquadratic F ⊇ ℚ(√3,√11)
given the 8/3 forcer (G55).*

## §0 Why this milestone exists, and why now

1. **The instrument is proved at 83.** On 2026-09-15 the triple-level SDP's exact certificate refused six colours on the
   83-plane: α(UD(𝔽₈₃,2)) ≤ 1082 < 1149, two independent certificates (two backends' iterates), each CERTIFIED by the untouched
   checker with the six-colour sentence and re-checked by exact LDL (`data/fs50/p83-refusal/`). It is the first exact chromatic
   digit of any finite Euclidean plane above p = 11 (χ(𝔽₁₁) = 5 is Moorhouse's; §PA of FS-50 found no other), and it cost hours
   on one GPU. The same instrument decides a plane a day.
2. **Not a single object anywhere in this project is six-chromatic**, and today the reason has a shape. Six colours on
   UD(𝔽_p, 2) need an independent set of ⌈p²/6⌉, and the ratio bound permits that only while 5|λ_min| ≥ p + 1; with Weil's
   |λ_min| ≤ 2√p that fails from p = 103, and five colours are refused from 59 up (G44). So **a plane with χ exactly 6 can
   live only at p ∈ {23, 31, 43, 47, 59, 67, 79}** — 71's exact spectrum already puts it at ≥ 7 (§2) — and 83 was the last
   prime where six was spectrally possible at all. We have decided 11 and 19 (five) and 83 (seven). We have decided none of
   the seven.
3. **The hunt's fields cannot see the window, by quadratic reciprocity.** Every field this project has built in contains
   ℚ(√3, √11) (the Moser spindle and every known five-forcer live there), and a prime is usable for such a field only if 3
   and 11 are both squares modulo it. At every window prime one of them is not (§2's table: 3 fails at 31, 43, 67, 79; 11 at
   23, 47, 59, 71). So for every F ⊇ ℚ(√3, √11) the usable primes are 11 and then nothing below 83, and L(F) ∈ {…, 5, 7, …} —
   **six is arithmetically excluded for every field the hunt has ever used**, given 83's refusal. A six-chromatic field, if
   one exists, contains no √11; no known five-forcer lives in it; its five-chromaticity is itself open.
4. **Under the conjecture the window decides whether "6" exists at all.** A finite unit-distance graph has algebraic
   coordinates (its realisation space is semi-algebraic over ℚ; FS-39's bridge), so χ(ℝ²) = sup_F χ(F²) over number fields. If
   no window plane is six-chromatic then no number field has L(F) = 6, the conjecture says no number field is six-chromatic,
   and χ(ℝ²) ∈ {5, 7}. If some window plane IS six-chromatic, there is a field F with L(F) = 6, χ(F²) ≤ 6 by theorem, and the
   conjecture predicts χ(F²) = 6 — which, by compactness, is a finite six-chromatic unit-distance graph in F² and χ(ℝ²) ≥ 6.
   **That is why this is the next milestone: it is the first question whose every answer bears on six.**

## §1 The question, in two halves and a third that is not promised

**(A) The prime.** Which p in the window has χ(UD(𝔽_p, 2)) = 6 exactly? Two certificates per prime: a six-colouring,
exhibited and verified proper (kernel-consumable as a colouring table, the shape of `chromaticNumber_finitePlane11`), and a
refusal of five — the exact certificate α ≤ ⌈p²/5⌉ − 1 when the relaxation reaches it (`card_le_mul_of_colorable` /
`add_one_le_chromaticNumber_of_indepNum_le` are the kernel consumers), otherwise an LRAT refutation of five-colourability by
cube-and-conquer over the rotation orbits, kernel-replayed on its core if the core is small (the `TwoAdicFive` recipe), or a
stronger relaxation (§4 B).

**(B) The field.** For each six-chromatic prime p, a real multiquadratic F with L(F) = 6 through p: the 2-adic wall broken
(an odd square class ≡ 7 mod 8, G35); 3, 7, 11 and 19 unusable (a radicand that is a non-square modulo each, so no plane at
≤ 5 colours bounds F); p usable; every other usable prime's plane at ≥ 6 (automatic from 59 up by the spectrum, and from 103
by Weil — so the design only has to keep the other window primes unusable or six-chromatic). Then χ(F²) ≤ 6 (the residue map
`unitQuadrance.map` is kernel over the ring; the field-level valuation-subring step is row 57's hand gap until FS-47 lands),
and the registered prediction χ(F²) = 6 with its falsifiers (§5).

**(C) Not promised: the six-forcer in F.** χ(F²) = 6 is a finite six-chromatic unit-distance graph in F², i.e. the hunt's
object. This milestone delivers the setting, not the object: the plane's tight/slack sign at six (G54 — by §2's table every
window plane is slack at six, λ_min ≠ −(p+1)/5, so the residue mechanism forces no pair at six colours over F and, if some
six-colouring of the plane has a fan gap, row 66 makes every six-colour forced pair over F a single vertex: a forcer over F
cannot be a residue compulsion plus a spindle, exactly as at five over sealed fields, and must be built as pigeonhole × kill
at arity ≥ 3), the six-colouring space of the plane (symmetric census; fan gaps; periodicity), and the analogue of M63's
screen (type-M rotations whose radicands lie in F, over a base lattice that lives in F). Priced in phase D, pursued only if
Kooshi says so.

## §2 The window, measured (2026-09-15; `tools/fplane.py spectrum`, exact Kloosterman sums; `data/fs53/window.md` at subplan)

| p | n = p² | λ_min | ratio bound α ≤ | spectral floor χ ≥ | five needs α ≥ | six needs α ≥ | (3/p) | (11/p) | usable for F ⊇ ℚ(√3,√11)? | known |
|---|---|---|---|---|---|---|---|---|---|---|
| 23 | 529 | −7.9607 | 131.76 | 5 | 106 | 89 | + | − | no | α ∈ [87, 108]; SDP 108.546; no rotationally symmetric 5-colouring; χ ∈ {5, 6} (six needs α ≥ 89, two above the set found) |
| 31 | 961 | −10.6665 | 240.25 | 5 (4.0001) | 193 | 161 | − | − | no | untouched |
| 43 | 1849 | −11.9622 | 395.23 | 5 | 370 | 309 | − | + | no | untouched |
| 47 | 2209 | −12.8465 | 466.39 | 5 | 442 | 369 | + | − | no | untouched |
| 59 | 3481 | −14.9176 | 693.14 | 6 | 697 (refused) | 581 | + | − | no | five refused by spectrum; χ ∈ {6, 7, …} |
| 67 | 4489 | −15.0567 | 813.78 | 6 | 898 (refused) | 749 | − | − | no | same |
| 71 | 5041 | −14.1728 | 829.09 | **7** | — | 841 (refused) | + | − | no | **six refused by spectrum; out of the window** |
| 79 | 6241 | −17.1019 | 1099.19 | 6 | — | 1041 | − | + | no | χ ∈ {6, 7, …} |
| 83 | 6889 | −17.7087 | 1199.46 | 6 | — | 1149 | + | + | yes (11 and 83 are K's only usable primes below 131) | **χ ≥ 7, exact certificate α ≤ 1082 (2026-09-15)** |

Six-tightness (λ_min = −(p+1)/5) holds at none of them (−4.8, −6.4, −8.8, −9.6, −12, −13.6, −16 against the column above):
every window plane is slack at six. The heuristic that χ sits one above the spectral floor, true at both decided primes
(11: floor 4, χ 5; 83: floor 6, χ 7), predicts **six at 23, 31, 43, 47 and seven at 59, 67, 79** — a reading with two data
points, to be scored by phase A.

## §3 Candidate fields (the designer's first outputs, exact Legendre symbols, 2026-09-15)

| field | wall | usable primes ≤ 83 | L(F) under the conjecture | note |
|---|---|---|---|---|
| ℚ(√2, √3, √31) | broken (31 ≡ 7 mod 8) | 23 only | χ(UD(𝔽₂₃, 2)) | 31 is ramified with 3 a non-square mod 31, so unusable; 47 fails at 31 |
| ℚ(√2, √3, √23) | broken (23 ≡ 7 mod 8) | 23 only | χ(UD(𝔽₂₃, 2)) | |
| ℚ(√2, √3, √7) | broken (7 ≡ 7 mod 8) | 47 only | χ(UD(𝔽₄₇, 2)) | 7 unusable (3 is a non-square mod 7); 23 fails at 7; 71 fails at 7; 83 fails at 2 |
| ℚ(√2, √3, √47) | broken | 23 and 47 | min of the two | a two-prime field: the table decides which prime bounds it |

The designer (phase C's tool): given p, search squarefree radicand sets for the congruence conditions of §1(B), print every
usable prime ≤ 200 with its plane's known status, the wall test, and the 3/7/11/19 exclusions; controls — ℚ(√3,√11) must
return {11, 83, 131, …}, de Grey's field {131, 479, …} (row 53), and a planted radicand that is a square everywhere must be
refused by name. Fields for 31, 43, 59, 67, 79 to be designed the same way (each needs its own wall-breaker and its own
exclusions; 31 ≡ 7 mod 8 and 47 ≡ 7 mod 8 are wall-breakers themselves).

## §4 Phases

- **A — the table across the window** (a GPU-day). For each of the seven primes: the two thresholds and the exact spectrum
  (done, §2); the triple-level SDP in real blocks on the GPU, both formulations (the certified one and the three-row one,
  FS-50 §1 item 10 — where the extra rows bind is itself a finding); the exact certificate from the converged dual (with the
  fresh-scale polish that produced 1082 at 83: round from a short continuation resumed with SCS's default scale, never from a
  long-run iterate whose adaptive scale has drifted); the largest independent set the Rust `plane-independent` finds; a
  six-colouring and a five-colouring attempt by the Rust colourer (FS-40's), whole plane and quotients; the tight/slack
  signs at 5 and 6. Output: one row per prime with three trust levels per cell (solver / exact-rational / kernel).
- **B — decide χ = 6 at the primes A names.** The six-colouring as a kernel certificate (`chromaticNumber_finitePlane_p ≤ 6`,
  a colouring table checked by `decide +kernel`, like `Instances/FinitePlane11.lean`); the refusal of five as an exact
  certificate where the relaxation's value is below ⌈p²/5⌉ (at 23 it is not: 108.546 against 105, the known 3.4% shortfall —
  so at 23 the refusal needs a stronger relaxation: the next level of the hierarchy on the same symmetry, cutting planes
  (odd-cycle / clique inequalities on Y), or the LRAT route) — priced per prime after A. The kernel statement per prime:
  `chromaticNumber (unitQuadrance (ZMod p)) = 6`, the lower half through `add_one_le_chromaticNumber_of_indepNum_le` with the
  certificate's ⌊N⌋ (exact-rational trust until FS-52), the upper half kernel.
- **C — the field.** The designer and its controls; the arithmetic verification of L(F) = 6 (exact, seconds); χ(F²) ≤ 6 in
  the kernel over the ring of integers' residue map (row 53's shape) with the field step marked [hand] or closed by FS-47;
  the prediction registered with its falsifiers; the tight/slack classification of the plane at six and its row-66
  consequence written out for F.
- **D — the setting for a forcer** (priced, not promised): the six-colouring census of the plane (symmetric colourings; fan
  gaps; the level-one compulsion structure at six, row 66 one level up), and M63's screen re-run over a base in F.
- **The close**: ledger rows (the sequence of exact digits; the field; the prediction), the grokking "six is excluded for
  every field containing ℚ(√3, √11)" (promoted from §0.3 once the 83 certificate is in the ledger), FRONTIER re-rank.

## §5 Registered expectations and their falsifiers

- **P1** (medium): at least one window plane is exactly six-chromatic. Falsifier: phase A's table reads five or ≥ 7 at all
  seven. The negative is the milestone's other product (§6).
- **P2** (low-medium, the "+1 over the floor" reading): six at 23, 31, 43, 47; seven at 59, 67, 79. Scored prime by prime.
- **P3** (unknown; measured first at 47): the certified relaxation's value at 47 lies below 442, so five is refused by the
  certificate alone. At 83 the relaxation had 7% to spare; at 23 it fell 3.4% short.
- **P4** (high; from §2): no window plane is six-tight, so over any field it seals at six the residue mechanism forces no
  pair, and a six-forcer over such a field is built, not transported.
- **P5** (high; theorem-shaped, to be re-verified by the designer as a control): for every real F ⊇ ℚ(√3, √11), no prime
  between 11 and 83 is usable.
- **P6** (the conjecture's exposed sentence, for a field F the milestone names): χ(F²) = 6. Falsifiers: a five-colouring of
  F² (local at no prime, non-additive — FS-46's genre), or a seven-forcer in F² (which would be χ(ℝ²) = 7).

## §6 Failure clauses, stated in advance

- Every window plane is five or ≥ 7: report it as the sequence of exact digits (a result: the first digits above 11) and the
  corollary "under the conjecture no number field is six-chromatic, so χ(ℝ²) ∈ {5, 7}", with its trust levels; six is then
  a value no algebraic method can reach, and the stub's bearing inverts to the seven side.
- A plane is six-chromatic but its five-refusal is out of reach (relaxation short, SAT undecided): bracket it as at 23 and
  say so; the six-colouring alone is χ ≤ 6, which already makes the field's L(F) ≤ 6 and the prediction ≤ 6.
- The field cannot be isolated (every field that sees p also sees a five-chromatic plane): record the obstruction; it would
  be a new reciprocity fact of the same kind as §0.3.
- The instrument's own failure modes carry over from FS-50 verbatim: iterates are never bounds; a capped chunk reads
  "solved (inaccurate)"; a rounding from a drifted-scale iterate is weak (200 above the objective) where a fresh-scale
  continuation rounds to within 9; the checker's word decides, and it ends on the verdict.

## §7 Deliverables

`data/fs53/window.md` (the table with provenance per cell); `data/fs53/cert-p<p>-N<N>.json` per prime with a certificate,
each checked; `tools/fplane_field_design.py` (the designer, with its controls); `Instances/FinitePlane<p>.lean` for each
decided prime; the field's upper bound module; the registered prediction in the plan; ledger rows and the grokking;
`plans/FRONTIER-STUBS.md` re-ranked.

## §8 Prior art to search at the subplan (§PA), in the disciplines' words

Finite Euclidean graphs / unit-distance graphs over finite fields: chromatic and independence numbers — `[Vinh2006]`,
`[Vinh2008]` (Thm 12, the ratio bound), `[Krebs2022]`, `[SchneiderSilva2013]`, `[LorenzZimmermann2023]`, Medrano–Myers–
Stark–Terras (spectra), Bannai–Shimabukuro–Tanaka (finite Euclidean graphs as association schemes; their Lovász theta);
"chromatic number 6 unit distance graph" anywhere (no claim known; Exoo–Ismailescu's {1,2}-graphs are six-chromatic on two
distances, not one); the choice of a number field by splitting conditions in the Hadwiger–Nelson-over-fields literature
(`[Fischer1990]`, `[Moorhouse2010]` §8–10, `[Madore2015]`, `[Polymath16wiki]`); Chebotarev-style existence of fields with
prescribed splitting (standard). Two disciplines: spectral finite geometry and algebraic number theory; walk the citation
graph of Moorhouse's draft and of Vinh 2008.

## §9 Cost and bearing

Phase A a GPU-day; B hours (certificate) to days (SAT) per prime; C a day; D open. **Bearing on χ ≥ 6: the highest of any
stub in either outcome** — a six-chromatic plane names the field a six-forcer must live in and the value the conjecture
predicts there; no six-chromatic plane retires six for every number field under the conjecture and points the hunt at seven.
