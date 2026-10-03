# Brief FS129-MA1 — pass 2 of the cross-application audit, lane A: where each mechanism of the arithmetic era bears and was not applied

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-MA1
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; invoke `ephodos-recognition` fresh with the Skill tool when a mechanism almost applies
  role: pass 2 of FS-129, lane A (arithmetic era): each mechanism the lane owns, followed to every place it bears across the whole corpus; each composition derived; each miss recorded
  launch: now; FS129-OA1 (lane A, pass 1) has reported, and FS129-OR1 (lane R, pass 1) is still running and writes only its own files
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1); every lane's files are open to you, and each writes only its own
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait (a statement defect, a refutation of a held result); the report goes to `data/fs129/reports/FS129-MA1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-MA1-audit.md`
  touches: `plans/FS129-MA1-audit.md`, `data/fs129/ma1/`, `tools/fs129_ma1_*.py`, `data/fs129/reports/FS129-MA1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the second-pass reader of lane A in an audit Kooshi asked for: everything this project has derived was derived for the
milestone that needed it, and the audit asks where else each result bears. Pass 1 went step by step down a ranked list of open steps.
Your pass goes the other way, mechanism by mechanism: for each mechanism your lane owns, find every place it is used, and every place
across the whole corpus — both eras — where it bears and was not applied. This is the failure that prompted the audit.
Your lane owns 70 grokkings, too many for one context, and that is planned for: take them in order of reach, save as you go, and hand
back at a saved stage with the rest listed; a successor, FS129-MA2, continues from your record (`plans/FS129-close-inventory.md` item 52).
Stopping with a list of what is left is a good report. Pass 1 of your lane found the audit's one cross-era hit so far: the finite plane
over the integers mod 11, Γ₁₁, with room to spare at five colours (row 66), bears on FS-104's route to six (FS129-OA1-NOLIN5, -FALC-RED,
-FALC-11, -NOPERLAW; `plans/FS129-OA1-audit.md`). Your first mechanisms are the ones behind that hit.

## Why this job

The plan, `plans/FS129-cross-application-audit.md`, is your specification: § 3's Stage 3 is yours; § 5 is the era split; § 7 sets grades,
expectations and failure. The stub, `plans/STUB-cross-application-audit.md`, holds the instances that prompted the audit (§ Why now) and
Poros's question card (§ The question): ask of each site what kind of input closes it, and whether your mechanism delivers that kind under
another name. The prompting instance is your pass's exact target: FS-116's double tip was worked for two rounds as though inhabited
while G83's straddle, held, would have emptied it at once (`plans/FS116-close-inventory.md` items 122, 124, 127). Closed forms and
identities are mechanisms too: Kooshi asked of one, "where else can we use that identity?" (`plans/FS116-close-inventory.md` item 142).

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> 1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, and also use general purpose agents instructed to read the deriver's identity, rather than the agent files which carry the 150k token grokkings. They'll have enough on their plates without needing all that context, and they can read them if needed. 3. yes, excellent idea. 4. definitely. Please set up the plan file and handoff, and I'll restart a new session after restarting the handoff so it'll pick up the latest changes.
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

## Who you are, and how to load it

You are a `general-purpose` agent, by Kooshi's decision 2, so that the grokkings (about 150k tokens) are not loaded into you at launch.
Read, in order: `.claude/skills/ephodos/SKILL.md` in full — the deriver's identity, which is yours for this job; then
`.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end, of which `## A derivation job` and `## What
leaves your lane` govern you. You read a grokking by its number when you need it —
`awk '/^\* \*\*G83 —/{p=1;print;next} /^\* \*\*G[0-9]+ —/{p=0} p' .claude/skills/grokkings/SKILL.md` prints G83 — and since your pass is
organised by grokking, you will read your lane's in full, one at a time; you need not load the others. `CLAUDE.md` § Grokkings'
theory-in-one-paragraph is the map.

## What you work from

