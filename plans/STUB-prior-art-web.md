# FS-23 — Solidifying the knowledge web, and aligning our vocabulary with the literature's

*Minted 2026-09-09 by de Bruijn at Kooshi's direction, immediately before a compaction. His words:
**"the goal will be to continue reading unread papers and solidifying our knowledge web within the prior art,
and potentially updating our vocabulary to match theirs where it makes sense."** This file is the handoff: it
assumes a reader with **zero conversation memory** and tells them what to do, why, and what not to break.*

---

## 0. Why this exists — the one-paragraph history a fresh session needs

This repository attacks the **Hadwiger–Nelson problem**: how many colours are needed to paint the plane so no
two points exactly one unit apart share a colour? (Known to be 5, 6, or 7.) Over four milestones it built a
theory of the problem **over number fields** — instead of the real plane, the plane whose coordinates lie in a
field like `ℚ(√3,√11)` — and proved, machine-checked, that **that plane needs exactly four colours**
(`Proofs/HadwigerNelson/FieldWall4.lean`; the project calls it "Theorem B"). Then two literature passes found
that **the central reduction had been derived independently six times in five decades by six groups in four
literatures that do not cite one another**, and that the exact value we computed answers a question posed or
named **six times** across those literatures without any of them noticing each other.

That discovery produced two standing rules — `CLAUDE.md` § Grokkings **G49** (recognition is half the rule; the
other half is a search) and **G50** (read what the search already found; an unread paper on your own shelf is a
debt) — and a workflow step (`WORKFLOW.md` **step 3a**, the prior-art gate). **This milestone is the
consolidation those rules imply.** It is not a hunt for a theorem; it is making the project's map of the
literature true, and making the project's language legible to the people who own the subject.

## 1. What is already done — do not redo it

* **FS-18 (2026-09-08) read the library**: 21 works read, 5 corrections to our own record, one external
  conditional discharged, one published numerical error found. Its record is `plans/STUB-library-read.md` §R.
* **The FS-20 prior-art repair (2026-09-09)** re-ran the "is the exact value known?" check properly after the
  first run characterised a held paper by its abstract. Record: `plans/STUB-theorem-B-writeup.md` §1. Its method
  is now `WORKFLOW.md` step 3a sub-rules 5–7 and should be the template here.
* **A bibliography key audit (2026-09-09)** found and fixed three dangling citation keys; **zero remain**. The
  check is cheap and worth re-running at the end of this milestone:

  ```
  # keys defined in BIBLIOGRAPHY.md vs keys cited anywhere in CLAUDE.md and plans/
  python3 - <<'EOF'
  import re, glob, collections
  defined = {m.group(1) for m in re.finditer(r'\*\*\[([A-Za-z0-9]+)\]\*\*', open('BIBLIOGRAPHY.md').read())}
  used = collections.Counter()
  for f in ['CLAUDE.md','WORKFLOW.md','ARCHITECTURE.md'] + glob.glob('plans/*.md'):
      for m in re.finditer(r'\[([A-Z][A-Za-z]+\d{4}[a-z]{0,3})\]', open(f).read()): used[m.group(1)] += 1
  print({k: v for k, v in used.items() if k not in defined} or "no dangling keys")
  EOF
  ```

## 2. Phase A — the reading debts, exactly (they are short)

`BIBLIOGRAPHY.md` § D rules 0b–0e are the authority; this is the list as of 2026-09-09.

**Held on disk and unread — read these first, they cost an hour each:**

| key | file | why it matters | the question to read it against |
|---|---|---|---|
| `[Heule2019]` | `library/pdf/arXiv-1907.00929-heule-529-trimming.pdf` | the 529-vertex witness and its trimming method | our G8 "shrinking scars" reading says SAT-shrinking leaves residue directions outside the construction group — does his method explain that, and what field do his coordinates lie in? (`[ExooIsmailescu2019]` says his 826-vertex graph is in `ℚ[√3,√11,√5]`; check against our record of Heule-510) |
| `[Parts2023]` | `library/pdf/arXiv-2303.14722-more-certainty-interval.pdf` | M43 draws **conditional** consequences from it and cited it under a key that did not exist until 2026-09-09 | what exactly does he prove about forbidden-distance *intervals*, and does it discharge M43's remaining conditional the way `[Voronov2023]` did? |
| `[Agoston2026]` | `library/pdf/arXiv-2601.07828-agoston-two-distance-range.pdf` | two-distance graphs — the μ-dial's own neighbourhood (M49/M50) | does anything there bear on `μ(d)`, the fewest `d`-edges of a non-5-colourable `{1,d}`-graph? |

