*Brief for job **FS112-Y3**: the construction side of FS-112, the unit-arc half, round 3. Opus 5.5, 2026-09-27. Written by the product owner. FS112-Y2
is done; its blind verifier FS112-YB2 is running. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS112-Y's brief `data/fs112/briefs/Y112-construction.md`, as
amended by `data/fs112/briefs/Y2-112-construction-continued.md`, plus this file**; where they differ, this file wins. `data/fs112/briefs/STANDING-RULES.md` is
part of all three; read rule 0 first.

## Where you start

- **Your side's record:** `plans/FS112-Y-construction.md` in full, Y2's section (§ Continuation — FS112-Y2) closely; Y2's report `data/fs112/reports/FS112-Y2.md`;
  Y2's tools and outputs (`tools/fs112_y2_*.py`, `data/fs112/fs112-y/y2_*`; run, never edit).
- **Write your record in a new file, `plans/FS112-Y3-construction.md`** (not a new section of Y's record): Y2's blind verifier FS112-YB2 is reading Y's record's
  earlier sections while it works, and must not see round 3. Your tools are `tools/fs112_y3_*.py`, your outputs `data/fs112/fs112-y/y3_*`.
- **Round 1's verifier FS112-YB is done and open to you** (as before). **FS112-YB2 is running: its record `plans/FS112-YB2-verification.md`, directory
  `data/fs112/fs112-yb2/` and tools `tools/fs112_yb2_*` are fenced.**

## Card R, part 1 — the competition advisor's note, identical for both sides (verbatim from `data/fs112/fs112-a3/card-R.md`)

> ## Part 1 (identical for both sides)
>
> **R1 — a reading, one mind (the advisor's): check it before relying on it.**
> - Take a stuck chain (C-CHAIN-8's structure at `P_k = v + kn`) with horn curvatures `λ_k < υ_k`, and C-CHAIN-9's recursion, verbatim:
>   "`λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`".
> - Since `f(λ) < λ` and `f̃(υ) > υ` for every nonzero value, each sequence is strictly increasing in `k` wherever it is nonzero.
> - The reading, then:
>   - a one-sided infinite chain carries infinitely many distinct boundary curvatures along one line;
>   - so a map whose boundary arcs fall into finitely many congruence classes (every periodic map) has no one-sided infinite chain;
>   - in such a map, the length of every stuck chain is bounded.
> - Confirm or refute it before relying on it. If it holds, a one-sided infinite chain can live only in a map with infinitely many arc classes.
>
> **R2 — the object both sides now meet at C-CHAIN-7 to 9 with unit arcs: a stuck chain whose end carries a horn bound of exactly `±1`.** At that end, the
> horn's arc is a unit arc centred at the next point of the normal line.
> - **Proof side:** exclude it, or name the step that fails.
> - **Construction side:** realise a finite segment of such a chain by formula, with its end. Fix the curvatures by C-CHAIN-9's recursion taken with
>   equality from the end. Then colour the neighbourhood of the end's unit-arc centre, check exactly, and report what that neighbourhood needs.
>
> **R3 — read the held positives' close complementary pairs at both of their common unit points: which are saved, and by what?** For the strip, read it
> from its printed words. (Card W's W6 and card X's X2, aimed at the seams.)

## Round 3 — the competition advisor's aim for the construction side (adopted by the owner)

FS112-A3's decision, quoted verbatim from its record (`plans/POROS-2026-09-27-fs112-competition.md` §A3-3.5; the record itself stays fenced from you):

> ### A3-3.5 Round 3's aim for the construction side — a decision in four parts (from Y2's §7 and card R)
>
> - **The choice.** In order:
>   0. **C-HOCK: declined as mis-aimed** (Y2 §7 item 2; recorded). A meaningful instance needs an arc of radius `< 1` between two tiles of a valid object,
>      and none is held.
>   1. **The pinned corner, both named GAPs** (Y2 §7 items 3–4), by derivation, each outcome stated as a claim:
>      - the disk: can `T*` be blue, with a change near `Z^L_0` that keeps `T2_0`'s locked top arc?
>      - the strip: colour 4 at `Q`, by cutting `C_{−1}` and `C_2` along `ω(Q)` against the valleys' forced sectors.
>      - An escape moves the dial (E6). A derived obstruction strengthens Y2-PIN into a statement the close can file.
>   2. **R2's stuck-chain end.** This replaces "the `κ = ±1` horn fragment" (Y2 §7 item 1).
>      - Take WC's horn at `κ = ±1`, and continue the chain along the normal line by C-CHAIN-9's recursion taken with equality: as a finite segment, never
>        a whole ray (R1).
>      - Complete the neighbourhood of the end's unit-arc centre.
>      - Report what that neighbourhood needs, exactly.
>   3. **If step 1 escapes anywhere,** grow the patch toward a global candidate (E5). **If it does not,** attempt the design principle the law suggests: a
>      pattern in which every close complementary pair is saved at both common unit points, as T2 saves `(W, W′)`. Derive it, never search for it, and
>      check it exactly (C-T2 (ii)).
> - **The alternatives weighed.**
>   - **(A)** R2's chain end first: it tests the proof side's secondary item and NB2-END soonest.
>   - **(B)** The owner's suggestion: the dial realises a stuck ray by formula, the pencil giving it a shape.
> - **Why this one won.**
>   - **The pinned corner is the frontier.** It is the one obstruction held on two positives with different skeletons, and the place any YES must pass. It
>     is also the configuration the proof side's round-3 step (a) must meet, so the next comparison scores the two sides at the same point.
>   - **Against (A):** the chain end tests a secondary item. If R1 holds, rays cannot matter to any periodic YES.
>   - **Against (B):** a whole ray cannot be periodic (R1), and a formula object gives only a finite segment, which (A)'s end-fragment already is.
>   - **The pencil itself stays with the proof side** (NB2's derivation). R2's "recursion taken with equality" leads the construction side to it.
> - **Confidence: medium.** Two facts would change it:
>   - **R1 fails.** Then a periodic ray is a new structural resource beyond (Q) centres, and step 2 goes first.
>   - **Both pinned-corner GAPs close quickly on one derived obstruction.** Then step 3's design principle becomes the round.
> - **Default:** if the owner says nothing, the construction successor's brief is steps 0–3, with card R part 1 verbatim. YB2's verdicts on Y2's objects
>   come in as they land.

## Rules

- **Touch only** `plans/FS112-Y3-construction.md`, `data/fs112/fs112-y/y3_*` and new `tools/fs112_y3_*.py` files (earlier tools run, never edited).
- **The D5 conditions and the ban** stand: objects by formula with derived parameters, checked at named values; no scans, no fitting; the log.
- **Fences:** Y's list as Y2's brief amended it, plus YB2's files (above). Still fenced: the proof side's files (`plans/FS112-N-proof.md`, `data/fs112/fs112-n/`,
  `tools/fs112_n_*`, `tools/fs112_n2_*`, `tools/fs112_n3_*`) and its verifiers' (`plans/FS112-NB-verification.md`, `plans/FS112-NB2-verification.md`,
  `data/fs112/fs112-nb/`, `data/fs112/fs112-nb2/`, `tools/fs112_nb*`); both advisors' records and working directories (card R's part 1 is quoted above); the
  transcripts, `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs112-y3/`); `plans/FS112-close-inventory.md`; `data/fs112/reports/`
  except Y's, Y2's and YB's; `git log` beyond the start-up snapshot.
- Commit by explicit path, with subjects "FS112-Y3: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Send every report to `"main"` explicitly; never message an agent after your own hand-back, or one idle after its own.
- Report under standing rule 9 to `data/fs112/reports/FS112-Y3.md`, and by SendMessage to `"main"`. Your final turn's text: "FS112-Y3 idle; report sent to the
  owner by SendMessage".

Thank you.
