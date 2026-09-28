*Brief for job **FS111-M3**, FS-111 (the cone scale and the regularity step), round 3: the finiteness rung. Opus 5.5. Written by the product owner,
2026-09-28. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS111-M's, `data/fs111/briefs/M-111-regularity.md`, plus
this file; where they differ, this file wins.** Read `data/fs111/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where route M stands (read these records first; all are open to you)

`plans/FS111-M2-regularity.md` (round 2), `plans/FS111-VM2-verification.md` (its blind check), `plans/FS111-VMW-verification.md`,
`plans/FS111-M-regularity.md`, `plans/FS111-W-wild.md`.
- **M2-REDUCE-C, TRUE at two minds**: a maximal five-cover with regular classes whose boundaries form a locally finite plane graph (REG-J′-C₅) gives
  `χ_m⁰ ≥ 6` through FS106-AE-MAP6. At five this is an **equivalence**, so it is a reformulation of `χ_m⁰ ≥ 6`, not a step smaller than it.
- **The colour-generic rung that is smaller** (VM2's reading, the owner's ruling): M2's **MUA-FIN-P**, verbatim *"every regular maximal cover can be
  modified, keeping it a maximal cover, into one satisfying MUA-FIN"*, **with VM2's clause D3**. MUA-FIN is M2 §2.3's *"`⋃_j ∂F_j` is, in every bounded
  set, a finite union of Jordan arcs"*; D3 adds *"meeting only at endpoints"* (a locally finite plane graph), which REDUCE-C's proof uses.
- **Against it**, M2's reading *"MUA-FIN-U: every regular MUA set has locally finitely many components"* is **FALSE** by **M2-PINCH-C** (a class pinching
  along a Cantor set), one mind and conditional on such a class existing. Its killing test: *"a regular MUA set by formula containing the configuration,
  or a proof that M2-FIX forbids it globally"*.
- MUA-REG (the classes are regular) is the other named hypothesis, open. MUA-REG-U's one-dimensional analogue is FALSE (M2 §1.5).

## Your job, route M round 3

Each stage is SAVED and committed. Every statement is posed for every `k` and inhabited at `k = 7` (R7, SQ9, DISC7, DISCK7 with its orientation fixed
per VM2), checked exactly.
1. **M2-PINCH-C decided.** Complete the Cantor pinch to a whole regular maximal unit-avoiding set by formula, checked exactly, or prove M2-FIX forbids it
   globally. Either way MUA-FIN-U is settled.
2. **MUA-FIN-P, with D3's clause.** If pinches exist, can a maximal cover be modified to remove them while staying a maximal cover? Derive the
   modification (a "smoothing" move at a pinch that keeps every class unit-avoiding and the union maximal), or name the obstruction.
   - Say whether the move changes the colour count. A move that needs a spare colour is where the count enters.
   - The prior art to read first: the geometric measure theory M2 cites (Federer 4.5.11; Federer 1959 on sets of positive reach; Kershner 1939), and
     `[Bukh2008]`'s zooming-out (held in `~/source/library/pdf/`).
3. **If context remains: MUA-REG.** Is every maximal unit-avoiding set, or some modification of one, regular in M2's sense?

**Honesty rule:** REDUCE-C makes any statement at `k = 5` that implies REG-J′-C₅ equivalent to `χ_m⁰ ≥ 6`. Keep the colour-generic rungs colour-generic,
and report plainly if a rung turns out to hold only at `k ≥ 7`.

## Rules

- **Your record** is `plans/FS111-M3-finiteness.md` (the usual headings; SAVED stages). Working files go in `data/fs111/fs111-m3/`, tools in
  `tools/fs111_m3_*.py`, the report in `data/fs111/reports/FS111-M3.md`. Subjects are "FS111-M3: stage n", neutral.
- **Fences:** the session transcripts, `chats-bak/`, other agents' scratchpad files, `plans/FS111-close-inventory.md`, other briefs, and FS-114's files
  (`plans/FS114-*`, `data/fs114/`, `tools/fs114_*`).
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3): objects by formula, checked exactly; no search; keep the would-have-searched log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs111/reports/FS111-M3.md` and to `"main"`. Final text: "FS111-M3 idle; report sent to
  the owner by SendMessage".

Thank you.
