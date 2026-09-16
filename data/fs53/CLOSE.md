# FS-53 — the sixth colour: the close, and the ranked options it leaves

*2026-09-16. The milestone asked which finite Euclidean plane is exactly six-chromatic, and which number
field that would hand us. It did not find one. What it did is narrow the question from eight candidates to
five, refuse five colours at two of them, exhaust the certificate instrument, and name the field each
remaining candidate would buy.*

## What landed

| | |
|---|---|
| **The window fell from eight to five** | 59, 67 and 79 refused six by exact certificate (α ≤ 575, 745, 1023), joining 83. Remaining: 23, 27, 31, 43, 47 |
| **Two members acquired a floor of six** | five is refused by certificate at **43** (α ≤ 365 against the 370 five needs) and **47** (α ≤ 371 against 442). A single verified six-colouring at either **is** that plane's exact chromatic number |
| **The certificate side is finished** | 23, 27, 31 and 47 are converged — `status solved`, not a stopped iterate — so those bounds are final. Only **43** retains headroom, and refusing six there needs 15%, which nothing approaches |
| **α(UD(𝔽₄₇,2)) ≤ 371** | the first converged solve, down from 377. Six at 47 now needs α ∈ {369, 370, 371} against a best-found 265 |
| **χ(UD(𝔽₁₇,2)) ≤ 6** | a published open cell narrowed from {5, 6, 7} to {5, 6} |
| **χ(UD(𝔽₂₃,2)) ≤ 8, kernel-checked** | on the standard three axioms, no compiler trust bought — the first kernel statement about any window member |
| **Three grokkings** | G56 (the window and reciprocity's exclusion), G57 (a field contains √3 iff its usable planes have triangles; no candidate field holds a Moser spindle), G58 (the antipodal conjecture) |
| **Every member's field named** | 23 → ℚ(√2,√31), 31 → ℚ(√5,√51), 43 → ℚ(√10,√23), 47 → ℚ(√7,√89). 27 alone has none from square roots  — *corrected at FS-54: these see their members first but are not the smallest; the smallest are ℚ(√167), ℚ(√1055), ℚ(√4703), ℚ(√2351), and 27 needs even degree ≥ 6 (`data/fs53/window.md`)* |

**What it did not do:** find a six-colouring anywhere, or clear a six-threshold on the finding side at any
member. Both were registered as long shots in advance and are reported as nulls at their budgets.

## The two calibration points, and what they decide

The certificate's **tightness** — true α divided by the certified bound — is the quantity that says which
members are worth compute. It is now measured at the two planes where α is known exactly:

| q | α exact | certified N | **α/N** |
|---|---|---|---|
| 7 | 14 | 14.088 | **0.9938** |
| 11 | 28 | 29.177 | **0.9597** |

A linear reading in `q` was **falsified by our own data** — it predicts α ≈ 250 at 43 and 243 at 47, where
verified sets of 258 and 265 exist. So the ratio does not fall linearly and no law is claimed. What survives
needs no law, only the arithmetic of what each member requires:

| q | six needs α/N ≥ | measured lower bound on α/N |
|---|---|---|
| 23 | 0.820 | ≥ 0.801 |
| **27** | **0.827** | **nothing — no set has ever been found there** |
| 31 | 0.801 | ≥ 0.727 |
| 43 | 0.850 | ≥ 0.710 |
| **47** | **0.994** | ≥ 0.714 |

**Six at 47 requires the relaxation to be 99.4 % tight at 2,209 vertices — a tightness observed only at
q = 7, the smallest plane in the project.** That is the strongest available argument that 47 is finished,
and it does not depend on any extrapolation. The others need 0.80–0.85, which is inside the plausible band.

## The ranked options, as of the close

| rank | option | what it decides | cost | confidence |
|---|---|---|---|---|
| **1** | **Measure 27** — give the Rust tools `--q`/`--modulus` and fill the table's only blank cell (**FS-54**, `plans/STUB-twenty-seven.md`) | 27 needs the least of any member (α ≥ 122 of a certified 147) and is the only one never searched. If five is refused there its floor becomes six at the most achievable threshold in the window; if α plateaus far below 122, the negative close is in sight | days | **high** that it is decisive either way |
| **2** | **Explain 27's integer spectrum** (λ_min exactly −8, ratio bound exactly 162, ω = 3 by characteristic where √3 = 0) | a clean answer may bound α(27) by hand and make the search unnecessary. Recognition before search (G46) — the cheapest item on this list | hours to days | medium-high |
| **3** | **Make the 43 search complete via G58** — test the antipodal conjecture with a **finder on the quotient**, not a decider | if it holds, χ(43) = 6 *implies* a symmetric six-colouring exists, so a symmetry-restricted search becomes a complete method at half size — (q²+1)/2 orbits against q² vertices | a day | medium-high |
| **4** | **A stronger relaxation at 27**, aimed at the one integer that would refuse five | five at 27 needs α ∈ {146, 147} against a converged 147.577. The triple level cannot go below; a higher level at 729 vertices may be affordable where it is hopeless at 2,209 | days | medium-low |
| **5** | **Kernel-promote the 43/47 refusals** (FS-52) | converts the two decisive members from the checker's word to the kernel's. Does not advance the hunt; does raise the standard of evidence to this project's own bar | days | high value, low urgency |
| **6** | **The field side** — the chain theorem (FS-45), one gadget for six (FS-49) | the only routes to χ(ℝ²) ≥ 6 that do not pass through a finite plane. G57 warns the vocabulary does not transfer: no candidate field holds a Moser spindle, and at 31 and 43 there is not even a triangle | weeks | low probability, highest payoff |

**Not recommended:** further compute on 47 (converged, and six needs a tightness seen only at q = 7), or on
23 and 31's certificates (converged and final). Their bounds will not move again.

## The honest assessment of where this is heading

The evidence accumulated against six existing anywhere in the window. 23's search plateau sits two short of
what six needs, on an instrument that attains the true α at q = 11 in two seconds and never produced an 88
across ~96,000 restarts. 47 needs a tightness never seen above q = 7. 43 needs α ≥ 309 against 258, unmoved
through hours. And G57 says that even if a member were six-chromatic, no gadget this project holds could be
built over the field it hands us.

**If no plane is six-chromatic, no field has local bound 6, the residue method can never reach six, and
under the conjecture's bold form χ(ℝ²) = 7** — with six a value no field attains, though every
seven-chromatic graph passes through it. That is a real result and the likelier outcome on current evidence.
It is not a disappointment, and the milestone should not be steered away from it.

## Predictions scored

* **The bias-corrected growth law LOST.** It predicted α ≈ 96–97 at 23 and ≈ 166 at 31; the searches reached
  **87** and **146**, both below the six-thresholds the law placed them above. Its ordering survives — 23 and
  31 remain the members closest to their thresholds — its shape below q ≈ 30 does not.
* **P3 (the certificate refuses five at 27) was FALSIFIED**, by one integer, permanently.
* **Q1 (six refused at 67) landed 3 inside** its threshold.
* **Q3 — the outside advisor's 2:1 bet that 23 is empty — is winning.**
* **A prediction registered before the 31 convergence run HELD**: from the trajectory (0.036 per 2,000
  iterations against 8.2 to go) I said it would not reach 193. It moved 0.79 and stopped.