**Not held, ranked (`BIBLIOGRAPHY.md` § D 0d).** `[Johnson2006]` (the compendium of this exact algebraic
direction — **the highest-value unobtained item, and the one most likely to contain further number-field prior
art**), `[Fischer1990b]` (the multiquadratic components paper, on exactly our fields), `[Johnson1987]`,
`[BendaPerles2000]` (the source of the open problem), `[MMST1996]` (still second-hand — the Kloosterman identity
is verified numerically here and never against the paper), `[Coulson2004]`, `[Townsend2005]`. **These need a
library or an interlibrary loan, not a fetch**; the library's notes holds the standing
request. `[DeNeve2025]` is paywalled and stays at abstract. The Raigorodskii Borsuk survey is held but Russian
with no OCR run.

**§C of the bibliography is a liability, not an archive (rule 0c).** It lists ~20 titles seen only in search
listings. Twice a §C row has turned out to be exactly the prior art for a milestone running at the time, once
under a note that had *correctly guessed so*. **Sweep §C in this milestone**: for each row, either fetch and
scan it, or write one line saying why it cannot touch anything we do.

## 3. Phase B — the knowledge web

The goal is a map that is **true**, not merely full. Three concrete deliverables:

1. **Verify every load-bearing attribution against the source PDF**, the way the FS-20 repair verified Madore's
   Props. 3.2/3.8/3.9/4.6 and Moorhouse's Prop. 1.4(b) on 2026-09-09. `BIBLIOGRAPHY.md` § A is full of claims
   of the form "*X* is [Author]'s Theorem *n*". **Each one that something of ours rests on gets opened and
   quoted.** A wrong credit is the one error a unification paper cannot apologise away.
2. **Draw the citation graph of the six lineages** — who cites whom among Fischer / Moorhouse / Manturov /
   Madore / the finite-field side (MMST → Vinh → Schneider–Silva → Krebs → Lorenz–Zimmermann) /
   Bardestani–Mallahi-Karai — and record the edges that *do not exist*. FS-20 §2 asserts they mostly do not; the
   graph makes it checkable, and it is the paper's central evidence.
3. **Re-run the FS-20 §1 searches once more before submission** (they are cheap and the manuscript rests on
   them), using step 3a sub-rules 5–7: walk the citations of the paper that **posed** the question, open every
   neighbourhood title rather than characterising it, and cross-check two citation databases — OpenAlex and
   Semantic Scholar disagreed fourfold on the same paper.

## 4. Phase C — vocabulary, and the decision I recommend against making carelessly

**The problem is real.** Every working term here is coined in-house and appears in no paper: *field wall*,
*5-sealed*, *seam plane / seam field / seam group*, *the descent*, *the dial*, *cheats*, *pigeonhole × kill*,
*Theorem A / Theorem B*, *the ladder*, *the hexagram*, `G1…G51`. G49 names this as **the mechanism that hid the
prior art from us**: a private vocabulary is an excellent instrument for thinking and a perfect filter against
discovering you are not first.

**And the literature has already had one of these arguments without us.** `[Parts2020a]` §2, verbatim:

> *"A non-mono pair that does not define an edge has sometimes been termed a **virtual edge**, but in our
> opinion, this term is not entirely successful, since it does not clearly express whether one means a mono- or
> non-mono-pair, which leads to confusion."*

We use "virtual edge" in almost every milestone. His terms — ***mono-pair***, ***non-mono-pair***, ***spindle***
(*"a cycle of two mono-pairs and a unit edge"*) — are published, are the two-distance community's, and are
**better**, because they name the polarity, which is exactly the distinction the 2-adic law of four-colour
compulsions turns on (ledger row 59).

**THE DECISION, and my recommendation.** Kooshi said *"potentially updating our vocabulary to match theirs
**where it makes sense**"*, and the qualifier is load-bearing.

| option | case for | case against | my call |
|---|---|---|---|
| **A translation table, plus adoption in new writing** — add a glossary to `BIBLIOGRAPHY.md` mapping every coinage to the literature's term with its source; use the literature's term in all *new* prose and in the paper; leave the historical record alone | The coinages are load-bearing across ~3,500 lines of `CLAUDE.md` and ~90 plan files, all cross-referenced. A global rename breaks every back-reference and rewrites the record of what we believed when — which this project's own rules forbid (*amend in place, never silently rewrite*). And G49's diagnosis is about **publication** vocabulary, not thinking vocabulary | Two names for one thing, for as long as the old files live | **RECOMMENDED — high confidence** |
| **Global rename** across the repository | one vocabulary, no ambiguity | destroys cross-references and the historical record; enormous diff; high risk of silent breakage in a corpus where prose *is* the artifact | no |
| **Change nothing** | zero cost | leaves the exact mechanism G49 blames for the duplication fully armed, and leaves the paper's terminology decisions unmade | no |

