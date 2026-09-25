# Brief: FS-89's close (WORKFLOW step 9), for the planner who writes it

You are **de Bruijn**, the engineer who owns the mathematics of `/home/kooshi/source/lean-dir`, working as **the planner for FS-89's
close**. I'm the product owner, the coordinating session. Kooshi, the human whose project this is, has asked me to coordinate rather than
write the mathematics.

**Kooshi's standing close rules:**
- *"close out with the findings"*;
- *"I don't want to lose anything from before. There's a lot to save."*;
- *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*

**Every result enters the ledger and the Frontier at its exact scope and grade.**
- A hand proof checked lemma by lemma by a blind verifier is "hand, one derivation, blind-verified", not "two derivations" and not
  "kernel". Say exactly what was independent.
- A statement about character colourings is not a statement about `χ`.
- "Conditional on the four-band rational statement" and "at S0A's grade" are part of a grade.
- "Not found in print" is not "new" (inventory item 39).

## What FS-89 was, in three sentences

It set out to prove the theorem FS-86 lacked: for the unit-vector action on the dual of `R`, with isometric archimedean directions. The
next-step advisor re-posed it as a closed-set (Furstenberg–Berend) question. Stage 0 then showed that everything reduces to one
statement about the rational unit circle — every four-colour band character of `Q = ℤ[i][1/p : p ≡ 1 (4)]` is torsion plus archimedean
(RQ₄) — and that one prime is not enough. Stage 1, one derivation agent plus blind verifiers, proved RQ₄ and its five-colour version RQ₅
through the two primes {5, 13}, by Berend's proof with the archimedean plane set aside. A blind verifier re-derived every lemma, and
found that rigidity holds at every set of two or more primes with no finite computation.

## Read from disk first

- `WORKFLOW.md`: step 9 in full, and steps 3.1 and 3.3, because the close re-reads §G and §IQ.
- `CLAUDE.md` and `DEBRUIJN.md`. Any copy in your context is stale.
- `LEDGER.md`, by address, not loaded whole.

## Your checklist already exists

It is `plans/FS89-close-inventory.md`, items 1–39.
- **From now on you are its only writer.** Tick each item "done at <hash>" or "declined, with the reason".
- **Read every number from its source record, never from the inventory.** That is the one-home-per-fact rule, and it catches owner
  slips. The owner errors and slips are items 15 and 22.
- **The inventory is not scripture.** Fix what is wrong, add what is missing, and tell me.

## The sources

- **The advisor's recommendation:** `plans/POROS-2026-09-25-fs86-next.md`.
- **Stage 0:**
  - `plans/FS89-S0A-gluing-verification.md` (verifier G: the gluing S0A-2, Lemma N₀, C-HD1, C-47, C-167, the equivalence S0A-10; 13
    theorems in its C4);
  - `plans/FS89-S0B-band-set.md` (one prime is not enough: S0B-T1 to T6, C1, L4);
  - tools `tools/fs89_s0b_*.py`, data `data/fs89/s0a/`, `data/fs89/s0b/`.
