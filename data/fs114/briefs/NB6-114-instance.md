*Instance file for job **FS114-NB6**, the blind verifier of FS-114's proof side, round 5 (FS114-N6). The brief is the template
`data/fs114/briefs/NB114-verify-proof.md`, with the changes below. Written by the product owner, 2026-09-28. **Each statement is copied verbatim from
`plans/FS114-N6-proof.md`'s theorem table by a script**; grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-NB6-verification.md`. Working files go in `data/fs114/fs114-nb6/`, tools in `tools/fs114_nb6_*.py`, the report in
  `data/fs114/reports/FS114-NB6.md`. Subjects are "FS114-NB6: stage n", neutral. Final text: "FS114-NB6 idle; report sent to the owner by SendMessage".
- **Reading adds** the round cards `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`; `plans/FS114-N5-proof.md` and
  `plans/FS114-NB5-verification.md` (N5-PIN0, the pinwheel's region at radius `1 + ε`; N5-SIGHT; N5-BENDG: open to you); `plans/FS114-L60-audit.md`
  (FS112-L60 is "at most 60°"). For N6-MTP: Aldous–Lyons, *Processes on unimodular random networks* (2007), and Angel–Hutchcroft–Nachmias–Ray on
  unimodular random planar maps (held in `~/source/library/pdf/`); `plans/FS107-derivation.md` for `𝓜_K`.
- **Fences, until your stage 1 is committed:** `plans/FS114-N6-proof.md`, `data/fs114/fs114-n6/`, `tools/fs114_n6_*`. **Always:** every construction-side
  record, directory and tool (`plans/FS114-Y*`, `data/fs114/fs114-y*/`, `tools/fs114_y*`) and the construction verifiers' (`plans/FS114-YB*`,
  `data/fs114/fs114-yb*/`) — the construction side is working the pinwheel from its end, and your derivation must stay independent of it;
  `plans/FS114-close-inventory.md`; FS-111's files; the template's other fences.

## The statements

The **pinwheel**: a degree-4 vertex `p` of a non-Siamese valid map with four tactic edges, each tile at `p` inner for one edge (N5-PIN0's frame: centres
`q_j = p + e(θ_j + 90°)`, cones `α_j`). A **(Q) arc** of the ring `ω(p)` is a boundary arc along `ω(p)` whose outer colour is carried at `p` (FS-112's (Q)
type; N5-BENDG).

1. **N6-KAPPA** — At a four-colour vertex after the bends, `κ(θ + 60°) = κ̄(θ)` wherever both are defined (`κ`: ring tile colour, or an (R2) arc's inner colour)
2. **N6-WIN** — **The window lemma**: at a `κ`-change point `y` (`Ā | A`), if `κ` is defined just beyond `y + 60°`, the window `(y, y + 60°)` carries no `Ā` and all its `A`-contacts are one tile, which reaches `y + 60°` (a change point when `κ` is defined just before it too); mirror for `(y − 60°, y)`
3. **N6-RING60** — A four-colour vertex whose ring carries no (Q) arc has ring change points exactly `y + 60°ℤ`: six ring tiles alternating the absent colours, each spanning a closed 60° arc
4. **N6-NOQ** — **No pinwheel has a ring free of (Q) arcs** (after the bends); in particular none with a `Γ`-free ring, at radius `1 + ε`. *(Stage 2's added clause "and the pinwheel `α ≡ 90°`" is withdrawn: N6-QOUT admits (Q) arcs there.)* Proof corrected in §3.1: a 60° cone forces the next cone below 120° (N6-P60′), so all four would be 60°
5. **N6-PIN** — K1-PIN after stage 3: the pinwheel is excluded at radius `1 + ε` unless its ring carries (Q) arcs of N6-QOUT's kind; **GAP** there
6. **N6-P60′** — *(Stage 2's N6-P60, "a 60° cone is impossible", is withdrawn: its step 1 misread the Reuleaux triangle's corner cone as 60°; it is 120°.)* If `α_{j+1} = 60°` and `κ` is defined on the two 60° windows beside `q_j`, then `T_{j+2}` reaches `q_j`, lies in `Reul(p, q_j, q_{j+1})`, borders the whole side `e_{j+1}` from `p` to `q_j`, and `α_{j+1} + α_{j+2} < 180°`
7. **N6-ADJ** — If `T_{j+2}` reaches `q_j` then `α_{j+1} = 60°` and `α_{j+1} + α_{j+2} < 180°`
8. **N6-QOUT** — A (Q) arc on the pinwheel's ring has inner `T_{j+1}`, lies in `[φ_j − min(60°, 180° − α_{j+1}), φ_j + min(0, α_{j+1} + α_{j+2} − 180°)]`, and has outer colour `c_{j+3}` (outer `c_j`, `c_{j+2}` impossible by U1)
9. **N6-QE1** — If `α_{j+1} ∈ (60°, 120°)`, no (Q) arc of `T_{j+2}` (outer colour `c_j`) holds `e(φ_j + 60°)` inside: `ω(q_j)` would enter a `c_j`-tile (N-E1 at `q_j`, which carries `c_j` by `z_j`); the pinwheel `α ≡ 90°` with full-zone (Q) arcs dies
10. **N6-PIN180** — In the pinwheel every cone satisfies `60° ≤ α_j < 180°`: a 180° cone would put `T_{j+1}`'s sector outside `B̄(q_j, 1)` beside `e_{j+1}`
11. **N6-CENT** — At a non-Siamese degree-4 vertex whose ring carries no (Q) arc (after the bends), all tactic centres lie in one class mod 60°: every cone between tactic edges is a multiple of 60°, and a lens is Reuleaux or `γ = 0°`; **non-Reuleaux lenses need a (Q) arc**
12. **N6-COV** — At a tactic centre that is a change point with `κ` defined on both windows beside it, the directions toward `p` are covered only by `p`'s own tiles reaching it; a unit gap between consecutive centres of one tile pushes that tile aside and forces a neighbour into a Reuleaux triangle on `p`
13. **N6-MTP** — For every `K`, a valid map in `𝓜_K` has a stationary random valid map in its hull whose Palm version is unimodular and hyperfinite, so of average curvature zero (Euler in expectation, pinch points included by multiplicity); route T's counts and N3-JOINT's assignment (a mass transport) hold as intensity identities: the aperiodic averaging step for Q-full_K closes by printed theorems; GAP-μ, K1, K2-loc, the Siamese class and unbounded complexity are untouched

**Priority:** N6-WIN, N6-RING60 and N6-NOQ first — they close K1-PIN outside (Q) rings at radius `1 + ε`, and the side's own stage-2 slip (a Reuleaux
corner cone taken as 60°, not 120°) was in this chain: audit them at the rate of a result you would want false. Then the rest; N6-MTP last, as a separate
question (does a valid map in `𝓜_K` have a stationary hull whose Palm version is unimodular and hyperfinite, with average curvature 0?).
