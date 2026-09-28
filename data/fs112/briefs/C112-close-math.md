*Brief for job **FS112-C**: the close of FS-112, "the unit-arc half" (WORKFLOW step 9) — its mathematics, its drafts, and the two stubs that
succeed it. Opus 5.5, 2026-09-27. Written by the product owner. Its template is FS-110's close brief (`data/fs110/briefs/C110-close-math.md`, with its
report `data/fs110/reports/FS110-C.md`): follow that brief's form wherever this one is silent. **Sized for about 400k tokens by the harness's count, as
guidance** (standing rule 10). A front-page job (FS112-X) applies your drafts afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. **`data/fs112/briefs/STANDING-RULES.md` is part of this
brief; read rule 0 first.** Then read these from disk (a subagent sees a stale snapshot of `CLAUDE.md`; read the file):
- `CLAUDE.md`'s header rules, § The aim, § Counter-priors, § Paths forward, "Where the problem stands" item 31, and G51, G71, G72, G79, G82;
- `WORKFLOW.md` step 9 in full;
- `LEDGER.md` rows 131–134 with their § B lines;
- `plans/FS110-derivation.md` (the entry form you will follow) and FS-110's §R-close in `plans/FS110-tangency-seam.md` (the form of yours).

**If `plans/FS112-unit-arc-half.md` already has a section "§R-close", you are resuming.**

## Why the milestone closes now

Kooshi, 2026-09-27 (inventory item 59), verbatim: *"When round 3 finishes, let's close this milestone, and point two milestones at the two gaps, so we can
focus on them specifically. They seem to require more research and careful exploration, and may be more complicated than they appear. Wrap up any further
documentation, and I'll compact now, then we can close out and spend the night on those two."* So there is no fresh advisor stage for round 3: **your
reconciliation is round 3's comparison** (N3 against NB3; Y3 against YB3), as well as the milestone's.

## What you work from

- **`plans/FS112-close-inventory.md`, items 1–62 and whatever the owner adds.** Read every number from the item's source, never from the inventory. **Do
  not edit the inventory** (the owner is still writing to it while a verifier runs): record each item's tick — "done", or "declined" with the reason — in
  `data/fs112/fs112-c/ticks.md` (a table: item, status, reason, where done), and the owner applies them.
- **The reports in `data/fs112/reports/` and the records they name.** Read each record's "Theorems this phase proved" table first, then its sections.
  - The proof side: `plans/FS112-N-proof.md` — FS112-N (stages 1–2), then the sections "§ Continuation — FS112-N2" and "§ Continuation — FS112-N3".
  - The construction side: `plans/FS112-Y-construction.md` (FS112-Y, then "§ Continuation — FS112-Y2") and `plans/FS112-Y3-construction.md` (FS112-Y3).
  - The blind verifiers: `plans/FS112-{NB,NB2,NB3,YB,YB2}-verification.md`, and `plans/FS112-YB3-verification.md` when it reports (below).
  - The prior-art reading: `plans/FS112-PA-reading.md`, `data/fs112/fs112-pa/extracts.md`.
  - The advisors: `plans/POROS-2026-09-27-fs112-unit-arc-half.md` (FS112-A, planning) and `plans/POROS-2026-09-27-fs112-competition.md` (A2, A3), with the
    cards in `data/fs112/fs112-a2/` and `data/fs112/fs112-a3/`.