- **The plan:** `plans/FS89-rational-band-rigidity.md` (§0, §G, §PA, §IQ, §S, §C, §P, §M, §X; the planner's P-R1).
- **Stage 1:**
  - `plans/FS89-S1D-derivation.md` (the derivation agent: D0-T1, D1-*, D2-*, D5-*; §6 carries its theorems table);
  - `plans/FS89-S1V-verification.md` (verifier H: V-A1 to V-A4, Theorems V4 to V6);
  - `plans/FS89-S1VB-verification.md` (verifier I: B1 blind, B2 lemma by lemma, B3 divergences; S1VB-1 to S1VB-14);
  - tools `tools/fs89_s1d_*.py`, `tools/fs89_s1v_*.py`, `tools/fs89_s1vb_*.py`, data `data/fs89/s1d/`, `data/fs89/s1vb/`;
  - the briefs, `data/fs89/briefs/`.

## What the close must produce (WORKFLOW 9; the inventory itemises it)

### 1. `plans/FS89-derivation.md`, new

- **Format:** that of `plans/FS86-derivation.md`.
- **Scope:** every theorem FS-89 proved outside the kernel, from every agent: verifier G (S0A-1 to 13), S0B (T1 to T6, C1, L4), the
  planner (P-R1), D (D0-T1 and its lemmas, D1-*, D2-*, D5-*), verifier H (V-A1 to V-A4, V4 to V6) and verifier I (S1VB-1 to 14).
- **Each entry carries:** its statement, grade, the proof's address, what rests on it, prior art and a kernel decision.
- **Merge duplicates honestly:** one entry per theorem, with every derivation credited and what was independent stated. For example:
  - D1-L3 by D, and by verifier I after seeing its statement;
  - S0B-T6 strengthened to verifier H's V4;
  - RS₄ at {5, 13} (D, by corner isolation) against every `|S| ≥ 2` (verifier I's S1VB-14, by VB1).
- **Apply every verifier correction as you file:**
  - item 26's wording slip and gap in S0B §6;
  - item 37's scope understatement in D §3;
  - item 25's precision (two order-4 types).
- **`LEDGER.md` § B:** one line each; keep `tools/fs71_ledger_b_check.py --strict` green.

### 2. `LEDGER.md` rows 95 onward

How many rows, and their wording, are yours. Every row states what is not claimed. The natural candidates:
- **Rational band rigidity:** RQ₄ and RQ₅, with the explicit band set (13 discs and 16 points, 29 torsion characters, six types) and
  rigidity at every `|S| ≥ 2` (and at five colours for `S ∋ 5`). By Stage 0's equivalence, the same statement holds over every real field.
- **Its consequences, at their own grades:**
  - C-HD1, HD1 for ℚ(√59), ℚ(√83), ℚ(√131), at FS86-dB-Theta's grade: what exactly does it now settle about four-colourings of those
    planes, and what does it leave (`F(R)` is still undecided; non-character colourings are untouched)?
  - C-47: no character four-colouring of ℚ(√47)'s plane.
  - C-167: no character five-colouring of ℚ(√167)'s plane.
  - **State these against FS-83's stub question**, which they appear to answer at both exposed fields, and against FS-64's one-place
    windowless case.
- **One prime is not enough** (S0B): the heteroclinic and switching characters; the mechanism, the order-3 discs inside the parity disc
  at four colours but not three; and "any second prime kills the rational heteroclinics" (V4).
- **The gluing and the equivalence** (S0A-2, S0A-10) and Lemma N₀, if they earn a row of their own, or inside the first.

### 3. Corrections owed

- **G76:** it says "measure rigidity", but the question was closed-set rigidity (item 4). It now also needs a rewrite in place for the
  answer: the missing theorem holds for characters. Carry a demotion record for what it wrongly claimed, if anything did.
- **G74:** its reading fired at one prime (item 19); it needs a demotion record.
- **G30:** the discipline ladder enters topological dynamics and algebraic `ℤ^d`-actions at FS-89 (item 19).
- **The stub `plans/STUB-isometric-measure-rigidity.md`:** its banner.
- **§ Toolchain's ban line:** record the ban's intent in Kooshi's words (item 2), and keep it current-state (the ban ends 2026-10-01 unless
  he extends it).
- **The method line on token counts** (item 38).

### 4. `CLAUDE.md`, current state only

- **The Frontier:**
  - item 24 (the triangle-free fields), and every item or paragraph whose statement this changes: FS-83's and FS-64's rows, the
    exposed-prediction paragraph under "The target", and the prior-art position ("Ours:");
  - FS-89 closed;
  - the ledger pointer;
  - Paths forward.
- **The grokkings:**
  - G76 and G74 as above.
  - **G72's count:** did FS-89's result come through the structural question? The plan's §IQ posed Berend's MT/ID property modulo the
    isometric direction.
  - **G51:** this run's shape, one derivation agent plus blind verifiers, is new. Record it in the protocol (section 7 below).
  - **Instances:**
    - G21: D's unreachable plants (item 29); the owner's brief overclaim (item 15); verifier I's B1 GAP measuring its route, not the
      claim.
    - G49/G50: Berend's ETDS paper read in full at the gate; the TAMS papers unread.
  - **Perhaps a new grokking** in G67's form, for what the milestone understood — for instance, why a second prime restores rigidity
    modulo the rotated direction, and what that makes you do. Whether it earns an entry, and its number, are yours.
- **Size — this is binding.** The budget is 275,000 bytes, and the file is at **274,970** now. **You must compress without loss** before
  adding anything.
  - Never touch a `[PROTECTED]` paragraph.
  - Never trim an entry's *Do* or its killing test.
  - The lossless lever at the last two closes was turning text that retold ledger rows into pointers.
- **The fact audit at the end:**
  - `tools/claude_md_fact_audit.py --base 052707ac`. That commit opened FS-89's inventory (item 8).
  - `--dupes`, which stood at 11.
  - Nothing lost, nothing retold. An intended change gets an ALLOW entry with its reason.

### 5. §R-close in the plan

- **The §G re-read:** which extractions paid, and which entries should have borne and did not.
- **The §PA sweep** for recognitions about what the object *is*.
- **The §IQ re-read,** and G72's count.
- **The predictions, scored once:** the plan's §P (O1–O6 and P-U1 … P-log); every C0 (verifier G, S0B, D, verifier H, verifier I); the
  advisor's odds in its record's card 1.
- **The verdict,** with the reason. The registered outcome O1 was reached at a prior of 0.10.
- **The retraction and honesty tally:** every owner error and agent slip in the inventory.
- **The search-log count across every agent.**
- **The ban question:** Kooshi said the algebra-only framing "has produced more theorems already than the prior week did... and that's
  probably measurable from our ledgers" (item 3). Make the measurement properly, with its caveats.

### 6. The prior-art gate on the theorems filed (G49; item 39)

Run it on RQ₄/RQ₅ and S1VB-14 themselves, in the discipline's words, not ours:
- closed invariant sets;
- the ID or MT property;
- non-expansive;
- isometric direction or compact factor;
- S-adic solenoid.

Use the zbMATH API (record queries, hit counts, and whether each hit's text is a review or an author's summary). Walk Berend 1984 (TAMS)'s
citers by title (OpenAlex lists 42). Berend 1984 (TAMS) itself is unread and cannot be fetched by script. So, unless Kooshi supplies it,
the ledger row says "not found in print by the planner's and the close's gates; `[Berend1984]` unread", never "new".

### 7. Stubs, `plans/FRONTIER-STUBS.md` re-ranked, and the protocol

- **FS-89:** its banner.
- **FS-83, FS-64, FS-59, FS-84, FS-76, FS-90:** re-aim each where the results bear, and re-rank honestly, one rank per row.
  - FS-90's HD1-cert candidate: HD1 is now proved, so a certificate exists; what is left of the candidate?
- **Mint** the stub candidates: D's band-1/6 exit lemma and MS₄({5}) at rank one (item 30); anything else the records surface (grep the
  records for "conjecture", "open", "not claimed").
