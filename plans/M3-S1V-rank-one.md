# M3 S1V — blind verification of the rank-one claims (crunch job J20)

*De Bruijn, blind verifier, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J20-M3-rank-one-verifier.md` (with
`STANDING-RULES.md`). The claims verified are the brief's fixed list (A-T1, A-T1′, A-T2, A-K0, A-K1, A-K2, A-Kq, A-K3, A-C) and,
added by the owner's launch message, J19's three (J19-KC, J19-FRZ, J19-KEF). Fenced and unopened: J18's and J19's records, tools, data,
briefs and reports; `plans/M3-exotic-colourings.md`; `plans/M3-close-inventory.md`; `plans/CRUNCH-2026-09-25-INDEX.md`; J18/J19
commits' contents. No fenced file has been opened.*

## Theorems this phase proved

All in this record, §2 (stage 2) unless marked. "W" is the window-state graph of the brief, not quotiented.
- **J20-W** [hand; Lind–Marcus §2.2–2.3] — `W` is essential; its bi-infinite paths are exactly the points of `X₄(D)` (§2.1).
- **J20-E1** [hand] — `X₄(D)` is finite iff every phase is rigid and no wall exists (§2.1).
- **J20-E2** [hand; Lind–Marcus Thm 4.3.1 and §4.4 (Perron–Frobenius)] — `h(X₄(D)) > 0` iff some phase is not rigid (§2.1).
- **J20-T35W** [hand] — FS79-T35 re-derived on the unquotiented `W`, `X₄(D) = ∅` included (§2.1).
- **J20-EQ** [hand] — for each `D`: A-T1 ⟺ A-T1′ ⟺ A-T2 ⟺ A-K3; and A-C ⟺ `∃D ¬A-T1(D)` (§2.1).
- **J20-RET** [hand] — a point whose two tails lie in one rigid phase is the periodic point of that phase, up to shift (§2.2).
- **J20-K0, J20-K1, J20-K2** [hand] — A-K0, A-K1, A-K2 as stated (§2.2).
- **J20-Q** [hand + tools exact] — A-Kq: `W` all rigid ⟹ the quotient all rigid, for every quotient; the converse holds for FS-79's
  transfer quotient and **fails for the orbit quotient at `D = {1}` and `D = {1,2}`**; the wall clause holds for every quotient (§2.3;
  `tools/crunch_j20_checks.py` Q1).
- **J20-CUT** [hand] — in a rigid phase, every `m`-window uses at least three colours, and every cut of the periodic point is crossed by
  an edge of every colour pair; at a wall's exit site the window is not two-coloured by the two colours absent from the backward
  neighbourhood; a crossing-free cut for the pair `π` in a wall point from `A` to `B` gives a wall from `A` to `τ_π·B` (§2.4).
- **J20-KC** [hand + tools exact] — J19-KC's three clauses under stated readings: clause 1 **false** with `N` the point's least period
  (`D = {1,3,6,9}`), true with `N` a common period of all periodic points; clauses 2 and 3 true (§2.5; Q2).
- **J20-FRZ** [hand] — J19-FRZ true, and it needs no rigidity (§2.5).
- **J20-KEF** [hand] — with KE's statement (forwarded at B2): KE fails at every rigid–rigid wall whose one-sided components are all
  total, frozen tails included; so KE ⟹ KE♯; likewise KE1′ ⟹ KE♯ and KT ⟹ KE♯ (§3.1).
- **J20-TW** [hand] — every wall between two distinct phases of any `X₄(D)` has a chiral end, rigid or not (§3.2).
- **J20-BIN** [hand] — for `{1,2} ⊆ D`, `c ↦ y`, `y(x) = [c(x+3) = c(x)]`, is exactly 24-to-1 and `S₄`-free; phases, rigidity,
  walls and mirroring transfer (§3.2).
- **J20-DC** [hand, under a stated reading of `D_c(M)`] — A-T1 fails iff some heteroclinic `c` has an all-rigid `X₄(D_c(M))` (§3.2).
- **J20-NAMED** [tools exact; `tools/crunch_j20_walls.py`, `data/m3/j20/walls-run.txt`] — on T30's four sets, on `{2,6,11,13,14}` and on
  `{1,5,7,10,13,27,33}` no rigid periodic point is Kempe-frozen; every rigid–rigid wall end has period 20 and is chiral; on
  `{2,6,11,13,14}`: all rigid, no wall, 94 rigid phases up to colour permutation, single-strand swaps stay rigid and connect them
  (J19-AF✗ confirmed) (§3.3).

## Stage 1 — SAVED

### 1.1 What the owner told me at launch (logged, because it is information a blind verifier would not otherwise hold)

- J18 reports A-T1 (R2) and A-K3 as GAP, and reports A-K3 logically equivalent to A-T1. (Owner's launch message; not a quotation of a
  statement, so not checkable against a source I may open.)
- J19's three claims, quoted by the owner from `plans/M3-S1B-rank-one.md` lines 14, 16, 17 (fenced; **not checked against the source**):
  - "**J19-KC** — in an all-rigid `X₄(D)`: strands of periodic points are `σ^N`-invariant; Kempe classes of periodic points are finite
    sets of periodic points; the Kempe class of a wall point consists of wall points whose tails lie in different labelled phases. [hand]"
  - "**J19-FRZ** — a wall point with Kempe-frozen tails: every point of its Kempe class has relabellings of the same tails. [hand]"
  - "**J19-KEF** — KE fails at every rigid–rigid wall whose one-sided components are all total, in particular between Kempe-frozen
    tails; so KE ⟹ KE♯. [hand]"
  - My brief defines none of: *strand*, *`N`*, *Kempe class*, *labelled phase*, *Kempe-frozen*, *one-sided component*, *total*, *KE*,
    *KE♯*. Each verdict on these three states the reading it verifies.

### 1.2 The quotation check

| quotation in the brief | source | result |
|---|---|---|
| FS79-T35, "The exact rank-1 criterion at four colours: `P ≠ F` iff every cyclic phase of the window-state graph is a single cycle and a wall exists." | `plans/FS79-derivation.md` line 272 (T35's title) | **verbatim match** |
| "FS79-T35 states its criterion with phases taken modulo colour permutation" | `plans/FS79-C-deBruijn.md` §3a ("the window-state graph modulo colour permutation") and its tool `data/fs79/comp-debruijn/tools/rank1_phases.py` | **matches**; and the tool's quotient is specific: vertices are canonical (first-occurrence) words, and the out-edges of a class are the out-edges of its canonical representative, **with multiplicity** (one edge per admissible next colour); "rigid" counts those edges. This definition matters for A-Kq (§2) |
| FS79-T34 and its proof in `plans/FS79-C-deBruijn.md` §3 | same, §3 "Claim C2" | present; proof read (steps 1–5) |
| FS73-T24 "(three colours: periodic colourings dense, so no walls)" | `plans/FS73-derivation.md` line 225 | a gloss, not a quotation; consistent with T24's statement and T30's "at three colours there are no walls" |
| FS73-T30 "(rank-1 walls at four colours, all beside positive entropy)" | `plans/FS73-derivation.md` line 284; "beside positive entropy" is `plans/FS79-C-deBruijn.md` §3a's finding | a gloss; consistent (T30 itself says "every one with `P = F = 0`") |
| FS85-dB1, dB2; FS86-dB-H; `LEDGER.md` rows 45, 86 | `plans/FS85-derivation.md` lines 72, 82; `plans/FS86-derivation.md` line 328; `LEDGER.md` lines 67, 109 | present and read |
| The fixed list (A-T1 … A-C) | `plans/M3-exotic-colourings.md` §S | **fenced: not checked**; verified as the brief states them |
| The definitions for Q1 (window-state graph, phase, rigid, wall, `F_k`, `P_k`) | the brief itself, "quoted" from J18's/J20's shared text | taken as the brief states them |

Observation logged at the check (not a quotation defect): FS79's tool builds its states from **locally** proper `m`-words, while the
brief's vertices are words **occurring in some point**. The two graphs have the same cyclic SCCs and the same walls (every vertex on a
cycle, or on a path between two cycles, occurs in a bi-infinite path), so T35 and the scan are unaffected.

### 1.3 C0 — probabilities before any written derivation

Honest timing: these were formed while reading the statements and the verified inputs. Two things were already visible in my head at
that moment and are recorded so the priors are not mistaken for pre-thought: (i) A-T1, A-T1′, A-T2 and A-K3 looked mutually
equivalent (the finite/zero-entropy dichotomy, T35, and C2's orbit argument); (ii) the literal "quotient by colour permutations" at
`D = {1}` collapses `K₄`'s complete digraph to a single loop — a doubt about A-Kq.

| claim | P(true) | why |
|---|---|---|
| A-T1 | 0.50 | 377 of 377 all-rigid sets without a wall (T36) and walls always beside entropy (T30, §3a); against: zero-entropy countable SFTs are routine in general, and two derivation agents stalled |
| A-T1′ | 0.50 | expected equivalent to A-T1 |
| A-T2 | 0.50 | expected equivalent to A-T1 given T35 |
| A-K0 | 0.95 | a one-point or one-component repaint of a periodic point in a single-cycle phase must return to the cycle |
| A-K1 | 0.93 | from A-K0 via a periodic three-colouring |
| A-K2 | 0.95 | backward-determined colours propagate |
| A-Kq | 0.55 | the `D = {1}` collapse; true if the quotient keeps edge multiplicities |
| A-K3 | 0.50 | expected equivalent to A-T1 (vacuous if A-T1 holds; implies A-T1 by C2's orbit) |
| A-C | 0.45 | the negation of A-T1 with a named `D`; a verdict TRUE needs the name |
| J19-KC | 0.75 | clause 1's `N` undefined |
| J19-FRZ | 0.90 | frozen tails have one strand per colour pair |
| J19-KEF | 0.50 | KE, "total", KE♯ undefined in my brief |

### 1.4 "Would have searched here" log

- (none yet)

## Stage 2 — SAVED

Phase B1, blind. Every verdict below is a derivation from the statement alone (and from the verified inputs the brief names). Order: the
claims the owner said J18 reports TRUE first, then the deciding claim, then J19's three.

### 2.1 Groundwork, and the equivalences

Throughout, `D ≠ ∅` finite (for `D = ∅`, `m = max D` is undefined; the full shift would be one non-rigid phase anyway), `X = X₄(D)`,
`m = max D`, `W` the window-state graph of the brief: vertices the `m`-words occurring in some point, an edge `w → w′` for each
`(m+1)`-word occurring in some point.

- **J20-W.** Every constraint `c(x) ≠ c(x + d)` spans at most `m + 1` positions, so a bi-infinite sequence all of whose `(m+1)`-windows
  occur in points is proper, hence a point; conversely every point gives a bi-infinite path. An edge `w → w′` is determined by the
  `(m+1)`-word, so `W` has no parallel edges. Every vertex and edge lies on a bi-infinite path (it occurs in a point). So the α- and
  ω-limit SCCs of any path are phases, and every vertex is reachable from a phase and reaches a phase.
- **J20-E1.** (⟸) A bi-infinite path whose α- and ω-limit phases coincide lies in that SCC (each vertex is reachable from it and reaches
  it); in a single cycle it is periodic, and there are finitely many. If the limit phases differ, the segment between them is a wall.
  (⟹) Finite `X` ⟹ every point periodic. A non-rigid phase carries periodic points of unbounded period (below), and a wall `C → C′`
  extends (prepend `C`'s cycle, append `C′`'s) to a non-periodic point, whose shifts are pairwise distinct.
- **J20-E2.** `X` is conjugate to the vertex shift of `W`, whose entropy is `log` of the spectral radius, the maximum over SCCs; an
  irreducible non-negative integer matrix has spectral radius 1 iff it is a cyclic permutation matrix, and radius > 1 otherwise.
  So `h > 0` iff some phase is not a single cycle. (A non-rigid phase `C` has `tr(A_C^L)` unbounded, so infinitely many periodic points.)
- **J20-T35W** (T35 without the quotient). `F ⊆ P` always. If some phase is not rigid, `X ≠ ∅` has infinitely many periodic points; a
  `δ ≠ 0` in `P` would make every periodic point `|δ|`-periodic, hence determined by `|δ|` symbols — finitely many. So `P = {0} = F`.
  If all phases are rigid and there is no wall, `X` is finite and all points periodic, so `P = F`. If all are rigid and a wall exists,
  `L = lcm` of the cycle lengths lies in `P`, and a wall point is not `L`-periodic, so `L ∉ F`. If `X = ∅`, `P = F = ℤ` and there is no
  phase. Hence **`P ≠ F` iff every phase is rigid and a wall exists** — on `W` itself.
- **J20-EQ.** By E1 and E2, A-T1′(`D`) ("finite or positive entropy") ⟺ (all rigid ∧ no wall) ∨ ¬(all rigid) ⟺ A-T1(`D`). By T35W,
  A-T2(`D`) ⟺ ¬(all rigid ∧ wall) ⟺ A-T1(`D`). A-T1(`D`) ⟹ A-K3(`D`) vacuously. A-K3(`D`) ⟹ A-T1(`D`): a colour permutation `g` is an
  automorphism of `W` (it preserves `X`), so from walls `C → C′` and `C′ → gC` we get `gC → gC′ → g²C → ⋯ → gⁿC = C` (`n` the order of
  `g`), a path from `C′` back to `C`; then `C, C′` share an SCC, contradicting `C ≠ C′`. (This is C2's step 5 with one end.) So
  **A-T1, A-T1′, A-T2 and A-K3 have the same truth value for every `D`**, and A-C holds iff A-T1 fails for some `D` and that `D` is named.
  (This agrees with what the owner relayed of J18: A-K3 ⟺ A-T1.)

### 2.2 A-K0, A-K1, A-K2 — TRUE

- **J20-RET (the return lemma).** Let `C` be a rigid phase and `c′ ∈ X` a point whose α- and ω-limit SCC are both `C`. Its path runs
  from `C` to `C`, so every vertex lies in `C`; inside a single cycle each vertex has one out-edge, so the path is the cycle: `c′` is
  periodic and, if it agrees with the periodic `p ∈ C` on one window, `c′ = p`. Only the rigidity of `C` is used.
- **A-K0: TRUE.** Let `c` be periodic; its phase `C` is rigid. A gap at `x` (a colour `b` missing from `c(N[x])`, necessarily `b ≠ c(x)`)
  gives `c′ = c` off `x`, `c′(x) = b`: proper, agreeing with `c` outside `{x}`, different from `c` — contradicting RET. A finite
  two-colour Kempe component `K`: swapping it gives a proper `c′ ≠ c` agreeing with `c` outside the finite `K` — contradicting RET. So all
  four colours meet every closed neighbourhood and every Kempe component is infinite. (With the finite-quotient voltage argument —
  components of the lift of a finite connected graph with ℤ-voltages are finite copies if every closed-walk voltage is 0, and are
  infinite and invariant under a nonzero translation otherwise — each Kempe component of `c` is two-sided and periodic.)
- **A-K1: TRUE.** `X ≠ ∅` gives `χ ≤ 4`. If `χ ≤ 3`, `X₃(D)` is a non-empty SFT, so it has a periodic point `q` (a finite graph with a
  bi-infinite path has a cycle); `q ∈ X` misses colour 4 on every closed neighbourhood, contradicting A-K0.
- **A-K2: TRUE (both clauses).** If `{c(x − d)} ∪ {c(x)} = [4]` then, `c` being proper, `{c(x − d) : d ∈ D} = [4] ∖ {c(x)}`. If `c′ = c`
  on `(−∞, x)` then `c′(x) ∉ {c(x − d)}`, so `c′(x) = c(x)`; induction upward from `x₀` gives `c′ = c`. The second clause: the last vertex
  of `C` on a wall has an out-edge inside `C` (a phase is strongly connected with a cycle) and one leaving it, so two next colours occur
  in points; a fortiori the local rule does not force the colour there. It holds in both readings of "determined by the window" (by the
  language, or by the backward neighbourhood), and the first clause's proof applied at the exit site gives the second.

### 2.3 A-Kq — TRUE for FS-79's quotient, FALSE for the orbit quotient

Let `G = S₄` act on `W`. **Groundwork (every quotient):** the image map has path lifting (an edge `[u] → [v]` lifts from every `u′ ∈ [u]`);
lifting a cycle of the quotient from `u` gives `u → gu`, and iterating, a cycle through `u`; so SCCs of the quotient are the images of
`G`-orbits of SCCs of `W`, phases correspond to phases, and there is no edge between two distinct translates `gC ≠ hC` of one SCC (it
would give `gC → kgC → k²gC → ⋯ → gC`, `k = hg⁻¹`).

- **Walls: TRUE in every quotient.** A wall `C → C′` in `W` has `C′ ∉ G·C` (a path `C → gC` forces `gC = C`), so it projects to a wall;
  a wall of the quotient lifts to a path between phases with different images.
- **`W` all rigid ⟹ quotient all rigid: TRUE in every quotient.** A vertex `v` of a rigid phase `C` uses at least three colours: if its
  colours lie in `{p, q}`, let `τ = (r s)` and `c′ = c` before the window's end, `τ∘c` after — proper, since every crossing constraint
  touches the window, which `τ` fixes; `τv = v` puts `c′`'s tails both in `C`; `c′ ≠ c` because `c` uses all four colours (A-K0). That
  contradicts RET. So vertex stabilisers are trivial on `C`, `Stab(C)` acts on the cycle by free rotations, and the image is the cycle
  `C/Stab(C)` — whether edges are orbits of `(m+1)`-words or bare image pairs.
- **Quotient all rigid ⟹ `W` all rigid: FALSE for the orbit quotient, TRUE for the transfer quotient.**
  - *Counterexample.* `D = {1}`: `W` is the complete loopless digraph on the four colours (one phase, entropy `log 3`); every `1`-word is
    one orbit and every `2`-word one orbit, so the orbit quotient is one vertex with one loop — a single cycle. `D = {1, 2}`: `W` has
    entropy `log 2` (two free choices at each step); the orbit quotient is again one vertex with one loop. Checked exactly:
    `tools/crunch_j20_checks.py` Q1 (`data/m3/j20/checks-run.txt`).
  - *Mechanism.* A collapse needs a phase vertex `u` whose `(m+1)`-extensions `u·a`, `u·b` lie in one orbit, i.e. some `g ≠ 1` fixes `u`
    and sends `a ↦ b`: `u` uses at most two colours. So the two quotients can disagree only where a phase contains an `m`-word of at most
    two colours — never when `W` is all rigid (above).
  - *The transfer quotient* (FS-79's `data/fs79/comp-debruijn/tools/rank1_phases.py`, read at stage 1: a class's out-edges are its
    canonical representative's, one per admissible colour): the out-edges of `u = g·ū` inside `C` are `g` of `ū`'s out-edges landing over
    the image `Q`, and edges from `C` over `Q` can only land in `C`; so each vertex's out-degree inside `C` equals its class's multiplicity
    out-degree inside `Q`, and `C` is a single cycle iff `Q` is.
  - **Bearing:** T35, T36 and the scan used the transfer quotient, so they are unaffected. The fixed list's A-Kq and the brief's
    parenthesis ("the claims below hold in either form") are true for the transfer quotient and false, in the rigidity clause, for the
    ordinary quotient of a graph by a group. A correction owed to the wording, not to any result.

### 2.4 A-T1 (the deciding claim) — GAP, my own stall; with A-T1′, A-T2, A-K3 GAP by J20-EQ and A-C GAP

**What I proved toward it (J20-CUT):**
1. Every `m`-window of a point in a rigid phase uses at least three colours (§2.3).
2. **Every cut of a rigid-phase periodic point `p` is crossed by an edge of every colour pair `π`.** If no `π`-edge crossed `t`, the future
   swap `p′ = p` on `(−∞, t)`, `τ_π∘p` on `[t, ∞)` would be proper, with tails in `A` and `τ_π A`; a path `A → τ_π A` forces `τ_π A = A`,
   and then RET gives `p′ = p`, false since `p` uses the colours of `π` after `t`. (Equivalently: its Kempe components are two-sided.)
3. **At a wall's exit site.** Let `c = p` on `(−∞, 0)`, `c(0) = β ≠ α = p(0)`. Then `α, β ∉ B(0) = {p(−d) : d ∈ D}`, so `|B(0)| ≤ 2`;
   the window `p[−m, 0)` is not coloured inside `[4] ∖ {α, β}` (else `(α β)` fixes it and `(α β)∘p` would give its vertex two out-edges
   inside `A`); and `β` occurs among `p`'s forward neighbours of 0 (gap-freeness).
4. **Walls are closed under future swaps.** If a wall point `c` from `A` to `B` has a cut with no `π`-edge across it, the future swap is
   a wall point from `A` to `τ_π B`. Kempe swaps also keep a wall point a wall point (J19-KC clause 3, verified in §2.5). Reflection
   `x ↦ −x` turns a wall `A → B` into `B^R → A^R`; splicing two points at a shared window needs their phases to coincide.

**The stall, named.** A-T1 is equivalent (J20-E1, EQ) to: *in an all-rigid `X₄(D)`, no point agrees with a rigid-phase periodic point on
a left half-line and differs from it.* To close it one needs an operation that turns such a point into a non-periodic point with both tails
in one phase, or into a wall `B → g·A`. The operations derivable from the statements alone do not reach it:
- colour permutations, Kempe swaps and future swaps preserve the wall's direction (left tail in the orbit of `A`'s Kempe relatives,
  right tail in `B`'s), and by KC clause 3 never produce a same-phase pair of tails;
- reflection plus splicing closes it exactly when both ends are achiral (FS79-T34, C2), and says nothing at a chiral end;
- at Kempe-frozen tails (each colour pair's subgraph connected) the Kempe class is only relabelled tails (J19-FRZ), so no Kempe
  argument has anything to work with there.
**The missing step, verbatim:** *"At a wall of an all-rigid `X₄(D)` with a chiral end and Kempe-frozen tails, some operation beyond
colour permutation, reflection, splicing at a shared window, Kempe swaps and future swaps produces a non-periodic point whose two tails
lie in one phase."* I found no such operation, and no counterexample either. The scan's null (FS79-T36: 377 all-rigid sets, `max D ≤ 14`,
`|D| ≤ 5`) measures its range (G21; FS85-dB2 shows the relevant structures can first appear at `|D| = 70`).

- **A-T1: GAP** (the missing step above). **A-T1′, A-T2, A-K3: GAP**, each equivalent to A-T1 for every `D` (J20-EQ; the equivalence
  itself is TRUE). **A-C: GAP** — true iff A-T1 fails somewhere; no `D` named.

### 2.5 J19's three claims (readings stated; my brief defines none of their terms)

- **J19-KC — clause 1 FALSE or TRUE by the reading of `N`; clauses 2 and 3 TRUE.**
  - *Clause 1, `N` = the periodic point's least period: FALSE.* `D = {1, 3, 6, 9}`: `X₄(D) ⊆ X₄({3,6,9})`, and `X₄({3,6,9})` is three
    interleaved copies of `X₄({1,2,3})` (24 points each), so finite: every phase rigid, no wall. The colouring `x ↦ h(x mod 4)`,
    `h = (a, d, c, b)`, is proper (no element of `D` is `≡ 0 mod 4`) with least period 4. Its `{a, c}`-vertices are `2ℤ` and the only
    element of `±D` that is `≡ 2 mod 4` is `±6`, so its `{a,c}`-strands are the three cosets `6ℤ, 6ℤ+2, 6ℤ+4` — none invariant under
    translation by 4 (4 carries `6ℤ` to `6ℤ+4`). Checked exactly (Q2: 840 essential states, 74 phases, all rigid, no wall; three
    components with residues `{0,6}, {2,8}, {4,10}` mod 12; plant `D ∪ {2}` merges them and the check fails as it must).
  - *Clause 1, `N` = a common period of all periodic points (e.g. the lcm of the cycle lengths): TRUE.* A strand `K` of periodic `p` is
    infinite (A-K0) and periodic (voltage argument); swapping it gives a periodic `p′`, and both `p, p′` are `N`-periodic, so
    `K = {x : p′(x) ≠ p(x)}` is `N`-invariant.
  - *Clause 2: TRUE.* Every swap of a strand of a periodic point in an all-rigid `X` gives a periodic point (above); a periodic point has
    finitely many strands (one per coset of a nonzero voltage group per component of a finite quotient), so any union of strands is a
    finite union; `X` has finitely many periodic points. Hence the Kempe class is a finite set of periodic points.
  - *Clause 3: TRUE* ("labelled phase" read as a phase of `W`; it is also true of quotient phases). Kempe swaps are involutions with the
    same two-colour subgraph, so Kempe equivalence is symmetric; a periodic member would make the wall point periodic by clause 2. A
    non-periodic point in an all-rigid `X` has distinct limit phases (RET). A wall point has finitely many Kempe components: far from the
    junction each strand of the tail's periodic point contributes exactly one infinite piece to a half-line, all of whose far vertices
    lie in it (translate a bounded connecting path), so only a bounded middle holds anything else.
- **J19-FRZ — TRUE** (reading: a periodic point is Kempe-frozen when every two-colour subgraph is connected, the usual sense). A
  relabelled frozen point is frozen. If the current point has frozen tails `g·p_A`, `g′·p_B`, the far-left `{a,b}`-vertices lie in the
  one infinite left piece, so a Kempe component contains all of them or none; a swap relabels each tail by `(a b)` or leaves it.
  Induction over single swaps. No rigidity is used.
- **J19-KEF — not verifiable from my brief.** KE, KE♯, "one-sided component" and "total" are not defined in it. What I can verify under
  the natural readings (a one-sided component meets exactly one tail; it is *total* when it contains every strand of its tail for its
  pair): **the "in particular" clause is TRUE** — frozen tails have one strand per pair per side, so a one-sided component meeting a tail
  contains all of that tail's strands. The first clause ("KE fails at every rigid–rigid wall whose one-sided components are all total")
  and the consequence ("so KE ⟹ KE♯") need KE's and KE♯'s statements: **asked for at B2**.

### 2.6 B1 verdicts (as sent to the owner)

| claim | verdict | one line |
|---|---|---|
| A-K0 | **TRUE** | a gap or a finite Kempe component repaints `c` on a bounded set, contradicting the return lemma |
| A-K1 | **TRUE** | a periodic three-colouring would be a gapped periodic point |
| A-K2 | **TRUE** | full backward neighbourhoods force the colour; an exit vertex has out-degree ≥ 2 |
| A-Kq | **FALSE** for the orbit quotient (`D = {1}`, `{1,2}`: `W` non-rigid, quotient one loop); **TRUE** for FS-79's transfer quotient; wall clause TRUE for both |
| A-T1 | **GAP** | missing step §2.4 (chiral end, Kempe-frozen tails) |
| A-T1′, A-T2, A-K3 | **GAP** | each ⟺ A-T1 for every `D` (proved) |
| A-C | **GAP** | ⟺ ¬A-T1 somewhere; no `D` named |
| J19-KC | clause 1 **FALSE** with `N` the least period (`D = {1,3,6,9}`), **TRUE** with `N` a common period; clauses 2, 3 **TRUE** |
| J19-FRZ | **TRUE** | needs no rigidity |
| J19-KEF | **not verifiable** (KE undefined); its "in particular" clause TRUE |

### 2.7 "Would have searched here" log

- A-C / A-T1: would have enumerated `D` beyond FS79-T36's range hunting an all-rigid set with a wall. Did instead: the stall analysis of
  §2.4; A-C left GAP.
- J19-KC clause 1: would have searched small `D` for an all-rigid set with a strand not invariant under its point's least period. Did
  instead: derived `{3,6,9}` (a product of three `{1,2,3}` systems, where `6` is the only `≡ 2 mod 4` difference) and `{1,3,6,9}` (adding
  1 keeps finiteness and gives `gcd 1`), then checked that one named set exactly.
- A-Kq: would have scanned `D` for sets where the two quotients disagree and a wall exists. Did instead: derived that a disagreement needs
  a phase vertex of at most two colours, which rigidity forbids, and exhibited `{1}`, `{1,2}` by hand; checked exactly.

## Stage 3 — SAVED

Phase B2. The owner forwarded (message of 2026-09-25, quoted from the fenced records, **not checked against them**): KE (J18 §3.5),
KE1′ (J19 §3 item 2), KE♯ (J19 §2.5), KT (J19 §2.8), and J18's and J19's theorem tables (statements and grades only). Each is verified
below from its statement, with my own tools. The quotations are those of the owner's message, verbatim.

### 3.1 The Kempe statements

- **KE** — "Let `D ⊂ ℤ_{>0}` be finite, and let `c ∈ X₄(D)` agree with a periodic point `p` of a rigid phase `C` on a left half-line and
  with a periodic point `q` of a rigid phase `C′ ≠ C` on a right half-line. Then some two-colour Kempe component of `c` is bounded on
  exactly one side, and swapping its two colours gives a point whose tail on the unbounded side lies in a phase that is not a single
  cycle." **Verdict: OPEN (GAP)** — neither proved nor refuted. It implies A-T1 (J18-KE⟹, below). It is **false at every rigid–rigid
  wall whose one-sided components are all total**: a one-sided component is infinite, so it contains a strand. If it holds every strand
  of its tail for its pair, its swap applies the transposition to the whole tail. The new tail is `τ·p` in the phase `τ·C`, a single
  cycle. Kempe-frozen tails have one strand per pair per side, so every one-sided component there is total. **Not refuted on any named set**:
  no rigid periodic point is Kempe-frozen on any of the six sets of §3.3.
- **KE1′** — "some two-colour component of `c` is bounded on exactly one side and its ends are a proper subset of that tail's strands."
  **OPEN.** It is false at frozen rigid–rigid walls (a proper subset of one strand is empty), so KE1′ ⟹ KE♯. It does not by itself imply
  A-T1: in an all-rigid `X`, the swap gives a tail `p^S` that is another rigid periodic point.
- **KE♯** — "in no `X₄(D)` does a rigid–rigid wall join two Kempe-frozen periodic points". **OPEN.** Not refuted: the six named sets
  have no frozen rigid periodic point at all.
- **KT** — "Let `c ∈ X₄(D)` agree with a periodic point of a rigid phase `C` on a left half-line and with a periodic point of a rigid
  phase `C′ ≠ C` on a right half-line. Then finitely many Kempe moves turn `c` into a point whose two tails lie in one labelled phase,
  or into a point one of whose tails lies in a phase that is not a single cycle." **OPEN as a statement; its implications are TRUE:**
  - KE ⟹ KT: KE's single move gives the second alternative.
  - KT ⟹ A-T1: in an all-rigid `X`, the second alternative cannot occur, and the first contradicts J19-KC clause 3 (§2.5). So KT
    restricted to all-rigid `X` is equivalent to A-T1 there.
  - KT ⟹ KE♯: at frozen tails, J19-FRZ keeps every tail a relabelling of a rigid one. Equal labelled phases `gC = g′C′` would give a
    wall `C → hC`, which is impossible.
- **J19-KEF: TRUE** (now that KE is stated): the argument under KE above, plus "frozen ⟹ total".

### 3.2 J18's and J19's tables

| claim | verdict | note (my route) |
|---|---|---|
| J18-F3 | **TRUE** | = J20-E1, E2; zero entropy with every phase a cycle gives countably many points (finitely many phase visits and times) |
| J18-K0loc | **TRUE** | = A-K0 with J20-CUT 1–2 (`≥ k − 1 = 3` colours per window; every cut crossed in every pair) |
| J18-K0H | **TRUE** | the half-line form of FS86-dB-H with two-sided gap-freeness fails. §3.3 re-derives T30's rigid–rigid walls, and their left tails are gap-free (K0loc needs only that phase's rigidity) |
| J18-AK2 | **TRUE** | = A-K2 ("left gap" read as a colour missing from the backward closed neighbourhood; "survives" as extends to a point) |
| J18-EQ | **TRUE** in its first clause (= J20-EQ); **not verifiable** in its second ("route (ii)'s potential" is undefined here) |
| J18-DC | **TRUE under my reading**: `D_c(M) = {d ≤ M : c(x) ≠ c(x+d) ∀x}` with `M ≥ max D`; heteroclinic = tails periodic in distinct phases. (⟸) `c ∈ X₄(D_c(M))`, non-periodic, all rigid, so a wall. (⟹) a wall point `c` of an all-rigid `X₄(D)` has `D ⊆ D_c(M)`, and `X₄(D_c(M)) ⊆ X₄(D)` has zero entropy, so it is all rigid (J20-E2). This is the construction route I had sketched for A-C (§3.4) |
| J18-KE⟹ | **TRUE** | in an all-rigid `X`, KE's conclusion (a non-single-cycle phase) cannot occur |
| J18-DPR | **PARTLY CONFIRMED** | `X₄({1,5,7,10,13,27,33})`: exactly one non-rigid labelled phase (so one up to colour permutation) and 270 rigid labelled phases. Rigid–rigid walls exist: 144 labelled reachable pairs, both ends period 20, non-frozen, chiral. "25 phases, 24 rigid" is consistent, but I did not count orbits. "**Satisfies KE**" is **not checked** (budget; needs the Kempe-component tool) |
| J19-ENDS | **TRUE** (first and third clauses, = §2.5's strand argument). The second clause is TRUE if "meet the junction" means "lie within distance `m` of it": a finite component inside the region where `c` equals a tail is cut off only by recoloured junction neighbours. It is not established if "meet" means "contain a junction vertex" |
| J19-TW | **TRUE, and more general**: C2's step 5 uses no rigidity, so **every wall between two distinct phases of any `X₄(D)` has a chiral end**. The twin: an achiral end `C₋^R = gC₋` gives `C₊^R → gC₋ → gC₊`, a wall `E → gẼ` with `E = C₊^R` |
| J19-BIN | **TRUE**. With `1, 2 ∈ D`, `c(x+3) ∈ {c(x), the fourth colour}`. `y(x) = [c(x+3) = c(x)]` and `(c(0), c(1), c(2))` determine `c`, and all 24 lifts of `y` are relabellings. So the factor is exactly 24-to-1, `S₄`-free and shift-commuting. The fibre over a phase is a finite cover with unique path lifting both ways, so the fibre over a cycle is disjoint cycles, there are no walls inside a fibre, and walls correspond. The mirror is `y(−x−3)` |
| J19-KT | **TRUE** as implications (§3.1). "A-T1 = FW ∧ A-T1ⁿᶠ": FW and A-T1ⁿᶠ are undefined here. Read as "no all-rigid wall between frozen tails" ∧ "none with a non-frozen tail", it is a tautological split, and "FW invisible to Kempe moves" is J19-FRZ |
| J19-AF✗ | **TRUE**, independently computed (§3.3) |

### 3.3 The named sets, exactly (`tools/crunch_j20_walls.py`; output `data/m3/j20/walls-run.txt`)

Frozenness is decided exactly: a two-colour subgraph of an `N`-periodic colouring is connected iff its quotient mod `N` is connected
and the closed-walk voltages have gcd 1. Controls: `{3,6,9}`'s `(a,d,c,b)`-point reads not frozen and `{1,2,3}`'s `(a,b,c,d)` reads
frozen. The plant (drop the gcd) makes the first control read frozen, and the run exits 1. Counts are of labelled phases (not quotiented).

| `D` | labelled phases | rigid | rigid–rigid reachable pairs | ends of those walls | frozen rigid points |
|---|---|---|---|---|---|
| `{1,5,7,10}` | 187 | 186 | 1,296 | all period 20, non-frozen, chiral | 0 |
| `{3,5,9,10}` | 262 | 258 | 144 | same | 0 |
| `{3,7,9,10}` | 369 | 348 | 48 | same | 0 |
| `{5,7,9,10}` | 163 | 162 | 144 | same | 0 |
| `{2,6,11,13,14}` | 2,094 | 2,094 (no wall) | 0 | — | 0; **94** rigid phases up to colour permutation; single-strand swaps stay rigid and connect them all |
| `{1,5,7,10,13,27,33}` | 271 | 270 | 144 | same as T30's | 0 |

Consistent with FS79 §3a's quotient counts (for example `{1,5,7,10}`: 18 phases up to colour permutation, 17 rigid).

### 3.4 Reassembly of A-T1 — not reassembled; GAP stands

The implications proved are KE ⟹ KT ⟹ A-T1 and KE, KE1′, KT ⟹ KE♯. None of KE, KE1′, KE♯, KT is proved. In an all-rigid `X`, KT is
A-T1 itself, so the chain does not reduce A-T1 to something smaller. My stall (§2.4: frozen chiral walls are invisible to every
operation I have) is J19's FW, reached independently. There is also the other half: a wall with a non-frozen tail, where J19-KC
clause 3 blocks every Kempe route to equal tails. **A-T1: GAP; the missing step is KT for all-rigid `X₄(D)`,** equivalently A-T1.
The named sets hold no frozen rigid point at all, so FW has no test case in hand.

**The construction route, stated as a reading (not a claim).** J18-DC turns A-C into one question: is there a heteroclinic `c` whose
Δ-completion kills every non-rigid phase? A sub-SFT has zero entropy iff it keeps only finitely many periodic points of the parent
(rigid phases carry finitely many). So adding large distances in the residue classes a named rigid–rigid wall admits, modulo its period
20, keeps that wall and asks only whether finitely many periodic points of the parent survive. First step (exact, seconds, allowed): the
admissible residue set of each T30 wall. It is **not run here**: it scaffolds a counterexample search, which is the owner's call under
the ban.

### 3.5 "Would have searched here" (B2)

- Would have Δ-completed T30's walls with trial distances to hunt an all-rigid set with a wall (A-C). Did instead: stated the route and
  its first exact step (§3.4); not run.
- Would have scanned many `D` for a frozen rigid–rigid wall to refute KE and KE♯. Did instead: checked only the six sets the
  statements name (T30's four, J19-AF✗'s, J18-DPR's), a complete enumeration of each one's phases.

## Stage 4 — SAVED

Phase B3. The fence was lifted by committing B2. I read only the theorem tables of `plans/M3-S1A-rank-one.md` (J18) and
`plans/M3-S1B-rank-one.md` (J19), J19's line 144 (its definition of `N`), and J18's line 245 (its definition of `D_c(M)`). Their proofs
were not read.

### 4.1 Divergence table (truth, scope, route, wording)

| item | J18 / J19 | J20 | kind |
|---|---|---|---|
| J19-KC clause 1, "`σ^N`" | the table line leaves `N` undefined; J19 line 144: "`N` is the least common multiple of the least periods in `Per(X)`" | TRUE with that `N`; FALSE with `N` a point's least period (`D = {1,3,6,9}`) | **wording**: the table line must read "`N` a common period of all periodic points (the lcm of their least periods)" |
| A-Kq | J18-AKq: true for the labelled quotient; the rigidity clause is false for the plain quotient (`D = {1}`) | the same, plus `D = {1,2}`, the mechanism (a phase vertex of at most two colours), and "W all rigid ⟹ every quotient all rigid" | agreement; the fixed list's wording and the brief's parenthesis owe the correction |
| A-T1, A-T1′, A-T2, A-K3, A-C | GAP. A-T1 = FW ∧ A-T1ⁿᶠ (J19); the missing step is KT (or KE) | GAP; my named stall (§2.4) is J19's FW, reached independently, plus the non-frozen half | agreement on truth. Route: mine names the operations that fail; J19's names the Kempe statements that would suffice |
| J19-TW | "every wall has a chiral end" | the same statement, with the observation that C2's step 5 needs no rigidity | agreement (I add the scope note) |
| J18-DC's `D_c(M)` | line 245: `{d ∈ [1, M] : c(x) ≠ c(x+d) ∀x}` | my reading was identical | agreement |
| J18-DPR "satisfies KE" | tools exact | not checked; its structure (one non-rigid phase; rigid–rigid walls with period-20, non-frozen, chiral ends) confirmed | scope of my check |
| J19-ENDS "finite components meet the junction" | stated | TRUE for "within distance `m` of the junction"; open for "contain a junction vertex" | wording (junction not read) |
| J19-AF✗ | tools exact | confirmed with my own tool | agreement |
| KE, KE1′, KE♯, KT | open (targets) | open; not refuted on any named set, since no frozen rigid point exists there | agreement |

### 4.2 The final statements read aloud against the informal claim

- *A-T1*: "if every phase is rigid, no wall". By J20-E1 and E2 this is exactly "`X₄(D)` is never countably infinite", and by T35W
  exactly "`P₄(D) = F₄(D)`", i.e. rank-one inheritance at four colours. The statement is the right one; it is unproved.
- *A-Kq*: "quotient by colour permutations" is ambiguous. The informal intent ("the criterion does not depend on quotienting") is true
  only for the quotient FS-79's tool computes. Read aloud, the fixed list's sentence claims more than is true.
- *J19-KC*: read aloud without line 144, "strands of periodic points are `σ^N`-invariant" suggests the point's own period, which is
  false. With line 144 it is true.

### 4.3 Slips (mine)

- `tools/crunch_j20_walls.py`'s first strand-swap labelled lift vertices `φ(r) + k` instead of `k − φ(r)`. An improper swapped word read
  as "swap to non-rigid" on `{2,6,11,13,14}`. I caught it because a proper colouring must lie in `W`, and fixed it before any verdict used
  it. A properness assert now guards the swap. Nothing in stage 3's table rests on the pre-fix output.

### 4.4 Proposed edits (for the front-page lane; I edit none of these files)

- The fixed list's A-Kq (`plans/M3-exotic-colourings.md` §S): name the quotient as "each class's out-edges those of a representative,
  with multiplicity (FS-79's `rank1_phases.py`)".
- J19's table line J19-KC: add "(`N` the lcm of the least periods in `Per(X)`)".
- J19-TW: note that it needs no rigidity (every wall of any `X₄(D)`).
