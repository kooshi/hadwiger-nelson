# Brief FS129-MR1 — pass 2 of the cross-application audit, lane R: where each mechanism of the regularity-wall era bears and was not applied

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-MR1
  identity: Ephodos, the deriver, read as files — `.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from its line `# Ephodos in lean-dir — the workflow` to its end; invoke `ephodos-recognition` fresh with the Skill tool when a mechanism almost applies
  role: pass 2 of FS-129, lane R (regularity-wall era): each mechanism the lane owns, followed to every place it bears across the whole corpus; each composition derived; each miss recorded
  launch: now; FS129-OR1 (lane R, pass 1) has reported; FS129-MA1 (lane A, pass 2) is running and writes only its own files
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1); every lane's files are open to you, and each writes only its own
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around or a finding that cannot wait (a statement defect, a refutation of a held result); the report goes to `data/fs129/reports/FS129-MR1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Rule 1 matters more for you than for most: you are a general-purpose agent and carry the Agent tool, which the lane agent files withhold
  record: `plans/FS129-MR1-audit.md`
  touches: `plans/FS129-MR1-audit.md`, `data/fs129/mr1/`, `tools/fs129_mr1_*.py`, `data/fs129/reports/FS129-MR1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the second-pass reader of lane R in an audit Kooshi asked for: everything this project has derived was derived for the
milestone that needed it, and the audit asks where else each result bears. Pass 1 went step by step down a ranked list of open steps.
Your pass goes the other way, mechanism by mechanism: for each mechanism your lane owns, find every place it is used, and every place
across the whole corpus — both eras — where it bears and was not applied. This is the failure that prompted the audit.
Your lane's pass 1 closed the audit's top step: FS129-OR1-QFREE (derived, one mind) answers the top-ranked stub's first question — bending a
fragment on a whole-tile restriction of radius at most √3 keeps it in FS116-Y4-EMPTY's class with only (Q) arcs on its ring
(`plans/FS129-OR1-audit.md` § Stage 2; `plans/FS129-close-inventory.md` item 54). The mechanisms behind that close, and the one whose
neglect prompted this audit, are your first.

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

- **Your mechanisms**: lane R's 12 grokkings — G2, G3, G81, G82, G83, G84, G85, G86, G88, G89, G90, G91 (`plans/FS129-close-inventory.md` item 51; G87 is
  a method and no lane's) — plus the mechanisms named in held results rather than in a grokking. **Work in this order**: (1) **G83's
  straddle** — the mechanism FS-116 held and did not apply to the double tip for two rounds (the stub's § Why now): every other place it
  bears; (2) **the bends** (FS112-N2-BENDS, -N2-AWAY, -N2-TOWARD, -N2-TAN) in the generality pass 1 found — they need only that one side
  colour of each ring arc is absent at the centre (FS129-OR1-BEND3, -WHOLE; item 61) — and every exclusion they now reach; (3) **two closed
  forms**: FS116-V6's identity `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)` (V6-HUG; displayed at line 159 of `plans/FS116-V6-verification.md` § 2.2 as `|a(s) − b(t)|² − 1`, negative for `0 < s, t ≤ 60°`, with
  `a(s)` and `b(t)` defined there — read the display, not this paraphrase), of which
  Kooshi asked "where else can we use that identity?" (`plans/FS116-close-inventory.md` item 142), and FS129-OR1-WHOLE's
  `|x − e|² = (|x|² + |x − 2e|²)/2 − 1` for a unit vector `e`, which stops working at √3; (4) pass 1's leads (item 62): FS110-A3-HOLE and
  FS110-N2-SWAP fail exactly where the unit circle carries an arc of Γ, which BEND3 and BENDFRAG remove below √3 — is their reading radius
  inside √3?; FS-112's stuck ray (FS112-N2-RAY) and FS-121's tangent pencils (FS121-O1-OUT), which pass 1 reads as one object; FS111-M4-CUT
  and FS121-D4-FACE, one sagitta; lane A's open question, "compute the winding jump at (u, p, v) on ω(y)", where u, p, v are consecutive
  points of one hexagon of ω(y) (`data/fs129/reports/FS129-OA1.md`); (5) the rest of your grokkings by reach — G84 is the most mentioned —
  then hubs and roots (`data/fs129/index/roots.md`: the deepest chains start at FS111-V0-ID1 and FS111-C-HULL-SO, 13 edges). Merges you
  find are pass 3's to make: note them in your table of misses, and derive only what a merge newly gives
- **Pass 1's records**: `plans/FS129-OA1-audit.md` (lane A, done) and `plans/FS129-OR1-audit.md` (lane R, done), with their reports in
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
   - **a composition**: a `derivation:` block in your identity's grammar (id `FS129-MR1-<NAME>`), `uses only:` by id, `not claimed:`,
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
