# The Wall at Six

Published artifact (private until shared): **https://claude.ai/artifact/4j9wbo4bfU3bNhHNqNN19h** (2026-09-18).

Two interval charts over the finite Euclidean planes `UD(𝔽_q, 2)` for the usable `q` from 3 to 83, answering one question:
*does any of them need exactly six colours?* `wall.html` is self-contained (no build step, no libraries) and is the
published file.

**Panel 1 — the normalization (G59).** Per `q`, the proven range for `c = α / q^{3/2}`: filled end the best independent set
found (a lower bound on the truth), open end the exact certificate (an upper bound). Behind them the band every best-known
set lies in for `q ≥ 7`, **0.756 to 0.918**. The orange rule is `⌈q²/6⌉ / q^{3/2}`, what six requires — it climbs like
`√q/6` while the band stays flat, overtakes the certificates between 47 and 59, and that is the whole reason six is refused
from 59 up. At 47 it misses by two vertices (369 needed against 371 certified).

**Panel 2 — what is proven about χ.** Lower ends are theorems, upper ends are verified colourings, a single dot is an exact
value. The rule at six passes through five ranges and no range has closed onto it.

**Panel 3** is the integers with their trust tags; the page computes every `c` from them rather than carrying transcribed
decimals.

**Where its values come from.** `data/fs53/window.md` (the authoritative per-member table: `α` lower and upper with tags,
χ floors and ceilings, the six thresholds), `data/fs50/README.md` (83), `CLAUDE.md` § Frontier rows 68–71 and G56/G59.
The `⌈q²/6⌉` column was recomputed here and agrees with `window.md`'s "six needs α ≥" at all eight of its rows.

**Independent control.** The page's claims rest on `α` figures, not on spectra, but the spectra were recomputed from
scratch while building it (additive character sums over the unit circle, sharing nothing with `tools/fplane.py`) and
reproduce `window.md`'s `λ_min` exactly at `q = 23, 31, 43, 47`, with the largest eigenvalue equal to the degree `q + 1`
at every member as a connectivity check.

**Two omissions, both stated on the page.** `q = 71` is refused six by its exact spectrum but has no recorded search
figure, so it has no lower end to plot. `U₆₄` — the sixth open member of the wall — is not a prime-field plane but a
characteristic-two target `Cay(𝔽₄₀₉₆, μ₆₅)` whose maximum sets are subspaces and whose measured `c` is 1.0, off the band
entirely; plotting it on the same axis would compare two things at once.

**The caveat the page carries in its footer, and it is the load-bearing one:** the flat left edge is a band of *lower*
bounds. Only `q = 3, 7, 11` have `α` pinned exactly, so the flatness may be measuring how hard the searches ran rather
than the graphs (G21). `plans/STUB-six-is-not-a-value.md` §2a names the calibration that would settle it — `α(19)` through
the level-3 relaxation that pinned 7 and 11 — and the two cheap falsifiers, an independent set of 78 at 19 or 263 at 43.

Checked current on 2026-09-18 against `data/fs53/window.md`.
