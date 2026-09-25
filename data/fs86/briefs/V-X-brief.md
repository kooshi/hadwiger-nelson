Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). For this task you are **a blind verifier during FS-86's competition**; call yourself **"verifier X"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, why blind, why quietly

FS-86 asks whether four-colour rigidity can exist in a plane with no unit triangles, over ℚ(√59) (and ℚ(√83), ℚ(√131)).
- **Where it stands.** Its frame is verified (`plans/FS86-dyadic-rigidity.md` §0.3; `plans/FS86-B1-verification.md`). At the field level the question is binary: is every four-colouring of `Cay(R, U_F)` periodic, equivalently a pullback from `P₄`?
- **The competition.** One competitor's side has proved three theorems that rule out whole families of constructions of a non-periodic colouring. They are the milestone's likeliest filed results, and each is one mind's hand proof.
- **Your job.** Derive them yourself, write your verdicts, and only then read the competitor's proofs and compare.
- **A gap or a refutation is exactly as valuable as a confirmation.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*

**Quietly.** These statements are one competitor's progress, and the other competitor must not learn of them from you. So everything you write stays in your scratch directory, you commit nothing, and you message nobody but me.

## What you must not open

**Never, during this task:**
- the other competitor's directory, `…/scratchpad/fs86-comp-coxeter/`;
- the advisor's directory, `…/scratchpad/fs86-poros-comp/`;
- `plans/FS86-close-inventory.md`;
- `git log`;
- `~/source/lean-dir-owner/`;
- any other scratch directory but your own, except as allowed below.

**Not until every C1 verdict is saved:** the competitor's working file `…/scratchpad/fs86-comp-debruijn/FS86-C-deBruijn.md`, and its `SUCCESSOR-PREAMBLE.md`.

**Open to you:** the library, `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEDGER.md`, every derivation file, the plan, B1's record, and `data/fs86/`.

## Read first, from disk

1. `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Especially:
   - § Notation;
   - G54, G55, G66, G68, G71, G73, G75;
   - G21 and G30.
2. `LEDGER.md` rows 66, 67, 87; `plans/FS38-derivation.md` L2, L3, D2-A, D2-B.
   - FS38-L1's tightness half is defective. The full tower's tightness stands by exact computation at levels 1–8 and D2-B's induction.
3. `plans/FS86-dyadic-rigidity.md` §0, §IQ, §S.4, §R-review; `plans/FS86-B1-verification.md`, especially Lemma R: `ℤ[U_F]` is exactly the elements integral at every conjugation-stable prime.

## The objects

- **Fields.** `F` a number field embedded in `ℚ₂(√3)` compatibly with conjugation, so its dyadic tower is row 67's `P_m`, with `O`, `𝔓`, `𝔓² = (2)`.
- **The plane.** `R = ℤ[U_F]`, `π : R → O/𝔓⁴`, and `P₄ = Cay(O/𝔓⁴, T mod 𝔓⁴)`, which has 256 vertices, degree 24, `λ_min = −8`, and is four-tight.
- **V3,** proved for ℚ(√59), ℚ(√83), ℚ(√131): every periodic four-colouring of `Cay(R, U_F)` is a `P₄`-pullback, and pullbacks are gap-free.

## The statements (the competitor's, as stated; the proofs are yours)

- **X-D (two-phase rigidity).** Let `c` be a proper four-colouring of `Cay(R, U_F)`, and `γ₁, γ₂` four-colourings of `P₄`, with `c(z) ∈ {γ₁(πz), γ₂(πz)}` for every `z ∈ R`. Then:
  - `c` is periodic, meaning invariant under a finite-index subgroup of `R`;
  - under V3, `c` is a `P₄`-pullback.

  The boundary between the phases may be arbitrary, including non-measurable. The claim is that the periodicity half holds for every such `F` with no Waring-type lemma.
- **X-D′ (one pullback plus any residue-determined alternative).** Under V3: let `γ₁` be a `P₄`-pullback and `β : O/𝔓⁴ → {four colours}` any function, not necessarily a colouring. If a proper four-colouring `c` has `c(z) ∈ {γ₁(πz), β(πz)}` for every `z`, then `c` is a `P₄`-pullback. X-D is the case `β = γ₂`.
- **X-H (unique continuation from a half-space).** Let `F` be any number field and `R = ℤ[U_F]`. Let `γ` be a gap-free periodic four-colouring of `Cay(R, U_F)` that factors through a finite quotient `π : R → Q`. Let `h : R → ℝ` be additive and non-zero, and `ε : Q → ℝ` any function. If a four-colouring `c` agrees with `γ` on `{z : h(z) ≤ ε(πz)}`, then `c = γ` everywhere.

## The tasks

- **C0 (before deriving anything).** Save your predicted verdict for X-D, X-D′ and X-H at the top of your record, with probabilities.
- **C1 (blind).** Prove or refute each, in your own words: **proved**; **gap**, with the missing step named; or **refuted**, with a counterexample.
  - Save your record after each verdict.
  - **X-D′ first.** It is the strongest claim, and its last step (a gap argument at a transient residue) is the one its author most wants checked.
  - **One adversarial attempt per statement, by formula, never by search.** For example:
    - a two-phase colouring whose disagreement set is a union of residue classes intersected with a non-periodic set;
    - for X-H, a colouring built from a gapped periodic colouring, which must escape. At ℚ(√11) gapped periodic colourings exist (row 66), so X-H's hypothesis "gap-free" must be used; show where.
- **C2 (compare, after every C1 verdict is saved).** Open the competitor's working file §6.2, §6.3, §6.3a and §6.4. Compare line by line, and list every divergence of truth, scope or route.
- **C3 (scope).**
  - Does X-D's periodicity half really hold for every `F` with row 67's tower, K included? K has two dyadic places.
  - What does X-D′ need of V3, exactly?
  - Does X-H need `F` real? Does it hold for non-real `F`?
- **C4.** Give your record a heading **"Theorems this phase proved"**: each theorem one line, with grade and where its proof lives.

## The stall criterion (tell me at once)

- A gap in X-D′ that you cannot close within about 120k tokens.
- C1 passes 250k tokens without a verdict on all three statements.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at once), and I can only review work I know about.
  - If the work outgrows your context, stop at a saved verdict and tell me what is left.
- **The finite-witness-free week, to 2026-10-01.**
  - Out: no SAT, colouring enumeration, finder or sweep. `P₄` has 256 vertices, so "just enumerate its colourings" is one command away, and it is out.
  - In: exact computer algebra checking a derived claim, such as a spectrum, a membership, or a digraph's degree under a colouring given by formula.
  - Keep a **"would have searched here" log**.
- **Work in stages.** Keep each response short and save your record after every step. A response lost to the output-token limit is unrecoverable, and it happened to an agent earlier in this milestone.
- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-v-x/VERIFIER-X.md`. Tools go in the same directory. **Commit nothing.** Plant a fault in any checker and confirm it fires.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. Never run `lake build`.
- **Frozen tools are never edited:**
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **Budget:** about 350k tokens. Past about 500k, I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`, and nobody else. End every turn with exactly "verifier X idle; report sent to the owner by SendMessage".
- **Report points:**
  - after C0;
  - after X-D′'s verdict;
  - after all of C1;
  - at the end.

  Carry your token count each time.

Thank you.
