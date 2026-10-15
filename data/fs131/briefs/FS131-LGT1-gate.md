# Brief FS131-LGT1 — the five-colour chain's landing, part 3: the full gate on one commit

*Written 2026-10-15 00:17 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LGT1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the gate-runner of the five-colour chain's landing — you take the joined branch the last lander left building with no `sorry`, write the gate's inputs it drafted (the audit's blocks, the assumptions ledger, the vacuity counts), run the full gate on one commit as the density bound's landing ran it, read the two headline statements aloud against their claims, and draft the front page
  launch: now, in the lander's tree on its branch (the lander has handed back; nobody else writes there); no other job is running
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way that needs any statement or definition changed, if a count moves and you cannot say why, if any disk, memory or count reading is near its limit, and with one line at the green commit; the report goes to `data/fs131/reports/FS131-LGT1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-LGT1-gate.md` (new, on branch `fs131-wlc`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1`, on its branch `fs131-wlc` (at `df6579be0`; its compiled library is current for those sources — build 5, sources as at `2fcba050a`): `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`, `ARCHITECTURE.md` and the gate's other inputs as the gate needs them; a docstring, a lint attribute or a proof where a gate step fails on it (a statement or definition change: ask me first); your checks and scripts under `tools/` and `data/fs131/lgt1/` named for this job; `plans/FS131-LGT1-gate.md`; `data/fs131/lgt1/`; `data/fs131/reports/FS131-LGT1.md`; and, at your hand-back, deleting the four uncommitted raw dumps `data/fs131/lch1/statements-*.txt` (their sha256 sums are committed). **Not** `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md` (you draft their lines; I file them); any generated module's text; any module under `Outside/` or `Plane/DensityBound/`. Nothing on `main`; no push
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage; save a stage after the readback, after the gate's inputs are written, at the green commit, and at the hand-back

Hello. The five-colour chain is joined: on this branch, every line it needs is merged, every ruled integration is
applied, and the library builds with no `sorry`. `χ(ℚ(√47)²) = 5` prints with no hypothesis. The last lander ran the
gate's steps that read the tree, and its budget ran out before the full gate on one commit. You run that gate. When it is
green and I have merged it, the chain has landed.

## Why this job

Kooshi's word for when the publication pass begins:

> Once the chain lands, we'll do some sanitization, git history rewrites, some nice readmes, a public readable roadmap of what's left to be formalized, and push to github. Not a full writeup, just that. Then we'll get back to work. That also solves our backup issue.
> — source: data/fs131/REQUEST-2026-10-13.md

In the plan's terms, "the chain lands" is `χ(ℚ(√47)²) = 5` through the gate on `main` with no hypothesis of ours left
(`plans/SESSION-HANDOFF-2026-10-14.md` § 1). The gate takes the whole library, so this one commit is the landing.

## The statements

What the two headline statements answer — the chain's leaf for the instance, from its claim list, and row 121 of the
ledger:

> NF2-LEAF-23: `NumberField` for `ℚ(√47)`'s `Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of `ℚ(√47, i)` and its target (D:116, FS100-T1: the class among real quadratic fields is `d ≡ 47, 143, 167 (mod 168)`). Then `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)` (D:275), `ℚ(√3,√5)` (D:301), `ℚ(√167) ≥ 5` (D:279).
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> | 121 | **`χ(ℚ(√47)²) = 5`: the local–global conjecture's cheapest exposed five-clause is met. MR at ℚ(√47) (row 120) with J45's SP-Cor and T-C(A) at `S = ∅` gives `≥ 5`; the plane at 11 gives `≤ 5`. The plane over ℚ(√47) has no unit triangles, so by de Bruijn–Erdős a finite triangle-free five-chromatic unit-distance graph exists (none is exhibited). Also `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335), `χ(ℚ(√167)²) ≥ 5` (row 123), and row 88 ⟺ T-B1 at ℚ(√59), ℚ(√83), ℚ(√131)** (FS-100 stage 5; FS100-Q47; `plans/FS100-three-field-lemma.md` §R-close (stage 5) 1.2, 1b). **[hand; the headline rule met (every half two blind minds, SP-Cor checked blind): MR row 120's grade; SP-Cor three minds (J45; J46-13 from its statement; X05V blind) over N1, N2, R-U, A⁺ each two blind minds (J45; J46); T-C(A) at `S = ∅` two blind (row 113); `χ ≤ 5` row 52 at 11, prior art. The consequences: row 123's grade; in the kernel only over named hypotheses, row 127; the upper half `χ ≤ 5` alone is [kernel] with no hypothesis, by two proofs of one statement (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`; `UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime`, the residue homomorphism at a prime above 11, FS131-LU1)]** The ladder has six links (PE-2, EF_F⁺, MR, SP-Cor, T-C(A), the upper bound), none broken; the control holds: at K and ℚ(√11), where four-colourings exist, the chain stops exactly at T-C(A), with the MR step exercised at a Haar mass `2/21` (X05V-3). **Answers** (`CLOSED-QUESTIONS.md` §1.7, §3): `[Moorhouse2010slides]`'s *"What about χ(ℚ(√47)²)?"*; the existence half of `[Soifer2024]` Open Problem 55.1, non-constructively (55.1 asks to construct; 55.2 open); `[ExooIsmailescu2019]`'s smallest-subfield question in part (ℚ(√47) is the first real quadratic field needing five: `d < 47` has `L ≤ 4 = χ`, row 99). **Not claimed:** an explicit graph; `χ(ℚ(√167)²)` beyond `≥ 5`; anything on six. **Prior art:** not found in print (X24R, 2026-09-26: zbMATH listings of twelve posers and fifteen abstract queries, arXiv with a positive control, the Polymath16 threads held and live to 2026-09-24, `[Soifer2024]` chs. 11 and 55; the only triangle-free five-chromatic unit-distance graph in print is in ℝ³, de Grey 2026, Zbl 1581.05080); `[Johnson2000]`, `[Johnson2006]` read 2026-09-27, not found in either — both pose the question as open (`[Johnson2006]` p. 214's ">" question; `CLOSED-QUESTIONS.md` §1.7) — so novelty is "not found", never "first". | `plans/FS100-derivation.md` FS100-Q47; `plans/FS100-X05V-verification.md` §2; `plans/FS84-SI-D-derivation.md` §4.2; `plans/FS84-SI-V-verification.md` §2–3; `plans/R88-derivation.md` R88-TCA; `tools/x05v_checks.py`; `plans/FS84-SI-D-derivation.md` (J45-N1, -N2, -SI-4, -SI-5, -SI-J, -SI-C, -SP-oi, -SP-if — the inputs FS100-Q47's grade names, filed as entries by FS129-Z1) | FS-100 stage 5 (crunch 2026-09-26) |
> — source: LEDGER.md § The novel-results ledger

