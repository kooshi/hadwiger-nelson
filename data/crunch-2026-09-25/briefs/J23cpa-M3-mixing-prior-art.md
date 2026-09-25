*Brief for crunch job **J23cpa**: a prior-art reader for M3's mixing-selection lemma (J21-MX) and its neighbours. Opus 5.5,
2026-09-25. Written by the product owner, in the form of `data/fs89/briefs/PA-tardif2023-reader-brief.md` (read it for the house form).*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **a prior-art reader** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (G49, G50), `WORKFLOW.md` (step 3.2) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record already exists, you are resuming:** continue at the first stage not SAVED (`git log -- plans/M3-PA-mixing.md`).

## The question

M3's close (job J23c, running beside you) found one result of M3 that could be new, **J21-MX**, stated verbatim in
`plans/M3-S1D-windows-five.md` ("Theorems this phase proved"):

> **J21-MX (mixing selection)** — `K` compact abelian, `ν` a probability on `T_K ⊆ K`, `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/(k−1)`: for every Borel
> graph `X`, a Borel proper `k`-colouring of `X × Cay(K, T_K)` yields the Borel proper `k`-colouring `φ(x) = min{j : μ(W(x,·)^{-1}(j)) >
> λ*/(1+λ*)}` of `X`; for measurable `W` proper off a null vertex set, `φ` is measurable and proper off a null vertex set. [hand] §3.2

In the discipline's words: a spectral (Fourier) condition on one factor of a categorical product that forces every `k`-colouring of the
product to descend to the other factor — a quantitative, measurable Hedetniemi-type statement; its finite case generalises Burr–Erdős–Lovász
`χ(G × K_n) = min(χ(G), n)`. J23c ran 24 zbMATH queries and 3 web searches without finding it, and named three unread neighbours
(`plans/M3-exotic-colourings.md` §R-close, item R3.10 — read it for the exact references):
- **Alon, Dinur, Friedgut, Sudakov 2004** (GAFA; "Graph products, Fourier analysis and spectral techniques") — stability of independent
  sets in weak products: the literature's form of the "cylinder lemma" J21 showed false in the planner's form;
- **Tardif–Wrochna 2019** (Hedetniemi-type products, strongly multiplicative graphs);
- **Godsil–Roberson–Rooney 2020** (as J23c's R3.10 names it).
Also bearing: `[Zhang2012]` Thm 1.8 (held), `[Zhu2021]` (now held, `~/source/library/pdf/`), `[KechrisMarks2020]` Problem 4.23 (held).

## What to do

For each paper: fetch it (arXiv or open copy; a paywalled one goes on a list for Kooshi with its exact reference and DOI), save it to
`~/source/library/pdf/` as `Author<year>-<short-title>.pdf`, and **read the sections that bear, in full** (an abstract is not a reading,
G50); record per section what you read. Then the verdict on J21-MX, at exact scope: *in print* (where, exactly — then it is prior art) /
*partly in print* (which part: the finite case, the spectral threshold, the Borel/measurable form) / *not found by these searches* (the
queries and papers) / *undecided* (a named unread paper). Never "new". Run WORKFLOW 3.2's items 1–3 and 8 (the zbMATH API) in the words
above for anything the three papers point to.

## Output

`plans/M3-PA-mixing.md`: one section per paper, the verdict, proposed `BIBLIOGRAPHY.md` rows (proposals only — you do not edit it), and a
list of papers for Kooshi. Send the verdict to me when it lands; I forward it to J23c.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved paper and tell me what is left.
- **Touch only** `plans/M3-PA-mixing.md`, `data/m3/j23cpa/`, and the library folder. Never touch J23c's files (the M3 plan, derivation
  file, inventory).
- **No finite-witness search** (the ban to 2026-10-01); keep the log (it will be empty; say so).
- **Commits by explicit path**, subjects "J23cpa: paper n". End commit messages with your harness's attribution lines. Push; never
  force-push.
- **Budget:** about 200k by the harness's count.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J23cpa.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J23cpa idle; report sent to the owner by SendMessage".

Thank you.
