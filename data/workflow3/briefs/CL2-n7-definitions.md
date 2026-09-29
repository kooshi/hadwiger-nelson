# Brief CL2 — the Clerk: extract, verbatim, the definitions a blind verifier needs for one FS-114 statement

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: CL2
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow
  role: a reading-and-copying job: find where each listed term is defined in FS-114's records and copy the definition verbatim with its address; decide nothing
  launch: now
  mission: § Why this job
  statements: none — a copying job; the terms to find are listed in § The terms
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — you are not blind; but your output goes to a blind verifier after the coordinator vets it, so it must carry definitions only (§ What must not be copied)
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/CL2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-CL2-n7-definitions.md`
  touches: `plans/WORKFLOW3-CL2-n7-definitions.md`, `data/workflow3/cl2/`, `data/workflow3/reports/CL2.md`
  budget: about 150k by the harness's count, as guidance; hand back at a saved stage before about 250k

Hello. This is a short copying job for a blind verifier, and the care is in what is left out.

## Why this job

A blind second mind (FS116-V1) is re-deriving the statement FS114-N7-3T, quoted in `data/fs116/claims.md` § 8. The statement uses terms
defined only in FS-114's records, which the verifier is fenced from because those records also hold the first derivation's route. It asked
for the definitions only. You find them and copy them; I check your file and give it to the verifier.

## The terms

The verifier's questions, verbatim from its message to me:
- (N1) "the sign of a tactic edge (+ / −), and the order convention in "+−+", "++−", "−++""
- (N2) ""Reuleaux lens", "non-Reuleaux lens", "60° anti-lens", "cap"/"caps", "open-cap family OC" and its members, "Reuleaux bowtie whose lenses
  do not border the caps""
- (N3) "what the 4-tuple in "the (2, 1, 1, 0) patterns" counts"
- (N4) ""the pinwheel" and "γ" (in "γ = 0°")"
- (N5) ""die in every member": member of which family, parametrised how"
- (N6) ""excluded at radius 1 + ε": the exact meaning (no valid fragment on B̄(p, 1 + ε) for some ε > 0? for every ε > 0? containing a
  neighbourhood of B̄(p, 1)?), and whether "non-Siamese and simple" is a hypothesis of the headline exclusion or only of the N7-HUB
  parenthetical"
- (N7) ""(Q)-free ring" and "(Q)-free after the bends" (which bends); "a four-colour vertex" (exactly four colours, or at least four); "tip";
  "p-tiles face away""

Also copy, verbatim, only the `statement:` and `not claimed:` fields of the entry `derivation: N7-3T` (or `FS114-N7-3T`) in
`plans/FS114-derivation.md`, and nothing else from that entry.

Where to look: `plans/FS114-derivation.md` (its header and the entries' statements), `plans/FS114-N7-proof.md` (its definitions and
notation sections), `plans/FS114-N-proof.md`, `plans/FS114-N3-proof.md`, `plans/FS114-Y*-construction.md`, and `data/fs114/claims.md`.
Search by the term; take the passage where the term is defined, not where it is used.

## What must not be copied

The verifier must not learn how the first mind proved the statement, or whether it did. So copy **only the defining sentence or clause**
of each term. Leave out every sentence that says what is excluded, what dies, what is forced, why, at what radius a configuration fails,
or which lemma does it; leave out every `argument:`, `uses only:`, `verdict:`, `minds:` and `model:` field. If a term has no definition
apart from such a sentence, do not copy it: write "no separate definition found; defined in use at <address>" and put it on a `CHECK:` line.
For N6's second half (which hypotheses the headline carries), copy the entry's `statement:` field and add nothing.

## Done means

1. `data/workflow3/cl2/n7-definitions.md`: one section per question N1–N7, each definition as a blockquote with its source address
   (file and line, or file and section) under it, then the entry's `statement:` and `not claimed:` fields in the same form.
2. **Your record**, `plans/WORKFLOW3-CL2-n7-definitions.md`: the readback, and for each term where you found it and anything you left out and why.
3. **The report** in the standing rules' form, with `CHECK:` lines for every term you could not find as a definition. Your last words are
   exactly "CL2 idle; report sent to the coordinator".

## What is yours to decide

Only which passage is the definition. When two passages define a term differently, copy both with their addresses and put a `CHECK:` line.

## Stages (save and commit each; standing rule 2)

1. The readback and the search, term by term.
2. The definitions file, then the report.

Thank you.
