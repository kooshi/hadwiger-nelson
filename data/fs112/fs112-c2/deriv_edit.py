#!/usr/bin/env python3
"""FS112-C2 stage 2: the stage-1b edits to plans/FS112-derivation.md, as exact (old, new) replacements, each asserted to occur once."""
import pathlib, re, sys
P = pathlib.Path('/home/kooshi/source/lean-dir/plans/FS112-derivation.md')
t = P.read_text()
E = []
def rep(old, new):
    E.append((old, new))

# header
rep("`FS112-NB2-`, `FS112-NB3-`, `FS112-YB-`, `FS112-YB2-verification.md` (and `FS112-YB3-verification.md`, folded in at stage 1b when it reports), the reading",
    "`FS112-NB2-`, `FS112-NB3-`, `FS112-YB-`, `FS112-YB2-`, `FS112-YB3-verification.md` (YB3 folded in at stage 1b by FS112-C2, reconciliation §1.8–1.10), the reading")
rep("moves a value; nothing answers a posed question.",
    "moves a value; nothing answers a posed question. Round 3's last verifier refuted Y3-END-NEEDS as stated with an exact, locally terminal stuck vertex\n"
    "between two unit circles (FS112-BOWTIE) — the proof side's doubly bounded one-vertex chain, built blind; corrected, a horn bound of exactly `±1` on both\n"
    "horns of a terminal map's stuck vertex occurs only at a one-vertex chain (FS112-C-HORNEND), and the composition is unchanged but for one residue of\n"
    "FS112-C-ENDS.")

# FS112-END
rep("*Proof:* N §1.4 row 9 (N112-END); NB-END. *Proof verdict:* TRUE with its scope: it reaches only chains with N4-STUCK's structure at the centre `P_k`, which\n"
    "a chain's end lacks (FS112-N2-RAY). *Rests on it:* FS112-N3-CHAINS.",
    "*Proof:* N §1.4 row 9 (N112-END); NB-END; its `λ` half re-derived blind at a chain's end by FS112-YB3 (§3.1 Step 2′), and used by NB3's N3-END item 1.\n"
    "*Proof verdict:* TRUE with its scope: it reaches only chains with N4-STUCK's structure at the centre `P_k`, which\n"
    "a chain's end lacks (FS112-N2-RAY). *Rests on it:* FS112-N3-CHAINS; FS112-C-HORNEND (the one-vertex conclusion); the corrected FS112-Y3-END-NEEDS's scope.")

# N3-END verdict
rep("continues past its item 4 (FS112-Y3-END-NEEDS). *Rests on it:* FS112-C-ENDS.",
    "continues past its item 4 (FS112-Y3-END-NEEDS). Its second disjunct, the doubly bounded one-vertex chain, is realised locally and exactly by\n"
    "FS112-BOWTIE in N3's first description (in-type tiles at both neighbours, which NB3 judged underived here); FS112-C-DOUBLE derives that structure at one\n"
    "mind when all four horn arcs are unit arcs. With FS112-C-HORNEND its first disjunct has no terminal instance at an end both of whose horns are bounded by\n"
    "unit arcs. *Rests on it:* FS112-C-ENDS.")

# C-ENDS
rep("**FS112-C-ENDS — In a terminal valid map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours. [hand; one mind: FS112-C, an assembly; its links two minds, one blind, but the arc-through-N count one mind: NB]**",
    "**FS112-C-ENDS — In a terminal valid map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours, except possibly beside a one-vertex chain bounded on one side by a unit arc of one horn only on an (R2) arc and on the other by a unit arc, a residue not walked. [hand; one mind: FS112-C, an assembly, repaired by FS112-C2; its links two minds, one blind, but the arc-through-N count one mind: NB, and FS112-C-DOUBLE one mind]**")
