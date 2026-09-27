*Brief for job **FS110-A6**: the competition advisor of FS-110 (the tangency seam) for round 4's comparison and the verdict. Opus 5.5, 2026-09-27.
Written by the product owner. FS110-A5 compared round 3 and stood down at its line; round 4 ran without an advisor.*

Hello Poros. Your identity is `~/source/poros/CLAUDE.md`. Read your skills directly: `~/source/poros/.claude/skills/poros/SKILL.md`,
`…/poros-reframing/SKILL.md` and `…/poros-anomaly-hunt/SKILL.md`. **Your brief is FS110-A2's brief, `data/fs110/briefs/A2-110-competition-advisor.md`,
plus this file.** Read that brief in full; where the two differ, this file wins. `data/fs110/briefs/STANDING-RULES.md` is part of both; read rule 0
first.

## The hand-over

The record is `plans/POROS-2026-09-27-fs110-competition.md`. Read A5's section, "§ Continuation — FS110-A5", with its § A5-5.4 (the `d = 2` card) and
§ A5-5.6. Read earlier sections as you need them. Continue the record in a new section, "§ Continuation — FS110-A6". Never rewrite an earlier stage.

**What happened after A5** (reports in `data/fs110/reports/`; every record named here is open to you, **except the blind verifiers still running**):
- **FS110-NB3 (blind on round 3's proof side):** W-MERGE and N3-RED TRUE blind, after one-line repairs.
- **FS110-YB3 (blind on round 3's construction side):** Y3's ring lemmas stand. YB3-SAME is a GAP: `W` is not carried across a same-type edge, so
  the winding framing weakens. N3-RED does not use windings.
- **FS110-CB and FS110-CD (two blind minds, different routes):** S–V Cor. 1 holds a.e. for curved cubic maps under Condition 5 with **no `d = 2`
  exception**. So G-d2 does not arise (`data/fs110/claims.md` §8 and its two updates).
- **Round 4 (W-4):**
  - **FS110-Y4:** tip-hard Woodall cones exist locally (fragments WCH and WC1H), and G-CONE is never an instance of G-d2 (Y4-D2). Its conclusion:
    "a NO at G-CONE must use non-local structure".
  - **FS110-N4:** G-CONE CLOSED at one mind (N4-SHAVE, N4-RAY, N4-STUCK, N4-PROP, N4-FIN, N4-TERM, N4-CONE). Hard cones are removable, and a stuck
    vertex forces a bi-infinite chain along the normal line, which curvature monotonicity forbids. So W-4 is NO: the Condition-5 half of S–V
    Question 2 is answered NO almost everywhere at bounded `K`. **That is held at one mind.**
- **Running, blind, never to be contacted:**
  - FS110-YB4, on Y4's fragments;
  - FS110-NB4, on N4's chain, with Y4's cone fragments as controls.

  Their records are fenced until their report files exist. The owner will tell you when each lands.

## What I'd like from you

1. **Compare round 4.** Both sides' records are open to you.
   - **The apparent tension:** Y4 says tip-hard cones survive every single-colour tip recolouring, and that a NO needs non-local structure. N4 says
     hard cones are removed by SHAVE (a recolouring with the flank colours) and RAY, or else are stuck, and a stuck vertex forces an infinite chain.
     Is this a divergence of truth, or two statements about different objects? Look at WC1H in particular: it is single-horn and degree 3, so it may
     already be cubic with a cusp sector.
   - Score both pre-round bets. Count the retractions.
2. **The base's scope** (N4's held question). N4-RED needs S–V Cor. 1 for cubic maps whose sectors may be **cusp horns**. Does CB's or CD's
   derivation cover that, and does either need a lower bound on radius? Read `plans/FS110-CB-verification.md` and `plans/FS110-CD-verification.md`
   and answer from their text, with line addresses. If neither covers it, say what a covering argument would need.
3. **When NB4 and YB4 report,** compare each with its side and give the count of minds for W-4's NO.
4. **The verdict and the close.** Give a four-part recommendation: close FS-110 now, with whatever grade W-4's NO then carries, or run one more
   targeted step. **State the milestone's headline, exactly and with its grade.**
5. **Report** to `"main"` by SendMessage after each stage, in at most 12 lines, and always address `"main"` explicitly.

## Rules

- **Touch only** your record (the new section) and `data/fs110/fs110-a6/`. Commit by explicit path, with subjects "FS110-A6: stage n". Push; never
  amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Fences:** standing rule 13's three channels; work in `scratchpad/fs110-a6/`. Never contact a blind verifier.
- **Budget:** about 300k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your record saved when your own count
  reaches about 180k.

Thank you.
