# The fixed-cardinality moment equations (FS-65, 2026-09-19)

*The external review's own first recommendation, implemented, controlled, and run. Written before the
`q = 19` solves finished, with the discriminating prediction registered below.*

## What the equations are

For an independent set `S` of size `s`, the level-3 programme's variables are `y(T) = N(T)/s` with
`N(T) = #{z : T + z ⊆ S}`, averaged over the automorphism group. Summing over every `v ∈ V`,

```
Σ_v N(T ∪ {v}) = Σ_z [T + z ⊆ S] · #{v : v + z ∈ S} = s · N(T),
```

and a `v` outside `T` adjacent to a member of `T` contributes nothing because `S` is independent. So
for every independent `T`

```
Σ_{v ∉ T ∪ N(T)}  y(T ∪ {v})  =  (|S| − |T|) · y(T).
```

One equation per orbit of an independent `T`. At `q = 19` the orbit counts are **1, 17 and 555** for
`|T| = 1, 2, 3` — **573 equations, exactly the count the review gave** (its 574 includes the vacuous
`|T| = 0`). They use variables of size 2, 3 and 4, and the level-3 relaxation carries all of them
(36,044 live variables at `q = 19`: 17 of size 2, 555 of size 3, **35,472 of size 4**). So the review's
"no new moment variables are needed" is exactly right.

## Which relaxation — a correction to my first attempt

This repository has **two** semidefinite relaxations and I strengthened the wrong one first.

| | variables | value at 7 | at 11 | at 19 |
|---|---|---|---|---|
| FS-50 **triple-level** (`tools/fplane_sdp_blocks.py`) | orbits of independent sets of size ≤ 3 — 573 live at 19 | 14.0879 | 29.1769 | — |
| FS-54 **level-3, GLV `L₃`** (`tools/fs54_d4_quad.py`) | orbits of size ≤ 4 — 36,044 live at 19 | **14** | **28** | **80.59** |

The triple-level's live-class count at `q = 19` is 573, which is numerically the same as the equation
count and is what led me to it. But its largest variable is a **3**-set, so the `|T| = 3` equations —
555 of the 573 — have nowhere to land there. Only `L₃` carries 4-sets. The 80.59 on record came from
`L₃`, and `L₃` is the object the review meant.

*Recorded because it is a real trap: two numbers agreed (573), and the agreement was a coincidence
between a variable count in one relaxation and an equation count in another.*

**What the detour bought** (`tools/fs65_l3_fixedk.py`, kept): the same equations for the triple-level
relaxation, where only `|T| ≤ 2` fits — 18 equations at `q = 19`. Measured there, the strengthening is
worth **exactly integer rounding and nothing more**: `f(k) = k` for every `k ≤ ⌊N⌋` and `f(k) = 1`
above it, so the threshold is `⌊14.0879⌋ = 14` at `q = 7` and `⌊29.1769⌋ = 29` at `q = 11`. That is
the null result the `L₃` run has to beat.

## The controls, all passing

Run before any solver, from a **real** independent set, with `y` built from its subsets exactly:

| field | set | equations | worst residual at `k = |S|` | at `k ± 1` |
|---|---|---|---|---|
| 7 | a 14-set (= α) | 29 | `3.6e-15` | `1.0` — they bite |
| 11 | a 28-set (= α) | 115 | `1.3e-14` | `1.0` — they bite |
| 19 | the 76-set | **573** | `1.6e-13` | `1.0` — they bite |

The `k ± 1` column is the half that matters: an equation satisfied at every `k` would constrain
nothing, and these are wrong by exactly 1 one step away.

Two-sided at the solver, where the answer is known exactly:

| field | `k` | `f(k) = max tr Y` | verdict | truth |
|---|---|---|---|---|
| 7 | 14 | 14.000000 | not refuted | α = 14 ✓ |
| 7 | 15 | **1.000000** | refuted, so α ≤ 14 | ✓ |
| 11 | 28 | 28.000000 | not refuted | α = 28 ✓ |
| 11 | 29 | **1.000000** | refuted, so α ≤ 28 | ✓ |
| 11 | 30 | **1.000000** | refuted | ✓ |

