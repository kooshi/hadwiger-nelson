# FS131-T1 — the vacuity scan tracks the backlog's plane carriers

Brief: `data/fs131/briefs/FS131-T1-vacuity-carriers.md`. Working files: `data/fs131/t1/`.

## Stage 1 — SAVED: the defect reproduced, the structures surveyed
- `main` built first (`./scripts/build.sh` under the slot: 440 of 440 batches, 10 modules rebuilt, 8m23s; `data/fs131/t1/build-main.log`).
- Reproduction (`data/fs131/t1/plant-ae.lean` spliced by `run-with.sh`; `repro-before.log`): the planted
  `theorem (c : Plane.AeColouring 1) (x : ℂ) : x = x` and its variable-`k` twin raised **no site and no row**:
  `declarations=7626` (7624 + 2 plants), `sites=279` unchanged, `vacuous=0`. The log does contain
  `EVIDENCE EMPTY ...instIsEmptyAeColouringOfNatNat_1 :: IsEmpty (AeColouring 1)`, so the evidence was gathered and no
  site was made: the defect is `carrierOf?` / `trackedProps`, not the evidence.
- Survey of `Proofs/HadwigerNelson/Plane/` (decisions and reasons are in `trackedProps`' docstring, the model being `UDCert`'s):
  IN `AeColouring` (a type whose emptiness is a theorem), `ArcMap.Valid`, `ArcMap.NonSiamese`, `ArcMap.Simple` (Prop carriers, refutable at a
  concrete map; `GENERIC` at a variable map). OUT `ArcMap k`, `Arc` (data), `Covers`, `IsPlaneMap`, `IsTile`, `Siamese`, `IsJordanDomain`, `coloursAt`
  (satisfiable by `const`), `UnitPairsNull`, `IsMUA` (predicates of a set variable, always generic).

## Stage 2 — SAVED: the fix, the controls, the gate
- `scripts/Vacuity.lean`: four names added to `trackedProps`; the docstring beside it holds the decisions and the four-step
  registration note for a later wave; `isGeneratedDecl` skips a structure's machine-written API (constructor, recursors, `casesOn`,
  `noConfusion`, `noConfusionType`, `ctorIdx`, projections) where a site would be made — without it the first run added 13 sites, 12 of them
  this API (`vacuity-main.log`), and every further tracked structure would add a dozen. They stay counted in `declarations=`.
- Controls (`scripts/vacuity-controls.lean`, expects in `scripts/vacuity.sh`): the empty `AeColouring 1` reads VACUOUS; `AeColouring k` reads
  GENERIC (read from `SITE` rows through a new `expect_site`, since GENERIC is never in FLAGGED); `AeColouring 3` reads UNKNOWN (load-bearing);
  `ArcMap.Valid` of the concrete one-colour map, refuted by `planted_not_valid` (the refutation stays silent), reads VACUOUS; `Valid` at variable
  `F` reads GENERIC; a user-written `def : AeColouring 3 → AeColouring 3` reads UNKNOWN (the filter is narrow). 14 controls; the old seven still fire.
- **Verdict law for a proved emptiness that is not declared: VACUOUS** (STALE is a *declaration* whose claim is false; DECLARED is an empty carrier
  with a reason). `AeColouring 1` planted reads VACUOUS.
- Negative controls watched: a mistyped `AeColourin` in the list made 4 controls FAIL, naming them (`selftest-neg-typo.log`); a mistyped
  `ArcMap.Valid_` made 2 FAIL (`selftest-neg-valid.log`); both restored. Final `--self-test`: 14 ok, exit 0 (`selftest-3.log`).
- `main`'s scan (`vacuity-main-3.log`, exit 0): `declarations=7624 refutations-skipped=319 sites=280`, `vacuous=0 stale=0 declared=3 witnessed=17
  generic=258 unknown=2`. Reconciliation against the recorded `sites=279 generic=257`: exactly one new site,
  `SITE GENERIC HadwigerNelson.Plane.chiM0_le :: AeColouring k` (a theorem over a tracked structure at a variable `k`). No new UNKNOWN, no
  verdict change, the baseline unchanged (2 entries). `AeColouring.dist_ne_one` makes no site because its conclusion `dist x y ≠ 1` is
  `… → False` under the reducing telescope, so the existing law reads it as a refutation (see the report).

## Theorems this phase proved
None — a tooling job.

## Drafts for the front page
- `CLAUDE.md` § The gate, the counts line: replace
  `declarations=7624 refutations-skipped=319 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`
  with `declarations=7624 refutations-skipped=319 sites=280`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=258 unknown=2`.
- `scripts/vacuity-baseline.txt`'s header counts (whichever line holds `sites=279`, `generic=257`): the same two numbers, 279 → 280 and 257 → 258.
- `LEAN.md` § The gate, the `--self-test` sentence: "plants seven controls" → "plants fourteen controls (the seven original, and seven for
  `AeColouring` and `ArcMap.Valid`)"; and add to the tracked-carrier sentence that the list is `trackedProps` and a later wave registers by the note
  in its docstring.
- Frontier line: none (tooling; no value moved).
