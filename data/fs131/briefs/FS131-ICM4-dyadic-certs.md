# Brief FS131-ICM4 — the five-colour chain: M13's two dyadic certificates

*Written 2026-10-14 20:53 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-ICM4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of M13's last two leaves on this line — `colorable_four_dyadic_small` (the level-one target at a prime above 2 is four-colourable at residue sizes 4, 8, 16 and 32) and `charSum_64_ge` (its least eigenvalue at 64 is at least −15) — through a generic form of `Floor128`'s binary-field bridge and five certificates; then, if the budget remains, the odd-characteristic Lemma P folded onto the general one so that it is proved once
  launch: now, in the last implementer's tree (its job is finished; nobody else writes there) on a new branch cut from its branch; three other jobs share the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a certificate fails in exact arithmetic, if the bridge's first part prices it above 1,200 lines, and with one line when `ratioAtMost_of_five_le_chromaticNumber` rests on `ratioAtMost_cert` alone; the report goes to `data/fs131/reports/FS131-ICM4.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-ICM4-implementation.md` (new, on branch `fs131-wcm4`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch` on a **new branch `fs131-wcm4`** that you cut from its head (`fs131-wcm3` at `c0b6798ed`; its build is current for that commit, build 4): **proofs, private helpers and import lines only — no statement changes, no definition changes** in `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`; new modules under `Proofs/HadwigerNelson/Arith/` for the bridge and the certificates, with their lines in the build's lists and `ARCHITECTURE.md`; `Proofs/HadwigerNelson/Arith/Floor128.lean` only to make it read the generic bridge (its public statements unchanged), if that is shorter than leaving it; your generators and checks under `tools/` named for this job; `plans/FS131-ICM4-implementation.md`; `data/fs131/icm4/`; `data/fs131/reports/FS131-ICM4.md`. **Not** the count's modules, `Arith/FibreCert*` (another line), `Arith/CircleCos.lean` (proved), any module under `Outside/`, the declared `StandingFive.kloosterman_bound`, the declared printed theorem. Untracked files of earlier jobs under `data/fs131/`: leave them. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. M13 — the step of the five-colour chain that turns "every prime's finite plane needs five colours" into a bound
on how large a colour class can be — is proved on this line but for three private leaves. One is the certificate link
at residue sizes 11 and 19, which closes when the lines are joined. You prove the other two, both at primes above 2.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The gate takes no `sorry`, so the chain cannot land on `main` until these two leaves are proved.

## The statements

The dated line of the chain's claim list (`data/fs131/claims-NF2.md`) that says what the count reads from M13:

> - 2026-10-14 — **The count is typed** (FS131-K12A): `Rigidity.Counting.count_of_oneAvoidingDensityBound : Plane.OneAvoidingDensityBound → (chainInterface F).Count`, for every real number field, composed over 57 leaves in eight modules (`Plane/WindowDensity`, `Rigidity/FiniteZhang`, `PlaneZhang`, `CountTorus`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`); it reads `tca_uniform`, `noRamifiedStableDyadic_of_tca`, `TA_subset_contChars`, `exists_mul_stableIntegers_le`, `dense_mixedEmbedding_nsmul_unitRing` and `upperDensity_le_of_oneAvoidingDensityBound`; no typed statement of another module changes.
> — source: data/fs131/claims-NF2.md § Dated lines

The last two hand-backs on this line and the instances planner's notice, as I logged them (their words in quotation
marks, the rulings mine):

