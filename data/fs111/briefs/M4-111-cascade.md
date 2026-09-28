*Brief for job **FS111-M4**, FS-111 (the cone scale and the regularity step), round 4: the cascade. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 350k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS111-M's, `data/fs111/briefs/M-111-regularity.md`, plus
this file; where they differ, this file wins.** Read `data/fs111/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where route M stands (read these first; all open to you)

`plans/FS111-M3-finiteness.md` (round 3) with `tools/fs111_m3_honey.py`; `plans/FS111-M2-regularity.md` and `plans/FS111-VM2-verification.md`;
`plans/FS111-VMW-verification.md`.
- **HC_K** (M3-HC; one mind; exact): a regular maximal unit-avoiding set whose bands pinch on a Cantor set, with infinitely many interior components per
  period. So MUA-FIN-U is FALSE, and local finiteness is not free.
- **M3-MOVE**: one class alone can be moved, arbitrarily little, to remove its pinches. **M3-COVER**: in a cover, the move keeps it maximal exactly when the
  removed sliver is covered by other classes.
- **M3-CASCADE** (the GAP): in a partition, a measurable fall colouring with one colour per point, the class that absorbs the removed sliver must give up
  its own material at distance 1 from it, and so on. **No partition containing an HC-type class is held, so whether the cascade can close is open.**
- The honesty rule stands: by M2-REDUCE-C (two minds) any statement at `k = 5` that yields a locally finite regular maximal five-cover is equivalent to
  `χ_m⁰ ≥ 6`.

## Your job

Each stage is SAVED and committed; objects by formula, checked exactly (`tools/fs111_m4_*.py`, each with planted faults beside faithful twins).
1. **Build a partition with an HC-type class.**
   - The target: a measurable fall colouring by `k` maximal unit-avoiding classes, a.e.-proper and tight, in which one class is HC-type (pinched along a
     Cantor set), for some `k`: first `k ≥ 7`, where honest saturation is available (R7), then as low as it goes.
   - Or derive the obstruction: the pinch forces a neighbouring class to be pinched, and so on without end.
   - Either answer settles whether MUA-FIN-L can fail in partitions.
2. **The cascade itself.** In a partition, remove one pinch by M3-MOVE and follow the absorbing classes.
   - Does the cascade close in finitely many steps, run to infinity, or need a spare colour?
   - Say at which `k` a spare colour is available. That is where the colour count would enter.
3. **If context remains, MUA-REG in partitions.** M3-IRREG shows a single maximal set can be irregular (a fat Cantor band). Can a partition be forced to
   contain one?

## Rules

- **Your record** is `plans/FS111-M4-cascade.md` (the usual headings; SAVED stages). Working files go in `data/fs111/fs111-m4/`, tools in
  `tools/fs111_m4_*.py`, the report in `data/fs111/reports/FS111-M4.md`. Subjects are "FS111-M4: stage n", neutral.
- **Fences:** the session transcripts, `chats-bak/`, other agents' scratchpad files, `plans/FS111-close-inventory.md`, other briefs, and FS-114's files
  (`plans/FS114-*`, `data/fs114/`, `tools/fs114_*`).
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3): objects by formula, checked exactly; no search; keep the would-have-searched log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs111/reports/FS111-M4.md` and to `"main"`. Final text: "FS111-M4 idle; report sent to
  the owner by SendMessage".

Thank you.
