# The ×2×3 crunch queue — two hours, six slots (planned 2026-09-26, 10:26–12:26 UTC)

*Planner: de Bruijn (Opus 5.5), from the owner's brief `data/crunch-2026-09-26-x2x3/briefs/PLN-x2x3-planner.md`. Advisor: Poros, whose
record is `plans/POROS-2026-09-26-x2x3-crunch.md`. Items the advisor changed are marked **[P-n]**, and §6 records where I disagreed. The
plan is mine; the choices are Kooshi's, through the owner. The template is `plans/CRUNCH-2026-09-25-queue.md`; its §1 protocol holds
except where §1 below changes it.*

**What two hours can and cannot do (said first).** The classical conjecture (Furstenberg's: every ergodic measure on ℝ/ℤ invariant under
×2 and ×3 is Lebesgue or finitely supported) will not fall here. What the project needs is not the classical conjecture but **MR(F)**:

> "**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure'" — J38 §3.5, T-J38-2 (iii),
> quoted in `plans/STUB-measure-rigidity-three-fields.md` §1.

This is about a group `U` of **infinite** rank. Three routes that a two-hour attack can actually test, each a derivation with a blind
verifier:
- **(A) Einsiedler–Fish [P-1].** Multiplier semigroups of polynomial growth are rigid in print, and `U` is such a group.
- **(B) PE-lim through finitely generated submodules.** Einsiedler–Lindenstrauss's Thm 1.2 does apply on the dual of each finitely
  generated piece of `R`.
- **(C) The Fourier form.** A `U`-invariant measure is a positive-definite function of the quadrance `x x̄`. This gives an averaging
  (equidistribution) route to MR and the flip that G79 asks for: what every actual four-colouring's spectrum carries, and whether the
  consumer needs less than MR.

---

## §1. Protocol deltas (everything else: `plans/CRUNCH-2026-09-25-queue.md` §1)

- **Clock:** opened 05:26; queue and first briefs committed by about 05:55; jobs about an hour; **close-math starts at 06:55 at the latest,
  front page at 07:10**; the crunch ends at about 07:26.
- **Slots: six in all.** Planner and advisor hold two until they hand back (about 06:05). The Sonnet clerk (J00) holds one while it runs.
  **Wave 1** (05:55): the three derivations X01D, X02D, X03D. **Wave 2** (as the planner and advisor hand back): the blind verifiers X01V and
  X02V. Five working jobs plus the clerk after that. The first slot to free goes to X05V (a blind check of SP-Cor and FL-1, FL-2), then to
  the close.