> 905. **FS131-ICM2 handed back at stage 4: Lemma P proved, the exclusions at 3 and 7 proved, the exact spectra reduced to a closed statement (logged 2026-10-14 19:21 UTC; "JOB FS131-ICM2 — STAGE 4 SAVED"; branch `fs131-wcm2` at `a7501c681`, tree `fs131-wch`; record `plans/FS131-ICM2-implementation.md` there).** From its hand-back message: "`Rigidity.tca_uniform` and `Rigidity.exists_uniform_tail` … rest on `[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]` … with no `sorry`"; Lemma P's two leaves on the standard three ("at an odd stable prime with `|𝓞 ⧸ P| = Q²`, every norm-one residue at level `n + 1` has exactly `Q` norm-one lifts at level `n + 2`"; "a character non-trivial on `ker red` sums to at most `(2/(Q + 1))·|S_{n+2}|`"); "at `Q ∈ {3, 7}` the level-one target is four-colourable"; `charBound_one_exact` reduced through `charBound_one_of_circleCos` to `circleCos_bound` ("a closed statement about `ZMod Q`. Read true in floating point, with margins `1.638·10⁻³` and `4.880·10⁻⁶`"); GAP at four private leaves (`ratioAtMost_dyadic`, `circleCos_bound`, `charBound_one_exact_27`, `ratioAtMost_cert`); "`count_of_oneAvoidingDensityBound`: its `sorryAx` now comes only from `Plane.upperDensity_le_of_oneAvoidingDensityBound` and `Rigidity.noRamifiedStableDyadic_of_tca`. No leaf of M13 is under it"; statements SAME 44, PRIVATE-SAME 69, CHANGED 0; two generalizations (Lemma P in any finite ring with an involution and a square-zero ideal; K3's isomorphism "in all but name"); a tool defect (ICM1's comparator skipped internal names) fixed in its own; a grading slip corrected. **My receipt:** item 901 (`tca_uniform` printed by me: the standard three and Weil's bound). **Rulings, four parts.** (1) *The next job on this line:* `circleCos_bound` (rational cosine bounds, one kernel `List.all` check of 528 and 960 pairs), then `charBound_one_exact_27`, then the dyadic branch with its own Lemma P; `ratioAtMost_cert` at the landing's join — item 906; high. **Corrections owed:** M13's prices (Lemma P 617 lines; the exclusions 60 against 300–500; the exact spectra 200 + 300–600 against 700–1,200). **Tool defect (the tooling list):** a statement comparator that skips internal names passes a changed private leaf.
> — source: plans/FS131-close-inventory.md

