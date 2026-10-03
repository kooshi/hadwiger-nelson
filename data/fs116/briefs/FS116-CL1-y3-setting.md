# Brief FS116-CL1 — the Clerk: extract, verbatim, the setting a blind verifier needs for three FS-116 statements

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-CL1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow
  role: a reading-and-copying job: find where each listed term is defined in one construction record and copy the definition verbatim with its address; decide nothing
  launch: now
  mission: § Why this job
  statements: none — a copying job; the terms to find are listed in § The terms
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — you are not blind; but your output goes to a blind verifier after the coordinator vets it, so it must carry definitions only (§ What must not be copied)
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-CL1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS116-CL1-y3-setting.md`
  touches: `plans/FS116-CL1-y3-setting.md`, `data/fs116/cl1/`, `tools/fs116_cl1_*.py`, `data/fs116/reports/FS116-CL1.md`
  budget: about 150k by the harness's count, as guidance; hand back at a saved stage before about 250k

Hello. This is a short copying job for a blind verifier, and the care is in what is left out. It has the shape of an earlier job of yours
(`data/workflow3/briefs/CL2-n7-definitions.md`, with its record `plans/WORKFLOW3-CL2-n7-definitions.md`), which did it well; read both as the example.

## Why this job

Three statements on FS-116's frozen claim list, `data/fs116/claims.md` § 12 (its last three bullets: FS116-Y3-NBTIP, FS116-Y3-TIGHTLENS,
FS116-Y3-STARFORCE), use labels and terms defined only in the record that proposed them, `plans/FS116-Y3-construction.md`. A blind verifier will
re-derive them, and it is fenced from that record because the record also holds the first derivation's route. A verifier found the gap at its
readback, and the statements were withdrawn from its job until their setting could be frozen beside them (`plans/FS116-close-inventory.md` items 90–91).
You find the definitions and copy them; I check your file and freeze it in the claim list.

## The terms

Each term as the three statements use it. Search by the term; take the passage where it is defined, not where it is used.
- (T1) **FS116-Y3-SIX and FS116-Y3-TIPS themselves**: copy, verbatim, only the `statement:` and `not claimed:` fields of the entries
  `derivation: FS116-Y3-SIX` and `derivation: FS116-Y3-TIPS`, and nothing else from those entries. ("FS116-Y3-TIPS's setting" and "labelled as
  FS116-Y3-TIPS" in the statements mean these.)
- (T2) the labels: the hubs `y_k`; the tiles `T1`, `T2`, `T3`, `T4` and their colours `1, 2, 3, 4`; the edges `δ_1`, …, `δ_4` of `p` and **the range**
  of each `δ_i` (TIGHTLENS's "generic star" speaks of "its range"); `X`, `X̄`.
- (T3) **hub**, **tip**, **outer tile**, **outer colour**, **single tip**, **double tip**, **Γ-free** (or "whose ring carries no arc of Γ").
- (T4) `q_k`, **lens** `L_k`, **far vertex**, `R_{k,k+1}`, **tight lens**, "lens beside a single tip", **lens points** (STARFORCE's "the lens points carry
  colour 2").
- (T5) **star**, **generic star**, **boundary value**, **flanking direction**, **tight at p** ("the tip of one of its two hubs is tight at p for that hub").
- (T6) anything else in the three statements' text, as quoted in `data/fs116/claims.md` § 12, that the record defines and § 0, § 10 or § 13 of the
  claim list does not; list each with its address.

Where to look: the record's header paragraph *Notation*; § 2.2 (the paragraph that names the tiles by role); the italic paragraph opening § 3; the
entries' `statement:` fields. The claim list's § 13 (frozen today) already quotes another record's notation paragraph defining **tip**, **outer tile**
and **hub**: where the construction record defines one of these, copy its definition anyway, and put a `CHECK:` line if the two differ in any word
that changes the meaning.

## What must not be copied

The verifier must not learn how the first mind derived the statements, or whether it did. So copy **only the defining sentence or clause** of each term.
Leave out every sentence or clause that says what is excluded, what dies, what is forced, why, at what radius a configuration fails, or which lemma
does it; leave out every `uses only:`, `argument:`, `verdict:`, `grade:`, `minds:`, `model:`, `prior art:` and `handoff:` field. Two examples from the
italic paragraph opening § 3, so the line is clear:
- "their ring tiles meet a double tip's tight edge (FS116-Y3-TIGHT)" is a claim, not part of what "tight lens" means: copy the sentence up to the colon
  and stop, and say in your record that you cut it there.
- "each is an edge of `p` along a flanking direction `60k ± 90°` of some hub, with that hub's tip on its side — the tip **tight at `p`** for that hub" mixes
  a claim (that a boundary value is such an edge) with a definition (of "tight at p" and of "flanking direction"). Copy the whole sentence, mark it
  with a `CHECK:` line naming the claim inside it, and let me cut it.
If a term has no definition apart from such a sentence, do not copy it: write "no separate definition found; defined in use at <address>" and put it on
a `CHECK:` line. A range that § 2.2 states as a conclusion ("with `δ_1 ∈ [30°, 90°]`, …") is copied with a `CHECK:` line saying so; it may be the
definition of "its range", and that is my call.

## Done means

1. data/fs116/cl1/y3-setting.md (a new file): one section per group T1–T6, each definition as a blockquote with its source address (file and line, or file and
   section) under it; T1's fields first.
2. **Your record**, `plans/FS116-CL1-y3-setting.md`: the readback, and for each term where you found it and anything you left out and why.
3. **The report** in the standing rules' form, with `CHECK:` lines for every term you could not find as a definition and every cut you want me to make.
   Your last words are exactly "FS116-CL1 idle; report sent to the coordinator".

## What is yours to decide

Only which passage is the definition. When two passages define a term differently, copy both with their addresses and put a `CHECK:` line.

## Stages (save and commit each; standing rule 2)

1. The readback and the search, term by term.
2. The definitions file, then the report.

Thank you.
