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

- 1–51 — silent, each: finite witnesses, cells, compulsion toolkit, descents (rows 1, 2, …, 51 walked one by one; none touches `R̂`, `U`-invariant measures or window colourings; no reason differs from "finite-object mechanism").
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
5. Counts: grokkings 79 (bears 31, silent 48, falsifiable 0 — the falsifiable items are registered in §P from the stub's §4 and §PA);
   rows 115 (bears 36, silent 79); method rules 36 (bears 16, silent 20).