> 922. **FS131-ICM3 handed back at stage 5: the exact spectra at 23, 27 and 31 proved, the dyadic branch down to two certificate children, the amendment done (logged 2026-10-14 20:52 UTC; "JOB FS131-ICM3 — STAGE 5 SAVED"; 548k by the harness's count; branch `fs131-wcm3` at `c0b6798ed`, tree `fs131-wch`; record `plans/FS131-ICM3-implementation.md` there).** From its hand-back message: "**TRUE — `circleCos_bound`**, proved through a new public module, `Arith/CircleCos` (297 lines)", margins "49141/1250000 (3.9·10⁻²) at 23, and 46847/300000000 (1.6·10⁻⁴) at 31", the control failing at 11 and 19; "**TRUE — `charBound_one_exact_27`** (private), [kernel] on the standard three and `StandingFive.kloosterman_bound`. I used another route" (Weil and the parity of `N₀`, `Re Σ ≥ −8`; "This proves the bound λ_min ≥ −8, not FS100-G27's equality"); "**TRUE — Lemma P with no unit 2**" (`SqZeroInvT`, `charBound_of_charBound_oneT`); "**TRUE — EN1-UQ4** (`charSum_dyadic_large`, private)"; "**GAP — `ratioAtMost_dyadic`** is proved except for two closed children": `colorable_four_dyadic_small` ("U_Q is four-colourable at Q ∈ {4, 8, 16, 32}") and `charSum_64_ge` ("λ_min(U₆₄) ≥ −15"), "Both are true by X26B-T1's exact computations [tools]"; the amendment's `ratioAtMost_of_two_notMem` "with the ruled statement verbatim", its `sorry` "from `ratioAtMost_cert` alone"; build 4 green, statements SAME 44 / PRIVATE-SAME 129 / NEW 1 / CHANGED 0 (plants 5/5), 245 records CLEAN 229 / IMPORTED 7 / UPSTREAM 9 / FAIL 0; what is left of the dyadic branch "About 700–1,200 lines in all" (a generic form of `Floor128`'s bridge, then five certificates); generalizations (Lemma P needs only one θ with θ − σθ a unit, so ICM2's odd chain "now exists twice"; `card_eq_sq_of_involution`); a lint finding outside it (`Rigidity.archTop`'s unused `[NumberField ↥F]`, `Rigidity/ContinuityGroup`). **My receipts:** the five commits are on `fs131-wcm3`; from the tree's compiled library (scratch `icm3/Ax1.lean`) `ratioAtMost_of_two_notMem` has the ruled statement and rests on `[propext, sorryAx, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`, as does `ratioAtMost_of_five_le_chromaticNumber`; `tca_uniform` on the standard three and Weil's bound; `CircleCos.circleCos_ge` on the standard three. **Rulings, four parts.** (1) *The next job on this line:* the two certificate children — the generic binary-field bridge, the four four-colourings and the spectrum at 64 — then, if the budget remains, ICM2's odd Lemma P folded onto `SqZeroInvT` (a fact proved once), in this tree on a new branch (item 923); alternative, leave the dyadic children for the chain's landing — declined: the gate takes no `sorry`, so the chain cannot land without them, and this tree's build is current; high. (2) *The route at 27 through Weil's bound:* accepted — the chain already rests on Weil at M13's tail (`tca_uniform`), so a Weil-free 27 buys nothing for the chain; alternative, the recorded model route at KC13's price — declined; high. (3) *`archTop`'s unused binder:* a definition, so the chain's landing gives it `@[nolint unusedArguments]` with its reason if dropping it moves other stored types, else drops it; high. **Corrections owed (the second filing):** the prices (23 and 31 about 300 lines against KC13's 700–1,200; 27 about 125 against 400–600; EN1-UQ4 about 260 against KR1's 300); EN1-UQ4's grade line in `plans/FS131-EN1-derivation.md` § 7.3, now [kernel]. **Credited:** the 27 route, Lemma P with no unit 2, and the amendment done the same day.
> — source: plans/FS131-close-inventory.md

> 920. **FS131-KM15 — a shorter route, one public fact from M13's line, and a generalization; ruled (notice, 2026-10-14 20:35 UTC; by message).** From its message: "M15 needs no ramification/inertia computation. M13's per-prime leaves read a stable prime only through `2 ∉ P` and `|𝓞/P| = Q²`, Q ∉ {3, 7}"; ω = (1 + i√47)/2 with ω(1−ω) = 12 excludes a stable prime above 2, and at an odd stable prime "the residue of √47 is fixed by conjugation … So 47 is a square mod the residue characteristic: false at 3 and at 7"; "My first estimate for M15 at ℚ(√47): 300–500 lines, against the map's 800–1,500. Not yet measured"; the public fact `ratioAtMost_of_two_notMem` (statement in `data/fs131/briefs/FS131-ICM3-m13-last-leaves.md` § Amendment), "composed only from M13's existing private leaves … none of them needs `¬ IsRamified`", stated on its branch as a private `sorry` link deleted at the join; generalizations: `5 ≤ L(F)` for every real number field holding `√d`, `d ≡ 47, 143, 167 (mod 168)` (D:116's class), and "CLS is an equivalence: TCA F ↔ 5 ≤ L(F)". **My receipt:** on `fs131-wcm3`, `ratioAtMost_of_five_le_chromaticNumber`'s odd branch (`ClassRatio` ll. 2436–2455) reads `h` only at `Q ∈ {3, 7}` (through `chromaticNumber_le_four_of_small`) and `hram` only on the dyadic branch, as reported. **Ruling, four parts:** (1) the planner's form: the public theorem added on M13's line by FS131-ICM3 (its brief amended, gate PASS, sent by message), the odd branch reading it; on M15's branch a private link under another name, deleted at the join; the general form over D:116's class typed, the instances corollaries; the equivalence typed if it is the three lines reported; (2) alternative, a χ-form floor (`5 ≤ χ(levelTarget P 1)`) in `ClassRatio` — declined: M15 consumes the ratio, and the ratio is what M13 proves; (3) the shorter route removes the place computation the map priced, and the fact lives once, upstream; (4) high. **Prediction registered (the planner's, to score at its hand-back):** M15 at `ℚ(√47)` 300–500 lines.
> — source: plans/FS131-close-inventory.md

**Your work, in order** (the last implementer's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-ICM3-implementation.md` § Stage 5, "What is left of the dyadic branch", and its
§ Stage 4 for the dyadic glue; the two leaves at `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` ll. 1649 and 1657): (1) **the bridge** —
a primitive polynomial of degree `n` over `𝔽₂` gives, in every field of `2^n` elements, a root whose powers are the
non-zero elements; `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/Proofs/HadwigerNelson/Arith/Floor128.lean` (661 lines) does this for one polynomial, and the generic form is priced
at 400–600 lines. (2) **The five certificates**, each with its generator: two coordinate functionals off the unit circle
for the four-colourings at degrees 4, 6, 8 and 10; counters at most 40 over the classes modulo 63 for the spectrum at
degree 12; about 60–120 lines each. The exact values they certify are X26B-T1's (`plans/FS100-X26B-derivation.md`) and X23D § 2.3's (`plans/FS100-X23D-derivation.md`),
at [tools]. (3) **If the budget remains:** the odd-characteristic Lemma P of the record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch/plans/FS131-ICM2-implementation.md` folded onto
`SqZeroInvT` with `θ = ι`, its private duplicate deleted and its readers redirected, no public statement moved.
Re-price each from its first part and say so.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the two leaves printed from the kernel
   and restated beside their routes; the stored statements of your files dumped from the built tree before any edit.
2. **The bridge** (a saved stage), with `Floor128`'s instance read through it or left as it is (say which and why).
3. **The certificates** (saved stages as they fall), each refusing a planted corrupted entry; the one line to me.
4. **No statement and no definition changed** but the new modules', shown from the kernel's side against item 1's dump
   (a planted change watched firing); one build under the slot with no warning from your files but `ratioAtMost_cert`'s;
   the axioms of every public declaration of your files, of `ratioAtMost_of_five_le_chromaticNumber`, of
   `tca_of_five_le_localBound` and of `ratioAtMost_of_two_notMem` printed from the built tree, each listed, with a planted
   record watched showing; the guarded lint (`lake lint --no-build -- --no-build --trace`) with no finding in your files.
5. **Drafts for the landing**, in your record: the audit's block; any `LEAN.md` lines.
6. The report in the standing rules' form. Leave no process running or queued. Stopping at a saved stage with a
   certificate left, named with its route, is a good report.

## What is yours to decide

The proofs; private helpers; the new modules and their names; imports; the order inside each part; the certificate
encodings; another route for a leaf where the recorded one does not go through (tell me which). An unread binder of a
statement in your files is dropped, listed and named. Not yours: any other change to a statement or definition; a new
declared axiom; the files listed as not yours; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 316 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is current for `fs131-wcm3` at build 4. One file through `lake env lean`: 3 to 24
seconds, 3.6 GB.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icm4 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree, and
run every command from inside it. The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never
`lake build`; do not edit a file a running build will compile. The certificate job at size 19 can hold up to 10 GiB of
the slot for long stretches: on exit 75 wait ten minutes and retry. A cap kill under a `timeout` wrapper shows as exit
143, not 137. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your
record cites lives under `data/fs131/icm4/`. Report at once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path on your branch and do not push**; I copy the branches to a
local backup.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
