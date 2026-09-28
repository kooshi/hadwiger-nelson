# FS112-NB2 — blind round-2 verification of FS-112's proof side (FS112-N2)

*Job FS112-NB2, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `dfc512ff`. Brief: `data/fs112/briefs/NB112-verify-proof.md` with its instance file
`data/fs112/briefs/NB2-112-instance.md` (which overrides it) and `data/fs112/briefs/STANDING-RULES.md`. Derive first, read second: stage 1 is committed
before the section "§ Continuation — FS112-N2" of `plans/FS112-N-proof.md`, `tools/fs112_n2_*.py` and `data/fs112/fs112-n/n2-*` are opened. Working
files: `data/fs112/fs112-nb2/`; tool `tools/fs112_nb2_checks.py`; scratch `scratchpad/fs112-nb2/`. Grades as `CLAUDE.md` § Notation; "minds" counts
derivations, mine included; every verdict below is mine alone unless it says otherwise. Notation is round 1's (`plans/FS112-N-proof.md` header, §§1.3,
2.2–2.3) and FS-110's N4 frame (`plans/FS110-N-proof.md` §N4-2): `Γ`, `P_cl`, `ω(x)`, N-E0/E1/E2, TS-C (tile diameter `≤ 1`), `s_in`, `s_out`, (Q), (R2),
`P_k = v + kn`, `f(λ) = λ/(1+λ)`, `f̃(υ) = υ/(1−υ)`.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| NB2-RAY | N4-FIN (a statement about bi-infinite sequences in `(−1, 1)`) stays TRUE; its application in N4-CONE needs N4-PROP's chain over all of `ℤ`, and PROP's step from `P_0` to `P_{−1}` has no proof when `λ_0 = −1` (it rests on N4-FLANK at `κ₋ = −1`, which fails, and on NB-4 at the unit-arc centre `P_{−1}`); the ray `λ_k = −1/(k+1)`, `υ_k = 0` (`k ≥ 0`) meets FIN's inequalities with equality in `λ` and is the family of concentric circles of radius `k+1` about `P_{−1}`; so N4-CONE is a GAP under unit arcs | [hand, one mind; RAY exact] | §1.4 |
| NB2-END | at the end `P_0` of a chain with `λ_0 = −1`, `P_{−1}` cannot be stuck (N112-END's argument), and, if `g` has two sectors there, terminality forces a colour `y ∉ P_cl(P_0)` into the side cone below `g`'s `+a` horn at `P_{−1}`, which N4-FLANK's list does not let shadow that horn: the end is blocked from a SHAVE only by an unlisted shadow, e.g. a further unit arc centred at `P_{−2}` | [hand, one mind; a sketch] | §1.4 N2-RAY (iv) |
| NB2-DENSE | in **every** valid map (no terminal modification needed), every trichromatic cubic vertex `u` has within distance 2 a vertex with a repeated colour, a vertex of `≥ 4` colours, or a unit-arc centre; hence a unit-arc centre within 3 or a repeated-colour vertex within 2 (N2-DENSE's 4 and 3 a fortiori); and every closed disc of radius 1 contains a vertex of degree `≥ 3`, so every closed disc of radius 4 contains a unit-arc centre or a repeated-colour vertex (N2-DENSE's 5 a fortiori) | [hand, one mind; over the base at row 134's grade, NB4′ and N112-SIX] | §1.4 |
| NB2-DISC1 | every closed disc of radius 1 of a valid map contains a vertex of degree `≥ 3` (nested tiles about the centre, each inside the disc, end at a branch point by local finiteness) | [hand, one mind] | §1.4 N2-DENSE |
| NB2-TOWARD | `s_out ∉ P_cl(P)` ⟹ `α` bends toward `P` including its end vertices: at an end `A` the only other candidate blocker is an `s_out` tile at `Q_A = P + 2e_A`; in-type there is impossible (N-E2 against `T_out`), and an out-type one's shadow near `A` lies beyond a circle tangent at `A` that cannot pass below `α` (else `T_out` is shadowed), so the lens inside `B(P,1)` is clear | [hand, one mind; INTYPE exact] | §1.4 |
| NB2-AWAY | `s_in ∉ P_cl(P)` and no `s_in` tile touching `R₂(ᾱ)` ⟹ `α` bends away including its ends; at an end the only possible blocker is an `s_in` tile at `Q_A`, and with a horn-shaped lens (tangent to `α` at `A`) only one bounded there by the radius-2 circle (`f(−1/2) = −1`) blocks | [hand, one mind; R2 exact] | §1.4 |
| NB2-TAN | an isolated `s_in` contact at `P + 2e_{w₀}` (or the end of an R2 sub-arc) is cleared by a bend tangent to `α` at `w₀` of curvature near 1: the caps of `ω(z)` beyond radius 2 (height `≤ (1−κ)δ²/2`, width `≍ √h`) stay under a contact tile that rises above the radius-2 circle linearly (a corner) or quadratically (an arc of other curvature); only a tile along the radius-2 circle blocks | [hand, one mind; round 1's NB sketch completed] | §1.4 |
| NB2-RED | N112-RED with both GAPs closed and terminating: no operation creates a unit arc, each unit arc is bent at most once and wholly, merges lower `Φ` | [hand, one mind; over NB-MERGE3 (two minds)] | §1.4 |
| NB2-TERM | a terminal valid modification `M*` under merge, ray merge, shave and bend exists; its unit arcs are (Q)/(R2); its vertices are corners, trichromatic cubic, `≥ 4`-colour, or carry a repeated colour, and every repeated-colour vertex lies on a normal-line chain every one of whose ends is within 1 of a (Q) or (R2) arc or a `≥ 4`-colour vertex; bi-infinite chains are excluded, one-sided infinite ones are the GAP | [hand, one mind; its GAP NB2-RAY] | §1.4 |
| NB2-FLANKQ | in `M*` a horn bound `−1` (resp. `+1`) at `v` lies on a unit arc of `ω(S′)` (resp. `ω(N)`) whose outer colour is the horn's; it is (Q) — an in-type flank-colour tile at the centre, FLANK's exception — or (R2) — a flank-colour tile at the far antipode along the radius-2 circle, whose shadow at `v` is the unit arc itself | [hand, one mind; R2 exact] | §1.4 |
| NB2-SIGN | every point `≠ P` of an (open) tile of a side colour of `α` is at distance `< 1` from all of `int α` or `> 1` from all of it; false for closure points (an R2 contact `P + 2e_w`, `w ∈ int α`, is at distance exactly 1 from `w`) | [hand, one mind; SIGN exact] | §1.4 |
| NB2-ENV | for a lens of angle `ψ` (thickness at arc-distance `φ` from the nearer end `≤ ψφ`), the disc `B(z, 1)` of a lens point leaves `⋃_{w∈ᾱ} B(w, 1)` only within `O(ψ)` of `P` (toward lens) or within `O(√ψ)` of `R₂(ᾱ)` (away lens) | [hand, one mind, second order; ENV exact at named values] | §1.4 |

## Would have searched here (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| scan lens points and disc points numerically to see where `B(z,1)` leaves the union of discs (N2-ENV) | derived the second-order expansion of `\|y − w_{φ+θ}\|²` and its two minimisations; checked the expansion and the identities exactly at named values (ENV) |
| enumerate curvature sequences to find a one-sided stuck chain consistent with FIN | solved FIN's equality case `λ_k = f(λ_{k+1})`: concentric circles about `P_{−1}` (RAY) |
| enumerate vertex figures at `P_{−1}` to see how a chain can end | derived the end's forced colours from N112-U1, N3-DEG and FLANK (NB2-END, a sketch) |
| sample tangent-bend curvatures against contact shapes (N2-TAN) | a second-order comparison of cap height and contact rise |

## Fence log

1. **Start-up snapshot** (in my context, not a command): five commit subjects, `dfc512ff` "FS-112: NB2 instance file", `4cba3035` "FS112-Y2: stage 5
   registration", `bdd3a586` "FS112-N2: report", `3078a6d8` "FS112-N2: stage 5", `ea2509af` "FS112-N2: stage 4". Subjects only.
2. `ls data/fs112/` printed the directory names (fenced ones among them: `fs112-a2`, `fs112-a3`, `fs112-n`, `fs112-y`, `fs112-yb`, `reports`); nothing
   inside a fenced path was listed or opened. One `ls data/fs112/reports/ | head -0` printed nothing.
3. `ls data/fs112/briefs/` and one `wc -c` on my three brief files printed the other briefs' **names**; none was opened.
4. **Touch of the fenced section's headings.** `grep -n "^#" plans/FS112-N-proof.md` (to find where round 1 ends) printed the 20 heading lines of
   "§ Continuation — FS112-N2" (ll. 303–582). They carry words that prime: "red plants at R2, END and L60 (divergence 15)"; "the end vertices closed;
   NB-ISO closed by the tangent bend; RED's termination"; "the terminal map (item 2) — FLANK's exception placed; divergence 1′ named, with a new object
   (the stuck ray)"; "item 3, the first global step (route B); card X answered"; "What the base's exceptions become in `M*` [hand, one mind]"; and
   **one grade tag**: "N2-DENSE — the first global step [hand, one mind for the assembly; over the base at row 134's grade, NB4′ (two minds), N2-TERM
   (one mind)]". No body line of the section was read. The instance file already names N2-DENSE's three supports, so the tag's new content is the
   side's mind count ("one mind for the assembly") and N2-TERM's ("one mind").
5. A heading listing of `plans/FS112-unit-arc-half.md` printed §5.3's heading line ("E1–E4, E10, E17 guess where the break sits"); §5.3's body was not read.
6. `git log` beyond the snapshot: not run.

## Stage 1 — SAVED: quotation check and the ten statements, blind

### 1.1 Files read from disk (this order)

`data/fs112/briefs/STANDING-RULES.md`; the brief and the instance file; `CLAUDE.md` § The aim, § Counter-priors, G82 (from disk; G21, G51, G79 as loaded,
unchanged on a spot check of G79's line); `LEDGER.md` rows 131–134; `data/fs112/claims.md` in full; `plans/FS112-N-proof.md` ll. 1–302 (round 1, open);
`plans/FS112-NB-verification.md` in full and `data/fs112/reports/FS112-NB.md` (round 1's verifier, open); `data/fs112/briefs/N112-proof.md`;
`plans/FS112-unit-arc-half.md` §G part 3, §PA, §IQ; `plans/FS110-N-proof.md` §1.3, N3 stage 2, N4 stages 2–4; `plans/FS110-derivation.md` ll. 1–34, 60–70,
94–125; `plans/FS110-CB-verification.md` D1–D6; `[SokolovVoronov2025]` (held PDF, my `pdftotext` in scratch): Thm 1, Cor. 1, Lemma 3, Lemma 4 and its
proof, §8, §9 — **read**. Not read: `plans/FS112-PA-reading.md` (on the brief's list; nothing below rests on the 2018 threads).

### 1.2 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter" (standing rule 0) | `CLAUDE.md` § Counter-priors | verbatim (`grep -F`, 1 hit) |
| "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | `CLAUDE.md` § Toolchain | verbatim |
| "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` (Where the problem stands, item 23) | verbatim |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress." | `plans/CONSOLIDATION-2026-09-27.md` | verbatim |
| S–V's "Note that all reasoning remains valid if we consider the interior of a circle of radius 3." and Lemma 4's "fix a coloring of a circle of radius 3 … Fix such a trichromatic point u located within a distance of at most 1 from the center" | held PDF, §9 and §7 | verbatim (my extraction ll. 745–755, 1009) |
| the instance file's ten statements, "verbatim from N2's 'theorems this continuation proved' table" | fenced until this stage is committed | **not checkable at stage 1**; checked in stage 2 |

### 1.3 Readings of symbols the claim list does not define (the most natural reading, named)

- **`R₂(α)`**: the arc `{P + 2e_w : w ∈ α}` of the radius-2 circle concentric with `α` ("ends included": `w ∈ ᾱ`, so `Q_A = P + 2e_A` at an end vertex `A`).
- **`M*`**: the terminal valid modification under W-MERGE, N4-RAY, N4-SHAVE and the bends of N2-TOWARD/AWAY/TAN (N2-TERM).
- **stuck vertex**: a vertex of `M*` at which some colour has at least two sectors (N4-STUCK's hypothesis in a terminal map); **stuck chain**: N4-PROP's
  sequence `P_k` along the normal line, each with N4-STUCK's structure, `λ_k < υ_k` the curvatures of the lower and upper arcs of the `+a` horn at `P_k`.
- **near / far tile** (N2-SIGN): within `< 1` of all of `int α` / farther than 1 from all of it.
- **lens point, `ψ`, `r(ψ)`** (N2-ENV): a point of the region a bend recolours; `ψ` the bend's angle at the end vertices (thickness at arc-distance `φ`
  from the nearer end `≤ ψφ`); `r(ψ)` the radius of the escape set.
- **"one"** in N2-DENSE's "every disc of radius 5 contains one": a unit-arc centre or a stuck vertex.
- **tangent bend** (N2-TAN): a bend whose new arc is tangent to `α` at the contact's foot `w₀`, of radius `≠ 1`.

### 1.4 Verdicts, in the instance file's priority order

#### N2-RAY — "N4-FIN's application fails at a chain's end; a one-sided stuck chain (`λ_k = −1/(k+1)`, `υ_k = 0`) is consistent with N4-FIN; N4-CONE is a GAP under unit arcs"

**Verdict: TRUE** [hand, one mind; RAY exact]. It retracts round 1's "N4-FIN (a); its application also survives" (`plans/FS112-N-proof.md` row 9), and I agree
with the retraction.
1. **N4-FIN as a statement is untouched**: it is about sequences indexed by `ℤ` with `−1 < λ_k < υ_k < 1`. What N4-CONE uses is its **application**: a
   stuck vertex of a terminal map forces, by N4-PROP, a chain over all of `ℤ`, and FIN forbids that chain.
2. **The ray is consistent with FIN's inequalities.** `λ_k = −1/(k+1)`, `υ_k = 0`, `k ≥ 0`: `f(λ_{k+1}) = (−1/(k+2))/((k+1)/(k+2)) = λ_k` (equality),
   `f̃(υ_{k−1}) = f̃(0) = 0 = υ_k`, `λ_k < υ_k`, and `λ_k ∈ [−1, 0)` with `−1` only at `k = 0` (exact for `k ≤ 60`, tool RAY). *Recognition:* at `P_k` the circle
   of radius `k + 1` about `P_{−1}` has upward curvature `1/(C − j) = 1/(−1 − k) = λ_k` — the ray's lower arcs are the **concentric circles of integer radius
   about `P_{−1}`** and its upper arcs the lines through `P_k` parallel to `a`: every shadow in the chain is tight, because `f` keeps the centre and moves the
   radius by 1. FIN's upward count still bites along an upward-infinite ray (it forces `υ_k ≤ 0`); its downward count reaches `λ = −1` exactly at the ray's
   end, `k = 0`, and the next step down would need `f(−1)`, a pole (the plant `k = −1` fires there).
3. **The end is not excluded by N112-END.** END forbids `λ_{k+1} = −1` only when `P_k` has N4-STUCK's structure. At the ray's end, `P_{−1}` is not stuck —
   and END's own argument shows it cannot be: `λ_0 = −1` makes the lower arc of `c = a_0`'s horn a unit arc `α ⊂ ω(P_{−1})` with `s_out = c`, so by N112-U1
   `c`'s sectors at `P_{−1}` lie in the away cone of width `π − ℓ`, while a stuck `P_{−1}` would need `c` to fill the `−n` half-plane there.
4. **So the chain is one-sided exactly when N4-PROP's step `P_0 → P_{−1}` fails, and that step has no proof at `λ_0 = −1`.** It rests on N4-STUCK (ii)–(iv)
   at `P_0`, which rest on N4-FLANK — failing at `κ₋ = −1` (an in-type flank tile at `S′ = P_{−1}` becomes possible; NB-FLANK, two minds) — and (iv) rests
   on NB-4 at `P_{−1}`, a unit-arc centre (NB-4's (E1)). Had the step survived, END would make `λ_0 = −1` impossible, chains would be bi-infinite with
   strict bounds, and N4-CONE would stand. **The GAP is precisely N4-PROP at a unit-arc end.** Not FALSE: no terminal valid map with a stuck vertex is held.
   Finite chains (both ends at `±1`) and a single stuck vertex with bounds `−1` and `+1` are equally unexcluded (round 1's NB noted the last); the ray is
   the case that also survives FIN's count, since its lower end absorbs the whole descent.
5. **(Sketch, one mind, not needed for the verdict — NB2-END.)** At the end: `c ∈ P_cl(P_{−1})` (N3-DEG at `P_0`, out-type) with its sectors in the away
   cone, so the side cone `(−ℓ, 0)` at `P_{−1}` holds neither `c` nor `h` (N112-U1). The out-type `g`-tiles at `P_{−1}` that shadow `P_0`'s horns from below
   (FLANK for the upper flank `g` is unaffected by `κ₋ = −1`) are two `g`-sectors separated by `c`'s sector; terminality then gives `int D_g(P_{−1}) = ∅`,
   so they are cusp horns (N3-DEG), and the sector just below `g`'s `+a` horn has a colour `y ∉ {c, g, h} = P_cl(P_0)`. A SHAVE of that horn is blocked
   only if `y` shadows it; FLANK's list allows that only through `y`-tiles at `P_0` (impossible) — so the end needs an unlisted shadow, the natural one being
   FLANK's in-type exception one step further down: the horn's lower arc a unit arc of `ω(P_{−2})` with `y` in-type at `P_{−2}` (a both-kind arc centred at
   `P_{−2}`). If that is the only way, a chain's end forces a unit arc one step beyond it — the shape of C-UA-CHAIN, and a candidate route to close the GAP.

#### N2-DENSE — "in `M*`, every trichromatic cubic vertex has a unit-arc centre within 4 or a stuck vertex within 3; every disc of radius 5 contains one"

**Verdict: TRUE, and it holds for every valid map, with radii 3, 2 and 4** [hand, one mind; over the base at row 134's grade, NB4′ (two minds) and
N112-SIX]. It does not need `M*`: its only input about the map is validity (the base's own setting), with "stuck vertex" read as "a vertex carrying a
repeated colour" — which is what a stuck vertex of `M*` is.
1. **What the base reads from `u`** (CB's route, the one row 134 uses; `plans/FS110-CB-verification.md` D1–D6): the ring `Ω = ω(u)` and the open disc
   `B(u, 1)` (the pigeonhole's paths and their trichromatic endpoints, D5); pairs `u₁, u₂ ∈ B̄(u, 1)` at distance `< 2` and their circles `Ω_i = ω(u_i) ⊂
   B̄(u, 2)`; the partner points `x ∈ Ω₁`, `y ∈ Ω₂` and the circles `ω(x)`, `ω(y)` (D2 (i)/(ii), D4); the strips at `u, u_i` ("no arc from u lies on a unit
   circle", circles `ω(u_i + e)`). So it reads the map's local structure (cubicity, NB-4, cusps — CUSP-BASE's normal circles `ω(u ± n)`) only at points of
   `B̄(u, 2)`, and Condition 5 only on circles centred in `B̄(u, 2)`. S–V's printed §9 ("all reasoning remains valid if we consider the interior of a circle
   of radius 3", with `u` within 1 of the centre) would give 4 from `u`; CB's route gives 2.
2. **The exceptions.** If `B̄(u, 2)` holds no vertex with a repeated colour, no vertex of `≥ 4` colours and no unit-arc centre, every circle the base reads
   meets `Γ` finitely and every point it reads is cubic or a corner, so the base (COR1-NOD2 with CUSP-BASE, a.e., curved, cubic, no `d = 2` exception)
   refutes the map near `u`. A vertex `v` of `≥ 4` colours has a unit-arc centre within 1: at `|P_cl(v)| ≥ 5`, arcs centred at `v` (N112-SIX); at four
   colours, either `ω(v) ∖ Γ` has a change point — then NB4′ puts an arc of `ω(v)` (centre `v`) or of `ω(y_{k±1})` (centre on `ω(v)`) at an orbit point — or
   it has none, and the colour changes of `ω(v)` happen across arcs of `Γ` on `ω(v)`, centred at `v`. So: **a repeated-colour vertex within 2 or a unit-arc
   centre within 3** — N2-DENSE's "stuck within 3 / centre within 4" a fortiori.
3. **Every closed disc of radius 1 contains a vertex of degree `≥ 3` (NB2-DISC1).** Let `x` be a point, `T₀` a tile with `x ∈ cl T₀`; `cl T₀ ⊆ B̄(x, 1)`
   (TS-C). If the outer boundary curve of `T_k` has no branch point, the tile across it is one tile `T_{k+1}`, bounded (TS-C), surrounding `T_k` and `x`; for
   `p ∈ T_{k+1}` the ray from `x` away from `p` meets `cl T_{k+1}` at `q` with `x` between them, so `|p − x| ≤ |p − q| ≤ 1`: `cl T_{k+1} ⊆ B̄(x, 1)`. Local
   finiteness ends the nesting, at an outer boundary with a branch point — a vertex of degree `≥ 3` in `B̄(x, 1)`. (CB's D6 states the trichromatic form for
   cubic maps; this form needs no hole-filling.)
4. **Assembly.** In `B̄(x, 1)` there is a vertex `w` of degree `≥ 3`: a repeated colour (done), `≥ 4` colours (a centre within 2 of `x`), or trichromatic
   cubic (by 2, a repeated-colour vertex within 3 or a centre within 4 of `x`). **Every closed disc of radius 4 contains a unit-arc centre or a
   repeated-colour vertex** — N2-DENSE's radius 5 a fortiori.
- *Where six is spent:* in the base (S–V's multicolour count and Lemma 2) and in NB4′'s complementary 2-set. *Seven-colour control:* the hexagonal
  seven-colouring has trichromatic cubic vertices with no unit arc and no repeated colour anywhere — the conclusion is false there, as it must be, since the
  base does not start with seven colours. *C-BEYOND:* step 2 reads `B̄(u, 2)` and is local; the statement is a density statement about maps of the plane, so a
  strip (not a map of the plane) does not test it.

#### N2-TOWARD — "`s_out ∉ P_cl(P)` ⟹ the whole unit arc, end vertices included, bends toward `P` (no stub)"

**Verdict: TRUE** [hand, one mind; INTYPE exact]. The interior is N112-BEND (two minds). At an end vertex `A` (frame: `e_A` outward normal, `τ_A` the
tangent along `α`), bend with a lens that is a wedge of small angle `ψ` at `A` inside `B(P, 1)`, recoloured `s_out`. `τ_A` bounds `T_out`'s sector at `A`, so
`τ_A ∈ D_{s_out}(A)`; by N3-CLEAR every `s_out` contact on `ω(A)` whose half-plane has `τ_A` strictly inside clears the wedge for small `ψ`. The contacts with
`τ_A` on their boundary line are at `A ± e_A`, i.e. at `P` and at `Q_A = P + 2e_A`:
- at `P`: excluded by `s_out ∉ P_cl(P)`;
- at `Q_A`, **in-type** (inside `B(A, 1)`): N-E2 against `T_out` forces the Siamese branch, `T_out ⊆ B̄(Q_A, 1)`, but `T_out`'s points just outside `α` near
  `A` lie outside that disc (INTYPE exact; plant: a point above `ω(Q_A)` fires) — impossible;
- at `Q_A`, **out-type**: a tile there with directions off `±τ_A` shadows near `A` only points of `B(Q_A, 1)`, which the lens misses; one tangent to `τ_A`
  shadows (N4-SHADOW) the far side of a circle `Σ` tangent to `τ_A` at `A`, and `Σ` cannot pass below `α` — else `T_out`'s own points just outside `α` near
  `A` are shadowed by a tile of their colour (N-E0). So the lens, strictly below `α`, is clear. (If `T_out`'s sector at `A` has positive angle, `T_out` has
  points on both sides of `ω(Q_A)` and N-E2 forbids any `s_out` tile at `Q_A`.)
The same at the other end; compactness joins the end wedges to the interior margin. The new arc has radius `< 1`; the old arc vanishes whole — **no stub**.
Contacts along a whole arc of `ω(A)` are covered (compact contact sets; an arc ending at `P` or `Q_A` puts its tile at that point).

#### N2-AWAY — "`s_in ∉ P_cl(P)` and no `s_in` tile touching `R₂(α)` (ends included) ⟹ the whole arc bends away; the end vertex's only blocker is R2 at the end"

**Verdict: TRUE** [hand, one mind; R2 exact]. The mirror of TOWARD: at an end `A` the only contacts with `τ_A` on their boundary are `s_in` tiles at `P`
(excluded) and at `Q_A` (excluded by "ends included"), so a wedge lens clears. *The second clause, sharpened:* `T_in` near `A` lies outside `B(Q_A, 1)`, so an
`s_in` tile at `Q_A` is outer (outside `B(A, 1)`), and its shadow near `A` is the far side of a tangent circle `Σ` of upward curvature `σ ≥ −1` (else `T_in` is
shadowed). With `σ > −1` it blocks a **wedge** lens (the wedge's first-order height `ψs` exceeds the gap `(σ+1)s²/2` near `A`) but not a **horn** lens tangent to
`α` at `A` with curvature in `(−1, σ)`; only `σ = −1` — the tile bounded near `Q_A` by the radius-2 circle, whose shadow circle is `f(−1/2) = −1`, the unit
arc itself (tool R2) — blocks every lens. So "the end vertex's only blocker is R2 at the end" is TRUE, with horn-shaped end lenses.

#### N2-TAN — "isolated R2 contacts (and ends of R2 sub-arcs) are cleared by a tangent bend; only R2 along an arc blocks (NB-ISO closed)"

**Verdict: TRUE** [hand, one mind; round 1's NB sketch (`plans/FS112-NB-verification.md` §1.5 BEND) completed]. Let `Y` be an `s_in` tile touching `q₀ = P +
2e_{w₀}`, outside `B̄(P, 2)` near `q₀` (N112-LOCK). Bend `α` near `w₀` away from `P` by an arc tangent to `α` at `w₀` with curvature `κ < 1` (radius `> 1`),
corners elsewhere on `α` at non-contact points. At angular offset `δ` from `w₀` the lens has height `h ≤ (1 − κ)δ²/2`; for a lens point `z` there, `ω(z)`
leaves `B̄(P, 2)` only in a cap near `P + 2e_{w₀+δ}` of height `h` and angular width `≍ √h`. `Y`'s boundary at `q₀`, being made of segments and circular arcs,
either **is** the radius-2 circle on a side of `q₀` (R2 along an arc) or rises above it at least linearly (a corner, rise `≍ δ`) or quadratically with a
positive coefficient `a` (a tangent arc of another curvature, rise `≈ 2aδ²` at arc-distance `2δ`; an arc bending into `B(P, 2)` is excluded by LOCK). With
`(1 − κ)` small against `a`, every cap stays under `Y`. **Only a tile along the radius-2 circle over an arc blocks**; at the end of such a sub-arc the bend is
made on the free side, tangent at the sub-arc's end. Isolated contacts are finitely many (local finiteness), so the bends are finitely many pieces. NB-ISO is
closed.

#### N2-RED — "N112-RED with its end-vertex and isolated-contact GAPs closed, and its termination (no stubs)"

**Verdict: TRUE** [hand, one mind; over NB-MERGE3 (two minds: round 1 N, NB) and N2-TOWARD/AWAY/TAN as derived here]. The case split is round 1's: an arc not
bendable toward `P` has `s_out ∈ P_cl(P)` (TOWARD, ends included); not bendable away, `s_in ∈ P_cl(P)` or an `s_in` tile along `R₂` over an arc (AWAY, TAN);
both side colours at `P` with exactly three colours: W-MERGE removes one (NB-MERGE3); with the side cones in two different colours, `P` carries `≥ 4` — (Q).
**Termination:** no operation creates a unit arc (bends make radii `≠ 1`; W-MERGE's new arcs have radius `ρ < 1`); a bend removes its arc **whole** (no stub),
so each original unit arc is operated at most once; W-MERGE lowers `Φ` at its vertex and raises it nowhere; a bend's lens is chosen to avoid the finitely many
unit-arc centres near `α` that are not on `α`, and centres on `int α` become interior points of the merged tile (types only shrink). N4-TERM's enumeration
argument then gives a terminal modification. *Where six is spent:* nowhere in the reduction (contacts of one colour); six enters at (Q)'s four colours.

#### N2-TERM — "the terminal map: arcs (Q)/(R2); vertices cubic, NB4′ exceptions, or stuck on chains ending near (Q)/(R2)/NB4′ or running to infinity (GAP)"

**Verdict: TRUE, with its GAP as named** [hand, one mind]. *Existence:* every operation (MERGE, MERGE-RAY, SHAVE, the bends) is local, creates no unit arc and
no repeated colour, and whether it is available depends on the map within a bounded distance (3 about a vertex; `α`, `P` and `R₂(α)` for a bend); N4-TERM's
enumeration (arcs listed with vertices) gives `M*`. *Arcs:* (Q)/(R2), by N2-RED. *Vertices:* a vertex of degree `≥ 3` is trichromatic cubic, `≥ 4`-colour, or
carries a repeated colour (exhaustive by definition). A repeated colour in a terminal map satisfies N4-STUCK's hypothesis (W-MERGE and N4-RAY survive unit
arcs), and N4-PROP carries the structure along the normal line until a step meets an exception: NB-4 at `P_k` or `P_{k±1}` (a `≥ 4`-colour vertex, NB4′'s
exception), N4-FLANK at a horn bound `±1` (a unit arc centred at `P_{k±1}`, (Q) or (R2) by N2-FLANK-Q), or N4-STUCK (iv)'s arc of `ω(P_k)` through `P_{k±1}`
(a unit arc, (Q) or (R2) in `M*`). A chain with no end is bi-infinite with N4-STUCK's structure everywhere, and N112-END with N4-FIN excludes it. **Precision:**
the two alternatives are not exclusive — a chain "running to infinity" is one-sided, and its one end is within 1 of a (Q)/(R2) arc or a `≥ 4`-colour vertex; the
GAP is that its vertices may lie arbitrarily far from every exception (N2-RAY).

#### N2-FLANK-Q — "a horn bound `±1` sits on a (Q) arc (FLANK's in-type exception, then two-sided) or an (R2) arc (FLANK's out-type tile along the radius-2 circle)"

**Verdict: TRUE** in `M*` [hand, one mind, over N2-RED; R2 exact]. A `c`-horn along `+a` at `v` with `κ₋ = −1` has its lower arc on `ω(S′)`: a unit arc with
`s_out = c` (the horn, outside `B(S′, 1)`) and `s_in = h` (the lower flank, inside). In `M*` it is (Q) or (R2) (N2-RED; `s_out = c ∈ P_cl(S′)`, else TOWARD bends
it). **(Q):** `h ∈ P_cl(S′)`, and by N112-U1 its sectors at `S′` lie in the facing cone, pointing into `B(v, 1)` — an in-type `h`-tile at `S′`, Siamese with the
flank: FLANK's exception; "two-sided" read as "both side colours at the centre". **(R2):** an `h`-tile along the radius-2 circle about `S′`, which passes through
`N`; near `N` it lies outside `B(v, 1)` (the radius-2 circle bends at curvature `1/2`, `ω(v)` at `1`), so it is FLANK's out-type `h`-tile at `N`, and its shadow
circle at `v` is `f(−1/2) = −1` — `ω(S′)`, the unit arc itself, i.e. `σ_h = κ₋`. The bound `+1` is the mirror (`ω(N)`, flank `g`, radius-2 circle about `N` through
`S′`).

#### N2-SIGN — "every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it (near / far tiles)"

**Verdict: TRUE for points of (open) tiles; FALSE if read for closure points** [hand, one mind; SIGN exact]. If a tile point `x ≠ P` of colour `s ∈ {s_in,
s_out}` had `|x − w| ≤ 1 ≤ |x − w′|` on `int α`, continuity gives `w ∈ int α` with `|x − w| = 1`. If `x − w ∦ e_w`, `ω(x)` crosses `α` transversally at `w` and
meets both `T_in` and `T_out`: N-E0 fails whichever `s` is. `x − w = −e_w` is `x = P`. `x − w = +e_w` is `x = P + 2e_w`: then `ω(x)` meets `T_out` near `w`
(fails for `s_out`), and for `s_in` the open tile contains points `x′` just inside `B(P, 2)`, at distance `< 1` from `w` and `> 1` from points of `int α` about
`√δ` away (`|2e_0 − e_θ|² = 5 − 4cos θ`, SIGN exact), whose unit circles cross `α` transversally: N-E0 fails. So no tile point is on the fence. **Scope:** for a
**closure** point the statement fails — an R2 contact `P + 2e_w`, `w ∈ int α`, is in the closure of an `s_in` tile and at distance exactly 1 from `w`.

#### N2-ENV — "a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` (toward lens) or near `R₂(α)` (away lens), within `r(ψ) → 0`"

**Verdict: TRUE, with `r(ψ) = O(ψ)` toward and `O(√ψ)` away** [hand, one mind, second order; ENV exact at named values]. Reading: `U = ⋃_{w∈ᾱ} B(w, 1)`; a lens
point `z = w_φ ∓ t e_φ` (toward `−`, away `+`) with `t ≤ ψ·min(φ, ℓ − φ)` (the wedge profile at both ends; bounded by `ψℓ` inside). A point `y ∈ B(z, 1) ∖ U`
lies outside `B(w_φ, 1)`, hence in the crescent `y = w_φ + (1 + s)u`, `0 ≤ s ≲ t|u·e_φ|`, with `u = −rot(e_φ, β)` (toward) or `+rot(e_φ, β)` (away).
Against `w_{φ+θ}`, to second order,
`|y − w_{φ+θ}|² ≈ 1 + 2s + 2θ sin β + θ²(1 − cos β)` (toward), `≈ 1 + 2s − 2θ sin β + θ²(1 + cos β)` (away) (ENV exact; plant: the linear term's sign
flipped fires). **Toward:** a `θ` of the right sign, `|θ|` up to `φ` or `ℓ − φ`, gains `≈ 2|θ||sin β|`, so `y ∈ U` unless `|β| ≲ t/φ ≤ ψ` (and `t/(ℓ − φ)`
on the other side): `y` is within `≈ |β| = O(ψ)` of `w_φ − e_φ = P`. **Away:** the gain is at most `1 − cos β ≈ β²/2`, reached at `θ = tan(β/2)` (exact
identity), so `y ∈ U` unless `β² ≲ 4s`, i.e. `|β| = O(√t) = O(√ψ)`: `y` is within `O(√ψ)` of `P + 2e_φ ∈ R₂(ᾱ)` (near an end, of `Q_A`). Both radii tend to 0
with `ψ`. **Divergence to check:** if the side states `r(ψ) = O(ψ)` for both lenses, the away case is `O(√ψ)`.

### 1.5 Where "six" is spent, and the controls

Six is spent in N2-DENSE (the base's multicolour count and Lemma 2; NB4′'s complementary 2-set) and nowhere in N2-RAY, TOWARD, AWAY, TAN, RED, SIGN, ENV or
FLANK-Q (contacts and shadows of one or two colours). N2-TERM spends it through NB-4 at the chain's steps. *Seven-colour control:* the hexagonal seven-colouring
has no unit arc and no repeated colour: every bend and chain statement is vacuous there, and N2-DENSE's conclusion is false there, as it must be. *CAL-STRIP:*
no verdict above refutes a strip; the bends and SIGN/ENV are statements about one arc and hold on the strip's arcs.

### 1.6 Tool

`tools/fs112_nb2_checks.py --self-test` → `data/fs112/fs112-nb2/checks.out`: RAY, R2, SIGN, INTYPE, ENV pass; each plant fires for its own named reason (RAY:
the pole at `k = −1`; R2: `f(−1/3) = −1/2`; SIGN: radius `1.9` changes sign; INTYPE: a point above `ω(Q_A)` is inside its disc; ENV: the flipped linear term's
first-order error). Three defects of my own were found and fixed before this record (a plant's radius truncated by `sp.Integer`; the INTYPE plant on the wrong
side of `ω(Q_A)`; a stationarity test relying on `simplify`), each seen as a plant that did not fire or a faithful check that failed.

## Stage 1 — SAVED

## Stage 2 — SAVED: the side's section read (after `8e3a08d6`); divergences

*Read after stage 1 was committed and pushed (`8e3a08d6`): `plans/FS112-N-proof.md` ll. 303–582 (§ Continuation — FS112-N2) in full;
`tools/fs112_n2_checks.py` (header and plant table); `data/fs112/fs112-n/n2-checks-selftest.out`. Re-run: `python3 tools/fs112_n2_checks.py --self-test`,
exit 0, output identical to the committed one (seven plants fire for their own reason codes, faithful run PASS; my copy in scratch). N2's ENVT/ENVA identity
checked by hand as well: at `s = 0`, `8 cos η sin(η + Δ/2) sin(Δ/2) = 4 cos η (cos η − cos(η + Δ))` gives `|p − z|² − 1` for `p = 2cos η·e_{−η}`,
`z = e_Δ`; the `±s` and `s²` terms follow from `(1 ∓ s)²` and `−4cos η (1 ∓ s) cos(η + Δ)`.*

### 2.1 Quotation check of the instance file against the side's table

All ten statements are **verbatim** against the table "N2: theorems this continuation proved" (`plans/FS112-N-proof.md` ll. 310–323; string comparison,
N2-RAY differing only by the instance file's line break). The instance file's gloss on N2-DENSE ("the side rests it on row 134's base, on NB4′, and on
N2-TERM") matches the table's grade cell.

### 2.2 The contest's result

**No statement the side calls TRUE do I find false, and none I call TRUE does the side refute.** On N2-RAY — the step the round turns on — both walks,
mine blind, find N4-CONE a GAP under unit arcs at the same place: N4-PROP cannot be carried past a chain's end where a horn bound is `±1`, N112-END does not
reach the end, and the ray `λ_k = −1/(k+1)`, `υ_k = 0` meets N4-FIN's inequalities. The divergences are of scope, precision and wording; three are mine to
correct.

### 2.3 Divergences, each with both addresses

| # | statement | mine (stage 1, §1.4) | the side (`plans/FS112-N-proof.md`) | changes a verdict? | resolution |
|---|---|---|---|---|---|
| 1 | N2-DENSE: radii and hypothesis | TRUE for **every** valid map ("stuck" read as "repeated colour"): a repeated-colour vertex within 2 or a unit-arc centre within 3 of `u`; every closed disc of radius 4 has one; CB's route reads local structure only in `B̄(u, 2)` and Condition 5 only on circles centred there | TRUE in `M*`, radii 4 / 3 / 5, over N2-TERM; the base "reads … points in `B̄(u, 3)`" (§5.3 (4)) | **no** (both TRUE); scope | Mine drops a hypothesis and sharpens the radii; N2's are sufficient. The base's circles `ω(x(t))`, `ω(y(t))` reach radius 3, but CB reads them only at their passage through the partner point (D1 (P′), D2 (i)/(ii)), which lies on `Ω_i ⊂ B̄(u, 2)`. **Consequence for the grade:** DENSE need not rest on N2-TERM (one mind). N2's disc-of-radius-1 lemma, "a sketch" there, is NB2-DISC1 here in full: two minds |
| 2 | N2-RAY: where the step fails | "(ii)–(iv) at `P_0` rest on N4-FLANK … and (iv) rests on NB-4 at `P_{−1}`" (stage 1 §1.4 N2-RAY item 4) | "(ii) holds: the in-type `g`-contact at `N` gives the same half-plane `{d·n ≥ 0}` as the out-type one at `S′`"; (iii)–(iv) change at the exceptions (§N2-4) | no; precision — **mine corrected** | The side is right: N4-STUCK (ii) uses FLANK only for the half-planes, and an in-type flank tile at the near antipode gives the same one. PROP's step at a unit-arc end fails in **(iv)** (the two `g`-sectors at `S′` came from out-type `g`-tiles there, which FLANK's exception replaces; and NB-4 at `S′`, a unit-arc centre). The GAP's location is unchanged: PROP at the end |
| 3 | N2-RAY: the ray's shape | the ray is the family of **concentric circles of radius `k+1` about `P_{−1}`** (every shadow tight), upper arcs straight | "met with equality by `λ_k = −1/(k+1)`, `υ_k = 0` (straight upper arcs)", "horn curvatures tending to 0" | no; mine adds | A recognition the side does not state; it makes the ray one object (a pencil of concentric circles and parallel lines along a normal line) |
| 4 | N2-RAY: what the GAP lists | the GAP at N4-PROP's step at a unit-arc end; finite chains and a single stuck vertex with bounds `±1` equally unexcluded; NB2-END (sketch): an end at `λ_0 = −1` forces, if `g` has two sectors at `P_{−1}`, a colour `y ∉ P_cl(P_0)` in the side cone below `g`'s horn there, whose shadow FLANK's list lacks | GAPs "(a) finite stuck chains between two exceptions; (b) the stuck ray" (§N2-4) | no; compatible | Same GAP. NB2-END is an addition, conditional (its premise "two `g`-sectors at `P_{−1}`" is exactly what divergence 2 says FLANK's exception can remove), one mind, a sketch: a candidate route in which a chain's end forces a unit arc one step beyond it |
| 5 | N2-TOWARD: route | contact half-planes through `τ_A` at the end vertex: only `P` and `Q_A`; in-type at `Q_A` impossible (N-E2 against `T_out`), out-type's shadow circle cannot pass below `α` | near tiles lie in `I = B̄(A, 1) ∩ B̄(B, 1)` and stay within `< 1` of every lens point (N2-ENV); far ones reach only `B(P, r(ψ))`; a Siamese tile at `q_A` would need `ᾱ ⊆ B̄(q_A, 1)` (§N2-3) | no; **different routes** | Two minds by different routes, mine blind. N2's lens stays inside `T_in`'s sectors at the ends (a corner, or a tangent start inside a horn); mine is a wedge that may cross other tiles at `A`. Checked sighted: `⋂_{w∈ᾱ} B̄(w, 1) = B̄(A, 1) ∩ B̄(B, 1)` for `ℓ < 60°` (a point within 1 of both ends is within 1 of every arc point except when it lies across `P`, which only `P` does) |
| 6 | N2-AWAY: the end's blocker | with a horn lens only an `s_in` tile bounded near `Q_A` by the radius-2 circle blocks (`f(−1/2) = −1`); any tangent tile blocks a wedge lens | "blocked at first order by an `s_in` tile touching `q_A` … and by nothing else"; N2-TAN applies at "an isolated point `w₀` of `C₂` (interior, or an end of `α`)" | no; wording | The same fact: N2's tangent bend at an end is my horn lens |
| 7 | N2-TAN | a contact tile rises linearly or with coefficient `a > 0`; only the radius-2 circle along an arc blocks | the same, with `a > 0` written `κ_Y < 1/2` (§N2-3) | no | Two minds, the same argument (both complete round 1's NB sketch); the side adds that the pair `(w₀, q₀)` stays outer |
| 8 | N2-RED: termination | "each original unit arc is operated at most once, and wholly" | a bend "removes an arc (or replaces it by (R2) pieces) and is re-enabled only by a W-MERGE or by a colour lost at its centre (then it is removed for good)"; a lens meets another arc's R2 witness at most at a point (§N2-3) | no; precision — **mine corrected** | The side is right: where `α` carries an R2 sub-arc the bend removes the rest and leaves (R2) pieces, which a later W-MERGE may free. Termination stands by the side's count; my "at most once, wholly" is true only for arcs with no R2 sub-arc |
| 9 | N2-TERM | the two alternatives are not exclusive; every chain has an end within 1 of an exception; the GAP is distance from exceptions | item 3: "each end that is not at infinity is within distance 1 of a (Q) or (R2) arc or an NB4′ exception … One-sided infinite chains: GAP" | no | Agree, the same precision |
| 10 | N2-FLANK-Q: "then two-sided" | read as "both side colours at the centre" | "the exception is one unit arc of `ω(N)` through `v`, never one-sided": both horns' upper arcs lie on `ω(N)` once N4-STUCK (ii) makes `g` fill the `+n` side (§N2-4) | no; **my reading of an undefined phrase was wrong** | Re-derived sighted: at a stuck vertex `g` fills the `+n` side and is Siamese with the in-type `g`-tile at `N` (N-E2), so `g`'s sector lies in `B̄(N, 1)`; both horns' upper arcs bound it, so their upward curvature is `≥ 1`, hence `= 1`: one arc of `ω(N)` through `v`. TRUE, two minds (mine sighted on this clause) |
| 11 | N2-SIGN: scope | TRUE for open-tile points; false for closure points (an R2 contact is at distance 1 from its foot) | proof reads open tiles; adds that each tile is wholly near or far by connectedness | no; wording | Agree. The side's "near = inside `I`" and "far = outside `⋃ B(w, 1)`" are the closure forms, consistent |
| 12 | N2-ENV: orders | `r(ψ) = O(ψ)` toward, `O(√ψ)` away | toward `B(P, r(ψ))`; away "a cap of radial height `≤ s` and angular half-width `≍ √s`" | no | Agree: the side's `√s` is my `√ψ`. Its exact identity for points beyond an end is correct (checked by hand, above, and by its tool) |

**Agreements** (second mind on each, mine blind; the side's first): N2-RAY, N2-DENSE (in either form), N2-TOWARD (different routes), N2-AWAY, N2-TAN,
N2-RED, N2-TERM, N2-FLANK-Q, N2-SIGN, N2-ENV — **every one TRUE**; the GAPs named (N4-CONE at a stuck chain's end or ray) are the same GAP.

### 2.4 Corrections to my stage 1 (not free: stage 1 was committed; counted)

1. N2-RAY item 4: "(ii)–(iv) at `P_0` rest on N4-FLANK" → **(ii) survives FLANK's exception; PROP's step at a unit-arc end fails in (iv)** (divergence 2).
2. N2-RED's termination: "each original unit arc is operated at most once, and wholly" holds only for arcs with no R2 sub-arc; in general a bend leaves (R2)
   pieces that a later W-MERGE may free, and termination is the side's count (divergence 8).
3. N2-FLANK-Q: "two-sided read as 'both side colours at the centre'" → the side's meaning, re-derived (divergence 10).
Retractions: three, all mine, all after reading.

### 2.5 Items for the close (proposed; I edit none of the shared files)

- `LEDGER.md` / the derivation file: N2-RAY, N2-TOWARD, N2-AWAY, N2-TAN, N2-RED, N2-TERM, N2-FLANK-Q, N2-SIGN, N2-ENV at **two minds, one blind**
  (N2; NB2); N2-TOWARD by different routes; N2-DENSE at two minds, **best filed in NB2's form**: every valid map; a repeated-colour vertex within 2 or a
  unit-arc centre within 3 of each trichromatic cubic vertex; every closed disc of radius 4 contains one — over the base (row 134's grade), NB4′ and
  N112-SIX, **not** over N2-TERM; NB2-DISC1 (every closed disc of radius 1 holds a vertex of degree `≥ 3`) two minds (N2's sketch, NB2's proof).
- The ray's recognition: the extremal stuck ray is the pencil of circles of radius `k + 1` about `P_{−1}` with straight upper arcs.
- NB2-END (one mind, a sketch, conditional): a candidate route to close N4-CONE's GAP — a chain's end forces a further unit arc one step beyond it.

## Stage 2 — SAVED
