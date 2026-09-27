# FS107-X — the front-page pass for FS-107's close (de Bruijn, Opus 5.5, 2026-09-27)

Brief: `data/fs107/briefs/X107-front-page.md` (+ `STANDING-RULES.md`). Launch HEAD `66f1f51a`. Drafts: `plans/FS107-stability.md` §R-close 4.1–4.6.
Owner rulings applied: inventory item 36 (FS-110 rank 1, FS-111 rank 2, above FS-104 — C's recommended ranking, so no alternative to choose between).

## Theorems this phase proved

None — an editorial job.

## "Would have searched here" log

None — no search is in scope.

## Stage 1 — SAVED: quotations, baseline gates

**Quotation check (standing rule 5).** Every quotation in the brief and the standing rules checked against its source with `grep -F`:
- "From here on out, you may doubt your ability to tackle …", "Don't. You are capable, and you will surprise yourself.", "A proven theorem about why
  its impossible is also valid. All novel knowledge is a success", "to eliminate the crutch …", "search for a finite graph is out. It would be huge,
  not feasible." — each once in `CLAUDE.md` (§ Counter-priors, item 23, § Toolchain, § Publication). Verbatim.
- WORKFLOW step 9's "File new instances out of `CLAUDE.md`" — once in `WORKFLOW.md`. Verbatim.
- The launch message's "item 36 — FS-110 at rank 1, FS-111 at rank 2, above FS-104" (not in quotation marks) matches inventory item 36.
- "`CLAUDE.md` is at about 299,242" and "about 299,438" match `wc -c` and `data/fs107/fs107-c/budget_sim.py`'s output (before 299,242, after
  299,438, margin 562).

**Baseline gates at launch HEAD `66f1f51a`** (exit status read directly):
- `claude_md_fact_audit.py --base 66f1f51a`: exit 0, AUDIT PASSED.
- `--dupes`: exit 0; 10 repeated runs, 628 B (the limit is "not above 10": no headroom).
- `fs71_ledger_b_check.py --strict`: exit 1, FAIL (18) — 14 FS107 entries without § B rows (stage 2 clears them), and 4 of C's entries lacking fields:
  K-C6 and K-BICH (*Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*), K-AD (*Proof:*, *Rests on it:*, *Prior art:*), MEET (*Proof verdict:*,
  *Prior art:*). **And two headers are silently unparsed:** `FS107-R-OB′ (corrected) —` (a ′ in the id; a parenthetical before the dash) and
  `FS107-V-C5 (observation) —` (a parenthetical before the dash); `near_misses` misses both (its id pattern also stops before `(`). C's § B draft
  lists both ids; applied as drafted they would add two FAILs. Sent to the owner at once (SendMessage, stage 1); the derivation file is outside my
  touch list.
- `bib_audit.py`: exit 0, PASS. `check_architecture.py`: exit 0, PASS.

