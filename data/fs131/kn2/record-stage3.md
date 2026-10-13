
## Stage 3 — SAVED: the skeleton, and the machine measured

**The skeleton.** Three modules, 518 lines; `sorry` is the whole body of 24 theorems and occurs nowhere else (counted:
`grep -c '^  sorry$'` and `grep -c sorry` agree per file — 12, 9, 3). Every definition has a body with no `sorry`
(`StablePrime.heightOne`, `.localRing`, `.residue`; the last takes the leaf `isUnit_mk_pow` as its proof argument).
In the build's lists: three `import` lines at the end of `Proofs.lean`; three rows in `ARCHITECTURE.md` § 3 after
`Arith/NegCircleModel`, each with its imports cell and `—` for ledger rows. `tools/check_architecture.py`: `RESULT: PASS`
(`data/fs131/kn2/logs/check_architecture.out`); run with the rows absent and the files present it fails `module coverage`
(`check_architecture.base.out`) — the control, seen by accident and kept.

**A spec example per headline** (all elaborate; those that rest on a leaf rest on its `sorry` until it is proved):
in `Arith/QuadraticPrime` — `ℚ → ℚ_5` as the model of `exists_maximal_card_of_padic`'s hypothesis; `exists_maximal_card_eq` at
`({11}, 7)`; `exists_maximal_card_eq_sqrt` at `(47, 11, s = 5)`; the ramified clause at `({3}, q = 11, p = 11)`, which is `K`;
`¬ IsSquare ((2 : ℕ) : ZMod 11)` — the hypothesis refusing the false reading; the `NumberField` instance at `{3, 11, 5}`.
In `Instances/UpperHalfValues` — the upper half at `ℚ`; `Nonempty (StablePrime ⊥)`; a usable prime of `ℚ(√11)` with 7 elements
in its quotient. `Arith/UpperHalf` itself carries no `example`: its hypotheses' models need the other two modules, and its
module docstring names them (`LEAN.md` § The gate: "or a one-line note naming the theorem that supplies one").

**Vacuity, read by hand** (no scan was run). No new binder is a colouring. `IsUsablePrime 𝔭` and `P : StablePrime F` are the
structure-valued hypotheses: the first is inhabited at `ℚ(√11)` (7), `ℚ(√47)` (11), `ℚ(√167)` (23) by `exists_maximal_card_eq`
once Q4–Q7 are proved; the second at `ℚ` by `exists_stablePrime_rat` once I3 is proved, and today at the standing field by
`StandingFive.exists_stablePrime_two`. `colorable_two_planeOver_of_ramified`'s `hram` is inhabited at `ℚ` by the same leaf.
`exists_stablePrime_of_valuationSubring`'s `A`: `P.localRing` for any stable `P` (`localRing_ne_top`, `conj_mem_localRing`).
`nonempty_ringHom_zmod_of_ramified_sqrt`'s hypotheses have no model in the kernel until Q9 builds one at `ℚ(√3, √11)`.

**The machine** (laptop, 12 cores, 31 GiB; logs under `data/fs131/kn2/logs/`):

| run | what was stale | wall | peak memory | what the number measures |
|---|---|---|---|---|
| `lake env lean`, probe importing `Arith/PlaceHom`, `SpectralChain`, Mathlib's `Padics` (first read) | — | 23.8 s | 3.56 GB | one file, cold `.olean`s |
| `lake env lean Arith/UpperHalf.lean` (246 lines) | — | 3.0–3.1 s | 3.59 GB | one file, warm; the implementers' iteration |
| `lake env lean Arith/QuadraticPrime.lean` (162 lines) | — | 2.3 s | 3.35 GB | the same |
| build 1: slot `--mem 18 --cpus 10`, `MEMMAX=18G BATCH=2 ./scripts/build.sh` | the three new modules and the root | **23 m 51 s** | 4.52 GB (largest single process; never two `lean` alive at a 3 s sample) | 947 Lake starts; compiling was 12.0 s of it (1.8 + 2.6 + 1.0 s, root 6.6 s) |
| build 2: the same at `BATCH=8` | `Arith/UpperHalf`, `Instances/UpperHalfValues`, the root | **6 m 37 s** | 4.53 GB (largest single process; one `lean` alive at every 1 s sample, at most 4.19 GB) | 249 Lake starts; compiling was 6.5 s (2.7 + 1.9 s, root 1.9 s). The walk is the cost, and it scales with the batch count: 1.51 s a batch at width 2, 1.59 s at width 8 |

A build under another job's slot waits: this job's second probe sat 24 minutes behind a slot named `kc1` (18 GiB, 10 cores)
— on this machine two builds do not overlap, and a `lake env lean` at `--mem 8` does not fit beside one (18 + 8 > 22).