- **Your mechanisms**: lane A's 70 live grokkings (G1 G4 G5 G6 G7 G8 G9 G10 G11 G12 G13 G14 G15 G16 G17 G18 G19 G20 G21 G22 G23 G24 G25 G26 G27 G28 G29 G31 G32 G33 G34 G35 G36 G37 G38 G39 G40 G41 G42 G43 G44 G45 G48 G52 G53 G54 G55 G56 G57 G58 G59 G60 G61 G62 G63 G64 G65 G66 G68 G69 G70 G71 G73 G74 G75 G76 G77 G78 G79 G80; `plans/FS129-close-inventory.md` item 51 — retired entries are cautions, not
  mechanisms; G87 is a method and no lane's), plus the mechanisms named in held results rather than in a grokking. **Work in this order**:
  (1) pass 1's leads — row 66's fan gap and slack residue plane at 11 (G13, G66, row 66), Hoffman tightness (G54), the Falconer fan
  (FS129-OA1-FALC-RED), the ring winding (FS129-OA1-RINGWIND, G71); (2) the rest by reach — mentions in `data/fs129/index/grokking-uses.md`
  (G54 23, G56 20, G55 13, G1 11, G35 11, G21 10, G48 10, G7 9, G31 8, …), hubs and roots; (3) the 17 lane-A grokkings no entry mentions by
  number (G5, G6, G8, G10, G11, G15, G17, G18, G19, G20, G22, G25, G28, G33, G39, G77, G78), which are where an unapplied mechanism is likeliest
  to hide. **Before anything builds on FS129-OA1-FALC-RED, your first stage confirms `[Falconer1981]` Lemmas 1–4 against the paper**, held at
  `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`: pass 1 used them as
  `plans/FS103-M-derivation.md` § 1.2 quotes them and did not re-read the PDF (item 41). Record each lemma's statement as the paper gives it,
  page and number, and any difference from the quotation, as a finding
- **Pass 1's records**: `plans/FS129-OA1-audit.md` (lane A, done) and `plans/FS129-OR1-audit.md` (lane R, still running when this brief was written — read whatever it has saved), with their reports in
  `data/fs129/reports/`. Their compositions are held at one mind for your purposes; their nulls tell you where a mechanism was looked for
  and not found. Do not redo a step pass 1 closed.
- **The demand list**, `data/fs129/demand-judged.md`: its § 1 (words that mean two things across the eras) is required reading before your
  first mechanism, and its § 2 (no-gos that exclude kinds of input) tells you where a mechanism cannot bear.
- **The index**, `data/fs129/index/` (its `data/fs129/index/README.md` says what it cannot see): `data/fs129/index/grokking-uses.md`, the
  entries that mention each grokking — a mention is a `G<n>` token, so an upper bound and sometimes another object called G-something;
  `data/fs129/index/theorems.jsonl`; `data/fs129/index/edges.csv`; `data/fs129/index/hubs.md` and `data/fs129/index/roots.md` (weigh a deep
  root as a hub; 87 of the 100 roots are lane R because older records name dependencies only in prose); `data/fs129/index/statements-A.md`
  and `data/fs129/index/statements-R.md`, the statements one per line. The places a mechanism bears and was not applied are by definition
  where it is not mentioned: search the statements by the mechanism's content, in both eras' words, not by its number.
- **The derivation files**, `plans/*-derivation.md`, read by entry, never whole; `LEDGER.md` by row.

## Done means

1. **Registered expectations** in your record's first saved stage, before you read the corpus: how many mechanisms you expect to bear
   somewhere unapplied, how many compositions, and your probability that one changes the bearing on the answer.
2. **One section per mechanism**: what it is, in one plain sentence and with its address; the kind of input it delivers (the card's list);
   the places it is used (by id); and every place it bears and was not applied, each as one of —
   - **a composition**: a `derivation:` block in your identity's grammar (id `FS129-MA1-<NAME>`), `uses only:` by id, `not claimed:`,
     argument in your record, verdict, grade, `minds: 1`, `handoff:` de Bruijn, and the site it serves — gated with
     `python3 .claude/skills/ephodos/scripts/derive_gate.py all <record>` before each stage's commit;
   - **a miss of the FS116-Y4 kind**: a milestone worked a step the mechanism would have shortened or emptied — say what it would have
     given, and derive it if it still matters;
   - **a near miss**: the hypothesis that fails at that site, named.
   A mechanism that bears nowhere new is a null, with what you searched.
3. **A table of misses** at the end of the record: mechanism, site, what it would have given, derived or not. Pass 3 and the record job
   read it first.
4. **The heading "Theorems this phase proved"**, one line per composition with its grade and address, or a line saying none.
5. **Your report** in standing rule 11's form; `search request` items for anything a search could decide (no job searches).

## What is yours to decide

The order of mechanisms (by how far each could reach, roots and hubs first, is one way), how deep to follow each, and when a near miss
deserves a derivation. If a mechanism your lane owns is really the other lane's, or one grokking is two mechanisms, say so. If a held
result looks false as you read it, stop and message the coordinator.
