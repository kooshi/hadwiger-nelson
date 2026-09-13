# data/m63 — M63 phase H4, the ρ₆₃ arena's additive-family gauge (2026-09-12)

Seven files, all from phase H4 of M63 (`plans/M63-phaseH4-familykeeping.md`, `plans/M63-phaseH4-freecensus.md`,
`plans/M63-phaseH4-sweep.md`, `plans/M63-phaseH4-reduce-the-platform.md`). Phase H4 studies the ρ₆₃ arena
(the 51,133-vertex, 544,530-edge object built in phase H2 over ℚ(√3,√7,√11), row 64 of the ledger) through
Fischer's additive-colouring yardstick (M56/M57's machinery): for a stage's edge-difference lattice Λ, list
every group homomorphism Λ → ℤ/k nonzero on every edge vector, and report the Kempe-closure gauge γ
(M57's rigidity measure) over that family. **Every file here is explicitly marked `UNTRUSTED`** in its own
`claim_scope` string — these are tools-side gauge computations, not solver refusals and not kernel claims.

Regenerate with `tools/m63_h4_gauge.py` (name per the `producer`-equivalent script referenced in the phase H4
plans; not independently confirmed against `tools/` in this pass — see Not recorded here).

| file | kind | population / what it holds | trust |
|---|---|---|---|
| `m63-phaseH4-control-record-k4.json` | `h4-family-gauge-dial` | Control stage: a **1,771–3,541-vertex** arena at the Moser twist (`cos = 7/8`) instead of ρ₆₃, at **k = 4**, over 4 stages (base/pair/diag/full); admissible ℤ/4-hom counts 24→0 as cross edges are added (`full`: 0 homs, γ undefined) | tools-only, marked UNTRUSTED in-file |
| `m63-phaseH4-control-record-k5.json` | `h4-family-gauge-dial` | Same control arena at **k = 5**: 4 stages, 48 admissible ℤ/5-homs throughout (`homs_exact: true`), γ rising 11,232 → 22,464 over the stages | tools-only, marked UNTRUSTED in-file |
| `m63-phaseH4-rho63-full-exact.json` | `h4-family-gauge-dial` | The real ρ₆₃ arena (`cos = 31/32`) at its full 51,133-vertex / 544,530-edge extent, **k = 5**, one row: **96 admissible ℤ/5-homs**, γ = 107,328 (γ̄ = 1,118), 5,256 loose vertices | tools-only, marked UNTRUSTED in-file; this is the one record FINDINGS cites as "the gauge record … (96 homs)" |
| `m63-phaseH4-rho63-k4.json` | `h4-family-gauge-dial` | The ρ₆₃ arena at **k = 4**, 4 stages (25,567 → 51,133 vertices): homs 24 → 0 (no admissible ℤ/4-hom on `full`) | tools-only, marked UNTRUSTED in-file |
| `m63-phaseH4-rho63-k5.json` | `h4-family-gauge-dial` | The ρ₆₃ arena at **k = 5**, 4 stages: homs 48 → 96, γ 27,360 → 53,664; `full` stage's γ is flagged `gamma_is_lower_bound: true` (hom enumeration capped) | tools-only, marked UNTRUSTED in-file |
| `m63-phaseH4-rho63-sweep.json` | `h4-family-gauge-dial` | A 20-row radius sweep of the ρ₆₃ construction at **k = 5**, from a 1,603-point base up to the 121,381-vertex / 1,386,930-edge stage; homs 48 throughout the sweep's early rows, reaching 96 at the largest; every row's γ is `gamma_is_lower_bound: true` (hom enumeration capped at these sizes) | tools-only, marked UNTRUSTED in-file |
| `m63-phaseH4-d1-classifier.log` | plain-text log | The arena-construction trace for the "D1" control (base 25,567 points / 272,232 unit edges, cross edges 126 = 60+30+36, arena 51,133/544,530), plus the base's exact direction-lattice rank (4) and its growth to rank 8 once the copy is adjoined, at two further test radii (r² = 81/4, r² = 25) — this is the rebuild that FINDINGS' "control C2" refers to | tools-only log, no JSON schema |

**Reading the numbers against FINDINGS/REVIEW-BRIEF.** These six JSON files are gauge computations on *proper
colourings of the additive family only* (M56/M57's yardstick), not a claim that the arena is or is not
k-colourable — the k = 5 UNSAT that gives row 64 its "χ ≥ 5" headline is the phase H2 solver certificate
(`m63-phaseH2-rho63-certificate.json`, `m63-phaseH2-rho63-proof-manifest.json`, in `data/m62/`, solver-only —
see `data/m62/README.md`), not anything here. The phase H4 items FINDINGS lists as **not committed** — the
free-deletion census (0/51,133), the pilot (397/400), the compulsion sweep (0 over ~1.3 billion questions,
two variants) — have **no file in this directory or anywhere under `data/`**; they exist only in
`build/m63-phaseH4-*` (gitignored) or as numbers quoted in the phase H4 plans.

## Not recorded here

- The **free-deletion census** (every one of the arena's 51,133 vertices individually deletable without
  losing the k = 4 refusal, reported as 0/51,133) — no committed record; see `plans/M63-phaseH4-freecensus.md`.
- The **pilot** run (397/400) and the **compulsion sweep** (0/1,307,266,278 and 0/1,306,721,748, two
  encodings) — no committed record; see `plans/M63-phaseH4-sweep.md`.
- The DRAT/LRAT proofs backing the phase H2 χ ≥ 5 solver certificate (0.35 GB / 1 GB, referenced by
  `m63-phaseH2-rho63-proof-manifest.json` in `data/m62/`) lived in `/tmp` and were never committed; only the
  151 KB certificate and 5 KB manifest survive, both in `data/m62/`.
