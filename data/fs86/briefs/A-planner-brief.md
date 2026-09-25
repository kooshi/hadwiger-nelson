Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to open milestone **FS-86, four-colour rigidity over ℚ(√59) and ℚ(√83)**, as its planner. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than contribute to the mathematics, so the mathematics of the plan is yours. I'll score it by artifact.

## Read first, from disk

1. **The house standard:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot. `CLAUDE.md` changed at FS-85's close (2026-09-24) in these places:
   - rows 85–87;
   - G75, new;
   - G54, rewritten with a demotion record;
   - Frontier item 23.
2. **The milestone:** `plans/STUB-dyadic-rigidity-triangle-free.md`, in full. It carries:
   - the question;
   - what is known: H6's two open types; the record's gap; the mechanism over K; the Soifer calibration; Coxeter's R2.6 reading;
   - four routes, of which route 4 is banned until 2026-10-01;
   - the outcomes registered before any run;
   - the provisional bearings and the reading owed.
3. **Its origin:** the FS-85 plan-phase advisor's held items H5 and H6, public since FS-85's competition ended (`data/fs85/held/HELD-plan-advisor.md`). Read H5 as a hypothesis by analogy (its own "basis" line says so), not as a result.
4. **The rules and the proposed stage shape:** `plans/SESSION-HANDOFF-2026-09-25-fs86-open.md`, especially §1 (the rules and FS-85's lessons), §2 (the stages) and §3 (budget anchors).
5. **The nearest mathematics:**
   - `LEDGER.md` rows 66, 67, 78, 82, 85, 86, 87;
   - `plans/FS85-derivation.md`, all 39 entries. Especially:
     - row 85's chain: C7, C8, C10, R3a, C15 and Theorem R;
     - row 86: dB2 and dB4, the Soifer calibration;
     - row 87's no-gos: C14, C11, C6;
     - L16, the slack plane that forces;
     - §7, Coxeter's R2.6 reading;
   - `plans/FS85-rigidity-without-triangles.md`, **§R-close first**. Then its §G, §IQ and §C, which show the shape of the last plan and what the close said about it;
   - `plans/FS38-derivation.md`: FS38-D2-A and D2-B (tight ⟹ balanced, gap-free, periodic) and row 67's tower;
   - `plans/FS79-derivation.md` T2 (never chainable inside the field);
   - `plans/FS81-derivation.md` for row 82 (four colours at d ≡ 11 mod 12).
6. **The competition design:** `plans/PROTOCOL-competitor-and-advisor.md`:
   - §1, all eleven rules. Rule 1 is the covert channels; rule 11 says verification is where contest begins;
   - §3, including FS-85's run (the fifth);
   - §4 and §5, the brief templates.
7. **`plans/FS86-close-inventory.md`**, read only (see "Standing rules").

## The milestone, and why it matters

The plane over ℚ(√59) needs exactly four colours. It has no unit triangles, and its only four-colour residue target is the inert dyadic `K₄`, which is Hoffman-tight. The stub asks:
- **the weak form:** does a rich lattice over it carry `P₄ ≠ 0` (a pair every periodic four-colouring identifies)?
- **the strong form:** does it carry `F₄ ≠ 0` (a pair every four-colouring identifies)?

It asks the same over ℚ(√83) and ℚ(√131). This is the one triangle-free field type the record never asked (H6's type B).

- **What a yes would mean.** By FS85-dB4 it is Soifer-strength: a four-colour forced pair in any triangle-free unit-distance graph chains, outside the field, to a triangle-free five-chromatic unit-distance graph, which is Soifer's Open Problem 55.1. So price it with a strong prior against it, and require two independent derivations and a blind verifier before a ledger row.
- **What a no would mean.** It kills H5's reading on that lattice, confirms Coxeter's R2.6, and tells us what four-colour rigidity needs besides a tight target.
- **Route 3 is G75's killing test.**

**Kooshi on how outcomes count** (2026-09-24): *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* No-gos count; he confirmed that. So:
- Register the outcomes honestly.
- Tell every agent you brief, in words, not to lean toward a yes. G21's selection mechanism is what that guards against.
- He also said of FS-85's ban and plan that they "may have been too strict, although restrictions do breed creativity, I'm not sure if these are the kinds that count". FS-85's §R-close.2 reads its 37 search-log lines on exactly that. Keep this plan's constraints to those that carry a stated reason, and make every stop rule one that can actually fire.

## Kooshi's ruling on shape: a competition

**Kooshi, today, while I was launching you:** *"you should make this one a competition too. It works well for derivations."* So FS-86's derivation work runs as a competition: two competitors and a competition-phase advisor, the protocol's design. That settles the handoff's open choice for stage C. The rest of the shape is yours:
- **Where routes 1–2 sit.** They are exact computer algebra: the Smith form on the dyadic tower, and tightness level by level. You have three options:
  - a one-agent stage before the competition;
  - inside the competition's challenge;
  - split between the two.
  Decide, and say why against the alternative.
- **The cap.** It is **three agents at once**, and a competition fills it. So nothing else runs beside it, and a blind verifier needs a slot, either during the competition (FS-85 used one in place of a stood-down advisor) or after it.
- **Whether routes 1 and 3 are one challenge or ordered.**
- **Where the blind verifier for any yes goes.**
- **What happens at 2026-10-01**, when the finite-witness-free week ends unless Kooshi extends it. Route 4 opens then, meaning G68's quotient screen on the composite quotients.

## Your job in this stage: WORKFLOW steps 3, 4 and 5

**3.1: the re-grokking (§G)**, with `CLAUDE.md` and `LEDGER.md` open. Walk:
- every grokking G1–G75 and every `LEDGER.md` row 1–87's mechanism, **one line each**;
- every `[method]` rule;
- **individually:** `plans/FS85-derivation.md`'s 39 entries, FS38-D2-A/B, and FS79-T2;
- **by block, with bearing lines individually:** `LEDGER.md` § B and the other derivation files.

Each entry gets one line and one verdict, each with its reason:
- **bears:** which phase it changes;
- **silent:** why;
- **falsifiable here:** register it as a prediction.

Write every *bears* into the phase design. The test of the re-grokking is that it changes the plan; if it changes nothing, say so explicitly.

**3.2: the prior-art gate (§PA)**, per `WORKFLOW.md` 3.2's eight questions.
- **Name the object in its home disciplines' words.** Candidates, yours to improve:
  - Hoffman colourings and the equality case of the ratio bound (algebraic graph theory);
  - uniquely colourable graphs and rigidity of colourings of products, meaning Greenwell–Lovász, Hedetniemi-type questions, and FS-67's four unread originals (`BIBLIOGRAPHY.md` § R.4);
  - frozen colourings of ℤ^d hom-shifts (symbolic dynamics);
  - unit-distance graphs over real quadratic fields (Benda–Perles, Johnson, Fischer);
  - triangle-free five-chromatic unit-distance graphs (Soifer ch. 55).
- **Search** under at least two disciplines, and for the question, not only the method.
- **Use the zbMATH Open API** (`curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=…' --data-urlencode 'results_per_page=100'`). Record each query, its hit count, and whether a hit's text is a review or an author's summary.
- **Read first: the debts** (inventory item 5):
  - Soifer ch. 55's posing citation "[Soi46]" and its citation graph;
  - `[deGrey2026]` (ℝ³, triangle-free, five-chromatic, 61 vertices) and `[Haugstrup2026]` (ℝ³, no `K₄`, six-chromatic), the clique-restricted constructions nearest this question, both read only by summaries so far;
  - Heule's T721 (not held; find what is public);
  - the product-rigidity literature behind FS-67.
- **Contacting anyone is Kooshi's call, never an agent's.**
- **Bibliography:** anything found goes into `BIBLIOGRAPHY.md` the same day, with an honest read status.
- **Carry what the gate teaches about the object into §IQ and into the competition's §C.** FS-73's gate once found the key idea and left it out of the competition brief, and both competitors re-derived it.

**3.3: the invariant question (§IQ)**, all five items. The structural form must be about **every** four-colouring, in the most general class where it still makes sense. The class must contain the rich lattices over ℚ(√59). If the reframe shows the question is already answered (a theorem in some literature, or a two-line argument), say so plainly. That re-aims the milestone, and it is a finding.

**4: the subplan**, at `plans/FS86-dyadic-rigidity.md`. You are its only writer.
- **Define "rich" precisely**, so that route 1's statement is sharp. That means an exact lattice or family, its unit-vector set, and its integrality at every prime. Enumerating a lattice's unit vectors is exact arithmetic and in scope; screening lattices for survivors is not.
- **§C, text ready to paste into both competitor briefs**, with the protocol §4 template's slots filled:
  - the mathematics they stand on, with addresses;
  - the challenge stated precisely, with its known positive (de Grey's lattice over K, row 85) and its known negatives. Among the negatives are FS-73's inert-dyadic row `K|Q(sqrt11,i)|D36`, loose by a gap at `N = 5`, and the type-A lattices;
  - what each registered outcome would look like;
  - what §PA found;
  - the ban and the search log.

  Add the advisor's slots from §5, and the held-items timing (see "Poros" below).
- **Outcome predictions with probabilities.** Confirm each outcome is reachable, the uninformative one included. **Every reachable outcome must be assigned a verdict:** FS-85's registration left "a result inside K only" unassigned until the owner's ruling (FS-85 inventory item 22). Carry the stub's registrations, and name any you change.
- **A killing test with a date, which you have checked can fire.** FS-85's stub's day-2 test could not (item 12). Say what evidence fires it, and confirm that evidence is reachable by that date. Add the fallback, sketched well enough to brief from.
- **Every phase** names:
  - its budget;
  - its stop rule;
  - its checkpoint and resume command;
  - what a kill redoes;
  - an acceptance checklist.
- **The modeling passes.** Say which apply. You may fold a light domain pass into the plan if you judge the stage too short for a separate one; say why.
- **Records.** Every phase record carries a heading "Theorems this phase proved".
- **Brief text you draft.** Every piece carries:
  - the "would have searched here" log;
  - the no-children rule with its reason;
  - Kooshi's "all novel knowledge is a success", with its instruction not to lean toward a yes.

  I'll check its statements against their sources before copying them into a brief. FS-85's verifier-2 brief inherited an overstated scope that way (items 76 and 81).

**5: commit** the plan by explicit path, then hand back to me.

## Please don't attempt the answer

Stating the questions as sharply as your reframe allows is exactly your job. Answering them is the competitors': both must start from the same point, and a planner's head start would turn the competition into a check of one answer. In practice:
- **Allowed:** small exact checks (seconds) that validate the spec, such as the splitting of 2, 3 and 7, `K₄`'s spectrum, or a lattice's unit vectors and integrality.
- **Not yours:**
  - route 1's Smith form at depth;
  - route 2's tower of signs;
  - any derivation of route 3's structural answer.

If a route lands outside the competition as a one-agent stage, its agent runs it, not you.

## Poros, your advisor for this stage

A fresh plan-phase Poros is already running. It is reading the record and writing its own expectation before it talks to you. Its agent id is `POROS_ID`.
- **The channel.** Message it with SendMessage, `to` set to that id. Its replies arrive wrapped as `<agent-message from="…">`; your plain-text output never reaches it.
- **What to send.** Send it your §G draft, §PA, §IQ and phase table as each takes shape, and ask what you marked *silent* that bears.
- **Its advice is advice.** You decide, and you record any disagreement with its reason in the plan.
- **Held routes.** It holds any candidate *route to the answer* for the competition's advisor, so don't ask it for one.
- **Frame-level items are not held.** Last time the plan-phase advisor wrote its two frame-level items at stand-down and the planner never saw them. Those items were H6, which fields are already free, and H5's frame part, what the record never asked. So before you commit, ask it plainly for any frame-level item it has not yet sent.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary (for instance with §G, §PA and §IQ committed), persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget: aim to hand back by about 350k tokens.** FS-85's planner used about 330k working. Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- **No search for a finite witness** until 2026-10-01 (`CLAUDE.md` § Toolchain), and keep your own "would have searched here" lines in the plan's §X.
- **The resource rule** for anything heavy: `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>` for any job over about 2 GiB or 2 minutes. /tmp is RAM on this machine, so keep large files on disk. **Never run `lake build`**; use `./scripts/build.sh` under a slot.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours.
  - Never amend.
  - End commit messages with the attribution lines your harness supplies, after a blank line.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Neutral commit subjects are not needed yet.** The competition has not started, and your plan is what both competitors will read. Once it starts, I'll handle the subjects.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other earlier milestone's tool as read-only.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-plan/`. Please don't list or read the other agents' directories beside it, or `~/source/lean-dir-owner/`.
- **The close inventory** (`plans/FS86-close-inventory.md`) is mine to write. Send me anything the close must not lose, and I'll log it the same turn.
- **Files you don't edit.** Don't edit `CLAUDE.md`, `LEDGER.md` rows or `plans/FRONTIER-STUBS.md`; propose such edits in your report. `BIBLIOGRAPHY.md` entries are the exception (the bibliography rule: same day).
- **State every result at its exact scope and grade.**
- **To reach me:** SendMessage with `to: "main"`. Keep your turn's final text content-free ("planner idle; report sent to the owner by SendMessage"), because the harness delivers it to whichever agent last woke you. Send every report by SendMessage.

## What I'll check at hand-back (the acceptance, up front)

1. **§G:**
   - every grokking, row and method rule has a verdict with a reason;
   - the nearest derivations are walked individually;
   - every *bears* appears as an instruction in the phase design.
2. **§PA:**
   - the eight questions answered, with queries and hit counts;
   - the four reading debts read, or their debt recorded with the reason;
   - bibliography entries with an honest read status;
   - what the gate taught carried into §IQ and §C.
3. **§IQ:** all five items; a structural form about every four-colouring, in a class that contains the rich lattices over ℚ(√59); the open-instance list.
4. **The plan:**
   - "rich" defined exactly;
   - where routes 1–2 sit, decided with its reason;
   - the competition with §C ready to paste, plus the advisor's slots;
   - the killing test, checked to be able to fire, and the fallback;
   - predictions with every reachable outcome assigned;
   - the search-log instruction in every brief;
   - the sequencing under the three-agent cap, including 2026-10-01.
5. **Your report:**
   - the commits, with exact hashes;
   - approximate token usage;
   - what you delegated (the answer should be nothing);
   - each disagreement with Poros and how it was resolved;
   - your own search-log lines;
   - anything you think I've framed wrongly.

   If you see a better shape for the milestone than the one this brief assumes, say so.

Thank you, and good hunting.
