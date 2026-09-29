# FS121-V4 — a blind second mind on the cover route's lemmas (FS-121's list § 7.2)

*Job FS121-V4 (Ephodos in its verification form, Opus 5.5), opened 2026-09-29 07:18 UTC. Brief: `data/fs121/briefs/FS121-V4-verify.md`, with
`plans/STANDING-RULES.md`. Five statements, fixed in `data/fs121/claims.md` § 7.2 (frozen by Keryx 2026-09-29 07:06 UTC). Blind to every path the
brief's § Fences names until the verdicts on all five are committed. Working files: `data/fs121/v4/`. Tools: `tools/fs121_v4_*.py`. Every address
and control in this record resolves from `plans/`.*

## Theorems this phase proved

*(statement, grade, count of minds, address; "one mind" = this verifier, blind to the cover route's proof record until stage 2 is committed)*

- Stage 1 proves nothing: it is the readback and the registered expectations.

## Would-have-searched-here log (standing rule 5)

- Stage 1: nothing searched, nothing would have been.

## Fence log (standing rule 8)

- No fenced path read, opened or printed by a search. The brief's § Fences says "until your verdicts on all three statements are committed"; the
  brief carries five statements and its § After your verdicts says "all five": I read the fence as closed until all five verdicts are committed (the
  stricter reading). A slip in the brief, reported to the coordinator.

## Stage 1 — SAVED: the readback, what was given, and the registered expectations

### 1.1 Files read, in order (2026-09-29, 07:18–07:29 UTC)

1. `data/fs121/briefs/FS121-V4-verify.md` (the brief, in full).
2. `plans/STANDING-RULES.md` (in full); the head of `.claude/agents/ephodos-verifier.md` (my identity, loaded at launch).
3. `data/fs121/claims.md` (in full: §§ 0–7, including the statements other jobs work).
4. `plans/FS111-derivation.md`, the entries FS111-M-R7, FS111-VMW-R7-MAX, FS111-VMW-R7-PPLUS, FS111-M-R7-FORCE, FS111-W-SQ9, FS111-W-HEX9,
   FS111-W-KB-DIR, FS111-W-LADDER, FS111-W-HEXSAT, FS111-M2-DISC7 (lines 340–420, 640–720, 875–915): the control objects' definitions.
5. `plans/FS110-derivation.md` lines 60–100: FS110-N4-SHADOW (the maps `f`, `f̃`) and FS110-N4-FIN.
6. `plans/FS111-M-regularity.md` § 2.1 (the reading of "at distance exactly 1 from the support") and its section list.
7. `data/fs106/claims.md` D-NF (lines 39–52); `data/fs111/claims.md` line 37 (essential closure, essential boundary).
8. `plans/FS111-M2-regularity.md` § 1.6 (DISC7, the hex7 centres and colours) and § 3.2 (M2-REDUCE-C, whose step (1) is the merged map).
9. `plans/FS111-VM2-verification.md` lines 1–60 and the gate's `example-verification.md` (the record's form).

### 1.2 The readback (standing rule 3)

`tools/fs121_v4_quotes.py` compares each quotation in the brief with `data/fs121/claims.md`, whitespace normalised: **5 of 5 verbatim**
(`data/fs121/v4/quotes.out`); with one character planted in the first quotation it reports the miss and exits 1.

derivation: fs121-v4-readback
  statement: each of the five statements quoted in data/fs121/briefs/FS121-V4-verify.md occurs verbatim, up to whitespace, in data/fs121/claims.md
  uses only: string containment after collapsing whitespace
  not claimed: that the claim list's statements say what their authors meant; anything about their truth
  argument: § 1.2 The readback (standing rule 3)
  verdict: derived
  grade: computed over: the 5 quotations of the brief, {BOUND, GMAP, SAT, COVMAP, FLAT}
  minds: 1
  model: C121-C1-BOUND, the first quotation
  prior art: known: not applicable — a bookkeeping check
  handoff: none — a readback

control: fs121-v4-quotes
  of: fs121-v4-readback — the five quotations, verbatim
  run: python3 ../tools/fs121_v4_quotes.py ../data/fs121/briefs/FS121-V4-verify.md ../data/fs121/claims.md | tail -1
  expect: quotations: 5  verbatim: 5
  fault: python3 ../tools/fs121_v4_quotes.py ../data/fs121/briefs/FS121-V4-verify.md ../data/fs121/claims.md --plant | tail -1

**The five statements, restated as fixed** (verbatim from `data/fs121/claims.md` § 7.2; each `verification:` block at stage 2 quotes its
statement line character for character):

> - **C121-C1-BOUND** (this addendum): in a locally finite map colouring, a point `x` of `F_i ∖ S_i` is `i`-bound if and only if it lies on the outer unit
>   parallel or on the far level of a connected component of `F_i`.
>   *Not claimed:* which of the two levels, or that the component is unique. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9.

