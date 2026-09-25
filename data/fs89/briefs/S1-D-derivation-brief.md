*Brief for the FS-89 Stage-1 derivation agent ("D", de Bruijn, Opus 5.5), 2026-09-25. Text: the plan's §C.1 (`plans/FS89-rational-band-rigidity.md`, commit ac236581), pasted by the owner with the persona line, the scratch path and the date added.*

**Persona:** you are de Bruijn (`DEBRUIJN.md`), called **"D"** in this milestone. **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-s1d/`. Please don't list or read other scratch directories, or `~/source/lean-dir-owner/`. **Date:** 2026-09-25; Stage 1a runs to 2026-09-27 evening.

**Berend 1983 (TAMS) §4:** I have put the browser-save request to Kooshi. Until it arrives, proceed without it and name the gap wherever case 1 of Prop. 4.1 needs it.

Hello. You are this project's derivation agent for milestone FS-89, Stage 1, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Your identity and standard are `DEBRUIJN.md`; the house rules are `CLAUDE.md` and `WORKFLOW.md`. Read
all three from disk: any copy in your context is a snapshot. I'm the product owner; I coordinate and review by artifact. The plan is
`plans/FS89-rational-band-rigidity.md`; read §0, §PA and §IQ first, then §S. One blind verifier works beside you on the same statements;
there is no competition and no advisor.

**The question.** Let `Q = ℤ[i][1/p : p ≡ 1 (mod 4)]`, the ring the rational unit vectors generate, and for a finite set `S` of such
primes let `R_S = ℤ[i][1/p : p ∈ S]` with unit vectors `U_S = ⟨i⟩ × ⟨w_p : p ∈ S⟩`, `w_p = π_p/π̄_p`. A **band character** at four
colours is a character `θ` with `θ(u) ∈ [1/4, 3/4]` for every unit vector `u`. The target, quoted from the plan's §0.2:
"**RQ₄**: `Θ₄(Q) ⊆ T + A`" (torsion characters plus archimedean ones `x ↦ Re(ē x) mod 1`). It is equivalent to the same statement over
every subfield of ℝ (S0A-10), and it would give HD1 for ℚ(√59), ℚ(√83), ℚ(√131) and exclude every character four-colouring of
ℚ(√47)'s plane (S0A-6, S0A-8). At one prime it is false: `Θ₄(ℤ[i][1/5])` contains heteroclinic and switching characters that are
not `T + A` (S0B-T3–T5).

**Your questions, in order** (quoted from §S.2; you may re-order with a logged reason, and I may redirect after Stage 1a):
- **D-0.** "Read `[Berend1984min]` in full (held), Haynes–Munday §1, S0B's record and `tools/fs89_s0b_orbits.py`; write the rank-two
  orbit model (arrays `e_m`, `m ∈ ℤ²`, one step rule per prime, the gluing across both directions)."
- **D-1a.** "Is every `U_S`-minimal closed subset of `Θ₄(R_S)` contained in `T + A`, for every finite `S` with `|S| ≥ 2` (first
  `S = {5, 13}`)? Prove it — the route to test first is Berend's Prop. 4.1 with the archimedean plane in place of the strictly
  contracted subspace — or name the step that fails and why."
- **D-1b.** "At `S = {5, 13}`: is there a band character of `R_S` whose orbit closure meets two different leaves (a heteroclinic or
  switching character)? Either exclude every such character, or exhibit one with exact band checks on a window and a proof that it
  persists (S0B-T3–T5's standard)."
- **Then (Stage 1b)**, depending on the outcome: **D-2** (RQ₄ over all primes, using weak approximation of the rational circle — the
  lever rank two lacks — and U1 only if the verifier has proved it), or **D-C** ("does the rank-two counterexample extend to a band
  character of `Q`, adding split primes one at a time with compactness, or does some prime kill it as 13 killed the rational
  heteroclinics?"). A counterexample to RQ₄ must read infinitely many split places (S0A-11).
- **Optional D-3**, only if D-1 lands early: are there band torsion characters of `ℤ[i][1/5]` of unbounded order? No enumeration beyond
  S0B's `N ≤ 130`.

**The mathematics you stand on, with addresses.**
- Stage 0: `plans/FS89-S0A-gluing-verification.md` (the gluing S0A-2; Lemma N₀ S0A-3, `N = 168` automatic over `Q`; level collapse
  S0A-4; finite type S0A-11; one prime cannot bound `N` S0A-12; C3's "natural attack" by weak approximation) and
  `plans/FS89-S0B-band-set.md` (the orbit model S0B-T1; leaves and margins S0B-T2; `θ*` S0B-T3; "not `T + A`" S0B-T4; the switching
  family S0B-T5; 13 kills rational heteroclinics S0B-T6, one mind; the reading U4 and its killing test in §6).
- FS-86: `plans/FS86-derivation.md` §4 (dB-Theta, dB-HDfin = Cx-C10, dB-Sv, dB-HDint, dB-HDcert, Cx-C15) and §9 (C14, CL1).
- The three-colour precedent: `plans/FS81-derivation.md` T3 (= C1(5)), T4, T5, T8; `CLAUDE.md` G74.
- **The literature the gate found (plan §PA.3), which is the key idea, handed to you in full:** Berend, *Minimal sets on tori* (ETDS 1984;
  `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf`). Thm 2.1: all minimal sets are torsion iff the semigroup is hyperbolic
  and multi-parameter. **Lemma 3.1**: an isometric common eigen-direction carries non-torsion minimal circles (our archimedean leaves),
  so the statement to aim at is "modulo the isometric direction", which is why the target says `T + A` and not `T`. **Lemma 3.3**: rank
  one has positive-dimensional minimal sets (the phenomenon S0B met). **Prop. 4.1**: for a non-torsion minimal `M`, `M − M` is closed,
  invariant, `0` non-isolated; case 1 (small differences with expanding components) forces `M − M` to be everything, contradicting
  Furstenberg's Prop. IV.1; case 2 (small differences in the weakly contracting subspace) uses an element contracting it strictly to
  produce a periodic point. With the archimedean plane in that subspace, case 2 plausibly gives "periodic modulo the archimedean leaf";
  **case 1 at the band, not the whole group, is untested, and its source (Berend 1983 §4) is not held** (AMS blocks scripted fetches;
  the owner has asked). Haynes–Munday (arXiv 1303.1661, held): Berend's adelic hypothesis is expansion in every completion,
  archimedean included — the one our norm-one action fails. Maucourant (Annals 2010, review only): non-homogeneous orbit closures
  arise when a factor behaves like one parameter — the shape a rank-two counterexample would take. Vocabulary: algebraic `ℤ^d`-action,
  non-expansive, heteroclinic point (Lind–Schmidt).
- The symmetries of `Θ₄`: the `U`-action, complex conjugation (`b₊ ↔ b₋`), negation. The known band points (positive controls for any
  classification): parity (margin 1/4), `(x+y)/4` and `(3x+2y)/8` (margin 0), the order-3 characters (1/12), the order-7 character
  `(2x+3y)/7` (1/28).
- **What the plan's re-grokking hands you** (§G, each entry's *Do*): the objects are closed sets and minimal sets, not invariant
  measures (G60); at an inert place use Weil's equidistribution of `Tr(at)/q` on `μ_{q+1}` (G44), and in any level-by-level argument
  there say where the carry enters (G66, FS66-E: arguments blind to the carry prove too much); the algebraic case — a `U`-invariant
  coset of a closed subgroup inside `Θ₄` — is FS86-Cx-C15's, so your question is the non-algebraic closed sets; split components are
  defined only modulo global elements (FS86-dB-HDint), so state any counterexample intrinsically; a would-be counterexample usually dies
  by a coset sweep leaving the band (S0A-5, S0A-11); the consumer fields' unit vectors are layers `b·U_ℚ` rotated by the type-M `v_n`
  (G7, G62); a finite window measures its depth, so no window count is read against zero (G21, FS81-T8); state every theorem for every
  `S` it covers, with `{5, 13}` as its inhabitant (G30).
- **Not verified, do not lean on them until the verifier has** (plan §0.3): U1 (the layering lemma), U2 (the explicit leaf list), U3,
  U4, U5. S0A-3 and S0B-T6 are one mind each; the verifier is re-deriving them.

**Scope, quoted from §0.2:** "RQ is about **character** colourings only. A proof of RQ₄ excludes every colouring of the form
`x ↦ ⌊4θ(x)⌋` as a falsifier of the conjecture at ℚ(√47) (C-47); it says nothing about `χ(ℚ(√47)²)` itself … A counterexample to RQ₄
is a band character of `Q`; it is a **seed** of a falsifier at ℚ(√47), not a falsifier."

**Every outcome counts.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* A
proof, a counterexample, a sharp statement of which rank suffices, and a named failing step are all results. **Do not lean toward a
yes**: this project's recorded failure mode is that defects which flatter the work survive and defects which displease are found
within the hour (G21). Audit a proof you like at the rate you would audit a counterexample you dislike.

**Stop rules** (§S.3). Stop a question at a saved claim at exact scope (proved or refuted), or at a named failing step with its reason.
Budgets: D-0 ≤ 40k tokens, D-1a ≤ 150k, D-1b ≤ 120k, D-2/D-C ≤ 150k, total ≤ 420k; at the total, hand back with the record saved.
KT-2: if Berend's route breaks, name the step by 2026-09-27.

**The one computation you may run** (§S.4): the rank-two window at `S = {5, 13}`, only after the verifier's V-A4 model and your D-0
model agree, with its reading pre-registered (both outcomes stated and checked reachable), its four controls, `K = 1` then `K = 2`
capped at 3 hours under `scripts/slot.py --mem 16 --cpus 8 -- …`, output to `data/fs89/s1d/`, never `/tmp`. `K ≥ 3` is Kooshi's.

**The finite-witness-free week** runs to 2026-10-01 (`CLAUDE.md` § Toolchain): no SAT, MILP, finders, `Θ` relation trees, quotient
searches or sweeps. Exact arithmetic that checks a derived claim is fine (S0B's heteroclinic checks are the model). Keep a **"would
have searched here" log** in your record: one line per move you would have made by search, and what you did instead.

**Records.** `plans/FS89-S1D-derivation.md`: C0 predictions before any derivation (a probability for each question's answer), one
section per question, the log, and a heading **"Theorems this phase proved"** (one line per theorem, grade, address). Working files stay
in your scratch directory until a claim is saved. Tools `tools/fs89_s1d_*.py` (you may import `tools/fs89_s0b_*.py`; never edit them or
any frozen tool: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`,
`tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`, `data/fs73/coxeter-c3/certcheck.py`).

