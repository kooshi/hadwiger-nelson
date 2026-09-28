# FS112-YB3 — round-3 blind verification of FS-112's construction side (the chain's end at a unit arc; the two pinned corners)

*Job FS112-YB3, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `8f01c225`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by the
instance file `data/fs112/briefs/YB3-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. The side verified is FS112-Y3 (round 3); its record,
tools and outputs stay fenced until my step 3 (every verdict below on Y3's nine claims) is committed. Every object below is a local fragment, not a map
of the plane.*

## Theorems this phase proved

The table is at the end of stage 3 ("Theorems this phase proved (FS112-YB3)").

## Would have searched here (standing rule 3)

- END-A, END-B: I would have tried horn lengths and closing colours until the checker accepted; instead each was fixed once by a derivation
  (rational points of the named circles; the closing colour 6 as the one colour no tile within reach forbids) and checked once.
- BOWTIE: I would have searched configurations for a stuck vertex with no `h` at `N`; instead Step 2's exception (in-type `h` at `E − n` needs
  `λ_E = −1`) named one configuration, built once.
- DISK-T* and STRIPCUT: I would have sampled points of the regions; instead named points by formula (centroids and pulled corners of `V`;
  rational unit vectors from `Q`), each checked exactly.
- The coverage guard is a float sampler, used as a sanity check only, never as a verdict.

## Fence log (standing rule 13; brief § Fences; instance)

1. Start-up, `git log --oneline -8` (to see whether I was resuming) printed one commit subject **beyond the start-up snapshot `8f01c225`**:
   `1cc4986f FS-112 inventory: YB3 launched` — a neutral subject; nothing else of it read. Logged as a touch of `git log` beyond the snapshot.
2. Start-up, `ls data/fs112/briefs/` printed the **file names** of the briefs (the fenced ones by name only: A112, A2-112, A3-112, N112, N2-112, N3-112,
   NB*, P112, PA112, Y2-112, Y3-112, YB112-instance, YB2-112-instance); none opened but mine, my instance file and `STANDING-RULES.md`.
3. Start-up, `ls data/fs112/` printed **directory names**, among them the fenced `fs112-a`, `fs112-a2`, `fs112-a3`, `fs112-n`, `fs112-nb`, `fs112-nb2`,
   `fs112-y`, `reports` — names only; nothing in the fenced ones listed, opened or grepped. `ls data/fs112/reports/ | head -0` printed nothing.
4. Read in full, open to me by the instance: `plans/FS112-Y-construction.md` (it holds rounds 1–2 only: Y's stages 1–2 and Y2's § Continuation, ll. 1–651;
   no Y3 text), `plans/FS112-YB-verification.md` (in parts: head, stages 3–4), `plans/FS112-YB2-verification.md` (in full).
5. My scratch directory is `scratchpad/fs112-yb3/`; nothing else in the shared scratchpad was listed or opened.
6. The owner's fence extension (message during stage 2): `plans/FS112-derivation.md`, any "§R-close" of `plans/FS112-unit-arc-half.md`,
   `data/fs112/fs112-c/`, `data/fs112/reports/FS112-C.md`, `data/fs112/briefs/C112-close-math.md`, `plans/STUB-global-step.md`,
   `plans/STUB-stuck-ray.md`. **None touched**: my read of `plans/FS112-unit-arc-half.md` was ll. 1–80 (headings) and 511–611 (stage 5 and its
   addendum, the file's end at that read); its heading list showed no "§R-close".

## Stage 1 — SAVED: reading; the quotation check

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors **from disk** (296,992 bytes at `8f01c225`; link 2 on disk carries the
`[GwynStavrianos2022]` sentence my context's snapshot lacks; I work from disk), G20, G21, G22, G60 (unchanged from my snapshot); `LEDGER.md` rows
133–134 as the claim list quotes them; `data/fs112/claims.md` **in full** (§0, §3 and §7 closely); `plans/FS112-unit-arc-half.md` stage 5 (§§5.1, 5.2,
5.4–5.7 and the addendum; **not §5.3**); `plans/FS112-PA-reading.md` (stages 4 and 8); `plans/FS112-Y-construction.md` ll. 1–651 (Y and Y2);
`plans/FS112-YB2-verification.md` in full; `plans/FS112-YB-verification.md` stages 1, 3, 4; **FS-110's chain in its proof record**,
`plans/FS110-N-proof.md` stage N4-2 (§§2.1–2.8: N4-SHADOW, N4-FLANK, N4-SHAVE, N4-RAY, N4-STUCK, N4-PROP, N4-FIN, N4-TERM) and the statements in
`plans/FS110-derivation.md` ll. 50–100; `[AxenovichEtAl2014]` p. 8 (text layer); `[Polymath2021]` pp. 194, 197–200 (PDF pp. 30, 33–36, text layer).
The frozen FS-110 tools and YB2's checker are read at stage 2, where I use them.

### 1.2 Quotation check (standing rule 5) — `tools/fs112_yb3_quotes.py`, output `data/fs112/fs112-yb3/quotes.out`

19 quotations: the brief's `[AxenovichEtAl2014]` sentences; the standing rules' five Kooshi quotations; C-CHAIN-8 and C-CHAIN-9 (which the claims
build on); the two GAPs of Y2 that Y3-STRIPCUT and Y3-DISK-T* answer; and **the instance's nine Y3 claims**.
- **9 FOUND verbatim** (whitespace, typographic quotes, backticks normalised).
- **1 punctuation-only difference**: standing rule 4's *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
  carries a terminal period inside the quotation marks that `CLAUDE.md` (Frontier item 23) does not have — the words exact (YB2 found the same).
- **9 FENCED**: the nine Y3 claims are quoted from `plans/FS112-Y3-construction.md`'s table, which I may not open before step 3; they are checked
  after step 3 (`--after-step3`), at stage 5.
- `--self-test` (`quotes-selftest.out`): one word altered in the Axenovich quotation turns it MISSING while its faithful twin is FOUND.

**No paraphrase found in my brief, instance or standing rules.** One naming point: the instance says to use YB2's labels for the disk and YB's for the
strip where a symbol is defined only in the fenced record. `T*`, `T2_0`, `Y_0`, `Z^L_0`, `C_k` are **defined in Y2's section**, which is open, so I use
Y2's labels for them (the claims' own words); the correspondence with YB2's labels is stated at stage 2 so that either can be read. `N`, `E`, `q2`, `K`
are defined in the claims' own text; I take the readings stated at stage 3.

## Stage 1 — SAVED

## Stage 2 (in progress): the tools, the rebuild readings, and the predictions registered before any run

### 2.1 Tools

- **Exact validity:** FS112-YB2's tower checker `tools/fs112_yb2_check.py` (open to me by the instance; imported and run, never edited). Its
  `--selftest` and the checker plants `closed_interval`, `noself` re-run here: all as predicted (the positive control of the instrument, in my
  environment). Every fragment below is built with **all centres, radii and corners rational**, so its tower is ℚ.
- **My own:** `tools/fs112_yb3_frags.py` — the builders (END-A, END-A merged, END-B, END-B shaved, BOWTIE), my own exact point-to-tile routine
  (every extreme of `|z − p|` over a segment or an arc is an endpoint, a foot, or a radial point; each compared with 1 by the exact `|√A + B|`
  test), and the stuckness report: contacts of a colour on `ω(v)` (min = 1: out-type; max = 1: in-type; min < 1 < max: crosses) and, at named
  points of each horn tip, which tiles block each flank colour (min < 1 < max).
- **Correspondence of labels** (the claims use Y2's disk labels; the instance offers YB2's): Y2 `C0` = YB2 `Z` (central); Y2 `T1_k` = YB2 `P_k`
  (arch); Y2 `T2_k` = YB2 `W_k` (wedge); Y2 `R_k` = YB2 `R_k`; Y2 `U_k` = YB2 `S_k`; Y2 `U′_k` = YB2 `T_{k+1}`; Y2 `Z^L_k`, `Z^R_k` = YB2 `U_k`,
  `U′_k`; **Y2 `Y_k` = YB2 `X_k`** (`A_k + s·e(126° + 72k)`, the leg from `A_k`) and Y2 `X_k` = YB2 `Y_k`; `C_k`, `D_k`, `B_k`, `A_k` agree; Y2 `u_k` =
  YB2 `F_k`. For the strip, the claims' `C_j` (top tile over the valley at `x = j/2`), `A_j` (arch) are Y's labels (Y's record §1.3), `Q = (1/4, top)`.

### 2.2 The rebuilds' readings (from the defining words; every choice the words leave open is named)

**Y3-END-A.** `P_k = (0, k)`, `n = (0, 1)`, `a = (1, 0)`, `N = P_3 = (0, 3)`, `E = P_2`. The horns of colour `a_k` at `P_k` lie between the line
`y = k` (below) and the circle about `N` of radius `3 − k` (above) — "upper arcs on the circles about `N` of radii 3, 2, 1", "lower boundaries the
lines `y = k`". Curvatures at `P_k`: `υ_k = 1/(3 − k)` = 1/3, 1/2, 1 and `λ_k = 0`; `f̃(1/3) = 1/2`, `f̃(1/2) = 1`, `f(0) = 0`: C-CHAIN-9's two
inequalities hold **with equality** ("taken with equality from the end"). Colours: the words fix `a_2 = 3` (N's top), `a_3 = 4` (N's wedges), `a_4 = 1`
(below N); I take `a_1 = 2`, `a_0 = 5`, `a_{−1} = 6` (any four consecutive distinct). Tiles (16): horns `H_k±` (colour `a_k`), each ending at a
rational point of its circle (half-lengths `45/113`, `22/61`, `5/13`); `U_k` (colour `a_{k−1}`) above `P_k`, inside the disc `D̄(N, 3 − k)`, up to
`y = k + 1/2`; `L_k` (colour `a_{k+1}`) the rectangle below `P_k`, down to `y = k − 1/2`; `L_3` (1) below `N`; at `N` the wedges `W+` (4, directions
`[0°, 45°]`), `W−` (4, `[135°, 180°]`) and `T` (3, `[45°, 135°]`), radius `2/5`; **the unit arcs' far ends** `V_2± = (±5/13, 27/13)` closed by two
small tiles `Q±` of colour 6 (reading, mine: 6 is the one colour no tile within reach of those ends forbids — 1, 2, 3, 4 and 5 each have a tile
straddling distance 1 there). The words do not fix where the horns end, the tiles' outer boundaries or `Q±`: the fragment is **one member** of the
family the words define.

**Y3-END-B.** The same chain; at `N`: `L_3` (1) below; the 4-horns `H_3±` between `y = 3` and arcs of the circle about `M = (0, 5)` of radius 2
(half-length `22/61`); upper flanks `F+` (5) and `F−` (6) up to the rays at `45°`, `135°`; `T` (3) on `[45°, 135°]`; **the 4-tile at `N + n = (0, 4)`**
inside the unit disc about `M` — the circle through `N + n` concentric with the horns' upper arcs ("on the concentric circle"). Reading (mine): the
concentric centre `M = (0, 5)` (radius 2 at `N`); the words fix neither. Built without `Q±`: END-B is not claimed arc-closed.

**BOWTIE — my candidate against Y3-END-NEEDS** (the audit's product; derivation at stage 3). `E = (0, 0)`, `N = (0, 1)`, `S = (0, −1)`. E's c-horns
(colour 2) lie between `ω(N)` and `ω(S)`: **upper and lower arcs both unit arcs**. `G` (colour 1) is the circular sector of radius 1 about `N`,
half-angle `α` (`sin α = 5/13`): near `E` it is E's whole `+n` side, and it is a tile at `N` inside the closed unit disc about `E` (in-type) — the
`[Polymath2021]` p. 194 tactic's self in-contact. `H` (colour 3) is its mirror about `S`. `c = 2` at `N` on `[45°, 135°]` and at `S` on `[225°, 315°]`;
`X_R` (4), `X_L` (5) fill `N`'s sides, `Y_R` (4), `Y_L` (5) `S`'s; `Z_R`, `Z_L` (6) close the unit arcs' ends. `P_cl(N) = {1, 2, 4, 5}`: **`h = 3` is not at `N`**.

### 2.3 Predictions registered before the first run (G21; each with both outcomes reachable)

| object | prediction | a wrong-reason outcome would look like |
|---|---|---|
| END-A faithful | ACCEPT, all pairs the colour map generates | a REJECT at a pair joined only by my own closure choices (`Q±`, the band tops) points at my reading, not the words |
| END-A, `closed_interval` | REJECT at exactly the 12 tight pairs `(L0,H1±)`, `(H1±,U2)`, `(H2±,L1)`, `(H2±,T)`, `(L2,W±)`, `(H0±,U1)` — the chain's six contacts at exactly 1 (the recursion's equalities and the lines), nothing else | a self-pair appearing (a tile of diameter 1 I did not intend) |
| END-A stuck | out-type 3-contacts on `ω(E)` at `N` (T) and `P_1` (L1) only; out-type 2-contacts on `ω(P_1)` at `E` (U2) and `P_0` (L0) only; at every named horn point both flank colours blocked (E: 2 by H1±, 4 by W+ or W−; P_1: 5 by H0±, 3 by H2±) | a flank colour blocked only by the flank tile itself |
| END-A MERGE of 4 at `N` | the 4-contacts on `ω(N)`: L2 out-type at `E` only (so `D_4(N)` is the half-plane `d·n ≥ 0`); the merged fragment ACCEPTs; after it, 3's contacts on `ω(E)` are L1 alone | — |
| END-B faithful | ACCEPT; 4-contacts on `ω(N)`: L2 out at `E`, U4 out at `N + n` (the line); colours at `N` = {1, 3, 4, 5, 6} | — |
| END-B SHAVE | at named points of `N`'s +a 4-horn: colour 5 blocked by nothing, colour 1 blocked by nothing; both shaved fragments (tip by 1, tip by 5) ACCEPT | — |
| BOWTIE faithful | ACCEPT; colours at `E` {1, 2, 3}, at `N` {1, 2, 4, 5}, at `S` {2, 3, 4, 5}; 2-contacts on `ω(E)`: CN out at `N`, CS out at `S`; 1-contacts: G in-type (at `N` and along its arc); 3-contacts: H in-type; at every named horn point 1 blocked by G and 3 blocked by H | colour 1 or 3 blocked only through a tile other than G, H |
| BOWTIE, `closed_interval` | REJECT at exactly `(G,G)`, `(H,H)` (diameter exactly 1: `N` to the arc), `(C+,CN)`, `(C−,CN)`, `(C+,CS)`, `(C−,CS)` (the horns on the unit circles) | any other pair |
| plant `chord2` (E's unit arcs → chords) | REJECT at exactly `(H2+,T)`, `(H2−,T)`: the 3-horns then enter the open unit disc about `N`, where `T` sits | `(H1±,U2)` rejecting (that would be U2's shape, not the horns') |
| plant `p1_fat` (P_1's horns' upper arcs of curvature 427/550 > 1/2) | REJECT at exactly `(H1+,U2)`, `(H1−,U2)`: the recursion's inequality `f̃(υ_1) ≤ υ_2` is violated | any other pair |
| plant `q_swap` (`Q+` coloured 5) | REJECT at exactly `(Q+,U1)` | `(H0±, Q+)` (they are ≥ 1.9 apart) |
| plant `h_is_g` (H coloured 1) | REJECT at exactly `(G,H)` | — |
| plant `no_cn` (the top tile at `N` coloured 3) | ACCEPT (validity unchanged); 2-contacts on `ω(E)`: CS alone — `D_2(E)` a half-plane, E no longer stuck | a REJECT (then the plant tests validity, not stuckness) |

### 2.4 Results (`tools/fs112_yb3_frags.py enda|endb|bowtie|plants|coverage`; outputs `data/fs112/fs112-yb3/{enda,endb,bowtie,plants,coverage}.out`)

**Every registered prediction met, with one reporting defect of mine found and fixed** (below). Pairs examined = pairs present in every run
(the colour map's same-colour pairs, a tile with itself included; the suspect verdict is ACCEPT, claim list §9).

| object | exact verdict | read off |
|---|---|---|
| **Y3-END-A rebuilt** | **ACCEPT, 39 / 39 pairs** | tight pairs exactly the 12 registered (`closed_interval` REJECTs those 12 and no other): the chain's contacts at exactly 1. Colours: `P_0` {2,5,6}, `P_1` {2,3,5}, `E` {2,3,4}, `N` {1,3,4} (exact). **E stuck**: 3-contacts on `ω(E)` exactly `L1` out at `P_1` and `T` out at `N` (so `D_3(E)` is the line); **P_1 stuck**: 2-contacts on `ω(P_1)` exactly `L0` out at `P_0`, `U2` out at `E`; one horn per ray; at six named horn points both flank colours blocked — E's by `H1±` (colour 2, from `P_1`) and `W±` (colour 4, from `N`), P_1's by `H0±` (5) and `H2±` (3). **MERGE of 4 at N**: the only 4-contact on `ω(N)` is `L2` out at `E` (so `D_4(N)` is the half-plane `d·n ≥ 0`); the merged fragment (T's tip within height 1/5 recoloured 4) **ACCEPTs, 43 / 43**, and after it 3's only contact on `ω(E)` is `L1` (E then unstuck). **Arc-closed**: the unit arcs (E's horns' upper arcs, on `ω(N)`) end at `E` and at `V_2± = (±5/13, 27/13)`, each an interior vertex (`V_2+`: `U2`, `H2+`, `Q+`) with its neighbourhood fully coloured (float guard: 0 holes, 0 overlaps in discs of radius 0.02) |
| **Y3-END-B rebuilt** | **ACCEPT, 44 / 44 pairs** | tight pairs: END-A's chain contacts plus `(H3±, L2)` and `(H3±, U4)`. Colours at `N` exactly {1,3,4,5,6}. **No MERGE at N**: the 4-contacts on `ω(N)` are `L2` out at `E` and `U4` out at `N + n` (the line), and 1, 3, 5, 6 have one sector each. E still stuck (3 out at `N` and `P_1`; its horn doubly shadowed, colour 4 now from `H3+`). **SHAVE available**: at named points of N's +a horn tip, neither flank colour (5 above, 1 below) is blocked by any tile; the fragment with the tip (within `x ≤ 30/113`) recoloured by the lower flank 1 **ACCEPTs, 46 / 46**, and by the upper flank 5 **ACCEPTs, 49 / 49** |
| **BOWTIE** (mine) | **ACCEPT, 21 / 21 pairs** | tight pairs exactly the six registered (`(G,G)`, `(H,H)` — diameter exactly 1; the horns against `CN`, `CS`). Colours: `E` {1,2,3}, `N` {1,2,4,5}, `S` {2,3,4,5}. **E stuck**: 2-contacts on `ω(E)` exactly `CN` out at `N`, `CS` out at `S` (the line); one horn per ray; at five named horn points colour 1 blocked by `G` and colour 3 by `H`; the 1-contact is `G` **in-type** at `N`, the 3-contact `H` in-type at `S`. **No 3-tile holds `N`**. `N` and `S`: four colours, one sector each, no horn — no MERGE, MERGE-RAY or SHAVE applies there. Every unit arc's end (`G_R`, `G_L`, `H_R`, `H_L`) interior, neighbourhood fully coloured (float guard: 0 holes, 0 overlaps) |

**Plants, each beside its faithful twin (which ACCEPTs), each firing for its registered reason and at exactly the registered pairs:** `chord2` →
`(H2+,T)`, `(H2−,T)`; `p1_fat` → `(H1+,U2)`, `(H1−,U2)`; `q_swap` → `(Q+,U1)`; `h_is_g` → `(G,H)`; `no_cn` → ACCEPT (validity unchanged) with 2's
only contact on `ω(E)` then `CS` (E no longer stuck: the stuckness report sees the missing contact); `closed_interval` on BOWTIE → the six tight pairs.

**Defects of mine, found by the run, fixed before any verdict was drawn:** (1) the contact report first printed contact points only at piece
endpoints, so the tangency of `L1`'s top edge with `ω(E)` at `P_1` (an interior point of the edge) showed no point — now every foot and radial point
at distance exactly 1 is printed; (2) the "colours at `N`" report of END-B first read {3,4,5,6}, missing `L3`, because `N` is interior to `L3`'s top
edge — a registered prediction ({1,3,4,5,6}) failed **for a wrong reason of the report**, now decided by the pieces' exact `contains`; (3) the float
coverage guard at 96 segments per arc showed 1–3 "holes" at unit-arc ends, every one within 2.2·10⁻⁶ of a unit circle (a chord–arc sliver between
two tiles subdividing one arc differently) and gone at 2,000 segments: an artefact of the guard, disclosed; the guard now uses 2,000.

## Stage 2 — SAVED

## Stage 3 — my verdicts on the nine claims, committed before I open Y3's record

### 3.1 Y3-END-NEEDS — derived blind; **TRUE for a chain of two or more vertices; FALSE as stated, by an exact fragment (BOWTIE)**

*Setting, as the claim's words give it:* a terminal valid map (unit arcs allowed; terminal = no MERGE, MERGE-RAY or SHAVE at any vertex);
`E` a stuck vertex with `P_cl(E) = {g, c, h}` — `c`-horns along `±a`, `g` filling the `+n` side, `h` the `−n` side (N4-STUCK (i)–(ii), which
with three colours at `E` need no NB-4); `E`'s horns' upper arcs unit arcs of `ω(N)`, `N = E + n` (`υ_E = 1`). I use, at the grades the claim
list gives them with unit arcs allowed, N3-DEG's cone (Y's walk, row 5 (b): out-type contacts at both antipodes; horn curvatures in `[−1, 1]`),
W-MERGE as written (Y's retraction 1), N4-SHAVE's criterion (blocked iff doubly shadowed), and the shadow calculus of N4 §2.1 completed by two
unit-arc cases I derive here: **(i) a tile beyond an arc of `ω(v)` (outside `B(v, 1)`, touching `ω(v)` along the arc of directions `u ∈ I`)
shadows near `v` every direction `d` with `d·u > 0` for some `u ∈ I`** (for `z = v + εd`, `|z − (v + u)|² = 1 − 2ε d·u + ε²`) — the `C = 0` case;
**(ii) an in-type tile at `w ∈ ω(v)` (inside `B̄(v, 1)` near `w`, with interior points inside `B(v, 1)`) shadows near `v` every point `z` with
`|z − w| > 1`** (`sup ≥ |z − w| > 1`, and `dist < 1` through the interior points).

**Step 1 — `c` at `N` in the pinch** (the claim's first clause): TRUE. No MERGE of `c` at `E` needs `D_c(E)` the line, so out-type `c`-contacts
at `E ± n` (N3-DEG): `c ∈ P_cl(N)`. `E`'s `c`-horns lie outside `B(N, 1)` and touch `ω(N)` along their upper arcs, directions `[270°, 270° + φ₀]`
and `[270° − φ₀, 270°]` from `N`; by (i) they shadow near `N` every direction in `(180° − φ₀, 360° + φ₀)`; N-E0 puts `c` at `N` in `[φ₀, 180° − φ₀]`:
the pinch with `δ = φ₀`, the angular half-width of `E`'s unit arcs seen from `N`.

**Step 2 — "`h` tangent to `±a` at `N`"**: TRUE **iff `λ_E > −1`**. No SHAVE at `E` needs an `h`-shadow on `E`'s horn near `E`. The sources are
`h`-tiles touching `ω(E)`; off `E ± n` N3-CLEAR clears the tip. At `N`: out-type tangent to `±a` (the claim's); out-type non-tangent shadows
only inside `B(N, 1)` (N4 §2.1), missing the horn; in-type is Siamese with `h`'s sector below `E`, which lies outside `B̄(N, 1)`: a straddle. At
`E − n`: out-type shadows a set closed downward that must miss `h`'s flank below the horn, hence misses the horn (N4-FLANK mirrored); **in-type
`h` at `E − n` is possible exactly when `h`'s flank lies in `B̄(E − n, 1)` near `E`, i.e. `λ_E = −1` (`E`'s lower arcs unit arcs of `ω(E − n)`),
and then by (ii) it shadows the whole horn**. So the clause fails at `λ_E = −1`, and holds otherwise.

**Step 2′ — when `λ_E > −1` is forced** [hand, one mind]: if `E − n` is a stuck vertex of the chain in N4-PROP's sense (its cone colour `g`, with
`c` filling its `−n` side, tangent to `±a` as the lower flank of its horns), then `λ_E = −1` is impossible: `E`'s `c`-horns would lie beyond arcs of
`ω(E − n)` and by (i) shadow near `E − n` every direction in `(−φ₁, 180° + φ₁)`, including the directions just below `±a` where `c` sits there.
So **for a chain of two or more vertices, Step 2 holds.** (END-A is such a chain: `λ_E = 0`.)

**Step 3 — "to block the MERGE there, `h`'s sectors horns and two upper flank colours outside `{g, c, h}`, so `|P_cl(N)| ≥ 5`"**: TRUE (given
Step 2). `h` has two sectors at `N` (tangent to `+a` and to `−a`, the pinch between). No MERGE of `h` ⟹ `D_h(N)` the line ⟹ (N3-DEG) out-type `h`
at `N ± n` and `h`'s sectors cusp horns along `±a`. Upper flanks `x₁` (+a), `x₂` (−a): not `h`; not `c` (only in the pinch); not `g` (the flank's
tile at `N` lies outside `B̄(E, 1)`, an out-type `g`-contact of `E` that would force `D_g(E) ⊆ {d·n ≤ 0}` while `g` fills `E`'s `+n` side); and
`x₁ ≠ x₂` (else two `x`-sectors at `N`, separated by the pinch; no MERGE needs out-type `x` at `N − n = E`, but `x ∉ P_cl(E)`). The lower flank
`y₁` of the `+a` horn is not `h`, not `c`, not `x₁` (both flanks `x₁` = a MERGE of `x₁` through the horn, `D_{x₁}(N)` non-degenerate), not `x₂`
(two sectors): five colours at `N`.
**Two sharpenings of mine** [hand, one mind]: (a) **`y₁ ≠ g`**: a `g`-tile below `N`'s horn crosses `ω(E)` unless `N`'s lower arcs are `ω(E)`
itself (`κ_− = −1`); then `E`'s `g`-sector (on `ω(N)` on both sides of `E`) and `N`'s `g`-tile (on `ω(E)` beside `N`) contain pairs at distance²
`≈ 1 + 2θθ′ > 1` beside pairs below 1 — a straddle. So `P_cl(N) = {c, h, x₁, x₂, y}` **exactly**, `y = y₁ = y₂` the sixth colour, `g ∉ P_cl(N)`.
(b) **`N` must centre unit arcs of total length at least 180°**: with five colours at `N`, every tile-interior point of `ω(N)` carries `g` (N-E1),
and two such points `60°` apart are at distance 1; so the tile-interior part `S` of `ω(N)` has `S ∩ (S + 60°) = ∅`, `|S| ≤ 180°` (Y's W1 (ii)
argument, applied at `N`).

**Step 4 — "to block the SHAVE too, the horns' upper arcs unit arcs of `ω(N + n)` and, at `N + n`, two distinct upper flank colours outside five
used colours — a seventh colour"**: TRUE (given Step 2). An `x₁`-shadow on `N`'s `+a` horn: none from `E` (`x₁ ∉ P_cl(E)`); out-type `x₁` at
`N + n` shadows a set closed upward that must miss the `x₁` flank, so misses the horn; **in-type `x₁` at `N + n` requires the flank inside
`B̄(N + n, 1)`, i.e. the horn's upper arc on `ω(N + n)`** (else the flank's points just above the arc straddle with the in-type tile). A `y`-shadow:
none from `E`; in-type `y` at `N + n` impossible (`y`'s flank below `N` is outside `B̄(N + n, 1)`); so out-type `y` at `N + n`, tangent to `+a`, and
likewise to `−a`. `h` is out-type at `N + n` (Step 3) and, by (i) applied to `N`'s `h`-horns (beyond arcs of `ω(N + n)`), confined to a pinch there;
so `y` has two sectors at `N + n` ⟹ (no MERGE) `y`-horns along `±a` at `N + n`, with upper flanks `z₁, z₂`: not `y`; not `h` (pinch); not `c`, `x₁`,
`x₂` (their sectors at `N` have `d·n > 0`, while `z_i`'s tile at `N + n` lies outside `B̄(N, 1)`); `z₁ ≠ z₂` (two sectors at `N + n` separated by
`h`'s pinch; degenerate only with an out-type `z` at `N`, i.e. `z ∈ {h, y}`). So `z₁, z₂` are two distinct colours outside
`{c, h, x₁, x₂, y}`, of which only `g` remains: **a seventh colour.**

**The conclusion, "So a stuck chain cannot end at a unit arc in a terminal map while `E` has three colours":**
- **TRUE for a chain of two or more vertices** (`E − n` stuck in N4-PROP's sense), [hand, one mind (mine, blind), over the chain steps named
  above].
- **FALSE as stated, for a chain of one vertex** — the exception at Step 2 is realised. **BOWTIE** (stage 2, `tools/fs112_yb3_frags.py bowtie`)
  is an exact valid local fragment with the following properties.
  - **`E` is stuck with `P_cl(E) = {1, 2, 3}`.** Its `c = 2` horns lie between two unit circles, `ω(N)` above and `ω(S)` below (`υ_E = 1`,
    `λ_E = −1`). `D_2(E)` is the line: the only 2-contacts are `CN` (out-type at `N`) and `CS` (out-type at `S`). Colour 1 is blocked by `G` and
    colour 3 by `H` at every named horn point: `G` is the in-type tile at `N`, `H` the in-type tile at `S`, each a circular sector of radius 1
    whose arc bounds the horns.
  - **`N` is not stuck.** `P_cl(N) = {1, 2, 4, 5}`, **`h = 3` absent**, each colour one sector, no horn; `S` likewise. No operation applies at
    `E`, `N` or `S`.
  - **Every unit arc's end is interior**, with its neighbourhood fully coloured.

  So the claim's clause "to keep `E` stuck, … `h` tangent to `±a` at `N`" has an exact counter-configuration, and a stuck vertex can end a chain
  at unit arcs **on both sides** with neither neighbour stuck. The fragment is local; whether a tight map of the plane contains it is Q-full's
  question. Grade: [tools, exact; one fragment, mine] + [hand, one mind] for reading it against the clause.
- **Corrected statement (proposed):** *"If `E` is the upper end of a stuck chain of at least two vertices (so `λ_E > −1`), with `P_cl(E) = {g, c, h}`
  and `υ_E = 1`, then a terminal map needs a seventh colour at `N + n`; a single stuck vertex may end at unit arcs on both sides (`υ_E = 1`,
  `λ_E = −1`, shadowed by in-type tiles at both antipodes: the tactic's self in-contact), as BOWTIE realises locally."*
- **Bearing (for the owner and the proof side, stated plainly):** the proof side's stuck-ray question must include the one-vertex "bowtie" end
  as a residue; FS-110's N4-PROP forced a stuck vertex's neighbours to be stuck, and with unit arcs that step fails exactly here.

### 3.2 Y3-END-A and Y3-END-B — **TRUE on my rebuilds** [tools, exact; one rebuild each, mine; stuckness exact at the antipodes and at named points, hand for the rest]

- **Y3-END-A**: rebuilt from its words (reading in 2.2), every clause realised: **valid** (39/39 pairs ACCEPT); **arc-closed at the unit arcs' ends**
  (`E` and `V_2±` interior, neighbourhoods fully coloured); **`P_1` and `E` stuck** (the two-sector colour's contacts on the vertex's unit circle
  exactly out-type at both antipodes; one horn per ray; both flank colours blocked at every named point of each horn tip — and by the hand shadow
  bookkeeping, the whole horn near the vertex is doubly shadowed: at `E`, `σ_2 = f̃(1/2) = 1 = κ_+` from `H1±` and `σ_4 = f(0) = 0 = κ_−` from `W±`;
  at `P_1`, `σ_5 = f̃(1/3) = 1/2 = κ_+`, `σ_3 = f(0) = 0 = κ_−`); **a MERGE of 4 at `N` available** (`D_4(N)` the half-plane; the merged fragment
  exact-valid). My choices beyond the words (named in 2.2): the colours `a_1, a_0, a_{−1} = 2, 5, 6`; where the horns end (rational points); the band
  tops; the closing tiles `Q±` (colour 6 — the one colour free there).
- **Y3-END-B**: rebuilt, every clause realised: **valid** (44/44); `P_cl(N) = {1, 3, 4, 5, 6}`; **no MERGE at `N`** (`D_4(N)` the line: `L2` out at
  `E`, `U4` out at `N + n`; the others one sector each); **a SHAVE of `N`'s 4-horns by their lower flank available** (no tile blocks 1 or 5 at named tip
  points; both shaved fragments exact-valid). **One consequence the claim does not state** [hand, one mind]: END-B is not arc-closed (it is not
  claimed to be), and by 3.1 Step 3 (b) no valid completion of `N`'s neighbourhood exists unless unit arcs centred at `N` total at least 180° —
  END-B carries `2·arcsin(5/13) ≈ 45.2°` (E's two arcs); in particular the tiles crossing `ω(N)` beside `V_2±` must be colour 2, the only colour not
  at `N`.

### 3.3 Y3-LEG — **TRUE** [tools, exact; one mind] (`tools/fs112_yb3_pins.py leg`, `data/fs112/fs112-yb3/leg.out`)

In YB2's disk (Y2's labels as the claim uses them): `|A_0 − q2|² = |A_0 − C_0|² = φ²` exactly; `(C_0 − q2)·(Y_0 − A_0) = 0` and the midpoint of `C_0q2`
on the leg's line: **the leg's line is the perpendicular bisector of `C_0, q2`**; `|C_0 − q2| = 1` (`q2 ∈ ω(C_0)` by definition), so `ω(C_0) ∩ ω(q2)`
is the pair of apexes of the two equilateral triangles on `C_0q2` — both on the bisector: `K = C_0 + e(276°)` at distance `≈ 0.6728` from `A_0` (on
the **segment** `A_0Y_0`, `|A_0Y_0| = √(1/φ) ≈ 0.7862`) and `K′ = C_0 + e(156°)` on the line beyond `Y_0`. Also exact: `q2 − C_0 = −e(36°)`, the leg's
direction `e(126°)`, `|q2 − Y_0|² ≈ 0.8165 < 1`, and `C_0 + Z^L_0 − q2 = D_0` (the other point of `ω(C_0) ∩ ω(Z^L_0)`).

### 3.4 Y3-STRIPCUT — **TRUE, with its list of tiles one-sided** [tools, exact at 22 named points; one mind] (`pins.py strip`, `strip.out`)

On YB2's strip (Y's `C_m` = YB2's `T_m`; colour 4 = marble): `ω(Q)` passes exactly through `(−3/4, top)` and `A_{−1}`'s apex `(−1/4, √15/4)`, and
through `(5/4, top)` and the apex `A_1 = (3/4, √15/4)`; the valleys `V_2`, `V_{−1}` (whose top sectors are forced to 4, YB2-FORCE / Y2-FORCE) lie outside
`B(Q, 1)` (`|·|² = 3/2`), so each tile's outer part keeps 4. **At all 22 named points** (per tile: three points of `ω(Q)` inside the tile, each with a
point just inside and just outside the cut, and two points of the inner part), **4 is the only colour no other tile forbids**. The blockers:
- **`C_{−1}`'s inner part**: colours 1, 2, 3 blocked only by midline arches (`U0`, `U−2`, `U−1` at every point; `U−3`, `U−4` at some), 5 by
  **`C_{−3}`** (and `C_0` at some points), 6 by **`C_1`** (and `C_{−2}`) — exactly the claim's "a midline arch or `C_{−3}` or `C_1`".
- **`C_2`'s inner part**: 1, 2, 3 by midline arches, 5 by **`C_0`** (and `C_3`), 6 by **`C_4`** (and `C_1`) — the mirror image under `x ↦ 1/2 − x`
  (which fixes `Q` and exchanges `C_{−1} ↔ C_2`, `C_{−3} ↔ C_4`, `C_1 ↔ C_0`).
Both cuts are needed to free 4 at `Q`, so "the cut also needs a change to a midline arch or to `C_{−3}` or `C_1`" is **true as a necessary condition**;
as a list it names `C_{−1}`'s side only — **precision owed**: "… and, for `C_2`'s part, to a midline arch or to `C_0` (one of `Q`'s own tiles) or `C_4`".

### 3.5 Y3-R1 — **TRUE, and the length bound sharpens to `2V`** [hand, one mind]

`f(x) − x = −x²/(1 + x) ≤ 0` for `x > −1` and `f̃(x) − x = x²/(1 − x) ≥ 0` for `x < 1`, each zero only at `x = 0`. So `λ_k ≤ f(λ_{k+1}) ≤ λ_{k+1}` and
`υ_{k−1} ≤ f̃(υ_{k−1}) ≤ υ_k`: both non-decreasing, and a consecutive equality forces the later term (then the earlier) to be 0. (At a unit arc,
`λ = −1` or `υ = 1`, the next inequality has no finite solution: the chain ends there.) Infinite toward `+k`: if some `υ_m > 0`, `1/υ` drops by at least
1 per step and `υ` passes 1 — so every `υ_k ≤ 0` and every `λ_k < υ_k ≤ 0`. Infinite toward `−k`: if some `λ_m < 0`, `1/λ` rises by at least 1 per
step down and `λ` passes `−1` — so every `λ_k ≥ 0` and `υ_k > 0`. A one-sided infinite chain therefore has its `λ` (resp. `υ`) strictly monotone and
nonzero: infinitely many distinct curvatures, hence radii; a map with finitely many arc radii (every doubly periodic map, every map of `𝓜_K`'s
periodic designs) has none. **Length:** monotone and repeating only at 0, the nonzero `λ_k` are distinct (at most `V` indices); where `λ_k = 0`,
`υ_k > 0`, and those `υ_k` are distinct (at most `V` more) — so **a chain has at most `2V` vertices**, within the claim's `3V + 3`.

### 3.6 Y3-T2-BUDGET — **TRUE** [hand, one mind; the strip clause exact] (`tools/fs112_yb3_r3.py`, `r3.out`)

For any pair `(u, v)` with common unit points `w₀, w₀′`, `u w₀ v w₀′` is a unit rhombus, so `u + v = w₀ + w₀′`. T2 at both points means `u` emits
unit arcs of `ω(w₀)` and `ω(w₀′)`: `w₀, w₀′` are among the centres of the unit arcs `u` emits — at most three for a trivalent `u` (one per edge;
two edges on one circle count once) — and `v = w_i + w_j − u` for two of them: at most `C(3, 2) = 3` partners, at determined places. The strip
(exact, YB2's rebuild): every `(V, A)` pair (18 listed) is complementary, at distance `≈ 0.7569`, **not** a completion (a valley emits arcs about
two midline vertices only, whose completion is the mirror valley), and saved by T2 at one point only — so the printed colouring does not meet the
pattern; the claim's hedge ("whether some other colouring of the strip's geometry avoids them is not claimed") stands.

### 3.7 Y3-R3 — **TRUE at both held positives** [tools, exact; one mind] (`tools/fs112_yb3_r3.py strip disk`, `r3.out`)

Every close complementary pair of vertices, listed exhaustively on YB2's two rebuilds, with its two common unit points tested exactly (is it a
vertex, how many colours, does each member emit a unit arc centred there) and tested for being a rhombus completion:
- **the strip** (24 pairs with a member in one period): 18 `(V, A)` pairs — saved at one four-colour midline vertex (both members emit arcs of its
  unit circle), the other point **an edge vertex** (two colours), not completions; 3 `(V_m, V′_m)` (√3) and 3 `(A_j, A′_j)` (√15/2) — completions,
  saved at **both** points (T2 twice);
- **the disk** (20 pairs): each saved at one four-colour vertex `A_j`; none a completion; the other point **on the rim** (`C_k`, `D_k`; 10 pairs) or
  **outside the disk, not a vertex** (Y2's `w*`, YB2's `Q_k`; 10 pairs).
So "saved at one common unit point by a four-colour vertex, and at both exactly when a rhombus completion" holds at both, and the unsaved second
points are the stop points. The disk's `(A_0, y)` (a ring change point, not a vertex) saved at both by (S1): Y2's §5.3 (d) (exact at the arcs, the
seam points placed in float) — not re-checked here; the claim's words for it are Y2's, which I read and do not dispute.

### 3.8 Y3-DISK-T* — **TRUE; the colour-free part of the vacated region is a proper sub-region** [tools, exact at named points; hand; one mind] (`pins.py disk`, `violet`; `disk.out`, `violet.out`, `q2-inside.out`)

On YB2's disk with the first move (Y2-MOVE = YB2's O3; the same object, two minds), in exact towers up to seven levels:
- **`T*` holds `q2`**: `q2 = Z^L_0 − (1, 0)` lies on `ω(C_0)` and `ω(Z^L_0)` (the other common point is `D_0`), strictly inside the disk
  (`|q2|² ≈ 3.894 < r² ≈ 4.512`); `T*` is the curvilinear triangle `q2`, `p*` (rim ∩ `ω(C_0)`, rim angle 130.84°), `ρ*` (rim ∩ `ω(Z^L_0)`, 127.25°).
- **`|q2 − Y_0|² ≈ 0.8165 < 1`, so `W_0` (Y2's `T2_0`) must vacate `B(q2, 1)`**: `W_0` holds `Y_0` inside and `A_0` outside (`|A_0 − q2| = φ`), so it
  straddles distance 1 from every point of a blue `T*` near `q2`. `ω(q2)` meets `W_0`'s boundary exactly at `Z^L_0` and at `K = C_0 + e(276°)` on
  the leg (3.3): the vacated region `V` is the curvilinear triangle `Z^L_0, Y_0, K`, of diameter `≈ 0.42`.
- **The second move's other tiles, built exactly:** `T*` blue; `T_1` (Y2's `U′_0`) cut to lie outside `B(C_0, 1)`; the violet extension
  `X_ext = T_1 ∩ B(C_0, 1) ∩ B̄(Z^L_0, 1)` (corners `B_0`, `F_0`, `ρ*`, `q2`) — **valid as part of the violet tile**: against `S_0` max exactly 1,
  against `P_1` min exactly 1, against `T_3`, `W_4` min > 1, itself diameter `≈ 0.749`.
- **At seven named points of `V`** (the centroid of the triangle `Z^L_0 Y_0 K`; each corner pulled 1/5 toward it; each side's midpoint pulled 1/10
  toward it), each colour's blockers:
  - red (`Z`, `R_0`, and `R_1` at three points), green (`T_0`, `W_1`), yellow (`P_4`, and the cut `T_1`), blue (`T*`), everywhere;
  - orange by `P_0` at five points, and **by nothing near `K` and on the leg `Y_0K`**;
  - violet by `S_0 ∪ X_ext` at the centroid, near the chord `KZ^L_0`, near `K` and on the leg (the last two also by `P_1`), and **by nothing near
    `Z^L_0`, near `Y_0` and on the side `Z^L_0Y_0`**.
  So **at two of my seven points — the centroid and the point by the chord — no colour is admissible**, and there the blockers are exactly `Z`
  (Y2's `C0`), `R_0`, `W_1` (`T2_1`), `T_0` (`U′_4`), `P_4` (`T1_4`), `P_0` (`T1_0`) — Y3's six tiles — plus the move's own tiles. At the other five,
  one colour survives (violet or orange).

**Verdict:** the claim's chain holds — `T*` holds `q2`; `W_0` must vacate a region reaching `Y_0` and `K`; that region contains points (an open
set, blocking being open) where no colour is admissible with the move's other tiles in place; so a change to one of the six named tiles (or to
the move's own choices, e.g. `X_ext`'s colour) is needed, and **no change confined to the region near `Z^L_0` lets `T*` be blue**. **Precision**:
"at 7 named points … no colour is admissible" depends on where the points are — the colour-free set is a proper part of `V` (violet is
admissible near `Z^L_0` and `Y_0`, orange near `K`); my points agree with the claim's conclusion at two of seven.

## Theorems this phase proved (FS112-YB3)

| id | statement (one line) | grade | address |
|---|---|---|---|
| YB3-ENDA | Y3-END-A rebuilt from its words is valid (39/39), arc-closed at its unit arcs' ends; `P_1`, `E` stuck; a MERGE of 4 at `N` is available and valid (43/43) | tools, exact; one rebuild (mine); stuckness exact at antipodes and named points + hand | 2.2, 2.4, 3.2 |
| YB3-ENDB | Y3-END-B rebuilt is valid (44/44); `P_cl(N) = {1,3,4,5,6}`; no MERGE at `N`; SHAVEs of `N`'s horn by either flank valid (46/46, 49/49) | tools, exact; one rebuild (mine) | 2.4, 3.2 |
| YB3-SHADOW | two unit-arc shadow cases: a tile beyond an arc of `ω(v)` shadows near `v` every direction within 90° of the arc; an in-type tile at `w ∈ ω(v)` shadows every `z` with `|z − w| > 1` | hand, one mind | 3.1 |
| YB3-NEEDS | Y3-END-NEEDS holds for a stuck chain of at least two vertices (then `λ_E > −1`); its clause "`h` tangent to `±a` at `N`" fails exactly when `λ_E = −1` (in-type `h` at `E − n`) | hand, one mind | 3.1 |
| YB3-BOWTIE | an exact valid fragment (21/21): a stuck vertex `E` with three colours whose horns lie between `ω(E + n)` and `ω(E − n)`, shadowed by in-type radius-1 sectors at both antipodes; `P_cl(E ± n)` four colours each, neither stuck, `h ∉ P_cl(E + n)`; every unit arc's end interior | tools, exact; one fragment (mine) | 2.2, 2.4, 3.1 |
| YB3-N5 | at the end's centre `N` of a two-vertex-or-longer chain, `P_cl(N) = {c, h, x₁, x₂, y}` exactly (`g ∉ P_cl(N)`), and `N` must centre unit arcs of total length at least 180° | hand, one mind | 3.1 |
| YB3-LEG | Y3-LEG: `|A_0 − q2|² = |A_0 − C_0|² = φ²`; the leg's line is the perpendicular bisector of `C_0, q2`; `K = C_0 + e(276°)` on the segment, `K′ = C_0 + e(156°)` beyond `Y_0` | tools, exact | 3.3 |
| YB3-STRIPCUT | at 22 named points of `C_{−1}`, `C_2` on and beside `ω(Q)`, 4 is the only colour no other tile forbids; `C_{−1}`'s cut needs a midline arch, `C_{−3}` or `C_1`, `C_2`'s a midline arch, `C_0` or `C_4` | tools, exact at named points | 3.4 |
| YB3-R1 | along C-CHAIN-9's inequalities `λ`, `υ` are non-decreasing, equal consecutive terms only 0; one-sided infinite chains need infinitely many radii; a chain has at most `2V` vertices | hand, one mind | 3.5 |
| YB3-T2B | Y3-T2-BUDGET; the strip's 18 `(V, A)` pairs are not completions | hand; strip clause tools, exact | 3.6 |
| YB3-R3 | Y3-R3 at both positives: every close complementary vertex pair saved by half of T2 at one four-colour vertex, at both exactly when a rhombus completion; the unsaved points are the edge vertices, rim points and outside points | tools, exact (exhaustive) | 3.7 |
| YB3-DISKT | Y3-DISK-T*: `T*` holds `q2`; `W_0` must vacate `W_0 ∩ B(q2, 1)`; at two of seven named points of it no colour is admissible (blockers Y3's six tiles plus the move's), at five one colour is | tools, exact at named points + hand | 3.8 |

## Stage 3 — SAVED (step 3 complete: every verdict above is committed before Y3's record, tools or outputs are opened)
