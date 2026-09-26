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

## §4. The queue

**Priority:** P1 launches at once or at the first free slot; P2 launches when its dependencies are met; P3 fills idle slots. **Kinds:**
derivation, blind verifier, close-math, front-page, clerk. Wall hours and harness tokens are the planner's prices; reports record the
actuals. A launch is one line: "Your brief is on disk: read `<path>` in full first."

| id | model | kind | M | decides | inputs | output | deps | h | k | stop rule | spawns | pri | status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| X01D | Opus | derivation | FS-100 s5 | list X01: does Einsiedler–Fish's zero-entropy argument transfer to `U` on `R̂` (EF_F) | EF 2010 (arXiv 0804.3586), its citing works, rows 98, 112–118 | `plans/FS100-X01D-derivation.md` | — | 1.0 | 250 | 220k or 06:50 | none planned | P1 | wave 1 |
| X02D | Opus | derivation | FS-100 s5 | list X02: PE-lim through finitely generated submodules (PE-2); CE-1 | EL2021 §1 and what fixes Thm 1.2's hypotheses; rows 105, 116–118 | `plans/FS100-X02D-derivation.md` | — | 1.0 | 220 | 200k or 06:50 | none planned | P1 | wave 1 |
| X03D | Opus | derivation | FS-100 s5 | list X03: the Fourier form; the averaging route (ED); the flip and what the consumer needs (FL) | SP-Cor (J45 §4.2), R88-TCA, rows 112–113, Bekka–Francini's statement | `plans/FS100-X03D-derivation.md` | — | 1.0 | 220 | 200k or 06:50 | none planned | P1 | wave 1 |
| X01V | Opus | blind verifier | FS-100 s5 | list X01, blind | EF 2010 and the same public inputs; fenced from X01D and the advisor's record | `plans/FS100-X01V-verification.md` | — | 1.0 | 220 | 200k or 06:55 | none | P1 | wave 2 |
| X02V | Opus | blind verifier | FS-100 s5 | list X02, then FR-1 and ED-1 from list X03, blind | EL2021; fenced from X02D, X03D and the advisor's record | `plans/FS100-X02V-verification.md` | — | 1.0 | 220 | 200k or 06:55 | none | P1 | wave 2 |
| X05V | Opus | blind verifier | FS-100 s5 | SP-Cor (a blind re-derivation from its statement, the advisor's ladder item [P-5]), then FL-1, FL-2 | J45's lemma statements (not proofs), R88-TCA; fenced from X03D | `plans/FS100-X05V-verification.md` | — | 0.8 | 180 | 160k or 06:55 | none | P2 | first free slot |
| J00 | Sonnet | clerk | — | folds reports into §4 statuses, `READY.md` and the close inventory | reports only | commits | every second report | 0.1 | 40 | brief | none | P1 | recurring |
| X09C | Opus | close-math | FS-100 s5 | the derivation file's entries; §R-close for stage 5; predictions scored; ledger rows and `CLAUDE.md` lines drafted | every record and report, the close inventory | `plans/FS100-three-field-lemma.md` §R-close (s5) | the derivations reported, or 06:55 | 0.3 | 150 | 07:12 | none | P2 | 06:55 |
| X10F | Opus | front-page | FS-100 s5 | applies X09C's drafts to `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`; scores §5; closes the queue | X09C's drafts | the four files | X09C | 0.25 | 120 | 07:26 | none | P2 | 07:10 |
