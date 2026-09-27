*Brief for job **FS112-Y2**: continue the construction side of FS-112, the unit-arc half, into round 2. Opus 5.5, 2026-09-27. Written by the
product owner. FS112-Y handed back at its stage 2 (its context full); its blind verifier FS112-YB has reported. **Sized for about 400k tokens by the
harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS112-Y's brief, `data/fs112/briefs/Y112-construction.md`,
plus this file.** Read that brief in full: its reading list, its fences, its contest rules and its "Your side" section all bind you. Where the two
differ, this file wins. `data/fs112/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

- **Your side's record:** `plans/FS112-Y-construction.md` in full (stages 1–2, and §2.5, what Y left for you); its report `data/fs112/reports/FS112-Y.md`.
  You continue the record in a new section, "§ Continuation — FS112-Y2", and never rewrite an earlier verdict; where you disagree with one, say so there.
- **Your side's blind verifier is done, and its record is now yours to read:** `plans/FS112-YB-verification.md`, `data/fs112/reports/FS112-YB.md`,
  `data/fs112/fs112-yb/`, and its tools `tools/fs112_yb_*.py` (run them; never edit them). It rebuilt the strip blind and agrees with Y on every object and
  verdict.
- **The D5 conditions stand** (the owner's ruling): transcribe `[Polymath2021]` Fig. 10's combinatorics by eye and fix the transcription before any
  solve; report an ambiguity, never resolve it by trying alternatives with a solver; no pixel fitting.

## Card X, part 1 — the competition advisor's note, identical for both sides (verbatim from `data/fs112/fs112-a3/card-X.md`)

> ## Part 1 (identical for both sides)
>
> Card X from FS112-A3, the competition advisor (FS112-A2's successor). Hints only; no reply to me is needed; put your verdicts in your record's next
> stage.
>
> **X1 — a calibration fact about a printed object, now exact.**
> - CAL-STRIP was rebuilt from `[AxenovichEtAl2014]` p. 8's printed words twice, blind and independently. Two independent exact checkers ACCEPT it.
> - Its height is exactly `√15/2 + √3`, and every same-colour tile pair within reach touches at exactly 1.
> - Every unit arc of the strip is centred at a midline vertex that carries four colours, and is of kind **both** (claim list §0).
> - Both ends of every unit arc are vertices inside the strip's coloured interior: it is **arc-closed** (claim list §6, C-ARC-END).
> - Every midline vertex's unit circle lies wholly inside the strip.
>
> **X2 — read the strip before you rely on a step.** The strip's coordinates follow from the printed words: midline vertices at `(j/2, 0)`, arches of
> width `1/2`, arcs of radius 1 about the opposite corner, top and bottom rows fixed by one unit distance.
> - Before any round-2 step is relied on, read the strip at that step's own reading radius, in two places in particular:
>   - the end vertices of the strip's unit arcs;
>   - every point configuration the step forbids.
> - For each, say whether the circles the step reads stay inside the strip, and where they leave it.
> - (This is card W's W6 and killing test 8, now on an exact object.)
>
> **X3 — one divergence of truth is left between the sides after card W: W1 (ii).**
> - One side: NB §2.3's alternation uses `|P_cl(y_k)| ≤ 4`, and a fifth colour at `y_k` would break it. It adds an exception: unit arcs of total `≥ 180°`
>   on some `ω(y_k)`.
> - The other side and its blind verifier (two minds): the bound is a consequence of the alternation, not an input.
> - The step at issue: whether `P_cl(y_k)` can hold a third colour of `P_cl(v)`. **The construction side** re-derives it in its next stage, with the
>   neighbours' circles in view. **The proof side:** no action.
>
> **X4 — a reading, one mind (the advisor's), for either side to confirm or refute when its round reaches the seams; no priority.**
> - Take a unit rhombus of vertices `u w₀ v w₀′`.
> - T2 at the pair `(u, v)` (claim list §2) may be the same configuration as the Q-rule's (S2) with one arc of each circle ending at the seam, read at
>   the other diagonal pair `(w₀, w₀′)` when that pair is covering.
> - Claim list §1 records the (S2)-with-arcs patterns as "GAP at every pattern but N-X's". The strip's midline vertices, read from the printed words,
>   are the candidates to check.

## Round 2 — the competition advisor's aim for the construction side (adopted by the owner)

FS112-A3's decision, quoted verbatim from its record `plans/POROS-2026-09-27-fs112-competition.md` (the record itself stays fenced from you):

> ### A3-2.3 Round 2's aim for the construction side — a decision in four parts
>
> - **The choice.** The successor does the following, in this order.
>   0. **Housekeeping**, seconds each:
>      - X3's re-derivation of W1 (ii), and the Y112-NB4-MIS statement it corrects.
>      - Y's checker on CAL-7's **brick** (D3).
>      - **Both checkers, Y's and YB's, on every new object** (D4). YB's tool is run, never edited.
>      - D6's arc count reconciled.
>      - X4 checked on the strip. If the (S2)-with-arcs pattern is confirmed at the valleys and apexes (A3-1.6 item 2), it is filed as a seam realisation.
>   1. **CAL-DISK**, in the three separated steps the owner ruled.
>      - First, `[Polymath2021]` Fig. 10's combinatorics transcribed by eye, with every ambiguity reported, never resolved by a solver.
>      - Then the exact system solved.
>      - Then both checkers, printing pairs examined against pairs present, with the control `r² = (25 + 9√5)/10`.
>      - Then the read-off: every unit arc's kind and centre (N112-P3); its end vertices (arc-closed?); its four-colour vertices' rings; its close
>        complementary pairs and where each common unit point is saved (YB-SEAMS for the disk); and where the disk cannot be continued
>        (`a3-disk-stops-at-a-seam`).
>   2. **The dial (E6), from both positives.**
>      - Each attempt is aimed at a named unsaved seam: the strip's edge vertices (Y112-EDGE: change the sectors at `V₀` or `A₁`), and the disk's
>        analogue from step 1.
>      - Each is built by formula with derived parameters (in-ban) and checked exactly.
>      - Each reports the seams it saves and the obstruction it meets, stated as a claim.
>      - If an attempt saves every seam of its patch, the global candidate it suggests (E5) is built and checked.
>   3. **The `κ = ±1` horn fragment:** WC with the horn's upper arc on `ω(N)`. It is the first object that reaches C-CHAIN 5–7, 11 and 17, and it tests
>      where FLANK's exception sits in the proof side's terminal-map statement.
>   4. **C-HOCK on A6-C2** (seconds).
> - **The alternatives weighed.**
>   - **(A) The dial first, from the strip alone.** It bears on the answer most directly, and its obstruction is already named at two minds.
>   - **(B) The horn fragment first.** It tests the proof side's item 2 soonest.
> - **Why this one won.**
>   - **Against (A):** the strip gives the dial one reading. Its stopping point is a single configuration, the second seam of a `(V, A)` pair, and
>     Polymath16 already reports in words that the strip cannot be extended (`[16.347]`). The rebuilt disk is a second positive built differently (a
>     five-fold skeleton). Its own stopping point, read beside the strip's, tells a law from a design, and that is what the dial exists to measure.
>   - **Also against (A):** the disk is the only calibration between radius 1.834 and 2.124. Without it, the next comparison cannot test any proof-side
>     step that reads a radius-2 disc. The base does: `ω(y)` for `y` on `ω(u)`. And N112-P3 stays unscored.
>   - **Against (B):** A2's clause has fired, so the proof side's items 1–2 are now lemmas feeding item 3. The horn fragment tests a lemma's exception, not
>     the global step.
> - **Confidence: medium.** Two facts would change it:
>   - **Fig. 10's transcription is ambiguous** at a unit arc's centre or an adjacency, so it cannot be fixed without a guess. Then step 1 stops at
>     "ambiguity reported", and the dial on the strip moves to first.
>   - **N2's global step, once stated, reads only unit circles about points inside the strip.** Then the disk adds nothing to the next comparison, and the
>     dial goes first.
> - **Default:** if the owner says nothing, the successor's brief is steps 0–4 in this order, with card X (part 1) quoted verbatim, followed by a blind
>   verifier on the disk (CAL-DISK's robust form is two rebuilds).

## Rules

- **Touch only** `plans/FS112-Y-construction.md` (your new section only), `data/fs112/fs112-y/` and new `tools/fs112_y2_*.py` files (Y's `tools/fs112_y_*.py`
  and YB's `tools/fs112_yb_*.py` are run, never edited).
- Commit by explicit path, with subjects "FS112-Y2: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **Fences:** Y's list, unchanged, except that YB's record, report, directory and tools are now open to you. That keeps fenced: the proof side's files
  (`plans/FS112-N-proof.md`, `data/fs112/fs112-n/`, `tools/fs112_n_*`, `tools/fs112_n2_*`) and its verifier's (`plans/FS112-NB-verification.md`,
  `data/fs112/fs112-nb/`, `tools/fs112_nb_*`); both advisors' records and working directories (card X's part 1 is quoted above); the session transcripts,
  `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs112-y2/`); `plans/FS112-close-inventory.md`; `data/fs112/reports/` except Y's and
  YB's; every brief but this one, `Y112-construction.md` and `STANDING-RULES.md`; and `git log` beyond the start-up snapshot until you hand back. A fence
  touch is disclosed at once.
- The competition advisor may contact you; send every report to `"main"` explicitly, and never message an agent after your own hand-back or one that is
  idle after its own.
- Report under standing rule 9 to `data/fs112/reports/FS112-Y2.md`, and by SendMessage to `"main"`. Your final turn's text: "FS112-Y2 idle; report sent
  to the owner by SendMessage".

Thank you.
