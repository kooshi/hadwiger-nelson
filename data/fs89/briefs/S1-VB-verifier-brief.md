*Brief for the FS-89 Stage-1 blind verifier of the derivation agent's claims ("V-B", verifier I, Opus 5.5), 2026-09-25. It continues
the work of verifier H ("V"), who finished the fixed list V-A1–V-A4 at about 390k tokens and was replaced rather than reused, under
Kooshi's rule for agents near 500k. Its reading fence and blindness rules are V's (`data/fs89/briefs/S1-V-verifier-brief.md`), with the
changes stated below.*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **verifier I**, the blind verifier for milestone FS-89, Stage 1, in the Lean 4
Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md` and `WORKFLOW.md`; read all three from disk.
I'm the product owner; I coordinate and review by artifact. The verdicts are yours.

## Why you, and why blind

The milestone asks whether every four-colour **band character** of the ring the rational unit vectors generate is a torsion character
plus an archimedean one. A band character is a homomorphism `θ` to `ℝ/ℤ` with `θ(u) ∈ [1/4, 3/4]` for every unit vector `u`.
- **Stage 0 found two things.** First, this rational statement is equivalent to the same statement over every real field. Second, at
  one prime (5) it is false.
- **The derivation agent now claims a proof.** It works at the two primes {5, 13} and then lifts to all primes, and it claims the
  five-colour version too. The planner put this outcome at 0.10.
- **What the proof would decide, if true:** the character part of four-colour rigidity over ℚ(√59), ℚ(√83), ℚ(√131), of ℚ(√47)'s
  five-colour prediction and, at five colours, of ℚ(√167)'s six-colour prediction.
- **Your job:** check it the way someone who trusts none of it would. Derive or refute each claim from its statement alone, before you
  see the route.

**Every verdict counts, and none is preferred.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge
is a success."*
- **Do not lean toward a yes.** This is a result the project would like to be true, which is exactly when this project's recorded
  failure mode bites (`CLAUDE.md` G21: defects that flatter the work survive; defects that displease are found within the hour).
- **Audit it as hard as you would a counterexample you disliked.**
- **FALSE** with a counterexample, or **GAP** with the missing step named, is as valuable as TRUE.

## Read first, from disk

1. `CLAUDE.md` (§ Notation; G21, G30, G54, G71, G74, G76), `WORKFLOW.md`, `DEBRUIJN.md`.
2. **The plan**, `plans/FS89-rational-band-rigidity.md`, **§0.1–§0.3, §PA.1–PA.2 and §IQ only.** Not §0.4, §PA.3–PA.4, §S or §C.1:
   they name the route the derivation agent was asked to test first.
3. **Stage 0, in full:** `plans/FS89-S0A-gluing-verification.md`, `plans/FS89-S0B-band-set.md`.
4. **Verifier H's record, in full:** `plans/FS89-S1V-verification.md`. Its results are verified inputs you may use:
   - V-A1, the layering lemma;
   - V-A2, Lemma N₀ and the explicit leaf list: 13 discs and 16 points, 29 torsion characters;
   - V-A3, Theorem V4: any second prime kills every rational heteroclinic;
   - V-A4, Theorems V5 and V6: the rank-`r` orbit model, the unique square fill, the orthant reading, and "one leaf on the axes ⟺
     `T + A`".
5. `plans/FS86-derivation.md` §4 and `plans/FS81-derivation.md` (T3, T4, T8), for background.
6. Any held paper. `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf` (Berend, *Minimal sets on tori*, ETDS 1984) is the nearest
   closed-set theorem in print.

## What you must not open

These stay closed until your verdict on the claim in question is committed. After that, you may read the route to write a divergence
table.
- `plans/FS89-S1D-derivation.md`;
- `data/fs89/s1d/` and `tools/fs89_s1d_*`;
- the derivation agent's scratch directory;
- `data/fs89/briefs/S1-D-derivation-brief.md`;
- `git log -p` or `git show` of the derivation agent's commits.

Also closed:
- `plans/FS89-close-inventory.md`, which logs the derivation agent's routes;
- `~/source/lean-dir-owner/`;
- every scratch directory but your own.

**`data/fs89/briefs/S1-VB-lemma-statements.md`** holds the derivation agent's lemma statements, with every proof omitted. Open it **only
after your phase-B1 verdicts are committed** (below).

## The claims (phase B1: headline statements, verbatim, blind)

Quoted verbatim from the derivation agent's record. The objects are the plan's §0.1:
- `R_S = ℤ[i][1/p : p ∈ S]`;
- `U_S = ⟨i⟩ × ⟨w_p⟩`, with `w_p = π_p/π̄_p`;
- `Θ₄(R_S)`, the band characters at `[1/4, 3/4]`;
- `T`, the torsion characters; `A`, the archimedean characters `x ↦ Re(ē x) mod 1`;
- the leaves `τ + D(r_τ)`.

1. **D1-T1 (`MS₄(S)`).** "For every finite set `S` of primes `≡ 1 (mod 4)` with `|S| ≥ 2`, every `U_S`-minimal closed subset of
   `Θ₄(R_S)` is either one finite orbit of torsion characters, or a finite union of leaf circles `τ + {λ_d : |d| = r}` with
   `0 < r ≤ r_τ`. In both cases it is contained in `T + A`. **Inhabitant** `S = {5, 13}`: `{θ₂}`, and the parity circle of radius ¼."
2. **D1-T2 (`RS₄({5, 13})`).** "`Θ₄(ℤ[i][1/65]) ⊆ T + A`." with "**Inhabitant:** `Θ₄(R₆₅) ∋ θ₂` (margin ¼)."
3. **D1-C2.** "The torsion characters in `Θ₄(R₆₅)` are finitely many. So `Θ₄(R₆₅)` is a finite union of leaf discs `τ + D(r_τ)`."
4. **D2-T1 (RQ₄).** "`Θ₄(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`." The derivation agent derives it from D1-T2 and D1-C2 by a bounded-order
   layering lemma. Treat "D1-T2 and D1-C2, hence D2-T1" as two claims, and check both.

5. **D5-T1 (`RS₅({5, 13})`).** "`Θ₅(ℤ[i][1/65]) ⊆ T + A`." (band `[1/5, 4/5]`)
6. **D5-C2.** "`Θ₅(R₆₅) ∩ T` is finite."
7. **D5-T2 (RQ₅).** "`Θ₅(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`." with "**Inhabitant:** `θ₂`." Again "D5-T1 and D5-C2, hence D5-T2" is two
   claims.

**Priority:** the four-colour claims 1–4 first; the five-colour claims 5–7 second. If your budget runs short, stop after the four-colour
verdicts with the record saved, and tell me; a successor takes 5–7.

**Phase B1 (blind; about 150k tokens).** Attempt each claim from its statement alone, by your own route. The literature and verifier H's
results are yours to use. Save a verdict per claim: **TRUE**, **FALSE** (with a counterexample) or **GAP** (true as far as you can
derive, with the missing step named). Name the step you found hardest.
- If your own route stalls, the verdict is **GAP at that step**, not a guess.
- Commit your B1 verdicts before phase B2.

**Phase B2 (the lemma statements; about 120k tokens).** Now open `data/fs89/briefs/S1-VB-lemma-statements.md`. For each lemma your B1
route did not already establish, derive or refute it from its statement: D1-L2, D1-L3, D1-L4, D1-L5, D1-L6, D1-C1, D2-L1, and for the five-colour claims
D5-L1, D5-L2, D5-L3.
- Then check the assembly: do these lemmas, as stated, imply the seven claims?
- **The derivation agent's own audit names D1-L3 as its weakest link** ("case 1 ⟹ `M − M = G`, when `|S| ≥ 2`"). Give it your most
  careful independent derivation.
- **D1-L5, D1-L6, D1-C1 and D5-L3 are exact finite statements at {5, 13}.** Check them with your own exact code (`tools/fs89_s1vb_*.py`), never
  the derivation agent's tool. Plant a fault and watch it fire.

**Phase B3 (after B2's verdicts are committed).** Open the derivation agent's record and write a divergence table: every difference of
truth, scope or route.

**What these claims do not say, if true** (the plan's §0.2 scope line, quoted): "RQ is about **character** colourings only. A proof of
RQ₄ excludes every colouring of the form `x ↦ ⌊4θ(x)⌋` as a falsifier of the conjecture at ℚ(√47) (C-47); it says nothing about
`χ(ℚ(√47)²)` itself." If you find any claim stated wider than it is proved, that is a finding.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one
  level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a saved verdict and tell me what is left. That is a good report.
- **Work in stages.** Keep each response short, and save your record after every section. At FS-86 an agent lost three responses to the
  output-token limit, and no message reached it.
- **The finite-witness-free week, to 2026-10-01.** No SAT, MILP, finders, `Θ` relation trees, quotient searches or sweeps. Exact
  arithmetic that checks a derived claim is fine. Keep a **"would have searched here" log**: one line per move you would have made by
  search, and what you did instead.
- **Your record:** `plans/FS89-S1VB-verification.md`.
  - C0 first: a probability per claim, before any derivation.
  - One section per claim, quoted verbatim.
  - The divergence table.
  - The log.
  - A heading **"Theorems this phase proved"**: one line per theorem, with grade and address.
- **Tools and data:** `tools/fs89_s1vb_*.py`, `data/fs89/s1vb/`. You may import `tools/fs89_s0b_*.py` and `tools/fs89_s1v_*.py`, and edit
  neither. Frozen tools are never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`,
    `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-s1vb/`.
- **Jobs** over about 2 GiB or 2 minutes run under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. /tmp is RAM. Never run
  `lake build`.
- **Commits by explicit path**, after `git diff -- <path>`.
  - **Neutral subjects:** "FS-89 S1VB: record, section n". The harness shows every agent the last five subjects.
  - Never amend. Don't push.
  - End commit messages with your harness's attribution lines.
  - Report each hash.
- **Budget:** about 380k tokens; hand back with the record saved by 450k.
- **Reports** go to me by SendMessage (`to: "main"`): after C0, after B1, after B2, and at the end, carrying your token count each time.
  Keep your turn's final text content-free: "verifier I idle; report sent to the owner by SendMessage".

Thank you. Verifier H's four verdicts are the ground you stand on, and they were careful work. This check is the one the milestone's
headline rests on.
