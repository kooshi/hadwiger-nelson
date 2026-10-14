# FS131-KR1 — the five-colour chain: the rest of its map, read, priced and typed as far as reached

*de Bruijn, the planner (the ninth on this chain). Brief: `data/fs131/briefs/FS131-KR1-chain-map.md` (on `main`). Branch
`fs131-wkr`, cut from `fs131-wk8b` at `fec557c9a`, in the tree `.claude/worktrees/fs131-wch`. Working files:
`data/fs131/kr1/`. Report: `data/fs131/reports/FS131-KR1.md`.*

## Theorems this phase proved

None yet (a planning job). Updated at each saved stage.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kr1_readback.py` reads every block quotation of the brief (`> …` lines followed by `> — source: <path>`) and
requires the quoted text, character for character, as one whole line of its source on `main`'s working tree
(`/home/kooshi/source/lean-dir`). Output `data/fs131/kr1/readback.out`: **5 quotations, 5 IDENTICAL** — W2
(`data/fs131/REQUEST-2026-10-13.md` l. 4), NF2-NC (`data/fs131/claims-NF2.md` l. 42), the dated line "takes eight, not nine"
(l. 49), inventory items 791 (l. 9228) and 811 (l. 9248) of `plans/FS131-close-inventory.md`. Control
(`--plant`, `data/fs131/kr1/readback-plant.out`): one character changed in each quotation in memory; **5 of 5 reported**,
exit 0 as the control requires.

One observation, not a mismatch: item 791 is stamped "2026-10-14 12:45 UTC logged" and item 811 "2026-10-14 09:54 UTC by the
clock"; the clock read 09:56 UTC when this job started. 791's stamp is later than 811's although 791 precedes it. Commit
`1649420e0` ("a coordinator's slip on times corrected") may concern it; recorded for the coordinator, nothing rests on it.

### 1.2 The seven modules' rows, restated from the architecture (`plans/FS131-KN3-chain-plan.md` § Stage 6, worktree copy)

| id | the architecture's row (module; leaves; discharges; needs; status then) | its draft claim list, read |
|---|---|---|
| M2 | Herglotz–Bochner; Bochner for an induced topology; leaves 3, 11; `BochnerHerglotz`, `BochnerOn`; needs nothing; "not read (ruling 4)" | two statements: `BochnerHerglotz G` for every countable `AddCommGroup G`; `BochnerOn t` for `t` induced by a homomorphism with dense range into an LCA group, "in the form M10 reads". Since item 757 the uniqueness clause is a theorem at countable `G` (`Rigidity/DualGroup.measure_eq_of_fourier`, a typed leaf): M2's first statement is the **existence half** |
| M3 | Markov–Kakutani; leaf 4; `InvariantMeasureOnClosed`; needs nothing; "not read (ruling 4)" | one statement: `InvariantMeasureOnClosed F` "for every `F` with `unitRing F` countable" |
| M10 | N1 (a) at `S = ∅`: the continuity group is `T + A`; leaf 11; N2 at `T + A`; needs C0; "not read" | (1) the topology `τ′_∅` on `unitRing F` and `contChars τ′_∅ = TA F`, both inclusions; (2) `spectral_carried_iff` read at `TA F` over `BochnerOn τ′_∅` (M2) |
| M11 | A⁺ at `S = ∅`; leaf 12; `(chainInterface F).APlusOfR88`; needs M10, M2; "not read" | one statement: `R88TCA → APlus0` at `T + A` |
| M12 | the count; `m₁(ℝ²) < 1/4` declared; `[S9]`; leaves 7, 9, 10; `(chainInterface F).Count`; needs M9; "not read; its own planner" | (1) `TCA F → R88TCA`; (2) `m₁` and `[AmbrusEtAl2023]` Thm 1 "to type and declare"; (3) `[S9]` "to type" |
| M13 | CLS, with EN1-UQ4 at the dyadic targets; leaf 8; `5 ≤ localBound F → TCA F`; needs the `Arith/` floors; "not read" | (1) `5 ≤ localBound F → TCA F`; (2) EN1-UQ4 at `Q = 2^f ≥ 256`, with the exact spectra at 64 and 128 |
| M15 | the instances, `ℚ(√47)` first; the final statement; leaf 23; row 121's sentence; needs all; "not read" | (1) `NumberField` for `ℚ(√47)`, `5 ≤ localBound` there, **and `NoRamifiedStableDyadic` there**; (2) `χ(ℚ(√47)²) = 5` |

**A correction owed to M15's draft claim list** (not a statement defect; the draft is a draft): its item 1 still lists
`NoRamifiedStableDyadic` "there" as a needed model. Since FS131-KN6 (the dated line quoted in the brief) the headline reads
the scope from `5 ≤ L(F)` (`noRamifiedStableDyadic_of_three_le_localBound`), and since FS131-K8B1 EF⁺ is typed with no scope
(`zeroEntropyCarried_of_numberField`). So M15 needs no scope model; the clause leaves its draft (§ the drafts, at the end).

### 1.3 The headline's eight hypotheses: who discharges each, and on which entry it rests

The headline is `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` (`Rigidity/ChainAtTA.lean` l. 529), read in the
source; its eight hypotheses' definitions read in `SpectralChain.lean` (ll. 114–126, 161–193, 301–351) and
`Rigidity/ChainAtTA.lean` (ll. 364–403).

| hyp. | its type (as the source states it) | discharged by | rests on (derivation entry, address) |
|---|---|---|---|
| `hBH` | `BochnerHerglotz (unitRing F)` | **M2**, existence half; uniqueness: `DualGroup.measure_eq_of_fourier` (M4, typed) | classical: `[Rudin1962]` 1.4.3 (not held, not read); no entry of ours |
| `hL1` | `InvariantMeasureOnClosed F` | **M3** | classical: `[Kakutani1938]` (not held); no entry of ours |
| `hCount` | `(chainInterface F).Count` = `TCA F → (chainInterface F).R88TCA` | **M12** | EN1 § 8.1 row 8: R88-TCA (`plans/R88-derivation.md` l. 161) with R88-TC-ext (l. 114), -TC-reg (l. 130), -TC-count (l. 144), -TC-Yp / -J28V-3 (ll. 135, 140), -TC-tab (l. 152); FS100-TCA (`plans/FS100-derivation.md` l. 291); FS100-CX (l. 293) |
| `hAP` | `(chainInterface F).APlusOfR88` = `R88TCA → APlus0` | **M11**, over **M10** (N1 (a), N2 at `T + A`) | EN1 § 8.1 rows 2, 4, 5, 6, 7: J45 N1 (a), N2, SI-1 to SI-4, A⁺ with remark (ii) (`plans/FS84-SI-D-derivation.md` ll. 105–113, 126–135, 145–162, 240–250); EN1-APLUS (`plans/FS131-EN1-derivation.md` § 3) |
| `hPE` | `EntropySplit F` | M5–M7 (planned by others; `entropySplit`, `Rigidity/EntropySplitMax`) | EN1 row 11: FS100-PE2 |
| `hEF` | `NoRamifiedStableDyadic F → ZeroEntropyCarried F` | M8 (`zeroEntropyCarried_of_numberField`, over `TateModel F`, lane T) — typed with no scope | EN1 row 12: FS100-EFP |
| `hCLS` | `5 ≤ localBound F → TCA F` | **M13** | EN1 § 8.1 row 9: FS100-CLS (`plans/FS100-derivation.md` l. 285), -DLP (l. 287), -G27 (l. 289); EN1-UQ4 (§ 7.3) |
| `hRow99` | `localBound F ≤ 4 → localBound F ≤ χ(F²)` | a theorem on `main` (FS131-LJ1: `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`); not on this branch's ancestry | `LEDGER.md` row 99 |

So five of the eight are this job's modules (M2, M3, M11 with M10, M12, M13), and M15 composes the instance.

## Drafts for files I do not write

*(filled at the stages that produce them)*
