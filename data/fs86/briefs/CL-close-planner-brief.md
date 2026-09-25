# Brief: FS-86's close (WORKFLOW step 9), for the planner who writes it

You are **de Bruijn**, the engineer who owns the mathematics of `/home/kooshi/source/lean-dir`, working as **the planner for FS-86's close**. I'm the product owner, the coordinating session. Kooshi, the human whose project this is, asked me to coordinate this milestone rather than write it.

His instructions for this close:
- *"Awesome results. Let's close out, then we'll spawn an advisor to decide what to do next: the missing theorem, 2 hours of sanctioned search time, or something else."*
- His standing close rules: *"close out with the findings"*, and *"I don't want to lose anything from before. There's a lot to save."*
- *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* No-gos count.

**Every result enters the ledger and the Frontier at its exact scope and grade.**
- A hand proof checked by a blind verifier is two derivations, not "kernel".
- A result on the local 2-adic plane is not a result on a field plane.
- A result on a lattice is not a result on the field plane.
- "Given FS-66's certificate at 11" is part of a grade.
- "Not seen in print" is not "new".

## What FS-86 was, in two sentences

It asked whether the four-chromatic, triangle-free plane over ℚ(√59) (and ℚ(√83), ℚ(√131)) carries a four-colour forced pair, which would answer Soifer's Open Problem 55.1. It re-framed the question at the field level (`F(R) ∈ {0, R ∩ 𝔓⁴}`; the whole question is whether `(0, 4)` is forced), left that question undecided, and proved a large family of no-gos and side results: every natural construction of a non-periodic four-colouring is impossible.

## Read from disk first

- `WORKFLOW.md`: step 9 in full, and steps 3.1 and 3.3, because the close re-reads §G and §IQ.
- `CLAUDE.md` and `DEBRUIJN.md`. Any copy in your context is stale. § Toolchain holds the finite-witness-free week, which runs to 2026-10-01; § Building holds the resource rule.
- `LEDGER.md`, by address, not loaded whole.

## Your checklist already exists

It is `plans/FS86-close-inventory.md`, items 1–69, plus **§ Held items** at its end. That section is the substance of the rows marked "restored at hand-back", kept out of the file during the competition and restored now.
- **From now on you are its only writer.** Tick each item: "done at <hash>", or "declined, with the reason".
- **Read every number from its source record, never from the inventory.** That is the one-home-per-fact rule, and it catches owner slips. Items 9 (a known-negatives line corrected before launch), 39 (competitors not briefed to work in stages), 44 (the advisor not told of a stand-down), 46 and 67 (two paraphrase slips in verifier briefs) record owner errors and slips.
- **The inventory is not scripture.** Fix what is wrong, add what is missing, and tell me.

## The sources

- **The plan:** `plans/FS86-dyadic-rigidity.md`:
  - §0 (the reframe), §G, §PA, §IQ, §S, §B, §C, §P, §M, §X, §Y;
  - the owner's §R-review with rulings R1–R6. Rulings R7–R9 are in the inventory, items 31 and 65.
- **Stage B:**
  - `plans/FS86-B1-verification.md` (the blind verification of the frame: V0–V4, V3-ram, VK, Lemmas R, P, D);
  - `plans/FS86-B2-profile.md` (`Λ₅₁₀`'s dyadic profile, B2-T1–T3, B3's certificates);
  - tools in `data/fs86/stageA/`, `b1/`, `b2/`, `b3/`.
- **The competition:**
  - `plans/FS86-C-deBruijn.md` and `plans/FS86-C-Coxeter.md`, each written by **three successive seats**. Each seat's successor preamble is in `data/fs86/comp-*/`, and tools are in `data/fs86/comp-*/`;
  - the advisors: `plans/POROS-2026-09-25-fs86-plan.md` and `plans/POROS-2026-09-25-fs86-competition.md` (its §7 is the killing-test verdict, §7a a reading of round 2 against §P);
  - the held files: `data/fs86/held/`.
