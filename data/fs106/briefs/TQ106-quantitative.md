*Owner's re-brief, 2026-09-27, before launch: read this block first. Where it differs from the planner's text below, this block wins.*

- **Wave 1 is done; these are your inputs** (read them from disk):
  - `plans/FS106-V-verification.md`, including **§ Continuation — FS106-V2**;
  - `plans/FS106-VB-verification.md`;
  - the advisor's comparison, `plans/POROS-2026-09-26-fs106-regular-half.md` stage 4.

  The state, at one mind unless marked otherwise:
  - **`[Voronov2023]` Thms 1.1–1.3:** TRUE after the same local repairs. Two minds, one of them blind.
  - **C-AE-SLACK:** TRUE.
  - **C-AE-CLOSED:** equivalent to "no almost-everywhere-proper six-colouring of `U₃(0)` with essentially closed classes".
  - **`[SokolovVoronov2025]` SV-2 (polygons need seven) and Cor. 1 (cubic maps):** repaired by V2 at [hand, one mind], except one named edge
    case: two same-multicolour points antipodal on ω, `d = 2`. The blind verifier VB found SV-2 a GAP through Observation 1, with a local
    counter-configuration; V2 says every use of Obs. 1 has a region-only replacement. The two have not been compared yet (FS106-V3 is doing that
    now).
  - **SV-1 (maps with Conditions 3, 5, 6):** GAP at the Condition-6 steps (SV-L4 (a) with bichromatic vertices of degree ≥ 4; Prop. 19's fills).
  - **SV-L3:** GAP as printed. The transplanted-bicycle repair for `1 ≤ d < 2` is written as a sketch (V2).
- **The planner's rule on an SV-2 GAP, applied:** where a claim of yours rests on SV-1 or SV-2, rest it on the repaired form, and name its grade
  and its open step.
- **No advisor runs during wave 2.** The one who compared wave 1 is at its token limit and has been retired. Wherever the text below says "send the
  advisor a short note", send `"main"` a two-line note after each saved stage instead. A fresh advisor compares TS and TQ after both report.
- **Your fence against the other wave-2 job** covers its files named below and standing rule 13's list: the session transcripts, `chats-bak/`, and
  every scratchpad file you did not create.
- **Hold rule.** If you reach a verdict that would move the answer, put it in your report's first line. That means an almost-everywhere-proper
  five- or six-colouring, or a proof of seven that covers tight, non-closed classes. It is held at one mind until a blind second mind confirms it.
  Do not soften it, and do not announce it anywhere outside the files.
- `[Parts2020c]` is held at `~/source/library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`: 95.99 % of the plane
  five-coloured, more than 99.985698 % six-coloured. Read its constructions for what they say about C-Q-STAB's refuting sequence.

---

*Brief for job **FS106-TQ**: the quantitative route — is Hadwiger–Nelson's measurable form the stability of Voronov's theorem? Opus 5.5. Drafted by the
planner (FS106-P) for the product owner to launch in wave 2. Not blind to the print or to wave 1; blind to FS106-TS until your verdict stage is saved.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief; read it in
full — rule 0 first.** Read from disk: `CLAUDE.md` § The aim and § Counter-priors; `plans/FS106-regular-half.md`; `data/fs106/claims.md` (§0, §1, §6);
`plans/FS103-M-derivation.md` §2 (the weak-* compactness M1) and §3 (D1–D5); `LEDGER.md` row 130; `[Voronov2023]`; `[SokolovVoronov2025]` §9; and the
advisor's record `plans/POROS-2026-09-26-fs106-regular-half.md` with `data/fs106/fs106-a/`.

## The question

`[SokolovVoronov2025]` §9: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the fraction of the plane that can be correctly colored in 6 colors with
forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow definitively that χmap (R2 ) = 7." The planner and the advisor, independently
and at one mind each, read more into it: deleting a vanishing fraction turns any almost-everywhere-proper colouring into one with a band forbidden
(C-Q-REM), and M1's compactness turns partial six-colourings with vanishing holes into a stationary six-colouring (C-Q-COMP); if both hold,
`χ_m⁰(ℝ²) ≥ 7` exactly when `lim_{ε→0} µ₆(ε) < 1` (C-Q-EQ) — Hadwiger–Nelson's measurable form, given MR, would be one stability statement about
Voronov's theorem (C-Q-STAB). The advisor showed (one mind) that Voronov's proof is feature-local: small holes are invisible to it (C-Q-HOLEa), yet excising a disc about
every trichromatic point costs little density (C-Q-LOCAL) — so a proof of C-Q-STAB needs an obstruction spread over positive measure. `[Parts2020c]` six-colours more than
99.985698 % of the plane, so any `δ` is small. **A FALSE on C-Q-STAB is a construction and gives `χ(ℝ²) ≤ 6` with no MR; a TRUE gives `χ(ℝ²) = 7`
given MR.** Aim at the answer.

## What I'd like from you, in this order

1. C-Q-REM (both halves, the pointwise core its own line), C-Q-COMP (i) and (ii), C-Q-EQ — derivations at [hand], each with its control (the tight
   hexagonal 7-colouring; a colouring whose `L¹` modulus degrades at infinity, as in `plans/FS103-M-derivation.md` §2.4).
2. C-Q-HOLEa and C-Q-LOCAL, then C-Q-STAB: find a non-local obstruction (an averaged count of circles or bicycles), or build the sequence of
   six-colourings with shrinking holes that refutes it.

Every claim: verdict (TRUE / FALSE / GAP-at-step / MISSTATED), count of minds, grade. Audit a TRUE at the rate of a FALSE (G21): the flattering result
here is "the equivalence holds and makes the problem easy"; it moves the difficulty, it does not remove it.

## Rules

- **Touch only** `plans/FS106-TQ-derivation.md`, `data/fs106/fs106-tq/`, `tools/fs106_tq_*.py`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Do not open `plans/FS106-TS-derivation.md` or `data/fs106/fs106-ts/` until your verdict stage for item 1 is committed.
- Stages: 1 quotation check and controls; 2 C-Q-REM; 3 C-Q-COMP and C-Q-EQ; 4 C-Q-HOLEa, C-Q-LOCAL, C-Q-STAB; 5 TS's record read, divergences. Commit subjects
  "FS106-TQ: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Send the advisor (its id comes from the owner) a short note after each saved stage.
- Report per standing rule 9 to `data/fs106/reports/FS106-TQ.md`.

Thank you.
