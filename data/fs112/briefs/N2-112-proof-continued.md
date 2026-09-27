*Brief for job **FS112-N2**: continue the proof side of FS-112, the unit-arc half, into round 2. Opus 5.5, 2026-09-27. Written by the product owner.
FS112-N handed back at its stage 2; its blind verifier FS112-NB has reported. **Sized for about 400k tokens by the harness's count, as guidance**
(standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS112-N's brief, `data/fs112/briefs/N112-proof.md`, plus
this file.** Read that brief in full: its reading list, its fences, its contest rules and its "Your side" section all bind you. Where the two differ,
this file wins. `data/fs112/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

- **Your side's record:** `plans/FS112-N-proof.md` in full (stages 1–2); its report `data/fs112/reports/FS112-N.md`. You continue the record in a new
  section, "§ Continuation — FS112-N2", and never rewrite an earlier verdict; where you disagree with one, say so in your section.
- **Your side's blind verifier is done, and its record is now yours to read:** `plans/FS112-NB-verification.md` and `data/fs112/reports/FS112-NB.md`
  (commits 2cd9d152, ebf3113e, 6821b777), and its checks `tools/fs112_nb_checks.py`. It agrees with N's chain walk letter for letter, confirms N112-U1,
  SIX, NB4′, END, L60, LOCK blind, and finds:
  - **N4-FLANK fails at `κ = ±1`** (N right; NB conceded; two minds). NB draws, and N's record does not name, that **N112-END assumes N4-STUCK's
    structure, which FLANK's failure removes at horn bound ±1**, so "N4-FIN's application also survives" is overstated there.
  - **N112-RED has a GAP N did not name:** N's l. 231, that isolated inner-colour contacts at `P + 2e_w` "do not exist in the arc's interior", is FALSE —
    NB's local corner example (a tile of the inner colour outside the closed radius-2 disc about `P` except one corner at `P + 2e_w₀`) blocks the
    away-bend; NB sketches a tangent bend (one mind).
  - `tools/fs112_n_arcs.py`: plants `r2_outside` and `end_half` are twins exiting 0; no plant turns R2, END or L60 red.

## Round 2 — the competition advisor's aim for the proof side (adopted by the owner)

FS112-A2's decision, quoted verbatim from its record `plans/POROS-2026-09-27-fs112-competition.md` §3.5 (the record itself stays fenced from you):

> ### 3.5 Round 2 for the proof side — a decision in four parts
>
> - **The choice.** The successor takes **the end vertices of unit arcs**, which are at once N112-RED's first GAP, C-ARC-END's question, and C-UA-CHAIN's
>   step ("each unit arc forces a further unit arc … at its end vertices"). In order:
>   1. Close N112-BEND at the end vertices, and NB-ISO's isolated radius-2 contacts by the tangent bend. Settle RED's termination, stub
>      accumulation included.
>   2. Combine RED with the N4 moves and the corrected FLANK into **one terminal-map statement**: every vertex cubic or a (Q) centre; every unit arc
>      (Q) or (R2); FLANK's `κ = ±1` exception placed inside (Q) or (R2), or named; N4-FIN's application at horn bound `±1` (divergence 1′) closed or
>      named.
>   3. With that object, the first global step, by one of two routes, with the choice stated: the (E2)/end-vertex chain (C-UA-CHAIN), or S–V Cor. 1
>      a.e. with (Q) centres admitted (the base's exceptions B1–B3 are all at arc centres, which RED makes (Q)).
>   The tool gets red plants at R2, END and L60 (divergence 15) before any of its checks is cited.
> - **The alternative weighed.** Go straight at C-BEYOND's global exclusion of all-(Q)/(R2) maps, carrying RED's GAPs as named.
> - **Why this one won.** Every global route consumes RED's terminal object. RED's open GAP sits at the arc's end vertices, and **the end vertices are
>   the joints where one unit arc meets the next** — the place any chain, count or propagation must pass through. So closing the end-vertex GAP is the
>   first half of the global question, not bookkeeping. A global attempt over a reduction that is open exactly at its joints would have to re-derive
>   them anyway, inside a harder argument. Item 2 also repairs the one overstatement that the two minds left in N's record (1′).
> - **Confidence: medium.** The fact that would change it: **N's own registrations N112-P1 and P2** (the strip's arcs all (Q), with rings inside it).
>   If they are confirmed exactly at the end vertices — arc-closed (Q) centres in a held valid object — then the end-vertex analysis cannot end in a
>   local exclusion. Item 3's global step then becomes the round's whole aim, and item 1 shrinks to a lemma.
> - **Default:** if the owner says nothing, the successor's brief is items 1–3 in order, with the tool plants first, and a blind verifier after it.

Tools: the frozen `tools/fs112_n_*.py` stay as they are; the red plants at R2, END and L60 go in new `tools/fs112_n2_*.py` files, each check paired with a
plant that turns it red for its own reason, before any of their checks is cited.

## Rules

- **Touch only** `plans/FS112-N-proof.md` (your new section only), `data/fs112/fs112-n/` and `tools/fs112_n2_*.py` (the frozen `tools/fs112_n_*.py`
  stay as they are).
- Commit by explicit path, with subjects "FS112-N2: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **Fences:** N's list, unchanged, except that NB's record, report and checks are now open to you. That keeps fenced: the construction side's files
  (`plans/FS112-Y-construction.md`, `data/fs112/fs112-y/`, `tools/fs112_y_*`) and its verifier's (`plans/FS112-YB-verification.md`, `data/fs112/fs112-yb/`,
  `tools/fs112_yb_*`); both advisors' records and working directories; the session transcripts, `chats-bak/`, scratchpad files you did not create (work
  in `scratchpad/fs112-n2/`); `plans/FS112-close-inventory.md`; `data/fs112/reports/` except N's and NB's; and `git log` beyond the start-up snapshot
  until you hand back. A fence touch is disclosed at once.
- The competition advisor may contact you; send every report to `"main"` explicitly, and never message an agent after your own hand-back.
- Report under standing rule 9 to `data/fs112/reports/FS112-N2.md`, and by SendMessage to `"main"`. Your final turn's text: "FS112-N2 idle; report sent
  to the owner by SendMessage".

Thank you.
