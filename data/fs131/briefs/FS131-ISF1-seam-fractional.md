# Brief FS131-ISF1 — prove that the fractional chromatic number of the plane over ℚ(√3, √11) is 4, from the skeleton and its plan, with the certificate's kernel price measured first

*Written 2026-10-17 00:42 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ISF1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the planner's Part B — `Proofs/HadwigerNelson/Instances/SeamFractional.lean` (its three heads proved from two leaves) and the `G27` certificate pipeline beneath it (about 1,360 lines, a generator of about 350 lines of Python, and generated data) — every `sorry` replaced by a proof without changing a stored statement, through the full gate on one commit
  launch: now, in a worktree of your own on a branch cut from the planner's; beside you one implementer in the planner's worktree proving Part A (rational four-space) on the planner's branch, writing none of your files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage at once with the price probe's measurement (stage 2), if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/FS131-ISF1.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ISF1-seam-fractional.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/kcs1`, on its branch `fs131-ksf1` (at `10cf51dd0`, the planner's last commit, with both parts' skeletons; `.lake/build` a copy of the planner's, current for the skeleton): `Proofs/HadwigerNelson/Instances/SeamFractional.lean`, the `Plane/G27/` modules the plan names and their generated data modules; the generator `tools/fs131_kfs1_g27.py` (the plan's name) and its outputs under `data/fs131/isf1/`; the removal of Part A's skeleton (the four `Proofs/HadwigerNelson/RationalFour/` modules, their import lines in `Proofs.lean` and their `ARCHITECTURE.md` rows) in your first commit; `Proofs.lean`'s import lines and `ARCHITECTURE.md` rows for your modules; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header); the merge of `main` before the gate; `plans/FS131-ISF1-seam-fractional.md`; your scripts and logs under `data/fs131/isf1/`; `data/fs131/reports/FS131-ISF1.md`. Front-file lines are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after the probe and after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. In 2015 Cranston and Rabern asked for the fractional chromatic number of the plane over ℚ(√3, √11). This project
answered 4 by hand; the planner found a route through the library's own invariant random independent set and the 27-point
graph's certificate, with no outside theorem, and built the skeleton. One number in its price is unmeasured — how much
the kernel pays to check the certificate's data — so you measure it first.

## Why this job

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The question and this project's hand answer:

> ### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`
> 
> > **`[CranstonRabern2015]`**, concluding section (Combinatorica 37, 2017): *"What is the fractional chromatic number of
> > `ℚ(√3,√11) × ℚ(√3,√11)`?"* — after noting that their graphs give `χ_f(ℚ(√3,√11)²) ≥ 76/21`.
> 
> **Our answer: 4, exactly.** The upper bound is Theorem B (§1.1, kernel-checked). The lower bound is `[MatolcsiEtAl2025]`'s
> 27-point graph `G27`, which lies in the Moser lattice inside `ℚ(√3,√11)²` and has geometric fractional chromatic number 4, combined
> with the observation that their blow-up (their Theorem 1) **never leaves the field its graph lives in**: every congruence between
> subsets of `F²` is an isometry of `F²`, the group those generate is solvable, and the Følner copies of `G27` stay in `F²`. So finite
> unit-distance graphs over `ℚ(√3,√11)` have fractional chromatic numbers arbitrarily close to 4 (and independence ratios
> arbitrarily close to `1/4`, never below). Proof: `plans/FS56-field-blowup.md` (hand). **Not kernel-checked** beyond Theorem B.
> 
> **Prior art that constrains the claim.** Almost all of it is theirs: the geometric fractional chromatic number (`[AmbrusEtAl2023]`),
> the blow-up and `G27` with its rational witness (`[MatolcsiEtAl2025]`). Ours is the field-internal reading of the blow-up and the
> upper bound. Their witness was **re-verified here** by an independent exact checker (`tools/fs56_gf_check.py`: the graph rebuilt in
> `ℚ(√3,√11)` arithmetic, every congruence decided by an exact isometry test, all 182,304 independent sets enumerated; CERTIFIED, with
> five planted faults refused — `data/fs56/g27/`). **Searched for a contradicting or earlier claim** on 2026-09-16: every work citing
> `[CranstonRabern2015]` (Semantic Scholar, 11 records; OpenAlex, 8) and `[MatolcsiEtAl2025]` (Semantic Scholar, 4; OpenAlex's preprint
> record, 0); none addresses a field plane.
> — source: CLOSED-QUESTIONS.md

