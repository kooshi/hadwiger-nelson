# FS-73 P3b — ℚ(√167)'s last surviving lattice `L21cc6506`: is its rotation set Θ empty?

Implementer E (de Bruijn), 2026-09-23. Brief: the product owner's `fs73-implE/BRIEF.md` (scratchpad). One bounded item.

**The question.** `L21cc6506` is the lattice `{(a,b,c,e) ∈ ℤ⁴ : c ≡ b, e ≡ a (mod 2)}` read as points
`((a+b√167)/420, (c+e√167)/420)` of ℚ(√167)² (FS-61 key `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`), with its 60 unit vectors `U`.
By H-i / dB-T0 (`plans/FS73-C3-Coxeter.md` §3, `plans/FS73-C3-deBruijn.md` §2 C1), its unit-distance graph is 3-colourable iff
`Θ = {θ ∈ Hom(span U, ℝ) : θ(u) mod 1 ∈ [1/3, 2/3] for every u ∈ U}` is nonempty. Empty Θ ⟹ χ(ℚ(√167)²) ≥ 4.

## 1. Prediction (registered before any computation on this lattice)

**Predicted: Θ nonempty (the lattice is 3-colourable), confidence 60 %.**

- *For nonempty.* 55 of FS-61's 57 lattices at 167 have periodic 3-colourings (P2b), and the other survivor `Ld14c588b`
  survived the finite screens only because its colourings have period index 1,080, beyond the screens' `N`. The likeliest
  reason a lattice survives those screens is a long period, not emptiness. G61(4): refusal tracks unit-vector supply —
  108 refuses at d = 11, 20–36 colour at 167 — and 60 is between.
- *For empty.* Coxeter's first-cell search found `Ld14c588b`'s cell in about 60 s; on this lattice it walked 528,876 nodes
  in 880 s with no cell. A depth-first first-cell search that runs long without a leaf is weak evidence that cells are rare
  or absent. That is why the confidence is only 60 %.
