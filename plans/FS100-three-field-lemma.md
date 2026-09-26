# FS-100 — the reframe and subplan (job J51, planner)

*Milestone: `plans/STUB-measure-rigidity-three-fields.md` (FS-100, "One missing lemma for three fields"). Brief:
`data/crunch-2026-09-25/briefs/J51-FS100-three-field-lemma-planner.md`, with `STANDING-RULES.md` and J03's template; the owner's notes
override both. Planner: de Bruijn (Opus 5.5), 2026-09-26. Working files: `data/fs100/j51/`. Fenced from J51V until J51V's verdicts are
committed.*

## Stage 1 — SAVED (quotation check; the reading; one exact check at the ban's edge)

### 1.1 Which `CLAUDE.md` was read

J05 is compressing `CLAUDE.md` in committed batches. Per the owner's note 2 the walk reads the committed copy at **`179c6c5b`** ("J05: stage 2
batch 1"), saved uncommitted as `data/fs100/j51/CLAUDE-snapshot.md` (291,789 bytes; deleted at the last stage). The copy loaded into my
context at launch is the working tree of that moment; `diff` against `179c6c5b` shows three hunks only (the Last-updated line, the
Open-milestones paragraph, G35's Gate sentence), each a compression with no fact removed. The §G walk reads the entries of G1–G79 and the
method rules, which the three hunks do not touch.

### 1.2 Quotation check of the brief (standing rule 5)

| # | the brief's quotation | source checked | verdict |
|---|---|---|---|
| Q1 | the stub's title, verbatim | stub line 1 | exact |
| Q2 | Kooshi: *"Write up the portrait of 4 in 47 …"* | stub header, lines 4–5 | exact |
| Q3 | "**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure'" — J38 §3.5, T-J38-2 (iii) | stub §1 line 48 | exact |
| Q4 | "Given MR, `χ(ℚ(√47)²) = 5`, row 88 ⟺ T-B1, and `χ(ℚ(√167)²) ≥ 5`" (unquoted in the brief) | `CLAUDE.md` § Paths forward, FS-100's row: "given MR(F) — every `U`-invariant `E`-null measure on `R̂` is a multiple of Haar — `χ(ℚ(√47)²) = 5`, row 88 ⟺ T-B1, and `χ(ℚ(√167)²) ≥ 5`" | faithful |
| Q5 | Kronecker selection, verbatim | stub §3 lines 225–228 **and** its origin J37 `plans/POROS-2026-09-25-wanted-poster-47.md` §4.5 R2 (line 366) | exact, both |
| Q6 | X-KS: "medium-low (0.4) that it is true as stated" | stub §4 line 251; J37 line 366 | exact |
| Q7 | stage 5's entropy question | stub §6.3 line 352 | exact |
| Q8 | the advisor's card (four lines) | J50 `plans/POROS-2026-09-26-next-two-milestones.md` §3.2, card `is-mr-attackable` | exact |
| Q9 | Kronecker's missing input, "an equidistribution statement … stronger than band rigidity" | stub §3 lines 231–232 (J37 §3.3 (d) J1) | exact |
| Q10 | "the first control the gap has ever had" | stub §6.3 line 350 (bold in the source) | exact |
| Q11 | "not checked here" (stub §5 item 5) | stub line 274 | exact |
| Q12 | "the FS-100 planner registers it at stage 0, with its uninformative outcome and whether it is reachable (G21)" | stub §4 line 259 (X-MR's prior cell; the source bolds "unregistered: the FS-100 planner registers it at stage 0") | exact |
| Q13 | "J43's facts file tags ℚ(√143), ℚ(√311), ℚ(√335) with zero theorems" | recounted: `data/viz/local-global-map/facts.json`, 829 theorems, `tags.field` counts — Q143 0, Q311 0, Q335 0 (Q47 18, Q167 29, Q59 24, as J50 §1.2 says) | exact |
| Q14 | T-C(A)'s class, "its address is in the stub's §2" | stub §2.1 P7: "row 113; `plans/R88-derivation.md` R88-TCA" | the address resolves; class read there (§1.4) |
| Q15 | Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* | `CLAUDE.md` Frontier item 23 | exact |

No discrepancy. One note: the brief's §G time box asks for "every grokking G1–G79" — the in-context `CLAUDE.md` numbers G1–G79 with no G51 gap
(G51 sits after G79 by position), so the walk is 79 entries.

### 1.3 The reading done in this stage

- The stub, in full (442 lines). The J50 record §1.2, §2's candidate A and §3 (the card, the swap, the hunch `mr-is-open-measure-rigidity`).
- `plans/R88-derivation.md` R88-TCA (T-C(A)) with its proof paragraph; `plans/FS86-B1-verification.md` Lemma P and the spectral table
  (Hoffman ratios at 11–131), and V3's stable-place method.
- **Not read in this stage, and why:** J37–J39's posters in full (the stub quotes every statement this plan consumes with its address; J51D
  reads J37 §3.3–§4.5 in its first stage); `plans/FS84-SI-D-derivation.md` (quoted in the stub §2.2; J51D reads §5.4's lemma list).

### 1.4 The exact check at the ban's edge: which real quadratic fields sit in T-C(A)'s class

**T-C(A)'s class, verbatim** (R88-TCA): "over ℚ(√47), and (J28D) over every real field whose stable places all have all-levels ratio `< 1/4`".
Its proof's list at ℚ(√47): "11 and 19 by FS-66, the tail by Hoffman — the maximum 31's `1/4 − 2.745·10⁻⁶` —, the ramified 47 by Lemma P, the
real places `m₁`, split places 0".

**The derivation that fixes the finite set** (so the check is a complete enumeration, standing rule 3's edge). For a real quadratic `F = ℚ(√d)`
and `L = F(i)`, a place `v` of `F` is stable iff `v` does not split in `L/F`. Odd `v` with residue field `𝔽_q` is stable iff `q ≡ 3 (mod 4)`,
i.e. `p ≡ 3 (mod 4)` split or ramified in `F` (inert gives `q = p²`). At every stable odd place the all-levels ratio is `< 1/4` except at
`p ∈ {3, 7}`: at 11 and 19 by FS-66's certificates `U(11) = 28.2043 < 121/4`, `U(19) = 77.5117 < 361/4`, at every level of the unramified
tower (row 75) and of the ramified one (Lemma P (ii), `plans/FS86-B1-verification.md`); at 23 and 31 by Hoffman (0.249077; `1/4 − 2.745·10⁻⁶`)
with Lemma P (i) for every level; at `p ≥ 37` by Weil + Hoffman + Lemma P (`≤ 2√p/(p+1+2√p)`). At 3 and 7 the ratio is `≥ 1/4` at level one
(`Γ₃`: 1/3; `Γ₇`: 14/49). A dyadic stable place is Hoffman-tight at `1/4` (row 67), so not `< 1/4`, or is ramified in `L/F` (ratio 1/2). A
dyadic place is non-stable iff `i ∈ F_v`, which for a real quadratic field is `d ≡ 7 (mod 8)` (then `−d ≡ 1 (mod 8)` is a 2-adic square and
`ℚ₂(√d) = ℚ₂(i)`). Hence **for a real quadratic field: in T-C(A)'s class ⟺ `d ≡ 7 (mod 8)`, `d ≡ 2 (mod 3)`, `(d/7) = −1` ⟺ `d ≡ 47, 143,
167 (mod 168)`** — which is G61's description of exactly the real quadratic fields with `L ≥ 5`. So for real quadratic fields **T-C(A)'s class
is the conjecture's `L ≥ 5` family**, no more and no less.

**The check** (`tools/j51_tca_class.py`, exact, under a second: Legendre symbols, 2-adic squares, per-field stable-place lists for `p ≤ 400`
beside the derived rule; plant: a wrong dyadic test that calls `d ≡ 3 (mod 8)` split, which must move ℚ(√59) into the class and fire).
Output `data/fs100/j51/tca_class.out`:

| field | stable places with ratio `≥ 1/4` | in T-C(A)'s class | `L` |
|---|---|---|---|
| ℚ(√47) (control, must pass) | none | yes | 5 |
| **ℚ(√143)** = ℚ(√(11·13)) | none (11 ramified: FS-66 via Lemma P (ii); 31 split: Hoffman) | **yes** | 5 |
| **ℚ(√311)** | none (11, 19 split: FS-66; 311 ramified: Weil) | **yes** | 5 |
| **ℚ(√335)** = ℚ(√(5·67)) | none (11 split: FS-66; 67 ramified: Weil) | **yes** | 5 |
| ℚ(√167) | none | yes (J36 F7's "probably includes ℚ(√167) (not checked)" — now checked) | ≥ 6 by level one (23 or 43) |
| ℚ(√59) (control, must fail) | the dyadic place (type (B)) | no | 4 |
| ℚ(√11) (control, must fail) | 7 (split) | no | 4 |

**Answer for §IQ item 5, and its grade.** ℚ(√143), ℚ(√311), ℚ(√335) sit in T-C(A)'s class **[hand + tools exact, one mind (J51); resting on
J28D's class form of T-C(A), which is one mind outside ℚ(√47), on Lemma P (FS86-B1, one mind + FFT) and on FS-66's certificates]**. So T-C(A)
holds there at J28D's grade, and the three are instances of the milestone's lemma **provided SP-Cor transfers** — J45's SP-Cor and A⁺ are stated
"over ℚ(√47)"; whether their proofs use anything of ℚ(√47) beyond T-C(A) at `S = ∅` is **not checked here** and is a named claim for J51D
(§S, claim K0). The facts file's zero is a tagging gap, not a gap in the mathematics: the Frontier's "exactly five" at those fields is G61's
congruence family, and T-C(A)'s class coincides with it.

### Theorems this phase proved

- **J51-T1** — for a real quadratic field `ℚ(√d)`: every stable place has all-levels four-colour ratio `< 1/4` (T-C(A)'s class) ⟺ `d ≡ 47, 143,
  167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`. [hand + tools exact; one mind; inputs FS-66 (cert), Lemma P (hand, one mind + FFT), the Hoffman table
  (tools exact), row 67] — `plans/FS100-three-field-lemma.md` §1.4; `tools/j51_tca_class.py`.

### Would have searched here (stage 1)

- None. The one computation is a complete enumeration of a set the derivation fixed (Legendre symbols at 2, 3, 7 and the stable-place lists),
  seconds, logged at the ban's edge.
