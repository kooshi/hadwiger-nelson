*Brief for job **X02D**: route (B) of the ×2×3 crunch, PE-lim through finitely generated submodules. Opus 5.5. Written by the crunch
planner (`plans/CRUNCH-2026-09-26-x2x3-queue.md`, which you may read in full). **Sized for about one hour and 220k harness tokens.** A blind
verifier, X02V, works on the same claims; never contact it.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your
context; re-read from disk only what you cite. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in
full.** The owner coordinates; the choices are Kooshi's, through the owner.

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X02D-derivation.md` and
continue at the first stage not SAVED.

## The question, and why now

`LEDGER.md` row 118 records: "No finitely generated `Γ ⊂ U_F` acts irreducibly on the solenoid `R̂` … so EL2021 Thm 1.2 never applies", and
"MR is its zero-entropy half plus an owed lemma PE-lim (from finitely generated `Γ` to `U`)". The planner's observation (one mind, a
sketch, to be written out or refuted, never trusted): Thm 1.2 does not apply on `R̂`, **but it may apply on `M̂` for every finitely generated
`ℤ[Γ]`-submodule `M ⊂ R` with `ℚM = L`**. Every `ℤ[Γ]`-submodule of such an `M` spans an `L`-subspace of `L` over `ℚ`, so it is `0` or of
finite index. `R̂` is the inverse limit of the `M̂`. Kolmogorov–Sinai entropy of an inverse limit is the limit of the factors' entropies.
If this works, the Haar components of the pushforwards cohere and PE-lim follows. The advisor calls PE-2 "the crux, not a side job": it is
the positive-entropy half that EF's argument (job X01D) needs beside it. A FALSE or a GAP counts in full.

## The claims (verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X02; notation there)

Copy §2's notation paragraph and list X02 (HX-1, PE-1, PE-2, CE-1) into your record first, verbatim, and work from that copy. Per claim:
TRUE, FALSE with a counterexample, or GAP at a named step.

## Read first

- EL2021 at `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (the held copy, under its journal-year key; J51's `data/fs100/j51/el2021.pdf` is not on disk): §1 (read by J51: the definitions of solenoid, irreducible, totally irreducible, virtually cyclic
  factor; Thms 1.1–1.3), and whatever of §§2–9 fixes what Thm 1.2 assumes (is `μ` required ergodic; is the acting group `ℤ^d` exactly;
  what "no virtually cyclic factor" means there). Mark reading status per section.
- `plans/FS100-three-field-lemma.md` §PA.1–§PA.3 (J51-T2 and the PE-lim sketch through Thm 1.3); `plans/FS100-derivation.md` FS100-T2;
  `LEDGER.md` rows 105 (`R = O′`), 116–118.
- **The advisor's two checks, relayed verbatim** (Poros, by message to the planner, 2026-09-26; one mind): "M is finitely generated over the
  1-dimensional Noetherian domain ℤ[Γ], so M/N has finite length, hence is finite, and every Γ'-module is irreducible. The risk: Thm 1.2
  needs µ_M to be Γ-ergodic, while µ is only U-ergodic. X2D must handle the Γ-ergodic decomposition, with entropy affine and the components
  permuted by U, explicitly."
- **The planner's own list of steps to check** (questions): does the Haar weight `a_M` of the pushforward to `M̂` stay the same as `M`
  grows (the pushforward of a zero-entropy measure has zero entropy, and Haar on `M̂` has positive entropy); is the family of non-Haar parts
  consistent, so that it defines `τ′` on `R̂ = lim M̂`; is `a` independent of `Γ`; does every non-torsion `u ∈ U` lie in some `Γ` of PE-1's
  kind; is `h_{τ′}(u) = lim_M h_{ρ′_M}(u)` legitimate (the factors' σ-algebras increase to the whole).

## Stages

1. Quotation check. Read EL2021 as above. A C0 table: your probability for each claim, before any derivation. Invoke
   `debruijn-obligation-modeling` **freshly with the Skill tool**, applied to PE-2: what is the statement from which the proof derives? Save.
2. HX-1 and PE-1. Save.
3. PE-2: every step on the list above, the ergodic-decomposition risk explicitly. Save.
4. CE-1: say exactly which conjecture in print it is conditional on; quote that conjecture from EL2021 or from a survey, if one states it.
   Save; the report.

**Stop rule:** at 200k harness tokens or at 11:50 UTC, whichever comes first, finish the current claim, save, and report what is left. Do
not lean toward TRUE: a PE-2 that fails at the ergodic decomposition is as useful as one that holds.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3). Keep a "would have searched here" log.
- **Record:** `plans/FS100-X02D-derivation.md`, with a "Theorems this phase proved" heading. Working files go in `data/fs100/x02d/`; exact
  checks in `tools/x02d_*.py`, with plants watched firing.
- Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the queue; propose edits in your record.
- **Commits:** by explicit path, with subjects "X02D: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X02D.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X02D idle; report sent to the owner by SendMessage".

Thank you.

## Addendum (05:45, from the advisor's review; read after launch)

- **PE-1's total irreducibility** (Poros, relayed verbatim): "PE-1's total irreducibility needs ℚ(Γ') = L for every finite-index Γ' ⊆ Γ,
  not only for Γ. A power of u can land in another quadratic subfield of L, for example ℚ(i) or ℚ(√−47). Tell X02D to choose Γ so that this
  cannot happen." If PE-1 as fixed is FALSE for some `Γ` of its stated kind for this reason, say so (that is a verdict on the claim as
  written), and then prove the corrected form: `Γ` chosen so that no non-torsion element has a power in a proper subfield of `L`. Say also
  whether every non-torsion `u ∈ U` still lies in some such `Γ` (PE-2 needs it, or needs a separate argument for `u` with a power in a
  proper subfield).

## Addendum 2 (05:46, the advisor; [reading, one mind] — write out or refute, never trust; the verifiers do not have it)

Poros, relayed verbatim: "PE-2: the snag. M is only a ℤ[Γ]-module, so U does not act on M̂. 'Components permuted by U' therefore cannot be
said on M̂. The fix: decompose on R̂, not on M̂. (1) Take the Γ-ergodic decomposition of µ on R̂ itself. A factor of an ergodic system is
ergodic, so each component µ_c pushes to a Γ-ergodic measure on every M̂. (2) If h_{µ_c}(u) > 0, then by the sup over M there is an M with
h((µ_c)_M) > 0. For every M′ ⊇ M the same holds, so Thm 1.2 gives (µ_c)_{M′} = Haar_{M′} on a cofinal family, and hence µ_c = m. Otherwise
µ_c has zero entropy for all of Γ. (3) U commutes with Γ. So U permutes the components, fixes m and preserves entropy (the systems are
conjugate). The split µ = a·m + ν is therefore U-invariant. (4) If µ is U-ergodic, then a ∈ {0, 1}. Every non-torsion u lies in some
admissible Γ. Conclusion (the ergodic PE-2): µ = m, or h_µ(u) = 0 for every u. Then: ergodic MR = ergodic PE-2 + EF_F. The general MR follows
by U-ergodic decomposition, since E is a U-invariant Borel set. CE-1 becomes moot."

What the planner would check in it (questions): in (2), is "zero entropy for all of Γ" what EL's dichotomy gives for each component, or
only "zero entropy for the elements of Γ" (the same thing, if Γ is the acting group); in (4), is "every non-torsion `u` lies in some
admissible `Γ`" true, given Addendum 1's subfield caveat. CE-1 stays on your list: if PE-2 lands, CE-1 is TRUE for that reason, so say so.
