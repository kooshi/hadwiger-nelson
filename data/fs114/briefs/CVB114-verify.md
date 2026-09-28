*Brief for job **FS114-CVB**, a blind second mind on FS114-CV's new lemmas, and a blind third mind on one split verdict, for FS-114 (the unit-arc
question). Opus 5.5. Written by the product owner, 2026-09-28. **Sized for about 250k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), a blind verifier, in `/home/kooshi/source/lean-dir`. **`data/fs114/briefs/STANDING-RULES.md` is part of this
brief; read it in full, rule 0 first**, then `CLAUDE.md` § The aim and § Counter-priors, from disk. You verify statements you have not seen proved:
derive first, read second. **Audit at the rate of a result you would want false (G21): part A flatters the NO**, and if it holds, a local exclusion about
one four-colour vertex is the whole unit-arc NO.

## Part A — FS114-CV's lemmas (one mind each; yours is the second)

Verbatim from `plans/FS114-CV-verification.md`'s theorem list (its proofs are fenced from you until your stage 1 is committed). `M*` is a terminal valid
map, `E` a stuck vertex, `n` its normal, `G_N` an in-type upper-flank tile at `E + n`, `H_S` an in-type lower-flank tile at `E − n`, `υ±` the upper and
`λ±` the lower horn bounds. The definitions are FS-112's (`data/fs112/claims.md` §0; `plans/FS112-derivation.md` header; `data/fs114/claims.md` §0).
1. **CV-L0**: "in a terminal valid map `M*` a stuck vertex centres no unit arc, so `Γ ∩ ω(E)` is finite".
2. **CV-HD**: "in `M*`, for a stuck `E`: both upper bounds `1` and no in-type lower-flank tile at `E − n` is impossible; hence
   `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1`" (all four horn arcs unit arcs, in-type flank tiles at both antipodes).
3. **CV-CLASS**: "a stuck vertex of `M*` is a bowtie (CV-HD's four equivalent conditions; both neighbours both-centres with `≥ 4` colours; a one-vertex
   chain) or has `g` twice at `E − n` and `h` twice at `E + n` (each neighbour stuck or with `≥ 4` colours and a repeated colour)".
4. **CV-ENDS**: "FS112-C-ENDS holds with no residue: the point one step beyond every finite end of a stuck chain has at least four colours".
5. **CV-EXISTS**: "every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step" — over
   FS112-N3-DENSE3, N2-TERM, N4-FIN, and N3-DEG, W-MERGE and N4-RAY under unit arcs (each two minds, statements in `plans/FS112-derivation.md` and
   `plans/FS110-derivation.md`). **This is the priority**: derive it from its inputs' statements first, and say whether it needs CV-HD or C-ENDS at all.

Use the held BOWTIE fragment (`tools/fs112_yb3_frags.py bowtie`, run unedited) as the control for CV-CLASS's bowtie case.

## Part B — C114-THOM-TOP's two clauses (the third mind; two earlier minds split)

`data/fs114/claims.md`'s C114-THOM-TOP asks whether `[Thomassen1999]`'s Lemma 1 and the topological steps of his proof hold for the map graph `M` of every
valid map (faces adjacent when their closures meet). Decide, blind:
1. **The pinch clause**: at a tile `x` whose boundary visits a vertex twice (a pinch point) or which has a hole, is `M − x` connected?
2. **The repair**: do Thomassen's steps other than the rainbow step ("x and its neighbors must have distinct colors") hold for every valid map, Siamese
   pairs allowed, or only for non-Siamese maps? Say what replaces his condition on same-coloured faces inside a curve of diameter `< 2` in the plane.
The held text is `~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt` (OCR; check a garbled line against the page
images) and `plans/FS106-V-verification.md` V3 stage 2 (this project's verification of his proof).

## Reading

`data/fs114/claims.md` §§0–3; `data/fs112/claims.md` §0; `LEDGER.md` rows 134–135; `plans/FS112-derivation.md` and `plans/FS110-derivation.md` (the
links' statements and grades); the links' own records as FS114-CV's brief lists them (`data/fs114/briefs/CV114-composition.md` § Reading — you may read
that brief).

**Fences** — do not open, list or grep **until your stage 1 is committed**: FS114-CV's record, directory and tools (`plans/FS114-CV-verification.md`,
`data/fs114/fs114-cv/`, `tools/fs114_cv_*`), and, for part B, the two earlier minds: `plans/FS114-N-proof.md` and `plans/FS114-NB-verification.md` with
their directories and tools. **Always**: the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`,
every shared scratchpad file you did not create (work in `scratchpad/fs114-cvb/`); FS112-C's assembly (`data/fs112/fs112-c/`, `data/fs112/fs112-c2/`);
every other FS-114 record and working directory (`plans/FS114-Y*`, `plans/FS114-YB*`, `plans/FS114-N3-proof.md`, `plans/FS114-Y2-construction.md`,
`data/fs114/fs114-*/` but your own); every brief in `data/fs114/briefs/` but this one, `CV114-composition.md` and `STANDING-RULES.md`;
`plans/FS114-close-inventory.md`, `data/fs114/reports/`; FS-111's files; `git log` beyond the start-up snapshot and `git log -p`. Log any touch.

## The job

1. **Stage 1, blind:** the quotation check (standing rule 5); then your own verdict on each of A1–A5 and B1–B2: TRUE with your derivation, FALSE with a
   counterexample configuration, GAP at a named step, or MISSTATED with the corrected statement, graded. Commit stage 1 **before** opening any fenced file.
2. **Stage 2:** read FS114-CV's record (part A) and FS114-N's stage-1 §1.4 (3) and FS114-NB's §2.2 D3–D4 (part B); list every divergence of truth, scope or
   grade, with both addresses.

## Rules

- **Touch only** `plans/FS114-CVB-verification.md` (headings "Theorems this phase proved", the would-have-searched log, the fence log; SAVED stages),
  `data/fs114/fs114-cvb/` and `tools/fs114_cvb_*.py`. Neutral subjects "FS114-CVB: stage n"; push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3), with its "would have searched here" log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs114/reports/FS114-CVB.md` and to `"main"`. Final text: "FS114-CVB idle; report sent
  to the owner by SendMessage".

Thank you.
