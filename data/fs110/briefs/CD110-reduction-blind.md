*Brief for job **FS110-CD**: a blind second mind on the claim that Sokolov–Voronov's Corollary 1 holds almost everywhere for curved cubic maps with
**no `d = 2` exception**. Opus 5.5, 2026-09-27. Written by the product owner. **Blind.** **Sized for about 300k tokens by the harness's count.
Your own count runs at 55–70 % of it, so hand back with your record saved when your own count reaches about 195k.***

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief. Read it in full,
rule 0 first; rule 13's fences bind you.** Read `CLAUDE.md` § The aim and § Counter-priors from disk.

## The claim

A blind verifier (FS110-CB) derived, at one mind, that `[SokolovVoronov2025]` Corollary 1 needs no `d = 2` exception almost everywhere for curved cubic
maps under Condition 5. Its route replaces S–V's Prop. 19 (a recolouring of the plane) with a reduction on the circle only, after which "every
pigeonhole endpoint lies in the open disc". If this is true, one of FS-110's two remaining configurations (S–V's `d = 2` case) never arises, and an
exception FS-106 carried is withdrawn. **It needs a second mind before anything rests on it.**

Derive, blind:
1. **S–V Corollary 1, almost everywhere, for curved cubic maps under Condition 5, with no exception at `d = 2`.** A locally finite map of the plane
   whose tiles are bounded by finitely many circular arcs and segments, none of radius 1, with exactly three tiles at every vertex, has no six-colouring
   in which same-coloured tiles contain no two interior points at distance exactly 1. Read Conditions 3, 5 and 6, Lemmas 3–5, Props. 17–19 and
   Corollary 1 in the paper, `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, and quote them verbatim.
   - **The step to find:** where S–V's own chain can meet two points at distance exactly 2, meaning two points antipodal on a unit circle about a
     vertex `u`, with the same multicolour or with disjoint multicolours. Is there an argument, working on the circle only and not by recolouring the
     plane, that keeps every endpoint of the pigeonhole strictly inside the disc? Give it, or name the step where it fails, with a configuration a
     stranger can check.
2. **Everything the argument uses from the print**, each marked as read or re-derived. CB accepted Lemma 5 and Prop. 18 from print; say whether you
   need them, and verify them if you do.

For each: TRUE, FALSE (with a counterexample), GAP at a named step, or MISSTATED; your count of minds and your grade.

## Fences (until your stage 3 is committed)

- standing rule 13's list: the session transcripts, `chats-bak/`, and scratchpad files you did not create (work in `scratchpad/fs110-cd/`);
- `plans/FS110-CB-verification.md`, `data/fs110/fs110-cb/` and `tools/fs110_cb_*`;
- every FS-106 verification, derivation and plan record;
- every FS-110 record, report and brief other than yours and the standing rules;
- `data/fs110/claims.md` §8 (its update names CB's route);
- every advisor record;
- `LEDGER.md` rows 131–133 and their § B lines;
- `git log` beyond `git log -1 --format=%h`.

The papers in `~/source/library/` are open to you.

## Stages

1. The quotation check, your restatement, and your registered expectation, with both outcomes reachable.
2. The derivation.
3. Your verdicts, committed before anything fenced is opened.
4. Only then: read CB's record and FS106-V's continuation sections, and record every divergence of truth and of route.

## Rules

- **Touch only** `plans/FS110-CD-verification.md`, `data/fs110/fs110-cd/` and `tools/fs110_cd_*.py`. Commit by explicit path, with subjects
  "FS110-CD: stage n". Push; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Exact checks of seconds on objects given by formula only; nothing is searched.
- Contact only `"main"`. Report to `data/fs110/reports/FS110-CD.md` and by SendMessage. Your final turn's text: "FS110-CD idle; no content in this
  hand-back; my reports go to the owner by SendMessage".

Thank you.
