Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to be **the verifier of milestone FS-81, stage C**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, and why blind

Early today the FS-81 planner found an argument that would prove **χ(ℚ(√d)²) ≥ 4 for every squarefree d ≡ 11 (mod 12)**, and more generally χ(F²) ≥ 4 for every subfield F ⊆ ℝ whose unit-vector ring contains 1/3 and whose plane is not bipartite.
- If it holds, it settles the census conjecture T4 (`CLAUDE.md` G61) for every real quadratic field that can need four colours, with no witness search. It is also an answer to questions posed in print.
- One mind produced it. An advisor attacked five named points and found no break, and I checked one step. **That is not two independent derivations**, and this project's rule is that a result the team likes gets audited at the same rate as one it does not (G21), while two independent attempts license a claim (G51).
- **Your job is to be the second, independent attempt.** You derive the lemmas yourself from their statements, write and commit your verdicts, and only then read the planner's proofs and compare.
- A gap or a refutation is as valuable a result as a confirmation. Please treat "proved" as a claim you must earn, not a box to tick.

## Read first, from disk

1. `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot. Especially read:
   - § Notation;
   - G55 (the unit-vector ring, prime inversion, the two- and three-colour classifications);
   - G61; G62 (lattices as multilayers); G71 (the three-colour criterion);
   - G21 and G30 (the method rules for a result you would like to be true).
2. **The statements you are verifying:** `plans/FS81-quadratic-four-colours.md`, **only §0, §IQ items 1–2, and §F** (the notation, L1–L4, F-T4, §F.5, the inhabitants and non-examples).
3. **The material the statements rest on:**
   - `plans/FS73-derivation.md` T21, T22, T40, T41, T42;
   - the FS-73 records behind T40: `data/fs73/records/phase-P3b-q167-theta.md` §3 and `data/fs73/records/verify-P3b-q167.md` §7;
   - `LEDGER.md` rows 72, 73, 74, 79, and its § B lines for ASTRA-2026-09-14;
   - `[Fischer1990]` (held: `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`; its §1, Thms 8–10, Example 4).

## What you must not open until your C1 verdicts are committed

Please don't open any of these, **including through `git show` or `git log -p`**, until every C1 verdict is committed:
- **`plans/FS81-F-sketch.md`**, the planner's proofs;
- **`plans/POROS-2026-09-24-fs81-plan.md`**, the advisor's record;
- **`plans/FS81-close-inventory.md`**, which summarises the argument and my check of it;
- **every other section of `plans/FS81-quadratic-four-colours.md`** (§G, §PA, §IQ items 3–5, §S, §P, §M, §X, §R-review), because they discuss the route;
- **`data/fs81/`** (phase 0's records, which measure the argument's finite shadows);
- the owner's scratch, and `~/source/lean-dir-owner/`.

The reason: the value of your derivation is its independence. Anything read from the first derivation before your own is written turns a second attempt into a check of one answer. The statements themselves already reveal the route's outline (layers, a classification of the rational pattern, a gluing relation); that is unavoidable and fine. After C1 is committed, everything above is open to you.

## The tasks

**C0 (before deriving anything). Write your predicted verdict for each of L1, L2, L3, L4, F-T4 and §F.5** (proved, gap or refuted, with a probability) at the top of your record, and commit it. "Proved" is informative only if predicted and written before the sketch is opened.

**C1 (blind).** Prove or refute L1, L2, L3, L4 and F-T4, each independently. For each, write the verdict as one of:
- **proved**, with the proof, in your own words, at the standard a referee would accept;
- **gap**, with the missing step named exactly;
- **refuted**, with a counterexample.

Commit `plans/FS81-C-verification.md` §1 after each lemma. Six instructions shape this work, and the advisor's advice is folded into them:
1. **State the objects exactly before proving anything:**
   - `R_F = ℤ[U_F]`, the additive span of the unit vectors. Is it a ring? Is it exactly the component of 0 in F²'s unit-distance graph? Prove both or find what fails.
   - Characters `R_F → ℝ/ℤ`, with the closed band `[1/3, 2/3]`.
   - `R₅ = ℤ[i][1/5]`, `w = (3+4i)/5`, `U₅ = {iᵏwᵐ}` (all k, m ∈ ℤ), the parity character θ₂ and the archimedean characters λ_e.
2. **L1 by compactness, with no finite-generation assumption.** `R_F` is not finitely generated. Index the compactness by **finite symmetric subsets of `U_F`**. Say exactly which form of the three-colour criterion's ⟹ direction you use: FS73-T22 on the lattice a finite set spans, or T42's forward lift, where the set need not generate its lattice. Check that the form you cite actually covers a finite set of unit vectors with many relations among them.
3. **L2: re-derive T40's cell list on a second code path.** Write your own exact arrangement code in exact rationals, not `tools/fs73v2_thetaR.py`, and not the planner's or the advisor's. The cell list is `Θ_R = c0 + (D0 ∪ F4) + 5ℤ²` on the characters of `(1/5)ℤ[i]` constrained by the 12 rational unit vectors of denominator 5.
   - Plant a fault in your code (a dropped direction, or a wrong band endpoint) and confirm your code reports a different arrangement. A check not seen to fail is not known to work.
   - Then prove L2 from the cell list.
   - **Name exactly the step that uses infinitely many layers `wᵐ` and infinitely many denominators `5^{−j}`.** That is where a gap would hide.
4. **The finite-lattice trap, both ways.** On the finite lattice `(1/5)ℤ[i]`, the parity character is itself archimedean (it is `c0 = (5/2, 5/2)`), and archimedean characters of finite order exist there. So checking L4 on a finite lattice will show apparent counterexamples that are *not* refutations of the field-level statement. The converse trap: an argument that silently uses finite-level facts at the field level. Keep the two levels apart in every sentence.
5. **L4 in general form before the special case.** Given `1 = Σ c_j u_j` with `u_j ∈ U_F`, which conditions on the `c_j` kill each layer type? Derive the conditions yourself. If your route needs different conditions from the statement's (every `c_j ≡ 0 mod 3`, `Σ c_j` even), that is worth recording, not correcting towards the statement. Then specialise to the type-M relation `1 = n(2 − v − v̄)`, with `v = ((2n−1) + i√d)/(2n)` and `n = (d+1)/4`, and check `n ≡ 0 (mod 3)` exactly at d ≡ 11 (mod 12).
6. **One adversarial attempt.** Try to build a three-colouring character of ℚ(√d)² for some d ≡ 3 (mod 4) that has a parity-type layer. Check that it fails, and that it fails **for the reason the proof names**. A failure for a different reason is a finding. Do the same at d ≡ 3 or 7 (mod 12), where three colours exist: the characters that survive there must be exactly what §F.5 says.

**C2 (compare, after C1 is committed).** Read `plans/FS81-F-sketch.md` and the advisor's record, and compare them with yours line by line. List every divergence, and resolve or escalate each in §2. Where you and the sketch took different routes, keep both.

**C3 (scope).**
- **The general form's hypotheses**, each shown necessary on an example:
  - the inhabitant ℚ(√11), whose conclusion is the kernel's `four_le_chromaticNumber_planeOver_eleven`;
  - the new instance ℚ(√2,√7);
  - the non-examples ℚ(√3), ℚ(√7), ℚ(√7,√10) and ℚ(√2).
  - For each example, establish 1/3 ∈ ℤ[U] by an explicit relation or by prime inversion (G55), and bipartiteness or its failure by an odd relation.
- **§F.5**, the classification at d ≡ 3, 7 (mod 12), checked against `[Fischer1990]` Thm 9's colourings.
- **The contrapositive**, "χ(F²) = 3 ⟹ some conjugation-stable prime of F(i) lies above 3", for every real F, stated against G55's two- and three-colour classifications (ASTRA-T3, T4).

**C4 (finite witnesses).** Give a finite-level version of L2–L4: for each d, the least K(d) with `Θ₃(V(d, K)) = ∅`, where `V(d, K) = span({vᵏ : |k| ≤ 2}·U^(5^K))`, as a function of n = (d+1)/4.
- The planner's crude estimate is 5^K ≳ 2n; the advisor expects K(d) to grow with d.
- Phase 0's data (`data/fs81/phase0/`) is open to you once C1 is committed.
- **A nonempty `Θ₃` at a finite K is not a refutation of F-T4: it measures K.** State every C4 result that way.
- The product is a finite certificate family for every d, which is the kernel's shape.

**C5 (filing).** Write the derivation-file entries for everything you proved: statement, grade, the proof's address, what rests on it, prior art, and a kernel decision (kernel / stub / declined with the reason). Use the format of `plans/FS79-derivation.md`. Your record carries a heading **"Theorems this phase proved"**.

## The stall criterion (the plan's; if any holds, tell me at once)

1. C1 names a gap in L1–L4 you cannot close within C1's budget (~150k tokens).
2. Your verdict contradicts the sketch on any lemma, and one exchange does not settle it.
3. Your second-code-path cell list disagrees with T40.
4. C1 passes 200k tokens without a written verdict on every lemma.

On a stall I bring in a second mind on the disputed lemma only (G51). Nothing is written into `CLAUDE.md` or `LEDGER.md` until stage C closes, so a retraction stays free. Please make it freely if you need to.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about. An independent verification done partly by an agent I don't know about is not one I can score.
  - If the work outgrows your context, stop at a clean boundary (a committed lemma), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: about 300k tokens**: C1 about 150k, C2 about 50k, C3–C5 about 100k. Past about 500k, Kooshi's rule is that I replace rather than reuse an agent. Your record, committed after each lemma, is what a successor would resume from.
- **Heavy jobs.** Your cell computation should take seconds and runs without the lock. Anything over ~2 minutes or ~8 GB takes the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`. Check the exit status, because an expired wait runs nothing. Phase 0 holds the lock at times. Never run `lake build`.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours; phase 0 and the modeling agent commit concurrently.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Write your own code under `tools/fs81_verify_*.py`.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-verifier/`. Please don't list or read the other agents' directories beside it.
- **The close inventory is mine to write.** Send me by message anything the close must not lose: a verdict, a correction owed, an error of anyone's, a stub candidate.
- **State every result at its exact scope and grade.** "Proved at the field level" and "checked on a finite lattice" are different sentences.
- Don't edit `CLAUDE.md`, `LEDGER.md` or `plans/FRONTIER-STUBS.md`; propose edits in your report. **The plan file is not yours**; the modeling agent is editing its phase sections meanwhile.
- **To reach me:** SendMessage with `to: "main"`. Your turn's final text is delivered to whichever agent last woke you, so keep it content-free ("verifier idle; report sent to the owner by SendMessage") and send every report by SendMessage.
- **Report at these points:**
  - after C0's predictions;
  - after each C1 verdict (one line each);
  - after C2;
  - at the end.

  Each report carries the commits (exact hashes) and your approximate token usage.

## What I'll check at the end (the acceptance, up front)

1. C0's predictions committed before any derivation.
2. Each of L1–L4 and F-T4: a proof in your own words committed before C2, or a named gap with the stall criterion applied.
3. T40's cell list from your own exact code, with a planted fault seen to fire.
4. L1's inverse limit written for a non-finitely-generated ring, indexed by finite symmetric subsets, the cited form of the criterion named.
5. The step using infinitely many layers and denominators named.
6. The adversarial attempt, and the C3 scope checks with each hypothesis shown necessary on an example.
7. C2's divergence list, each resolved or escalated.
8. C4's results stated as measurements of K, never as refutations.
9. The record `plans/FS81-C-verification.md` with "Theorems this phase proved", and the derivation-file entries.

Thank you. This is the most consequential check the milestone has.
