# FS-75 minimal-instance close inventory (opened by the product owner, 2026-09-26, with the plan; WORKFLOW 5 — the owner is its only writer until the close)

*Milestone: FS-75's minimal instance, `χ(ℚ(√167)²) ≥ 4` in the kernel (`plans/FS75-kernel-167.md`). Planner J52; kernel implementer J52K. One line per item with its source; the close planner ticks each done or declined with its reason and reads every number from the source.*

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | bears | G7: `v = (83 + i√167)/84` is the type-M rotation n = 42; named in leaf 3's docstring | §G.1 | open |
| 2 | bears | G18: the theorem is three separately checked leaves composed; no finite graph built | §G.1 | open |
| 3 | bears | G21: the Lean checker derives every constraint from (r, lo, hi); plants must fire for their own reason | §G.1 | open |
| 4 | bears | G30: an inhabitant for the criterion's hypothesis; statements over any AddCommGroup | §G.1 | open |
| 5 | bears | G38: the criterion is the passage from additive to all three-colourings; said in leaf 1's doc | §G.1 | open |
| 6 | bears | G46: named classically (height through K₃'s universal cover, winding cocycle) | §G.1 | open |
| 7 | bears | G49: the gate for a kernel milestone is Mathlib and core; attribution recorded | §G.1 | open |
| 8 | bears | G50: Mathlib's statements read, not recalled (one recalled name, `List.sum_flatMap`, was not held and was corrected) | §G.1 | open |
| 9 | bears | G55: row 103's statement shape; no chain route at 167 at three colours | §G.1 | open |
| 10 | bears | G57: ℚ(√167) is triangle-free, so the Θ route is the only three-colour route | §G.1 | open |
| 11 | bears | G61: the 3-adic barrier and T41's minimality give free negative controls | §G.1 | open |
| 12 | bears | G62: the 36 vectors are a three-layer multilayer `{1, v, z}·U_R`; construction stated | §G.1 | open |
| 13 | bears | G67: first Do-line count at a kernel milestone (7 Do, 9 body) | §G.4 | open |
| 14 | bears | G71: the criterion's ⟹ plus one tree is the target | §G.1 | open |
| 15 | bears | G74: the family theorem (row 82) covers 167; declined here as the stub's next target | §G.1 | open |
| 16 | bears | G79: the winding is the example invariant; the tree is its wanted poster | §G.1 | open |
| 17 | result | the winding form of the three-colour criterion's ⟹ direction; first seven lemmas kernel-checked in the skeleton [hand + kernel-partial] | plans/FS75-kernel-167.md §1.3, §S.3 | open |
| 18 | result | T41's certificate in integer form passes the new checker in the kernel, 19.4 CPU s, 6.04 GB [kernel, scratch module] | §S.0 | open |
| 19 | result | `tinyK4` (S = {1, 2, 3} in ℤ): five-leaf certificate passes; three plants fail, all under `decide +kernel` | §S.2 | open |
| 20 | prediction scored | J50's hunch `leaf-one-is-elementary`: supported and sharpened (averages and compactness not needed either); J52K stage 2 is the test | §P | open |
| 21 | slip | my hand-tallied §G counts were wrong (21/9/50); recounted mechanically at stage 3 and corrected in place | §G.4 | open |
| 22 | slip | first "perturbed leaf" plant could not fire (tripling one multiplier left the leaf refuting); replaced by a zeroed leaf, recorded in the tool | tools/j52_intcert.py | open |
| 23 | slip | the "non-unit" plant was first refused for the wrong reason (a relation failed first); units now checked first, reason tightened | tools/j52_intcert.py | open |
| 24 | tool defect | none outstanding; `tools/j52_intcert.py` (integer scaling, exact mirror of the Lean checker, Lean-literal emitter; six plants, restore verified) is new | tools/j52_intcert.py | open |
| 25 | stub to mint or re-aim | FS-75 stub, shape item 1: the kernel needs only the winding form; averages and compactness belong to the full criterion (FS81-T2's route), not to any relation-branching certificate | §"Edits proposed" | open |
| 26 | stub to mint or re-aim | FRONTIER-STUBS row FS-75: the same line; "J52K running" once launched | §"Edits proposed" | open |
| 27 | owner ruling | No swap to FS-87: FS-75's minimal instance runs (J52K), decided by the card on measurement (leaf 1a–1d closed first time; the certificate checks in 19.4 CPU s, 6.04 GB) | plans/FS75-kernel-167.md §S.0; handoff §7 | open |
| 28 | owner ruling | The headline keeps `four_le_chromaticNumber_planeOver_sqrt167`: the house's word spelling is ambiguous at a multi-digit radicand (`…_two_three` is ℚ(√2,√3), so `…_one_six_seven` would read as three radicands); statement shape checked against `four_le_chromaticNumber_planeOver_eleven` and `…_two_three` — identical form | owner review at J52K's launch | open |
| 29 | owner ruling | ℚ(√47)'s tree as a second instance only after the gate, format checked first (P-47fmt 0.60 not V2's format) — accepted as briefed | data/crunch-2026-09-25/briefs/J52K-FS75-kernel-167.md stage 5 | open |
| 30 | agent slip | J52 ran to 437k harness against a 350k hand-back line | owner's job log | open |
| 31 | result | Owner's gate re-run at J52K's end (2026-09-26): `scripts/slot.py … ./scripts/build.sh` OK — 1,713 modules up to date (build/gate/build/20260926T053429Z-866632.log); `scripts/axioms.sh` OK — 1193 clean, 11 axiom-free, 5 declared purchases, the headline, `nonempty_winding`, `isEmpty_winding` and `four_le_chromaticNumber_of_cert` on the standard three (build/gate/axioms/20260926T053431Z-866750.log); `scripts/vacuity.sh` OK, counts unchanged, baseline 2 (build/gate/vacuity/20260926T053434Z-866933.log); `tools/check_architecture.py` PASS; zero `sorry` in the four new modules | owner, 2026-09-26 | open |
| 32 | result | Owner's reading of the headline against the informal claim: `4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber` — the unit-distance graph on the points with both coordinates in ℚ(√167) needs four colours; the same shape as `four_le_chromaticNumber_planeOver_eleven` and `…_two_three` | owner, 2026-09-26 | open |
| 33 | correction owed | `CLAUDE.md` § Trust ledger's count is stale: 1130 clean → 1193 (the axioms gate says so); the fact audit needs a reviewed gate-count transition ('1130','5') → ('1193','5') with this gate log | build/gate/axioms/20260926T053431Z-866750.log | open |
| 34 | result | `four_le_chromaticNumber_planeOver_sqrt167` and `…_of_sqrt167_mem` (every real field ∋ √167): row 79 in the kernel from T41's 1,050-leaf certificate; `Sqrt167.cert_check` by `decide +kernel` in 12.22 CPU s, 5.49 GiB (literal module 7.12 s) | J52K report; plans/FS75-K-kernel-167.md Stage 4 (added by J54 from the report) | open |
| 35 | result | `ThreeColour.nonempty_winding`: a colouring `A → ZMod 3` proper along `s` carries an additive `W` on `ker(r ↦ Σ r_j s_j)` with `Σ min(r_j, 2r_j) ≤ 3W(r)`; no averaging, compactness, torsion-freeness [kernel] | J52K report; K record Stage 2 | open |
| 36 | result | `ThetaCert.Cert.isEmpty_winding` (mutual structural recursion on the nested `Tree`) and `ThetaPlane.four_le_chromaticNumber_of_cert` (any `d`, `D`, any real `F ∋ √d`) [kernel] | J52K report; K record Stages 3–4 | open |
| 37 | result | both audited hypotheses necessary: without `s j ≠ 0` `nonempty_winding_of_colorable` is false (`s = ![0]` on ℤ) [hand]; without the sign guard the checker accepts `signPlant` while its units carry a winding [kernel] | J52K report; K record §5.1 | open |
| 38 | prediction scored | P-elem, P-tree, P-price, P-check, P-47fmt met; P-60 not run (out of scope) | J52K report; K record §5.5 | open |
| 39 | correction owed | `LEDGER.md` row 79 (+ § B), `CLAUDE.md` "What the kernel holds", § What compute actually helps (one more over-priced kernel phase) | J52K report; K record § Edits proposed | open |
| 40 | stub to re-aim | FS-75 (minimal instance landed; next the family theorem, row 82, `nonempty_winding` its first input) and FS-60 (V2 certificates one-line instances) | J52K report; K record § Edits proposed | open |
| 41 | tool defect | `tools/j52_intcert.py` hard-wired to `d = 167`, `D = 420`; the two other V2-format certificates (`Ld65c8ee8`, `d = 11`; the 60-vector control, P-60) need `(d, D)` first | J52K report; K record §5.4 | open |
| 42 | tool defect | `scripts/vacuity.sh`'s site law does not see `Winding`-typed binders (sites stayed 279); the inhabitant `nonempty_winding_one_two` supplied by hand | J52K report; K record §5.3 | open |
| 43 | slip | the J52K brief's "18 `sorry` sites" counts declarations; there are 19 `sorry` tokens (`iota` carries two) | J52K report; K record §1.1 | open |
| 44 | result | deviations from the J52K brief, each in four parts: §4 in its own module `ThetaPlane.lean`; one docstring in the literal module; the checker guards `pm.1 < path.length`, `ri < rels.length`, `lo − 1 ≤ hi` unused by the soundness proof (kept as well-formedness) | J52K report; K record Stages 3–4 | open |
| 45 | held decision | run the consumer on the two other V2-format certificates (ℚ(√11): a second kernel route to row 73; the 60-vector control: P-60)? J52K: low priority, neither new mathematics; default nothing runs | J52K report, HELD | open |
| 46 | held decision | FS-75's next target, the family theorem (row 82; FS81-T5, needing FS81-T2's inverse limit and C1(5)'s cells), is a milestone of its own: Kooshi's choice | J52K report, HELD | open |
| 47 | correction owed | `CLAUDE.md` § The gate's vacuity counts are stale: `declarations=7051 refutations-skipped=304` → `declarations=7279 refutations-skipped=309` (sites and verdicts unchanged); `scripts/vacuity-baseline.txt`'s header if it records them | build/gate/vacuity/20260926T053434Z-866933.log lines 336–337 (added by J54) | open |
| 48 | ban measurement | the "would have searched here" log across J52, J52K and J54 | plan §R-close (added by J54) | open |
| 49 | prior-art debt | the close-time gate on the winding form of the criterion's ⟹ direction | plan §R-close (added by J54) | open |