The landing's last three items as I logged them — the lander's part 2 and the announcement rule, the one `sorry` ruled,
and the lander's hand-back (their words in quotation marks, the rulings mine). Every quotation in this section is
from the main checkout `/home/kooshi/source/lean-dir/`, whose inventory is current; your tree's copy is older:

> 940. **FS131-IKL1 handed back: the certificate link proved (logged 2026-10-14 22:53 UTC; "JOB FS131-IKL1 — DONE"; 575k by the harness's count; branch `fs131-wkl` at `b2a2b06d3`, tree `fs132-wi1`; record `plans/FS131-IKL1-implementation.md` there).** From its hand-back message: "**The certificate link is proved.** M13's leaf `ratioAtMost_cert` now closes in one line in a scratch copy of wcm4's ClassRatio. After that, the chain's per-prime theorem `ratioAtMost_of_five_le_chromaticNumber` rests on `sorryAx` only through a stand-in for IKC4's `sum_le_nineteen`, plus Weil's bound"; K3 `CertLink.exists_addEquiv_zmod`, K4 `CertLink.card_le_of_fibreShareBound` (over `HenselCount P q` and `NewCharBound P q`, "L2 itself is proved in the abstract, by characters, as `FibreShare.fibreShare_le`"), K5 `ratioAtMost_eleven`, `ratioAtMost_nineteen`, `ratioAtMost_cert_link`; the discharge "21 lines in your new names"; "173 of 173 unchanged against ICM4's dump"; three modules, 753 lines; a model of K4 at q = 3 drafted; generalizations (`card_le_of_fibreShareBound` at every prime q; "i is an integer of F(i)" private in four modules); a statement defect for the landing (the `q = 19` hypothesis has no free variables: state it as a theorem); the two discharge lemmas drafted public. **My receipts:** the five commits on `fs131-wkl`; from the tree's compiled library (scratch `ikl1/Ax1.lean`) `ratioAtMost_cert_link`'s statement as reported, it and `ratioAtMost_eleven`, `card_le_of_fibreShareBound`, `exists_addEquiv_zmod` on the standard three. **Rulings, four parts.** (1) *Part 2 to the running lander (FS131-LCH1), as far as its budget reaches:* merge `fs131-wkl`, apply the link's drafts, state `CertLink.exists_fibreShareBound_nineteen`, the i-integer fact once, then the headline and the instance with no `sorryAx`, then the full gate on one commit (brief amended, gate PASS); alternative, a fresh lander for part 2 — declined while the running lander holds the joined tree's context and budget; a successor takes the gate if it stops before it; high. (2) *The discharge lemmas public:* accepted — public vocabulary, and the assumptions step reads them as concluding the link's hypotheses; high. (3) *The `q = 19` hypothesis as a theorem:* accepted; high. **Announcement rule for the chain's landing (written now, before its reports; item 808's and item 910's form):** `χ(ℚ(√47)²) = 5` (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`) is reported to Kooshi as held, and W6's trigger as met, only when (a) the gate is green on one commit; (b) that commit is merged into `main` and `main` is checked equal to it outside `plans/` and `data/`; (c) the theorem's axioms, printed by me from the gated build, are the standard three and declared outside theorems only (expected: `StandingFive.kloosterman_bound`, Weil's bound, and `Rigidity.positive_entropy_rigidity`, Einsiedler–Lindenstrauss Thm 1.3), with no `sorryAx` and no hypothesis; (d) its stored statement is read aloud against row 121's claim. The report then names both declared outside theorems as what it rests on. **Credited:** the route that kept the fact once (option (c)), and the q = 3 model.
> — source: plans/FS131-close-inventory.md

