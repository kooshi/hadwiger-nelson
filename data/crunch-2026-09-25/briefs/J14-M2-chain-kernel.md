*Brief for crunch job **J14**, milestone M2 (FS-45, `plans/STUB-chain-theorem.md`), kernel. Opus 5.5, 2026-09-25. Written by J04
(`plans/M2-kernel-lane.md` §S).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for FS-45, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No children: do not use the
Agent tool, a fork or a workflow (delegation here is one level deep; staffing is Kooshi's budget decision and the owner can only review work it
knows about). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.**

## The question, and why now
Put GPT Astra's chain theorem in the kernel: a pair forced equal at `k` colours, chained along unit vectors whose sum times the pair's difference is
1, refuses `k` colours — the spindle's generalisation, with no field extension. Then its first instance, a Moser-free four-chromatic plane
(ℚ(√2,√3)), and the conditional five-level over `K(√7)`. Grade debt: the ban window produced 171 hand theorems and no Lean. **Every outcome
counts** (rule 4): a leaf that will not close, named, is a result.

## The statements (verbatim)
- G55 (`CLAUDE.md`): "a finite graph over F forcing two points at difference δ equal at k colours makes every k-colouring of F² periodic under
  the ideal δR …; if 1/δ = u₁ + ⋯ + u_m is a sum of unit vectors, 1 is a period and χ(F²) > k, witnessed by m chained copies plus one closing
  edge, at most m(n − 1) + 1 vertices, in F itself".
- The Lean statements are the skeleton `data/m2/j04/K1Chain.lean` (elaborates today; 5 declarations closed, 13 named leaves), as refined by
  `plans/M2-kernel-lane.md` §4.4 (§M): the field form for any `S : Subring ℂ`; `G4` over `planeOver (fieldOfRadicands {3, 11})`; the names in
  §M experience item 1.
- The instance: `plans/ASTRA-2026-09-14-derivation.md` T6 and `reference/ChatGPT-local-global-tightness-conjecture/example_qsqrt2_qsqrt3.json`
  ("`δ(1+ω̄+u+uω̄+ū+ūω̄) = 1`", `u = (−1+2i√2)/3`, "`δ(1+ω̄) = 3`", "`1+u+ū = 1/3`"). The K(√7) multipliers: T9 ("`w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²`",
  `w = (−3+i√7)/4`, "`w³+w̄³−3w²−3w̄² = 3/8`").

## Read first, from disk
`plans/M2-kernel-lane.md` §2.1 (the modules and the one trap: a `comap` union does not identify shared points — use the induced graph on the
image set), §3.2 (K1's price), §4.4 (the proof shapes: `Nat.le_induction` over junctions; factor the six-unit sum). `Proofs/HadwigerNelson/Copy.lean`,
`Forcer.lean`, `OneDefect.lean`, `Gadget.lean` (`rhombus`, `rhombusGadget`, `Gadget.transport`, `inter`, `edge`, `not_colorable_of_gadget`),
`Instances/SqrtEleven.lean` (the `planeOver` statement and the four-colouring control).

## Fenced
Nothing is fenced from you.

## Stages
1. The quotation check; C0 (a probability per product, against §P's P-J14a–c); then **price from the skeleton's next two leaves**
   (`not_colorable_chain`, `planeOverSubring`) before anything else, and record the price beside §3.2's (~40k). Save.
2. `Proofs/HadwigerNelson/Chain.lean`: the finite, plane and subring/planeOver forms, the spindle as a spec example (`m = 2`) (~80k). Save.
3. `Instances/SqrtTwoThree.lean`: `rhombusX`, the six units (factored), field membership, `four_le_chromaticNumber_planeOver_two_three`; the gadget
   oracle `eighteen_not_colorable_three` by `decide +kernel` (time it) and `eighteen_colorable_four`; a planted fault (drop one critical edge from
   the oracle's list → `decide` must find a colouring) watched red, then restored (~100k). Save.
4. `Instances/SevenConditional.lean`: `G4` and `five_le_chromaticNumber_planeOver_seven_of_G4`, docstring `VACUITY DECLARED:` with the reason
   (no kernel proof of `G₄` exists; its certificate needs a solver run, banned to 2026-10-01; the spare-colour lemma is why it is not trivially
   false) (~50k). Save.
5. The gate, the module map, the report (~40k).

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: new modules only (a declaration in `SquareClass.lean` rebuilds its dependents); add each to `Proofs.lean`, to `ARCHITECTURE.md`'s module map
(`python3 tools/check_architecture.py` green), and each public theorem to `scripts/Axioms.lean`'s CLEAN section. Measured iteration peak: 3.4 GB
(`--mem 8` is honest for these files; re-measure). No `native_decide`, no solver: the ban holds (keep the "would have searched here" log).
Read each headline statement aloud against its informal claim before the gate.

## Record and paths
Record: `plans/M2-S1K-chain.md`, with "Theorems this phase proved". Working files: `data/m2/j14/`. Budget 350k (harness); hand back by 420k.
Stop rule: at 3 hours or 350k, land what is green; if the six-unit identity is open at 45 minutes, land the chain theorem and the gadget-oracle half
and name the identity as the leaf left. Report (rule 9) to `data/crunch-2026-09-25/reports/J14.md`, SendMessage to `"main"`. Any follow-on job
as a Q-line with its brief file.