rep("four; at a horn bound `±1`, FS112-N3-END puts four colours at the centre one step beyond. Where (iii) holds the antipode carries a double sector, so in\n"
    "`M*` it is stuck or has four colours (FS112-N2-TERM item 2), and the chain continues. `data/fs112/fs112-c/reconciliation.md` §1.6 (L4). *Proof verdict:* TRUE\n"
    "at one mind; the exhaustiveness of N2's exception list for (iii)–(iv) is N2's (NB2 checked N2-TERM, not the list separately).",
    "four; at a horn bound `±1`, FS112-N3-END puts four colours at the centre one step beyond — **its first disjunct only**: at its second, the doubly bounded\n"
    "one-vertex chain, N3-END says nothing of the neighbours' colours (the assembly's slip, made visible by FS112-BOWTIE; repaired by FS112-C2): there a bound on\n"
    "an in-type flank tile makes the neighbour a (Q) centre (the first case above), and with all four horn arcs unit arcs FS112-C-DOUBLE makes both neighbours\n"
    "(Q). Where (iii) holds the antipode carries a double sector, so in\n"
    "`M*` it is stuck or has four colours (FS112-N2-TERM item 2), and the chain continues. `data/fs112/fs112-c/reconciliation.md` §1.6 (L4), §1.9. *Proof\n"
    "verdict:* TRUE at one mind outside the residue in the statement; the exhaustiveness of N2's exception list for (iii)–(iv) is N2's (NB2 checked N2-TERM, not the list separately).")

# C-COMPOSE
rep("so the NO reduces to the four-colour form with no ray step and no third step; (3) for aperiodic maps the four-colour form needs both the stuck ray excluded (b′) and a uniform bound on the length of finite stuck chains, a third GAP, (b″). [hand; one mind: FS112-C; its links two minds, one blind]**",
    "so the NO reduces to the four-colour form with no ray step and no third step; (3) for aperiodic maps the four-colour form needs both the stuck ray excluded (b′) and a uniform bound on the length of finite stuck chains, a third GAP, (b″). [hand; one mind: FS112-C; its links two minds, one blind, but FS112-C-ENDS, on which item 2 rests, one mind]**")
rep("which no record derives. *Proof verdict:* TRUE at one mind; (b″) named, not bridged.",
    "which no record derives. **No step uses FS112-Y3-END-NEEDS** (only the reconciliation's forecast, §1.6 item 5, did; corrected in §1.9): item 2 inherits\n"
    "FS112-C-ENDS's residue; with FS112-C-HORNEND, (b′) and (b″) concern chains of two or more vertices, whose ends lie at NB4P exceptions, at an arc of the\n"
    "end vertex's circle through the next point, or at a unit arc bounding one horn only (not walked); the one-vertex bowtie (FS112-BOWTIE) adds nothing to\n"
    "(b′), (b″) or item 2's radius. *Proof verdict:* TRUE at one mind; (b″) named, not bridged.")

# C-PARTNERS
rep("and the count of leaving centres, N3 stage N3-3's frame and Y3 §4.2 item 1]**",
    "and the count of leaving centres, N3 stage N3-3's frame, Y3 §4.2 item 1 and YB3 §3.6]**")

