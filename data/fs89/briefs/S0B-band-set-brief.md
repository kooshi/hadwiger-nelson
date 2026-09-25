Hello de Bruijn. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). I'd like you to run **FS-89's Stage-0 computation**: the exact four-colour band set of the rational unit circle at the prime 5. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the computation and its reading are yours. I'll score them by artifact.

## The question

**Three colours, already done.** FS-81 computed the three-colour band set of the rational pattern exactly (`plans/FS81-derivation.md` T3 = C1(5); FS73-T40's cells):
- `Θ(U₅) = {θ ∈ Hom(ℤ[i][1/5], ℝ/ℤ) : θ(iᵏwᵐ) ∈ [1/3, 2/3]}`;
- this equals `{θ₂ + λ_e : |e| ≤ 1/6} ∪ X₃`;
- so it is torsion plus archimedean, and nothing else.

**Four colours, the question here.** Compute **`Θ₄(U₅) = {θ ∈ Hom(ℤ[i][1/5], ℝ/ℤ) : θ(iᵏwᵐ) ∈ [1/4, 3/4] for all k, m}`** exactly, with `w = (3+4i)/5` or the generator FS-81 used. Is it contained in **torsion plus archimedean** (`T + A`)? Or does it hold points with a non-trivial 5-adic part, which would make it a Cantor-like family?

**Why it matters.** Milestone FS-89 is exploring a route to HD1, the statement that every four-colour band character of a type-(B) field's unit-vector ring is torsion. The route needs such a statement about the rational unit circle. A single prime may or may not suffice. A heuristic count, unverified, says that at four colours one prime probably leaves survivors (about 5·(1/2)² = 1.25 > 1, against 5·(1/3)² ≈ 0.56 at three colours).
- **Both outcomes are results.** If `Θ₄(U₅) ⊆ T + A`, one prime suffices. If not, the survivors are the explicit obstruction, and the route needs many primes at once.
- **How outcomes count** (Kooshi): "All novel knowledge is a success." Don't lean toward either answer.

## Permission and scope

**Kooshi ruled this computation allowed under the finite-witness-free week**: *"that computation is indeed allowed. The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time."* So:
- it is an exact computation of a fixed set, level by level in the 5-adic digits, with a derived shape;
- it must have a **stop rule that can fire**, and it must checkpoint;
- no SAT, no colouring finder, no survivor sweep over fields.

## Read first, from disk

1. `CLAUDE.md` (G71, G73, G74; § Building's resource rule and the protected checkpointing rule), `WORKFLOW.md`, `DEBRUIJN.md`.
2. `plans/FS81-derivation.md` T1–T8, especially T3; `plans/FS73-derivation.md` T40; their tools: `tools/fs81_verify_thetaR.py`, and FS73's cell code. **Frozen tools are never edited.** Import or copy them.
3. `plans/FS86-derivation.md`: FS86-Cx-C10, dB-HDfin, Cx-C15 (the homogeneous part is torsion) and dB-HDcert (the certificate form).

## The tasks

1. **C0.** Before computing, save your prediction at the top of your record, with a probability: is `Θ₄(U₅) ⊆ T + A`?
2. **Positive control.** Reproduce FS-81's three-colour result, `Θ₃(U₅) = θ₂ + disc ∪ X₃`, with your code. Plant one fault and confirm it fires.
3. **The four-colour set, exactly.**
   - Structure it as an inverse limit over the 5-adic depth (the layers `wᵐ`, `|m| ≤ M`).
   - Report, at each depth: the cells, the torsion points, the archimedean part, and whether any cell survives with a non-trivial 5-adic component.
   - **Stop rule:** either the set stabilises to `T + A` with a proof that deeper levels add nothing, or a non-`T + A` family is exhibited with a proof that it persists to every depth. If neither is reached by about 250k tokens or 12 hours of wall time, stop and report the frontier exactly.
4. **Reading.** If survivors exist, describe them: their dimension, their self-similarity, and whether a second prime (13, say) would kill them. **Derive** the effect of a second prime; don't compute it this stage.
5. **"Theorems this phase proved"**, each with grade and address.

## Rules

- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation).
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Resources and checkpoints.**
  - Any job over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. /tmp is RAM, so large outputs go to disk under `data/fs89/s0b/`.
  - A run over about 15 minutes checkpoints and resumes. Write its resume command in your record before launching.
  - Kill by pid and verify by effect. Never run `lake build`.
- **Work in stages.** Keep responses short and save after every step.
- **Your record:** `plans/FS89-S0B-band-set.md`. Commit by explicit path after each result, running `git diff --cached` first, because another agent commits concurrently.
  - Never amend. End each commit message with your harness's attribution lines. Don't push. Report each hash.
- **Another Stage-0 agent** is checking a derivation blind. Please don't open its record (`plans/FS89-S0A-gluing-verification.md`), don't open `data/fs89/s0a/`, and don't message it.
- **Keep a "would have searched here" log.**
- **Budget:** about 300k. Reach me by SendMessage (to: "main").
  - **Report points:** after C0; after the control; at each depth where the answer changes; at the end.
  - **Hand-back:** "S0B idle; report sent to the owner by SendMessage".

Thank you.
