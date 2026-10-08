# Shifted-sequence colourings of the 23 board — a tangent from the puzzle (2026-10-07)

Kooshi's idea, from playing `visualizations/unit-step-puzzle/`: fill the board deterministically — place a colour, move
by one clash step, place the next colour, repeat. Made exact as a family: **one master sequence `W` of `q` colours laid
along a direction `v`; each of the `q` lines parallel to `v` carries it from its own offset `g(u)`**,
`c(t·v + u·w) = W[(t + g(u)) mod q]`. Straight stripes are the case `g` linear. Up to the graph's symmetries there are
two direction types (`v` a multiple of a clash step, or not); both are run.

Run by Keryx in the search role, at Kooshi's word, outside any milestone. **Not filed** (no ledger row, no queue line).

| board `q` | least colours in the family | straight stripes (row 101) | the board's own number |
|---|---|---|---|
| 7 | 4 | 4 | 4 |
| 11 | 6 | 6 | 5 |
| 19 | 5 | 5 | 5 |
| 23 | **8** | 8 | 6, 7 or 8 (open) |

At 23: no choice of offsets lets one colour sit at four positions of the sequence (a class of 92 cells) — UNSAT for both
direction types — so each colour holds at most 69 cells and seven colours cannot cover 529; the seven-colour instance is
UNSAT directly as well. Eight is found.

**Grade**: [tools], one mind. Every colouring found is re-checked cell by cell against the 24 steps. The "no" answers at
23 are the solver's word (kissat 4.0.4), no proof logged or checked. Controls: `offsets_search.py` (a plain backtrack
over offsets, exhaustive, no solver) and `offsets_sat.py` (one SAT instance per case) agree at 7, 11 and 19, on both the
yes and the no side; the family's 6 at 11 and 8 at 23 equal row 101's values for straight stripes.

**A remark, by hand, unchecked by a second mind**: a colouring of the 23 board with fewer than 23 colours that satisfies
`c(x + s) = π(c(x))` for a nonzero `s` and a permutation `π` of the colours has `π = id` on the colours used (`π²³ = id`
there, and a permutation of fewer than 23 things with every cycle length dividing 23 is the identity), so it is constant
along `s` — a function of one linear form, a straight stripe colouring. With row 101: **a colouring of the 23 board with
at most seven colours has no translation symmetry, even up to a permutation of colours.**

Files: `offsets_search.py` (run on 7, 11, 19; too slow at 23 in Python, stopped), `offsets_sat.py`, `out/q23-sat.txt`.
Reproduce: `python3 scripts/slot.py --mem 4 --name puzzle23 -- python3 data/puzzle23/offsets_sat.py 23 col 7` (about
four minutes) and `… 23 cls 4` (seconds).

## How many cells can one colour hold? (same day, second tangent; `one_colour.py`)

Kooshi: "It feels like the largest independent set could be solved by exhaustive exact search (with pruning and other
optimizations) by a more traditional computer science algo rather than SAT."

