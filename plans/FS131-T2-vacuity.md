# FS131-T2 — the vacuity check: a theorem concluding `≠` or `¬` is not a refutation

Brief: `data/fs131/briefs/FS131-T2-vacuity-negations.md`. Working files: `data/fs131/t2/`.

## Stage 1 — SAVED: the defect reproduced
Plants in `data/fs131/t2/plant-neg.lean`, spliced by `run-with.sh` (`repro-before.log`): `(c : AeColouring 1) … : x + 1 ≠ y`, the same with
`¬ (x = x + 1)`, their variable-`k` twins, and an explicit `P → False`. Result on `main`'s unfixed scan: `declarations=7629
refutations-skipped=324` (319 + 5, so all five plants were counted as refutations), `sites=280` unchanged, `vacuous=0`: the empty carrier raised
no row, the defect as reported. Cause: `carriersOf` and the `refutations` counter read `forallTelescopeReducing … = False`, and `Not P`, `a ≠ b` unfold to `… → False`.

## Stage 2 — SAVED: the fix, the controls, the gate
- `scripts/Vacuity.lean`: `isNegationConcl`, `isRefutation`; `carriersOf` and the refutation counter use `isRefutation`.
  **Decision (in the docstring):** a declaration is a refutation iff the reducing telescope ends in `False` AND the statement as written (non-reducing telescope)
  does not end in `Not`/`Ne`. `P → False` stated so stays a refutation (the arrow is a stated hypothesis, meant empty). `¬ P` / `a ≠ b` stated as such is
  audited: every stated binder is a carrier, and the one binder the unfolding adds (the claim's own `P`) is dropped, since the theorem proves `P` empty
  and `gather` already reads `¬ P` of tracked `P` as evidence of that — keeping it would flag the emptiness proof by its own emptiness. A name that unfolds to
  `False` by some other definition keeps the old reading (skipped); none such shows in the diff.
- Controls 15–20 (`scripts/vacuity-controls.lean`, expects in `scripts/vacuity.sh`): `≠` and `¬` over `AeColouring 1` read VACUOUS; both at variable `k`
  read GENERIC; `≠` over `AeColouring 3` reads UNKNOWN (load-bearing); `P → False` over `AeColouring 1` gives no row. 20 controls, all fire (`selftest-2.log`).
- Negative control watched: with `isNegationConcl` replaced by `false`, 5 controls FAIL by name (`selftest-neg-isneg.log`; 15, 16, 17, 18, 20; the silent one correctly still passes); restored.
- `main`'s scan (`vacuity-main-1.log`, exit 0; full output `vacuity-main-1.full.log`): `declarations=7624 refutations-skipped=45 sites=357`,
  `vacuous=0 stale=0 declared=3 witnessed=17 generic=335 unknown=2`, baseline unchanged (2 entries, both the prior ones). No new VACUOUS, STALE, UNKNOWN.
- Reconciliation: `refutations-skipped` 319 → 45 (274 declarations with a stated `¬`/`≠` conclusion are no longer skipped). Of them 55 make sites: 77 new
  `SITE` rows, 0 removed, all GENERIC (`data/fs131/t2/site-diff.txt`; the 55 declarations are the `not_forces_*`, `not_separated_*`, `not_colorable_*`,
  `UDCert.*`, `Separated.*`, `Forces.not_colorable`, `Plane.AeColouring.dist_ne_one` … families, each over a variable colouring or `Forces`/`Separated` binder). 280 + 77 = 357, generic 258 + 77 = 335. The other 219 have no tracked carrier. `Plane.AeColouring.dist_ne_one` now reads `SITE GENERIC … :: AeColouring k`.

## Theorems this phase proved
None — a tooling job.

## Drafts for the front page
- `CLAUDE.md` § The gate, counts line: replace `declarations=7438 refutations-skipped=313 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`
  (as the file stood at the brief; the scan before this job read `declarations=7624 refutations-skipped=319 sites=280 … generic=258`) with
  `declarations=7624 refutations-skipped=45 sites=357`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=335 unknown=2`.
- `scripts/vacuity-baseline.txt` header counts: `refutations-skipped` 319 → 45, `sites` 280 → 357, `generic` 258 → 335.
- `LEAN.md` § The gate: "plants fourteen controls" → "plants twenty controls". Law clause, after "a declaration concluding `False` is a refutation and is skipped":
  "— `False` as stated, so `P → False` is one and `¬ P` and `a ≠ b` are not: their binders are audited like any other's".
- Frontier line: none (tooling).
