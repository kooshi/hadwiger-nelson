*Brief for job **J52K**, FS-75's minimal instance (`plans/STUB-three-colour-criterion-kernel.md`), kernel. Opus 5.5, 2026-09-26. Written by
J52 (`plans/FS75-kernel-167.md` §S). Sized at about 2–2.5 hours and 300k harness tokens.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for FS-75's minimal instance, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No
children: do not use the Agent tool, a fork or a workflow (delegation here is one level deep; staffing is Kooshi's budget decision and the owner
can only review work it knows about; if the work outgrows your context, stop at a saved stage and say what is left). **If your record already
exists, you are resuming: read it and the brief, check the last SAVED stage against `git log -- <record>`, and continue at the first stage not
SAVED. Redo nothing saved.**

## The question, and why now
Put `χ(ℚ(√167)²) ≥ 4` (`LEDGER.md` row 79) in the kernel, with no finite graph: a proper three-colouring of the plane pulls back to a colouring
of an abelian group proper along 36 unit vectors; such a colouring carries a **winding** (an additive functional on the relation lattice bounded
below by the least rise); and a 1,050-leaf relation-branching certificate leaves no winding. ℚ(√167) is the conjecture's widest gap (predicted
≥ 6, proven 4), and no field-level lower bound at either exposed field is in the kernel yet. The criterion and the checker are reusable: every
`Θ₃` certificate in V2's format becomes a one-line instance. **Every outcome counts** (rule 4): a leaf that will not close, named, is a result.

## The statements (verbatim)
- The target, from the stub's shape item 4: "**Compose:** `Θ₃(S) = ∅` ⟹ `addCayley S` not 3-colourable ⟹ `3 < χ(ℚ(√167)²)`, stated as
  `four_le_chromaticNumber_planeOver_sqrt167`, standard three axioms, no native purchase."