- **The four quiet blind verifiers:**
  - `plans/FS86-V-W-verification.md`: de Bruijn's A, A1, B, C0, D₀;
  - `plans/FS86-V-X-verification.md`: D, D′, H, and Lemma C′;
  - `plans/FS86-V-C-verification.md`: Coxeter's C14, C12.1, C13.0, C10;
  - `plans/FS86-V-D-verification.md`: HD1-cert, T1, Theorem C (refuted as stated; proved under H*), with a PARI counterexample;
  - their briefs are `data/fs86/briefs/V-*.md`, and their tools are in `data/fs86/v-*`.

## What the close must produce (WORKFLOW 9; the inventory itemises it)

### 1. `plans/FS86-derivation.md`, new

- **Format:** that of `plans/FS85-derivation.md`.
- **Scope:** every theorem FS-86 proved outside the kernel, from every agent. That means the planner (FS86-A1–A4), the plan-phase advisor (FR-1, the ramified-tower fibre argument), B1, B2, both competitor files (all seats), the four verifiers and the competition advisor's reductions.
- **Each entry carries:** its statement, grade, the proof's address, what rests on it, prior art and a kernel decision.
- **Merge duplicates honestly:** one entry per theorem, with every independent derivation credited. For example:
  - Theorem A has two derivations (de Bruijn's; verifier W's shorter route);
  - HD1 for finite-type characters was proved independently by both sides (C10 and HD1-fin);
  - HD4 was proved by de Bruijn-3 and found by verifier X.
- **Apply every verifier correction as you file:**
  - W's D1, D4, D7;
  - X's scope widenings: D′ and D's pullback half need no V3 via Lemma C′; H for every number field;
  - C's scope notes: one coset in C14; C12.1's "iff" vacuous; the class;
  - D's refutation of Theorem C's "non-real" clause and its H* version.
- **`LEDGER.md` § B:** one line each; keep `tools/fs71_ledger_b_check.py --strict` green.

### 2. `LEDGER.md` rows 88 onward

