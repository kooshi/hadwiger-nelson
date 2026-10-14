# FS131-KN9 — the five-colour chain, next: M5 (Theorem 1.2 from Theorem 1.3), M9 (the ring and the scope), M8b (the zero-entropy side's second half)

*Job FS131-KN9, de Bruijn (the planner), Opus 5.5, 2026-10-14. Brief `data/fs131/briefs/FS131-KN9-chain-zero-entropy.md` (on `main`).
Branch `fs131-wk9`, cut from `3b531d1d2` (the join of `fs131-wl1` into `fs131-wpd`), in the worktree
`.claude/worktrees/fs131-wch`. Not pushed (the brief: the remote is unreachable). Working files under `data/fs131/kn9/`.*

## Theorems this phase proved

None. A planning job: every statement typed here is a skeleton leaf (`sorry`), each with its plan; the few-line checks
that elaborate are definitions' examples, not theorems of the chain.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn9_quotes.py` parses every block quotation of the brief (a run of `> ` lines closed by `> — source: <path>`)
and requires its text, verbatim, in the source file on `main`. **8 quotations, 0 missing** (exit 0): W2
(`data/fs131/REQUEST-2026-10-13.md`), NF2-NC, NF2-LEAF-21, NF2-MRPLUS-SCOPE and the two dated lines of 2026-10-14
(`data/fs131/claims-NF2.md`), inventory items 761 and 775 (`plans/FS131-close-inventory.md`). **Control** (`--plant`, one
character of the first quotation changed): that one reported `MISS`, the others `OK`, exit 0 under the plant's rule — the
check can fail. The nested quotations inside items 761 and 775 are from hand-back messages, not on disk; item 775's ruling 3
already says so, and I did not re-check them.

### 1.2 The build of the branch

`./scripts/build.sh` under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G`, `BATCH=8`): `==> build: OK — 249 of 249 batches,
10 module(s) rebuilt, 11 module(s) with warnings, 7m36s`, `exit=0` (`data/fs131/kn9/build1.log`). Rebuilt: the first
parent's modules (`Rigidity.PositiveEntropy`, `DualGroup`, `DualConnected`, `Annihilator`, `UnitCircle`, `SubgroupHaar`,
`Duality`, `Pieces`, `EntropySplitMax`) and `Proofs`, as the brief expected. 74 warnings, each ``declaration uses `sorry` ``;
no other warning.

### 1.3 The three modules' rows, restated

From the chain's architecture (`plans/FS131-KN3-chain-plan.md` § Stage 6, its table):

| id | module | leaves | discharges | needs | status (KN3) |
|---|---|---|---|---|---|
| M5 | Theorem 1.2 from Theorem 1.3 (FS105-DED) | 16 | `haar_or_zero_entropy` | M1 | statement typed |
| M8 | EF_F⁺ | 21, 18 | `zeroEntropyCarried` | M1, M9 | not read; its own planner |
| M9 | the ring and the scope — with the two unnumbered results | — | `noRamifiedStableDyadic_of_tca`; `R = O′`; the density of `R` | — | entries read |

From the split planner's lanes (`plans/FS131-KN8-chain-split.md` § 5.1): M5 writes `Rigidity/PositiveEntropy` (one proof) or a
new file, needs M1 and the finite-fibred step, "a planner first"; M8b writes new files, needs N (the names at entropy zero,
`Rigidity/ZeroEntropyNames`, landed in `fs131-wl1`), M9 and PD (Tate), "a planner, on § Stage 4's vocabulary". M8 was cut by
FS131-KN6 into M8a (the names, `Rigidity/ZeroEntropyNames`, proved by lane N) and M8b (the model, the pigeonhole, the
wandering step; `data/fs131/kn3/claims-M8-zero-entropy-carried.md`).

The split planner's § Stage 4, in its four parts (its words): **(1)** "The model of `R̂` — a theorem over one classical
input, not a definition of `Dual F`": `W := L_∞ × ∏′_{w split} L_w` (or `𝔸_L` with `Λ_𝔸 := L + ∏_{w stable} 𝔡_w^{-1}Ô_w`),
the standard character `ψ`, `π : W → Dual F`, `π a := (r ↦ ψ(a r))`, equivariant; the input Tate's self-duality ("`π` is
open and onto with kernel `Λ = R^∨ ⊂ L`, discrete and cocompact"); `TA F = π(L + L_∞)` a theorem. **(2)** M8b-2, thin boxes:
`Q(ε)`, `Q_{v*}(ε, δ)`, Lemma PF, the expanding place (Kronecker), local injectivity, Lemma 3.1′ over EN2-ZE with
`P := ξ`, `T := rot u*`. **(3)** M8b-3, the pigeonhole with `V_M ⊆ U_ℚ` and the shorter height input (`z = 1 + 2bi`,
`α′ = 1/(2[F:ℚ])`), the two scales, the global point, `μ(R̂ ∖ (T + K_{v*})) = 0`. **(4)** M8b-4, leaves (`φ_t` injective,
a Borel isomorphism by Lusin–Souslin; finite `U`-orbits on `L/Λ`, strong approximation or the torsion-group route) and
wandering shells (`g = γ/σ(γ)`, `(γ) = 𝔓_w^h`); exit `Rigidity.zeroEntropyCarried`.

The dated line of FS131-KPD1 the brief quotes adds to part (1): surjectivity of `π` from D2's case
(`Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot`) once `W/Λ` is compact; "its kernel `Λ = R^∨` and the
cocompactness are the adelic part M8b must price".
