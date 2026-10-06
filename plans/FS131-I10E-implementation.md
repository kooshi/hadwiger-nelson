# FS-131, wave 10 — implementation record: the floor at 128 (`Floor128`, the bridge `charSum_128_ge`)

*Job FS131-I10E (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10e` (cut from the second planner's `330d2f48`, fast-forwarded
at launch to `a14f9ab0`, FS131-I10D's hand-back: the brief's Amendment 1). Brief: `data/fs131/briefs/FS131-I10E-wave10-second.md`.
Plan: `plans/FS131-w10-kernel-plan.md` §§ 7.1, 7.2, 9.3, 9.4.*

**What I may change, and what I may not.** Mine: the proof of the one open leaf of `Proofs/HadwigerNelson/Arith/Floor128.lean`,
`charSum_128_ge`; new helper declarations in that file, under names no other module declares (all in the namespace
`HadwigerNelson.Floor128`, which only this module opens); the file's import list; a docstring extended, never rewritten; a block
"FS131-I10E" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i10e_*.py`; `data/fs131/i10e/`;
the report. Not mine: any statement, hypothesis, conclusion or definition of the skeleton — the certificate (`clmul`, `P`, `qBig`,
`a4`, `b4`, `a128`, `b128`, `step`, `pass`, `counts`, `countsOk`) and its five kernel checks stay as they are; a new `axiom`;
`native_decide`; the wave's other files, `NormOneTarget` and `FloorPlanes` among them (their theorems `card_normOne`,
`card_filter_pow_eq_one`, `exists_mulShift_eq` are cited, never declared again); `ARCHITECTURE.md` (not in the brief's `touches`: an
edit it needs is drafted below); the planner's record; any landed module; `main`; the gate; another branch.

## Theorems this phase proved

*(filled at the stage that proves them; at Stage 1: none yet.)*

## Stage 1 — SAVED (FS131-I10E): the readback, and the branch as given

**The brief's quotations** (standing rule 3), by script (`data/fs131/i10e/logs/quotations.sh`, `grep -F` of each quoted string in
the file the brief names; output `data/fs131/i10e/logs/quotations.txt`): **fourteen of fourteen match** — `CLAUDE.md`
§ Counter-priors; inventory items 500, 503, 509, 510 (`plans/FS131-close-inventory.md` on `main`); the two statements of
`Floor128.lean`; the plan's §§ 7.1, 7.2, 9.3, 9.4 headings; the amendment's three statements (`exists_mulShift_eq` in `FloorPlanes`,
`card_normOne` and `card_filter_pow_eq_one` in `NormOneTarget`). The script's control (a planted string that is in no file) reads
missing, as it must.

**Read whole**: the brief with its amendment; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; the plan's Stages 6–9 (§§ 7.1, 7.2, 9.1–9.6 whole; § 7.3–7.4 for the sibling row); `Floor128.lean`;
`NormOneTarget.lean`; `FloorPlanes.lean` lines 296–375 (the three theorems the amendment names, with `exists_ringHom_pow`); the
definitions `normOneCayley`, `TargetFloor`, `StandingFloor` of `StandingFive.lean`; FS131-I10D's record (its theorems). **The row's
sentence**: G56 (`.claude/skills/grokkings/SKILL.md`), "Q = 128 has floor 8 (`data/fs54/char2/`)", which the plan's § 7.2 reads as
"U₁₂₈'s Hoffman floor is 8".

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, 454 of 454
batches, 5 modules rebuilt, 8 m 22 s (`data/fs131/i10e/logs/build-0-as-given.log`). **Seventeen `sorry` leaves, one mine**:
`Floor128` 1 (`charSum_128_ge`), `MajorityVote` 1, `NegCircleModel` 2, `ProductFactor` 1, `StandingFive` 9, `StationaryRatio` 3 —
counted as distinct `file:line` warnings of the build's full output. It agrees with the amendment's count.

**The statement checker**: `tools/fs131_i10e_statements.py` (FS131-I10D's checker, copied under this job's prefix), base
`a14f9ab0`: every base declaration of `Floor128.lean` — 14 chunks (the six certificate literals are one chunk), each compared
verbatim, a definition with its body, a docstring verbatim or extended — is present; `--self-test` plants a statement fault, a
definition fault and a docstring fault, each caught, and a docstring extension, passed and listed
(`data/fs131/i10e/logs/statements-0.txt`).

**The route, decided before the first leaf, and where it leaves the plan's** (the plan's children B1–B6, § 7.2):

- B1 (the code), B2 (a root, from `clmul_P_qBig`), B4 (the register), B6 (the sum) as planned. B5's second half and B6's count are
  now cited (`exists_mulShift_eq`, `card_normOne`), so `Floor128` gains the import `Arith/FloorPlanes`.
- **B3 (the basis) by the register's orbit, not by the two Bézout identities.** On codes, `step` has the point 1 of period exactly
  16383 (`counts_ok`'s first clause; `order_checks`; `16383 = 3·43·127`), and it keeps `[1, 2¹⁴)`; so the orbit of 1 is every
  non-zero code below `2¹⁴`. A non-zero code `n < 2¹⁴` is then some `step^[j] 1`, whose value at the root `g` is `gʲ ≠ 0`. That
  is the basis statement (`φ_g(n) = 0 ∧ n < 2¹⁴ → n = 0`), with no subfield, no minimal polynomial and no degree count; it also
  hands B4 and B6 the two facts they read (the powers `gʲ`, `j < 16383`, are distinct and are every non-zero element). **A
  shorter-route note, not a defect** (the amendment's item 3): `bezout4` and `bezout128` stay kernel theorems of the file and the
  bridge does not read them — the register's exact period already says `P` is primitive, which is more than irreducible.

**Draft for `ARCHITECTURE.md`** (not in my `touches`; slot: § 3, the row `Arith/Floor128`, its Imports cell, which reads
`` `Arith/NormOneTarget` ``): it becomes `` `Arith/NormOneTarget`, `Arith/FloorPlanes` `` once the bridge cites
`exists_mulShift_eq`. Until that cell is edited `tools/check_architecture.py` reports one import mismatch on this branch, this row.

Token count at this stage: own estimate ≈ 140k of the harness's (the launch context is most of it).
