*Brief for job **J54**: the close of FS-75's minimal instance, `χ(ℚ(√167)²) ≥ 4` in the kernel — a kernel milestone. Opus 5.5, 2026-09-26.
Written by the product owner. **Its templates are J41's brief** (`data/crunch-2026-09-25/briefs/J41-row88-close-math.md`, the close-math
shape) **and M2's kernel close** (`plans/M2-kernel-lane.md` §R-close, the shape of a kernel lane's close): read both, and follow them where
this brief does not differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's close planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner, and the choices the
templates call his come to me by your report.

**If your outputs already exist, you are resuming.** The ticks in `plans/FS75-close-inventory.md` and the `Stage n — SAVED` headings in the
plan's §R-close are your map. Check them against `git log` and continue at the first stage not SAVED.

## The milestone

**The stub** `plans/STUB-three-colour-criterion-kernel.md`; **the plan** `plans/FS75-kernel-167.md` (J52: §G, §PA, §S — the skeleton and
the obligation pass — §P, §M, §X); **the kernel record** `plans/FS75-K-kernel-167.md` (J52K, DONE). It is a kernel milestone, so it has no
§IQ (WORKFLOW 3.3).

**What landed, as the records state it** (read each at exact scope; this list is a pointer, never a source):
- `four_le_chromaticNumber_planeOver_sqrt167` and `four_le_chromaticNumber_planeOver_of_sqrt167_mem` (`Proofs/HadwigerNelson/Instances/SqrtOneSixSeven.lean`),
  standard three axioms, no native purchase: row 79's lower bound in the kernel, with no finite graph.
- Three reusable kernel pieces: `ThreeColour.nonempty_winding` (the three-colour criterion's ⟹ direction in **winding form** — no averaging,
  compactness, Farkas lemma or torsion-freeness), `ThetaCert.Cert.isEmpty_winding` (the tree walk by mutual structural recursion on the
  nested `Tree`), `ThetaPlane.four_le_chromaticNumber_of_cert` (any `d`, `D`, any real field holding `√d`).
- Measured: `Sqrt167.cert_check` by `decide +kernel` in 12.22 CPU s at 5.49 GiB; the job took about 45 minutes against a planned 4.5 hours.
- The mutation audit: both audited hypotheses shown necessary (J52K record §5.1).
- ℚ(√47)'s tree is a `θ`-space tree, not V2's relation-branching format: out of scope, reported.
- The owner re-ran the gate at the milestone's end (build, axioms, vacuity, architecture); the results are in the inventory.

## Outputs

- **The derivation file's entries — only for what is proved outside the kernel.** The kernel theorems are filed by their Lean names in the
  kernel register form M2 used (`plans/M2-derivation.md`: read its entry form and `tools/fs71_ledger_b_check.py`'s `ENTRY_RE` first). Write
  them into **`plans/FS75-derivation.md`**, home `FS75`: the kernel theorems as [kernel] entries with their Lean addresses, and any [hand]
  statement the records prove (for example the necessity of `s j ≠ 0`). Run `python3 tools/fs71_ledger_b_check.py --strict` and read its
  exit status directly; the § B lines are drafted in §R-close, not written into `LEDGER.md`. (It is red now on the 15 FS100 ids, which a
  front-page job fixes; your own ids must parse in the draft check, as `data/fs100/j53/check_b_draft.py` does it — copy that pattern.)
- **The plan's §R-close:** the §G re-read and forward propagation (J52's 16 bears — which paid, which were missed); predictions scored once
  each (J52's §P: P-elem, P-tree, P-price, P-check, P-47fmt, P-60; J50's hunch `leaf-one-is-elementary`); the verdict in four parts; the
  honesty tally (slips, plants that could not fire, the owner's rulings); the ban measurement; **the price lesson** — § What compute actually
  helps already carries "a kernel leaf priced after a fine obligation pass is priced high"; say what this instance adds, if anything, and
  draft it only if it adds.
- **A close-time prior-art gate, time-boxed at about 10 minutes:** is the winding form of the three-colour criterion's ⟹ direction (an
  additive functional on the relation lattice with `Σ_j min(r_j, 2r_j) ≤ 3W(r)`, from a proper three-colouring, with no averaging) in print?
  In the discipline's words: height functions and the winding / rotation cocycle of three-colourings of `ℤ^d` (Chandgotia; Chandgotia–Meyerovitch),
  homomorphisms to `K₃` and their liftings, graph homomorphism obstructions by cohomology. zbMATH API (WORKFLOW 3.2 item 8). Record negatives.
- **The inventory:** every row of `plans/FS75-close-inventory.md` ticked "done" or "declined, with the reason"; add J52K's report items
  (`data/crunch-2026-09-25/reports/J52K.md`), which came after its last row. Read every number from its source.
- **Drafts in §R-close only** (a front-page job applies them together with FS-100's):
  - `LEDGER.md`: **decide** between a new row numbered **119** (FS-100's close took 116–118) and an update of row 79's grade and address,
    in four parts; M2's rows 103–107 are the precedent for kernel ports. Plus the § B lines, and the claim-list line if the result is ours.
  - `CLAUDE.md` lines, **at most 1,500 bytes net** (FS-100's drafts add about 2,400 to 283,904): "What the kernel holds" (the first field-level
    lower bound at an exposed field of the conjecture in the kernel), the FS-75 Paths-forward row, the "Open milestones" line (FS-75's minimal
    instance CLOSED), and the price instance only if it adds.
  - `plans/FRONTIER-STUBS.md` rows for FS-75 and FS-60, following the stub files.
- **Stub re-aims, as files:** FS-75's stub (the minimal instance landed; next the family theorem, row 82, with `nonempty_winding` as its first
  input; ℚ(√47)'s `θ`-space tree needs a different checker) and FS-60's (V2-format certificates are one-line instances through
  `ThetaPlane.four_le_chromaticNumber_of_cert`; `tools/j52_intcert.py` needs `(d, D)` parameters first).

## Rules

- **Touch only:** `plans/FS75-kernel-167.md` (§R-close only); `plans/FS75-derivation.md`; `plans/FS75-close-inventory.md` (ticks and added
  rows); `plans/STUB-three-colour-criterion-kernel.md`; `plans/STUB-quadratic-witnesses-kernel.md`; `data/fs75/j54/`. **Never touch**
  `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, Lean files, `scripts/`, `ARCHITECTURE.md`, job records, or any FS-100
  file. Do not build Lean.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved stage and
  tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01); keep the "would have searched here" log.
- **All novel knowledge is a success** (Kooshi). A kernel port of a known bound is not new mathematics; the winding form may or may not be —
  let the gate say. Do not inflate it.
- **Commits by explicit path**, subjects "J54: stage n"; never amend. End commit messages with your harness's attribution lines. Push after
  each commit (on a ref-lock race, `sleep 4` and retry); never force-push.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J54.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J54 idle; report sent to the owner by SendMessage".

Thank you.
