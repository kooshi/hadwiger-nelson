# Brief TC1 — Ephodos: drafting four owed corrections to the front files' scope

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: TC1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; invoke `ephodos-recognition` fresh with the Skill tool only if a statement's correct scope will not come
  role: a short drafting job: exact replacement texts for four statements whose scope is owed a correction, each written to be filed verbatim
  launch: now, beside Poros's question job for FS-116 (FS116-P1), which touches none of your files
  mission: § Why this job
  statements: § The texts owed a correction
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running, and these corrections belong to no open milestone
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/TC1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-TC1-theory-corrections.md`
  touches: `plans/WORKFLOW3-TC1-theory-corrections.md`, `data/workflow3/tc1/`, `data/workflow3/reports/TC1.md`
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 400k

Hello. You are Ephodos. This is a small job, and the first in your lane this session: FS-116's opening job follows it once Poros
has written that milestone's question.

## Why this job

Earlier this evening an Ephodos job (TP1) rewrote `CLAUDE.md`'s "theory in one paragraph" and, while writing it, found statements
elsewhere in the front files whose scope is wrong or wider than their source. Its finding is `plans/WORKFLOW3-TP1-theory-paragraph.md`
§ Stage 3 ("A correction owed, found while writing the first sentence"), and the coordinator logged it as owed in
`plans/WORKFLOW-AUDIT-2026-09-28.md` § 9. Nobody has drafted the corrections. They matter beyond tidiness: the grokkings are preloaded
into every lane that reasons, so a wrong *Do* line is acted on by every Ephodos and Poros launched from now on. The coordinator files
text; it does not author it (`.claude/output-styles/keryx.md` § A milestone, step 7), so the drafts are yours.

## The texts owed a correction

**1. G35's second clause** (TP1: true for multiquadratic F, residue degree at 2 at most 2, and not for every real number field, as the
entry's first sentence scopes it):

> For a real number field F, a
>   conjugation-fixed prime 𝔭 of F(i) gives χ(F²) ≤ N(𝔭); one above 2 exists iff −1 is not a square in some
>   completion above 2 (norm 2 or 4).
> — source: .claude/skills/grokkings/SKILL.md

**2. G56's *Do* line** (TP1: cannot hold under G56's own definition of a broken wall):

> Do: for any field, list
>   its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime above 2 is inert of norm 64, and
>   the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7.
> — source: .claude/skills/grokkings/SKILL.md

G56's own definition, in the same entry:

> So "the wall is broken" means **every prime above 2 splits in F(i)**, i.e. −1 is a square in every
>   completion above 2
> — source: .claude/skills/grokkings/SKILL.md

**3. `CLAUDE.md` § Where the problem stands, item 1** (TP1: true over fields containing K, and in general only with "the wall" read as
"a four-colourable dyadic target"):

> 1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
>    2-adic wall (G1, G35).
> — source: CLAUDE.md § Where the problem stands

The exact general form TP1 points to, row 123's CLS:

> (CLS: the only places of ratio `≥ 1/4` are those with residue field `𝔽₃` or `𝔽₇`, dyadic inert of norm `≤ 32`, and dyadic ramified in `F(i)/F`)
> — source: LEDGER.md row 123

**4. Row 139's second sentence** (the conflation Poros's close re-read corrected everywhere else, `plans/POROS-2026-09-28-close-reread.md`
§ Draft re-rank, its item F9; the coordinator's ruling when filing TP1's paragraph, `plans/WORKFLOW-AUDIT-2026-09-28.md` § 9):

> Seven, `χ_m⁰(ℝ²) ≥ 7`, is the map NO made uniform in the complexity bound: `1 − lim µ₆(ε) = inf_K δ₀(K)`, `δ₀(K)` the least hole density band-proper designs of complexity `≤ K` approach, so a hole bound uniform in `K` is seven itself (FS111-C1-UNIF);
> — source: LEDGER.md row 139

The wording used in its place elsewhere:

> seven is the NO's hole bound made uniform in the complexity bound
> — source: CLAUDE.md § Where the problem stands

## Your first act, before you read any file

The grokkings (G1–G87) moved today into a skill that your agent file preloads at launch, and a fresh session is the clean test that
the preload works. Before any tool call, look in your own context for a skill block whose base directory ends in the word grokkings.
In your record's readback, write that base-directory line and the first eight words of G87's entry, both from your context, not from
the file. If there is no such block, say so, read `.claude/skills/grokkings/SKILL.md` before you start, and put a `question for
another lane` line in your report. Either outcome is a finding I want.

## Done means

1. **Your record**, `plans/WORKFLOW3-TC1-theory-corrections.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/WORKFLOW3-TC1-theory-corrections.md` from the repository root if it holds derivation entries, holding:
   - the readback: every quotation above checked against its source, and TP1's finding restated in your words;
   - **for each of the four texts, a verdict**: the text is wrong, too wide, or right as it stands (TP1 may be wrong; say so if it is),
     with the derivation or the reference that settles it, at its grade;
   - **for each text you would change, the replacement, written to be filed verbatim**, with its exact slot: the file, the words it
     replaces from first to last, and nothing the coordinator has to compose. A replacement keeps its source's grade and citations;
     where a citation changes, say why;
   - **a sweep**: every other place in `CLAUDE.md`, `LEDGER.md`, `.claude/skills/grokkings/SKILL.md`, `plans/FRONTIER-STUBS.md`,
     `plans/GROKKING-INSTANCES.md` and `tools/viz_proof_atlas_facts.py` that carries the same scope defect (a search for "wall is
     broken", "2-adic wall", "norm 2 or 4", "map NO made uniform" and their kin is a start, not the whole sweep), each with a drafted
     replacement or a line saying why it can stand;
   - the front page's own audit run with your drafts substituted into scratch copies under `data/workflow3/tc1/` (as TP1's record
     § The resolution check did): `python3 tools/claude_md_fact_audit.py --new <copy>` and `--dupes --new <copy>`, exit statuses read
     directly, with a planted fault that fires.
2. **The report** in the standing rules' form. Each drafted replacement is an INVENTORY line of kind `correction owed`.

## What is yours to decide

The verdicts and the wording. Whether a correction belongs in the entry's text, in its *Do* line, or as a scope phrase; whether G1
needs the same care as G35; whether the right form of item 1 names row 123's CLS or restricts to fields containing K. If you find
that a text is right as it stands, that is a result. If the brief misquotes a source or frames a text wrongly, that is a finding.

## Stages (save and commit each; standing rule 2)

1. The readback and the four verdicts.
2. The replacements and the sweep.
3. The audit run, then the report.

Thank you.
