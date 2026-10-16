# Brief FS131-IRU1 — prove the ring of unit vectors: Lemma C′, the components clause and the dichotomy, from the skeleton and its plan

*Written 2026-10-16 20:54 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IRU1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of a planner's five skeleton modules (40 leaves, about 970 lines) — row 100's Lemma C′, its per-prime form, the statement that the plane over every real number field has infinitely many components, and the dichotomy — every `sorry` replaced by a proof without changing a statement, three private lemmas of `Rigidity/AdmissiblePrime` made public by ruling, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch, with `main` merged in; beside you two implementers in other worktrees (the density form of the collapse, and the five-colour fields — the latter's branch holds the bridge `UpperHalf.exists_stablePrime_card_eq_sq` your plan reads if it lands first); none writes another's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-IRU1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IRU1-ring.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-kru1` (at `e27c45182`: the planner's skeleton with `main` merged in — the three-colour criterion's modules among what it brought; `main`'s build files copied in by checksum, so the first build recompiles little beyond the root): the five skeleton modules `Proofs/HadwigerNelson/Rigidity/NormOneGen.lean`, `Proofs/HadwigerNelson/Rigidity/UnitRingEq.lean`, `Proofs/HadwigerNelson/Rigidity/UsablePrime.lean`, `Proofs/HadwigerNelson/Rigidity/PlaneComponents.lean`, `Proofs/HadwigerNelson/Instances/UnitRingModels.lean` (their proofs; their statements only by my word); in `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean` the edit of the plan's § 3.7 item 1 and nothing else; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/FS131-IRU1-ring.md`; your scripts and logs under `data/fs131/iru1/`; `data/fs131/reports/FS131-IRU1.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner before you found an elementary proof that every real number field has a prime of the kind this
library calls stable, so the statement that the unit-distance graph of every such plane falls into infinitely many pieces
needs no outside theorem; and it halved the price of the ring lemma. The skeleton builds; you prove its leaves.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

Row 100's Lemma C′ is that kind of finding, and so is the components clause beside it. Row 100 as the ledger states it:

> | 100 | **The class theorem for character colourings (CLG), at existence scope: for every real number field `F` and `k ≥ 2`, given band rigidity (row 98), the plane has a band `k`-character — equivalently a character `k`-colouring `x ↦ ⌊kθ(x)⌋` — iff some stable place of `F(i)` carries one at some level of its residue tower; so `χ_char(F²) = min` over the residue targets, and at `k ≤ 5`, and at every `k` over fields of degree ≤ 2, a character `k`-colouring exists only if `L(F) ≤ k`** (FS-91; FS91-J07-1 to J07-15, J10-L1, J10-L2, J10-L7, J10-L8, J11-T12). **[hand (+ tools exact); two independent derivations (J07; J10 blind in phase 1, then from J07's 25 lemma statements: 24 TRUE, one GAP)]** The peel: by row 98, `θ = τ + α`; the archimedean part vanishes at every complex place and is an interval about 0 at each real one, so `τ` is band; `τ` factors through finitely many stable places (Lemma C: `R ⊗ ℤ_p = R̄_p × V_n`; Lemma C′: `R_F = O′`, the ring integral at the stable primes, with **no Galois hypothesis**, except possibly at a ramified stable dyadic place — three derivations; the exception occurs at ℚ(√5), ℚ(√17), ℚ(α)); weak approximation makes the image of `U` a product of local images; and a sum of symmetric subsets of the circle inside the band keeps **some** summand inside it (the peeling lemma, three derivations). CLG-g makes the exception explicit — a stable place carrying a band `k`-character only above level one, odd with residue field `𝔽_{p^f}`, `f ≥ 3`, `2p < k < χ(Γ_{p^f})`, or inert dyadic of norm `Q ≥ 64` — using level collapse for `k ≤ 2p` (four derivations) and every inert tower's `λ_min` scaling by `Q^{j−1}`; its corollary (g3) at `k = 7` holds only as "exact level `2e(𝔭\|3) + 1`" (a GAP in the lemmas, found by the verifier). **CLG is not a classification:** it does not say that every character colouring is pulled back from one place; that is proved at `k = 3` (row 99's no mixing) and at `k = 4` over ℚ(√59), ℚ(√83), ℚ(√131) (HD1, from CLG's *proof* with Lemma D — with no FS-66 certificate, no `[Zhang2012]`, no Lemma R), and open elsewhere (FS-92). Controls reproduced: `θ₂` at a ramified dyadic place; `[Fischer1994]`'s ℤ/4 colouring of K at one dyadic place, level 3 (one existing checker); C9 on ℚ(√11) at `Γ₇`; row 96's C-47 and C-167, C-167 with no certificate. With `A(R_F)` wide, FS89-CL3–CL5 are TRUE and FS89-CL2 false only as worded. **Not claimed:** anything about `χ` from four colours up (`Θ_k = ∅` is one-sided, G71); the classification at `k ≥ 4` beyond HD1's fields; whether CLG-g's exception is ever realised; a kernel proof. **Prior art:** the close gate found no statement of it; `χ_char` is `[BarajasSerra2008]`'s *regular chromatic number* (circulant graphs), `κ` the lonely-runner / view-obstruction parameter; Lemma C/C′ partly `[Fischer1990b]`'s (quadratic and multiquadratic cases), the general form not found, Shimura 1964 undecided; the peeling lemma not found (folklore-grade); `[Johnson2000]` and `[Johnson2006]` read 2026-09-27, not found; Lemma C′ answers `[Johnson2000]` §5's question at `n = 2` outside the exception fields (*"the problem of characterizing the additive group A generated by the unit vectors in 𝔽ⁿ"*, p. 177; `CLOSED-QUESTIONS.md` §2.7). | `plans/FS91-S1D-character.md`, `plans/FS91-S1V-character.md`, `data/fs91/j07/lemma-statements.md`, `plans/FS91-derivation.md` §2, §4, `tools/crunch_j07_checks.py`, `tools/crunch_j10_{checks,phase2}.py` | FS-91 |
> — source: LEDGER.md

## The statements

The skeleton's head statements, on your branch (the plan names every other):

> theorem unitRing_eq_stableIntegers (h : NoRamifiedStableDyadic F) :
>     UnitRing.unitRing (conjOn (fieldI_conj F)) = stableIntegers F := by
> — source: Proofs/HadwigerNelson/Rigidity/UnitRingEq.lean

> theorem exists_two_pow_mul_mem_unitRing {x : fieldI F} (hx : x ∈ stableIntegers F) :
>     ∃ a : ℕ, (2 : fieldI F) ^ a * x ∈ UnitRing.unitRing (conjOn (fieldI_conj F)) := by
> — source: Proofs/HadwigerNelson/Rigidity/UnitRingEq.lean

> theorem nonempty_stablePrime : Nonempty (StablePrime F) := by
> — source: Proofs/HadwigerNelson/Rigidity/UsablePrime.lean

> theorem connected_or_infinite_planeOver (F : Subfield ℝ) :
>     ((unitDistance ℂ).induce (planeOver F)).Connected ∨
>       Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
> — source: Proofs/HadwigerNelson/Rigidity/PlaneComponents.lean

> theorem infinite_connectedComponent_planeOver [NumberField F] :
>     Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
> — source: Proofs/HadwigerNelson/Rigidity/PlaneComponents.lean

The plan is `plans/FS131-KRU1-ring-plan.md` on your branch: § 1.3 its findings; § 2 the map; § 3.5 the modules, leaves and price; § 3.7 the
drafts for files it does not write. Its report is `data/fs131/reports/FS131-KRU1.md`.

## My rulings

> 1044. **FS131-KRU1 handed back DONE: the ring of unit vectors planned with a skeleton (logged 2026-10-16 20:53 UTC; about 570k by the harness's count — not to be resumed; branch `fs131-kru1`, worktree `.claude/worktrees/il5`; record `plans/FS131-KRU1-ring-plan.md`, report `data/fs131/reports/FS131-KRU1.md` there).** Five skeleton modules (`Rigidity/NormOneGen`, `UnitRingEq`, `UsablePrime`, `PlaneComponents`, `Instances/UnitRingModels`), 40 leaves, about 970 lines (about 925 if FS131-ICS1's bridge lands first), no outside theorem: Lemma C′ as typed (`Rigidity.unitRing_eq_stableIntegers`, `F` implicit; about 420 lines — three of the old map's leaves held since FS131-ICL2, local generation by Cayley elements in the product ring); the per-prime form and `exists_two_pow_mul_mem_unitRing` (`2^a·x ∈ R` for every `x ∈ O′`, every real number field; 37 lines, ruled in by item 1040's threshold); the components clause at every real number field (`infinite_connectedComponent_planeOver`, `not_connected_planeOver`, through `Rigidity.nonempty_stablePrime` by the elementary route); the dichotomy (`connected_or_infinite_planeOver` at every subfield of ℝ, `connected_planeOver_iff_isEmpty_stablePrime`; about 50 lines, 26 % of its module); `localBound_lt_top`. **My receipts:** the eight commits exist; `data/fs131/kru1/build.out` reads "build: OK — 1100 of 1100 batches, 6 module(s) rebuilt, 5 module(s) with warnings" and "build exit=0", every warning a `sorry`; I read `unitRing_eq_stableIntegers` (`UnitRingEq.lean` ll. 103–104), `exists_two_pow_mul_mem_unitRing` (ll. 115–116), `nonempty_stablePrime` (`UsablePrime.lean` l. 101), `connected_or_infinite_planeOver` and `infinite_connectedComponent_planeOver` (`PlaneComponents.lean` ll. 62–64, 80–81) — as reported. `main` merged into the branch (`4b166e589`; `check_architecture` PASS) and `main`'s build copied in by checksum (32 files). **Rulings, four parts each.** (1) *Make `Rigidity/AdmissiblePrime`'s three private lemmas public* (record § 3.7 item 1), ruled changes. *Alternative:* `open private`. *Why:* items 1021 (2) and 1027 (1). *Confidence:* high. (2) *The dichotomy rides* in the implementer's brief. *Alternative:* leave it out, as item 1040's fifth-of-the-module threshold would. *Why:* it is 5 % of the job, a finding of this project's (W2), and it says exactly what the components clause means; the threshold was a guard against padding, not against a statement this cheap. *Confidence:* medium-high. (3) *One implementer, sequential*, not two in parallel. *Alternative:* modules 1–2 and 3–4 in two worktrees. *Why:* about 970 lines is within one implementer's measured reach, and one branch gates once. *Confidence:* medium. **Logged from its report:** corrections owed at the landing — row 105's "(a stable prime exists by Chebotarev)" (drafted, record § 3.7 item 3) and FS131-KCS1's § 2.6 (superseded); prior-art debts — Lemma C′'s general statement (item 1027) and "every real number field has infinitely many degree-one primes of norm `≡ 3 (mod 4)`" by the sign-change route (probably classical, unsearched); hygiene — the norm-one residue set defined three times (record § 1.3 F5). **Credited:** the planner halved the lemma's price and removed its one outside input.
> — source: plans/FS131-close-inventory.md

The ruling it builds on, with my check of the elementary route:

> 1040. **FS131-KRU1, mid-job: the components clause needs no outside theorem (logged 2026-10-16 20:04 UTC; by message; branch `fs131-kru1`, record § 1.3).** Its findings: (1) every real number field has a usable prime, hence a stable prime, by an elementary route — `f` the minimal polynomial of an integral primitive `θ ∈ F ⊆ ℝ` changes sign at `θ`; take `x/k` beside `θ` where `f < 0`, `k = D^a`, `x ≡ 1 (mod D)`, `D = 4M` (`M` the Kummer–Dedekind bad primes); `N = −kⁿf(x/k)` is a positive integer `≡ −1 (mod D)`, so it has a prime factor `q ≡ 3 (mod 4)` prime to `M` and `k`, and `f` has the root `x/k` modulo `q`; Kummer–Dedekind (in `Rigidity/AdmissiblePrime`) gives a prime of `F` with residue field `𝔽_q` [hand, one mind, kernel pending]; about 250 lines against about 120 for a declared Chebotarev-type axiom; it also discharges row 105's "a stable prime exists by Chebotarev"; (2) a dichotomy: `F²` is connected or has infinitely many components, and over a number field connected exactly when no stable prime exists; (3) a wider kernel form, FS91-J07-4's per-prime one: every `x ∈ O′` has `2^a·x ∈ R` at every real number field; (4) Lemma C′'s price falls to about 350 lines (three of the eight leaves held since FS131-ICL2; local generation by Cayley elements, with no counting and no Hensel). **My check of (1)**, by hand: `k ≡ 0 (mod D)` makes `kⁿf(x/k) ≡ xⁿ ≡ 1 (mod D)` for monic `f`, so `N ≡ −1 (mod 4)` and `N ≡ −1` modulo each prime of `M`; `x` may be taken on either side of `θ` within `D^{1−a}`; `θ` is a simple root — as stated. **Ruling, four parts.** *Choice:* the elementary route; the components clause at every real number field with no outside theorem; the dichotomy (2) and the wider form (3) stated in the skeleton beside the head statement, each priced, the implementer's brief to take them if each is under about a fifth of the module. *Alternative weighed:* the declared axiom, about 130 lines cheaper. *Why:* `CLAUDE.md`'s rule for imports — what can be formalized is formalized, and a declared theorem is a trust cost a reader pays; the difference is an afternoon of agent work. *Confidence:* high. **Owed at the landing:** row 105's "by Chebotarev" clause. **Credited:** the planner found a route around the one outside input the previous map required.
> — source: plans/FS131-close-inventory.md

And on history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

In short, for you: make the three private lemmas of `Rigidity/AdmissiblePrime` public as the plan's § 3.7 item 1 drafts
(with docstrings; ruled changes), in your first build; the dichotomy rides; if FS131-ICS1's bridge has not landed on `main`
when you need the stable prime above a usable prime, take the plan's fallback (`Arith.placeHom_base` with row 105's prime
inversion, about 45 lines) and say so.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iru1/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ict3/gate/`, the three-colour criterion's,
   unless I tell you another landed first); the statement comparison against a dump of the skeleton's stored statements
   that you take before your first proof edit (a comparator shaped like `data/fs131/ico2/statements.py`, with a planted
   control watched), the ruled changes listed; the vacuity scan's new sites with each structure hypothesis's inhabitant
   named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected: the standard three, no outside theorem).
   Commit any statement dump gzipped.
4. **The read-aloud** of each head statement against row 100, the roadmap's typed form and the asking lane's C8, in your
   record, with what is not claimed.
5. **The drafts** for the front files (the plan's § 3.7 brought to what is proved — row 105's Chebotarev clause among them),
   each naming its slot. No novelty wording: Lemma C′'s general statement and the sign-change route to degree-one primes
   are unsearched (item 1044) — write "prior art not yet searched" where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
beyond the ruled `AdmissiblePrime` edit (message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers that build and will run full gates. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/iru1/`. Nothing with a `sorry` reaches `main`.
