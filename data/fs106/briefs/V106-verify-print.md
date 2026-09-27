*Brief for job **FS106-V**: verify the printed regular-class theorems, first-hand. Opus 5.5. Drafted by the planner (FS106-P) for the product owner to
launch. Not blind. The advisor (Poros, job FS106-A) stands beside you; a blind verifier (FS106-VB) checks the same claims without your record.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief; read it in
full — rule 0 first.** Read from disk: `CLAUDE.md` § The aim and § Counter-priors, then the plan `plans/FS106-regular-half.md` (Stage 1 §1.2, Stage 4,
Stage 5) and the fixed claim list `data/fs106/claims.md`.

## The question

The regular classes of colourings need seven colours in print — band-avoiding (`[Voronov2023]` Thm 1.1), closed (Thm 1.3), polygonal and map-type
under conditions (`[SokolovVoronov2025]` Thms 1–2) — and maps need six (`[Townsend1981]` states it; its proof is `[Townsend2005]`'s). None has been
checked here proof by proof. Given MR, Hadwiger–Nelson is whether a tight, non-closed measurable colouring can save a colour that these cannot
(`CLAUDE.md` link 5). Your job: are the printed proofs right, and exactly where does each use its regularity?

## What I'd like from you

1. Verdicts (TRUE / FALSE / GAP-at-step / MISSTATED, with your count of minds and grade) on `data/fs106/claims.md` §2 (V-1.1 … V-6.1, SV-1, SV-2,
   SV-L1, SV-C2, SV-C3, SV-L3, SV-L4, TW-81), §3 (C-CS-1, C-CS-2), §4's two short claims (C-AE-SLACK, C-AE-CLOSED) and §7 (C-ROW40). A verdict on a
   printed theorem is on its proof as printed; name every step you repaired.
2. **The map of hypotheses:** for Voronov's proof of Thm 1.1, every step that uses `ε > 0`; for S–V's proofs, every step that uses Conditions 3, 5, 6
   and every step that uses the colour of a boundary point or vertex. For each: does it hold with `ε = 0` for colourings proper at every point, and for
   classes in the normal form (D-NF)? This map is what the transfer jobs work from.
3. Read first-hand, in this order: `[Voronov2023]` (`~/source/library/pdf/arXiv-2304.10163-voronov.pdf`), `[SokolovVoronov2025]` (`…/arXiv-2502.01958-maptype.pdf`),
   `[Townsend1981]` (`~/source/library/papers/townsend-1981-…pdf`), `[Coulson2004]` (`…/pdf/jams-2004-coulson-…pdf`), `[Woodall1973]` (`…/pdf/jcta-1973-woodall-…pdf`);
   and `[Townsend2005]`, `[Thomassen1999]`, `[Pritikin1998]` when Kooshi's copies land in `~/source/library/` (the owner relays), `[Parts2020c]` from
   arXiv:2010.12668. For each, quote the main theorem and its definitions verbatim into your record (claims TW-05, CO-04, WO-73, TH-99, PR-98, PA-20),
   with a reading status per section, and propose `BIBLIOGRAPHY.md` rows.

## Rules

- **Touch only** your record `plans/FS106-V-verification.md`, `data/fs106/fs106-v/`, and `tools/fs106_v_*.py` if an exact check of seconds is needed.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Do not open `plans/FS106-VB-verification.md` or `data/fs106/fs106-vb/` until your verdict stage is committed; then read them and record divergences.
- Stages: 1 quotation check and reading plan; 2 Voronov; 3 S–V; 4 the short §3–§4 claims and the map of hypotheses; 5 Townsend, Coulson, Woodall (and
  the late arrivals); 6 divergences with VB. Commit subjects "FS106-V: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Send the advisor (its id comes from the owner) your map of hypotheses when stage 4 is saved.
- Report per standing rule 9 to `data/fs106/reports/FS106-V.md`.

Thank you.