The collapse is to the trivial point `y = 0` (`tr Y = 1`, the one-point set), not to something just
under `k` — a sharp signal rather than a marginal one.

## How the test is put, and why not as feasibility

The `|T| = 1` equation reads `Σ_v y{0,v} = k − 1`, which is exactly `tr Y = k`. Imposing it would pin
the objective and turn the programme into a feasibility question, so it is **left out by default** and
the objective stays `max tr Y`, whose value at cardinality `k` is called `f(k)`. A real independent set
of size exactly `k` satisfies every remaining equation and has `tr Y = k`, so

> **`f(k) < k` proves there is no independent set of size `k`, hence `α < k`** — any larger independent
> set has an independent `k`-subset.

The first version of this work asked the feasibility question instead and it was numerically
degenerate exactly at the boundary: at `q = 11, k = 28`, where a 28-set exists and is on disk, the
margin came back `−5e-08` and the run reported a refutation. **A test whose false positive sits at the
answer is not a test.** `f(k)` is a number in the units the unstrengthened bound already has.

## THE RESULT AT `q = 19`: `f(78) = 78.000000`, and the equations do not settle it

**Converged** — status `solved`, primal 78.000000 against dual 77.999999, `res_pri 1.2e-08`,
`res_dual 8.1e-07`, gap `6.1e-07`, in 750 iterations and 55 minutes, with all 572 equations in the
problem over 36,044 variables. So

> **`α(19) ≤ 77` is NOT proven by this route.** The standing interval `76 ≤ α(19) ≤ 80` is unchanged
> and `c(19) ∈ [0.918, 0.966]` still has the deciding 0.933 inside it.

**And the shape of the answer is the finding, not the value.** `f(78)` is *exactly* 78, not 78-and-a-bit.

### Why, and it is a one-second experiment

The `|T| ≥ 2` equations **force `tr Y = k` on their own** — the `|T| = 1` equation, which is literally
`tr Y = k`, is implied by them. Measured at `q = 7`, where α = 14 and the bound is 14.0879, at values
of `k` far below both:

| `k` | 8 | 10 | 12 | 14 |
|---|---|---|---|---|
| `f(k)` | 8.000000 | 10.000000 | 12.000000 | 14.000000 |

So the objective carries no information once the equations are imposed, and **the strengthened
programme is a pure feasibility test.** Its only output is the largest `k` at which the system is
feasible. Every feasible point has `tr Y = k ≤ N`, the unstrengthened optimum, so

> **the threshold can never exceed `⌊N⌋`** — the strengthening cannot beat the integer rounding of the
> bound it starts from, on either relaxation.

It could in principle land *below* `⌊N⌋`, and that is the only way it could still pay: at `q = 19`,
`⌊80.588⌋ = 80`, so a collapse at `k = 80` would give `α(19) ≤ 79` and a collapse at 79 would give 78.
`f(78) = 78` rules out anything better than that.

### The bracket, and what was cut from it

At 400 iterations every member was converging to exactly its own `k` — 77.04, 79.31, 80.31, and
81.0006 — which is the law again. With five solves the per-iteration cost had risen from 2.8 s to
13–17 s (memory bandwidth, not cores: each uses one of sixteen), so the uninformative runs were
taxing the decisive ones by about 3×. **`k = 77` and `k = 79` were killed**, on this repository's rule
that a run blocking something is presumed killable.

*What that forfeits, named:* the converged values of `f(77)` and `f(79)`. Both were already heading to
their own `k` and neither can change the conclusion — if `f(80) = 80` the threshold is 80 whatever 79
does, and `f(78) = 78` bounds what 79 could have bought. Their checkpoints survive, so if `k = 80`
surprises us by collapsing, `k = 79` resumes from where it stopped rather than restarting.

