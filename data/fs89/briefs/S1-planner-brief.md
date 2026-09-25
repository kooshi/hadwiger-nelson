Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to open milestone **FS-89, the missing theorem, re-posed as a closed-set question**, as its planner. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than contribute the mathematics, so the plan's mathematics is yours. I'll score it by artifact.

## Read first, from disk

1. **The house standard:** `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`, all from disk. Any copy in your context is a snapshot. `CLAUDE.md` last changed at FS-86's close: rows 88–94, G76, and Frontier item 24.
2. **Why FS-89, and its current shape:**
   - `plans/POROS-2026-09-25-fs86-next.md`, the next-step advisor's recommendation, which Kooshi accepted. Read §3 (card 1 and "The gluing, stated so a derivation agent can check it"), §4 row A′ and §5.
   - `plans/STUB-isometric-measure-rigidity.md`, the stub; its "Chosen … re-posed" banner comes first.
   - `plans/FS89-close-inventory.md`, items 1–17. Read only (see the standing rules).
3. **Stage 0, both records, in full.** They are this plan's main input.
   - `plans/FS89-S0A-gluing-verification.md`: verifier G's blind check of the gluing (G0–G3, C2, C3, and C4's 13 theorems).
   - `plans/FS89-S0B-band-set.md`: the exact band set at the prime 5 (S0B-T1 to T6, the torsion list, §6's reading).
4. **What FS-86 established:**
   - `plans/FS86-dyadic-rigidity.md` §R-close;
   - `LEDGER.md` rows 88–94;
   - `plans/FS86-derivation.md`, especially §4 (dB-Theta, Cx-C10 = dB-HDfin, dB-Sv, dB-HDint, dB-HDcert, Cx-C15) and §9 (C14, CL1);
   - `CLAUDE.md` G74, G75, G76.
5. **The three-colour precedent the gluing copies:** `plans/FS81-derivation.md` (C1(5), T3, T5, T8) and G74.

## Where things stand after Stage 0 (each statement quoted from its source; check them there)

- **HD1** (FS86-dB-HDcert): "HD1 (`Θ₄(R) ⊆ T`)".
- **The advisor's reduction** (POROS record, card 1): "for every type-(B) field, HD1 follows from `Θ₄(ℤ[U_ℚ]) ⊆ T_N + A` by G74's `5^{−k}` gluing and FS86-dB-Theta; and `Θ₄(ℚ(√47)) = ∅` follows the same way".
- **Verifier G: the gluing holds** (S0A-2): "G1: `Θ_k(ℤ[U_ℚ]) ⊆ T_N + A` ⟹ `Θ_k(R_F) ⊆ T_N + A` for every subfield `F ⊆ ℝ`, at every band (the gluing reads only `ℤ[1/5]` per layer)". Lemma N₀ (S0A-3) makes the fixed `N` automatic: `N = 168` at four colours.
- **The rational statement's exact form** (S0A C3): "`Θ_k(ℤ[U_ℚ]) ⊆ T + A`; the order bound is then automatic (`N = 168` at four colours; finite, not computed, at five)". The ring is "`ℤ[U_ℚ]` with **every** split prime inverted"; the band is `[1/4, 3/4]` for HD1 and ℚ(√47), and `[1/5, 4/5]` for ℚ(√167).
- **It is the whole problem, not a lemma on the way** (S0A-10): "Equivalence: `Θ_k(ℤ[U_ℚ]) ⊆ T + A` ⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`". The verifier's caveat: the route is a clean field-free reduction, not an escape from the difficulty. Also from S0A C3: "a counterexample must read infinitely many split places".
- **What it would decide** (S0A-6, S0A-8, S0A-9, each conditional on the rational statement):
  - HD1 for ℚ(√59), ℚ(√83), ℚ(√131);
  - `Θ₄(R_F) = ∅` for ℚ(√47), by a route that needs only Lemma R and Weil;
  - `Θ₅(R) = ∅` for ℚ(√167), under the five-band statement, which is stronger.
- **One prime is not enough** (S0B-T3/T4/T5): "`θ* = (e; q, P)`, `e` in the lens, lies in `Θ₄(U₅)`"; "forward `τ₁ + λ`, backward `τ₂ + λ`, `τ₁ ≠ τ₂` ⟹ not `T + A`"; "from `e₀ = q` the forward orbits form a perfect tree; continuum many non-`T + A` points, a Cantor fibre of irrational `b₊`". The mechanism: at four colours the order-3 points lie inside the parity character's archimedean disc (`√2/6 < 1/4`); at three colours they do not (`√2/6 > 1/6`). I checked S0B-T3/T4 myself with independent code (inventory item 16).
- **Torsion orders at one prime** (S0B-L4, tools exact): "the band torsion characters of order ≤ 130: 145 characters, 12 orders (2, 3, 4, 7, 8, 22, 26, 31, 41, 48, 76, 79)". Both Stage-0 agents read the orders as unbounded; neither proved it.
- **A second prime** (S0B-T6, derived, one mind): "a second prime (13) kills every rational heteroclinic whose torsion difference is prime to 13". §6 reads, unproved, that 13 also kills the infinitely-switching family. Its killing test: "an exact 2-D orbit window (`e_{m,n}`, both steps) at depth `K` in both directions whose piece count grows like the 1-D one, or an explicit 2-D switching array".
- **A correction owed** (inventory items 4 and 14): G76 and the stub say "measure rigidity", but the question is closed-set rigidity. Use closed-set language in the plan.

## The milestone, and why it matters

FS-86 reduced four-colour rigidity over the triangle-free fields ℚ(√59), ℚ(√83), ℚ(√131) to HD1, and showed that every construction of a "no" reading finitely much is impossible (rows 88–92). Stage 0 has shown two things. First, HD1 for every such field, and the character falsifiers at ℚ(√47) (four colours) and ℚ(√167) (five colours), all follow from one statement about the rational unit circle. Second, that statement is equivalent to the uniform statement over every real field. The object is now a closed subset of a compact abelian group (the dual of `ℤ[U_ℚ]`), invariant under multiplication by the rational unit vectors. That is Furstenberg–Berend territory, and the advisor named it. **Stage 0 also showed that one prime leaves a Cantor family, and that a second prime kills its rational part.** That is the rank-one versus rank-two shape of Furstenberg's ×2×3 theorem.

**How outcomes count** (Kooshi): *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* A proof, a counterexample (an explicit band character of infinite type, which would be the only known seed of a falsifier at ℚ(√47)), a sharp statement of which rank suffices, or a named no-go are all results. Register outcomes honestly, and tell every agent you draft text for, in words, not to lean toward a yes (G21's selection mechanism).

## Kooshi's ruling on shape: one derivation agent plus a blind verifier

**Kooshi, for Stage 1:** *"Let's go ahead and try one agent plus verifier this time."* So the plan's derivation stage is **one derivation agent and one blind verifier**: no competition and no advisor. The rest of the shape is yours:
- whether the verifier derives the target statements blind in parallel with the derivation agent, or checks the agent's claims after they are made (FS-86's verifiers W, X, C and D ran blind on fixed statements; verifier G ran blind on a sketch);
- how to split the derivation into stages that each end in a saved, checkable claim;
- what the first question is. Candidates, yours to judge and improve:
  - the two-prime set `Θ₄(ℤ[i][1/65])` (does rank two already force `T_N + A`?);
  - the all-primes statement by a Berend-type argument, working modulo the isometric archimedean directions;
  - a proof that the torsion orders are unbounded at one prime;
  - a counterexample of infinite type.

The cap is three agents at once. You are the only agent running now, and Stage 1 fills two slots.

## Your job in this stage: WORKFLOW steps 3, 4 and 5

**3.1: the re-grokking (§G)**, with `CLAUDE.md` and `LEDGER.md` open. Walk:
- every grokking G1–G76 and every `LEDGER.md` row 1–94's mechanism, **one line each**;
- every `[method]` rule;
- **individually:** both Stage-0 records' theorems (S0A-1 to S0A-13, S0B-T1 to T6, S0B-L4), FS-86's §4 entries named above, and FS-81's C1(5), T3, T5, T8;
- **by block, with bearing lines individually:** `LEDGER.md` § B and the other derivation files.

Give each one line and one verdict, with its reason: **bears** (which phase it changes), **silent** (why), or **falsifiable here** (register it as a prediction). Write every *bears* into the phase design. The test of the re-grokking is that it changes the plan; if it changes nothing, say so explicitly.

**3.2: the prior-art gate (§PA)**, per `WORKFLOW.md` 3.2's eight questions.
- **Name the object in its home disciplines' words.** Candidates, yours to improve:
  - closed sets invariant under a commuting multiplicative action on a solenoid or an `S`-adic group (topological dynamics: Furstenberg 1967's ×2×3 closed-set theorem, `[Berend1983]`, `[Berend1984]`, and their `S`-adic and solenoidal successors);
  - the band condition as a circular-colouring or character-sum question (the discipline G74 names);
  - Bohr-set or Kronecker-type sets of characters (harmonic analysis).
- **Read first, the debts:**
  - **`[Berend1983]` and `[Berend1984]` in full.** Neither is held; the entry says so. They are Transactions of the AMS papers; if a public copy exists, fetch it to `~/source/library/pdf/` and record the route.
  - Furstenberg 1967, which needs a new `[Furstenberg1967]` bibliography entry (inventory item 4).
  - The Einsiedler–Lindenstrauss line only as far as it settles which closed-set theorem is nearest. Its measure theorems are not this question.
- **Use the zbMATH Open API** (`curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=…' --data-urlencode 'results_per_page=100'`). Record each query, its hit count, and whether each hit's text is a reviewer's review or an author's summary.
- **Search for the question as well as the method.** Has anyone classified the closed sets of characters of `ℤ[i][1/S]` that take the unit circle into an arc, or asked for "circular colourings given by characters" of rational unit-distance graphs?
- **Bibliography:** anything found goes into `BIBLIOGRAPHY.md` the same day, with an honest read status. Contacting any author or library is Kooshi's call, never an agent's.
- **Carry what the gate teaches into §IQ and into the Stage-1 briefs.** FS-73's gate once found the key idea and left it out of the competition brief, and both competitors re-derived it.

**3.3: the invariant question (§IQ)**, all five items.
- The structural form must be about **every** band character, in the most general class where the question makes sense. For example, every closed set of characters invariant under a multiplicative rank-`r` action with isometric archimedean directions.
- If the reframe shows the question is already answered (a theorem in the literature, or a two-line argument), say so plainly. That re-aims the milestone, and it is a finding.

**4: the subplan**, at `plans/FS89-rational-band-rigidity.md`. You are its only writer. It needs:
- **The statements, sharp,** with their exact rings, bands and scopes, taken from the sources above. When you restate one of the advisor's or the Stage-0 agents' consequences ("X, hence Y"), mark it as unverified and give the verifier the job of checking it. My S0B brief carried the advisor's "one prime suffices" as settled, and it was wrong (inventory item 15).
- **Stage 1 in Kooshi's shape**, with text for each of the two briefs. Each needs:
  - the mathematics they stand on, with addresses;
  - the questions, quoted verbatim;
  - the stop rules;
  - the "would have searched here" log;
  - the no-children rule with its reason;
  - Kooshi's "all novel knowledge is a success", with the instruction not to lean toward a yes;
  - "work in stages", with the reason: at FS-86 an agent lost three responses to the output-token limit.
- **Outcome predictions with probabilities**, every reachable outcome assigned a verdict, the uninformative one included.
- **A killing test with a date that you have checked can fire,** and a fallback sketched well enough to brief from. The ban ends 2026-10-01 unless Kooshi extends it; say what changes then.
- **Every phase:** its budget, its stop rule, its checkpoint and resume command, what a kill redoes, and an acceptance checklist.
- **The modeling passes:** say which apply. You may fold a light domain pass into the plan if you judge the stage too short for a separate one; say why.
- **Records:** every phase record carries a heading "Theorems this phase proved".

**5: commit** the plan by explicit path, then hand back to me.

## Please don't attempt the answer

Stating the questions as sharply as the reframe allows is your job. Answering them is Stage 1's. There are two reasons:
- **Context:** a planner that starts deriving runs out of room before the plan is written.
- **Blindness:** the verifier must check a derivation made from the plan's statements, not the planner's own route.

Small exact checks (seconds) that validate the spec are welcome: a splitting, a unit's order modulo a prime, a character's value on the circle points.

## The finite-witness-free week, and what Stage 0 was allowed

No search for a finite witness runs until 2026-10-01 (`CLAUDE.md` § Toolchain): no SAT, MILP, finders, `Θ` relation trees, quotient searches or sweeps.
- **Kooshi ruled S0B's exact band-set computation allowed**, and gave the ban's intent: *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time."*
- **An exact computation of the same kind** (for example the 2-D orbit window S0B named as its reading's killing test) is in scope if a derivation fixes its shape first and its cost is bounded in hours, not days. Price it in the plan. I'll put anything larger to Kooshi.
- S0B's torsion list (`N ≤ 130`) sits at the ban's edge. I have recorded it for Kooshi (inventory item 17); don't extend it without a ruling.
- Keep your own "would have searched here" lines in the plan's §X.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary (for instance with §G, §PA and §IQ committed), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Work in stages:** keep each response short, and save the plan file after every section. A response lost to the output-token limit is unrecoverable.
- **Budget:** aim to hand back by about 350k tokens. Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- **Resources:** any job over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. /tmp is RAM on this machine. **Never run `lake build`**; use `./scripts/build.sh` under a slot.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours.
  - Never amend.
  - End commit messages with the attribution lines your harness supplies, after a blank line.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other earlier milestone's tool as read-only; `tools/fs89_s0b_*.py` may be imported.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-plan/`. Please don't list or read other directories beside it, or `~/source/lean-dir-owner/`.
- **The close inventory** (`plans/FS89-close-inventory.md`) is mine to write. Send me anything the close must not lose, and I'll log it the same turn.
- **Files you don't edit.** Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`; propose such edits in your report. `BIBLIOGRAPHY.md` entries are the exception (the bibliography rule: same day).
- **State every result at its exact scope and grade.**
- **To reach me:** SendMessage with `to: "main"`. Keep your turn's final text content-free ("planner idle; report sent to the owner by SendMessage"), and send every report by SendMessage.

## What I'll check at hand-back (the acceptance, up front)

1. **§G:**
   - every grokking, row and method rule has a verdict with a reason;
   - Stage 0's theorems and the nearest derivations are walked individually;
   - every *bears* appears as an instruction in the phase design.
2. **§PA:**
   - the eight questions answered, with queries and hit counts;
   - Berend 1983 and 1984 read, or the debt recorded with its reason;
   - the `[Furstenberg1967]` entry added;
   - what the gate taught carried into §IQ and the briefs.
3. **§IQ:** all five items; a structural form about every band character; the open-instance list.
4. **The plan:**
   - the statements sharp, the unverified consequences marked;
   - Stage 1 in Kooshi's shape with both briefs' text;
   - predictions with every reachable outcome assigned;
   - the killing test, checked to be able to fire, and the fallback;
   - any exact computation priced, with its derivation fixing its shape;
   - the search-log instruction in every brief.
5. **Your report:**
   - the commits, with exact hashes;
   - approximate token usage;
   - what you delegated (the answer should be nothing);
   - anything for the inventory.

Thank you. This is the milestone where the question finally has a home discipline, and the plan decides whether we meet it with the right theorem.
