# Brief FS131-LJ1 — land the three-and-four-colours line through the full gate: six files, no `sorry`, the theorem's three clauses in the kernel

*Written 2026-10-14 02:44 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LJ1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the lander of one finished line of six files — no `sorry`, built in its tree, every public declaration printing the standard three axioms or those and one declared outside theorem; you take it through every step of the gate on one commit, register its records, retire the hypothesis it now proves, read its headlines aloud against the claim list, and draft the front-page lines; the merge into `main` is the coordinator's, at your green line
  launch: now, in the tree the line was joined in — its last job has handed back and nobody else writes there; a planner and an implementer of other milestones work in other trees and share the build slot; the last landing was merged and its drafts filed, so `main` at `0b56f33ee` is what you merge and what your drafts quote
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the records do not explain, if the read-aloud finds a statement that says more or less than its claim, or if a count does not come out as § Done means predicts; **with one line when the gate is green on one commit** (then finish your record and hand back: the merge into `main` is mine); the report goes to `data/fs131/reports/FS131-LJ1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-LJ1-landing.md` (new, on branch `fs131-wj1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc` (branch `fs131-wj1`, at `dec3b73ce`; its compiled library is current for the line's last build): the merge of `main`; the six files `Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean`, `Proofs/HadwigerNelson/Arith/TorsionExtraction.lean`, `Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean`, `Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean`, `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean`, `Proofs/HadwigerNelson/Instances/UpperHalfCorollaries.lean` — **docstrings only, no statement changes**; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` where a row needs a word; `plans/FS131-LJ1-landing.md`; `data/fs131/lj1/`; `data/fs131/reports/FS131-LJ1.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the registrations, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. This is the third landing on this machine in two days. The second went through the gate on its first full
pass yesterday evening, and its record is the pattern for yours — with two things it learned the hard way, which are
in § Done means.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

This line is the second-ranked finding and the first of this project's own to reach the gate: for real quadratic
fields, which planes need two, three and four colours; over every real number field, exactly when three colours
suffice; and a lower bound of four for any subfield of the reals whose unit vectors generate one third. Four
implementers proved its four modules on four branches, and a fifth job joined them with the landed residue module,
proved the ten joining statements and read every credit against the paper it names. In that tree nothing rests on an
unproved step. Until the gate is green none of it is "held".

## The statements

The claim list `data/fs131/claims-NF4.md` — the theorem, its "not claimed" line, and the dated line that says where
the kernel says more (its five earlier dated lines are in the file; read them there):

> NF4-THEOREM: *The theorem.* (a) For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`. So, with the printed values: `χ(ℚ(√m)²) = 2` for `m ≢ 3 (mod 4)`; `3` for `m ≡ 3, 7 (mod 12)`; `4` for `m ≡ 11 (mod 12)` outside the classes `47, 143, 167 (mod 168)`; and at least 4 in those. (b) For every real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`. (c) For any subfield `F` of `ℝ`: if `1/3` is an integer combination of unit vectors and `F²` has an odd cycle, then `χ(F²) ⩾ 4`.
> — source: data/fs131/claims-NF4.md § The theorem (the asking lane's wording, rank 2)

> NF4-NC: any upper bound as this project's (every upper bound here is prior art, and the field-level upper halves are the first module's, on branch `fs131-wnf`); the two-colour classification over every real number field and the three-colour one for fields containing the square root of 3 as this project's (they are an outside model's derivation recorded in this repository: `LEDGER.md` § B, the two entries dated 2026-09-14); anything at five colours; anything over a field that is not a number field where the map or the ledger's row 99 says a wider reading fails.
> — source: data/fs131/claims-NF4.md § Not claimed

> - 2026-10-13 — **Statements of the line that say more than the list, typed by the joining job (FS131-KJ1).** (1) NF4-S6 holds reading the colouring only on the ring of unit vectors: a three-colouring of the unit-distance graph on `ℤ[U_F]` gives the character (`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing`; found by FS131-IC1). (2) Clause (a) in character form: `Θ₃(R_F) = ∅` for every subfield `F ∋ √d`, `d ≡ 11 (mod 12)` (`TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem`; named by FS131-IT1). (3) The table's rows need less than squarefreeness: two colours for every `m ≡ 1, 2 (mod 4)` (found by FS131-ID1); three for `m ≡ 3 (mod 4)` with `m ≡ 1 (mod 3)`, or `3 ∣ m` and `9 ∤ m`; four for `m ≡ 11 (mod 12)` with `m ≡ 1, 2, 4 (mod 7)`, or `7 ∣ m` and `49 ∤ m`; four for every `m ≡ 11 (mod 24)`. Squarefreeness cannot be dropped whole: `m = 12` is `ℚ(√3)` (three colours, and `12 ≢ 3 (mod 4)`), `m = 99` is `ℚ(√11)` (four, and `99 ≡ 3 (mod 12)`). (4) Two upper bounds on level targets, the first in the library: a stable prime modulo which conjugation is the identity has a two-colourable target, and one whose quotient has nine elements a three-colourable one (`ThreeFourColours.levelTarget_colorable_two_of_ramified`, `levelTarget_colorable_three_of_card_nine`). (5) NF4-DYADIC-FOUR as worded holds at every `m ≡ 3 (mod 8)`, not only `m ≡ 11 (mod 24)` (`exists_stablePrime_card_four_sqrt`). No statement defect found.
> — source: data/fs131/claims-NF4.md

The joining job's hand-back as I logged it, with my receipt (its words are in quotation marks; the rulings are mine):

> 720. **FS131-KJ1 handed back: the three-and-four-colours line is one tree with no `sorry` (2026-10-14 02:44 UTC logged; "JOB FS131-KJ1 — DONE"; 601k by the harness's count — past its line, not to be resumed; branch `fs131-wj1` at `dec3b73ce`, clean).** "the ten joining leaves — ALL PROVED, no statement of the planned text changed (… 122 named constants of the first build are in the final dump unchanged, 26 added, 0 changed or gone …)". "From the built tree, 232 records in nine files (private helpers included): none prints `sorryAx`; 219 are on `[propext, Classical.choice, Quot.sound]` or fewer, 13 on those and Weil's bound". **The theorem's clauses, read aloud by it:** clause (a) "TRUE in the kernel as one statement, `ThreeFourColours.chromaticNumber_planeOver_sqrt_table {m : ℕ} (hm : Squarefree m)`, a conjunction of the four clauses; standard three"; clause (b) "TRUE in the kernel on Weil's bound: `chromaticNumber_planeOver_eq_three_iff` … \"Above 3\" is implied by three elements and is not written"; clause (c) "TRUE in the kernel of the joined tree, standard three"; row 99 "TRUE in the kernel on Weil's bound: `localBound_le_chromaticNumber_of_le_four` (the hypothesis `hRow99` of the five-colour chain's headline, now a theorem)" with two corollaries; "Not in the kernel and still [hand]: the row's \"no mixing\" clause and `χ(ℚ(α,√7)²) = 4`". **Which clauses rest on Weil's bound:** "standard three alone: clause (a) whole …, clause (c), …, clause (b) from the prime to the colouring …. Standard three and Weil: clause (b) as claimed …; row 99 in all four forms …. Weil's bound is read at one place, `targetFloor_four_weil`; nothing at two or four colours reads it." The statements the implementers named are typed and proved; the residue module's corollaries: three in a new file `Instances/UpperHalfCorollaries`, and "GAP: row 52's two VALUES are not one application — `χ ≥ 5` over `K(√5)` and `K(√247)` is stated by no declaration" (their upper halves are). "96 public records for the landing to register, 84 CLEAN and 12 IMPORTED on the one declared import; no new axiom, no purchase, no hypothesis former". Its credits against the paper are item 708. Two of the plan's routes replaced (J.7, J.10). A machine fact: "with two other jobs each reserving 12 GiB under a 22 GiB budget a third 12-GiB build is starved …; a build with two or three small modules stale runs honestly at `--mem 10`". **My receipt:** the tree is clean at its head; no `sorry` in the six files; `data/fs131/kj1/logs/axioms-final.out` ends "CONTROL: 3 of 3 planted records read as planted … SORRY records: 0, equal to the expected list (0) / PASS"; the three headline statements read in the source — the table's four rows are the claim's, with the excluded classes 47, 143, 167 modulo 168, which I re-derived (radicands 23 modulo 24 that are not squares modulo 7); **run by me from its compiled tree**: the table and clause (c) print the standard three; clause (b) and the row-99 statement print the standard three and `StandingFive.kloosterman_bound`. Not read by me: the proofs. **Rulings.** (a) *It passed its budget line to finish the last two leaves instead of handing them back with plans, each stage committed first, and asks whether it should have stopped: no — finishing two leaves from a saved stage was the cheaper path; the line that matters is the harness's 500k for resuming, and it is not resumed.* (b) Its dated line for the claim list (five places where the kernel says more) is filed in `data/fs131/claims-NF4.md`, by script from its record. (c) Row 52's two values stay [hand] with their upper halves in the kernel; a lower bound of five there is the five-colour chain's. (d) The chain's headline can lose its row-99 hypothesis once this line is on `main` — for the chain's next job. (e) The corrections it drafts for older files join the cleanup sweep (items 702, 708). Credit: ten leaves where the plan promised compositions and six were not; a paper read page by page; a control planted at every reading.
> — source: plans/FS131-close-inventory.md

Where everything is, in your tree: the joining job's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc/plans/FS131-KJ1-joining-module.md` — **its § Stage 7 gathers the drafts for the
landing and the filing in one place** (the audit block of 96 records at `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc/data/fs131/kj1/audit-block.txt`; the
note on the assumptions step; the drafts for the ledger rows, the front page, `LEAN.md` and the bibliography, each
with its slot), its § Stage 4 the credits read against the paper, its § Stage 5 the readings from the built tree.
The last landing's record `plans/FS131-LU1-landing.md` on `main` and its receipts `data/fs131/lu1/gate/` — **its
three final receipts are the "previous" side of your digests**, and its stages 4 and 7 are the two lessons below.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; the joining job's record read;
   `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`; the last landing's record. Merge
   `main` into the branch (it holds the last landing's filing: the front page, the ledger, the fact-audit tool):
   trial the merge and name its conflicts first; keep both sides. Dump the stored statements of the six files from
   the built tree before any edit. Build.
2. **Docstrings, no statement**: whatever the joining job's record leaves for the landing; nothing in a file outside
   your six (the corrections it drafts for older files wait for one sweep).
3. **The registrations**: the 96 records as one block of yours in the audit script — by the joining job's count 84
   under the banner for the standard three or fewer and 12 under the banner for records that rest on a declared
   outside theorem (Weil's bound, `StandingFive.kloosterman_bound`; no record may rest on two declared theorems);
   if the audit's state-reading controls go red on a count, move it by that file's own rule after seeing it red;
   `tools/check_architecture.py` exit 0 (four rows of `ARCHITECTURE.md` still call the proved modules skeletons:
   the joining job drafted their words); the doubled-name check.
4. **What the library assumes**: `./scripts/assumptions.sh --self-test`, then the step, **run before you edit
   anything of it**, and its output kept. The line proves a statement the library has carried as a written-out
   hypothesis of ours (the lower bound through four, the chain's `hRow99`), now on Weil's bound. **The step will
   not tell you** — the last landing found that it reports a proved hypothesis only when the hypothesis is a named
   one — so the entry is retired on your own reading, as that landing did (its stage 4). Say in your record what
   the entry becomes: a hand result of ours discharged, with the theorem that discharges it resting on a declared
   outside theorem. Write the ledger with the script's own flag, and set the nine counts the step then prints beside
   the ones on the front page (`axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1`),
   each difference explained by name.
5. **The vacuity step** and its `--self-test`: how the scan classes every new site; and name by hand the kernel
   model of each hypothesis-shaped headline (the joining job's four models are in the joining module).
6. **Read aloud**, in your record: the theorem's three clauses and the row-99 statements against the claim list's
   theorem line, its "not claimed" line and its dated lines, clause by clause — every hypothesis Lean has that the
   claim lacks and every one the claim has that Lean does not need; which clauses rest on the standard three alone
   and which also on Weil's bound, read from your own print; and for each exact value the kernel theorem that holds
   each half, by name with its axioms. A difference is a message to me before the gate runs.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search
   whose plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test`
   green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and
   `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build
   --trace`, under the slot), silent, with its planted control red; the notes check and the records check as the
   last landing ran them. The three digests against `data/fs131/lu1/gate/receipt-axioms-final.log`,
   `data/fs131/lu1/gate/receipt-vacuity-final.log` and `data/fs131/lu1/gate/receipt-assumptions-final.log` (say
   exactly which front-page lines they report stale). By my arithmetic from the joining job's count the audit
   should read 7,602 records, 7,531 clean, 38 imported, with the axiom-free and purchase counts unchanged — a
   difference is a message to me, not a failure. Every step's log saved under `data/fs131/lj1/gate/` and named,
   with its wall time and peak memory. Then one line to me.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LJ1)", each with the log line
   it comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once
   (the last landing's `data/fs131/lu1/drafts-slots.py` is the pattern; **give the fact-audit tool's table every
   token your drafts retire — the code spans whole, and a count both with and without its comma** — the last filing
   failed its audit on five such tokens): the audit's and the gate's count lines and the assumptions counts in
   `CLAUDE.md`; a `GATE_CHANGES` entry; the ledger rows this line regrades, from the joining job's drafts checked
   against what landed (rows 52, 73, 79, 82, 99, 105 — each only as far as its statement landed; row 52's two
   values are still not in the kernel, only their upper halves); the front page's sentences on three and four
   colours; **whose each value is, exactly as the joining job read it against the paper** (the values two and three
   and the upper bounds are Fischer's; what is ours is the lower bound of four against every colouring at radicands
   11 modulo 12, the three-colour criterion over every real number field, and the clause for subfields of the reals);
   `LEAN.md`'s facts from the five records; the bibliography's row. And the open gate items at this landing, by name.
9. **Your record**, stages headed "Stage n — SAVED (FS131-LJ1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with
   the gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; how the records are grouped; the batch size of each build; the
wording of an open gate item; whether a rebuild after the merge is saved by copying compiled files from the tree
whose gate passed last (`fs131-wnf`) — three jobs did that and I accepted it on the condition that the record says
what was copied, from where, and how it was compared. Not yours: any statement; the merge into `main`; a push;
anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md`, `LEAN.md` and older
landings' records do not apply.** Measured by the last two landings here: every whole-library gate step is one `lean`
process of 4.4 to 5.1 GiB; a build in which only small modules are stale is 5.5 to 8 minutes; the whole final pass
was 22 to 24 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lj1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build:
`--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. Two other jobs share the slot,
each asking up to 12 GiB for a build: on exit 75 wait and retry, and tell me if a step has waited an hour. Stop a
process by its PID, never by matching its command line. `/tmp` is wiped at power-off: every log your record cites
lives under `data/fs131/lj1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
