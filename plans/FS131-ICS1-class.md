# FS131-ICS1 — five colours by field and by class: the quadratic dichotomy, the family, CLS in full, ℚ(√23, ∛2)

*de Bruijn, the kernel lane's implementer, on Opus. Brief `data/fs131/briefs/FS131-ICS1-class.md` (on `main`); branch
`fs131-kcs1`, worktree `.claude/worktrees/kcs1`, at `9db09ce35` on launch (the planner's skeleton with `main` merged in).
Launched 2026-10-16 18:43 UTC. The plan is `plans/FS131-KCS1-class-plan.md` (FS131-KCS1's record). Nothing is fenced.*

## Theorems this phase proved

None yet (filled at the gate).

## Stage 1 — SAVED: the readback

### 1.1 Quotations

All nine blockquotes of the brief are verbatim in their named sources (`data/fs131/ics1/quote_check.py`, a copy of
FS131-KCS1's checker: it strips the `> ` prefix, collapses whitespace and searches the named source; its planted control —
one word of the first quote changed — is reported `MISMATCH` and exits 1). Run 2026-10-16 18:46 UTC from the worktree:
`9 quotes, 0 mismatches`, exit 0 (`data/fs131/ics1/logs/quote_check.out`); plant: `9 quotes, 1 mismatches`, exit 1
(`logs/quote_check_plant.out`). The line numbers ruling 1027 cites (A1 `SqrtFiveClass.lean` ll. 39–41, A2 ll. 64–66, A3
`FourColourPlaces.lean` ll. 73–74, A4 `SqrtTwentyThreeCbrtTwo.lean` l. 80, the bridge `StableAboveUsable.lean` ll. 44–45;
`Rigidity/SqrtClassFive.lean` l. 270) are where the statements stand.

### 1.2 Findings from the readback

- **R1 — the skeleton has 35 leaves, not 36.** The four files hold 12 + 4 + 7 + 12 `sorry`s (`FourColourPlaces`,
  `StableAboveUsable`, `SqrtFiveClass`, `SqrtTwentyThreeCbrtTwo`); the plan's table (§ 3.1) counts 13 in the instance
  module, whose `instance : NumberField F23 := numberField_F23` is not a leaf. The planner's build log's 85 `sorry`
  warnings are 35 distinct lines, each printed more than once (`sort -u` of the log's `declaration uses` lines: 35). No
  statement is missing; the count is a bookkeeping slip.
- **R2 — the drafted `ratioAtMost_dyadic_of_six_le` carries an unread binder.** The plan's § 3.5 item 1 drafts it with
  `(h2 : 2 ∈ P)`; the `f ≥ 6` branch of `ratioAtMost_dyadic` (ll. 1458–1477) reads only `ha`, `hQ` and `f`'s bound — `h2`
  enters `ratioAtMost_dyadic` only through `exists_card_two_pow_sq`, which the new lemma replaces by its hypothesis `hQ`.
  A public theorem with an unread hypothesis fails the linters (`unusedVariables` in the build, `unusedArguments` in
  `lake lint`). I state it without `h2`: strictly stronger, and no weaker in meaning, since `|𝓞 ⧸ P| = (2^f)²` with
  `f ≥ 6` already makes `P` dyadic. The ruling fixes the lemma's name, place and role, not its binders; reported to the
  coordinator with the gate.

### 1.3 The target, the rulings, the order of work

**Target.** Replace each of the 35 `sorry`s of the four skeleton modules with a proof, changing no stored statement;
make the ruled `ClassRatio` edit; pass the full gate (`data/fs131/clone1/run-gate.sh`'s steps, copied under
`data/fs131/ics1/`) on one commit; read each head statement aloud against row 123; draft the front-file edits.

**Rulings in force for this job** (inventory items 1025, 1027):
1. *The `ClassRatio` edit* (item 1027 (1)): state `ratioAtMost_dyadic_of_six_le` as a public theorem after
   `ratioAtMost_dyadic`; make `chromaticNumber_le_four_of_small` and `chromaticNumber_le_four_dyadic` public, with
   docstrings; call them by name, no `open private`. Touch no other line of `ClassRatio` (FS131-IFR1 edits l. 92,
   `ratioAtMost_of_charBound`, on its own branch). Done in the first build. Each is a ruled change in the statement
   comparison.
2. Part B (the ring lemma) is not this job's.
3. The commit hook runs the privacy guard; a refusal is reworded, never `--no-verify`.

**Before the first proof edit**: the stored statements of 21 modules dumped from the compiled skeleton
(`data/fs131/ics1/lean/StatementDump.lean`, a copy of FS131-ICO2's dumper; print `data/fs131/ics1/statements-before.txt.gz`,
taken 2026-10-16 18:48 UTC at `9db09ce35` against the build the planner made of `09fc7f4c2`'s text, which
`lake build --no-build` reported up to date, `logs/uptodate-0.log`): `ClassRatio`, its 19 downstream modules (the three
skeleton modules among them) and `StableAboveUsable`.

**Order** (the plan's § 3.3, kept): the `ClassRatio` edit; `Rigidity/FourColourPlaces` (leaves 8, 9, 10, 1, 2, 3–7, 11,
12; re-price after 8 and 1); `Arith/StableAboveUsable` (u3, u12, heads); `Instances/SqrtFiveClass` (s1–s5, then s6–s7);
`Instances/SqrtTwentyThreeCbrtTwo` (t2, t4, t1, t5, t3, t6, t7–t10, t11). A build through `./scripts/build.sh` under the
slot after each module, and a saved stage. Iteration is in a real-copy farm of the compiled library (`build/ics1-farm`,
gitignored), never evidence.
