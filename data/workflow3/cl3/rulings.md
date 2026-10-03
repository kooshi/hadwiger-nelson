# CL3 — requests to search and their rulings, copied verbatim

Each entry: the address (file, item, line), then the table row exactly as it stands.

## plans/FS81-close-inventory.md, item 82 (line 99)

| 82 | ruling (Kooshi) | **A one-week SAT-solver ban after FS-81 closes.** Kooshi, 2026-09-24: "I feel like we have never actually succeeded at any 'priced attempt', not since the days where we were working in extensions of K anyway. I think the triangle free fields make SAT infeasible. I'm tempted to ban SAT solvers for a week and see what we can do on algebra alone." Then: "Let's let this milestone finish out, then SAT solvers will be banned for 1 week afterward. In the meantime, launch a Poros agent to determine where we go with the algebra only approach. Don't tell it your ideas, let's see where it lands." So FS-81 finishes as planned (D1, the running re-asks, and D2's priced attempt by a successor); **the ban runs for one week from FS-81's close date**; a fresh Poros, briefed without the owner's ideas, advises on the algebra-only direction. At the close: record the ban in `CLAUDE.md` (current state, with its dates) and in the handoff. | Kooshi's messages, 2026-09-24 | **done** — § Toolchain and the Frontier (9ac6a758), `plans/FRONTIER-STUBS.md` (e55de81f), the session handoff (ff3cd5c3) |

## plans/FS81-close-inventory.md, item 86 (line 103)

| 86 | finding + ruling (D2) | **D2 as specified cannot discharge its matched-control obligation**: Λ₂₄₀'s ball at d* has ≈ 5.1·10⁷ points against X_A's 39,829 (×1,284; §S.D requires n within ×2); any Λ₂₄₀ ball a solver could hold sits at low degree (7.3 at 1.8·10⁷ points, 11.8 at 2.9·10⁷), inside X_A's own undecided band; the ask at d* is ≈ 2·10⁹ clauses, which kissat cannot parse within W = 221.6 s, so its UNKNOWN would measure the parser (G21). **Owner's ruling: D2 closes with the price as a size ratio and no solve** — "the cheapest minimal survivor over ℚ(√47) needs at least 1,284 times the calibration control's points at the density where the control refuses four colours in 55 s", graded [reading] (carried from an abelian Cayley graph with one non-unit edge; the triangle axis uncovered); not evidence that four colours suffice. **D1's deep pass** (`screen --ids survivors`, the UNKNOWN residue re-asks, P3b's Θ₄ finder and cell analysis on the 10 minimal survivors) **is carried forward to a stub at the close** (a ℚ(√47) sibling of FS-59), not run in FS-81: it types survivors for a question D2 cannot price, and the week after the close is algebra-only. The stage-D implementer is retired (≈ 345k working tokens); no successor is launched. | the implementer's §D2; the owner | **done** — row 84 (08606f17); FS-84 minted with D1's deep pass (e55de81f) |

## plans/FS85-close-inventory.md, item 2 (line 17)

| 2 | ruling (Kooshi) | **The finite-witness-free week, 2026-09-24 to 2026-10-01**, with the advisor's scope: no SAT, MaxSAT or #SAT; no MILP/CP or local-search colourers; no Θ relation trees or float finders; no quotient-colouring searches or survivor sweeps. Allowed: hand derivation, computer algebra, formula colourings, the Lean kernel, existing checkers on existing certificates, and exact LPs only when a derivation fixes their shape first. Kooshi: "I agree with the advisor on the scope as well." Recorded in `CLAUDE.md` § Toolchain. | Kooshi's messages; the advisor's §6.4 | settled |

## plans/FS85-close-inventory.md, item 3 (line 18)

| 3 | method | **The "would have searched here" log**: every brief carries it (one line per move an agent would have made by search, and what it did instead). At the close, count the lines and read what replaced them; zero lines means the ban constrained nothing. | the advisor's §6.5 | done at e834f05f (§R-close.2: 37 lines, 2 breaches, 4 borderline, read against item 37) |

## plans/FS85-close-inventory.md, item 37 (line 52)

| 37 | remark (Kooshi) | **On the week's design:** "I think the ban and plan may have been too strict, although restrictions do breed creativity, I'm not sure if these are the kinds that count." Not a change of rules (the ban runs to 2026-10-01 as registered); **for the close's verdict on the week**, read with the search logs (item 3): which lines were a creative constraint and which were friction. | Kooshi's message | done at e834f05f (§R-close.2: 37 lines, 2 breaches, finder versus aiming) and df202277 (Frontier item 23) |

## plans/FS86-close-inventory.md, item 2 (line 18)

| 2 | ruling (Kooshi, carried) | **The finite-witness-free week runs to 2026-10-01** (`CLAUDE.md` § Toolchain). The stub's routes 1–3 are in scope. Route 4 (composite quotients, a quotient-colouring search) waits for the week's end. Every brief carries the "would have searched here" log. | `CLAUDE.md` § Toolchain | open; **close:** done: § Toolchain's ban line kept current to 2026-10-01 (de8bb61c); route 4 carried to FS-90 (d) (aa977ec6) |

