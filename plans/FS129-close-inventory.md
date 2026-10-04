# FS-129 close inventory (opened by Keryx, 2026-10-03 22:38 UTC; Keryx is its only writer until the close)

*Milestone: FS-129, the cross-application audit (`plans/STUB-cross-application-audit.md`; the plan `plans/FS129-cross-application-audit.md`).
One line per item with its source; no narration. Each line is ticked done or declined with its reason by the close.*

## Rulings in force

1. **Kooshi's four decisions** (2026-10-03, verbatim in the plan § 1): open steps, then mechanisms, then merges, never pairwise; the cap of
   three agents, the readers `general-purpose` agents reading the deriver's identity, not the agent files that preload the grokkings; the audit
   prepares the Lean backlog's input; the arithmetic era is asked whether it bears on the measurable question.
2. **Poros runs as its own agent type** (`poros`, grokkings preloaded) for the card and the re-rank — Keryx's default, since decision 2 named
   the readers. Alternative weighed: a `general-purpose` agent reading Poros's identity. Why: ranking is reasoning from the theory, which the
   preload carries. Confidence: medium; Kooshi's word overrides.
3. **No announcement rule beyond Workflow 3.1's**: a composition is "derived, one mind" until its Lean module passes the gate; nothing in
   FS-129 is blind.

## Registered expectations

- **Keryx's priors** (stated to Kooshi 2026-10-03 before any job; Keryx's, not a lane's, and not scored as a lane's): most of the yield is
  housekeeping — merges, weaker hypotheses, disagreeing records; a hit from the arithmetic era on the measurable question is unlikely and
  would be the most surprising find.
- The lanes' expectations: copied here from each reader's first saved stage and from Poros's card (plan § 7).

## Items

1. Opened 2026-10-03 22:38 UTC: the plan, this inventory, the stub's method section, `CLAUDE.md`'s and `plans/FRONTIER-STUBS.md`'s open-milestone lines. Source: this commit.
2. **Workflow friction:** `/clear` reloads `CLAUDE.md` but not the output style, so a cleared session ran Keryx on Workflow 3.0's
   instructions (its system prompt lacked "Workflow 3.1"); FS-129's first jobs therefore launch from a restarted session. Rule: after a change
   to `.claude/output-styles/keryx.md`, restart, never clear. Source: this session; `plans/SESSION-HANDOFF-2026-10-03.md` § 1.
3. **The prompting instances** that pass 2 must cover (stub § Why now): FS116-Y4 and G83's straddle (`plans/FS116-close-inventory.md` items
   122, 124, 127); V6-HUG and "where else can we use that identity?" (item 142); FS-112's bends stated two ways (item 136, pass 3). FS-121's
   three-into-one (`plans/FS121-Z1-close.md` § 2.5) is already FS-126.
4. **Closed in the Lean backlog's session**: FS-129's compositions join the backlog's queue (plan § 3, Closed).
5. **Launched 2026-10-03 22:45 UTC** (Kooshi's word: "You are go for the audit."): FS129-IX1, the index (`clerk`, Sonnet;
   `data/fs129/briefs/FS129-IX1-index.md`), and FS129-Q1, the question card (`poros`, Opus; `data/fs129/briefs/FS129-Q1-card.md`), both at
   `ddf5abfd`. IX1's brief gated PASS; Q1's FAIL twice, judged false (item 6). Two agents running, of the cap of three.
