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
   prime where six was spectrally possible at all. We have decided 11 (five, kernel), 19 (five, on the solver's word) and 83 (≥ 7 by certificate; a seven-colouring was sought and not
   found, so χ(83) ∈ {7, 8, …}). We have decided none of the seven.
3. **The hunt's fields cannot see the window, by quadratic reciprocity.** Every field this project has built in contains
   ℚ(√3, √11) (the Moser spindle and every known five-forcer live there), and a prime is usable for such a field only if 3
   and 11 are both squares modulo it. At every window prime one of them is not (§2's table: 3 fails at 31, 43, 67, 79; 11 at
   23, 47, 59, 71). So for every F ⊇ ℚ(√3, √11) the usable primes are 11 and then nothing below 83, and L(F) ∈ {…, 5, 7, …} —
   **six is arithmetically excluded for every field the hunt has ever used**, given 83's refusal. A six-chromatic field, if
   one exists, contains no √11; no known five-forcer lives in it; its five-chromaticity is itself open.
4. **The window decides whether six is reachable by the residue method at all** (corrected 2026-09-15 at the modeling
   passes; the first draft said "χ(ℝ²) ∈ {5, 7}", which the weak conjecture does not give). A finite unit-distance graph has
   algebraic coordinates, so χ(ℝ²) = sup_F χ(F²) over number fields (`[Madore2015]` ¶5.4 plus de Bruijn–Erdős; FS-39's kernel
   form). If no window plane is six-chromatic then no number field has L(F) = 6, so every field holding a six-chromatic graph has
   all its usable planes at ≥ 7 — the finite planes can never pin six, and under the conjecture's bold form (χ(F²) = 7 wherever
   L(F) ≥ 7) χ(ℝ²) = 7 with six a value no field attains. If some window plane IS six-chromatic, there is a field F with L(F) = 6,
   χ(F²) ≤ 6 by theorem, and the conjecture predicts χ(F²) = 6 — by compactness a finite six-chromatic unit-distance graph in F²
   and χ(ℝ²) ≥ 6. **That is why this is the next milestone: it is the first question whose every answer bears on six.**

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
| 23 | 529 | −7.9607 | 131.76 | 5 | 106 | 89 | + | − | no | α ∈ [87, 108]; SDP 108.546; five CDCL-undecided (4 h, M58) and no rotationally symmetric 5-colouring; line-periodic colourings need 8 (χ ≤ 8); χ ∈ {5, 6, 7, 8} (six needs α ≥ 89, two above the set found) |
| 31 | 961 | −10.6665 | 240.25 | 5 (4.0001) | 193 | 161 | − | − | no | five CDCL-undecided (4 h, M58); line-periodic colourings need 8 (χ ≤ 8); no SDP yet |
| 43 | 1849 | −11.9622 | 395.23 | 5 | 370 | 309 | − | + | no | five CDCL-undecided (4 h, M58); line-periodic 8 (χ ≤ 8); no SDP yet |
| 47 | 2209 | −12.8465 | 466.39 | 5 | 442 | 369 | + | − | no | five CDCL-undecided (4 h, M58); line-periodic 10 (χ ≤ 10); no SDP yet |
| 59 | 3481 | −14.9176 | 693.14 | 6 | 697 (refused) | 581 | + | − | no | five refused by spectrum; line-periodic 10 (χ ≤ 10); χ ∈ {6, …, 10} |
| 67 | 4489 | −15.0567 | 813.78 | 6 | 898 (refused) | 749 | − | − | no | five refused by spectrum; line-periodic 12 (χ ≤ 12); χ ∈ {6, …, 12} |
| 71 | 5041 | −14.1728 | 829.09 | **7** | — | 841 (refused) | + | − | no | **six refused by spectrum; out of the window**; line-periodic 12 |
| 79 | 6241 | −17.1019 | 1099.19 | 6 | — | 1041 | − | + | no | χ ∈ {6, 7, …} |
| 83 | 6889 | −17.7087 | 1199.46 | 6 | — | 1149 | + | + | yes (11 and 83 are K's only usable primes below 131) | **χ ≥ 7, exact certificate α ≤ 1082 (2026-09-15)** |

Six-tightness (λ_min = −(p+1)/5) holds at none of them (−4.8, −6.4, −8.8, −9.6, −12, −13.6, −16 against the column above):
every window plane is slack at six. The heuristic that χ sits one above the spectral floor — true at the three decided primes,
7 (floor 3, χ 4), 11 (floor 4, χ 5) and 19 (floor 4, χ 5 on the solver's word), and consistent with 83 (floor 6, χ ≥ 7, seven
not found) — predicts **six at 23, 31, 43, 47 and seven at 59, 67, 79**: a reading with three data points, to be scored by
phase A. The upper bounds the project holds in the window are line-periodic colourings (`data/fplane/periodic-below-71.json`:
8 at 23, 31, 43; 10 at 47, 59; 12 at 67, 71), each refused at one colour fewer by the solver, so **a six-colouring of any window
plane, if it exists, is not constant on the cosets of any line** (§PA item 3).

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

## §8 Prior art searched at the subplan — the result is §PA below (run 2026-09-15); the search list as minted:

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

## §PA. The prior-art gate (run 2026-09-15, before the subplan; WORKFLOW step 3a; about an hour; extends FS-50's gate, `plans/FS50-prior-art.md`, whose independence-side negatives stand and are not repeated)

**In one sentence:** no finite Euclidean plane is known to be six-chromatic and no window prime has been decided or even
bracketed in print; the only bracketed cells anywhere are Moorhouse's `χ(𝔽₁₃²) ∈ {5, 6}` (this project measured 5, M58) and
`χ(𝔽₁₇²) ∈ {5, 6, 7}` (five unfinished here at 50 min, M58) — primes ≡ 1 (mod 4), which seal no field; the field half's
existence step is elementary and its bridge to χ(ℝ²) is `[Madore2015]` ¶5.4; six is reached by every neighbouring problem
(3-space, two distances, odd distances) and never by one distance in a plane.

### PA.1 The names searched (the gate's questions)

1. **The object in the disciplines' words.** (i) *the chromatic number of the finite Euclidean graph `E_q(2, 1)` / unit-quadrance
   graph `D_q`* (`[Vinh2005]`, `[MMST1998]`, `[BannaiShimabukuroTanaka2009]`); (ii) *the generalized Paley graph `GP(p², p−1)`*
   (Lim–Praeger; `[SchneiderSilva2013]`; Broere–Döman–Ridley); (iii) *chromatic numbers of Cayley graphs of abelian groups*
   (`[CervantesKrebs2023]` and its two follow-ups); (iv) *unit-distance / distance graphs over finite fields*; (v) *a 6-chromatic
   unit-distance graph* anywhere — plane, space, field; (vi) the field half: *Hadwiger–Nelson over number fields / quadratic
   fields*, *prescribed splitting of primes* (Chebotarev). Strings: "chromatic number finite Euclidean graph exact small q",
   "generalized Paley graph chromatic number GP(p², p−1) norm-one subgroup", "Lorenz Zimmermann unit-quadrance chromatic",
   "Bannai Shimabukuro Tanaka finite Euclidean graphs Ramanujan Kloosterman", "6-chromatic OR six-chromatic unit distance graph
   field plane", "Hadwiger–Nelson number field quadratic field chromatic number exactly 6", "Kurz integral point sets finite
   fields unit distance chromatic", "Chromatic numbers of Cayley graphs of abelian groups matrix method unit-quadrance".
2. **Two disciplines.** Spectral finite geometry / algebraic graph theory (the finite-field lineage and the Cayley-graph
   literature) against algebraic number theory (splitting in multiquadratic fields; Madore's Chebotarev argument). The
   disciplines still do not cite each other: `[Moorhouse2010]` is indexed by no citation database (Semantic Scholar has no
   record of it; reached only through `[Madore2015]` and `[Krebs2022]`), and `[Vinh2005]`'s five citing works are all on the
   finite-field side.
3. **The question, not only the method.** "Is any finite plane `UD(𝔽_q, 2)` exactly six-chromatic?" and "is there a number
   field `K` with `χ(K²) = 6`?" — neither is posed anywhere found. The nearest posed items are Moorhouse's two bracketed cells
   (Table 6.1) and `[Fischer1990]` §1's question for an algebraic criterion.
4. **Outside arXiv:** Moorhouse's draft (personal page); Kurz's Australasian J. Combin. papers; the Polymath16 wiki (read in
   full for FS-23 — it holds no finite-plane chromatic number).
5. **Citation graphs, two databases, identifiers compared.** `[Madore2015]`: Semantic Scholar 4 citing works via
   arXiv:1509.07023 (*Chromatic number of spacetime* 2023; `[Krebs2022]`; `[Heule2018]`'s new proof; a thesis on
   computer-aided extremal unit-distance graphs and quantum contextuality) against OpenAlex `W2216410758` with 1 — none
   computes a finite plane. `[Vinh2005]`: Semantic Scholar 5 via arXiv:math/0510092 (Kurz's integral point sets 2007/2008;
   `[CervantesKrebs2023]`; `[Krebs2022]`; a 2024 paper on maximal circular point sets over arbitrary fields with a cryptographic
   application) against OpenAlex `W1590777427` with 2 — none. `[Krebs2022]` (doi 10.1007/s10801-022-01157-8): 2, both
   `[LorenzZimmermann2023]`'s, held. `[Vinh2008]`'s were walked for FS-50.
6. **Read, not characterised from abstracts:** `[Moorhouse2010]` §6 and §8 (the tables and the quadratic-field theorem);
   `[Madore2015]` §5 (the whole section); `[CervantesKrebs2023]` Example 2.13 and its Vinh citation; Vinh 2005 from the held
   bibliography row.

### PA.2 What was found, with verdicts

| key | what it holds | verdict for FS-53 |
|---|---|---|
| `[Moorhouse2010]` §6 | **Table 6.1**, `χ(𝔽_q²)` for `q ≤ 17`: 2, 3, 2, 3, 4, 2, 3, 5 at `q = 2, 3, 4, 5, 7, 8, 9, 11`; **`{5, 6}` at 13; 2 at 16; `{5, 6, 7}` at 17**; Lemma 6.2 (`q ≡ ±1 mod 12 ⟹ χ ≥ 4`, by a chain of rhombi); the guess `χ → ∞` (proved by `[Vinh2005]`, whom he does not cite) | the only bracketed finite-plane cells in print. Both primes are ≡ 1 (mod 4): −1 is a square, unit vectors need not be 𝔭-integral, `[Madore2015]` Cor. 3.4's hypothesis fails, **no field is sealed through them**. They bear on "is any finite Euclidean plane six-chromatic?" and on nothing else; 13 reads 5 here (M58: `k = 4` UNSAT, `k = 5` SAT, 3.8 s) and **17 is open — `k = 4` UNSAT, `k = 5` unfinished at 50 min** (M58's log, under `build/`, gone); 289 vertices, degree 16, a side row |
| `[Moorhouse2010]` §8 | **Theorem 8.1:** for real quadratic `ℚ(√d)`, `χ ≤ 4` unless `d ≡ 47, 59, 83 (mod 84)` — the sieve at 2, 3 and 7 (11 unused there); Lemma 8.2 counts a **ramified** `p` as usable (`d ≡ 0 mod p`); Theorem 8.6 (`√p ∈ K`, `p ≡ 3 mod 4 ⟹ χ ≥ 3`, an odd cycle from Pell) | the quadratic case of the field half, from the field to its bound; the three exceptional classes are where the quadratic fields' `L` is 5 or more; our designer runs the other way (from the prime to a field) and must count ramified primes as usable (`tools/fplane.py usable` — a control for phase C: `ℚ(√23)` sees 23) |
| `[Vinh2005]` (held row) | `√q(1/2 + o(1)) ≤ χ(𝔽_q²) ≤ q(1/2 + o(1))`, the upper bound constructive (pairs of parallel lines of non-square slope, `(p+1)/2` colours); the only exact value `χ(𝔽₇²) = 4` | at 23 his colouring uses 12 where our line-periodic one uses 8; nothing at the window; the divergence kills Madore's Prop. 5.3 route (next row) |
| `[Madore2015]` §5 (read 2026-09-15) | **¶5.4:** `χ(E^d)` is the same for every real closed `E` (Tarski), so `χ(ℝ^d) = χ(ℚ_r-alg^d)`, and "if `χ(ℝ²) = 7` then this fact is provable"; **Prop. 5.3:** a finite graph drawn in `ℂ^d` maps into `𝔽_p^d` for a positive-density set of degree-one primes (Chebotarev; the finitely many denominators avoided; every residue class mod 4), so `χ(ℝ^d) ≤ lim sup_p χ(𝔽_p^d)` | **FS-39's bridge is prior art**: with de Bruijn–Erdős, `χ(ℝ²) = sup_K χ(K²)` over number fields is a two-line corollary of ¶5.4, and §0.4 rests on published theorems. The upper route is dead (`[Vinh2005]`'s floor diverges), and the plane → field direction runs only through Cor. 3.4 (`q ≡ 3 mod 4`): a six-chromatic plane at 13 or 17 says nothing about any field |
| `[CervantesKrebs2023]` and follow-ups | Heuberger-matrix calculus for abelian Cayley graphs; Example 2.13 computes `χ` of the infinite unit-distance Cayley graph in ℝ² generated by `1, ω, ω², ω³` with `ω = (5 + i√39)/8`; the follow-ups classify small dimension and rank | our planes are rank-2 Cayley graphs on `ℤ_p²` of degree `p + 1`, outside the classified cases; **no finite plane computed**; the row-collapse homomorphism is M61's periodic quotient (bib row) |
| generalized Paley graphs (Broere–Döman–Ridley 1988; `[SchneiderSilva2013]`; Lim–Praeger) | `χ = ω = q` for `GP(q², d)` with `d ∣ q + 1`; the `χ = ω` cases classified | our `GP(p², p−1)` has `p − 1 ∤ p + 1` for `p > 3` and `ω ∈ {2, 3} ≪ χ`; the GP chromatic literature covers the `χ = ω` cases only — **nothing** |
| `[BannaiShimabukuroTanaka2009]` (held listing) | `E_q(n, Q, a)` asymptotically Ramanujan; spectra as (twisted) Kloosterman sums | the spectra's prior art with `[MMST1998]`; our window spectra are exact computations, not cited values; no colourings |
| Kurz, *Integral point sets over finite fields* (AJC 43 (2009); listing) and *Maximal integral point sets in affine planes over finite fields* (arXiv:0804.1285) | the **integral-distance** graph on `𝔽_q^m` (squared distance a square), strongly regular in even dimension | a different graph; no chromatic numbers of unit-quadrance graphs |
| six by the neighbours: Nechushtan 2002 (`χ(ℝ³) ≥ 6`, listing), `[Parts2020b]` and `[ExooIsmailescu2019]` (two distances, 16 vertices), `[PartsOdd2022]` (odd distances) | each relaxation of "one distance in the plane" reaches six with a finite graph | **aims the milestone**: six is not intrinsically out of reach for distance graphs — it is the value every neighbour attains — and the finite planes are the one setting where "one distance" is asked exactly and decided |
| the existence half of the field design (standard: Dirichlet + CRT; Chebotarev for density) | for real multiquadratic `ℚ(√d₁, …, √d_k)`, `p ≡ 3 (mod 4)` is usable iff every `(dᵢ/p) ∈ {0, 1}` (a ramified `dᵢ` with the others squares); a consistent finite list of congruences on the `dᵢ` modulo `3, 7, 11, 19, 23, 31, 43, 47` (every usable prime ≥ 59 already refuses five) has squarefree solutions by Dirichlet, and the usable set is infinite of density `2^{−(k+1)}` | **the design's content is the exclusion list and the table, never existence**; no paper designs a field from a target prime (`[Moorhouse2010]` §8 and `[Fischer1990]` §1 go from the field to its bound) |

