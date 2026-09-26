*Brief for job **X01D**: route (A) of the ×2×3 crunch, the Einsiedler–Fish transfer. Opus 5.5. Written by the crunch planner
(`plans/CRUNCH-2026-09-26-x2x3-queue.md`, which you may read in full). **Sized for about one hour and 250k harness tokens.** A blind verifier,
X01V, works on the same claims; never contact it.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your
context; re-read from disk only what you cite (G21, G72, G76, G79 bear most). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is
part of this brief; read it in full.** The owner coordinates; the choices are Kooshi's, through the owner.

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X01D-derivation.md` and
continue at the first stage not SAVED.

## The question, and why now

The project's missing lemma is MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure"
(J38 §3.5, T-J38-2 (iii), quoted in `plans/STUB-measure-rigidity-three-fields.md` §1). Given it, `χ(ℚ(√47)²) = 5` follows (SP-Cor,
`plans/FS84-SI-D-derivation.md` §4.2). FS-100 filed MR as "its zero-entropy half plus an owed lemma PE-lim" (`LEDGER.md` row 118), and
the zero-entropy half looked ×2×3-hard. The advisor found a theorem in print that may cover a group like `U`: Einsiedler–Fish (2010) prove
that multiplier semigroups of **polynomial growth** on 𝕋 are rigid. A finitely generated semigroup cannot have polynomial growth; `U` has
infinite rank. **Does EF's zero-entropy argument transfer to `U` acting on `R̂`?** Either answer counts in full. A transfer, or a proof
that it fails at a named step, is a result. The failing step would be the honest statement of how hard MR is.

## The claims (verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X01; notation there)

Copy §2's notation paragraph and list X01 (EF-G, EF_F, EF-MR, EF-X) into your record first, verbatim, and work from that copy. Per claim:
TRUE, FALSE with a counterexample, or GAP at a named step.

## Read first

- **The paper:** arXiv 0804.3586 (Einsiedler–Fish). The advisor saved it at `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`,
  with its text beside it as `ef.txt`. Read it in full; the proof is three pages. Quote its main theorem verbatim.
- **Its citing works, as prior art for EF_F** (read these before any novelty claim): "Strongly Independent Matrices and Rigidity of
  ×A-invariant Measures on n-torus" (2023), and Huang 2017 (Zbl 1402.37006). They may already be the higher-dimensional EF. Fetch them.
  Check `BIBLIOGRAPHY.md` and `~/source/library/` first.
- `LEDGER.md` rows 98, 112, 113, 116–118; `plans/FS100-three-field-lemma.md` §PA.1–§PA.3; EL2021 at `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (the held copy, under its journal-year key; J51's `data/fs100/j51/el2021.pdf` is not on disk) §1.
- **The advisor's reading of EF, relayed verbatim** (Poros, by message to the planner, 2026-09-26; one mind, not checked):
  > "Lemma 3.1 (by Shannon–McMillan–Breiman): h(T_p) = 0 ⟹ µ(B_δ(x)) > δ^β on a set of measure 1−ε."
  > "Lemma 3.2 has two steps: (a) Pigeonhole: the M^{α/2} images qB_δ(x), q ≤ M, each of mass > δ^β, cannot be disjoint. (b) The
  > Diophantine step: it gives x ≈ k/ℓ with error 2M^{-4} and ℓ < M. Then |k1/ℓ1 − k2/ℓ2| ≥ 1/(ℓ1ℓ2) forces the approximation to be stable,
  > so x is rational."
  > "Step (b) is the product formula in disguise. Adelically (lift x to ∏O_w × a fundamental domain at ∞), the archimedean freedom lands
  > exactly in A. So the natural conclusion of an EF_F is 'zero entropy for every u ⟹ µ is carried by T+A'."
  > "(i) Lemma 3.1 applies to one u, and gives smallness only at S(u), u's non-isometric places. So take u = ∏u_p to cover a chosen S.
  > (ii) At the S-places, ℓ = v1 − v2 can be w-adically tiny (v1 ≡ v2 mod π^k). EF gets |ℓ| ≥ 1 for free. Bound ∏_{w∈S}|ℓ|_w^{-1} by the
  > product formula (it is ≤ 2·H(v1)H(v2)); but a product of maxima over two approximations is not a product of products. This is where I
  > expect the derivation to sweat. (iii) The count #{v ∈ U : H(v) ≤ M} ≥ M^α for general F: rational points of an anisotropic torus. It is
  > linear over ℚ; cite it rather than assume it."
  > "Every non-torsion u ∈ U has positive Haar entropy. U ∩ O_L^× is torsion by Kronecker's theorem, because |u|_v = 1 at every
  > archimedean place of L."
- **The advisor's sketch for EF_F, relayed verbatim** (Poros, second message, 2026-09-26; **[reading, one mind, unchecked]** — write it out
  or refute it, never trust it; X01V does not have it):
  > "(a) Multiply through; do not divide. Set e_i = ℓ_i·x − r_i, using the lift of x in ∏O_w × D_∞. Two scales give z := ℓ2·r1 − ℓ1·r2 =
  > ℓ1·e2 − ℓ2·e1 ∈ R. The bounds on z: at each w ∈ S: |z|_w ≤ M²·δ; off S: the product of the local bounds is ≤ H(v)'s, that is M^{O(1)};
  > at ∞: |z| ≤ 4C. Stable places give ≤ 1. So if z ≠ 0, the product formula needs ∏_{∞,split}|z|_v ≥ 1. With δ = M^{-K} the product is
  > < 1, so z = 0 and r1/ℓ1 = r2/ℓ2. No |ℓ|_w^{-1} appears anywhere."
  > "(b) One prime suffices. Take S = {π, π̄} and u = u_p. Lemma 3.1 plus the adelic Lemma 3.2 give x ∈ T + K_S, where K_S is the image of
  > ℂ × ∏'_{w∉S} L_w. The map from that product is injective, because an element of R vanishing at S is 0. The stabiliser of a leaf t + K_S
  > is a congruence subgroup of U of finite index, because K_S ∩ T = 0. On each leaf, pulled back to V_S, the finite measure is invariant
  > under u_q^k for every split q ∉ S. That element acts on L_π' × L_π̄' hyperbolically, as (a, a^{-1}). By Poincaré recurrence the measure
  > is carried by the set where both coordinates are 0. Hence µ is carried by T + A ⊂ E. So EF_F reads: an ergodic U-invariant µ with
  > h_µ(u_p) = 0 for ONE split p is carried by T + A. With PE-2 this gives MR(F) for every real number field."
  > "(c) Control: known four-colourings must survive. MR must be consistent with the four-colourings we know exist: K by Theorem B, and
  > ℚ(√11)'s non-periodic ones (row 94). Their spectral measures are local, lying in T + Fin_S (plus Haar), and MR allows exactly that. SP-Cor
  > must therefore fail at K and at ℚ(√11) exactly at T-C(A). … If MR-based reasoning ever implies χ(K²) ≥ 5, a step is wrong."

  What to watch in (b), from the planner (questions): is the measure's lift to `V_S` well defined and measurable (the leaf decomposition of
  `T + K_S`, and whether `K_S` is a Borel set); is the "wandering shells" form of recurrence (`u_q` shifts the shells `|x_q| ∈ (p^n, p^{n+1}]`,
  all of equal mass, inside a finite measure) what is used; and does (a) really give `x ∈ T + K_S` for `μ`-almost every `x`, from Lemma 3.1
  at the single element `u_p`? **Run control (c) as a claim-level check**: say where the argument would break at K and at ℚ(√11) if it
  were applied to their four-colourings' spectra, and confirm that it does not claim they are Haar.