# new §3 entries, after C-PARTNERS's paragraph and before SEAMS-TWO
new_c = """**FS112-C-HORNEND — In a terminal valid map, a stuck vertex `E` both of whose horns are bounded by unit arcs of `ω(E + n)` has a horn bounded by a unit arc of `ω(E − n)` too, and is a one-vertex chain; likewise with `n` reversed. [hand; one mind: FS112-C2, an assembly over FS112-Y3-END-NEEDS as corrected and FS112-END]**
*Proof:* if neither horn's lower arc is a unit arc of `ω(E − n)`, FS112-Y3-END-NEEDS as corrected needs a seventh colour; so some lower arc is one. A unit
arc of `ω(E ± n)` bounding a horn of `E` makes `E ± n` not stuck (FS112-END; FS112-YB3 Step 2′; NB3's N3-END item 1), so the chain is `{E}`; the mirror is
the same argument with `n` reversed. `data/fs112/fs112-c/reconciliation.md` §1.9. *Proof verdict:* TRUE at one mind; its hypothesis is Y3-END-NEEDS's
setting — **a unit arc bounding one horn only of a side (an (R2) arc) is not walked**. *Rests on it:* FS112-C-COMPOSE's narrowing of (b′) and (b″); FS-115's
question. *Prior art:* not found in print. *Kernel:* stub — with FS-115.

**FS112-C-DOUBLE — In a terminal valid map, a stuck vertex `E` all four of whose horn arcs are unit arcs, of `ω(E + n)` above and `ω(E − n)` below, carries an in-type tile of its upper flank colour at `E + n` and of its lower flank colour at `E − n`, and both are (Q) centres with at least four colours. [hand; one mind: FS112-C2, a sketch over FS112-Y3-END-NEEDS's levels with n reversed and FS112-N2-TERM]**
*Proof:* `data/fs112/fs112-c/reconciliation.md` §1.9: any `g` at `N = E + n` is in-type (an out-type one contradicts `g` filling `E`'s `+n` side); if `g` is
absent at `N`, both horns take their `g`-shadows from out-type tiles at `S = E − n` tangent to `±a`, two sectors of `g` at `S` with `c` in the pinch below —
Y3-END-NEEDS's level 2 at `S` with `g` in `h`'s role — and its levels then need a seventh colour at `S − n`; so `g` is at `N`, in-type, the arcs of `ω(N)`
bounding the horns carry both side colours at their centre, are not (R2), hence (Q) in `M*`. Likewise at `S`. *Proof verdict:* TRUE at one mind, a sketch; the
mixed source case (one horn's `g`-shadow from each side) is covered; a unit arc bounding one horn only of a side is outside it. It is N3's first description
of the one-vertex chain (`plans/FS112-N-proof.md` N3-END, "the in-type `g` at `P_1` and `h` at `P_{−1}`"), which NB3 judged underived by N3-END's own proof, and
FS112-BOWTIE realises it. *Rests on it:* FS112-C-ENDS's repair. *Prior art:* not found in print. *Kernel:* stub — with FS-115.

"""
rep("**FS112-SEAMS-TWO — C-SEAMS-TWO corrected:", new_c + "**FS112-SEAMS-TWO — C-SEAMS-TWO corrected:")

# Y3-PIN
rep("and the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2`. [tools, exact at named points + hand; one mind: Y3]**\n"
    "*Proof:* Y3 §2.1–2.3 (Y3-STRIPCUT, Y3-DISK-T*, Y3-LEG; `tools/fs112_y3_pin.py`). *Proof verdict:* TRUE at one mind; Y2 §6.4's blocker corrected from\n"
    "`Z^L_0`'s sector to `Y_0` (recorded, not rewritten). **Grade pending FS112-YB3** (stage 1b). Y2-PIN strengthened: each named local move forces a change\n"
    "one ring further out.",
    "and the leg `Y_0A_0` is the perpendicular bisector of `C_0` and `q2`. [tools, exact at named points + hand; two minds, one blind: Y3; YB3]**\n"
    "*Proof:* Y3 §2.1–2.3 (Y3-STRIPCUT, Y3-DISK-T*, Y3-LEG; `tools/fs112_y3_pin.py`); FS112-YB3 §3.3, 3.4, 3.8 (`tools/fs112_yb3_pins.py`: 22 exact points at the\n"
    "cut; Y3's seven disk points colour-free in a second, in-disk object). *Proof verdict:* TRUE, two minds, one blind; Y2 §6.4's blocker corrected from\n"
    "`Z^L_0`'s sector to `Y_0` (recorded, not rewritten). Precisions (YB3 D5–D7): the cut's list of tiles to change is `C_{−1}`'s side — a midline arch, `C_{−3}`\n"
    "or `C_1` — and `C_2`'s is its mirror, a midline arch, `C_0` or `C_4`; the colour-free part of the region `T2_0` must vacate is a proper sub-region (one mind,\n"
    "YB3: violet admissible near `Z^L_0` and `Y_0`, orange near `K`); `|q2 − Y_0|` ≈ 0.9036, its square ≈ 0.8165. Y2-PIN strengthened: each named local move\n"
    "forces a change one ring further out.")

