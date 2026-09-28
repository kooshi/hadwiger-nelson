# FS112-YB2 — round-2 blind verification of FS-112's construction side (the six-coloured disk and the strip's stopping points)

*Job FS112-YB2, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `b5f5db3b`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by
the instance file `data/fs112/briefs/YB2-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. My checker `tools/fs112_yb2_check.py` is
written without reading Y's, Y2's or YB's checker code; Fig. 10 is transcribed by eye and the transcription committed before any solve; my verdicts on
O1–O5 are committed (step 3) before I open Y2's section, tools or outputs. Every object below is a local positive, not a map of the plane.*

## Theorems this phase proved

(filled at each stage; one line per theorem, its grade and its address)

## Would have searched here (standing rule 3)

(one line per move I would have made by search, and what I did instead)

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
