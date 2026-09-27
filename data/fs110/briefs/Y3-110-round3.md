*Brief for job **FS110-Y3**: the construction side of FS-110 in round 3, on the winding question. Opus 5.5, 2026-09-27. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is `data/fs110/briefs/Y110-construction.md` (the original brief for
the construction side; its reading list, fences, contest rules and "Your side" section bind you) plus this file, which wins where they differ.**
`data/fs110/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

Read your side's record, `plans/FS110-Y-construction.md`, in full, including every "§ Continuation" section. It holds your side's two rounds. You continue it in a new
section, "§ Continuation — FS110-Y3", and you never rewrite an earlier verdict.

Then read **`data/fs110/claims.md` §7**, the round-3 frame. Under Condition 5, NB-4 and NB-5 (two minds, one blind) close the tangency seam, and
what is left is **W-3: does a winding map exist?**

Two notes before you start:
- **The prior-art check (FS110-PA, `plans/FS110-PA-prior-art.md`, open to you) finds W-3 unsettled, unstated and unasked in print.** Round 3 is
  new ground. S–V's Lemma 2 is NB-4's four-colour half.
- **Say which Condition 5 you use.** The print's Condition 5 reads: "If any boundary intersects with a circle of unit radius at a finite set of
  points, we say that arcs of unit curvature are forbidden." The claim list's gloss is "no boundary arc of radius 1". State which form you use, and
  whether the two coincide in `𝓜_K`.

## Your task

**Build a winding map** (W-3 YES): a periodic curved six-map given by formula, every trivalent ring winding `|W| ≥ 2` consistently along edges, every tile even, no four-colour vertex, no boundary arc of radius 1 (W-POLY says it cannot be polygonal, bar `d = 2`, so it needs curved arcs of radius `≠ 1`), checked exactly with your side's checker extended as needed. A YES is decisive: a full tight six-map, `χ(ℝ²) ≤ 6` with no MR (W-EQ-K) — **it is held at one mind under the hold rule until a blind verifier rebuilds it from the formula**. Or name the obstruction your constructions meet: that is a result too.

**The pre-round question** (sent word for word to both sides by the owner): before your first saved stage of round 3, name the step of the proof side's
programme on W-3 that you expect to fail, and say what would show you wrong. Put the answer at the top of your section and send it to `"main"`.
From then on, retractions are counted.

## Rules

- **Touch only** your side's record (your new section only), `data/fs110/fs110-y/` and `tools/fs110_y_*.py`.
- Commit by explicit path, with subjects "FS110-Y3: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Fences:** your original brief's list, unchanged: the proof side's files, every advisor's record and working directory, both blind verifiers' records
  and directories, the session transcripts, `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs110-y3/`), and `git log`
  beyond the start-up snapshot until you hand back. A fence touch is disclosed at once.
- **The ban** runs to 2026-10-01, and Kooshi's ruling stands beyond it: a candidate is given by formula and checked exactly, and nothing is searched.
- An advisor may join during the round. Its id comes from me. Send every report to `"main"` explicitly. Do not message any agent after you hand
  back.
- **Budget:** about 400k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your record saved when your own count
  reaches about 220k.
- Report under standing rule 9 to `data/fs110/reports/FS110-Y3.md` and by SendMessage to `"main"`. Your final turn's text: "FS110-Y3 idle; report
  sent to the owner by SendMessage".

Thank you.