**What is left is the pair that decides it.** `k = 80` converging to 80 makes the threshold exactly
`⌊N⌋` and the strengthening worth precisely integer rounding; `k = 81` is the reachability check that a
collapse happens at all at this field size, without which `f(80) = 80` would leave open the reading
that the test is simply inert here. Note `f(81) = 81` is *impossible* — every feasible point has
`tr Y = k ≤ N = 80.588` — so the 81.0006 on its iterate is a solver that has not yet found the
infeasibility, and watching it find one is the check.

*The prediction below was registered before any of this landed, and the outcome it named as "only
integer rounding" is the one that occurred.*

## The prediction, registered before the `q = 19` runs finished

The controls at 7 and 11 **cannot** distinguish the two live possibilities, because `L₃` is already
exact at both — there is no room there for the strengthening to show itself. At `q = 19` the
unstrengthened value is 80.59, so:

- **if the strengthening is only integer rounding** (what it demonstrably is for the triple-level
  relaxation), then `f(81) = 1` and `f(78) ≥ 78`, and nothing is gained over `⌊80.59⌋ = 80`;
- **if it is genuinely stronger**, `f(78) < 78` and `α(19) ≤ 77`, which puts `c(19) ≤ 0.930` under the
  0.933 that G59's uniform-bound reading needs.

### The control at field 19, which needs no solver at all

`f(76) ≥ 76` **is already established by exhibition**, and that is a better control than the solver run
I first launched for it. `checkset` builds `y` from the real 76-point set and finds: every block PSD
(least eigenvalue `−2.9e-14`), every one of the 573 equations satisfied at `k = 76` (residual
`1.6e-13`), `y ≥ 0` by construction, and objective exactly 76. That is a **feasible point of the
strengthened programme at `k = 76` with `tr Y = 76`** — so `f(76) ≥ 76` holds without optimising
anything, and a collapse at 76 would have meant a bug rather than a finding.

The solver run at `k = 76` was therefore redundant and was killed, on this repository's own rule that a
run blocking something is presumed killable: it was taking half the machine from the question. What
replaced it on that core is `k = 81`, which is the **reachability check** — the unstrengthened bound
80.59 already refutes 81, so a collapse there says the mechanism fires at this field size, and its
absence would say the programme has simply not converged rather than that 78 survives.

## Files

| file | what it is |
|---|---|
| `l3-fixedk-q19-k77.json` … `-k80.json` | the bracket: **`k = 77…80` is the untested regime** |
| `l3-fixedk-q19-k81.json` | the reachability check: 80.59 already refutes 81, so this must collapse |

**`k` between α and the unstrengthened bound has never been observed.** At `q = 7` and `q = 11` the
unstrengthened `L₃` value already equals α, so there is no gap and every `k` tested was either at the
answer or outside the bound entirely — where the programme collapses to 1. At `q = 19` the gap is real:
α ∈ [76, 80] against a bound of 80.59, so `k = 77, 78, 79, 80` all sit inside it, and what `f` does
there is exactly what has never been measured. The whole bracket is therefore run, not just `k = 78`:
the shape of `f` across it is the finding, and one point of it would not be readable.

The cost, measured: **2.83 s per iteration** against the unstrengthened programme's 0.42 s, a 6.7×
slowdown for 572 rows that are dense across the 4-set variables. The collapse, where it happens, is
fast — 225 iterations at `q = 7`, 950 at `q = 11` — so the run is short if it refutes and long if it
does not, which is the wrong way round for patience.

The checkpoints are large and regenerable; they are not committed. Re-run with

```
build/venv-sdp/bin/python -u tools/fs54_d4_quad.py solve --q 19 --fixed-k 78 \
    --ckpt <path>.npz --new --eps 1e-7 --chunk 200 --linear-solver cpu_indirect --out <out>.json
```

and the control with

```
build/venv-sdp/bin/python -u tools/fs54_d4_quad.py checkset --q 19 --set <set>.json --path set
```