# Y3-END-AB
rep("a SHAVE available). [tools, exact; one mind: Y3; plants fire]**\n"
    "*Proof:* Y3 §3.1–3.2 (`tools/fs112_y3_chainend.py`; 43 of 43 and 47 of 47 pairs). *Proof verdict:* TRUE at one checker; neither completion is terminal at\n"
    "`N`. **Grade pending FS112-YB3.**",
    "a SHAVE available). [tools, exact; two rebuilds, one blind: Y3; YB3; plants fire in both]**\n"
    "*Proof:* Y3 §3.1–3.2 (`tools/fs112_y3_chainend.py`; 43 of 43 and 47 of 47 pairs); FS112-YB3 §2.2–2.4, 3.2 (`tools/fs112_yb3_frags.py enda endb`; 39 of 39\n"
    "and 44 of 44, the MERGE at `N` built and checked, 43 of 43, both SHAVEs built and checked, 46 of 46 and 49 of 49). *Proof verdict:* TRUE; two members of one\n"
    "family (colours, horn ends, closing tiles, END-B's concentric centre differ); neither completion is terminal at `N`. END-B's open arc ends need unit arcs\n"
    "centred at `N` of total length at least 180° (FS112-SIX at `N`, YB3 §3.1 Step 3 (b)); END-B carries ≈ 14.3° in Y3's and ≈ 45.2° in YB3's, so Y3's remedy\n"
    "(a shorter arc of `H1`) is necessary, not sufficient.")

# Y3-END-NEEDS: replace header + body whole
old_needs_start = "**FS112-Y3-END-NEEDS — To keep the chain's end `E` stuck"
i = t.index(old_needs_start)
j = t.index("**FS112-Y3-R1 —", i)
old_needs = t[i:j]
new_needs = """**FS112-Y3-END-NEEDS — Corrected: if both horns of a stuck vertex `E` of a terminal valid map, `P_cl(E) = {g, c, h}`, are bounded by unit arcs of `ω(N)`, `N = E + n`, and neither by a unit arc of `ω(E − n)` — in particular at the end of every stuck chain of at least two vertices — then keeping `E` stuck and `N` terminal needs five colours at `N` against its MERGE and a seventh colour at `N + n` against its SHAVE, so no such end exists; as Y3 stated it, for every three-colour end at a unit arc, it is FALSE, by FS112-BOWTIE. [hand; the levels two minds, one blind: Y3; YB3; the shadow-source list, its exception and the step y ≠ g one mind: YB3; the chain case through FS112-END, two minds, one blind]**
*Proof:* Y3 §3.3; FS112-YB3 §3.1 (Steps 1–4, 2′), §4 D1–D2. Y3's first requirement ("No SHAVE at `E` needs `h` shadowing the horn from above: FLANK's list,
re-read with unit arcs, leaves only `h`-tiles at `N` tangent to `±a` from above") misses one source: an in-type `h`-tile at `E − n`, possible exactly when
`E`'s lower arcs are unit arcs of `ω(E − n)`, shadows the whole horn (YB3 Step 2, an "iff"). Steps 3–4 use only Step 2's conclusion, so the statement holds
whenever neither lower arc is a unit arc; a chain of two or more vertices forces that (Step 2′ = FS112-END). Step 4's "no shadow from `E`" for `N`'s lower
flank `y` needs `y ≠ g`, which Y3 assumed and YB3 proved (Step 3 (a)); YB3 also shows `P_cl(N) = {c, h, x₁, x₂, y}` exactly (YB3-N5, one mind), which settles
the close's first scope point: FLANK's in-type exception at `N` does not occur at such an end. `data/fs112/fs112-c/reconciliation.md` §1.8. *Proof verdict:*
**TRUE as corrected; FALSE as Y3 stated it**, by FS112-BOWTIE, a one-vertex chain bounded by unit arcs on both sides. Its levels 1–2 agree with FS112-N3-END's
items 1–3 (frames matched), sharpened to five colours at `N`; its level 3 goes past N3-END's item 4 to a contradiction. Precisions, named: both horns' upper
arcs are unit arcs in the setting (a unit arc bounding one horn only is not walked); Y3's corollary about periodic maps is corrected in the reconciliation
§1.9 (ends at NB4P exceptions, at an arc of the end vertex's circle, at a one-horn unit arc, and one-vertex bowties). *Rests on it:* FS112-C-HORNEND; the
narrowing of FS-115. *Prior art:* not found in print. *Kernel:* stub — with FS-115.

**FS112-BOWTIE — An exact valid local fragment realises a one-vertex stuck chain bounded by unit arcs on both sides: `E = (0, 0)` with three colours, its two horns of colour 2 between `ω(E + n)` and `ω(E − n)`, shadowed by in-type radius-1 sectors of colours 1 and 3 at `E + n` and `E − n`; both neighbours four-coloured, one sector per colour, neither stuck, no MERGE, MERGE-RAY or SHAVE applicable at `E`, `E ± n`; every unit arc's end interior with its neighbourhood coloured. [tools, exact; one fragment: YB3; one checker, YB2's tower checker; stuckness exact at the antipodes and at named points]**
*Proof:* FS112-YB3 §2.2, 2.4, 3.1 (`tools/fs112_yb3_frags.py bowtie`, 21 of 21 same-colour pairs ACCEPT, over ℚ; `closed_interval` rejects exactly the six
tight pairs; the plants `h_is_g`, `no_cn` fire for their reasons); re-run by FS112-C2, identical (`data/fs112/fs112-c2/bowtie-rerun.out`). *Proof verdict:*
TRUE locally; a fragment, not a map. It refutes Y3-END-NEEDS as Y3 stated it, and it is FS112-N3-END's second disjunct — N3's first description of it, with
the in-type tiles at both neighbours — built by the construction side's verifier fenced from every proof-side record. Its name is YB3's; "bowtie" in
FS-106/FS-107's words (W-TAN) is any vertex with one colour in two opposite sectors, every stuck vertex being one. *Rests on it:* FS112-C-DOUBLE's reading;
FS-115's question (whether it lives in a valid map). *Prior art:* the in-type self-contact is `[Polymath2021]` p. 194's tactic; the fragment not found in
print. *Kernel:* declined — an exact fragment; FS-115 may promote it.

"""
t = t.replace(old_needs, new_needs, 1)