**Where adopting theirs plainly makes sense** (start here): *virtual edge* → **non-mono-pair**; *mono pair* →
**mono-pair** (already theirs); *cheats* → **non-unit edges** or **`d`-edges**; *seam plane* → **`K²`**;
*the finite-plane bound* → say the statement, per FS-20 §4 decision N2 (**do not name the criterion at all** —
Fischer, Madore and Bardestani–Mallahi-Karai all leave it unnamed, and naming it obscures that they are the
same condition). **Where ours should survive**: terms naming objects nobody else has (*the direction ladder*,
*the hexagram*, *the arity floor*, *the μ-dial*) — but each gets a one-line gloss in the glossary saying what
the nearest published term is, or that there is none. **Note `[Aggarwal2025]` calls our direction ladder the
"Moser Lattice"** — that is a published name for one of our objects, found 2026-09-09.

The paper's own naming decisions (N1–N5) live in `plans/STUB-theorem-B-writeup.md` §4 and should be settled in
this milestone, since they need exactly this reading.

## 5. Method, acceptance, and stop rules

* **Run under `WORKFLOW.md` step 3a's discipline** — it is now seven sub-rules, three of them added on
  2026-09-09 from the FS-20 repair's own failure.
* **Every finding lands in `BIBLIOGRAPHY.md` the same day**, with the read column telling the truth about *what*
  was read (Table 1 and §6, not "read") — the honest granularity FS-18 used.
* **Corrections to our own record go in place, with a banner, never by deletion**, and a ledger row or grokking
  that changes gets its correction marked where it is, not in a new note elsewhere.
* **Acceptance:** zero dangling keys; §B and §C empty of unread items or each row carrying a written reason it
  cannot matter; every § A attribution that something of ours rests on quoted from its source; a glossary
  section in `BIBLIOGRAPHY.md`; FS-20 §4's N1–N5 settled.
* **Stop rules:** an interlibrary-loan item is *not* a blocker for anything but the paper's submission — record
  it and move on. If a paper turns out to contain one of our results, **stop and write the correction before
  reading further**; that is what FS-18 did five times and it is why its record is trustworthy.
* **This milestone touches no Lean.** If it somehow does, the gate is `./scripts/build.sh` then
  `./scripts/axioms.sh` — **never `lake build`, bare or named** (`CLAUDE.md` explains what that cost twice).

## 6. Cost and bearing

**Cost:** two to four days, no compute, no Lean. **Bearing on χ(ℝ²) ≥ 6: none directly** — and the stub says so
plainly, as every stub here must. It is ranked on three other grounds: it is the prerequisite that stops G49
firing a fourth time; it is what the paper (FS-20) needs before submission; and the vocabulary work is what
makes any future result of this project *findable* by the people who have been asking its questions for fifty
years. **M62 (FS-6, the design target in a 5-sealed field) remains the ranked rank-1 milestone for the hunt
itself and is untouched by this.**

---

# §R — RESULTS, 2026-09-09 (one day; phases A and C done, B partly)

**Kooshi's amendment at the go:** *"I agree we should not wholly rewrite our history with the terms of the
literature, but we should replace any where the scope is small and our chosen term might lead to confusion.
Otherwise, carry on in making our knowledge graph as rigid as we want our unit graphs!"*

## R1. Phase A — the reading debts, discharged

| paper | verdict against its registered question |
|---|---|
| `[Heule2019]` | **Read in full.** His §5 is titled *"Observed patterns of points in `Q[√3,√11] × Q[√3,√11]`"* — he names `K` in 2019 and says `G553`'s 420-vertex large part lies in `K²`. His §6.2 states **pigeonhole × kill** as a design principle (G15 amended). **"virtual edge" is his published term, not ours.** Two of his three observed colouring regularities are instances of ledger row 59's law, recorded there as unexplained. G8's "shrinking scars" reading is neither confirmed nor refuted, and now has a sharp test |
| `[Parts2023]` | **Read in full.** Does **not** bear on M43's conditional (already discharged at FS-18). Its value was its reference list: it is the door to `[deGreyParts2022]`, and hence to the cell family's prior art |
| `[Agoston2026]` | **Read.** Does **not** bear on `μ(d)` — a realizability paper, not a colouring one. Free: Bukh's conjecture, Maehara's theorem, and the `d ↦ 1/d` range inversion. Author's initial corrected at source (P., not G.) |