> - **C121-C1-GMAP** (this addendum): (i) for every `k`, a Grundy-bound `k`-colouring that is a.e. equal to a locally finite map colouring makes that map
>   colouring a member of `𝒫_k` under the order `1 < 2 < … < k`; (ii) G-FIN₆ and C121-NOPAR together imply `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆
>   holds if and only if `χ_m⁰(ℝ²) ≥ 7`.
>   *Not claimed:* G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring. *Inhabitants of (i):* `k = 7`, R7 (every class a MUA
>   set).

> - **C121-C1-SAT** (this addendum): for every `k`, a locally finite map colouring with `k` colours whose edges are finite chains of segments and circular
>   arcs, and whose classes form an honest saturated colouring, is a member of `𝒫_k` under every total order of its colours; so C121-NOPAR implies that no
>   honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs.
>   *Not claimed:* the converse (a member of `𝒫_k` need not be saturated). *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9.

> - **C121-C1-COVMAP** (this addendum): under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that
>   order, of a disc containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in `𝒫_7` under no order.
>   *Not claimed:* anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level). *Colours:* seven, a
>   statement about one object.

> - **C121-C1-FLAT** (this addendum): there are germs `L_k`, `U_k` at `P_k`, for every `k ∈ ℤ`, with `U_k > L_k` on both sides of `P_k`, every one of
>   curvature 0 at `P_k`, such that for every `k`: `L_k` is the unit parallel toward `P_k` of `L_{k+1}`, and `U_k` is the unit parallel toward `P_k` of
>   `U_{k−1}`. (So the relations `plans/FS110-derivation.md` states on circular arcs as "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤
>   f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", read on germs with `L_k` below the parallel of `L_{k+1}` and `U_k` above the parallel of `U_{k−1}`, hold with
>   equality for every `k`, and `λ_k = υ_k = 0`.)
>   *Not claimed:* that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries.
>   *Colours:* none (a statement about germs of curves).

— source: `data/fs121/claims.md` § 7.2 Lemmas (every `k`); definitions § 7.0 and § 0; held inputs § 1.

**Terms, and the reading I take.** One term is written two ways in the list, and its own "i.e." fixes it:
- **Bound** (§ 7.0): "a point `x` is **`j`-bound** when it is at distance exactly 1 from `F_j`, i.e. the unit circle `T₁(x)` about `x` meets `F_j`."
  Read as the set distance `d(x, F_j) = 1`, no point of `F_i` could be `i`-bound, so C121-C1-BOUND's "if" direction would fail at every point of every
  far level; read as the "i.e." clause, it is FS-111's established sense (`plans/FS111-M-regularity.md` § 2.1: "saturated" means "every essential
  boundary point is at distance exactly 1 from the support of each colour", where the point lies in that support). **I take the "i.e." reading
  throughout:** `x` is `j`-bound iff `T₁(x) ∩ F_j ≠ ∅`. The same reading for the Grundy clause ("at distance exactly 1 from the support of A_i") and for
  saturation. No question to the author: the definition fixes it; the wording is reported as a wording divergence if the first derivation leans on
  the other sense.
- **Essential boundary** (`data/fs111/claims.md` § 0): `∂_e S_j = {x : d̄_j(x) > 0} ∖ S̃_j`; every notion in "honest saturated" (densities, `P(x)`,
  supports) depends only on the classes up to null sets.
- **The merged map** (§ 7.0): the arrangement of DISC7's boundary circles, each face coloured by the least colour, in the chosen order, of a disc
  containing it — M2-REDUCE-C's step (1), without its step (3) clean-up. DISC7's centres and colours: `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`, colour
  `(m + 3n) mod 7` (`plans/FS111-M2-regularity.md` § 1.6).

### 1.3 What was given (the cut)

**Given before any verdict:** the five statements with their *not claimed* lines; the claim list's definitions (§§ 0, 7.0) and held inputs (§ 1),
with their grades; the claim list's other statements (§§ 2–7.1, including C121-NOPAR and the vacuity rule); the brief's framing ("Its cover route was
opened tonight and its NO stated"; "the five lemmas below relate that NO to the answer and to FS-116's question"; "Two are about objects given by
formula (DISC7's merged map; germs of curves)"; in § Fences, "FS-111's W-NOREP proof, which the first statement strengthens", and that two of the
five were passed to FS-116 as inputs); the held control objects' entries (R7, SQ9, HEX9, DISC7) and FS-110's N4-SHADOW and N4-FIN (§ 1.1). **Not
given:** any verdict, sketch, route or confidence of the cover route's author; nothing of FS121-C1's record or data. I held no prior knowledge of
these five lemmas; the objects' prior-art status is the held entries'.

**How informed the predictions are.** They were written at 07:29 UTC, after about eleven minutes of reading the definitions, during which a route for
each statement came to mind unbidden (for BOUND a connectedness argument on the components of `F_i`; for COVMAP a parity count over each disc's three
pairs of opposite neighbours; for FLAT a family of parallel curves). They are **informed, not naive**, and the sketches in my head count as mine, not
as given. No derivation was written before this commit.

### 1.4 The registered expectations (written before any derivation)

| statement | expected verdict | probability | the likeliest break |
|---|---|---|---|
| C121-C1-BOUND | derived | 0.85 | the "only if" direction: a component of `F_i` that reaches both inside and outside `T₁(x)`; the argument needs every component to be a chain of face closures, which needs faces to be locally finite — wild Jordan edges could break that |
| C121-C1-GMAP | derived | 0.85 | (i) rests on BOUND's "only if"; (ii)'s biconditional may be vacuous in one direction, or "six-colouring" may exclude colourings using fewer colours |
| C121-C1-SAT | derived | 0.80 | edge points where one side has density 0 (a cusp, or a corner of a chain): saturation says nothing there, and only a closure argument can reach them; "every total order" needs both colours bound, not just the smaller |
| C121-C1-COVMAP | derived | 0.85 | an order under which every edge point is bound by its smaller colour — i.e. an order with no colour lying between the colours of two opposite neighbours; or a merged-map edge that is not where I expect |
| C121-C1-FLAT | derived | 0.85 | whether the unit parallels stay `C^∞` graph germs with curvature exactly 0 for every `k ∈ ℤ` simultaneously, and whether the order `U_k > L_k` survives on both sides at every level |

Each prediction is scored at stage 2 against the committed verdict (the gate prints the Brier score).