# Y3-R1
rep("its chains have at most `3V + 3` vertices. [hand; one mind: Y3; arithmetic]**",
    "its chains have at most `3V + 3` vertices. [hand; two minds, one blind: Y3; YB3; arithmetic]**")
rep("FS112-N3-CHAINS, independently (a second mind for STEP, not blind to card R's reading). **Grade pending FS112-YB3.** *Rests on it:* nothing beyond",
    "FS112-N3-CHAINS, independently (a second mind for STEP, not blind to card R's reading). FS112-YB3 (§3.5) confirms it blind and sharpens the bound to\n"
    "`2V`; it applies the finite alphabet to \"a map\" as Y3 does, so the premise's correction to `M*` stays the proof side's. *Rests on it:* nothing beyond")

# Y3-R3
rep("the disk's `(A_0, y)` pairs are saved at both by (S1). [a reading of exact results held; one mind: Y3]**\n"
    "*Proof:* Y3 §4.1 (over YB-SEAMS, Y2 §5.3 (d), YB2-PAIRS). *Proof verdict:* TRUE as a reading; **grade pending FS112-YB3.**",
    "the disk's `(A_0, y)` pairs are saved at both by (S1). [tools, exact; two minds, one blind: Y3, a reading of exact results; YB3, an exact recount]**\n"
    "*Proof:* Y3 §4.1 (over YB-SEAMS, Y2 §5.3 (d), YB2-PAIRS); FS112-YB3 §3.7 (`tools/fs112_yb3_r3.py`: every close complementary vertex pair of YB2's rebuilds,\n"
    "24 on the strip with a member in one period, 20 on the disk, both common unit points and the completion tested). *Proof verdict:* TRUE; the `(A_0, y)`\n"
    "(S1) clause rests on Y2's seam points, placed in floating point, not re-checked.")