**The simulation.** `budget_sim.py`'s output diffs against `CLAUDE.md` exactly in 4.2's places (program paragraph, "Last updated", item 31, "Open
milestones", paths-forward rows 1–30 and the bucket, G72's count, G82); every other `FS-107` mention in `CLAUDE.md` lies inside those spans.

## Stage 2 — SAVED: `LEDGER.md` and the derivation file (the owner's grant)

**The owner's grant** (message to FS107-X, 2026-09-27, after stage 1): the touch list gains `plans/FS107-derivation.md` for six entries — K-C6,
K-BICH, K-AD, MEET, FS107-R-OB′ and FS107-V-C5: fill the missing fields from the sources, pointing by address, "none recorded" where a source is
silent; make the two headers parse with an ASCII id and no parenthetical before the dash, the old name kept in the text, the same ids in the § B
lines and row 133; no nested brackets in any grade.

**`plans/FS107-derivation.md`, applied:**
- `**FS107-R-OB′ (corrected) —` → `**FS107-R-OB2 — (FS107-R-OB′, corrected)`; `**FS107-V-C5 (observation) —` → `**FS107-V-C5 — (observation)`.
- K-C6: *Proof:* (FS107-A l. 16–19, "trivial", no proof text recorded), *Proof verdict:* (§R-close 1.3 l. 574, quoted), *Rests on it:* (R-CP; R's
  registered part (2), A2 l. 265–267, quoted; W-orient, FS107-A l. 88–92), *Prior art:* none recorded (FS107-A; the plan's §PA l. 366–396).
- K-BICH: *Proof:* (FS107-A l. 20–23, quoted), *Proof verdict:* (l. 575), *Rests on it:* (FS107-A l. 72–73 and l. 91–92, quoted), *Prior art:*
  none recorded.
- K-AD: *Proof:* (FS107-A l. 12–15, quoted; the grade split l. 175–177), *Rests on it:* (FS107-A l. 70; the plan's E7, l. 481, quoted),
  *Prior art:* none in print (§PA checked); in-house TQ §4.4's dichotomy (FS107-A l. 15, quoted).
- MEET: *Proof verdict:* (§R-close 1.3 l. 578, quoted), *Prior art:* none recorded (A2 §5.1; §PA).
- The §PA (plan l. 366–396) was grepped for C6, BICH, anchors, junctions and the meeting point before "none recorded" was written: no hit.

**`LEDGER.md`, applied from §R-close 4.1 verbatim** (extracted by script from its two code blocks, 1 row + 16 lines asserted):
- row 133 after row 132, its id list's `R-OB′` → `R-OB2` (the owner's grant);
- row 131's two corrections in place (mechanism sentence; prior-art clause), each anchor asserted unique;
- the 16 § B lines after FS106-PDEQ, `FS107-R-OB′` → `FS107-R-OB2`.

**Gates on the stage's tree** (exit status read directly): § B `--strict` exit 0, PASS (898 entries, 898 rows; FS107 = 16); fact audit
`--base 66f1f51a` exit 0, AUDIT PASSED (LOST 0 in every class); `--dupes` 10 (unchanged); `bib_audit` exit 0; `check_architecture` exit 0.

## Stage 3 — SAVED: `CLAUDE.md` (§R-close 4.2) and the audit's reviewed lines

**Applied** by running `data/fs107/fs107-c/budget_sim.py` to a copy (its output byte-identical across two runs) and copying it over `CLAUDE.md`,
after checking every text the script inserts against 4.2 (the blockquotes with `> ` stripped, the code block's rows 1–2, G72's line): all seven equal.
So: "Last updated", the program paragraph, item 31, "Open milestones", paths-forward rows 1–2 new (FS-110, FS-111 — the owner's item 36), old ranks
2–28 renumbered 3–29 with 4.2's two in-row edits (FS-104, FS-109), FS-98 (old 29) into the bucket `30–64`, G72's count, G82 with its demotion record.

**One edit beyond the drafts, decided here** (0 bytes): "**Rows 1–130 live in `LEDGER.md`**" → "Rows 1–133": the pointer was stale since FS-106's
close (rows 131–132 exist) and a current-state fact. Alternative: leave it for the owner as a correction owed — it would have stayed false in the one
file every session loads. Confidence high.

**Gates, first run: FAIL (9).** Lost tokens `plans/STUB-ultrametric-continuation.md`, `J38`, `J38's` (FS-98's row, now in the bucket), `§ FS` (the
address "`plans/STUB-regularity-wall.md` § FS-107"), `δ₀`, `δ₀|U_R` (FS-107's rank-1 row, claim R), `1–130`, `30–63`; G82's status tag changed.
`--dupes` 11: C's two drafts told "must count a defect at a scale independent of `ε` — spread over positive measure, or at features whose" twice
(G82 and row 131).

**Repairs:**
- row 131's corrected mechanism reworded, content unchanged: "at a scale independent of `ε` — spread over positive measure, or at features whose
  scale is bounded below" → "at an `ε`-independent scale — over positive measure, or at features of bounded-below scale" (the one-home rule: the
  reading's home is G82). `--dupes` back to 10.
- `tools/claude_md_fact_audit.py`, reviewed lines only. **ALLOW** (reason in the table): `1–130` (the ledger range, now 1–133; the 1–127
  precedent), `30–63` (the group rank, now 30–64; the 30–62 precedent), `G82:[hand, two minds, one blind (row 131); the reading one mind]` (G82
  corrected at FS-107, item 26). **EXTERNAL_HOMES**, each verified in its home on every run: `plans/STUB-ultrametric-continuation.md`, `J38`,
  `J38's` → `plans/FRONTIER-STUBS.md` (FS-98's row); `§ FS` → `plans/FRONTIER-STUBS.md` (the closed-list entry keeps "§ FS-107"); `δ₀`, `δ₀|U_R` →
  `plans/STUB-regularity-wall.md` (§ FS-107 keeps claim R).
- **A planted control:** the audit run in-process with `δ₀|U_R`'s home pointed at `plans/FRONTIER-STUBS.md` (which lacks it) fires exactly one
  failure, "external home plans/FRONTIER-STUBS.md lacks chunk token 'δ₀|U_R'"; the faithful run fails 0. `--self-test` exit 0, SELF-TEST PASSED.

**Gates on the stage's tree** (exit status read directly): fact audit `--base 66f1f51a` exit 0, AUDIT PASSED (LOST 0; homed outside 6); `--dupes`
10; § B `--strict` exit 0; `bib_audit` exit 0; `check_architecture` exit 0. **`CLAUDE.md`: 299,242 → 299,438 bytes** (under 300,000 by 562).

## Stage 4 — SAVED: `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, the protocol

**`BIBLIOGRAPHY.md` (4.3):** `[MundingerEtAl2025]` held at its path, read §1 "Variant 1", §4.1 with Table 1, App. B's pipeline paragraph (FS107-P),
FS-107 bearing added, and a held-copies row; `[DeCorteOliveiraVallentin2022]` §6.1 (Lemmas 6.1–6.2) read (the plan's §PA row 2 says "§6.1 in full",
so "NOT read" now says "any other proof … §6 bar §6.1"), bearing added, held-copies row gains §6.1; `[Voronov2023]` "§§2–6 re-read in full
(FS107-R)"; `[Parts2020c]` the void area per cell (FS107-V). Listing rows: `[Bukh2008]`, `[CroftFalconer1981]`, `[Croft1967]` exist — each gains an
FS-107 note; **new § C rows** `[FalconerMarstrand1986]` and `[HoffmanSoifer1993]`, their titles, authors, pages and Zbl numbers checked against the
zbMATH Open API (seconds; the drafts gave neither title nor first names for the first) — Falconer–Marstrand: *Plane sets with positive density at
infinity contain all large distances*, Bull. Lond. Math. Soc. 18 (1986) 471–474, Zbl 0599.28008; Hoffman–Soifer: Geombinatorics 3(2) (1993) 38–40,
Zbl 0845.05037, with a correction, 3(3) (1994) 102, Zbl 0845.05038. `[Townsend2005]` already carries "requested"; unchanged. "OpenAlex not run" as an
R.6 debt row. No `CLOSED-QUESTIONS.md` draft exists in §R-close: nothing applied there.

**`plans/FRONTIER-STUBS.md` (4.4):** the closed list's first entry (FS-107); the header note (FS-106's replaced by FS-107's, as drafted); rows 1–2
FS-110 and FS-111 (item 36); old ranks 2–63 renumbered 3–64 (FS-107's row removed); FS-104 (rank 3) "sub-question of row 131's question", and its
rank label "Rank 2 since FS-106's close, below FS-107" → "Rank 3 since FS-107's close, below FS-110 and FS-111 (item 36)" — the label was a
current-state fact the renumbering falsified; FS-109 (rank 4) question and solver cells as drafted, **and its bearing "a dial on FS-107's question" →
"row 131's"**, mirroring 4.2's `CLAUDE.md` edit (4.4 names only the question and solver). **The Open-milestones paragraph** mirrors 4.2's
`CLAUDE.md` text (4.4 has no draft for it; it named FS-107 as next).

**The mirror, checked by script:** `CLAUDE.md` ranks 1–29 equal `plans/FRONTIER-STUBS.md`'s, and the bucket `30–64` lists ranks 30–64 in order (35
of 35).

**`plans/GROKKING-INSTANCES.md` (4.5):** seven instances, each text extracted verbatim from 4.5 by script and placed at the end of its entry's
section (§G51 ×3, §G72, §G79, §G21, § Make the gate fail). Two drafts had no italic header; I wrote house-form headers ("under the fence rule";
"the rule 'quote statements verbatim in briefs'"). The first wording of the latter repeated FS106-X's header for ten words and raised `--dupes` to
11; reworded, back to 10.

**`plans/PROTOCOL-competitor-and-advisor.md` (4.6):** the §1 rule 1 amendment, the harness note, and the ninth run before "The next use", all
verbatim from 4.6's blockquotes (wrapped to the file's width). **One deviation, decided here:** 4.6's replaced span ran through "**The advisor may
read exactly the two working files**, and **each competitor is told, in words, not to open the other's file until it has handed back.**", and the
replacement text omits both. I kept them, verbatim, after the amendment. Alternative: drop them as drafted — then the new sentence "each
competitor's record … named by path in every other job's fence" reads as fencing the advisor off both records, against FS-107's own practice
(A107b rule 5: "You may read exactly the two records named in the briefs"). Confidence high; the owner may strike them.

**Gates on the stage's tree** (exit status read directly): fact audit `--base 66f1f51a` exit 0, AUDIT PASSED; `--dupes` 10; § B `--strict` exit 0,
PASS; `bib_audit` exit 0; `check_architecture` exit 0. `CLAUDE.md` 299,438 bytes.