6. **Tool defect — the brief gate, U8:** a backticked path that a parallel job writes fails "does not exist"; Q1's brief names
   `data/fs129/index/`, which IX1 writes. Noted in the brief, launched, filed in agent-forge (its forge/STATUS.md, Keryx section,
   agent-forge commits `bf2d79c` and `a9427a5`, the second adding a repro script beside the earlier defects' evidence; not pushed). Source: `data/fs129/briefs/FS129-Q1-card.md` § Gate note.
7. **Ruling — the eight derivation files with no milestone number** (`ASTRA-2026-09-14`, `MASCOT`, `Q8`, `R52`, `R57`, `R59`, `R88`, `TC1`)
   are placed in an era by the `LEDGER.md` § B section their theorems are listed under; unplaceable ones go to `CHECK:`. Alternative weighed:
   by each file's first commit date against FS-104's opening. Why: § B's sections already name the milestone, so the rule needs no date
   judgement. Confidence: high. Source: IX1's brief § What you work from.
8. **Ruling, pending — the merged demand list** (plan § 3 Stage 1 says pass 1 "works the merged list" without saying who merges): the pass-1
   readers get both halves — Poros's ranked `data/fs129/demand-judged.md` first, then the index's mechanical `data/fs129/index/open-steps.md`
   entries not on it, in their stubs' rank order — and no separate merge job. Alternative weighed: the Clerk merges them into one file first.
   Why: a merge needs a judgement about which mechanical step is the same as a judged one, which is the readers' work, not the Clerk's.
   Confidence: medium; changes if Poros's list already absorbs the mechanical half.
9. **FS129-IX1 reported DONE** (`data/fs129/reports/FS129-IX1.md`; commits `21bf0b1d`, `46ed4113`, `777c88f4`, all present): 1,295 theorems
   (A 770, R 474, CHECK 51), 1,328 edges, 197 results in the Lean order from 78 seeds. **Keryx's receipt**: re-ran `tools/fs129_index.py
   --self-test`, exit 0, PASS; drew five records at random (seed 20261003) and read each against its file line — FS111-REG-A6
   (`plans/FS111-derivation.md:1367`), M63H4-T3 (`plans/M63H4-derivation.md:64`), ASTRA-2026-09-14-T9 (`plans/ASTRA-2026-09-14-derivation.md:51`),
   FS70-T9 (`plans/FS70-derivation.md:76`) match field for field; **FS100-TCA** (`plans/FS100-derivation.md:289`) does not — its
   `statement` holds the entry's `*Also:*` sentence (X25B-PZ, X25B-LP), its own statement is only in `title`; the one older entry of 1,003
   whose body opens so (Keryx's count). Correction owed to the index: item 15.
10. **Kooshi's note on roots** (2026-10-03 22:56 UTC), verbatim in the plan § 1 and applied to § 3 Stage 0: deep roots weigh as hubs do. The
    index gains `data/fs129/index/roots.md` (item 15), and every reader's brief names roots beside hubs.
11. **Ruling — the 51 era-CHECK theorems go to lane A** (ASTRA-2026-09-14, MASCOT, Q8, R52, R57, R59, R88, TC1): every one is filed under a date
    from 2026-09-08 to 2026-09-14 or a ledger row at or below 88, all before FS-104 opened. Alternative weighed: leave them CHECK for the readers
    to place. Why: their § B lines already date them inside the arithmetic era; a reader placing them would spend judgement on bookkeeping.
    Confidence: high. Supersedes item 7's rule where § B gives a date or a row.
12. **Ruling — FS-105 stays in lane R**, by its number (plan § 5: "The boundary is by milestone number"), although its § B column holds rows
    120, 128, 129 (measure rigidity, the collapse). Alternative weighed: move it to A, whose description in § 5 names the collapse. Why: the
    collapse states the plane's number as the measurable one, which is lane R's subject; lane A still reads it, since each lane reads the whole
    corpus. Confidence: medium.
13. **Ruling — the Lean order keeps all 78 seeds**, the three `none`-led handoffs that name de Bruijn on a later line (FS116-Y4-SPOKE,
    TC1-SQRT3-DYADIC, TC1-STANDING-FIVE) flagged as conditional: each crosses "with" another result or "if" something is formalized. The
    backlog session decides; FS129-L1 quotes the handoff text. Alternative: drop them to match the plan's 77. Why: dropping hides a
    condition the backlog needs. Confidence: high.
14. **Accepted from IX1's proposals**: an edge source `grade` for the ids a `derived from:` grade names. Declined: hubs split by grammar
    (the roots file and the orphans caveat carry the same warning more cheaply).
15. **Amendment to FS129-IX1** (dated 2026-10-03 in its brief): `roots.md` and depth columns; `grade` edges; FS100-TCA's statement and every
    `*Also:*` claim listed; items 11–12's eras applied; the 22 files with no entry checked for theorems no indexed entry carries. IX1
    continued by message (well below its line).
16. **Statement defect, found by IX1 — credit to the Clerk**: the grokkings skill's description says "entries G1 to G87"; the file holds
    G1–G91. Keryx's file; fixed in the same commit as this line.
17. **Tool defect — the brief gate, U9:** a backticked `dir/file:line` address to an existing file fails "does not exist"; met on the
    first draft of IX1's amendment, reworded to pass. Filed in agent-forge with a repro (agent-forge commit `fa3de16`, not pushed), beside U8
    (item 6), at Kooshi's word ("quickly file the defects in the brief checker to ../agent-forge alongside the others, so I can fix them
    later", 2026-10-03).
18. **FS129-IX1's amendment reported DONE** (commit `02a4a553`; report `data/fs129/reports/FS129-IX1.md`). **Keryx's receipt**: the commit's
    18 files are all under `data/fs129/` or `tools/fs129_index.py`; `--self-test` re-run, exit 0, PASS; `data/fs129/index/roots.md` read — the
    longest chain of dependents has 13 edges, from FS111-V0-ID1 or FS111-C-HULL-SO to FS121-Z1-NOCURVED. Eras now A 821, R 474, CHECK 0.
    FS100-TCA corrected. IX1 closed; its context (≈210k by its count) is not reused.
19. **Finding for the readers — the roots ranking leans to lane R**: 87 of `roots.md`'s 100 are lane R (FS-111 to FS-121); the 13 lane-A rows
    are FS-89, FS-91 and one FS-66 (ranks 21 to 100, chains of 5 to 8 edges), all milestones whose records name their dependencies by id.
    Older-format entries carry no `uses only:`, so their edges come from prose (IX1's CHECK), and an arithmetic-era root of a long chain may
    be missing. Every reader's brief says so; lane A finds the rest of its roots by reading. Source: `data/fs129/index/roots.md` (header and
    the era column); IX1's report. *Corrected 2026-10-03 by Keryx: the first text of this line said "all 100 … are lane R", written from
    the top rows before counting the era column; the count is 87 R, 13 A.*
20. **For the readers — two `*Also:*` claims with no record**: X25B-PZ and X25B-LP (`plans/FS100-derivation.md` line 289); and 68 ids defined in
    the no-entry files appear in no indexed entry, three files wholly (FS100-X28D, FS84-S1, FS84-SI-D). Lane A's pass 3 (merges) owns them.
    Source: `data/fs129/index/checks.md`.
21. **Slip, IX1's, self-reported**: stage 4 committed with `git commit -a` against standing rule 6; the commit holds only its own files
    (checked, item 18). No harm; logged because the rule exists for a shared tree.
22. **FS129-Q1 reported DONE** (`data/fs129/reports/FS129-Q1.md`; commits `44c577d5`, `f69ac133`, `72b2ae79`, all present; harness ≈398k, not
    reused). The card `what-kind-of-input-closes-each-step` and its existence and structural forms are in `plans/STUB-cross-application-audit.md`
    § The question (Poros, 2026-10-03); the bearing rewritten; `data/fs129/demand-judged.md` ranks 24 steps (J1–J24), with § 1 the homonyms, § 2
    the no-gos that exclude kinds, § 4 the index's 30 open-step entries placed. **Keryx's receipt**: every one of the 20 addressed step
    quotations checked by script against its source lines — 20 verbatim (one differs only by the source's `> ` blockquote marker, J3); the
    invention signal's four quotations (`plans/STUB-forced-pair.md` lines 35–37; `LEDGER.md` rows 135, 136) found verbatim.
23. **Registered expectations, Poros** (copied from `plans/POROS-2026-10-03-fs129-card.md` § 1.2; scored at FS129-Z1): A1 closes, expected 1,
    P(≥ 1) = 0.45; A2 shortenings, expected 5, P(≥ 3) = 0.6; A3 share null in both lanes, expected 0.7; **A4** the audit changes item 31's open
    list or the top three, P = 0.2; **A5** lane A closes or shortens a regularity-era step from a result its stub does not cite, P = 0.35;
    A6 pass 2 yields more than pass 1, P = 0.6; A7 another FS116-Y4-type miss, P = 0.6. Its list expectations D1–D4 scored at stage 2: one of
    four met, Brier 0.283 (record § 2.1). A4 and A5 decide what runs next: a lane-A null at pass 1 is A5's evidence, and lane A's pass 2 still
    runs (decision 4 asks for the null as a finding).
24. **Ruling — item 8 settled**: the readers take `data/fs129/demand-judged.md` first (it places all 30 of the index's § 1 entries), then
    `data/fs129/index/open-steps.md` §§ 2–4 (the 12 "stalls at" lines, 372 GAP lines, 418 gap lines) in their stubs' rank order; no merge job.
    Alternative: a Clerk merge. Why: § 1 is absorbed; §§ 2–4 are prose lines a merge would have to judge. Confidence: medium; changes if a reader
    finds a step there that bears on the answer and the list missed. Poros recommended the same (its report).
25. **Ruling — Poros's three corrections adopted into the pass-1 briefs** (record § 2.5): each step opens with one line naming the kind of input
    its closing argument must read, checked against the list's § 2, before statements are scanned; the homonym list (§ 1) is required reading;
    lane A works its four sites first — J4, J12–J13, J2, J17 — then the rest in rank order. Alternative: put them to Kooshi before launching.
    Why: none changes the passes, their order, the era split or the staffing, which are his decisions; they are how a brief aims a reader.
    Reported to Kooshi as settled, overridable. Confidence: high.
26. **Ruling — the map step at five (Poros's card 3; J10)**: Poros's default stands — it stays on the demand list for lane R, and FS129-P1 drafts
    its carrier (FS-104's route list or a new stub) at the re-rank. Alternative: Keryx files a stub now. Why: which stub carries a route is a
    ranking call, Poros's lane. Confidence: high.
27. **Invention signal (Poros's card 2, addressed to Ephodos; J15)**: route R's "meet nowhere below the answer" (`plans/STUB-forced-pair.md`
    lines 35–37; `plans/FRONTIER-STUBS.md` rank 5) against rows 133, 135, 136 (close complementary pairs and four-colour vertices). Routed to
    FS129-OR1 as part of J15, both sides quoted, no side picked. Source: `plans/POROS-2026-10-03-fs129-card.md` § 2.4.
28. **Correction owed — `plans/STUB-cp-plane-six.md` line 53** calls the collapse "FS-103's F1 (a candidate, not held)"; rows 128 and 130 hold it
    at [hand], given MR. For FS129-Z1, which writes open stubs' bearing lines at the record job. Source: Poros's report.
29. **Hunches for lane R's FS-124 cases** (Poros's questions for another lane): `skeleton-carries-a-syntheme` (J17, 0.5) and
    `semipar3-reads-a-height` (J2, 0.35); in the demand list, read by both readers. Source: record § 2.4.
30. **Touch beyond the brief, Poros's**: `data/fs129/q1/build_demand.py` and `data/fs129/q1/demand-template.md`, working files under
    `data/fs129/` (standing rule 2). No harm.
31. **Launched 2026-10-03 23:10 UTC**: FS129-OA1 and FS129-OR1, pass 1, lanes A and R (`general-purpose`, Opus;
    `data/fs129/briefs/FS129-OA1-pass1.md`, `data/fs129/briefs/FS129-OR1-pass1.md`, both gated PASS, at `6848d57d`). Two agents running, of
    the cap of three.
32. **Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. Sounds like the vacuity issue we encountered in a lean implementation a while
    back... and thus gated... will be back to bite us with the hand proofs. Well, hopefully putting them in lean will help check them
    mechanically. This is another reason for workflow 3.1 and the lean backlog."
33. **Held for Kooshi — a vacuity sort, proposed by Keryx; default: added.** Of the 292 block-format entries, 54 have a `model:` line saying no
    held object meets their hypotheses (211 name one; 27 have no `model:` line; Keryx's count by script, 2026-10-03). The older 1,003 entries
    have no `model:` field at all. Proposal: the index gains a column (the `model:` text, and "none known" flagged), and pass 3 sorts each
    flagged result as inhabited (an object found), empty (the result holds vacuously, and every result resting on it is marked through the
    dependency graph), or a statement about a hypothetical object by design (a step in a proof by contradiction, such as properties of a
    tight six-map, whose emptiness is the goal). Alternative: leave vacuity to the Lean backlog's gate. Why: the Lean gate's vacuity check
    needs a witness or a declaration per statement, and the sort supplies that input; FS-116's double tip was worked two rounds before its
    class was found empty (items 3, 9; `plans/FS116-close-inventory.md` items 122, 124, 127). Confidence: medium on yield, high on cost
    (one mechanical column; one pass-3 duty). Not relayed to the running readers.
34. **Item 33 approved by Kooshi** (2026-10-03, verbatim: "sounds good, thankyou"). The index column is added now, by FS129-IX1 continued below
    its line (amendment of 2026-10-03, its brief); the sort goes into the pass-3 briefs (FS129-SA1, FS129-SR1).
35. **FS129-IX1's vacuity column reported DONE** (commit `98ebf5f1`; `data/fs129/index/vacuity.md`). Block entries: 55 `none-known`, 212 `named`,
    25 `no-field` (Keryx's rough 54 / 211 / 27; the Clerk's rule is in its README and its count stands). **Keryx's receipt**: `--self-test` re-run,
    exit 0, PASS; the top entry read against its file — FS121-D4-HOLE (`plans/FS121-derivation.md` line 962, 60 transitive dependents):
    "none held of the hypothesis (R7, SQ9, HEX9, TINY16 have no region with a hole); a no-go for islands whose shore holds a point off Σ".
    IX1 closed (≈263k by the harness); reopened by item 48.
36. **For the pass-3 briefs — the sort needs a fourth heading**: a no-go, whose statement is that its hypothesis class is empty, has no model
    by construction (FS121-D4-HOLE above). Pass 3 sorts each `none-known` result as inhabited, empty, hypothetical by design (a step in a proof
    by contradiction), or a no-go — and only "empty" passes vacuity to its dependents. Source: item 35.
37. **Ruling — the flag rule stands as the Clerk wrote it**; its two borderline cases (FS116-N1-QFREE4, FS121-O1-OUT: a phrase later in the
    line, the first naming an object for part of its scope) and the 16 `named` entries that match a looser negative pattern go to pass 3 as a
    second list, sorted the same way. Alternative: widen the rule. Why: a wider rule moves judgement into a regex; pass 3 reads each anyway.
    Confidence: high. Source: IX1's report; `data/fs129/index/vacuity.md`.
38. **FS129-OA1 reported DONE** (`data/fs129/reports/FS129-OA1.md`; commits `9e2ffde5`, `69f99f02`, `cefcd69c`, `525dea12`, `a0f68791`, all
    present; ≈313k by the harness, not continued into pass 2). Of 24 steps: J12 and J13 shortened, J2 given an invariant without closing, 21
    null (J4 among them), each null with its reason (record §§ 3.2–3.3). Five entries, each derived, hand, one mind: FS129-OA1-NOLIN5,
    -FALC-RED, -FALC-11, -NOPERLAW, -RINGWIND (record § Theorems this phase proved). **Keryx's receipt**: the record's derive gate re-run,
    exit 0, PASS (3 controls fire on their faults, 4 warnings); NOLIN5's argument re-derived by Keryx from row 66's Slack (Γ₁₁, 5) — for each
    vertex v of H, the colouring of Γ₁₁ that gaps ρ(v), pulled back, repainted at v alone (v's neighbours map to neighbours of ρ(v), which
    avoid the gap colour), gives two colourings differing only at v, so c_v = 0 by the simplex labelling's injectivity — holds; a checking
    reading, not a second mind. `BIBLIOGRAPHY.md` line 169 and line 626 confirm `[Falconer1981]` held and read in full.
39. **Decision 4 has a hit, at one mind**: arithmetic-era results bear on a regularity-era step — row 66's slack residue plane at 11 (Γ₁₁) and the
    kernel's two colouring tables for it shorten FS-104's route (c) (NOLIN5: G75's annihilator format closed on fields with a residue-𝔽₁₁ prime)
    and routes (0)/(b) (FALC-RED, FALC-11, NOPERLAW). **On Poros's A5** (item 23; OA1 held the question for Keryx): by A5's own words a
    regularity-era step is "FS-104 on", and `plans/STUB-cp-plane-six.md` cites neither row 66 nor Γ₁₁ (Keryx's grep), so J12 and J13 meet A5's
    letter if FS129-Z1 scores them as shortenings under A2's definition; Z1 scores. Keryx's priors (top of this file) called this hit unlikely.
40. **Search requests queued** (`plans/SEARCH-QUEUE.md` rows 1–3): Γ₁₁ with two gap colours at a vertex (row 1); UD(ℤ/121, 2), conditional (row 2);
    a Falconer fan at five colours over K(√7) or a window field (row 3) — **held for Kooshi**: a finite-witness search toward six, which `CLAUDE.md`
    § Publication rules out, and lane R's to word first.
41. **Held for pass 2 — confirm `[Falconer1981]` Lemmas 3 and 4 from the paper** before anything builds on FALC-RED: OA1 used them as
    `plans/FS103-M-derivation.md` § 1.2 quotes them and did not re-read the PDF (its HELD). FS129-MA1's first stage. Source: OA1's report.
42. **Correction owed — the Falconer status**: `plans/STUB-cp-plane-six.md` lines 55 and 87 (and the demand list's J13) say `[Falconer1981]` is
    "not held"; it is held and read in full (item 38). With item 28, for FS129-Z1. Source: `plans/FS129-OA1-audit.md` § 2.3.
43. **Correction owed — Poros's FS-128 card**: it says the top colour's circle is "covered by the five lower colours"; exact only where max P(x) is
    the sixth colour, otherwise the five other colours, higher ones included. For FS129-P1 (Poros, the re-rank). Source: `plans/FS129-OA1-audit.md`
    § 2.1.
44. **Tool defect — `data/fs129/index/open-steps.md` § 4**: at least 158 of its 418 lowercase "gap" lines use the word in row 66's fan-gap sense,
    not as an open step. Relayed to FS129-OR1 by message, 2026-10-03; named in the pass-2 briefs. Source: `plans/FS129-OA1-audit.md` § 4.1 item 3.
45. **Prior-art debts**: NOLIN5, FALC-11, NOPERLAW and RINGWIND owed, FALC-RED partly; for FS129-Z1 (the record job's prior-art gate).
46. **Relayed to FS129-OR1** (by message, 2026-10-03): RINGWIND and OA1's question on the winding jump at (u, p, v) for J2; item 44. OA1's
    other cross-era lines (row 132's index as RINGWIND's object; row 130's N-EASY and FALC-RED; W-FILL-FREE and M-DEADLOCK) go to FS129-MR1's brief.
47. **Lane A's scored registration** (record § 4.2; for FS129-Z1): closed 0 (expected 0), shortened 2 (expected 1.5), nulls 88 % (expected 85 %),
    E9 (J4 yields) missed.
48. **Tool defect — the index's grokking parser reads 8 of 91 grokkings**, found by Keryx while briefing pass 2. `GROK_HEAD`
    (`tools/fs129_index.py` line 58) requires the bold title to end its line, and 83 of the 91 entries continue on the same line (`* **G1 — The
    field wall. [kernel]** The Moser twist …`), so `data/fs129/index/grokking-uses.md` and every record's `mentions_grokkings` cover only G64,
    G74, G75, G76, G80, G83, G87, G88. The self-test planted a grokking in the one form the regex reads. IX1's report had a hint ("G87 and G88
    are mentioned by no entry"), and Keryx's two reviews missed it — a coordinator's slip: the receipts checked theorem records, never a
    count against the corpus. Fix: FS129-IX1 continued, third amendment, with a completeness assertion against the corpus counts (91
    grokkings, 148 ledger rows). Pass 2 waits for it.
49. **FS129-IX1's parser fix reported DONE** (commit `c2d322fc`): 91 of 91 grokkings read; a completeness assertion on every run (grokkings
    91 = 91, ledger rows 148 = 148, theorems 1,295 = 1,295), each with a planted fault that fires. **Credit to the Clerk**: Keryx's diagnosis
    (text after the title) would have reached 68 of 91; 23 entries wrap their bold title onto a second line, and the new assertion caught
    it on the first real run. **Keryx's receipt**: `--self-test` re-run, exit 0, PASS; `data/fs129/index/grokking-uses.md` holds 91 sections.
    Era by majority of mentions: A 54, R 5 (G2, G3, G83, G84, G85), tied 4 (G4, G58, G71, G80), mentioned by no entry 28. IX1 closed (≈286k).
50. **Declined — the census's `ROW_RE`** (`tools/fs71_ledger_b_check.py` line 58) would drop a § B row without a trailing `|`; Keryx's count of
    such rows today: 0. Why declined: the census is no longer run at a filing (the handoff, § 3), § B takes no rows from Workflow 3.1 on,
    and the index's own § B count fires if a row's entry goes missing. Reopen if the census is run again.
51. **Ruling — which lane owns each grokking for pass 2**: majority of mentions where there is one; ties and unmentioned entries by the
    grokking's own era — G1–G80 lane A, G81–G91 lane R — so lane R owns G2, G3, G81–G86, G88–G91 (12) and lane A the other live entries up
    to G80 (70). Retired entries (G30, G46, G47, G49, G50, G51, G67, G72) are read as cautions, never applied as mechanisms; G87 (a method,
    the invention signal) is no lane's mechanism. Alternative: majority only, which leaves lane R five grokkings and the regularity era's own
    entries (G81–G91, almost never cited by number) unowned. Why: an entry the regularity era rarely cites by number is still its
    mechanism. Confidence: high.
52. **Ruling — lane A's pass 2 runs as successive agents, not two at once**: FS129-MA1 takes lane A's 70 mechanisms in order of reach (pass 1's
    leads first — row 66's slack residue plane and fan gap, Hoffman tightness, the Falconer fan, the ring winding — then by mentions, hubs and
    roots), hands back at a saved stage with the rest listed, and FS129-MA2 continues from it. Alternative: split lane A's grokkings across two
    agents now. Why: the cap of three must keep a slot for FS129-MR1 when FS129-OR1 lands; the plan's staffing (two readers split by era) stands
    unchanged. Confidence: medium.
53. **Launched 2026-10-03 23:42 UTC**: FS129-MA1, pass 2, lane A (`general-purpose`, Opus; `data/fs129/briefs/FS129-MA1-pass2.md`, gated PASS, at
    `16142efb`). Running: FS129-OR1 and FS129-MA1, two of the cap of three; the third slot is kept for FS129-MR1.
54. **FS129-OR1 reported DONE** (`data/fs129/reports/FS129-OR1.md`; commits `a62e3252`, `6c2b4de7`, `60a7fc11`, `99ad3261`, `4b1870fd`, all present;
    ≈448k by the harness, not continued). **J1 closed, answer yes** (FS-123 question 1): bending a fragment keeps FS116-Y4-EMPTY's class and leaves
    only (Q) arcs on the ring, provided the bends run on a whole-tile restriction of radius ≤ √3 (a round restriction, as the side-1 recipe has
    it, can cut a tile into a Siamese pair). So **FS129-OR1-QFREE** (derived, one mind): "no non-Siamese simple valid six-coloured fragment on a
    closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no (Q) arc". J19 half closed (LOCALDENSE at r = 3,
    possibly vacuous; DISCF-NS); J2, J3, J7, J10, J15, J17, J23 shortened or reduced; J18 moot; 14 nulls with near misses. Eight entries, all
    derived, one mind, prior art owed: FS129-OR1-WHOLE, -BENDFRAG, -QFREE-CLASS, -QFREE, -BEND3, -TOP5, -LOCALDENSE, -DISCF-NS. **Keryx's
    receipt**: derive gate re-run, exit 0, PASS (2 controls fire, 19 warnings); QFREE's statement read against FS116-Y4-EMPTY's
    (`plans/FS116-derivation.md` line 1713) — identical but "no arc of Γ" → "no (Q) arc", as its `uses only:` says; its `model:` names an
    inhabitant (FS114-Y2-BOWTIE); WHOLE's identity `|x − e|² = (|x|² + |x − 2e|²)/2 − 1` for `|e| = 1` checked exactly by sympy.
55. **Where a second reader should attack J1** (OR1's HELD, verbatim): "J1's composition rests on FS112-N2-BENDS being read on a fragment (it
    depends only on the tiles present) and on simplicity surviving horn lenses at cusp ends." For FS129-SR1 (pass 3, lane R) as a checking
    reading, and for the Lean backlog. Kooshi decides whether a blind second mind runs (item 56).
56. **Held for Kooshi — J1's close is one mind and moves the ranking's top**: it answers the top-ranked stub's (FS-123's) first question, empties
    the construction target "(R2) ring, (Q)-free, past 1 + ε" in the non-Siamese simple class, and makes FS-123's Siamese question its main
    one. Default (Workflow 3.1): no blind verifier; pass 3 attacks item 55's two steps; the re-rank files it as "derived, one mind"; the Lean
    backlog formalizes it early. Alternative: a blind `ephodos-verifier` on QFREE-CLASS and BENDFRAG, on Kooshi's word only.
57. **Poros's A4 may be met** (item 23: P = 0.2 that the audit changes item 31's open list): `CLAUDE.md` item 31 lists "(Q)-free rings with (R2)
    arcs" as open, and QFREE closes that case in the non-Siamese simple class at one mind. FS129-Z1 scores.
58. **The invention signal J15 does not stand** (OR1, § Stage 4): side 1's reason is a Condition-5 theorem (row 134), its conclusion stated
    without that restriction; with unit arcs routes R and M meet at the pinned corner (FS112-STOP, FS112-Y3-R3, FS112-N3-COR3). **Statement
    defect**: `plans/STUB-forced-pair.md` line 37 ("so this route and FS-121's meet nowhere below the answer") holds under Condition 5 only. For
    FS129-Z1 (bearing lines) and FS129-P1 (`plans/FRONTIER-STUBS.md` rank 5 says the same). Keryx's own reading on 2026-10-03 (to Kooshi,
    one mind, not sent to any reader) was the same.
59. **Corrections owed, from OR1** (for FS129-Z1 unless named): the side-1 remarks (`plans/FS114-NB5-verification.md` § 1b.3,
    `plans/FS114-NB6-verification.md` § 1b.0, `plans/FS114-N7-proof.md` lines 88–89) say "restrict first" to a round neighbourhood — true only
    for the whole-tile restriction; `plans/FS116-local-exclusion.md` § 3.6 (C114-LOCAL-F and DISC-F one question given LOCAL-DENSE) — true in the
    non-Siamese simple class only; `data/fs129/demand-judged.md` J10 "no open stub carries it" — half true: MUA-FIN is FS-120's, REG-J′₅ FS-127's,
    and only MUA-REG-P and the five-colour top-colour clause lack a carrier (for FS129-P1, with item 26).
60. **Stubs to re-aim, from OR1** (for FS129-Z1 and FS129-P1): FS-123 (question 1 answered yes, 2 moot, 3 — Siamese — now its main question);
    FS-125 (case 2 and case 1's G3 closed in the non-Siamese simple class); FS-115 bears on DISC-F in the Siamese class, against the demand
    list's § 5 "no bearing"; FS-124 may assume below √3 about p that p's ring carries only (Q) arcs plus finitely many points (BENDFRAG), and no
    further.
61. **Generalization** (OR1): the bends need only that one side colour of each ring arc is absent at the centre; BEND3 is that form at
    three-colour vertices; WHOLE holds for any number of colours. For FS129-MR1 and FS129-SR1.
62. **Leads for pass 2, lane R** (OR1's questions for another lane): FS110-A3-HOLE and FS110-N2-SWAP fail exactly where the unit circle carries
    an arc of Γ, which BEND3 and BENDFRAG remove below √3 — reading radius unchecked; FS-112's stuck ray (N2-RAY) and FS-121's tangent pencils
    (O1-OUT) one object; FS111-M4-CUT and FS121-D4-FACE one sagitta (the last two pairs also pass 3's). To FS129-MR1's brief. RINGWIND as
    FS110-Y3-GP's and FS110-N2-RING's mechanism relayed to FS129-MA1 by message, 2026-10-03.
63. **The mechanical half read only partly** (OR1): § 2 in full; § 3 for FS106, FS106-TS, FS106-TQ, FS107, FS110 (about 66 of 372 lines); § 4
    counted by file. Lane A read its own part (item 38). The unread rest goes to the pass-3 briefs, scoped to `data/fs129/index/lean-order.md`
    first as the plan says.
64. **Lane R's scored registration** (`plans/FS129-OR1-audit.md` § Registered expectations, scored; for FS129-Z1): closes and compositions priced
    low (1½ closes and 8 compositions against expected 0 and 3); J15 predicted to stand at 0.40, did not; J10 predicted to bear at 0.35, did.
65. **Launched 2026-10-03 23:46 UTC**: FS129-MR1, pass 2, lane R (`general-purpose`, Opus; `data/fs129/briefs/FS129-MR1-pass2.md`, gated PASS, at
    `a951d15f`). Running: FS129-MA1 and FS129-MR1, two of the cap of three.
66. **FS129-MA1 reported STAGE 5 SAVED, as planned** (`data/fs129/reports/FS129-MA1.md`; commits `1572ddb5`, `3ce9119a`, `ff124f65`, `9cd3e570`,
    `1be0b883`, `ca9c191f`, all present; ≈327k by the harness, not continued): 23 of lane A's 70 mechanisms audited, 47 left in order
    (`plans/FS129-MA1-audit.md` § 5.4). Three entries, each derived, hand, one mind: FS129-MA1-NOAFF5 (NOLIN5 widened — vector coefficients;
    targets Γ₁₁, Γ₁₉ and any four-colourable target), -FALC-T (FALC-11's argument for any target), -FALC-19. No miss of the FS116-Y4 kind; none
    of the 17 unmentioned lane-A grokkings bears anywhere unapplied. **Keryx's receipt**: derive gate re-run, exit 0, PASS (3 controls fire);
    § 2.1's table of `[Falconer1981]` Lemmas 1–4, transcribed from pp. 185–187, read.
67. **`[Falconer1981]` checked against the paper** (item 41 done): Lemmas 2, 3, the null-set sentence and Theorems 1–2 verbatim as
    `plans/FS103-M-derivation.md` § 1.2 quotes them; Lemma 1 chooses the rigid motion, so the point of E the apex lands on cannot be fixed first.
    **Correction owed** to FS129-OA1-FALC-RED: its statement stands; its argument and `uses only:` line are reordered as Falconer's own p. 188
    (`plans/FS129-MA1-audit.md` § 2.2). For FS129-Z1. No grade moves.
68. **Merges for pass 3, lane A** (MA1's generalizations): FS129-OA1-NOLIN5 is a case of FS129-MA1-NOAFF5; FS129-OA1-FALC-11 and FS129-MA1-FALC-19
    are instances of FS129-MA1-FALC-T; M60-T2 and M61-T5 are subsumed by row 66; FS86-Cx-C11 is NOAFF5's four-colour face. Source: record § 3.1.
69. **Correction owed — ASTRA-2026-09-14-T10's statement** ("for any real F ⊇ K") lacks the clause its own prose knows: its hypothesis is empty
    over every F ⊇ K with a residue-𝔽₁₁ prime (row 66). For pass 3 (and the vacuity sort, item 36). Source: record § 3.1 item 3.
70. **Ownership finding, MA1** (record § 5.2): G71 is two mechanisms — the lattice height (lane A) and the height on a curve (lane R in practice);
    G13 is two (the coverage iff, era-free; the fan-ladder reading, lane A); G54's last paragraph is separate (gap-free pullbacks in products);
    row 66 is one mechanism under four grokkings (G13's slack face, G26, G31, G48). Relayed to FS129-MR1 by message (G71's curve height, and the
    FS106-BIKE lead: G71's ring winding not tried on its GAP, the route it served closed by row 133). Folded into FS129-MA2's brief.
71. **Search requests**: row 3 annotated with FALC-T's three filters (still held for Kooshi); row 4 queued (Γ₁₉ with two gap colours at a vertex,
    low priority). `plans/SEARCH-QUEUE.md`.
72. **Prior-art debts**: NOAFF5, FALC-T, FALC-19 owed; for FS129-Z1.
73. **MA1's registration, provisionally scored** (record § 5.3; FS129-Z1 scores): reached 23 of an expected 22; 3 compositions of an expected 4;
    0 misses of the Y4 kind; 0 of the 17 unmentioned grokkings bearing unapplied, against an expected 0.2; MA1-E5 (a material Falconer
    difference, P = 0.15) not met.
74. **Launched 2026-10-04 00:07 UTC**: FS129-MA2, pass 2, lane A, second part (`general-purpose`, Opus; `data/fs129/briefs/FS129-MA2-pass2.md`,
    gated PASS, at `034cd9e0`). Running: FS129-MR1 and FS129-MA2, two of the cap of three.
75. **FS129-MR1 reported DONE** (`data/fs129/reports/FS129-MR1.md`; commits `97beb60d`, `20995ea7`, `b8746b68`, `33c5c21e`, `60a18599`, all present;
    ≈389k by the harness, not continued). **FS129-MR1-DOUBLETIP** (derived, one mind): the double-tip kill of FS116-V6-HUG and FS116-Y4-EMPTY,
    stated there only for rings with no arc of Γ, holds on every ring of the non-Siamese simple class provided the outer germ of each tip
    pair lies on no (Q) arc; it answers Poros's card 2 (rank 1) and does not reach SEMI-PAR3. **Kooshi's "where else can we use that
    identity?"** (`plans/FS116-close-inventory.md` item 142) answered: V6-HUG's identity was already used at FS-114, unnamed — FS114-YB4-2ND's
    `2(1 − cos s)(1 − cos t) − 2 sin s sin t` for FS114-Y5-PXKILL's pair — so one law found three times (PXKILL, V6-HUG and V6-ADJ, FLANK's
    least-curved case); its new use is DOUBLETIP. Nulls with named failing hypotheses: WHOLE's identity, the straddle at SEMI-PAR3 and in the
    Siamese class, the bends at FS110-P17, -Y3-SIX, FS116-N2-RECIP, FS110-N2-SWAP, G86, G88, G81. **Keryx's receipt**: derive gate re-run, exit
    0, PASS (3 controls fire); the identity `2(1 − cos s)(1 − cos t) − 2 sin s sin t = −8 sin(s/2) sin(t/2) cos((s + t)/2)` checked by sympy
    (simplify, and 200 random points, max difference 7e-16).
76. **Where a second reader should attack DOUBLETIP** (MR1's HELD, verbatim): "Its steps 1 and 3 rest on RING-GERM (i) and N2-STAR applied at
    a change point whose other tip germ is free only because the neighbouring point is a change point." For FS129-SR1 and the Lean backlog.
77. **Tool defect — "Rests on it: nothing; …" read as edges**: 24 entries whose "Rests on it" paragraph begins "nothing" carry edges from ids
    the sentence goes on to name (Keryx's count, 2026-10-03, by matching `rests_text` against "nothing|none" with non-empty `rests_ids`). Some
    are false: FS111-C-HULL-SO → FS111-C-HULL and FS111-M2-DISCK7-AS-PLACED → FS111-M2-DISCK7 ("the corrected form is …", from refuted entries),
    FS114-K1 and FS114-ROUTE-T (a successor's list). Some may be real ("nothing in this file; FS116-C114-LOCAL-F's (Q)-ring case"). The false
    C-HULL-SO edge makes a refuted entry `data/fs129/index/roots.md`'s rank-2 root with 78 dependents that are C-HULL's; the true top root is
    FS111-V0-ID1 (MR1). Judgement, so pass 3 sorts the 24 and FS129-Z1 corrects the index when it adds its column. Found by MR1.
78. **Correction owed — FS110-A3-HOLE's GAP was answered elsewhere without a link back** (MR1): its first step is FS116-N1-QFREE4 (held,
    stronger, Siamese allowed), false on fragments with (Q) arcs (FS116-Y2-SIXFRAG); its second step is FS112-A4SIX's branch or a change point of
    exactly two colours (FS116-N1-QDISK). For FS129-Z1. Source: `plans/FS129-MR1-audit.md` § Stage 3 lead (a), § Stage 4.
79. **Merges for pass 3, lane R** (MR1): V6-HUG / PXKILL (YB4-2ND) / V6-ADJ / FLANK's model one lemma; FS112-SIX the coarse form of
    FS116-N2-FIVERING and -SIXRING; FS112-U1 = FS116-V5-U1; FS111-V0-ID1 = FS116-V5-NE1 and FS111-C-HULL = FS116-V4-DICHOTOMY (measurable forms;
    each proved once in Lean); the stuck ray = the tangent pencil (FS121-D2-SYM's window hypothesis a candidate weakening of FS112-N3-PER, toward
    its GAP N3-ALPH); FS111-M4-CUT and FS121-D4-FACE one sagitta (FACE-SHARP as CUT's sharpness). Source: record §§ Stage 3 (b), (c), Stage 4.
80. **For FS-125's and FS-124's openings** (MR1's questions for another lane; for FS129-Z1's stub bearing lines): which side's binding each
    saturated-fragment kill reads (FS116-S1-QF, -SAT-STRIP, -S1-RUNG) — a kill reading only the lower colour's binding bypasses TOP₆, since Grundy
    fragments come free (FS121-D3-GRUNDY); whether FS111-M2-INTRAD's one-step parallel argument makes FS116-O1-SATPIN's tangent edges segments or
    integer-radius arcs; the winding computation at SEMI-PAR3 confines t_front to the tip cone at y, at radius √3 + ε about p, provided a germ
    assignment not yet derived (`data/fs129/mr1/jump_explore.py`). Lane A's question computed but conditional: jump 0 when the two (Q) arcs'
    side tiles hold ω(y)'s germs at u and v; ±2 needs an f-coloured tile at u or v.
81. **Unread, for pass 3, lane R** (MR1): G83's straddle against FS114-K1's residues on (Q) rings (FS114-Y6-E2RED's survivor S6, the wrap, the
    Reuleaux (2, 1, 1, 0) past √3); V6-ADJ's argument at adjacent change points whose outer pairs are off (Q). FS106-BIKE: FS110-Y3-GP gives
    |W| ≥ 3 for circles with no two change points 60° apart; a coupling of two circles' windings across the cross curve is missing.
82. **Stub to re-aim — FS-124** (`plans/STUB-q-ring.md`): add DOUBLETIP as a pruning rule for ring types in case 5 and at hubs and kind-T
    semi-hubs in case 1; SEMI-PAR3 untouched. For FS129-Z1. **Generalization, not derived**: below √3 the bends free the ring of any point with at
    most three colours of Γ (non-Siamese simple); no consumer found.
83. **Ruling corrected — G2 and G3 are lane A's** (MR1's HELD): item 51's majority count came from homonyms (FS-106's [G2], [G3] labels; FS-125's
    open places G1–G3), so no lane audited them — a coordinator's slip, from a rule that trusted a token count Keryx knew to be an upper bound
    (item 49's CHECK). Relayed to FS129-MA2 by message, 2026-10-03, to add to its list.
84. **MR1's scored registration** (record § Stage 4; for FS129-Z1): 1 composition against 4 registered; 0 strict Y4-kind misses against 2, but 3
    citation or re-derivation misses (the identity found three times; A3-HOLE answered without a link; the double tip stated narrowly); the
    bends shortening an FS-110 GAP, P = 0.45, no. Poros's card-2 hunch (0.5) met for the configuration, not for SEMI-PAR3. Prior art owed for
    DOUBLETIP.