- **The planner's named risk** (a question, not the answer): in EF every multiplier expands the **same** real direction. Each `u ∈ U`
  expands only its own split places. EF_F's hypothesis is zero entropy for **one** `u`, which constrains `μ` only at `S(u)`. Decide whether
  the pigeonhole of Lemma 3.2 (a) can be run with multipliers that expand different places, or whether EF_F must be weakened to "zero
  entropy for every `u`". If so, record the weakened statement as a new claim, and do not silently replace EF_F.

## Stages

1. Quotation check (every quotation above against its source; the relayed advisor text against nothing, since it is a message, so log it
   as relayed). Read EF in full and its two citing works. A C0 table: your probability for each claim, before any derivation. Save.
2. EF-G (cite the count of rational points of bounded height on the norm-one torus; over ℚ it is the Pythagorean count) and EF-X (the
   control: say what a wrong-reason pass would look like). Save.
3. EF_F, following EF's lemmas step by step through risks (i)–(iii) and the planner's risk. Save.
4. EF-MR (a composition: check which hypotheses of PE-2 and SP-Cor it uses, and name them). Save; the report.

**Stop rule:** at 220k harness tokens or at 11:50 UTC, whichever comes first, finish the current claim, save, and report what is left. A
GAP with the step named is a complete result. Do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3). Reading papers is in. Keep a "would have searched here" log.
- **Record:** `plans/FS100-X01D-derivation.md`, with a "Theorems this phase proved" heading. Working files go in `data/fs100/x01d/`; exact
  checks in `tools/x01d_*.py`, each with a planted fault watched firing.
- Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the queue; propose edits in your record.
- **Commits:** by explicit path, with subjects "X01D: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X01D.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X01D idle; report sent to the owner by SendMessage".

Thank you.

## Addendum (05:45, from the advisor's review; read after launch)

- **EF-G (b) has a two-line proof** (Poros, relayed verbatim, one mind): "U_ℚ ⊆ U_F, and for u ∈ U_ℚ we have H_L(u) = H_{ℚ(i)}(u)^{[F:ℚ]}.
  So #U_N(F) ≥ #U_{N^{1/n}}(ℚ), where n = [F:ℚ]. Over ℚ this is the count of primitive Pythagorean triples with hypotenuse ≤ N, which is
  about N/(2π). Hence the exponent is ≥ 1/[F:ℚ] > 0." Check it, and spend no more time there than that.
- **EF-X is one line** (Poros): "Take the uniform measure on a circle in A. U is dense in S¹, so the measure is U-ergodic; it has zero
  entropy and is not finitely supported." Check it, and move on. Your time belongs to EF_F. If your derivation gives the stronger conclusion
  `μ(T + A) = 1`, record it as a separate, stronger statement beside EF_F.

## Addendum 2 (05:46, the advisor; [reading, one mind] — write out or refute, never trust; X01V does not have it)

Poros, relayed verbatim: "Lemma 3.1 transfers, by local injectivity. Partition the fundamental domain ∏O_w × D_∞ into pieces that are
η-small at S and at ∞. Along the two-sided refinement under u_p, the correction r ∈ R at each step is integral off S and ≤ 2η at ∞. By the
product formula it has |r|_π·|r|_π̄ ≥ 1/(4η²) unless r = 0, so r = 0 at every step. Hence the atoms are ηp^{-n}-small at S."
"The final step, x_lift = q at S, divides by |ℓ_k|_w, and that is fine. The product formula for ℓ_k gives |ℓ_k|_π·|ℓ_k|_π̄ ≥ c·M_k^{-2}. So
|x − q|_w ≤ C·M_k^{4−K}, which tends to 0 for K > 6. K > 6 is also what z = 0 needs, since (M³·M^{-K})²·M⁶ < 1. The pigeonhole needs
β < α/K. Lemma 3.1 allows any β > 0."
"A sanity fact. A finite U-invariant measure on a Fin_S leaf is carried by T + A, by the same recurrence argument. That is R-U (two
derivations), so EF_F agrees with a held result."