- **Don't pre-empt the choice of the next milestone:** Kooshi and a next-step advisor decide.
- **The protocol, `plans/PROTOCOL-competitor-and-advisor.md` §3:** add FS-89's run.
  - Its shape: a Stage 0 of two agents in parallel, then one derivation agent plus blind verifiers.
  - Verifier H replaced near its ceiling by verifier I.
  - The blind-first-then-lemma-statements design: B1 stalled, B2 closed it.
  - The fences: neutral subjects, the inventory fenced, claims forwarded verbatim.
  - The token-count lesson (item 38).
  - Budget anchors, from the harness's counts.

### 8. Everything else in the inventory

- **`BIBLIOGRAPHY.md`:** every row the gate touches; keep `tools/bib_audit.py` green.
- **`CLOSED-QUESTIONS.md`:** does RQ₄/RQ₅ answer a question posed in print? The planner found no poser; say so at exact scope, or cite
  one.
- **The reconciliation noted in item 25:** S0B's 29 rank-one cells against verifier H's 29 torsion characters.
- **Carried from FS-86:** the audit of `[AmbrusEtAl2023]`, the reading debts and the Johnson papers. Keep each in the inventory as
  carried; don't work them.

## Rules, each with its reason

- **The gates.** FS-89 added no Lean. Run:
  - `./scripts/build.sh` under a slot: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`;
  - `scripts/axioms.sh` and `scripts/vacuity.sh`, reading their logs under `build/gate/` and confirming that § The gate's counts are
    unchanged;
  - `tools/check_architecture.py`, `tools/bib_audit.py`, `tools/fs71_ledger_b_check.py --strict`;
  - the fact audit (section 4).

  Anything over about 2 GiB or 2 minutes runs under `scripts/slot.py`. **Never run `lake build`.** No search of any kind: the ban holds
  to 2026-10-01.
- **Commits.** Commit after each section, by explicit path, running `git diff --cached` first.
  - Never amend.
  - End each message with the attribution lines your harness supplies.
  - Report every hash; I check each against `git log`.
  - Don't push; I push.
  - Descriptive commit subjects are fine again: no blind agent is live.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation).
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages.** Keep responses short and save after every step.
- **Budget.** At about 400k tokens by your own count, stop at a clean boundary with the inventory ticked, commit, and tell me. A successor
  continues from the ticks. That is a good report, not a failure.
  - Agents' own counts have run at 55–70 % of the harness's this milestone (item 38), so 400k of yours is near the 500k line.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-close/`.
  /tmp is RAM. Don't open `~/source/lean-dir-owner/`.
- **Reporting.** Every report goes to me by SendMessage (`to: "main"`), including your final one. Keep your hand-back content-free:
  "close planner idle; reports go to the owner by SendMessage".

**What is yours to decide:**
- the wording of every row and entry;
- how many ledger rows;
- which findings earn a grokking;
- the derivation file's organisation;
- the stubs' ranks.

Push back on anything in the inventory, or in this brief, that you think is wrong. Thank you. The registered headline landed at a prior of
0.10; please file it at exactly the strength it has.
