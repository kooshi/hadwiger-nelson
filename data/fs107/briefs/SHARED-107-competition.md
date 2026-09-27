*The shared part of the briefs for FS-107's competitors **R** (`R107-stability.md`) and **W** (`W107-near-colourings.md`). Drafted by the planner
FS107-P, 2026-09-27, for the product owner to launch. Both competitors read this file word for word; it is identical for both by construction.
`data/fs107/briefs/STANDING-RULES.md` is part of it — read it in full, rule 0 first.*

## What you stand on

Read from disk, in `/home/kooshi/source/lean-dir`:
- `CLAUDE.md` § The aim and § Counter-priors first (rule 0), then G82, G71, G79, G21 and G51;
- `LEDGER.md` rows 129–132;
- **the fixed claim list, `data/fs107/claims.md`, in full** — the statements you work, the shared constraints, the killing tests and the break table,
  each with its object and its grade;
- `plans/FS106-derivation.md` §3 and §4; `plans/FS106-TQ-derivation.md` §§3–5; `plans/FS106-QB-verification.md` §§2–3; `plans/FS106-TS-derivation.md`
  §§2, 4, 5; `plans/FS106-SB-verification.md` as you need it;
- the plan, `plans/FS107-stability.md`, §G part 3 (the instructions to your phase), §PA and §IQ;
- the papers: `[Voronov2023]`, `[SokolovVoronov2025]`, `[Parts2020c]`, `[Pritikin1998]`, `[MundingerEtAl2025]`, `[DeCorteOliveiraVallentin2022]` §6.1 —
  all in `~/source/library/pdf/` (grep `BIBLIOGRAPHY.md` for the paths). Shared prior art from the planner's gate (plan §PA): `[DeCorteOliveiraVallentin2022]`
  Lemma 6.2 already proves, for one class and any bounded distance set, that periodic sets approximate the independence density; `[MundingerEtAl2025]`
  built machine-found, verified periodic cell-constant almost six-colourings removing 0.04 % — W's object class at a fixed `δ`, with no driving
  parameter and no `ε → 0` question.

## The question, and what each side is for

FS-106 proved at two minds, the second blind (`LEDGER.md` row 131; claim H-EQ), with no MR and no Voronov: `χ_m⁰(ℝ²) ≥ 7` holds exactly when the
uncovered fraction of band-proper six-colourings stays bounded below as the band `[1 − ε, 1 + ε]` closes. So Hadwiger–Nelson's measurable form is a
**stability** question.
- **R proves stability**: claim R (C-Q-STAB in its exact disc form), or its sufficient form R′ (C-VOID), on the sequence object (route R-Q) or the
  limit object (route R-S). Success is `χ_m⁰(ℝ²) ≥ 7`, and given MR `χ(ℝ²) = 7`.
- **W builds near-colourings**: claim W (row 131's (e)) — periodic grid-square six-colourings with a band and vanishing holes, given by formula and
  checked exactly. Success is `χ(ℝ²) ≤ 6` **with no MR** (with five colours, `≤ 5`; keep the two apart).
- **Each side is the other's test.** W's families are the objects R's argument must survive; R's argument names where W's holes cannot shrink. **A
  named obstruction on either side is a result**: a theorem that a class of arguments cannot give stability, or that a class of families cannot make its
  holes vanish. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
- If the challenge as posed is subtly the wrong challenge, say so. That is a finding, not a refusal.

## The protocol (`plans/PROTOCOL-competitor-and-advisor.md` §1)

- **An advisor** (Poros) advises both sides identically. Before your round 1, it asks you to name the step of the other side's programme you expect
  to fail; answer in one message. Retractions are counted from there, and a retraction while it is free is the cheapest instrument there is (G51).
- **Prior art is shared**: report any paper you find to the advisor, who passes it to both sides.
- **Teasing hints only** between the sides, through the advisor or by SendMessage: enough to show movement, never the mechanism, a formula or a
  coordinate.
- **Hold rule.** A verdict that would move the answer — a proof of R or R′, or a family meeting W — goes in your report's first line, is held at one
  mind until a blind verifier confirms it, and is announced nowhere outside the files. Do not soften it either.
- **Hand-backs are content-free**: your final turn's text is exactly "<your job id> idle; no content in this hand-back; my reports go to the owner by
  SendMessage". Every report goes to `"main"` by SendMessage; every card to the advisor by SendMessage to the id the owner gives you.

## Fences (standing rule 13 and the protocol; each by path, and no `git log -p` on any of them)

Until you have handed back, do not open, list, grep or `git log -p`:
- the other competitor's record and working directory (named in your own brief);
- the advisor's record `plans/POROS-2026-09-27-fs107-stability.md` and `data/fs107/fs107-a/`, and any later advisor record the owner names;
- `plans/FS107-close-inventory.md` and `data/fs107/reports/`;
- `git log` beyond `git log -1 --format=%h` (commit subjects can carry routes);
- the session transcripts — everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`, memory included — and `chats-bak/`;
- every file in the shared harness scratchpad you did not create: work only in `<scratchpad>/<your job id>/`; a listing of the shared root, or an
  opened file you did not create, is a fence touch — log it and say so.

When you search `plans/` or `data/`, exclude the fenced paths (`rg --glob '!<path>'`). A fence touch is disclosed at once, never worked around.

## The ban and the would-have-searched log

The ban on finite-witness search runs to 2026-10-01 (standing rule 3), and FS-107 will cross that date. Until then: derivation by hand; exact
arithmetic of seconds that checks a given object; reading. After it, Kooshi's separate ruling stands: *"search for a finite graph is out. It would be
huge, not feasible."* Any later numerical work (the joint dial, FS-109) is the owner's to schedule, never yours. Keep the log in your record.

## Records, stages, budget

- **Your record is committed after every stage** (standing rule 2), at the path your brief names; subjects exactly "<your job id>: stage n".
- Stage 1 of both sides: the quotation check of this brief and of your own (standing rule 5); the claim list's statements you will work, restated in
  your own words beside the quotation (to catch a misreading early); the one-message answer to the advisor's question.
- Every claim you work gets a verdict (TRUE / FALSE / GAP-at-step / MISSTATED), a count of minds, a grade. Audit a result you like at the rate of one
  you do not (G21): **R's flattering result is a stability argument that passes because it never met a W family; W's is a family whose holes vanish
  because the check was only sufficient.**
- **Budget:** about 400k tokens by the harness's count; your own count runs at 55–70 % of it. Hand back with your record saved before 500k; the owner
  replaces an agent above that, at a stage boundary.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision (at most three
  agents at once, all Opus 5.5), and the owner can only review work it knows about. If the work outgrows you, stop at a saved stage and say what is left.