- *Both outcomes are reachable by the method* (§3): an exact branch-and-bound over the torus `ℝ⁴/ℤ⁴` is a finite tree (every
  node's range for the next unit vector is bounded, and its depth is `|U|/2`); it ends either with a leaf — a nonempty cell, from
  which a vertex gives an exact rational θ — or with every branch closed by an exact Farkas vector, which is an emptiness
  certificate. **The uninformative outcome is "undecided at the cap"**, and it is reachable too: it is where Coxeter stopped.

## 2. Result, in one paragraph — Θ empty by two exact routes; pending independent verification

**Θ(L21cc6506) is empty by two exact routes, and each route's certificate is accepted by its checkers. This is pending the
independent verification the product owner is arranging.** If it survives that verification, H-i makes the lattice's
unit-distance graph not 3-colourable. The graph is a subgraph of the plane over ℚ(√167), so the claim would be
χ(ℚ(√167)²) ≥ 4. **The registered prediction (nonempty, 60 %) lost.** The mechanism is a product structure the lattice was
hiding, §3, and three of its five "rotations" already refuse three colours (§6, hand).

## 3. The structure (found before the verdict; it is what made both routes cheap)

- **U = B5 · U_R**, exactly (a set equality, checked in Fractions against an enumeration of U).
  - U_R is the 12 rational unit vectors: ±1, ±i, (±4±3i)/5, (±3±4i)/5.
  - B5 = {1, v, v̄, z, z̄}, with v = (83+i√167)/84 and z = (1+i)(15−i√167)/28.
  - As (a,b,c,e) at M = 420: v = (415,0,0,5), z = (225,15,225,−15), z̄ = (225,15,−225,15).
- **span U = (1/210)ℤ[i] ⊕ (v/5)ℤ[i].** This is the whole key lattice (index 1).
- **The coordinates.** Take coordinates w dual to the basis {1/210, i/210, v/5, iv/5}, with (a,b,c,e) rows (2,0,0,0),
  (0,0,2,0), (83,0,0,1), (0,−1,83,0), and periods ℤ⁴. For each b ∈ B5, the map μ_b(w) = (θ(b), θ(bi)) satisfies
  θ(b·x) = ⟨μ_b, x⟩ for every x ∈ U_R. So **θ ∈ Θ ⟺ μ_b(w) ∈ Θ_R for all five b**, where Θ_R is the rotation set of the
  rational pattern.
- The five maps are μ_1 = 210(w1,w2) and ν := μ_v = 5(w3,w4), with μ_v̄ = (83/42)μ_1 − ν,
  μ_z = (1−i)((7/2)μ_1 − 3ν) and μ_z̄ = (1+i)(3ν − (17/7)μ_1), in complex notation.
- **Θ_R = c0 + (D0 ∪ F4) + 5ℤ²**, by exact vertex enumeration.
  - c0 = (5/2, 5/2).
  - D0 = {δ : |⟨δ,x⟩| ≤ 1/6 for every x ∈ U_R}, a dodecagon with 12 vertices.
  - F4 = {(±5/6, ±5/6)}: four **isolated points**, degenerate cells of Θ_R that a float search can pass over.
- **The size of the torus, and why Coxeter's tree could not finish.** The torus is (ℝ²/210ℤ²) × (ℝ²/5ℤ²). ν sees one period
  of Θ_R, and μ_1 sees 42² = 1,764 periods. An LLL-reduced basis leaves unit coefficients near 210–420 because of those
  1,764 lifts, and no change of frame removes them.

## 4. Controls (both directions; they test the pipeline, not the lattice)

| control | expected | result |
|---|---|---|
| `certcheck.py cert_47.json` (Coxeter, ℚ(√47)) | EMPTY | CERTIFICATE OK, 2,997 nodes, 0 leaves; my checker agrees |
| `Ld65c8ee8` over d = 11 (FS-61 `11:REF/108`) | EMPTY | **new exact certificate**: 20,843 nodes, 4.9 MB, 40 s to build; accepted by `certcheck.py` *as it stands* (18 s) and by `tools/fs73_theta_check.py` |
| `Ld65c8ee8` over d = 59 (FS-61 `peri/36`) | a point | ψ = (5/18, 1/2, 5/18, −1/2) on (a,b,c,e), 2,342 nodes; **slack 0**, a degenerate cell; `POINT OK`, period order 9 |
| `Ld14c588b` (Coxeter's colouring) | a point | ψ = (59/240, 120239/154496, 15735/154496, −350921/579360), found in 14,130 nodes; max slack **133/115872**, the same cell as Coxeter's; `POINT OK`; Coxeter's own ψ re-checks `POINT OK` with period 1,080 |
| route 2 with conditions dropped | NONEMPTY is reachable | keep only v̄: **1,200 feasible**; keep only z̄: **7,056 feasible**; keep only z: 0 feasible (the §6 theorem) |
| planted faults, my tree checker (d = 11) | each refused by name | a child dropped, a unit dropped from S, a multiplier doubled, the wrong field, a basis vector doubled, a ψ perturbed: all refused; the faithful copies pass |

**An instrument that failed its control, recorded so nobody reuses it.** A float MIP (HiGHS, via scipy's `milp`) ran in
the Hermite-normal-form basis of span U, whose unit coefficients reach 6,188. It reported the known-colourable `Ld14c588b`
**infeasible**. That cell's slack is 0.00115 in θ, far below the solver's feasibility tolerance once divided by coefficients
that size. Rescaled so that the coefficients are at most 1, the MIP got all three controls right. On L21cc6506 it then ran
to its 1,000 s wall with no answer. A float verdict is unusable here in either direction.

## 5. Price, then the decision

- **Price** (desktop, one core, under the heavy lock). With my structural frame and order, the exact builder ran at about
  520 nodes/s. The first ν-cell's subtree cost about 110,000 nodes, predicting about 550,000 in total.
- **Route 1: a branch-and-bound certificate in `certcheck.py`'s format** (`tools/fs73_theta_cert.py`).
  - Branching order: the six v-units first (they pin ν to its 5 pieces). Next the six rational units, with (4,3)/5 and
    (3,4)/5 first, because that pair's cell count is 7/25 of the axis pair's. Then z, z̄ and v̄.
  - Result: **exhausted, 605,203 nodes, 0 leaves, 0 exact-simplex fallbacks.** Every multiplier came from a float proposal
    and was re-bounded in Fractions. It took 1,207 s CPU with a 93 MB peak.
  - File: 219.5 MB raw (sha256 `7fdef2b6ecb12735…`), 7.7 MB gzipped (sha256 `714fd58c5b9f15fd…`).
  - Checkers: see §5a.
- **Route 2: the product structure** (`tools/fs73_theta_struct.py`; standalone checker `tools/fs73_theta_struct_check.py`).
  - It sweeps 1,764 lifts × 25 piece pairs = **44,100 cases**. An exact bounding-box test leaves **444**, which break into
    **4,768 target combinations**.
  - **Each combination is refuted by a Farkas vector** over labelled rows, and the checker rebuilds and verifies every one.
    **0 are feasible.**
  - Cost: 2.7 MB (106 KB gzipped). Built in 29.5 s CPU with a 24 MB peak, regenerated byte-identically
    (sha256 `652f084cc103e927…`), and checked in 48 s.
  - The checker re-derives the whole reduction from the key: U = B5 · U_R, the frame, Θ_R's vertex structure, the case
    coverage and every bounding box.

### 5a. The route-1 certificate's two checkers
Both checkers accept the route-1 certificate, run on the desktop under the heavy lock:

| checker | verdict | cost |
|---|---|---|
| `data/fs73/coxeter-c3/certcheck.py` (committed; Coxeter's code, unmodified) | `lattice check OK: 60 unit vectors … CERTIFICATE OK: nodes checked 605203 leaves 0 => Theta EMPTY` | 209 s CPU, 1.9 GB |
| `tools/fs73_theta_check.py` (mine; its own enumeration of U, its own lattice-equality test by HNF) | `CERTIFICATE OK: 605203 nodes walked, 0 leaves => Theta EMPTY` | 182 s CPU, 1.9 GB |

**Planted faults on the route-1 certificate** (`tools/fs73_theta_plant.py tree`). Each plant sits on the first path the walk
visits, so it is refused early. All eight are refused, each by its checker's own message:
- **A rational unit vector dropped from S.** `certcheck.py`: `S is not the full unit set`. Mine: `a unit vector is missing
  from S`.
- **One node's lower-bound multipliers tripled.** Both checkers: the children no longer match the certified range. Mine
  gives `[6]` against `[4, 5, 6]`.
- **One child dropped at the root.** Both checkers refuse, for the same reason.
- **A zero Farkas vector on a feasible node.** `certcheck.py`: `Farkas vector does not certify infeasibility`. Mine:
  `Farkas vector does not refute`.

The runs cost 252 s CPU and 1.9 GB. The faithful copy is the check run in the table above.

### 5b. Planted faults in the L21cc6506 certificates themselves (the product owner's item 2)

`python3 tools/fs73_theta_plant.py struct data/fs73/q167/L21cc6506-theta-struct.json <scratch>`: the faithful copy passes, and
each of six plants is refused by name:
- **Structural lie: the rotation z̄ dropped.** Refused with `R1: 48 distinct products against 60 unit vectors`.
- **Structural lie: z replaced by a rational unit.** Refused with `R1: a product b*x is not a point of (1/M)Z^4`.
- **Arithmetic lie: one Farkas multiplier doubled.** Refused with `Farkas vector fails at (0, 0, 'D0', 'D0') …`.
- **One Farkas certificate removed.** Refused with `no certificate for case …`.
- **A basis vector doubled.** Refused with `R2: a unit vector is not in the basis lattice`.
- **The wrong field.** Refused with `R1: a rotation is not a unit vector`.

For the route-1 tree, `python3 tools/fs73_theta_plant.py tree … ` runs both tree checkers: see §5a.

## 6. Why it is empty: three rotations already suffice (hand, confirmed exactly)

**P3b-T4.** Keep only b ∈ {1, v, z}: 36 unit vectors, still spanning the same lattice. The rotation set is still empty. By
hand:
- Write μ_1 = c0 + 5k + δ1 and ν = c0 + δ2, with δ1, δ2 ∈ D0 ∪ F4.
- Since (1−i)c0/2 = 5/2, μ_z ≡ 5/2 + ε·(5/2)(1+i) + η (mod 5ℤ[i]), where η = (1−i)((7/2)δ1 − 3δ2), and ε = 0 or 1 as
  k₁ + k₂ is even or odd.
- The requirement μ_z ∈ Θ_R becomes: η ∈ (5/2)i + (D0 ∪ F4) + 5ℤ[i] when ε = 0, and η ∈ 5/2 + (D0 ∪ F4) + 5ℤ[i] when
  ε = 1. The D0 targets sit at distance at least 7/3 from the axis in the relevant coordinate. The F4 targets are the four
  points (±5/6, ±5/3), or those four with coordinates swapped.
- Three facts decide every case:
  - |⟨δ,1⟩|, |⟨δ,i⟩| ≤ 1/6 on D0.
  - (1−i)f ∈ (5/3){±1, ±i} for f ∈ F4, so −3(1−i)f ≡ 0 and (7/2)(1−i)f ≡ (5/6)σ (mod 5).
  - The coordinate bounds 13/12 (both δ in D0), 7/6 (δ2 a point) and 1 (δ1 a point).
- The four cases each end in a contradiction:
  - **Both in D0.** Hitting an F4 target forces a coordinate of (7/2)δ1 − 3δ2 to be 5/4 > 13/12.
  - **δ2 a point.** Then |η| ≤ 7/6 < 5/3 coordinatewise.
  - **δ1 a point.** Then (1−i)δ2 would need both coordinates of size 5/18, forcing |δ2| ≥ 5/18 > 1/6 in some coordinate.
  - **Both points.** η ≡ (5/6)σ, whose coordinates lie in {0, ±5/6}, and none of the target residues is in that set.
- **Confirmed exactly.** `fs73_theta_struct.py … z` gives 5,292 surviving cases and 14,112 combinations, every one refuted
  by a checked Farkas vector. The z̄-only and v̄-only runs are **nonempty**, so which rotation kills is not arbitrary.

## 7. Theorems this phase proved (WORKFLOW step 7)

| id | statement | grade | where |
|---|---|---|---|
| P3b-T1 | Θ(`L21cc6506`) = ∅, so by H-i its unit-distance graph is not 3-colourable, and χ(ℚ(√167)²) ≥ 4 — **pending independent verification** | tools, exact, two routes, three checkers | §5; `data/fs73/q167/L21cc6506-theta-{tree.json.gz,struct.json}` |
| P3b-T2 | U(`L21cc6506`) = {1, v, v̄, z, z̄} · U_R exactly; span U = (1/210)ℤ[i] ⊕ (v/5)ℤ[i]; Θ ≅ {w : μ_b(w) ∈ Θ_R ∀b} with the five maps of §3 | hand + tools (exact) | §3; route-2 checker R1–R2 |
| P3b-T3 | the rational 12-vector pattern: Θ_R = (5/2,5/2) + ({\|⟨δ,x⟩\| ≤ 1/6} ∪ {(±5/6,±5/6)}) + 5ℤ², with four isolated degenerate points | tools (exact vertex enumeration) + hand | §3; checker R3 |
| P3b-T4 | the 36 vectors {1, v, z} · U_R already have Θ = ∅ | hand; confirmed exactly | §6 |
| P3b-T5 | `Ld65c8ee8` over ℚ(√11): Θ = ∅ by an exact certificate (FS-61's refusal re-derived through H-i) | tools, exact | §4; `data/fs73/q167/theta-controls/` |
| P3b-T6 | `Ld65c8ee8` over ℚ(√59): ψ = (5/18, 1/2, 5/18, −1/2) ∈ Θ, a cell of slack 0 (degenerate) | tools, exact | §4 |
| P3b-T7 | `Ld14c588b`: the cell of Coxeter's ψ is full-dimensional with maximum slack 133/115872 | tools, exact | §4 |

## 8. Reproduce, resume, check

All commands run from the repository root. Anything over 2 minutes runs under
`flock -w 1800 <scratchpad>/locks/heavy.lock`.

```
# route 2 (30 s): certificate + standalone check (48 s)
python3 tools/fs73_theta_struct.py data/fs73/q167/L21cc6506-theta-struct.json
python3 tools/fs73_theta_struct_check.py data/fs73/q167/L21cc6506-theta-struct.json
# route 1 (1,207 s CPU; resumable: re-running the same build command resumes from OUT.state.json / OUT.nodes.jsonl)
python3 tools/fs73_theta_cert.py build "420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 167 OUT \
    --basis-rows "2,0,0,0;0,0,2,0;83,0,0,1;0,-1,83,0" --order-units data/fs73/q167/L21cc6506-order.json --ckpt 60
python3 tools/fs73_theta_cert.py assemble OUT          # writes OUT.json (certcheck.py's format)
gunzip -k data/fs73/q167/L21cc6506-theta-tree.json.gz
python3 data/fs73/coxeter-c3/certcheck.py data/fs73/q167/L21cc6506-theta-tree.json
python3 tools/fs73_theta_check.py cert data/fs73/q167/L21cc6506-theta-tree.json
# controls
python3 tools/fs73_theta_cert.py build "30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 11 OUT11      # then assemble, check
python3 tools/fs73_theta_cert.py build "30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 59 OUT59 --first-leaf
python3 tools/fs73_theta_cert.py point OUT59 OUT59-point.json && python3 tools/fs73_theta_check.py point OUT59-point.json
python3 tools/fs73_theta_plant.py struct data/fs73/q167/L21cc6506-theta-struct.json /tmp/x
python3 tools/fs73_theta_plant.py tree   data/fs73/q167/L21cc6506-theta-tree.json   /tmp/x
```
- **If the route-1 build is killed,** the relaunch redoes at most the last 60 s of nodes: the nodes file is truncated to the
  count in the saved state.
- **Route 2 has no checkpoint.** It is 30 s of work, and a relaunch redoes all of it.

## 9. For the verifier: what to attack first

1. **H-i's "only if" direction.** It is the one link both routes share and that no computation here re-checks: every proper
   3-colouring gives a θ with θ(U) ⊆ [1/3, 2/3] mod 1. Both routes prove only that no such θ exists. Proved by hand twice
   (Coxeter §3; de Bruijn C1) and checked by the owner, but not in the kernel.
2. **Among the computations, R3: the completeness of Θ_R's vertex enumeration.** Route 2's case split rests on Θ_R being
   exactly the dodecagon plus four *isolated points*. A missed degenerate piece is exactly what a float method cannot see,
   and it would open a hole in route 2. Route 1 does not depend on R3, so the two routes cross-check each other there.
3. **The enumeration of U.** Four independent loops agree on 60 unit vectors: `fs73_theta_lib`, `fs73_theta_check`,
   `fs73_theta_struct_check` and Coxeter's `certcheck.py`. The hand theorem of §6 needs only 36 of them.
