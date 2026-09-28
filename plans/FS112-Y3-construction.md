# FS112-Y3 — the construction side of FS-112 (the unit-arc half), round 3

*Job FS112-Y3, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `4609152f`. Brief: `data/fs112/briefs/Y3-112-construction-round3.md`, on
`data/fs112/briefs/Y112-construction.md` as amended by `data/fs112/briefs/Y2-112-construction-continued.md`, with `data/fs112/briefs/STANDING-RULES.md`.
This record is a new file (the brief's rule: FS112-YB2 reads Y's record while it works and must not see round 3). It continues FS112-Y's and FS112-Y2's
record `plans/FS112-Y-construction.md` and never rewrites a verdict there; where I disagree with one I say so here. Working files:
`data/fs112/fs112-y/y3_*`; tools `tools/fs112_y3_*.py` (earlier tools run, never edited). Every fragment below is **a local fragment, not a map**.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| Y3-R1 | card R's R1 holds: along any sequence obeying C-CHAIN-9's two inequalities, `λ` and `υ` are non-decreasing and two consecutive terms are equal only when both are 0; a chain infinite toward `+k` has every `λ_k < 0`, toward `−k` every `υ_k > 0`, so a one-sided infinite chain has infinitely many distinct horn radii; a map with finitely many arc radii (every doubly periodic map) has no one-sided infinite chain, and its chains have length at most `3V + 3`, `V` the number of signed curvature values its arcs can present | hand, one mind; arithmetic only | §1.4 |

## Fence log (standing rule 13; the three briefs' fences)

1. Start-up, first minute: `ls data/fs112/briefs/` with `wc -c` printed the **file names and sizes** of the fenced briefs (A112, A2-112, A3-112, N112,
   N2-112, N3-112, NB112-instance, NB112-verify-proof, NB2-112-instance, P112, PA112, YB112-*, YB2-112-instance); none was opened.
2. Same minute: `ls data/fs112/reports/` printed the **file names** of fenced reports (FS112-A, FS112-A3, FS112-N, FS112-N2, FS112-NB, FS112-NB2,
   FS112-P, FS112-PA) beside the open ones (FS112-Y, FS112-Y2, FS112-YB); none of the fenced ones was opened. `ls data/fs112/` printed directory names
   (among them `fs112-a2`, `fs112-a3`, `fs112-n`, `fs112-nb`, `fs112-nb2`, `fs112-p`, `fs112-pa`); none was listed or opened.
3. My scratch directory is `scratchpad/fs112-y3/` in this session's harness scratchpad; nothing else there was listed or opened.

## Would-have-searched-here log (standing rule 3)

- (filled per stage)

## Stage 1 — SAVED: reading, quotation check, step 0, card R's R1

