# Session handoff — FS-73 mid-milestone (2026-09-23, night), before the competition phase

*Written by the product owner before a compaction, for a reader with no conversation memory. Everything here can be checked
against the repository. Agent ids, the held advisor items and the drafted competition briefs live in the session scratchpad
(`/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-owner/`: `state.md`,
`held-items.md`, `P3-competitor-brief.md`, `P3-advisor-brief.md`). They are deliberately not in the repository: the competitors
read the repository, and the held items must reach them only through the advisor.*

## 0. First acts after compaction

1. **Read the owner's running notes** (`fs73-owner/state.md` in the scratchpad above). They hold every agent id, every ruling
   and the close-item list, which §5 below repeats.
2. **Implementer D may still be running** (P1e and P1f: the rich lattices over ℚ(√3,√5), and the census README with its
   standalone checker). Its id is in `state.md`. Wait for its hand-back, then review it by artifact:
   - check every commit hash it reports against `git log`;
   - run its new checker yourself;
   - plant a fault of your own and confirm the checker refuses it.
3. **Then launch P3, the competition**, from the drafts in §3.

## 1. The staffing and role rules now in force (Kooshi)

| rule | source | where it is recorded |
|---|---|---|
| **Opus 5.5 for every role** until further notice (`model: "opus"` → `claude-opus-5-5[1m]`, checked) | 2026-09-22 | `CLAUDE.md` § Delegation; memory `model-choice.md` |
| **Replace, don't reuse, any agent that returns above ~500k tokens**, whatever the model | 2026-09-22 | § Delegation; memory |
| **Up to three agents at once** (de Bruijn, Coxeter, Poros); still no child spawns children | 2026-09-23 | § Delegation; `plans/PROTOCOL-competitor-and-advisor.md` rule 9 |
| **For FS-73 the product owner coordinates and reviews, and does not contribute** | 2026-09-23 | memory `m63-product-owner-orchestration.md` |
| "I'll trust your decisions in the meantime": drive phase to phase without go-aheads (never push unasked, never amend, halt on unexplained crashes) | 2026-09-23 | memory |
| **Pushed on Kooshi's go:** `9fb4513d..72129faf` | 2026-09-23 evening | — |
| **No kernel proof of the big certificate.** Kooshi prefers "an attempt at an algebraic explanation in a separate milestone rather than formalizing a big graph". Record the kernel decision for v's certificate as *declined, with that reason*, and mint the stub at the close (§5) | 2026-09-23 evening | memory `hadwiger-nelson-project.md` |

**Every brief says three things:** that no child spawns children (with the reason), how to reach the product owner (SendMessage
`to: "main"`), and to use the shared heavy-job lock
(`flock -w 1800 …/scratchpad/locks/heavy.lock <cmd>` for anything over ~2 minutes or ~8 GB).

## 2. Where FS-73 stands

**The plan.** `plans/FS73-rigidity-dichotomy.md`, accepted (`9d1fe367`, `974ec8fa`, `73114a7f`, then the modeling passes
`085fab95`, `9fdb9d67`, `1b8e933c`, `29ce2745`). The question is C3-inherit, in subgroup form: the forced group `F` against the
H1 group `P` (the common periods of all periodic colourings), with `F ⊆ P`, and the question is whether `P = F`.

