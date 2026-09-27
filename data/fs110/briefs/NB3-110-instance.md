*Instance block for job **FS110-NB3**, the round-3 blind verifier of the proof side. Its brief is `data/fs110/briefs/NB110-verify-proof.md`; this file
is part of it and is not fenced. Filled in by the product owner on 2026-09-27, when FS110-N3 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS110-NB3.
- **Your record** is `plans/FS110-NB3-verification.md`.
- **Your working directory** is `data/fs110/fs110-nb3/`.
- **Your tools** are `tools/fs110_nb3_*.py`.
- **Your commit subjects** are "FS110-NB3: stage n".
- **Your report** goes to `data/fs110/reports/FS110-NB3.md`.
- **Your scratch** is `scratchpad/fs110-nb3/`.

## Scope

- **The side verified:** the proof side's round 3, FS110-N3: its section "§ Continuation — FS110-N3" of `plans/FS110-N-proof.md`.
  - The whole record stays fenced until your stage 3 is committed, and so do its tools.
  - **Also fenced:** the earlier verifiers' records (FS110-NB, FS110-YB) and the round-3 construction verifier's (FS110-YB3).
- **What round 3 asks:** W-3, the winding question, is in `data/fs110/claims.md` §7, and its terms are defined in §7.1, which is open to you. **Read
  both first.**
- **The side's claimed verdict:** W-3 is a GAP at two named steps, G-CONE and G-d2, and NO given both. Its reduction N3-RED rests on W-MERGE, which is
  Woodall 1973's step 3 in the almost-everywhere, curved, Condition-5 setting. It also rests on FS106-V's repaired `[SokolovVoronov2025]` Cor. 1 for
  cubic maps (one mind, bar `d = 2`).
  - Woodall 1973 and S–V are held in `~/source/library/` (see the brief's reading list).
  - `plans/FS106-V-verification.md` is open to you for the Cor. 1 repair only (§ Continuation — FS106-V2).
- **Priority order:**
  1. **W-MERGE**, with N3-CONF, N3-CLEAR and N3-UP, its inputs.
  2. **N3-DEG:** does merging fail only in Woodall's cone?
  3. **N3-RED:** does W-MERGE plus Cor. 1 give it, and what exactly does it rest on?
  4. **N3-P17.**

  Run the brief's killing tests on W-MERGE's shape: the seven-colour controls, and Townsend's ⅔π sector. Also check whether a merge can land a
  recoloured point at distance exactly 1 from a tile of the same colour.

## The statements, quoted verbatim from the side's theorem table (FS110-N3)

| id | statement (one line) | grade | address |
|---|---|---|---|
| N3-CONF | at a point `v`, for a colour `c ∈ P_cl(v)`: every contact `w ∈ cl(C_c°) ∩ ω(v)` (finitely many, Condition 5) has all its `c`-tiles on one side of `ω(v)` (in-type or out-type), and every `c`-sector at `v` has its directions in `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}` | [hand, one mind] | stage 2, §2.1 |
| N3-CLEAR | for every compact set `Λ` of directions in `int D_c(v)` there is `ρ > 0` with `{v + rd : d ∈ Λ, 0 < r < ρ}` at distance `≠ 1` from every `c`-tile point | [hand, one mind] | §2.1 |
| N3-UP | at a tangent contact (`e_w ⊥ a`), in-type at `v + n` and out-type at `v − n` are both upward closed near `v`: a point clear of them stays clear when moved in the `+n` direction (lens `\|p\|² ≤ 2p_y`, lune `p_y ≤ −1/2`) | [hand, one mind; exact check `tools/fs110_n_merge.py` C1–C2] | §2.1 |
| W-MERGE | Woodall's step 3, almost everywhere, for curved arcs: if `int D_c(v) ≠ ∅`, any two non-adjacent `c`-sectors at `v` (positive angle or cusp horns) are joined by recolouring with `c` the sectors of the gap between them inside `D_c(v)`, within `B(v, ρ)`; the result is a full a.e.-proper colouring by a map with Condition 5, types only shrink, new vertices are cubic with distinct colours, and no other vertex's `D_c` changes | [hand, one mind] | §2.2 |
| N3-DEG | `int D_c(v) = ∅` only in **Woodall's cone**: `c` has out-type contacts at both `v ± n` (`n ⊥ a`), and every `c`-sector at `v` is a cusp horn along `±a` with bounding curvatures in `(−1, 1)` (strict by Condition 5) | [hand, one mind] | §2.3 |
| N3-P17 | under Condition 5 (and NB-4), no vertex with exactly three sectors has a purely rotating ring (six 60° arcs): the outward cone at a rotation point is bounded by an arc of `ω(σx)` lying in `Γ` | [hand, two derivations: `[SokolovVoronov2025]` Prop. 17 as repaired by FS106-V; this job through N2-ROT, N2-HEX and N-E2; exact geometry C5] | §2.4 |
| N3-RED | a tight six-map in `𝓜_K` under Condition 5 has, in every disc of radius 3, a hard Woodall-cone vertex or (after W-MERGE) S–V's `d = 2` configuration — given FS106-V's repaired S–V Cor. 1 (cubic maps, Condition 5; one mind, a sketch at Lemma 3 for `√3 ≤ d < 2`) | [hand, one mind, over FS106-V's one mind] | §2.5 |
