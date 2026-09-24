# FS-79 phase 0 — ℚ(√167)'s lattices at four colours: which could need five, and what a direct refusal would cost

*Implementer (de Bruijn standard, Opus 5.5), 2026-09-23/24, desktop (16 physical cores / 32 threads, 128 GB).
Brief: `data/fs79/briefs/P0-implementer-brief.md`; spec: §S.P0 of `plans/FS79-invariant-question.md` (the planner's), with the
owner's five additions and rulings R3 and R7 and the scope change of 2026-09-23 (below). Tools: `tools/fs79_p0.py` (driver),
`tools/fs79_p0_check.py` (standalone checker, standard library only, imports nothing from `tools/`). Data: `data/fs79/phase0/`.*

## Predictions (registered before any run: 2026-09-24T01:32+00:00, commit `59eb1246`)

| id | prediction | probability | outcome |
|---|---|---|---|
| I-1 | `L21cc6506` (= Λ₄₂₀) is four-colourable by a periodic colouring found in P0.3 | 0.85 | **won**: additive into ℤ/4 (8 homomorphisms) and a Θ₄ point of order 5,880 |
| I-2 | smallest candidate `M` ≤ 2,520, point estimate 1,260 (a candidate with `M ≤ 30,240`: 0.75) | 0.50 | **won on both bounds**: smallest candidate `M = 264`; the point estimate was off by a factor of five |
| I-3 | some survivor's degree-18 ball is under 5·10⁶ points | 0.25 | **the 0.75 side won**: the cheapest survivor's ball is 1.57·10¹¹ points (Λ₂₄₀₀); every candidate's is ≥ 1.38·10⁸ |
| I-4 | at four colours the smallest refusing residue set mod 23 has ≥ 7 antipodal pairs | 0.60 | **won**: 7 pairs, `(0,1,2,3,4,6,10)` |
| P0-a (planner) | `L21cc6506` has a periodic four-colouring found by P0.3 | 0.75 | **won** |
| P0-b (planner) | a candidate Λ_M with `M ≤ 30,240` exists | 0.60 | **won** (`M = 264`, and 115 in all) |
| P0-c (planner) | the cheapest survivor's degree-18 ball exceeds 5·10⁶ points, so P0.5 is not run | 0.65 | **won**: 1.57·10¹¹ (Λ₂₄₀₀); P0.5 not triggered |

## Headline

- **`L21cc6506` is four-colourable** — by an additive colouring into ℤ/4 (8 homomorphisms Λ₄₂₀ → ℤ/4 nonzero on all 60 unit vectors;
  period group ker φ, index 4; never gapped) and by a linear form θ = (799/840, 199/280, 1/2, 631/980) on the LLL basis (a point of Θ₄,
  order 5,880, not in Θ₃). Both CERTIFIED by the standalone checker; the owner re-derived the additive count with his own code (close
  inventory item 38). So the lattice that proved χ(ℚ(√167)²) ≥ 4 does not need five.
- **The saturated chain Λ_M** (`M ≤ 2,520`, all; then the 66 further multiples of 420 up to 30,240): 370 distinct rank-4 lattices;
  **115 candidates** (every residue set at both primes above 23 and both above 43 refuses four colours; 63 of them with `M ≤ 2,520`);
  the smallest is **`M = 264`** (36 unit vectors); 15 more lattices are left undecided by one 14-pair residue set at 43 (UNKNOWN at 120 s).
- **The four-colour screens (P0.3) on all 130** (115 candidates + 15 undecided): **118 four-colourable** (first rule: additive 64,
  gapped residue colouring 36, linear Θ₄ point 10, full quotient Λ/NΛ at N ≤ 11: 8; 39 of the 118 with a fan gap, so loose by row 66),
  **12 survivors**, of which **7 minimal** (containing no other survivor). **Λ₂₅₂₀ is four-colourable and loose**: a gapped residue colouring at the ramified prime
  (167, √167 ↦ 0), which alone coloured 36 lattices.
- **Price (P0.4):** the cheapest survivor's degree-18 ball is 1.57·10¹¹ points (Λ₂₄₀₀, 100 unit vectors, R = 1.064); the cheapest candidate's is
  1.38·10⁸ (`M = 540`, coloured). **P0.5 not triggered** (cap 5·10⁶). *Caveat (the owner's):* the degree-18 aim is G65's **three-colour**
  law; the four-colour hardness band is unmeasured, so these are the prices of balls at that degree, not a proven price of a refutation.
- **The quotient screen was the one that mattered.** The cheap pass ran no quotients and left 20 survivors; small full quotients
  (admissible N ≤ 12, gap-aimed first, seconds each) then coloured 8 of them — Λ₁₆₃₂ at N = 5 with a gap, Λ₁₄₆₄ at N = 11 with a gap,
  Λ₂₁₃₆ at N = 5 with a gap, Λ₂₁₉₆, Λ₁₇₄₀, Λ₂₄₃₆, Λ₁₂₁₈₀ and Λ₂₅₆₂₀ at N = 4 — while the Θ₄ tree at 300 s found nothing on the two it was
  run on (Λ₁₆₃₂: 117,476 nodes; Λ₂₁₉₆: 111,409). So "survivor of the cheap pass" was mostly a fact about skipping quotients (defect 8).

## The minimal survivors (the instances for §IQ item 5 and FS-59)

Each is **SURVIVOR at**: additive into ℤ/4 and V₄ (exhaustive: none); Θ₄ branch-and-bound capped at 60 s (≈ 22,000–23,500 nodes, no
point; float LPs, not a certificate of emptiness); residue targets at 23 and 43 (both primes each: every set refuses four, by the
sweep), 167 (ramified), 59, 67, 71, 79, 83 and 29 (both primes each), each plain four-colour ask by linear forms, the Hoffman floor,
Schrijver's ϑ′ (q ≤ 47) and kissat at a 15–30 s budget (refusals and UNKNOWNs per lattice in `screen.jsonl`); and full quotients
Λ/NΛ at every admissible N ≤ 12 (the N listed; every other N ≤ 12 is inadmissible, a unit vector lying in NΛ), gap-aimed then plain,
kissat at 300 s, refusals re-asked by cadical with no break (`quotients.jsonl`). "No periodic colouring" is **not** claimed (G21).

| `M` | unit vectors | degree-18 price (points) | residue targets undecided (UNKNOWN at 15–30 s) | quotients refused (plain) | quotients undecided |
|---|---|---|---|---|---|
| 2448 | 84 | 2.29·10¹¹ | 71, 79, 167 | N = 5, 7 | N = 10 (300 s) |
| 2328 | 92 | 1.59·10¹¹ | 67, 79, 83, 167 | N = 5, 7, 8, 9, 10, 11 | N = 13 (300 s) |
| 2400 | 100 | 1.57·10¹¹ | 67, 71, 79, 167 | N = 7, 9, 11, 13 | — |
| 4200 | 180 | 6.83·10¹¹ | 167 | N = 8, 9, 11 | — |
| 10920 | 324 | 1.85·10¹³ | 167 | N = 8, 9, 11 | — |
| 14280 | 324 | 5.40·10¹³ | 167 | N = 8, 9, 11 | — |
| 24360 | 852 | 2.59·10¹⁴ | 167 | N = 8, 9, 11 | — |

**Corrected by P3b** (`data/fs79/records/phase-P3b-survivors.md`, 2026-09-24): Λ₂₄₄₈ is admissible at `N = 11`, which this phase never
asked (its quotient budget ran out after `N = 10`); it refuses there, replicated. Its row should read: refused at `N = 5, 7, 11, 13`;
`N = 14` by one solver; undecided at `N = 10` (plain) and `N = 15`.

The 5 non-minimal survivors each contain Λ₄₂₀₀ (and 16800 also Λ₂₄₀₀): 12600, 16800, 21000, 25200, 29400. They need no separate
screen: a quotient colouring of Λ_Y at N restricts to one of Λ_X ⊆ Λ_Y at N, so Λ₄₂₀₀'s refusals at N = 8, 9, 11 hold for them (T2).
Containment is by divisibility of true denominators. Every lattice in the pool was screened; no row is "not screened".

## Theorems this phase proved

*(Grades per `CLAUDE.md` § Notation.)*

1. **[cert — `tools/fs79_p0_check.py`, CERTIFIED, planted faults refused by name; the owner's independent recount] `L21cc6506` = Λ₄₂₀ is
   four-colourable, additively.** Exactly 8 homomorphisms φ : Λ₄₂₀ → ℤ/4 are nonzero on all 60 unit vectors (e.g. φ = (0,0,1,1) on the
   Hermite rows of `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`); none into V₄. **[hand, one line]** None is gapped, necessarily: φ(U) = −φ(U),
   and an all-odd φ would two-colour the graph, so φ(U) = {1, 2, 3} and the origin sees every colour. Also **[cert]** the Θ₄ point
   θ = (799/840, 199/280, 1/2, 631/980) on the LLL basis colours it by ⌊4{θ(x) + β}⌋, period index 5,880 (θ ∉ Θ₃, as T39 requires).
   *Witnesses:* `data/fs79/phase0/witnesses/L21cc6506-*.json`.
2. **[hand] The chain.** Λ_M = ℤ⟨U_M⟩ lies in (1/M)ℤ[√167]², so U(Λ_M) = U_M; Λ_X ⊆ Λ_Y iff X | Y for true denominators (the lcm of the
   unit vectors' exact denominators); four-colourability passes down the chain, refusal (and each residue set's refusal) passes up.
   Λ₄₂₀'s Hermite form equals the `L21cc6506` key (checked), so Λ₄₂₀ = `L21cc6506`.
3. **[hand, one line] Circular forms are Θ₄ points.** ⌊4{φ(x)}⌋ with φ ∈ (1/N)ℤʳ is proper only if every step b = Nφ(u) mod N satisfies
   ⌈N/4⌉ ≤ b ≤ N − ⌈N/4⌉ ⊂ [N/4, 3N/4]; so screen (e) is covered by (a) wherever (a) is exhaustive, and by (d) at the N that (d) asked (N ≤ 12 here).
4. **[tools, exact; refusals replicated] The residue-set classification at 23 at four colours** (`classify-q23-k4.jsonl`): of 224 dihedral
   orbits, 203 colour, 20 refuse, 1 is UNKNOWN at 60 s (`(0,1,3,4,6,7,9,10)`, invariant under g³); monotone (0 violations). **Every
   colourable orbit except the empty set colours by a linear form**, and every one has a gapped colouring. Minimal refusing sets (4
   orbits): `(0,1,2,3,4,6,10)` (7 pairs), `(0,1,2,3,4,5,6,9)`, `(0,1,2,4,6,7,8,10)`, `(0,1,2,4,5,6,8,9,10)`; maximal colourable (3):
   `(0,1,2,3,4,5,6,7)`, `(0,1,2,4,5,6,8,10)`, `(0,1,2,3,4,5,7,8,9,10)` (10 pairs). The full circle refuses by the Hoffman bound
   (4.0148 > 4); Schrijver's ϑ′ gives 131.76 < 529/4. Refusals re-asked by cadical with no pins and no precedence: 0 SAT; one
   re-ask UNKNOWN at 60 s (`(0,1,2,3,4,6,10)`). Convention: pair j = {g^j, g^(j+12)}, g = (4, 10), C's. **Port control:** at k = 3 the
   same code reproduces C's table exactly (224 / 98 / 126, by-size counts, minimal refusing and maximal colourable sets), twice.
5. **[tools, asserted on every M] Integrality at the stable primes 23 and 43** (the owner's addition 3; `[Fischer1990b]`, G55): no unit
   vector over any of the 2,586 denominators has 23 or 43 in its denominator (0 violations); the 169 denominators divisible by 23 or
   43 therefore repeat a smaller lattice.
6. **[tools, exact on U_M] The sweep** (`sweep.jsonl`): 2,586 denominators; 370 distinct rank-4 lattices; drops: rank 2 (289),
   3-integral hence 3-colourable by row 72 (143), a residue set at 23 or 43 colours (97), undecided (15); **115 candidates**, smallest
   264, 36–852 unit vectors; degree-18 prices 1.38·10⁸ (M = 540) to 1.16·10¹⁵.
7. **[tools, exact] Additive survival** (the owner's request; `additive.jsonl`): 141 of the 370 lattices have no additive four-colouring
   into ℤ/4 or V₄ (the smallest is Λ₈₈); 125 have one into V₄. **Along the multiples of 420, the first with none is Λ₈₄₀.** At the
   multiples computed, ℤ/4-colourings (8 each) exist exactly when 8 ∤ M (420, 2100, 2940, …; none at 840, 2520, 3360, …): observed,
   not proved. A landmark only, not a claim about five.
8. **[cert where CERTIFIED below; tools otherwise] The cheap screen** (`screen.jsonl`, `verdicts.jsonl`, witnesses under `witnesses/`):
   118 of 130 lattices four-colourable, 39 of them with a fan gap (loose); 12 survivors, 7 minimal (table above). The ramified prime 167
   is the commonest colouring prime (36 lattices); **Λ₂₅₂₀ is loose**, by a gapped residue colouring at 167. **All 159 witness files
   CERTIFIED** by the standalone checker (`checker-run.txt`), with planted-fault controls on one witness of each kind (additive,
   linear, residue, quotient), each refused for its own reason.

## Controls and acceptance

| what | verified how | pass | result |
|---|---|---|---|
| classifier port | k = 3 at 23 reproduces C's table | exact match | **PASS** (both pipelines) |
| residue plant | a non-square s at 23 | the residue check fails | **PASS**: s = 5 sends 48 of 60 unit vectors of Λ₄₂₀ off the circle; the true roots 11, 12 keep all 60 on; the checker refuses a non-square root as `ROOT_NOT_SQUARE_ROOT` |
| quotient controls | de Grey's lattice over K, `fs73_table.ask_k` | N = 8 SAT, N = 5, 7 UNSAT | **PASS** |
| L3e1c94c6 | the residue screen at (23, 11) | coloured | **PASS** (k = 3 with a gap; k = 4) |
| every "four-colourable" row | the standalone checker on every witness, exact on every unit vector | 0 failures | **PASS**: 159 of 159 CERTIFIED, 0 FAIL; controls PASS on each kind |
| every survivor row | lists its screens and caps | present | **PASS** (`screen.jsonl`; the table above) |
| price rows | g·φ(R)² on de Grey's lattice at R = 1.5 against G65's 18.4 | within 2 % | **PASS**: 18.391; the real ball (39,829 points) has mean degree 18.412 |
| refusal controls (P0.5's encoder: FS-73's 2,044-point graph + its edge; Heule-510) | kissat and cadical | both UNSAT | **not run: P0.5 not triggered** (the owner's steer); the encoder `refusal_ask` and the subcommand `refusal-controls` are in the driver |

## Owner rulings and scope changes recorded

- **R3 — a spec ambiguity, resolved by the implementer and approved:** the stop rule ("M = 30,240 or when the cheapest candidate's
  degree-18 price passes 10⁸, whichever first") fired at the first candidate (every candidate ≥ 1.38·10⁸). M ≤ 2,520 was finished (the
  spec's "first") and the 72 multiples of 420 up to 30,240 swept anyway as rows: minutes of compute answering the question the rule
  guards. Answer: no candidate up the chain is cheaper than 1.38·10⁸.
- **Scope change (2026-09-23), to unblock the competition:** cheap screens on every candidate; deep screen on at most three survivors in
  30 minutes; classify-43 skipped. Then (the owner's refinement) the **minimal** survivors, fewest unit vectors first — the owner's
  earlier "richest" reversed before any deep work, because the chain is nested.
- **R7:** cut the cheap screen at 00:20 if unfinished (it finished at 00:02, all 130 screened); refusal controls not run (P0.5 not
  triggered). The deep pass (00:03–00:15) was replaced by the quotient-only pass on every survivor (00:15–00:50), then the checker.
- **What the stops forfeit, named:** the automatic deep stage (Θ₄ tree to 900 s and quotients to 900 s on each of 20 survivors); P0.1's
  classification at 43 up to 7 pairs (spec deliverable, **declined** by the scope change: at 43 only the sets real lattices produce
  were asked, cached in `residue-cache.jsonl`); the 300 s re-asks of the 7 undecided 43-sets (one ran, UNKNOWN; the job was stopped by
  pid, so 15 lattices stayed "undecided" and were screened as candidates anyway); the P0.5 refusal controls.

## Decisions (four parts)

| choice | alternative | why this one won | confidence |
|---|---|---|---|
| external kissat/cadical under a parent-enforced timeout | pysat's in-process CaDiCaL with a Timer interrupt | pysat raises "Limited solve is currently unsupported by CaDiCaL" inside the timer thread, so the budget never fired (defect 1) | high |
| linear forms, Hoffman and ϑ′ before any SAT ask on a residue set | SAT first | the first 4-colour ask to hang had a linear colouring found in 0.25 s; ϑ′ refuses the full circle at 23 where SAT is slow | high |
| a quotient-only pass (N ≤ 12) on every survivor, in place of the deep pass on three | the scope change's deep pass (Θ₄ 300 s + quotients) on three minimal survivors | the first two deep-pass lattices fell to quotients at N = 5 and 4 in under a second each, after 300 s of Θ₄ each; the quotient screen is the decisive cheap one | high |
| Θ₄ by float-LP branch and bound, smallest-ℓ¹ branching, exact rational snap | FS-73's exact Θ₃ trees ported to [1/4, 3/4] | Θ₄ is one-sided at four colours (a point colours; emptiness decides nothing), so a finder with an exact re-check suffices; ℓ¹ branching cut Λ₄₈₀ from 6,550 nodes to 308 | medium — an exact emptiness tree would say more about survivors |
| the cheap pass stops at the first colouring; 23/43 verdicts reused from the sweep | every screen on every lattice | the first pass spent ~10 min per lattice looking for gaps on coloured lattices and re-asked 43-sets at a smaller budget than the sweep (defects 4, 5) | high |
| the sweep deduplicates lattices by true denominator and asks 43 only if both 23-sets refuse | ask all four sets for every M | the same lattice recurs at every multiple; the 23 table is free | high |
| a new standalone checker for colourings | C's `fs73_q167_check.py` (frozen, three colours, residue only) | four colours, four rule kinds (additive, linear, residue, quotient), two unit enumerations | high |

## Defects found in this phase's own work (G21: each silent or flattering until caught)

1. **An unbounded ask.** pysat's CaDiCaL cannot be interrupted; the Timer's `interrupt()` raised in its own thread and the solve ran on.
   Caught at ~2 min; killed by process group, verified by effect; replaced (close inventory item 40).
2. **A silent monitor.** The first sweep monitor piped through `cut`, which block-buffers, so it reported nothing; re-armed with
   `awk … fflush()`.
3. **A finder that could not find.** A TabuCol finder failed in 200,000 moves on a set with a known linear colouring; removed, not used.
4. **Inconsistent budgets.** The first cheap pass re-asked the 23- and 43-sets at 30 s where the sweep had decided them at 120 s, so
   `540`'s 43-sets read UNKNOWN in `screen.jsonl` against UNSAT in the sweep; the screen now reuses the sweep's verdicts (those two early
   rows remain, superseded).
5. **A slow cheap pass** kept asking residue targets for a gap after a colouring was found (~7 min per lattice); stopped by process
   group and restarted, keyed records resumed.
6. **A wasted ask order.** The first sweep asked the 43-sets even when a 23-set coloured; fixed by short-circuit.
7. **The ramified prime last.** 167 colours more lattices than every other prime together; the restart put it first.
8. **The cheap pass skipped the cheapest decisive screen.** Full quotients at N ≤ 12 cost seconds and coloured 8 of the 20 cheap-pass
   survivors; they should have been in the cheap pass, and the first deep pass spent its first 5 minutes per lattice on a Θ₄ tree
   instead. The deep pass was stopped by process group and replaced by a quotient-only pass (N ≤ 12) on every survivor; an ask at
   N = 13 had run to its 300 s budget twice (gap and plain) because `quot_total` is checked only between N.

## Regenerate

```
python3 tools/fs79_p0.py classify --q 23 --k 3 ; python3 tools/fs79_p0.py classify --q 23 --k 4 --budget 60
python3 tools/fs79_p0.py sweep --mmin 1 --mmax 2520 --budget 120            # resumes; residue-cache.jsonl is the 43 cache
python3 tools/fs79_p0.py sweep --mlist 420,840,...,30240 --budget 120
python3 tools/fs79_p0.py additive --mmax 30240
python3 tools/fs79_p0.py controls
python3 tools/fs79_p0.py screen --ids all --budget 15 --theta_cap 60 --noquot    # cheap pass, resumes
python3 tools/fs79_p0.py screen --ids 1632,2196,2448 --budget 60 --theta_cap 300 --quot_total 300   # deep pass (stopped)
python3 tools/fs79_p0.py screen --ids survivors --budget 60 --theta_cap 60 --quot_total 120 --quot_nmax 12   # quotient pass
python3 tools/fs79_p0.py price
python3 tools/fs79_p0_check.py data/fs79/phase0/witnesses/<file>.json [--controls]
```
Every job over two minutes ran under the heavy lock with `setsid` and a pgid file; the quotient ask takes the lock itself when heavy
(addition 1), so it was never wrapped.
