Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). For this task you are **a blind verifier during FS-86's competition**; call yourself **"verifier W"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, and why blind, and why quietly

FS-86 asks whether four-colour rigidity can exist in a plane with no unit triangles: over ℚ(√59), and ℚ(√83), ℚ(√131).
- **Where it stands.** The plan's frame is verified: `plans/FS86-dyadic-rigidity.md` §0.3, confirmed blind in `plans/FS86-B1-verification.md`. At the field level the question is binary: is `F(R) = 0` or `R ∩ 𝔓⁴`?
- **The competition.** Two competitors are working on it. One of them has derived several theorems that re-frame the question locally, at the prime 2, and has paused.
- **Why now.** The protocol's rule 11 says verification is where contest begins. So those theorems get an independent derivation now, while the competition continues.
- **Your job.** Derive the statements below yourself, write your verdicts, and only then read the competitor's proofs and compare.
- **A gap or a refutation is exactly as valuable as a confirmation.** Kooshi, 2026-09-24: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* Treat "proved" as a claim you must earn.

**Quietly, because a competition is running.** These statements are one competitor's progress, and the other competitor must not learn of them from you. So:
- everything you write stays in your scratch directory;
- you commit nothing;
- you message nobody but me.

## What you must not open

**Never, during this task:**
- the other competitor's directory, `…/scratchpad/fs86-comp-coxeter/`;
- the advisor's directory, `…/scratchpad/fs86-poros-comp/`;
- `plans/FS86-close-inventory.md`;
- `git log`;
- `~/source/lean-dir-owner/`;
- any other scratch directory but your own.

**Not until every C1 verdict is written and saved:** the competitor's working file, `…/scratchpad/fs86-comp-debruijn/FS86-C-deBruijn.md`. Also not that directory's `SUCCESSOR-PREAMBLE.md` (it holds route sketches).

Prior art is open to you: the library, `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md`, every derivation file, and the plan, its frame and B1's record.

## Read first, from disk