| phase | status | record · key commits |
|---|---|---|
| P0 (spectrum) | done | §R0 of the plan |
| P1a–P1d′ (census at K) | **accepted** | `data/fs73/records/phase-P1.md` (implementers A and A2); `194198ef` … `9ae8b79f` |
| P1d verification (independent) | **accepted** | `data/fs73/records/verify-P1d.md`; `b5f32334`, `d43739d9` |
| P1g (Poros's card on L3) | **accepted** | `75c7c4af` |
| P1e, P1f | **running (implementer D)** | appends to `phase-P1.md`; `data/fs73/census/README.md`, `tools/fs73_census_check.py` |
| P2 (classification table) | **accepted** | `data/fs73/records/phase-P2.md`, `data/fs73/table/TABLE.md`; `e42b3a32` |
| P2 ℚ(√11) verification | **accepted** | `data/fs73/records/verify-P2-q11.md`; `4eba7998` |
| P2b (ℚ(√167)) | **accepted** | `data/fs73/records/phase-P2b-q167.md`; `3807b9f5`, `72129faf`, `b2e67b18` |
| P5 (kernel, `Kempe.lean`) | **accepted**: zero `sorry`, standard three axioms, in `Proofs.lean` | `data/fs73/records/phase-P5.md`; `cb0813d1`; architecture row `9c8a60a5` |
| P3 (competition) | **next**; briefs drafted | §3 |
| P4 (rank-6 mechanism) | not started; P1g's card is its first measurement | plan §S.2 |
| P6 (close) | — | §5 |

**Results (grades as in `CLAUDE.md` § Notation):**
- **[cert] De Grey's lattice over K = ℚ(√3,√11), four colours: `F = P = 8Λ`.**
  - The pair `(0, v)`, `v = −(4/9)(1+√−11)`, is forced by a 2,044-point graph plus the edge {0, v}. It has a trimmed LRAT proof (383,771 additions, 56.5 MB gzipped, in git by the product owner's ruling) and a standard-library checker `tools/fs73_cert_check.py`. The product owner ran the checker (CERTIFIED in 16 s) and a planted moved vertex was refused. An independent verifier also refused both pairs with Glucose and drat-trim, with live negative controls.
  - Λ = (1/9)·O_E with E = ℚ(√−3,√−11), and v's orbit spans 8Λ; this is Poros's identity, re-derived twice.
  - The upper half, P ⊆ 8Λ, comes from exhibited separators.
  - **So every four-colouring of the lattice is 8Λ-periodic.** There are 380 pinned colourings in 12 orbits, and G70 holds on them.
  - The pair 8/9 = −(v + v̄) and Harder's 8/3 are elements of F.
- **[verified] ℚ(√11)'s Λ₁₀ (the 36 unit vectors of denominator dividing 10), three colours: `F = P = 3Λ`.**
  - FS-58's forcers u₁ (52 points) and u₂ (65 points) carry it, and both are needed.
  - All 48 three-colourings are affine, forming one orbit.
  - Λ₅₀ gives `F = P = 3Λ₅₀`; that is replicated but not independently verified.
- **[hand] The fixed-prime gap lemma** (P2): every other lattice in the table is loose by theorem.
- **[cert] ℚ(√167):**
  - L3e1c94c6 is three-colourable with period 23: a gapped residue colouring at (23, √167 − 11), certified with a completeness proof of U. P2's "no periodic colouring" label measured its search, which stopped at 20.
  - 52 of FS-61's 57 lattices carry certified gapped periodic three-colourings. Only Ld14c588b and L21cc6506 survive, and both are priced out.
  - A residue-set design rule at 23 and 43 exists for FS-59.
- **[derived] P-D3 (row 67) is refuted:** `G ∪ (G + 8/3)` forces 16/3, which has depth 4.
- **[tools] The informative instance (generator graph only), from D:** twounits:14 over ℚ(√3,√5), rank 8.
  - F_known = 0, and P_found has rank 8 with finite index, containing 4/3, 8/3, 4, 4/7 and 4/√3.
  - Forcing asks at 4/3 on word balls are pending. The product owner cautioned about the word-ball core ceiling (G65).

**Predictions scored so far** (details in the records):

| outcome | predictions |
|---|---|
| won | P-C1, P-C2, P-C6, P-T1, P-R1 (index-81 component), C's P-C1/P-C1b |
| lost | P-S1, P-C4, P-T2 (to an unregistered outcome, since superseded), P-C3(b) |
| decided | P-C5 (P = F) |
| void | P-C3(a): its informative outcome was unreachable |
| won on the verdict, lost on the mechanism | P-T3 |
| held | G70 |

## 3. The competition (P3): how to launch it

**Drafts.** `fs73-owner/P3-competitor-brief.md` and `fs73-owner/P3-advisor-brief.md`. They replace the plan's §C, which predates today's results: its "K may be the instance under test" and "8/3's orbit has rank 2 at K" are superseded.

**The challenge.** Explain or refute C3-inherit for a class containing both proved instances. The prize is a derivation predicting F = 8Λ at K and F = 3Λ at ℚ(√11). Fallbacks (a)–(d), with a "not landed" headline if neither theorem nor counterexample lands.

**Placeholders to fill.**
- Competitor brief: `{NAME}` (de Bruijn / Coxeter), `{OTHER}`, `{OTHER_ID}`, `{POROS_ID}`, `{SCRATCH}` (make `fs73-comp-debruijn/` and `fs73-comp-coxeter/`), and `{FILE}` (`plans/FS73-C3-deBruijn.md` / `plans/FS73-C3-Coxeter.md`).
- Advisor brief: `{DEBRUIJN_ID}`, `{COXETER_ID}`, and `{HELD_ITEMS}`, which gets `held-items.md`'s two items. Its scratch directory is `fs73-poros-P3/`.
- **`[CENSUS: …]` in both briefs:** write D's final result on twounits:14.

**Spawn order** (ids are circular):
1. Poros, told that the ids follow by message.
2. de Bruijn, with Poros's id, told that Coxeter's follows.
3. Coxeter, with both ids.
4. Message de Bruijn Coxeter's id, and Poros both ids.

This fills the three-agent cap, so D must be finished first.

**Rules carried in:**
- Isolated scratch directories.
- Identical briefs.
- Teasing hints only between competitors.
- Poros writes its expectation first.
- The held items go to both competitors at once, only after each has written its first route (ruling R1).
- Retractions are counted.
- A theorem's key step is re-derived by the other side or by Poros, and one step by the product owner.

**Kooshi's separate milestone** (the algebraic explanation) overlaps fallback (b). The competition stays on the general question, and its output seeds the new milestone.

## 4. Rulings the product owner made this milestone (each in `state.md` with reasons)

1. **R1.** The plan-phase Poros's two held items (irreversible walls tied to G58; window colourings through the other complex embedding) stay out of the plan. They go to both competitors at once, through the P3 advisor.
2. **R2.** The target of question (1) stays "theorem or counterexample", with a registered outcome prediction and named fallbacks.
3. **R3.** The F_μ invariant-measure frame goes into §0, §G and §C; it is not held.
4. **The census's sandwich.** Ask forcing on the *generators* of P_found modulo F_known (the coset version is infinite at rank 2). The degree-up certification route was relaxed once Poros showed v alone suffices.
5. **The 56.5 MB LRAT stays in git.** A reviewer never re-runs a solver; FS-61's 45 MB file is the precedent.
6. **P1d′ runs N = 24 and 32 past the plateau rule.** The rule counted periods that cannot move the 2-adic part (a G21 defect).
7. **No dense ball at ℚ(√167)**, because a theorem answers it.
8. **Kill of orphan kissat pid 884222.** It had been re-parented after its table driver died, with nothing reading its result.

## 5. Close items (P6), so nothing is lost

- **`LEDGER.md` row 78 and the Frontier.**
  - F = P = 8Λ at K, with its certificate.
  - F = P = 3Λ at ℚ(√11) Λ₁₀.
  - The fixed-prime gap lemma.
  - The ℚ(√167) screen and design rule.
  - P-D3 refuted.
  - Theorems filed in `plans/FS73-derivation.md` and `LEDGER.md` § B (every phase record has its "Theorems this phase proved" heading).
- **Kernel decision for v's certificate:** declined, per Kooshi, in favour of an algebraic explanation. **Mint that milestone's stub:**
  - the algebraic explanation of F = 8Λ at K and 3Λ at ℚ(√11);
  - the lead is B's tight-prime reading, Λ = (1/9)O_E, and O_E/8O_E as the product of the level-3 quotients at the primes above 2, compared with row 67.
- **Candidate grokkings** (G67 form):
  - B's tight-prime reading;
  - "Fourier-transform a solver's colouring before searching periods" (C);
  - "price leaves in minutes after a fine obligation pass" (K: priced at 1.5 days, took 40 minutes).
- **`CLAUDE.md` corrections:**
  - G69 (Harder's smallest forcer is 745 points, not our 23,083-point ball; "three orders" should read nearer four);
  - G60 and G66 (the F_μ and profinite-completion sentences);
  - FS58-T4's kernel note (Mathlib has `Finset.rado_selection` and `nonempty_hom_of_forall_finite_subgraph_hom`), and FS-39's phase A;
  - "rigid" qualified against *frozen* (`[AlonEtAl2021]`) and `[PeledSpinka2023]`;
  - § The gate counts (axioms 1004→1034 clean; vacuity declarations 6728→6795, refutations 270→278, sites 262→275, generic 240→253). The header of `scripts/vacuity-baseline.txt` is stale (it reads 6723).
- **Plan and record fixes:**
  - T10.2's wording: membership, not the index, decides.
  - The plan's §C "depth 6 (8/3)" convention clashes with depth 3 per prime.
  - P1d′'s outcomes should include "P = F certified"; §0 consequence 5 is closed.
  - P-R1 should be restated per Kempe component (the least-ℓ rule is a convention; 301 of 2,304 colourings escape only non-locally).
  - B's four plan edits: 2-unit is not "dead"; rank-2 denominator lattices; chainability is field-relative; the command name.
  - T5's prose defect: the prime above 3 splits in ℚ(√5,i) over ℚ(√5).
  - P2's table rows for L3e1c94c6 are superseded (C's wording is in its record).
  - Re-score P-T2.
- **Tool defects:**
  - P2's quotient code takes the lock itself, so wrapping it in `flock` deadlocks.
  - It writes CNFs into B's scratch directory.
  - An orphaned solver outlived its driver.
- **Prior art owed:**
  - Is a four-colour forced pair at 8/9 (under a unit apart), or at v, over K anywhere in Polymath16 or Parts?
  - The Semantic Scholar cross-check (HTTP 429 at the gate).
  - `[PeledSpinka2023]`'s "rigidity", read enough to state the collision.
  - Mohar–Salas 2009, if P4 uses Kempe classes on tori.
- **The product owner's notes** (for Kooshi):
  - A spindle at 8/9 adjoins √(4d²−1) = (5/9)√7, so it lands directly in K(√7).
  - Consistency: 9/8 ∉ ℤ[U] over K, so there is no chain contradiction with χ(K²) = 4.
- **Commit at the close:**
  - the owner's blind controls, B1–B7 (all found by the plan, B4 in part);
  - the held items (after the competition);
  - the P3 briefs, as `data/fs73/briefs/`.
- **New stubs:**
  - C3-aper (`[AbrishamiEtAl2025]` Problem 4.6 on ℤ^r; FS-72's lattice);
  - possibly a five-colour rigidity table;
  - a note on FS-67's stub (the finite-U quotient is a subgraph of the product);
  - update FS-59's stub with C's design rule and the two survivors.

## 6. Owner errors this milestone (for the close's honesty section)

1. **"Smallest refusing ball."** I told A to shrink R, which walked the solver into G65's hardness band: five UNKNOWNs and about 2 hours. Poros's route replaced it.
2. **A wrong paraphrase.** I told the verifier that "2 is separable by a period-2 colouring", which is impossible since 2 ∈ 2Λ. The separator was a Kempe re-periodisation.
3. **An unreachable registration.** P-C3(a) was registered on periods (5, 7) that were inadmissible, so its informative outcome was unreachable. It is recorded as void.
4. **No mid-flight channel.** The first briefs omitted how to reach me. Kooshi caught it; memory now carries the rule.
5. **Retired a rule wrongly.** I retired the 500k rotation rule along with the Opus 5 quirks; Kooshi restored it.

**Two agents reported commit hashes that didn't exist** (A: one quoted before its commit printed; the verifier: one invented). Verify every reported hash against `git log`.