- The Lean statements are the skeleton `data/fs75/j52/skeleton/ThreeColourKernel.lean` (elaborates today with `lake env lean`, 3.6 CPU s,
  3.39 GB; **18 `sorry` sites**; leaf 1's children 1a–1d, seven lemmas, are already closed there, and the headline type-checks over the rest).
  The headline, verbatim:
  ```lean
  theorem four_le_chromaticNumber_planeOver_sqrt167 :
      4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber
  ```
  and the two reusable theorems: `ThreeColour.nonempty_winding (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) : Nonempty (Winding s)`
  and `ThetaCert.Cert.isEmpty_winding (c : Cert) (h : c.check = true) : IsEmpty (Winding c.gen)`, with the general consumer
  `ThetaPlane.four_le_chromaticNumber_of_cert`.
- The mathematics: `plans/FS75-kernel-167.md` §1.3 (why the certificate needs only the winding) and §S.3 (every child, with its route).

## Read first, from disk
`plans/FS75-kernel-167.md` §1.3, §S (all of it: S.0 the price, S.1 placement, S.3 the obligation pass, S.4 alternatives) and §M.
`data/fs73/records/verify-P3b-q167.md` §1 steps 1–3 and §2 (the certificate's semantics). `tools/j52_intcert.py` (the emitter and the exact
mirror of the Lean checker; run `--self-test` first). `Proofs/HadwigerNelson/Chain.lean` (`norm_eq_one_of_sq`), `SquareClass.lean`
(`fieldOfRadicands`, `sqrt_mem_fieldOfRadicands`), `UnitDistance.lean` (`unitDistance_adj`, `add_one_le_chromaticNumber_iff_not_colorable`),
`CayleyCertificate.lean` (the house checker pattern).

## Fenced
Nothing is fenced from you. Frozen and read-only: `tools/fs73*check*.py`, `tools/fs73v2_check.py`, `data/fs73/`.

## Stages
1. The quotation check; C0 (a probability for each of §P's P-elem, P-tree, P-price); then **price from the first two open children actually
   closed** — 1e (`wsum_word`, `length_word`, `word_add_perm`; route: `List.perm_iff_count` with `count j (word v) = v j`, and
   `Finset.sum_list_map_count`) and 1f (`wind_shift` and its siblings) — and record the price beside §S.0's (~40k). Save.
2. `Proofs/HadwigerNelson/ThreeColour.lean`: §1–§2 of the skeleton sorry-free — 1g `nonempty_winding` by `W r := wind 0 r⁺ r⁻ / 3` with
   `3 * W r = wind …` (divisibility from `wind_cast` and `ZMod.intCast_zmod_eq_zero_iff_dvd`), additivity through a lemma
   `wind_eq_of_sub_eq` (balanced pairs with the same integer difference have the same winding, by `wind_add_diag` twice) and `wind_add`, the
   bound from `minRise_le_wind`; `nonempty_winding_of_colorable` through `addCayley_adj`; the inhabitant `properAlong_one_two` (~80k). Save.
3. `Proofs/HadwigerNelson/ThetaCert.lean`: §3 sorry-free — the list–vector bridges (`vecOf l j := l.getD j 0`; `addL` pads, so no length
   hypothesis), the relation lemma from `Cert.check`, the total extension `W.ext r := if h : r ∈ ker then W ⟨r, h⟩ else 0`, the path invariant
   (every constraint's coefficient in the kernel, of length ≤ m, and holding), coverage of `childCons`, the leaf lemma as **one** induction over
   the multiplier list with a tupled conclusion (`Q` in the kernel ∧ `Q.length ≤ m` ∧ `W.ext Q ≤ P`), and the walk as **mutual structural
   recursion** on the nested `Tree` (`checkTree_sound` / `checkKids_sound`, the latter carrying "some constraint in the remaining list holds";
   the planner checked that Lean 4.32 accepts nested structural recursion in mutual theorems on this `Tree`); `tinyK4` and its three plants as
   spec examples (~90k). Save.
4. `Proofs/HadwigerNelson/Instances/SqrtOneSixSeven/Cert.lean` (the literal, emitted by `python3 tools/j52_intcert.py --emit-lean <out>
   data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`, renamed `cert` in namespace `Sqrt167`; `--` comments only) and
   `Instances/SqrtOneSixSeven.lean` (§4–§5: `iota`, `iota_mem`, `norm_iota`, `properAlong_of_colorable`, `four_le_chromaticNumber_of_cert`,
   `cert_units` and `cert_check` by `decide +kernel` — **time it: min of three, CPU seconds, peak RSS; §S.0 measured 19.4 s and 6.04 GB on the
   skeleton**, and the headline). A planted fault on the real certificate (one relation's entry changed; `check` must return `false` by
   `decide +kernel`) watched red, then removed (~60k). Save.
5. The gate, the module map, the report (~30k). If time and budget remain after the gate, and only then: **ℚ(√47)'s tree** (FS73-T26) —
   first check its format against `tools/fs73v2_check.py`'s; if it is V2's relation-branching format, a one-line instance through
   `four_le_chromaticNumber_of_cert` with `d = 47`; if it is a `θ`-space tree, report that and stop (a different checker, out of scope).

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: new modules only; add each to `Proofs.lean`, to `ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py` green), and each
public theorem to `scripts/Axioms.lean`'s CLEAN section. `set_option autoImplicit false` is redundant in `Proofs/` (the lakefile sets it); it is in the
skeleton only because `lake env lean` skips the lakefile. Measured iteration peak: 3.4 GB for the skeleton, 6.0 GB with the literal (`--mem 12`
is honest; re-measure). No `native_decide`, no solver: the ban holds to 2026-10-01 (keep the "would have searched here" log; checking and
transforming the existing certificate is in, producing a new one is out). Mutation audit before the gate: delete `hs` from
`nonempty_winding_of_colorable` and the sign guard `decide (0 ≤ pm.2)` from `leafOk` once each, and confirm the proofs break. Read the headline
statement aloud against the informal claim before the gate. Kill by pid, never by pattern; read exit statuses directly, never through a pipe.
On any unexplained process crash, halt and report.

## Record and paths
Record: `plans/FS75-K-kernel-167.md`, with "Theorems this phase proved". Working files: `data/fs75/j52k/`; exact checks `tools/j52k_*.py`, each
with a planted fault watched firing. Budget 300k (harness); hand back by 380k. **Stop rule:** re-price from the first two children actually
closed (stage 1); if the total is heading past three hours, or the nested-`Tree` soundness resists three attempts, land what is green (leaf 1
alone is a result: the criterion's ⟹ in winding form, reusable) and report the leaf left, named. Report (rule 9) to
`data/crunch-2026-09-25/reports/J52K.md`, SendMessage to `"main"`. Any follow-on job as a Q-line with its brief file.
