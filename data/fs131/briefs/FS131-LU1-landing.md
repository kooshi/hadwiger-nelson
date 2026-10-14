# Brief FS131-LU1 — land the first module of the number-field results through the full gate: a plane over a real number field needs no more colours than its residue targets, and four values that follow

*Written 2026-10-13 20:13 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LU1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the lander of one finished module of three files — no `sorry`, built in its tree, every public declaration printing the standard three axioms; you take it through every step of the gate on one commit, register its records, retire the named hypothesis it now proves, read its headlines aloud against the claim list, and draft the front-page lines; the fast-forward of `main` is the coordinator's, at your green line
  launch: now, in the tree the module was finished in — its implementers have handed back and nobody else writes there; implementers of another line work in other trees and share the build slot; the last landing was merged and its drafts filed just before this brief was written, so `main` at `147e38bc8` is what you merge and what your drafts quote
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the records do not explain, if the read-aloud finds a statement that says more or less than its claim, or if the assumptions step does not come out as the last implementer predicted; **with one line when the gate is green on one commit** (then stop: the fast-forward of `main` is mine); the report goes to `data/fs131/reports/FS131-LU1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-LU1-landing.md` (new, on branch `fs131-wnf`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-wnf`, at `d83fdd8c7`; its `.lake/build` is current for that commit): the merge of `main`; the three files `Proofs/HadwigerNelson/Arith/UpperHalf.lean`, `Proofs/HadwigerNelson/Arith/QuadraticPrime.lean`, `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` — **docstrings only, no statement changes**; `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` where a row needs a word; `plans/FS131-LU1-landing.md`; `data/fs131/lu1/`; `data/fs131/reports/FS131-LU1.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the registrations, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. This is the second landing on this machine today. The first went through the gate on its first full pass,
and its record is the pattern for yours — including what the machine can carry, which it measured.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The results about planes over number fields come first, and this module is the piece nearly all of them stand on: a
plane over a real number field maps homomorphically into each of its residue targets, so it needs no more colours
than they do. A planner typed it this morning and caught a false statement by typing; three implementers proved its
twenty-four leaves this afternoon with no statement changed. With it the kernel holds, on the standard three axioms:
the bound by the local bound for every real number field; the five-colour chain's headline with one of its named
hypotheses discharged; the plane over the field of the square root of 11 needs exactly four colours; the rational
plane exactly two. **None of the values is claimed as new mathematics** — the upper bounds are prior art, and what
is this project's is said in `LEDGER.md` § The claim list. Until the gate is green none of it is "held".

## The statements

The claim list, fixed before the module was planned, with its two dated lines:

> NF1-S1A: For a real number field `F` and `𝔭` with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-S1B: For a real number field `F` and `P : SpectralChain.StablePrime F`: a graph homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F) ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-S2: For squarefree `d > 1`, `F = ℚ(√d) ⊂ ℝ` with its `NumberField` instance, and an odd prime `p` with `d ≡ s² ≢ 0 (mod p)`: a maximal ideal `𝔭` of `𝓞 F` with `Nat.card (𝓞 F ⧸ 𝔭) = p`. The same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`).
> — source: data/fs131/claims-NF1.md § Statements

> NF1-MODULE: **The first module I would start with, whatever the ranking:** the residue upper half — `[S1a]` and `[S1b]` in one new module (`Arith/UpperHalf`, importing `Arith/PlaceHom` and `SpectralChain`), `[S2]` for real quadratic fields in a second (`Arith/QuadraticPrime`), and the values they close in a third (`Instances/…`: `χ(ℚ(√11)²) = 4`, `χ(ℚ²) = 2`, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` again as the control against `SqrtFortySeven`). Reasons: thirteen rows wait on it; it discharges one hypothesis of the headline (`inline:UpperHalf`) and is leaf 1 of row 99; it imports nothing; and the result everyone expects first, `χ(ℚ(√47)²) = 5`, is not reachable without the whole chain, of which this is also a leaf. Two implementers could run at once with no shared file: one on `Arith/UpperHalf`, one on `Arith/QuadraticPrime`; the instances file follows both. In parallel and independent of both, the chain's own first leaf is C0 (naming `T + A`) and then leaf 13 (entropy): a third tree.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-NC: any lower bound for a plane over a field; anything above level one of a tower; `[S2]` at a prime where some radicand is not a square; that an instance's value is new mathematics (the value four over the field of the square roots of 3 and 11 is K. G. Fischer's of 1994; `LEDGER.md` § The claim list says what is ours); that the upper half alone gives any exact value — each exact value named also needs its lower half, which the map says the kernel holds for the instances listed.
> — source: data/fs131/claims-NF1.md § Not claimed

> - 2026-10-13 16:36 UTC — **NF1-S2's second sentence is false as written; found by the module's planner (FS131-KN2) while typing it; its counterexample checked by me.** Its words: "Read with more than one radicand divisible by p it is false. Counterexample: F = Q(sqrt 11, sqrt 22), p = 11. Both radicands are squarefree and are 0 = 0^2 mod 11, so 'every radicand is a square' holds; but F = Q(sqrt 11, sqrt 2) and 2 is not a square mod 11 (the squares are 1, 3, 4, 5, 9), so 11 is inert in Q(sqrt 2) and every prime of F above 11 has residue field of 121 elements: no maximal ideal with 11. The missing hypothesis: at most one radicand is divisible by p, and p^2 does not divide it. '11 in K' is that case and is true." **The statement stands with that hypothesis**: the other radicands nonzero squares modulo p, at most one radicand divisible by p, and p² not dividing it.
> — source: data/fs131/claims-NF1.md

> - 2026-10-13 16:36 UTC — **Three statements widened by the same planner, each kept beside the claim's own form as a corollary** (its words): NF1-S1A — "both clauses follow in four lines from Arith.placeHom_base and Arith.exists_hom_of_isPlaceHom, and are proved in the skeleton, no sorry"; NF1-S1B — "the homomorphism … exists into levelTarget P m at every level m >= 1, by the same argument", with the bound at every level; NF1-S2's first sentence — "needs neither 'squarefree' nor 'd > 1': for any natural d and odd prime p with d a nonzero square mod p, Q(sqrt d) in R has a maximal ideal of its integers with p elements in the quotient — and the same for any finite set of such radicands". A further leaf it names: a number-field instance for the field of a finite set of radicands, which the library lacks.
> — source: data/fs131/claims-NF1.md

Where everything is, in your tree: the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KN2-upper-half-plan.md` (§ D: what the
landing needs; § Stage 5: its drafts for eight ledger rows, each conditional on its leaf landing); the three
implementers' records `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IU1-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IQ1-implementation.md` and
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IV1-implementation.md` — **the last gathers the drafts for the landing in one place** (the audit
block of 52 records, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/iv1/audit-block.txt`; the model table; the three lines for the assumptions
step; its predicted counts). The last landing's record `plans/FS131-LC1-landing.md` on `main` and its receipts
`data/fs131/lc1/gate/` — **its three final receipts are the "previous" side of your digests.**

## Done means

1. **Readback** (a saved stage): the seven quoted lines checked against the claim list; the four records read;
   `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`; the last landing's record, its
   stages 3 to 9. Merge `main` into the branch (it holds the last landing's module, its edits to the audit and
   assumptions scripts, and the front page as filed): trial the merge and name its conflicts first — the audit
   script, the build's lists and `ARCHITECTURE.md` are where they would be; keep both sides. Build.
2. **Docstrings, no statement**: the two rewordings the implementers left for the landing (the stable prime of the
   rational field, described by the proof's own route; the ramified homomorphism, "a ring homomorphism" where it
   says automorphism), and the reader's note on the ramified theorem (its two hypotheses are jointly satisfiable
   only when the divisible radicand is outside the set). The two stale comments in `Proofs/HadwigerNelson/SpectralChain.lean` that still
   call the upper half a hypothesis are **not** edited here — a comment there recompiles everything above it — and
   go into your open gate items.
3. **The registrations**: the 52 records as one block of yours in the audit script, each under the banner its
   axioms put it under (all on the standard three or fewer, by the implementers' prints); if the audit's
   state-reading controls go red on a count, move it by that file's own rule after seeing it red;
   `tools/check_architecture.py` exit 0; the doubled-name check.
4. **What the library assumes**: `./scripts/assumptions.sh --self-test`, then the step. **The module proves a
   statement the library has carried as a named hypothesis** (the upper half): by `LEAN.md` § The gate's rule the
   step fails until that hypothesis leaves the declared list. Make the edits the last implementer drafted, write
   the ledger with the script's own flag, and set what the step reports against its prediction (`rests=23` before
   the last landing made it 26; `inline` 16 to 15, `ours` 23 to 22, `takes` 98 to 106): any difference is a message
   to me.
5. **The vacuity step** and its `--self-test`: how the scan classes every new site; and name by hand the kernel
   model of each hypothesis-shaped headline — the two-colour theorems' is the stable prime of the rational field,
   which the instances file proves; the usable prime's first model in the library is the field of the square root
   of 11 at 7.
6. **Read aloud**, in your record: each headline theorem against its claim line and the dated lines, clause by
   clause — every hypothesis Lean has that the claim lacks and every one the claim has that Lean does not need;
   "into", never "onto", for the homomorphism; and for each exact value, the kernel theorem that holds its other
   half, by name with its axioms. A difference is a message to me before the gate runs.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search
   whose plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test`
   green; `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and
   `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build
   --trace`, under the slot), silent, with its planted control red; the notes check and the records check as the
   last landing ran them. The three digests against `data/fs131/lc1/gate/receipt-axioms-final.log`,
   `data/fs131/lc1/gate/receipt-vacuity-final.log` and `data/fs131/lc1/gate/receipt-assumptions-final.log` (say
   exactly which front-page lines they report stale). Every step's log saved under `data/fs131/lu1/gate/` and named,
   with its wall time and peak memory. Then one line to me, and stop.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LU1)", each with the log line
   it comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once
   (the last landing's `data/fs131/lc1/drafts-slots.py` is the pattern): the audit's and the gate's count lines and
   the assumptions counts in `CLAUDE.md`; a `GATE_CHANGES` entry; the ledger rows this module regrades, from the
   planner's and implementers' drafts checked against what landed (rows 52, 57, 63, 73, 99, 105, 119, 121, 123,
   127 — each only as far as its leaf landed; row 52's two further values are **not** in this module and stay as
   they are); the front page's sentences that say the upper bound is by hand or that only one inequality at the
   field of the square root of 47 is in the kernel; `LEAN.md`'s facts from the four records; the map's three
   corrections. And the open gate items at this landing, by name.
9. **Your record**, stages headed "Stage n — SAVED (FS131-LU1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running or queued. Stopping at a saved stage with
   the gate red at a named check is a good report.

## What is yours to decide

The order of the gate's steps before the final pass; how the records are grouped; the batch size of each build; the
wording of an open gate item. Not yours: any statement; the fast-forward of `main`; a push; anything in another
tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md`, `LEAN.md` and older
landings' records do not apply.** Measured by the last landing here: every whole-library gate step is one `lean`
process of 4.4 to 5.1 GiB; a build in which only small modules are stale is 5.5 to 6.5 minutes at `BATCH=8` to `10`;
a build that recompiles 117 real modules is 47 minutes at `BATCH=2` with 8 GiB in its largest batch; the whole final
pass was 24 minutes. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name lu1 -- <command>`

One file: `--mem 4 --cpus 2`. A gate step that elaborates the whole library: `--mem 8`. A build:
`--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. Implementers share the slot: on
exit 75 wait and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
every log your record cites lives under `data/fs131/lu1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-13 20:39 UTC) — your three notes: retire the entry as you say; the read-aloud is accepted; no cold rebuild

Thank you for all three, and most for the first: you ran the step before editing anything and found that a sentence
this brief, the planner and the last implementer all carried about the tool is not what the tool does.

1. **The assumptions step.** Go on exactly as you describe: the `hUpper` entry out, the two entries for the new
   theorem in, the ledger rewritten by the step's own flag, and the counts the step then prints set beside this
   brief's prediction. *The alternative I weighed:* leave the entry until the tool can find it by itself; declined,
   because the statement is now a theorem and a list of assumptions that still names it tells a reader the library
   assumes more than it does. Confidence: high. Three small things for your record and drafts: the mechanism as you
   found it, with the receipt's path; a corrected sentence for `LEAN.md` § The gate (the clause "or one a theorem
   proves over its own variables" holds of a named hypothesis only; an entry written out in a binder is retired, as it
   is declared, on the landing's own word); and one line for the tooling list saying what a check on such an entry
   would have to read. The brief's sentence was mine to verify and I did not; it is logged as my slip.
2. **The read-aloud.** Accepted as you read it, and your docstring edits with it (a wrong file name and "exhibited"
   where two of three fields only use the prime are what the read-aloud is for; the three files' docstrings are in
   your touches). I have put (a), (b) and (d) into `data/fs131/claims-NF1.md` as dated lines in your words, so the
   claim list no longer says less, or denies more, than the module. On (e): "into" stands; the planner's "onto" in its
   draft for the ledger's row 57 will not be filed, and your draft's wording is the one I file.
3. **The copied compiled files.** Accepted; no cold rebuild before the fast-forward. *The alternative:* recompile
   the 117 modules here (47 minutes on this machine). *Why not:* what I checked — between the tip of the tree that
   gated them and your tip, the sources under `Proofs/`, the root list, `scripts/`, the lakefile, the manifest and
   the toolchain file differ only by your three new modules and three lines of the root list — so every copied file
   was compiled from a source identical to yours, which is what the build's own trace check also said, and the
   publication gate replays every module in an independent kernel run in any case. Confidence: medium-high; it would
   change if any gate step printed a stored statement that differs from your dump of the three modules. Say in your
   record what was copied, from which tree, and how it was compared.

Your touches are unchanged. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