# Y3-T2-BUDGET
rep("and the strip's printed colouring cannot meet the pattern. [hand; one mind: Y3]**\n"
    "*Proof:* Y3 §4.2. *Proof verdict:* TRUE at one mind; **grade pending FS112-YB3.**",
    "and the strip's printed colouring cannot meet the pattern. [hand; two minds, one blind: Y3; YB3; the strip clause tools, exact]**\n"
    "*Proof:* Y3 §4.2; FS112-YB3 §3.6 (the strip's 18 listed `(V, A)` pairs complementary at ≈ 0.7569, none a completion). *Proof verdict:* TRUE, two minds.")

# errata rows
rep("| `data/fs112/claims.md` §2, T2 | \"(the spindle's rhombus)\" | also a thin unit rhombus at `√15/2` | FS112-STRIP-SEAMS |",
    "| `data/fs112/claims.md` §2, T2 | \"(the spindle's rhombus)\" | also a thin unit rhombus at `√15/2` | FS112-STRIP-SEAMS |\n"
    "| `plans/FS112-Y3-construction.md` §3.3 and its table, Y3-END-NEEDS | \"leaves only `h`-tiles at `N` tangent to `±a`\"; \"So a stuck chain cannot end at a unit arc in a terminal map while `E` has three colours\" | an in-type `h` at `E − n` when the lower arcs are unit arcs; TRUE only when neither lower arc is one (every chain of two or more vertices); FALSE at a one-vertex chain bounded on both sides | FS112-Y3-END-NEEDS, FS112-BOWTIE |\n"
    "| Y3 §3.3 item 4 | \"a periodic terminal map has no stuck chain at all unless an end vertex is a four-colour vertex\" | ends also at NB4P exceptions, at an arc of the end vertex's circle, at a one-horn unit arc, and one-vertex bowties | reconciliation §1.9; FS112-Y3-END-NEEDS |\n"
    "| Y3 §2.1 (Y3-STRIPCUT) | \"The same at `C_2`\", the list `C_{−3}` or `C_1` | at `C_2` the mirror list: a midline arch, `C_0` or `C_4` | FS112-Y3-PIN |\n"
    "| Y3 §2.2 item 2 | \"`\\|q2 − Y_0\\|² < 1` (float 0.9036)\" | 0.9036 is `\\|q2 − Y_0\\|`; its square is ≈ 0.8165 | FS112-Y3-PIN |\n"
    "| Y3 §3.2, END-B | \"closing it needs `H1`'s arc to end at a smaller angle than `E`'s\" | necessary, not sufficient: unit arcs centred at `N` must total at least 180° | FS112-Y3-END-AB |\n"
    "| Y3 §1.4 item 3; YB3 §3.5 | the finite alphabet applied to \"the map\" | the premise is on `M*`: FS112-N3-PER for doubly periodic maps, GAP N3-ALPH otherwise | FS112-Y3-R1 |\n"
    "| `plans/FS112-N-proof.md` N3-P5, l. 904 | falsifier \"no arc at `P_{−2}`, refutes N3-END\" | omits N3-END's own second disjunct: the doubly bounded one-vertex chain has no arc at `P_{−2}` and is allowed | FS112-N3-END |\n"
    "| `data/fs112/fs112-c/reconciliation.md` §1.6, (L4) and item 5 | C-ENDS's horn-bound clause from N3-END's first disjunct only; \"Y3-END-NEEDS, if YB3 confirms it, removes horn-bound-`±1` ends from terminal maps\" | the second disjunct repaired by FS112-C-DOUBLE; item 5 as corrected in §1.9 | FS112-C-ENDS, FS112-C-COMPOSE |")

for old, new in E:
    n = t.count(old)
    if n != 1:
        print('COUNT', n, 'for:', old[:120]); sys.exit(1)
    t = t.replace(old, new)
P.write_text(t)
print('applied', len(E), 'replacements + the Y3-END-NEEDS block')