**Also read, none of them on any list before today:** `[deGreyParts2022]`, `[PartsOdd2022]`, `[Ducz2026]`,
`[MatolcsiEtAl2025]`, `[Polymath16wiki]`; scanned `[ChybowskaSokol2022]`, `[DuczVarga2026]`, `[Davies2024]`,
`[Parts2022]`. Named-only rows added for `[Heule2021]`, `[Ardal2009]`, `[Exoo2005]`, `[Ivanov2007]`,
`[Lonc2007]`, `[Bukh2008]`, `[Maehara1991]`, `[Schaefer2013]`, `[Parts2021]`, `[Hubai2018]`,
`[AmbrusEtAl2024]`. **Twenty entries, in one day, and the whole chain was four references deep.**

## R2. The two corrections, and the seventh lineage

1. **Ledger row 59's identification half is `[Ducz2026]` (10 June 2026)** and one instance is
   `[Polymath16wiki]` (4 June 2018). What survives is delimited in the row and the row is **stronger**:
   `[Heule2021]` asks for this theorem in print, and it now sits inside a classification conjecture.
2. **The cell family (rows 34–37, 39; G22–G24) was studied from the dual direction** by `[deGreyParts2022]`
   in 2022, agreeing with our band boundaries at three points. What survives is arbitrary labels, measured:
   twelve colours their way against seven ours on the G\* band.
3. **`[Polymath16wiki]`, the seventh lineage** — the Cayley reframing, linear colourings, the periodic
   quotient, Theorem A's recipe, the Moser ring's 4-colourability, `8/3` monochromatic, the `√247` spindle,
   and the half-spindle group derived by UFD factorisation. Rows 26, 47, 57, 59 and G8 amended.

## R3. Phase C — the vocabulary decision, settled

`BIBLIOGRAPHY.md` **§E** is the translation table. Applying Kooshi's criterion (**narrow scope AND real
confusion**):

* **Replaced: *direction ladder* → *Moser lattice*** (25 uses; three independent published sources; and
  "ladder" already names M24's *matched ladder pair*). Tool output updated, `T13` keeps its title with a gloss,
  closed milestone records untouched.
* **Not replaced, and the reasons are on the record**: *virtual edge* (it was never ours — `[Heule2019]`'s), so
  keeping it is the correction; *cheats* (817 uses — not narrow, and the paper will say `d`-edge anyway);
  *field wall / 5-sealed* (no published counterpart, and FS-20 N2 already forbids naming the criterion in the
  paper).
* **The sharpest single fix**: the literature indexes the spindle rotation by the **squared** distance
  (`ω_t = spindleRot √t`), so their `ω₄` is our `spindleRot 2`. A `--` note is now in `Copy.lean`.

## R3b. FS-20's R6, discharged the same day — the eighteen Polymath16 threads

All eighteen fetched and searched (**1,673,859 characters**, April 2018 – January 2026; archived to
`library/notes/polymath16-threads-1-18-text.txt`). Full record in `plans/STUB-theorem-B-writeup.md` §1d. The
short form: **the Theorem B question is posed there on 2 May 2018 in our exact notation and is never answered**
— every four-colouring result in eight years is about the rank-4 *ring*, never the field plane — and
**"Fischer", "Moorhouse" and "Vinh" occur zero times in the entire corpus** while "Woodall" occurs in four
threads and "Madore" in one. Two more gifts: the residue colouring conjectured for UFDs in the first thread
(April 2018, an eighth independent statement of the reduction), and the 2018 question *"does `5/3` receive the
same colour as `0` in every 5-colouring of `R`? … a spindling argument implies `χ ≥ 6`"*, **which is FS-6/G48's
design target posed eight years early and which M60's residue law answers in the negative.**

## R4. What is left

* **Phase B, deliverable 2 — the citation graph of the seven lineages.** Not drawn. The evidence for "they do
  not cite one another" is now much stronger (three more non-citing sources) but it is still assertion.
* **Phase B, deliverable 1 — verify every load-bearing §A attribution against its PDF.** Done for the four
  Madore propositions and one Moorhouse (FS-20, 2026-09-09) and for everything read today; the older §A rows
  that rest on `[Fischer1990]` and `[Moorhouse2010]` are **not** re-verified.
* ~~FS-20's R6~~ — **done, see R3b.**
* The key audit's regex misses keys with digits inside the name (`[Polymath16wiki]`); widen it before relying
  on it again.

