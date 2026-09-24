Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to open milestone **FS-85, can four-colour rigidity exist without triangles?**, as its planner. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than contribute to the mathematics, so the mathematics of the plan is yours. I'll score it by artifact.

## Read first, from disk

1. **The house standard:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot. `CLAUDE.md` changed today in three places:
   - FS-81's close (rows 82–84, G74);
   - § Building's resource rule;
   - § Toolchain's finite-witness-free week.
2. **The milestone:** `plans/STUB-four-colour-rigidity-without-triangles.md`, in full. It carries:
   - the mission;
   - step 1 (FS-74's lead) and step 2;
   - the controls;
   - a §IQ draft for you to rewrite;
   - the outcomes and the experiment's verdicts;
   - the killing test;
   - the reading owed;
   - the provisional bearings.
3. **Why it was chosen:** `plans/POROS-2026-09-24-algebra-week.md` §4–§6: the premise check, the ranking, the ban's scope and the verdicts. Kooshi chose its rank 1, with rank 2 (FS-83) as the fallback, and confirmed its scope.
4. **The rules and the stage design:** `plans/SESSION-HANDOFF-2026-09-24-fs85-open.md`.
5. **The stub FS-85 absorbs:** `plans/STUB-algebraic-explanation.md` (FS-74). Its leads, and its re-aim at FS-79's close, are step 1's starting point.
6. **The nearest mathematics:**
   - `plans/FS73-derivation.md` T1–T7 (the Kempe period group, 8Λ, the (0, v) certificate) and T21–T24;
   - `plans/FS79-derivation.md` T17–T37. T21 is the edge-local height classification, T23 says every edge-local cocycle on de Grey's 9,120 colourings is trivial, and T37 says de Grey's cosets are coupled by single matchings;
   - `plans/FS81-derivation.md` (the layer method; T25, the four-colour sign table);
   - `LEDGER.md` rows 78–84.
7. **The design:** `plans/PROTOCOL-competitor-and-advisor.md` §1 and §3, including FS-79's run (the last competition) and FS-81's (a blind verifier).
8. **`plans/FS85-close-inventory.md`:** read only (see "Standing rules").

## The milestone, and why it matters

Every four-colour forced pair known anywhere uses a unit triangle. A field without √3 has no unit triangles (G57). That covers every real quadratic field that can need four colours, and ℚ(√47) and ℚ(√167) in particular. In those fields no four-colour refusal or forced pair has ever been found, here or in print. Soifer's Open Problem 55.1 (2019) asks for exactly such an object: a triangle-free five-chromatic unit-distance graph.

- **Step 1:** why is de Grey's lattice rigid (every four-colouring is 8Λ-periodic)? Hubai's 2018 stripes and one chirality are the lead. Record where the triangles enter.
- **Step 2:** can a triangle-free abelian Cayley graph carry a four-colour forced pair?

If no, the chain route (G55) is dead in every triangle-free field. If yes, and it is realised in a wall-broken triangle-free field, then five colours follow for that field.

**The week runs 2026-09-24 to 2026-10-01 with no search for a finite witness** (`CLAUDE.md` § Toolchain):
- **Out:** SAT, MILP/CP or local-search colourers, Θ trees, float finders, quotient searches, survivor sweeps.
- **In:** derivation, computer algebra, formula colourings, the kernel, existing checkers on existing certificates, and exact LPs whose shape a derivation fixed first.

This milestone is the week's experiment, and Kooshi will judge it partly by the **"would have searched here" log**: one line each time an agent's default next move would have been a search, saying what it did instead. Keep yours in the plan's §X, and put the same instruction into every brief you draft.

## Your job in this stage: WORKFLOW steps 3, 4 and 5, kept short because the week is short

**3.1: the re-grokking (§G)**, with `CLAUDE.md` and `LEDGER.md` open. Walk:
- every grokking G1–G74 and every `LEDGER.md` row 1–84's mechanism, **one line each**;
- every `[method]` rule;
- **individually:** `plans/FS79-derivation.md` T17–T37 and `plans/FS73-derivation.md` T1–T7 and T21–T24, the nearest material;
- **by block, with bearing lines individually:** `LEDGER.md` § B and the other derivation files.

Each entry gets one line and one verdict, each with its reason:
- **bears:** which phase it changes;
- **silent:** why;
- **falsifiable here:** register it as a prediction.

Write every *bears* into the phase design. The test of the re-grokking is that it changes the plan; if it changes nothing, say so explicitly.

**3.2: the prior-art gate (§PA)**, per `WORKFLOW.md` 3.2's eight questions. Name the object in its home disciplines' words; candidates include:
- **frozen** or **rigid** colourings of ℤ^d shifts and hom-shifts (symbolic dynamics; `[AlonEtAl2021]` calls our "rigid" *frozen*);
- **Kempe equivalence and reconfiguration of colourings**;
- **uniquely colourable graphs**;
- **forced or "frozen" vertices in graph colouring**;
- **triangle-free graphs and fractional or circular colouring** (Soifer ch. 55; Exoo–Ismailescu).

Search under at least two disciplines, and search for the question, not only the method. Use the zbMATH Open API (`curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=…' --data-urlencode 'results_per_page=100'`), recording each query, its hit count, and whether a hit's text is a review or an author's summary.

**Read first:**
- Hubai's 2018 comments, `[Hubai2018]`, in the held threads `~/source/library/notes/polymath16-threads-1-18-text.txt`;
- de Grey 2026: a triangle-free five-chromatic unit-distance graph in ℝ³, 61 vertices; find it, read what you can, enter it;
- Haugstrup's pseudo-edge constructions (Polymath16, 2025–26), if reachable;
- Heule's T721 (not held; find what is public about it).

**Contacting anyone is Kooshi's call, never an agent's.** Anything found goes into `BIBLIOGRAPHY.md` the same day, with an honest read status. **Carry what the gate teaches about the object into §IQ and into the competition's §C.** FS-73's gate once found the key idea and left it out of the competition brief, and both competitors re-derived it.

**3.3: the invariant question (§IQ)**, all five items, rewriting the stub's draft. The structural form must be about every four-colouring, in the most general class where it still makes sense. If the reframe shows that step 1 or step 2 is already answered (a theorem in some literature, or a two-line argument), say so plainly. That re-aims the milestone, and it is a finding.

**4: the subplan**, at `plans/FS85-rigidity-without-triangles.md` (you are its only writer):
- **The competition phase, with §C** holding the text for both competitor briefs, the protocol §4 template's slots filled:
  - the mathematics they stand on, with addresses;
  - the challenge stated precisely, with its known positive (de Grey's lattice) and known triangle-free controls (ℚ(√11)'s Λ₁₀ at three colours; ℚ(√167)'s L21cc6506 and ℚ(√47)'s lattices, loose at four);
  - what outcome (a) or (b) would look like;
  - what §PA found;
  - the ban and the search log;
  - plus the advisor's slots from §5.
- **Decide** whether steps 1 and 2 are ordered or posed as one challenge.
- **The killing test at about day 2**, and the fallback (FS-83) sketched well enough to brief from.
- **Every phase** names its budget, stop rule, checkpoint, what a kill redoes, and an acceptance checklist.
- **Register the outcome predictions** with probabilities, confirming each is reachable, the uninformative one included; carry the advisor's P-W3–P-W5.
- **Say which modeling passes apply.** You may fold a light domain pass into the plan if you judge the week too short for a separate stage; say why.
- Every phase record carries a heading "Theorems this phase proved".

**5: commit** the plan by explicit path, then hand back to me.

## Please don't attempt the answer

Stating the questions as sharply as your reframe allows is exactly your job. Answering them is the competitors': both must start from the same point, and a planner's head start would turn the competition into a check of one answer. That covers the stripes derivation for step 1, and any theorem or construction for step 2.

## Poros, your advisor for this stage

A Poros advisor is already running, reading the record and writing its own expectation before it talks to you. Its agent id is `POROS_ID`.
- Message it with SendMessage, `to` set to that id. Its replies arrive wrapped as `<agent-message from="…">`; your plain-text output never reaches it.
- Send it your §G draft, §PA, §IQ and phase table as each takes shape, and ask what you marked *silent* that bears.
- Its advice is advice. You decide, and you record any disagreement with its reason in the plan.
- It holds any candidate answer of its own for the competition's advisor, so don't ask it for one.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary (for instance with §G, §PA and §IQ committed), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: aim to hand back by about 350k tokens.** FS-81's planner used about 230k of working context. Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- **No search for a finite witness** (the week's rule), and **the resource rule** for anything else heavy: `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>` for any job over about 2 GiB or 2 minutes. /tmp is RAM on this machine, so keep large files on disk. **Never run `lake build`**; use `./scripts/build.sh` under a slot.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other earlier milestone's tool as read-only.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-plan/`. Please don't list or read the other agents' directories, or `~/source/lean-dir-owner/`.
- **The close inventory** (`plans/FS85-close-inventory.md`) is mine to write. Send me anything the close must not lose, and I'll log it the same turn.
- Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`; propose such edits in your report. `BIBLIOGRAPHY.md` entries are the exception (the bibliography rule: same day).
- **State every result at its exact scope and grade.**
- **To reach me:** SendMessage with `to: "main"`. Keep your turn's final text content-free ("planner idle; report sent to the owner by SendMessage"), because the harness delivers it to whichever agent last woke you. Send every report by SendMessage.

## What I'll check at hand-back (the acceptance, up front)

1. **§G:** every grokking, row and method rule has a verdict with a reason; the nearest derivations are walked individually; every *bears* appears as an instruction in the phase design.
2. **§PA:** the eight questions answered, with queries and hit counts; Hubai and de Grey 2026 read or their debt recorded; bibliography entries with honest read status; what the gate taught carried into §IQ and §C.
3. **§IQ:** all five items; a structural form about every four-colouring; the open-instance list.
4. **The plan:**
   - the competition with §C ready to paste into two briefs, plus the advisor's slots;
   - the killing test and the fallback;
   - predictions with both outcomes reachable;
   - the search log instruction in every brief;
   - the sequencing under the three-agent cap.
5. **Your report:** the commits (exact hashes), approximate token usage, what you delegated (the answer should be nothing), each disagreement with Poros and how it was resolved, your own search-log lines, and anything you think I've framed wrongly. If you see a better shape for the milestone than the one this brief assumes, say so.

Thank you, and good hunting.
