JOB FS131-KRU1 — DONE   harness≈570k (the session counter's fall; own≈200k of context)

RESULT:
- Lemma C′, `Rigidity.unitRing_eq_stableIntegers` (the roadmap's statement as typed, `F` now implicit): planned, ≈ 420 lines with its common step. Three of the previous map's eight leaves are already kernel theorems on `main` (FS131-ICL2: `Counting.exists_normOneL_residue(s)`, Hilbert 90 mod `P^m` and the joint CRT lift; the division step inside `Counting.exists_mem_nsmul_of_resR_eq_zero`). Local generation needs no counting, no Hensel count and no idempotents. The Cayley elements `(a + θ)/(a + σθ)`, with `a` fixed by conjugation, generate any finite ring with an involution that moves some `θ` by a unit, and that includes the product `∏_{P ∈ Φ} 𝓞 ⧸ P^m` directly (`Rigidity/NormOneGen`).
- Per-prime form (the coordinator's (3)): `exists_eq_add_mul_of_mem_stableIntegers` says `R → O′/nO′` is onto wherever no stable prime holding `n` is ramified. It lies on the head statement's path. Its corollary `exists_two_pow_mul_mem_unitRing` holds at every real number field with no scope: every `x ∈ O′` has `2^a·x ∈ R`. Marginal cost ≈ 37 lines, 14 % of its module, under the fifth.
- Components clause (C8) at every real number field, no outside theorem (ruled route, item 1040): `infinite_connectedComponent_planeOver F` and `not_connected_planeOver F`, through `Rigidity.nonempty_stablePrime F`. The route ([hand], one mind; the congruence step checked by the coordinator): a usable prime of degree one from the sign change of a minimal polynomial at its real root, a prime factor `q ≡ 3 (mod 4)` of a homogeneous value `≡ −1 (mod 4M)`, then Kummer–Dedekind. The stable prime above it comes either from FS131-ICS1's bridge (one line, if it lands first) or, as fallback on `main` today, from `Arith.placeHom_base` with row 105's prime inversion (≈ 45 lines). The variant at fields with an exhibited stable prime is `infinite_connectedComponent_planeOver_of_stablePrime`.
- Dichotomy (the coordinator's (2)): `connected_or_infinite_planeOver` holds at every subfield of ℝ, and `connected_planeOver_iff_isEmpty_stablePrime` at every real number field. Marginal cost ≈ 50 lines, 26 % of its module (5 % of the job), over the fifth, so it is left out of the implementer's brief unless ruled in.
- Also planned: `localBound_lt_top` (`L(F) < ⊤` at every real number field, ≈ 15 lines).
- Price: ≈ 970 lines of proof over 40 `sorry` leaves in five new modules (≈ 925 if FS131-ICS1 lands first). No outside theorem, no `native_decide`. The skeleton builds: `./scripts/build.sh` under the slot, "build: OK — 1100 of 1100 batches, 6 module(s) rebuilt, 5 module(s) with warnings, 33m5s", exit 0; the only warnings are the 40 `sorry`s (`build/gate/build/20261016T201711Z-1223591.log`, copied to `data/fs131/kru1/build-full.log`). Modules: `Rigidity/NormOneGen`, `Rigidity/UnitRingEq`, `Rigidity/UsablePrime`, `Rigidity/PlaneComponents`, `Instances/UnitRingModels`; ARCHITECTURE rows and `Proofs.lean` imports in the same commits; `tools/check_architecture.py` PASS.
- No statement defect. Theorems this phase proved: none (a planning job).

RECORD: plans/FS131-KRU1-ring-plan.md (branch fs131-kru1, worktree .claude/worktrees/il5)   COMMITS: bb2ed0098, c899b83f6, 72e818b66, 67cae9a0b, 7ad533b39, e20f1ff85, 556e5b50d, and this report's commit

INVENTORY:
- result — Lemma C′'s kernel route: Cayley generation in the product ring plus the held joint lift. ≈ 420 lines, not the previous ≈ 700 — record § 2.1, § 3.5 module 1–2.
- generalization — the per-prime onto statement and its "R and O′ agree once 2 is inverted" corollary at every real number field, no scope. This is a wider kernel statement only: FS91-J07-4 already says it — record § 1.3 F4, § 2.2.
- result — the components clause is equivalent, at a number field, to the existence of a stable prime. The plane over any subfield of ℝ is connected or has infinitely many components — record § 1.3 F2, § 2.3.
- result — every real number field has usable primes of degree one outside any finite set, so `F(i)` has a stable prime and `L(F) < ⊤`, with no Chebotarev ([hand], one mind; kernel pending) — record § 1.3 F3, § 2.4.
- correction owed — LEDGER row 105's "(a stable prime exists by Chebotarev)", at the landing; replacement drafted — record § 3.7 item 3.
- correction owed — FS131-KCS1's map (§ 2.6, on branch fs131-kcs1) priced three held leaves as missing and called C8 "a Chebotarev-type fact Mathlib lacks". Both are superseded by this plan — record § 1.3 F1, F3.
- slip — none.
- tool defect — none (`data/fs131/kru1/quote_check.py`, planted control fires).
- prior-art debt — Lemma C′'s general statement, novelty unchecked (carried from item 1027; not worded as new anywhere here).
- prior-art debt — "every real number field has infinitely many degree-one primes of norm ≡ 3 (mod 4)" by the sign-change route: unsearched; likely classical. The component lemma is `[Fischer1990b]`'s (§§ 2–3).
- question for another lane (Keryx) — make `AdmissiblePrime`'s three private lemmas public (draft § 3.7 item 1, as item 1027 (1) ruled for `ClassRatio`) or let the implementer `open private`.
- question for another lane (Keryx) — rule the dichotomy in or out of the implementer's brief (26 % of its module, 5 % of the job).
- stub to mint or re-aim — item 1027's "stub to mint for part B" is now this plan; the implementer's brief is the next step. Modules 1–2 and 3–4 are independent and can be built by two implementers.
- hygiene — the norm-one residue set is defined three times (`CertLink.normOneSet`, `Counting.normOneQ`, `ClassRatio.levelSet` private) — record § 1.3 F5.

HELD FOR THE COORDINATOR:
- The two rulings above: AdmissiblePrime's publicity, and the dichotomy in or out.
- Front-file drafts, each with its slot: record § 3.7 (ARCHITECTURE `Rigidity/RingScope` row; LEDGER rows 100 and 105; ROADMAP § 3 item 2; one LEAN.md line; a line for the asking lane's § 3.3).