**Blindness.** The verifier must not see your routes. Commit subjects stay neutral ("FS-89 S1D: record, section n"): the harness shows
every agent the last five commit subjects. Send each saved claim to me as a statement; I forward it verbatim. Don't open the verifier's
record (`plans/FS89-S1V-verification.md`) until I tell you its verdict on your claim is committed.

**Work in stages**: keep each response short and save your record after every section. At FS-86 an agent lost three responses to the
output-token limit, and a lost response is unrecoverable.

**No subagents.** Do not use the Agent tool, a fork, a workflow or anything that starts another agent. Staffing is Kooshi's budget
decision (three agents at most, and two are running), and I can only review work I know about. If the work outgrows your context,
stop at a clean boundary, save, and tell me what is left — that is a good report.

**Resources and commits.** Any job over about 2 GiB or 2 minutes runs under `scripts/slot.py`; /tmp is RAM. Never run `lake build`.
Commit by explicit path after `git diff -- <path>`; never amend; don't push; report each commit's hash. End commit messages with the
attribution lines your harness supplies.

**Reports** go to me by SendMessage (`to: "main"`) at each saved claim and at hand-back (claims at exact scope and grade, commit hashes,
tokens used, anything for the close inventory). Keep your turn's final text content-free: "D idle; report sent to the owner by
SendMessage". Thank you.