- **Directory:** `data/crunch-2026-09-26-x2x3/`, holding `briefs/` (every brief, plus `STANDING-RULES.md` for this crunch), `reports/`
  (one short report per job) and `READY.md` (the clerk's list of launchable jobs).
- **The clerk (J00, Sonnet):** runs after every second report and once before the close-math job. Its brief is
  `data/crunch-2026-09-26-x2x3/briefs/J00-clerk.md`, the last crunch's with the paths changed.
- **Halts and resumes:** as before (§1.4 there). A resumed job gets the same brief. In the last 30 minutes the owner launches no
  derivation's first stage.
- **`CLAUDE.md` has no byte budget during this crunch** (Kooshi, 2026-09-26: *"CLAUDE.md unbounded temporarily so we don't need to
  compress on the fly"*). The front-page job adds what it needs and compresses nothing; the fact audit (`--base`, `--dupes`) still runs.
- **The milestone:** **FS-100, stage 5 (the MR reading room and PE-lim), run ahead of stage 4′ at Kooshi's request.** The argument is in
  §3. Close inventory: `plans/FS100-x2x3-close-inventory.md`.
- **The close:** X09C (close-math, Opus, from 06:55) writes the derivation file's new entries, §R-close for this stage in
  `plans/FS100-three-field-lemma.md`, the predictions scored and the drafted ledger rows. X10F (front page, Opus, from 07:10) applies them
  to `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` and `BIBLIOGRAPHY.md`, and scores §5.
- **The ban holds** (no finite-witness search until 2026-10-01). Every brief carries the "would have searched here" log. Reading papers is
  in.

---

## §2. The fixed claim lists (verbatim; written before any derivation, 05:45)

**Notation** (from `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`,
`U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones,
`E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added here: `U` acts on
`R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`,
`H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`.

### List X01 — route (A), Einsiedler–Fish (X01D derives, X01V verifies blind)

- **EF-G.** "For every real number field `F`: (a) `h_m(u) = log H(u)` for every `u ∈ U`; (b) `liminf_{N→∞} log #U_N / log N > 0`."
- **EF_F** [Poros's target, P-1]. "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that
  `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`."
- **EF-MR.** "PE-2 (list X02) and EF_F together imply MR(F) for every real number field `F`; over ℚ(√47), with SP-Cor and T-C(A) at `S = ∅`,
  they imply `χ(ℚ(√47)²) = 5`."
- **EF-X** (a control; the conclusion's shape). "Over `F = ℚ` there is a `U`-invariant, `U`-ergodic probability measure on `R̂` with
  `h_μ(u) = 0` for every `u ∈ U` that is not finitely supported; so EF_F's conclusion cannot be strengthened to finite support."

The input to quote from the paper itself (a reading item, not a claim): Einsiedler–Fish, *Rigidity of measures invariant under the action of
a multiplicative semigroup of polynomial growth on 𝕋*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005 — its main theorem,
verbatim, with its hypotheses.

### List X02 — route (B), PE-lim (X02D derives, X02V verifies blind)

- **HX-1.** "For every real number field `F`, every closed `U`-invariant subgroup of `R̂` is finite or all of `R̂`."
- **PE-1.** "Let `F` be a real number field, `Γ ⊂ U` generated by two multiplicatively independent elements with `ℚ(Γ) = L`, and `M ⊂ R` a
  finitely generated `ℤ[Γ]`-submodule with `ℚM = L`. Then `M̂` is a solenoid, and the `Γ`-action on it is by automorphisms, totally
  irreducible, and has no virtually cyclic factor, so EL2021 Thm 1.2 applies to every `Γ`-invariant ergodic probability measure on `M̂`."
- **PE-2** (PE-lim). "For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with
  `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`."
- **CE-1** (conditional MR). "If every ergodic invariant probability measure of a totally irreducible ℤ²-action by automorphisms of a
  solenoid with no virtually cyclic factor is Haar or finitely supported, then MR(F) holds for every real number field `F`."

### List X03 — route (C), the Fourier form, the flip and the consumer (X03D derives; X02V verifies FR-1, ED-1 and FL-1 blind, if its budget allows)

- **FR-1.** "For every real number field `F`, the `U`-orbits on `R ∖ {0}` are exactly the non-empty fibres of `x ↦ x x̄`; so a finite
  positive measure `τ` on `R̂` is `U`-invariant if and only if `τ̂(x) = τ̂(y)` whenever `x x̄ = y ȳ`."
- **ED-1.** "If, for every `χ ∈ R̂ ∖ E`, `lim_{N→∞} (1/#U_N) Σ_{u ∈ U_N} χ(u) = 0`, then MR(F) holds."
- **ED-2.** "Over `F = ℚ`, the hypothesis of ED-1 holds." (TRUE, or FALSE with an explicit `χ ∉ E`, or GAP at a named step.)
- **FL-1** (the example invariant). "Over ℚ(√47), given T-C(A) at `S = ∅` and rows 112–113's inputs: for every translation- and
  rotation-invariant random proper four-colouring of the plane, with the colours embedded as the vertices of a regular tetrahedron centred at
  `0` and `σ` the trace of its spectral measure on `R̂` (`σ(R̂) = 1`), write `σ = a·m + σ_E + τ` with `σ_E` carried by `E` and `τ(E) = 0`
  non-Haar. Then `τ ≠ 0`, and `τ̂(u) = τ̂(1) ≤ −τ(R̂)/3` for every `u ∈ U`."
- **FL-2** (what the consumer needs). "Over ℚ(√47), given T-C(A) at `S = ∅`: if every `U`-invariant, `E`-null finite positive measure `τ` on
  `R̂` satisfies `τ̂(1) > −τ(R̂)/3` whenever `τ ≠ 0`, then `χ(ℚ(√47)²) = 5`."

**On leaning:** every claim above can be FALSE, and a FALSE with its counterexample, or a GAP with the step named, counts in full (standing
rule 4). EF_F and ED-2 are the claims most likely to fail, and the brief of each job names the step where a failure is most likely.

---

## §3. The reframe (WORKFLOW 3), in proportion to two hours

**How it is kept in proportion, not skipped.** One walk, done by the planner with the advisor reading beside it, fresh from disk
(`LEDGER.md` rows 94–118 and every grokking's *Do* line). **Every entry that bears gets its own line. Entries that are silent are grouped by
the one reason they share.** A silent group is a claim the owner can push back on, entry by entry. §PA is the advisor's reading plus J51's
(FS-100 §PA.2), with each job's brief naming the sections it must read. §IQ is written out in full below.

**The milestone: FS-100, stage 5.** MR(F) is FS-100's own lemma, and its stub already names "stage 5 (the reading room proper, then PE-lim
as a derivation)". The owner's ruling at FS-100's close put stage 4′ (`KS-sat_E` at ℚ(√47)) first in the next slot. Kooshi's request for
×2×3 is a request for stage 5's content, so this crunch runs stage 5 ahead of 4′ (close inventory item 1). **Alternative weighed:** a new
stub, "FS-101: MR and ×2×3". It would give the reading a clean home, at the cost of a second home for MR, whose one home is FS-100 (the
header's one-home-per-fact rule). **Confidence:** medium. If EF_F lands and MR becomes a theorem, FS-100 closes and the choice stops
mattering.

### §G — the re-grokking (bears: one line each; silent: grouped)

- **G79** — bears: the rows (96, 113) and FS-100 carry counterexample invariants. The flip asks what every actual four-colouring's spectrum
  carries (σ̂ = −1/3 on `U`, forcing `τ̂(1) < 0`). → X03D's FL-1, FL-2.
- **G72** — bears: the structural form asks about every `U`-invariant measure, in the most general class: polynomial-growth multiplier
  groups on S-adic solenoids. The invariants are entropy and the quadrance profile. → §IQ; X01D, X03D.
- **G76** — bears: closed-set rigidity at two or more primes already holds (rows 95, 98). MR is its measure half. The advisor's sketch uses
  the hyperbolic action at the split places, in the same spirit. → X01D.
- **G21** — bears: a generator proves only its own shapes. EF-X is a control of the conclusion's shape (finite support versus `E`). KC is a
  known-positive control (K, ℚ(√11)). → X01V, X05V.
- **G49, G50** — bear: FS-100 wrote held papers as "none held". EF was missed by FS-100's gate, which searched "solenoid", not "semigroup
  of polynomial growth". Every brief greps `BIBLIOGRAPHY.md` first. → standing rule 11; inventory 2–4.
- **G46** — bears: name the object in the classical theory's words. `U`-invariant measures are quadrance-radial positive-definite
  functions, and characters of `R ⋊ U` restricted to `R`. → X03D's FR-1 and its Bekka–Francini discharge.
- **G51** — bears: two minds per claim while retraction is free. → verifiers in wave 1–2; the advisor on call.
- **G30** — bears: derivation kills, measurement generates. There is no measurement in this crunch. Exact checks only confirm derived
  claims. → standing rules.
- **G60, G66** — bear: "Fractional colourings … stop where a residue plane is fractionally small", and the towers' limits are measurable
  densities. FL-2's one-sided bound is of their Hoffman type. → X03D stage 3.
- **G71, G74, G75, G77** — bear: at three colours the slope is a character, and characters peel to one place (G77). MR is the measure
  analogue of that peel. → context for X03D's reading of `E`.
- **G48, G55, G56, G59, G64** — bear through the consumer only: MR at ℚ(√47) gives the conjecture's cheapest five-clause (G48), and at
  ℚ(√167) ≥ 5, not 6. Nothing here bears on six. → §5's bearing line.
- **Rows 94, 98, 105, 109–118** — bear: they are the inputs (`E`, `R = O′`, T-C(A), SP-Cor's inputs, row 118's PE-lim statement). They are
  quoted in the briefs.
- **Silent groups.**
  - G1–G20, G22–G29, G31–G45, G52–G53, G57–G58, G61–G63, G65, G67–G70, G73, G78; rows 1–93, 99–104, 106–108, 119: finite witnesses,
    constructions, cells, the 2-adic wall, residue planes, kernel ports. They say nothing about invariant measures on a solenoid.
  - The method rules of § Building and § The gate: no Lean, no solver, no long run in this crunch, so none of them fires.
  - **Falsifiable here:** G76's reading "for all colourings the obstruction is the real place" dies in MR's form if EF_F lands with
    `T + A` as its conclusion. That is registered as §5 item 7.

### §PA — what is held, and what each job must read

- **Read in full:** EF 2010 (the advisor, 05:40; copy under `data/crunch-2026-09-26-x2x3/poros/`); Furstenberg 1967, Berend 1983/1984,
  Manners 2015 (FS-89, FS-91).
- **Partly read:** EL2021 §1 (J51); X02D reads what fixes Thm 1.2's hypotheses.
- **Reviews or summaries only:** Rudolph 1990, Johnson 1992, Host 1995, EL2003, Lindenstrauss–Wang 2012, Z. Wang 2012.
- **Bekka–Francini:** abstract only. Its hypothesis ("generated by unipotent elements") fails for `R ⋊ U`; X03D confirms from the statement.
- **Unread, and blocking a novelty claim:** EF's citing works (the 2023 ×A-invariant paper; Huang 2017). X01D reads them before any
  novelty claim for EF_F.
- **The recognition, in the discipline's words:** measures on a solenoid invariant under a multiplicative group of polynomial growth
  (Einsiedler–Fish); character rigidity of `R ⋊ U` (Bekka); radial positive-definite functions (Schoenberg).

### §IQ — the invariant question (WORKFLOW 3.3)

1. **Existence form.** Is there a `U`-invariant, `E`-null, finite positive measure on `R̂` that is not a Haar multiple? For the consumer:
   is there a four-colouring of ℚ(√47)'s plane?
2. **Structural form.** *What does every invariant probability measure of a multiplicative group of polynomial growth, acting by
   automorphisms on a solenoid, carry?* Pose it with the arithmetic stripped: any countable abelian group of automorphisms whose number of
   elements of entropy `≤ log N` grows like a power of `N`.
3. **The invariants it forces.** Entropy, split into the positive-entropy half (Johnson on 𝕋; PE-2 here) and the zero-entropy half (EF's
   pigeonhole on balls against the group's growth). The Fourier profile: `τ̂` is a function of the quadrance (FR-1).
4. **Route.** Derivation only.
5. **Open instances it would decide.** MR at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) (row 117), hence five colours there given SP-Cor and K0.
   `χ(ℚ(√167)²) ≥ 5`. Row 88 at ℚ(√59), ℚ(√83), ℚ(√131), given T-B1 (FS-98).

---

## §4. The queue

**Priority:** P1 launches at once or at the first free slot; P2 launches when its dependencies are met; P3 fills idle slots. **Kinds:**
derivation, blind verifier, close-math, front-page, clerk. Wall hours and harness tokens are the planner's prices; reports record the
actuals. A launch is one line: "Your brief is on disk: read `<path>` in full first."

| id | model | kind | M | decides | inputs | output | deps | h | k | stop rule | spawns | pri | status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| X01D | Opus | derivation | FS-100 s5 | list X01: does Einsiedler–Fish's zero-entropy argument transfer to `U` on `R̂` (EF_F) | EF 2010 (arXiv 0804.3586), its citing works, rows 98, 112–118 | `plans/FS100-X01D-derivation.md` | — | 1.0 | 250 | 220k or 06:50 | none planned | P1 | DONE |
| X02D | Opus | derivation | FS-100 s5 | list X02: PE-lim through finitely generated submodules (PE-2); CE-1 | EL2021 §1 and what fixes Thm 1.2's hypotheses; rows 105, 116–118 | `plans/FS100-X02D-derivation.md` | — | 1.0 | 220 | 200k or 06:50 | none planned | P1 | DONE |
| X03D | Opus | derivation | FS-100 s5 | list X03: the Fourier form; the averaging route (ED); the flip and what the consumer needs (FL) | SP-Cor (J45 §4.2), R88-TCA, rows 112–113, Bekka–Francini's statement | `plans/FS100-X03D-derivation.md` | — | 1.0 | 220 | 200k or 06:50 | none planned | P1 | DONE |
| X01V | Opus | blind verifier | FS-100 s5 | list X01, blind | EF 2010 and the same public inputs; fenced from X01D and the advisor's record | `plans/FS100-X01V-verification.md` | — | 1.0 | 220 | 200k or 06:55 | none | P1 | DONE |
| X02V | Opus | blind verifier | FS-100 s5 | list X02, then FR-1 and ED-1 from list X03, blind | EL2021; fenced from X02D, X03D and the advisor's record | `plans/FS100-X02V-verification.md` | — | 1.0 | 220 | 200k or 06:55 | none | P1 | DONE |
| X05V | Opus | blind verifier | FS-100 s5 | SP-Cor (a blind re-derivation from its statement, the advisor's ladder item [P-5]), then FL-1, FL-2 | J45's lemma statements (not proofs), R88-TCA; fenced from X03D | `plans/FS100-X05V-verification.md` | — | 0.8 | 180 | 160k or 06:55 | none | P2 | DONE |
| X11K | Opus | kernel | FS-100 s5 | — | — | — | — | — | — | — | — | — | run |
| X12B | Opus | blind derivation | FS-100 s5 | — | — | — | — | — | — | — | — | — | DONE |
| X13R | Opus | reading check | FS-100 s5 | — | — | — | — | — | — | — | — | — | DONE |
| J00 | Sonnet | clerk | — | folds reports into §4 statuses, `READY.md` and the close inventory | reports only | commits | every second report | 0.1 | 40 | brief | none | P1 | recurring |
| X09C | Opus | close-math | FS-100 s5 | the derivation file's entries; §R-close for stage 5; predictions scored; ledger rows and `CLAUDE.md` lines drafted | every record and report, the close inventory | `plans/FS100-three-field-lemma.md` §R-close (s5) | the derivations reported, or 06:55 | 0.3 | 150 | 07:12 | none | P2 | run |
| X10F | Opus | front-page | FS-100 s5 | applies X09C's drafts to `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`; scores §5; closes the queue | X09C's drafts | the four files | X09C | 0.25 | 120 | 07:26 | none | P2 | 07:10 |

---

## §5. Registered expectations (the planner's, 05:50, before any job reports; the advisor's in its record)

| # | outcome | P |
|---|---|---|
| 1 | Furstenberg's ×2×3 conjecture (the classical one) is proved | < 0.001 |
| 2 | MR(F) lands: EF_F and PE-2 both TRUE, each by two minds, with no GAP | 0.08 |
| 3 | EF_F: TRUE (X01D) / GAP at a named step / FALSE | 0.30 / 0.55 / 0.15 |
| 4 | PE-2: TRUE by both minds / GAP / FALSE | 0.45 / 0.40 / 0.15 |
| 5 | PE-1 FALSE as written (the subfield caveat), and TRUE in its corrected form | 0.30 |
| 6 | FR-1 TRUE; ED-1 TRUE; ED-2 GAP (FALSE with a counterexample: 0.15) | 0.95; 0.90; 0.75 |
| 7 | EF_F's derivation gives the stronger conclusion "carried by `T + A`" (G76's reading of the real place, falsifiable here) | 0.20 |
| 8 | FL-1 TRUE as written (FL-2 then TRUE with it: 0.8) | 0.40 |
| 9 | The headline `χ(ℚ(√47)²) = 5` is claimed at the close (it needs item 2 and X05V's SP-Cor check) | 0.05 |
| 10 | Every job reports by 06:55 | 0.60 |

**What would make the two hours good:**
- a verdict on EF_F, with the failing step named if it fails, and that step recorded as the honest statement of how hard MR is;
- PE-lim settled by two minds, either way;
- the consumer's exact need stated: MR, or FL-2's one-sided bound.

**Bearing on χ ≥ 6: none directly.** MR decides five at the conjecture's exposed five-clauses, and at ℚ(√167) at most "≥ 5".

---

## §6. The advisor's advice, and where I disagreed

- **P-1 (adopted):** Einsiedler–Fish as the lead route. Its target statement EF_F is in list X01. No hardness job until EF has been read.
  The hardness question (the brief's question 1) becomes: if EF_F fails, its failing step is the hardness statement.
- **P-2 (adopted):** PE-2 is the crux beside EF_F. X02D was moved into wave 1. The advisor's check on Γ-ergodic decompositions was added to
  X02D's brief.
- **P-3 (adopted as addenda):** EF-G's two-line proof, EF-X in one line, a 20-minute cap on ED-2, and the subfield caveat for PE-1.
- **P-4 (adopted):** Bekka–Francini is discharged at the grade reached. The advisor's abstract reading says its unipotent hypothesis fails,
  so no full-reading job.
- **P-5 (adopted):** a blind check of SP-Cor (X05V) and the headline cap (inventory item 8); the known-positive control KC.
- **Disagreed — the wave order.** The advisor wanted verifiers X01V and X02V in wave 1, with X03D deferred. I launched three derivations
  first. The flip (FL-1, FL-2) is the G79 question the owner's brief asks for, and it gets no other slot. The owner then launched X01V into
  the sixth slot at 05:42, so only X02V waits for a hand-back. **Cost:** X02V starts about ten minutes late. **Confidence:** medium.
- **Disagreed, mildly — ED-2 stays in the list.** The advisor reads ED-1's hypothesis as strictly stronger than MR (Nazarov, EF §4). I
  agree. But a FALSE for ED-2, with an explicit character, shows where equidistribution fails for this `U`, and that is knowledge. It is
  capped at 20 minutes.
- **Kept out of the claim lists:** the advisor's sketch for EF_F (multiply through, one prime, recurrence at the split places). It is
  X01D's to write out or refute, and X01V is fenced from it.

---

## §7. Wave 3 — do the findings transfer to the other wanted posters? (planned 06:20; claim lists fixed 06:25, before any derivation)

**Kooshi, verbatim (relayed 06:17):** *"We still have usage left for crunching. Do these findings transfer to the other wanted posters? Please
continue the queue with asks about them."*

**Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
the grade and scope just described; each job names it as an input and does not re-derive it.

**The posters** (`plans/STUB-measure-rigidity-three-fields.md` §2): ℚ(√47) at four colours (J37; now five, `[hand]`); the type-(B) fields
ℚ(√59), ℚ(√83), ℚ(√131) at four (J38); ℚ(√167) at five (J39). The quoted theorems below are from that stub's §2, all
"[hand, one mind; blind-checked TRUE by J48, stage 1]".

### List X21 — ℚ(√167), and the `L ≥ 5` family (X21D derives; X21V verifies blind)

Inputs quoted verbatim:
- Row 117: "For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)`
  ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and SP-Cor hold with J45's proofs — so MR(F) ⟹
  `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)."
- K0 (list of `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`): "J45's A⁺ and SP-Cor hold, with the same proofs, over every
  real quadratic field in T-C(A)'s class (so over ℚ(√143), ℚ(√311), ℚ(√335)), given T-C(A) there at `S = ∅`."
- J48-N4cor (stub §2, under T-J39-4): "For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`", and
  J48-N4: "`N₄(ℚ(√167)) = ∅`: every stable place of ℚ(√167) is 4-thick, 23 by `0.331695… < 1/3` (margin `1.6·10⁻³`)".
- T-J39-3, T-J39-1 and T-J39-5, verbatim in the stub's §2 (J39 block); J48's corrections there included.

The claims:
- **Q-0.** "Every real quadratic field `ℚ(√d)` with `d ≡ 7 (mod 8)` has no stable dyadic place, so it lies outside row 100's exception."
- **A-1.** "Given MR, for every squarefree `d > 1` with `d ≡ 47, 143, 167 (mod 168)`: `χ(ℚ(√d)²) ≥ 5`."
- **A-2.** "Given MR, for every such `d` with `L(ℚ(√d)) = 5`: `χ(ℚ(√d)²) = 5`. This includes ℚ(√47), ℚ(√143), ℚ(√311) and ℚ(√335)."
- **A-3.** K0, as quoted above (a second mind on a one-mind input; X21V derives it blind).
- **A-4.** "Given MR, `χ(ℚ(√167)²) ≥ 5` by J48-N4cor, independently of row 117 and K0."
- **B-1.** "Given MR, at `F = ℚ(√167)`: `χ(F²) ≤ 5` iff `Y = UD(ℝ²) × G₂₃ × G₄₃` carries a CP five-colouring (T-J39-3 and T-J39-1 with MR(F)
  discharged)."
- **B-2.** "Given MR, if PL(23, 43) holds, then `χ(ℚ(√167)²) ≥ 6` iff `χ_CP(ℝ²) ≥ 6` (T-J39-5 (i), and (ii) with MR(F) discharged and J48's
  correction)."
- **B-3** (a question; the answer is a derivation or a GAP). "Name the weakest statement about `Y`'s factors (`UD(ℝ²)`, and `G₂₃`, `G₄₃` at full
  depth) that implies 'Y has no CP five-colouring', and say whether any held result gives it: row 75 (five refused at 23 at every level), row 71
  (five refused at 43 at level one), five-colour bounds on `m₁`-type densities of `ℝ²`."

### List X22 — the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) (X22D derives; X22V verifies blind)

Inputs quoted verbatim: T-J38-2 and T-J38-3 (stub §2, J38 block); row 111: "`F(R) ≠ 0` iff every translation-invariant random four-colouring of
the plane is a pullback from the tight place (Q-μ) and no colouring is transient — none whose orbit closure's invariant measures all live on
the pullbacks without its being one (Q-tr)".

The claims:
- **C-0.** "ℚ(√59), ℚ(√83) and ℚ(√131) lie outside row 100's exception: their stable dyadic place is inert, not ramified, in `L/F`."
- **C-1.** "Given MR, at `F ∈ {ℚ(√59), ℚ(√83), ℚ(√131)}`, Q-μ holds: every translation-invariant random four-colouring of `F²` is almost
  surely a pullback from the tight place. T-B1 is not used."
- **C-2.** "Given MR, at those fields: `F(R) ≠ 0` (row 88) iff Q-tr (no four-colouring is transient)."
- **C-3.** "Given MR, at those fields: T-B1 ⟺ row 88 ⟺ Q-tr."
- **C-4.** "Over ℚ(√59), no four-colouring of the plane is transient." (TRUE, FALSE, or GAP at a named step. It asks whether EF_F⁺'s method —
  Lemma 3.1′, EF's pigeonhole against polynomially many rational unit-vector multipliers, Lemma Z's wandering shells — transfers from invariant
  measures to a single colouring's orbit.)
- **SEL-k** (the advisor's F2; a reduction, for every `k`). "For every real number field `F` outside row 100's exception and every `k ≥ 2`,
  given MR: `F²` is `k`-colourable iff it has a translation- and rotation-invariant random `k`-colouring whose spectral measure is carried by
  `E`." **Named risk:** it rests on X03D's FL-K (the relatively independent self-joining over the `E`-factor), which is one mind; check it
  blind. At `k = 5` over ℚ(√167) it would turn six into row 110's window question at `{∞, 23, 43, …}`, graded as a reduction, never as a
  bound.

### List X23 — every real number field: SP-Cor(F) and the class (X23D derives; X23V verifies blind) — **revised 06:27, before any X23 job launched, on the advisor's F1 and F4**

*The first draft (D-1 to D-4, 06:25) is replaced. D-1 and D-C survive below as D-1 and CTL. Nothing had been derived on the first draft.*

Inputs quoted verbatim: row 117 (quoted in list X21); SP-Cor and A⁺ at `S = ∅` (`plans/FS84-SI-D-derivation.md` §4.2, §5.4); X05V's re-derivation
P0–P8 (`plans/FS100-X05V-verification.md` §2.1); J48-N4cor (quoted in list X21).

- **SPC(F)** (SP-Cor for every real number field; the advisor's F1 (a)). "For every real number field `F` outside row 100's exception: if T-C(A)
  holds at `S = ∅` (every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`), then J45's A⁺ and SP-Cor hold with J45's
  proofs, and, given MR, `χ(F²) ≥ 5`." **Named risk (the advisor):** A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places. X03D's
  `Λ = 0.4028 > 1/3` shows that first moments alone cannot do it; J45 did it at `n = 2`.
- **CLS(F)** (the class; the advisor's F1 (b)). "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff
  `L(F) ≥ 5`." **Named risks (the advisor):** `q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n`
  places.
- **COR.** "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)` for every real number field outside row 100's exception."
- **CTL** (controls; each must come out as stated, and each can fail). "T-C(A) at `S = ∅` fails at K = ℚ(√3,√11), ℚ(√2,√3), ℚ(√11) and ℚ(√23),
  where `L ≤ 4`. At ℚ(√47) it holds."
- **Q35.** "ℚ(√3,√5) lies outside row 100's exception. Its stable places are exactly those above 11, 59 and the other primes of residue
  degree one in `L/ℚ(√3,√5)` that are inert in `L/F`; 3, 7, 19, 23, 31, 43 and 47 are not stable; and T-C(A) holds there at `S = ∅`. Hence,
  given MR and SPC, `χ(ℚ(√3,√5)²) = 5`." (The advisor's F4; its Legendre-symbol list is one mind. An exact check of seconds is in.)
- **D-1** (the J48 route, kept). "Given MR, for every totally real number field `F` outside row 100's exception with `N₄(F) = ∅`: `χ(F²) ≥ 5`."

### Queue rows (wave 3; stop time 12:30 UTC; close from 07:30)

| id | model | kind | M | decides | inputs | output | deps | h | k | stop rule | spawns | pri | status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| X21D | Opus | derivation | FS-100 s5 (w3) | list X21: ℚ(√167) ≥ 5, the family's five, six at ℚ(√167) as a CP question | rows 111, 117; the stub's §2; waves 1–2 records by statement | `plans/FS100-X21D-derivation.md` | — | 0.75 | 250 | 230k or 07:30 | none | P1 | ready |
| X21V | Opus | blind verifier | FS-100 s5 (w3) | list X21, blind (A-3 = K0's blind second mind) | same, fenced from X21D | `plans/FS100-X21V-verification.md` | — | 0.75 | 250 | 230k or 07:30 | none | P1 | ready |
| X24R | Opus | reader | FS-100 s5 (w3) | the prior-art gate for MR and for the value `χ(ℚ(√47)²) = 5`; EL2021 §2; Sataev 1975; Huang 2017 | `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` §1.7, §3 | `plans/FS100-X24R-prior-art.md` | — | 0.75 | 200 | 07:30 | none | P1 | ready |
| X22D | Opus | derivation | FS-100 s5 (w3) | list X22: the type-(B) fields given MR (Q-μ; row 88 as transience alone; C-4 capped at 20 minutes), and SEL-k | T-J38-2/3, rows 88, 111, 112 | `plans/FS100-X22D-derivation.md` | a free slot | 0.75 | 250 | 230k or 07:30 | none | P1 | ready |
| X22V | Opus | blind verifier | FS-100 s5 (w3) | list X22, blind | same, fenced | `plans/FS100-X22V-verification.md` | a free slot | 0.75 | 250 | 230k or 07:30 | none | P1 | ready |
| X23D | Opus | derivation | FS-100 s5 (w3) | list X23: SP-Cor and the class for every real number field; ℚ(√3,√5) | SP-Cor, A⁺, X05V's P0–P8, row 117, J48-N4cor | `plans/FS100-X23D-derivation.md` | a free slot | 0.75 | 250 | 230k or 07:30 | none | P1 | ready |
| X23V | Opus | blind verifier | FS-100 s5 (w3) | list X23, blind | same, fenced | `plans/FS100-X23V-verification.md` | a free slot | 0.75 | 250 | 07:30 | none | P1 | ready |
| X29C | Opus | close-math | FS-100 s5 (w3) | wave 3's close: derivation entries, §R-close (wave 3), drafts | wave-3 reports | `plans/FS100-three-field-lemma.md` | 07:30 | 0.3 | 150 | 07:50 | none | P2 | wait |
| X30F | Opus | front-page | FS-100 s5 (w3) | applies X29C's drafts | X29C | the four front files | X29C | 0.25 | 150 | 08:05 | none | P2 | wait |
