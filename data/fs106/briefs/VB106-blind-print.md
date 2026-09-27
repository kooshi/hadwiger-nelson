*Brief for job **FS106-VB**: a blind verification of the printed regular-class theorems, and a second mind on three held lemmas. Opus 5.5. Drafted by
the planner (FS106-P) for the product owner to launch. **Blind.***

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief; read it in full —
rule 0 first.** Read from disk `CLAUDE.md` § The aim and § Counter-priors, and the fixed claim list `data/fs106/claims.md` (statements only — that is
by design).

## The question

Printed theorems say that regular colourings of the plane need seven colours: `[Voronov2023]` (forbidden interval; closed sets), `[SokolovVoronov2025]`
(polygonal and map-type colourings), `[Townsend1981]` (maps need six; the note has no proof). Are their proofs right? And three lemmas this project
holds at one mind — are they right?

## What I'd like from you

1. From the PDFs and `data/fs106/claims.md` alone, verdicts (TRUE / FALSE / GAP-at-step / MISSTATED, count of minds, grade) on §2 (V-1.1 … V-6.1,
   SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4, TW-81) and §3 (C-CS-1, C-CS-2). The PDFs: `~/source/library/pdf/arXiv-2304.10163-voronov.pdf`,
   `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, `~/source/library/papers/townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.pdf`.
   For every proof, write in your own words which steps use the forbidden interval, closedness, or the colour of a boundary point.
2. **Second minds (Phase H):** derive, blind, the held inputs I-D1, I-D2, I-D4 of `data/fs106/claims.md` §1 and the density-point statement in D-NF
   ("the classes `S̃_j` avoid the distance 1 at every pair of their points"). Give each a verdict.
3. Register, before any derivation, your own expectation per claim and the control you will use (the tight hexagonal 7-colouring must survive every
   seven-colour claim).

## Fences (do not open until your verdict stage is committed)

Standing rule 13's list — the session transcripts under `~/.claude/projects/-home-kooshi-source-lean-dir/` (memory included), `chats-bak/`, and every
file in the shared harness scratchpad you did not create (work in your own subdirectory there). Also: `plans/FS106-regular-half.md`;
`plans/POROS-2026-09-26-fs106-regular-half.md`; `data/fs106/fs106-a/`; `data/fs106/fs106-p/`; `plans/FS106-V-verification.md` and `data/fs106/fs106-v/`;
every other FS-106 record; `plans/FS103-M-derivation.md`, `plans/FS103-N-verification.md`, `plans/FS103-V1-verification.md`,
`plans/FS103-V2-verification.md`, `plans/POROS-2026-09-26-hn-paths.md`. Commit subjects stay neutral.

## Rules

- **Touch only** `plans/FS106-VB-verification.md`, `data/fs106/fs106-vb/`, `tools/fs106_vb_*.py`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Stages: 1 quotation check, expectations, controls; 2 Voronov; 3 S–V and Townsend; 4 Phase H; 5 the write-up (committed before anything fenced is
  opened); 6 the fenced records read, divergences recorded. Commit subjects "FS106-VB: stage n". **Budget:** about 300k by the harness's count; hand
  back by 400k.
- Report per standing rule 9 to `data/fs106/reports/FS106-VB.md`. Never contact the advisor or FS106-V; only `"main"`.

Thank you.
