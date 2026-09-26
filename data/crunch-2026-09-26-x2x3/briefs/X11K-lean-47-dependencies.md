*Brief for job **X11K**: the kernel lane for `χ(ℚ(√47)²) = 5` — start formalizing its dependencies in Lean. Opus 5.5, 2026-09-26. Written by
the product owner at Kooshi's request. Its templates are J52K's brief (`data/crunch-2026-09-25/briefs/J52K-FS75-kernel-167.md`, the kernel
lines) and M2's kernel lane (`plans/M2-kernel-lane.md`, how a result resting on a true-but-unformalized theorem entered the kernel as a
theorem conditional on one named hypothesis, `RealAlgebraicDescent`).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for the ℚ(√47) five-colour chain, in `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read
it in full** — except its clock: you are not bound by the crunch's 06:50 stop, and may run past the crunch's end. **No children:** do not use
the Agent tool, a fork or a workflow (delegation here is one level deep; staffing is Kooshi's budget decision and the owner can only review
work it knows about; if the work outgrows your context, stop at a saved stage and say what is left). **If your record already exists, you
are resuming:** read it, check the last SAVED stage against `git log -- <record>`, and continue at the first stage not SAVED.

## Kooshi's words (2026-09-26, verbatim)

> "If 47 lands at 5, tell all running agents the news, and launch one to start formalizing the dependencies in Lean."

## The landing, as the owner graded it (11:08 UTC)

The crunch's headline rule (close inventory item 8: two minds on each of EF_F and PE-2, and X05V's blind check of SP-Cor) is met, at
this grade — [hand] throughout, nothing in the kernel:
- **EF_F**, in X01D's stronger form EF_F⁺: one derivation (X01D) plus a second mind's checking reading (X01V's stage 4, VALID, after its blind
  stage-2 GAP was withdrawn); a blind second derivation (X12B) is still running.
- **PE-2** (PE-lim): X02D, and X02V blind — both TRUE, given Einsiedler–Lindenstrauss 2021 Thm 1.2, applied to groups `Γ` with every
  finite-index subgroup spanning `L` (X02D's PE-1′, X02V's (★)); PE-1 as first stated is FALSE.
- **SP-Cor**: X05V blind, TRUE, given J45's N1, N2, R-U (R-U verified blind by J46: `plans/FS84-SI-V-verification.md` §2.6) and R88-TCA at
  `S = ∅`; the control at K and ℚ(√11) stops where it must.
- **`χ(ℚ(√47)²) ≤ 5`**: held (row 84); both X01 minds note the "= 5" needs it named.
The close (X09C, from 06:55) audits this ladder; if it finds a break, the owner tells you, and the skeleton is still the product.

## What landed, and where it is written (read each at exact scope; this list is a pointer, never a source)

- The crunch's queue and claim lists: `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2 (the claims verbatim) and the close inventory
  `plans/FS100-x2x3-close-inventory.md` (item 8: the headline rule).
- The derivations and the blind verifications of the crunch: `plans/FS100-X01D-derivation.md`, `plans/FS100-X02D-derivation.md`,
  `plans/FS100-X03D-derivation.md`, and the verifiers' records the queue names (X01V, X02V, X05V). The reports:
  `data/crunch-2026-09-26-x2x3/reports/`.
- The chain from MR to five colours at ℚ(√47): `plans/FS84-SI-D-derivation.md` (§1.2 notation, §5.4 the lemma statements SI-1 to SI-5, RU,
  SP-oi, SP-if, A⁺, B⁺, SP-Cor) and its verification `plans/FS84-SI-V-verification.md`; `plans/STUB-measure-rigidity-three-fields.md`;
  `LEDGER.md` rows 84, 96, 98, 105, 112, 113, 116–118 and the rows they cite.
- The external theorems the chain uses (Einsiedler–Fish 2010; Einsiedler–Lindenstrauss 2021, held at
  `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`; Rudolph, Johnson, Host;
  Furstenberg 1967; Berend): `BIBLIOGRAPHY.md` and the derivation records' prior-art sections.

## The job: start the kernel lane, dependencies first

The goal is the headline `χ(ℚ(√47)²) = 5` in the kernel. The deep measure-rigidity theorems (entropy theory, Einsiedler–Lindenstrauss,
Einsiedler–Fish) are not in Mathlib and are months of formalization, so the lane's first product is **the chain's dependency graph and a
skeleton**, with each external theorem entering as an explicitly named hypothesis (M2's precedent), and the project's own steps formalized
leaf by leaf, cheapest first.

## Stages

1. **The quotation check and the dependency map** (`plans/FS100-K-kernel-47.md` §D). Every lemma on the path from the external theorems to
   the headline, both halves (`χ ≤ 5` and `χ ≥ 5`), one line each: its statement quoted with its address; what it uses; and one status —
   **in the kernel** (the declaration's name; grep `Proofs/` first), **Mathlib has it** (the name, found by `exact?`/grep, never from
   memory), **formalizable now** (with a price in harness tokens), or **external** (to enter as a named hypothesis; quote the paper's
   statement and say what Mathlib lacks). Draw the graph. Save.
2. **The reframe, kernel-sized** (WORKFLOW 3; a kernel milestone has no §IQ): §G, the grokkings and rows that bear on the lane, one line each;
   §PA, a ten-minute check that the combination is not already formalized anywhere (Mathlib, the Lean community's measure-rigidity or
   ergodic-theory projects). Save.
3. **The skeleton**, under `data/fs100/x11k/skeleton/` (never in `Proofs/` while it holds a `sorry`): every signature and full statement,
   `sorry` at every leaf, each external theorem as a named `Prop` whose docstring quotes the paper's statement and address, and the headline
   stated as a theorem conditional on exactly those named hypotheses. It elaborates with `lake env lean`; spec examples; one concrete
   model of each structure hypothesis. **Read the headline aloud against the informal claim** and record it. Save.
4. **Burn down leaves**, cheapest first. **Re-price from the first two leaves actually closed** (§ What compute actually helps). A module
   leaves the skeleton for `Proofs/` only when it is sorry-free and passes the gate; then add it to `Proofs.lean`, to `ARCHITECTURE.md`'s
   module map (`python3 tools/check_architecture.py` green), and each public theorem to `scripts/Axioms.lean`. Save after each module.
5. **The report**, at your budget or when stage 4's cheap leaves are gone: what is in the kernel, what is skeleton, what is external, and the
   price of the rest, as a table.

## Kernel lines (verbatim, every kernel brief)

- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant
  per structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

No `native_decide`, no solver: the ban on finite-witness search holds to 2026-10-01 (keep the "would have searched here" log). **All novel
knowledge is a success** (Kooshi): a leaf named as out of reach, with its reason, is a result; do not lean toward a smaller hypothesis list
than the mathematics supports. Quote statements verbatim. Kill by pid, never by pattern; read exit statuses directly, never through a pipe.
On any unexplained process crash, halt and report.

## Record and paths

Record: `plans/FS100-K-kernel-47.md`, with "Theorems this phase proved". Working files: `data/fs100/x11k/`; exact checks `tools/x11k_*.py`,
each with a planted fault watched firing. **Never edit** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, or another
job's records or tools. Commits by explicit path, subjects "X11K: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4`
and retry), never force-push; end with your harness's attribution lines. **Budget:** about 300k by the harness's count; hand back by 400k.
Report in the standing rules' ≤ 12-line form to `data/crunch-2026-09-26-x2x3/reports/X11K.md`, committed, and by SendMessage to `"main"`.
Final turn text: "X11K idle; report sent to the owner by SendMessage".

Thank you.
