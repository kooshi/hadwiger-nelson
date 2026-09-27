*Instance block for job **FS110-YB3**, the round-3 blind verifier of the construction side. Its brief is `data/fs110/briefs/YB110-verify-construction.md`;
this file is part of it and is not fenced. Filled in by the product owner on 2026-09-27, when FS110-Y3 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS110-YB3.
- **Your record** is `plans/FS110-YB3-verification.md`.
- **Your working directory** is `data/fs110/fs110-yb3/`.
- **Your tools** are `tools/fs110_yb3_*.py`.
- **Your commit subjects** are "FS110-YB3: stage n".
- **Your report** goes to `data/fs110/reports/FS110-YB3.md`.
- **Your scratch** is `scratchpad/fs110-yb3/`.

## Scope

- **The side verified:** the construction side's round 3, FS110-Y3: its section "§ Continuation — FS110-Y3" of `plans/FS110-Y-construction.md`.
  That whole record stays fenced until your stage 3 is committed. So do its tools, **the earlier verifier FS110-YB's record**, and FS110-NB's.
- **What round 3 asks.** The question is W-3, the winding question, in `data/fs110/claims.md` §7. Its terms are defined in §7.1, which is open to
  you. **Read both first.**
- **The side's claimed verdict on W-3:** no winding map was built, so there is no YES. Its results are obstructions.
- **Priority order:**
  1. **Y3-BOW.** The side asks whether its single homotopy along both `b|a` edges meets the rigour of N2-TRANS's nerve step.
  2. **Y3-PROP**, including "`|W|` is one constant on a connected map".
  3. **Y3-SIX.**
  4. **Y3-GP**, with its exact ring check. Rebuild the rings from the statement with your own checker.
  5. **Y3-FLIP** and **Y3-C5**.

## The statements, quoted verbatim from the side's theorem list (FS110-Y3)

- **Y3-RING** — `tools/fs110_y_ring.py`: Y3-GP checked exactly on six named rings (three aligned, three in general position, `W = 0, 2, 3, 3, −3, 9`),
  two plants each firing for its own reason — [tools, exact], stage 9.
- **Y3-C5** — in `𝓜_K`, the print's Condition 5 and "no boundary arc of radius 1" coincide — [hand, one mind, trivial], above.
- **Y3-GP** — a ring (§7.1's) whose change points are never at angular distance `≡ 0 (mod 60°)` from one another winds `W ≡ 3 (mod 6)`; so
  `W ∈ {0, ±1, ±2}` needs two change points at distance 1, `√3` or 2 — [hand, one mind; `tools/fs110_y_ring.py` checks it on named rings], §8.2.
- **Y3-PROP** — N2-TRANS rederived from NB-4 and NB-5 at both ends of the edge, at every vertex with `|P_cl| = 3` (bowties included) and through
  bichromatic vertices on edges of one colour pair; `|W|` is one constant on a connected map — [hand, one mind; N2-TRANS's second derivation], §8.3.
- **Y3-FLIP** — a tile with all boundary vertices of type `{a, b_{i−1}, b_i}` returns the ring orientation with sign `(−1)^k`, `k` the same-type steps
  — [hand, one mind, derived before §7.1 arrived; agrees with N2-FLIP's statement], §8.3.
- **Y3-BOW** — at a bowtie `(a, b, a, c)`, tile `b`'s flanking vertices `{a, b, x}`, `{a, b, y}` (next trichromatic vertices along its two `b|a` edges)
  satisfy `x = y` or `c ∈ {x, y}` in a winding map, else `W = 0`; so the bowtie counts as one merged neighbour of tile `b`, a same-type step iff
  `x = y` — the count extended to bowtie-flanked tiles — [hand, one mind], §8.4.
- **Y3-SIX** — no vertex of degree 3 with three essential sectors has a ring of exactly six arcs (the aligned `|W| = 2` ring), in a tight six-map in
  `𝓜_K` under Condition 5 with NB-4 and NB-5 — [hand, one mind; the distances exact], §8.5.

### Fence log (FS110-Y3)

- **Touch 1 (10:4x UTC, disclosed):** an `rg -l` for the round-2 labels "N2-TRANS|N2-FLIP|N2-SWAP", with the fenced paths excluded, returned the
  **file name** `tools/fs110_nb_ring.py` (the blind verifier NB's tool, which my exclusion list missed: it named `tools/fs110_n_*` only). No content