**Not found under any name tried:** a chromatic number of any finite Euclidean plane at `p ≡ 3 (mod 4)` above 11 other than
ours; any statement bracketing a window prime; any six-chromatic single-distance graph over any field; any number field
proposed or asked about with `χ(K²) = 6`; any designer of fields from a prime.

### PA.3 What the gate aims (handed to the advisor and the planner)

1. **Phase A′, a side row:** decide `χ(𝔽₁₇²)` (Moorhouse's open cell; 289 vertices; five unfinished at 50 min on one CDCL —
   the cube-and-conquer or the SDP at `(17, 5)`: five needs `α ≥ 58`), and record 13 as decided (5). If 17 is six, it is the
   first six-chromatic unit-quadrance graph ever exhibited, and it seals nothing — say both.
2. **Both directions are open at every window prime, and any six-colouring is non-periodic.** The upper bounds are ours
   (line-periodic: 8, 8, 8, 10, 10, 12 at 23–67, each one colour above the solver's refusal of the circulant), five is
   CDCL-undecided at 23–47 (4 h, M58), and the SDP has run only at 23. The planner's phase A therefore has a finding side
   (six- and five-colourings by the Rust colourer, whole plane and quotients — FS-40's instrument, which failed at 83 for
   seven and eight) as well as the certificate side, and the reading "+1 over the floor" has three data points (7, 11, 19).
3. **FS-39's bridge is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős** — state §0.4 with the attribution; the kernel form stays
   FS-39's.
4. **The designer counts ramified primes as usable** (Moorhouse Lemma 8.2) and needs no existence theorem: its output is the
   exclusion list, the usable-prime table with each plane's status, and the controls the stub names.
5. **Bibliography, the same day:** listings added for Nechushtan 2002 and Kurz 2009; `[Madore2015]` §5 and `[Moorhouse2010]`
   §8 marked read; `[Vinh2005]` and `[CervantesKrebs2023]` rows extended with the citation walk.

## §S. The subplan (2026-09-15, the planner; the advisor's pass read first, per Kooshi's ordering; the stub's §0–§9 and §PA above are the brief this refines)

*Written for an implementer with zero conversation memory. Every number below is either recomputed here (numpy or exact
arithmetic, in the planner's scratch) or carries a file path. A search's null is a null at a budget, never a refusal; a
solver's verdict is untrusted until an independent checker or the kernel holds it; a relaxation's iterate is never a bound.*

### §S0. State on disk at opening

| what | where | trust |
|---|---|---|
| the window's exact spectra, thresholds and Legendre symbols | §S1's table; `tools/fplane.py spectrum`, recomputed independently at subplanning | exact character sums, reproduced twice |
| **the finding side, everything ever asked**: `(23,6)` not found in 300 s (best 1.83 % of edges monochromatic), `(23,7)` 0.60 %, `(31,6)` 1.35 %, `(43,6)` 2.87 %, `(47,6)` 3.52 %, all at 120 s; controls `(23,8)` found in 1.5 s and `(19,5)` in 8.7 s | `data/fs53/README.md` (committed 2026-09-15) | the search's word; nulls at a budget |
| the refusing side, everything ever asked: `k = 5` **undecided at 4 h** at 23, 31, 43, 47; `k = 5` undecided at 2,328 s at `q = 27`; no rotationally symmetric 5-colouring at 23 | `data/fplane/chi-p{23,31,43,47}-k5.json`, `chi-q27.json`, `equivariant-p23-k5.json` | the solver's word |
| the upper bounds the project holds: line-periodic 8 / 8 / 8 / 10 / 10 / 12 at 23 / 31 / 43 / 47 / 59 / 67 | `data/fplane/periodic-below-71.json` | verified colourings |
| **α: 28 exactly at 11** (cadical refuses 29), ≥ 76 at 19, ≥ 87 at 23, ≥ 597 at 83; nothing at 27, 31, 43, 47, 59, 67, 79 | `data/fplane/alpha-p{11,19}.json`, `data/fs50/alpha-p23-ge87.json`, `data/fs50/wo18/` | verified sets |
| the exact certificates: α(11) ≤ 29, α(23) ≤ 108.546075, **α(83) ≤ 1076.366454** | `data/fs50/cert-p11-N29.json`, `cert-p23-real-N108.json`, `data/fs50/p83-refusal/` | exact rational, re-checked by `tools/fplane_cert_check.py` |
| the kernel: `add_one_le_chromaticNumber_of_indepNum_le`, `not_colorable_of_mul_lt`, `card_le_mul_of_colorable`; `unitQuadrance`, `finitePlane`, `unitQuadrance.map`, `rotHom`; `addCayleyMap`, `addCayleyColoring`, `colorable_of_addCayleyMap`, `unitQuadrance_colorable_of_quotient`; `Adjoin.lift`; `unpackColor`; the three FS-50 consumers at 83 / 23 / 11 | `LocalGlobal.lean`, `UnitQuadrance.lean`, `Critical.lean:241`, `Instances/IndependenceThreshold.lean`, `Instances/FinitePlane11.lean` | kernel |
| `tools/fplane.py chi --q 27` is **broken**: `field_q27()` was deleted by commit `a3adc46`; the body survives only at `.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`, so `data/fplane/chi-q27.json` is unreproducible from `main` | verified at subplanning | a defect, phase A0 |
| `plane-colour` writes its record **once, at the end** (`crates/plane-colour/src/main.rs:485`), unlike `plane-independent`, whose `--out` is rewritten at every progress tick through a temp file and resumed by `--start` | verified at subplanning | a defect against the PROTECTED checkpointing rule, phase A0 |
| two live FS-50 GPU jobs (pids 2808409, 2816615) and a polish loop | `plans/SESSION-HANDOFF-2026-09-15.md` §2 | must be stopped at a checkpoint before phase B |

### §S1. Units, and the window — fixed once

`q` is a prime power `≡ 3 (mod 4)` of odd degree over its prime; `UD(𝔽_q, 2)` is the Cayley graph on `𝔽_q²` joining points
whose difference satisfies `x² + y² = 1` — `n = q²` vertices, degree `d = q + 1` (no isotropic vectors, so the circle is a
`(q+1)`-point conic). `α` is the independence number, `χ` the chromatic number, `χ_f` the fractional chromatic number.
Three identities and one bound are used throughout and are not re-derived:

* **vertex-transitive ⟹ `χ_f = n/α` exactly** (Scheinerman–Ullman Prop. 3.1.1), so `χ ≥ ⌈n/α⌉`;
* **a proper `k`-colouring needs `α ≥ ⌈n/k⌉`** — necessary, never sufficient: a cleared threshold says six is possible
  *fractionally* and nothing more (the classes must also partition);
* **the ratio (Hoffman) bound `α ≤ n·|λ_min| / (d + |λ_min|)`**, on exact character sums;
* **the certificate's reach** is the ratio `N_certified / Hoffman` — *lower is tighter*. Measured three times, and only
  three: **0.8444 at 11** (29.176808 / 34.55), **0.8238 at 23** (108.546075 / 131.76), **0.8974 at 83**
  (1076.366454 / 1199.46). It bounds `α` from **above**, so it can **remove** a prime from the window and never place a six.

**The window** — every `q ≡ 3 (mod 4)` of odd degree whose plane can be exactly six-chromatic. Six needs `α ≥ ⌈q²/6⌉`,
which the ratio bound permits only while `5|λ_min| ≥ q + 1`; with Weil's `|λ_min| ≤ 2√q` that fails from `q = 98` up
(`t² − 10t + 1 ≤ 0` at `t = √q` gives `q ≤ 97.98`), 71's exact spectrum fails it, and 83 is refused by certificate. **Eight
members** (the stub's §2 and `CLAUDE.md` G56 list seven: `q = 27 = 3³` was omitted — the advisor's finding, adopted):

| q | n = q² | λ_min | Hoffman α ≤ | spectral floor χ ≥ | six needs α ≥ | **frac6** | five needs α ≥ | **frac5** | (3/q) | (11/q) |
|---|---|---|---|---|---|---|---|---|---|---|
| 23 | 529 | −7.9607 | 131.76 | 5 | 89 | **0.6755** | 106 | 0.8045 | + | − |
| **27** | 729 | **−8 exactly** | 162.00 | 5 | 122 | **0.7531** | 146 | **0.9012** | ramified | − |
| 31 | 961 | −10.6665 | 240.25 | 5 | 161 | **0.6701** | 193 | 0.8033 | − | − |
| 43 | 1849 | −11.9622 | 395.23 | 5 | 309 | **0.7818** | 370 | **0.9362** | − | + |
| 47 | 2209 | −12.8465 | 466.39 | 5 | 369 | **0.7912** | 442 | **0.9477** | + | − |
| 59 | 3481 | −14.9176 | 693.14 | 6 | 581 | **0.8382** | (refused) | 1.0056 | + | − |
| 67 | 4489 | −15.0567 | 813.78 | 6 | 749 | **0.9204** | (refused) | 1.1035 | − | − |
| 79 | 6241 | −17.1019 | 1099.19 | 6 | 1041 | **0.9471** | (refused) | 1.1363 | − | + |

*(Out of the window: 71, floor 7 by its exact spectrum; 83, six refused by certificate 2026-09-15; 11 and 19, decided at 5.)*
**Every figure recomputed at subplanning** from the exact character sums, including 𝔽₂₇'s, whose integer spectrum is
`{−8, −5, −2, 1, 4, 7, 10, 28}` (rebuilt from the deleted `field_q27` body in scratch; the circle has 28 points, the graph
is 28-regular and loopless). `frac6` and `frac5` are the fractions of the ratio bound a certificate must get **below** to
refuse six and five; compare them against the reach 0.82–0.90 and the whole of phase B's ordering falls out.

*(At `q = 27` the floor 5 is the ratio bound's, `⌈729/162⌉ = 5`, not the solver's: `data/fplane/chi-q27.json`'s `k = 4` UNSAT is the same number by an untrusted route, and its `k = 5` row is `unknown` at 2,328 s.)*

**The exclusion for every field this project has built in** (`CLAUDE.md` G56, §0.3): a prime is usable for `F` only if every
radicand of `F` is a square modulo it; every field here contains `ℚ(√3, √11)`, and at each window member 3 or 11 fails — 3 at
31, 43, 67, 79; 11 at 23, 47, 59. **At `q = 27` the argument as written does not typecheck** (3 is ramified) and needs one
extra line, the advisor's: `11 ≡ −1 (mod 3)` and `−1` is a non-square in every `𝔽_q` with `q ≡ 3 (mod 4)`, so `√11 ∉ 𝔽₂₇`.
The conclusion survives at all eight: **six is arithmetically excluded for every field containing `ℚ(√3, √11)`.**

### §S2. What the arithmetic decided, before any phase was written

**1. The milestone is asymmetric, and the stub's headline is unreachable.** The positive outcome is **one colouring away**:
a single verified six-colouring of one window plane gives `χ ≤ 6` there, `α ≥ ⌈q²/6⌉` for free, a field with `L(F) = 6`,
and the conjecture's first prediction of the middle value. The negative outcome needs **eight refusals of six**, and by
§S1's `frac6` column the certificate can deliver at most two of them (67 and 79). So **§0.4's conditional — "no
six-chromatic window plane ⟹ χ(ℝ²) ∈ {5, 7}" — cannot be reached by this milestone in the negative direction**, and the
subplan does not promise it. What the negative direction delivers instead is §S6's scorecard: a per-prime verdict with its
cause, the α table with its growth law, and the exact digits the certificate does produce.

**2. The certificate is aimed by arithmetic, not by preference** (the advisor's §3.1, recomputed). Against a reach of
0.82–0.90 it should:

| it should | at | because |
|---|---|---|
| **refuse six** (⟹ `χ ≥ 7`, the prime leaves the window) | **79** (frac6 0.9471), **67** (0.9204) | both above the worst reach ever measured (0.8974 at 83) |
| **refuse five** (⟹ floor 6) | **47** (frac5 0.9477), **43** (0.9362), **27** (0.9012) | all above 0.8974, though 27 by only 0.4 % |
| **decide nothing about six** | 23 (0.6755), 31 (0.6701), 27 (0.7531), 43 (0.7818), 47 (0.7912) | 10–25 % below the best reach ever measured (0.8238 at 23) |
| **probably decide nothing at 59** | 59 (frac6 0.8382) | *sharpening the advisor's "coin flip"*: 0.8382 is below two of the three measured reaches, and the reach **worsens with q** (0.8238 at 23 → 0.8974 at 83). Interpolated at 59 it is ≈ 0.87. Registered as Q1 |

So phase B's order is **27, 79, 67, 47, 43, 59** — and never 23 or 31 for six. The stub's "phase A starts with 23 and 47"
is dropped, with the reason in §S7 D-2.

**3. `q = 27` is the milestone's best target, and the reason is new** (this subplan's opening measurement, §S3). Its
five-threshold 0.9012 is inside the certificate's measured reach, so the certificate can raise its floor to **six**; and
its ceiling is now **seven**, measured here. Alone in the window it would then read `χ ∈ {6, 7}` — one bit from the
milestone's whole question, against `{6, 7, 8}` at 43, `{6, …, 10}` at 47 and 59, and `{5, 6, 7, 8}` at 23 and 31. It is
also the second-smallest plane in the window (729 vertices) and carries an extra symmetry the prime members do not: the
Frobenius `x ↦ x³` is a graph automorphism (`(x³)² + (y³)² = (x² + y²)³ = 1`), so `|Aut| ≥ 729 · 28 · 2 · 3 = 122,472`
against 25,392 at 23 — a larger group means fewer orbits and a cheaper semidefinite program. **The cost is that the whole
certificate stack is prime-field-only** (§S7 D-5, and a decision card for Kooshi).

**4. The decisive measurement is the independence number, not the chromatic number** (the advisor's reframing, adopted and
sharpened). At every window prime a six-colouring needs a class of `≥ ⌈q²/6⌉` points, so **the α search is a necessary
precondition that is cheaper and better instrumented than the colouring search** — and at 23 the arithmetic is brutal: six
classes of the best set ever found cover `6 × 87 = 522 < 529`, so a six-colouring at 23 *contains* an independent set of at
least 89, two above a plateau that 16 threads held for 298 of 300 seconds across 22,390 restarts, on the one plane where
that searcher's plateau has been calibrated against truth (it plateaus at 28 at `p = 11`, and `α(11) = 28`). **The whole
question at 23 is two vertices wide, and the only instrument that has looked says it falls on the wrong side.** The
evidence is one-sided (a local search can only raise α) and defeasible in an hour, which is exactly why it goes first.

**5. `χ ≥ 7` is out of reach at 23, 27, 31, 43 and 47 by every instrument this project can name, and that is a measured
fact, not a budget.** `χ > 6` for a vertex-transitive graph is exactly `χ_f > 6`, which is exactly `α < q²/6`: fractional
and spectral instruments give nothing the certificate does not. An *integrality* argument would have to come from
resolution, and FS-50 measured resolution's reach on these graphs — cadical refutes `α ≥ N` only above a residual density
of ≈ 0.41, at 23 with `N = 106` the easiest undecided cube sits at 0.394, and the monolith is undecided at **every** `N`
from 110 to 140, above the ratio bound. **So the undecidable primes are undecidable for a reason independent of their χ,**
and the escape hatch "six lives in the ones we could not decide" is closed in advance (§S6).

**6. What the kernel can hold today, with no prime decided.** Three modules' worth, all provable before phase A returns:
the packed **Cayley colouring certificate** (a `Bool` the kernel decides, turning a table plus the circle into
`(finitePlane q).Colorable k` at `(q+1)·q²` checks instead of `q⁴`); the **sixteen conditional consumers** (six- and
seven-colour thresholds at each of the eight window members, one line each from
`add_one_le_chromaticNumber_of_indepNum_le`); and the **field half's ring-level reduction** (`χ(unitQuadrance O) ≤ χ(UD(𝔽_q,2))`
for each candidate field's order `O`, one `Adjoin.lift` each). None waits on a digit (§S9).

### §S3. The opening measurement: the periodic family at `q = 27`, exhausted (run at subplanning, 2026-09-15)

**Why this and not something else.** Over a prime field the additive group `𝔽_p²` has exactly `p + 1` proper nonzero
subgroups — the lines — so "colourings constant on the cosets of a subgroup" is the `periodic-below-71.json` family, and it
is already exhausted (8 / 8 / 8 / 10 / 10 / 12 at 23 / 31 / 43 / 47 / 59 / 67, each refused at one colour fewer). Over
`𝔽₂₇` the additive group is `(ℤ/3)⁶`, whose subgroups are **all** `𝔽₃`-subspaces: 364 of dimension 1, 11,011 of dimension 2,
33,880 of dimension 3, 11,011 of dimension 4. That family is tens of thousands of times larger than a line family, it is
searchable exhaustively in minutes, the project's tools cannot express it, and **at `q = 27` the project held no upper
bound of any kind.** A colouring of the quotient pulls back to the plane whenever the subgroup misses the circle
(`colorable_of_addCayleyMap`, kernel), so every hit is sound and every miss is one-sided.

**The decision rule, registered in the planner's scratch before the run** (`DECISION-RULE-q27.md`): a six-colouring of any
quotient ⟹ `χ(UD(𝔽₂₇,2)) ≤ 6` on the spot and 27 becomes the live prime; a five-colouring ⟹ `χ = 5` exactly (with the
recorded `k = 4` UNSAT) and 27 leaves the window; none ⟹ the first upper bound at 27 plus an exhaustive negative over the
periodic family. Both outcomes reachable: the family certainly contains colourings at large `k`, and 27's six-threshold
0.7531 is the friendliest in the window.

**The result.** Every subspace enumerated by reduced row echelon form; a subspace is *usable* when no circle point lies in
it (else the quotient has a loop); dimensions 3 and 4 decided **exactly** by backtracking, dimensions 1 and 2 by DSATUR at
40 restarts — **sound on success, a null at a budget on failure**:

| subgroup dim | index | quotient size | subspaces | usable | six-colourable | best `k` found |
|---|---|---|---|---|---|---|
| 4 | 9 | 9 | 11,011 | 2,100 | **0 (exact)** | 9 — every usable quotient is `K₉` |
| 3 | 27 | 27 | 33,880 | 20,216 | **0 (exact)** | **7** (a quotient with a 12-element connection set) |
| 2 | 81 | 81 | 11,011 | 9,408 | 0 (DSATUR budget) | 9, or 8 at a wider budget |
| 1 | 243 | 243 | 364 | 350 | 0 (DSATUR budget) | 11 |

**Two findings, both new.**
1. **`χ(UD(𝔽₂₇, 2)) ≤ 7`** — the first upper bound at `q = 27`, and a 27-vertex certificate: the quotient by the subspace
   spanned by `(1,0,0,0,0,1), (0,1,0,0,2,2), (0,0,1,0,1,1)` (coordinates: the three `𝔽₃`-components of `x` then of `y`) is a
   27-vertex Cayley graph of degree 12 which is 7-colourable and, by the exact sweep, not 6-colourable. **Review note (de Bruijn, 2026-09-15):** the committed record's dim-3 `best.basis` is a different subspace, `(1,0,0,0,0,2), (0,1,0,0,1,1), (0,0,1,0,2,2)` (the tool's rerun found a different 7-colourable quotient from the scratch run's); BOTH were rebuilt independently, 7-coloured, pulled back and verified proper on all 10,206 edges, and neither quotient is 6-colourable — the colourings are filed in `data/fs53/colour-q27-k7-quotient.json`, which is the certificate (the sweep record carries no colouring, since its witness fields are for `k = 6` hits). With the recorded
   `k = 4` UNSAT this brackets **`χ(UD(𝔽₂₇,2)) ∈ {5, 6, 7}`**.
2. **No six-colouring of `UD(𝔽₂₇, 2)` is constant on the cosets of any subgroup of index 9 or 27**, exhaustively; and none
   at index 81 or 243 at the DSATUR budget. The finding side at 27 must go non-periodic, exactly as at the prime members.

**Reproduced, and committed.** `tools/fplane_periodic_subgroups.py` ships with this subplan, carrying a `--self-test`
with three controls — a positive (a `k = 9` colouring of a dimension-4 quotient, found and verified), a planted subspace
containing a circle point (refused as unusable, never silently coloured), and the `𝔽₂₇` graph's shape and `edges_sha256`
asserted against the restored `field_q27` body — and it reproduces every count above into
`data/fs53/periodic-q27.json` in 234 s. **Two notes on honesty.** Its graph (729 vertices, degree 28, 10,206 edges) equals
the one `data/fplane/chi-q27.json` records, so the orphaned record and the restored producer agree on the object. And its
dimension-2 row reads `best k = 9` where the scratch run read 8: the committed tool climbs with a cheaper restart budget,
both numbers are sound upper bounds, and neither matters because dimension 3 already gives 7 — **a search's number is a
function of its budget, and the record says which budget.**

### §S4. Derivations that fix the shape

**D1 — the kernel cost of a colouring certificate, and the shape it forces.** `Instances/FinitePlane11.lean` proves
properness by `decide +kernel` over **all ordered pairs**: `q⁴` adjacency tests, 14,641 at 11 but 279,841 at 23, 3.4 M at
43 and 4.9 M at 47. The plane is a Cayley graph, so properness is equivalent to `∀ s ∈ circle, ∀ v, col(v) ≠ col(v + s)` —
`(q+1)·q²` tests: 12,696 at 23, 20,412 at 27, 81,356 at 43, 106,032 at 47, a factor of `q²/(q+1)` cheaper (22× at 23, 42×
at 47). Mathlib's `addCayleyColoring` (`LocalGlobal.lean:103`) already consumes exactly that hypothesis. Two further rules
from `CLAUDE.md` § The kernel's cost model shape the rest: a `∀ x ∈ l` under `decide` costs an order of magnitude more than
the same check as a `Bool` (state it through `List.all` and recover with `List.all_eq_true`), and a numeral at an
unsimplified type index is paid per numeral (so the table carries **no** `ZMod q` literals — vertices are `ℕ` ids
`v = x·q + y`, and the colours are packed into one `Nat` at 3 bits each, `unpackColor` from `Critical.lean:241`, the M04
rule that a `Nat` literal costs ≈ 2.3 KB of olean against ≈ 145 bytes per literal node). **So the certificate is: one
packed `Nat`, one `List ℕ` of circle ids, one `Bool`, one soundness theorem** (§S9). Its cost is measured, not assumed, in
phase K1's acceptance.

**D2 — which direction of the circle check is load-bearing.** The `Bool` must verify that the listed circle **covers** the
true circle (`∀ i < q², quadrance i = 1 → i ∈ list`), not that it equals it. A *missing* circle point drops edges, makes a
colouring easier and would make an unsound certificate look sound; a *spurious* point only makes the check harder. This is
`CLAUDE.md` G21's rule ("the finding and refusing sides fail in opposite directions") applied to the kernel: the check is
written in the direction whose failure mode is unsound, and the negative control is a certificate whose circle list is
missing one point, which must be refused.

**D3 — what the milestone can and cannot put in the kernel about tightness.** The advisor's sharpening of G54's classifier
is correct and is used throughout: adjacency eigenvalues are algebraic integers, so `λ_min = −d/(k−1)` rational forces
`(k−1) ∣ d = q + 1`; for six that is `5 ∣ q + 1`, which **fails at 23, 27, 31, 43, 47 and 67** — six-slackness there is a
divisibility theorem. It does **not** cover 59 and 79, where `5 ∣ 60` and `5 ∣ 80`: those need the explicit spectrum
(`λ_min = −14.9176 ≠ −12` and `−17.1019 ≠ −16`, recomputed here). *(The same caveat applies to 19, where `5 ∣ 20`; 19 is
decided at 5 and is not a window member, but the divisibility filter alone does not exclude it.)* **None of this enters the
kernel in this milestone**: the project has no spectral infrastructure — no `λ_min`, no Hoffman bound, no eigenvalue of an
adjacency matrix — and building it is FS-41's whole milestone. The window's slackness stays `[hand]`, stated with its
one-line proof, and the stub's P4 is scored as a theorem in the plan and nowhere else (§S7 D-6).

**D4 — the field half's kernel content does not wait on a digit, and its `q = 27` case is the expensive one, not the
cheapest.** For a candidate field `F` the kernel statement available today is at the level of the **ring**: a ring
homomorphism from the order `O_F` to `𝔽_q` is a graph homomorphism `unitQuadrance O_F →g UD(𝔽_q, 2)` (`unitQuadrance.map`,
kernel), so `(unitQuadrance O_F).Colorable k` for every `k` the plane admits. At `q = 23` and `F = ℚ(√2, √3, √31)` the hom
is `Adjoin.lift` three times with the roots `5² = 2`, `7² = 3`, `10² = 8 ≡ 31 (mod 23)` — three `decide`s, an hour. The
step from the ring to the field (`𝔭`-integrality of unit vectors) is row 57's standing hand gap, marked as such, unchanged
by this milestone. **At `q = 27` none of this is available**: `Adjoin d K` is `K[√d]`, a *quadratic* adjunction, and the
field `ℚ(√3, α)` with `α³ = α + 1` needs a cubic one; and `unitQuadrance R` needs a concrete `CommRing` with `DecidableEq`
that the kernel can compute in, which `𝔽₂₇` has not got here (Mathlib's `GaloisField 3 3` is a quotient type). Both are
bounded and real: a `Cubic e d K` on the basis `1, t, t²` with `t³ = e + d·t` and its `lift`, plus `𝔽₂₇` as a concrete
three-component ring with `decide`d axioms — about a day. **The advisor calls `ℚ(√3, α)` "the milestone's cheapest field
half"; it is the cheapest on paper and the most expensive in the kernel, and the subplan prices it as such.**

**D5 — exact maximum independent set at 23 is declined, with the reason.** The advisor files orbital branching over the
order-25,392 automorphism group as "the only instrument that could turn §3.4's reading into a proof … a real candidate for
phase B". It is not one: the target is `α ≤ 88` and the best node bound anybody can evaluate is the same triple-level
relaxation whose *global* value is 108.55 — a gap of twenty vertices that every node inherits, each node's bound costing
minutes — while resolution, the other proof system available, is measured undecided at every size from 106 to 140 (§S2.5).
Priced and declined; it returns to the table only if the relaxation's value at 23 falls below about 95.

**D6 — the finding side's missing instrument: peel-and-colour.** The Rust colourer is a tabu search on the number of
monochromatic edges over whole colourings; it never uses the independent sets the α search has already found. A
`k`-colouring of a vertex-transitive graph is naturally built the other way — peel a maximum independent set, recurse on
the rest — and at 23 the arithmetic makes that the *only* shape available: six classes must average 88.2, the best class
known is 87, so the first class must be at least 89 and the residual 440 vertices must then carry five classes averaging
88. So the finding side gets a second instrument: seed `plane-colour` with a verified independent
set pinned as one colour class and run the α search on the residual. The flag is **filed and not implemented** — FS-50's
engineer proposed `--pin-class` (D87) and FS-50 dropped the seeded-colouring phase *because at 83 no set near the threshold
existed to seed with, 52 % of it* — **and that reason is false at 23, where the best set is 87 of the 89 needed, 98 % of
it.** An instrument dropped for a reason that does not hold here is the cheapest thing on the list: about an hour of Rust
(§S5 A0.3). Its null is as informative as its hit — a residual whose α falls below `⌈440/5⌉ = 88` closes that branch exactly.

### §S5. Phases — cost, checkpoint, resume, acceptance

**The standing rules for every phase.** No `timeout` wall on any solve, ever (killing the wrapper kills the child: GNU
timeout arms `PR_SET_PDEATHSIG`). Every launch is `setsid`, writes its pgid to a file in the job's tmp, and is signalled by
pid or pgid — **never by a command-line match** (`pkill -f` / `pgrep -f` match the shell that runs them and other agents'
monitors; six recorded incidents). Every long run is launched from a snapshot copy of its script. One heavy job at a time;
**phase B does not begin until FS-50's two GPU jobs (pids 2808409, 2816615) and its polish loop are stopped at a
checkpoint** — the relaunch commands are in `plans/SESSION-HANDOFF-2026-09-15.md` §2, and stopping them forfeits nothing but
the minutes since the last chunk. Every new graph the milestone builds carries an `edges_sha256` in its record.

| phase | what | cost | **if it dies at any instant, the relaunch redoes** | acceptance |
|---|---|---|---|---|
| **A0** repair and instrument | **A0.1** restore `field_q27()` in `tools/fplane.py` (body at `.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`), add a `self-test` row for it, regenerate `data/fplane/chi-q27.json` with an `edges_sha256`. **A0.2** ship §S3's sweep as `tools/fplane_periodic_subgroups.py --self-test` with its three controls and file `data/fs53/periodic-q27.json`. **A0.3** two work orders to `~/source/descent-engine`: give `plane-colour --out` the per-tick rewrite `plane-independent` already has (its record is written once, at the end, `main.rs:485` — **every colour run over ~15 minutes currently violates the PROTECTED checkpointing rule**), and implement `--pin-class` (D6) | half a day, CPU | nothing — each step is minutes and idempotent | `fplane.py self-test` green with the `q = 27` row; `chi-q27.json` regenerated and its graph hash recorded; the periodic tool's three controls each seen to fire; a killed `plane-colour` leaves a readable record |
| **A** the finding side and the α ladder, all eight members | **A.1 α**, per member: `plane-independent` free; then seeds by rotation order over every divisor of `q+1`, the line quotients, and chaining through `--start` (the recipe that moved 574 → 597 at 83); target `⌈q²/6⌉`. **A.2 the colouring**, per member: `plane-colour --k 6` at a long budget, `--rotation-order/--tau` for the equivariant families, spectral seeding (threshold a random combination of the `λ_min` characters), and D6's peel-and-colour once A0.3 lands. **A.3** `fplane.py equivariant --p q --k 6`. At `q = 27` the Python path is the instrument (729 vertices); the Rust tools are prime-only and are **not** extended for it | 2 days, CPU, no GPU | **α: nothing** — `plane-independent --out` rewrites the record at every progress tick and `--start <that file>` resumes from its best set. **Colouring: everything since launch**, until A0.3 lands; until then each launch is capped at 15 minutes with its seed recorded (one thread at a seed reproduces byte for byte) | every run files a record with its budget, thread count, seed, `edges_sha256` and the word "not found", never "refused"; every null names its cause; each member's α bracket `[found, certified]` written into `data/fs53/window.md` |
| **B** the certificate side, ordered by §S2.2 | per member, on one GPU: the real-block program (`tools/fplane_sdp_blocks.py --real`), then `tools/fplane_cert_round.py --p q --blocks --real --chunk 500 --linear-solver gpu_indirect --scs-ckpt … --ckpt …`; the exact rational bound rounded **from a fresh short continuation's own dual, never from a long-run iterate** (SCS's adaptive scale is not checkpointed and drifts: 1082 against 1260 from the same solve); then the untouched `tools/fplane_cert_check.py` on the file, a second rounding of the same dual at a different cut and denominator, and `--ldl`. Order: **27** (five), **79**, **67** (six), **47**, **43** (five), **59** (six). 27 needs the prime-power extension of the stack — see §S7 D-5 and card 1 | 1–2 GPU-days for the prime members; +1.5 days of engineering if 27 is included | **the minutes since the last chunk**: the SCS iterate is saved every chunk to `data/fs53/ckpt/scs-q<q>-real.npz` and the rounding log to `data/fs53/ckpt/round-q<q>.jsonl` (**both outside `build/`**, which is scratch another agent may clean — clause 2 of the PROTECTED rule). Resume = the identical command | a checked certificate per member, or an honest "the relaxation's optimum is `V`, above the threshold `T`, so it decides nothing here" with `V` recorded. **Stop rule per member**: stop when the objective has stayed within 0.5 for 3,000 iterations *and* the rounding gap over the objective is below 100; halt and verify the moment a rounded `⌊N⌋` crosses the threshold |
| **B′** the side row at 17 | `plane-colour --p 17 --k 6` **before** `k = 5` (satisfiable is cheap, unsatisfiable is dear, and the 50-minute null on record at `k = 5` is the expensive question asked first). 289 vertices, degree 16 — note `17 ≡ 1 (mod 4)`, so the circle has `p − 1` points and isotropic vectors exist: it is **not** a window member and none of §S1's identities transfer | an hour | nothing (short runs) | one sentence carrying both halves: a six-colouring at 17 would be **the first six-chromatic single-distance graph over any field**, *and* it seals no number field, because `17 ≡ 1 (mod 4)` is outside `[Madore2015]` Cor. 3.4's hypothesis. Moorhouse's `χ(𝔽₁₇²) ∈ {5,6,7}` cell either way |
| **C** the field | **C.1, unconditional and now**: the ring-level reduction module for the candidate fields (§S9 K3), `Adjoin.lift` per field, and `tools/fplane_field_design.py` with its controls — `ℚ(√3,√11)` must return `{11, 83, 131, …}`, de Grey's field `{131, 479, …}`, ramified primes counted usable (`[Moorhouse2010]` Lemma 8.2, so `ℚ(√23)` sees 23), and a planted radicand that is a square everywhere refused by name. **C.2, only if a plane is decided `≤ 6`**: the field's `L(F) = 6` verified by Legendre symbols (seconds; a stranger checks it as a table of `±1`), the prediction `χ(F²) = 6` registered with its falsifiers, and the tight/slack consequence written out | C.1 an afternoon; C.2 an afternoon | nothing (all seconds-scale) | the designer's four controls each seen to fire; the reduction module green; C.2 does not start before C.1's controls pass and a digit exists |
| **D** the setting for a forcer | priced, not promised (the stub's §1(C)): the six-colouring census of a decided plane, its fan gaps, and M63's screen over a base in `F` | open | — | only on Kooshi's word |
| **E** the record | `data/fs53/window.md` and `README.md` rows; the ledger row with three trust levels per cell; G56 corrected to eight members with the `q = 27` exclusion line; the α growth law registered; FRONTIER re-ranked; `plans/FRONTIER-STUBS.md` updated; every conjecture the milestone surfaces minted as a stub or explicitly declined | half a day | — | `CLAUDE.md` under 200,000 bytes; the close updates § Frontier or the milestone is not closed |

**Kernel work (K1–K4), which runs beside A–C and waits on nothing except K4.** K1 the packed Cayley colouring certificate;
K2 the sixteen conditional consumers and the `χ = 6` schema; K3 the field half's ring reductions; **K4** the per-member
instance modules (`Instances/FinitePlane<q>.lean`), which exist only for a member phase A actually decides and are not
written before. Build **only** through `./scripts/build.sh` (never `lake build`, bare or named); `lake env lean <file>` is
for iteration and is not the gate. `./scripts/vacuity.sh` green, and the counts in `CLAUDE.md` § The gate updated in the
same commit that changes them.

### §S6. Expectations — the stub's, scored; the advisor's and the planner's, registered

**The scorecard replaces P1.** The stub's P1 ("at least one window plane is exactly six-chromatic") had the falsifier
"phase A's table reads five or ≥ 7 at all seven", which is **unreachable**: by §S2.2 the modal table has five or six
members still bracketed. P1 becomes a **per-member verdict with a stated cause and a stopping rule**, so that "undecided"
is a recorded outcome and not an escape hatch:

| verdict | what it takes |
|---|---|
| **= 6** | a verified six-colouring **and** five refused (a checked certificate, or a solver refusal an independent checker holds) |
| **≤ 6** | a verified six-colouring alone |
| **≥ 7** | six refused by a checked certificate |
| **≥ 6** | five refused by a checked certificate |
| **undecided** | with its cause, in numbers: the relaxation's converged optimum `V` against the threshold `T`, and the finding side's best conflict fraction at its budget |

**The stopping rule**, fixed now: a member closes as *undecided* when its certificate has met phase B's convergence rule
with `V > T`, **and** the finding side has spent at least four CPU-hours across at least three distinct instruments (free
tabu, equivariant, peel-and-colour or spectral seeding) with no hit. **And the cause is recorded in advance as independent
of χ**: a member is undecidable here because `frac6` sits 10–25 % below the instrument's measured reach and because
resolution's reach on these graphs is a residual density, not a size (§S2.5) — neither has anything to do with whether that
plane is six-chromatic. So the undecided set is **not enriched for six**, and "six lives in the ones you could not decide"
is closed before anyone reaches for it.

| id | prediction | confidence · falsifier · both outcomes reachable? |
|---|---|---|
| **P2** *(replaced)* | ~~χ sits one above the spectral floor~~ — **dead**: false at `p = 3` (floor 3, χ 3), the one Hoffman-tight plane in the table, and its omission flattered the reading (G21). **The replacement, the advisor's:** `χ = ⌈q²/α⌉` at every decided plane — these graphs have integrality gap below one | medium. True at 3 (α = 3) and 11 (α = 28); consistent at 7 (needs α ≤ 16, known `[14,17]`) and 19 (needs α ≤ 90, known `≥ 76`). **Not automatic** — Kneser graphs are vertex-transitive with arbitrarily large gaps. Falsifier: a plane with α and χ both pinned and `χ > ⌈q²/α⌉`. The dead reading is not carried in prose anywhere |
| **P3** *(widened)* | the certificate refuses **five** at 47 (frac5 0.9477), 43 (0.9362) **and 27** (0.9012) | high at 47 and 43; **medium-high at 27**, and the margin must be stated carefully: 0.9012 clears the worst reach ever measured — **0.8836, at 83, improved from 0.8974 by the polish loop's longer solve on the same formulation (the product owner, 2026-09-15), so the reach is a function of compute and not of the instrument alone** — by **1.8 %**, where the close's number gave 0.4 %, but the reach is not monotone in `q` (0.8444 at 11, 0.8238 at 23, 0.8974 at 83) and both small-`q` measurements sit below 0.845, so at `q = 27` the expected margin is ≈ 6 %, not 0.4 %. Falsifier: a converged `V ≥ ⌈q²/5⌉`. Both reachable |
| **P4** *(now a theorem, and narrower than stated)* | no window plane is six-tight | **proved** for 23, 27, 31, 43, 47, 67 by divisibility (`5 ∤ q+1`); **at 59 and 79, where `5 ∣ q+1`, by the explicit spectrum** (−14.9176 ≠ −12; −17.1019 ≠ −16). So over any field a window plane seals at six, the residue mechanism forces no pair and a six-forcer there is built, not transported |
| **P5** *(a control, not a prediction)* | for every real `F ⊇ ℚ(√3,√11)`, no prime in `(11, 83)` is usable | verified here; only 83 in `(11, 83]` has both `(3/p)` and `(11/p)` non-negative. It is the designer's **first self-test** (§S5 C.1) |
| **P6** | for a field `F` the milestone names, `χ(F²) = 6` | the conjecture's exposed sentence; only live if a plane is decided. Falsifiers unchanged: a five-colouring of `F²` local at no prime and non-additive, or a seven-forcer in `F²` |
| **Q1** *(planner; sharpens the advisor's "coin flip at 59")* | the certificate refuses six at **79 and 67 and not at 59** | medium-high. 59's `frac6` is 0.8382, below two of the three measured reaches, and the reach **worsens with q** (0.8238 → 0.8974 from 23 to 83), interpolating ≈ 0.87 at 59. Falsifier: a checked `N < 581` at 59. Both reachable |
| **Q2** *(planner)* | **no six-colouring is found at any window member in phase A** | medium-high, and it is the modal outcome the milestone must be worth having. Falsifier: one verified six-colouring — which is also the jackpot, so both outcomes are reachable and the prediction costs nothing to be wrong about |
| **Q3** *(the advisor's, adopted)* | `α(UD(𝔽₂₃,2)) ∈ {87, 88}`, so `χ(23) ≥ 7` — a **reading**, never reported as a bound | medium-high. Basis: 16 threads at 87 from second 2 to second 300 over 22,390 restarts, the same searcher's plateau equal to α exactly at 11, and 51 % of the 87-set's centred Fourier mass on the `λ_min` eigenspace against ~4 % for a uniform set. Falsifier: a verified 89-point independent set. One-sided: a local search can only raise α |
| **Q4** *(the advisor's law, adopted)* | `α/Hoffman ≈ ln d/√d`, i.e. α ≈ **86 / 102 / 147 / 226 / 261 / 366 / 416 / 539** at 23 / 27 / 31 / 43 / 47 / 59 / 67 / 79 — against six-thresholds 89 / 122 / 161 / 309 / 369 / 581 / 749 / 1041, a shortfall of **3.4 % at 23**, 8.7 % at 31, 16 % at 27, and 27–48 % everywhere above | every α measured in phase A scores it. Falsifier: a measured α more than 15 % off at any member. **This is the milestone's durable product in the modal outcome** (card 5) |
| **Q5** *(planner; measured at subplanning, §S3)* | no six-colouring of any window plane is constant on the cosets of a subgroup | measured exhaustively at `q = 27` for index 9 and 27, at a budget for 81 and 243; already known for the prime members' line families. Falsifier: a periodic six-colouring anywhere. The interest is that at 27 the family was 30,000 times larger than a line family and still empty |
| **Q6** *(planner)* | with P3 at 27, the milestone ends with **`χ(UD(𝔽₂₇,2)) ∈ {6, 7}`**, the narrowest bracket any finite Euclidean plane has ever had above 11 | medium — it needs both the prime-power extension of the stack (card 1) and P3 at 27. Falsifier: either half failing |

**Q4 scored before phase A, against every plane where α is already known or bounded below** (the product owner,
2026-09-15; `tools/fplane_review_verify.py` rebuilt each graph from `q` and re-verified each set from the definition —
28 at 11, 76 at 19, 87 at 23, each 0 internal edges). One thing differs per row: the law's prediction against the same
plane's α.

| q | degree | Hoffman | `ln d/√d` | Q4 predicts α ≈ | α known | predicted ÷ α |
|---|---|---|---|---|---|---|
| 3 | 4 | 3.00 | 0.6931 | 2.1 | **3** `[exact]` | 0.693 |
| 7 | 8 | 17.62 | 0.7352 | 13.0 | ≥ 14 | ≤ 0.926 |
| 11 | 12 | 34.55 | 0.7173 | 24.8 | **28** `[exact]` | 0.885 |
| 19 | 20 | 99.50 | 0.6699 | 66.7 | ≥ 76 | ≤ 0.877 |
| 23 | 24 | 131.76 | 0.6487 | 85.5 | ≥ 87 | ≤ 0.982 |
| 83 | 84 | 1199.46 | 0.4834 | 579.9 | ≥ 597 | ≤ 0.971 |

**The law under-predicts at six of six, and the bias is one-sided.** Where α is only bounded below the true ratio is at
most what is shown, so no row can rescue it. At the two planes where α is *exact* the shortfall is **11.5 % (q = 11)**
and 30.7 % (q = 3, the one Hoffman-tight plane in the table, which killed the old P2 reading and is excluded from any
fit here rather than leaned on). The residual **shrinks with `q`** — ≤ 2 % at 23 and ≤ 3 % at 83 — so the misfit is in
the law's *shape* at small `q`, not only in a missing constant.

**Registered before phase A.1 measures anything, with both outcomes reachable.** If the 11.5 % shortfall at `q = 11` is
the law's typical small-`q` bias, then α(23) ≈ **96–97**, which **clears** the six-threshold 89 — and that contradicts
**Q3** (α(23) ∈ {87, 88}, the advisor's 2:1 bet that 23 is empty) head-on. Phase A.1 at 23, targeting 89, separates them:
* a **verified 89-point set** confirms the bias correction, kills Q3, and puts six at 23 back in play;
* **another plateau at 87–88** confirms Q3 and shows the law's shape is wrong below `q ≈ 30`, so the close reports the
  law with a stated range of validity rather than as one formula.

Either way the close scores Q4 at eight new points **plus these six**, and the law's residual against `q` is the
milestone's durable product (R-4). *What this does not say:* nothing here bounds α from above at any member, and a
search plateau is never α — the exact points are 3 and 11 alone.

**What the bias-corrected law nominates, and the re-aiming it buys.** Take the law's constant from the one
**non-degenerate** plane where α is exact — `q = 11`, where α = 28 against the law's 24.78, so `c = 1.130` — and read
the eight members against their six-thresholds:

| q | law | × 1.130 | six needs α ≥ | margin |
|---|---|---|---|---|
| 23 | 85.5 | **96.6** | 89 | **+8.5 %** |
| 27 | 102.0 | 115.3 | 122 | −5.5 % |
| 31 | 147.2 | **166.3** | 161 | **+3.3 %** |
| 43 | 225.5 | 254.8 | 309 | −17.5 % |
| 47 | 260.6 | 294.5 | 369 | −20.2 % |
| 59 | 366.4 | 414.0 | 581 | −28.7 % |
| 67 | 416.4 | 470.5 | 749 | −37.2 % |
| 79 | 538.5 | 608.5 | 1041 | −41.5 % |

Read with Q4's own ±15 % falsifier band, this **nominates** rather than decides. Inside the band — so not excluded —
are **23, 27 and 31**; **43 sits just outside** it and **47, 59, 67, 79 are far outside** (20–42 % short), so under the
law those five cannot be six-chromatic at all and their finding side is predicted empty. **Two independent reasons now
point the same way as R-3**: the certificate is the decisive instrument from 43 up, and the search is the decisive
instrument at 23, 27 and 31 — which are exactly the members the certificate cannot reach for six (`frac6` 0.6755,
0.7531, 0.6701 against a reach of 0.8836).

**Consequence for §S13.2 A.1's order, fixed here:** the independent-set search runs **23 first (target 89), then 31
(target 161), then 27 (target 122)** — the three the law leaves live — and only then the five it predicts empty, where
a null is the expected outcome and costs the milestone nothing. α at 31 has never been searched at all.

*The honesty on the constant:* it rests on **one** non-degenerate exact point. With only `q = 3` (degenerate,
Hoffman-tight) and `q = 11` exact, a constant cannot be separated from a slope in `q`, and every other row is a lower
bound that can only push `c` up. So `c = 1.130` is a floor read from the cleanest point, not a fit; phase A.1's eight
measurements are what turn it into one.

**Q7 — the law has a theorem behind it on exactly half the window, and the residual should split there** (the product
owner, 2026-09-15; registered before phase A.1 measures anything). `[Krebs2022]`'s rule — `ω(UD(𝔽_q,2)) = 3` iff the
characteristic is 3 or 3 is a square in `𝔽_q`, else 2 — was **verified here directly rather than cited**, by searching
for a triangle (a pair of circle points whose difference is again on the circle) at **21 planes** spanning both
residue classes mod 4 (`q` = 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83):
**21 of 21 agree**, and the rule holds uniformly in `q mod 4`, not only at `q ≡ 3`.

**The split itself is prior art, and older than Krebs — state it that way.** `[Vinh2008]` **Theorem 13** classifies the
triangle-free finite Euclidean graphs (attributing the elementary proof to Vinh–Dung and noting it also follows from the
association schemes' character tables), and his §3 uses exactly our triangle-free members — *"a prime of form
`q = 12k ± 5`"*, which for `q ≡ 3 (mod 4)` is `q ≡ 7 (mod 12)`, i.e. 3 a non-square — as **explicit Ramsey graphs**,
disproving a conjecture of Chvátal and giving `R(3, k) ≥ Ω(k^{4/3})`; his Theorem 12 is the ratio-bound upper bound
`α ≤ (4 + o(1))·q^{3/2}` already in our bibliography. So *neither* the split *nor* an upper bound on `α` is ours. **What
Q7 registers is only that the growth law's residual splits along that line** — which Vinh does not consider, since he
wants `α` small for Ramsey purposes and never asks how large it actually is (the bibliography row records "no exact
value, no construction, the question not posed").

The split runs exactly **four and four** across the window:

| | members | 3 in `𝔽_q` |
|---|---|---|
| **ω = 3**, contains triangles | **23, 27, 47, 59** | a square (27: characteristic 3) |
| **ω = 2**, triangle-free | **31, 43, 67, 79** | a non-square |

*Why that should matter to the law.* For a **triangle-free** graph, Shearer's bound (with Ajtai–Komlós–Szemerédi behind
it) gives `α ≥ (1 + o(1))·n ln d / d`. Since `|λ_min| ≈ 2√q` by Weil and `d = q + 1`, the ratio bound is
`≈ 2n/√d`, so Q4's law is `α ≈ (2n/√d)(ln d/√d) = 2n ln d / d` — **asymptotically exactly twice Shearer's bound**, and
the measured constant makes it about 2.26 times. For the **ω = 3** half no comparable lower-bound theorem applies:
triangles suppress independence at a given degree, and there is no Shearer there. So **the law is a theorem's shadow on
the triangle-free half of the window and a pure fit on the other half** — an asymmetry the law as registered does not
mention, and one that predicts its residual is not a single constant.

**Q7, stated:** `α / law` is systematically **larger on the triangle-free members (31, 43, 67, 79) than on the ω = 3
members (23, 27, 47, 59)**. Present evidence is weak and mostly one-sided, which is why it is registered rather than
claimed: ω = 2 gives ≥ 1.080 at 7 and ≥ 1.140 at 19; ω = 3 gives 1.130 *exactly* at 11, ≥ 1.018 at 23, ≥ 1.030 at 83,
and 1.443 at the degenerate `q = 3`. *Falsifier:* phase A.1's eight measured ratios showing no separation by `ω`, or a
separation in the other direction. *Both outcomes reachable:* A.1 produces a number at every member either way, and the
split is 4–4, which is the cleanest natural experiment the window offers.

**The split is not a second fact — it IS the exclusion, and that has a strategic consequence.** Both halves are the
same Legendre symbol. `ω = 2` iff `(3/q) = −1`; and a prime is usable for a field only if every radicand is a square or
zero there, so `(3/q) = −1` is exactly *"no field containing `√3` can use `q`"*. Verified together at all eight members
(the product owner, 2026-09-15), which also re-verifies G56's exclusion from scratch:

| q | `(3/q)` | `(11/q)` | excluded by | ω |
|---|---|---|---|---|
| 23 | square | **non-square** | 11 | 3 |
| 27 | 3 = 0 (ramified, usable by `[Moorhouse2010]` Lemma 8.2) | **non-square** | 11 | 3 |
| 31 | **non-square** | **non-square** | 3 and 11 | 2 |
| 43 | **non-square** | square | 3 | 2 |
| 47 | square | **non-square** | 11 | 3 |
| 59 | square | **non-square** | 11 | 3 |
| 67 | **non-square** | **non-square** | 3 and 11 | 2 |
| 79 | **non-square** | square | 3 | 2 |

So the window's 4–4 split by clique number **coincides exactly** with the split by *which* radicand does the excluding:
the four members excluded by `√3` (31, 43, 67, 79) are precisely the triangle-free four, and the four excluded only by
`√11` (23, 27, 47, 59) are precisely the four with triangles.

**What follows, and it aims phase C.1.** Every field this project has ever built contains `√3` — it is what the Moser
spindle needs — so **such a field can reach only the four members with triangles**, which is exactly what G56's named
candidates do (`ℚ(√2,√3,√31)` sees 23, `ℚ(√2,√3,√7)` sees 47, `ℚ(√3, α)` with `α³ = α + 1` sees 27). A field reaching
**31, 43, 67 or 79 must contain no `√3` at all** — hence no Moser spindle, hence none of the project's five-forcers, so
its own five-chromaticity would have to be established from nothing. **C.1's designer must report that split explicitly
per candidate**, because "this field sees 43" and "this field sees 23" are not the same kind of object: the first is a
field the hunt has never worked in. And the two halves are also where the growth law does and does not have a theorem
behind it (above), so the arithmetic exclusion and the Ramsey structure are one fact seen twice.

**Why it is worth registering rather than noticing at the close.** If it holds, the milestone's durable product (R-4)
stops being a fitted curve and becomes a **two-constant law with a structural reason** — `c₂` on the triangle-free half,
where a theorem already bounds it below, and `c₃` on the half where triangles bind — which is the programme's own
preference for a derivation over an object. And it is **directly actionable for six**: at a uniform `c = 1.130` the two
nominated members are **23 (ω = 3, +8.5 %)** and **31 (ω = 2, +3.3 %)**, one from each class; if the residual splits as
predicted, 31 gains and 23 loses, and which of the two is the better six-candidate can **reverse**. So A.1 measures
both before either is called — which is what its order already does.

### §S7. Decisions settled at subplanning (choice · alternative · why · confidence)

| # | choice | alternative | why this one | confidence |
|---|---|---|---|---|
| D-1 | the milestone's object is **α**; the table's rows are α brackets `[found, certified]` and χ is derived by `⌈q²/α⌉` | a table of χ, as stubbed | the same runs produce it, every cell is then informative instead of "undecided", and it is the one quantity both sides of the milestone bound — the finding side from below, the certificate from above | high |
| D-2 | phase B runs **27, 79, 67, 47, 43, 59**, and never 23 or 31 for six | the stub's "23 and 47 first" | arithmetic, not preference: `frac6` at 23 and 31 is 0.675 and 0.670 against a best-ever reach of 0.824 — a GPU-day there returns a number that decides nothing, and the same day at 79, 67 and 27 returns verdicts | high |
| D-3 | the **finding side runs first, on the CPU, before any GPU** | the stub's GPU-first phase A | the positive outcome is one colouring away and the negative needs eight refusals; the cheap side is the decisive side; and the GPUs are occupied by FS-50 until they are stopped at a checkpoint | high |
| D-4 | a colouring certificate is a **packed Cayley `Bool`** — one `Nat` table, a circle list, `(q+1)·q²` checks | `FinitePlane11.lean`'s all-pairs `decide +kernel` | the all-pairs form is `q⁴`: 3.4 M tests at 43 against 81 k, and the Cayley hypothesis is what `addCayleyColoring` already consumes. The factor is `q²/(q+1)`, 22× at 23 and 42× at 47 | high on the shape; the constant is measured in K1's acceptance, not assumed |
| D-5 | whether to extend the SDP producer, the block builder and the frozen checker from prime fields to **prime powers** is **Kooshi's** (card 1); the planner recommends yes | keep the stack prime-only and drop 27 from phase B | it is ~1.5 days of engineering against the narrowest bracket in the window and the only member where the certificate can raise a floor that is not already 6 — but it touches a frozen checker, which is a decision above the planner | recommendation; medium on the estimate |
| D-6 | the tight/slack classification stays **`[hand]`**; nothing spectral enters the kernel | prove the divisibility theorem in Lean | there is no `λ_min`, no adjacency spectrum and no ratio bound in this library; that infrastructure is FS-41's entire milestone, and the divisibility argument is one line on paper | high |
| D-7 | the field half's **ring-level reduction lands now** (unconditional, an hour per field); the `L(F) = 6` half waits on a digit | the stub's phase C as one block after phase A | the reduction needs no digit, and a phase that cannot start is a phase that quietly grows; the advisor's "the field half is an afternoon once a prime exists and a sink before" is right about the second half only | high |
| D-8 | `q = 27`'s field half is priced at **about a day of Lean**, not an afternoon | take the advisor's "cheapest field half" at face value | `Adjoin d K` is `K[√d]` — quadratic — and `ℚ(√3, α)` with `α³ = α + 1` needs a cubic adjunction; and `unitQuadrance` needs a concrete `CommRing` with `DecidableEq` that the kernel can compute in, which `𝔽₂₇` has not got here. Cheap on paper, expensive in the kernel | high |
| D-9 | exact maximum independent set at 23 (orbital branching) is **declined** | the advisor's "a real candidate for phase B" | the target is `α ≤ 88`, every node inherits a bound of 108.55 costing minutes to evaluate, and resolution is measured undecided at every size from 106 to 140. It returns only if the relaxation at 23 falls below ≈ 95 | high |
| D-10 | the desktop only; **no server at any branch** | ask for the 256-core machine | nothing on the list is bound by cores: the certificate is one GPU stream, the searches are 12–16 threads, and a server-day returning "undecided" is the failure clause at full price | high |
| D-11 | the stub's §0.4 conditional (`no six ⟹ χ(ℝ²) ∈ {5,7}`) is **not promised**, and the close says why | keep it as the headline | it needs all eight members decided; at most two refusals are available. Stating it and missing it is the rescoping the mission rule forbids — "not landed" is a complete sentence | high |
| D-12 | one implementer at a time, phase by phase, each with its own checkpoint and resume line in this file | a single long implementation session | Kooshi's halt, the PROTECTED checkpointing rule, and FS-50's own record of what an unresumable multi-hour run costs | high |

### §S8. Gap audit — every promise in the stub, and every card of the advisor's

| promise | status |
|---|---|
| §1(A) the prime: a six-colouring **and** a refusal of five, per member | **planned, narrowed**: phase A (colouring) and phase B (refusal). The refusal of five is available at 27, 43, 47 and nowhere else in the window; at 23 and 31 it is out of reach and the subplan says so instead of budgeting for it (§S2.5) |
| §1(A) the LRAT route for five, by cube-and-conquer over the rotation orbits | **dropped with reason**: FS-50 measured resolution's reach on these graphs as a residual density (≈ 0.41), not a size — at 23 the monolith is undecided at every `N` from 110 to 140, above the ratio bound. No cube tree lifts it |
| §1(B) the field with `L(F) = 6` | **split**: the ring-level reduction is unconditional and lands in phase C.1; `L(F) = 6` is phase C.2 and waits on a digit |
| §1(C) the six-forcer in `F` | **unchanged**: not promised; phase D, priced, only on Kooshi's word |
| §2 the window table | **corrected**: eight members, not seven — `q = 27` added with its exact spectrum, its thresholds and the extra line the exclusion argument needs there. `CLAUDE.md` G56 and the stub's §2 both carry the seven-member list and are corrected at the close |
| §2 the "+1 over the spectral floor" reading | **dead**, replaced by `χ = ⌈q²/α⌉` (P2); not carried in prose |
| §4 A: "a GPU-day … starts with 23 and 47" | **re-ordered** to 27, 79, 67, 47, 43, 59, by §S2.2's arithmetic; and the finding side moves ahead of it (D-3) |
| §4 A: both SDP formulations, "where the extra rows bind is itself a finding" | **already measured and settled at FS-50's close**: the extra `le_diag` rows are valid, new, and inactive at 11 and 23 (29.176799 both ways; 108.546073 both ways, one tool, one tolerance). Recorded as a known unexploited strengthening; revisited only if two solves at one member converge to different values at equal tolerance |
| §4 B: `chromaticNumber (unitQuadrance (ZMod p)) = 6` per prime | **planned as K4**, written only for a member phase A decides; the schema and the sixteen conditional consumers (K2) land first and need no digit |
| §4 C: `χ(F²) ≤ 6` in the kernel | **restated honestly**: the kernel holds the *ring* statement; the ring-to-field step is row 57's standing hand gap, marked, unchanged |
| §4 D: the setting for a forcer | unchanged, priced |
| §7 `data/fs53/window.md`, `cert-q<q>-N<N>.json`, `tools/fplane_field_design.py`, `Instances/FinitePlane<q>.lean`, the field module, the ledger row, the FRONTIER re-rank | all planned; **added**: `tools/fplane_periodic_subgroups.py` + `data/fs53/periodic-q27.json` (A0.2), the `field_q27` restore (A0.1), and two `descent-engine` work orders (A0.3) |
| §PA.1 phase A′ at 17 | **planned as B′**, with the advisor's two changes (ask `k = 6` first; both halves in one sentence) |
| §PA.3 item 4: the designer counts ramified primes as usable | **planned** as the designer's control (`ℚ(√23)` must see 23) |
| the advisor's card 1 (is any window plane six-colourable?) | **answered in part and planned**: the first measurement ran before the planner (`data/fs53/README.md`, nulls at 23, 31, 43, 47); `q = 27`'s periodic family exhausted here (§S3); the rest is phase A.2 |
| the advisor's card 2 (α at 23) | **phase A.1**, first member, first instrument |
| the advisor's card 3 (does the window have eight members?) | **yes, adopted** — §S1, with the `q = 27` exclusion line |
| the advisor's card 4 (where should the GPU-day go?) | **adopted and extended**: reordered, and 27 added at the front, which the card did not have |
| the advisor's card 5 (the digits or the growth law?) | **to Kooshi** (§S10 card 5), with the planner's recommendation |

### §S9. The skeleton — every statement the milestone will prove that does not wait on a digit

Two modules, added to the flat import surface `Proofs.lean` and to `ARCHITECTURE.md` § 3
(`tools/check_architecture.py` reads PASS). Both **elaborate** — checked with `lake env lean`, which
builds nothing; **the real gate is `./scripts/build.sh`**, deliberately not run here because FS-50's two
GPU solves were live and this machine runs one heavy job at a time. Running it is the implementer's
first act.

**`Proofs/HadwigerNelson/CayleyCertificate.lean` — K1, the packed Cayley colouring certificate.**
Vertex identifiers (`toId`, `ofId`, `addId`, `quadId`), the certificate `CayleyCert.Cert` (modulus,
colour count, field width, one packed `Nat`, one circle list), the three `Bool`s (`covers`, `proper`,
`check`), the colouring `Cert.colouring` and the soundness theorem `Cert.sound`. Five identifier lemmas
and `sound` are the `sorry` leaves. **The spec is validated where it is cheap**, and this is not
decoration: four `#guard`s pin the identifier arithmetic at `q = 11`, and `cert3` — the plane over `𝔽₃`,
circle `[1, 2, 3, 6]`, the colouring `(x, y) ↦ x + y` packed two bits per vertex into the single number
`74340` — **passes `check` in the elaborator**, so the format is exhibited end to end before anything
large is attempted and `sound`'s hypothesis has an inhabitant in the same file. Two reds sit beside it:
the same certificate with an **empty circle list** must be refused (the covering direction doing its
job), and with **one bit of the table flipped** must be refused (properness doing its).

**`Proofs/HadwigerNelson/Instances/SixthColour.lean` — K2 and K3.** The equality schema
`chromaticNumber_eq_succ_of_colorable_of_indepNum_le` (the milestone's headline shape: a verified
colouring is the upper half, a certified independence bound the lower, and neither alone is a digit);
the seven prime members' six-colour thresholds and the three remaining five-colour ones, with their
vertex counts — ten `norm_num` facts and ten one-line consequences of
`add_one_le_chromaticNumber_of_indepNum_le`, all proved, no leaves; and the field half at the level of
the ring — the order `O23 = ℤ[√2, √3, √31]`, its residue homomorphism `O23.res` (`√2 ↦ 5`, `√3 ↦ 7`,
`√31 ↦ 10`, three `decide`s) and `colorable_unitQuadrance_O23`. The schema is the module's one leaf.

**The `sorry` inventory — seven leaves, every one a tracked obligation of this milestone, none a
conjecture.** Nothing below is a statement that might be false: each is a lemma whose proof is routine
and whose route is named, and the milestone's *open questions* appear only as **hypotheses** of
conditional theorems, never as `sorry`d conclusions.

| leaf | route |
|---|---|
| `toId_lt`, `ofId_toId`, `toId_ofId` | `ZMod.val_lt`, `ZMod.val_cast_of_lt`, `Nat.div_add_mod`; `Nat.lt_of_div_lt_div` for the bound |
| `toId_add` | `ZMod.val_add` and `Nat.add_mul_mod_self`; the one place identifier arithmetic meets `ZMod` arithmetic, and the only lemma `sound` needs |
| `mem_unitCircle_iff` | `ZMod.natCast_self_eq_zero` and `ZMod.val_cast_of_lt`, with `Fact (1 < q)` giving `(1 : ZMod q).val = 1` |
| `Cert.sound` | `List.all_eq_true` twice to recover the per-element forms, `mem_unitCircle_iff` and `toId_add` to move to identifiers, then `addCayleyColoring` and `unitQuadrance_eq_addCayley` |
| `chromaticNumber_eq_succ_of_colorable_of_indepNum_le` | `le_antisymm (hcol.chromaticNumber_le)` against `add_one_le_chromaticNumber_of_indepNum_le hα hlt`, cast in `ℕ∞`. Two lines; **left open here because implementation is paused, not because it is hard** |

**What is deliberately absent.**
* **No statement about `q = 27`.** `finitePlane q` is `unitQuadrance (ZMod q)`, the plane over the *ring*
  `ℤ/q`; at 27 that is not the finite Euclidean plane, and `ℤ/27` is not `𝔽₂₇`. Instantiating any
  theorem here at 27 and reading it as a statement about the window's eighth member would be exactly the
  characteristic failure this project guards against — proving the wrong theorem efficiently. Both
  module docstrings say so in those words, and the plane over `𝔽₂₇` waits on §S7 D-8's concrete field.
* **No `Instances/FinitePlane<q>.lean`** (K4). Those exist only for a member phase A actually decides,
  and their data does not exist. A `sorry`d `(finitePlane 23).Colorable 6` would be a conjecture wearing
  a skeleton's clothes.
* **Nothing spectral** (§S7 D-6), and **no five-refusal by resolution** (§S8).

**Gate notes for the implementer.** The seven leaves are FS-53's tracked `sorry`s and the milestone's
close must show zero; `./scripts/vacuity.sh`'s counts in `CLAUDE.md` § The gate move when these modules
land and must be re-recorded in the same commit; the threshold theorems assume a `≤` between naturals,
so they create no carrier site, the schema is parametric (`GENERIC`), and `Cert.sound`'s structure
hypothesis has `cert3` as its named inhabitant in the same file.

### §S10. What is being put to Kooshi

**Four** cards, in the planner's report in the house format. In one line each, with the planner's
recommendation and the default if Kooshi says nothing:

1. **Extend the certificate stack from prime fields to prime powers**, so `q = 27` can be certified —
   *yes* (about 1.5 days, and it touches the frozen checker). Default: no; 27 gets the finding side only.
2. **Two `descent-engine` work orders** — a per-tick record for the colourer (a live breach of the
   PROTECTED checkpointing rule) and `--pin-class` for peel-and-colour — *yes, both* (about an hour each).
   Default: neither; colour runs stay capped at 15 minutes and peel-and-colour is dropped.
3. **Does the certificate phase run at all**, given that it can never *find* a six? — *yes, one to two
   GPU-days, ordered 27, 79, 67, 47, 43, 59*. Default: it runs, after the finding side's first two days.
4. **The milestone's durable product: the digits, or the growth law of α?** (the advisor's card 5) — *the
   law, with "is six ever attained" as its corollary*. Default: record both, lead with the law.

Two questions the stub left open are **settled here and not put to him**: how long the finding side runs
before a member closes as undecided (§S6's stopping rule — four CPU-hours across three instruments), and
whether phase D is priced or promised (priced, §S5).

### §S11. The data layout

Two committed files carry the milestone's state, and every phase writes into them rather than into prose.

* **`data/fs53/window.md`** — the table, one row per window member, **three trust levels per cell**: `[exact]` (exact
  arithmetic, reproducible from `q` alone), `[cert]` (an exact rational certificate a stranger re-checks with
  `tools/fplane_cert_check.py`), `[solver]` (a SAT solver's word, untrusted), `[search]` (a local search — a verified
  object when it says *found*, a **null at a budget** when it says *not found*), `[kernel]`. It also fixes the file names
  (`cert-q<q>-N<N>.json`, `alpha-q<q>-ge<size>.json`, `colour-q<q>-k<k>.json`, `periodic-q27.json`,
  `ckpt/scs-q<q>-real.npz`, `ckpt/round-q<q>.jsonl`, `field-q<q>.json`) and carries the designer's specification with its
  four controls.
* **`data/fs53/README.md`** — one row per file, and the row format is fixed: file · what it is · budget · verdict ·
  claim scope. `not_found` and `unknown` are written in those words and are never "refused". Two standing rules are
  recorded there: every graph carries an `edges_sha256` (the finding and refusing sides fail in opposite directions), and
  an iterate is never a bound (FS-50 measured a long-run iterate rounding 200 above its own objective).

`tools/fplane_periodic_subgroups.py` (§S3's measurement, with its three controls and `--self-test`) and
`data/fs53/periodic-q27.json` are committed with this subplan, so the two `q = 27` findings are reproducible from the
number 27 rather than resting on the planner's word.

### §S12. Modeling passes (WORKFLOW step 5; de Bruijn, 2026-09-15, each a fresh skill invocation on §S and the skeleton)

**§S12.1 Domain modeling — the verdicts, each a decision in four parts (numbered on from §S7).**

| # | choice | alternative | why this one | confidence |
|---|---|---|---|---|
| D-13 | **`CayleyCert.Cert` is generic over an identifier arithmetic**: a structure `IdArith R` for a finite commutative ring `R` bundling `toId : R × R → ℕ`, `ofId`, `addId`, `quadId` and their three laws (`ofId_toId`, `toId_add`, and `quadId (toId v) = 1 ↔ v.1² + v.2² = 1`); `check` and `sound` are stated and proved **once** over `[CommRing R] [Fintype R] [DecidableEq R] (A : IdArith R)`, and `ZMod q` (the planner's `x·q + y` arithmetic) is the first instance | the skeleton as committed: `Cert` hard-wired to `ZMod q`, with the eighth member excluded by a docstring | the certificate's intrinsic structure is "a Cayley graph on the additive group of `R²` whose connection set is computed from the ring"; the carrier `ZMod q` is incidental to the seven prime members and false for `q = 27`. The generic form costs nothing in the proof (`sound` is the same Cayley argument) and turns the documented trap into a **type**: a certificate over `𝔽₂₇` needs `IdArith F27`, and `IdArith (ZMod 27)` honestly certifies the ring `ℤ/27`'s graph and nothing else. The second instance is named and priced (D-8, card 1), so this is not a typeclass with one use | high |
| D-14 | **the sixteen per-member threshold theorems are dropped from the skeleton**; K2 keeps the equality schema plus one `finitePlane` form, `(hlt : k * a < q * q) → indepNum ≤ a → (k + 1 : ℕ∞) ≤ χ`, and a per-member named statement is minted by K4 only when its certificate exists (exactly as FS-50 did at 83) | keep the sixteen, each `simpa using add_one_le_chromaticNumber_of_indepNum_le … six_mul_lt_card_finitePlane<q>` | N declarations identical modulo a numeral are a table wearing declarations' clothes; the role is already named (`add_one_le_chromaticNumber_of_indepNum_le`), the arithmetic side conditions are `norm_num` at use time, and sixteen statements a reader must audit buy nothing a one-line instantiation does not | high |
| D-15 | **the equality schema lives in `LocalGlobal.lean`** beside `add_one_le_chromaticNumber_of_indepNum_le`, as that definition's lemma API; `Instances/SixthColour.lean` keeps the field half and the window's spec examples | leave it in the Instances module | a general statement about any finite graph is library, not instance; a consumer looking for "colouring + independence bound ⟹ χ exactly" looks next to the bound it already uses | high |
| D-16 | **the `𝔽₂₇` plane needs a `CommRing`, not a `Field`** — `unitQuadrance R` is defined over any commutative ring, so the eighth member's carrier is a hand-rolled triple `(a, b, c) : ZMod 3 × ZMod 3 × ZMod 3` with multiplication reduced by `t³ = t + 1`, its ring axioms by `decide +kernel` over 27³ cases, and no inverse anywhere; the order's residue map is `AdjoinRoot.lift` from `AdjoinRoot (X³ − X − 1)` over `Adjoin 3 ℤ` (noncomputable is fine for a *theorem*; computability is needed only where the kernel evaluates `check`, i.e. on `F27`) | D-8 as priced: "a day of Lean", a cubic adjunction structure of our own | it removes the `Field` instance and the bespoke cubic tower from the price; what remains is an afternoon: the triple ring, `IdArith F27` (base-3 digits, digitwise addition, the quadrance by polynomial multiplication), and the lift. D-8's pricing is revised to **half a day**, still Kooshi's card 1 for the *tools* side (the SDP producer, block builder and frozen checker for prime powers), which this decision does not touch | medium-high — the one fact that would change it: `decide +kernel` on 19,683 associativity cases proving slower than expected, in which case the axioms are proved by `ring`-style rewriting over the triple instead |

**Seams validated.** The model of the hypotheses: `cert3` (the 3-plane, three colours) is the inhabitant of `Cert.check = true` and stays; under D-13 it becomes `IdArith (ZMod 3)`'s inhabitant. The unsampled member: a `Cert` with `k = 0` is refused by `check` (the `0 < k` conjunct), and a `Cert` over `ZMod 1` — every point is the origin and the circle is empty — is where `Fact (1 < q)` earns its place in `sound`. The adversarial member the planner already pinned: a circle list one point short **must** fail `covers` (negative control kept). The next theorem for free: with D-13 the same `sound` gives `χ(UD(𝔽₂₇,2)) ≤ 7` from `data/fs53/colour-q27-k7-quotient.json` the day `IdArith F27` exists, with no restatement — the test the incidental `ZMod q` shape fails.

**Not changed by the pass.** The covering direction of `covers` (the planner's reasoning is right and the negative control is the right one); the packed-`Nat` table and `unpackColor` (M04's rule); the `ℕ`-identifier arithmetic itself (kernel cost, not model); α as the object with χ derived (D-1).

**§S12.2 Obligation modeling — the proofs the skeleton owes, partitioned and localised.**

*The partition.* **Prove:** `CayleyCert.sound` (once, generically under D-13); the identifier-arithmetic laws as the
fields of `IdArith (ZMod q)`; the equality schema; the ring-level reduction (already closed: `h.of_hom
(unitQuadrance.map O23.res)`). **Test:** `cert3` (`#guard cert3.check`), the two negative controls (a circle one point
short, a table one bit off — each `#guard !check`), the four `#guard`s on `toId`/`addId`/`quadId`, and — added by this pass —
**the model of `sound`'s hypothesis at a window prime:** `cert23_8 : Cert`, the line-periodic eight-colouring of the 23-plane
(`data/fplane/periodic-below-71.json`, lifted) packed into a table, `#guard cert23_8.check`, and
`example : (finitePlane 23).Colorable 8 := CayleyCert.sound …` — the first kernel-checked upper bound at any window member,
a positive control for the whole K1 pipeline before any digit, and the inhabitant that keeps `colorable_unitQuadrance_O23`'s
hypothesis from being vacuous (it is: χ(23) ≤ 8 is on record). **Assume:** `Fact (1 < q)` / `NeZero q` only; every threshold
hypothesis `indepNum ≤ a` is the certificate's, discharged outside the kernel and stated as a hypothesis, never a `sorry`d
conclusion (§S9's rule).

*`sound`, derived — the statement from which the proof falls out.* `unitQuadrance R` is `addCayley (unitCircle R)` (the
identification `unitQuadrance_colorable_of_quotient` already runs through; if it is not a named lemma it is one line from
`unitQuadrance_adj`), so `sound` is `addCayleyColoring tab h` with `tab := colouring c hk` and the one local obligation
`∀ s ∈ unitCircle, ∀ v, tab (v + s) ≠ tab v`. Its case table has one row: fix `s` on the true circle and `v`; **(i)** `covers`
at `toId s` (which `List.range (q*q)` reaches by `toId_lt`) gives `toId s ∈ c.circle`, using `quadId (toId s) = 1` from the
law `mem_unitCircle_iff`; **(ii)** `proper` at that listed `s` and at `toId v` gives
`unpack (toId v) ≠ unpack (addId (toId v) (toId s))`; **(iii)** `toId_add` rewrites the right side to `unpack (toId (v + s))`.
Three named `have`s, each two lines; `0 < k` is spent only in `colouring`'s `Fin c.k` and `Fact (1 < q)` only in `NeZero` and
`ZMod.val_one`. The symmetric direction (`v = u − s`) is not a second case: the true circle is closed under negation, so
`addCayleyColoring`'s hypothesis over the *true* circle already covers it — which is why `covers` quantifies over the true
circle and `proper` over the listed one.

*The laws of `IdArith (ZMod q)`, each local.* `toId_lt`: `val_lt` twice and `omega`. `ofId_toId` / `toId_ofId`:
`Nat.add_mul_div_left`, `Nat.add_mul_mod_self_left`, `ZMod.val_lt`, `ZMod.natCast_zmod_val` (query, do not recall:
`exact?` on each). `toId_add`: `ZMod.val_add` (`(a + b).val = (a.val + b.val) % q` under `NeZero q`) on each component, then
the two identities above. `mem_unitCircle_iff`: `ZMod.val_add`, `ZMod.val_mul` (or `val_pow`), `ZMod.val_one` (needs `1 < q`),
and `ZMod.val_injective`; the `%` on the identifier side matches the `val` of the sum. Every one is arithmetic over `ℕ` after
the `val` lemmas and closes by `omega` or `simp only [...]` with the lemma named — no `unfold` at a use site (the definitions
`toId`/`addId`/`quadId` are sealed by these five lemmas, their whole API).

*The schema.* `le_antisymm (hcol.chromaticNumber_le) (add_one_le_chromaticNumber_of_indepNum_le hα hlt)` after the cast
`((k + 1 : ℕ) : ℕ∞)` is normalised — two lines; if `Colorable.chromaticNumber_le`'s name has moved, `exact?` finds it.
Under D-15 it lives in `LocalGlobal.lean`; moving it rebuilds that module's dependents, so the **implementer** moves it as
part of K1, not the planner now.

*The mutation audit, registered before any proof is written (each must break a named step).* Drop `covers` from `check` →
`sound` fails at (i) and the short-circle control passes `check`, so the theorem would be false. Reverse `covers`'s direction
(listed ⊆ true) → (i) fails: a true circle point may be unlisted. Drop `0 < k` → `colouring`'s `Fin c.k` is empty at `k = 0`.
Drop `Fact (1 < q)` → `ZMod.val_one` fails and at `q = 1` the plane is a single loopless point where `check` passes for
every table. Delete `toId_add` from the proof → (iii) fails and `proper` says nothing about `v + s`. A statement whose
weakenings all still prove was vacuous; each of these must go red, and K1's acceptance says which line each one breaks.

*Kernel cost, as an obligation.* `check` at 47 is `48 · 2,209 ≈ 106,000` `unpackColor` pairs (GMP shift-and-mask on one
≈ 6,600-bit `Nat`) plus `2,209` `quadId`s each against a 48-element `List.contains` — seconds under `decide +kernel`, measured
at K1's acceptance beside `FinitePlane11.lean`'s all-pairs cost (D-4's constant). `List.range (q*q)` is one `q²`-node list per
`check`, never rebuilt inside the inner `all`; nothing here is `Nat.fold` or an `insert`-grown table (`CLAUDE.md` § The
kernel's cost model).

*Not obligations of this milestone:* the tight/slack sign and the `(k−1) ∣ (q+1)` divisibility (D-6, `[hand]`); the law
`χ = ⌈q²/α⌉` (a registered reading scored by measurement); the field-level step from the order to the field (row 57's gap,
FS-47).

**§S12.3 Experience modeling — the surfaces a stranger, an implementer, Kooshi and the kernel each meet.**

*The stranger who checks an upper bound* holds a colouring record and a definition. `plane-colour`'s records carry the
vertex convention (`v = x·p + y`), the edge rule, the edge hash and the colouring, so a twenty-line script from the
definition re-verifies them; the 𝔽₂₇ record `colour-q27-k7-quotient.json` carries its modulus and its own convention (base-3
digits, `x` then `y`) for the same reason. **The defect this pass found:** `periodic-q27.json` reports `best_k_found = 7`
and names the subspace but carries **no colouring**, so the ceiling it advertises was not checkable from the file — the
review filed the colouring separately, `window.md` now cites that file, and **A0.2's acceptance gains a line: the tool
writes the colouring behind `best_k_found` (a `best_witness` field), so every "χ ≤ k" a record states is re-checkable from
that record alone.** The wire's one safety property, stated so it is not re-derived at every certificate: a vertex-convention
mismatch between a record and `IdArith`'s `toId` can only make `check` refuse a good certificate (a permuted table is not a
colouring; a table permuted by a plane automorphism such as `(x, y) ↦ (y, x)` is still a colouring), never make a false
theorem true, because the kernel re-checks properness against the true circle.

*The stranger who checks a lower bound* holds the FS-50 surface unchanged: the certificate JSON, `tools/fplane_cert_check.py`
(frozen; one recorded change, FS-50 §M3), CERTIFIED restated last, `--k` printing the chromatic sentence. **It refuses a
non-prime modulus by name today** (`certificate.p: 27 is not prime`), which is the breakdown behaving as a breakdown should;
card 1's specification therefore keeps the field an **explicit** parameter (`--modulus t^3-t-1` beside `--q 27`, carried in the
record), never inferred from the number — a certificate "at 27" with no modulus stays refused.

*The reader of the table* holds `data/fs53/window.md`: one row per member, a trust tag on every cell with the legend on the
page (`[exact]`, `[cert]`, `[solver]`, `[search]`, `[kernel]`, `[planner]`), `frac6`/`frac5` beside the reach, and the file
names fixed. The verdict vocabulary differs per tool (found / not_found; hits / exact / best_k_found; sat / unsat / unknown;
CERTIFIED / NOT A CERTIFICATE) and the legend is the one place that maps each to a trust tag — keep it the only place. A
cell that reads "not found at budget B" carries the budget in the cell, never in prose elsewhere (the advisor's trap 1).

*The implementer* holds §S5's phase table and K1–K4. The kernel surface they build is `CayleyCert.check` and `sound` (one
theorem; the lemma API of `toId`/`addId`/`quadId` is the five laws, and no downstream proof unfolds them), plus the single
`finitePlane` threshold form with its two spec `example`s — the sixteen per-member names they might have guessed are
deliberately absent until a certificate exists (D-14), and the docstring says so. The one name that must be predictable:
`add_one_le_chromaticNumber_finitePlane_of_indepNum_le` sits beside `add_one_le_chromaticNumber_of_indepNum_le` and reads
as its `finitePlane` specialisation, which is what `exact?` will be asked for.

*Kooshi* holds §S10's four cards in the house format, each with its default; the close's ledger row uses row 68's three-level
shape (`[search]`/`[cert]`/`[kernel]` per cell) and its consequence sentence is written in advance as D-11 says: no headline
conditional is promised, and "not landed" is a complete sentence.

*Not changed:* the trust tags and file names (§S11), the designer's spec and its four named controls, `plane-colour`'s and the
checker's verdict words.

*Found on review (2026-09-15, after the passes), and **the attribution corrected by the A0 implementer**:* the committed
`data/fs53/periodic-q27.json` was **overwritten in place** during the review (timings changed; the `partial`/`dims_done`
checkpoint fields vanished) and had to be restored with `git checkout --`. The product owner recorded the cause as
`--self-test`. **That was wrong, and the implementer checked it rather than believing it**: on `main`, `--self-test`
returns before any write (`if a.self_test: return self_test()`, and `self_test` writes nothing), verified by md5 on the
committed tool before any edit — so the overwrite came from a sweep run with `--out data/fs53/periodic-q27.json`, the
tool's own documented invocation. **The defect was real and the fix is right; the cause named in the plan was not.** What
was genuinely wrong is the part the implementer repaired: **two record writers**, the checkpointing one and an older one
in `main`, which could disagree. A0.2's acceptance keeps both lines — one writer, and the self-test confined to a scratch
path — the second now as a *guarantee to preserve* rather than a defect to fix, and the implementer went further and made
the tool **assert** the committed record is byte-identical before and after (its control 7).

### §S13. The rulings (Kooshi, 2026-09-15) and the implementation gate — written for an implementer who arrives with no memory and a product owner who scores by artifact

**§S13.0 Rulings.** Kooshi, 2026-09-15, after the report of §S10: *"I agree with all of your decisions."* Every card is decided as
recommended and every decision D-1 … D-16 stands. Implementation is by **Opus 5**, one implementer at a time, one phase each,
under this gate; Kooshi's instruction verbatim: *"Opus 5 is an excellent engineer, but it misses things sometimes, so a well
specified plan and a rigid gate definition are necessary."* The product owner (de Bruijn, or whoever holds this file after
a compaction) scores every report against §S13.2 **item by item, opening the artifacts and the gate logs, never the summary.**

| ruling | what it decides | where it lands |
|---|---|---|
| **R-1** (card 1) | the certificate stack — `tools/fplane_sdp_blocks.py`, `tools/fplane_cert_round.py`, `tools/fplane_cert_check.py` — is extended from prime fields to prime powers so `q = 27` can be certified. **This paragraph is the recorded decision that unfreezes the checker for exactly this change** (FS-50 §M3's rule: the checker changes only by a decision recorded in the plan) | phase A0.4 |
| **R-2** (card 2) | two work orders to the Rust engineer (`~/source/descent-engine`, the `ferrous-engineer` agent): **WO-19** `plane-colour` writes its record every progress tick and resumes from it; **WO-20** `plane-colour` can hold a given independent set as one colour class | phase A0.3 |
| **R-3** (card 3) | phase B runs, on one GPU, in the order **27, 79, 67, 47, 43, 59**, after phase A's CPU work; never 23 or 31 for six | phase B |
| **R-4** (card 4) | the milestone's durable product is the **growth law of α** with "is six attained" as its corollary; the table records both α brackets and χ brackets; the close leads with the law | phase E |
| **R-5** | Opus 5 implements; one subagent at a time; the gate below is binding; the product owner reviews by artifact | every phase |

**§S13.1 Standing rules — a violation fails the phase whatever its results** (each with the reason; all are `CLAUDE.md` rules,
two of them PROTECTED):
1. **Build only through `./scripts/build.sh`** — never `lake build`, bare or named (it took the desktop down twice). `lake env
   lean <file>` is for iteration and does not apply the lakefile's options; it is never the gate.
2. **Every run expected to exceed 15 minutes checkpoints outside `build/` and has its resume command written in the phase
   record BEFORE launch** (PROTECTED). No `timeout` wall on any solve (killing the wrapper kills the child). Launch with
   `setsid`, write the pgid to a file in the job tmp, signal by pid or pgid — **never `pkill -f` / `pgrep -f`** (they match the
   shell that runs them and other agents' monitors). Launch long runs from a snapshot copy of their script.
3. **One heavy job at a time.** Phase B does not start until FS-50's GPU jobs are stopped at a checkpoint by §S13.3.
4. **Verdict words are fixed.** A search's `not_found` is a null at a stated budget, never a refusal. A solver's UNSAT is "the
   solver's word". Only the checker's CERTIFIED and the kernel are exact. A float reading is never a bound. A record says which
   it is in its `claim_scope`.
5. **Every graph record carries `edges_sha256`; every record carries `claim_scope`, the budget, the threads and the seed.**
6. **The checker is frozen except for A0.4's recorded change (R-1).** Any other edit to `tools/fplane_cert_check.py` fails the
   phase. The prime code path must stay byte-identical (§S13.2 A0.4).
7. **Commit incrementally** with the attribution lines the brief gives; `git diff -- <path>` before every `git add` and commit only
   hunks that are yours; one writer per file, named in the brief. A committed half-phase is recoverable, an uncommitted one is not.
8. **Never read credential files; never edit a running shell script; never work past an unexplained process crash** — halt and
   report.
9. **Every new check ships a planted failure that is seen to fire** (G21, § Make the gate fail). A control whose failure mode
   cannot be reached has not been tested by passing; the phase record names the plant and the line it broke.
10. **A number in a record travels with what it measures** — units, conditions, population, budget. When two numbers are
    compared, exactly one thing differs, written as fractions with the denominators spelled out.

**§S13.2 The gate, phase by phase.** Each item: *what* · *verified how* · *pass condition*. An item is green only when the product
owner has opened the artifact named; "the report says so" is not green.

**A0.1 — restore the 27-plane's producer** (an hour). Restore `field_q27()` in `tools/fplane.py` from
`.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`; add a `self-test` row asserting the 27-graph's shape (729 vertices,
degree 28, 10,206 edges, `edges_sha256 = b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d`); regenerate
`data/fplane/chi-q27.json` carrying that hash. *Pass:* `python3 tools/fplane.py chi --q 27 --k 4` reproduces `k = 4 unsat`;
`python3 tools/fplane.py self-test` green with the new row; `git diff` on the file shows the restore and the row and nothing else.

**A0.2 — the sweep tool's record** (an hour). `tools/fplane_periodic_subgroups.py`: one record writer (the checkpointing one,
with `partial`/`dims_done`); the self-test writes only under a scratch path (**it already did on `main`** — the plan's
claim that `--self-test` overwrote the record was a misattribution, corrected in §S12.3; keep it true and *assert* it); a
`best_witness` field carries the colouring behind
`best_k_found`. *Pass:* `--self-test` green and `git status` clean afterwards; a rerun's `data/fs53/periodic-q27.json` carries
`best_witness`, and the product owner's independent script (the one behind `data/fs53/colour-q27-k7-quotient.json`, re-run) verifies
that colouring proper on all 10,206 edges.

**A0.3 — WO-19 and WO-20 to the Rust engineer** (R-2; a day). WO-19: the record is rewritten every progress tick with the best
colouring so far and `partial: true`, and `--start <record>` resumes from it. *Pass:* a run killed by pid at two minutes leaves a
valid record; the resumed run's best conflict count is monotone from it; the plant — a record with a corrupted colouring — is
refused by name. WO-20: `--fix-class <independent-set record>` holds that set as colour class 0. *Pass:* at `(23, 6)` with
`data/fs50/alpha-p23-ge87.json` the verifier confirms class 0 equals the set; the plant — a set that is not independent — is
refused by name before any search. **Added to the work order by the product owner, 2026-09-15, with the arithmetic below
(§S13.2 A.2's note):** `--fix-class` computes `⌈q²/k⌉` and, when `|S|` is smaller, prints a note that the fixed class is below
the size a `k`-colouring forces and that the remainder therefore needs an independent set of at least `⌈(q² − |S|)/(k − 1)⌉`,
larger than the one fixed; both numbers go in the record. A note, never a refusal — the run is legitimate and a success would
be a major finding — but a run whose failure was arithmetically predetermined must not be recorded as evidence about the graph. Both under the ferrous standard's own gate (its tests, its controls), reported with the test
counts.

**A0.4 — the certificate stack over prime powers** (R-1; a day and a half). The three tools accept `--q 27 --modulus t^3-t-1`
(the field named explicitly, carried in every record and certificate; never inferred from the number). *Pass, all four:* (i) the
prime path is byte-identical — `git diff` shows only the dispatch, and the 11 and 23 certificates (`data/fs50/cert-p11-N29.json`,
`cert-p23-real-N108.json`) re-run through the checker with **identical output lines**; (ii) a certificate labelled 27 without a
modulus is refused by name; (iii) the 27 graph the tools build matches A0.1's hash; (iv) the self-test gains these as controls and
each is seen to fire. The checker's CERTIFIED line still comes after all four checks in every path. (**The acceptance's earlier wording,
"the last line printed", was wrong against the committed tool** — with `--k` the colourability consequence prints *after*
CERTIFIED, which is FS-50 §M3's behaviour and correct: the consequence is what the reader came for. A0.4 preserved it
byte-identically; the wording is fixed here, not the tool.)

**K1 — the packed Cayley certificate, in the kernel** (§S9, §S12.1 D-13, §S12.2; two days). `CayleyCert.Cert` generic over
`IdArith R`; `sound` proved once; `IdArith (ZMod q)` with its five laws proved; `cert3` and **`cert23_8`** (the line-periodic
8-colouring of the 23-plane from `data/fplane/periodic-below-71.json`, packed) with `#guard cert23_8.check` and
`example : (finitePlane 23).Colorable 8 := CayleyCert.sound …`; the cost of `check` at 23 measured and written in the module
docstring. *Pass:* `./scripts/build.sh` green with **zero `sorry`** in `CayleyCertificate.lean`; `./scripts/vacuity.sh` green with
the counts in `CLAUDE.md` § The gate updated in the same commit; `#print axioms` clean; **the five mutations of §S12.2's audit each
applied and each seen to break the named step**, recorded in the phase record with the line numbers (dropping `covers` from `check`
must make the short-circle control pass `check` and `sound` fail; reversing `covers`; dropping `0 < k`; dropping `Fact (1 < q)`;
deleting `toId_add` from the proof).

**K2 — the schema and the threshold form** (half a day). D-15: `chromaticNumber_eq_succ_of_colorable_of_indepNum_le` moves to
`LocalGlobal.lean` beside `add_one_le_chromaticNumber_of_indepNum_le` and is proved; the `finitePlane` threshold form and its two
`example`s stay in `Instances/SixthColour.lean`. *Pass:* build green, zero `sorry` in both, the dependents of `LocalGlobal.lean`
rebuilt under the cap (expect an hour of wall; do not raise `BATCH`).

**A.1 — α at every member** (per member, an hour of one core; 27 through A0.1's graph exported in the engine's format). For each of
the eight: `plane-independent` free, then rotation-order seeds over every divisor of `q + 1`, the line quotients, chaining through
`--start`. **Order: 23 (target 89), 31 (target 161), 27 (target 122) first** — the three members the
bias-corrected growth law leaves live (§S6) — then 43, 47, 59, 67, 79, where the law predicts the search is empty
and a null costs the milestone nothing. *Pass:* `data/fs53/alpha-q<q>-ge<size>.json` per member, every set re-verified by the product
owner's script from the definition; the record states budget, threads, seed and `halt`; a plateau is reported as "plateau at N
under budget B", never as α.

**A.2 — six-colourings at every member** (per member, the long budget WO-19 makes safe: an hour, checkpointed). `plane-colour
--k 6` whole plane; `fplane.py equivariant --p q --k 6` for the prime members; WO-20's fixed-class search at 23 with the best set;
`k = 5` after `k = 6` where five is open. **Peel-and-colour has an arithmetic precondition, and at 23 it is not met** (the
product owner, 2026-09-15): a `k`-colouring partitions `q²` vertices into `k` independent sets, so some class has `≥ ⌈q²/k⌉`;
fixing a class `S` with `|S| < ⌈q²/k⌉` leaves `q² − |S|` vertices needing `k − 1` classes, one of size `≥ ⌈(q² − |S|)/(k − 1)⌉`
— **larger than `|S|`**. At `(23, 6)`: `⌈529/6⌉ = 89`, the best known set is **87**, and the remainder would need `⌈442/5⌉ = 89`.
So the fixed-class run at 23 cannot succeed unless α(23) ≥ 89, which is the open question itself, and `plane-independent`
targeting 89 answers it directly and more cheaply. **Consequence for the order of A.2 at 23: the independent-set ask (A.1,
target 89) is the decisive instrument and runs first; the fixed-class colour search is run only with a set of size ≥ 89 if one
is ever found.** The same test applies at every member before a fixed-class run is launched. *Pass:* one record per (member, k) with its budget; any `found` re-verified by the product
owner from the definition and promoted to a `Cert` under K1 the same day; every `not_found` names its budget in `data/fs53/window.md`.

**B — the certificate side** (R-3; one GPU-day; §S13.3 first). **27 is DONE, delivered early by phase A0.4** — the
prime-power extension had to solve it to prove itself, so `data/fs53/cert-q27-N147.json` is filed, CERTIFIED and
converged (two formulations, three solvers, 147.5774–147.5780), and **B's remaining order is 79, 67, 47, 43, 59.** Note
what 27 cost the expectations: B's product there was to have been a five-refusal (P3), and the converged optimum
147.578 sits **above** the 146 five needs, so the cell reads `α ≤ 147 [cert]` and five stays open in a two-integer
window. Per remaining member:
`tools/fplane_sdp_blocks.py --real` (with `--q 27 --modulus t^3-t-1` at 27), then `tools/fplane_cert_round.py --p <q> --blocks
--real --chunk 500 --linear-solver gpu_indirect --scs-ckpt data/fs53/ckpt/scs-q<q>-real.npz --ckpt data/fs53/ckpt/round-q<q>.jsonl
…` (the FS-50 command line, `data/fs50/README.md` "Resume"), the anytime polish loop beside it; **the exact bound is rounded from a
fresh short continuation's own dual, never from a long-run iterate and never through `--round-only`'s nudge** (the mechanism of
row 68). *Pass per certificate, in this order:* the untouched checker CERTIFIED with the right sentence (`--k 5` at 27, 47, 43;
`--k 6` at 79, 67, 59); a second rounding of the same dual at another cut and denominator with the same `⌊N⌋`; `--ldl` green;
filed as `data/fs53/cert-q<q>-N<N>.json` with a README row and the `window.md` cell tagged `[cert]`. A member the certificate
cannot reach is recorded as "N = … at convergence, above the threshold by …" — a fact about the instrument, in the cell.

**B′ — the side row at 17** (an hour). `plane-colour --p 17 --k 6` **before** `--k 5` — the cheap gate, since a `k = 6`
null at an hour makes a `k = 5` hit hopeless. **But give `k = 5` a real budget if `k = 6` is found** (the product owner,
2026-09-15): 17 is **triangle-free** (3 is a non-square mod 17, verified by direct triangle search), its ratio bound is
96.01 and the bias-corrected growth law predicts **α(17) ≈ 75 against the 58 that five needs — a 29 % margin, the
largest of any undecided plane in or beside the window**, so a five-colouring at 17 is the likeliest `found` anywhere in
this milestone. It is also the most valuable: `k = 4` is already UNSAT there, so a verified five-colouring **closes
`[Moorhouse2010]` Table 6.1's open cell `χ(𝔽₁₇²) ∈ {5, 6, 7}` at exactly 5** — a published open question answered, of
the kind `CLOSED-QUESTIONS.md` exists for — while a six-colouring alone only narrows it to `{5, 6}`. The calibration
that makes the prediction credible: at `q = 13`, where `χ = 5` is known, the same corrected law gives α ≈ 39 against the
34 five needs, and five is indeed attained. *Pass:* records with budgets; a `found`
re-verified; the README sentence carries both halves (first six-chromatic single-distance graph over any field if six; seals no
field because 17 ≡ 1 mod 4).

**C.1 — the designer and the ring reductions** (a day). `tools/fplane_field_design.py` with its **four controls seen to fire**
(`ℚ(√3,√11)` → {11, 83, 131, …}; de Grey's field → {131, 479, …} and not 11; `ℚ(√23)` sees 23 by ramification; a planted
square-everywhere radicand refused by name); P5 as a self-test row (only 83 in (11, 83] has both (3/p), (11/p) ≥ 0). The ring-level
reductions per candidate field in `Instances/SixthColour.lean` (the `O23` shape; ℚ(√3, α) per D-16 when 27 is live). *Pass:*
self-test green; build green; `data/fs53/field-q<q>.json` per candidate.

**E — the close** (WORKFLOW step 9; half a day). `data/fs53/window.md` complete, every cell tagged; README rows for every file;
the ledger row(s) in row 68's three-level shape; G56 already carries eight members; FRONTIER re-ranked and `plans/FRONTIER-STUBS.md`
updated; the conjecture sweep of this plan (`grep -n "conjecture\|not claimed" plans/STUB-sixth-colour.md`, each hit a stub or an
explicit decline); the growth law scored at eight points (R-4) and the reading `χ = ⌈q²/α⌉` scored at every decided plane;
`CLAUDE.md` under 200,000 bytes; a session handoff. *Pass:* the product owner reads the ledger row against every cited artifact.

**§S13.3 Stopping FS-50's GPU jobs before phase B** (the killable-run rule: they block phase B and forfeit only the minutes since
their last chunk). 1. Signal by pid: `kill -TERM 2808409 2816615 $(cat /home/kooshi/.claude/jobs/b1507518/tmp/sdp/pid-anytime-loop2)`
and wait with `kill -0` until each is gone (if `kill -0` already fails, the jobs ended earlier — check the timestamps of
`data/fs50/ckpt/*.npz`). 2. Take the newest `cert-polish-*.json` under the job tmp `sdp/` (or the certificate the producer wrote at
convergence) through the untouched checker, a second rounding, and `--ldl`; file it under `data/fs50/p83-refusal/` with a README row;
update row 68's tightest number. 3. Record both formulations' last chunk lines as `[solver]` readings in `data/fs50/README.md` and say
whether the two values differ at equal tolerance (the third-row revisit condition, FS-50 §1 item 10). 4. Only then launch phase B.
The FS-50 relaunch commands stay in `plans/SESSION-HANDOFF-2026-09-15.md` §2 should the readings ever be wanted again.

**§S13.4 The review procedure** (the product owner, per phase, before anything is pushed): open `build/gate/build/latest`'s digest and
the vacuity digest; `git log` the phase's commits and `git diff` every touched file; run the checker yourself on every certificate;
re-verify every `found` colouring and every independent set with a script that shares nothing with the tool that produced it;
score §S13.2's items for the phase one by one; an item not demonstrably green is **not done** and goes back to the implementer as a
measurement and a question, never as a reprimand (the peer-delegation rule). Push only after the phase scores green.

**§S13.5 The brief template for each phase** (peer-delegation shape): the milestone in a paragraph (§S13's first lines); the phase's
mission and why it matters; what is on disk (§S0, the previous phase's record); the standing rules §S13.1 with their reasons; the
phase's items from §S13.2 as the acceptance; the files the implementer may write (one writer per file); the scratch directory; the
attribution lines; "commit incrementally, Kooshi may be cut off"; the report format — commits, the checklist scored by the
implementer itself, what was rejected and why, and anything found that contradicts this plan.
