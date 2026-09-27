*Brief for job **FS110-CC**: a second mind on one step. Does S–V Corollary 1, almost everywhere, as FS110-CB derived it, hold at cubic vertices with a
**cusp sector**? Opus 5.5, 2026-09-27. Written by the product owner. **Sized for about 200k tokens by the harness's count. Your own count runs at
55–70 % of it, so hand back with your record saved when your own count reaches about 130k.***

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief. Read rule 0 first;
rule 13's fences bind you.**

## Why this step matters

FS-110's proof side reduced every tight six-map under S–V's Condition 5 to a cubic map on the whole plane. That map may keep **cubic vertices with a
cusp sector**: a vertex of degree 3 at which one colour's sector has angle 0 and the two boundary tangents coincide. Such a vertex exists locally; it
has been checked exactly (`data/fs110/fs110-a6/a6_c2_single_horn.py`, which is open to you).

The last step of the proof side's chain is **S–V Corollary 1 almost everywhere for curved cubic maps under Condition 5**. Two blind minds derived
it, FS110-CB and FS110-CD, by different routes. **Neither was asked about cusp sectors.** FS110-CD's route takes S–V's Props. 9–11 and 17 from print.
FS110-CB's route may cover them.

## What to check (read `plans/FS110-CB-verification.md`, which is open to you)

**The main step is CB's D2 strip, lines 104–112 of its record.** Every vertex used as a circle centre passes through it: `u` itself, the pigeonhole
endpoints handed to Lemma 3 (D4, lines 135–158), and those handed to Cor. 3 (lines 111–112). At a vertex whose two tangents coincide (a cusp
sector), check each of these:
- **(a)** For a suitable `δ`, the three numbers `|u + e − x_ij(δ)| − 1` stay nonzero, including along the cusp's normal.
- **(b)** A horn tile still holds "a curve beside the arc".
- **(c)** Any two arcs still border all of `{4, 5, 6}`.

**Then two secondary steps,** each checked at a cusp vertex:
- D5 item 5 (lines 180–185);
- D1's (P′) (lines 94–97).

For each item: TRUE, FALSE (with a configuration a stranger can check, by exact arithmetic of seconds where it helps), GAP at the exact step, or
MISSTATED, with your count of minds and grade. If a step fails at cusps, say whether a local repair exists, and give it.

## Fences

- Standing rule 13's list: the session transcripts, `chats-bak/`, and scratchpad files you did not create (work in `scratchpad/fs110-cc/`).
- **The competition advisors' records** (`plans/POROS-2026-09-27-fs110-competition.md` and `data/fs110/fs110-a*/` other than the one tool named
  above). An advisor has already read CB's route at cusps, and you are the independent second reading.
- **FS110-CD's record.**
- The running verifiers' records (FS110-NB4, FS110-YB4).

Everything else in the repository is open to you, including the papers in `~/source/library/`.

## Rules

- **Touch only** `plans/FS110-CC-verification.md`, `data/fs110/fs110-cc/` and `tools/fs110_cc_*.py`. Commit by explicit path, with subjects
  "FS110-CC: stage n". Push; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Contact only `"main"`. Report to `data/fs110/reports/FS110-CC.md` and by SendMessage. Your final turn's text: "FS110-CC idle; no content in this
  hand-back; my reports go to the owner by SendMessage".

Thank you.