**The number that matters is 88.** 529 = 6·88 + 1, so six colours need one colour on at least 89 cells: **if no clash-free
set of 89 cells exists, the 23 board needs at least seven colours** (row 69's window would lose 23). Seven colours need
only 76. The certificate's ceiling is 105 (row 71).

| instrument | result | grade |
|---|---|---|
| exact branch and bound inside rotation-invariant families (order of the rotation: 24, 12, 8, 6) | best unions of orbits: 73, **85**, 81, 85 cells | exact within each family; sets re-checked |
| the same at order 4 | at least 85 | node cap hit — a lower bound only |
| tabu local search over all sets, 13 runs (7 from the stripes class of 69, 6 from random maximal sets of 62–64) | **87 cells in every run**, within about a second; **88 in none**, about 6–8 million swap moves each | a lower bound: α(Γ₂₃) ≥ 87, each set re-checked cell by cell (`out/one-colour*.txt` hold the sets) |

**What is and is not established.** Held at [tools]: a clash-free set of 87 cells exists, so α(Γ₂₃) ∈ [87, 105].
**Not established: that 87 is the maximum.** That every run stops at exactly 87 is a reading, with its killing test — one
clash-free set of 88. No earlier record of a lower bound on α(Γ₂₃) was found in a quick search of the ledger and the
grokkings (not a full check).

**What an exact answer would take** (unbudgeted, unqueued; a search-lane job when the budget returns): decide whether a
clash-free set of 89 cells exists. Notes for whoever plans it: (1) the board is vertex-transitive, so fix the origin in
the set and use the 48 symmetries fixing it; (2) the cheap bounds are far off — the largest clique is a triangle, so a
clique-cover bound is a third of what is left, and the certificate's 105 is final for its instrument — so plain branch
and bound will not prune until very deep; (3) for a vertex-transitive graph, α(Γ)/529 ≤ α(H)/|H| for every set of cells
H, so one piece H with an exactly computed α(H) < 0.1682·|H| proves it; because 87/529 = 0.1645 the piece must be nearly
as hard as the board (for a union of j parallel no-clash lines, j·3.783 ≤ α(H) < j·3.870: no integer fits below j = 10;
at j = 10 it would have to be exactly 38 of 230 cells, and that would give α = 87 outright); (4) Russian-doll search over
nested unions of lines is the classical algorithm of this shape.

**Corrections, same evening (found while fixing the claim list for the tool's planner).** (1) "No earlier record of a
lower bound" is wrong for the sibling repository: its independent-set tool already holds 87 at 23, sixteen threads
agreeing (`/home/kooshi/source/descent-engine/plans/WO-18-outcome.md` § 2.3) — measured there against the 106 that five
colours need, not against the 89 that six need. (2) "no integer fits below j = 10" is false: `87j/23 ≤ α(H) < 89j/23`
has the integer solutions 19, 23, 27 at j = 5, 6, 7 as well; j = 5 is out for whole lines, because one whole line is
already 23 clash-free cells. The corrected statement is `data/puzzle23/claims.md` S5.

## The tool (Kooshi's word, `REQUEST.md` K3) — state

- What it must decide is fixed in `claims.md` (D1–D3, S1–S6). S3–S5 are one mind's, by hand, unchecked.
- **The planner is launched** (21:5x UTC, 2026-10-07; job WO22-FP1, the Rust engineer of the sibling repository, Opus;
  brief `briefs/WO22-FP1-exact-independence-plan.md`, gate pass, generator `briefs/mk-wo22-fp1.py`). Its record will be
  in the sibling repository: `/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md` (it may rename it).
  It writes there and under that repository's `scratch/wo22/` only, commits locally, and does not push — the product
  owner (this session) reviews and pushes.
- **Next, at its hand-back**: review the plan by artifact (the commits exist; one measurement re-run); any statement it
  found false is corrected in `claims.md` by a dated line; then the implementer's brief (a fresh mind of the same agent
  type, on the plan), on the pattern of the planner's generator. The decisive run is DECIDE(23, 89).
- The milestone handoff (`plans/SESSION-HANDOFF-2026-10-07.md`) is untouched at Kooshi's word; this section is this
  tangent's handoff.
- **The planner's stage 2 (its message 22:3x UTC; sibling repository commits `79ba60c`, `9312378`, `f911ee5`, local, unpushed): the measurements replace the proposed method.** As reported: (1) "S5's pieces do not exist. No six lines clash pairwise, so every union of 6 to 11 whole lines holds two whole lines (alpha >= 46, above every window); at j = 12 the two candidate line sets both hold a 47-set; at j <= 5 the least alpha is 23, 23, 23, 30, 33 against windows topping out at 19.35. A piece that works is the board minus a few cells." (2) "Plain exhaustive search (one cell fixed, clique-cover bound): NO at q = 7, 11, 13 in 0.00 s, 0.02 s, 10 s (alpha(13) = 39 exactly). kissat needs 16 s where that needs 0.02 s. Estimated tree at 23/89: 10^16.7 nodes." (3) a split by the pair of least difference class: "At 23/89 every branch but the first is trivial — 'no clash-free 89-set avoids squared distance 2' is about 1.4e8 nodes, under an hour — and the whole cost is the branch with such a pair present: sampled at >= 6.5e15 nodes, about 38,000 core-days at an engineered 0.5 us per node. 19/77 is 1e10 to 5e11 nodes: hours." (4) the design it is now writing: "whole board, not pieces; a proof log checked by a separate checker as it is produced …; a built-in estimator so a long run is priced before it is spent; and the levers not yet tried, in order." Its slip, as reported: one stray prototype run outside the slot tool, six seconds on one core, stopped by PID. **My receipt**: the three commits exist; my own short computation gives the largest set of pairwise-clashing lines at 23 as 5 (e.g. line indices 0, 3, 8, 13, 16 for `3x + 5y`), so no six — its point (1) stands on that; the tree sizes and the 38,000 core-days are as reported, unchecked. **So: Kooshi's exhaustive search is instant on small boards and hours at 19; the decisive question at 23 is priced at two to three orders of magnitude beyond the desktop with the engine as measured.** Decision owed to Kooshi at the planner's hand-back: build as designed (with the estimator and the untried levers), ask for the 256-core server, or stop.
- **A slip of mine, corrected**: the times in this section ("21:5x UTC", "22:0x UTC", "22:3x UTC", 2026-10-07) were written from memory and are wrong. By the commits: the planner's brief and launch were at 02:22 UTC on 2026-10-08, the dated correction to the statement list at 02:33 UTC, the planner's measurements logged at 03:02 UTC.
- **A second correction to "what is new" (2026-10-08 03:17 UTC)**: the arithmetic "six colours need a class of 89, and 87 is what is held" was also already on record in the sibling repository — its colouring tool prints exactly that warning when a class of 87 is fixed at `p = 23, k = 6` (`/home/kooshi/source/descent-engine/crates/plane-colour/README.md` § Peel and colour, ll. 160–172, naming "the campaign's 87-point set"). So neither the 87 nor the 89 is this evening's. What is this evening's: the shifted-sequence family exhausted at 23 (eight), the exact values inside the rotation families (73, 85, 81, 85), that the sub-board route by whole lines is dead (no six lines clash pairwise; the planner's finding, re-checked by me), and the planner's price for the exhaustive search.
- **Kooshi's GPU idea (`REQUEST.md` K4) passed to the planner as Amendment 1 of its brief (2026-10-08 03:17 UTC; gate run on the amended brief)**: a lever to price in the design, not to build. This machine has graphics card A (32 GB) and graphics card B (24 GB).
- **The planner handed back (2026-10-08 03:19 UTC logged; "JOB WO22-FP1 — DONE (planned and modeled; nothing implemented, nothing pushed)"; 417k by the harness's count).** Record: `/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md` (84 KB); commits `79ba60c`, `9312378`, `f911ee5`, `88c55e6`, `c3b196c`, `e184c25`, `87bf103`; a stub for the follow-on, `plans/WO-23-levers-for-23-at-89.md`, in the same repository. **Its headline**: "as measured, it cannot decide the 23 board at 89 on this desktop — short by a factor of about 300 against a week's run — and S4's method (pieces, Russian dolls over lines) does not work at all. It can decide 19 at 77 in hours, and at 23 it can prove one real partial statement in under an hour." **Not established, in its words**: "'every clash-free 89-set at 23 contains two cells at squared distance 2' is estimated to be provable in under an hour, not proved"; "The estimator is good to an order of magnitude only. Nothing was measured at 27 (the prototypes are prime-only)." **The design**: two crates, a solver (`plane-exact`) and a checker that depends on no workspace crate (`plane-exact-check`); one kind of statement — a cell set holds no m pairwise non-adjacent cells when clashes and some difference classes are forbidden — with six rules; the proof streams through the checker as it is produced; a journal per sub-search, any kill harmless, the same command resumes; a built-in estimate verb. **My receipt**: the seven commits exist and are pushed by me to that repository's origin after this review (2026-10-08 03:19 UTC); I re-ran one measurement under the slot — `./proto decide 13 40`: "NO … nodes 26874106 ; 10.53s", as its table says; the follow-on stub read. **Not read by me: the plan itself (84 KB)** — the hand-back's decision list is what I ruled from.
- **Rulings on its five decisions.** (1) A large NO keeps the hash of each sub-proof, checked in-run, not the proof — **stands, with a grade attached**: a NO whose proof is stored whole and accepted by the checker is a certificate; a NO checked in-run with proofs dropped is [tools] (a run with a checked log), and every record says which — alternative: require the proof on disk (terabytes at the sizes that matter), declined; confidence medium-high; this reads S1's "a certificate that a separate small checker accepts" as met only by the stored kind. (2) This work order stops at the engine as measured and the speed-ups are the follow-on — **Kooshi's** (scope and budget): told to him with my recommendation. (3) The checker builds each cover itself from a named procedure — accepted; the listed form exists for an outside re-check. (4) S4 replaced by the whole board split by difference class — accepted: the brief gave the freedom and the measurements say so. (5) The solver depends on the reactor crate, against that repository's architecture note — accepted, the implementer updates the note; alternative: a private loop; confidence medium. Its files beyond the brief's touches (a gitignore line, three deferred items, the follow-on stub) — kept: its repository's workflow requires them. Its slips (one stray process, three runs past a minute outside the slot, memory negligible) — logged as reported.
- **Amendment 1 (the GPU as a lever) never reached the planner**: it handed back before the one-line message was sent. No resume (417k). **It goes into the follow-on's planning brief as a sixth lever to price**, with Kooshi's words (`REQUEST.md` K4).
- **Next, on Kooshi's word**: the implementer's brief (a fresh mind of the same agent type, on the plan; generator on the pattern of `briefs/mk-wo22-fp1.py`). Not launched: the plan's headline changes what the tool will be able to answer, and the weekly budget is nearly spent.
- **A third correction on "what was already known" (2026-10-08 03:22 UTC)**: the ledger itself holds the bracket — row 75: `α(Γ₂₃) ≤ 97` "(was 105; bracket [87, 97])" and `α(Γ₁₉) ∈ {76, 77}`. My search of the ledger earlier used too narrow a pattern and missed it. So the floor 87 and a ceiling of 97, not 105, were both on file before this evening; the dated line in `claims.md` corrects S6.

## ENDED (2026-10-08 03:25 UTC) — Kooshi: "nah, not worth it. […] we'll go back to the frontier. end tangent."

The exact tool is **not built** and no implementer is launched. Its plan and the follow-on stub stay in the sibling repository as a record, each headed by the decision (`/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md`, `plans/WO-23-levers-for-23-at-89.md` there; pushed). Nothing of this tangent is filed in the ledger, the search queue or the front page, and nothing is owed from it. What it leaves, each at its grade above: the shifted-sequence family needs eight at 23; a colouring of the 23 board with at most seven colours has no translation symmetry (by hand, one mind); the exact values inside the rotation families; no six no-clash lines of the 23 board clash pairwise, so no sub-board made of whole lines decides it; exhaustive search for a set of 89 at 23 is priced at about 38,000 core-days as measured (the planner's estimate, order of magnitude); the ledger's own bracket at 23 is [87, 97] (row 75). The puzzle page is unchanged.
