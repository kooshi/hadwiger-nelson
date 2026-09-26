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

## Stage 2 — SAVED: §G, the re-grokking (terse form; `CLAUDE.md` at `179c6c5b`, `LEDGER.md` at HEAD)

*Method: every grokking G1–G79 read in full; `LEDGER.md` § A **read by each row's head (first ~240 characters), not in full** — the
budget deviation is declared here — and the rows this milestone consumes (88, 92, 94, 95, 97, 98, 102, 109, 111–113) read to ~1,100
characters; § B not opened (no id needed beyond the stub's addresses). Verdicts: `bears → stage`, `silent`, `falsifiable → P-x`.
Stages: 4 = Kronecker selection (J51D/J51V), 5 = MR and entropy (reading room), 6 = EI-2 over ℚ(√11), P1 = post-ban finite `H`.*

### §G.1 Grokkings

- G1 — silent: ℚ(√47)'s wall is broken (47 ≡ 7 mod 8); no solver planned.
- G2 — silent: construction grammar; nothing built.
- G3 — silent: witness radii.
- G4 — silent: shell inventory.
- G5 — silent: 1-sums.
- G6 — silent: seeds.
- G7 — silent: rotation family; no arena.
- G8 — silent: de Grey's direction group, not `U_F`.
- G9 — silent: compulsions over K.
- G10 — silent: criticality.
- G11 — silent: Moser-free spindling; P1 is a finite `H`, not a spindle.
- G12 — silent: quadrature law.
- G13 — silent: fans.
- G14 — silent: matchings.
- G15 — silent in-ban; P1's design shape post-ban.
- G16 — silent: K-fabric.
- G17 — silent.
- G18 — silent: composition of SAT.
- G19 — silent.
- G20 — silent.
- G21 — bears: "three fields share one lemma" is liked and route-dependent (J48 held item 1); J51V's controls must be the right shape (FS-91's slip) → stage 4, §S claim list; X-MR's uninformative outcome named (§P).
- G22 — silent: polygonal six-colourings.
- G23 — silent.
- G24 — silent.
- G25 — silent.
- G26 — silent.
- G27 — bears: the Galois flip `√d ↦ −√d` also acts on `R̂` (row 111's scope repair); MR may assume Galois-averaged `τ` → stage 5 note.
- G28 — silent.
- G29 — silent.
- G30 — bears: name the discipline: algebraic `ℤ^d`-actions on solenoids (Schmidt; EL); failure mode 2 (EL's quantifier is ℤ^d-ergodic, MR's is `U`-invariant) → §PA, stage 5.
- G31 — silent.
- G32 — silent.
- G33 — silent.
- G34 — silent.
- G35 — bears: split dyadic place ⟺ `d ≡ 7 (mod 8)`; used in §1.4's class test → stage 1 (done).
- G36 — silent.
- G37 — silent.
- G38 — silent.
- G39 — silent.
- G40 — silent.
- G41 — silent: additive colourings are torsion characters, already excluded.
- G42 — silent.
- G43 — bears: stable places decide T-C(A)'s class (§1.4) → stage 1 (done).
- G44 — bears: Hoffman/Weil table at 23, 31, `p ≥ 37` is the class check's tail → stage 1 (done).
- G45 — silent.
- G46 — bears: `R̂` is a 4-dimensional solenoid, `U` acts by automorphisms; Kronecker selection is an orbit-closure (self-joining) question → §PA, stage 4.
- G47 — silent.
- G48 — bears: target `L = 5` at ℚ(√47) and (§1.4) at ℚ(√143), ℚ(√311), ℚ(√335); only a whole-plane colouring falsifies; register first → §P.
- G49 — bears: gate in the discipline's words (measure rigidity, solenoid, ×p×q, self-joinings), zbMATH author listings → stage 3.
- G50 — bears: EL "recalled, not read" is the debt; read at the statements now, full reading written into §S → stage 3.
- G52 — silent.
- G53 — silent.
- G54 — bears: no tight place at ℚ(√47) makes the last step a count; thickness `λ* < 1/(k−1)` is MX's hypothesis → stage 4.
- G55 — bears: `R = O′` (prime inversion) makes `R̂` an S-adic solenoid, S = the split primes, infinite → stage 4/5 statements.
- G56 — silent: the window; ℚ(√167)'s `L ≥ 6` only as context.
- G57 — silent: ℚ(√47) triangle-free; no triangle identity to use.
- G58 — silent.
- G59 — silent.
- G60 — bears: P10/EI-F is the finite-`H` route; amenability splits `F ⊆ F_μ ⊆ P` → P1 (post-ban).
- G61 — silent: three colours.
- G62 — silent.
- G63 — silent.
- G64 — bears: keep S and W apart in any ℚ(√167) sentence; T-J39-5 is not evidence for seven → report wording.
- G65 — silent: solver phase diagram; ban.
- G66 — bears: all-levels ratios (FS-66, Lemma P) are §1.4's inputs; MR is the measurable rung of G66's clopen/Borel chain → stage 1, §IQ.
- G67 — bears: this §G's form; every bear sent to a stage → §G.
- G68 — silent: quotient screens banned.
- G69 — silent.
- G70 — silent.
- G71 — bears: at four colours no height; the spectral measure is pair-level only ("one order too low") → §IQ item 3.
- G72 — bears: §IQ's structural form, and the count at close → §IQ.
- G73 — bears: only averaged/structure-derived certificates remain at four; MR is averaged → §IQ.
- G74 — bears: rank one of Kronecker selection is band rigidity at every band (a window avoiding a neighbourhood of 0 is band-`k`) → stage 4, J51D's rank-one control.
- G75 — silent: no pinning identity on triangle-free fields.
- G76 — bears: run Berend's dichotomy with the rotated plane set aside, count primes; closed sets are the solved half, measures the open one → stage 4 route, stage 5.
- G77 — bears: CLG is existence-only; C9's character colouring is Kronecker's rank-one control over ℚ(√11) → stage 4.
- G78 — silent: rank-one Kempe walls.
- G79 — bears: MR/SP is a counterexample invariant; flip to what every colouring carries (EI-2) → §IQ, scored at close.
- G51 — bears: one derivation + one blind verifier from a fixed list; verification is where contest begins → §S.

### §G.2 Rows (by mechanism)

- 1 — silent: two-circle colourability; a finite-object mechanism.
- 2 — silent: seam identity; a finite-object mechanism.
- 3 — silent: coverage ratchet; a finite-object mechanism.
- 4 — silent: fan iff coverage; a finite-object mechanism.
- 5 — silent: class-only graphs; a finite-object mechanism.
- 6 — silent: 120° triangle; a finite-object mechanism.
- 7 — silent: greedy colouring; a finite-object mechanism.
- 8 — silent: balanced de Grey colouring; a finite-object mechanism.
- 9 — silent: 120° compulsion; a finite-object mechanism.
- 10 — silent: one-pivot cap; a finite-object mechanism.
- 11 — silent: strip automaton; a finite-object mechanism.
- 12 — silent: extension profile; a finite-object mechanism.
- 13 — silent: negative knowledge, M17; a finite-object mechanism.
- 14 — silent: pair-gluing; a finite-object mechanism.
- 15 — silent: extension pressure; a finite-object mechanism.
- 16 — silent: coupled automaton; a finite-object mechanism.
- 17 — silent: gluing classification; a finite-object mechanism.
- 18 — silent: near-relation; a finite-object mechanism.
- 19 — silent: kill mechanism; a finite-object mechanism.
- 20 — silent: pivot-triangle layer; a finite-object mechanism.
- 21 — silent: registered statistics; a finite-object mechanism.
- 22 — silent: matched ladder pair; a finite-object mechanism.
- 23 — silent: four-ladder object; a finite-object mechanism.
- 24 — silent: hexagram; a finite-object mechanism.
- 25 — silent: field-wall identity; a finite-object mechanism.
- 26 — silent: de Grey anatomy; a finite-object mechanism.
- 27 — silent: quadrature law; a finite-object mechanism.
- 28 — silent: 2-adic kill engine; a finite-object mechanism.
- 29 — silent: stacking law; a finite-object mechanism.
- 30 — silent: mechanism hunt; a finite-object mechanism.
- 31 — silent: Act One carriers; a finite-object mechanism.
- 32 — silent: six-programme; a finite-object mechanism.
- 33 — silent: classical interval; a finite-object mechanism.
- 34 — silent: coset chromatic number; a finite-object mechanism.
- 35 — silent: coarse cells; a finite-object mechanism.
- 36 — silent: scale non-monotone; a finite-object mechanism.
- 37 — silent: gap atlas; a finite-object mechanism.
- 38 — silent: gradient hunt; a finite-object mechanism.
- 39 — silent: gap atlas, kernel; a finite-object mechanism.
- 40 — silent: fine tail; a finite-object mechanism.
- 41 — silent: limit lemma; a finite-object mechanism.
- 42 — silent: arity floor; a finite-object mechanism.
- 43 — silent: de Grey bracketed; a finite-object mechanism.
- 44 — silent: two-distance dial; a finite-object mechanism.
- 45 — silent: batch descent; a finite-object mechanism.
- 46 — silent: copy unions; a finite-object mechanism.
- 47 — silent: M53 residue colouring; a finite-object mechanism.
- 48 — silent: critical-set localization; a finite-object mechanism.
- 49 — silent: absorption; a finite-object mechanism.
- 50 — silent: additive yardstick; a finite-object mechanism.
- 51 — silent: additive rigidity; a finite-object mechanism.
- 52 — bears: the finite-plane bound through a stable place → §1.4.
- 53 — silent.
- 54 — silent.
- 55 — silent.
- 56 — silent.
- 57 — bears: Theorem A's valuation form defines the stable places → §1.4.
- 58 — silent.
- 59 — silent.
- 60 — silent.
- 61 — silent.
- 62 — silent.
- 63 — silent.
- 64 — silent.
- 65 — silent.
- 66 — silent: gap ⟹ free, a finite-target fact.
- 67 — bears: dyadic tower tight at 1/4 excludes type (B) from the class → §1.4.
- 68 — silent.
- 69 — silent.
- 70 — silent.
- 71 — bears: field-internal fractional bound; P10/EI-F → P1.
- 72 — silent.
- 73 — bears: `χ(ℚ(√47)²) ≥ 4` context → §P.
- 74 — silent.
- 75 — bears: all-levels certificates at 11, 19 → §1.4.
- 76 — silent.
- 77 — silent.
- 78 — silent.
- 79 — silent.
- 80 — bears: no cell-local certificate at four; window LP exact in rank 1 → §IQ.
- 81 — silent.
- 82 — bears: four at ℚ(√47) by the field theorem → §P.
- 83 — silent.
- 84 — bears: N1's survivors are nulls, not constraints → §P (no weight).
- 85 — silent: de Grey's lattice.
- 86 — silent.
- 87 — silent.
- 88 — bears: type-(B) frame; given MR, row 88 ⟺ T-B1 → §IQ item 5.
- 89 — bears: K has two tight places — a field outside the class (control for class tests) → §1.4.
- 90 — silent.
- 91 — silent.
- 92 — bears: measurable windows over finitely many places excluded; Kronecker is the infinitely-many-places analogue → stage 4.
- 93 — silent.
- 94 — bears: C9, a non-periodic four-colouring of ℚ(√11) by formula — stage 4's control, stage 6's field.
- 95 — bears: two primes restore closed-set rigidity modulo the rotation; the method stage 4 reuses → stage 4.
- 96 — bears: `Θ₄(ℚ(√47)) = ∅` (P3) → stage 4 rank-one input.
- 97 — bears: one prime fails (heteroclinic characters) — why `Fin_S` components sit outside `K′` → stage 4.
- 98 — bears: band rigidity at every band — rank one of Kronecker selection → stage 4.
- 99 — silent.
- 100 — bears: CLG existence scope; the peeling lemma is a selection lemma of the same shape → stage 4.
- 101 — silent.
- 102 — bears: one-prime minimal sets miss `T + A`; the one-place control for stage 4.
- 103 — silent.
- 104 — silent.
- 105 — bears: prime inversion in the kernel; `R = O′` → stage 4/5.
- 106 — silent.
- 107 — silent.
- 108 — silent: rank-one inheritance on ℤ.
- 109 — bears: the mixing selection MX — Kronecker selection's named tool → stage 4.
- 110 — bears: five-colour windows over ℚ(√167) at nine places; the same selection at `k = 5` → stage 4 remark.
- 111 — bears: rigidity splits into measures and transience → §IQ.
- 112 — bears: Theorem C (finite-place spectra are pullbacks) — MR's `Fin_S` half → stage 5.
- 113 — bears: T-C(A) at ℚ(√47); its class (§1.4) → §IQ item 5.
- 114 — bears: `χ(E_k(G)) ≤ k` criterion; product colourings from a factor → stage 4 remark.
- 115 — bears: mixing pins a product colouring (finite MX) → stage 4.

### §G.3 Method rules

- G21 (negatives measure their enumeration) — bears: J51V's controls pointed at a known positive of the right shape → §S.
- G30 (measurement generates, derivation kills; discipline ladder) — bears → §PA.
- G46 (recognize the classical theory first) — bears → §PA.
- G49 (prior-art gate) — bears → stage 3.
- G50 (read what the search found) — bears → stage 3, §S's reading stage.
- G67 (grokked by form) — bears → §G.
- G72 (the invariant question) — bears → §IQ.
- G79 (example vs counterexample invariant) — bears → §IQ.
- G51 (competitor/advisor; blind verifier) — bears → §S.
- Checkpoint-and-resume (PROTECTED) — silent: no run over 15 minutes planned.
- A blocking run is killable (PROTECTED) — silent: no runs.
- Kill by PID, never by pattern — silent.
- Pipes hide exit status — bears: §1.4's tool run with `PIPESTATUS` → stage 1 (done).
- Never edit a running script — silent.
- Build only through `scripts/build.sh` — silent: no Lean.
- `slot.py` for jobs over 2 GiB / 2 min — silent.
- Symmetry-break before SAT — silent: ban.
- Make the gate fail and watch it — bears: every `tools/j51_*` plant fired (§1.4) → stage 1.
- Positive signal for what did not happen — silent.
- Waiter conditions false at arming — silent.
- Uninformative outcome reachable — bears: X-MR and X-KS state both outcomes reachable → §P.
- One thing differs between compared numbers — silent.
- Measured vs derived half — silent.
- Read the value the code ships — silent.
- Two-sided plants — silent.
- Replay policies — silent.
- A failing run understates cost — silent.
- A caveat stepped over — bears: "the first yes" must carry its named hypothesis in the report's one line → report.
- Count generator parameters — bears: Kronecker's statement vs its control (one free coordinate) → J51V's controls.
- A true explanation stops the search for a second — bears: the swap decision checks the equidistribution step against both walls → §S.
- Restore-verify, mutate the constant, archived checkers — silent.
- Enumerate the parameter first — bears: §1.4 derived the rule, then enumerated → stage 1.
- A positive control proves only its generator's shapes — bears: the ℚ(√11) control is rank one in disguise; J51V adds a rank-two control → §S.
- One-sided filters — silent.

### §G.4 What the re-grokking changed

1. **G46 + G76 recast stage 4**: Kronecker selection's missing input can be posed as a **closed-set** statement (the orbit closure of `Θ` under
   the diagonal `U`-action on `R̂ⁿ`, a topological self-joining) rather than an equidistribution (measure) statement; that decides the swap
   (§S head) and aims §PA at Lindenstrauss–Wang.