- **The plan and the claims:** `plans/FS112-unit-arc-half.md` (§G, §PA, §IQ, §5.3's E1–E17, §5.5–5.6) and `data/fs112/claims.md`.

**One verifier is still running: FS112-YB3**, blind on Y3 (the chain-end fragments Y3-END-A/-B, the obstructions Y3-STRIPCUT, Y3-DISK-T* and Y3-LEG, and
the hand claims Y3-END-NEEDS, Y3-T2-BUDGET, Y3-R3, Y3-R1). Do everything else first. When it reports, the owner logs it in the inventory and sends you
one message naming the item; fold it in then (stage 1b). **Never contact FS112-YB3, and never open its record or working directory before the owner's
message** — its record is its own until it hands back. If you reach the end of stage 3 before that message, write the report as far as you are, send it,
and say you are waiting; the owner will resume you.

## The headline rules

- **Grades come from the minds that actually derived.** A lemma a blind verifier confirmed is two minds, one blind; one it did not reach stays at one
  mind. Name every open step. Row 134's base (S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch, CUSP-BASE) is carried at row 134's grade, unre-derived
  here — NB3 §2.3 names it as the place a common error of both walks would sit; say so wherever the headline rests on it.
- **Polarity.** FS-112's question (plan title): *"does a tight six-map exist once boundary arcs of radius 1 are allowed?"* A YES gives `χ(ℝ²) ≤ 6`
  with no MR; a NO answers `[SokolovVoronov2025]` Question 2 ("Is it true that 7 colors are needed …?") **YES** for its unit-arc half and closes door (A).
  FS-110 inverted this once (its inventory item 97); check every sentence you draft.
- **The headline, as round 3 leaves it: not decided; the NO reduced to two named steps, the YES stalled at a named obstruction.** Establish each part
  from the records and state it with its grade.
  - **The NO side.** The links, quoted from their tables: N2-RED with N2-TOWARD, N2-AWAY, N2-TAN (NB2: TRUE, two minds, one blind); N2-DENSE filed in
    NB2's form (inventory item 44); N2-RAY, *"N4-FIN's application fails at a chain's end; a one-sided stuck chain (`λ_k = −1/(k+1)`, `υ_k = 0`) is
    consistent with N4-FIN; N4-CONE is a GAP under unit arcs"*; N3-BASE, *"the base refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)`
    holds a vertex of `≥ 4` colours or a repeated colour"*; N3-DENSE3, *"every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a
    repeated colour"*; N3-PER, *"a doubly periodic valid map has a periodic terminal modification (so finitely many arc classes)"*; N3-END; the GAP N3-ALPH
    (`plans/FS112-N-proof.md` l. 695–699). NB3 confirms every N3 statement blind (inventory items 60–61).
  - **Derive, do not assert, how the two gaps compose into a NO**, and state it as one sentence with its grade: which valid maps the chain already
    refutes, what exactly is left — (1) **the global step**, excluding maps in which a vertex of `≥ 4` colours or a repeated colour lies within 3 of every
    point, and (2) **the non-periodic stuck ray** (N3-ALPH / N3's (b′)) — and how they interact with the cone removal (N2-DENSE's "or a stuck vertex within
    3" in the terminal map). In particular: **for doubly periodic maps, does the NO reduce to the global step alone** (N3-PER closing the ray there)? If
    the composition has a step no record derives, name it as a third GAP rather than bridge it.
  - **The YES side.** CAL-STRIP and CAL-DISK exact and robust (two blind rebuilds each, two checkers each); every arc "both"-kind at a four-colour vertex;
    both positives stop at a pinned corner (Y2-PIN; YB2 O2, two minds, one blind); the dial stalls (Y2-MOVE, 108° → 36°, two minds); the strip's
    colourless cone corrected to `(arcsin ¼, 180° − arcsin ¼)` (item 54); φ attained (YB2-DISC); Y3's obstructions and Y3-END-NEEDS at whatever grade
    YB3 leaves them.
- **Propose ledger rows.** The next free number is 135; rows are never renumbered. My expectation, which you may overrule with a reason: **row 135** the NO
  side's reduction (RED, BASE/DENSE3, RAY with its extremal pencil, PER, END — each at its grade — and the two GAPs named); **row 136** the YES side (the
  positives' exact status, the pinned-corner law, the stall, Y3's obstructions); § B lines for everything else. The ledger checker
  `tools/fs71_ledger_b_check.py` skips three header shapes silently, so every derivation header uses an ASCII id, puts no parenthetical before the dash,
  and nests no brackets inside a grade; run `--strict` on your draft before you save.
- **Prior art and posed questions.** `[Polymath2021]` p. 199 poses FS-112's question; `[SokolovVoronov2025]` Question 2's unit-arc half; `[Parts2021]`
  p. 182 (the tactic saving colours). Say whether anything answers a posed question (`CLOSED-QUESTIONS.md`), and do not stretch: my reading is that
  nothing is answered and the note is a partial reduction — overrule it with a reason if the records say otherwise. `BIBLIOGRAPHY.md`: items 16 and 55.
- **Corrections owed** (draft each, with both addresses): items 6, 9 and 28 (NB-4's general form as NB4′, in `plans/FS110-derivation.md` l. 42 and row
  134's § B line); 15 (Gibbs, not de Grey); 29 (the frozen N tool's twin plants — answered by N2's plants? say so); 34, 46, 54, 61, 62; N's row 9
  overstatements (item 39); N112-RED's merge unneeded at cubic centres and CE5's in-vote count (item 51). Side records are never rewritten: corrected
  statements go into the derivation file, and §R-close lists every erratum with its address.

## The two successor stubs (Kooshi's ruling: ranked 1–2, above FS-111)

Write both stub files under WORKFLOW's stub rule — plain language, full mission context, everything this milestone learned about the step (the
observations, the held objects that realise the escape locally, the registered expectations with both outcomes reachable, the failure clauses, the named
deliverables) and a **provisional-bearings line** — so a fresh session with no memory of tonight can plan it. Kooshi expects both to "require more
research and careful exploration": give each a reading section naming the disciplines and the held papers whose methods bear, and the questions a
prior-art gate should ask, not a route chosen in advance.
- **FS-114, the global step** (suggested `plans/STUB-global-step.md`): exclude valid maps whose vertices of `≥ 4` colours or a repeated colour lie within
  3 of every point. The construction side's handles: the pinned corner (Y2-PIN, Y3) and the T2 budget (Y3-T2-BUDGET). Say whether it is decisive alone for
  periodic maps (from your composition above).
- **FS-115, the non-periodic stuck ray** (suggested `plans/STUB-stuck-ray.md`): N3-ALPH / (b′); the candidate route Y3-END-NEEDS with N3-END; NB2's
  extremal object, the pencil of circles of radius `k + 1` about `P_{−1}`; N3-RAYR's growing radii.
- **Re-aim FS-111** (`plans/STUB-reg-scale.md`): its bearing names "FS-112's unit-arc half"; point it at FS-114 and FS-115. Put a closed banner on
  `plans/STUB-unit-arc-half.md`. Place Y2's leftovers (item 47: the `κ = ±1` horn fragment, C-HOCK's mis-aimed instance, the strip's colour-4 cut) in a
  stub or decline each with the reason.

## Stages (save after each)

1. **Reconciliation** — 1a now: every claim and lemma, its verdict, its minds and their blindness, every divergence and how it was settled, with round 3
   compared (N3 against NB3 in full; Y3 against its record). 1b when the owner's message comes: Y3 against YB3. Save.
2. **`plans/FS112-derivation.md`** (new), in `plans/FS110-derivation.md`'s entry form. Save.
3. **§R-close** in `plans/FS112-unit-arc-half.md`. Save. It covers: the §G re-read (which extractions paid, which entry should have borne and was not
   used); the §PA sweep (what the prior-art work taught about the object itself — promote each to a grokking or a stub, or decline); the §IQ re-read with
   G72's count and G79's record for FS-112; E1–E17 scored, with every competitor's and advisor's registered prediction; the verdict in four parts; the
   would-have-searched lines.
4. **Drafts in §R-close, never in the target files**, then the two stub files, then the report. The drafts:
   - `LEDGER.md` rows 135+ and the § B lines;
   - `CLAUDE.md`: "Last updated"; "Open milestones"; the paths-forward rows (FS-112 closed, FS-114 and FS-115 at ranks 1–2, FS-111 re-aimed); § The aim's
     programme line; "Where the problem stands" item 31; G82 if it needs a clause; any correction owed. **The budget:** `CLAUDE.md` is 296,992 bytes
     against its 300,000 limit. Every new line must be paid for — point to ledger rows instead of retelling them, and move later instances out — so that
     the front page lands under the limit without cutting an intrinsic. Measure your drafts' net bytes and state them;
   - a new grokking only if the milestone earned one, in G67's form (trigger, *Do*, killing test or what it forbids), with its byte cost — or say why
     none;
   - `BIBLIOGRAPHY.md` (items 16, 55); the `CLOSED-QUESTIONS.md` note; `plans/FRONTIER-STUBS.md` (FS-112 to the closed list; FS-114, FS-115 ranked);
   - `plans/GROKKING-INSTANCES.md` entries: G51's run (three advisors in succession, replaced at about 480k and 550k; the separate record file that kept a
     running verifier blind to its side's next round, item 50; the close comparing round 3 in place of an advisor), G72's count, G79's record, the owner's
     quotation and pointer slips (items 32, 34, 62), the fence listings;
   - the protocol amendment for `plans/PROTOCOL-competitor-and-advisor.md` (the separate record file; the close as the last round's comparison);
   - claim-list corrections, as an appended section of `data/fs112/claims.md`, which you may write directly.

## Rules

- **Touch only:** `plans/FS112-derivation.md`, `plans/FS112-unit-arc-half.md` (§R-close only), `plans/STUB-global-step.md` and `plans/STUB-stuck-ray.md`
  (or the names you choose), `plans/STUB-reg-scale.md` (its bearing and provisional-bearings lines only), `plans/STUB-unit-arc-half.md` (a banner),
  `data/fs112/claims.md` (the appended section), and `data/fs112/fs112-c/`. Never touch the front files (`CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`,
  `CLOSED-QUESTIONS.md`, `plans/FRONTIER-STUBS.md`), the protocols, the instances file or the inventory.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **Machine:** anything over about 2 minutes or 2 GiB runs under `scripts/slot.py` (standing rule 8). Frozen tools are run, never edited.
- **Contact:** only `"main"`. Never message any other agent, running or idle.
- **Commits:** by explicit path, with subjects "FS112-C: stage n". Never amend. Push after each; never force-push.
- **Report** (standing rule 9) to `data/fs112/reports/FS112-C.md`, committed, and by SendMessage to `"main"`. Your final turn's text: "FS112-C idle;
  report sent to the owner by SendMessage".

Thank you.
