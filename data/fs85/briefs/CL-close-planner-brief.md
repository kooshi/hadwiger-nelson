# Brief: FS-85's close (WORKFLOW step 9), for the planner who writes it

You are **de Bruijn**, the engineer who owns the mathematics of `/home/kooshi/source/lean-dir`, working as **the planner for FS-85's close**. I'm the product owner, the coordinating session. Kooshi, the human whose project this is, asked me to coordinate this milestone rather than write it.

His standing instructions for a close hold:
- *"close out with the findings"*;
- *"I don't want to lose anything from before. There's a lot to save."*

And this milestone's own ruling:
- *"A proven theorem about why its impossible is also valid. All novel knowledge is a success"*;
- asked whether proofs that rule approaches out count, he said *"yes"*.

**Every result enters the ledger and the Frontier at its exact scope and grade.**
- A hand proof checked twice is not "kernel".
- "Given Parts's trees" is part of a grade.
- "Not seen in print" is not "new".
- A result about de Grey's lattice `Λ` is not a result about the Moser ring `R₂`.

## Read from disk first

- `WORKFLOW.md`: step 9 in full, and steps 3.1 and 3.3, because the close re-reads §G and §IQ.
- `CLAUDE.md` and `DEBRUIJN.md`. Any copy in your context is stale. § Toolchain holds the finite-witness-free week, which runs to 2026-10-01; § Building holds the resource rule.
- `LEDGER.md`, by address, not loaded whole.

## Your checklist already exists

It is `plans/FS85-close-inventory.md`, items 1–81. It was written as the milestone ran, and every item names its source.
- **From now on you are its only writer.** Tick each item as you finish it: "done at <hash>", or "declined, with the reason".
- **Read every number from its source record, never from the inventory.** That is the one-home-per-fact rule, and it also catches the owner's slips. Items 18, 49, 59, 76 and 78 are owner errors.
- **The inventory is not scripture.** Fix what is wrong, add what is missing, and tell me.

## The sources

- **The plan:** `plans/FS85-rigidity-without-triangles.md`: §0, §G, §PA, §IQ, §S, §C, §P, §M, §X, §Y, and the owner's §R-review with rulings 1–4 and Kooshi's reading.
- **Stage C, the competition:**
  - `plans/FS85-C-deBruijn.md`: Route 1, Part 1, dB1–dB11;
  - `plans/FS85-C-Coxeter.md`: round 1, and round 2's R2.0–R2.12 (C1–C15);
  - the advisors: `plans/POROS-2026-09-24-fs85-plan.md` and `plans/POROS-2026-09-24-fs85-competition.md`, with the held file `data/fs85/held/HELD-plan-advisor.md`.
