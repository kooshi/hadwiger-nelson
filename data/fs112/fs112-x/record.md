# FS112-X — the front-page pass for FS-112's close (de Bruijn, Opus 5.5, 2026-09-27)

*Brief `data/fs112/briefs/X112-front-page.md` (e08a33f6) with `data/fs112/briefs/STANDING-RULES.md`. HEAD at launch `e08a33f6`. `CLAUDE.md` at
launch: 296,992 bytes (read from disk). Launched 2026-09-28 ~03:17 UTC.*

## Theorems this phase proved

None — an editing job.

## Would have searched here (standing rule 3)

None — no search was contemplated.

## Stage 1 — SAVED: quotation check, inputs located, gates at launch

**1.1 Quotations in the brief and the standing rules, checked against source** (`grep -cF`, each found once): "From here on out, you may doubt
your ability to", "Don't. You are capable, and you will surprise yourself." (`CLAUDE.md` § Counter-priors); "to eliminate the crutch of feeling like
we're accomplishing something by asking uncomputable problems for days at a time" (§ Toolchain); "search for a finite graph is out. It would be huge,
not feasible." (§ Publication); "A proven theorem about why its impossible is also valid. All novel knowledge is a success" (item 23); "It's ok if
jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress." (`plans/CONSOLIDATION-2026-09-27.md` item 20);
Kooshi's deferral to NIGHT-A, "Even decompressed, this is a bit beyond me, […]. I'll defer to a Poros agent." (inventory item
70); "They seem to require more research and careful exploration" (item 59). All match. Quotations inside the drafts I apply, spot-checked: "got
very close" (`plans/FS112-PA-reading.md` l. 157, `[16.317]`); "realised by FS-110's own fragments" (plan §5.3, E1, l. 545); C2's own checker
`data/fs112/fs112-c2/quotes.py` reads "missing: 0" on its stage-1b quotations. All match.

**1.2 Inputs.** C's drafts: `plans/FS112-unit-arc-half.md` §R-close stage 4 (l. 779–973), with C2's stage-1b versions in place (§R-close
3.0–3.6, 4.1, 4.5–4.7; C2's § Building instance draft is §R-close 4.6's "§ Building (the slot line)"). § B draft
`data/fs112/fs112-c/ledger-b-draft.md` (56 lines). Rulings: inventory item 65 (G83 applied; §R-close 4.8's two FS-110 corrections added to my touch
list), item 70 (NIGHT-A's ranking binds; the ranking waits for the owner's message), item 72 (C-HORNEND and C-DOUBLE filed as derivations at their
grades). C's byte measurement: `data/fs112/fs112-c/drafts.py` (net +1,174 with G83 → 298,166).

**1.3 What waits for the owner's message** (brief item 1b): the paths-forward table (D5), `plans/FRONTIER-STUBS.md`'s ranked rows and its "At FS-112's
close" paragraph, and both files' Open-milestones paragraph (D2: its "Next:" names tonight's milestones, which NIGHT-A decides). Everything else is
applied first.

**1.4 Gates at launch** (exit status read directly): fact audit `--base e08a33f6` exit 0 PASS; `--dupes` 10; `fs71_ledger_b_check.py --strict`
exit 1, FAIL (56) — the 56 FS-112 derivation entries without § B lines, expected; `bib_audit.py` exit 1 — `[Oostema2020]` cited in the plan and
undefined, expected (C's 4.3 adds it); `check_architecture.py` exit 0; `rk_mirror_check.py` exit 0.

## Stage 2 — SAVED: `LEDGER.md`

- **Rows 135–136** inserted after row 134, C's §R-close 4.1 text as it stands after C2's stage 1b (row 136's grade clause from FS112-YB3's
  verdicts; row 135 with FS112-C-HORNEND and FS112-BOWTIE), applied by `data/fs112/fs112-x/apply_ledger.py` (every replacement asserted once).
- **Row 134's corrections** (4.1): its Not-claimed clause now reads "the unit-arc half of Question 2 (Condition 5 dropped: reduced at FS-112, rows
  135–136; FS-114, FS-115)"; § B line FS110-NB-4 gains "; without Condition 5 its general form is FS112-NB4P (NB4′)".
- **§ B:** the 56 lines of `data/fs112/fs112-c/ledger-b-draft.md` appended after FS-110's (one table, no heading, the FS110-X precedent).
- **One change to C's text, for the dupes gate:** with C2's stage-1b wording, `--dupes` read 11 — the run "at a single vertex bounded by unit arcs
  on both [sides]" told in row 135's bold text and again in row 136's Not claimed (C's preview of 10 predates stage 1b). Row 136's clause now points:
  "Y3-END-NEEDS as Y3 stated it (FALSE at the one-vertex end, FS112-BOWTIE; its corrected form is row 135's)" — the same content, one home.
- Gates (exit status read directly): `--strict` exit 0 PASS (1,003 § B rows; FAIL (56) at launch); fact audit `--base e08a33f6` exit 0 PASS;
  `--dupes` 10; `check_architecture` exit 0; `bib_audit` exit 1, the one pre-existing `[Oostema2020]` failure (stage 4 adds its row).

## Stage 3 — SAVED: `CLAUDE.md` (all but D2 and D5), `plans/GROKKING-INSTANCES.md` §G21, the audit's reviewed lines