## plans/FS89-close-inventory.md, item 2 (line 17)

| 2 | ruling (Kooshi) | **The exact band-set computation is allowed under the ban.** Kooshi: "that computation is indeed allowed. The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time." The ban otherwise runs to 2026-10-01 (`CLAUDE.md` § Toolchain). **At the close:** record the ban's intent in § Toolchain's ban line, in his words. | Kooshi's message | done at 3dcb8de8 (§ Toolchain's ban line carries the intent in his words; the dates are unchanged, 2026-09-24 to 2026-10-01) |

## plans/FS89-close-inventory.md, item 17 (line 32)

| 17 | ruling owed (Kooshi), know-not-decide | **The torsion list in item 16(b) was a finite exact enumeration**: the characters of `ℤ[i]/N` for every `N ≤ 130` with `5 ∤ N`, one fixed set per `N`, under a second of CPU. S0B logged it in its would-have-searched log as "a loop over orders … labelled a measurement". The owner judges it inside item 2's ruling: the torsion part of the allowed band-set computation, with no witness sought. It sits at the ban's edge ("sweeps"), so it is recorded for Kooshi. | `plans/FS89-S0B-band-set.md` § Would-have-searched-here log | carried (Kooshi's; recorded in S0B-L4's entry) |

## plans/M3-close-inventory.md, item 37 (line 45)

| 37 | ban note | J19 enumerated all 94 rigid periodic points of X₄({2,6,11,13,14}) (a finite set its derivation fixed; "at the ban's edge", its words) — for the close's ban measurement | J19 report | done, J23c stage 3: R3.8 item 1 |

## plans/M3-close-inventory.md, item 60 (line 68)

| 60 | owner ruling | J20's declined residue step mod 20 (J18-DC's route to A-C) waits for 2026-10-01 | the J23c brief (`data/crunch-2026-09-25/briefs/J23c-M3-close-math.md`, "The ban measurement") (added by J23c) | done, J23c stage 1: logged (§R-close.R3, owner rulings; R1.1 row 7) |

## plans/FS114-close-inventory.md, item 115 (line 124)

| 115 | slip | **A ban touch by FS114-Y6**: it checked its hand case split against the inequalities on a 5° grid of cone sequences (exact integers, seconds; verified a derived split, found no object, nothing rests on it; logged; no tool kept). **Owner ruling:** it counts as a scan over a parameter; the grid is not evidence; the split stands on the hand derivation at its grade; completeness, if needed, by hand or by exact linear algebra whose shape the derivation fixes (the inequalities are linear in the cone angles) | Y6's message; the owner's reply | done (FS114-C, `data/fs114/fs114-c/ticks.md`) |

## plans/FS116-close-inventory.md, item 82 (line 116)

| 82 | owner ruling | S1's `tools/fs116_s1_reach.py` (a discretised reachable set of curves under two derived constraints; no colouring, fragment or solver; not a control; no theorem rests on it; logged in its would-have-searched log): **ruled acceptable as exploration, not evidence**. Alternative: treat it as a breach of the list's § 9. Why not: § 9 forbids enumerating maps, colourings, tile graphs or ring types, and this enumerates none; the search ban's dates have passed (its deletion is Kooshi's, pending in the interim report). Confidence: medium-high. S1's scratch files were written to the session scratch (W21) | S1's held items | done |

## plans/FS116-close-inventory.md, item 86 (line 120)

| 86 | owner ruling | Y3's held question — may HEX3's stalled star now go to a solver, the ban's dates having passed? **No**: FS-116's frozen list § 9 forbids "enumeration of maps, colourings, tile graphs or dual graphs, by any program" and of ring types, independently of the ban, and Kooshi's ruling "search for a finite graph is out" stands. The star goes to derivation or to a construction by formula. Confidence: high | Y3's held items | done |

## plans/FS116-close-inventory.md, item 129 (line 163)

| 129 | question for another lane | Standing rule 5 (the search ban to 2026-10-01) is still in `plans/STANDING-RULES.md` on 2026-10-03; Y4 kept its log and was bound by the list's § 9 anyway. Kooshi's decision, default: delete it at the next filing | Y4 § 1.1 | open: Kooshi asked for a count first (O7) |

## plans/FS116-close-inventory.md, item O7 (line 230)

| O7 | owner ruling | **Kooshi, 2026-10-03 18:30 UTC**, on the search ban (item 129): "As for the ban - have a clerk count the number of times it actually hindered us in the short time it was active. We didn't get to have a full week of it, but I want to know how it affected our approach before we remove it outright. I'm thinking of restricting search to a wallclock budget per day and per week. A lot of progress was made without it." So the ban is not deleted at the filing; the Clerk job CL3 counts, from every "would have searched here" log written since 2026-09-24, where the ban left a step open and where a result replaced the search; the wallclock-budget policy is for the workflow refinement, from CL3's counts | Kooshi's message | open (CL3; the workflow refinement) |

