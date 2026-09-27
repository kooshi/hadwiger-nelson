*Brief for job **FS110-CB**: a blind second mind on the base FS-110's NO route rests on, Sokolov–Voronov's Corollary 1 for cubic maps, repaired.
Opus 5.5, 2026-09-27. Written by the product owner. **Blind.** **Sized for about 300k tokens by the harness's count. Your own count runs at
55–70 % of it, so hand back with your record saved when your own count reaches about 195k.***

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief. Read it in full,
rule 0 first; rule 13's fences bind you.** Read `CLAUDE.md` § The aim and § Counter-priors from disk.

## Why this matters

FS-110's proof side reduced `[SokolovVoronov2025]`'s Question 2 under their Condition 5 to two local configurations, both at distance exactly 2.
The reduction runs in two steps:
1. A merge step (Woodall 1973's step 3, almost everywhere) makes any tight six-map cubic, except at one configuration.
2. **S–V's Corollary 1** (cubic maps need seven) kills the cubic map. FS-106 repaired its printed proof, except at the `d = 2` edge case. That repair
   stands at one mind for cubic maps with curved boundaries. Its weakest link is the repair of S–V's **Lemma 3** at `√3 ≤ d < 2`, a transplanted
   bicycle, graded as a sketch.

**You give that base its second mind, blind.**

## The statements (derive your own verdict on each before reading anyone's proof)

1. **S–V Corollary 1, almost everywhere, for curved cubic maps under Condition 5.** A locally finite map of the plane whose tiles are bounded by
   finitely many circular arcs and segments, none an arc of radius 1, with exactly three tiles at every vertex, has no six-colouring in which
   same-coloured tiles contain no two interior points at distance exactly 1 — **except possibly** where two same-multicolour points lie antipodal on a
   unit circle (`d = 2`). Read Conditions 3, 5 and 6 and Corollary 1 in the paper, `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, and quote
   them verbatim. State exactly what "the printed chain, repaired" must be, and derive it.
2. **S–V Lemma 3 at `√3 ≤ d < 2`.** Its printed proof uses Fig. 5's three curves, which cannot exist as drawn beyond `√3`. Is there a proof, for
   instance Voronov's bicycle argument (`[Voronov2023]` Lemma 6.1, at `~/source/library/pdf/arXiv-2304.10163-voronov.pdf`) run on the two unit
   circles? Derive one, or name the step where it stops.
3. **The `d = 2` case:** state exactly what it is, and whether Corollary 1's chain can reach it at all.

For each: TRUE, FALSE (with a counterexample a stranger can check), GAP at a named step, or MISSTATED, with your count of minds and grade.

## Fences (until your stage 3 is committed)

Standing rule 13's list: the session transcripts, `chats-bak/`, and scratchpad files you did not create (work in `scratchpad/fs110-cb/`). Also:
- `plans/FS106-V-verification.md`, `plans/FS106-VB-verification.md`, `plans/FS106-TS-derivation.md`, `plans/FS106-SB-verification.md`,
  `plans/FS106-derivation.md` and `plans/FS106-regular-half.md`;
- every FS-110 record, report and brief other than yours and the standing rules;
- every advisor record;
- `LEDGER.md` rows 131–133 and their § B lines;
- `git log` beyond `git log -1 --format=%h`.

The papers in `~/source/library/` are open to you.

## Stages

1. The quotation check, your restatements, and your registered expectation, with both outcomes reachable.
2. The derivations.
3. Your verdicts, committed before anything fenced is opened.
4. Only then: read `plans/FS106-V-verification.md` § Continuation — FS106-V2 and FS106-V3, and `plans/FS106-derivation.md`'s FS106-SV2 entry, and
   record every divergence of truth and of route.

## Rules

- **Touch only** `plans/FS110-CB-verification.md`, `data/fs110/fs110-cb/` and `tools/fs110_cb_*.py`. Commit by explicit path, with subjects
  "FS110-CB: stage n". Push; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **The ban:** exact checks of seconds on objects given by formula only; nothing is searched.
- Contact only `"main"`. Report under standing rule 9 to `data/fs110/reports/FS110-CB.md`, and by SendMessage. Your final turn's text: "FS110-CB idle;
  no content in this hand-back; my reports go to the owner by SendMessage".

Thank you.
