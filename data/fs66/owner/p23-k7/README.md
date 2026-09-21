# Seven colours on the 529-point plane `UD(𝔽₂₃, 2)` — a bounded search, nothing found (owner, 2026-09-21)

**The ask.** The plane's chromatic number is 6, 7 or 8 (five refused by certificate, `α ≤ 105`; an 8-colouring is kernel-checked).
Seven needs classes averaging 75.6 points against a best known independent set of 87; the only earlier search was 120 s
(`data/fs53/colour-p23-k7.json`, best 38 clashing edges). Kooshi suggested asking again while the GPU solve at 23 ran.

**What ran.** `plane-colour` (tabu local search, `~/source/descent-engine`), three arms of 600 s on 14 threads, desktop (the machine),
beside a GPU job using one host thread: two plain arms (seeds 11, 13) and one holding the 87-point set of
`data/fs53/alpha-q23-ge87.json` as colour class 0 (seed 12). Each record carries its own `rerun` line.

| arm | verdict | best clashing edges (of 6,348) | restarts |
|---|---|---|---|
| plain, seed 11 | not found | 37 | 2,495 |
| 87-set fixed as one class, seed 12 | not found | **30** | 2,453 |
| plain, seed 13 | not found | 40 | 2,464 |

**What it says.** Nothing about existence: a local search can exhibit a colouring and can never refuse one, and this is about 7
thread-hours of one move set. The ceiling stays 8. The plateau (30–40 clashing edges from ~7,400 restarts,
barely below the 38 of the 120-second run) reads like the six-colour plateaus of FS-53, so a longer run of the *same* instrument is
not the next move; a SAT ask with a pinned triangle and precedence on the free colours, or a finder on the antipodal quotient (G58),
would be. Neither is run here: the question bears on the finite plane's own value (FS-17), not on ℚ(√167), whose ceiling of 7 is free.
