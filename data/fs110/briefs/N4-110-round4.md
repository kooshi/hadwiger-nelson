*Brief for job **FS110-N4**: the proof side of FS-110 in round 4, on the `d = 2` seam. Opus 5.5, 2026-09-27. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is `data/fs110/briefs/N110-proof.md` (the original brief for
the proof side; its reading list, fences, contest rules and "Your side" section bind you) plus this file, which wins where they differ.**
`data/fs110/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

Read your side's record, `plans/FS110-N-proof.md`, in full, including every "§ Continuation" section. It holds your side's two rounds. You continue it in a new
section, "§ Continuation — FS110-N4", and you never rewrite an earlier verdict.

Then read **`data/fs110/claims.md` §7, §7.1 and §8**. §8, with its update, is the round-4 frame: under Condition 5, N3-RED (two minds, one blind)
leaves G-CONE and G-d2, both at distance exactly 2. A blind check finds G-d2 possibly vacuous (one mind; a second mind is running). **W-4: can a hard
Woodall cone, or the `d = 2` configuration, occur in a tight six-map in `𝓜_K` under Condition 5?**

Two notes before you start:
- **The prior-art check (FS110-PA, `plans/FS110-PA-prior-art.md`, open to you) finds Condition 5 without Condition 6 unsettled, unstated and unasked in print.**
  Round 4 is new ground. S–V's Lemma 2 is NB-4's four-colour half.
- **Say which Condition 5 you use.** The print's Condition 5 reads: "If any boundary intersects with a circle of unit radius at a finite set of
  points, we say that arcs of unit curvature are forbidden." The claim list's gloss is "no boundary arc of radius 1". State which form you use, and
  whether the two coincide in `𝓜_K`.

## Your task

**Close the `d = 2` seam (W-4 NO).** Prove that a hard Woodall-cone vertex (N3-DEG) cannot occur in a tight six-map in `𝓜_K` under Condition 5.
Say whether G-CONE and G-d2 are one configuration, decided by one argument (the card in §8, "hunch: one").
- Your side's contact calculus (N3-CONF, N3-CLEAR, N3-UP) and `tools/fs110_n_merge.py` are yours to use.
- If G-d2 is not vacuous, close it too.
- A NO at both, over its base, answers the Condition-5 half of S–V Question 2 almost everywhere at bounded `K`. That answer is partial, and is
  reported as partial.

**The pre-round question** (sent word for word to both sides by the owner): before your first saved stage of round 4, name the step of the construction side's
programme on W-4 that you expect to fail, and say what would show you wrong. Put the answer at the top of your section and send it to `"main"`.
From then on, retractions are counted.

## Rules

- **Touch only** your side's record (your new section only), `data/fs110/fs110-n/` and `tools/fs110_n_*.py`.
- Commit by explicit path, with subjects "FS110-N4: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Fences:** your original brief's list, unchanged: the construction side's files, every advisor's record and working directory, every blind verifier's record and directory (FS110-NB, YB, NB3, YB3, CB, CD), the session transcripts, `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs110-n3/`), and `git log`
  beyond the start-up snapshot until you hand back. A fence touch is disclosed at once.
- **The ban** runs to 2026-10-01, and Kooshi's ruling stands beyond it: a candidate is given by formula and checked exactly, and nothing is searched.
- An advisor may join during the round. Its id comes from me. Send every report to `"main"` explicitly. Do not message any agent after you hand
  back.
- **Budget:** about 400k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your record saved when your own count
  reaches about 220k.
- Report under standing rule 9 to `data/fs110/reports/FS110-N4.md` and by SendMessage to `"main"`. Your final turn's text: "FS110-N4 idle; report
  sent to the owner by SendMessage".

Thank you.
