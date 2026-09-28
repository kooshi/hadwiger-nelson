*Brief for job **FS112-N3**: the proof side of FS-112, the unit-arc half, round 3. Opus 5.5, 2026-09-27. Written by the product owner. FS112-N2 and its
blind verifier FS112-NB2 are done. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS112-N's brief `data/fs112/briefs/N112-proof.md`, as amended by
`data/fs112/briefs/N2-112-proof-continued.md`, plus this file**; where they differ, this file wins. `data/fs112/briefs/STANDING-RULES.md` is part of all
three; read rule 0 first.

## Where you start

- **Your side's record:** `plans/FS112-N-proof.md` in full, N2's section (§ Continuation — FS112-N2) closely; N2's report `data/fs112/reports/FS112-N2.md`.
  You continue the record in a new section, "§ Continuation — FS112-N3", and never rewrite an earlier verdict.
- **Both finished proof-side verifiers are open to you:** `plans/FS112-NB-verification.md`, `plans/FS112-NB2-verification.md`, their reports, and their tools
  (`tools/fs112_nb_checks.py`, `tools/fs112_nb2_checks.py`; run, never edit). **NB2 confirms all ten of N2's statements blind, and files N2-DENSE in a
  sharper form** — every valid map: each trichromatic cubic vertex has a repeated-colour vertex within 2 or a unit-arc centre within 3, every closed disc of
  radius 4 holds one — which is your round's input (the owner's ruling). NB2 also gives the extremal stuck ray as the pencil of circles of radius `k+1`
  about `P_{−1}`, and NB2-END (a sketch, one mind): a chain's end may force a unit arc one step beyond it.

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

## Round 3 — the competition advisor's aim for the proof side (adopted by the owner)

FS112-A3's decision, quoted verbatim from its record (`plans/POROS-2026-09-27-fs112-competition.md` §A3-3.4; the record itself stays fenced from you), with one
reason withheld as its own fence note directs:

> ### A3-3.4 Round 3's aim for the proof side — a decision in four parts
>
> - **The choice.** **(a), the base at a trichromatic vertex within distance 4 of a (Q) or (R2) centre** (N2 §5.4: Lemma 4's pigeonhole at `u`, and
>   whether a (P′)-nesting pair at a (Q) centre can be one the pigeonhole hands to Lemma 3 or Cor. 3, starting at a junction of two consecutive arcs of a
>   centre's circle). In order:
>   1. **A bounded lemma stage first:** check R1. If it holds, state (b) for maps with a finite arc alphabet as closed, and (b) for aperiodic maps as the
>      named GAP, with NB2-END as its route.
>   2. **Then (a)**, over NB2's form of DENSE, reading every step against R3 on the strip.
>   3. **(b)'s aperiodic case** (R2's exclusion by NB2-END) comes after (a), or first if (a)'s pigeonhole lands on a stuck chain's end.
> - **The alternative weighed.** (b) as the round's aim (N2's recommendation: "the one whole-line object no disc-local argument sees"), with NB2-END as its
>   route.
> - **Why this one won.**
>   1. **Bearing on the answer.** Every YES candidate a formula can give has a finite arc alphabet. If R1 holds, there are no rays there and every chain is
>      bounded, so by DENSE unit-arc centres come in every disc of bounded radius, and the whole question in that class is (a). (b)'s remaining content is
>      aperiodic limit objects: needed for a NO of Q-full_K, never for a periodic YES.
>   2. *[withheld from the proof side by the advisor's own fence note: its construction-side content]*
>   3. **NB2-END lands in (a) anyway.** Its route closes a chain's end by forcing a further unit arc, which is (a)'s territory.
> - **Confidence: medium.** Two facts would change it:
>   - **R1 fails:** a map with finite arc alphabet carries a ray or unbounded chains. Then (b) first, as N2 recommends.
>   - **(a)'s first stage finds** that the base's pigeonhole near a (Q) centre falls on a stuck chain's end. Then the two merge at NB2-END, and (b)'s end
>     analysis goes first.
> - **Default:** if the owner says nothing, N3's brief is the R1 lemma stage, then (a), then (b)'s aperiodic case. Card R part 1 goes in verbatim, with
>   NB2's DENSE as the input, and a blind verifier follows.

## Rules

- **Touch only** `plans/FS112-N-proof.md` (your new section only), `data/fs112/fs112-n/` and new `tools/fs112_n3_*.py` files (earlier tools run, never edited).
- **Fences:** N's list as N2's brief amended it, and now also open: NB2's record, report, directory and tools. Still fenced: the construction side's files
  (`plans/FS112-Y-construction.md`, `plans/FS112-Y3-construction.md`, `data/fs112/fs112-y/`, `tools/fs112_y_*`, `tools/fs112_y2_*`, `tools/fs112_y3_*`) and
  its verifiers' (`plans/FS112-YB-verification.md`, `plans/FS112-YB2-verification.md`, `data/fs112/fs112-yb/`, `data/fs112/fs112-yb2/`, `tools/fs112_yb*`);
  both advisors' records and working directories (card R's part 1 is quoted above); the transcripts, `chats-bak/`, scratchpad files you did not create (work
  in `scratchpad/fs112-n3/`); `plans/FS112-close-inventory.md`; `data/fs112/reports/` except N's, N2's, NB's and NB2's; `git log` beyond the start-up snapshot.
- Commit by explicit path, with subjects "FS112-N3: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Send every report to `"main"` explicitly; never message an agent after your own hand-back, or one idle after its own.
- Report under standing rule 9 to `data/fs112/reports/FS112-N3.md`, and by SendMessage to `"main"`. Your final turn's text: "FS112-N3 idle; report sent to the
  owner by SendMessage".

Thank you.
