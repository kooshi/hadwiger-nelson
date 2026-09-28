# FS111-M4 — route M, round 4: the cascade (a pinch in a partition, and where it goes)

*Job FS111-M4 (de Bruijn, Opus 5.5), opened 2026-09-28. Brief: `data/fs111/briefs/M4-111-cascade.md`, which points to FS111-M's brief
`data/fs111/briefs/M-111-regularity.md` and to `data/fs111/briefs/STANDING-RULES.md` (rule 0 read first); where they differ the round-4 brief wins.
Working files: `data/fs111/fs111-m4/`; tools `tools/fs111_m4_*.py`. Saved in stages; each stage's section is headed "Stage n — SAVED" and committed
before the next begins. Notation: M3's (`plans/FS111-M3-finiteness.md` header and §1.6: HC, the edge frame, `g`, `ℓ`, `U`, `Λ_e`, the slivers) and
round 1's (`plans/FS111-M-regularity.md` §3: saturated, (H1), (H2), M-PINCH's (split) and (tangent) cases, M-C11). This record adds, for a closed set
`X` and `n > 0`, the **upper and lower `n`-parallels** of a graph `t = β(s)`: `β^{+n}(s) = sup{p_t + (n² − (s − p_s)²)^{1/2} : p ∈ graph β, |s − p_s| ≤ n}`
and `β^{−n}(s) = inf{p_t − (n² − (s − p_s)²)^{1/2} : …}` — the upper and lower boundaries of the `n`-neighbourhood of the graph (so `(β^{+1})^{+1} =
β^{+2}`, dilations composing).*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address)*

*(filled as stages land)*

## Would-have-searched-here log (standing rule 3)

- Stage 1: none.

## Fence log (standing rule 13)

- Stage 1: the start-up git status printed the names of four untracked W files (`data/fs111/fs111-w/blocks.out`, `hex7_free.out`, `hx_pairs.out`)
  and one FS-114 file name (`data/fs114/fs114-yb4/yb3-calib-rerun.out`), and `git log` printed FS-114 commit subjects: names and subjects only, nothing
  opened. No transcript, `chats-bak/` file, foreign scratchpad file, close inventory, other brief or FS-114 file was opened.

## Stage 1 — SAVED: resuming check; quotation check; the object named

### 1.0 Resuming check

`plans/FS111-M4-cascade.md` and `data/fs111/fs111-m4/` did not exist at start: fresh start at stage 1.

### 1.1 Files read, in order

The round-4 brief; `data/fs111/briefs/STANDING-RULES.md`; FS111-M's brief; `CLAUDE.md` § The aim and § Counter-priors (in context);
`plans/FS111-M3-finiteness.md` in full; `plans/FS111-M2-regularity.md` §1.4–§1.6 (M2-COV, M2-ZERO, M2-INT, M2-FIX, DISC7), §3.1–§3.3 (M2-SELCOMP,
M2-REDUCE-C), §4.1–§4.3 (M2-INTRAD, M2-DISCK7); `plans/FS111-M-regularity.md` §2 (M-SATC, R7, M-DEADLOCK) and §3.1–§3.5 (M-PINCH, M-C11, M-EXTREME,
controls); `plans/FS111-VM2-verification.md` (its REDUCE-C and D3 rows, by grep).

### 1.2 Quotation check (standing rule 5)

The round-4 brief puts no statement in quotation marks; its summaries of round 3 are paraphrases, checked against their sources:

| # | the brief's summary | source | verdict |
|---|---|---|---|
| 1 | HC_K: "a regular maximal unit-avoiding set whose bands pinch on a Cantor set, with infinitely many interior components per period" | M3 theorem line M3-HC: "infinitely many components of the interior in every disc of radius 3 about a face centre" | faithful (every period contains a face centre's disc of radius 3) |
| 2 | "MUA-FIN-U is FALSE, and local finiteness is not free" | M3-FIN-U | faithful |
| 3 | M3-MOVE: "one class alone can be moved, arbitrarily little, to remove its pinches" | M3-MOVE (1)–(3) | faithful |
| 4 | M3-COVER: "the move keeps it maximal exactly when the removed sliver is covered by other classes" | M3-COVER: "iff `L_τ ⊆ ⋃_{b ≠ j} F_b` a.e." | faithful |
| 5 | M3-CASCADE: "the class that absorbs the removed sliver must give up its own material at distance 1 from it, and so on" | M3-CASCADE: "every such `b` loses (a.e.) all of `F_b ∩ {φ_{G_b} > 0}`", `G_b = F′_b ∖ F_b` | faithful with one nuance: the source's gainer takes `G_b`, a positive-measure part of what was lost, not necessarily the whole sliver |
| 6 | "No partition containing an HC-type class is held" | M3 §3.3: "I have no regular maximal partition with an HC-type class" | faithful |
| 7 | "by M2-REDUCE-C (two minds) any statement at `k = 5` that yields a locally finite regular maximal five-cover is equivalent to `χ_m⁰ ≥ 6`" | VM2 §3 row 1 ("an equivalence at five given AE-MAP6 (both minds say so)"; VM2-EQ5) and M3 §3.1 | faithful, read as the conditional form ("if a maximal five-cover exists, a regular locally finite one exists"), over FS106-AE-MAP6's grade; VM2's D3 clause ("meeting only at endpoints") is part of "locally finite" |
| 8 | standing rules' quotations of Kooshi | `CLAUDE.md` § Counter-priors, § Toolchain, § Publication | verbatim (checked by M3 at its stage 1; the file is unchanged in those sections) |

### 1.3 The object of this round, named

A **regular maximal partition** is a `k`-tuple of regular MUA sets `F_1, …, F_k` with pairwise null overlaps and full union: a measurable fall colouring
(M2-ZERO's reading), and **saturated** (M2-SELCOMP (d)): every essential boundary point of a class is at distance exactly 1 from that class's support.
An **HC-type class** is one containing a **pinched layer**: over an interval `I` of a line, a region `{0 < t < β(s)}` (in coordinates with the line as
`t = 0`) of the class, bounded below by the flat segment and above by a graph `β ≥ 0` vanishing exactly on a closed null set `Z` with infinitely many
gaps. The brief's two questions are about how such a layer sits among the other classes. The instrument this round uses is round 1's M-PINCH: at a
saturated two-colour interface point it puts the two colours' contacts at distance 1 along the normal, one on each side, and the material near each
contact beyond the unit parallel. Applied to a pinched layer it gives a **ladder**: the pinch at distance 1 above and below, in the neighbouring
classes (stage 2), and a bound on how far the ladder can run before it meets the singular set (stage 3).

## Stage 1 — SAVED
