# FS112-YB2 — round-2 blind verification of FS-112's construction side (the six-coloured disk and the strip's stopping points)

*Job FS112-YB2, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `b5f5db3b`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by
the instance file `data/fs112/briefs/YB2-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My checker `tools/fs112_yb2_check.py` is
written without reading Y's, Y2's or YB's checker code; Fig. 10 is transcribed by eye and the transcription committed before any solve; my verdicts on
O1–O5 are committed (step 3) before I open Y2's section, tools or outputs. Every object below is a local positive, not a map of the plane.*

## Theorems this phase proved

(filled at each stage; one line per theorem, its grade and its address)

## Would have searched here (standing rule 3)

- Stage 2: none (a checker built from a derivation, calibrated on held objects).

## Fence log (standing rule 13; brief § Fences; instance)

- Start-up: `ls data/fs112/` listed directory **names**, among them the fenced `fs112-a2`, `fs112-a3`, `fs112-y` — names only, nothing in them listed,
  opened or grepped. `ls data/fs112/briefs/` listed the brief file names (other briefs fenced; none opened but mine, my instance file,
  `Y112-construction.md` not yet, and `STANDING-RULES.md`).
- `plans/FS112-Y-construction.md`: I read lines 1–266 only (round 1, open to me), having located the fenced heading "§ Continuation — FS112-Y2" at
  l. 267 by a `grep -n "Continuation"` that printed that one heading line and nothing of its section.
- Owner's message during stage 1 (fence addition, effective at once): FS112-Y3's `plans/FS112-Y3-construction.md`, `tools/fs112_y3_*.py` and
  `data/fs112/fs112-y/y3_*` are fenced until my step 3 is committed; after it, read only if step 4 needs them. Logged; nothing of them touched.

## Stage 1 — SAVED: reading; the quotation check

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors **from disk** (they differ from my context's snapshot in link 2, which
on disk adds `[GwynStavrianos2022]` and the choice remark; I work from disk), G20, G21, G22, G60 (unchanged from my snapshot); `LEDGER.md` rows 133–134;
`data/fs112/claims.md` in full (§0 and §7 closely); `plans/FS112-unit-arc-half.md` stage 5 (§§5.1, 5.2, 5.4–5.7 and the addendum; **not §5.3**);
`plans/FS112-PA-reading.md` (stages 1, 6, 8, 9) and the extracts `[07.10]`, `[07.15]`–`[07.19]`, `[07.45]`–`[07.50]`, `[08.12]`, `[09.100]`, `[11.1]`,
`[11.34]`, `[11.35]`, `[16.91]`, `[16.105]`, `[16.106]`, `[16.346]`, `[16.347]`, `[17.181]`; round 1 of `plans/FS112-Y-construction.md` (ll. 1–266); YB's
record `plans/FS112-YB-verification.md` in full and report `data/fs112/reports/FS112-YB.md`; `[Polymath2021]` pp. 194, 197–200 (PDF pp. 30, 33–36, text
layer) and **Fig. 10 viewed at 600 dpi** (PDF p. 36, the paper's p. 200) with its caption; the frozen FS-110 tools `tools/fs110_y_check.py` (in full),
`tools/fs110_y_fragments.py` and `tools/fs110_y_cone.py` (their object formats and drivers), `data/fs110/fs110-a6/a6_c2_single_horn.py` (in full);
YB's `tools/fs112_yb_strip.py` **for its object format only** (its `Strip` class and `check_strip` driver) and the data-representation lines of
`tools/fs112_yb_check.py` (the classes `F`, `Seg`, `Arc`: fields and orientation convention), so that my checker can take YB's strip object as input.
I did not read YB's pair logic, candidate list or sign code: my checker's logic is my own.

### 1.2 Quotation check (standing rule 5) — `tools/fs112_yb2_quotes.py`, output `data/fs112/fs112-yb2/quotes.out`

20 quotations: the brief's `[AxenovichEtAl2014]` sentences; the instance's `[11.34]` phrase; the standing rules' five Kooshi quotations; and those I use
below from the claim list, `[Polymath2021]` pp. 194–200 and the threads (`[07.49]`, `[07.50]`, `[11.34]`'s radius, `[16.91]`, `[16.106]`, `[16.346]`).
**19 of 20 verbatim.** One difference: standing rule 4's *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
carries a terminal period inside the quotation marks that `CLAUDE.md` (item 23) does not have — punctuation only, the words exact. Normalisation stated in
the tool (whitespace; typographic quotes; the `[Polymath2021]` text layer read in plain and `-layout` modes, because plain mode dehyphenates the printed
"unit-/edge" by itself). `--self-test`: an altered word turns FOUND into MISSING (`quotes-selftest.out`).

The Fig. 10 caption's radical is garbled in the text layer; on the page image (600 dpi) it reads "Figure 10: A 6-tiling of a disk of radius
√(5/2 + 9/(2√5))." — as the claim list §7 quotes it. The instance's radius `√((25 + 9√5)/10)` is not a quotation; its identity with `[11.34]`'s
printed `r = φ·√((15+√5)/10)` and with the caption is checked exactly at stage 3.

**No paraphrase found in my brief or instance file.** One naming point, not a paraphrase: the instance's O4 names `A₁ = (3/4, √15/4)` "YB's O3 placing"; in
YB's own labels that point is `A_1`, and in Y's round-1 labels `A₁` too (both `(3/4, √15/4)`): consistent.

## Stage 1 — SAVED

## Stage 2 — SAVED: my exact checker over towers of square roots, calibrated (brief step 1; instance: strip first, then plants)

**The checker** `tools/fs112_yb2_check.py` (written without reading Y's, Y2's or YB's checker logic). *Arithmetic:* a `Tower` is
`Q(√d₁)(√d₂)…(√d_n)`, each `d_k` a positive element of the level below; an element of level `k` is a pair `(a, b)` = `a + b√d_k`. Sums and products are
identities in the square roots; **the sign is exact by recursion** — `sign(a + b√d)` from `sign a`, `sign b` and `sign(a² − b²d)` — a statement about
real numbers that stays correct even if a radicand is a square lower down; inversion raises (never guesses) if a conjugate norm vanishes at a nonzero
element. Towers are built per object (`Q(√3)` for FS-110's fragments; `Q(√3)(√5)` for the strip; up to five levels for YB's radius plants; the disk's
at stage 4). *Verdict:* for a same-colour tile pair (a tile with itself included) REJECT iff `m < 1 < M`, `m`, `M` the exact minimum and maximum
cross-distance; each is decided against 1 exactly (`<`, `=`, `>`), with float values printed beside. *Completeness:* the candidate list holds every pair
of points that can realise an extreme (endpoint–endpoint; endpoint to a segment's foot; endpoint to an arc's radial points; segment–arc pairs along the
normal through the arc's centre; arc–arc pairs on the line of centres, radial and antipodal pairs for concentric arcs), each checked to be realised, each
of the form `|√A + B|` compared with 1 exactly. **No map hypothesis:** whether two tiles meet is decided exactly (incident endpoints, segment crossings,
segment–circle and circle–circle intersection points written `a + b√Δ` and tested on both pieces).

**Self-test** (`--selftest`, `data/fs112/fs112-yb2/selftest.out`): ten exact controls — a Reuleaux triangle of width 1 (ACCEPT), two at gap exactly 1
(ACCEPT), squares of diagonal 0.99 and 1.06, two squares at gap 9/10, two unit caps whose nearest pair is interior to both arcs, a cap facing a bar
(nearest pair interior to arc and bar), two long bars crossing, a thin crescent crossed by a bar **only at its arcs**, and two crescents crossing **only
arc to arc**. **Seven checker plants, each flipping exactly the controls predicted and no other:** `noself` (the 1.06 square), `endpoints_only` (both
interior-pair controls), `no_interior` (the same two), `no_meet` (the three crossing controls — each built so that every critical candidate is at least
1.13 while the tiles cross, so only the exact meeting test can see them), `closed_interval` (the two tight Reuleaux controls: tightness visible),
`cw_arcs` (both Reuleaux controls turn REJECT; the caps, the cap–bar and the crescent–bar turn ACCEPT; the two crescents stay REJECT because their
complementary circles still meet near `(2.0, −1.51)`). **Two slips of mine, both caught before any verdict was used:** my first cap–bar control had bar
corners 0.924 from the arc, so `no_interior` could not have flipped it (the plant's failure mode unreachable — rebuilt with the bar `|y| ≤ 7/10`), and
my first arc-crossing controls also crossed at a straight chord (a segment test, not the curved one — rebuilt as crescents); and I registered **no**
flips for `cw_arcs` by omission, the first run showed flips, and I derived the set above by hand before reading which controls had flipped.

**Calibration** (`tools/fs112_yb2_calib.py`; outputs `calib-frag.out`, `calib-cal7.out`, `calib-strip.out`):

| # | object | pairs | verdict | against |
|---|---|---|---|---|
| 1 | FS-110's S1, T2, BB, MX, WC, WC1, WCEQ, WCH, WC1H; the builders' planted faults `s1_flat`, `t2_flip`, `t2_flat`, `t2_six`, `bb_rot`; the eight tip tests; A6-C2 and its ten runs; every fragment under `closed_interval` in both checkers — built by the frozen builders (imported, unedited), converted exactly | **1,663 pairs**, each also run through the frozen checker in the same process | **every verdict agrees pair by pair** (89 REJECTs on both sides, the same pairs) | `tools/fs110_y_check.py` |
| 2 | **CAL-7, the claim list's object**: row 33's brick (`4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`), cell `(0,0)` against itself and every same-colour cell with `|i|, |j| ≤ 5`, the rest dismissed by an exact gap bound (`≥ min(hR, R(w − s))`, squared ≥ 4) | 17 | **ACCEPT**; exact contacts at 1: the cell's own diagonal and the cells `(±1, ±2)` | `Seven.lean`'s docstring |
| 2′ | the variants `Seven.lean` records: `h = 1/2`, `w = 1`, `c = 2, 4, 6`, shear 0 (Lean `check false`); `c = 5` at shears 2/5 and 4/15 (Lean `check true`); `closed_interval` on the brick; and the frozen checker's hexagonal controls | 17–19 each | REJECT, REJECT, REJECT ×3, REJECT; ACCEPT ×2; REJECT (tight); hex7 ACCEPT, hex7 at side 11/20 REJECT, hex4 REJECT | each as recorded |
| 3 | **YB's strip object** (`tools/fs112_yb_strip.py`, run in-process, never edited), converted exactly into `Q(√3)(√5)` | **90 orbit pairs** (YB's own list) | **ACCEPT, every pair agreeing with YB's checker**; my exact contacts at 1: **36**, the number YB reports | `tools/fs112_yb_check.py` |
| 3′ | YB's four strip plants (arc radius 11/10, 9/10, edges raised 1/100, a colour swap) and `closed_interval` in both checkers, each in the tower of the primes it uses (up to `Q(√2, √3, √7, √13, √23)`) | 90–97 each | the same rejected pairs as YB's checker in every case (6, 18, 6, 3; 36 under `closed_interval`) | YB's checker |

**The instance's requirement is met**: the checker reproduces YB's verdict on YB's own strip object, pair by pair; and it reproduces the frozen FS-110
checker's verdicts pair by pair on 1,663 pairs, including every REJECT. **The suspect verdict is ACCEPT** (claim list §9): every ACCEPT above prints pairs
examined against pairs present, and the plants show which kinds of pair the ACCEPTs rest on (interior pairs, crossings, self-pairs, tight contacts).

## Stage 2 — SAVED