How many rows, and their wording, are yours. Every row states what is not claimed. The natural candidates:
- **The field-level frame for type-(B) fields:** `F(R) ∈ {0, R ∩ 𝔓⁴}` and `P(R) = R ∩ 𝔓⁴`, so the whole question is `(0, 4)`. Two derivations. V3 rests on FS-66's certificates at 11 and 19 plus `[Zhang2012]`.
- **The K classification:** every four-colouring of `K²` is, per `R_K`-coset, a pullback from `P₄` at one of K's two dyadic places, and `F(R_K) = 4R_K`. Two derivations. The prior-art check found nothing (Speyer 2018 posed the level-one question on the Moser ring). Check how it sits with row 85's `8Λ`.
- **The local plane over ℚ₂(√3) is four-colour rigid (Theorem A),** with its corrected grade.
- **The no-go family on type-(B) planes** (and wider scopes where verified): D, D′ (V3-free), H (every field), C14 (measurable windows at finitely many places, S2-wide, pointwise), HD1-fin/C10, HD4, B, D₀/W, C7. With them, **HD1-cert**: HD1 is equivalent to a finite certificate, semi-decidable, with no size bound.
- **ℚ(√2,√3) is in S2, with triangles** (C12, C12.1), and the triangle question there becomes "is √3 a four-colour virtual edge?" (C13).
- **C9:** an explicit non-periodic four-colouring of ℚ(√11)'s plane, by formula.
- **Theorem C** under H*, with the quartic counterexample to its broad clause.
- **The negative results on the record's own claims:**
  - FS38-L1's tightness half is defective;
  - "tightness propagates up a tower with constant fibres" is false in general (`Λ₅₁₀`: tight at 14, slack at 24);
  - the correct statement for unramified-quadratic dyadic towers (C12.1 with FS38-L2's non-strict half).
- **`Λ₅₁₀`'s dyadic profile** (B2), if it earns a row.
- **A question for you, not a claim:** does C14's count also show that the type-(A) fields ℚ(√47) and ℚ(√167) have **no** measurable window four-colouring at all? Every factor there has ratio below 1/4. If it holds, state it at exact scope, because it bears on FS-84 and FS-59. If not, say why.

### 3. Corrections owed (the inventory lists them)

- FS38-L1, D3, and the D2-B line for levels 1–4;
- row 67's propagation clause;
- G54's propagation sentence and its unlabelled margin at 31;
- the stub's and H5's "11, 19, 23";
- plan §0.4's false ℚ(√11) side claim (B1's D8);
- de Bruijn §1.3's K sentence;
- D₀'s missing h ≠ 0;
- Theorem A's grade;
- Theorem C's scope;
- C14.4's numeric slip;
- **row 85 and G75's attribution**: the periodicity step is Kari–Szabados's annihilator method; the one-family exception is Herva–Kari/Puzynina (de Bruijn §6.6);
- **B1's Lemma R's stated scope at ramified dyadic places** (verifier D's retraction note);
- V3-ram's "ratio" wording.

### 4. `CLAUDE.md`, current state only

- **The Frontier:** item 23's FS-86 sentence becomes the results; FS-86 closed; the exposed-prediction and theory paragraphs where they change; the ledger pointer; Paths forward.
- **The grokkings:**
  - **G54:** propagation corrected, with a demotion record.
  - **G75:** its attribution to Kari–Szabados; its killing test's status; the triangle-free obstruction.
  - **G71/G73:** the measurable-window format closed on S2.
  - **G72's fourth count:** was FS-86's result reached through the structural question?
  - **Instances:**
    - **G21:**
      - a plant that fired for the wrong reason (Γ₂₇);
      - B1's silent PARI stability checker;
      - W's unreachable ζ ↦ ζ⁵ plant;
      - the two owner-brief paraphrase slips.
    - **G49/G50:**
      - Zhang 2012's MIS-normal half, held and unread for this question;
      - Kari–Szabados;
      - Kuhlmann;
      - Berend and Einsiedler–Lindenstrauss (unread);
      - Godsil–Roberson–Rooney as D2-A(ii) in vector-colouring words.
    - **G51:** FS-86's run.
  - **Perhaps a new grokking** in G67's form, for what the milestone understood. For instance: that rigidity is local at the tight place and the global question is extension; or that every non-periodic construction dies, and the obstruction is measure rigidity with isometric archimedean directions. Both sides reached that obstruction independently. Whether it earns an entry, and its number, are yours.
- **§ Toolchain's ban line** stays current-state until 2026-10-01.
- **Size.** The budget is 275,000 bytes and the file is about 274,600 now. **You must compress without loss** to fit this close. Never touch a `[PROTECTED]` paragraph, and never trim an entry's *Do* or its killing test. Last time the lossless lever was turning items that retold ledger rows into pointers.
- **The fact audit at the end:**
  - `tools/claude_md_fact_audit.py --base 46f42ca1`. That is the commit that opened FS-86's inventory (item 7), and it is FS-86's base.
  - `--dupes`, which stood at 11.
  - Nothing lost, nothing retold. An intended change gets an ALLOW entry with its reason.

### 5. §R-close in the plan

- The §G re-read: which extractions paid, and which entries should have borne and did not.
- The §PA sweep for recognitions: vector colourings; Zhang's MIS-normality; the annihilator method; valued-field model theory; measure rigidity.
- The §IQ re-read, and G72's count.
- **The predictions, scored once:** the plan's §P table (P-free … P-log), plus every C0 in B1, B2, W, X, C and D, and the advisors' predictions.
- **The verdict.** The competition advisor reads the outcome as falling in a gap of §P's partition, and its reading is "Paid (no-go)". **Rule it explicitly, with the reason:**
  - my ruling R3 exists because after-the-fact placement is the least trustworthy kind;
  - Kooshi counts no-gos;
  - verdicts score only the experiment.
- **The retraction tally:** de Bruijn 2, Coxeter 1, advisors 0, verifiers' own, the errata and the honesty record (every owner error and agent slip).
- **The search-log count across every agent,** read with Kooshi's remark on whether the ban's constraints were creative or friction.

### 6. Stubs, and `plans/FRONTIER-STUBS.md` re-ranked

Re-rank honestly, one rank per row. FS-86's banner goes on. **Write the candidates Kooshi named as stubs an advisor can compare side by side,** each with its cost, its bearing on χ ≥ 6, and whether it needs search:
- **(a) The missing theorem:** an S-adic, Berend-type measure-rigidity result for the unit-vector action on the dual of `R`, with isometric archimedean directions. It gives HD1, and bears on `F(R)`.
- **(b) Candidates for "2 hours of sanctioned search time",** which is Kooshi's to grant. Price each exactly:
  - HD1-cert's certificate on `Λ₅₁₀` and a saturation. It is semi-decidable with no size bound, so price what 2 hours could and could not show;
  - "is √3 a four-colour virtual edge in ℚ(√2,√3)'s plane?", which is a finite-witness question for single forcers;
  - anything else the records name.
- **(c) Others the findings earn:**
  - Theorem C's Lemma X;
  - the three-phase case;
  - the type-(A) corollary question above;
  - FS-67 re-aimed (Zhang answers its main case);
  - FS-83 (dead at `k = 4` on type-(B) planes, by C14 and C10);
  - FS-64 (its finitely-many-places form closed on S2);
  - FS-76 (HD4, D, D′);
  - FS-59 and FS-84 (C14's bearing);
  - the kernel targets (W1, Lemma R, C12.1).
- **Don't pre-empt the choice:** the post-close advisor and Kooshi decide.

### 7. The protocol, `plans/PROTOCOL-competitor-and-advisor.md`

Add FS-86's run, in §3's style:
- **Staffing:**
  - stage B split into a blind verifier and a computation agent;
  - quiet blind verifiers during a live competition, with briefs in the owner's scratch;
  - successor seats: three per side;
  - notifying the advisor of every stand-down and launch.
- **Incidents:**
  - the output-token-limit incident (three lost responses, and the "work in stages" rule);
  - the paraphrase slips (**quote statements verbatim in briefs**).
- **Findings about the design:** convergence without contact, and both sides reaching one obstruction.
- **Budget anchors,** from the inventory and the records' own counts.

### 8. Everything else in the inventory

- **`CLOSED-QUESTIONS.md`:** Soifer 55.1's status, what FS-86 excludes, at exact scope.
- **`BIBLIOGRAPHY.md`:**
  - Berend 1984's read status (unread);
  - an Einsiedler–Lindenstrauss entry if cited;
  - Puzynina (unread, not held);
  - Soifer 2019, the posing paper (not held; obtaining it is Kooshi's call);
  - `tools/bib_audit.py` passes now; keep it green.
- **Carried:** the Johnson papers; **the Ambrus et al. input to C14.** `[AmbrusEtAl2023]` Thm 1 is computer-assisted. The competition advisor asks that it be audited as a fixed certificate. Existing checkers on existing certificates are allowed this week. **If you judge it needs its own agent, tell me and I'll staff an auditor alongside you.**

## Rules, each with its reason

- **The gates.** FS-86 added no Lean. Run:
  - `./scripts/build.sh` under a slot: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`;
  - `scripts/axioms.sh` and `scripts/vacuity.sh`, reading their logs under `build/gate/` and confirming that § The gate's counts are unchanged;
  - `tools/check_architecture.py`, `tools/bib_audit.py`, `tools/fs71_ledger_b_check.py --strict`.

  Anything over about 2 GiB or 2 minutes runs under `scripts/slot.py`. **Never run `lake build`.** No SAT solver and no search of any kind: the week's ban holds, and Kooshi's 2-hour exception is for after the close, not for it.
- **Commits.** Commit after each section, by explicit path, running `git diff --cached` first. Never amend. End each message with the attribution lines your harness supplies. Report every hash; I check each against `git log`. Don't push; I push. The competition is over, so descriptive commit subjects are fine again.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation).
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages.** Keep responses short and save after every step. One agent this milestone lost three responses to the output-token limit.
- **Budget.** At about 450k tokens, stop at a clean boundary with the inventory ticked, commit, and tell me. A successor continues from the ticks. That is a good report, not a failure: FS-85's close took two planners.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-close/`. /tmp is RAM, so large files go to disk. Don't open `~/source/lean-dir-owner/`.
- **Reporting.** Every report goes to me by SendMessage (to: "main"), including your final one. Keep your hand-back content-free: "close planner idle; reports go to the owner by SendMessage".

**What is yours to decide:**
- the wording of every row and entry;
- how many ledger rows;
- which findings earn a grokking;
- the derivation file's organisation;
- the stubs' ranks.

Push back on anything in the inventory, or in this brief, that you think is wrong. Thank you. This one has a great deal worth saving.
