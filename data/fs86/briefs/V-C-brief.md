Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). For this task you are **a blind verifier during FS-86's competition**; call yourself **"verifier C"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, why blind, why quietly

FS-86 asks whether four-colour rigidity can exist in a plane with no unit triangles, over ℚ(√59) (and ℚ(√83), ℚ(√131)).
- **Where it stands.** The frame is verified (`plans/FS86-dyadic-rigidity.md` §0.3; `plans/FS86-B1-verification.md`). At the field level the question is binary: is every four-colouring of `Cay(R, U_F)` periodic, equivalently a pullback from row 67's `P₄`?
- **The competition.** One competitor side has proved the theorems below, each one mind's hand proof. They are candidates for the milestone's filed results, and the protocol (rule 11) says verification is where contest begins.
- **Your job.** Derive them yourself, write your verdicts, and only then read the competitor's proofs and compare.
- **A gap or a refutation is exactly as valuable as a confirmation.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*

**Quietly.** The competition formally runs to 2026-09-29, and these statements are one side's progress. So everything you write stays in your scratch directory, you commit nothing, and you message nobody but me.

## What you must not open

**Never, during this task:**
- the other side's directory, `…/scratchpad/fs86-comp-debruijn/`;
- the advisor's directory, `…/scratchpad/fs86-poros-comp/`;
- the other verifiers' directories;
- `plans/FS86-close-inventory.md`;
- `git log`;
- `~/source/lean-dir-owner/`.

**Not until every C1 verdict is saved:** the competitor side's working file `…/scratchpad/fs86-comp-coxeter/` (its main `.md` file and `SUCCESSOR-PREAMBLE.md`). Its tools may be run after C1 too.

**Open to you:** the library, `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md`, every derivation file, the plan, B1's record, and `data/fs86/`.

## Read first, from disk

