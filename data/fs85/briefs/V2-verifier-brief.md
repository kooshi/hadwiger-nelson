Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). For this task you are **the second blind verifier of FS-85**; call yourself **"verifier 2"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, and why blind

**`LEDGER.md` row 78 holds that every four-colouring of de Grey's lattice is `8Λ`-periodic (`F = P = 8Λ`, 9,120 colourings).** Until this week that rested on a 2,044-point solver refusal (a 56.5 MB LRAT).
- Today three agents, building on each other, derived it from one published input: Parts's human-checkable case analysis. No certificate of ours is used.
- If it holds, it is the milestone's main result. It is also an answer to a question posed on Polymath16 in 2018: "Is Tamas's result that every 4-coloring … is 8-periodic human-provable?"
- **The chain has been checked in pieces, but no one has derived it whole, independently.** Your job is to be that second, independent derivation: derive the statements below yourself, write your verdicts, and only then read the agents' proofs and compare.
- A gap or a refutation is as valuable as a confirmation. Treat "proved" as a claim you must earn.

## What you must not open until every C1 verdict is written

Please don't open any of these, including through `git show`, `git log -p` or a grep that prints their contents:
- `plans/FS85-C-Coxeter.md`, `plans/FS85-C-deBruijn.md`, `plans/FS85-R3-five-part.md`, `plans/FS85-V-verification.md`;
- `plans/POROS-2026-09-24-fs85-*.md`, `plans/FS85-close-inventory.md`, `plans/FS85-input-audit.md`;
- `data/fs85/` except `data/fs85/briefs/V2-verifier-brief.md` (this file) and `data/fs85/audit/trees/` (Parts's trees, transcribed);
- `git log` messages or diffs from this week (from commit 202bc890 on). Your start-up context may show recent commit subjects; if any describes a route, note that in your record and derive your own anyway.

**The reason:** the value of your derivation is its independence. Anything read from the existing derivations before your own is written turns a second attempt into a check of one answer. The statements below already reveal the outline (spectra, characters, chirality at the primes above 2); that is unavoidable and fine.

## Read first, from disk

1. `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`, from disk. Especially:
   - § Notation;
   - G54, G68, G69, G70, G71, G73;
   - G21 and G30 (the method rules for a result you would like to be true).
2. `LEDGER.md` row 78; `plans/FS73-derivation.md` T4–T7.
3. `plans/FS85-rigidity-without-triangles.md` §0, §M and §R-review.
4. `plans/MASCOT-derivation.md` T6–T11.
5. `[Parts2020hv]`, `~/source/library/pdf/arXiv-2010.12661-parts-human-verifiable.pdf`, §§1–4. The input below comes from it.

## The objects

- `E = ℚ(√−3, √−11)`, `O_E = ℤ[ζ₆, w]`, `w = (1+√−11)/2`.
- **De Grey's lattice** `Λ = (1/9)O_E`, `U = {ζ₆^a η^b : 0 ≤ a < 6, |b| ≤ 4}` (54 unit vectors), `η = (√33 + i√3)/6`.
- **Families** `k = −4..4`: the six vectors `ζ₆^j η^k`, a hexagon.
- `Λ_K = ⟨U_K⟩` for a set `K` of families; `Λ₅ := Λ_{|k|≤2}` and `Λ₇ := Λ_{|k|≤3}`.
- `2` splits in `E` into two conjugation-stable primes. `β = (5+√33)/2`; define `P_± = (1/9)β^{±3}O_E` (check that these are what the statements need).
- A proper four-colouring `c` of a graph `Cay(Λ, S)`, and its **tetrahedron embedding**: `g(x) = v_{c(x)} ∈ ℝ³`, where `v₁..v₄` are the vertices of a regular tetrahedron centred at 0.
- **NT_k:** for every colouring and every `x`, no alternate triple `x + ζ₆^{j}η^k, x + ζ₆^{j+2}η^k, x + ζ₆^{j+4}η^k` is monochromatic.
- `Θ_K = {θ ∈ Hom(Λ, ℝ/ℤ) : ∀k ∈ K ∃ j ∈ {0,1,2}: θ(ζ₆^j η^k) = 1/2}`; `P(Θ) = ⋂_{θ∈Θ} ker θ`.
- **Pair-linear:** with colours identified with `𝔽₂²`, the colouring's first coordinate (the pair it wears) is a group homomorphism `Λ → 𝔽₂`.

## The input taken as given (prior art)

**(S′) NT_k for `|k| ≤ 2`**, for every proper four-colouring of `Cay(Λ, U_{|k|≤2})`.
- This is Parts's "no monochromatic √3-triple": his 481-vertex graph G481, whose 30 edge vectors are exactly `μ₆·η^{−2..2}`, sits inside `Λ` in these five orientations, and his case-analysis trees refute a monochromatic triple at its centre.
- The trees were transcribed and walked as a fixed certificate today (`data/fs85/audit/trees/`); you may read them.
- **Where does (S′) fail on the loose controls?** Take `ℤ[ζ₆]` alone at four colours, and FS-73's loose lattices (`data/fs73/table/TABLE.md`). Say so, so the theorem does not prove too much.

## The statements

- **W1 (the spectral lemma).**
  - (a) With `A_k g(x) = Σ_{j=0}^{5} g(x + ζ₆^jη^k)`: NT_k at every point ⟺ `A_k g = −2g`.
  - (b) If `A_k g = −2g` for every `k ∈ K`, then `supp ĝ ⊆ Θ_K`.
  - (c) If `Θ_K` is finite, `c` is periodic under `P(Θ_K)`.
  - **Prove (c)'s analytic step as a stand-alone lemma:** a bounded function on `ℤ^r` whose Fourier transform, a periodic distribution, has finite support is a finite sum of characters.
- **W2 (exact).** `|Θ_all| = 42` and `P(Θ_all) = 8Λ`; `|Θ_{|k|≤2}| = 7290` and `P(Θ_{|k|≤2}) = 120Λ`. Re-check these exactly, by your own code, from the definition.
- **W3 (the 5-part lemma, stronger form).** Given (S′): every proper four-colouring of `Cay(Λ, U_{|k|≤2})` is, on each component `y + Λ₅`, a function of `x mod P_ε` for one `ε ∈ {+, −}`, so `8Λ₅`-periodic. Hence every proper four-colouring of `Cay(Λ, U)` is `24Λ`-periodic.
- **W4 (the alternate-triple lemma).** If a colouring's spectrum lies in `Θ_all + Ann(Λ_K)` with `[Λ : Λ_K]` odd, then NT_k holds for every family `k` whose even alternate triple and odd alternate triple each lie in one coset of `Λ_K`. Hence, given W3: NT_{±3} (via `Λ₅`) and NT_{±4} (via `Λ₇`).
- **W5 (the collapse).** NT for all nine families implies all of the following:
  - every colouring is `8Λ`-periodic;
  - it is local at one prime above 2, with one chirality throughout;
  - it is pair-linear;
  - `Cay(Λ/8Λ, U)` has exactly 9,120 proper four-colourings.
- **W (the theorem).** Given (S′): every proper four-colouring of `Cay(Λ, U)` is `8Λ`-periodic, `F = P = 8Λ`, and there are 9,120 colourings of the quotient.

## The tasks

- **C0 (before deriving anything).** Write your predicted verdict for each of W1, W3, W4, W5 and W at the top of your record, with a probability.
- **C1 (blind).** Prove or refute each statement, in your own words, at the standard a referee would accept: **proved**; **gap**, with the missing step named; or **refuted**, with a counterexample.
  - Save your record after each verdict.
  - **Do W3 before anything else is read.** It is the newest and least-checked step.
  - One adversarial attempt: try to build a tetrahedron-valued function on `Λ/40Λ` with spectrum in the 90 order-dividing-10 characters of `Θ_{|k|≤2}` that is proper on the five-family graph and **not** `24Λ`-periodic. Show that it fails for the reason your proof names. Build it by formula, never by search.
- **C2 (compare, after every C1 verdict is written).** Now open everything listed above. Compare line by line with `plans/FS85-R3-five-part.md` §1 (W3) and with `plans/FS85-C-Coxeter.md` R2.1–R2.4 and R2.9–R2.12 (W1, W2, W4, W5). List every divergence, and resolve or escalate each. Where you took a different route, keep both.
- **C3 (scope).**
  - The controls: where (S′) fails.
  - Does W still need anything of row 78's certificate? It should not.
  - Say whether W answers the 2018 question as posed. Its words were "every 4-coloring of ℤ[ω₁,ω₃]", which is a larger ring than `Λ`. Forcing is monotone upward, so be exact about which graph the theorem covers.
- **C4 (filing).** Write derivation-file entries in the format of `plans/FS79-derivation.md`: statement, grade, the proof's address, what rests on it, prior art, and a kernel decision (kernel / stub / declined with the reason). Give your record a heading **"Theorems this phase proved"**.

## The stall criterion (tell me at once if any holds)

1. C1 names a gap in any statement that you cannot close within about 150k tokens.
2. Your C2 verdict contradicts an agent's on any statement, and the comparison doesn't settle it.
3. C1 passes 220k tokens without a written verdict on every statement.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about. An independent verification done partly by an agent I don't know about is not one I can score.
  - If the work outgrows your context, stop at a written verdict and tell me what is left.
- **The finite-witness-free week, to 2026-10-01.** No SAT, colouring enumeration, finder or sweep. `Λ/40Λ` is finite, so "just colour it" is always one command away, and it is out. Exact computer algebra checking a derived claim is in: spectra, Smith forms, character sets, patterns whose shape a derivation fixed. Keep a **"would have searched here" log**.
- **Your record:** `plans/FS85-V2-verification.md`, committed after each verdict. Tools under `data/fs85/v2/`. Plant a fault in every checker and confirm it fires.
- **Commits:** by explicit path. Run `git diff --cached` and confirm every hunk is yours; another agent commits concurrently. Never amend. End each message with the attribution lines your harness supplies. **Keep your commit subjects neutral until C1 is written** (no route in them). Don't push; I push. Report each hash.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. Never run `lake build`.
- **Budget:** about 350k tokens. Past about 500k, I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`. Keep your turn's final text content-free ("verifier 2 idle; report sent to the owner by SendMessage").
- **Report points:** after C0; after each C1 verdict (one line each); after C2; at the end. Carry your token count each time.
- **State every result at its exact scope and grade.** "Proved given (S′)" is the grade the chain can reach.

Thank you. This is the check the milestone's headline stands on.