2. **G55 + G30** make the §PA check concrete: is `R̂` a solenoid in EL's sense, and is any finitely generated `Γ ⊂ U` totally irreducible on it.
3. **G74 + rows 96, 98** give J51D its rank-one control and J51V a known positive; **G21's** shape rule adds a rank-two control.
4. **G79 + G72** put EI-2, not MR, at §IQ's structural form, with MR its colouring-free shadow.
5. Counts: grokkings 79 (bears 24, silent 55, falsifiable 0 — the falsifiable items are registered in §P from the stub's §4 and §PA);
   rows 115 (bears 27, silent 88); method rules 34 (bears 17, silent 17); counted mechanically.

## Stage 3 — SAVED: §PA, the MR reading room cut to the card

### §PA.1 The recognition, in the discipline's words

`R = ℤ[U_F] = O′ ⊂ L = F(i)` (prime inversion, row 105; `O′` integral exactly at the stable primes) is torsion-free of rank `[L:ℚ] = 4`, so
its Pontryagin dual `R̂` is **a solenoid in Einsiedler–Lindenstrauss's sense** — "a compact, connected, abelian group whose Pontryagin dual …
can be embedded into a finite-dimensional vector space over Q" (EL2021 p. 2) — and `U` acts on it **by automorphisms** (multiplication). `U`
is abelian of infinite rank; every non-torsion `u ∈ U` is isometric at both complex places of `L` and at every stable place, and expands at
some split place. MR is **measure rigidity for an algebraic action of an infinite-rank abelian group on a 4-dimensional S-adic solenoid, S
the (infinite) set of split primes, modulo the exceptional set `E`**; Kronecker selection is a question about **orbit closures of the
diagonal action on `R̂ⁿ`**, i.e. topological self-joinings. Disciplines: ergodic theory of algebraic `ℤ^d`-actions (Schmidt; Rudolph,
Johnson, Host, Katok–Spatzier, Einsiedler–Lindenstrauss) and topological rigidity (Furstenberg 1967, Berend, Z. Wang, Lindenstrauss–Wang).

### §PA.2 What was fetched and read (G50: status per section)

| work | how found | status |
|---|---|---|
| Einsiedler–Lindenstrauss, *Rigidity properties for commuting automorphisms on tori and solenoids*, arXiv 2101.11120v1 (2021; the full proof of the 2003 announcement) — "EL2021" | arXiv API, `au:Einsiedler AND au:Lindenstrauss AND abs:solenoid` | **§1 (pp. 1–3) read**: the definitions (solenoid, irreducible, totally irreducible, virtually cyclic), Thms 1.1–1.3, Cor. 1.4, the closed-set remark; §§2–9 **unread**. Copy `data/fs100/j51/el2021.pdf` (for `~/source/library/`) |
| Einsiedler–Lindenstrauss, *Rigidity properties of ℤ^d-actions on tori and solenoids*, ERA-AMS 9 (2003) 99–110, Zbl 1068.37002 — "EL2003" | zbMATH `au:` pair | **author's summary only** (a claim, not a reading); the AMS PDF returned a bot-check page twice. EL2021 says Thm 1.2 is "[7, Thm. 1.1]", i.e. EL2003's |
| Rudolph, *×2 and ×3 invariant measures and entropy*, ETDS 10 (1990), Zbl 0709.28013 | zbMATH | **review only**; the theorem as EL2021 Thm 1.1 quotes it |
| A. Johnson, *Measures on the circle invariant under multiplication by a nonlacunary subsemigroup of the integers*, Israel J. Math. 77 (1992), Zbl 0790.28012 | zbMATH | **review only** (Theorem A: an invariant measure is Lebesgue or of entropy zero) |
| Host, *Nombres normaux, entropie, translations*, Israel J. Math. (1995), Zbl 0839.11030 | zbMATH | **review only** (a normality criterion; EL2021 lists it as another proof of Rudolph–Johnson) |
| Z. Wang, *Rigidity of commutative non-hyperbolic actions by toral automorphisms*, ETDS 32 (2012), Zbl 1278.37007 | EL2021's references | **author's summary only**: Berend's theorem **without** the expanding-direction condition — our isometric (archimedean) directions |
| Lindenstrauss–Z. Wang, *Topological self-joinings of Cartan actions by toral automorphisms*, Duke 161 (2012), Zbl 1258.37031 | EL2021's references | **review only**: closed invariant sets of products — Kronecker selection's closed-set form |
| Bekka–Francini, *Characters of algebraic groups over number fields*, GGD (2022), Zbl 1518.22005 | zbMATH `ab:"solenoid" & ab:"measure rigidity"` (1 hit) | **title and review's first lines only**; positive-type functions on `G(K)` via solenoid rigidity — by Bochner a `U`-invariant measure on `R̂` is a `U`-invariant positive-definite function on `R`, so it may be the closest in print. **Prior-art debt.** |
| Berend 1983, 1984; Manners 2015 | held | read at FS-89/FS-91 (rows 95, 98) |

**Negatives.** zbMATH `ab:"solenoid" & ab:"invariant measure" & (ab:"S-adic" | ab:"infinitely many primes" | ab:"S-integers")`: **0 hits**.
Nothing found treats an **infinite-rank** acting group on a solenoid, or the **non-Noetherian** case (dual module not finitely generated over
the acting group ring). EL2021 p. 3: "In the non-irreducible case, orbit closures, and closed invariant sets are much less understood."

### §PA.3 The advisor's card, answered

**First question — is the positive-entropy half of MR a theorem in print whose hypotheses hold here?** **Yes in part, with one named
hypothesis failing and one lemma owed.**
- `R̂` is a solenoid in EL's sense (above). ✓
- **EL2021 Thm 1.2 (= EL2003 Thm 1.1) does not apply**: its hypothesis "totally irreducible" **fails for every finitely generated
  `Γ ⊂ U`** — `ann(ℤ[Γ]) ⊂ R̂` is a proper, infinite, closed, `Γ`-invariant subgroup, because `ℤ[Γ] ⊆ O_L[1/N]` inverts finitely many primes
  while `R = O′` inverts infinitely many, so `R/ℤ[Γ]` is infinite. [hand, one mind, two lines.] This is "the solenoid's form" of the card's
  third branch: **the dual module is not finitely generated over any finitely generated subgroup's ring**. And EL is stated for `ℤ^d`, not
  for `U`.
- **EL2021 Thm 1.3 is the in-print statement that can apply** ("Let α be a ℤ^d-action (d ≥ 2) by automorphisms of a solenoid X. Suppose α
  has no virtually cyclic factors …"): for `Γ` generated by two multiplicatively independent elements whose powers generate `L`, every
  solenoid factor of `R̂` is `M̂` for a nonzero `Γ`-submodule `M ⊆ R` with `M ⊗ ℚ = L`, on which `Γ` acts by multiplication in `L`, not
  virtually cyclically. [reading, one mind.] Its conclusion — finitely many `μ_j`, each invariant under a closed `Λ`-invariant subgroup `G_j`
  and of zero entropy on `X/G_j` — is **relative to subgroups that may be totally disconnected** (`ann` of a finitely generated submodule),
  whose factors `X/G_j` read finitely many places: the `Fin_S`-type part of `E` appears here as EL's zero-entropy factors.
- **The lemma owed (PE-lim, not in print; searched):** for a `U`-invariant `μ` on `R̂` with `μ(E) = 0`, pass from Thm 1.3 at `Γ` to all of
  `U` as `Γ ↑ U` — using that a `U`-invariant closed subgroup of `R̂` is `ann(I)` for an ideal `I` of the Dedekind ring `R`, hence finite or
  all of `R̂` — to conclude: positive entropy for some `u` ⟹ `μ` is Haar.

**Second question — does the four-colouring constraint force positive entropy?** **No theorem in print, and nothing known to be carried by
the spectral measure forces it.** What properness puts on `σ_μ` is its Fourier values on `U` (`σ̂_μ(u) = −1/3`, the tetrahedral embedding,
pair correlations only — G71's "one order too low"); a Fourier condition at the points of `U` does not bound entropy from below, and J46-8's
SP equivalence turns **any** non-Haar `E`-null `U`-invariant `τ` into a witness, zero entropy included. [reading, one mind.] Whether the
colouring process `μ` on `X₄(F)` (which carries more than `σ_μ`) forces positive entropy of `U` on its spectral measure is **open**, and no
link between the two entropies is known here.

**Branch taken: "the first yes, the second no"** — with the first yes conditional on PE-lim and on the Thm 1.3 hypothesis reading. **MR is
its zero-entropy half plus PE-lim**; FS-100's MR route is a **reading room while ×2×3 stands**; the post-ban plan leads with P1's finite `H`.
The hunch `mr-is-open-measure-rigidity` (J50) is **supported by a read citation**: EL2021 Thm 1.2's own dichotomy ("either µ = m_X … or the
entropy … vanishes for all n") is the positive-entropy half and leaves zero entropy open, and total irreducibility fails here.

**The swap question — is Kronecker selection's missing input the zero-entropy Furstenberg problem?** **No, on this reading.** The input J37
names is "an equidistribution statement for the `U`-values of an infinite-type character"; it can be replaced by a **closed-set** statement
(KS-sat, §S): the closure of `Θ(U)` in `Tⁿ` contains, over each point of its image in the (T + A)-factor, a full coset of the kernel of that
factor map. Given KS-sat, a proper `W` gives a proper `W′` with **no measure at all** (the colours a.e. present on a fibre coset are disjoint
from those on every adjacent fibre coset, so any measurable selection is proper). KS-sat is an orbit-closure (topological self-joining)
statement for the diagonal `U`-action on `R̂ⁿ` — the closed-set half, where rows 95 and 98 succeeded (Berend with the rotated plane set
aside, G76) — **not** the zero-entropy measure problem. Its risk, read: that action is not irreducible, where EL2021 says closed sets are
"much less understood"; Lindenstrauss–Wang 2012 and Z. Wang 2012 are the nearest in print (unread). **So the derivation slot stays on stage 4.**

### Theorems this phase proved

- **J51-T2** — for every finitely generated `Γ ⊂ U_F` (`F` a real number field with infinitely many split places — every real field) the
  `Γ`-action on `R̂` is not irreducible: `ann(ℤ[Γ])` is a proper infinite closed invariant subgroup. [hand, one mind] — §PA.3.
- **J51-T3** — (the reduction behind the no-swap) KS-sat ⟹ Kronecker selection. [hand, one mind, sketch; J51D is to write it out, J51V to
  check it as claim KS-2] — §PA.3, §S.

### Would have searched here (stage 3)

- None: every query was a literature query (zbMATH, arXiv, OpenAlex).

## Stage 4 — SAVED: §IQ, §S, §P, §M (left), §X, and the briefs

### §IQ (WORKFLOW 3.3)

1. **Existence form.** Is there a four-colouring of ℚ(√47)'s plane — and (§1.4) of ℚ(√143)'s, ℚ(√311)'s, ℚ(√335)'s?
2. **Structural form.** EI-2, about every solution: *does every translation-invariant random four-colouring of the plane over a real number
   field have a proper factor colouring continuous in probability at finitely many places?* Stripped of the colouring, its shadow is MR
   (every `U`-invariant `E`-null finite positive measure on `R̂` is Haar). **This milestone's rung of it** is layer 1: *does every pure-point
   (Kronecker) four-colouring `x ↦ W(Θ(x) + t)` select onto its (T + A)-factor?* — Kronecker selection.
3. **The invariant it forces.** Layer 1: **the orbit closure of `Θ` under the diagonal `U`-action on `R̂ⁿ`** (a closed invariant set, a
   topological self-joining) — named, and decisive through KS-sat (§PA.3). Layer 2: the carrier `τ = σ_μ|_{R̂∖E}`; the deciding property is
   **entropy** — positive entropy is handled in print modulo PE-lim (EL2021 Thm 1.3); **for zero entropy none is known**, and finding a
   property of every four-colouring beyond its pair correlations remains the milestone's open core (G79: an example invariant).
4. **Route.** Derivation only; no search answers EI-2, MR or Kronecker selection.
5. **Open instances it would decide.** Kronecker selection with T-C(A) at `S = ∅`: FS-64's adelic windows at four colours over **every field
   in T-C(A)'s class** — among real quadratic fields exactly `d ≡ 47, 143, 167 (mod 168)` (J51-T1): ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335),
   ℚ(√167), … MR: `χ = 5` at ℚ(√47) (SP-Cor), and at ℚ(√143), ℚ(√311), ℚ(√335) **if SP-Cor transfers** (claim K0); row 88 at ℚ(√59),
   ℚ(√83), ℚ(√131) given T-B1; `χ(ℚ(√167)²) ≥ 5`.

### §S — the stages as jobs

**Head: the stage-4 / stage-6 swap is NOT made.** Reason (§PA.3): Kronecker selection's missing input can be posed as the closed-set
statement KS-sat, whose failure mode is the closed-set theory of a non-irreducible action (EL2021: "much less understood"), not the
zero-entropy measure problem; and KS-sat ⟹ Kronecker selection needs no measure (J51-T3). Confidence medium: it changes if J51D finds
KS-sat false while Kronecker selection is true — then the input is measure-theoretic after all and stage 6 takes the next slot.

**The precise reading of the statement** (a domain-modeling observation made before §M; J51D confirms or corrects it at its stage 1): "the
closure of the image of `Θ`'s `(T + A(R_F))`-part" is read as the **factor** `K′ = K / K₀` of `K = cl Θ(R)`, where `K̂′ = {m ∈ ℤⁿ : m·Θ ∈ T +
A(R_F)}` and `K₀ = ann(K̂′)` — the Kronecker factor spanned by the (T + A) characters among the combinations of `Θ`'s coordinates;
`K′` is a closed subgroup of `T^{n′}` through any basis of `K̂′`. The literal "subgroup of `Tⁿ`" is ill-defined when no coordinate
decomposition exists (e.g. `Θ = (θ_E, θ_E + ψ)`).

**The claims (fixed now; J51V's list quotes them verbatim):**

| id | claim, verbatim | kind |
|---|---|---|
| KS-1 | "Let `F ⊆ ℝ` be a real number field, `R = ℤ[U_F]`, `n ≥ 1`, `Θ : R → Tⁿ` a homomorphism, `K = cl Θ(R)`, `K̂′ = {m ∈ ℤⁿ : m·Θ ∈ T + A(R_F)}`, `K₀ = ann_K(K̂′)`, `π : K → K′ = K/K₀`, and `W : K → {0,1,2,3}` measurable with `W(t) ≠ W(t + s)` for Haar-almost every `t ∈ K` and every `s ∈ cl Θ(U)`. Then there is a measurable `W′ : K′ → {0,1,2,3}` with `W′(t′) ≠ W′(t′ + s′)` for almost every `t′` and every `s′ ∈ cl π(Θ(U))`." (Kronecker selection, J37 §4.5 R2, in the reading above) | TRUE / FALSE / GAP |
| KS-2 | "If, for every `s ∈ cl Θ(U)`, `s + K₀ ⊆ cl Θ(U)` (KS-sat), then the conclusion of KS-1 holds, with `W′(π(t))` any measurable selection from the colours `W` takes on a positive-measure part of `t + K₀`." | TRUE / FALSE / GAP |
| KS-3 | "KS-sat holds for every real number field `F`, every `n` and every homomorphism `Θ : R → Tⁿ`." | TRUE / FALSE / GAP |
| KS-4 | "Over ℚ(√11), with `Θ = (θ_{C9}, θ₁)`, `θ_{C9}` row 94's character `(2x + 3y)/7` plus an archimedean term below `1/28`, `θ₁ ∉ E`, and `W` reading only the first coordinate as `⌊4·⌋`, KS-1's conclusion holds with `W′` the same window." (the stub's control) | TRUE / FALSE |
| KS-5 | "Over ℚ(√11), with `Θ = (θ_{C9}, θ_{C9} + θ₁)`, `θ₁ ∉ E`, and `W(t₁, t₂) = ⌊4t₁⌋`, KS-1's conclusion holds, and `K′` is the image of `θ_{C9}`." (a rank-two control of the shape T-J37-4 names) | TRUE / FALSE |
| KS-C | "Over ℚ(√47), KS-1 together with T-C(A) at `S = ∅` implies: no four-colouring of ℚ(√47)'s plane has the form `x ↦ W(Θ(x) + t)` with `Θ : R → Tⁿ` a homomorphism, `W` measurable and the colouring proper for almost every `t`." | TRUE / FALSE / GAP |
| K0 | "J45's A⁺ and SP-Cor hold, with the same proofs, over every real quadratic field in T-C(A)'s class (so over ℚ(√143), ℚ(√311), ℚ(√335)), given T-C(A) there at `S = ∅`." | TRUE / GAP at a named step |

**Jobs.**

| job | what | size | runs |
|---|---|---|---|
| **J51D** | the derivation of KS-1 to KS-5, KS-C, K0 (brief `data/crunch-2026-09-25/briefs/J51D-FS100-kronecker-derivation.md`); its stage 1 also runs §M's two skills on KS-1 | ~2 h, 300k | now, beside J51V |
| **J51V** | blind verifier of the same list (brief `…/J51V-FS100-kronecker-verifier.md`) | ~2 h, 300k | now, beside J51D |
| stage 5 (next, not briefed) | the MR reading room proper: EL2021 §§2–4 and §7 (the entropy-ratio theorem), Z. Wang 2012, Lindenstrauss–Wang 2012, Bekka–Francini 2022, Rudolph and Johnson at their proofs; then PE-lim as a derivation | ~2 h reading + a derivation job | after J51D/J51V |
| stage 6 (fallback) | EI-2 over ℚ(√11), J45-SI-5's right side | derivation | only if KS-3 turns out measure-theoretic |
| P1 (from 2026-10-01) | a triangle-free finite `H ⊂ ℚ(√47)²` with `α(H) < \|H\|/4` | construction; price first | post-ban |

### §P — registered before J51D or J51V runs

| id | statement | prior | uninformative outcome, and reachability (G21) | killing test |
|---|---|---|---|---|
| X-MR | MR(F) holds for every real quadratic `F` (uniform) | **0.7** that it is true (the Furstenberg analogue is believed); **0.02** that this milestone decides it | "open at the zero-entropy half" — reachable and expected (0.95); a proof is not reachable in-ban on §PA's reading, so X-MR is a belief, not a prediction this milestone can score | an SP witness over any real field |
| X-KS | KS-1 TRUE | **0.50** TRUE, 0.15 FALSE, 0.35 GAP (at KS-3's self-joining step) — up from J37's 0.4 by J51-T3 | GAP at KS-3 — reachable and informative (it names the closed-set step) | a proper `W` on some `K` with no proper `W′` on `K′` |
| P-sat | KS-2 TRUE | 0.85 | — | a proper `W` with KS-sat and no proper selection |
| P-sat1 | KS-3 at `n = 1`: for `θ ∉ T + A`, `cl θ(U)` is the whole circle | 0.70 | GAP at a non-dense `U`-value set of a `Fin_S` character | a character off `T + A` whose `U`-values avoid an interval |
| P-K0 | K0 TRUE | 0.75 | GAP at a step of A⁺ that uses ℚ(√47)'s own arithmetic | such a step, named |
| P-EL | EL2021 Thm 1.3's hypothesis holds for generic `Γ ⊂ U` on `R̂` | 0.80 | — | a virtually cyclic solenoid factor |
| P-ent | the four-colouring constraint is shown to force positive entropy in this milestone | 0.05 | "open" — reachable, expected | — |
| X-R1 (carried) | FS-97's R1 closes by a limit argument | 0.3 | — | **written now:** a `U`-invariant `E`-null `τ` that is a weak* limit of measures carried by `Fin_S` and is not Haar |

### §M — the modeling passes: **LEFT**

Not run: the context budget went to §G, §PA and the briefs, as the brief's order allows ("say that §M is left"). **Proposed:** J51D's stage 1
invokes `debruijn-domain-modeling` and `debruijn-obligation-modeling` freshly on KS-1 (its brief says so); the one pre-pass observation, the
factor reading of "the (T + A)-part", is in §S above.

### §X — would have searched here

- Stage 1: none (a complete enumeration fixed by a derivation, logged).
- Stage 3: none (literature queries only).
- Stage 4: a numerical look at `cl θ(U)` for a sample character of ℚ(√11) off `E` (P-sat1) — **not done**; registered as a prediction
  instead, for J51D to derive.

### Proposed edits for the front-page lane (not made here)

- `plans/STUB-measure-rigidity-three-fields.md` §5 item 5: "not checked here" → J51-T1 (in T-C(A)'s class: exactly `d ≡ 47, 143, 167 (mod
  168)`); §2.3's "probably includes ℚ(√167) (not checked)" → checked, yes.
- `BIBLIOGRAPHY.md`: EL2021 (arXiv 2101.11120v1; §1 read), EL2003 (summary only), Rudolph 1990, Johnson 1992, Host 1995 (reviews only),
  Z. Wang 2012, Lindenstrauss–Wang 2012 (summary/review only), Bekka–Francini 2022 (debt); EL2021's copy to `~/source/library/`.
- J43's facts file: tag ℚ(√143), ℚ(√311), ℚ(√335) with row 113's class form (J51-T1).

### Theorems this phase proved

- None new (J51-T1 to T3 are in stages 1 and 3).

## §R-close — the close (WORKFLOW step 9, the mathematics half; crunch job J53, the close planner)

*Written by J53 (de Bruijn, Opus 5.5, 2026-09-26) under `data/crunch-2026-09-25/briefs/J53-FS100-close-math.md` (templates J41's and J23a's
briefs) and `STANDING-RULES.md`, worked from `plans/FS100-close-inventory.md`. Results are filed in `plans/FS100-derivation.md`; every draft for
`LEDGER.md`, `CLAUDE.md`, `BIBLIOGRAPHY.md` and `plans/FRONTIER-STUBS.md` is written here and nowhere else. Nothing here judges a verdict a record
reached; where the records differ, both are filed. **The milestone's target — MR, and through it five colours at ℚ(√47) — is not reached; its
stage-4 lemma is refuted as stated by two minds, with its corrected form pinned at a named step.** Working files: `data/fs100/j53/`.*

### Stage 1 — SAVED (quotation check; reconciliation; K0's one-step check; the inventory walk)

**Quotation check of the brief (standing rule 5).** Every quoted or summarised item was checked against its source:
- the commit facts — `2654b675` at 23:59:22 ("J51D: stage 1 (obligation-modeling pass, C0)", its C0 row "KS-1 | 0.10 | 0.80 | 0.10"); `aa12db5e` at
  23:58:31, whose §M.1 already reads "**`T + A` is the wrong subgroup to select onto**" and "Over a field with a two-colouring (`ℚ`) that is enough
  for a proper `W` with `Γ ∩ (T + A) = 0`"; `3648d3a5` at 00:01:16, subject "FS-100 close inventory: J51V's items, the owner's check of its
  counterexample, rulings"; `616ee08b` (J51D stage 2) at 00:03:57 — **exact** (`git log -1 --format=%ci`);
- the results list against J51D's and J51V's records and reports — **faithful**, with one wording note: the brief's "every real field with a
  ramified stable dyadic place, i.e. `χ(F²) = 2`" joins J51V-X2 (a) ("a stable dyadic place ramified in `L/F`") and J51D §2.4 ("a stable place with
  residue field `𝔽₂`, i.e. `χ(F²) = 2`, G56"); for a real number field the two conditions coincide (G55: `χ(F²) = 2 ⟺ L(F) = 2`; G56's ramified
  case), so the join is exact;
- J51's report says "INVENTORY: 30 lines follow" and holds **29** (inventory rows 1–29 are those 29); J51's held item (4) (the `CLAUDE.md`
  snapshot) had no row — added as row 68.

#### 1.1 Reconciliation — the divergence table

*Per claim and per extension: J51D's verdict, J51V's verdict, the routes, the scope, and whether the routes are independent. "Blind" means the
mind had not seen the other's work; the owner's check (inventory row 48) is a third mind, not blind.*

| claim / extension | J51D | J51V | routes | independent? |
|---|---|---|---|---|
| **KS-1** (select onto `T + A`) | FALSE, T3 over ℚ: `Θ = (τ + ψ_w, τ + ψ_w̄)`, `W = 2[t₁ ≥ ½] + [t₂ ≥ ½]` | FALSE, X1 over ℚ: `Θ = (θ + ψ_w, θ + ψ_w̄)`, `W = 2⌊2t₁⌋ + ⌊2t₂⌋` — **the same `Θ` and the same `W`** | the cross (T2 (a) / X1 step 1): the same one-line identity `ι(ū) = ι(u)⁻¹`; `K̂′ = 0`: J51D by strong approximation (T2 (b), every field), J51V by an explicit subring `R₀` and orders `5^k` (at ℚ) | **the same counterexample found twice**: J51V blind; J51D's construction sketched in its own §M.1 at `aa12db5e`, before any disclosure; its written proof after `3648d3a5` (ruling 2). The `K̂′ = 0` steps are different proofs |
| KS-1's reach | every real field with `χ(F²) = 2` | every real field with a ramified stable dyadic place (X2 (a)); the `k²`-colour analogue over **every** real field (X2 (b)) | X2 (b) replaces parity by a band character's `k`-colouring: a co-normal product (§3.2 reading) | X2 (a) = J51D's reach (one class); **X2 (b) one mind (J51V)** |
| KS-1 at `n = 1` | not stated | TRUE given row 98 (N1) | N1: a proper `W` forces `0 ∉ cl θ(U)`, so `θ` is a band character, row 98 puts it in `T + A` | one mind (J51V); see ruling 1 |
| **KS-2** | TRUE, T1 in a general form (`K` compact abelian, `C + H = C`), change of variables | TRUE, Weil's formula and a Borel section | two proofs of one Fubini argument | **two derivations, blind to each other** (J51D fenced from J51V; J51V blind) |
| **KS-3** | FALSE, `Θ = (ψ_w, ψ_w̄)` over every real field; non-vacuous over ℚ(√11) with `θ_{C9}` added (KS-sat not necessary for KS-1) | FALSE, the same example; also `(ψ_w, ψ_w̄)` alone, every field | the cross | two derivations; the non-necessity remark one mind (J51D) |
| KS-3 at `n = 1` (P-sat1: `θ ∉ T + A ⟹ cl θ(U) = T`) | T4 TRUE inside `E` (every field); T5 TRUE at ℚ; **GAP** off `E` for general `F` (field form of PA-B2 and JC) | "Not decided … not needed for any verdict" (§2.5) | — | one mind (J51D); no divergence |
| conjugate-pair dichotomy | T2 (a), (b), every real field, every split place | (a) as X1 step 1 and §2.5's mechanism, every field; (b) only at ℚ, at 5 | (a) one line; (b) strong approximation vs explicit orders | (a) two minds + the owner's check; (b) in general one mind (J51D), at ℚ two |
| no naive vector band rigidity | implied by T3 (`0 ∉ cl Θ(U)`, `K̂′ = 0`) | X2 (c), stated | a witness is X1 = T3 | the witness is two minds |
| **KS-4, KS-5** | TRUE, "uninformative": "`θ₁ ∉ E`" never used (§2.5) | TRUE; §2.1–§2.2 "what a wrong-reason pass looks like"; KS-5's "image" → "closure of the image" | `W` factors through `π` | two derivations, **both minds found the controls unable to fail** |
| **KS-C** | TRUE as an implication; KS-C_E TRUE; at ℚ(√47) KS-1 ⟺ KS-1_E ⟺ KS-C's conclusion (§3.3) | TRUE as an implication, "hollow"; J51V-EQ: KS-1 at `F` ⟺ X at `F` wherever T-C(A)@∅ holds; X holds for `Θ ∈ Eⁿ` and at `n = 1` | random placement, then T-C(A) | two derivations; the equivalence at ℚ(√47) reached by both |
| KS-1_E / KS-sat_E (the corrected statement) | proposed; **GAP** at J51D-R's density step | — (not on the fixed list) | — | one mind |
| **K0** | not started (stop rule) | TRUE with a scope note (A⁺ at a finite `S` needs T-C(A) at that `S`); class membership not blind | — | one mind + J53's one-step check (ruling 3) |
| the mechanism | §M.1: fibres "small but colourable" (an OR fibre; the product case is Hedetniemi-type) | §3.2: the co-normal product `Cay(T, I) ∗ Cay(T, I)`, `χ(G)²`-colourable [reading] | — | two readings of one mechanism, one mind each |

**Ruling 1 — rank one: two different statements, no divergence.** J51V-N1 is KS-1 at `n = 1`: if `θ ∉ T + A` and a proper `W` exists then
`0 ∉ cl θ(U)` (J51V-L2: `s = 0` would violate properness), so `θ ∈ Θ_k` for some `k` and row 98 puts `θ ∈ T + A`; the hypothesis is empty, the
claim holds vacuously; if `θ ∈ T + A`, `K′ = K`. J51D's GAP is KS-3 at `n = 1`: for `θ ∉ T + A`, purity (J51V-L0) gives `K̂′ = 0`, `K₀ = K =
cl θ(R) = T` (`θ` non-torsion), and KS-sat reads `cl θ(U) = T` — a density statement. The two are logically independent in the needed
direction: density implies N1 (then `0 ∈ cl θ(U)`), N1 does not imply density. **The owner's reading is confirmed**; J51V's "KS-sat at `n = 1`:
not decided" is the statement J51D decided in part. Filed as two entries.

**Ruling 2 — KS-1's independence.** J51V's X1 is blind (fence log §1.2: its one breach touched only K0's class membership). J51D's
counterexample was predicted and its construction sketched in its own committed §M.1 (`aa12db5e`, 23:58:31) and priced FALSE 0.80 in C0
(`2654b675`, 23:59:22), both **before** `3648d3a5` (00:01:16) put "counterexample" into a subject J51D could read (owner error, inventory row 52);
its stage-2 write-up committed at 00:03:57. **Grade: KS-1 FALSE — [hand + tools exact; two derivations: J51V blind, J51D independent in its
construction (committed before the disclosure) and possibly informed, in its write-up, that the verifier had refuted some claim; the owner's hand
check a third, not blind].** The `K̂′ = 0` step has two different proofs; the counterexample itself is one object found twice.

**Ruling 3 — K0, J53's one-step check (not blind: J51V §2.7 and J45 §§3, 4.1–4.2, 5.4 read).** SP-Cor's proof (J45 §4.2) uses, in order: (i) an
`R ⋊ U`-invariant measure on the compact `X₄(F)` — `R ⋊ U` countable and abelian-by-abelian, `x ↦ vx + y` an automorphism of `Cay(R, U)` for
`v ∈ U`: **every real number field**; (ii) `σ_μ` is `U`-invariant (`C(vy) = C(y)`): **field-free**; (iii) R-U: stated and proved by J45 "for every
real number field" (its N1 (b) supplies density with no Lemma R); (iv) A⁺ at `S = ∅` with remark (ii): its proof uses SI-4 and N2 (field-free:
statements about `μ`, `𝒜_S`, `τ′_S`) and **T-C(A) at `S = ∅`** — J45's own lemma text already reads "Over ℚ(√47) (and every field in T-C(A)'s
class)". No step reads ℚ(√47) except through T-C(A). **T-C(A) at `S = ∅` at the three fields.** R88-TCA's proof at ℚ(√47) lists its inputs as
"11 and 19 by FS-66, the tail by Hoffman — the maximum 31's `1/4 − 2.745·10⁻⁶` —, the ramified 47 by Lemma P, the real places `m₁`, split places
0". Re-derived by Legendre symbols (J53, by hand): ℚ(√143) — `143 ≡ 7 (mod 8)` (dyadic split in `L/F`), `(143/3) = (143/7) = (143/19) = (143/23) =
−1` (inert, not stable), 11 ramified (FS-66 through Lemma P (ii)), `(143/31) = +1` (31 split, stable: Hoffman `1/4 − 2.745·10⁻⁶`), 43 and above by
Weil + Hoffman + Lemma P; ℚ(√311) — `311 ≡ 7 (mod 8)`, `(311/3) = (311/7) = −1`, 11 and 19 split (FS-66), 23 and 31 split (Hoffman 0.249077 and `1/4 − 2.745·10⁻⁶`,
Lemma P (i)), 311 ramified (Weil + Lemma P); ℚ(√335) — `335 ≡ 7 (mod 8)`, `(335/3) = (335/7) = −1`, 11 split (FS-66), 23 and 31 split
(Hoffman), 67 ramified (Weil + Lemma P). The stable lists below 100 were re-checked by exact Legendre symbols (sympy, seconds): {11 ram, 31,
43, 47, 59, 67, 71, 79}, {11, 19, 23, 31, 43, 59, 71}, {11, 23, 31, 47, 67 ram, 79, 83} — J51V §2.7's lists exactly. Each input of R88-TCA's list has its
analogue; the real places are two `m₁`'s; split places 0. So T-C(A) holds at the three fields **at R88-TCA's class-form grade (J28D, one mind
outside ℚ(√47))**, and SP-Cor and A⁺@∅ hold there with J45's proofs. **Grade of K0: [hand; one mind (J51V) + one-step check (J53); class
membership J51-T1 (hand + tools exact, one mind) with J51V's partly blind check; resting on R88-TCA's class form (one mind)]**, the house form of
FS67-CL. J51V's scope note stands: A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which R88-TCA's class form supplies.

#### 1.2 The inventory walk

Rows 1–52 are the owner's; J51D's report (13 lines and 2 held items, after the last row) and J51's held item (4) had no rows — added as rows
53–68. Dispositions (the ticks are written into the inventory's status column):

| disposition | rows |
|---|---|
| done now (answered in this stage or by a job; nothing owed) | 30, 31, 32, 34, 49, 50, 51, 67, 68 |
| → stage 3, the derivation file | 1, 2, 3, 35–41, 48, 53–59 |
| → stage 4, §R-close (re-reads, predictions, verdict, tallies, ban measurement, §PA sweep) | 4, 13–17, 20–29, 45–47, 52, 61–63 |
| → stage 2, the close-time prior-art gate | 5–9, 64 |
| → stage 5, drafts, stub files and the file move | 10, 11, 12, 18, 19, 33, 42, 43, 44, 60, 65, 66 |

**Would have searched here (stage 1):** none — reconciliation, and Legendre symbols of four fixed fields at the primes below 100 (by hand, then
re-checked by sympy in seconds: a complete enumeration the derivation fixed, at the ban's edge).

### Stage 2 — SAVED (the close-time prior-art gate, time-boxed; the file move)

*Method (WORKFLOW 3.2 item 8, G49): zbMATH Open API for discovery, in the disciplines' words, with `ab:`, `ti:` and all-field queries side by side
(G49: `ab:` cannot hit a record whose summary is withheld). Tool `data/fs100/j53/zb.py` (J51's `zb.py` with an HTTP 404 read as zero hits — the
API answers 404 to an empty result); every query and hit in `data/fs100/j53/gate.out`. **Controls:** `ti:"topological self-joinings"` must hit
Lindenstrauss–Wang 2012 (it does, Zbl 1258.37031); `"Borel chromatic number" & "Cayley"` must hit `[BardestaniMallahiKarai2017]` (it does, Zbl
1360.05050). About 25 queries.*

**Verdicts, per filed theorem.**

| theorem | queries (disciplines) | verdict |
|---|---|---|
| KS-1's counterexample (J51V-X1 = J51D-T3) and J51V-X2 | measurable/Borel chromatic numbers of Cayley graphs on compact abelian groups (`ab:"measurable chromatic number" & ab:"Cayley"` 1 hit, Weilacher 2022, locally finite Borel graphs — not this; `"Borel chromatic" & "abelian"` 2 hits, Gao–Jackson 2015 and Gao–Jackson–Krohne–Seward 2024, Bernoulli shifts of `ℤⁿ` — not this); Kronecker factors and discrete spectrum (`"discrete spectrum" & ("coloring" \| "colouring")`, `ab:"Kronecker factor" & ab:"coloring"`: 0); measurable Hedetniemi (`"Hedetniemi" & ("measurable" \| "Borel")`: 1, Todorčević–Vidnyánszky 2021, a complexity result — not this) | **not found**. Its two ingredients are textbook: the norm-one torus at a split place is `F_v^×` embedded as `y ↦ (y, y⁻¹)`, and a co-normal (disjunctive) product is `χ(G)χ(H)`-colourable (`"disjunctive product" & "chromatic number"`: Akgüneş 2018, Fritz 2021; `ab:"co-normal product" & ab:"chromatic"`: Körner–Pilotto–Simonyi 2005 — the product's standard literature). The counterexample is a new use of both, filed as ours at "not found" |
| J51D-T2, the conjugate-pair dichotomy | `"norm one torus" & "orbit closure"`: 0 | (a) **textbook** (a restatement of `u ū = 1` at a split place); (b) strong approximation, standard. Filed as a lemma with its textbook status stated, not as a new theorem |
| KS-2 (J51D-T1, J51V-KS2) | `ab:"measurable coloring" & ab:"compact abelian group"`: 0 | **not found** as stated; a Fubini selection of the folklore kind. Filed as ours at "not found; likely folklore" |
| J51-T1 (the class ⟺ `d ≡ 47, 143, 167 (mod 168)`) | `"chromatic number" & "quadratic field"`: 0; `"unit distance" & "quadratic field"`: 0; `"unit distance graph" & ("rational points" \| "number field" \| "algebraic numbers")`: 1 (Füredi–Kang 2004, ℓ₁ — not this) | the congruence family `L ≥ 5` is G61's, from `[Fischer1990]` Thm 10 (held, read); **the identification with T-C(A)'s class is ours** (its terms — all-levels four-colour ratios at stable places — are this project's) |
| J51D-R (the reduction of KS-sat_E) and the rank-one lemmas J51D-T4/T5 | `"topological self-joinings"`: 2 (LW2012, `[Wang2012]`) | the nearest literature is the topological-rigidity line (Furstenberg 1967, Berend 1983/84, `[Wang2012]`, Lindenstrauss–Wang 2012); **neither Wang paper's hypotheses hold here** (J51-T2: no finitely generated `Γ ⊂ U` acts irreducibly on `R̂`). T4 and T5 compose held lemmas (weak approximation; FS89's PA-B2, VB1, SW-m) |

**What the gate taught about the object (for the §PA sweep, stage 4).** Lindenstrauss–Wang's review (read in full): topological rigidity "means
that closed invariant sets are either infinite or unions of translates of closed subgroups", and for Cartan `ℤ^r` actions the diagonal action on
`𝕋^d × 𝕋^d` "has strong topological rigidity properties for `r ≥ 3` but not for `r = 2`". **KS-3's failure is exactly the allowed case**: the
orbit closure `(T × 0) ∪ (0 × T)` of the pair `(ψ_w, ψ_w̄)` is a union of two closed invariant subgroups — rigid in Berend's sense, and not a full
fibre. KS-sat asked for more than topological rigidity ever gives; the right saturation statement must allow unions of subgroup translates.
[reading, J53]

**Reading status (G50), for the bibliography drafts (stage 5):**
- **EL2021 is held, and was before this milestone**: `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`,
  key `[EinsiedlerLindenstrauss2022]` (J23p, 2026-09-25, "read: §1, pp. 1–3"), **byte-identical** to J51's fetch (md5
  `1a32060a31636fcad481901dfa1c7e7b` both). Reading status unchanged: §1 read (J23p; J51 again); §§2–9 unread.
- **Z. Wang 2012 is held**: `[Wang2012]`, `library/pdf/Wang2012-rigidity-commutative-non-hyperbolic-toral.pdf`, "read: abstract, §1, §2.3, §4.1, the
  start of §4.2 (2026-09-25, J23p)". J51's §PA.2 and inventory row 8 call it "author's summary only … unread": **it was held and part-read**.
- Lindenstrauss–Wang 2012 (Duke 161, Zbl 1258.37031): **not held**; zbMATH review read in full (J53). EL2003 (Zbl 1068.37002): author summary only.
  Rudolph 1990, A. Johnson 1992, Host 1995: zbMATH reviews only (J51); the bibliography's joint row says "Listings only (J28 §PA.4)" — to be
  updated. Bekka–Francini 2022 (Zbl 1518.22005): title and the review's first lines only (J51).
- **Debts, and whose.** None of these bears on the truth of a filed theorem; LW2012, the rest of `[Wang2012]` and EL2021 §§2–9 bear on the GAP
  (KS-sat_E's density step) and on MR, so they stay **the next FS-100 slot's reading** (the brief's default), as does Bekka–Francini.

**A G50 instance (for the honesty tally).** J50 wrote "the four measure-rigidity papers are 'none held'" and J51 re-fetched EL2021 into the
repository and read `[Wang2012]` by its zbMATH summary — both papers had been held and part-read since J23p's gate the day before, under keys by
**journal year** (2022) where the milestone searched by arXiv year (2021). The bibliography's own rows would have answered in one grep of the
arXiv id `2101.11120`. *Do* (for G49's list): grep `BIBLIOGRAPHY.md` for a paper's arXiv id and Zbl number, not only its author–year key, before
fetching or calling it unheld.

**The file move.** The house copy exists already (above), so nothing is copied; `data/fs100/j51/el2021.pdf` is removed from the repository by
`git rm` in this stage's commit. The bibliography draft names `[EinsiedlerLindenstrauss2022]`'s existing address.

**Would have searched here (stage 2):** none — literature queries only.

### Stage 3 — SAVED (the derivation file)

`plans/FS100-derivation.md` files every theorem the round proved outside the kernel: **15 entries** covering J51's T1–T3 (T3 merged into
FS100-KS2, the sketch written out), J51D's T1–T5, KS-3, R, C and the controls, and J51V's L0–L2, KS2, X1, X2, N1, EQ, K4, K5 and K0 — duplicates
merged, one entry per theorem with every other id in its title. The card's answer, PE-lim, KS-1_E/KS-sat_E and the field form of P-sat1 are
stated, not filed (the file's §G). Id spelling: `FS100-X2B` for J51V-X2 (b)–(d) (X2 (a) and (c) sit in FS100-X1).

| verification | entries |
|---|---|
| two derivations, blind to each other | FS100-L0, FS100-KS2, FS100-KS3 (the counterexample), FS100-EQ (the implication and the equivalence), FS100-C45; FS100-CP (a) with the owner's check |
| two derivations, one of them possibly informed in its write-up | FS100-X1 (ruling 2) |
| one mind | FS100-X2B (J51V), FS100-N1 (J51V), FS100-T4, FS100-T5, FS100-R (J51D), FS100-T2 (J51); FS100-CP (b) in general; FS100-KS3's non-necessity clause; FS100-EQ's `E`-form |
| one mind + checks | FS100-T1 (J51; J51V's partly blind re-derivation; J53's Legendre re-check); FS100-K0 (J51V; J53's one-step check; on R88-TCA's class form) |

**Kernel decisions:** all fifteen declined, each with its reason in the entry; no stub route (the file's §K).

**§ B lines (drafts for `LEDGER.md` § B, 15 lines):** `data/fs100/j53/ledger-b-draft.md`, reproduced in stage 5's drafts. Checked by
`data/fs100/j53/check_b_draft.py` (J41's tool with the prefix changed): `tools/fs71_ledger_b_check.py`'s own parser and `--strict` check with the
drafted lines appended to `LEDGER.md`'s text in memory, restricted to `FS100-` ids — **PASS, 15 entries, 15 lines, 0 failures, exit 0**
(`check-b.out`; a first run caught two `*Proof verdict:*` fields broken across a line, fixed); the plant (one drafted line dropped) **FAILS, exit 1**
(`check-b-plant.out`). The repository-wide `python3 tools/fs71_ledger_b_check.py --strict` reads **FAIL (15), exit 1** — exactly the fifteen
`FS100-` ids, and nothing else (`repo-check.out`) — until a front-page job applies the § B lines.

**Would have searched here (stage 3):** none — filing only.

### Left for a successor on the same brief (J53 handed back at its context line after stage 3)

- **Stage 4** — the §G re-read and forward propagation; the §IQ re-read and G72's count; the §PA sweep (candidates: FS100-CP's dichotomy; J51V's
  co-normal reading; stage 2's "orbit closures are unions of subgroup translates", which also decides the no-swap trigger — FS100-KS3's note says
  stage 6 does not take the slot, to be ruled here); predictions scored once each (X-KS, P-sat, P-sat1, P-K0, P-EL, P-ent, X-MR, X-R1, J50's
  hunch and card, both C0 tables); the verdict in four parts; the honesty tally (inventory rows 32, 46, 47, 52, 62, 63, 34; stage 2's G50 instance;
  J51's 30-for-29 lines); the ban measurement (every would-have-searched line). Inventory rows ticked "→ stage 4".
- **Stage 5** — drafts: `LEDGER.md` rows **116** (Kronecker selection refuted as stated; KS-2; the `E`-form and FS100-EQ), **117** (T-C(A)'s
  class = `L ≥ 5`; K0), **118** (rank one: N1, T4, T5; FS100-T2 and the card) — last number 118; the § B lines (`data/fs100/j53/ledger-b-draft.md`,
  checked); `CLAUDE.md` lines ≤ 3,000 bytes net; `BIBLIOGRAPHY.md` rows (update `[EinsiedlerLindenstrauss2022]` and `[Wang2012]` rather than add;
  new: EL2003, Lindenstrauss–Wang 2012 (review read), Bekka–Francini 2022; the Rudolph/Johnson/Host row "Listings only" → "zbMATH reviews
  (J51)"); the stub re-aims as files (FS-100: stage 4 → KS-sat_E at ℚ(√47), K0 done, §2.3 cell and §5 item 5 corrections, PE-lim as stage 5, P1
  leads post-ban; FS-64: Kronecker selection with T-C(A) in the `E`-form). Inventory rows ticked "→ stage 5". The file move is done (stage 2).

### Stage 4 — SAVED (J53b, the successor on the same brief: rulings; the re-reads; predictions; the verdict; the tallies; the ban measurement)

*J53b (de Bruijn, Opus 5.5, 2026-09-26), resuming J53's brief at its first stage not SAVED (stages 1–3: `7fc933c7`, `0c61c274`, `0820043b`;
report `5bcc8105`). Nothing saved above is redone.*

**The owner's rulings on J53's held items (verbatim, the owner's message to J53b, 2026-09-26), applied here and in stage 5:**
1. "Inventory row 66: KS-1 is recorded as refuted as stated, with KS-1_E (selection onto E = T + A + Fin_S) as the corrected, open statement.
   FS-100's stage 4 is re-aimed, not closed as a no-go."
2. "The no-swap trigger fired in its letter, not its sense: stage 6 (EI-2 over ℚ(√11)) does not take the derivation slot; the re-aimed stage 4
   (KS-sat_E at ℚ(√47), J51D-R's density step) leads FS-100's next slot, with stage 6 kept as the fallback. Write that into the stub."
3. "J53's G50 finding (EL2021 and Z. Wang 2012 were held since J23p under [EinsiedlerLindenstrauss2022] and [Wang2012], while J50 and J51
   called them not held or unread) is an honesty-tally item and a G50 instance to draft for the front page, with its Do: grep BIBLIOGRAPHY.md by
   arXiv id and Zbl number before fetching."

*The trigger, for the record.* §S's head: "it changes if J51D finds KS-sat false while Kronecker selection is true — then the input is
measure-theoretic after all and stage 6 takes the next slot." In letter it fired: KS-sat is false while KS-1's conclusion holds on ℚ(√11)'s
instance (FS100-KS3's non-necessity clause). In sense it did not: KS-1 is false too (FS100-X1), and KS-sat's failure is closed-set and local — the
orbit closure of `(ψ_w, ψ_w̄)` is the cross `(T × 0) ∪ (0 × T)`, a union of two closed invariant subgroups, which Lindenstrauss–Wang's topological
rigidity allows (stage 2) — while the corrected form's missing step is a density statement (FS100-R), not the zero-entropy measure problem.

#### 4.1 The §G re-read (which extractions paid; which bore and were missed) and forward propagation

| entry (the plan's §G line) | outcome |
|---|---|
| G46 + G30: `R̂` a solenoid, Kronecker selection an orbit-closure (self-joining) question (§G.4 item 1) | **paid** — the orbit closure `cl Θ(U)` is the invariant that decided KS-1 and KS-3 (the cross: FS100-X1, FS100-KS3) and reduced the corrected form to one density step (FS100-R) |
| G55: `R = O′` makes `R̂` S-adic with S infinite | **paid** — FS100-T2 in two lines; FS100-CP (b) by strong approximation |
| G35, G43, G44, G66: the class check's inputs | **paid** — FS100-T1 (the class = `L ≥ 5`), re-checked by J51V and J53 |
| G74 + rows 96, 98: rank one of Kronecker selection is band rigidity | **paid** — FS100-N1 is exactly that sentence, proved (J51V) |
| G51: one derivation + one blind verifier from a fixed list | **paid** — the same counterexample found twice, both controls found uninformative by both, no divergence of truth (§R-close 1.1) |
| G48, G64: targets as values of `L`; S and W apart | **paid** in wording; no ℚ(√167) claim was made |
| G21 (route dependence; controls of the right shape) + §G.3's "a positive control proves only its generator's shapes" and "count generator parameters" | **extracted and misapplied** — the plan added the rank-two control KS-5, but its `W` still reads one coordinate, so both controls lie inside the image where KS-1 cannot fail (FS100-C45; inventory row 62). The rule was named and the control was built inside the same generator image: a G21 instance (drafted, stage 5) |
| G77: CLG is existence-only; C9 the control | **used for the control only.** Its *Do* — "name the extra input … before saying every character colouring is local" — bore on KS-1 itself: a selection uniform over every real field is a classification claim for Kronecker (vector) colourings, which G77 and FS-92 hold open at `k ≥ 4`. The uniform quantifier should have been flagged at §S |
| G56 (the ramified dyadic case) and G38 (the two-colour criterion), both marked silent | **missed.** FS100-X1 lives exactly where these entries put `χ(F²) = 2`: KS-1 quantified over every real field, the bipartite ones included, where a parity character times a split-place cross four-colours for free. Read against KS-1's quantifier, G56's *Do* ("L is 2, 3, 4, 5 or ≥ 7 before any solver") prices FALSE before any derivation — which J51D's domain pass did (`aa12db5e`). **Instance for WORKFLOW 3.1:** a lemma quantified over a class of fields is read against the grokking that decides each sub-class's value, the smallest values first |
| G50: "EL 'recalled, not read' is the debt" | **missed in its own letter** — EL2021 and `[Wang2012]` were held and part-read (ruling 3; stage 2). A G50 instance, drafted in stage 5 with the ruling's *Do* |
| G27, G54, G60, G71, G73, G76, G79 | not exercised: stage 5 (MR) and P1 did not run; G76's closed-set frame held (KS-3's failure is closed-set) |

**Forward propagation.** No new grokking is minted (the decline, in four parts, is §4.3's). The G76 sentence drafted in stage 5 (the split-place
cross, and saturation modulo unions of subgroup translates) bears on: **FS-100** (the stub's stage 4, written as a file in stage 5); **FS-64** (the
`E`-form of its windows, written as a file in stage 5); **FS-92** (FS100-X1's clause (c), no naive vector form of band rigidity, is a
classification statement for character vectors — a provisional-bearings line, drafted for `plans/FRONTIER-STUBS.md`); **FS-84** (FS100-K0: its
five-clause route is shared with ℚ(√143), ℚ(√311), ℚ(√335) — drafted likewise). FS-84's and FS-92's stub files are outside this brief.

#### 4.2 The §IQ re-read, G72's count and G79's record

- **§IQ item 3 named the invariant, and it decided the round.** "Layer 1: the orbit closure of `Θ` under the diagonal `U`-action on `R̂ⁿ`" — computed
  at one split place, it is the cross, and the cross refutes KS-1 and KS-3 and shows why ℚ(√47) is out of the counterexample's reach (a co-normal
  product needs a bipartite factor at four colours, FS100-X2B). The reduction of the corrected form (FS100-R) is the same invariant's density
  question. FS100-T1 came from extending a known tool (Legendre symbols and Lemma P, at the ban's edge). Layer 2's invariant (a property of every
  four-colouring beyond its pair correlations that forces positive entropy) was **not found**; stage 5 did not run.
- **G72's count, twelfth (FS-100):** through the structural question — its named invariant decided both uniform claims negatively and reduced the
  corrected one to a named step; T1 by extending a known tool; layer 2's invariant not found: **twelve of twelve**.
- **G79's record:** the result came from an **example** — an actual proper Kronecker four-colouring of ℚ² (FS100-X1) — and its invariant (the
  cross); the counterexample invariant MR/SP was not advanced. It moved the question: the target relocated from `T + A` to `E`, and at ℚ(√47) the
  selection, its `E`-form and the pure-point conclusion became one statement (FS100-EQ).

#### 4.3 The §PA sweep — what the gate taught about the object

| recognition | where it goes | decision |
|---|---|---|
| FS100-CP (a): at a split place the norm-one torus is `y ↦ (y, y⁻¹)` — the unit circle is a hyperbola — so the two conjugate primes' characters send `U` into a cross | **already in-house and in print**: FS86-Cx-C1 ("the field plane embeds injectively in the hyperbola graph at every split place", `LEDGER.md` § B) and `[BardestaniMallahiKarai2017]` §3.2 (the split-place hyperbola, in § The prior-art position's "Not ours") — **added to FS100-CP's *Prior art:* field in this stage**; the new content is the vector reading: no non-zero combination lands in `T + A` (FS100-CP (b)) | a G76 sentence (stage 5), not a grokking |
| J51V's co-normal reading: at a split place `Cay(R, U)` maps into `Cay(T, I) ∗ Cay(T, I)`, `χ(G)²`-colourable | why the counterexample needs `χ(F²) = 2` at four colours, and why ℚ(√47) is out of its reach (FS100-X2B) | a reading (J51V's, with its killing test), carried in FS100-X2B and the FS-64 stub; not a grokking (one mind) |
| Lindenstrauss–Wang 2012's topological rigidity: closed invariant sets are unions of translates of closed subgroups; KS-3's cross is such a union | the corrected saturation must be stated modulo unions of subgroup translates, or it asks for more than rigidity gives | a design note in the FS-100 stub's stage 4 (stage 5); [reading, J53] |
| FS100-T1: among real quadratic fields "every stable place below `1/4` at all levels" is the conjecture's `L ≥ 5` | item 10's line (stage 5) | a Frontier line |

**The decline of a new grokking (four parts).** *Choice:* no G80; the split-place cross enters G76 as one sentence. *Alternative:* mint G80, "the
split-place cross", with a *Do* (at a split place, test every multi-character statement against `(ψ_w, ψ_w̄)`) and a killing test. *Why:* the fact is
textbook and already twice in-house (FS86-Cx-C1, BMK §3.2); its one new consequence (no vector band rigidity; KS-1 false) sits where G76 already
holds the closed-set frame, and a new entry in the *Do*/killing form costs about 900 bytes of a 3,000-byte allowance. *Confidence:* medium — if a
second milestone trips on the cross, it earns its own entry.

#### 4.4 Predictions, scored once each

| id (source) | registered | outcome | score |
|---|---|---|---|
| X-KS (§P) | KS-1 TRUE 0.50 / FALSE 0.15 / GAP 0.35 | FALSE (FS100-X1) | **lost** (FALSE at 0.15) |
| P-sat (§P) | KS-2 TRUE 0.85 | TRUE (FS100-KS2) | met |
| P-sat1 (§P) | KS-3 at `n = 1` TRUE 0.70 | TRUE inside `E` (FS100-T4) and at ℚ (FS100-T5); GAP for general `F` off `E` | met in part; the rest open |
| P-K0 (§P) | K0 TRUE 0.75 | TRUE with a scope note (FS100-K0) | met |
| P-EL (§P) | EL2021 Thm 1.3's hypothesis holds for generic `Γ` 0.80 | not tested (stage 5 did not run) | unscored; carried to the stub |
| P-ent (§P) | positive entropy forced here 0.05 | not forced; open | met |
| X-MR (§P) | MR true 0.7; decided here 0.02 | not decided | the 0.02 met; the 0.7 a belief, unscored |
| X-R1 (§P, carried) | FS-97's R1 closes by a limit argument 0.3 | not tested | carried to the stub |
| J50's hunch `mr-is-open-measure-rigidity` | MR at least as hard as a known open problem unless its hypotheses supply entropy or rank | its falsifier ("MR reduced to a published theorem whose hypotheses are met here") not met: EL2021 Thm 1.2's total irreducibility fails (FS100-T2) | holds |
| J50's card `is-mr-attackable`, hunch "first yes, second no" | — | "first yes, second no", the first yes conditional on PE-lim and a one-mind reading of Thm 1.3's hypothesis | met, conditionally |
| J51D's C0 (`plans/FS100-J51D-derivation.md` §1.4) | KS-1 F 0.80; KS-2 T 0.95; KS-3 F 0.90; KS-3 rank one T 0.55 / G 0.40; KS-4 T 0.97; KS-5 T 0.95; KS-C T 0.85; KS-1_E G 0.55; K0 T 0.70 | as filed | all modal outcomes met; K0 met by J51V's proof (J51D did not reach K0) |
| J51V's C0, first-read column (`plans/FS100-J51V-verification.md` §1.3) | KS-1 T 0.55; KS-2 T 0.85; KS-3 T/F 0.35/0.35; KS-4 T 0.92; KS-5 T 0.88; KS-C T 0.75; K0 T 0.80 | as filed | KS-1 **lost**; KS-3 FALSE (a tie); the other five met (J51V §3.3) |
| J51V's C0, at-writing column | KS-1 F 0.75; KS-3 F 0.85 (informed by the split-place idea) | FALSE, FALSE | met |

**What the table says.** Every uninformed prior on KS-1 was modal TRUE (the planner 0.50, J51V's first read 0.55); every prior written after a look
at the split place was modal FALSE (J51D's domain pass 0.80, J51V's at-writing 0.75). The modeling pass, run before any derivation, moved the
probability more than any reading did — the fresh `debruijn-domain-modeling` pass paid here in the most direct way available.

#### 4.5 The verdict (four parts)

- **The choice.** FS-100's in-ban round closes **not landed on its target** (MR, and through it five colours at ℚ(√47)), and **paid in theorems**:
  stage 4's lemma is **refuted as stated** by two minds with a counterexample over ℚ (FS100-X1), its reduction is true in an arithmetic-free form
  (FS100-KS2), its corrected form KS-1_E is **open at one named density step** (FS100-R), and at ℚ(√47) the selection, its `E`-form and the
  pure-point conclusion are one statement (FS100-EQ); T-C(A)'s class among real quadratic fields is the `L ≥ 5` family (FS100-T1) and SP-Cor holds
  over it (FS100-K0). **Stage 4 is re-aimed, not closed** (ruling 1), and the re-aimed stage 4 leads FS-100's next slot, stage 6 the fallback
  (ruling 2).
- **The alternative weighed.** Close stage 4 as a no-go ("Kronecker selection is false") and hand the slot to stage 6 (EI-2 over ℚ(√11)), since
  the no-swap trigger fired in its letter.
- **Why the choice won.** The refutation costs the uniform lemma, not the target: the counterexample needs a bipartite plane at four colours
  (FS100-X2B), unavailable at ℚ(√47), and at ℚ(√47) the corrected statement is exactly the question (FS100-EQ, two derivations). The failure is
  closed-set and local at one split place, and the corrected form's missing step is a density statement — the trigger's sense (a
  measure-theoretic input) did not fire.
- **Confidence: medium-high** on the re-aim; **medium** on the order — it changes if the next slot's reading of Lindenstrauss–Wang 2012 and
  `[Wang2012]` shows KS-sat_E's density step equivalent to a zero-entropy measure statement; then stage 6 leads.

#### 4.6 The honesty tally

| # | whose | what | source | disposition |
|---|---|---|---|---|
| 1 | J51 (planner) | § A of `LEDGER.md` read by row heads (~240 characters), the consumed rows deeper — declared | inventory row 32 | accepted for this milestone |
| 2 | J51 (planner) | the controls KS-4, KS-5 cannot fail — a G21 control of the wrong shape, named by both minds | row 62; FS100-C45 | a G21 instance, drafted (stage 5) |
| 3 | J51 (planner, as J51D's brief-writer) | the brief's "a FALSE … over ℚ(√11) is 'the first control'" dropped the source's "in the gap" qualifier | row 63; J51D §1.2 B5 | caught by J51D's quotation check (standing rule 5 paid) |
| 4 | J51 | its report promised 30 inventory lines and held 29 | row 68 | recorded |
| 5 | J51V | fence breach by a broad `grep … plans/*.md` (K0's class membership only) | row 46 | accepted (row 49); K0 graded not blind |
| 6 | J51V | two plants that could not fire (`c9-shift`, `forget-seven`), replaced by firing plants | row 47 | a G21 instance (the list's plants-that-could-not-fire line) |
| 7 | owner | J51V's fence wording literally included J51V's own commits and report | row 34 | clarified at launch |
| 8 | owner | commit `3648d3a5`'s non-neutral subject ("… its counterexample …"), visible to J51D at its stage 1 | row 52 | FS100-X1 graded "J51D's write-up possibly informed" (ruling 2 of stage 1) |
| 9 | J47, J50, J51 (a chain) | EL2021 and `[Wang2012]` were in `BIBLIOGRAPHY.md` from `67fdcda2` (2026-09-25 19:30, J24 applying J23p's gate); J47's stub (`1332c108`, 21:51 the same evening) wrote "none held", J50's card carried that sentence as evidence, and J51 re-fetched EL2021 into the repository and read `[Wang2012]` by its zbMATH summary | stage 2; owner ruling 3 | a G50 instance, drafted (stage 5) with the ruling's *Do*. *Precision:* J53's stage 2 wrote "J50 wrote 'none held'" — J50 quoted J47's stub |
| 10 | J53 | stage 1's walk left rows 5–9 and 64 at "→ stage 2" and row 33 at "→ stage 5" though stage 2 did them | inventory | ticked in this stage |
| 11 | J53 | handed back at ≈370k against a brief of "about 300k … hand back by 380k" — inside the hand-back line | report `5bcc8105` | recorded |

**Retractions:** none in either record — no verdict was committed and later withdrawn. J51V's timing note (its C0's two columns) is the one
self-correction, made before any verdict.

#### 4.7 The ban measurement (every would-have-searched line)

| job | would have searched | did instead |
|---|---|---|
| J51 (stage 4) | a numerical look at `cl θ(U)` for a sample character of ℚ(√11) off `E` | registered P-sat1 for derivation; J51D proved it inside `E` and at ℚ |
| J51D (stage 1) | sample characters of ℚ(√11) and plot `cl Θ(U)` | derived the valuation dichotomy (FS100-CP) |
| J51D (stage 2) | a proper `W` on `T²` or `T³` with small fibres | FS100-CP plus a hand-built `W` (FS100-X1) |
| J51V (stage 2) | a four-colour counterexample to KS-1 over ℚ(√47) (random character vectors, a `W`-finder on a discretised torus) | derived the split-place cross, and FS100-EQ: at ℚ(√47) such a counterexample is a four-colouring of the plane, so nothing short of the conjecture's falsifier exists to search for |
| J51V (stage 2) | float samples of `cl Θ(U)` to test KS-sat | the identity from `u_w u_w̄ = 1`, checked exactly on a fixed enumeration |

**At the ban's edge (complete enumerations of sets a derivation fixed, seconds each):** J51's Legendre symbols and stable-place lists (stage 1);
J51D's 25,492 unit vectors of height `≤ 20,000` (`tools/j51d_or_check.py`); J51V's 3,920 unit vectors (`tools/j51v_cross.py`) and its 49 linear
forms mod 7 (diagnosing an unreachable plant); J53's sympy Legendre re-check (stage 1). J51D's stage 3 and J53's stages 2–3 logged none.
**Measured:** five search moves were displaced, and every displacing derivation gave more than the search could have: a float sample of
`cl Θ(U)` cannot show that the closure *is* the cross, and a `W`-finder at ℚ(√47) would have been a finder for the conjecture's falsifier.

#### 4.8 Inventory ticks (this stage)

Rows 4, 13–17, 20–29, 45–47, 52, 61–63 ticked "done (J53b stage 4)" with their address in this stage; rows 5–9 and 64 ticked "done (J53 stage 2)";
row 33 ticked "done (J53 stage 2, `0c61c274`)". One correction made to a saved file: FS100-CP's *Prior art:* field in `plans/FS100-derivation.md`
gains its in-house and in-print addresses (4.3); nothing else there changes.

**Theorems this stage proved:** none (re-reads and tallies).

**Would have searched here (stage 4):** none.

### Stage 5 — SAVED (J53b: the drafts for the front-page lane; the stub re-aims as files; the inventory closed)

*Every draft below is for a front-page job to apply; nothing here was written into `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` or
`plans/FRONTIER-STUBS.md`. The `CLAUDE.md` and `LEDGER.md` drafts are machine-checked by `data/fs100/j53/front_page_drafts.py` against the files
as they stand: every anchor occurs exactly once, and `CLAUDE.md`'s net is **+2,357 bytes** against the brief's 3,000 (`front-page-drafts.out`,
exit 0; the plant — an anchor that does not exist — fails, exit 1, `front-page-drafts-plant.out`). The text below is that file's `--markdown`
output, so the two cannot drift. A front-page job re-runs the check first; an anchor moved by an intervening edit reads `FAIL`, never a silent
miss.*

#### 5.1 `LEDGER.md` rows 116–118 (the last number is **118**; FS-75's close numbers from 119) and `CLAUDE.md` lines

##### CLAUDE.md

- **item 10 — T-C(A)'s class among real quadratic fields (row 117)** — replace
  > carried by no `T + A + Fin_S`, `S` finite (row 113). With every

  with
  > carried by no `T + A + Fin_S`, `S` finite (row 113). Among real quadratic fields that count's class is exactly `L ≥ 5`, `d ≡ 47, 143, 167 (mod 168)` (row 117), so MR would give five at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47) (FS-100). With every

- **item 27 — Kronecker windows at four colours (row 116)** — replace
  > over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`.

  with
  > over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`. **Kronecker windows at four colours** (row 116; FS-100): selecting one onto its `T + A` characters is false — at a split place a unit vector is integral at one of the two conjugate primes, so the pair sees only a cross, and over a bipartite plane parity times the cross four-colours with no such factor; at ℚ(√47) the selection onto `E = T + A + Fin_S` is the five-clause's pure-point layer itself, open at one density step.

- **G76 — the split-place cross (body)** — replace
  > torsion orders all fail (rows 97, 102).

  with
  > torsion orders all fail (rows 97, 102). **For vectors of characters** a split place pairs its conjugate primes into a cross (`ψ_w(u) = 0` or `ψ_w̄(u) = 0` on every unit vector): no naive vector band rigidity, Kronecker selection onto `T + A` false (row 116), and a closed invariant set may be a union of subgroup translates (`[LindenstraussWang2012]`), which a saturation statement must allow.

- **G76 — the split-place cross (Do)** — replace
  > (one is not enough); when an invariant measure's

  with
  > (one is not enough); test a statement about several characters against a split place's pair `(ψ_w, ψ_w̄)` first; when an invariant measure's

- **G21 — FS-100's instances** — replace
  > (every circle is a similarity image of the unit circle).

  with
  > (every circle is a similarity image of the unit circle). **FS-100's two:** a rank-two control added under the rule that a control proves only its generator's shapes, whose window still read one coordinate, so neither control could fail (row 116); and two plants that could not fire.

- **G50 — FS-100's instance and the Do (owner ruling 3)** — replace
  > went unsearched. *Do: scan, at the opening

  with
  > went unsearched. **FS-100's:** EL2021 and `[Wang2012]`, in `BIBLIOGRAPHY.md` since the day before under a journal-year key, were written "none held" in the milestone's stub, carried so into the advisor's card, re-fetched, and one read by its summary. *Do: grep `BIBLIOGRAPHY.md` for a paper's arXiv id and Zbl number before fetching it or calling it unheld; scan, at the opening

- **G72 — the count's total** — replace
  > **The count so far — eleven of eleven**

  with
  > **The count so far — twelve of twelve**

- **G72 — the twelfth close** — replace
  > the three-colour selection not found.

  with
  > the three-colour selection not found. Twelfth, FS-100 — §IQ's named invariant, the orbit closure of `Θ(U)`, refuted both uniform selection claims and reduced the corrected one to one density step; the class identification by extending a known tool; layer 2's invariant not found.

- **G79 — its first record** — replace
  > which set counterexample invariants side by side.*

  with
  > which set counterexample invariants side by side; FS-100's result came from an example's (the cross of an actual four-colouring of ℚ², row 116).*

- **Paths forward — FS-100's row (rank 3; no rank moves)** — replace
  > stages 1 (blind check, J48) and 2 (KT-1, J49) done — the stub's status block; FS-97 absorbed; next the reframe, MR's reading room, Kronecker selection

  with
  > its in-ban round ran (the stub's status block): Kronecker selection refuted as stated, its `E`-form open at one density step, which leads the next slot, stage 6 the fallback (row 116); the class is `L ≥ 5` (row 117); MR = its zero-entropy half plus PE-lim (row 118); FS-97 absorbed; P1 leads post-ban

- **Paths forward — FS-64's row** — replace
  > (rows 92, 96, 101, 110, 112–113; FS-96, FS-98)

  with
  > (rows 92, 96, 101, 110, 112–113; FS-96, FS-98); four-colour Kronecker windows: the `E`-form open over T-C(A)'s class (rows 116–117)

- **Last updated — FS-100's in-ban round** — replace
  > FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub).

  with
  > FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub); then FS-100's in-ban round (rows 116–118) — **Paid (theorem); MR not landed** (`plans/FS100-three-field-lemma.md` §R-close).

##### LEDGER.md

- **§ A — rows 116–118 after row 115 (last number 118)** — append after row 115's line:

  | 116 | **Kronecker selection is false as stated, and at ℚ(√47) its corrected form is the question. For a real number field `F`, `R = ℤ[U_F]`, `Θ : R → Tⁿ` and a measurable `W` proper on `Cay(cl Θ(R), cl Θ(U))`, a proper `W′` on the factor `K/K₀` spanned by the `T + A` combinations need not exist: over ℚ, `Θ = (τ + ψ_w, τ + ψ_w̄)` (`τ` the dyadic parity, `w, w̄` above 5) with `W = 2⌊2t₁⌋ + ⌊2t₂⌋` is proper while `K̂′ = 0`; the same over every real field with `χ(F²) = 2`, and at `k²` colours over every real field. The reduction holds in an arithmetic-free form (`C + H = C` in a compact abelian group ⟹ selection to `K/H`); saturation onto `T + A` fails over every real field; and wherever T-C(A) holds, the selection, its form onto `E = T + A + Fin_S` (KS-1_E) and "no Kronecker four-colouring" are one statement, proved for `Θ ∈ Eⁿ` and `n = 1`, open for `n ≥ 2` off `E`** (FS-100; `plans/FS100-derivation.md` FS100-X1, X2B, KS2, KS3, CP, L0, EQ, C45, R). **[hand + tools exact; the counterexample two derivations — J51V blind, J51D's construction committed before any disclosure, its write-up possibly informed — and the owner's check; KS-2, KS-3 and the equivalence two derivations blind to each other; the `k²` form, the `E`-form and the reduction R one mind]** Mechanism: at a split place a unit vector is integral at one of the two conjugate primes (`ι_w̄(u) = ι_w(u)⁻¹`), so `(ψ_w, ψ_w̄)` maps `U` into the cross `(T × 0) ∪ (0 × T)` and `Cay(R, U)` into a co-normal product, `χ(G)²`-colourable [reading, J51V]; at four colours that needs a bipartite plane, so it cannot reach ℚ(√47). The corrected saturation KS-sat_E is equivalent to the density of `Φ(N)` for off-`E` families on neighbourhoods of 1 in `U`, stopped at one named step (uncontrolled poles against the discreteness of `U_{Σ′}`: cut-and-project sums). The plan's controls KS-4, KS-5 could not fail (their window reads one coordinate). **Not claimed:** KS-1_E or KS-sat_E; anything at ℚ(√47) beyond the equivalence; the co-normal reading as the only cheap mechanism. **Prior art (`plans/FS100-three-field-lemma.md` §R-close stage 2):** the counterexample not found; its ingredients textbook — the split norm-one torus `y ↦ (y, y⁻¹)` (FS86-Cx-C1; `[BardestaniMallahiKarai2017]` §3.2) and the co-normal product's `χ(G)χ(H)` bound; the reduction not found, likely folklore; the cross is a union of subgroups, which `[LindenstraussWang2012]`'s topological rigidity allows. | `plans/FS100-derivation.md` §1; `plans/FS100-J51D-derivation.md` §2–§3; `plans/FS100-J51V-verification.md` §2.3–§2.6, §3.2; `tools/j51d_or_check.py`, `tools/j51v_cross.py` | FS-100 (crunch 2026-09-26) |

  | 117 | **T-C(A)'s class among real quadratic fields is the conjecture's `L ≥ 5` family, and SP-Cor holds over it. For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and SP-Cor hold with J45's proofs — so MR(F) ⟹ `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)** (FS-100; FS100-T1, K0). **[hand + tools exact, one mind (J51), re-derived by J51V (not blind) and J53 (Legendre symbols); K0 hand, one mind (J51V) + a one-step check (J53); both on R88-TCA's class form, one mind outside ℚ(√47)]** The inputs: the dyadic place split iff `d ≡ 7 (mod 8)`; 3 and 7 not stable; FS-66 at 11 and 19; Lemma P at a ramified place; the Hoffman table (31's `1/4 − 2.745·10⁻⁶` the largest) and Weil above. A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which the class form supplies. ℚ(√167) is in the class; ℚ(√59) and ℚ(√11) are not. **Not claimed:** MR anywhere; the class among fields of higher degree. **Prior art:** the congruence family is G61's (`[Fischer1990]` Thm 10); its identification with T-C(A)'s class not found (J53's gate). | `plans/FS100-derivation.md` §2; `plans/FS100-three-field-lemma.md` §1.4, §R-close 1.1; `plans/FS100-J51V-verification.md` §2.7; `tools/j51_tca_class.py`, `tools/j51v_class.py` | FS-100 (crunch 2026-09-26) |

  | 118 | **Rank one of Kronecker selection, and why Einsiedler–Lindenstrauss's classification does not apply. Over every real number field one character carries the selection (given row 98, a proper window forces a band character, hence `θ ∈ T + A`), and `θ ∈ E ∖ (T + A)` has `cl θ(U) = T`; at `F = ℚ` every `θ ∉ T + A` has `cl θ(U) = T`. No finitely generated `Γ ⊂ U_F` acts irreducibly on the solenoid `R̂` (`R = O′` inverts infinitely many primes, `ℤ[Γ]` finitely many), so EL2021 Thm 1.2 never applies** (FS-100; FS100-N1, T4, T5, T2). **[hand; one mind each — J51V, J51D, J51D, J51]** For general `F` off `E` the rank-one density is a GAP at the field form of FS89's PA-B2 and JC over `R_{F,S}` (row 98's gluing does not transfer). The card's answer [reading, one mind]: EL2021 Thm 1.3 is the in-print positive-entropy statement that can apply, and MR is its zero-entropy half plus an owed lemma PE-lim (from finitely generated `Γ` to `U`); nothing known forces positive entropy from the four-colouring constraint. **Not claimed:** PE-lim; MR; the rank-one density off `E` in general. **Prior art:** the nearest is the topological-rigidity line (`[Furstenberg1967]`, `[Berend1983]`, `[Wang2012]`, `[LindenstraussWang2012]`), whose hypotheses fail here (FS100-T2); T4 and T5 compose held lemmas. | `plans/FS100-derivation.md` FS100-N1, T4, T5, T2; `plans/FS100-three-field-lemma.md` §PA.3 | FS-100 (crunch 2026-09-26) |

- **row 98 — Not claimed (J51V-X2 (c))** — replace
  > one prime (rows 97, 102); anything kernel-checked.

  with
  > one prime (rows 97, 102); anything kernel-checked; any vector form — `0 ∉ cl Θ(U)` forces no non-zero `m·Θ` into `T + A` (false, row 116).

- **the claim list — Ours** — replace
  > Theorem C over the real S2 fields and its ℚ(√47) form (rows 111–113);

  with
  > Theorem C over the real S2 fields and its ℚ(√47) form (rows 111–113); Kronecker selection refuted as stated, its reduction and its corrected form's reduction to one density step (row 116); T-C(A)'s class among real quadratic fields and SP-Cor over it (row 117); rank one of the selection and the non-irreducibility of the unit-vector group on its solenoid (row 118);


#### 5.2 `LEDGER.md` § B lines (15; checked in stage 3 and again in stage 4 — `data/fs100/j53/check-b-stage4.out`, PASS, exit 0)

Append to § B, under the milestone heads' order (the file `data/fs100/j53/ledger-b-draft.md` holds the same lines):

| FS100-L0 | row 116 | `T + A` and `E` pure in `R̂`: `K̂′` a direct summand, `Θ = (Φ, B)` after a unimodular change, `K/K₀ ≅ cl Φ(R)`; properness at `Θ(U)` extends to its closure | hand, two derivations (blind) | `plans/FS100-derivation.md` FS100-L0 | declined |
| FS100-KS2 | row 116 | KS-2, arithmetic-free: `C + H = C` in a compact abelian `K` ⟹ a measurable proper 4-colouring of `Cay(K, C)` selects to `Cay(K/H, C/H)`; so KS-sat ⟹ Kronecker selection | hand, two derivations (blind) | `plans/FS100-derivation.md` FS100-KS2 | declined |
| FS100-CP | row 116 | the conjugate-pair dichotomy: at a split place `w w̄`, `ψ_w(u) = 0` or `ψ_w̄(u) = 0` for every unit vector; no non-zero `m₁ψ_w + m₂ψ_w̄` in `T + A` (every real field) | hand; (a) two derivations + tools exact (textbook); (b) one mind in general | `plans/FS100-derivation.md` FS100-CP | declined |
| FS100-X1 | row 116 | KS-1 (Kronecker selection onto `T + A`) is FALSE: over ℚ, `Θ = (τ + ψ_w, τ + ψ_w̄)` at 5 with `W = 2⌊2t₁⌋ + ⌊2t₂⌋`; every field with `χ(F²) = 2`; no naive vector band rigidity | hand + tools exact, two derivations (J51V blind; J51D's construction before disclosure) | `plans/FS100-derivation.md` FS100-X1 | declined |
| FS100-X2B | row 116 | the `k²`-colour analogue of KS-1 fails over every real number field (band character plus a split pair: a co-normal product); unavailable at four colours over ℚ(√47) | hand, one mind (J51V) | `plans/FS100-derivation.md` FS100-X2B | declined |
| FS100-KS3 | row 116 | KS-3 (saturation onto `T + A`) FALSE over every real field (`(ψ_w, ψ_w̄)`: a union of two subgroups); non-vacuous over ℚ(√11), where KS-1 holds, so KS-sat is not necessary | hand + tools exact, two derivations (blind); non-necessity one mind | `plans/FS100-derivation.md` FS100-KS3 | declined |
| FS100-EQ | row 116 | KS-C: where T-C(A) holds, KS-1 ⟺ KS-1_E ⟺ X (no Kronecker four-colouring); X proved for `Θ ∈ Eⁿ` and `n = 1`, open for `n ≥ 2` off `E` | hand, two derivations (blind); the `E`-form one mind | `plans/FS100-derivation.md` FS100-EQ | declined |
| FS100-C45 | row 116 | the controls KS-4, KS-5 over ℚ(√11) hold and cannot fail (`W` factors through `π`): uninformative, a G21 control of the wrong shape | hand + tools exact, two derivations (blind) | `plans/FS100-derivation.md` FS100-C45 | declined |
| FS100-R | row 116 | KS-sat_E ⟺ density of `Φ(N)` for off-`E` families on neighbourhoods of 1 in `U`; stopped at "uncontrolled poles vs `U_Σ′` discrete" (cut-and-project sums) | hand, one mind (J51D) | `plans/FS100-derivation.md` FS100-R | declined |
| FS100-T1 | row 117 | real quadratic ℚ(√d) is in T-C(A)'s class (every stable place below 1/4 at all levels) ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L ≥ 5` | hand + tools exact, one mind + two checks | `plans/FS100-derivation.md` FS100-T1 | declined |
| FS100-K0 | row 117 | J45's SP-Cor and A⁺@∅ hold wherever T-C(A)@∅ holds; so MR ⟹ five colours at ℚ(√143), ℚ(√311), ℚ(√335) | hand, one mind + one-step check; on R88-TCA's class form | `plans/FS100-derivation.md` FS100-K0 | declined |
| FS100-N1 | row 118 | Kronecker selection at `n = 1` holds over every real field given row 98 (a proper `W` forces a band character) | hand, one mind (J51V) | `plans/FS100-derivation.md` FS100-N1 | declined |
| FS100-T4 | row 118 | `θ ∈ E ∖ (T + A)` ⟹ `cl θ(U) = T`, every real field (weak approximation) | hand, one mind (J51D) | `plans/FS100-derivation.md` FS100-T4 | declined |
| FS100-T5 | row 118 | at `F = ℚ`, `θ ∉ T + A` ⟹ `cl θ(U) = T` (PA-B2, VB1, the sweep at an arc); GAP for general `F` off `E` | hand, one mind (J51D) | `plans/FS100-derivation.md` FS100-T5 | declined |
| FS100-T2 | row 118 | no finitely generated `Γ ⊂ U_F` acts irreducibly on the solenoid `R̂` (`R/ℤ[Γ]` infinite), so EL's Thm 1.2 never applies | hand, one mind (J51) | `plans/FS100-derivation.md` FS100-T2 | declined |

After they land, `python3 tools/fs71_ledger_b_check.py --strict` should read PASS; until then it reads FAIL (15), exactly the fifteen `FS100-` ids
(`data/fs100/j53/repo-check-stage4.out`).

#### 5.3 `BIBLIOGRAPHY.md` (update two rows and two listings; add three)

- **`[EinsiedlerLindenstrauss2022]`** (update, do not add): role column, append "; FS-100: its Thm 1.2 (EL2003's Thm 1.1) never applies to a
  finitely generated subgroup of the unit-vector group on `R̂` (row 118), its Thm 1.3 is the in-print positive-entropy statement that can
  [reading, one mind; J51 §PA.3]"; read column, append "; re-read at §1 by J51, 2026-09-26, from a re-fetched copy (byte-identical, md5
  `1a32060a…`, removed from the repository at `0c61c274`); §§2–9 unread — FS-100's next slot". Its library-index row is unchanged.
- **`[Wang2012]`** (update): role column, append "; FS-100: the nearest in print to KS-sat_E's density step (row 116); its hypotheses fail for
  the unit-vector group (row 118)"; read column unchanged, with "(J51 read only its zbMATH summary on 2026-09-26, not knowing it held)".
- **The Einsiedler–Lindenstrauss listing row** ("which paper is the nearest was not settled"): append "**FS-100 (2026-09-26):** for MR's
  positive-entropy half the nearest is EL2021 Thm 1.3 (`[EinsiedlerLindenstrauss2022]`, §1 read); its Thm 1.2 never applies (row 118)."
- **`[Rudolph1990]` / `[JohnsonA1992]` / `[Host1995]`**: "**Listings only** (J28 §PA.4)" → "**zbMATH reviews only** (J51, 2026-09-26: Zbl
  0709.28013, 0790.28012, 0839.11030): Rudolph's theorem as EL2021 Thm 1.1 quotes it; Johnson's Theorem A, an invariant measure is Lebesgue or
  of entropy zero (*Measures on the circle invariant under multiplication by a nonlacunary subsemigroup of the integers*, Israel J. Math. 77
  (1992)); Host's a normality criterion (*Nombres normaux, entropie, translations*, Israel J. Math. (1995))". Johnson's initials stay unchecked.
- **New `[EinsiedlerLindenstrauss2003]`** — M. Einsiedler, E. Lindenstrauss, *Rigidity properties of ℤ^d-actions on tori and solenoids*,
  Electron. Res. Announc. Amer. Math. Soc. 9 (2003) 99–110, Zbl 1068.37002 | **author's summary only** (J51; the AMS PDF returned a bot-check
  page twice) — EL2021 says its Thm 1.1 is EL2021's Thm 1.2 | not held.
- **New `[LindenstraussWang2012]`** — E. Lindenstrauss, Z. Wang, *Topological self-joinings of Cartan actions by toral automorphisms*, Duke Math.
  J. 161 (2012), Zbl 1258.37031 (pages unchecked) | **zbMATH review read in full** (J53, 2026-09-26): closed invariant sets of products are
  unions of translates of closed subgroups, strong for `r ≥ 3`, not for `r = 2` — KS-3's cross is such a union (row 116) | not held; FS-100's
  next slot reads it.
- **New `[BekkaFrancini2022]`** — B. Bekka, C. Francini, *Characters of algebraic groups over number fields*, Groups Geom. Dyn. (2022), Zbl
  1518.22005 | **title and the review's first lines only** (J51): positive-type functions on `G(K)` via solenoid rigidity; by Bochner a
  `U`-invariant measure on `R̂` is a `U`-invariant positive-definite function on `R`, so possibly the nearest in print to MR | not held; a
  prior-art debt of FS-100's next slot.

#### 5.4 `plans/FRONTIER-STUBS.md` (drafts; no rank moves)

- **FS-100's row (rank 3):** as the `CLAUDE.md` Paths-forward draft above; its banner line "stage 4 run in-ban: Kronecker selection FALSE as
  stated, re-aimed as 4′ (KS-sat_E at ℚ(√47)), which leads the next slot; stage 6 the fallback; P1 leads post-ban". **Solver column:** stages 4′,
  5, 6 in-ban (derivation, reading); P1 post-ban.
- **FS-64's row (rank 12):** as the `CLAUDE.md` draft above.
- **FS-84's provisional-bearings line** (its stub is outside this brief): "FS-100 (rows 116–117): ℚ(√143), ℚ(√311), ℚ(√335) are in T-C(A)'s class
  and SP-Cor holds there, so FS-84's five-clause route is shared with them; Kronecker selection onto `T + A` is false as stated, and at ℚ(√47) its
  `E`-form is the pure-point layer of the five-clause (FS-100's stage 4′)."
- **FS-92's provisional-bearings line** (outside this brief): "FS-100 (row 116; FS100-X1 (c)): no naive vector form of band rigidity —
  `0 ∉ cl Θ(U)` forces no non-zero `m·Θ` into `T + A`; any classification of character vectors must allow the split-place cross."
- **The visualization's facts** (inventory row 11; `visualizations/` is outside this brief): tag ℚ(√143), ℚ(√311), ℚ(√335) with row 117
  (FS100-T1) at the local–global map's next build.

#### 5.5 Stubs written as files; mints and declines

- **`plans/STUB-measure-rigidity-three-fields.md` (FS-100), re-aimed:** the status block rewritten to the in-ban close with the owner's two rulings
  verbatim; §2.3's "Kronecker selection" cell (J51V §3.4 item 1); §3's selection, with the factor reading (inventory row 12), the counterexample,
  the "not in the gap" qualifier (row 63), the corrected statement KS-1_E / KS-sat_E and the union-of-subgroups design note; §3's "recalled, not
  read" answered; §5 item 5 (J51-T1, K0); §6's order and table (stage 4 RUN, stage 4′ leads, stage 6 the fallback); §6.3's "none held" corrected
  (G50, ruling 3), stage 4's qualifier, **PE-lim as stage 5's derivation**; §6.4 **P1 leads post-ban**; new **§6.5, the next slot**; §7's
  failure clause scored and its "(not checked)" answered; §4's X-R1 killing test, P-EL and an unregistered X-KS′; §10's bearings from this close.
- **`plans/STUB-adelic-window-colouring.md` (FS-64), re-aimed:** a head block — Kronecker windows at four colours, the selection's failure over
  bipartite planes, and the corrected ask (KS-1_E with T-C(A) at every finite `S` closes four-colour Kronecker windows over every field in
  T-C(A)'s class, inventory row 19), with the five-colour remark [derived, J53b].
- **No new stub (four parts).** *Choice:* mint none. *Alternative:* a stub for PE-lim (inventory row 18), or one for KS-sat_E. *Why:* PE-lim is
  FS-100's stage 5 and KS-sat_E its stage 4′ — both questions the FS-100 stub holds, with §6.5 their order; a separate stub would split one
  milestone's next slot across two files. *Confidence:* high — it changes only if PE-lim is wanted outside FS-100 (for row 88's type (B) via
  T-J38-2, it is the same MR).

#### 5.6 Inventory ticks (this stage)

Rows 10, 11, 12, 18, 19, 42, 43, 44, 60, 65, 66 ticked; every row of `plans/FS100-close-inventory.md` is now "done" or "declined, with the reason".
Row 44's three parts: KS-5's wording is in FS100-C45 (stage 3); K0's A⁺ scope is in FS100-K0 and the stub; the brief input list's two slips
(SP-oi not in J45 §5.4; row 105 does not state `R = O′`, Lemma C′ does) are recorded here and need no file edit.

**Theorems this stage proved:** one remark, [derived, J53b] — the co-normal mechanism cannot give five colours over any field in T-C(A)'s class
among real quadratic fields (`k² ≤ 5` needs a two-colourable factor; those fields need four, row 82) — recorded in the FS-64 stub, not filed
(a two-line corollary of FS100-X2B).

**Would have searched here (stage 5):** none.

---

## §R-close (stage 5, the ×2×3 crunch) — the close (WORKFLOW step 9, the mathematics half; crunch job X09C, the close planner)

*de Bruijn (Opus 5.5), 2026-09-26, from 11:07 UTC. Brief `data/crunch-2026-09-26-x2x3/briefs/X09C-close-math.md` with its standing rules and the
owner's launch notes (06:07). Worked from `plans/FS100-x2x3-close-inventory.md` and the six records `plans/FS100-X01D-derivation.md`,
`plans/FS100-X01V-verification.md`, `plans/FS100-X02D-derivation.md`, `plans/FS100-X02V-verification.md`, `plans/FS100-X03D-derivation.md`,
`plans/FS100-X05V-verification.md`, with the queue `plans/CRUNCH-2026-09-26-x2x3-queue.md` and the advisor's record
`plans/POROS-2026-09-26-x2x3-crunch.md`. Late jobs X12B (a blind second derivation of EF_F⁺) and X13R (a non-blind reading of ED-2 and X03D-Z) are
folded in stage 4b if they report before the stop rule. No subagents; no search.*

### Stage 1 — SAVED (quotation check; reconciliation; the ladder audited link by link; the headline ruling)

**1.0 Quotation check (standing rule 5).** Checked against their sources: EF_F⁺ (X01D §3.0, verbatim below); inventory item 8 ("The headline
cap [P-5]: "`χ(ℚ(√47)²) = 5`" may be claimed only if X01 and X02 land **and** X05V's blind check of SP-Cor passes. Otherwise the claim is "MR(F)
given PE-2 and EF_F"."); queue §5 item 2 ("MR(F) lands: EF_F and PE-2 both TRUE, each by two minds, with no GAP"); the claim lists of queue §2
(copied verbatim by every record, each record's own quotation check logged there); SP-Cor's inputs as X05V §1.2 quotes them from J45 §5.4. The
brief's "EF_F and PE-2 are each TRUE by two minds" paraphrases item 8's "X01 and X02 land"; the gloss is the one queue §5 item 2 registers, so
it is used. The owner's grade line (launch note 3) cites "χ ≤ 5 held (row 84)": row 84 holds the lower-side calibration; the upper half's home
is **row 52** (the finite-plane bound at 11: `47 ≡ 3 ≡ 5² (mod 11)`, so 11 is usable of residue degree one, and `χ(Γ₁₁) = 5`), which
`CLAUDE.md` item 10 cites as "a proven 4 ≤ χ ≤ 5". Logged as a correction of address, not of substance.

> EF_F⁺ (X01D §3.0, verbatim): "For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` on `R̂` such that
> `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`. (No ergodicity; one element; the conclusion `T + A ⊆ E`.)"

**1.1 Reconciliation, per claim** (D = derivation, V = verifier; "blind" = fenced from each other's records by brief).

| claim | D's verdict | V's verdict | blind? | divergence and ruling |
|---|---|---|---|---|
| EF-G | X01D: (a) FALSE at ℚ(∛2), TRUE for totally real `F`; (b) TRUE | X01V: (a) FALSE at ℚ(∛2) (another `u`), TRUE totally real; (b) TRUE totally real, `#U_N = ∞` otherwise | yes | none of truth; two counterexamples. (b) is TRUE everywhere (an infinite `#U_N` makes the liminf `+∞`); X01V's "degenerate" is wording. Owner ruling (inventory 16): "totally real" where meant |
| EF_F | X01D: TRUE via EF_F⁺ [one mind] | X01V stage 2 (blind): GAP at EF Lemma 3.2 (UZ); stage 4 (after reading X01D §3): VALID, GAP and X01V-T7 withdrawn | stage 2 yes, stage 4 no | **resolved, no difference of truth**: X01V's stage-2 premise (the multiplier images small at every place) is EF's Euclidean requirement, not the adelic one; the product formula needs only the product small (X01V §4.2 item 1). The close re-read X01D §3.1–3.8 step by step and found no failing line (1.3 below). Grade: 1.4 |
| EF-MR | X01D: TRUE as an implication; "= 5" needs `χ ≤ 5` (unlisted) | X01V: TRUE as a conditional; the same unlisted input | yes | none; both name the upper bound |
| EF-X | TRUE (archimedean circle) | TRUE (X01V-T4) | yes | none |
| HX-1 | X02D: TRUE, elementary (no `R = O′`) | X02V: TRUE (ideals of finite index, FI); X01V's held two-line proof (not passed on, inventory 18) is X02V's | yes | none; three proofs of one line |
| PE-1 | X02D: FALSE at ℚ(√47) (`Γ = ⟨v, u′⟩`, index-2 subgroup in ℚ(√−47)); PE-1′ TRUE for admissible `Γ` | X02V: FALSE at ℚ(√5) (index-2 subgroup in ℚ(i)), and Thm 1.2's **conclusion** fails there too; TRUE with (★) | yes | none; two counterexamples; admissibility = (★) word for word ("`ℚ(Γ′) = L` for every finite-index `Γ′`"); Lemma W is one construction found twice (`w = z/c(z)`, `(z) = 𝔓ʰ` at a totally split prime) |
| PE-2 | X02D: TRUE given EL2021 Thm 1.2, via Lemma Γ (Γ-ergodic decomposition on `R̂`, permuted by `U`) and a second route (on `M̂_k`, consistency) | X02V: TRUE given EL2021 Thm 1.2, via `U`-ergodic reduction, `Γ`-ergodic decomposition on each `M̂_j`, uniqueness by Lemma H, consistency up the inverse system | yes | none; **two derivations blind to each other**, different routes, both applying Thm 1.2 only under (★) (checked: X02D §3.1 step 2 "By PE-1′ and E1"; X02V §2.3 step 2 "By PE-1′") |
| CE-1 | X02D: TRUE only vacuously — its hypothesis (H) is FALSE for every real `F` (a rotation circle at a complex place over a real embedding) | X02V: TRUE, and stronger (`T` for `E`) | yes | **no difference in the implication; ruled for X02D on the hypothesis.** X02V's own strengthened conclusion ("every `U`-invariant `τ` with `τ(T) = 0` is a multiple of `m`") is refuted outright by EF-X's circle measure (atomless, `U`-invariant, carried by `A`, not Haar), so (HF) is false — X02D §4.2 reaches the same consistency check. **Correction owed:** X02V §3.2's "MR(F) … is no harder than that classical open question" is withdrawn: (HF) is not an open question but false, because of the isometric directions |
| FR-1 | X03D: TRUE | X02V: TRUE | yes | none |
| ED-1 | X03D: TRUE when `U_N` is finite (all totally real `F`); ill-posed with a complex place | X02V: TRUE totally real; ill-posed otherwise | yes | none |
| ED-2 | X03D: FALSE, explicit `χ_{P′}` (sparse split primes), limit `∏(1 − 1/p) ≠ 0` [one mind, on one classical input] | none (X13R, a non-blind reading, launched 06:0x) | — | open to X13R; graded one mind here |
| FL-1 | X03D: GAP (needs `σ̂_E(1) ≥ −(σ_E(R̂)+a)/3`; the spectral route needs `Λ ≤ 1/3`, and `Λ = 0.402759` at the real place over every real field) | X05V: GAP at clause (iii), missing QTCA_{1/3}; `J₀` below `−0.4027 < −1/3` | yes | none; one step, two wordings (X03D-FL-H ≡ X05V-5/6) |
| FL-2 | X03D: GAP at the same step (FL-1 ⟹ FL-2 TRUE) | X05V: GAP at the same step | yes | none |
| SP-Cor | (J45's; not re-derived by a D this crunch) | X05V: TRUE, blind re-derivation P0–P8 from lemma statements | yes (fenced from X03D) | none; now three minds (J45; J46-13 from its statement; X05V blind) |
| KC | X01D §4.2: passes, breaks at T-C(A) at K and ℚ(√11) | X05V: TRUE, with the MR step exercised at `a = 2/21` on J45's F2 | yes | none; one wording fix (KC's "`T + Fin_S` plus Haar" → "`T + A`, or `T` plus Haar for the noisy ones"; X05V §2.2) |

**Divergences open after reconciliation: none of truth.** ED-2 has one mind (X13R pending). Everything else agrees in truth; the differences are
routes, counterexamples and wording, listed above.

**1.2 The ladder to `χ(ℚ(√47)²) = 5`, link by link** (the owner's launch note 3; audited, not adopted).

| link | statement | inputs it uses (named, none unlisted) | grade |
|---|---|---|---|
| L1 PE-2 | every `U`-invariant finite `τ` is `a·m + τ′`, `τ′` of zero entropy for every `u` | EL2021 Thm 1.2 by statement, applied only on `(M̂, Γ)` with `Γ` admissible (★); Lemma W (Chebotarev, class number); Lemma TI (Krull dimension one); ergodic decomposition, Jacobs, entropy of increasing factors, Fourier uniqueness (textbook). **No `R = O′`** (X02D-HX1) | [hand; two derivations blind to each other (X02D, X02V); E1 external, in print — EL2021 §§2–9, where its proof lives, unread] |
| L2 EF_F⁺ | quoted in 1.0 | the adelic duality `R̂ ≅ W/R^∨` (Tate/Weil; X02V §2.4 Step B re-derives the same duality independently), **`R = O′`** (row 100's Lemma C′: unconditional except possibly at a ramified stable dyadic place — **none at ℚ(√47)**, whose dyadic place is split, `47 ≡ 7 (mod 8)`); Kronecker, the product formula, the class number; SMB + Jacobs + Egorov; Lehmer's count of Pythagorean triples for `#V_M`; Lusin–Souslin | [hand; one derivation (X01D) + non-blind line-by-line readings (X01V stage 4; the advisor, whose sketch it writes out; the close, 1.3)]; X12B pending |
| L3 MR(F) | `PE-2 ∧ EF_F⁺ ⟹ MR(F)`: `τ = a·m + τ′`, `τ′ ≤ τ` carried by `T + A ⊆ E`, `τ(E) = 0`, so `τ′ = 0` | the non-torsion `(3+4i)/5 ∈ U_ℚ ⊆ U_F`. **MR does not need R-U** (Step 7 of EF_F⁺ re-derives R-U's mechanism internally), nor `m(E) = 0` | [hand; composition, two minds (X01D §4.1; X01V §2.4 and §4.3)] |
| L4 SP-Cor | MR(ℚ(√47)) ⟹ `χ(ℚ(√47)²) ≥ 5` | P1 an `R ⋊ U`-invariant `μ` (amenability); N1, N2, **R-U** (P4), A⁺ at `S = ∅` (from SI-1, SI-3, SI-4, N2), T-C(A) at `S = ∅` | [hand; three minds: J45; J46-13 (from its statement); X05V blind]. Its inputs: **N1/N2 two blind minds** (J45; J46-1), **R-U two blind minds** (J45; J46-7), **A⁺ two blind minds** (J45; J46-5; re-derived a third time by X05V-2) |
| L5 T-C(A) at `S = ∅` | R88-TCA at ℚ(√47) | row 112's inputs: FS-66's certificates at 11 and 19, `[AmbrusEtAl2023]`'s `m₁(ℝ²) ≤ 0.246989` (re-checked), the Hoffman table, Lemma P at the ramified 47, C14.2 (c) at `q = 2` for the split dyadic place (three derivations) | [hand; two derivations blind to each other (J28D, J28V); row 113] |
| L6 `χ ≤ 5` | the plane at 11 | row 52's finite-plane bound (Theorem A's valuation-subring form in the kernel, row 57; the field-level step hand and in print, `[Madore2015]` Prop. 3.2, Cor. 3.4, `[Moorhouse2010]` §8.2) and `χ(Γ₁₁) = 5` (`[Moorhouse2010]` Table 6.1) | [hand + kernel over rings; prior art] |

**No link breaks.** The two things the owner's grade line left out: (i) L2 uses `R = O′`, which holds at ℚ(√47) (and at ℚ(√143), ℚ(√311),
ℚ(√335), ℚ(√167): all `≡ 7 (mod 8)`, dyadic place split) but is open at row 100's exception fields (ℚ(√5), ℚ(√17), ℚ(α)), so **EF_F⁺ and MR(F)
"for every real number field" carry that exception** — X02D-LT names the same gap for its lemma; (ii) the inputs X05V called one-mind (R-U,
N2) are two blind minds (J45 and J46), so inventory item 23's worry is discharged. The weakest link is L2, alone.

**1.3 The close's own reading of L2** (not blind; recorded because the ruling below leans on it). X01D §3.1–3.8, re-derived line by line:
Lemma PF (product formula, `C_Λ` at the finitely many stable places where `Λ = R^∨` is not integral); Step 0 (an expanding place `v*`, split or
archimedean, by Kronecker); Lemma 3.1′ (the correction `y′ ∈ Λ` has product `< 1/C_Λ` by the choice of `ε`, so `y′ = 0`; Bowen atoms are
`s^{−(n−1)}`-thin at `v*`; SMB's non-ergodic limit is the components' entropy, zero a.e. by Jacobs); Step 3 (`μ(vB) = μ(B)`, `#V_M ≥ c₀M^α`,
`δ^β = M^{−α/2}`, so two images meet; the table's bounds, including `|e|_w ≤ m(w)` at split `w ≠ v*`); Step 4 (`z = ℓ₁e₂ − ℓ₂e₁ ∈ Λ`, bounds
`(16ε)^{[L:ℚ]}`, `M^{3−K}`, `M⁶`, so `z = 0` at `K = 16`); Step 5 (one division, at `v*`, bounded below by Lemma PF for `ℓ_j` of height `≤ M_j²`;
one `t` for all scales); Step 6 (disjoint injective leaves; `L/Λ ≅ ⊕_{stable} L_w/Λ_w`, finite `U`-orbits); Step 7 (shells `A_j` periodic under
`g^k`, summable, so null). **No failing line.** The two places a failure would hide — a pigeonhole pair with `|ℓ|_{v*}` tiny (excluded by Lemma PF)
and fatness at `w ≠ v*` (paid for polynomially) — are both handled. This reading is the fourth by a mind that had the route in front of it.

**1.4 The headline ruling (inventory item 8), in four parts.**
- **The choice.** A checking reading that follows a withdrawn blind GAP **does not count as the second mind** item 8 requires. EF_F⁺ is graded
  **[hand; one derivation (X01D), checked line by line by three readers who had it in front of them (X01V stage 4, the advisor, the close), no
  failing line; blind second derivation pending (X12B)]**. So at 06:15 item 8 is **not met on its letter**, and the strongest claim the
  verdicts support is: **"EF_F⁺ ⟹ MR(F) for every real number field `F` with `R = O′` (PE-2 two minds), and ⟹ `χ(ℚ(√47)²) = 5`"** — the headline
  **conditional on EF_F⁺**, EF_F⁺ at the grade above. **If X12B reports EF_F⁺ TRUE blind, item 8 is met** and the row is drafted unconditional
  (stage 4 drafts both forms).
- **The alternative weighed.** Count the checking reading as the second mind: a referee's line-by-line check that also located its own
  earlier error for a reason the close verified is how ordinary mathematics accepts a proof. It would have bought the unconditional headline
  now, matching the owner's 06:08 announcement.
- **Why this one won.** (a) House precedent: row 117 grades a non-blind re-derivation "one mind (J51), re-derived by J51V (not blind)"; rows
  112–113 reserve "two derivations blind to each other"; FS-89's verifier (G51), which closed from D's lemma *statements*, had less in front of it
  than X01V, which read the proofs. (b) The rule's authors meant blind: queue §5 item 2 says "each by two minds, with no GAP", the advisor wrote at
  its stage 8 "It still waits on a blind confirmation", and X01V's own caveat reads "it deserves a blind second derivation before it enters
  `LEDGER.md` as more than one mind's". (c) G21: the decisive idea (Steps 4–5, the two-scale product formula) has one source, the advisor's
  sketch; every mind since has read it and none has produced it; it is the result everyone in the crunch wanted. (d) The price is about 35 minutes
  (X12B reports by 06:50).
- **Confidence.** High on the grade (the precedent is explicit). On the mathematics, about 0.9 that EF_F⁺ is true. What would change the ruling:
  X12B's report — TRUE blind promotes the headline to unconditional; a GAP or FALSE at a named step demotes it to the conditional form for good.

**What the owner's 06:08 announcement needs** (held for the owner): the announcement stands as "lands, pending one blind confirmation of
EF_F⁺ (X12B, 06:50)"; Kooshi should hear the grade in those words. **The ledger row's grade** (either form): "[hand; PE-2 two derivations blind
to each other, through (★), given EL2021 Thm 1.2 (external); EF_F⁺ one derivation, three checking readings (or, after X12B: two derivations
blind to each other); SP-Cor three minds over two-mind inputs; T-C(A) at `S = ∅` two blind; the upper bound row 52, prior art]".

**Would have searched here (stage 1):** none (reading and checking only).

### Stage 1b — SAVED (X12B and X13R folded; the headline ruling applied)

**X12B** (a blind second derivation of EF_F⁺; `plans/FS100-X12B-derivation.md`, report `data/crunch-2026-09-26-x2x3/reports/X12B.md`): **EF_F⁺
TRUE [hand], blind to X01D.** Its brief's quotation of EF_F⁺ checked here against `plans/FS100-X01D-derivation.md` l. 194–195 (the item X12B
held, the source being fenced for it): **verbatim match**. **Independence, checked:** its fence list was X01D's and X01V's records, the advisor's
record and the X01 reports and briefs; its fence log reports none opened. The close inventory (item 24 names X01D's route in one line) was
**not** on its fence list — a gap in the fence, logged as a slip of the brief — but X12B's route differs from X01D's in exactly the two steps
item 24 names, which is evidence against contamination: (i) **the Diophantine step** — X12B divides at once, `ℓ = λ/(q₁ − q₂)`, bounds
`|q₁ − q₂|_v` below at every place (`q₁ − q₂ = N/(c₁c₂)`, `0 ≠ N ∈ ℤ[i]`) and `ℓ`'s height polynomially, then stabilises `ℓ(X) = ℓ(X²)` by the
product formula on `ℓ − ℓ′`; X01D cross-multiplies (`z = ℓ₁e₂ − ℓ₂e₁`) and divides only at `v*`; (ii) **the other places** — X12B's Lemma Z
pushes `μ` along `L + Z_{P⁺} ≅ T × 𝔸_{S∖P⁺}` to the adelic part and reads `ord_w`, whose push-forward is a finite measure on `ℤ ∪ {∞}` invariant
under `k ↦ k + h` (`u_w = α/ᾱ`, `(α) = w^h`); X01D uses leaves, finite `U`-orbits on `L/Λ` and wandering shells. Common to both: EF Lemmas 3.1–3.2
transferred, `U_ℚ` as multipliers (every `q` a rotation at every archimedean place), one expanding set of places for `u*`, and `R = O′` for the
adelic model — the architecture EF's paper and the brief's named hard point both suggest. **The owner's three targets, checked by the close
(not blind):** step 1 (the Bowen atom is a union of `K_Q`-fibres over a thin box of the finite-dimensional `S`-adic solenoid `X_Q`; the
lattice-vector-is-zero induction is X01D's Lemma 3.1′ (ii) in another coordinate system) — **valid**; step 5 (`1 = ∏_v|δ|_v ≤
C′·X^{3b+2a|P⁺|}·X^{−K|P⁺| log ρ}`, false for `K` large; the order of choices in step 6 fixes `K` before `β` before `X′`) — **valid**; Lemma Z's
`α/ᾱ` (`u_w ū_w = 1`; `ord_w(ᾱ) = 0` because `ᾱ` generates `w̄^h` and `w̄ ≠ w` at a split place; so `ord_w(u_w) = h`) — **valid**. One
presentational thinness, not a gap: step 4's height bound `H′(ℓ) ≤ C(x̃)X^b` is stated per place; over the finitely many places where the
multipliers are non-integral it needs the product formula for `q₁ − q₂` (as X01D's table does), which gives the same polynomial bound.
X12B-E (`μ(E ∖ (T + A)) = 0` for every `U`-invariant finite `μ`) is **a third derivation of R-U** (J45; J46-7 blind), by the valuation argument.

**X13R** (a non-blind reading of X03D §4; `plans/FS100-X13R-check.md`): **X03D-ED2 VALID, X03D-Z VALID** [hand], step by step; the "one classical
input" named exactly (lattice-point counts of Gaussian integers in residue classes, Möbius for primitivity, Hilbert 90, CRT) and checked at
`N = 100,000`; X03D-Z's unwritten measurability line supplied (Lusin–Souslin in the `S`-adic model). Corrections owed (wording) and three
tool-defect items for `tools/x03d_weyl.py` (inventory, stage 4). **ED-2 and X03D-Z: [hand; one derivation (X03D) + a checking reading (X13R, not
blind)].**

**The headline ruling, applied (1.4's promotion clause fires).** EF_F⁺ is now **[hand; two derivations blind to each other (X01D; X12B), plus
X01V's checking reading after its withdrawn blind GAP, the advisor's and the close's readings]**. PE-2 is two derivations blind to each other;
X05V's blind check of SP-Cor passed. **Inventory item 8 is met: `χ(ℚ(√47)²) = 5` may be claimed**, at the grade

> [hand; PE-2 two derivations blind to each other through (★), given EL2021 Thm 1.2 (external, in print; its proof in §§2–9, unread here);
> EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading (X01V); MR a composition, two minds; SP-Cor three minds over
> inputs each held by two blind minds (N1, N2, R-U, A⁺: J45, J46); T-C(A) at `S = ∅` two blind (J28D, J28V); `χ ≤ 5` row 52 at 11, prior art].

The four-part ruling of 1.4 stands as the rule (a checking reading after a withdrawn blind GAP is not a second mind); the headline passes it on
X12B, not on X01V. The owner's 06:08 announcement is **confirmed** by the audit; what it must say to Kooshi is the grade above, not "proved in
the kernel" — X11K's lane is where the kernel starts.

**What the headline answers, found in `CLOSED-QUESTIONS.md` (held for the owner; the file is outside every lane's touch list):**
- **Moorhouse's question by name** (§1.7, `[Moorhouse2010slides]`: *"What about `χ(ℚ(√47)²)`?"*): **5**.
- **Soifer's Open Problem 55.1** (§3, `[Soifer2024]` ch. 55, *"Construct a triangle-free 5-chromatic unit-distance graph"*): the **existence**
  half, **non-constructively** — `√3 ∉ ℚ(√47)`, so its plane has no unit triangles (G57), and de Bruijn–Erdős gives a finite subgraph that is not
  four-colourable; none is exhibited. "Construct" and 55.2 (smallest order) stay open. FS85-dB4 (row 86) then gives a finite triangle-free
  unit-distance graph with a four-colour forced pair, again non-constructively.
- **Exoo–Ismailescu's smallest-subfield question** (§3): a quadratic field needs five, and ℚ(√47) is the first real quadratic one (every
  `ℚ(√d)` with `d < 47` has `L ≤ 4`, and `χ = L` there, row 99).
- **The local–global conjecture's cheapest exposed five-clause** (`CLAUDE.md` § The mission, item (2)): met.
- **The publication rule** (`CLAUDE.md` § Publication, third bullet: "a result that answers a question the literature has independently and
  repeatedly posed"): Moorhouse (2010) and Soifer (2019) posed it independently; whether it fires, and at what standard of evidence (the chain
  is hand-graded, resting on an external theorem, and not yet in the kernel), is **Kooshi's call**. A prior-art gate on the value
  `χ(ℚ(√47)²) = 5` itself is owed before any such claim (G49; the zbMATH author listings of Moorhouse and Soifer, and the Polymath16 threads).

**Would have searched here (stage 1b):** none.

### Stage 2 — SAVED (the derivation file: `plans/FS100-derivation.md` §3, commit ce78623a)

Seventeen entries (FS100-EFP, EFZ, PE1, HX1, PE2, MR, Q47, EFG, EFX, CE1, FR1, ED1, ED2, FLK, SPEC, FLH, and §K's stage-5 line), each with its
statement, grade, proof address, what rests on it, prior art and kernel decision; the §G line "PE-lim … Owed" rewritten to point at FS100-PE2.

### Stage 3 — SAVED (§G re-read; §PA sweep; §IQ, G72, G79; §5 scored; the verdict; the search log counted)

**3.1 §G re-read (queue §3), against what happened.**

| entry | extraction | paid? |
|---|---|---|
| G79 | the flip → FL-1, FL-2 | **paid as a result, not as a route**: the example invariant of an actual colouring's spectrum is now a theorem twice (FS100-FLK), and it located the consumer's exact need (FS100-FLH); it did not produce MR |
| G72 | §IQ: entropy split and the quadrance profile | **paid**: entropy was the deciding invariant, split exactly as §IQ item 3 wrote it (PE-2; EF's pigeonhole against growth). §IQ was written after the recognition, so the credit is shared (3.3) |
| G76 | MR as closed-set rigidity's measure half; the advisor's hyperbolic sketch | **paid**: EF_F⁺ is that half; §3's registered falsifiable item fired (3.4, item 7) |
| G21 | EF-X and KC as controls | **paid three times**: KC exercised MR at `a = 2/21` with a witness at each field; EF-X explained why the conclusion is `T + A`, not finite support; and EF-X refuted CE-1's hypothesis (FS100-CE1). Plants: two could not fire at first (X01V's, X02V's), both caught by their own red runs |
| G49, G50 | grep `BIBLIOGRAPHY.md` first | **paid and missed**: the recognition that decided the crunch came from the advisor's stage-0 zbMATH query; but EL2021 was re-fetched a third time, its path in four briefs was wrong (inventory 13, 21), and EL2021 §2 (adelic solenoids) is still unread where it may hold PE-2 |
| G46 | classical names; Bekka–Francini | paid (the discharge from the statement: our group is a torus, not unipotent-generated) |
| G51 | two minds per claim | **paid, and needed twice**: X01V's blind GAP was its own error, caught only by a non-blind read; the headline's second mind had to be bought after the plan (X12B) |
| G60, G66 | FL-2's bound "of Hoffman type" | **bore more than was extracted — a 3.1 miss**: G60's body already holds "real: `J₀`'s −0.40276", the least local character mean at the real place, below `−1/3`. That number predicts FL-1's GAP before the run; §5 item 8 put FL-1 TRUE at 0.40 without it. X03D re-derived it as `Λ = 0.402759` |
| G57 (grouped silent) | "finite witnesses … say nothing about invariant measures" | **missed**: G57 bears through the consumer — `χ(ℚ(√47)²) = 5` over a field without √3 answers Soifer 55.1's existence half (stage 1b). Neither §G nor §5's bearing line said so; it surfaced at the close |
| row 100 (not listed) | — | **missed**: EF_F⁺'s adelic model needs `R = O′`, open at row 100's exception fields; the scope caveat surfaced only at the close |
| G48, G55, G56, G59, G64 | through the consumer | paid as written (five at ℚ(√47); ≥ 5 at ℚ(√167); nothing on six) |

**Forward propagation of the misses.** G60's entry wants its *Do* line to carry the number ("the real place's `J₀` minimum `−0.40276` is below
`−1/3`: a one-sided spectral bound at `−1/k` for `k ≥ 3` fails at every real field before it is tried"); G57's *Do* line wants "a five over a
field without √3 answers Soifer 55.1's existence half"; both are drafted in stage 4 for the front page.

**3.2 §PA sweep — what the reading taught about the object** (WORKFLOW 9).
1. **`U` is a multiplicative group of polynomial growth** (EF's hypothesis): `#{u : H(u) ≤ M} ≥ c·M^{1/[F:ℚ]}` through `U_ℚ` alone. Infinite rank is a
   resource, not an obstacle: no finitely generated `Γ` has polynomial growth, and no finitely generated `Γ` acts irreducibly on `R̂` (FS100-T2), yet
   together they give rigidity. **Promote to a grokking** (drafted as G80, stage 4).
2. **The zero-entropy measures of the whole group live on the archimedean isometric leaves** (`T + A`, EF-X's circles). The real place is where
   non-Haar invariant measures survive, and it is inside `E`: the "obstruction" G76's reading located at the real place is exactly `E`'s `A`-layer.
3. **Total irreducibility of a finitely generated `Γ` is a subfield condition** (admissibility), and it genuinely fails for natural `Γ` (the Pell unit
   at ℚ(√47)). The object has proper-subfield pieces a finite-rank argument must dodge (Lemma W).
4. **Equidistribution is strictly stronger than rigidity here** (FS100-ED2): sparse split characters keep a non-zero Weyl limit. The Schoenberg
   (radial positive-definite) reading of FR-1 is right, but averaging over `U_N` is not the route.
5. **The hypothesis of the classical ℤ²-solenoid conjecture is false for our pieces** (FS100-CE1): isometric directions carry non-algebraic
   zero-entropy measures, so MR was never reducible to the Katok–Spatzier question; it needed the whole group.

**3.3 §IQ re-read, G72's count, G79's record.**
- The structural form ("what does every invariant probability measure of a multiplicative group of polynomial growth … carry?") **is the question
  the result answers**, and its named invariant (entropy, split into halves) is the one that decided it. But the recognition came first — the
  advisor's zbMATH query in the discipline's words (G49), before §IQ was written — and the proofs extend two known tools (EF's pigeonhole; EL's
  Thm 1.2). **G72's count: thirteenth, "from elsewhere — recognition at the prior-art gate, then two known tools extended"**; the structural form
  produced the consumer statements (FS100-FLH) and the example invariant (FS100-FLK), not the headline. The first milestone whose headline did not
  come through the structural question: **twelve of thirteen**.
- **G79's record:** the headline came from an **example invariant** — entropy and growth, which every `U`-invariant measure carries — not from the
  counterexample invariants the wanted posters set side by side (rows 96, 113, FS-100's §PA.3). The G79 flip on colourings (FL) returned a GAP. So:
  "example invariant of the acting group (entropy against growth); the colouring flip GAP'd at QTCA_{1/3}". The fourth data point, the third
  "example".

**3.4 §5's expectations, scored once each** (P as registered at 05:50).

| # | outcome registered | P | what happened | scored |
|---|---|---|---|---|
| 1 | Furstenberg's ×2×3 proved | < 0.001 | not touched; the project's version sidesteps it because `U` is large | as predicted |
| 2 | MR lands: EF_F and PE-2 TRUE, each by two minds, no GAP | 0.08 | MR lands (FS100-MR); PE-2 two blind minds; EF_F⁺ two blind minds (X01D, X12B); one blind GAP on the way (X01V), withdrawn as its own error | **met** (the "no GAP" clause met only after the withdrawal) — a 0.08 outcome |
| 3 | EF_F TRUE / GAP / FALSE | 0.30 / 0.55 / 0.15 | TRUE | the 0.30 outcome |
| 4 | PE-2 TRUE by both / GAP / FALSE | 0.45 / 0.40 / 0.15 | TRUE by both | the 0.45 outcome |
| 5 | PE-1 FALSE as written, TRUE corrected | 0.30 | exactly so, two counterexamples | met |
| 6 | FR-1 TRUE; ED-1 TRUE; ED-2 GAP (FALSE with a counterexample: 0.15) | 0.95; 0.90; 0.75 | FR-1 TRUE; ED-1 TRUE where posed (ill-posed with a complex place); **ED-2 FALSE with an explicit character** | 2 of 3 as predicted; ED-2 the 0.15 outcome |
| 7 | EF_F gives "carried by `T + A`" (G76's reading, falsifiable) | 0.20 | EF_F⁺'s conclusion is `T + A`, twice | met — the registered falsifier of G76's reading fired (stage 4 drafts G76) |
| 8 | FL-1 TRUE as written (FL-2 with it: 0.8) | 0.40 | GAP at QTCA_{1/3}, two blind minds | not met (G60 predicted it: 3.1) |
| 9 | the headline claimed at the close | 0.05 | claimed (stage 1b), at a hand grade | met — a 0.05 outcome |
| 10 | every job reports by 06:55 | 0.60 | all eight (X01D–X05V, X12B, X13R) by 06:15 | met |

Calibration: the four long-shots that fired (items 2, 3, 6's ED-2, 9) all sit on one mechanism the plan under-weighted: EF's growth hypothesis
matching `U` exactly. The planner's and the advisor's estimates moved in the right direction as the reading deepened (the advisor 45 % → 80 %).

**3.5 The verdict, in four parts.**
- **The choice.** FS-100 stage 5 is **Paid (theorem)**: MR(F) for every real number field with `R = O′`, by Einsiedler–Fish plus Einsiedler–
  Lindenstrauss, and with it **`χ(ℚ(√47)²) = 5`** [hand, the grade of stage 1b], the conjecture's cheapest exposed five-clause met. The flip is
  **not landed** (GAP at QTCA_{1/3}); ED-2 is a no-go (FALSE).
- **The alternative weighed.** "Paid (theorem), headline conditional": hold `= 5` back until the value's own prior-art gate and a kernel port. It
  would have bought a cleaner novelty statement.
- **Why this one won.** Item 8's rule is met as written (two blind minds on each half, SP-Cor checked blind), and the verdict labels score the
  experiment, not the publication (Kooshi: "all novel knowledge is a success"). The novelty gate and the publication decision are held
  separately for Kooshi (stage 1b); they do not change what was proved.
- **Confidence.** High that the chain is sound as graded (every link two minds or more, EL2021 external); medium on "new" (EL2021 §2 unread;
  the value's gate not run). What would change it: EL2021 §2 or a posers' listing holding PE-2 or the value (re-attribution, not retraction);
  a defect found by X11K's kernel port (retraction of the affected link).

**3.6 The "would have searched here" lines, counted.** Across the eleven records of the crunch (the six derivation and verification jobs, X12B,
X13R, the advisor, the planner's queue, this close): **eleven moves** logged — X01D 1 (a PARI hunt over non-totally-real fields), X01V 2, X02D 2,
X02V 2, X03D 2, X05V 2; X12B, X13R, the advisor and this close 0 (X12B's multiplier count and X13R's `U_N` enumeration logged at the ban's edge,
extents fixed first). Each was replaced by a derivation plus one exact check of seconds. The ban cost the crunch nothing that a record names.

### Stage 4 — SAVED (drafts for the front-page lane X10F; the stub re-aims as files; the inventory closed)

*Drafts only: `LEDGER.md`, `CLAUDE.md`, `BIBLIOGRAPHY.md` and `plans/FRONTIER-STUBS.md` are X10F's to write. One home per fact: the numbers live in
rows 120–122; `CLAUDE.md` points.*

**4.1 `LEDGER.md` rows (numbered from 120; row 119 is FS-75's).**

| 120 | **Measure rigidity for the unit-vector group: for every real number field `F` with `R_F = O′` (row 100 — every `F` without a ramified stable dyadic place), every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure (MR(F)). It splits by entropy: every `U`-invariant `τ` is `a·m + τ′` with `τ′` of zero entropy for every `u` (PE-2, through Einsiedler–Lindenstrauss's Thm 1.2 on the finitely generated pieces `M̂`, applied only under admissibility — every finite-index subgroup of `Γ` spans `L`); and one non-torsion `u` of zero entropy puts a `U`-invariant measure on `T + A` (EF_F⁺, Einsiedler–Fish's pigeonhole with the rational unit vectors as multipliers and the product formula as the Diophantine step). PE-1 as first posed is false (ℚ(√47); ℚ(√5)), and CE-1's hypothesis is false (a rotation circle), so MR was never the classical finitely generated question** (FS-100 stage 5, the ×2×3 crunch; `plans/FS100-derivation.md` FS100-EFP, EFZ, PE1, PE2, MR, CE1, EFG, EFX, HX1). **[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021 Thm 1.2 by statement (external, in print; its proof in EL2021 §§2–9, unread here); EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading (X01V, after its blind GAP, withdrawn as its own error); MR a composition, three minds]** Mechanism: `U` has polynomially many elements of bounded height (`U_ℚ` alone gives `c·M^{1/[F:ℚ]}`), which is Einsiedler–Fish's hypothesis and which no finitely generated subgroup has (row 118's FS100-T2: none acts irreducibly either); the zero-entropy measures that survive sit on the archimedean isometric leaves, inside `E` (EF-X's circles). EF-G (a), `h_m(u) = log H(u)` with `H` over finite places, is false off the totally real fields (ℚ(∛2)); `h_m(u) = Σ_v log⁺|u|_v` over all places. HX-1: closed `U`-invariant subgroups of `R̂` are finite or everything. **Not claimed:** MR at row 100's exception fields (ℚ(√5), ℚ(√17), ℚ(α)), where the adelic model needs `R = O′`; anything about finitely generated `Γ` alone. **Prior art:** the zero-entropy method is `[EinsiedlerFish2010]` Lemmas 3.1–3.2 (on 𝕋; Sataev 1975 first, unread); the positive-entropy input `[EinsiedlerLindenstrauss2022]` Thm 1.2 (EL2003 Thm 1.1); the transfer to an `S`-adic solenoid or number field not found (four zbMATH queries; Huang 2017, Huang–Li–Shi–Xu 2023 read at §1: circle and tori only); **EL2021 §2 ("Actions on adelic solenoids") unread and may hold PE-2's inverse-limit step — no novelty claimed for PE-2 until it is read**; PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed. | `plans/FS100-derivation.md` §3; `plans/FS100-X01D-derivation.md` §3–4; `plans/FS100-X12B-derivation.md` §2; `plans/FS100-X02D-derivation.md` §2–4; `plans/FS100-X02V-verification.md` §2; `plans/FS100-X01V-verification.md` §2, §4; `tools/x01d_unit_check.py`, `tools/x01v_entropy_check.py`, `tools/x02d_pe1_counterexample.py`, `tools/x02v_checks.py`, `tools/x12b_multiplier_count.py` | FS-100 stage 5 (crunch 2026-09-26) |

| 121 | **`χ(ℚ(√47)²) = 5`: the local–global conjecture's cheapest exposed five-clause is met. MR at ℚ(√47) (row 120) with J45's SP-Cor and T-C(A) at `S = ∅` gives `≥ 5`; the plane at 11 gives `≤ 5`. The plane over ℚ(√47) has no unit triangles, so by de Bruijn–Erdős a finite triangle-free five-chromatic unit-distance graph exists (none is exhibited). At their grades: `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335) (K0), `χ(ℚ(√167)²) ≥ 5`, and row 88 ⟺ T-B1 at ℚ(√59), ℚ(√83), ℚ(√131)** (FS-100 stage 5; FS100-Q47; `plans/FS100-three-field-lemma.md` §R-close (stage 5) 1.2, 1b). **[hand; the headline rule met (every half two blind minds, SP-Cor checked blind): MR row 120's grade; SP-Cor three minds (J45; J46-13 from its statement; X05V blind) over N1, N2, R-U, A⁺ each two blind minds (J45; J46); T-C(A) at `S = ∅` two blind (row 113); `χ ≤ 5` row 52 at 11, prior art. The consequences: K0 one mind + a check (row 117), R88-TCA's class form one mind outside ℚ(√47); not kernel — X11K's lane has begun]** The ladder has six links (PE-2, EF_F⁺, MR, SP-Cor, T-C(A), the upper bound), none broken; the control holds: at K and ℚ(√11), where four-colourings exist, the chain stops exactly at T-C(A), with the MR step exercised at a Haar mass `2/21` (X05V-3). **Answers** (`CLOSED-QUESTIONS.md` §1.7, §3): `[Moorhouse2010slides]`'s *"What about χ(ℚ(√47)²)?"*; the existence half of `[Soifer2024]` Open Problem 55.1, non-constructively (55.1 asks to construct; 55.2 open); `[ExooIsmailescu2019]`'s smallest-subfield question in part (ℚ(√47) is the first real quadratic field needing five: `d < 47` has `L ≤ 4 = χ`, row 99). **Not claimed:** an explicit graph; `χ(ℚ(√167)²)` beyond `≥ 5`; anything on six. **Prior art:** the value's own gate not yet run (the posers' zbMATH listings, the Polymath16 threads) — owed before any novelty or publication claim. | `plans/FS100-derivation.md` FS100-Q47; `plans/FS100-X05V-verification.md` §2; `plans/FS84-SI-D-derivation.md` §4.2; `plans/FS84-SI-V-verification.md` §2–3; `plans/R88-derivation.md` R88-TCA; `tools/x05v_checks.py` | FS-100 stage 5 (crunch 2026-09-26) |

| 122 | **Where the other routes to MR stop: the one-sided flip needs a quantitative T-C(A); equidistribution is false; the classical ℤ² hypothesis is false. The example invariant of an actual four-colouring (the `E`-null part of its spectrum has unit correlation `−P(c¹(0) = c²(u))/P(c¹(0) ≠ c²(0))` over the `E`-factor, so `τ̂₀ < 0` on `U`) reaches the consumer's `−1/3` only with QTCA_{1/3}, because every `U`-invariant measure on `T + A` obeys the sharp `ρ̂(1) ≥ −Λρ(R̂)` with `Λ ≥ −J₀(j₁,₁) = 0.402759 > 1/3` at the real place of every real field; and over ℚ a character built from a sparse set of split primes (`Σ1/p < ∞`) lies outside `E` with Weyl averages tending to `∏(1 − 1/p) ≠ 0`** (FS-100 stage 5; FS100-FLK, SPEC, FLH, ED1, ED2, FR1). **[hand (+ tools float with controls); FLK, SPEC, the GAP's step and FR-1, ED-1 two blind minds each (X03D; X05V or X02V); ED-2 and X03D-Z one derivation + a checking reading (X13R)]** Consumers: MR, or `H_κ` with QTCA_κ for one `κ > 0`; `H_κ` for every `κ` ⟺ MR (X05V-7/8). FR-1 makes MR a Schoenberg-type statement (radial positive-definite functions of the quadrance); ED-2 shows averaging over `U_N` is strictly stronger than rigidity (the Nazarov phenomenon, `[EinsiedlerFish2010]` §4). **Not claimed:** QTCA; ED-1′'s mean value over ℚ. **Prior art:** Bekka–Francini's character rigidity does not apply (a torus, not unipotent-generated; `[BekkaFrancini2022]` Thm 1.1, Remark 1.2 read); the ED gate (adelic equidistribution of Pythagorean points) not run. | `plans/FS100-derivation.md` FS100-FLK … FS100-ED2; `plans/FS100-X03D-derivation.md` §2–4; `plans/FS100-X05V-verification.md` §3; `plans/FS100-X13R-check.md`; `tools/x03d_factor_minima.py`, `tools/x03d_weyl.py`, `tools/x13r_check.py` | FS-100 stage 5 (crunch 2026-09-26) |

**Row 118's text, corrected in place:** "The card's answer [reading, one mind]: EL2021 Thm 1.3 is the in-print positive-entropy statement that can
apply, and MR is its zero-entropy half plus an owed lemma PE-lim" → "The card's answer [reading, one mind] — MR as its zero-entropy half plus an
owed PE-lim — was right in shape; **both halves are now held (row 120)**: PE-lim through Thm 1.2 on the finitely generated pieces under
admissibility, the zero-entropy half by Einsiedler–Fish". And its "EL2021 Thm 1.2 never applies" gains its scope: "on `R̂` itself; on the pieces
`M̂` it applies exactly under admissibility (row 120)". **Not claimed: PE-lim; MR** → delete (superseded by row 120).

**§ B lines (one per theorem; the `plans/FS100-derivation.md` entry is the address; kernel "declined" unless noted):**

| id | row | statement | grade | address | kernel |
|---|---|---|---|---|---|
| FS100-EFP | row 120 | one zero-entropy non-torsion `u` puts a `U`-invariant finite measure on `T + A` (EF_F⁺), every real `F` with `R = O′` | hand, two blind derivations + a checking reading | `plans/FS100-derivation.md` FS100-EFP | X11K's lane |
| FS100-EFZ | row 120 | `μ(E ∖ (T + A)) = 0` for every `U`-invariant finite `μ` (R-U, a third derivation) | hand, three derivations | FS100-EFZ | declined |
| FS100-PE1 | row 120 | PE-1 false (ℚ(√47), ℚ(√5)); PE-1′ under admissibility; Lemma W | hand + tools exact, two blind | FS100-PE1 | declined |
| FS100-HX1 | row 120 | closed `U`-invariant subgroups of `R̂` are finite or `R̂` | hand, three proofs | FS100-HX1 | declined |
| FS100-PE2 | row 120 | PE-2: `τ = a·m + τ′`, `τ′` of zero entropy for every `u` | hand, two blind, on EL2021 Thm 1.2 | FS100-PE2 | X11K's lane |
| FS100-MR | row 120 | PE-2 ∧ EF_F⁺ ⟹ MR(F); MR ⟺ PE-2 given R-U; given PE-2, MR ⟺ the zero-entropy half | hand, a composition, three minds | FS100-MR | X11K's lane |
| FS100-Q47 | row 121 | `χ(ℚ(√47)²) = 5`; five at the K0 fields, `≥ 5` at ℚ(√167), row 88 ⟺ T-B1, at their grades | hand, the headline rule met | FS100-Q47 | X11K's lane |
| FS100-EFG | row 120 | `h_m(u) = Σ_v log⁺|u|_v`; EF-G (a) false at ℚ(∛2); (b) holds | hand + tools exact, four minds | FS100-EFG | declined |
| FS100-EFX | row 120 | archimedean circle measures: `U`-ergodic, zero entropy, atomless, on `A` | hand, two blind | FS100-EFX | declined |
| FS100-CE1 | row 120 | CE-1 true and void: its hypothesis is false; Lemma LT | hand, two blind (LT one mind) | FS100-CE1 | declined |
| FS100-FR1 | row 122 | `U`-orbits on `R ∖ 0` are the quadrance fibres | hand, two blind | FS100-FR1 | declined |
| FS100-ED1 | row 122 | Weyl averages → 0 off `E` ⟹ MR; ill-posed with a complex place | hand, two blind | FS100-ED1 | declined |
| FS100-ED2 | row 122 | ED-2 false over ℚ (sparse split characters); X03D-Z; ED-1′ | hand, one derivation + a checking reading | FS100-ED2 | declined |
| FS100-FLK | row 122 | the `E`-null part's unit correlation of an actual colouring; `τ̂₀ < 0` on `U` | hand, two blind | FS100-FLK | declined |
| FS100-SPEC | row 122 | `ρ̂(1) ≥ −Λρ(R̂)` on `T + A`, `Λ ≥ 0.402759`, sharp | hand + tools float, two blind | FS100-SPEC | declined |
| FS100-FLH | row 122 | FL-1, FL-2 GAP at QTCA_{1/3}; the consumer statements | hand, the GAP two blind | FS100-FLH | declined |

**4.2 `CLAUDE.md` lines (the front page applies; the rows above are the one home of every number).**
- **Last updated:** lead with "FS-100 stage 5 (the ×2×3 crunch, 2026-09-26): **Paid (theorem)** — MR(F) (row 120) and **`χ(ℚ(√47)²) = 5`** (row 121),
  the conjecture's cheapest exposed five-clause met; the flip not landed and ED-2 false (row 122) (`plans/FS100-three-field-lemma.md` §R-close
  (stage 5))". Keep FS-100's in-ban round and FS-75 after it.
- **§ The mission, the target paragraph (2):** "Its exposed predictions: exactly five at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5), where four
  is proven …, ℚ(√47) the cheapest (row 84, FS-84; no character four-colouring, row 96)" → "exactly five at ℚ(√47) — **met** (row 121) — and at
  ℚ(√143), ℚ(√311), ℚ(√335) (met at K0's grade, row 121) and ℚ(√3,√5) (open, four proven)"; "and at least six at ℚ(√167), proven 4" → "proven 4
  in the kernel (row 119) and ≥ 5 at K0's grade (row 121)". Its remaining testable range at `L = 5` is ℚ(√3,√5) and FS-48's table.
- **§ Publication** (held for Kooshi; the default leaves "It has not fired" standing): a candidate line — "**A candidate:** `χ(ℚ(√47)²) = 5` (row
  121) answers Moorhouse's named question (2010) and the existence half of Soifer's Open Problem 55.1 (2019); hand-graded, resting on an external
  theorem, not yet kernel; whether the rule fires is Kooshi's call, after the value's prior-art gate."
- **Where the problem stands — item 10:** replace "at ℚ(√47) (L = 5: …) it predicts exactly five against a proven 4 ≤ χ ≤ 5 — open (row 84;
  FS-84), and a four-colouring there would carry an invariant measure whose spectrum is carried by no `T + A + Fin_S` (row 113). Among real
  quadratic fields that count's class is exactly `L ≥ 5` … (row 117), so MR would give five at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47) (FS-100)"
  → "at ℚ(√47) (L = 5) **χ = 5** (row 121: measure rigidity for the unit-vector group, row 120, with SP-Cor), and at ℚ(√143), ℚ(√311), ℚ(√335) —
  T-C(A)'s class among real quadratic fields, exactly `L ≥ 5` (row 117) — five at K0's grade".
- **Item 12:** "against a proven four (row 79)" → "against four in the kernel (row 119) and five at K0's grade (row 121)".
- **Item 24:** "the plane is rigid iff `(0, 4)` is forced (row 88) — **undecided**" gains "; with MR held (row 120), row 88 ⟺ T-B1 (FS-98)".
- **Item 27:** "at ℚ(√47) its `E`-form is the five-clause's pure-point layer, open at one density step" → "at ℚ(√47) moot since row 121".
- **New item 29:** "**Measure rigidity for the unit-vector group, and five at ℚ(√47)** (rows 120–122; FS-100 stage 5). Every `U`-invariant `E`-null
  measure on `R̂` is Haar, by entropy: Einsiedler–Lindenstrauss on the finitely generated pieces for positive entropy, Einsiedler–Fish's
  pigeonhole for zero entropy — `U` is large enough for it, no finitely generated subgroup is (G80). With SP-Cor, `χ(ℚ(√47)²) = 5`; the flip
  stops at a quantitative T-C(A) (row 122). Bearing on χ ≥ 6: none; ℚ(√167)'s gap is now [5, 7]."
- **The prior-art position, "Not ours":** add "the zero-entropy pigeonhole for multiplier semigroups of polynomial growth (`[EinsiedlerFish2010]`,
  after Sataev 1975) and the positive-entropy dichotomy for totally irreducible solenoid actions (`[EinsiedlerLindenstrauss2022]` Thm 1.2, EL2003)".
- **Paths forward:** Open milestones — "**One is open: FS-84**" → "FS-84's question is **answered** by FS-100 stage 5 (row 121); its remaining
  stages (S2 onward, from 2026-10-01) re-aim to an explicit triangle-free five-chromatic graph over ℚ(√47) (Soifer 55.1 as posed) or close — held
  for Kooshi". Closed most recently: add FS-100 stage 5 first. Rows: see 4.4.
- **G76:** its reading sentence "for all colourings the obstruction is the real place … survives only for infinite-place spectra and transient
  colourings" → "**Demoted in MR's form** (row 120; §5 item 7's registered falsifier fired): a rotation-invariant colouring's spectrum is Haar plus a
  part on `T + A`, so infinite-place spectra are out; the real place is where non-Haar invariant measures survive, and it lies inside `E`. The
  reading survives only for transient colourings (T-B1, FS-98)." Its Do line gains: "when a group of multipliers has polynomially many elements of
  bounded height, run Einsiedler–Fish's pigeonhole with the product formula before calling a measure question ×2×3-hard".
- **G79's test record:** append "FS-100 stage 5: the headline from an example invariant of the acting group (entropy against growth); the colouring
  flip GAP'd at QTCA_{1/3} (row 122)".
- **G72's count:** "twelve of twelve" → "**twelve of thirteen**", appending "Thirteenth, FS-100 stage 5 — the headline (row 120) from recognition at the
  prior-art gate and two known tools extended, §IQ's named invariant (entropy) right but written after the recognition; the structural form
  produced the consumer statements and the example invariant (row 122)".
- **G49 or G50 instance (G50):** "**FS-100 stage 5's:** the theorem that decided MR (`[EinsiedlerFish2010]`) is stated on 𝕋 for semigroups of ℕ, in
  one-dimensional words; FS-100's gate searched 'solenoid & S-adic', read the zero as support for 'MR is ×2×3-hard', and missed it; the advisor
  found it by one zbMATH query in the discipline's words ('multiplicative semigroup of polynomial growth'). EL2021 was fetched a third time, its path
  wrong in four briefs; its §2 on adelic solenoids is still unread where it may hold PE-2."
- **G60's Do line** gains: "the real place's `J₀` minimum `−0.40276` is below `−1/3`: a one-sided spectral bound at `−1/k`, `k ≥ 3`, fails over
  every real field before it is tried (row 122; missed at FS-100 stage 5's registration)".
- **G57's Do line** gains: "a five over a field without √3 answers Soifer 55.1's existence half (row 121)".
- **G48's proved range:** add "and at ℚ(√47) (row 121; the K0 fields at their grade)".
- **New grokking G80** (drafted, [hand theorem + reading]): "**Infinite rank is the resource: the unit-vector group is large enough for
  rigidity that no finitely generated piece has.** `U_F` has polynomially many elements of bounded height; no finitely generated subgroup does, and
  none acts irreducibly on `R̂` (row 118). The classical ×2×3 question lives at finite rank; `U` sidesteps it (row 120): positive entropy is
  Einsiedler–Lindenstrauss on each finitely generated piece, zero entropy is Einsiedler–Fish's pigeonhole run with the whole group's growth, and
  what survives is the archimedean isometric layer, inside `E`. *Do: when a question over a field's plane reduces to invariant measures under
  `U_F`, count the group's elements by height before calling it ×2×3-hard; transfer a one-dimensional polynomial-growth theorem by running its
  Diophantine step through the product formula at all places. Killing test of the reading that this extends: a real field whose `U`-invariant
  `E`-null measures are not Haar (only row 100's exception fields are uncovered).*"

**4.3 `BIBLIOGRAPHY.md` rows** (reading status per section; the copies to move are item 20's).
- **`[EinsiedlerFish2010]`** M. Einsiedler, A. Fish, *Rigidity of measures invariant under the action of a multiplicative semigroup of polynomial
  growth on 𝕋*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005, arXiv:0804.3586 — row 120 (FS100-EFP: Lemmas 3.1–3.2 transferred) —
  held `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`, **to move to `~/source/library/pdf/`** (inventory 20) — **read in full**
  (the advisor; X01D; X01V §§1–4; X12B).
- **`[Huang2017]`** H. Huang, *Fourier coefficients of ×p-invariant measures*, J. Mod. Dyn. 11 (2017) 551–562, Zbl 1402.37006, arXiv:1606.06078 —
  EF's citing work; names Sataev 1975 — held `data/fs100/x01d/` — read §1, Remark 5.4, references (X01D).
- **`[HuangLiShiXu2023]`** H. Huang, H. Li, E. Shi, H. Xu, *Strongly independent matrices and rigidity of ×A-invariant measures on n-torus*, Front.
  Math. 18 (2023) 153–166, Zbl 1537.37013, arXiv:1908.02611 — EF's citing work; tori, not `S`-adic — held `data/fs100/x01d/` — read §1 (X01D).
- **`[Sataev1975]`** E. A. Sataev, *On measures invariant with respect to polynomial semigroups of circle transformations*, Uspekhi Mat. Nauk 30
  (1975) no. 2, 203–204 — EF's Thm 1.2 first (per Huang) — **not held, unread**.
- **`[Lindenstrauss2004]`** E. Lindenstrauss, *Rigidity of multiparameter actions*, arXiv:math/0402165 — survey context for PE-2 — WebFetch copy,
  not in the library — pp. 1–6 read (X02D).
- **`[EinsiedlerLindenstrauss2022]`** (amend): §1 re-read in full by X02D and pp. 1–3 by X02V (2026-09-26); Thm 1.2 applies on `M̂` under
  admissibility (row 120); **§2 ("Actions on adelic solenoids") unread — a prior-art debt on PE-2**; §§3–9 unread. The advisor's second copy
  (`data/crunch-2026-09-26-x2x3/poros/`, arXiv 2101.11120) is a duplicate of the library copy (inventory 21): remove it.
- **`[BekkaFrancini2022]`** (amend the existing key's status): Thm 1.1 and Remark 1.2 (iii)–(iv) read by X03D; its hypothesis (Levi component
  semisimple, `L⁺ = L`) fails for `R ⋊ U` — PDF at `data/fs100/x03d/`, to move to the library.
- **Lind–Ward 1988** (*Automorphisms of solenoids and p-adic entropy*, ETDS 8) and **Chothi–Everest–Ward 1997** (*S-integer dynamical systems:
  periodic points*, J. reine angew. Math. 489): cited from memory for the entropy formula (FS100-EFG) — **not held, unread; a debt**; the duality
  FS100-EFP uses is textbook (Tate/Weil) and re-derived by X02V and X12B.

**4.4 `plans/FRONTIER-STUBS.md` rows (drafts).**
- **FS-100** — re-aimed (the stub's status block, written here): "MR proved (row 120), `χ(ℚ(√47)²) = 5` (row 121). **Left:** the value's prior-art
  gate and EL2021 §2; MR at row 100's exception fields; X11K's kernel port; stage 4′ moot for ℚ(√47). Bearing on χ ≥ 6: none." Rank: below FS-59.
- **FS-84** — "**answered by FS-100 stage 5** (row 121); S2 onward (post-ban) re-aims to an explicit triangle-free five-chromatic graph over ℚ(√47)
  (Soifer 55.1 as posed), or closes — held for Kooshi". Banner on `plans/STUB-five-colours-47.md` (the front page writes it).
- **FS-59** — "its ≥ 5 waits only on MR" → "≥ 5 at K0's grade (row 121); six waits on J39's T-J39-5 and its two lemmas".
- **FS-98** — "given MR, row 88 ⟺ T-B1" → "row 88 ⟺ T-B1 (MR held, row 120)"; its bearing unchanged.
- **FS-97** — the banner written in its file (answered at FS-100 stage 5).
- **FS-64** — "four-colour Kronecker windows: the `E`-form open over T-C(A)'s class" gains "moot at ℚ(√47) (row 121)".
- **Candidate, held for Kooshi (the owner's note: drafted, not minted): "FS-101? QTCA_κ — a quantitative T-C(A)."** *Question:* does every
  rotation-invariant four-colouring over a field in T-C(A)'s class have `Σ_j E[p_j(0)p_j(u)] ≥ κ(1 − Σ_j E[p_j(0)²])` for some `κ > 0` (X05V's
  form), equivalently `s_E ≤ s* < 0.8276` (X03D-FL-Q)? *Why:* the only route from the flip to a consumer weaker than MR. *Bearing on χ ≥ 6:*
  none; with MR held its value is mechanism only (a second, spectral proof of five). *Recommendation:* do not mint — MR supersedes its purpose;
  keep the text here. Confidence medium.
- **Declined:** X02D's "zero-entropy classification for solenoidal ℤ²-actions with isometric directions" (inventory 68) — moot for MR, which uses
  the whole group; at finite rank it is the classical open question with no consumer here. X03D's "ED-1′ mean value over ℚ" (inventory 95) — ED-2
  shows equidistribution is strictly stronger than rigidity and MR is held; no consumer.

**4.5 The stub re-aims, as files (done in this stage):** `plans/STUB-measure-rigidity-three-fields.md` — a new status block at FS-100 stage 5's
close above the in-ban one, whose last sentence and §1's "reading room at a known wall" paragraph are rewritten to current state;
`plans/STUB-infinite-place-spectra.md` — FS-97's banner records that its questions are answered.

**Would have searched here (stage 4):** none.
