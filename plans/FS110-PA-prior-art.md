# FS110-PA — prior art for a Condition-5-only round (Sokolov–Voronov's Condition 5 kept, Condition 6 dropped)

*Job FS110-PA (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/PA110-sv-condition5.md` with `data/fs110/briefs/STANDING-RULES.md`
(rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read). Not blind; fenced from the two blind verifiers' records and the three
channels of standing rule 13. Working files: `data/fs110/fs110-pa/`. The question comes from FS110-A4's recommendation
(`plans/POROS-2026-09-27-fs110-competition.md` § A4-1.9): "a prior-art check showing that S–V or Townsend already settle maps with Condition 5
and without Condition 6. That check is owed before round 3".*

## Theorems this phase proved

*(filled stage by stage; this is a reading job, so most lines are findings, not theorems)*

## Would-have-searched-here log

- Stages 1–2: none (reading only).

## Stage 1 — SAVED: quotation check, fences, reading plan

**Quotation check (standing rule 5).**
- The brief's gloss "Condition 5 (no unit arcs on boundaries)" is **not verbatim and is weaker than the print.** `[SokolovVoronov2025]` p. 4:
  "Condition 5. (fa = “forbidden arcs”) If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of
  unit curvature are forbidden." The condition is **finite intersection of every boundary with every unit circle**; "no unit arcs" is only
  the first consequence the paper draws from it (p. 4, Observation 2: "1. The boundaries do not contain arcs of a circle of radius 1. 2. Any
  circle of radius 1 is partitioned into a finite number of monochromatic arcs."). A boundary meeting a unit circle in an infinite set with no
  arc (a Cantor set, or a sequence of tangencies) satisfies "no unit arcs" and violates Condition 5. **Which of the two a Condition-5-only
  round works under must be fixed in its registration**; FS-110's own list (`data/fs110/claims.md` l. 64–65) quotes the finite-intersection
  form verbatim, correctly. (S–V themselves slide between the two: Prop. 10's proof says "which states that the boundaries do not contain such
  arcs", p. 12, while needing the finite-intersection form, since its conclusion is "infinitely many points"; FS106-V's Cor. 2 row already
  notes this.)
- The standing rules' quotations of Kooshi ("From here on out …", "to eliminate the crutch …", "search for a finite graph is out …", "A proven
  theorem about why its impossible is also valid …") match `CLAUDE.md` § Counter-priors, § Toolchain, § Publication and § Where the problem
  stands item 23.
- The brief's "their §9 (the open questions)": §9 is headed "Conclusion" (p. 26) and holds Questions 1–2; checked.
- `[SokolovVoronov2025]` exists in one arXiv version: the arXiv API (queried 2026-09-27) returns `2502.01958v1` only (published and updated
  2025-02-04). The journal version (Discrete Math. 349 (2026) 115321, per `BIBLIOGRAPHY.md` l. 128) is not held; whether its §9 differs is
  unchecked (stage 3 tries).

**Fences.** A listing of the shared scratchpad directory (to create my subdirectory) showed other jobs' **file names**; no other file was opened.
My first extraction wrote `v3.txt` at the scratchpad's top level; its birth time equals the write (2026-09-27 10:26:16), so it overwrote
nothing, and it was moved into `scratchpad/fs110-pa/`. One `grep` for "third round|Condition 5|…" ran over `data/fs110/fs110-a4/*`, which
holds a copy named `FS110-NB-verification.md` (a blind verifier's record): **it printed no line from that file** (zero hits there); nothing
else of it was read. Logged for the owner.

**What is already known (read, not redone).** `plans/FS106-V-verification.md` §§3.1–3.2 (FS106-V), § Continuation — FS106-V2 (§7, the
Appendix, the verdicts), § Continuation — FS106-V3 stages 1 and 3 (Townsend's manuscript, Woodall §3). Their findings used below are cited by
section, never re-derived.

## Stage 1 — SAVED

