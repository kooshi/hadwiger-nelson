# FS114-YB4 — blind verification of FS-114's construction side, round 5 (FS114-Y5: the pinwheel)

*Job FS114-YB4, de Bruijn on Opus 5.5, launched 2026-09-28 about 11:56 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB4-114-instance.md` (read from disk; its changes win) and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory or tool of this job existed at start. Working files `data/fs114/fs114-yb4/`; tools
`tools/fs114_yb4_*.py`; scratch `scratchpad/fs114-yb4/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y5-construction.md`, `data/fs114/fs114-y5/` or
`tools/fs114_y5_*`.*

## Theorems this phase proved

*(Filled at the end of stage 1b and after stage 2.)*

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status and standing rules; nothing about FS114-Y5's statements
   or proofs. No file under that path was opened by me. One of my own reads (`plans/FS114-Y4-construction.md` by `cat`) was too long for the
   terminal, and the harness saved its output under that path; I did not open the saved copy and re-read the file with the Read tool instead.
2. **The harness's start-up git snapshot** printed five commit subjects (`FS114-Y5: report`, `FS-114 inventory`, `FS114-Y5: stage 4 (wording)`,
   `FS114-Y5: stage 4`, `FS114-NB6: stage 1a`) and FS-111's untracked `data/fs111/fs111-w/*.out` names. Subjects and names only.
3. My start-up `git log --oneline -8` printed one subject beyond the snapshot (`f606c30c FS-114 inventory; verifier instance`) and two older FS-111
   subjects (`FS111-M3: stage 2 …`). Subjects only; no further `git log`, no `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` listed by **name** the fenced directories (`fs114-n` … `fs114-n6`, `fs114-nb*`, `fs114-y5`, `fs114-cv*`,
   `reports`) and briefs (the proof side's, the verifiers', `Y5-114-construction-round5.md`, …). `ls tools/fs114_yb*` listed only the YB tools. Nothing
   fenced opened, listed inside or grepped.
5. `plans/FS114-L60-audit.md` (open to me by the instance) was read at its header, theorem table and fence log only (lines 1–60); its later sections
   discuss proof-side records and were not read.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full** (its § Reading's sources — FS-112's close, the printed local NOs, the Google group, two papers —
  are **not re-read this round**; what bears on the pinwheel is in the FS-112 entries and round records below).
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y4-construction.md` **in full**; `plans/FS114-YB3-verification.md` header, theorem table, fence log, stage 1a and stage 1b through
  YB3-W (lines 1–160); `plans/FS114-YB2-verification.md` by headings only (its content reaches me through YB3 and Y4, which cite it).
  Tools: `tools/fs114_yb_quotes.py` header (run unedited).
- `plans/FS112-derivation.md`: header, FS112-WALK, FS112-U1, FS112-SIX, FS112-NB4P, FS112-A4SIX, FS112-L60, FS112-LOCK's statement, FS112-N3-NOBOTH,
  N3-FAIL, N3-ANTI, **FS112-N3-COR3**, N3-PAIRS entries **in full** (lines 1–70, 140–168).
- `plans/FS114-L60-audit.md`: header, theorem table and fence log (lines 1–60).
- **Not read:** every fenced file.

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb4/quotes.tsv`, through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**16 of 16 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); the instance's "at most 60°" and L60-LE in
`plans/FS114-L60-audit.md`; the instance's definition of **simple** against `plans/FS114-Y4-construction.md`'s header (the one unfenced file carrying it);
the Siamese and valid-map definitions, C114-LOCAL-F and the claim list's "possible object" sentence against `data/fs114/claims.md`; FS112-U1 against
`plans/FS112-derivation.md`; K1-PIN against the round-4 card; K1 against the round-2 card; Y2-GAPS against the round-3 card. The tool's self-test PASSED
(`quotes-selftest.out`); my two plants (one word changed in SIMPLE; FS112-L60 read as "at most" in FS-112's own file, which says "below") read
**MISSING** (`quotes-plant.out`, exit 1).

**Not checkable in stage 1:** the twelve statements, copied by the owner's script from `plans/FS114-Y5-construction.md` (fenced until stage 1 is
committed): stage 2's first step. The instance's glosses of **tactic edge**, **pinwheel**, **ring** and **non-Siamese** have fenced sources (the proof
side's records) or none; I work them as the instance states them. **Non-Siamese** is read as the instance glosses it (closures at distance at least 1),
the reading FS114-YB2 and FS114-YB3 used; de Grey's words ("tiles that lie entirely within each other's annulus of exclusion") are the same condition.

### 1a.3 Reading points fixed before any verdict (my notation; the instance leaves them implicit)

- `p = 0`; `e(φ)` the unit vector at angle `φ`, counter-clockwise. The pinwheel's edges `e_1, …, e_4` leave `p` counter-clockwise at directions
  `d_1 < d_2 < d_3 < d_4`; blade `t_k` fills the sector `[d_{k−1}, d_k]` at `p` and has colour `k` (four tiles at a vertex of a non-Siamese map have four
  colours). **Orientation:** "blade `t_{j+1}` whose clockwise edge `j`" and "each tile at `p` inner for one edge" force every edge's inner side to be its
  counter-clockwise side (the mirror pinwheel is the reflection): edge `k` is a unit arc of `ω(q_k)`, `q_k = e(d_k + 90°)`, with inner tile `t_{k+1}` and
  outer tile `t_k`; so the tactic tile `T_k` at `q_k` has colour `k` (the outer colour), matching the instance's "`T_k` (`k`)" and "`O_k` (colour `k − 1`)".
- **Cones.** `α_k` is read as blade `t_k`'s sector at `p`, `α_k = d_k − d_{k−1}`, `Σα_k = 360°` ("blade `t_j`, … cones `α_j`"). Centre `q_k` sits between
  `t_k` (cone `α_k`) and `t_{k+1}` (cone `α_{k+1}`); so `|q_{k−1} − q_k| = 2 sin(α_k/2)` and `arg q_k = arg q_{k−1} + α_k`. `φ_k := arg q_k`.
- **Edge ends and sides.** `ℓ_k ∈ (0°, 60°]` is edge `k`'s angular length about `q_k` (L60-LE); `w_k` its far end, `|w_k| = 2 sin(ℓ_k/2)`. Blade
  `t_{k+1}`'s boundary: edge `k` (clockwise), then its clockwise side `L_k` from `w_k` to `q_k` — an **inside part** `L_k^in` from `w_k` to the ring
  point `r_k` where it meets `ω(p)`, then the ring from `r_k` counter-clockwise to `q_k` (angle `λ_k`, "borders the ring clockwise from `q_k` for
  `λ_k`") — and its counter-clockwise side `M_k` from `q_k` to `w_{k+1}`, then edge `k + 1` (where `t_{k+1}` is the outer tile) back to `p`.
- **Pockets.** `P_k` is the region inside `B(p, 1)` bounded by `M_k`, `L_{k+1}^in` and the ring from `q_k` to `r_{k+1}`; `μ_k` (colour `m_k`) the 5/6 tile
  along `M_k`, `Λ_{k+1}` the one along `L_{k+1}^in`. **E1**: some `ℓ_k = 60°`. **E2**: some `M_{k+1} ⊂ ω(w_{k+1})`. **Bordering** means sharing a boundary
  arc of positive length. `v_{k+1}` is read as `e(φ_k + 60°)`, the ring point `60°` counter-clockwise of `q_k`, as the statement writes it; `β_k`, `t`,
  `t′` are not defined in my brief and are read where they occur.

## Stage 1a — SAVED