### 1.1 Read from disk

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (at `4609152f`: link 2 carries one more sentence of attribution than my
context's snapshot) and G82 from disk (the other grokkings the brief names as in my snapshot); the three briefs; `plans/FS112-Y-construction.md` in full
(Y's stages 1–2, Y2's stages 3–7, closely); the reports `FS112-Y.md`, `FS112-Y2.md`, `FS112-YB.md`; `data/fs112/claims.md` in full; the plan's §1.3,
§G part 3 and §IQ; `plans/FS110-derivation.md` §1 (the chain's statements); `plans/FS110-N-proof.md` N3 §2.1–2.4 and N4 §2.1–2.8 (the chain's proofs:
contacts, the cone, the shadow, FLANK/SHAVE, RAY, STUCK, PROP, FIN, TERM — FS-110's record, not fenced); the tools `tools/fs112_y_check.py`,
`tools/fs112_y2_disk.py`, `tools/fs112_y2_dial.py` (source and outputs), `tools/fs110_y_cone.py` (the WC builder).

### 1.2 Quotation check (standing rule 5)

- `python3 tools/fs112_y3_quotes.py` (`data/fs112/fs112-y/y3_quotes.out`): **12 of 12 found** — card R's R1 quotation of C-CHAIN-9 ("`λ_k ≤ f(λ_{k+1})`
  and `f̃(υ_{k−1}) ≤ υ_k`") against `plans/FS110-derivation.md` and the claim list; the standing rules' four quotations of Kooshi (rules 0, 3, 4 against
  `CLAUDE.md`, rule 10 against `plans/CONSOLIDATION-2026-09-27.md` item 20); C-CHAIN-8, C-T2 (ii) and HOCK's sentence (claim list); and the three Y2
  sentences A3-3.5 builds on (Y2 §7 items 2–4). `--self-test`: `f` replaced by `f̃` in C-CHAIN-9 is MISSING while the faithful twin is FOUND.
- FS112-Y's 33 quotations re-found at today's HEAD (`python3 tools/fs112_y_quotes.py`: 33 found, 0 missing).
- **Not checkable:** card R part 1 (`data/fs112/fs112-a3/card-R.md`) and A3-3.5 (the advisor's record) are fenced for me; I work their text as the brief
  quotes it. A3-3.5's lines about Y2's items are not in quotation marks there (the advisor's own summary); they match Y2 §7 items 2–4 in substance.
- **No paraphrase found in my brief.**

### 1.3 Step 0 — C-HOCK: declined as mis-aimed (recorded, A3-3.5 item 0)

Y2 §7 item 2 (verbatim): "A meaningful instance needs an arc of radius `< 1` between two tiles of a valid object; none of the held exact objects has one".
I add nothing and build nothing for it. The claim C-HOCK stays open for the construction side; its first honest instance needs a valid object with a
boundary arc of radius `< 1` between two coloured tiles — none of the strip, the disk, the moved disk, FS-110's fragments (their `9/10` arcs border an
uncoloured gap) has one.

### 1.4 Card R, R1 — **TRUE, with its precise form** [hand, one mind; arithmetic only]

C-CHAIN-9's inequalities, verbatim: "`λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", with `f(λ) = λ/(1 + λ)`, `f̃(υ) = υ/(1 − υ)`, `f̃ = f⁻¹`, both increasing.
1. `f(λ) − λ = −λ²/(1 + λ) < 0` for `λ > −1`, `λ ≠ 0`; `f̃(υ) − υ = υ²/(1 − υ) > 0` for `υ < 1`, `υ ≠ 0`. Hence `λ_k ≤ f(λ_{k+1}) ≤ λ_{k+1}` and
   `υ_{k−1} ≤ f̃(υ_{k−1}) ≤ υ_k`: **both sequences are non-decreasing in `k`, and two consecutive terms are equal only when both are 0** (`λ_k = λ_{k+1}`
   forces `λ_{k+1} = 0`; `υ_{k−1} = υ_k` forces `υ_{k−1} = 0`). This is R1's "strictly increasing in `k` wherever it is nonzero", made exact.
2. **Infinite toward `+k`** (`k ≥ 0`): if some `υ_m > 0` then `1/υ_{k+1} ≤ 1/υ_k − 1` for `k ≥ m`, so `υ > 1` after more than `1/υ_m − 1` steps — impossible
   (N4-FIN's count); so every `υ_k ≤ 0`, every `λ_k < υ_k ≤ 0`, no `λ` is 0, and `λ_0 < λ_1 < λ_2 < …`. **Infinite toward `−k`**: the mirror — every
   `λ_k ≥ 0`, every `υ_k > 0`, and `… < υ_{−2} < υ_{−1} < υ_0`. Either way the curvatures at the chain points, hence (curvature `1/(C − k)` signed, `|·|`
   strictly monotone) **the radii of the horn arcs, are pairwise distinct: infinitely many radii on one normal line.** With unit arcs allowed the values
   lie in `[−1, 1]`; `f̃(1) = +∞` and `f(−1) = −∞` only shorten chains (a term equal to `±1` is an end), so nothing changes.
3. **Finitely many radii** (in particular every map periodic in two independent directions: finitely many tiles per period, finitely many arcs up to
   translation): the curvatures at chain points lie in a finite set of `V` signed values, so no one-sided infinite chain exists, and splitting any
   finite chain into its `υ < 0`, `υ = 0` (where `λ < 0`) and `υ > 0` parts, each strictly monotone, bounds **its length by `3V + 3`**.
4. **Scope.** R1 is about the inequality chain only — arithmetic, no geometry. It does not say where a chain ends or what an end needs (card R's R2);
   and it does not reach a limit object of `𝓜_K`, which need not be periodic (W-EQ-K's tight map is a Hausdorff limit; only its approximating band-proper
   designs are periodic). So: **a periodic YES candidate has only finite stuck chains, each with two ends**, and every end is a place where C-CHAIN-8's
   propagation fails — under Condition 5 nowhere (row 134), with unit arcs possibly at a unit arc (R2). A3-3.5's first alternative (R1 fails) did not fire.

## Stage 1 — SAVED
