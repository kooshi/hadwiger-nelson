*Brief for job **FS103-B**: a blind second mind on the fractional shadow (FS103-F's theorems). Opus 5.5, 2026-09-26. Written by the product
owner. **Sized for about 250k harness tokens; hand back by 330k.***

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. **`data/fs103/briefs/STANDING-RULES.md` is part of this brief; read it
in full.** Read from disk `CLAUDE.md` (G21, G54, G60, G80), `LEDGER.md` rows 92, 100, 110, 116–127, and **`data/fs103/claims-f2.md`** — the claims
you check, statements only.

**If your record `plans/FS103-B-verification.md` already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS103-B-verification.md`.

## Why

One mind (job FS103-F) found that this project's five-colour lower bound over every real number field (`LEDGER.md` row 123) runs on one colour
class at a time. Given MR (row 120), it gives the fractional statement FS103-F-FRAC, and at ℚ(√635087) that yields FS103-F-DV:
`α₁(ℝ²) = m₁(ℝ²)`. That is the first clause of a conjecture published in 2026 (`[DuczVarga2026]`, Conjecture 1). It also says the route can
never give six (FS103-F-ROUND). **A published conjecture answered is the flattering outcome, so audit it at the rate of an unwelcome one**
(G21). FALSE or GAP with the step named is as valuable as TRUE (standing rule 4).

## Blind — the fences (until your stage 3 is committed)

Do not open:
- `plans/FS103-F-fractional-shadow.md`, `data/fs103/reports/`, `data/fs103/fs103-f/`, `tools/fs103_f_*`, `data/fs103/briefs/F103-*`;
- every other FS-103 record: `plans/FS103-*.md` except this brief's own record; `plans/POROS-2026-09-26-fs103-collapse.md`;
  `data/fs103/claims-sealed.md`;
- `plans/FS103-close-inventory.md`; `plans/SESSION-HANDOFF-2026-09-26.md`; any memory file under
  `~/.claude/projects/-home-kooshi-source-lean-dir/memory/` (your auto-memory's pointer to the handoff is overridden here);
- the bodies of commits whose subjects start "FS103-".

**Open:** everything else, including row 123's derivations and every lemma they use (`plans/FS100-derivation.md` §4, the X23, X25B and X26B
records, `plans/FS84-SI-D-derivation.md`, `plans/R88-derivation.md`), the MR derivations, `data/fs103/claims.md`, and the papers.

## Stages

1. Quotation check of `data/fs103/claims-f2.md` against every source open to you. Write your own controls **before deriving**, each with what a
   wrong-reason pass would look like: K = ℚ(√3,√11), where `χ_f(K²) = 4` (G60), so any argument must give `ρ(K) ≥ 1/4`; ℚ(√11); ℚ(√3);
   the arithmetic-free `Cay(ℝ, {±1, ±√2})`. Save.
2. **FS103-F-FRAC**, derived blind: does each step of row 123's chain hold with one translation- and rotation-invariant random independent set
   of density `δ` in place of a colouring? Name every place where a second class, or the count of classes, is used. Then FS103-F-TJ and
   FS103-F-ROUND. Save.
3. **FS103-F-DV, -TF, -47**: each link on its own. In particular:
   - `m₁(ℝ²)` bounds the density of the object FRAC produces (continuity in probability, a measurable version: which exactly?);
   - `m₁(ℝ²) ≤ α₁(ℝ²)` holds;
   - ℚ(√635087)'s stable places all have ratio below Croft's 0.22936 (PARI, seconds; plant a fault);
   - the conjecture's own words (`[DuczVarga2026]`) match the statement.

   The write-up, a verdict per claim; **commit before opening anything fenced.** Save.
4. Only after stage 3: read `plans/FS103-F-fractional-shadow.md` and record divergences of route and of truth. Save; the report.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- The ban (standing rule 3); a "would have searched here" log. Contact only `"main"`.
- **Touch only** `plans/FS103-B-verification.md` (record, with "Theorems this phase proved"), `data/fs103/fs103-b/`, `tools/fs103_b_*.py`.
- **Commits:** by explicit path, subjects "FS103-B: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-B.md`, committed, and by SendMessage to "main". Final turn text: "FS103-B idle;
  report sent to the owner by SendMessage".

Thank you.
