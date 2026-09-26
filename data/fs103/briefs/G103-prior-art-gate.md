*Brief for job **FS103-G**: the prior-art gate for FS-103, the collapse (WORKFLOW 3.2). Opus 5.5, 2026-09-26. Written by the product owner.
**Sized for about 200k harness tokens.** A planner (FS103-P) and an advisor (FS103-A) work beside you; you do not need to contact them.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`, as a reader. **`data/fs103/briefs/STANDING-RULES.md` is part of
this brief; read it in full.** Your procedure is WORKFLOW 3.2's eight items and `CLAUDE.md` G49 and G50; read them from disk. Read the stub
`plans/STUB-collapse-cp-plane.md` in full: its "What the milestone must do" item 2 is your starting query list. **When the planner commits
§PA.0 of `plans/FS103-collapse-cp-plane.md`** (check `git log -- plans/FS103-collapse-cp-plane.md` at each stage), read that section and add
its queries. Your record becomes the plan's §PA.

## Why

The candidate: given MR (`LEDGER.md` row 120) and T-J39-3, at a real field with no non-thick stable place — de Grey's field
ℚ(√3,√5,√7,√11) is the instance to publish — `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`. Here `χ_CP(ℝ²)` is the least `k` admitting a translation-invariant
random `k`-colouring of the plane, continuous in probability and proper for every unit pair almost surely (the stub quotes the definition
verbatim). Kooshi (2026-09-26): *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a
writeup."* The gate decides both whether the collapse is already in print and which known problem it would collapse HN to. A 1994
proceedings paper held Theorem B's value for thirty-two years (G49), so run this gate as if the answer might be in print already.

## Questions (record each answer with its sources and a reading status per section; a negative names its queries)

1. **The question itself.** Is it known, proved or conjectured in print that the chromatic number of the plane equals:
   - its measurable version `χ_m` (Falconer 1981);
   - its Borel version `χ_B`;
   - the least number of colours of a stationary (translation-invariant) random colouring;
   - the chromatic number of the plane over a single countable subfield?

   Where is `χ = χ_m` stated as open (Soifer's book, Kechris–Marks Example 5.1, Shelah–Soifer)? Are there known consequences of it that would
   become consequences of the collapse?
2. **`[Falconer1981]`.** Fetch and read it (it is unheld; JCTA 31 (1981) 184–189). Our route notes are in
   `~/.claude/projects/-home-kooshi-source-lean-dir/memory/paper-fetch-routes.md`. Record exactly what it proves (`χ_m(ℝ²) ≥ 5`), by what
   method, and whether its argument is stated for sets that are measurable, or proper almost everywhere, or proper everywhere.
3. **Where `χ_CP` sits.** Is anything in print about random or stationary colourings of `ℝⁿ` avoiding a distance? Search on factor of IID,
   Følner averaging of colourings, "continuity in probability", Doob's measurable modification, and measurable versions proper everywhere
   versus almost everywhere. Also the harmonic-analysis line (`[OliveiraVallentin2010]`, `[BachocEtAl2009]`/`[BachocEtAl2014]`,
   `[AmbrusEtAl2023]`, `[DeCorteOliveiraVallentin2022]`): does any of it define a colouring number between `χ` and `χ_m`?
4. **The posers' complete author listings** from the zbMATH Open API (WORKFLOW 3.2 item 8): at least Falconer, Soifer, Shelah, Kechris,
   Marks, Oliveira Filho, Vallentin and Bukh, plus any the planner's §PA.0 names. Each run in their own vocabulary against abstracts, with
   the queries recorded.

## Stages

1. The `BIBLIOGRAPHY.md` and `~/source/library/` grep (arXiv ids and Zbl numbers) for everything above; the Falconer fetch; the zbMATH
   author listings. Save.
2. Question 1, then question 3 (the question itself first: it decides whether the milestone is a verification or an attribution). Save.
3. Question 2's reading, and the planner's §PA.0 queries if they are not yet run. Save; the report, with proposed `BIBLIOGRAPHY.md` and
   `CLOSED-QUESTIONS.md` rows in your record.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- Reading and fetching are in; no finite-witness search (the ban). An abstract is not a reading; mark every item's status.
- **Record** `plans/FS103-G-prior-art.md`; fetched PDFs under `data/fs103/fs103-g/` (proposed for `~/source/library/`). Touch nothing else.
- **Commits:** by explicit path, subjects "FS103-G: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-G.md`, committed, and by SendMessage to "main". **If question 1 finds the collapse,
  or `χ(ℝ²) = χ_m(ℝ²)`, or any single field attaining `χ(ℝ²)` in print, send the owner one line at once**, before finishing. Final turn text:
  "FS103-G idle; report sent to the owner by SendMessage".

Thank you.
