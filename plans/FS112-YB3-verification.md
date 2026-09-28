# FS112-YB3 — round-3 blind verification of FS-112's construction side (the chain's end at a unit arc; the two pinned corners)

*Job FS112-YB3, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `8f01c225`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by the
instance file `data/fs112/briefs/YB3-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. The side verified is FS112-Y3 (round 3); its record,
tools and outputs stay fenced until my step 3 (every verdict below on Y3's nine claims) is committed. Every object below is a local fragment, not a map
of the plane.*

## Theorems this phase proved

*(filled at the end of step 3; one line per theorem, its grade and its address)*

## Would have searched here (standing rule 3)

*(one line per move I would have made by search, and what I did instead)*

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
