*Brief for job **FS106-P**: open FS-106, the regular half, by WORKFLOW 3–4. Opus 5.5, 2026-09-26. Written by the product owner. An advisor
(Poros, job FS106-A) works beside you.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is
part of this brief; read it in full — rule 0 first.** Read from disk (the file was reframed today; read the disk copy):
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest;
- `LEDGER.md` in full;
- `WORKFLOW.md` steps 3–5 and `DEBRUIJN.md`;
- **the stub `plans/STUB-regularity-wall.md`** (FS-106 is its first half);
- FS-103's records of the measurable normal form (`plans/FS103-V1-verification.md` §2b on C-FMT, `plans/FS103-M-derivation.md` §2–§3, `plans/FS103-N-verification.md`) and PA1's (E) (`plans/POROS-2026-09-26-hn-paths.md` §2.1).

## Kooshi's words (2026-09-26, verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish."

> "Let's see some ambition. I know we can do it. Look at what you've done in just the last couple days, and we've already reduced it to a
> single set of fields!"

## The question (the stub's FS-106, stated so a plan can aim at it)

Regular colour classes need seven in print: closed classes (`[Voronov2023]` Thm 1.3), band-avoiding colourings (Thm 1.1), nice maps
(`[Thomassen1999]`), polygons (`[SokolovVoronov2025]`); maps need six (`[Townsend1981]`, `[Townsend2005]`, `[Coulson2004]`). **Which of these
hold when properness is required only almost everywhere, and does Voronov's circle-colouring method run on the measurable normal form?**
The normal form: density-open classes, avoiding distance 1 at every point, covering the plane off a null set. Given MR, a yes to the
second question is `χ(ℝ²) = 7`; a regular almost-everywhere-proper six-colouring is `χ(ℝ²) ≤ 6` with no MR (the stub, links 5–6).

## What to produce: `plans/FS106-regular-half.md`

1. **§G** (WORKFLOW 3.1): one short line per grokking, row mechanism and method rule, with each *bears* extracted into a phase. Keep it
   terse. Save in two stages.
2. **§PA**:
   - `[Voronov2023]`'s own citation graph and its citing works: is the method, or any measurable form of it, in print since? Include
     `[SokolovVoronov2025]`'s references.
   - The literature on measurable and almost-everywhere colourings: Falconer's line, Bachoc–DeCorte–Oliveira–Vallentin, "density
     topology", "approximately continuous colouring".
   - Kooshi is fetching Townsend 1981 and 2005, Thomassen 1999 and Pritikin 1998. Plan around their arrival, and read them when they land
     (`~/source/library/`).
3. **§IQ**, the structural form: what must every almost-everywhere-proper measurable colouring carry at the circles? That is the invariant
   Voronov's method reads on closed colourings.
4. **The fixed claim list** `data/fs106/claims.md`, statements only:
   - Voronov's Thms 1.1 and 1.3, verbatim, with every hypothesis;
   - the almost-everywhere slack corollary;
   - the almost-everywhere form of each regular-class theorem;
   - the named closed-set step of Voronov's method and its measurable replacement.
5. **The plan**: phases, budgets, stop rules and checkpoints. A verification of Voronov's proofs by two minds, one of them blind. The
   derivations the claims need, each with a blind second mind. The method transfer as the heart; name where a competitor would help, since
   FS-107 is the competition proper. Draft the job briefs as `data/fs106/briefs/<id>-*.md` for the owner to launch (at most three agents at
   once). Register expectations with both outcomes reachable; per the counter-priors they are instruments, not caps.

## Rules

- **Touch only** `plans/FS106-regular-half.md`, `data/fs106/claims.md`, `data/fs106/briefs/<new job briefs>`, `data/fs106/fs106-p/`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- Do not derive the method transfer yourself (the jobs do); read Voronov enough to state the claims exactly.
- Send the advisor your §G bears list and your claim-list draft by SendMessage (its id comes from me); you decide and record disagreements.
- Commit subjects "FS106-P: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Report per standing rule 9 to `data/fs106/reports/FS106-P.md`: the claim ids, the phases, the expectations, and any paper still needed.

Thank you.