- **`CLAUDE.md`**, C's §R-close 4.2 as drafted, applied by `data/fs112/fs112-x/apply_claude.py` (the (old, new) pairs read from C's
  `data/fs112/fs112-c/drafts.py`, each new text checked line by line against §R-close 4.2 before writing; every replacement asserted once): **D1** Last
  updated; **D3** § The aim's program line; **D4** item 31; **D6** G72's count (sixteen of nineteen); **D7** G83 before G51 (inventory item 65); **D8**
  G21's FS-81 instance moved out. Also the ledger pointer "Rows 1–134" → "Rows 1–136" (the FS110-X precedent; C drafted none). **Held for the last
  stage** (brief 1b): D2 (Open milestones; its "Next:" names tonight's milestones, NIGHT-A's decision) and D5 (paths forward).
  **Bytes: 296,992 → 298,118** (+1,126; C measured +1,174 for all eight drafts, D2 and D5 carrying the other +48).
- **`plans/GROKKING-INSTANCES.md` §G21** (§R-close 4.6), before "## G30": D8's moved text verbatim (checked against the text D8 removed), headed
  "*FS112-X, moved from G21 at FS-112's close …, after “…named the period 23 at once.”:*", and FS-112's own G21 instance (E1's acceptance test),
  by `data/fs112/fs112-x/apply_gi_g21.py`. The rest of 4.6 is stage 4's.
- **`tools/claude_md_fact_audit.py`, reviewed ALLOW lines** (2 lost tokens, each reviewed): "1–134" — the ledger's row range in the pointer, now
  1–136 (the 1–133 precedent); "131–134" — item 31's row range, now 131–136 (C's D4). A third loss, "83–84", came back when D8's text reached
  §G21 (the audit reads the three files), so it needs no line. C forecast "30–65" too; it is D5's and comes with the last stage.
- **Left (no draft):** the Grokkings header still reads "G1–G81 are stable identifiers" (G82 and G83 exist); C drafted no change, so none is made —
  a correction owed for the owner.
- Gates (exit status read directly): fact audit `--base e08a33f6` exit 0 PASS; `--dupes` 10; `--strict` exit 0 PASS; `check_architecture` exit 0;
  `rk_mirror_check` exit 0 (table untouched); `bib_audit` exit 1, the pre-existing `[Oostema2020]` only.

## Stage 4 — SAVED: `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `plans/GROKKING-INSTANCES.md` (the rest), the protocol, `plans/FS110-derivation.md`

Applied by `data/fs112/fs112-x/apply_stage4.py`, reading C's texts out of §R-close 4.3–4.8 with `data/fs112/fs112-x/drafts_extract.py` (every
replacement asserted once). The owner's ranking message arrived during this stage (2abacbfa, NIGHT-A's §2); it is stage 5's.
- **`BIBLIOGRAPHY.md`** (4.3): `[Polymath2021]` reading column; `[AxenovichEtAl2014]` reading and role columns; `[Polymath16threads]` reading and role
  columns (FS112-PA's Stage 8 item 1, checked verbatim against `plans/FS112-PA-reading.md` l. 258–262); `[Coulson2004]` figures viewed;
  `[Soifer2024]` ch. 18; Kruskal's and Ágoston's rows in FS-110's gate block; a new block, "FS-112's prior-art gate", with C's five rows verbatim
  (`[Oostema2020]` keyed). **Checked against source records:** Ágoston's title, author, DOI and venue against FS112-P's OpenAlex record
  (`data/fs112/fs112-p/thomassen_citing.json`); Oostema's title, authors, DOI, volume and first page against `axenovich_citing.json`, whose last page
  reads 355 (a defect of the record), so "389" is unchecked — said in the block's head line. **Two changes beyond C's "add", for current state:**
  Axenovich's reading column said "§3–§4 not read", now "§3 and the rest of §4 not read"; its role column began "**Nothing of ours rests on it; it
  blocks a novelty claim.**", now "**Row 136 rests on it: the one exact six-coloured strip with unit arcs, FS-112's calibration. Otherwise it blocks a
  novelty claim.**" (C's role text inside).
- **`CLOSED-QUESTIONS.md`** (4.4): §3's sentence after "…FS-112 is silent." as drafted. **§2.8's sentence placed after the Not-answered list's last
  item** ("…boundaries other than segments and circular arcs.") rather than between its two items, where C's anchor put it, so the list stays whole;
  the text is C's.
- **`plans/GROKKING-INSTANCES.md`** (4.6): §G51 — FS-112's run, the quote-verbatim instance, the fence instance, each under an "*FS112-X, …*" line
  after FS-110's; §G72 — nineteenth; §G79 — FS-112; **a new section "`CLAUDE.md` § Building — RAM is the discriminator (`scripts/slot.py`)"** for C2's
  slot-line instance (no section for that rule existed).
- **The protocol** (4.7): rule 12 extended, rules 13 and 14 added; §3's eleventh run before "The next use", laid out as the tenth run is (records;
  a bullet for the rounds' objects; a bullet "**The run** (FS112-C, §R-close 3.1, 3.4, 4.6):" carrying 4.6's G51 text in place of C's "4.6's G51 text").
- **`plans/FS110-derivation.md`** (4.8; inventory item 65): FS110-NB-4's general form read as FS112-NB4P — "`ω(y)` or" deleted, the orbit-point clause
  added, and "through a change point" written "with a change point … in its closure" (C's "through" → "in the closure of", in the direction NB4P
  states: the change point lies in the arc's closure); FS110-CE5's note added after its proof verdict.
- **Left (no draft):** CLAUDE.md's slot rule (§ Building, "RAM is the discriminator") has no pointer to its new instance section; none added.
- Gates (exit status read directly): fact audit `--base e08a33f6` exit 0 PASS; `--dupes` 10; `--strict` exit 0 PASS; **`bib_audit` exit 0 PASS**
  (exit 1 at launch); `check_architecture` exit 0; `rk_mirror_check` exit 0.