1. `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Especially:
   - § Notation;
   - G54, G55, G59, G60, G66, G68, G71, G73, G74, G75;
   - G21 and G30.
2. `LEDGER.md` rows 66, 67, 75, 82, 85, 87; `plans/FS38-derivation.md` L2, L3, D2-A, D2-B.
   - FS38-L1's tightness half is defective. The full tower's tightness stands by exact computation at levels 1–8 and D2-B's induction.
3. `plans/FS86-dyadic-rigidity.md` §0, §IQ, §S.4, §R-review; `plans/FS86-B1-verification.md`.
4. `[AmbrusEtAl2023]` (held in the library; `BIBLIOGRAPHY.md` gives the file) and `[Zhang2012]` (held).

## The objects

- **Fields.** `F` real, with `U_F` its unit vectors and `R = ℤ[U_F]`.
- **The class S2.** One stable place tight at four colours at every level, and every other stable place with independence ratio below 1/4 at every level. ℚ(√59), ℚ(√83) and ℚ(√131) are in it by V3.
- **The dyadic tower.** Row 67's `P_m = Cay(O/𝔓^m, T mod 𝔓^m)`, with `O = ℤ₂[ω][√3]` and `𝔓² = (2)`.
- **Θ₄(A).** For an abelian group `A` spanned by unit vectors, the characters `θ : A → ℝ/ℤ` with `θ(u) ∈ [1/4, 3/4]` for every unit vector `u`. A point of Θ₄ four-colours by `⌊4θ⌋`.

## The statements (the competitor's, as stated; the proofs are yours)

- **VC-14 (the window no-go, class S2).** For every S2 field, and every finite set `S` of places containing the tight place `𝔓`, consider the local unit-distance graph `Γ_S = Cay(G_S, T_S)`. Here `G_S` is the product of the completions (or finite levels) at `S`, and the places may be archimedean, odd stable at full level, split at full level, or `𝔓` at any finite level `m`. The claim:
  - every proper four-colouring `W` of `Γ_S` with **measurable** colour classes equals, pointwise on each of finitely many cosets, a pullback of a proper four-colouring of `P_m`;
  - hence every plane colouring `r ↦ W(ι_S(r) + t)` of `F²` is periodic and local at `𝔓`.

  Its stated inputs are `[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`), V3's all-levels bounds, row 67, and `[Zhang2012]` Prop. 1.7. It is stated to fail at ℚ(√11) and at K, exactly at the hypothesis each violates. **The step the author most wants checked:** a measurable transplant of Zhang's MIS-normality count (inner regularity, analytic sets, Fubini on windows), and then the choice of a good point in every coset. **Second:** the split-place factor's ratio tends to 0 on growing compact windows, by Hoffman plus a Kloosterman count.
- **VC-12.1 (unramified quadratic dyadic towers).** Let `E/ℚ₂` be finite with residue field `𝔽₂`, and `E(i)/E` unramified quadratic. Consider the norm-one tower `P_m(E) = Cay(O_{E(i)}/𝔓^m, T mod 𝔓^m)`. The claim:
  - (i) the level maps are 2-to-1;
  - (ii) FS38-L2 holds verbatim;
  - (iii) `M ⊇ 𝔓^c` for some finite `c`, where `M` is the ℤ₂-span of `{t − 1 : t ∈ T, t ≡ 1 mod 𝔓}`;
  - so the tower is four-tight at every level iff it is four-tight at levels `≤ c`. FS38-L1 is not used.
- **VC-13.0.** In such a tower, `√−3` is congruent to a norm-one unit mod `𝔓^m` exactly for `m ≤ e(E/ℚ₂)`. The stated reason: `N(1+2ω) = 3`, and `N(1 + 𝔓^m) = 1 + 𝔭^m` in an unramified extension.
- **VC-10 (finite-type characters, class S2).** Every point of `Θ₄(F)` that is torsion plus archimedean plus components at finitely many non-stable places is a torsion character of the tight tower.
  - **Notice:** the other side independently proved a close analogue. Two derivations exist, so your check here is a third, and lower priority.

## The tasks

- **C0 (before deriving anything).** Save your predicted verdict for each statement, with a probability, at the top of your record.
- **C1 (blind).** Prove or refute each, in your own words: **proved**; **gap**, with the missing step named; or **refuted**, with a counterexample.
  - **VC-14 first.** It is the side's main result.
  - Save after every verdict.
  - One adversarial attempt per statement, by formula, never by search.
- **C2 (compare, after every C1 verdict is saved).** Open the competitor side's working file (its "Round 2" sections, steps 2–6, and "Theorems this phase proved"). Compare line by line and list every divergence of truth, scope or route.
- **C3 (scope).** Does VC-14 need `F` real? Does it hold for the measurable-window colourings of ℚ(√2,√3) (S2 with triangles)? For VC-14 at K, say exactly why it gives "one of two dyadic places" rather than a contradiction.
- **C4.** Give your record a heading **"Theorems this phase proved"**: each theorem one line, with grade and where its proof lives.

## The stall criterion (tell me at once)

- A gap in the first statement that you cannot close within about 120k tokens.
- C1 passes 250k tokens without a verdict on every statement.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at once), and I can only review work I know about.
  - If the work outgrows your context, stop at a saved verdict and tell me what is left.
- **The finite-witness-free week, to 2026-10-01.**
  - Out: no SAT, colouring enumeration, finder or sweep. Every finite quotient here is one command from a colouring enumeration or a Θ relation tree, and both are out; in particular, don't run the certificate computation any statement names.
  - In: exact computer algebra checking a derived claim, such as a spectrum, a membership, or a digraph's degree under a colouring given by formula.
  - Keep a **"would have searched here" log**.
- **Work in stages.** Keep each response short and save your record after every step. A response lost to the output-token limit is unrecoverable, and it happened to an agent earlier in this milestone.
- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-v-c/VERIFIER-C.md`. Tools go in the same directory. **Commit nothing.** Plant a fault in any checker and confirm it fires.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. Never run `lake build`.
- **Frozen tools are never edited:**
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **Budget:** about 350k tokens. Past about 500k, I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`, and nobody else. End every turn with exactly "verifier C idle; report sent to the owner by SendMessage".
- **Report points:**
  - after C0;
  - after the first statement's verdict;
  - after all of C1;
  - at the end.

  Carry your token count each time.

Thank you.