- **The blind verifications:**
  - `plans/FS85-V-verification.md`, V1–V8 (the stripes-to-periodicity chain; it found the wiki's Prop. 7 defect);
  - `plans/FS85-V2-verification.md`, V2-T1–T8 (the whole `F = P = 8Λ` chain; D1–D12).
- **Round 3:** `plans/FS85-R3-five-part.md` (R3a, R3b) and `plans/FS85-input-audit.md` (IA1–IA5; A3's prior art).
- **Tools and checks:** `data/fs85/`, including `owner-checks/`, `audit/`, `v2/`, `r3/`, `comp-*/` and `verifier/`.
- **The briefs:** `data/fs85/briefs/`.

## What the close must produce (WORKFLOW 9; the inventory itemises it)

1. **`plans/FS85-derivation.md`, new**, in the format of `plans/FS79-derivation.md`. Every theorem FS-85 proved outside the kernel goes in:
   - FS85-A1–A2;
   - dB1–dB11;
   - Coxeter's C-numbers;
   - R3a–R3b;
   - V1–V8, V2-T1–T8, IA1–IA5.

   Each entry carries its statement, grade, the proof's address, what rests on it, prior art and a kernel decision. Add one line each in `LEDGER.md` § B, and keep `tools/fs71_ledger_b_check.py --strict` green. **Merge duplicates honestly:** one entry per theorem, with every independent derivation credited by name.
   - **Apply V2's D1–D6 as you file.** R3a's scope becomes its conditional form (D1). The ideal `P₋` is `(1/9)β̃³O` (D2). Pick one chirality convention (D3). Close C7's "generic line" gap by V2's eigenspace proof (D4).
2. **`LEDGER.md` rows 85 onward.** How many rows, and their wording, are yours. The natural candidates:
   - **`F = P = 8Λ` on de Grey's lattice, by derivation.** Every four-colouring is `8Λ`-periodic, local at one prime above 2, pair-linear and striped; there are 9,120 of them.
     - It rests on Parts's no-monochromatic-√3-triple, whose trees were walked here as a certificate, whose root split was proved here by hand, and whose placement in `Λ` is exact.
     - It has two independent derivations: the agents' chain and verifier 2's. `P = F` alone has three mechanisms.
     - Row 78's certificate is no longer needed for it, and row 78 gets a pointer.
     - It answers Mixon's 2018 question at its exact scope (V2 C3). Credit Hubai, Gibbs, Tao and Parts.
   - **The abstract triangle-free forced pair.** `G(ℤ, D)`, `|D| = 70`, `F₄ = 4ℤ`, at two derivations. With it: the every-`k` uniquely colourable triangle-free circulants ("not seen in print, folklore-grade", IA5, a corollary of `[KlotzSander2017]` Thm 4.2), and dB4, which makes a forced pair in `𝒰^tf` equivalent to Soifer 55.1 (genericity closed for `m ≥ 4`).
   - **The no-gos and negatives:**
     - C14: radius-1 averaged certificates cannot lift `120Λ` to `8Λ`;
     - C11: family ±4 is indispensable;
     - G54's middle case observed at `Λ/16Λ` (item 55);
     - the infinite lattice is not Hoffman-tight.
   - **The published-argument defect:** the wiki's Prop. 7 does not close as written, and the one-line repair.
   - **Every row states what is not claimed.**
3. **Corrections owed:**
   - row 78 and FS73-T6's "`η^{±3} ∉ Λ`" (item 18);
   - the plan's P-K1held non sequitur (item 34);
   - 776 → 783;
   - the "not held" slip (items 77–78);
   - `[Parts2020hv]`'s bibliography row (already corrected by the auditor).
4. **`CLAUDE.md`, current state only.**
   - **The Frontier:**
     - item 18's "forced by one 2,044-point certificate" becomes the derivation;
     - FS-74 closed;
     - the mission and exposed-prediction paragraphs where they change;
     - the ledger pointer;
     - Paths forward.
   - **The grokkings:**
     - **G54 rewritten.** The middle case is observed, so slack permits gaps and does not supply them.
     - **G73:** the averaged format narrowed on `Λ`.
     - **G70 and G69:** 8Λ and Harder's pair are now derived.
     - **G72's third count**, together with Kooshi's ruling that no-gos count (item 36). Update G72's count sentence.
     - **Instances:**
       - G21: the rank-1 scan measured its range; the transfer check measured membership, not logic;
       - G49/G50: Klotz–Sander and Bašić held since FS-38; the wiki tools uncited; Gibbs's abandoned route; Klotz–Sander Thm 4.2 one page after they posed 3.6;
       - G51: FS-85's run; personas; convergence; the owner-write leak and the start-up snapshot channel; two blind verifiers; the input audit.
     - **Perhaps a new grokking** for the mechanism, in G67's form: where triangles enter, namely the hexagon symbol `1 + ζ² = ζ` and Parts's local no-triple; locality at the tight dyadic quotient; the 5-part killed pointwise.
       - Weigh it against Coxeter's R2.6 reading: in triangle-free lattices the analogous frequencies are generically non-torsion.
       - Whether it earns an entry, and its number, are yours.
   - **The week's verdict** (Paid / Paid (abstract) / Draw (K) / Draw / Null, per the plan's §P and ruling 1), scored once and read with Kooshi's words. Count the search logs across every agent, the breaches included (items 24, 53, 56).
   - **§ Toolchain's ban line** stays current-state until 2026-10-01.
   - **Size.** The budget is 275,000 bytes and the file is about 273,400 now. **You must compress without loss** to fit this close. Never touch a `[PROTECTED]` paragraph, and never trim an entry's *Do* or its killing test.
   - **The fact audit at the end:** `tools/claude_md_fact_audit.py --base 202bc890` (FS-85's minting commit, the last change before this close) and `--dupes` (it stood at 13 runs). Nothing lost, nothing retold; an intended change gets an ALLOW entry with its reason.
5. **§R-close in the plan.**
   - The §G re-read: which extractions paid, and which entries should have borne and did not.
   - The §PA sweep for recognitions: the hom-shift and frozen vocabulary; Greenwell–Lovász products; Gibbs's route.
   - The §IQ re-read and G72's count.
   - **The predictions, scored once:**
     - the plan's §P, including P-S1b, "`F ⊇ 8Λ` derived with no certificate at two independent derivations by the close", registered at 0.25;
     - P-W3, P-W4 and P-W5;
     - both advisors' hunches;
     - both verifiers' C0 predictions;
     - R3's prediction.
   - The retraction tally, the errata and the honesty record: every owner error and agent slip in the inventory.
6. **Stubs, and `plans/FRONTIER-STUBS.md` re-ranked** honestly, one rank per row.
   - FS-85's and FS-74's banners.
   - **New stubs or re-aims, where the findings earn them:**
     - four-colour rigidity over ℚ(√59) and ℚ(√83): the held H5 idea, now public, with its falsifier;
     - gap B / FS-67's four-colour form (product rigidity);
     - Mixon's follow-up (finitely many colourings of the literal ring);
     - the kernel targets: V2-T5, the stripe lemma; W as a conditional theorem with (S) a named hypothesis; a checker for Parts's trees;
     - FS-76 re-aimed (`P = F` now holds on `Λ`);
     - FS-59's bearing (Coxeter's R2.6).
   - **Don't pre-empt the next direction.** Mark which stubs the finite-witness-free week can run, and leave the choice to Kooshi.
7. **The protocol, `plans/PROTOCOL-competitor-and-advisor.md`:** FS-85's run, in §3's style.
   - The owner-write leak and the fence rule: neutral commit subjects from the first competitive commit on, and the harness start-up snapshot.
   - Successor preambles, early blind verification during a running competition, and the input audit.
   - **Budget anchors** (from the inventory):
     - planner about 330k working;
     - plan-phase advisor about 320k working;
     - competitors about 310–520k;
     - competition advisors about 475k and 441k;
     - verifier 1 about 345k; verifier 2 about 330k;
     - round-3 agent about 370k; auditor about 220k working (640k harness).
8. **Everything else in the inventory:**
   - **`CLOSED-QUESTIONS.md`:** a Mixon 2018 entry at exact scope (V2 C3; item 77(c)), and §3's Soifer 55.1 status (the equivalence dB4; still open).
   - **`BIBLIOGRAPHY.md`:** the unlogged arXiv:2001.08801 (`tools/bib_audit.py` exits 1 until it is logged); the wiki's Prop. 7 defect noted on `[Polymath16wikiR2]`.
   - The open debts carried: the Johnson papers.

## Rules, each with its reason

- **The gates.** FS-85 added no Lean. Run:
  - `./scripts/build.sh` under a slot: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`;
  - `scripts/axioms.sh` and `scripts/vacuity.sh`, reading their logs under `build/gate/` and confirming § The gate's counts are unchanged;
  - `tools/check_architecture.py`, `tools/bib_audit.py` and `tools/fs71_ledger_b_check.py --strict`.

  Anything over about 2 GiB or 2 minutes runs under `scripts/slot.py`. **Never run `lake build`.** No SAT solver, and no search of any kind: the week's ban holds.
- **Commit after each section, by explicit path.** Run `git diff --cached` first. Never amend. End each message with the attribution lines your harness supplies. Report every hash; I check each against `git log`. Don't push; I push.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Budget: at about 450k tokens, stop at a clean boundary** with the inventory ticked, commit, and tell me. A successor continues from the ticks. That is a good report, not a failure. FS-73's close took two planners.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-close/`. /tmp is RAM, so keep large files on disk. Don't open `~/source/lean-dir-owner/`.
- **Every report goes to me by SendMessage (to: "main")**, including your final one. Keep your hand-back content-free ("close planner idle; reports go to the owner by SendMessage").

**What is yours to decide:**
- the wording of every row and entry;
- how many ledger rows;
- which findings earn a grokking;
- the derivation file's organisation;
- the stubs' ranks.

Push back on anything in the inventory you think is wrong. Thank you. This one has a great deal worth saving.