> 941. **FS131-LCH1 — the headline and `χ(ℚ(√47)²) = 5` print with no hypothesis and no `sorryAx`; one `sorry` left, outside every cone (notice, logged 2026-10-14 23:59 UTC; by message).** From its message: "the headline and χ(ℚ(√47)²) = 5 now print with no hypothesis and no sorryAx, on the five-way joined tree"; "`fs131-wlc` at `60b1dd0d3`; build 4 OK, 1,087 of 1,087 batches"; both "rest on [propext, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]"; "`Plane.mOne_le_0_2470` and `Plane.mOne_lt_one_quarter` rest on the standard three"; "The headline's re-added hypotheses (by kernel term surgery) hash equal to its type before the edit, 362919061; the control differs"; "One `sorry` is left in the tree, and it is outside every cone: `Rigidity/RingScope` l. 247, `unitRing_eq_stableIntegers` (Lemma C′, row 100). No record reads it, but it fails the gate's zero-sorry check. Which line closes it, or is it ruled out of the gate?" **My receipts:** `60b1dd0d3` is on `fs131-wlc`, and it is the tree's head (no build running). From the tree's compiled library (scratch `lch1/Ax.lean`): `Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField ↥F], min (SpectralChain.localBound F) 5 ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber` and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5`, each on the standard three, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`; the two `m₁` corollaries on the standard three. The tree's one `sorry` token under `Proofs/` is `Rigidity/RingScope.lean` l. 249 (the message's l. 247), the proof of `unitRing_eq_stableIntegers`; the name occurs in no other file under `Proofs/` (`rg`). It was typed by FS131-KN9 "off M8b's path, planned in words only" (item 791; its record § 3.3: "Not sized; not on the headline's path … a stub-sized job (Lemma C and C′ in the kernel are FS-47's stub"). **Ruling, four parts.** *Choice:* the theorem is deleted from the library at this landing — its declaration and its `sorry` —, its statement and route kept verbatim in the lander's record and in a file under `data/fs131/lch1/`, the module's title and docstring rewritten to say it is not in the library and where it is kept, the statement check's allowed list given this one deletion and nothing else; Lemma C′ goes on the publication roadmap's list of what is left to formalize (owed). *Alternative weighed:* prove it before the landing — declined: it is unsized and needs weak approximation for the norm-one torus and a computation at every stable prime, nothing reads it, and the gate takes no `sorry`, so the five-colour result would wait on a proof that is not part of it. Ruling it out of the gate's zero-`sorry` check — declined: `main` carries no `sorry`, and the publication's bar is the kernel's. *Why:* no other stored statement moves (no reader), and W6's roadmap is where a finding of ours not yet formalized belongs. *Confidence:* high; it would change if the statement check shows any other stored type moving. **Brief amended** (Amendment 2026-10-14 23:59 UTC); **owed:** the roadmap line for Lemma C′ (row 100) at the publication pass.
> — source: plans/FS131-close-inventory.md

