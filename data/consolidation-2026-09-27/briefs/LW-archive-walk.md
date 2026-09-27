*Brief for job **LW**: the Geombinatorics archive walk. Opus 5.5, 2026-09-27. Written by the product owner. **Sized for about 400k tokens by the
harness's count. Your own count runs at 55–70 % of it, so hand back with your catalogue and record saved when your own count reaches about 230k;
a successor continues from them.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first.** Then read from disk: `plans/CONSOLIDATION-2026-09-27.md` (the run, the archive's shape, and Kooshi's
words); `CLAUDE.md` § The aim (links 1–6), § Counter-priors, § Where the problem stands, § Paths forward, and G49, G50, G82; `LEDGER.md` rows
128–134; `plans/STUB-unit-arc-half.md` (FS-112) and `plans/STUB-reg-scale.md` (FS-111); `CLOSED-QUESTIONS.md`'s headings and §3.

## Why this job exists

Kooshi, 2026-09-27, on the journal whose archive became accessible: *"Additionally, this whole journal is one of the most rich
authorities on what we've been looking for, perhaps with the exception of where the domain landed, but look around the recent articles for
anything that might be useful."* The next milestone is FS-112, the unit-arc half — *"unless something comes up from the prior art"*. This walk
is that prior-art pass, over the journal as a whole.

**Held:** the 45 full issues from vol. 25 no. 2 (October 2015) to vol. XXXVI no. 1 (July 2026) are in `~/source/library/geombinatorics/` as
`geomb-issue-<issue id>-<galley id>.pdf`, each with a text layer (`pdftotext -layout`); the issue ids and titles came from the archive's listing
(`tools/geomb_fetch.sh archive` prints it; no login needed). A separate job, LP, is reading `[Johnson2000]`, `[Johnson2006]`, `[BendaPerles2000]`
and `[Townsend2005]` and the older issues holding them (vol. IX nos. 3–4, vol. XIV no. 4): leave those four papers to it.

## The task, in stages (save after each)

1. **The catalogue.** Rename each held issue to `geombinatorics-v<vol, two digits>-n<no>-<yyyy>-<mm>.pdf` (the form of the three already
   renamed), and write `~/source/library/geombinatorics/CATALOGUE.md` with a copy committed at `data/consolidation-2026-09-27/lw/catalogue.md`:
   per issue, every article's title, authors and pages, read from the issue's own contents page. Cross-check against zbMATH's index of the journal
   (`https://api.zbmath.org/v1/document/_search` with `search_string=so:Geombinatorics & py:2015-2026`, 173 records, `results_per_page=100`;
   `curl -G --data-urlencode`), and note articles either lists and the other lacks.
2. **Flag and read.** Flag every article in the catalogue that bears on any of the following, then read each flagged one in full (the text layer;
   figures by rendering the page), recording its statements verbatim with page numbers:
   - **the direction** (`CLAUDE.md` § The aim): measurable, Borel, closed, polygonal, map, tiling, Jordan-region or otherwise regular colourings
     of the plane; colourings that avoid a band of distances `[1−ε, 1+ε]` or "almost unit" distances; stability of any of these; tight six-maps,
     tangencies, unit-arc boundaries, cusps, bowties (FS-112), junctions and their scale (FS-111); `χ_m`, the fractional and measurable chromatic
     numbers, `m₁(ℝ²)`; Sokolov–Voronov, Voronov, Parts, Townsend, Coulson, Woodall, Thomassen, Currie–Eggleton, Exoo, de Grey;
   - **the lower bound's machinery**: de Grey's graph and its descendants, five- and six-chromatic unit-distance graphs, two-distance graphs;
   - **the algebraic direction** outside LP's four papers: planes over rational points or number fields, `ℚ(√m)²`, residue or additive
     colourings;
   - **open problems and conjectures** the journal posed (Soifer's, Johnson's, de Grey's, anyone's) that a `LEDGER.md` row answers or bears on.
3. **Older issues, by index.** Pull zbMATH's full listing of the journal for 1991–2015 (its titles and review text), flag by the same list, and
   fetch (through the wrapper, standing rule 8, into `~/source/library/geombinatorics/` under the same naming) and read the issues holding the
   flagged articles, most bearing first, until your budget line. List the rest as ranked debts.
4. **Fold in, and report.** For each article read: what it proves, at what grade in print (proof, sketch, claim), and its bearing on our rows and
   stubs — does it **pre-empt** a result of ours (the attribution moves), **answer or sharpen** an open stub, or **pose** a question a row of ours
   answers? `BIBLIOGRAPHY.md`: add a new section, "§ G. The Geombinatorics archive walk (2026-09-27)", before § D, with one row per article read or
   flagged (key, full citation with volume, issue and pages, what bears, file, read status), and a pointer line to it from § B; never edit an
   entry LP owns (`[Johnson2000]`, `[Johnson2006]`, `[BendaPerles2000]`, `[Townsend2005]`, § R). Everything else — `CLOSED-QUESTIONS.md` rows,
   `LEDGER.md` attribution changes, `CLAUDE.md` lines, stub banners — as drafts in your record for the owner. Run `python3 tools/bib_audit.py`,
   exit status read directly.

**The report's first section is "Bearing on FS-112 and FS-111"**: whether anything read changes what the unit-arc milestone should do or
whether it opens first — in the four-part form (the choice, an alternative, why, confidence), with the article's words quoted. Nothing found is a
finding: say what was searched.

## Rules

- **Touch only:** `~/source/library/geombinatorics/` (renames, fetched issues, `CATALOGUE.md`), `BIBLIOGRAPHY.md` (§ G and its pointer line only),
  and `data/consolidation-2026-09-27/lw/`. Everything else by draft in your record.
- **Record:** `data/consolidation-2026-09-27/lw/record.md`, with a heading "Theorems this phase proved" (normally empty for a walk: a check you make
  of a printed proof is one).
- **Hold anything answer-moving at one mind** and say so: a printed six-colouring of a class the direction cares about, or a printed proof that
  would decide a stub, goes to the owner by SendMessage at once, before your next stage.
- Commits by explicit path, subjects "LW: stage n". Never amend; push after each; never force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/LW.md`, committed, and by SendMessage to `"main"`, with: the bearing on FS-112 and FS-111;
  every article read with its verdict; the CLOSED-QUESTIONS and ledger drafts; the debts left; each gate's result. Your final turn's text: "LW
  idle; report sent to the owner by SendMessage".

Thank you.