1. `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Especially:
   - § Notation;
   - G54, G55, G60, G66, G68, G71, G73, G75;
   - G21 and G30, the method rules for a result you would like to be true.
2. `LEDGER.md` rows 67, 75, 78, 85, 87; `plans/FS38-derivation.md` L2, L3, D2-A, D2-B.
   - **FS38-L1's tightness half is defective** (a wrong-direction step; the close inventory records it). The full tower's tightness stands by exact computation at levels 1–8 and by D2-B's induction.
3. `plans/FS86-dyadic-rigidity.md` §0, §IQ, §S.4 and §R-review; `plans/FS86-B1-verification.md`, which holds VK, the K classification, proved.

## The objects

- **The local field.** `L = ℚ₂(√3)(i) = ℚ₂(ζ₁₂)` with its conjugation; `O` its integers; `𝔓` its prime, with `𝔓² = (2)`.
- **The local unit circle.** `T = {t ∈ L : t t̄ = 1} ⊂ O^×`, compact.
- **The local plane.** `𝒫 = Cay(L, T)`, which is the unit-distance graph on `ℚ₂(√3)²`.
- **Row 67's tower.** `P_m = Cay(O/𝔓^m, T mod 𝔓^m)`.
- **The global objects.** For `F ⊂ ℚ₂(√3)`: `U_F` its unit vectors and `R = ℤ[U_F]`. For ℚ(√59), `R` is dense in `O` and `U_F` is dense in `T`, by weak approximation.
- **K** = ℚ(√3,√11) embeds in `ℚ₂(√3)`, because `33 ≡ 1 (mod 8)`.

## The statements (the competitor's, as stated; the proofs are yours)

- **W-A (local rigidity).** Every proper four-colouring of `𝒫`, arbitrary (no measurability or continuity assumed), is on each coset of `O` the pullback along `O → O/𝔓⁴` of a four-colouring of `P₄`. Equivalently, its forced group is exactly `𝔓⁴`. It is stated as resting on VK, the K classification, proved in B1's record.
- **W-A1 (the extension form).** For `F = ℚ(√59)`: `F(R) ≠ 0` if and only if every four-colouring of `Cay(R, U_F)` extends, per `R`-coset, to a four-colouring of `Cay(O, T)` along `R ⊂ O`.
- **W-B (continuous implies pullback).** If a four-colouring `c` of `Cay(R, U_F)` is 2-adically locally constant at every point, then `c` is a `P₄`-pullback. Locally constant means each `z ∈ R` has `N_z` with `c` constant on `R ∩ (z + 𝔓^{N_z})`.
  - **The step to scrutinise:** extending `c` to a locally constant `G` on an open dense `U ⊂ O`. Check that `G` properly colours `𝒫` restricted to `U`, and that the finite forcers of every `δ ∈ 𝔓⁴` can be translated into `U`.
- **W-C0 (the Bessel obstruction).** On any real field plane, the unit-distance pair correlations of a stationary random four-colouring are consistent with a purely archimedean spectrum. The data is `Σ̂(u) = E[g(0)·g(u)] = −1/3` for every unit `u`, where `g` is the tetrahedral field. The spectrum is uniform on the characters `z ↦ e(Re(ᾱσ₁z))` with `|α| = r₀` and `J₀(2πr₀) = −1/3`, which exists since `min J₀ = −0.40276`. So pair correlations alone can never pin the spectrum on a real field.
- **W-D₀ (no threshold walls).**
  - **The construction.** Take two four-colourings `γ₁ ≠ γ₂` of `P_N` (`N ≥ 4`), an additive `h : R → ℝ`, and a threshold `ε` on a finite quotient `Q` of `R` refining `O/𝔓^N`. Colour `c(z) = γ₁(π_N z)` if `h(z) < ε(z mod Q)`, and `γ₂(π_N z)` otherwise.
  - **The claim.** On ℚ(√59), or any real `F ⊂ ℚ₂(√3)` with the same dyadic tower, `c` is proper only if `γ₁ = γ₂`.

## The tasks

- **C0 (before deriving anything).** Save, at the top of your record, your predicted verdict for each of W-A, W-A1, W-B, W-C0, W-D₀, with a probability.
- **C1 (blind).** Prove or refute each statement in your own words, at the standard a referee would accept: **proved**; **gap**, with the missing step named; or **refuted**, with a counterexample.
  - **W-A first.** Everything else rests on it.
  - Save your record after each verdict.
  - One adversarial attempt per statement, by formula, never by search. For W-A, try to write down a four-colouring of `𝒫` that is not locally a `P₄`-pullback, for instance one reading a finer level on part of `O`, and show where it fails.
- **C2 (compare, after every C1 verdict is saved).** Open the competitor's working file: §1.1–§1.4 for W-A, W-A1, W-B; §4.1 for W-C0; §6.1 for W-D₀. Compare line by line, list every divergence of truth, scope or route, and resolve or escalate each.
- **C3 (scope).** Say exactly what W-A needs from VK (one forced pair at K? the whole classification?), and whether W-A holds for ℚ(√11)'s plane restricted from `𝒫`. That plane has `F = 0` (row 66), so W-A can only be a local statement, and its transfer to a global field must fail there. Name the step that fails.
- **C4 (filing).** Give your record a heading **"Theorems this phase proved"**: each theorem one line, with its grade and where its proof lives.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at once), and I can only review work I know about.
  - If the work outgrows your context, stop at a saved verdict and tell me what is left.
- **The finite-witness-free week, to 2026-10-01.**
  - Out: no SAT, colouring enumeration, finder or sweep.
  - In: exact computer algebra checking a derived claim.
  - Keep a **"would have searched here" log** in your record.
- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-v-w/VERIFIER-W.md`. Tools go in the same directory, which is your scratch directory. **Commit nothing.** I move your record into the repository when the competition ends. Plant a fault in any checker you write and confirm it fires.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. Never run `lake build`.
- **Frozen tools are never edited:**
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **Budget:** about 300k tokens. Past about 500k, I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`, and nobody else. Keep your turn's final text content-free ("verifier W idle; report sent to the owner by SendMessage").
- **Report points:**
  - after C0;
  - after W-A's verdict;
  - after all of C1;
  - at the end, after C2–C4.

  Carry your token count each time.
- **State every result at its exact scope:** the local plane, a global field plane, a coset, or K.

Thank you.