## The statements

Two of the three head statements, on your branch (already proved from two leaves; the plan's § 3.2 reads each aloud):

> theorem fractionalChromaticNumber_seamPlane :
>     ((unitDistance ℂ).induce seamPlane).fractionalChromaticNumber = 4 := by
> — source: Proofs/HadwigerNelson/Instances/SeamFractional.lean

> theorem iSup_fractionalChromaticNumber_seamPlane :
>     ⨆ S : Finset seamPlane, (((unitDistance ℂ).induce seamPlane).induce (S : Set seamPlane)).fractionalChromaticNumber
>       = 4 := by
> — source: Proofs/HadwigerNelson/Instances/SeamFractional.lean

The plan is `plans/FS131-KFS1-four-space-plan.md` on your branch: § 2.2 the routes compared; § 3.1–3.3 the modules, the heads and the plan per leaf;
§ 3.5 the price; Stage 4 the drafts. Its report is `data/fs131/reports/FS131-KFS1.md`. The certificate is
`data/fs56/g27/cert-g27-mrvz.json`, checked outside the kernel by `tools/fs56_gf_check.py`.

## My rulings

> 1082. **FS131-KFS1 handed back DONE: both parts planned with skeletons (logged 2026-10-17 00:40 UTC; about 395k by the harness's count — not to be resumed for work; record `plans/FS131-KFS1-four-space-plan.md`, report `data/fs131/reports/FS131-KFS1.md`; branch `fs131-kfs1` at `0c47f7b02`, worktree `il5`).** Planned, one mind; nothing held. **Part A (C7):** four modules `Proofs/HadwigerNelson/RationalFour/{Basic,Order,Compulsion,Forbid}.lean`, about 1,190 lines on the standard three axioms with no import — `[Zaks1999]` Lemma 1, `[BendaPerles2000]` pp. 123–125 and `[Johnson1990]` Thm 3 formalized; heads `forall_coloring_eq_iff`, `forall_coloring_ne_iff`, `exists_coloring_eq_and_ne_iff` (the compulsion law), `exists_coloring_forbidding_iff` (Johnson's question, every `d > 0`), its `padicValRat` form, `coloring_forbids_of_odd`, and the read-back anchor `nonempty_iso_unitDistance`. **Part B (C14):** `Instances/SeamFractional.lean`, the three heads already proved from two leaves (`numberField_seamField`, `IndepLaw.density_le_quarter_seamField`), by an invariant random independent set (`Collapse.exists_indepLaw`, standard three) and `G27`'s certificate — no blow-up and no E–L; about 1,360 lines, a generator of about 350 and generated data whose kernel price is unmeasured. **My receipts:** the four commits exist; I read the stored heads `exists_coloring_forbidding_iff` ("a colouring forbidding `d` exists ⟺ `d²` is not rational, or `d² = p/q` with `p`, `q` odd") and `forall_coloring_eq_iff` ("forced equal ⟺ `x = y` or `v₂(|x − y|²) ≥ 1`") against `CLOSED-QUESTIONS.md` § 3's C7 — they say what C7 says; `sorry` counts 36 in Part A's four modules, 2 in Part B's. **Rulings, four parts, on its held decisions:** (1) *Choice:* Part A also states A3, the structure clause (every proper four-colouring is, on each component, the residue map up to a bijection), about 40 lines. *Alternative:* leave it out. *Why:* it is the theorem the 2002 paper may hold (item 1075), so the library should state it in the form a reader can compare, and its price is small. *Confidence:* high. (2) *Choice:* Part B's first leaf is a price probe — generate the data and check two atom chunks before the whole `G27` pipeline. *Alternative:* build in the plan's order. *Why:* the kernel price is the one unmeasured number (`LEAN.md`: re-price from the first two leaves). *Confidence:* high. (3) *Choice:* two implementers at once, on two branches, each removing the other part's skeleton in its first commit (nothing with a `sorry` reaches `main`); the landings serialize. *Alternative:* one implementer for both (about 2,550 lines — past one context). *Why:* the parts share no module. *Confidence:* high. **Routed:** FS131-PAS2's generalization (every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4`) to Part B's implementer as optional; its search request (a smaller certificate for `χ_gf(G27) ≥ 4`) to `plans/SEARCH-QUEUE.md` row 27; its question for the asking lane (a `ℚ⁸` analogue through the octonions; steps A3 and A5 use associativity) to the asking lane's next job. **Held:** its front-file drafts (a ledger row for C7, `CLOSED-QUESTIONS.md` lines, bibliography "rests on" fields) until the landings and `[KubickiLehelMorayne2002]`. **Credited:** the route for C14 with no blow-up and no E–L, and its own tool defect found and fixed with a control.
> — source: plans/FS131-close-inventory.md

The prior-art search on C14, whose generalization I route to you as optional:

> 1080. **FS131-PAS2 handed back DONE (logged 2026-10-17 00:36 UTC; about 549k by the harness's count — not to be resumed; record `plans/FS131-PAS2-prior-art.md`, report `data/fs131/reports/FS131-PAS2.md`; branch `fs131-pas2` merged).** **C7:** pending `[KubickiLehelMorayne2002]` — not found in print among everything read (124 logged queries); `[Johnson2010]` p. 169 poses it again in 2011 with C7's answer as a guess; `[BauJohnsonNoble2021]` Thm 3.3 is C7's similarity step (fetched and read); drafts in two forms, (A) not in print, (B) in print in part (§ 2.4). **C14:** not found in print (§ 4.3): the upper bound `[Fischer1994]`'s, the lower bound's graph and blow-up `[MatolcsiEtAl2025]`'s read inside the field, and at the Moser ring `sup χ_gf = 4` is `[Ducz2026]` Thm 3.1 with its p. 4 ring remark. **Off-brief:** row 129's plane clause is `[LiSu2026]`'s (filed and pushed, items 1077, 1079). **My receipt:** `[Ducz2026]`'s abstract ("We show that this bound is tight for graphs in the Moser lattice … The same colorings also extend to the entire Moser ring") and Theorem 3.1 read in the held PDF (`~/source/library/pdf/arXiv-2606.12325.pdf`), as the record quotes them. My two leads, checked by it: arXiv:2602.17943 is Istrate–Zara, no bearing; the Haifa record is `[Zaks1989]`. My key `[Johnson2011]` in item 1075 was wrong — the work is `[Johnson2010]` (the 2011 volume's chapter); corrected in place. **Ruling, four parts, on what is filed now:** *Choice:* a Clerk (FS131-FPA2) files § 4.4 items 1–3 (`CLOSED-QUESTIONS.md` § 1.6, row 71, the bibliography lines) and § 2.4 item 4 (C7's bibliography rows, the same in both forms), with item 1054's owed bibliography items, `[Neukirch1999]` and § C rows for the arXiv ids `tools/bib_audit.py` lists. *Held:* § 2.4 items 1–3 (C7's novelty in form A or B, and the period question of draft 2, whose attribution may move with the 2002 paper) until `[KubickiLehelMorayne2002]` is read; C14's novelty line until its module lands. *Alternative:* file C7's form (A) now and correct it later. *Why:* a public "not found in print" that a held lead may overturn is the error items 1076–1079 just corrected. *Confidence:* high. **Routed:** its generalization — every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4` ([derived], one mind, from FS56-T2 and Theorem B; record § 4.2), which carries `[Ducz2026]`'s ring bound to the field — goes into FS131-KFS1's implementer brief (the planner is near its line). **Owed (prior-art debts, title only, for the asking lane or a later search):** Didin–Voronov 2026 (dense colour classes); `[Davies2026]`'s conditional transfer giving `χ(ℝ³) ≥ 7`; `[Zaks1989]` (closed access; `[Johnson2010]` p. 174 names it as where the `ℚ⁴` key "might be found"); C133-CHIF in print (what separates `[LiSu2026]` from `[MatolcsiEtAl2025]` § 2's question). **Credited:** FS131-PAS2, for the Li–Su find, the phrase probes of a withheld summary with a nonsense and a visible-text control, and the two printed questions it answered in passing (held with C7). Running: FS131-KFS1 — 1 slot.
> — source: plans/FS131-close-inventory.md

On history and commits:

> 1025. **The unpushed history rewritten, and the privacy guard made a commit hook (logged 2026-10-16 18:38 UTC; Kooshi: "Go ahead and rewrite the local history, and maybe add a git commit hook to run the privacy guard").** Item 1022's question, answered. **Done on `main`:** the 21 commits after `origin/main` (`66d5e928c`) rewritten by `git filter-branch` with a deterministic rewording filter (two commit messages; four item headings in five versions of this file), kept outside the repository because it holds the refused words; the final tree is unchanged (`main^{tree}` equal before and after), `main` still descends from `origin/main`, and the guard over every message and every added or changed file version of the range reads 0 refusals (17 before). Every commit of the range has a new hash: the old-to-new list is `data/fs131/history-rewrite/main-2026-10-16.txt`, and every hash this file cites from items 1016–1024 is an old one. **Signatures:** `filter-branch` drops them, so the 21 commits are now unsigned. *Choice:* leave them unsigned. *Alternative weighed:* re-sign them. *Why:* re-signing puts a timestamp in each commit, so the job branches' copies of these commits would no longer rewrite to the same hashes at their landing; and 116 of the last 200 commits already on GitHub are unsigned. *Confidence:* medium; Kooshi may want them signed, which can be done once at the next push. **The job branches** (`fs131-kpa1`, `fs131-ktc1`, `fs131-kfr1`, `fs131-kcs1`) carry the old commits through my merges of `main`; each is rewritten by the same filter when its agent hands back and before it merges, so its old commits become `main`'s new ones; the `p`-adic and three-colour branches also need their stopped agents' records reworded (the filter gains those lines then). **The hooks:** `pre-commit` (each staged text file's staged content through the guard; binary files and files over 10 MB skipped and named, left to the push-time check) and `commit-msg` (the message through the guard), in the common hooks folder, so they run in every worktree; untracked, so the guard's location is not published. Controls in a scratch repository: a clean commit passes; a planted phrase is refused in a file, in a message and in a path with spaces; a binary file is skipped.
> — source: plans/FS131-close-inventory.md

In short, for you: remove Part A's skeleton from this branch in your first commit; make the price probe your first leaf
— generate the data and check two atom chunks in the kernel, then message me the measurement (time and memory per chunk,
and the extrapolation to all of them) and continue unless it shows the whole check will not fit the machine; the
generalization (every finite unit-distance graph over ℚ(√3, √11) has `χ_gf ≤ 4`, FS131-PAS2 § 4.2) is optional — state and
prove it if it is under about 100 lines in the library's vocabulary, else write its price in your record; merge `main`
before the gate.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding. Take a dump of the skeleton's stored statements before
   your first proof edit (a comparator shaped like `tools/fs131_iru2_statements.py`, with a planted control watched).
2. **Stage 2 — the price probe**, measured and messaged, as ruled.
3. **The leaves**, in the plan's order, re-pricing from the probe and the first two leaves and writing the re-price into
   your record; every module built through `./scripts/build.sh` under the slot; the generator with a `--check` mode whose
   planted fault is refused; a saved stage after each module.
4. **The gate on one commit**, after merging `main`: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/isf1/`, its logs there); every count change explained against `main`'s last gate (`data/fs131/iru2/gate/`,
   the ring of unit vectors', unless I tell you another landed first); the statement comparison against your dump; the
   vacuity scan's new sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate); `#print axioms` of
   every head statement (expected: the standard three, no outside theorem). Commit any statement dump gzipped.
5. **The read-aloud** of each head statement against `CLOSED-QUESTIONS.md` § 1.6 and `[CranstonRabern2015]`'s question, in
   your record, with what is not claimed.
6. **The drafts** for the front files (the plan's Stage 4 brought to what is proved), each naming its slot; for the
   novelty line, FS131-PAS2's C14 line (`plans/FS131-PAS2-prior-art.md` § 4.4, "C14's novelty line"), quoted, not reworded.
7. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, the data's format and chunking, helper lemmas and their modules, and
whether a leaf is better proved another way than the plan says — say so in your record. Not yours: any stored statement
of the skeleton or of `main` (message me with the defect and the form you need). You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

The laptop: 12 cores, 31 GB, shared with one other implementer that builds and will run a full gate. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`; a data chunk that needs more memory asks the slot for it (`--mem 12`), and on exit 75 waits ten
minutes and retries. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only,
never evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what
your record cites under `data/fs131/isf1/`. Nothing with a `sorry` reaches `main`.