> 942. **FS131-LCH1 handed back at stage 5: the five-way join built with no `sorry`; the full gate left (logged 2026-10-15 00:16 UTC; "JOB FS131-LCH1 — STAGE 5 SAVED"; 587k by the harness's count — past the line, not to be resumed; branch `fs131-wlc` at `df6579be0`, tree `fs131-wq1`; record `plans/FS131-LCH1-join.md` there).** From its hand-back message: "The joins and every ruled integration are done, and the tree builds with no sorry. The full gate on one commit is left for a successor"; "Build 5: 291 of 291 batches, 0 warnings"; "No chain record rests on `sorryAx`"; "Statement check against the dumps made before any edit: 34,480 constants, 0 reports. Its five planted faults are all reported"; "`dupnames.sh` OK; `axioms.sh` OK (9,451 clean, 355 axiom-free, 34 imported, 5 declared purchases); lint 14/14; `check_architecture.py` PASS"; "Lemma C′ deleted, with its statement and route kept in `data/fs131/lch1/ring-scope-lemma-c-prime.lean` and in the record"; "**The brief's build recipe runs out of memory.** `BATCH=8` at 10 GiB is killed by the kernel's OOM killer inside its own memory scope at the density bound's cells"; "four files of 0.45–1.6 GB each sit uncommitted in `data/fs131/lch1/` (`statements-*.txt`; their sha256 sums are committed)"; "Nothing is running and the slot is empty." **My receipts:** the 18 commits it names are on `fs131-wlc`, `df6579be0` the tree's head; `git diff 2fcba050a df6579be0` outside `plans/` and `data/` is empty; no `sorry` token under the tree's `Proofs/`, and `unitRing_eq_stableIntegers` occurs nowhere there; the kept file exists. From the tree's compiled library, the whole root imported (scratch `lch1/Ax2.lean`): `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : (SimpleGraph.induce (planeOver SqrtFortySeven.F47) (unitDistance ℂ)).chromaticNumber = 5`, it, `Rigidity.min_localBound_five_le_chromaticNumber` and `Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound` on the standard three, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`; `Plane.mOne_le_0_2470`, `Plane.oneAvoidingDensityBound`, `Rigidity.exists_mul_stableIntegers_le` and `Rigidity.dense_mixedEmbedding_nsmul_unitRing` on the standard three; `Outside.OAI158.chromaticNumber_plane_six_or_seven` on the standard three and `Outside.OAI158.no_proper_five_coloring`, unchanged. `main` since the merged `bd3bd9541` has moved in `plans/` and `data/` only. Disk 308 GB free. **Rulings, four parts.** (1) *The full gate to a successor (FS131-LGT1), in the same tree on the same branch, from the record's § "Drafts for part 2":* alternative, resume the lander — declined, it is past the line (587k); high. (2) *The build width:* the brief's recipe is replaced by the record's measured one (`BATCH ≤ 2` at 16 GiB for any build recompiling the density bound's cells or the p = 19 checks), and the `LEAN.md` lines are drafts filed at the landing's filing; alternative, keep `BATCH=8` and retry — declined, two measured OOM kills; high. (3) *The four raw dumps:* kept until the gate's statement check has read them, then deleted by the successor at its hand-back (their sums committed); high. **Credited:** the term-surgery check for dropped binders, and the plant that could not fire, found and fixed.
> — source: plans/FS131-close-inventory.md

**Where everything is** (in your tree unless the path says otherwise): the lander's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-LCH1-join.md` — its § "Drafts for
part 2 — what is left, in order" is your work list (the audit's blocks, the coverage run, the assumptions step, vacuity,
the lint's negative control, the read-aloud, the front-page drafts), its § Stage 4 and § Stage 5 the state you start
from, its § "Drafts for `LEAN.md`" lines to carry into your drafts; its report `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/reports/FS131-LCH1.md`. The
density bound's landing `/home/kooshi/source/lean-dir/plans/FS131-LDB1-landing.md` § Stage 5 is how the full gate was run last time (one pass, every step in order, under the
slot; `/home/kooshi/source/lean-dir/data/fs131/ldb1/run-gate.sh`; every log with its exit status on its last line), § "Drafts for the front page (FS131-LDB1)" is the
form of the drafts, and its logs `/home/kooshi/source/lean-dir/data/fs131/ldb1/gate/` are the previous side of every
digest you compare. The drafted chain block `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/lch1/draft-axioms-block.lean` must be regenerated (its one OPEN
record, Lemma C′, is deleted). The records drafting the other lines' blocks are on this branch: FS131-IKL1's § 4.3,
FS131-IKC4's and FS131-ICM4's records under `plans/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the branch's head checked, and its
   sources against `2fcba050a` outside `plans/` and `data/`; the work list restated in your record, one line per step,
   with the previous landing's log it compares against.
2. **The gate's inputs** (a saved stage): the audit's blocks for the chain, the link, the `p = 19` line and the dyadic
   line in `scripts/Axioms.lean`, and a coverage run (every public constant a record or reached); the assumptions step
   (`--self-test`, a run, `--write-ledger`, the nine counts); the vacuity scan (`--self-test`, the counts reconciled
   against `main`'s `declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38
   generic=1411 unknown=2`); the lint's negative control. Each count that moves, explained in one line.
3. **The full gate on one commit** (a saved stage): one pass, every step in order, under the slot, as `/home/kooshi/source/lean-dir/plans/FS131-LDB1-landing.md` § Stage 5
   ran it — the build, zero `sorry`, the axiom audit, the lint, the statement check against the lander's dumps, vacuity,
   assumptions, `dupnames`, architecture, coverage — every log under `data/fs131/lgt1/gate/` with its exit status, the
   commit's full hash recorded, each check's control watched firing. **The one line to me at the green commit.**
4. **Read aloud** (in your record): `Rigidity.min_localBound_five_le_chromaticNumber` and
   `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`, each printed from the gated build with its axioms, read
   against NF2-LEAF-23 and row 121 above, every binder and every defined term traced to its definition; then M15's other
   values against `LEDGER.md` row 123.
5. **Drafts for the front page**, in your record, in the density bound's landing's form, each slot checked once by a
   script: `CLAUDE.md` (the Frontier's lines, "What the kernel holds", the Trust ledger — the library now declares a third
   outside theorem, `Rigidity.positive_entropy_rigidity` —, the assumptions' counts, the gate's counts), `LEDGER.md` rows
   121, 123 and 127 regraded with what they rest on, `LEAN.md` lines (the lander's among them), and bibliography lines.
6. The report in the standing rules' form. Delete the four raw dumps once the gate's statement check has read them. Leave
   no process running or queued. Stopping at a saved stage with what is left named is a good report.

## What is yours to decide

The order inside each step; how each input is generated; the scripts; what to do when a step fails, within your touches;
the drafts' wording. An unread binder of a statement is reported to me, not dropped. Not yours: any statement or
definition change; the files listed as not yours; the merge into `main`; a push.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 308 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for its sources (build 5). One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lgt1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. **The build, measured by the last lander:** `--mem 16 --cpus 4 -- env MEMMAX=16G
BATCH=2 ./scripts/build.sh` for any build that recompiles the density bound's cells or the `p = 19` checks (at `BATCH=8`
and 10 GiB the kernel's OOM killer stops it inside its scope); `BATCH=8` at 10 GiB only when neither is stale. Never
`lake build`; do not edit a file a running build will compile. A whole-library gate step: `--mem 8`. On exit 75 wait
ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never
by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/lgt1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment — 2026-10-15 00:33 UTC (Keryx, by message to this job)

**How the drafts word novelty** (Kooshi's question of this hour, on the last lander's sentence "None of these values is new"): that sentence meant *not new to this landing* — each value was derived here by hand before (`LEDGER.md` rows 121, 123) — and it reads as *prior art*, which it is not. In your front-page drafts, state each value's novelty in the ledger's own terms: row 121's "**Prior art:** not found in print" (never "first", never "not new"), with what is not ours named as the ledger names it (the upper half `χ ≤ 5` and the plane at 11 are prior art; Weil's bound and Einsiedler–Lindenstrauss Thm 1.3 are declared outside theorems; the density bound is `[AmbrusEtAl2023]`'s); what this landing adds is the kernel's check, said as that. No new touches. You still start no agents of your own: only the coordinator launches agents, so that Kooshi's budget holds and every piece of work is known.
